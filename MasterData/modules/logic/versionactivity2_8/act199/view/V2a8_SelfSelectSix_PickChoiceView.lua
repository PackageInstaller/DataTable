-- chunkname: @modules/logic/versionactivity2_8/act199/view/V2a8_SelfSelectSix_PickChoiceView.lua

module("modules.logic.versionactivity2_8.act199.view.V2a8_SelfSelectSix_PickChoiceView", package.seeall)

local V2a8_SelfSelectSix_PickChoiceView = class("V2a8_SelfSelectSix_PickChoiceView", BaseView)

function V2a8_SelfSelectSix_PickChoiceView:onInitView()
	self._txtnum = gohelper.findChildText(self.viewGO, "Tips2/#txt_num")
	self._btnconfirm = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_confirm")
	self._btncancel = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_cancel")
	self._scrollrule = gohelper.findChildScrollRect(self.viewGO, "#scroll_rule")
	self._trsscrollrule = gohelper.findChild(self.viewGO, "#scroll_rule").transform
	self._trscontent = gohelper.findChild(self.viewGO, "#scroll_rule/Viewport/Content").transform

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V2a8_SelfSelectSix_PickChoiceView:addEvents()
	self._btnconfirm:AddClickListener(self._btnconfirmOnClick, self)
	self._btncancel:AddClickListener(self._btncancelOnClick, self)
	self.addEventCb(self, V2a8_SelfSelectSix_PickChoiceController.instance, V2a8_SelfSelectSix_PickChoiceEvent.onCustomPickListChanged, self.refreshUI, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, self._onCloseView, self)
end

function V2a8_SelfSelectSix_PickChoiceView:removeEvents()
	self._btnconfirm:RemoveClickListener()
	self._btncancel:RemoveClickListener()
	self.removeEventCb(self, V2a8_SelfSelectSix_PickChoiceController.instance, V2a8_SelfSelectSix_PickChoiceEvent.onCustomPickListChanged, self.refreshUI, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, self._onCloseView, self)
end

function V2a8_SelfSelectSix_PickChoiceView:_btnconfirmOnClick()
	V2a8_SelfSelectSix_PickChoiceController.instance:tryChoice(self.viewParam)
end

function V2a8_SelfSelectSix_PickChoiceView:_btncancelOnClick()
	self:closeThis()
end

function V2a8_SelfSelectSix_PickChoiceView:_editableInitView()
	return
end

function V2a8_SelfSelectSix_PickChoiceView:onUpdateParam()
	return
end

function V2a8_SelfSelectSix_PickChoiceView:onOpen()
	self:refreshSelectCount()
end

function V2a8_SelfSelectSix_PickChoiceView:refreshUI()
	self:refreshSelectCount()
end

function V2a8_SelfSelectSix_PickChoiceView:_onCloseView(viewName)
	if viewName == ViewName.CharacterGetView then
		self:closeThis()
	end
end

function V2a8_SelfSelectSix_PickChoiceView:refreshSelectCount()
	local selectCount = V2a8_SelfSelectSix_PickChoiceListModel.instance:getSelectCount()
	local maxCount = V2a8_SelfSelectSix_PickChoiceListModel.instance:getMaxSelectCount()

	self._txtnum.text = GameUtil.getSubPlaceholderLuaLang(luaLang("summon_custompick_selectnum"), {
		selectCount,
		maxCount
	})

	ZProj.UGUIHelper.SetGrayscale(self._btnconfirm.gameObject, selectCount ~= maxCount)
end

function V2a8_SelfSelectSix_PickChoiceView:onClose()
	return
end

function V2a8_SelfSelectSix_PickChoiceView:onDestroyView()
	return
end

return V2a8_SelfSelectSix_PickChoiceView
