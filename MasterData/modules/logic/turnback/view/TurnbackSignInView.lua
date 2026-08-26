-- chunkname: @modules/logic/turnback/view/TurnbackSignInView.lua

module("modules.logic.turnback.view.TurnbackSignInView", package.seeall)

local TurnbackSignInView = class("TurnbackSignInView", BaseView)

function TurnbackSignInView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._txtdesc = gohelper.findChildText(self.viewGO, "tips/#txt_desc")
	self._txttime = gohelper.findChildText(self.viewGO, "tips/#txt_time")
	self._scrolldaylist = gohelper.findChildScrollRect(self.viewGO, "#scroll_daylist")
	self._gocontent = gohelper.findChild(self.viewGO, "#scroll_daylist/Viewport/#go_content")
	self._rectMask2d = gohelper.findChild(self.viewGO, "#scroll_daylist/Viewport"):GetComponent(typeof(UnityEngine.UI.RectMask2D))
	self._mask = gohelper.findChild(self.viewGO, "#scroll_daylist/Viewport"):GetComponent(typeof(UnityEngine.UI.Mask))
	self._maskImage = gohelper.findChild(self.viewGO, "#scroll_daylist/Viewport"):GetComponent(gohelper.Type_Image)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TurnbackSignInView:addEvents()
	self.addEventCb(self, TurnbackController.instance, TurnbackEvent.RefreshSignInScroll, self._refreshScrollPos, self)
	self.addEventCb(self, TurnbackController.instance, TurnbackEvent.RefreshRemainTime, self._refreshRemainTime, self)
	self.addEventCb(self, TurnbackController.instance, TurnbackEvent.RefreshView, self._refreshUI, self)
	self._scrolldaylist:AddOnValueChanged(self._onScrollValueChange, self)
end

function TurnbackSignInView:removeEvents()
	self.removeEventCb(self, TurnbackController.instance, TurnbackEvent.RefreshSignInScroll, self._refreshScrollPos, self)
	self.removeEventCb(self, TurnbackController.instance, TurnbackEvent.RefreshRemainTime, self._refreshRemainTime, self)
	self.removeEventCb(self, TurnbackController.instance, TurnbackEvent.RefreshView, self._refreshUI, self)
	self._scrolldaylist:RemoveOnValueChanged()
end

function TurnbackSignInView:_editableInitView()
	self._simagebg:LoadImage(ResUrl.getTurnbackIcon("turnback_signfullbg"))
end

function TurnbackSignInView:onOpen()
	local parentGO = self.viewParam.parent

	self.viewConfig = TurnbackConfig.instance:getTurnbackSubModuleCo(self.viewParam.actId)

	gohelper.addChild(parentGO, self.viewGO)
	self:_refreshUI()
	TurnbackSignInModel.instance:setOpenTimeStamp()
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Task_page)
end

function TurnbackSignInView:_refreshUI()
	self._txtdesc.text = self.viewConfig.actDesc

	self:_refreshRemainTime()
	self:_refreshScrollPos()
	self:_refreshMaskShowState()
end

function TurnbackSignInView:_refreshRemainTime()
	self._txttime.text = TurnbackController.instance:refreshRemainTime()
end

function TurnbackSignInView:_refreshScrollPos()
	local cangetIndex = TurnbackSignInModel.instance:getTheFirstCanGetIndex()
	local curSignInDay = TurnbackModel.instance:getCurSignInDay()
	local totalCount = GameUtil.getTabLen(TurnbackSignInModel.instance:getSignInInfoMoList())
	local csListView = self.viewContainer._scrollView:getCsListScroll()
	local listScrollParam = self.viewContainer._scrollParam
	local cellWidth = listScrollParam.cellWidth
	local cellSpaceH = listScrollParam.cellSpaceH
	local offset = 0
	local itemInViewCount = 7
	local finalPassIndex = totalCount - itemInViewCount
	local totalCellWidth = cellWidth + cellSpaceH

	offset = cangetIndex ~= 0 and (finalPassIndex < cangetIndex - 1 and totalCellWidth * (finalPassIndex + 1) or totalCellWidth * math.max(0, cangetIndex - 2)) or finalPassIndex < curSignInDay and totalCellWidth * (finalPassIndex + 1) or totalCellWidth * (curSignInDay - 1)
	csListView.HorizontalScrollPixel = math.max(0, offset)

	csListView:UpdateCells(true)
end

function TurnbackSignInView:_onScrollValueChange()
	self._rectMask2d.enabled = self._scrolldaylist.horizontalNormalizedPosition < 0.95
end

function TurnbackSignInView:_refreshMaskShowState()
	local scrollWidth = recthelper.getWidth(self._scrolldaylist.gameObject.transform)
	local contentWidth = recthelper.getWidth(self._gocontent.transform)
	local showState = scrollWidth < contentWidth

	self._rectMask2d.enabled = showState
	self._mask.enabled = showState
	self._maskImage.enabled = showState
end

function TurnbackSignInView:onClose()
	self._simagebg:UnLoadImage()
end

function TurnbackSignInView:onDestroyView()
	return
end

return TurnbackSignInView
