-- chunkname: @modules/logic/ressplit/xml/ResSplitXmlParser.lua

module("modules.logic.ressplit.xml.ResSplitXmlParser", package.seeall)

local function decimalToHtmlChar(code)
	local num = tonumber(code)

	if num >= 0 and num < 256 then
		return string.char(num)
	end

	return "&#" .. code .. ";"
end

local function hexadecimalToHtmlChar(code)
	local num = tonumber(code, 16)

	if num >= 0 and num < 256 then
		return string.char(num)
	end

	return "&#x" .. code .. ";"
end

local ResSplitXmlParser = {
	_TAG = "^(.-)%s.*",
	_DTD2 = "<!DOCTYPE%s+(.-)%s+(PUBLIC)%s+[\"'](.-)[\"']%s+[\"'](.-)[\"']%s*(%b[])%s*>",
	_DTD4 = "<!DOCTYPE%s+(.-)%s+(SYSTEM)%s+[\"'](.-)[\"']%s*>",
	_WS = "^%s*$",
	_ATTR2 = "([%w-:_]+)%s*=%s*'(.-)'",
	_ATTRERR2 = "=+?%s*'[^']*$",
	_ATTRERR1 = "=+?%s*\"[^\"]*$",
	_DTD5 = "<!DOCTYPE%s+(.-)%s+(PUBLIC)%s+[\"'](.-)[\"']%s+[\"'](.-)[\"']%s*>",
	_DTD3 = "<!DOCTYPE%s.->",
	_TRAILINGWS = "%s+$",
	_PI = "<%?(.-)%?>",
	_DTD1 = "<!DOCTYPE%s+(.-)%s+(SYSTEM)%s+[\"'](.-)[\"']%s*(%b[])%s*>",
	_COMMENT = "<!%-%-(.-)%-%->",
	_ATTR1 = "([%w-:_]+)%s*=%s*\"(.-)\"",
	_TAGEXT = "(%/?)>",
	_XML = "^([^<]*)<(%/?)([^>]-)(%/?)>",
	_LEADINGWS = "^%s+",
	_CDATA = "<%!%[CDATA%[(.-)%]%]>",
	_errstr = {
		unmatchedTagErr = "Unbalanced Tag",
		incompleteXmlErr = "Incomplete XML Document",
		endTagErr = "End Tag Attributes Invalid",
		xmlErr = "Error Parsing XML",
		declStartErr = "XMLDecl not at start of document",
		cdataErr = "Error Parsing CDATA",
		piErr = "Error Parsing Processing Instruction",
		commentErr = "Error Parsing Comment",
		declAttrErr = "Invalid XMLDecl attributes",
		declErr = "Error Parsing XMLDecl",
		dtdErr = "Error Parsing DTD"
	},
	_ENTITIES = {
		["&apos;"] = "'",
		["&gt;"] = ">",
		["&lt;"] = "<",
		["&amp;"] = "&",
		["&quot;"] = "\"",
		["&#(%d+);"] = decimalToHtmlChar,
		["&#x(%x+);"] = hexadecimalToHtmlChar
	}
}

function ResSplitXmlParser.new(_handler, _options)
	local obj = {
		handler = _handler,
		options = _options,
		_stack = {}
	}

	setmetatable(obj, ResSplitXmlParser)

	obj.__index = ResSplitXmlParser

	return obj
end

local function fexists(table, elementName)
	if table == nil then
		return false
	end

	if table[elementName] == nil then
		return fexists(getmetatable(table), elementName)
	else
		return true
	end
end

local function err(self, errMsg, pos)
	if self.options.errorHandler then
		self.options.errorHandler(errMsg, pos)
	end
end

local function stripWS(self, s)
	if self.options.stripWS then
		s = string.gsub(s, "^%s+", "")
		s = string.gsub(s, "%s+$", "")
	end

	return s
end

local function parseEntities(self, s)
	if self.options.expandEntities then
		for k, v in pairs(self._ENTITIES) do
			s = string.gsub(s, k, v)
		end
	end

	return s
end

local function parseTag(self, s)
	local tag = {
		name = string.gsub(s, self._TAG, "%1"),
		attrs = {}
	}

	local function parseFunction(k, v)
		tag.attrs[k] = parseEntities(self, v)
		tag.attrs._ = 1
	end

	string.gsub(s, self._ATTR1, parseFunction)
	string.gsub(s, self._ATTR2, parseFunction)

	if tag.attrs._ then
		tag.attrs._ = nil
	else
		tag.attrs = nil
	end

	return tag
end

local function parseXmlDeclaration(self, xml, f)
	f.match, f.endMatch, f.text = string.find(xml, self._PI, f.pos)

	if not f.match then
		err(self, self._errstr.declErr, f.pos)
	end

	if f.match ~= 1 then
		err(self, self._errstr.declStartErr, f.pos)
	end

	local tag = parseTag(self, f.text)

	if tag.attrs and tag.attrs.version == nil then
		err(self, self._errstr.declAttrErr, f.pos)
	end

	if fexists(self.handler, "decl") then
		self.handler:decl(tag, f.match, f.endMatch)
	end

	return tag
end

local function parseXmlProcessingInstruction(self, xml, f)
	local tag = {}

	f.match, f.endMatch, f.text = string.find(xml, self._PI, f.pos)

	if not f.match then
		err(self, self._errstr.piErr, f.pos)
	end

	if fexists(self.handler, "pi") then
		tag = parseTag(self, f.text)

		local pi = string.sub(f.text, string.len(tag.name) + 1)

		if pi ~= "" then
			if tag.attrs then
				tag.attrs._text = pi
			else
				tag.attrs = {
					_text = pi
				}
			end
		end

		self.handler:pi(tag, f.match, f.endMatch)
	end

	return tag
end

local function parseComment(self, xml, f)
	f.match, f.endMatch, f.text = string.find(xml, self._COMMENT, f.pos)

	if not f.match then
		err(self, self._errstr.commentErr, f.pos)
	end

	if fexists(self.handler, "comment") then
		f.text = parseEntities(self, stripWS(self, f.text))

		self.handler:comment(f.text, next, f.match, f.endMatch)
	end
end

local function _parseDtd(self, xml, pos)
	local dtdPatterns = {
		self._DTD1,
		self._DTD2,
		self._DTD3,
		self._DTD4,
		self._DTD5
	}

	for _, dtd in pairs(dtdPatterns) do
		local m, e, r, t, n, u, i = string.find(xml, dtd, pos)

		if m then
			return m, e, {
				_root = r,
				_type = t,
				_name = n,
				_uri = u,
				_internal = i
			}
		end
	end

	return nil
end

local function parseDtd(self, xml, f)
	f.match, f.endMatch, _ = _parseDtd(self, xml, f.pos)

	if not f.match then
		err(self, self._errstr.dtdErr, f.pos)
	end

	if fexists(self.handler, "dtd") then
		local tag = {
			name = "DOCTYPE",
			value = string.sub(xml, f.match + 10, f.endMatch - 1)
		}

		self.handler:dtd(tag, f.match, f.endMatch)
	end
end

local function parseCdata(self, xml, f)
	f.match, f.endMatch, f.text = string.find(xml, self._CDATA, f.pos)

	if not f.match then
		err(self, self._errstr.cdataErr, f.pos)
	end

	if fexists(self.handler, "cdata") then
		self.handler:cdata(f.text, nil, f.match, f.endMatch)
	end
end

local function parseNormalTag(self, xml, f)
	while true do
		f.errStart, f.errEnd = string.find(f.tagstr, self._ATTRERR1)

		if f.errEnd == nil then
			f.errStart, f.errEnd = string.find(f.tagstr, self._ATTRERR2)

			if f.errEnd == nil then
				break
			end
		end

		f.extStart, f.extEnd, f.endt2 = string.find(xml, self._TAGEXT, f.endMatch + 1)
		f.tagstr = f.tagstr .. string.sub(xml, f.endMatch, f.extEnd - 1)

		if not f.match then
			err(self, self._errstr.xmlErr, f.pos)
		end

		f.endMatch = f.extEnd
	end

	local tag = parseTag(self, f.tagstr)

	if f.endt1 == "/" then
		if fexists(self.handler, "endtag") then
			if tag.attrs then
				err(self, string.format("%s (/%s)", self._errstr.endTagErr, tag.name), f.pos)
			end

			if table.remove(self._stack) ~= tag.name then
				err(self, string.format("%s (/%s)", self._errstr.unmatchedTagErr, tag.name), f.pos)
			end

			self.handler:endtag(tag, f.match, f.endMatch)
		end
	else
		table.insert(self._stack, tag.name)

		if fexists(self.handler, "starttag") then
			self.handler:starttag(tag, f.match, f.endMatch)
		end

		if f.endt2 == "/" then
			table.remove(self._stack)

			if fexists(self.handler, "endtag") then
				self.handler:endtag(tag, f.match, f.endMatch)
			end
		end
	end

	return tag
end

local function parseTagType(self, xml, f)
	if string.find(string.sub(f.tagstr, 1, 5), "?xml%s") then
		parseXmlDeclaration(self, xml, f)
	elseif string.sub(f.tagstr, 1, 1) == "?" then
		parseXmlProcessingInstruction(self, xml, f)
	elseif string.sub(f.tagstr, 1, 3) == "!--" then
		parseComment(self, xml, f)
	elseif string.sub(f.tagstr, 1, 8) == "!DOCTYPE" then
		parseDtd(self, xml, f)
	elseif string.sub(f.tagstr, 1, 8) == "![CDATA[" then
		parseCdata(self, xml, f)
	else
		parseNormalTag(self, xml, f)
	end
end

local function getNextTag(self, xml, f)
	f.match, f.endMatch, f.text, f.endt1, f.tagstr, f.endt2 = string.find(xml, self._XML, f.pos)

	if not f.match then
		if string.find(xml, self._WS, f.pos) then
			if #self._stack ~= 0 then
				err(self, self._errstr.incompleteXmlErr, f.pos)
			else
				return false
			end
		else
			err(self, self._errstr.xmlErr, f.pos)
		end
	end

	f.text = f.text or ""
	f.tagstr = f.tagstr or ""
	f.match = f.match or 0

	return f.endMatch ~= nil
end

function ResSplitXmlParser:parse(xml, parseAttributes)
	if type(self) ~= "table" or getmetatable(self) ~= ResSplitXmlParser then
		error("You must call xmlparser:parse(parameters) instead of xmlparser.parse(parameters)")
	end

	if parseAttributes == nil then
		parseAttributes = true
	end

	self.handler.parseAttributes = parseAttributes

	local f = {
		match = 0,
		pos = 1,
		endMatch = 0
	}

	while f.match do
		if not getNextTag(self, xml, f) then
			break
		end

		f.startText = f.match
		f.endText = f.match + string.len(f.text) - 1
		f.match = f.match + string.len(f.text)
		f.text = parseEntities(self, stripWS(self, f.text))

		if f.text ~= "" and fexists(self.handler, "text") then
			self.handler:text(f.text, nil, f.match, f.endText)
		end

		parseTagType(self, xml, f)

		f.pos = f.endMatch + 1
	end
end

ResSplitXmlParser.__index = ResSplitXmlParser

return ResSplitXmlParser
