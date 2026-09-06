-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/waterdraktower/view/WaterdraktowerrankView.lua

module("logic.extensions.waterdraktower.view.WaterdraktowerrankView", package.seeall)

local WaterdraktowerrankView = class("WaterdraktowerrankView", TableViewComponent)
local WRankType = {
	Water = 1,
	Dark = 2
}

function WaterdraktowerrankView:_getPath()
	return {
		cellPath = "right/rankCell",
		viewPath = "right/rankListView"
	}
end

function WaterdraktowerrankView:unbindEvents()
	WaterdraktowerrankView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._btnWater:RemoveClickListener()
	self._btnDark:RemoveClickListener()
end

function WaterdraktowerrankView:bindEvents()
	WaterdraktowerrankView.super.bindEvents(self)
	self._closeButton:AddClickListener(self.close, self)
	self._btnWater:AddClickListener(self._onClickbtnWater, self)
	self._btnDark:AddClickListener(self._onClickbtnDark, self)
end

function WaterdraktowerrankView:onExit()
	WaterdraktowerrankView.super.onExit(self)
	GlobalDispatcher:removeListener(WaterDarkTowerAgent.PM_WaterDarkTowerGetRankInfoRes, self._onRankRes, self)
end

function WaterdraktowerrankView:buildUI()
	WaterdraktowerrankView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self._goEmpty = self:getGo("right/goEmpty")
	self._txtMyRank = self:getTxt("right/myRank/txtMyRank")
	self._txtTip = self:getTxt("right/myRank/txtTip")
	self._txtTip.text = "进度前100名的训练师的试炼榜单，按照试炼进度排序"
	self._btnWater = self:getBtn("btnWater")
	self._btnDark = self:getBtn("btnDark")
	self._btnWaterChange = self._btnWater.gameObject:GetComponent(ComponentType.UIChangeGroup)
	self._btnDarkChange = self._btnDark.gameObject:GetComponent(ComponentType.UIChangeGroup)
end

function WaterdraktowerrankView:onEnter()
	WaterdraktowerrankView.super.onEnter(self)

	self._actId = self:getFirstParam()

	GlobalDispatcher:addListener(WaterDarkTowerAgent.PM_WaterDarkTowerGetRankInfoRes, self._onRankRes, self)
	self:_switchRankType(WRankType.Water, true)
end

function WaterdraktowerrankView:_onClickbtnWater()
	self:_switchRankType(WRankType.Water)
end

function WaterdraktowerrankView:_onClickbtnDark()
	self:_switchRankType(WRankType.Dark)
end

function WaterdraktowerrankView:_onRankRes(status, msg)
	if status == 0 then
		self._curViewDatas = msg.rankInfos or {}

		local myRank = checknumber(msg.myRank)

		self._txtMyRank.text = myRank > 0 and myRank or lang("未上榜")

		self._goEmpty:SetActive(#self._curViewDatas == 0)
		self:reloadData()
	end
end

function WaterdraktowerrankView:_updateCell(view, cell, data)
	local go = cell.gameObject
	local imgRank = goutil.findChildComponent(go, "imgRank", typeof(UIImageSpriteChange))
	local txtRank = goutil.findChildTextComponent(go, "txtRank")
	local imgIcon = goutil.findChild(go, "imgIcon")
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local txtFamily = goutil.findChildTextComponent(go, "txtFamily")
	local txtLevel = goutil.findChildTextComponent(go, "txtLevel")
	local btnHead = goutil.findChild(go, "btnIcon")

	txtName.text = data.headInfo.userName

	HeadItemController.instance:setHeadCellByInfo(imgIcon, data.headInfo)

	txtRank.text = data.rank
	txtFamily.text = not string.nilorempty(data.familyName) and data.familyName or lang("无")

	local rank = checknumber(data.rank)
	local isTop3 = rank <= 3

	imgRank.gameObject:SetActive(isTop3)
	txtRank.gameObject:SetActive(not isTop3)

	if isTop3 then
		imgRank:SetState(rank - 1)
	end

	if data.headInfo.userId then
		GameUtil.addClickHandler(btnHead, GameUtil.handler(self.onHeadClick, self, data.headInfo.userId, btnHead))
	end

	txtLevel.text = langPara("%d层%d关", data.tier, data.stage)
end

function WaterdraktowerrankView:_clearTableview(cell)
	local imgIcon = goutil.findChild(cell.gameObject, "imgIcon")

	MaterialMgr.resetAll(imgIcon)
end

function WaterdraktowerrankView:onHeadClick(userId, imgIcon)
	FriendController.instance:showInfoView(userId, imgIcon)
end

function WaterdraktowerrankView:_switchRankType(rtype, force)
	if self._rankType == rtype and not force then
		return
	end

	self._rankType = rtype

	self._btnWaterChange:SetState(rtype == WRankType.Water and 1 or 0)
	self._btnDarkChange:SetState(rtype == WRankType.Dark and 1 or 0)
	WaterDarkTowerAgent.instance:sendPM_WaterDarkTowerGetRankInfoReq(self._actId, self._rankType)
end

return WaterdraktowerrankView
