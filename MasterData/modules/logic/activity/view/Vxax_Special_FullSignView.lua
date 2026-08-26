-- chunkname: @modules/logic/activity/view/Vxax_Special_FullSignView.lua

module("modules.logic.activity.view.Vxax_Special_FullSignView", package.seeall)

local Vxax_Special_FullSignView = class("Vxax_Special_FullSignView", Vxax_Special_BaseView)

function Vxax_Special_FullSignView:onInitView()
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Root/LimitTime/image_LimitTimeBG/#txt_LimitTime")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Vxax_Special_FullSignView:addEvents()
	Vxax_Special_FullSignView.super.addEvents(self)
end

function Vxax_Special_FullSignView:removeEvents()
	Vxax_Special_FullSignView.super.removeEvents(self)
end

function Vxax_Special_FullSignView:ctor(...)
	Vxax_Special_FullSignView.super.ctor(self, ...)

	self._inited = false

	self:internal_set_openMode(Activity101SignViewBase.eOpenMode.ActivityBeginnerView)
end

function Vxax_Special_FullSignView:_editableInitView()
	self._txtLimitTime.text = ""
end

function Vxax_Special_FullSignView:onOpen()
	self:_clearTimeTick()
	TaskDispatcher.runRepeat(self._refreshTimeTick, self, 1)

	if not self._inited then
		self:internal_onOpen()

		self._inited = true
	else
		self:_refresh()
	end
end

function Vxax_Special_FullSignView:onClose()
	self:_clearTimeTick()
end

function Vxax_Special_FullSignView:onDestroyView()
	self:_clearTimeTick()
	Vxax_Special_FullSignView.super.onDestroyView(self)
end

function Vxax_Special_FullSignView:_clearTimeTick()
	TaskDispatcher.cancelTask(self._refreshTimeTick, self)
end

function Vxax_Special_FullSignView:onRefresh()
	self:_refreshList()
	self:_refreshTimeTick()
end

function Vxax_Special_FullSignView:_refreshTimeTick()
	self._txtLimitTime.text = self:getRemainTimeStr()
end

function Vxax_Special_FullSignView:onFindChind_RewardGo(i)
	return gohelper.findChild(self.viewGO, "Root/reward/node" .. i)
end

return Vxax_Special_FullSignView
