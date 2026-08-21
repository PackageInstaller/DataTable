-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/characterinformation/view/CharacterVoiceView.lua

module("logic.extensions.characterinformation.view.CharacterVoiceView", package.seeall)

local M = class("CharacterVoiceView", DynamicFragmentView)

function M:buildUI()
	self._voiceScrollGo = self:getGo("role_voice_tips_-34131455")
	self._voiceScroll = LoopListHelper.New(self._voiceScrollGo)

	self._voiceScroll:InitListView(0, self._onVoiceCellUpdate, self)
end

function M:destroyUI()
	self._voiceScroll:Dispose()

	self._voiceScroll = nil
end

function M:onEnter()
	GlobalDispatcher:addEventListener(EventType.CHARACTER_VIEW_SWITCH, self._refreshByHeroChange, self)
	self:_refreshByHeroChange()
end

function M:_refreshByHeroChange()
	local viewPageMo = HeroDepotModel.instance:getViewPageMo()

	self._heroData = viewPageMo and viewPageMo.hero or false
	self._heroId = self._heroData:getId()
	self._modelId = self._heroData:getModelId()

	self:_refreshView()
end

function checkVoiceIsUnlock(data, heroId)
	local isCanUnlock = true
	local unlockCO = CharacterUnlockContentConfig.instance:getUnlockConfigByHeroIdAndVoiceId(heroId, data.audioId)
	local universallyUnlockCO = PastInfoConfig.instance:getUniversallyUnlockConfig(data.audioId + 3000)

	if universallyUnlockCO == nil then
		printWarn("找不到通用解锁信息声音id，角色ID，", data.audioId, heroId)
	end

	local condition = unlockCO ~= nil and unlockCO.condition or universallyUnlockCO and universallyUnlockCO.condition or {}

	condition = condition or {}

	local heroData = HeroDepotModel.instance:getHeroInfoByID(heroId)
	local heroTacit = heroData and heroData:getTacit() or 0
	local heroPowerLv = heroData and heroData:getPowerLv() or 0
	local heroLv = heroData and heroData:getLevel() or 0

	for i, v in ipairs(condition) do
		if v.type == "tacitLv" and heroTacit < v.value then
			isCanUnlock = false

			return false
		end

		if v.type == "powerLv" and heroPowerLv < v.value then
			isCanUnlock = false

			return false
		end

		if v.type == "heroLv" and heroLv < v.value then
			isCanUnlock = false

			return false
		end
	end

	local VoiceEnumRes = CharacterInfoEnum.VoiceRes[data.audioId]
	local voiceRes = VoiceEnumRes and string.format(VoiceEnumRes, heroId) or data.voiceId
	local wwiseCo = CriwareAudioConfig.instance:getCOByName(voiceRes)

	if not wwiseCo then
		isCanUnlock = false
	end

	return isCanUnlock
end

function M:_refreshView()
	local cgfList = CharacterAudioConfig.instance:getCharacterAudiosById(self._heroId) or {}

	table.sort(cgfList, function(a, b)
		local aIsUnlock = checkVoiceIsUnlock(a, self._heroId) and 1 or 0
		local bIsUnlock = checkVoiceIsUnlock(b, self._heroId) and 1 or 0

		if aIsUnlock ~= bIsUnlock then
			return bIsUnlock < aIsUnlock
		else
			local aSort = CharacterAudioConfig.instance:getSoundSort(a.audioId)
			local bSort = CharacterAudioConfig.instance:getSoundSort(b.audioId)

			return aSort < bSort
		end
	end)

	self._voiceCfgList = cgfList
	self._curSelectVoiceId = 0

	self._voiceScroll:SetListItemCount(#self._voiceCfgList, true)
	self._voiceScroll:RefreshAllShownItem()
end

function M:_onVoiceCellUpdate(curIndex)
	if curIndex < 0 then
		return
	end

	curIndex = curIndex + 1

	local item

	if self._voiceCfgList then
		local itemData = self._voiceCfgList[curIndex]

		if itemData then
			item = itemData.audioId == 41 and self._voiceScroll:NewListViewItem("role_special_voice_item") or self._voiceScroll:NewListViewItem("role_voice_item")

			local shower = Astral.LuaComponentContainer.Add(item.gameObject, VoiceCellComp)

			shower:setCellData(itemData, curIndex, self._curSelectVoiceId, self._heroId)
			shower:setClickCallBack(self._clickCallBack, self)
		end
	end

	if item == nil then
		item = self._voiceScroll:NewListViewItem("role_voice_item")
	end

	return item
end

function M:_clickCallBack(data, index)
	self._curSelectVoiceId = data.audioId

	GlobalDispatcher:dispatchEvent(EventType.HERO_VOICE_DATA_CHANGE, data)
end

function M:_onClickUse(faceId, index)
	local unlockCO
end

function M:onExit()
	self._voiceScroll:ClearCells()
	GlobalDispatcher:removeEventListener(EventType.CHARACTER_VIEW_SWITCH, self._refreshByHeroChange, self)
end

return M
