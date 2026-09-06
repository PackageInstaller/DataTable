-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/halloweenguest/view/HalloweenBossRankView.lua

module("logic.extensions.halloweenguest.view.HalloweenBossRankView", package.seeall)

local HalloweenBossRankView = class("HalloweenBossRankView", TableViewComponent)

function HalloweenBossRankView:ctor()
	HalloweenBossRankView.super.ctor(self)
end

function HalloweenBossRankView:bindEvents()
	HalloweenBossRankView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
end

function HalloweenBossRankView:unbindEvents()
	HalloweenBossRankView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
end

function HalloweenBossRankView:onExit()
	HalloweenBossRankView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.HalloweenRankInfo, self._updataRankListSR, self)
end

function HalloweenBossRankView:destroyUI()
	HalloweenBossRankView.super.destroyUI(self)
end

function HalloweenBossRankView:buildUI()
	HalloweenBossRankView.super.buildUI(self)

	self._closeBtn = self:getBtn("closeBtn")

	local rankListGo = self:getGo("rankListGo")

	self._emptyGo = goutil.findChild(rankListGo, "emptyGo")

	local myRankGo = goutil.findChild(rankListGo, "myRankGo")

	self._myRankTxt = goutil.findChildTextComponent(myRankGo, "myRankTxt")

	self._emptyGo:SetActive(false)

	self._myRankTxt.text = ""
end

function HalloweenBossRankView:onEnter()
	HalloweenBossRankView.super.onEnter(self)

	self._planId = self:getFirstParam()

	if checknumber(self._planId) <= 0 then
		self._planId = 1
	end

	GlobalDispatcher:addListener(GlobalNotify.HalloweenRankInfo, self._updataRankListSR, self)
	self:_updataRankListSR({}, 0)
	HalloweenGuestController.instance:csGetHalloweenBossChallengeRankReq()
end

function HalloweenBossRankView:_updataRankListSR(list, myRank)
	self._curViewDatas = list or {}

	if self._curViewDatas == nil or #self._curViewDatas == 0 then
		self._emptyGo:SetActive(true)
	else
		self._emptyGo:SetActive(false)
	end

	self._myRankTxt.text = checknumber(myRank) <= 0 and "未上榜" or tostring(myRank)

	self._tableview:ReloadData()
end

function HalloweenBossRankView:_getPath()
	return {
		cellPath = "rankListGo/rankItem",
		viewPath = "rankListGo/rankListSR"
	}
end

function HalloweenBossRankView:_cellSize()
	return 1140, 108
end

function HalloweenBossRankView:_updateCell(view, cell, data)
	local rankIma = goutil.findChildComponent(cell, "rankIma", "UIImageSpriteChange")
	local rankTxt = goutil.findChildTextComponent(cell, "rankTxt")
	local headGo = goutil.findChild(cell, "headGo")
	local nameTxt = goutil.findChildTextComponent(cell, "nameTxt")
	local familyTxt = goutil.findChildTextComponent(cell, "familyTxt")
	local damageTxt = goutil.findChildTextComponent(cell, "damageTxt")
	local goodsList = {
		goutil.findChild(cell, "goodsGo_1"),
		goutil.findChild(cell, "goodsGo_2"),
		goutil.findChild(cell, "goodsGo_3"),
		goutil.findChild(cell, "goodsGo_4")
	}

	MaterialMgr.resetAll(headGo)

	for i = 1, #goodsList do
		MaterialMgr.resetAll(goodsList[i])
	end

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
	familyTxt.text = string.nilorempty(data.familyName) and "无" or data.familyName
	damageTxt.text = tostring(data.totalDamage)

	local prizeList = HalloweenGuestModel.instance:getBossRankPrizeByRank(self._planId, data.rank)

	if prizeList == nil or #prizeList == 0 then
		return
	end

	for i = 1, #prizeList do
		if not string.nilorempty(prizeList[i]) and goodsList[i] then
			MaterialMgr.setCellByCfg(prizeList[i], goodsList[i])
		end
	end
end

return HalloweenBossRankView
