-- chunkname: @modules/logic/settings/view/SettingsLoginPageView.lua

module("modules.logic.settings.view.SettingsLoginPageView", package.seeall)

local SettingsLoginPageView = class("SettingsLoginPageView", BaseView)

function SettingsLoginPageView:onInitView()
	self._godropnode = gohelper.findChild(self.viewGO, "scroll/Viewport/Content/#go_loginpage")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SettingsLoginPageView:addEvents()
	self._loginpageClick:AddClickListener(self._onDropClick, self)
end

function SettingsLoginPageView:removeEvents()
	self._loginpageClick:RemoveClickListener()
end

function SettingsLoginPageView:_editableInitView()
	self._itemTbList = {}
	self._godroploginpage = gohelper.findChild(self._godropnode, "droploginpage")
	self._txtDrop = gohelper.findChildText(self._godroploginpage, "Label")
	self._loginpageClick = gohelper.getClickWithAudio(self._godroploginpage, AudioEnum.UI.play_ui_set_click)
	self._dropDownItemListGo = gohelper.findChild(self._godroploginpage, "Template")
	self._goitem = gohelper.findChild(self._dropDownItemListGo, "Viewport/Content/Item")

	gohelper.setActive(self._goitem, false)

	self._dropDownTouchEventMgr = TouchEventMgrHepler.getTouchEventMgr(self._dropDownItemListGo)

	self._dropDownTouchEventMgr:SetIgnoreUI(true)
	self._dropDownTouchEventMgr:SetOnlyTouch(true)
	self._dropDownTouchEventMgr:SetOnClickCb(self._hideDropPage, self)

	self._dropArrowTrs = gohelper.findChildComponent(self._godroploginpage, "arrow", typeof(UnityEngine.Transform))

	self:_initPageDropDown()
end

function SettingsLoginPageView:_initPageDropDown()
	self._loginPageIdList = {
		SettingsEnum.LoginPageType.LastId,
		SettingsEnum.LoginPageType.Random
	}
	self._PageTypeLang = {
		[SettingsEnum.LoginPageType.LastId] = "v3a2_loginpagesetting_new_text",
		[SettingsEnum.LoginPageType.Random] = "v3a2_loginpagesetting_random_text"
	}

	local cfgList = LoginConfig.instance:getPageCfgList()

	for _, cfg in ipairs(cfgList) do
		table.insert(self._loginPageIdList, cfg.id)
	end

	self._curId = PlayerPrefsHelper.getNumber(PlayerPrefsKey.GameLoginViewPageSettingKey, 0)

	if not tabletool.indexOf(self._loginPageIdList, self._curId) or self:_isLockByPageId(self._curId) then
		self._curId = SettingsEnum.LoginPageType.LastId

		PlayerPrefsHelper.setNumber(PlayerPrefsKey.GameLoginViewPageSettingKey, self._curId)
	end

	self:_updatePageDropDown()
end

function SettingsLoginPageView:_updatePageDropDown()
	for i, id in ipairs(self._loginPageIdList) do
		local txt = self:_getStrById(id)
		local isLock = self:_isLockByPageId(id)

		if id == self._curId then
			self._txtDrop.text = string.format("<color=#c3beb6ff>%s</color>", txt)
			txt = string.format("<color=#efb785ff>%s</color>", txt)
		else
			txt = isLock and string.format("<color=#c3beb666>%s</color>", txt) or string.format("<color=#c3beb6ff>%s</color>", txt)
		end

		local item = self._itemTbList[i]

		if item == nil then
			item = self:_createItemTb(gohelper.cloneInPlace(self._goitem, "Item" .. i))

			item.btn:AddClickListener(function(tabTable)
				transformhelper.setLocalScale(self._dropArrowTrs, 1, 1, 1)
				self:_onChangePageItemTb(item)
			end, item)

			self._itemTbList[i] = item
		end

		item.txt.text = txt
		item.id = id

		gohelper.setActive(item.golockicon, isLock)
		gohelper.setActive(item.goselected, id == self._curId)
		gohelper.setActive(item.go, true)
		gohelper.setActive(item.goxian, i ~= #self._loginPageIdList)
	end

	for i = #self._loginPageIdList + 1, #self._loginPageIdList do
		gohelper.setActive(self._loginPageIdList[i].go, false)
	end

	local contentHeight = #self._loginPageIdList * 72

	recthelper.setHeight(self._dropDownItemListGo.transform, contentHeight)
end

function SettingsLoginPageView:_getStrById(id)
	local cfg = LoginConfig.instance:getPageCfgById(id)

	if cfg then
		return cfg.name
	end

	return luaLang(self._PageTypeLang[id])
end

function SettingsLoginPageView:_createItemTb(go)
	local item = self:getUserDataTb_()

	item.go = go
	item.goselected = gohelper.findChild(go, "BG")
	item.goxian = gohelper.findChild(go, "xian")
	item.txt = gohelper.findChildText(go, "Text")
	item.golockicon = gohelper.findChild(go, "LockIcon")
	item.btn = gohelper.getClickWithAudio(go, AudioEnum.UI.play_ui_plot_common)

	return item
end

function SettingsLoginPageView:_onChangePageItemTb(item)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_set_select)

	local cfg = LoginConfig.instance:getPageCfgById(item.id)

	if cfg and self:_isLockByPageId(item.id) then
		local episodeDisplay = DungeonConfig.instance:getEpisodeDisplay(cfg.episodeId)

		GameFacade.showToast(ToastEnum.DungeonMapLevel, episodeDisplay)

		return
	end

	self._curId = item.id

	PlayerPrefsHelper.setNumber(PlayerPrefsKey.GameLoginViewPageSettingKey, self._curId)
	self:_updatePageDropDown()
	self:_hideDropPage()
end

function SettingsLoginPageView:_isLockByPageId(pageId)
	local cfg = LoginConfig.instance:getPageCfgById(pageId)

	if cfg and cfg.episodeId ~= 0 and not LoginPageController.instance:isPassDungeonById(cfg.episodeId) then
		return true
	end

	return false
end

function SettingsLoginPageView:onUpdateParam()
	return
end

function SettingsLoginPageView:onOpen()
	return
end

function SettingsLoginPageView:_onDropClick()
	transformhelper.setLocalScale(self._dropArrowTrs, 1, -1, 1)
	gohelper.setActive(self._dropDownItemListGo, true)
end

function SettingsLoginPageView:_hideDropPage()
	transformhelper.setLocalScale(self._dropArrowTrs, 1, 1, 1)
	gohelper.setActive(self._dropDownItemListGo, false)
end

function SettingsLoginPageView:onClose()
	return
end

function SettingsLoginPageView:onDestroyView()
	if not gohelper.isNil(self._dropDownTouchEventMgr) then
		TouchEventMgrHepler.remove(self._dropDownTouchEventMgr)
	end

	if self._itemTbList and #self._itemTbList > 0 then
		for i = 1, #self._itemTbList do
			self._itemTbList[i].btn:RemoveClickListener()
		end
	end
end

return SettingsLoginPageView
