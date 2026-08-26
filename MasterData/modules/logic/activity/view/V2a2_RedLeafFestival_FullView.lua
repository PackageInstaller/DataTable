-- chunkname: @modules/logic/activity/view/V2a2_RedLeafFestival_FullView.lua

module("modules.logic.activity.view.V2a2_RedLeafFestival_FullView", package.seeall)

local V2a2_RedLeafFestival_FullView = class("V2a2_RedLeafFestival_FullView", Activity101SignViewBase)

function V2a2_RedLeafFestival_FullView:onInitView()
	self._simagePanelBG = gohelper.findChildSingleImage(self.viewGO, "Root/#simage_PanelBG")
	self._simageTitle = gohelper.findChildSingleImage(self.viewGO, "Root/#simage_Title")
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

function V2a2_RedLeafFestival_FullView:addEvents()
	Activity101SignViewBase.addEvents(self)
end

function V2a2_RedLeafFestival_FullView:removeEvents()
	Activity101SignViewBase.removeEvents(self)
end

function V2a2_RedLeafFestival_FullView:_editableInitView()
	self._txtLimitTime.text = ""

	self:internal_set_openMode(Activity101SignViewBase.eOpenMode.ActivityBeginnerView)
end

function V2a2_RedLeafFestival_FullView:onOpen()
	self:internal_onOpen()
	self:_clearTimeTick()
	TaskDispatcher.runRepeat(self._refreshTimeTick, self, 1)
end

function V2a2_RedLeafFestival_FullView:onClose()
	self:_clearTimeTick()
end

function V2a2_RedLeafFestival_FullView:onDestroyView()
	Activity101SignViewBase._internal_onDestroy(self)
	self:_clearTimeTick()
end

function V2a2_RedLeafFestival_FullView:_clearTimeTick()
	TaskDispatcher.cancelTask(self._refreshTimeTick, self)
end

function V2a2_RedLeafFestival_FullView:onRefresh()
	self:_refreshList()
	self:_refreshTimeTick()
end

function V2a2_RedLeafFestival_FullView:_refreshTimeTick()
	self._txtLimitTime.text = self:getRemainTimeStr()
end

return V2a2_RedLeafFestival_FullView
