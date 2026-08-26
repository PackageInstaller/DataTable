-- chunkname: @modules/logic/activity/view/Role_FullSignView.lua

module("modules.logic.activity.view.Role_FullSignView", package.seeall)

local Role_FullSignView = class("Role_FullSignView", Activity101SignViewBase)

function Role_FullSignView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._simageTitle = gohelper.findChildSingleImage(self.viewGO, "Root/#simage_Title")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Root/LimitTime/image_LimitTimeBG/#txt_LimitTime")
	self._scrollItemList = gohelper.findChildScrollRect(self.viewGO, "Root/#scroll_ItemList")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Role_FullSignView:addEvents()
	Activity101SignViewBase.addEvents(self)
end

function Role_FullSignView:removeEvents()
	Activity101SignViewBase.removeEvents(self)
end

function Role_FullSignView:onOpen()
	self._txtLimitTime.text = ""

	self:internal_set_openMode(Activity101SignViewBase.eOpenMode.ActivityBeginnerView)
	self:internal_onOpen()
	TaskDispatcher.runRepeat(self._refreshTimeTick, self, 1)
end

function Role_FullSignView:onClose()
	self._isFirstUpdateScrollPos = nil

	TaskDispatcher.cancelTask(self._refreshTimeTick, self)
end

function Role_FullSignView:onDestroyView()
	Activity101SignViewBase._internal_onDestroy(self)
	self._simageFullBG:UnLoadImage()
	TaskDispatcher.cancelTask(self._refreshTimeTick, self)
end

function Role_FullSignView:onRefresh()
	self:_refreshList()
	self:_refreshTimeTick()
end

function Role_FullSignView:_refreshTimeTick()
	self._txtLimitTime.text = self:getRemainTimeStr()
end

return Role_FullSignView
