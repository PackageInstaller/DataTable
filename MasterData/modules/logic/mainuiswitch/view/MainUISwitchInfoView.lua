-- chunkname: @modules/logic/mainuiswitch/view/MainUISwitchInfoView.lua

module("modules.logic.mainuiswitch.view.MainUISwitchInfoView", package.seeall)

local MainUISwitchInfoView = class("MainUISwitchInfoView", BaseView)

function MainUISwitchInfoView:onInitView()
	self._gomiddle = gohelper.findChild(self.viewGO, "middle")
	self._gomainUI = gohelper.findChild(self.viewGO, "middle/#go_mainUI")
	self._btnequip = gohelper.findChildButtonWithAudio(self.viewGO, "right/start/#btn_equip")
	self._goshowing = gohelper.findChild(self.viewGO, "right/start/#go_showing")
	self._goLocked = gohelper.findChild(self.viewGO, "right/start/#go_Locked")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "right/start/#btn_close")
	self._scrollcard = gohelper.findChildScrollRect(self.viewGO, "right/mask/#scroll_card")
	self._goSceneName = gohelper.findChild(self.viewGO, "left/LayoutGroup/#go_SceneName")
	self._txtSceneName = gohelper.findChildText(self.viewGO, "left/LayoutGroup/#go_SceneName/#txt_SceneName")
	self._txtTime = gohelper.findChildText(self.viewGO, "left/LayoutGroup/#go_SceneName/#txt_SceneName/#txt_Time")
	self._btnnamecheck = gohelper.findChildButtonWithAudio(self.viewGO, "left/LayoutGroup/#go_SceneName/#btn_namecheck")
	self._txtSceneDescr = gohelper.findChildText(self.viewGO, "left/#txt_SceneDescr")
	self._btnshow = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_show")
	self._goSceneLogo4 = gohelper.findChild(self.viewGO, "left/#go_SceneLogo4")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MainUISwitchInfoView:addEvents()
	self._btnequip:AddClickListener(self._btnequipOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnnamecheck:AddClickListener(self._btnHideOnClick, self)
	self._btnshow:AddClickListener(self._btnshowOnClick, self)
end

function MainUISwitchInfoView:removeEvents()
	self._btnequip:RemoveClickListener()
	self._btnclose:RemoveClickListener()
	self._btnnamecheck:RemoveClickListener()
	self._btnshow:RemoveClickListener()
end

function MainUISwitchInfoView:_btnHideOnClick()
	if self._hideTime and Time.time - self._hideTime < 0.2 then
		return
	end

	self._hideTime = Time.time
	self._showUI = not self._showUI

	gohelper.setActive(self._goleft, self._showUI and self._isCanShowLeft)
	gohelper.setActive(self._goright, self._showUI)
	gohelper.setActive(self._btnshow.gameObject, not self._showUI)
	gohelper.setActive(self._goMask, self._showUI)
	MainUISwitchController.instance:dispatchEvent(MainUISwitchEvent.PreviewSwitchUIVisible, self._showUI)
end

function MainUISwitchInfoView:_btnshowOnClick()
	if not self._showUI then
		if MainUISwitchController.instance:isClickEagle() then
			MainUISwitchController.instance:dispatchEvent(MainUISwitchEvent.ClickEagle)

			return
		end

		if MainUISwitchController.instance:isClickObj("#btn_bird") then
			MainUISwitchController.instance:dispatchEvent(MainUISwitchEvent.ClickBird, self.viewName)

			return
		end
	end

	self:_btnHideOnClick()
end

function MainUISwitchInfoView:_btnequipOnClick()
	MainUISwitchController.instance:setCurMainUIStyle(self._selectSkinId, self._showSceneStatus, self)
end

function MainUISwitchInfoView:_showSceneStatus()
	local sceneStatus = MainUISwitchModel.getUIStatus(self._selectSkinId)
	local isUnlock = sceneStatus == MainSceneSwitchEnum.SceneStutas.Unlock
	local isEquip = self._selectSkinId == MainUISwitchModel.instance:getCurUseUI()

	gohelper.setActive(self._btnequip, isUnlock and not isEquip)
	gohelper.setActive(self._goshowing, isUnlock and isEquip)
	gohelper.setActive(self._goLocked, not isUnlock)
	self:_updateSceneInfo()
end

function MainUISwitchInfoView:_btncloseOnClick()
	self:closeThis()
end

function MainUISwitchInfoView:_editableInitView()
	self._rootAnimator = self.viewGO:GetComponent("Animator")
	self._goleft = gohelper.findChild(self.viewGO, "left")
	self._goright = gohelper.findChild(self.viewGO, "right")
	self._goMask = gohelper.findChild(self.viewGO, "MaskBG")
end

function MainUISwitchInfoView:onOpen()
	self._showUI = true
	self._selectSkinId = self.viewParam.SkinId
	self._isCanShowLeft = true

	if self.viewParam and self.viewParam.isNotShowLeft == true then
		self._isCanShowLeft = false
	end

	self:_showSceneStatus()

	if not self.viewParam.noInfoEffect then
		self._rootAnimator:Play("info", 0, 0)
		AudioMgr.instance:trigger(AudioEnum.MainSceneSkin.play_ui_main_get_scene)
	end

	self._goblurmask = self._goblurmask or self:getResInst(self.viewContainer:getSetting().otherRes[2], self._gomiddle)

	if self.viewParam then
		if not self.viewParam.sceneId then
			local sceneId = MainSceneSwitchModel.instance:getCurSceneId()

			gohelper.setActive(self._goleft, self._showUI and self._isCanShowLeft)
			gohelper.setActive(self._goMask, self._showUI)
		end
	end
end

function MainUISwitchInfoView:_updateSceneInfo()
	local config = lua_scene_ui.configDict[self._selectSkinId]

	if not config then
		return
	end

	MainSceneSwitchController.instance:dispatchEvent(MainSceneSwitchEvent.ShowPreviewSceneInfo, MainSceneSwitchModel.instance:getCurSceneId())

	local itemId = config.itemId
	local itemConfig = lua_item.configDict[itemId]

	if not itemConfig then
		return
	end

	self._txtSceneName.text = itemConfig.name
	self._txtSceneDescr.text = itemConfig.desc

	if config.defaultUnlock == 1 then
		local info = PlayerModel.instance:getPlayinfo()
		local time = TimeUtil.timestampToString5(ServerTime.timeInLocal(info.registerTime / 1000))

		self._txtTime.text = string.format(luaLang("receive_time"), time)
	else
		local itemMo = ItemModel.instance:getById(itemId)

		if itemMo and itemMo.quantity > 0 and itemMo.lastUpdateTime then
			local time = TimeUtil.timestampToString5(ServerTime.timeInLocal(itemMo.lastUpdateTime / 1000))

			self._txtTime.text = string.format(luaLang("receive_time"), time)
		else
			self._txtTime.text = ""
		end
	end
end

function MainUISwitchInfoView:onClose()
	return
end

return MainUISwitchInfoView
