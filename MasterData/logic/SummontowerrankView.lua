-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summontower/view/SummontowerrankView.lua

module("logic.extensions.handbook.view.SummontowerrankView", package.seeall)

local SummontowerrankView = class("SummontowerrankView", TableViewComponent)

function SummontowerrankView:_getPath()
	return {
		cellPath = "right/cell",
		viewPath = "right/rankScrollRect"
	}
end

function SummontowerrankView:unbindEvents()
	SummontowerrankView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
end

function SummontowerrankView:bindEvents()
	SummontowerrankView.super.bindEvents(self)
	self._closeButton:AddClickListener(self.close, self)
end

function SummontowerrankView:onExit()
	SummontowerrankView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.OnSommonTowerRankInfo, self.onRefreshUI, self)
end

function SummontowerrankView:buildUI()
	SummontowerrankView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self._txtTitle = self:getTxt("title/txtTitle")
	self._goEmpty = self:getGo("right/goEmpty")
	self._txtMyRank = self:getTxt("right/myRank/txtMyRank")
	self._txtTip = self:getTxt("right/myRank/txtTip")
	self._txtSubTitle = self:getTxt("right/subTitle/txtTime")
end

function SummontowerrankView:onEnter()
	SummontowerrankView.super.onEnter(self)

	self._txtTip.text = SummontowerConfig.instance:getParamsString("MYRANK_DESC_TIPS")

	GlobalDispatcher:addListener(GlobalNotify.OnSommonTowerRankInfo, self.onRefreshUI, self)
	SummontowerController.instance:requestRankInfo()
	self:onRefreshUI()
end

function SummontowerrankView:onRefreshUI()
	local info = {}
	local currActivityId = SummontowerController.instance:getActivityId()

	if currActivityId > 0 then
		info = SummontowerModel.instance:getRankInfo(currActivityId)
	end

	self._curViewDatas = info.rankList or {}

	local myRank = checknumber(info.myRank)

	self._txtMyRank.text = myRank > 0 and myRank or lang("world_Boss_tip9")

	self._goEmpty:SetActive(#self._curViewDatas == 0)
	self:reloadData()
end

function SummontowerrankView:_updateCell(view, cell, data)
	local go = cell.gameObject
	local imgRank = goutil.findChildComponent(go, "imgRank", typeof(UIImageSpriteChange))
	local txtRank = goutil.findChildTextComponent(go, "txtRank")
	local imgIcon = goutil.findChild(go, "imgHeadIcon")
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local txtStage = goutil.findChildTextComponent(go, "txtStage")
	local txtScore = goutil.findChildTextComponent(go, "txtScore")
	local txtArea = goutil.findChildTextComponent(go, "txtArea")
	local btnHead = goutil.findChild(go, "btnHead")

	txtName.text = data.headInfo.userName

	HeadItemController.instance:setHeadCellByInfo(imgIcon, data.headInfo)

	txtRank.text = data.rank

	local rank = checknumber(data.rank)
	local isTop3 = rank <= 3

	imgRank.gameObject:SetActive(isTop3)
	txtRank.gameObject:SetActive(not isTop3)

	if isTop3 then
		imgRank:SetState(rank - 1)
	end

	txtStage.text = data.maxStage
	txtScore.text = data.totalScore
	txtArea.text = data.areaName
end

function SummontowerrankView:_clearTableview(cell)
	local imgIcon = goutil.findChild(cell.gameObject, "imgHeadIcon")

	HeadItemController:resetHeadCell(imgIcon)
end

return SummontowerrankView
