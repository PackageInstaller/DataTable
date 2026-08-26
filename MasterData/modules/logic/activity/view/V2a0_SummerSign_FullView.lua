-- chunkname: @modules/logic/activity/view/V2a0_SummerSign_FullView.lua

module("modules.logic.activity.view.V2a0_SummerSign_FullView", package.seeall)

local V2a0_SummerSign_FullView = class("V2a0_SummerSign_FullView", Activity101SignViewBase)

function V2a0_SummerSign_FullView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Root/LimitTime/image_LimitTimeBG/#txt_LimitTime")
	self._scrollItemList = gohelper.findChildScrollRect(self.viewGO, "Root/#scroll_ItemList")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V2a0_SummerSign_FullView:addEvents()
	Activity101SignViewBase.addEvents(self)
end

function V2a0_SummerSign_FullView:removeEvents()
	Activity101SignViewBase.removeEvents(self)
end

function V2a0_SummerSign_FullView:_editableInitView()
	self._txtLimitTime.text = ""

	self:internal_set_openMode(Activity101SignViewBase.eOpenMode.ActivityBeginnerView)
end

function V2a0_SummerSign_FullView:onOpen()
	self:internal_onOpen()
	self:_clearTimeTick()
	TaskDispatcher.runRepeat(self._refreshTimeTick, self, 1)
end

function V2a0_SummerSign_FullView:onClose()
	self:_clearTimeTick()
end

function V2a0_SummerSign_FullView:onDestroyView()
	Activity101SignViewBase._internal_onDestroy(self)
	self:_clearTimeTick()
	self._simageFullBG:UnLoadImage()
end

function V2a0_SummerSign_FullView:_clearTimeTick()
	TaskDispatcher.cancelTask(self._refreshTimeTick, self)
end

function V2a0_SummerSign_FullView:onRefresh()
	self:_refreshList()
	self:_refreshTimeTick()
end

function V2a0_SummerSign_FullView:_refreshTimeTick()
	self._txtLimitTime.text = self:getRemainTimeStr()
end

return V2a0_SummerSign_FullView
