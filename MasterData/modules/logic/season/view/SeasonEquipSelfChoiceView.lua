-- chunkname: @modules/logic/season/view/SeasonEquipSelfChoiceView.lua

module("modules.logic.season.view.SeasonEquipSelfChoiceView", package.seeall)

local SeasonEquipSelfChoiceView = class("SeasonEquipSelfChoiceView", BaseView)

function SeasonEquipSelfChoiceView:onInitView()
	self._btnclose1 = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close1")
	self._simagebg1 = gohelper.findChildSingleImage(self.viewGO, "root/bg/#simage_bg1")
	self._simagebg2 = gohelper.findChildSingleImage(self.viewGO, "root/bg/#simage_bg2")
	self._scrollitem = gohelper.findChildScrollRect(self.viewGO, "root/mask/#scroll_item")
	self._gocarditem = gohelper.findChild(self.viewGO, "root/mask/#scroll_item/viewport/itemcontent/#go_carditem")
	self._btnok = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_ok")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SeasonEquipSelfChoiceView:addEvents()
	self._btnclose1:AddClickListener(self._btnclose1OnClick, self)
	self._btnok:AddClickListener(self._btnokOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function SeasonEquipSelfChoiceView:removeEvents()
	self._btnclose1:RemoveClickListener()
	self._btnok:RemoveClickListener()
	self._btnclose:RemoveClickListener()
end

function SeasonEquipSelfChoiceView:_btnclose1OnClick()
	return
end

function SeasonEquipSelfChoiceView:_btnokOnClick()
	Activity104EquipSelfChoiceController.instance:sendSelectCard(self.handleSendChoice, self)
end

function SeasonEquipSelfChoiceView:_btncloseOnClick()
	self:closeThis()
end

function SeasonEquipSelfChoiceView:_editableInitView()
	self._simagebg1:LoadImage(ResUrl.getCommonIcon("bg_leftdown"))
	self._simagebg2:LoadImage(ResUrl.getCommonIcon("bg_rightup"))
end

function SeasonEquipSelfChoiceView:onDestroyView()
	self._simagebg1:UnLoadImage()
	self._simagebg2:UnLoadImage()
	Activity104EquipSelfChoiceController.instance:onCloseView()
end

function SeasonEquipSelfChoiceView:onOpen()
	local actId = self.viewParam.actId
	local costItemUid = self.viewParam.costItemUid

	if not Activity104EquipSelfChoiceController:checkOpenParam(actId, costItemUid) then
		self:delayClose()

		return
	end

	Activity104EquipSelfChoiceController.instance:onOpenView(actId, costItemUid)
end

function SeasonEquipSelfChoiceView:onClose()
	TaskDispatcher.cancelTask(self.closeThis, self)
end

function SeasonEquipSelfChoiceView:delayClose()
	TaskDispatcher.runDelay(self.closeThis, self, 0.001)
end

function SeasonEquipSelfChoiceView:handleSendChoice(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	self:closeThis()

	if self.viewParam.successCall then
		self.viewParam.successCall(self.viewParam.successCallObj)
	end
end

return SeasonEquipSelfChoiceView
