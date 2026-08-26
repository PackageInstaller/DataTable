-- chunkname: @modules/logic/activity/view/Vxax_Role_PanelSignView.lua

module("modules.logic.activity.view.Vxax_Role_PanelSignView", package.seeall)

local Vxax_Role_PanelSignView = class("Vxax_Role_PanelSignView", Activity101SignViewBase)

function Vxax_Role_PanelSignView:onInitView()
	self._simagePanelBG = gohelper.findChildSingleImage(self.viewGO, "Root/#simage_PanelBG")
	self._simageTitle = gohelper.findChildSingleImage(self.viewGO, "Root/#simage_Title")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Root/image_LimitTimeBG/#txt_LimitTime")
	self._scrollItemList = gohelper.findChildScrollRect(self.viewGO, "Root/#scroll_ItemList")
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "Root/#btn_Close")
	self._btnemptyTop = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_emptyTop")
	self._btnemptyBottom = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_emptyBottom")
	self._btnemptyLeft = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_emptyLeft")
	self._btnemptyRight = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_emptyRight")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Vxax_Role_PanelSignView:addEvents()
	Activity101SignViewBase.addEvents(self)
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
	self._btnemptyTop:AddClickListener(self._btnemptyTopOnClick, self)
	self._btnemptyBottom:AddClickListener(self._btnemptyBottomOnClick, self)
	self._btnemptyLeft:AddClickListener(self._btnemptyLeftOnClick, self)
	self._btnemptyRight:AddClickListener(self._btnemptyRightOnClick, self)
end

function Vxax_Role_PanelSignView:removeEvents()
	Activity101SignViewBase.removeEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnemptyTop:RemoveClickListener()
	self._btnemptyBottom:RemoveClickListener()
	self._btnemptyLeft:RemoveClickListener()
	self._btnemptyRight:RemoveClickListener()
end

function Vxax_Role_PanelSignView:_btnCloseOnClick()
	self:closeThis()
end

function Vxax_Role_PanelSignView:_btnemptyTopOnClick()
	self:closeThis()
end

function Vxax_Role_PanelSignView:_btnemptyBottomOnClick()
	self:closeThis()
end

function Vxax_Role_PanelSignView:_btnemptyLeftOnClick()
	self:closeThis()
end

function Vxax_Role_PanelSignView:_btnemptyRightOnClick()
	self:closeThis()
end

function Vxax_Role_PanelSignView:onOpen()
	self._txtLimitTime.text = ""

	self:internal_set_actId(self.viewParam.actId)
	self:internal_set_openMode(Activity101SignViewBase.eOpenMode.PaiLian)
	self:internal_onOpen()
	TaskDispatcher.runRepeat(self._refreshTimeTick, self, 1)
end

function Vxax_Role_PanelSignView:onClose()
	TaskDispatcher.cancelTask(self._refreshTimeTick, self)
end

function Vxax_Role_PanelSignView:onDestroyView()
	Activity101SignViewBase._internal_onDestroy(self)
	self._simagePanelBG:UnLoadImage()
	self._simageTitle:UnLoadImage()
	TaskDispatcher.cancelTask(self._refreshTimeTick, self)
end

function Vxax_Role_PanelSignView:onRefresh()
	self:_refreshList()
	self:_refreshTimeTick()
end

function Vxax_Role_PanelSignView:_refreshTimeTick()
	self._txtLimitTime.text = self:getRemainTimeStr()
end

return Vxax_Role_PanelSignView
