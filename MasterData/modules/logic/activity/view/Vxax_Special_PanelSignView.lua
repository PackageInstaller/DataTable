-- chunkname: @modules/logic/activity/view/Vxax_Special_PanelSignView.lua

module("modules.logic.activity.view.Vxax_Special_PanelSignView", package.seeall)

local Vxax_Special_PanelSignView = class("Vxax_Special_PanelSignView", Vxax_Special_BaseView)

function Vxax_Special_PanelSignView:onInitView()
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Root/LimitTime/image_LimitTimeBG/#txt_LimitTime")
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "Root/#simage_FullBG/#btn_Close")
	self._btnemptyTop = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_emptyTop")
	self._btnemptyBottom = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_emptyBottom")
	self._btnemptyLeft = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_emptyLeft")
	self._btnemptyRight = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_emptyRight")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Vxax_Special_PanelSignView:addEvents()
	Vxax_Special_PanelSignView.super.addEvents(self)
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
	self._btnemptyTop:AddClickListener(self._btnemptyTopOnClick, self)
	self._btnemptyBottom:AddClickListener(self._btnemptyBottomOnClick, self)
	self._btnemptyLeft:AddClickListener(self._btnemptyLeftOnClick, self)
	self._btnemptyRight:AddClickListener(self._btnemptyRightOnClick, self)
end

function Vxax_Special_PanelSignView:removeEvents()
	self._btnClose:RemoveClickListener()
	Vxax_Special_PanelSignView.super.removeEvents(self)
	self._btnemptyTop:RemoveClickListener()
	self._btnemptyBottom:RemoveClickListener()
	self._btnemptyLeft:RemoveClickListener()
	self._btnemptyRight:RemoveClickListener()
end

function Vxax_Special_PanelSignView:ctor(...)
	Vxax_Special_PanelSignView.super.ctor(self, ...)
	self:internal_set_openMode(Activity101SignViewBase.eOpenMode.PaiLian)
end

function Vxax_Special_PanelSignView:_btnCloseOnClick()
	self:closeThis()
end

function Vxax_Special_PanelSignView:_btnemptyTopOnClick()
	self:closeThis()
end

function Vxax_Special_PanelSignView:_btnemptyBottomOnClick()
	self:closeThis()
end

function Vxax_Special_PanelSignView:_btnemptyLeftOnClick()
	self:closeThis()
end

function Vxax_Special_PanelSignView:_btnemptyRightOnClick()
	self:closeThis()
end

function Vxax_Special_PanelSignView:_editableInitView()
	self._txtLimitTime.text = ""
end

function Vxax_Special_PanelSignView:onOpen()
	self:internal_set_actId(self.viewParam.actId)
	self:_clearTimeTick()
	TaskDispatcher.runRepeat(self._refreshTimeTick, self, 1)

	if not self._inited then
		self:internal_onOpen()

		self._inited = true
	else
		self:_refresh()
	end
end

function Vxax_Special_PanelSignView:onClose()
	self:_clearTimeTick()
end

function Vxax_Special_PanelSignView:onDestroyView()
	self:_clearTimeTick()
	Vxax_Special_PanelSignView.super.onDestroyView(self)
end

function Vxax_Special_PanelSignView:_clearTimeTick()
	TaskDispatcher.cancelTask(self._refreshTimeTick, self)
end

function Vxax_Special_PanelSignView:onRefresh()
	self:_refreshList()
	self:_refreshTimeTick()
end

function Vxax_Special_PanelSignView:_refreshTimeTick()
	self._txtLimitTime.text = self:getRemainTimeStr()
end

function Vxax_Special_PanelSignView:onFindChind_RewardGo(i)
	return gohelper.findChild(self.viewGO, "Root/reward/node" .. i)
end

return Vxax_Special_PanelSignView
