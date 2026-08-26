-- chunkname: @modules/logic/ressplit/xml/ResSplitXmlDom.lua

module("modules.logic.ressplit.xml.ResSplitXmlDom", package.seeall)

local function init()
	return {
		options = {
			declNode = 1,
			dtdNode = 1,
			piNode = 1,
			commentNode = 1
		},
		current = {
			_type = "ROOT",
			_children = {}
		},
		_stack = {}
	}
end

local ResSplitXmlDom = init()

function ResSplitXmlDom:new()
	local obj = init()

	obj.__index = self

	setmetatable(obj, self)

	return obj
end

function ResSplitXmlDom:starttag(tag)
	local node = {
		_type = "ELEMENT",
		_name = tag.name,
		_attr = tag.attrs,
		_children = {}
	}

	if self.root == nil then
		self.root = node
	end

	table.insert(self._stack, node)
	table.insert(self.current._children, node)

	self.current = node
end

function ResSplitXmlDom:endtag(tag, s)
	local prev = self._stack[#self._stack]

	if tag.name ~= prev._name then
		error("XML Error - Unmatched Tag [" .. s .. ":" .. tag.name .. "]\n")
	end

	table.remove(self._stack)

	self.current = self._stack[#self._stack]
end

function ResSplitXmlDom:text(text)
	local node = {
		_type = "TEXT",
		_text = text
	}

	table.insert(self.current._children, node)
end

function ResSplitXmlDom:comment(text)
	if self.options.commentNode then
		local node = {
			_type = "COMMENT",
			_text = text
		}

		table.insert(self.current._children, node)
	end
end

function ResSplitXmlDom:pi(tag)
	if self.options.piNode then
		local node = {
			_type = "PI",
			_name = tag.name,
			_attr = tag.attrs
		}

		table.insert(self.current._children, node)
	end
end

function ResSplitXmlDom:decl(tag)
	if self.options.declNode then
		local node = {
			_type = "DECL",
			_name = tag.name,
			_attr = tag.attrs
		}

		table.insert(self.current._children, node)
	end
end

function ResSplitXmlDom:dtd(tag)
	if self.options.dtdNode then
		local node = {
			_type = "DTD",
			_name = tag.name,
			_attr = tag.attrs
		}

		table.insert(self.current._children, node)
	end
end

ResSplitXmlDom.cdata = ResSplitXmlDom.text
ResSplitXmlDom.__index = ResSplitXmlDom

return ResSplitXmlDom
