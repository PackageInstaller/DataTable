-- chunkname: @modules/logic/clickuiswitch/view/ClickUISwitchInfoView.lua

module("modules.logic.clickuiswitch.view.ClickUISwitchInfoView", package.seeall)

local ClickUISwitchInfoView = class("ClickUISwitchInfoView", BaseView)

function ClickUISwitchInfoView:onInitView()
	self._gomiddle = gohelper.findChild(self.viewGO, "middle")
	self._gorawImage = gohelper.findChild(self.viewGO, "RawImage")
	self._btnequip = gohelper.findChildButtonWithAudio(self.viewGO, "right/start/#btn_equip")
	self._goshowing = gohelper.findChild(self.viewGO, "right/start/#go_showing")
	self._goLocked = gohelper.findChild(self.viewGO, "right/start/#go_Locked")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "right/start/#btn_close")
	self._scrollcard = gohelper.findChildScrollRect(self.viewGO, "right/mask/#scroll_card")
	self._goSceneName = gohelper.findChild(self.viewGO, "left/LayoutGroup/layout/#go_SceneName")
	self._txtSceneName = gohelper.findChildText(self.viewGO, "left/LayoutGroup/layout/#go_SceneName/#txt_SceneName")
	self._txtTime = gohelper.findChildText(self.viewGO, "left/LayoutGroup/layout/#go_Time/#txt_Time")
	self._btnnamecheck = gohelper.findChildButtonWithAudio(self.viewGO, "left/LayoutGroup/#go_HideBtn/#btn_Hide")
	self._txtSceneDescr = gohelper.findChildText(self.viewGO, "left/#txt_SceneDescr")
	self._btnshow = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_show")
	self._goSceneLogo4 = gohelper.findChild(self.viewGO, "left/#go_SceneLogo4")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ClickUISwitchInfoView:addEvents()
	self._btnequip:AddClickListener(self._btnequipOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnnamecheck:AddClickListener(self._btnHideOnClick, self)
	self._btnshow:AddClickListener(self._btnshowOnClick, self)
	self.addEventCb(self, ClickUISwitchController.instance, ClickUISwitchEvent.LoadUIPrefabs, self._loadUIPrefabs, self)
end

function ClickUISwitchInfoView:removeEvents()
	self._btnequip:RemoveClickListener()
	self._btnclose:RemoveClickListener()
	self._btnnamecheck:RemoveClickListener()
	self._btnshow:RemoveClickListener()
	self.removeEventCb(self, ClickUISwitchController.instance, ClickUISwitchEvent.LoadUIPrefabs, self._loadUIPrefabs, self)
end

function ClickUISwitchInfoView:_btnHideOnClick()
	if self._hideTime and Time.time - self._hideTime < 0.2 then
		return
	end

	self._hideTime = Time.time
	self._showUI = not self._showUI

	gohelper.setActive(self._goleft, self._showUI and self._isCanShowLeft)
	gohelper.setActive(self._goright, self._showUI)
	gohelper.setActive(self._btnshow.gameObject, not self._showUI)

	local animName = self._showUI and "open" or "close"

	self._rootAnimator:Play(animName, 0, 0)
	ClickUISwitchController.instance:dispatchEvent(ClickUISwitchEvent.PreviewSwitchVisible, self._showUI)
end

function ClickUISwitchInfoView:_btnshowOnClick()
	self:_btnHideOnClick()
end

function ClickUISwitchInfoView:_btnequipOnClick()
	self._equipBtnAnimatorPlayer:Play("click", self._equipCb, self)
end

function ClickUISwitchInfoView:_equipCb()
	ClickUISwitchController.instance:setCurClickUIStyle(self._selectSkinId, self._showSceneStatus, self)

	local title = luaLang("main_switch_classify_title_3")

	ToastController.instance:showToast(ToastEnum.FightUISwitchSuccess, title)
end

function ClickUISwitchInfoView:_showSceneStatus()
	local sceneStatus = ClickUISwitchModel.getUIStatus(self._selectSkinId)
	local isShow = self.viewParam.isAmplify == nil
	local isUnlock = sceneStatus == MainSceneSwitchEnum.SceneStutas.Unlock
	local isEquip = self._selectSkinId == ClickUISwitchModel.instance:getCurUseUI()

	gohelper.setActive(self._btnequip, isShow and isUnlock and not isEquip)
	gohelper.setActive(self._goshowing, isShow and isUnlock and isEquip)
	gohelper.setActive(self._goLocked, isShow and not isUnlock)
	self:_updateSceneInfo()
end

function ClickUISwitchInfoView:_btncloseOnClick()
	if self._isClosing then
		return
	end

	self._rootAnimator:Play("close", 0, 0)
	TaskDispatcher.runDelay(self.closeThis, self, 0.334)

	self._isClosing = true
end

function ClickUISwitchInfoView:_editableInitView()
	self._rootAnimator = self.viewGO:GetComponent("Animator")
	self._equipBtnAnimatorPlayer = SLFramework.AnimatorPlayer.Get(self._btnequip.gameObject)
	self._goleft = gohelper.findChild(self.viewGO, "left")
	self._goright = gohelper.findChild(self.viewGO, "right")
	self._rawImage = gohelper.onceAddComponent(self._gorawImage, gohelper.Type_RawImage)
end

function ClickUISwitchInfoView:onOpen()
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

	if self.viewParam then
		if not self.viewParam.sceneId then
			local sceneId = MainSceneSwitchModel.instance:getCurSceneId()

			gohelper.setActive(self._gorawImage, false)
			self:_onShowSceneInfo(sceneId)
			gohelper.setActive(self._goleft, self._showUI and self._isCanShowLeft)
		end
	end
end

function ClickUISwitchInfoView:_updateSceneInfo()
	local config = lua_scene_click.configDict[self._selectSkinId]

	if not config then
		return
	end

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

	self:_showClickUI(config.effect)
end

function ClickUISwitchInfoView:_showClickUI(prefabName)
	self._clickUIItems = self._clickUIItems or {}

	if not self._clickUIItems[prefabName] then
		local prafab = ClickUISwitchController.instance:getClickUIPrefab(prefabName)

		if not prafab then
			return
		end

		local go = gohelper.clone(prafab, self._gomiddle)
		local ani = go:GetComponent(typeof(UnityEngine.Animation))
		local animTime = ani.clip.length

		self._clickUIItems[prefabName] = {
			go = go,
			ani = ani,
			animTime = animTime
		}
	end

	for name, item in pairs(self._clickUIItems) do
		gohelper.setActive(item.go, name == prefabName)
	end

	self._clickUIPrefabName = prefabName

	if self._clickUIItems[prefabName] then
		if not self._clickUIItems[prefabName].animTime then
			local animTime = 0.5

			TaskDispatcher.cancelTask(self._runRepeatClickUIAnim, self)
			TaskDispatcher.runRepeat(self._runRepeatClickUIAnim, self, animTime)
		end
	end
end

function ClickUISwitchInfoView:_runRepeatClickUIAnim()
	local item = self._clickUIItems[self._clickUIPrefabName]

	if not item then
		return
	end

	item.ani:Play()
end

function ClickUISwitchInfoView:_loadUIPrefabs()
	local config = lua_scene_click.configDict[self._selectSkinId]

	if config then
		self:_showClickUI(config.effect)
	end
end

function ClickUISwitchInfoView:_onShowSceneInfo(id)
	self._sceneId = id

	MainSceneSwitchCameraController.instance:showScene(id, self._showSceneFinished, self)
end

function ClickUISwitchInfoView:_showSceneFinished(rt)
	gohelper.setActive(self._gorawImage, true)
	ClickUISwitchInfoView.adjustRt(self._rawImage, rt)
end

function ClickUISwitchInfoView.adjustRt(rawImage, rt)
	rawImage.texture = rt

	rawImage:SetNativeSize()

	local width = rt.width
	local root = ViewMgr.instance:getUIRoot().transform
	local containerWidth = recthelper.getWidth(root)
	local scale = containerWidth / width

	transformhelper.setLocalScale(rawImage.transform, scale, scale, 1)
end

function ClickUISwitchInfoView:onClose()
	TaskDispatcher.cancelTask(self._runRepeatClickUIAnim, self)
end

return ClickUISwitchInfoView
