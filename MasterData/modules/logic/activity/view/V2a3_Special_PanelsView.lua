-- chunkname: @modules/logic/activity/view/V2a3_Special_PanelsView.lua

module("modules.logic.activity.view.V2a3_Special_PanelsView", package.seeall)

local V2a3_Special_PanelsView = class("V2a3_Special_PanelsView", V2a3_Special_BaseView)

function V2a3_Special_PanelsView:onInitView()
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

function V2a3_Special_PanelsView:addEvents()
	V2a3_Special_PanelsView.super.addEvents(self)
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
	self._btnemptyTop:AddClickListener(self._btnemptyTopOnClick, self)
	self._btnemptyBottom:AddClickListener(self._btnemptyBottomOnClick, self)
	self._btnemptyLeft:AddClickListener(self._btnemptyLeftOnClick, self)
	self._btnemptyRight:AddClickListener(self._btnemptyRightOnClick, self)
end

function V2a3_Special_PanelsView:removeEvents()
	self._btnClose:RemoveClickListener()
	V2a3_Special_PanelsView.super.removeEvents(self)
	self._btnemptyTop:RemoveClickListener()
	self._btnemptyBottom:RemoveClickListener()
	self._btnemptyLeft:RemoveClickListener()
	self._btnemptyRight:RemoveClickListener()
end

function V2a3_Special_PanelsView:ctor(...)
	V2a3_Special_PanelsView.super.ctor(self, ...)
	self:internal_set_openMode(Activity101SignViewBase.eOpenMode.PaiLian)
end

function V2a3_Special_PanelsView:_btnCloseOnClick()
	self:closeThis()
end

function V2a3_Special_PanelsView:_btnemptyTopOnClick()
	self:closeThis()
end

function V2a3_Special_PanelsView:_btnemptyBottomOnClick()
	self:closeThis()
end

function V2a3_Special_PanelsView:_btnemptyLeftOnClick()
	self:closeThis()
end

function V2a3_Special_PanelsView:_btnemptyRightOnClick()
	self:closeThis()
end

function V2a3_Special_PanelsView:_editableInitView()
	self._txtLimitTime.text = ""
end

function V2a3_Special_PanelsView:onOpen()
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

function V2a3_Special_PanelsView:onClose()
	self:_clearTimeTick()
end

function V2a3_Special_PanelsView:onDestroyView()
	self:_clearTimeTick()
	V2a3_Special_PanelsView.super.onDestroyView(self)
end

function V2a3_Special_PanelsView:_clearTimeTick()
	TaskDispatcher.cancelTask(self._refreshTimeTick, self)
end

function V2a3_Special_PanelsView:onRefresh()
	self:_refreshList()
	self:_refreshTimeTick()
end

function V2a3_Special_PanelsView:_refreshTimeTick()
	self._txtLimitTime.text = self:getRemainTimeStr()
end

function V2a3_Special_PanelsView:onFindChind_RewardGo(i)
	return gohelper.findChild(self.viewGO, "Root/reward/node" .. i)
end

return V2a3_Special_PanelsView
