-- chunkname: @modules/logic/versionactivity2_7/v2a7_selfselectsix_1/view/V2a7_SelfSelectSix_PickChoiceView.lua

module("modules.logic.versionactivity2_7.v2a7_selfselectsix_1.view.V2a7_SelfSelectSix_PickChoiceView", package.seeall)

local V2a7_SelfSelectSix_PickChoiceView = class("V2a7_SelfSelectSix_PickChoiceView", BaseView)

function V2a7_SelfSelectSix_PickChoiceView:onInitView()
	self._gopickchoice = gohelper.findChild(self.viewGO, "pickchoice")
	self._gooverview = gohelper.findChild(self.viewGO, "overview")
	self._txtnum = gohelper.findChildText(self._gopickchoice, "Tips2/#txt_num")
	self._btnoverview = gohelper.findChildButtonWithAudio(self.viewGO, "overview/#btn_close")
	self._btnconfirm = gohelper.findChildButtonWithAudio(self._gopickchoice, "#btn_confirm")
	self._btncancel = gohelper.findChildButtonWithAudio(self._gopickchoice, "#btn_cancel")
	self._scrollrule = gohelper.findChildScrollRect(self.viewGO, "#scroll_rule")
	self._trsscrollrule = gohelper.findChild(self.viewGO, "#scroll_rule").transform
	self._trscontent = gohelper.findChild(self.viewGO, "#scroll_rule/Viewport/Content").transform
	self._gostoreItem = gohelper.findChild(self.viewGO, "#scroll_rule/Viewport/#go_storeItem")
	self._txtlocked = gohelper.findChildText(self.viewGO, "#scroll_rule/Viewport/#go_storeItem/Title/go_locked/#txt_locked")
	self._txtunlock = gohelper.findChildText(self.viewGO, "#scroll_rule/Viewport/#go_storeItem/Title/go_unlock/#txt_unlock")
	self._gohero = gohelper.findChild(self.viewGO, "#scroll_rule/Viewport/#go_storeItem/#go_hero")
	self._goexskill = gohelper.findChild(self.viewGO, "#scroll_rule/Viewport/#go_storeItem/#go_hero/heroitem/role/#go_exskill")
	self._imageexskill = gohelper.findChildImage(self.viewGO, "#scroll_rule/Viewport/#go_storeItem/#go_hero/heroitem/role/#go_exskill/#image_exskill")
	self._goclick = gohelper.findChild(self.viewGO, "#scroll_rule/Viewport/#go_storeItem/#go_hero/heroitem/select/#go_click")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V2a7_SelfSelectSix_PickChoiceView:addEvents()
	self._btnconfirm:AddClickListener(self._btnconfirmOnClick, self)
	self._btncancel:AddClickListener(self.closeThis, self)
	self._btnoverview:AddClickListener(self.closeThis, self)
	self.addEventCb(self, V2a7_SelfSelectSix_PickChoiceController.instance, V2a7_SelfSelectSix_PickChoiceEvent.onCustomPickListChanged, self.refreshUI, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, self._onCloseView, self)
end

function V2a7_SelfSelectSix_PickChoiceView:removeEvents()
	self._btnconfirm:RemoveClickListener()
	self._btncancel:RemoveClickListener()
	self._btnoverview:RemoveClickListener()
	self.removeEventCb(self, V2a7_SelfSelectSix_PickChoiceController.instance, V2a7_SelfSelectSix_PickChoiceEvent.onCustomPickListChanged, self.refreshUI, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, self._onCloseView, self)
end

function V2a7_SelfSelectSix_PickChoiceView:_btnconfirmOnClick()
	V2a7_SelfSelectSix_PickChoiceController.instance:tryChoice(self.viewParam)
end

function V2a7_SelfSelectSix_PickChoiceView:_editableInitView()
	return
end

function V2a7_SelfSelectSix_PickChoiceView:onOpen()
	self._isPreview = self.viewParam and self.viewParam.isPreview

	gohelper.setActive(self._gopickchoice, not self._isPreview)
	gohelper.setActive(self._gooverview, self._isPreview)
	self:refreshSelectCount()

	local lastunlockindex = V2a7_SelfSelectSix_PickChoiceListModel.instance:getLastUnlockIndex() - 1
	local arrCount = V2a7_SelfSelectSix_PickChoiceListModel.instance:getArrCount()
	local itemheight = 266
	local endspace = 30
	local contentHeight = itemheight * arrCount + endspace

	if lastunlockindex > 0 then
		if not (lastunlockindex * itemheight) then
			local moveHeight = 0
			local showHeight = recthelper.getHeight(self._trsscrollrule)
			local canMoveHeight = contentHeight - showHeight

			if canMoveHeight < moveHeight then
				moveHeight = canMoveHeight
			end

			ZProj.TweenHelper.DOAnchorPosY(self._trscontent, moveHeight, 0.3)
		end
	end
end

function V2a7_SelfSelectSix_PickChoiceView:refreshUI()
	self:refreshSelectCount()
end

function V2a7_SelfSelectSix_PickChoiceView:_onCloseView(viewName)
	if viewName == ViewName.CharacterGetView then
		self:closeThis()
	end
end

function V2a7_SelfSelectSix_PickChoiceView:refreshSelectCount()
	local selectCount = V2a7_SelfSelectSix_PickChoiceListModel.instance:getSelectCount()
	local maxCount = V2a7_SelfSelectSix_PickChoiceListModel.instance:getMaxSelectCount()

	self._txtnum.text = GameUtil.getSubPlaceholderLuaLang(luaLang("summon_custompick_selectnum"), {
		selectCount,
		maxCount
	})

	ZProj.UGUIHelper.SetGrayscale(self._btnconfirm.gameObject, selectCount ~= maxCount)
end

function V2a7_SelfSelectSix_PickChoiceView:onClose()
	return
end

function V2a7_SelfSelectSix_PickChoiceView:onDestroyView()
	return
end

return V2a7_SelfSelectSix_PickChoiceView
