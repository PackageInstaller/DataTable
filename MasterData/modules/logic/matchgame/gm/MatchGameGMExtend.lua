-- chunkname: @modules/logic/matchgame/gm/MatchGameGMExtend.lua

module("modules.logic.matchgame.gm.MatchGameGMExtend", package.seeall)

local MatchGameGMExtend = class("MatchGameGMExtend", GMServerCommandExtendBase)

function MatchGameGMExtend:initUI()
	local obj = self.obj

	obj:addLineIndex()
	obj:addLabel(obj:getLineGroup(), "活动ID")

	self._actIdInput = obj:addInputText(obj:getLineGroup(), ActivityEnum.Activity.V4a0_MatchGame)

	obj:addButton(obj:getLineGroup(), "进入游戏", self._onClickEnterGame, self)
	obj:addLineIndex()

	self._levelIdInput = obj:addInputText(obj:getLineGroup(), MatchGameFightEnum.TestEpisodeId)
	self._heroIdListInput = obj:addInputText(obj:getLineGroup(), "1001#1002#1008#1015", "角色id用#隔开")

	obj:addButton(obj:getLineGroup(), "进入关卡", self._setEpisodeLevel, self)
end

function MatchGameGMExtend:_onClickEnterGame()
	local actId = tonumber(self._actIdInput:GetText())
	local activityCo = actId and lua_activity.configDict[actId]

	if not activityCo then
		ToastController.instance:showToastWithString("不存在的活动ID")

		return
	end

	MatchGameController.instance:openEnterView(actId)
end

function MatchGameGMExtend:_setEpisodeLevel()
	local episodeId = tonumber(self._levelIdInput:GetText()) or MatchGameFightEnum.TestEpisodeId
	local heroIdListStr = self._heroIdListInput:GetText()
	local heroIdList = string.splitToNumber(heroIdListStr, "#")

	MatchGameFightEnum.TestHeroInfoIds = heroIdList
	MatchGameFightEnum.TestEpisodeId = episodeId
	MatchGameHeroGroupModel.instance._teamHeroMap[1] = MatchGameHeroGroupModel.instance._teamHeroMap[1] or {}

	for posIndex, heroId in ipairs(heroIdList) do
		local singleGroupMo = MatchGameHeroSingleGroupMo.New()
		local characterMo = MatchGameCharacterMo.New()

		characterMo:init({
			heroId = heroId,
			level = MatchGameFightEnum.TestHeroLevel
		})
		singleGroupMo:initData(posIndex, heroId, characterMo, heroId)

		MatchGameHeroGroupModel.instance._teamHeroMap[1][posIndex] = singleGroupMo
	end

	local params = {
		isGM = true
	}

	MatchGameController.instance:openMatchGameFightView(params)
end

function MatchGameGMExtend:getInput_addItems_1(inputData, lastInput)
	local obj = self.obj
	local allItems = {}
	local itemNames = {}
	local selectVal = 1
	local lastItemId
	local addItemNum = 1

	if not string.nilorempty(lastInput) then
		local arr = string.split(lastInput, "#")

		lastItemId = tonumber(arr[1])
		addItemNum = tonumber(arr[2]) or 1
	end

	for i, v in ipairs(lua_activity244_item.configList) do
		table.insert(allItems, v)
		table.insert(itemNames, v.name .. "\n" .. v.itemId)

		if lastItemId == v.itemId then
			selectVal = i
		end
	end

	inputData.dropDown = obj:addDropDown(obj:getLineGroup(), "", itemNames)

	recthelper.setWidth(inputData.dropDown.transform, 400)

	inputData.input2 = obj:addInputText(obj:getLineGroup())
	inputData.items = allItems

	inputData.input2:SetText(addItemNum)
	inputData.dropDown:SetValue(selectVal - 1)

	return inputData
end

function MatchGameGMExtend:getText_addItems_1(inputData)
	local index = inputData.dropDown:GetValue() + 1

	return tostring(inputData.items[index].itemId) .. "#" .. (tonumber(inputData.input2:GetText()) or 1)
end

function MatchGameGMExtend:getDefaultVal_addItems_1()
	local itemCo = lua_activity244_item.configList[1]

	if not itemCo then
		return
	end

	return string.format("%s#%s", itemCo.itemId, 1)
end

function MatchGameGMExtend:getInput_unlockEpisode_1(inputData, lastInput)
	local obj = self.obj
	local episodeList = {}
	local episodeNames = {}
	local selectVal = 0
	local lastEpisodeId
	local all = {
		id = 0,
		levelName = "全部"
	}

	table.insert(episodeList, all)
	table.insert(episodeNames, all.levelName)

	for i, v in ipairs(lua_activity244_episode.configList) do
		table.insert(episodeList, v)
		table.insert(episodeNames, v.levelName)

		if ((not string.nilorempty(lastInput) or nil) and tonumber(lastInput)) == v.id then
			selectVal = i
		end
	end

	inputData.dropDown = obj:addDropDown(obj:getLineGroup(), "", episodeNames)

	recthelper.setWidth(inputData.dropDown.transform, 300)

	inputData.items = episodeList

	inputData.dropDown:SetValue(selectVal)

	return inputData
end

function MatchGameGMExtend:getText_unlockEpisode_1(inputData)
	local index = inputData.dropDown:GetValue() + 1

	return tostring(inputData.items[index].id)
end

function MatchGameGMExtend:getInput_finishEpisode_1(inputData, lastInput)
	local obj = self.obj
	local episodeList = {}
	local episodeNames = {}
	local selectVal = 0
	local lastEpisodeId
	local all = {
		id = 0,
		levelName = "全部"
	}

	table.insert(episodeList, all)
	table.insert(episodeNames, all.levelName)

	for i, v in ipairs(lua_activity244_episode.configList) do
		table.insert(episodeList, v)
		table.insert(episodeNames, v.levelName)

		if ((not string.nilorempty(lastInput) or nil) and tonumber(lastInput)) == v.id then
			selectVal = i
		end
	end

	inputData.dropDown = obj:addDropDown(obj:getLineGroup(), "", episodeNames)

	recthelper.setWidth(inputData.dropDown.transform, 300)

	inputData.items = episodeList

	inputData.dropDown:SetValue(selectVal)

	return inputData
end

function MatchGameGMExtend:getText_finishEpisode_1(inputData)
	local index = inputData.dropDown:GetValue() + 1

	return tostring(inputData.items[index].id)
end

function MatchGameGMExtend:getDefaultVal_unlockEpisode_1()
	return "0"
end

return MatchGameGMExtend
