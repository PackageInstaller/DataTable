-- chunkname: @modules/logic/versionactivity1_5/aizila/view/AiZiLaStageItem.lua

module("modules.logic.versionactivity1_5.aizila.view.AiZiLaStageItem", package.seeall)

local AiZiLaStageItem = class("AiZiLaStageItem", ListScrollCellExtend)

function AiZiLaStageItem:onInitView()
	self._goUnLocked = gohelper.findChild(self.viewGO, "Root/#go_UnLocked")
	self._txtStageName = gohelper.findChildText(self.viewGO, "Root/#go_UnLocked/Info/#txt_StageName")
	self._btnPlay = gohelper.findChildButtonWithAudio(self.viewGO, "Root/#go_UnLocked/Info/#txt_StageName/#btn_Play")
	self._txtStageNum = gohelper.findChildText(self.viewGO, "Root/#go_UnLocked/Info/#txt_StageNum")
	self._goLocked = gohelper.findChild(self.viewGO, "Root/#go_Locked")
	self._btnClick = gohelper.findChildButtonWithAudio(self.viewGO, "Root/#btn_Click")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AiZiLaStageItem:addEvents()
	self._btnPlay:AddClickListener(self._btnPlayOnClick, self)
	self._btnClick:AddClickListener(self._btnClickOnClick, self)
end

function AiZiLaStageItem:removeEvents()
	self._btnPlay:RemoveClickListener()
	self._btnClick:RemoveClickListener()
end

function AiZiLaStageItem:_btnPlayOnClick()
	if self._stroyIds and #self._stroyIds > 0 then
		if #self._stroyIds == 1 then
			AiZiLaGameController.instance:playStory(self._stroyIds[1])
		else
			AiZiLaController.instance:openStoryView(self._config.episodeId)
		end
	end
end

function AiZiLaStageItem:addEventListeners()
	self:addEvents()
end

function AiZiLaStageItem:removeEventListeners()
	self:removeEvents()
end

function AiZiLaStageItem:_btnClickOnClick()
	if AiZiLaModel.instance:getEpisodeMO(self._config.episodeId) then
		AiZiLaController.instance:openEpsiodeDetailView(self._config.episodeId)
	else
		GameFacade.showToast(ToastEnum.V1a5AiZiLaEpisodeNotOpen, self._config.unlockDesc)
	end
end

function AiZiLaStageItem:_editableInitView()
	self._txtLockStageNum = gohelper.findChildText(self.viewGO, "Root/#go_Locked/Info/#txt_StageNum")
	self._goRoot = gohelper.findChild(self.viewGO, "Root")
	self._animator = self.viewGO:GetComponent(AiZiLaEnum.ComponentType.Animator)
end

function AiZiLaStageItem:onDestroy()
	return
end

function AiZiLaStageItem:setCfg(cfg)
	self._config = cfg
	self._stroyIds = {}

	if cfg then
		if cfg.storyBefore and cfg.storyBefore ~= 0 then
			table.insert(self._stroyIds, cfg.storyBefore)
		end

		if cfg.storyClear and cfg.storyClear ~= 0 then
			table.insert(self._stroyIds, cfg.storyClear)
		end
	end

	self._isPlayUnLockAnim = nil
end

function AiZiLaStageItem:getEpisodeId()
	return self._config and self._config.episodeId
end

function AiZiLaStageItem:refreshUI()
	gohelper.setActive(self._goRoot, self._config ~= nil)

	if self._config then
		self._txtStageName.text = self._config.name
		self._txtStageNum.text = self._config.nameen
		self._txtLockStageNum.text = self._config.nameen

		local episodeMO = AiZiLaModel.instance:getEpisodeMO(self._config.episodeId)

		self._isLock = episodeMO == nil

		if self._isPlayUnLockAnim == nil then
			self._isPlayUnLockAnim = self:_isPlayedUnLock(self._config.episodeId)
		end

		if self._isLock then
			self._isPlayUnLockAnim = false
		end

		self._isShowStoryPlay = self:_checkShowStory()

		self:_refreshStateUI()
	end
end

function AiZiLaStageItem:_refreshStateUI()
	if not self._isLock then
		local isLock = self._isPlayUnLockAnim == false

		gohelper.setActive(self._goUnLocked, not isLock)
		gohelper.setActive(self._goLocked, isLock)
		gohelper.setActive(self._btnPlay, self._isShowStoryPlay)
	end
end

function AiZiLaStageItem:_playAnim(animName)
	if self._animator then
		self._animator:Play(animName, 0, 0)
	end
end

function AiZiLaStageItem:playUnlockAnim()
	if self._isLock == false and self._isPlayUnLockAnim == false then
		self._isPlayUnLockAnim = true

		self:_playAnim("unlock")
		gohelper.setActive(self._goUnLocked, true)
		gohelper.setActive(self._goLocked, true)
		TaskDispatcher.runDelay(self._refreshStateUI, self, 0.8)
		self:_setUnLockAnim(self:getEpisodeId(), true)
		AudioMgr.instance:trigger(AudioEnum.V1a5AiZiLa.play_ui_wulu_aizila_level_unlock)
	end
end

function AiZiLaStageItem:playFinish()
	self:_playAnim("finish")
end

function AiZiLaStageItem:_checkShowStory()
	if self._stroyIds and #self._stroyIds > 0 then
		for i, storyId in ipairs(self._stroyIds) do
			if StoryModel.instance:isStoryHasPlayed(storyId) then
				return true
			end
		end
	end

	return false
end

function AiZiLaStageItem:_isPlayedUnLock(episodeId)
	local key = self:_getLockAnimKey(episodeId)

	return PlayerPrefsHelper.getNumber(key, 0) == 1
end

function AiZiLaStageItem:_getLockAnimKey(episodeId)
	local userId = PlayerModel.instance:getPlayinfo().userId
	local actId = VersionActivity1_5Enum.ActivityId.AiZiLa

	return string.format("AiZiLaStageItem_PLAY_UNLOCK_ANIM_KEY_%s_%s_%s", userId, actId, episodeId)
end

function AiZiLaStageItem:_setUnLockAnim(episodeId)
	local key = self:_getLockAnimKey(episodeId)

	return PlayerPrefsHelper.setNumber(key, 1)
end

AiZiLaStageItem.prefabPath = "ui/viewres/versionactivity_1_5/v1a5_aizila/v1a5_aizila_stageitem.prefab"

return AiZiLaStageItem
