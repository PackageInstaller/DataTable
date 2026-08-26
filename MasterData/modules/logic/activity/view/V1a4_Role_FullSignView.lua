-- chunkname: @modules/logic/activity/view/V1a4_Role_FullSignView.lua

module("modules.logic.activity.view.V1a4_Role_FullSignView", package.seeall)

local V1a4_Role_FullSignView = class("V1a4_Role_FullSignView", Activity101SignViewBase)

function V1a4_Role_FullSignView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._simageTitle = gohelper.findChildSingleImage(self.viewGO, "Root/#simage_Title")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Root/LimitTime/image_LimitTimeBG/#txt_LimitTime")
	self._scrollItemList = gohelper.findChildScrollRect(self.viewGO, "Root/#scroll_ItemList")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V1a4_Role_FullSignView:addEvents()
	Activity101SignViewBase.addEvents(self)
end

function V1a4_Role_FullSignView:removeEvents()
	Activity101SignViewBase.removeEvents(self)
end

function V1a4_Role_FullSignView:onOpen()
	self._txtLimitTime.text = ""

	self:internal_set_openMode(Activity101SignViewBase.eOpenMode.MainActivityCenterView)
	self:internal_onOpen()
	TaskDispatcher.runRepeat(self._refreshTimeTick, self, 1)
end

function V1a4_Role_FullSignView:_updateScrollViewPos()
	if self._isFirstUpdateScrollPos then
		return
	end

	self._isFirstUpdateScrollPos = true

	self:updateRewardCouldGetHorizontalScrollPixel(function(index)
		if index <= 4 then
			return index - 4
		else
			local list = self:getTempDataList()

			return (list or nil) and (#list or index)
		end
	end)
end

function V1a4_Role_FullSignView:onClose()
	self._isFirstUpdateScrollPos = nil

	TaskDispatcher.cancelTask(self._refreshTimeTick, self)
end

function V1a4_Role_FullSignView:onDestroyView()
	self._simageTitle:UnLoadImage()
	self._simageFullBG:UnLoadImage()
	TaskDispatcher.cancelTask(self._refreshTimeTick, self)
end

function V1a4_Role_FullSignView:onRefresh()
	self:_refreshList()
	self:_updateScrollViewPos()
	self:_refreshTimeTick()
end

function V1a4_Role_FullSignView:_refreshTimeTick()
	self._txtLimitTime.text = self:getRemainTimeStr()
end

function V1a4_Role_FullSignView:_setPinStartIndex(dataList)
	local _, index = self:getRewardCouldGetIndex()

	index = index <= 4 and 1 or 3

	local scrollModel = self.viewContainer:getScrollModel()

	scrollModel:setStartPinIndex(index)
end

return V1a4_Role_FullSignView
