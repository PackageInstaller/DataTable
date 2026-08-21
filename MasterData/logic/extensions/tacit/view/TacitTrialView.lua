-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tacit/view/TacitTrialView.lua

module("logic.extensions.tacit.view.TacitTrialView", package.seeall)

local M = class("TacitTrialView", DynamicFragmentView)
local StageType = {
	Thrid = 3,
	Second = 2,
	First = 1
}
local Tacit_Select_Stage_KEY = "Tacit_Select_Stage"
local Tacit_Finish_Task_VoiceId = 27

function M:buildUI()
	self._StageTb = {
		lines = {
			self:getGo("tacit_trial_panel_1233449380"),
			self:getGo("tacit_trial_panel_2022691038"),
			self:getGo("tacit_trial_panel_1969296973")
		},
		btns = {
			self:getBtn("tacit_trial_panel_888544112"),
			self:getBtn("tacit_trial_panel_770137923"),
			self:getBtn("tacit_trial_panel_115477359")
		},
		tips = {
			self:getText("tacit_trial_panel_-1537488499"),
			self:getText("tacit_trial_panel_1849422019"),
			self:getText("tacit_trial_panel_-367862114")
		},
		locks = {
			self:getGo("tacit_trial_panel_-2105187441"),
			self:getGo("tacit_trial_panel_-2111054323"),
			self:getGo("tacit_trial_panel_-1768178646")
		},
		normals = {
			self:getGo("tacit_trial_panel_1349990502"),
			self:getGo("tacit_trial_panel_1827847021"),
			self:getGo("tacit_trial_panel_1963963880")
		},
		select = {
			self:getGo("tacit_trial_panel_720880705"),
			self:getGo("tacit_trial_panel_1687363685"),
			self:getGo("tacit_trial_panel_1601507208")
		},
		redpoint = {
			self:getGo("6&red_point_-1414002736"),
			self:getGo("7&red_point_-1414002736"),
			self:getGo("8&red_point_-1414002736")
		}
	}
	self._taskScrollGo = self:getGo("tacit_trial_panel_1030494170")
	self._scrollView = LoopGridViewHelper.New(self._taskScrollGo)

	self._scrollView:InitGridView(0, self._updateCell, self)

	self._dialogGO = self:getGo("dialogue_-1584339662")
	self._txtDialog = self:getText("dialogue_-471327988")
end

function M:destroyUI()
	self._scrollView:Dispose()

	self._scrollView = nil
end

function M:bindEvents()
	local btns = self._StageTb.btns

	for i = 1, #btns do
		if i ~= #btns then
			goutil.setActive(self._StageTb.lines[i], true)
		end

		btns[i]:AddClickListener(function()
			self:_onClickStage(i)
		end, self)
	end

	GlobalDispatcher:addEventListener(EventType.TACIT_REFRESH_TASK_VIEW, self._onRefreshTaskSuc, self)
	GlobalDispatcher:addEventListener(EventType.TACIT_GET_REWARD_QIPAO_EVENT, self._onShowQiPaoInfo, self)
end

function M:unbindEvents()
	local btns = self._StageTb.btns

	for i = 1, #btns do
		btns[i]:RemoveClickListener()
	end

	GlobalDispatcher:removeEventListener(EventType.TACIT_REFRESH_TASK_VIEW, self._onRefreshTaskSuc, self)
	GlobalDispatcher:removeEventListener(EventType.TACIT_GET_REWARD_QIPAO_EVENT, self._onShowQiPaoInfo, self)
end

function M:onEnter()
	self._curShowList = false

	local viewPageMo = HeroDepotModel.instance:getViewPageMo()

	self._heroData = viewPageMo and viewPageMo.hero or false
	self._Tacit_Select_Stage = Tacit_Select_Stage_KEY .. PlayerModel.instance:getId() .. self._heroData:getId()

	local lastSelectStage = Astral.LocalStorage.Instance:GetInt(self._Tacit_Select_Stage, StageType.First)

	self._curSelectStage = lastSelectStage

	TacitAgent.instance:sendGetTaskInfoRequest(self._heroData:getId())
	self:_refreshDataByStage(true)
end

function M:onExit()
	Astral.LocalStorage.Instance:SetInt(self._Tacit_Select_Stage, self._curSelectStage)
	self._scrollView:ClearCells()
	self:_onPlayVoiceFinish()
	CriwareAudioFacade.instance:stopVoice()
end

function M:_refreshUnlockTips()
	local count = #self._StageTb.btns

	for i = 1, count do
		local stageCO = TacitConfig.instance:getTacitStageCO(i)

		if stageCO then
			local needLevel = stageCO.level
			local curLevel = self._heroData:getTacit()
			local isEnoughLevel = needLevel <= curLevel

			goutil.setActive(self._StageTb.locks[i], not isEnoughLevel)

			if not isEnoughLevel then
				goutil.setActive(self._StageTb.normals[i], false)
				goutil.setActive(self._StageTb.select[i], false)
				goutil.setActive(self._StageTb.redpoint[i], false)
			else
				goutil.setActive(self._StageTb.normals[i], i ~= self._curSelectStage)
				goutil.setActive(self._StageTb.select[i], i == self._curSelectStage)

				local hasRedDot = false

				hasRedDot = TacitModel.instance:checkHasRedDot(i)

				goutil.setActive(self._StageTb.redpoint[i], hasRedDot)
			end

			self._StageTb.tips[i].text = langF("tip_tacit_unlock_level", needLevel)
		end
	end

	if self._StageTb.lines and self._StageTb.lines[self._curSelectStage - 1] then
		goutil.setActive(self._StageTb.lines[self._curSelectStage - 1], false)
	end
end

function M:_refreshDataByStage(refresh)
	if self._curSelectStage == StageType.First then
		self._curShowList = TacitModel.instance:getFirstStageList()
	elseif self._curSelectStage == StageType.Second then
		self._curShowList = TacitModel.instance:getSecondStageList()
	elseif self._curSelectStage == StageType.Thrid then
		self._curShowList = TacitModel.instance:getThirdStageList()
	end

	local count = #self._curShowList

	self._scrollView:ClearCells()
	self._scrollView:SetListItemCount(count, refresh)
	self._scrollView:RefreshAllShownItem()
	self:_refreshUnlockTips()
end

function M:_onRefreshTaskSuc(evt, showExpAnim)
	self:_refreshDataByStage(false)
end

function M:_onShowQiPaoInfo(evt, levelUp)
	self:_showDialogInfo(levelUp)
end

function M:_updateCell(curIndex, row, column)
	if curIndex < 0 then
		return nil
	end

	curIndex = curIndex + 1

	local item = self._scrollView:NewListViewItem("tacit_trial_item")

	if self._curShowList then
		local itemData = self._curShowList[curIndex]
		local shower = Astral.LuaComponentContainer.Add(item.gameObject, TacitTaskItem)

		shower:setCellData(itemData, curIndex)
		shower:setClickCallBack(self._onClickTaskItem, self)
	end

	return item
end

function M:_onClickTaskItem(data)
	if data then
		if data:getHasFinish() then
			return
		end

		if data:getCanReward() then
			TacitAgent.instance:sendTakeTaskRewardRequest(data:getId(), self._heroData:getId())
		elseif not data:getIsTarget() then
			TacitAgent.instance:sendMarkPrimaryTaskRequest(data:getId())

			return
		end
	end
end

function M:_onRefreshTaskView(evt)
	return
end

function M:_showUpgradeLevel(newLevel)
	ViewMgr.instance:open(ViewName.TacitPlotPromoteTipsView, {
		heroData = self._heroData,
		level = newLevel
	})
end

function M:_showDialogInfo(levelUp)
	local heroId = self._heroData:getId()
	local audioId = levelUp and CharacterInfoEnum.VoiceResKey.haogan or CharacterInfoEnum.VoiceResKey.haoganrenwu

	if not levelUp then
		local playSuc = CriwareAudioFacade.instance:playVoiceByAudioId(audioId, heroId, self._onPlayVoiceFinish, self)

		goutil.setActive(self._dialogGO, playSuc)
	end

	local audioCO = CharacterAudioConfig.instance:getCharacterAudioCOByHeroIdAndAudioId(heroId, audioId)

	if audioCO then
		self._txtDialog.text = audioCO.qipaoContent

		local faceStr = ExpressionConfig.instance:getFaceResByName(self._heroData:getModelId(), audioCO.expressionName)
	end
end

function M:_onPlayVoiceFinish()
	goutil.setActive(self._dialogGO, false)
end

function M:_onClickStage(index)
	local stageCO = TacitConfig.instance:getTacitStageCO(index)

	if stageCO then
		local needLevel = stageCO.level
		local curLevel = self._heroData:getTacit()
		local isEnoughLevel = needLevel <= curLevel

		if not isEnoughLevel then
			FloatWordMgr.instance:show(langF("tip_tacit_not_engouh_level", needLevel))

			return
		end
	end

	if self._StageTb.lines and self._StageTb.lines[index - 1] then
		goutil.setActive(self._StageTb.lines[index - 1], false)
	end

	self._curSelectStage = index

	self:_refreshDataByStage(true)
end

return M
