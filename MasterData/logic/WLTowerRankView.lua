-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/waterdraktower/view/WLTowerRankView.lua

module("logic.extensions.waterdraktower.view.WLTowerRankView", package.seeall)

local WLTowerRankView = class("WLTowerRankView", TableViewComponent)

function WLTowerRankView:ctor()
	WLTowerRankView.super.ctor(self)
end

function WLTowerRankView:bindEvents()
	WLTowerRankView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
end

function WLTowerRankView:unbindEvents()
	WLTowerRankView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
end

function WLTowerRankView:onExit()
	WLTowerRankView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.WaterDarkTowerGetRankInfo, self._updataRankListSR, self)
end

function WLTowerRankView:destroyUI()
	WLTowerRankView.super.destroyUI(self)
end

function WLTowerRankView:buildUI()
	WLTowerRankView.super.buildUI(self)

	self._closeBtn = self:getBtn("closeBtn")

	local rankListGo = self:getGo("rankListGo")

	self._emptyGo = goutil.findChild(rankListGo, "emptyGo")

	local myRankGo = goutil.findChild(rankListGo, "myRankGo")

	self._myRankTxt = goutil.findChildTextComponent(myRankGo, "myRankTxt")

	self._emptyGo:SetActive(false)

	self._myRankTxt.text = ""
end

function WLTowerRankView:onEnter()
	WLTowerRankView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.WaterDarkTowerGetRankInfo, self._updataRankListSR, self)
	self:_updataRankListSR({}, 0)
	WaterdraktowerController.instance:csGetWaterDarkTowerGetRankInfoReq()
end

function WLTowerRankView:_updataRankListSR(list, myRank)
	self._curViewDatas = list or {}

	if self._curViewDatas == nil or #self._curViewDatas == 0 then
		self._emptyGo:SetActive(true)
	else
		self._emptyGo:SetActive(false)
	end

	self._myRankTxt.text = checknumber(myRank) <= 0 and lang("text_rank_notrank") or tostring(myRank)

	self._tableview:ReloadData()
end

function WLTowerRankView:_getPath()
	return {
		cellPath = "rankListGo/rankItem",
		viewPath = "rankListGo/rankListSR"
	}
end

function WLTowerRankView:_cellSize()
	return 1140, 108
end

function WLTowerRankView:_updateCell(view, cell, data)
	local rankIma = goutil.findChildComponent(cell, "rankIma", "UIImageSpriteChange")
	local rankTxt = goutil.findChildTextComponent(cell, "rankTxt")
	local headGo = goutil.findChild(cell, "headGo")
	local nameTxt = goutil.findChildTextComponent(cell, "nameTxt")
	local timeTxt = goutil.findChildTextComponent(cell, "timeTxt")
	local tierTxt = goutil.findChildTextComponent(cell, "tierTxt")
	local stageTxt = goutil.findChildTextComponent(cell, "stageTxt")

	MaterialMgr.resetAll(headGo)

	if data.rank > 3 then
		rankIma.gameObject:SetActive(false)

		rankTxt.text = tostring(data.rank)
	else
		rankIma.gameObject:SetActive(true)

		rankTxt.text = ""

		rankIma:SetState(data.rank - 1)
	end

	HeadItemController.instance:setHeadCellByInfo(headGo, data.headInfo)

	nameTxt.text = data.headInfo.userName

	local time = GameUtil.time2date(data.submitTime / 1000)

	timeTxt.text = string.format(lang("text_timeinfo"), time.month, time.day, time.hour, time.min, time.sec)
	tierTxt.text = tostring(data.tier)
	stageTxt.text = tostring(data.stage)
end

return WLTowerRankView
