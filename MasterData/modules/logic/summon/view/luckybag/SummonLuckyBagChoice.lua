-- chunkname: @modules/logic/summon/view/luckybag/SummonLuckyBagChoice.lua

module("modules.logic.summon.view.luckybag.SummonLuckyBagChoice", package.seeall)

local SummonLuckyBagChoice = class("SummonLuckyBagChoice", BaseView)

function SummonLuckyBagChoice:onInitView()
	self._txtnum = gohelper.findChildText(self.viewGO, "Tips2/#txt_num")
	self._btnconfirm = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_confirm")
	self._btncancel = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_cancel")
	self._scrollrule = gohelper.findChildScrollRect(self.viewGO, "#scroll_rule")
	self._gostoreItem = gohelper.findChild(self.viewGO, "#scroll_rule/Viewport/#go_storeItem")
	self._goexskill = gohelper.findChild(self.viewGO, "#scroll_rule/Viewport/#go_storeItem/selfselectsixchoiceitem/role/#go_exskill")
	self._imageexskill = gohelper.findChildImage(self.viewGO, "#scroll_rule/Viewport/#go_storeItem/selfselectsixchoiceitem/role/#go_exskill/#image_exskill")
	self._goclick = gohelper.findChild(self.viewGO, "#scroll_rule/Viewport/#go_storeItem/selfselectsixchoiceitem/select/#go_click")
	self._gonogain = gohelper.findChild(self.viewGO, "#scroll_rule/Viewport/#go_storeItem/#go_nogain")
	self._goown = gohelper.findChild(self.viewGO, "#scroll_rule/Viewport/#go_storeItem/#go_own")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SummonLuckyBagChoice:addEvents()
	self._btnconfirm:AddClickListener(self._btnconfirmOnClick, self)
	self._btncancel:AddClickListener(self._btncancelOnClick, self)
end

function SummonLuckyBagChoice:removeEvents()
	self._btnconfirm:RemoveClickListener()
	self._btncancel:RemoveClickListener()
end

function SummonLuckyBagChoice:_btnconfirmOnClick()
	SummonLuckyBagChoiceController.instance:trySendChoice()
end

function SummonLuckyBagChoice:_btncancelOnClick()
	self:closeThis()
end

function SummonLuckyBagChoice:_editableInitView()
	self._noGainHeroes = {}
	self._ownHeroes = {}
	self._goTitleNoGain = gohelper.findChild(self.viewGO, "#scroll_rule/Viewport/#go_storeItem/Title1")
	self._goTitleOwn = gohelper.findChild(self.viewGO, "#scroll_rule/Viewport/#go_storeItem/Title2")
	self._txtTitle = gohelper.findChildText(self.viewGO, "Title")
	self._goitem = gohelper.findChild(self.viewGO, "#scroll_rule/Viewport/#go_storeItem/selfselectsixchoiceitem")
	self.goTips2 = gohelper.findChild(self.viewGO, "Tips2")
	self._tfcontent = self._gostoreItem.transform

	gohelper.setActive(self._goitem, false)
	gohelper.setActive(self.goTips2, false)
end

function SummonLuckyBagChoice:onDestroyView()
	SummonLuckyBagChoiceController.instance:onCloseView()
end

function SummonLuckyBagChoice:onOpen()
	logNormal("SummonLuckyBagChoice onOpen")
	self.addEventCb(self, SummonController.instance, SummonEvent.onLuckyBagOpened, self.handleLuckyBagOpened, self)
	self.addEventCb(self, SummonLuckyBagChoiceController.instance, SummonEvent.onLuckyListChanged, self.refreshUI, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	SummonLuckyBagChoiceController.instance:onOpenView(self.viewParam.luckyBagId, self.viewParam.poolId)
	self:refreshUI()
end

function SummonLuckyBagChoice:onClose()
	return
end

function SummonLuckyBagChoice:refreshUI()
	local isOpened = SummonLuckyBagChoiceController.instance:isLuckyBagOpened()
	local selectId = SummonLuckyBagChoiceListModel.instance:getSelectId()

	ZProj.UGUIHelper.SetGrayscale(self._btnconfirm.gameObject, isOpened or selectId == nil)
	self:refreshList()
end

function SummonLuckyBagChoice:handleLuckyBagOpened()
	self._btnconfirm:RemoveClickListener()
	self._btncancel:RemoveClickListener()

	local isOpened = SummonLuckyBagChoiceController.instance:isLuckyBagOpened()
	local selectId = SummonLuckyBagChoiceListModel.instance:getSelectId()

	ZProj.UGUIHelper.SetGrayscale(self._btnconfirm.gameObject, isOpened or selectId == nil)
end

function SummonLuckyBagChoice:refreshList()
	self:refreshItems(SummonLuckyBagChoiceListModel.instance.noGainList, self._noGainHeroes, self._gonogain, self._goTitleNoGain)
	self:refreshItems(SummonLuckyBagChoiceListModel.instance.ownList, self._ownHeroes, self._goown, self._goTitleOwn)
	ZProj.UGUIHelper.RebuildLayout(self._tfcontent)
end

function SummonLuckyBagChoice:refreshItems(datas, items, goRoot, goTitle)
	if datas and #datas > 0 then
		gohelper.setActive(goRoot, true)
		gohelper.setActive(goTitle, true)

		for index, mo in ipairs(datas) do
			local item = self:getOrCreateItem(index, items, goRoot)

			item.component:onUpdateMO(mo)
		end
	else
		gohelper.setActive(goRoot, false)
		gohelper.setActive(goTitle, false)
	end
end

function SummonLuckyBagChoice:_onCloseView(viewName)
	if viewName == ViewName.CharacterGetView then
		self:closeThis()
	end
end

function SummonLuckyBagChoice:getOrCreateItem(index, items, goRoot)
	local item = items[index]

	if not item then
		item = self:getUserDataTb_()
		item.go = gohelper.clone(self._goitem, goRoot, "item" .. tostring(index))

		gohelper.setActive(item.go, true)

		item.component = MonoHelper.addNoUpdateLuaComOnceToGo(item.go, SummonLuckyBagChoiceItem)

		item.component:init(item.go)
		item.component:addEvents()

		items[index] = item
	end

	return item
end

return SummonLuckyBagChoice
