-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddessshop/data/GoddessShopChatTree.lua

module("logic.extensions.goddessshop.data.GoddessShopChatTree", package.seeall)

local GoddessShopChatTree = class("GoddessShopChatTree")

function GoddessShopChatTree:ctor(dialoguePlanId, dialogueId)
	self._root = nil
	self._lookUp = {}

	local cfg = GoddessShopConfig.instance:getDialogueCfg(dialoguePlanId, dialogueId)

	if cfg then
		local rootChatId = 1

		self._root = {
			current = rootChatId,
			children = {}
		}

		local rootNode = self._root
		local lookup = self._lookUp

		lookup[rootChatId] = rootNode

		local queue = {}

		table.insert(queue, rootNode)

		local processedNodes = {}

		while #queue > 0 do
			local node = table.remove(queue, 1)

			if not processedNodes[node.current] then
				processedNodes[node.current] = true

				local data = cfg[node.current]

				if data then
					local arr

					if data.waitAnswer then
						arr = data.waitAnswer
					elseif data.autoNext > 0 then
						arr = {
							data.autoNext
						}
					end

					if arr then
						for _, chatId in ipairs(arr) do
							local childNode = {
								current = chatId,
								parent = node,
								children = {}
							}

							table.insert(node.children, childNode)
							table.insert(queue, childNode)

							lookup[childNode.current] = childNode
						end
					end
				else
					printError(string.format("错误！配置缺失，%s-%s-%s ", dialoguePlanId, dialogueId, node.current))
				end
			else
				printError(string.format("错误！检测到循环引用，%s-%s-%s ", dialoguePlanId, dialogueId, node.current))
			end
		end
	end
end

function GoddessShopChatTree:dispose()
	table.clear(self._lookUp)

	self._lookUp = nil
	self._root = nil
end

function GoddessShopChatTree:findChatNode(chatId)
	return self._lookUp[chatId]
end

function GoddessShopChatTree:getChatIdListFromRoot(chatId)
	local list = {}
	local node = self:_findChatNode(chatId)

	if node == nil then
		printError(string.format("错误，未找到 chatId:%s 对应的节点。", chatId))

		return list
	end

	while node do
		table.insert(list, node.current)

		node = node.parent
	end

	local left, right = 1, #list

	while left < right do
		list[left], list[right] = list[right], list[left]
		left = left + 1
		right = right - 1
	end

	return list
end

function GoddessShopChatTree:getChatIdListByAnswer(answerIds)
	local list = {}
	local node = self._root

	while node do
		table.insert(list, node.current)

		local children = node.children

		node = nil

		if #children == 1 then
			node = children[1]
		elseif #children >= 1 then
			for i, v in ipairs(children) do
				if table.indexof(answerIds, v.current) ~= false then
					node = children[i]

					break
				end
			end
		end
	end

	return list
end

function GoddessShopChatTree:printChatTree()
	local output = {}

	local function traverse(node, indent)
		indent = indent or ""

		table.insert(output, indent .. "- ChatId: " .. tostring(node.current))

		for _, child in ipairs(node.children) do
			traverse(child, indent .. "  ")
		end
	end

	if self._root then
		traverse(self._root)

		local treeOutput = table.concat(output, "\n")

		printError(string.format("self._curChatId = %s\n%s", self._curChatId, treeOutput))
	else
		printError("对话树为空，无法打印。")
	end
end

return GoddessShopChatTree
