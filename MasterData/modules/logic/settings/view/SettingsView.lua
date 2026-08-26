-- chunkname: @modules/logic/settings/view/SettingsView.lua

module("modules.logic.settings.view.SettingsView", package.seeall)

local SettingsView = class("SettingsView", BaseView)

function SettingsView:onInitView()
	MainController.instance:dispatchEvent(MainEvent.OnClickSwitchRole)

	self._gosettingscontent = gohelper.findChild(self.viewGO, "#go_settingscontent")
	self._scrollcategory = gohelper.findChildScrollRect(self.viewGO, "#scroll_category")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SettingsView:addEvents()
	return
end

function SettingsView:removeEvents()
	return
end

function SettingsView:_editableInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "bg/bgimg")

	self._simagebg:LoadImage(ResUrl.getSettingsBg("full/shezhi_bj.jpg"))
end

function SettingsView:onUpdateParam()
	local cateList = SettingsModel.instance:getSettingsCategoryList()

	self:_selectCategory(cateList[1].id)
end

function SettingsView:_selectCategory(id)
	SettingsModel.instance:setCurCategoryId(id)
	SettingsModel.instance:setSettingsCategoryList(self.viewParam.cateList)

	local cateList = SettingsModel.instance:getSettingsCategoryList()

	SettingsCategoryListModel.instance:setCategoryList(cateList)
	self:_refreshView()
end

function SettingsView:onOpen()
	local cateList = SettingsModel.instance:getSettingsCategoryList()

	self:_selectCategory(cateList[1].id)
	self.addEventCb(self, SettingsController.instance, SettingsEvent.SelectCategory, self._selectCategory, self)
	self.addEventCb(self, SettingsController.instance, SettingsEvent.OnChangeLangTxt, self._refreshLangTxt, self)
end

function SettingsView:_refreshView()
	local id = SettingsModel.instance:getCurCategoryId()

	self.viewContainer:switchTab(id)
end

function SettingsView:onClose()
	self.removeEventCb(self, SettingsController.instance, SettingsEvent.SelectCategory, self._selectCategory, self)
	self.removeEventCb(self, SettingsController.instance, SettingsEvent.OnChangeLangTxt, self._refreshLangTxt, self)
	SettingsController.instance:dispatchEvent(SettingsEvent.PlayCloseCategoryAnim)
end

function SettingsView:_refreshLangTxt()
	local arr = self.viewGO:GetComponentsInChildren(typeof(SLFramework.LangTxt), true)
	local len = arr.Length

	for i = 0, len - 1 do
		SLFramework.LanguageMgr.Instance:ApplyLangTxt(arr[i])
	end
end

function SettingsView:onDestroyView()
	self._simagebg:UnLoadImage()
end

return SettingsView
