module FCSHD
  class Problem < Struct.new(:source_location, :raw_mxmlc_message)
    ERROR_PREFIX = /^Error: /

    def mxmlc_message
      raw_mxmlc_message.sub(ERROR_PREFIX, "")
    end

    def error?
      raw_mxmlc_message =~ ERROR_PREFIX
    end

    def message
      case mxmlc_message
      when /^Unable to resolve MXML language version/
        <<"^D"
Missing MXML version.
  Try xmlns="http://www.adobe.com/2006/mxml
   or xmlns:fx="library://ns.adobe.com/mxml/2009
^D
      when /^Could not resolve <(.+)> to a component implementation.$/
        <<"^D"
`#$1' is undefined.
^D
      else
        mxmlc_message
      end
    end

    def formatted_message_lines
      message.lines.map do |line|
        if error?
          "error: #{line.chomp}"
        else
          line.chomp
        end
      end
    end
  end
end
