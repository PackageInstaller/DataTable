-- chunkname: @modules/logic/activity/view/V2a3_Role_FullSignView.lua

module("modules.logic.activity.view.V2a3_Role_FullSignView", package.seeall)

local V2a3_Role_FullSignView = class("V2a3_Role_FullSignView", Activity101SignViewBase)

function V2a3_Role_FullSignView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._simageTitle = gohelper.findChildSingleImage(self.viewGO, "Root/#simage_Title")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Root/LimitTime/image_LimitTimeBG/#txt_LimitTime")
	self._scrollItemList = gohelper.findChildScrollRect(self.viewGO, "Root/#scroll_ItemList")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V2a3_Role_FullSignView:addEvents()
	Activity101SignViewBase.addEvents(self)
end

function V2a3_Role_FullSignView:removeEvents()
	Activity101SignViewBase.removeEvents(self)
end

function V2a3_Role_FullSignView:onOpen()
	self._txtLimitTime.text = ""

	self:internal_set_openMode(Activity101SignViewBase.eOpenMode.ActivityBeginnerView)
	self:internal_onOpen()
	TaskDispatcher.runRepeat(self._refreshTimeTick, self, 1)
end

function V2a3_Role_FullSignView:onClose()
	self._isFirstUpdateScrollPos = nil

	TaskDispatcher.cancelTask(self._refreshTimeTick, self)
end

function V2a3_Role_FullSignView:onDestroyView()
	Activity101SignViewBase._internal_onDestroy(self)
	self._simageFullBG:UnLoadImage()
	self._simageTitle:UnLoadImage()
	TaskDispatcher.cancelTask(self._refreshTimeTick, self)
end

function V2a3_Role_FullSignView:onRefresh()
	self:_refreshList()
	self:_refreshTimeTick()
end

function V2a3_Role_FullSignView:_refreshTimeTick()
	self._txtLimitTime.text = self:getRemainTimeStr()
end

return V2a3_Role_FullSignView
