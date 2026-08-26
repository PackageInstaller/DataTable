-- chunkname: @modules/logic/activity/view/V2a7_Labor_FullSignView.lua

module("modules.logic.activity.view.V2a7_Labor_FullSignView", package.seeall)

local V2a7_Labor_FullSignView = class("V2a7_Labor_FullSignView", Activity101SignViewBase)

function V2a7_Labor_FullSignView:onInitView()
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Root/LimitTime/image_LimitTimeBG/#txt_LimitTime")
	self._txtDec = gohelper.findChildText(self.viewGO, "Root/image_DecBG/#txt_Dec")
	self._goNormalBG = gohelper.findChild(self.viewGO, "Root/Task/#go_NormalBG")
	self._txtdec = gohelper.findChildText(self.viewGO, "Root/Task/#go_NormalBG/scroll_desc/Viewport/Content/#txt_dec")
	self._txtnum = gohelper.findChildText(self.viewGO, "Root/Task/#go_NormalBG/#txt_num")
	self._simagereward = gohelper.findChildSingleImage(self.viewGO, "Root/Task/#go_NormalBG/#simage_reward")
	self._gocanget = gohelper.findChild(self.viewGO, "Root/Task/#go_canget")
	self._goFinishedBG = gohelper.findChild(self.viewGO, "Root/Task/#go_FinishedBG")
	self._scrollItemList = gohelper.findChildScrollRect(self.viewGO, "Root/#scroll_ItemList")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V2a7_Labor_FullSignView:addEvents()
	Activity101SignViewBase.addEvents(self)
end

function V2a7_Labor_FullSignView:removeEvents()
	Activity101SignViewBase.removeEvents(self)
end

function V2a7_Labor_FullSignView:_editableInitView()
	self._txtLimitTime.text = ""

	self:internal_set_openMode(Activity101SignViewBase.eOpenMode.ActivityBeginnerView)
end

function V2a7_Labor_FullSignView:onOpen()
	self:internal_onOpen()
	self:_clearTimeTick()
	TaskDispatcher.runRepeat(self._refreshTimeTick, self, 1)
end

function V2a7_Labor_FullSignView:onClose()
	self:_clearTimeTick()
end

function V2a7_Labor_FullSignView:onDestroyView()
	Activity101SignViewBase._internal_onDestroy(self)
	self:_clearTimeTick()
end

function V2a7_Labor_FullSignView:_clearTimeTick()
	TaskDispatcher.cancelTask(self._refreshTimeTick, self)
end

function V2a7_Labor_FullSignView:onRefresh()
	self:_refreshList()
	self:_refreshTimeTick()
end

function V2a7_Labor_FullSignView:_refreshTimeTick()
	self._txtLimitTime.text = self:getRemainTimeStr()
end

return V2a7_Labor_FullSignView
