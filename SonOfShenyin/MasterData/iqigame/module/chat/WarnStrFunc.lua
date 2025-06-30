-- chunkname: @IQIGame\\Module\\Chat\\WarnStrFunc.lua

WarnStrFunc = {}

function WarnStrFunc:init()
	self:createTree()
end

function WarnStrFunc:createNode(c, flag, nodes)
	local node = {}

	node.c = c or nil
	node.flag = flag or 0
	node.nodes = nodes or {}

	return node
end

function WarnStrFunc:createTree()
	self.rootNode = self:createNode("R")

	for i, v in pairsCfg(CfgDirtyWordsTable) do
		local chars = self:getCharArray(v.DirtyWord)

		if #chars > 0 then
			self:insertNode(self.rootNode, chars, 1)
		end
	end
end

function WarnStrFunc:insertNode(node, cs, index)
	local n = self:findNode(node, cs[index])

	if n == nil then
		n = self:createNode(cs[index])

		table.insert(node.nodes, n)
	end

	if index == #cs then
		n.flag = 1
	end

	index = index + 1

	if index <= #cs then
		self:insertNode(n, cs, index)
	end
end

function WarnStrFunc:findNode(node, c)
	local nodes = node.nodes
	local rn

	for i, v in ipairs(nodes) do
		if v.c == c then
			rn = v

			break
		end
	end

	return rn
end

function WarnStrFunc:getCharArray(str)
	local array = {}

	if str == nil then
		return array
	end

	local len = string.len(str)

	while str do
		local fontUTF = string.byte(str, 1)

		if fontUTF == nil then
			break
		end

		if fontUTF > 127 then
			local tmp = string.sub(str, 1, 3)

			table.insert(array, tmp)

			str = string.sub(str, 4, len)
		else
			local tmp = string.sub(str, 1, 1)

			table.insert(array, tmp)

			str = string.sub(str, 2, len)
		end
	end

	return array
end

function WarnStrFunc:warningStrGsub(inputStr)
	local chars = self:getCharArray(inputStr)
	local index = 1
	local node = self.rootNode
	local word = {}

	while index <= #chars do
		if chars[index] ~= " " then
			node = self:findNode(node, chars[index])
		end

		if node == nil then
			index = index - #word
			node = self.rootNode
			word = {}
		elseif node.flag == 1 then
			table.insert(word, index)

			for i, v in ipairs(word) do
				chars[v] = "*"
			end

			node = self.rootNode
			word = {}
		else
			table.insert(word, index)
		end

		index = index + 1
	end

	local str = ""

	for i, v in ipairs(chars) do
		str = str .. v
	end

	return str
end

function WarnStrFunc:isWarningInPutStr(inputStr)
	local chars = self:getCharArray(inputStr)
	local index = 1
	local node = self.rootNode
	local word = {}

	while index <= #chars do
		if chars[index] ~= " " then
			node = self:findNode(node, chars[index])
		end

		if node == nil then
			index = index - #word
			node = self.rootNode
			word = {}
		elseif node.flag == 1 then
			return true
		else
			table.insert(word, index)
		end

		index = index + 1
	end

	return false
end

WarnStrFunc:init()

return WarnStrFunc
