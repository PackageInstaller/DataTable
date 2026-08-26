-- chunkname: @modules/logic/ressplit/xml/ResSplitXmlPrint.lua

module("modules.logic.ressplit.xml.ResSplitXmlPrint", package.seeall)

local ResSplitXmlPrint = {}

function ResSplitXmlPrint:starttag(tag, s, e)
	io.write("Start    : " .. tag.name .. "\n")

	if tag.attrs then
		for k, v in pairs(tag.attrs) do
			io.write(string.format(" + %s='%s'\n", k, v))
		end
	end
end

function ResSplitXmlPrint:endtag(tag, s, e)
	io.write("End      : " .. tag.name .. "\n")
end

function ResSplitXmlPrint:text(text, s, e)
	io.write("Text     : " .. text .. "\n")
end

function ResSplitXmlPrint:cdata(text, s, e)
	io.write("CDATA    : " .. text .. "\n")
end

function ResSplitXmlPrint:comment(text, s, e)
	io.write("Comment  : " .. text .. "\n")
end

function ResSplitXmlPrint:dtd(tag, s, e)
	io.write("DTD      : " .. tag.name .. "\n")

	if tag.attrs then
		for k, v in pairs(tag.attrs) do
			io.write(string.format(" + %s='%s'\n", k, v))
		end
	end
end

function ResSplitXmlPrint:pi(tag, s, e)
	io.write("PI       : " .. tag.name .. "\n")

	if tag.attrs then
		for k, v in pairs(tag.attrs) do
			io.write(string.format(" + %s='%s'\n", k, v))
		end
	end
end

function ResSplitXmlPrint:decl(tag, s, e)
	io.write("XML Decl : " .. tag.name .. "\n")

	if tag.attrs then
		for k, v in pairs(tag.attrs) do
			io.write(string.format(" + %s='%s'\n", k, v))
		end
	end
end

return ResSplitXmlPrint
