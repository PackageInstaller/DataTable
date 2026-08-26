-- chunkname: @modules/logic/activity/view/V1a4_Role_PanelSignView.lua

module("modules.logic.activity.view.V1a4_Role_PanelSignView", package.seeall)

local V1a4_Role_PanelSignView = class("V1a4_Role_PanelSignView", Activity101SignViewBase)

function V1a4_Role_PanelSignView:onInitView()
	self._simagePanelBG = gohelper.findChildSingleImage(self.viewGO, "Root/#simage_PanelBG")
	self._simageTitle = gohelper.findChildSingleImage(self.viewGO, "Root/#simage_Title")
	self._txtTitle = gohelper.findChildText(self.viewGO, "Root/image_LimitTimeBG/#txt_title")
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

function V1a4_Role_PanelSignView:addEvents()
	Activity101SignViewBase.addEvents(self)
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
	self._btnemptyTop:AddClickListener(self._btnemptyTopOnClick, self)
	self._btnemptyBottom:AddClickListener(self._btnemptyBottomOnClick, self)
	self._btnemptyLeft:AddClickListener(self._btnemptyLeftOnClick, self)
	self._btnemptyRight:AddClickListener(self._btnemptyRightOnClick, self)
end

function V1a4_Role_PanelSignView:removeEvents()
	Activity101SignViewBase.removeEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnemptyTop:RemoveClickListener()
	self._btnemptyBottom:RemoveClickListener()
	self._btnemptyLeft:RemoveClickListener()
	self._btnemptyRight:RemoveClickListener()
end

function V1a4_Role_PanelSignView:_btnCloseOnClick()
	self:closeThis()
end

function V1a4_Role_PanelSignView:_btnemptyTopOnClick()
	self:closeThis()
end

function V1a4_Role_PanelSignView:_btnemptyBottomOnClick()
	self:closeThis()
end

function V1a4_Role_PanelSignView:_btnemptyLeftOnClick()
	self:closeThis()
end

function V1a4_Role_PanelSignView:_btnemptyRightOnClick()
	self:closeThis()
end

function V1a4_Role_PanelSignView:onOpen()
	self._txtLimitTime.text = ""

	self:internal_set_actId(self.viewParam.actId)
	self:internal_set_openMode(Activity101SignViewBase.eOpenMode.PaiLian)
	self:internal_onOpen()

	local CO = self:actCO()

	self._txtTitle.text = CO.name

	TaskDispatcher.runRepeat(self._refreshTimeTick, self, 1)
end

function V1a4_Role_PanelSignView:onClose()
	self._isFirst = nil

	TaskDispatcher.cancelTask(self._refreshTimeTick, self)
end

function V1a4_Role_PanelSignView:onDestroyView()
	self._simageTitle:UnLoadImage()
	self._simagePanelBG:UnLoadImage()
	TaskDispatcher.cancelTask(self._refreshTimeTick, self)
end

function V1a4_Role_PanelSignView:onRefresh()
	self:_refreshList()
	self:_updateScrollViewPos()
	self:_refreshTimeTick()
end

function V1a4_Role_PanelSignView:_refreshTimeTick()
	self._txtLimitTime.text = self:getRemainTimeStr()
end

function V1a4_Role_PanelSignView:_updateScrollViewPos()
	if self._isFirst then
		return
	end

	self._isFirst = true

	self:updateRewardCouldGetHorizontalScrollPixel(function(index)
		if index <= 4 then
			return index - 4
		else
			local list = self:getTempDataList()

			return (list or nil) and (#list or index)
		end
	end)
end

function V1a4_Role_PanelSignView:_setPinStartIndex(dataList)
	local _, index = self:getRewardCouldGetIndex()

	index = index <= 4 and 1 or 3

	local scrollModel = self.viewContainer:getScrollModel()

	scrollModel:setStartPinIndex(index)
end

return V1a4_Role_PanelSignView
