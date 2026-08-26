-- chunkname: @modules/logic/clickuiswitch/view/ClickUISwitchView.lua

module("modules.logic.clickuiswitch.view.ClickUISwitchView", package.seeall)

local ClickUISwitchView = class("ClickUISwitchView", BaseView)

function ClickUISwitchView:onInitView()
	self._gomiddle = gohelper.findChild(self.viewGO, "middle")
	self._btnchange = gohelper.findChildButtonWithAudio(self.viewGO, "right/start/#btn_change")
	self._btnget = gohelper.findChildButtonWithAudio(self.viewGO, "right/start/#btn_get")
	self._goshowing = gohelper.findChild(self.viewGO, "right/start/#go_showing")
	self._goLocked = gohelper.findChild(self.viewGO, "right/start/#go_Locked")
	self._scrollcard = gohelper.findChildScrollRect(self.viewGO, "right/mask/#scroll_card")
	self._goname = gohelper.findChild(self.viewGO, "left/LayoutGroup/#go_name")
	self._txtname = gohelper.findChildText(self.viewGO, "left/LayoutGroup/#go_name/#txt_name")
	self._txtTime = gohelper.findChildText(self.viewGO, "left/LayoutGroup/#go_name/#txt_name/#txt_Time")
	self._txtdescr = gohelper.findChildText(self.viewGO, "left/#txt_descr")
	self._goright = gohelper.findChild(self.viewGO, "right")
	self._goleft = gohelper.findChild(self.viewGO, "left")
	self._btnHide = gohelper.findChildButtonWithAudio(self.viewGO, "left/LayoutGroup/#go_name/#btn_namecheck")
	self._btnShow = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_show")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ClickUISwitchView:addEvents()
	self._btnchange:AddClickListener(self._btnchangeOnClick, self)
	self._btnget:AddClickListener(self._btngetOnClick, self)
	self._btnHide:AddClickListener(self._btnHideOnClick, self)
	self._btnShow:AddClickListener(self._btnshowOnClick, self)
	self.addEventCb(self, ClickUISwitchController.instance, ClickUISwitchEvent.SwitchVisible, self._onSwitchUIVisible, self)
	self.addEventCb(self, ClickUISwitchController.instance, ClickUISwitchEvent.SwitchClickUI, self._onSwitchClickUI, self)
	self.addEventCb(self, ClickUISwitchController.instance, ClickUISwitchEvent.UseClickUI, self._onUseClickUI, self)
	self.addEventCb(self, ClickUISwitchController.instance, ClickUISwitchEvent.LoadUIPrefabs, self._loadUIPrefabs, self)
	self.addEventCb(self, ClickUISwitchController.instance, ClickUISwitchEvent.LoadUIPrefabs, self._loadUIPrefabs, self)
	self.addEventCb(self, ClickUISwitchController.instance, ClickUISwitchEvent.UseClickUI, self._showBtnStatus, self)
	self.viewContainer:registerCallback(ViewEvent.ToSwitchTab, self._toSwitchTab, self)
end

function ClickUISwitchView:removeEvents()
	self._btnchange:RemoveClickListener()
	self._btnget:RemoveClickListener()
	self._btnHide:RemoveClickListener()
	self._btnShow:RemoveClickListener()
	self.removeEventCb(self, ClickUISwitchController.instance, ClickUISwitchEvent.SwitchVisible, self._onSwitchUIVisible, self)
	self.removeEventCb(self, ClickUISwitchController.instance, ClickUISwitchEvent.SwitchClickUI, self._onSwitchClickUI, self)
	self.removeEventCb(self, ClickUISwitchController.instance, ClickUISwitchEvent.LoadUIPrefabs, self._loadUIPrefabs, self)
	self.removeEventCb(self, ClickUISwitchController.instance, ClickUISwitchEvent.LoadUIPrefabs, self._loadUIPrefabs, self)
	self.removeEventCb(self, ClickUISwitchController.instance, ClickUISwitchEvent.UseClickUI, self._showBtnStatus, self)
	self.viewContainer:unregisterCallback(ViewEvent.ToSwitchTab, self._toSwitchTab, self)
end

function ClickUISwitchView:_toSwitchTab(tabContainerId, tabId)
	if tabContainerId == 1 then
		if self.viewContainer:getClassify() == MainSwitchClassifyEnum.Classify.Click then
			if tabId == MainEnum.SwitchType.Scene then
				self:onTabSwitchOpen()
			else
				self:onTabSwitchClose()
			end
		else
			self:onTabSwitchClose()
		end
	end
end

function ClickUISwitchView:_btnchangeOnClick()
	ClickUISwitchController.instance:setCurClickUIStyle(self._selectSkinId)
	ClickUISwitchListModel.instance:refreshScroll()
end

function ClickUISwitchView:_btngetOnClick()
	local config = lua_scene_click.configDict[self._selectSkinId]

	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.Item, config.itemId)
end

function ClickUISwitchView:_onSwitchClickUI(skinId)
	self:_showUIInfo(skinId)
end

function ClickUISwitchView:_onUseClickUI(skinId)
	self:_showUIInfo(self._selectSkinId)
	ClickUISwitchListModel.instance:refreshScroll()
end

function ClickUISwitchView:_btnHideOnClick()
	if self._hideTime and Time.time - self._hideTime < 0.2 then
		return
	end

	self._hideTime = Time.time
	self._showUI = not self._showUI

	gohelper.setActive(self._btnShow, not self._showUI)
	ClickUISwitchController.instance:dispatchEvent(ClickUISwitchEvent.SwitchVisible, self._showUI)
end

function ClickUISwitchView:_btnshowOnClick()
	self:_btnHideOnClick()
end

function ClickUISwitchView:_onSwitchUIVisible(showUi)
	gohelper.setActive(self._goright, showUi)
	gohelper.setActive(self._goleft, showUi)
end

function ClickUISwitchView:_editableInitView()
	self._goshow = gohelper.findChild(self.rootGO, "#btn_show")
	self._rootAnimator = self.viewGO:GetComponent("Animator")
end

function ClickUISwitchView:onUpdateParam()
	return
end

function ClickUISwitchView:onTabSwitchOpen()
	if self._rootAnimator then
		self._rootAnimator:Play("open", 0, 0)
	end
end

function ClickUISwitchView:onTabSwitchClose(isClosing)
	return
end

function ClickUISwitchView:onOpen()
	ClickUISwitchListModel.instance:initList()
	self:_onSwitchUIVisible(true)
	self:_showUIInfo(ClickUISwitchModel.instance:getCurUseUI())

	self._showUI = true

	gohelper.setActive(self._btnShow, false)
	MainSceneSwitchDisplayController.instance:hideScene()
	WeatherController.instance:onSceneShow()
	self._rootAnimator:Play("open", 0, 0)
end

function ClickUISwitchView:_showUIInfo(skinId)
	self._selectSkinId = skinId

	self:_showBtnStatus(skinId)

	local config = lua_scene_click.configDict[skinId]

	if config then
		self:_updateInfo(config.itemId, config.defaultUnlock)
		self:_showClickUI(config.effect)
	end
end

function ClickUISwitchView:_showClickUI(prefabName)
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

function ClickUISwitchView:_runRepeatClickUIAnim()
	local item = self._clickUIItems[self._clickUIPrefabName]

	if not item then
		return
	end

	item.ani:Play()
end

function ClickUISwitchView:_loadUIPrefabs()
	local config = lua_scene_click.configDict[self._selectSkinId]

	if config then
		self:_showClickUI(config.effect)
	end
end

function ClickUISwitchView:_showBtnStatus(skinId)
	local status = ClickUISwitchModel.getUIStatus(skinId)
	local curSkinId = ClickUISwitchModel.instance:getCurUseUI()
	local showCurScene = skinId == curSkinId
	local isUnlock = status == MainSceneSwitchEnum.SceneStutas.Unlock

	gohelper.setActive(self._btnchange, not showCurScene and isUnlock)
	gohelper.setActive(self._btnget, not showCurScene and status == MainSceneSwitchEnum.SceneStutas.LockCanGet)
	gohelper.setActive(self._goshowing, showCurScene and isUnlock)
	gohelper.setActive(self._goLocked, not showCurScene and status == MainSceneSwitchEnum.SceneStutas.Lock)
end

function ClickUISwitchView:_updateInfo(itemId, defaultUnlock)
	local itemConfig = lua_item.configDict[itemId]

	if not itemConfig then
		return
	end

	self._txtname.text = itemConfig.name
	self._txtdescr.text = itemConfig.desc

	if defaultUnlock == 1 then
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

function ClickUISwitchView:onClose()
	TaskDispatcher.cancelTask(self._runRepeatClickUIAnim, self)
end

function ClickUISwitchView:onDestroyView()
	return
end

return ClickUISwitchView
