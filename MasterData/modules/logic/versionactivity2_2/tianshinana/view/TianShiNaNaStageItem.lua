-- chunkname: @modules/logic/versionactivity2_2/tianshinana/view/TianShiNaNaStageItem.lua

module("modules.logic.versionactivity2_2.tianshinana.view.TianShiNaNaStageItem", package.seeall)

local TianShiNaNaStageItem = class("TianShiNaNaStageItem", LuaCompBase)

function TianShiNaNaStageItem:init(go)
	self.viewGO = go
	self._gounlock = gohelper.findChild(self.viewGO, "#go_UnLocked")
	self._gostory = gohelper.findChild(self.viewGO, "#go_UnLocked/#go_StoryStage")
	self._gogame1 = gohelper.findChild(self.viewGO, "#go_UnLocked/#go_GameStage1")
	self._gogame2 = gohelper.findChild(self.viewGO, "#go_UnLocked/#go_GameStage2")
	self._goStar1Has1 = gohelper.findChild(self.viewGO, "#go_UnLocked/#go_Star/#go_Star1/Has1")
	self._goStar1Has2 = gohelper.findChild(self.viewGO, "#go_UnLocked/#go_Star/#go_Star1/Has2")
	self._goStar1Eff = gohelper.findChild(self.viewGO, "#go_UnLocked/#go_Star/#go_Star1/eff_star")
	self._goStar2 = gohelper.findChild(self.viewGO, "#go_UnLocked/#go_Star/#go_Star2")
	self._goStar2Has1 = gohelper.findChild(self.viewGO, "#go_UnLocked/#go_Star/#go_Star2/Has1")
	self._goStar2Has2 = gohelper.findChild(self.viewGO, "#go_UnLocked/#go_Star/#go_Star2/Has2")
	self._goStar2Eff = gohelper.findChild(self.viewGO, "#go_UnLocked/#go_Star/#go_Star2/eff_star")
	self._txtstagename = gohelper.findChildTextMesh(self.viewGO, "#go_UnLocked/#txt_StageName")
	self._txtstagenameEn = gohelper.findChildTextMesh(self.viewGO, "#go_UnLocked/#txt_StageName/#txt_StageName")
	self._txtstagenum = gohelper.findChildTextMesh(self.viewGO, "#go_UnLocked/#txt_StageNum")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "#go_UnLocked/#btn_click")
	self._effect1 = gohelper.findChild(self.viewGO, "#go_UnLocked/eff_flow1")
	self._effect2 = gohelper.findChild(self.viewGO, "#go_UnLocked/eff_flow2")
	self._goChess = gohelper.findChild(self.viewGO, "image_chess")
	self._chessAnimator = gohelper.findChild(self._goChess, "ani"):GetComponent(typeof(UnityEngine.Animator))
	self._golocked = gohelper.findChild(self.viewGO, "#go_Locked")
	self._txtlockstagenum = gohelper.findChildTextMesh(self.viewGO, "#go_Locked/#txt_StageNum")
	self._anim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function TianShiNaNaStageItem:initCo(co, index)
	self._episodeCo = co
	self._index = index
	self._txtstagename.text = self._episodeCo.name
	self._txtstagenameEn.text = self._episodeCo.nameEn
	self._txtstagenum.text = string.format("%02d", self._index)
	self._txtlockstagenum.text = string.format("%02d", self._index)

	gohelper.setActive(self._gostory, self._episodeCo.episodeType == TianShiNaNaEnum.EpisodeType.Story)
	gohelper.setActive(self._gogame1, self._episodeCo.episodeType == TianShiNaNaEnum.EpisodeType.Normal)
	gohelper.setActive(self._gogame2, self._episodeCo.episodeType == TianShiNaNaEnum.EpisodeType.Hard)
	gohelper.setActive(self._effect1, self._episodeCo.episodeType ~= TianShiNaNaEnum.EpisodeType.Hard)
	gohelper.setActive(self._effect2, self._episodeCo.episodeType == TianShiNaNaEnum.EpisodeType.Hard)

	local haveStar2 = not string.nilorempty(self._episodeCo.exStarCondition)

	gohelper.setActive(self._goStar2, haveStar2)
	gohelper.setActive(self._goStar1Has1, self._episodeCo.episodeType ~= TianShiNaNaEnum.EpisodeType.Hard)
	gohelper.setActive(self._goStar1Has2, self._episodeCo.episodeType == TianShiNaNaEnum.EpisodeType.Hard)
	gohelper.setActive(self._goStar2Has1, self._episodeCo.episodeType ~= TianShiNaNaEnum.EpisodeType.Hard)
	gohelper.setActive(self._goStar2Has2, self._episodeCo.episodeType == TianShiNaNaEnum.EpisodeType.Hard)
	self:_refreshView()
end

function TianShiNaNaStageItem:addEventListeners()
	self._btnclick:AddClickListener(self._clickBtn, self)
	TianShiNaNaController.instance:registerCallback(TianShiNaNaEvent.EpisodeClick, self._playChooseEpisode, self)
	TianShiNaNaController.instance:registerCallback(TianShiNaNaEvent.EpisodeStarChange, self._onStarChange, self)
end

function TianShiNaNaStageItem:removeEventListeners()
	self._btnclick:RemoveClickListener()
	TianShiNaNaController.instance:unregisterCallback(TianShiNaNaEvent.EpisodeClick, self._playChooseEpisode, self)
	TianShiNaNaController.instance:unregisterCallback(TianShiNaNaEvent.EpisodeStarChange, self._onStarChange, self)
end

function TianShiNaNaStageItem:_onStarChange(index, preStar, star)
	if index + 1 == self._index then
		self:_refreshView()

		if preStar == 0 then
			if self._episodeCo.episodeType == TianShiNaNaEnum.EpisodeType.Hard then
				self._anim:Play("unlock_hard")
			else
				self._anim:Play("unlock")
			end
		end

		AudioEffectMgr.instance:playAudio(AudioEnum.UI.play_ui_activity_hero37_checkpoint_tongguan)
	elseif index == self._index then
		self:_refreshView()

		if preStar < 1 and star >= 1 then
			gohelper.setActive(self._goStar1Eff, true)
		end

		if preStar < 2 and star >= 2 then
			gohelper.setActive(self._goStar2Eff, true)
		end
	end
end

function TianShiNaNaStageItem:_refreshView()
	gohelper.setActive(self._goStar1Eff, false)
	gohelper.setActive(self._goStar2Eff, false)

	local unLock = true
	local preEpisodeCo = lua_activity167_episode.configDict[self._episodeCo.activityId][self._episodeCo.preEpisode]

	if preEpisodeCo then
		if preEpisodeCo.storyBefore > 0 and not StoryModel.instance:isStoryFinished(preEpisodeCo.storyBefore) then
			unLock = false
		end

		if preEpisodeCo.mapId > 0 then
			local star = TianShiNaNaModel.instance:getEpisodeStar(self._index - 1)

			if star <= 0 then
				unLock = false
			end
		end
	end

	gohelper.setActive(self._gounlock, unLock)
	gohelper.setActive(self._golocked, not unLock)
	gohelper.setActive(self._goChess, TianShiNaNaModel.instance.curSelectIndex == self._index)

	if unLock then
		local star = TianShiNaNaModel.instance:getEpisodeStar(self._index)

		ZProj.UGUIHelper.SetGrayFactor(self._goStar1Has1, star < 1 and 1 or 0)
		ZProj.UGUIHelper.SetGrayFactor(self._goStar1Has2, star < 1 and 1 or 0)
		ZProj.UGUIHelper.SetGrayFactor(self._goStar2Has1, star < 2 and 1 or 0)
		ZProj.UGUIHelper.SetGrayFactor(self._goStar2Has2, star < 2 and 1 or 0)
	end
end

function TianShiNaNaStageItem:_playChooseEpisode(nowIndex)
	if TianShiNaNaModel.instance.curSelectIndex == self._index then
		if nowIndex < self._index then
			self._chessAnimator:Play("close_left", 0, 0)
		else
			self._chessAnimator:Play("close_right", 0, 0)
		end

		AudioEffectMgr.instance:playAudio(AudioEnum.UI.play_ui_activity_hero37_checkpoint_unlock)
	end
end

function TianShiNaNaStageItem:_clickBtn()
	if TianShiNaNaModel.instance.curSelectIndex == self._index then
		self:_beginStory()
	else
		UIBlockMgr.instance:startBlock("TianShiNaNaStageItem")
		TianShiNaNaController.instance:dispatchEvent(TianShiNaNaEvent.EpisodeClick, self._index)
		TaskDispatcher.runDelay(self._delayPlayChessOpenAnim, self, 0.4)
	end
end

function TianShiNaNaStageItem:_delayPlayChessOpenAnim()
	gohelper.setActive(self._goChess, true)
	self._chessAnimator:Play("open_right", 0, 0)
	TaskDispatcher.runDelay(self._beginStory, self, 0.9)
end

function TianShiNaNaStageItem:_beginStory()
	UIBlockMgr.instance:endBlock("TianShiNaNaStageItem")

	TianShiNaNaModel.instance.curSelectIndex = self._index

	local actId = VersionActivity2_2Enum.ActivityId.TianShiNaNa

	GameUtil.playerPrefsSetStringByUserId(PlayerPrefsKey.Version2_2TianShiNaNaSelect .. actId, tostring(self._index))

	if self._episodeCo.mapId > 0 then
		local isSkipStory = self._episodeCo.storyBefore <= 0

		if isSkipStory then
			self:_storyEnd()
		else
			StoryController.instance:playStory(self._episodeCo.storyBefore, nil, self._storyEnd, self)
		end
	elseif self._episodeCo.storyBefore > 0 then
		StoryController.instance:playStory(self._episodeCo.storyBefore, nil, self._storyEnd, self)
	end
end

function TianShiNaNaStageItem:_onGetEpisodeInfo(cmd, resultCode, msg)
	if resultCode == 0 then
		TianShiNaNaModel.instance.currEpisodeId = msg.episodeId

		TianShiNaNaController.instance:dispatchEvent(TianShiNaNaEvent.EnterLevelScene)
	end
end

function TianShiNaNaStageItem:_storyEnd()
	if self._episodeCo.mapId > 0 then
		Activity167Rpc.instance:sendAct167StartEpisodeRequest(VersionActivity2_2Enum.ActivityId.TianShiNaNa, self._episodeCo.id, self._onGetEpisodeInfo, self)
	else
		TaskDispatcher.runDelay(self._delayMarkFinish, self, 0.2)
	end
end

function TianShiNaNaStageItem:_delayMarkFinish()
	if not self._index then
		return
	end

	TianShiNaNaModel.instance:markEpisodeFinish(self._index, 1)
end

function TianShiNaNaStageItem:onDestroy()
	UIBlockMgr.instance:endBlock("TianShiNaNaStageItem")
	TaskDispatcher.cancelTask(self._delayPlayChessOpenAnim, self)
	TaskDispatcher.cancelTask(self._beginStory, self)
	TaskDispatcher.cancelTask(self._delayMarkFinish, self)
end

return TianShiNaNaStageItem
