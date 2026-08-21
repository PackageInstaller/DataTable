-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/preinstall/CharacterPreinstallModle.lua

module("logic.extensions.charactersystem.view.preinstall.CharacterPreinstallModle", package.seeall)

local M = class("CharacterPreinstallModle", BaseModel)
local HandleType = {
	Delete = 2,
	Save = 1,
	Change = 3
}

function M:ctor()
	M.super.ctor(self)
	self:onInit()
end

function M:onInit()
	self:onReset()
end

function M:onReset()
	self._preinstallHeroList = {}
	self._preinstallsList = {}
	self._itemList = {}
end

function M:updateCharPreinstall(msg)
	if not msg then
		return
	end

	for k, v in ipairs(msg) do
		if v.presets == nil or #v.presets == 0 then
			local tempstr = string.format("角色%s的装备预设为空", v.hero)

			printWarn(tempstr)
		else
			local preinstallList = v.presets

			for _, tv in ipairs(preinstallList) do
				local index = self:getPreOfListIndex(v.hero, tv.id)

				if index then
					self:updateHeroPreinstallList(tv, HandleType.Change)
				else
					self:updateHeroPreinstallList(tv, HandleType.Save)
				end
			end

			table.sort(self._preinstallHeroList[v.hero], function(presetA, presetB)
				if presetA.lastModifyTime > presetB.lastModifyTime then
					return true
				end

				return false
			end)
		end
	end
end

function M:updateDelCharPreinstall(msg)
	if not msg then
		return
	end

	for k, v in ipairs(msg) do
		if v.presets == nil or #v.presets == 0 then
			local tempstr = string.format("角色%s的装备预设为空", v.hero)

			printWarn(tempstr)
		else
			local preinstallList = v.presets

			for _, tv in ipairs(preinstallList) do
				self:updateHeroPreinstallList(tv, HandleType.Delete)
			end

			table.sort(self._preinstallHeroList[v.hero], function(presetA, presetB)
				if presetA.lastModifyTime > presetB.lastModifyTime then
					return true
				end

				return false
			end)
		end
	end
end

function M:getHeroPreinstallList(heroId)
	if self._preinstallHeroList[heroId] then
		return self._preinstallHeroList[heroId]
	end

	return nil
end

function M:getHeroPreinstall(heroId, id)
	if self._preinstallHeroList[heroId] then
		local index = self:getPreOfListIndex(heroId, id)

		return self._preinstallHeroList[heroId][index]
	end

	return nil
end

function M:getPreOfListIndex(heroId, id)
	local presets = self._preinstallHeroList[heroId]

	if not presets then
		return nil
	else
		for k, v in ipairs(presets) do
			if v.id == id then
				return k
			end
		end
	end

	return nil
end

function M:getPreInAllById(id)
	return self._preinstallsList[id]
end

function M:getItemPreinstallList(echoId)
	if self._itemList[echoId] then
		local temp = {}

		for k, v in ipairs(self._itemList[echoId]) do
			temp[k] = self._preinstallsList[v]
		end

		return temp
	end

	return nil
end

function M:updateHeroPreinstallList(onepreinstallData, handleType)
	if not onepreinstallData then
		return
	end

	local preinstallId = onepreinstallData.id

	if handleType == HandleType.Save then
		self:addHeroPreinsatll(onepreinstallData)
		self:addItemPreinsatll(onepreinstallData.echo, preinstallId)
		self:addItemPreinsatll(onepreinstallData.equip1, preinstallId)
		self:addItemPreinsatll(onepreinstallData.equip2, preinstallId)
		self:addItemPreinsatll(onepreinstallData.equip3, preinstallId)
	elseif handleType == HandleType.Delete then
		local preinstall = self:getHeroPreinstall(onepreinstallData.hero, preinstallId)

		if preinstall then
			self:deleteItemPreinsatll(preinstall.echo, preinstallId)
			self:deleteItemPreinsatll(preinstall.equip1, preinstallId)
			self:deleteItemPreinsatll(preinstall.equip2, preinstallId)
			self:deleteItemPreinsatll(preinstall.equip3, preinstallId)
		end

		self:deleteHeroPreinsatll(onepreinstallData)
	elseif handleType == HandleType.Change then
		local preinstall = self:getPreInAllById(preinstallId)

		self:changeItemPreinstall(preinstall.echo, onepreinstallData.echo)
		self:changeItemPreinstall(preinstall.equip1, onepreinstallData.equip1)
		self:changeItemPreinstall(preinstall.equip2, onepreinstallData.equip2)
		self:changeItemPreinstall(preinstall.equip3, onepreinstallData.equip3)
		self:changeHeroPreinsatll(onepreinstallData)
	end
end

function M:addHeroPreinsatll(onepreinstallData)
	local heroId = onepreinstallData.hero

	if not self._preinstallHeroList[heroId] then
		local preinstallList = {}

		preinstallList[1] = onepreinstallData
		self._preinstallHeroList[heroId] = preinstallList
	else
		local numLimit = CharacterPreinstallConfig.instance:GetPreinstallNumLimit()
		local length = #self._preinstallHeroList[heroId]

		if length < numLimit then
			self._preinstallHeroList[heroId][length + 1] = onepreinstallData
		end
	end

	self._preinstallsList[onepreinstallData.id] = onepreinstallData
end

function M:deleteHeroPreinsatll(onepreinstallData)
	local heroId = onepreinstallData.hero

	if not self._preinstallHeroList[heroId] then
		return false
	else
		local index

		for k, v in ipairs(self._preinstallHeroList[heroId]) do
			if v.id == onepreinstallData.id then
				index = k

				break
			end
		end

		local index_1

		for k, v in ipairs(self._preinstallsList) do
			if v.id == onepreinstallData.id then
				index_1 = k

				break
			end
		end

		table.remove(self._preinstallHeroList[heroId], index)
		table.remove(self._preinstallsList, index_1)
	end

	return true
end

function M:addItemPreinsatll(oneItemId, preinstallId)
	if not oneItemId then
		return
	end

	local itemId = oneItemId

	if not self._itemList[itemId] then
		local tempList = {}

		tempList[1] = preinstallId
		self._itemList[itemId] = tempList
	else
		local length = #self._itemList[itemId]

		self._itemList[itemId][length + 1] = preinstallId
	end
end

function M:deleteItemPreinsatll(oneItemId, preinstallId)
	if not oneItemId then
		return
	end

	local itemId = oneItemId

	if not self._itemList[itemId] or #self._itemList[itemId] == 0 then
		return
	else
		local index

		for k, v in ipairs(self._itemList[itemId]) do
			if v == preinstallId then
				index = k

				break
			end
		end

		table.remove(self._itemList[itemId], index)

		if #self._itemList[itemId] == 0 then
			self._itemList[itemId] = nil
		end
	end
end

function M:changeHeroPreinsatll(onepreinstallData)
	if onepreinstallData then
		local index = 0

		for k, v in ipairs(self._preinstallHeroList[onepreinstallData.hero]) do
			if v.id == onepreinstallData.id then
				index = k

				break
			end
		end

		if index > 0 then
			self._preinstallHeroList[onepreinstallData.hero][index] = onepreinstallData
			self._preinstallsList[onepreinstallData.id] = onepreinstallData
		end
	end
end

function M:changeItemPreinstall(preItemId, curItemId)
	if preItemId and not curItemId then
		self._itemList[preItemId] = nil
	end
end

M.instance = M.New()

return M
