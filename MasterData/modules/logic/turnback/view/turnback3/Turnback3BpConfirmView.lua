-- chunkname: @modules/logic/turnback/view/turnback3/Turnback3BpConfirmView.lua

module("modules.logic.turnback.view.turnback3.Turnback3BpConfirmView", package.seeall)

local Turnback3BpConfirmView = class("Turnback3BpConfirmView", BaseView)

function Turnback3BpConfirmView:onInitView()
	self._gostate1 = gohelper.findChild(self.viewGO, "root/#go_state1")
	self._btnclosebtn = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_state1/bg/#btn_closebtn")
	self._scrollreward1 = gohelper.findChildScrollRect(self.viewGO, "root/#go_state1/#scroll_reward1")
	self._gorewarditem = gohelper.findChild(self.viewGO, "root/#go_state1/#scroll_reward1/viewport/content/#go_rewarditem")
	self._scrollreward2 = gohelper.findChildScrollRect(self.viewGO, "root/#go_state1/#scroll_reward2")
	self._gounlockbtn = gohelper.findChild(self.viewGO, "root/#go_state1/#go_unlockbtn")
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "root/#go_state1/#go_unlockbtn/#simage_icon")
	self._txtprice = gohelper.findChildText(self.viewGO, "root/#go_state1/#go_unlockbtn/#txt_price")
	self._gostate2 = gohelper.findChild(self.viewGO, "root/#go_state2")
	self._scrollreward = gohelper.findChildScrollRect(self.viewGO, "root/#go_state2/#scroll_reward")
	self._gostate3 = gohelper.findChild(self.viewGO, "root/#go_state3")
	self._txtdesc = gohelper.findChildText(self.viewGO, "root/#go_state3/#txt_desc")
	self._btnyes = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_state3/#btn_yes")
	self._gopcbtn = gohelper.findChild(self.viewGO, "root/#go_state3/#btn_yes/#go_pcbtn")
	self._btnno = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_state3/#btn_no")
	self._txtnum = gohelper.findChildText(self.viewGO, "root/#go_state3/yueka/#txt_num")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Turnback3BpConfirmView:addEvents()
	self._btnclosebtn:AddClickListener(self._btnclosebtnOnClick, self)
	self._btnyes:AddClickListener(self._btnyesOnClick, self)
	self._btnno:AddClickListener(self._btnnoOnClick, self)
end

function Turnback3BpConfirmView:removeEvents()
	self._btnclosebtn:RemoveClickListener()
	self._btnyes:RemoveClickListener()
	self._btnno:RemoveClickListener()
end

function Turnback3BpConfirmView:_btnclosebtnOnClick()
	return
end

function Turnback3BpConfirmView:_btnyesOnClick()
	return
end

function Turnback3BpConfirmView:_btnnoOnClick()
	return
end

function Turnback3BpConfirmView:_editableInitView()
	return
end

function Turnback3BpConfirmView:onUpdateParam()
	return
end

function Turnback3BpConfirmView:onOpen()
	return
end

function Turnback3BpConfirmView:onClose()
	return
end

function Turnback3BpConfirmView:onDestroyView()
	return
end

return Turnback3BpConfirmView
