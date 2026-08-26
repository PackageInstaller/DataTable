-- chunkname: @modules/logic/versionactivity3_2/huidiaolan/view/HuiDiaoLanEpisodeItem.lua

module("modules.logic.versionactivity3_2.huidiaolan.view.HuiDiaoLanEpisodeItem", package.seeall)

local HuiDiaoLanEpisodeItem = class("HuiDiaoLanEpisodeItem", LuaCompBase)

function HuiDiaoLanEpisodeItem:ctor(param)
	self.param = param
	self.episodeConfig = self.param.episodeConfig
	self.actId = self.episodeConfig.activityId
	self.episodeId = self.episodeConfig.episodeId
	self.index = self.param.index
end

function HuiDiaoLanEpisodeItem:init(go)
	self:__onInit()

	self.go = go
	self._goNormalStage = gohelper.findChild(self.go, "unlock/#go_NormalStage")
	self._goSPStage = gohelper.findChild(self.go, "unlock/#go_SPStage")
	self._goStoryStage = gohelper.findChild(self.go, "unlock/#go_StoryStage")
	self._txtStageName = gohelper.findChildText(self.go, "unlock/#txt_StageName")
	self._txtstageNum = gohelper.findChildText(self.go, "unlock/#txt_stageNum")
	self._goLockIcon = gohelper.findChild(self.go, "unlock/#go_LockIcon")
	self._gostar1 = gohelper.findChild(self.go, "unlock/Star/#go_star1")
	self._gostar2 = gohelper.findChild(self.go, "unlock/Star/#go_star2")
	self._goSelect = gohelper.findChild(self.go, "unlock/#go_Select")
	self._btnclick = gohelper.findChildButtonWithAudio(self.go, "unlock/#btn_click")
	self._animPlayer = SLFramework.AnimatorPlayer.Get(self.go)
	self.normalStageStateGOList = {}
	self.spStageStateGOList = {}
	self.storyStateGOList = {}

	for state = 1, 3 do
		local normalGO = gohelper.findChild(self._goNormalStage, HuiDiaoLanEnum.EpisodeItemStateGOName[state])

		table.insert(self.normalStageStateGOList, normalGO)

		local spGO = gohelper.findChild(self._goSPStage, HuiDiaoLanEnum.EpisodeItemStateGOName[state])

		table.insert(self.spStageStateGOList, spGO)

		local storyGO = gohelper.findChild(self._goStoryStage, HuiDiaoLanEnum.EpisodeItemStateGOName[state])

		table.insert(self.storyStateGOList, storyGO)
	end

	gohelper.setActive(self._goSelect, false)

	self.isNormalGameType = self.episodeConfig.gameId > 0 and self.episodeConfig.type == 0
	self.isSPGameType = self.episodeConfig.gameId > 0 and self.episodeConfig.type == HuiDiaoLanEnum.SpEpisodeType
	self.isStoryType = self.episodeConfig.gameId == 0

	gohelper.setActive(self._goNormalStage, self.isNormalGameType)
	gohelper.setActive(self._goSPStage, self.isSPGameType)
	gohelper.setActive(self._goStoryStage, self.isStoryType)
end

function HuiDiaoLanEpisodeItem:addEventListeners()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
	HuiDiaoLanGameController.instance:registerCallback(HuiDiaoLanEvent.NextEpisodePlayUnlockAnim, self.playUnlockAnim, self)
end

function HuiDiaoLanEpisodeItem:removeEventListeners()
	self._btnclick:RemoveClickListener()
	HuiDiaoLanGameController.instance:unregisterCallback(HuiDiaoLanEvent.NextEpisodePlayUnlockAnim, self.playUnlockAnim, self)
end

function HuiDiaoLanEpisodeItem:_btnclickOnClick()
	local isOpen = self:checkIsOpen()

	if not isOpen then
		return
	end

	HuiDiaoLanModel.instance:setCurEpisodeId(self.episodeId)
	HuiDiaoLanGameController.instance:dispatchEvent(HuiDiaoLanEvent.SelectEpisode, self.episodeId)
end

function HuiDiaoLanEpisodeItem:checkIsOpen()
	local mo = ActivityModel.instance:getActMO(self.actId)

	if mo == nil then
		logError("活动数据不存在, id: " .. self.actId)

		return false
	end

	if not mo:isOpen() or mo:isExpired() then
		GameFacade.showToast(ToastEnum.ActivityNotInOpenTime)

		return false
	end

	self.isUnlock = HuiDiaoLanModel.instance:getEpisodeInfo(self.episodeId)

	if not self.isUnlock then
		GameFacade.showToast(ToastEnum.Activity142PreEpisodeNotClear)

		return false
	end

	return true
end

function HuiDiaoLanEpisodeItem:onRefreshUI()
	self.episodeInfo = HuiDiaoLanModel.instance:getEpisodeInfo(self.episodeId)
	self.isLock = not self.episodeInfo
	self.isFinish = self.episodeInfo and self.episodeInfo.isFinished
	self.isNormal = self.episodeInfo and not self.episodeInfo.isFinished

	local curState = HuiDiaoLanEnum.EpisodeItemState.Normal

	if self.isNormal then
		curState = HuiDiaoLanEnum.EpisodeItemState.Normal
	elseif self.isLock then
		curState = HuiDiaoLanEnum.EpisodeItemState.Locked
	elseif self.isFinish then
		curState = HuiDiaoLanEnum.EpisodeItemState.Finish
	end

	for state = 1, 3 do
		gohelper.setActive(self.normalStageStateGOList[state], state == curState)
		gohelper.setActive(self.spStageStateGOList[state], state == curState)
		gohelper.setActive(self.storyStateGOList[state], state == curState)
	end

	self._txtStageName.text = self.episodeConfig.name
	self._txtstageNum.text = self.isSPGameType and "STAGE-SP" or string.format("STAGE-%02d", self.index)

	gohelper.setActive(self._goLockIcon, self.isLock)
	gohelper.setActive(self._gostar1, self.isStoryType and self.isFinish)
	gohelper.setActive(self._gostar2, not self.isStoryType and self.isFinish)
end

function HuiDiaoLanEpisodeItem:setSelectState(curEpisodeId)
	gohelper.setActive(self._goSelect, curEpisodeId == self.episodeId)
end

function HuiDiaoLanEpisodeItem:playFinishAnim()
	self._animPlayer:Play("finish", self.onRefreshUI, self)
end

function HuiDiaoLanEpisodeItem:playUnlockAnim(episodeId)
	local newUnlockEpisodeInfoList = HuiDiaoLanModel.instance:getNewUnlockEpisodeInfoList()

	for _, episodeInfo in ipairs(newUnlockEpisodeInfoList) do
		if episodeInfo.episodeId == self.episodeId and self.episodeConfig.preEpisodeId == episodeId then
			gohelper.setActive(self.normalStageStateGOList[HuiDiaoLanEnum.EpisodeItemState.Normal], true)
			gohelper.setActive(self.spStageStateGOList[HuiDiaoLanEnum.EpisodeItemState.Normal], true)
			gohelper.setActive(self.storyStateGOList[HuiDiaoLanEnum.EpisodeItemState.Normal], true)
			self._animPlayer:Play("unlock", self.onRefreshUI, self)
		end
	end
end

function HuiDiaoLanEpisodeItem:destroy()
	return
end

return HuiDiaoLanEpisodeItem
