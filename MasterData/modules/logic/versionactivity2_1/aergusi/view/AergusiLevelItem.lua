-- chunkname: @modules/logic/versionactivity2_1/aergusi/view/AergusiLevelItem.lua

module("modules.logic.versionactivity2_1.aergusi.view.AergusiLevelItem", package.seeall)

local AergusiLevelItem = class("AergusiLevelItem", LuaCompBase)

function AergusiLevelItem:init(go)
	self.go = go
	self._animator = go:GetComponent(typeof(UnityEngine.Animator))
	self._gounlock = gohelper.findChild(self.go, "Root/unlock")
	self._imagehasstar = gohelper.findChildImage(self.go, "Root/unlock/Info/#image_HasStar")
	self._imagenostar = gohelper.findChildImage(self.go, "Root/unlock/Info/#image_NoStar")
	self._txtstagename = gohelper.findChildText(self.go, "Root/unlock/Info/#txt_StageName")
	self._txtstagenum = gohelper.findChildText(self.go, "Root/unlock/Info/#txt_StageNum")
	self._imageinfo = gohelper.findChildImage(self.go, "Root/#image_Info")
	self._btnclick = gohelper.findChildButtonWithAudio(self.go, "Root/unlock/#btn_Click")
	self._golocked = gohelper.findChild(self.go, "Root/#go_Locked")
	self._imageItemMask = gohelper.findChildImage(self.go, "Root/#go_Locked/image_ItemMask")

	gohelper.setActive(self._gounlock, true)
	gohelper.setActive(self._golocked, true)

	self._itemAni = self.go:GetComponent(typeof(UnityEngine.Animator))

	self:addEventListeners()
end

function AergusiLevelItem:refreshItem(co, index)
	self._index = index
	self._episodeMo = co
	self._config = AergusiConfig.instance:getEpisodeConfig(nil, co.episodeId)
	self._episodeId = self._config.episodeId

	local unlock = AergusiModel.instance:isEpisodeUnlock(self._episodeId)

	if unlock then
		self._imageItemMask.raycastTarget = false

		local newUnlockEpisode = AergusiModel.instance:getNewUnlockEpisode()

		if newUnlockEpisode == self._episodeId then
			self._itemAni:Play("idlegray", 0, 0)
		else
			self._itemAni:Play("idle", 0, 0)
		end
	else
		self._itemAni:Play("idlegray", 0, 0)
	end

	local hasPass = AergusiModel.instance:isEpisodePassed(self._episodeId)

	gohelper.setActive(self._imagenostar.gameObject, not hasPass)
	gohelper.setActive(self._imagehasstar.gameObject, hasPass)

	local isStoryEpisode = AergusiModel.instance:isStoryEpisode(self._episodeId)

	gohelper.setActive(self._imageinfo.gameObject, not isStoryEpisode)

	self._txtstagenum.text = self._index
	self._txtstagename.text = self._config.name

	self:_checkFirstTimeEnter()
end

function AergusiLevelItem:_checkFirstTimeEnter()
	local newFinishEpisode = AergusiModel.instance:getNewFinishEpisode()
	local isStoryEpisode = AergusiModel.instance:isStoryEpisode(self._episodeId)

	if newFinishEpisode == self._episodeId then
		AudioMgr.instance:trigger(AudioEnum.Activity163.play_ui_wangshi_argus_level_over)
		self._itemAni:Play("finish", 0, 0)

		local episodeClues = AergusiModel.instance:getEpisodeClueConfigs(self._episodeId, false)

		if isStoryEpisode and #episodeClues > 0 then
			GameFacade.showToast(ToastEnum.Act163GetClueTip)
		end

		AergusiModel.instance:setNewFinishEpisode(0)
	end

	local newUnlockEpisode = AergusiModel.instance:getNewUnlockEpisode()

	if newUnlockEpisode == self._episodeId then
		local delayTime = self._index == 1 and 0.68 or 1.34

		UIBlockMgrExtend.setNeedCircleMv(false)
		UIBlockMgr.instance:startBlock("waitUnlock")
		AergusiModel.instance:setNewUnlockEpisode(0)
		TaskDispatcher.runDelay(self._playUnlock, self, delayTime)
	end
end

function AergusiLevelItem:_playUnlock()
	UIBlockMgr.instance:endBlock("waitUnlock")
	AudioMgr.instance:trigger(AudioEnum.Activity163.play_ui_wangshi_argus_level_open)
	self._itemAni:Play("unlock")
end

function AergusiLevelItem:addEventListeners()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function AergusiLevelItem:removeEventListeners()
	self._btnclick:RemoveClickListener()
end

function AergusiLevelItem:_btnclickOnClick()
	local unlock = AergusiModel.instance:isEpisodeUnlock(self._episodeId)

	if not unlock then
		GameFacade.showToast(ToastEnum.Act163LevelLocked)

		return
	end

	AergusiController.instance:dispatchEvent(AergusiEvent.EnterEpisode, self._episodeId)
end

function AergusiLevelItem:destroy()
	TaskDispatcher.cancelTask(self._playUnlock, self)
	self:removeEventListeners()
end

return AergusiLevelItem
