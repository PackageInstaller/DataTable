-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/lightking/LightKingJiXianView.lua

module("logic.extensions.timelimitedchallenge.view.lightking.LightKingJiXianView", package.seeall)

local LightKingJiXianView = class("LightKingJiXianView", LightKingShengGuangView)

function LightKingJiXianView:unbindEvents()
	LightKingJiXianView.super.unbindEvents(self)
	self._btnRank:RemoveClickListener()
end

function LightKingJiXianView:bindEvents()
	LightKingJiXianView.super.bindEvents(self)
	self._btnRank:AddClickListener(self._onClickRank, self)
end

function LightKingJiXianView:onExit()
	LightKingJiXianView.super.onExit(self)
end

function LightKingJiXianView:buildUI()
	LightKingJiXianView.super.buildUI(self)

	local rank = self:getGo("rank")

	self._btnRank = self:getBtn("rank/btnRank")
	self._empty = goutil.findChild(rank, "empty")
	self._cells = {}

	for i = 1, 3 do
		table.insert(self._cells, goutil.findChild(rank, "cell_" .. i))
	end
end

function LightKingJiXianView:onEnter()
	LightKingJiXianView.super.onEnter(self)
	LightKingChallengeAgent.instance:sendPM_LightKingChallengeGetRanksReq(1, 3, self._onRankInfoRes, self)
end

function LightKingJiXianView:_onRankInfoRes(msg)
	self.curViewDatas = msg.rankInfos or {}

	self:_updateTop3()
end

function LightKingJiXianView:_updateTop3()
	for i = 1, #self.curViewDatas do
		self:_updateOneCell(self._cells[i], self.curViewDatas[i])
	end

	for i = #self.curViewDatas + 1, #self._cells do
		self._cells[i]:SetActive(false)
	end

	self._empty:SetActive(#self.curViewDatas == 0)
end

function LightKingJiXianView:_updateOneCell(go, data)
	go:SetActive(true)

	local head = goutil.findChild(go, "head")
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local txtDesc = goutil.findChildTextComponent(go, "txtTime")

	txtName.text = data.headInfo.userName

	HeadItemController.instance:setHeadCellByInfo(head, data.headInfo)

	local time = GameUtil.time2date(checknumber(data.time) / 1000)

	txtDesc.text = langPara("%d月%d日 %02d:%02d:%02d", time.month, time.day, time.hour, time.min, time.sec)
end

function LightKingJiXianView:_onClickRank()
	UIStateManager.instance:push(ViewName.LightKingRankView)
end

return LightKingJiXianView
