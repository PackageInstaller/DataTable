-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/numberbomb/view/NumberRankView.lua

module("logic.extensions.numberbomb.view.NumberRankView", package.seeall)

local NumberRankView = class("NumberRankView", TableViewComponent)

function NumberRankView:ctor()
	NumberRankView.super.ctor(self)
end

function NumberRankView:bindEvents()
	NumberRankView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
end

function NumberRankView:unbindEvents()
	NumberRankView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
end

function NumberRankView:onExit()
	NumberRankView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdataGameRankList, self._updataRankListSR, self)
end

function NumberRankView:destroyUI()
	NumberRankView.super.destroyUI(self)
end

function NumberRankView:buildUI()
	NumberRankView.super.buildUI(self)

	self._closeBtn = self:getBtn("closeBtn")

	local rankListGo = self:getGo("rankListGo")

	self._emptyGo = goutil.findChild(rankListGo, "emptyGo")

	local myRankGo = goutil.findChild(rankListGo, "myRankGo")

	self._myRankTxt = goutil.findChildTextComponent(myRankGo, "myRankTxt")

	self._emptyGo:SetActive(false)

	self._myRankTxt.text = ""
end

function NumberRankView:onEnter()
	NumberRankView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.UpdataGameRankList, self._updataRankListSR, self)
	self:_updataRankListSR()
	NumberGameController.instance:csGetGameRankListReq()
end

function NumberRankView:_updataRankListSR()
	self._curViewDatas, self._myRank = NumberGameModel.instance:getGameRankList()

	if self._curViewDatas == nil or #self._curViewDatas == 0 then
		self._emptyGo:SetActive(true)
	else
		self._emptyGo:SetActive(false)
	end

	self._myRankTxt.text = checknumber(self._myRank) <= 0 and "未上榜" or tostring(self._myRank)

	self._tableview:ReloadData()
end

function NumberRankView:_getPath()
	return {
		cellPath = "rankListGo/rankItem",
		viewPath = "rankListGo/rankListSR"
	}
end

function NumberRankView:_cellSize()
	return 1140, 108
end

function NumberRankView:_updateCell(view, cell, data)
	local rankIma = goutil.findChildComponent(cell, "rankIma", "UIImageSpriteChange")
	local rankTxt = goutil.findChildTextComponent(cell, "rankTxt")
	local headGo = goutil.findChild(cell, "headGo")
	local nameTxt = goutil.findChildTextComponent(cell, "nameTxt")
	local familyTxt = goutil.findChildTextComponent(cell, "familyTxt")
	local scoreTxt = goutil.findChildTextComponent(cell, "scoreTxt")
	local areaTxt = goutil.findChildTextComponent(cell, "areaTxt")

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
	familyTxt.text = data.familyName
	scoreTxt.text = tostring(data.score)
	areaTxt.text = data.areaName
end

return NumberRankView
