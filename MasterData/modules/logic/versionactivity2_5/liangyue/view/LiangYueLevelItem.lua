-- chunkname: @modules/logic/versionactivity2_5/liangyue/view/LiangYueLevelItem.lua

module("modules.logic.versionactivity2_5.liangyue.view.LiangYueLevelItem", package.seeall)

local LiangYueLevelItem = class("LiangYueLevelItem", LuaCompBase)

function LiangYueLevelItem:onInit(go)
	self._go = go
	self._goGet = gohelper.findChild(self._go, "unlock/#go_afterPuzzleEpisode/#go_Get")
	self._gostagenormal = gohelper.findChild(self._go, "unlock/#go_stagenormal")
	self._gostagefinished = gohelper.findChild(self._go, "unlock/#go_stagefinished")
	self._btnclick = gohelper.findChildButtonWithAudio(self._go, "unlock/#btn_click")
	self._gostagelock = gohelper.findChild(self._go, "unlock/#go_stagelock")
	self._txtstagename = gohelper.findChildText(self._go, "unlock/#txt_stagename")
	self._txtstageNum = gohelper.findChildText(self._go, "unlock/#txt_stageNum")
	self._goAfterPuzzleItem = gohelper.findChild(self._go, "unlock/#go_afterPuzzleEpisode")
	self._btnAfterPuzzle = gohelper.findChildButton(self._go, "unlock/#go_afterPuzzleEpisode/#btn_puzzle")
	self._goStarFinish1 = gohelper.findChild(self._go, "unlock/star1/#go_star")
	self._goStarFinish2 = gohelper.findChild(self._go, "unlock/star2/#go_star")
	self._episodeAnim = gohelper.findChildAnim(self._go, "")
	self._episodeGameAnim = gohelper.findChildAnim(self._go, "unlock/#go_afterPuzzleEpisode")
	self._episodeGameFinishAnim = gohelper.findChildAnim(self._go, "unlock/#go_afterPuzzleEpisode/#go_Get/go_hasget")
end

function LiangYueLevelItem:setInfo(index, config)
	self.index = index
	self.actId = config.activityId
	self.episodeId = config.episodeId
	self.config = config
	self.preEpisodeId = config.preEpisodeId
	self.gameEpisodeId = LiangYueConfig.instance:getAfterGameEpisodeId(self.actId, config.episodeId)

	self:refreshUI()
	self:refreshStoryState(true)
	self:refreshGameState(true)
end

function LiangYueLevelItem:refreshUI()
	local config = self.config
	local actId = self.actId

	self._txtstagename.text = config.name
	self._txtstageNum.text = string.format("0%s", self.index)

	local isPreFinish = config.preEpisodeId == 0 or LiangYueModel.instance:isEpisodeFinish(actId, config.preEpisodeId)

	self.isFinish = LiangYueModel.instance:isEpisodeFinish(actId, config.episodeId)
	self.isPreFinish = isPreFinish
end

function LiangYueLevelItem:refreshStoryState(playAnim)
	local isFinish = self.isFinish
	local isPreFinish = self.isPreFinish

	gohelper.setActive(self._gostagelock, not isPreFinish)
	gohelper.setActive(self._gostagenormal, isPreFinish and not isFinish)
	gohelper.setActive(self._gostagefinished, isFinish)
	gohelper.setActive(self._goStarFinish1, isFinish)
	gohelper.setActive(self._goStarFinish2, isFinish)

	if not playAnim then
		return
	end

	local animTime = 1

	if isFinish then
		self:playEpisodeAnim(LiangYueEnum.EpisodeAnim.FinishIdle, animTime)
	elseif isPreFinish then
		self:playEpisodeAnim(LiangYueEnum.EpisodeAnim.Unlock, animTime)
	else
		self:playEpisodeAnim(LiangYueEnum.EpisodeAnim.Empty, animTime)
	end
end

function LiangYueLevelItem:setLockState()
	gohelper.setActive(self._gostagelock, true)
	gohelper.setActive(self._gostagenormal, false)
	gohelper.setActive(self._gostagefinished, false)
	gohelper.setActive(self._goStarFinish1, false)
	gohelper.setActive(self._goStarFinish2, false)
end

function LiangYueLevelItem:refreshGameState(playAnim)
	local isFinish = self.isFinish
	local haveAfterEpisode = self.gameEpisodeId ~= nil

	gohelper.setActive(self._goAfterPuzzleItem, haveAfterEpisode and isFinish)

	local finishAfterEpisode = LiangYueModel.instance:isEpisodeFinish(self.actId, self.gameEpisodeId)

	gohelper.setActive(self._goGet, finishAfterEpisode)

	local animTime = 1

	if not haveAfterEpisode or not playAnim then
		return
	end

	self:playGameEpisodeRewardAnim(LiangYueEnum.EpisodeGameFinishAnim.Idle, animTime)

	if finishAfterEpisode then
		self:playGameEpisodeAnim(LiangYueEnum.EpisodeGameAnim.FinishIdle, animTime)
	elseif isFinish then
		self:playGameEpisodeAnim(LiangYueEnum.EpisodeGameAnim.Open, animTime)
	else
		self:playGameEpisodeAnim(LiangYueEnum.EpisodeGameAnim.Idle, animTime)
	end
end

function LiangYueLevelItem:playGameEpisodeAnim(animName, animTime)
	self._episodeGameAnim:Play(animName, 0, animTime)
end

function LiangYueLevelItem:playEpisodeAnim(animName, animTime)
	self._episodeAnim:Play(animName, 0, animTime)
end

function LiangYueLevelItem:playGameEpisodeRewardAnim(animName, animTime)
	self._episodeGameFinishAnim:Play(animName, 0, animTime)
end

function LiangYueLevelItem:addEventListeners()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
	self._btnAfterPuzzle:AddClickListener(self._btnafterPuzzleOnClick, self)
end

function LiangYueLevelItem:removeEventListeners()
	self._btnclick:RemoveClickListener()
	self._btnAfterPuzzle:RemoveClickListener()
end

function LiangYueLevelItem:_btnclickOnClick()
	local actId = self.actId
	local mo = ActivityModel.instance:getActMO(actId)

	if mo == nil then
		logError("not such activity id: " .. actId)

		return
	end

	if not mo:isOpen() or mo:isExpired() then
		GameFacade.showToast(ToastEnum.ActivityNotInOpenTime)

		return
	end

	if self.config.preEpisodeId ~= 0 and not LiangYueModel.instance:isEpisodeFinish(actId, self.config.preEpisodeId) then
		GameFacade.showToast(ToastEnum.Act184PuzzleNotOpen)

		return
	end

	local episodeId = self.config.episodeId

	LiangYueController.instance:dispatchEvent(LiangYueEvent.OnClickStoryItem, self.index, episodeId, false)
end

function LiangYueLevelItem:_btnafterPuzzleOnClick()
	local actId = self.actId
	local mo = ActivityModel.instance:getActMO(actId)

	if mo == nil then
		logError("not such activity id: " .. actId)

		return
	end

	if not mo:isOpen() or mo:isExpired() then
		GameFacade.showToast(ToastEnum.ActivityNotInOpenTime)

		return
	end

	if not self.gameEpisodeId then
		logError("have no gameEpisodeId")

		return
	end

	if not LiangYueModel.instance:isEpisodeFinish(actId, self.config.episodeId) then
		GameFacade.showToast(ToastEnum.Act184PuzzleNotOpen)

		return
	end

	LiangYueController.instance:dispatchEvent(LiangYueEvent.OnClickStoryItem, self.index, self.gameEpisodeId, true)
end

function LiangYueLevelItem:onDestroy()
	return
end

return LiangYueLevelItem
