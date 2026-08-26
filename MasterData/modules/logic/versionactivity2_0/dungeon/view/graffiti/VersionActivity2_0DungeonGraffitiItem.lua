-- chunkname: @modules/logic/versionactivity2_0/dungeon/view/graffiti/VersionActivity2_0DungeonGraffitiItem.lua

module("modules.logic.versionactivity2_0.dungeon.view.graffiti.VersionActivity2_0DungeonGraffitiItem", package.seeall)

local VersionActivity2_0DungeonGraffitiItem = class("VersionActivity2_0DungeonGraffitiItem", LuaCompBase)

function VersionActivity2_0DungeonGraffitiItem:init(go)
	self:__onInit()

	self.go = go
	self.canvasGroup = gohelper.findChild(self.go, "icon"):GetComponent(typeof(UnityEngine.CanvasGroup))
	self.picture = gohelper.findChildSingleImage(self.go, "icon/simage_picture")
	self.imagePicture = gohelper.findChildImage(self.go, "icon/simage_picture")
	self.lock = gohelper.findChild(self.go, "icon/simage_picture/go_lock")
	self.goLockTime = gohelper.findChild(self.go, "icon/simage_picture/go_lockTime")
	self.txtUnlockTime = gohelper.findChildText(self.go, "icon/simage_picture/go_lockTime/txt_unlockTime")
	self.toUnlock = gohelper.findChild(self.go, "go_toUnlock")
	self.goUnlockEffect = gohelper.findChild(self.go, "go_unlockEffect")
	self.goUnlockEffect1 = gohelper.findChild(self.go, "unlock")
	self.goFinishEffect = gohelper.findChild(self.go, "finish")
	self.simageEffect = gohelper.findChildSingleImage(self.go, "go_unlockEffect/simage_effect")
	self.gocompleted = gohelper.findChild(self.go, "icon/simage_picture/go_completed")
	self.btnClick = gohelper.findChildButtonWithAudio(self.go, "btn_click")
	self.isRunTime = false
	self.isNewUnlock = false
end

function VersionActivity2_0DungeonGraffitiItem:addEventListeners()
	self.btnClick:AddClickListener(self.onPictureClick, self)
	self.addEventCb(self, Activity161Controller.instance, Activity161Event.GraffitiCdRefresh, self.refreshUnlockTime, self)
	self.addEventCb(self, Activity161Controller.instance, Activity161Event.ToUnlockGraffiti, self.toUnlockGraffiti, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self, LuaEventSystem.Low)
end

function VersionActivity2_0DungeonGraffitiItem:removeEventListeners()
	self.btnClick:RemoveClickListener()
	self.removeEventCb(self, Activity161Controller.instance, Activity161Event.GraffitiCdRefresh, self.refreshUnlockTime, self)
	self.removeEventCb(self, Activity161Controller.instance, Activity161Event.ToUnlockGraffiti, self.toUnlockGraffiti, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self, LuaEventSystem.Low)
end

function VersionActivity2_0DungeonGraffitiItem:onPictureClick()
	local graffitiMO = Activity161Model.instance.graffitiInfoMap[self.elementId]

	if graffitiMO.state == Activity161Enum.graffitiState.Normal or graffitiMO.state == Activity161Enum.graffitiState.IsFinished then
		Activity161Controller.instance:openGraffitiDrawView({
			graffitiMO = graffitiMO,
			normalMaterial = self.normalMaterial
		})
		self:resetPicture()
	elseif graffitiMO.state == Activity161Enum.graffitiState.ToUnlock then
		Activity161Controller.instance:jumpToElement(graffitiMO)
	elseif self.showLockTime then
		GameFacade.showToast(ToastEnum.GraffitiLockWidthTime)
	else
		GameFacade.showToast(ToastEnum.GraffitiLock)
	end
end

function VersionActivity2_0DungeonGraffitiItem:initData(actId, elementId, materialTab)
	self.elementId = elementId
	self.actId = actId
	self.config = Activity161Config.instance:getGraffitiCo(self.actId, self.elementId)

	local effectRes = string.format("%s_effect", self.config.picture)

	self.simageEffect:LoadImage(ResUrl.getGraffitiIcon(effectRes), self.setNativeSize, self)

	self.oldState = Activity161Model.instance.graffitiInfoMap[self.elementId].state
	self.lockMaterial = materialTab[1]
	self.normalMaterial = materialTab[2]
end

function VersionActivity2_0DungeonGraffitiItem:refreshItem()
	self.graffitiMO = Activity161Model.instance.graffitiInfoMap[self.elementId]
	self.isUnlock = Activity161Model.instance:isUnlockState(self.graffitiMO) == Activity161Enum.unlockState

	local curInCdMoList = Activity161Model.instance:getInCdGraffiti()

	self:refreshUnlockTime(curInCdMoList)
	gohelper.setActive(self.lock, self.graffitiMO.state == Activity161Enum.graffitiState.Lock and not self.showLockTime)
	gohelper.setActive(self.toUnlock, self.graffitiMO.state == Activity161Enum.graffitiState.ToUnlock)
	gohelper.setActive(self.gocompleted, self.graffitiMO.state == Activity161Enum.graffitiState.IsFinished)
end

function VersionActivity2_0DungeonGraffitiItem:refreshUnlockTime(curInCdMoList)
	local curInCdMo

	for _, mo in pairs(curInCdMoList) do
		if mo.id == self.graffitiMO.id then
			curInCdMo = mo

			break
		end
	end

	self.showLockTime = curInCdMo ~= nil

	gohelper.setActive(self.goLockTime, self.graffitiMO.state == Activity161Enum.graffitiState.Lock and self.showLockTime)

	local unlockTime = Mathf.Floor(self.graffitiMO:getRemainUnlockTime())

	self.txtUnlockTime.text = TimeUtil.getFormatTime1(unlockTime, true)

	self:refreshPicture()
end

function VersionActivity2_0DungeonGraffitiItem:refreshPicture()
	local pictureMaterial
	local pictureAlpha = 1

	if not self.isNewUnlock then
		if self.graffitiMO.state == Activity161Enum.graffitiState.Lock then
			pictureMaterial = self.lockMaterial
			pictureAlpha = self.showLockTime and 1 or 0.5
		elseif self.graffitiMO.state == Activity161Enum.graffitiState.ToUnlock then
			pictureMaterial = self.lockMaterial
			pictureAlpha = 1
		elseif self.graffitiMO.state == Activity161Enum.graffitiState.Normal then
			pictureMaterial = self.normalMaterial
			pictureAlpha = 1
		end
	else
		pictureMaterial = (self.graffitiMO.state ~= Activity161Enum.graffitiState.IsFinished or nil) and self.normalMaterial
	end

	local pictureRes = string.format("%s_manual", self.config.picture)

	self.picture:LoadImage(ResUrl.getGraffitiIcon(pictureRes), self.setNativeSize, self)

	self.imagePicture.material = pictureMaterial

	ZProj.UGUIHelper.SetColorAlpha(self.imagePicture, pictureAlpha)
end

function VersionActivity2_0DungeonGraffitiItem:setNativeSize()
	ZProj.UGUIHelper.SetImageSize(self.picture.gameObject)
	ZProj.UGUIHelper.SetImageSize(self.simageEffect.gameObject)
end

function VersionActivity2_0DungeonGraffitiItem:refreshUnlockState(saveUnlockState)
	local unlockState = saveUnlockState == Activity161Enum.unlockState

	if self.isUnlock and self.isUnlock ~= unlockState then
		gohelper.setActive(self.goUnlockEffect, true)
		self:playUnlockEffect()
	else
		gohelper.setActive(self.goUnlockEffect, false)
		gohelper.setActive(self.goUnlockEffect1, false)
	end
end

function VersionActivity2_0DungeonGraffitiItem:toUnlockGraffiti(mo)
	if mo.id == self.elementId then
		gohelper.setActive(self.goLockTime, false)
		self:refreshItem()
	end
end

function VersionActivity2_0DungeonGraffitiItem:playUnlockEffect()
	self.isNewUnlock = true

	AudioMgr.instance:trigger(AudioEnum.UI.OpenRewardView)
	self:refreshPicture()
	gohelper.setActive(self.goUnlockEffect1, true)
end

function VersionActivity2_0DungeonGraffitiItem:resetPicture()
	self.isNewUnlock = false

	gohelper.setActive(self.goUnlockEffect, false)
	gohelper.setActive(self.goUnlockEffect1, false)
	self:refreshPicture()
end

function VersionActivity2_0DungeonGraffitiItem:_onCloseViewFinish(viewName)
	if viewName == ViewName.VersionActivity2_0DungeonGraffitiDrawView then
		if self.graffitiMO.state == Activity161Enum.graffitiState.IsFinished and self.oldState ~= self.graffitiMO.state then
			gohelper.setActive(self.goFinishEffect, true)
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_unlock)

			self.oldState = self.graffitiMO.state
		end
	else
		gohelper.setActive(self.goFinishEffect, false)
	end
end

function VersionActivity2_0DungeonGraffitiItem:destroy()
	self.picture:UnLoadImage()
	self.simageEffect:UnLoadImage()
	TaskDispatcher.cancelTask(self.freshUnlockTime, self)
	self:__onDispose()
end

return VersionActivity2_0DungeonGraffitiItem
