-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newfamily/view/war/FamilyWarReportView.lua

module("logic.extensions.newfamily.view.war.FamilyWarReportView", package.seeall)

local FamilyWarReportView = class("FamilyWarReportView", TableViewComponent)

function FamilyWarReportView:ctor()
	FamilyWarReportView.super.ctor(self)

	self._curViewDatas = nil
end

function FamilyWarReportView:bindEvents()
	FamilyWarReportView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
end

function FamilyWarReportView:unbindEvents()
	FamilyWarReportView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
end

function FamilyWarReportView:onExit()
	FamilyWarReportView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdataFamilyWarReportInfo, self._updataViewRankShow, self)
end

function FamilyWarReportView:destroyUI()
	FamilyWarReportView.super.destroyUI(self)

	self._curViewDatas = nil
end

function FamilyWarReportView:buildUI()
	FamilyWarReportView.super.buildUI(self)

	self._closeBtn = self:getBtn("closeBtn")
	self._emptyGo = self:getGo("emptyGo")

	GameUtil.SetActive(self._emptyGo, false)
end

function FamilyWarReportView:onEnter()
	FamilyWarReportView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.UpdataFamilyWarReportInfo, self._updataViewRankShow, self)
	self:_updataViewRankShow({})
	FamilyWarController.instance:csRequestFamilyBattleGetReportInfoReq()
end

function FamilyWarReportView:_updataViewRankShow(list)
	self._curViewDatas = list or {}

	if self._curViewDatas == nil or #self._curViewDatas == 0 then
		GameUtil.SetActive(self._emptyGo, true)
	else
		GameUtil.SetActive(self._emptyGo, false)
	end

	self._tableview:ReloadData()
end

function FamilyWarReportView:_getPath()
	return {
		cellPath = "newsItem",
		viewPath = "newsListSR"
	}
end

function FamilyWarReportView:_cellSize()
	return 890, 100
end

function FamilyWarReportView:_updateCell(view, cell, data)
	local tagIma = goutil.findChild(cell, "tagIma"):GetComponent("UIImageSpriteChange")
	local lHeadGo = goutil.findChild(cell, "lHeadGo")
	local lNameTxt = goutil.findChildTextComponent(cell, "lNameTxt")
	local lFamilyTxt = goutil.findChildTextComponent(cell, "lFamilyTxt")
	local rHeadGo = goutil.findChild(cell, "rHeadGo")
	local rNameTxt = goutil.findChildTextComponent(cell, "rNameTxt")
	local rFamilyTxt = goutil.findChildTextComponent(cell, "rFamilyTxt")
	local timeTxt = goutil.findChildTextComponent(cell, "timeTxt")

	MaterialMgr.resetAll(lHeadGo)
	MaterialMgr.resetAll(rHeadGo)

	if data.isWin then
		tagIma:SetState(0)
	else
		tagIma:SetState(1)
	end

	HeadItemController.instance:setHeadCellByInfo(lHeadGo, data.casterHeadInfo)
	HeadItemController.instance:setHeadCellByInfo(rHeadGo, data.targetHeadInfo)

	lNameTxt.text = data.casterHeadInfo.userName
	rNameTxt.text = data.targetHeadInfo.userName
	lFamilyTxt.text = data.casterFamilyName
	rFamilyTxt.text = data.targetFamilyName
	timeTxt.text = GameUtil.formatTimeStamp("%m月%d日 %H:%M", data.time / 1000)
end

function FamilyWarReportView:_clearTableview(cell)
	local lHeadGo = goutil.findChild(cell, "lHeadGo")
	local rHeadGo = goutil.findChild(cell, "rHeadGo")

	HeadItemController.instance:resetHeadCell(lHeadGo)
	HeadItemController.instance:resetHeadCell(rHeadGo)
end

return FamilyWarReportView
