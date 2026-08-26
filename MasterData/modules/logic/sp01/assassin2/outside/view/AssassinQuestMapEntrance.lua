-- chunkname: @modules/logic/sp01/assassin2/outside/view/AssassinQuestMapEntrance.lua

module("modules.logic.sp01.assassin2.outside.view.AssassinQuestMapEntrance", package.seeall)

local AssassinQuestMapEntrance = class("AssassinQuestMapEntrance", BaseViewExtended)

function AssassinQuestMapEntrance:ctor(mapId)
	AssassinQuestMapEntrance.super.ctor(self)

	self._mapId = mapId
end

function AssassinQuestMapEntrance:onInitView()
	self._golock = gohelper.findChild(self.viewGO, "go_lock")
	self._txtname1 = gohelper.findChildText(self.viewGO, "go_lock/txt_name")
	self._txtprogress1 = gohelper.findChildText(self.viewGO, "go_lock/txt_progress1")
	self._gounlock = gohelper.findChild(self.viewGO, "go_unlock")
	self._txtname2 = gohelper.findChildText(self.viewGO, "go_unlock/txt_name")
	self._txtprogress2 = gohelper.findChildText(self.viewGO, "go_unlock/txt_progress2")
	self._gofinish = gohelper.findChild(self.viewGO, "go_finish")
	self._txtname3 = gohelper.findChildText(self.viewGO, "go_finish/txt_name")
	self._txtprogress3 = gohelper.findChildText(self.viewGO, "go_finish/txt_progress3")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "btn_click", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AssassinQuestMapEntrance:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
	self.addEventCb(self, AssassinController.instance, AssassinEvent.OnFinishQuest, self._onFinishQuest, self)
	self.addEventCb(self, AssassinController.instance, AssassinEvent.OnUnlockQuestContent, self._onUnlockQuestContent, self)
	self.addEventCb(self, AssassinController.instance, AssassinEvent.OnAllAssassinOutSideInfoUpdate, self.refresh, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
end

function AssassinQuestMapEntrance:removeEvents()
	self._btnclick:RemoveClickListener()
	self.removeEventCb(self, AssassinController.instance, AssassinEvent.OnFinishQuest, self._onFinishQuest, self)
	self.removeEventCb(self, AssassinController.instance, AssassinEvent.OnUnlockQuestContent, self._onUnlockQuestContent, self)
	self.removeEventCb(self, AssassinController.instance, AssassinEvent.OnAllAssassinOutSideInfoUpdate, self.refresh, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
end

function AssassinQuestMapEntrance:_btnclickOnClick(questId, fightReturn)
	local status = AssassinOutsideModel.instance:getQuestMapStatus(self._mapId)

	if status == AssassinEnum.MapStatus.Locked then
		return
	end

	AssassinController.instance:openAssassinQuestMapView({
		mapId = self._mapId,
		questId = questId,
		fightReturnStealthGame = fightReturn
	})
end

function AssassinQuestMapEntrance:_onFinishQuest()
	self:refreshStatus()
	self:refreshProgress()
end

function AssassinQuestMapEntrance:_onUnlockQuestContent()
	self:refresh()
end

function AssassinQuestMapEntrance:_onCloseView(viewName)
	self:checkUnlockAnim()
end

function AssassinQuestMapEntrance:_editableInitView()
	local name = AssassinConfig.instance:getMapTitle(self._mapId)

	self._txtname1.text = name
	self._txtname2.text = name
	self._txtname3.text = name
	self._unlockanimator = self._gounlock:GetComponent(typeof(UnityEngine.Animator))
end

function AssassinQuestMapEntrance:onOpen()
	self:refresh()

	local viewParam = self.viewContainer.viewParam

	if not viewParam then
		return
	end

	local questMapId = viewParam.questMapId

	if questMapId and self._mapId == questMapId then
		self:_btnclickOnClick()

		return
	end

	local questId
	local fightReturn = viewParam.fightReturnStealthGame

	questId = fightReturn and AssassinOutsideModel.instance:getProcessingQuest() or viewParam.questId

	if questId and questId ~= 0 then
		local mapId = AssassinConfig.instance:getQuestMapId(questId)

		if mapId and self._mapId == mapId then
			self:_btnclickOnClick(questId, fightReturn)
		end
	end
end

function AssassinQuestMapEntrance:refresh()
	self:refreshStatus()
	self:refreshProgress()
end

function AssassinQuestMapEntrance:refreshStatus()
	local status = AssassinOutsideModel.instance:getQuestMapStatus(self._mapId)

	gohelper.setActive(self._golock, status == AssassinEnum.MapStatus.Locked)
	gohelper.setActive(self._gounlock, status == AssassinEnum.MapStatus.Unlocked)
	gohelper.setActive(self._gofinish, status == AssassinEnum.MapStatus.Finished)
	self:checkUnlockAnim()
end

function AssassinQuestMapEntrance:checkUnlockAnim()
	local viewNameList = ViewMgr.instance:getOpenViewNameList()
	local topView = viewNameList[#viewNameList]

	if topView ~= ViewName.AssassinMapView then
		return
	end

	local status = AssassinOutsideModel.instance:getQuestMapStatus(self._mapId)
	local cacheKey = AssassinHelper.getPlayerCacheDataKey(AssassinEnum.PlayerCacheDataKey.MapPlayUnlockAnim, self._mapId)
	local needPlayUnlockAnim = not AssassinOutsideModel.instance:getCacheKeyData(cacheKey)

	if status == AssassinEnum.MapStatus.Unlocked then
		if needPlayUnlockAnim then
			self._unlockanimator:Play("unlock", 0, 0)
			AudioMgr.instance:trigger(AudioEnum2_9.StealthGame.play_ui_cikeshang_unlockmap)
			AssassinController.instance:setHasPlayedAnimation(cacheKey)
		else
			self._unlockanimator:Play("idle", 0, 0)
		end
	end
end

function AssassinQuestMapEntrance:refreshProgress()
	local _, strProgress = AssassinOutsideModel.instance:getQuestMapProgress(self._mapId)

	self._txtprogress1.text = strProgress
	self._txtprogress2.text = strProgress
	self._txtprogress3.text = strProgress
end

function AssassinQuestMapEntrance:onClose()
	return
end

function AssassinQuestMapEntrance:onDestroyView()
	return
end

return AssassinQuestMapEntrance
