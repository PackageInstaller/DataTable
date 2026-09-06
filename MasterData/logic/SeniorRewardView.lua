-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/seniorarena/view/SeniorRewardView.lua

module("logic.extensions.seniorarena.view.SeniorRewardView", package.seeall)

local SeniorRewardView = class("SeniorRewardView", TableViewComponent)

function SeniorRewardView:_getPath()
	return {
		cellPath = "Panel_Rank/tablecell",
		viewPath = "Panel_Rank/tableview"
	}
end

function SeniorRewardView:unbindEvents()
	SeniorRewardView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._btnRule:RemoveClickListener()
	self._btnRank:RemoveClickListener()
end

function SeniorRewardView:bindEvents()
	SeniorRewardView.super.bindEvents(self)
	self._closeButton:AddClickListener(self.close, self)
	self._btnRule:AddClickListener(self._onClickRule, self)
	self._btnRank:AddClickListener(self._onClickRank, self)
end

function SeniorRewardView:buildUI()
	SeniorRewardView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self._btnRule = self:getBtn("btnRule")
	self._btnRank = self:getBtn("btnRank")
	self._panelRule = self:getGo("Panel_Rule")
	self._panelRank = self:getGo("Panel_Rank")

	self:buildPanelRule()

	self._redPoint = goutil.findChild(self._btnRank.gameObject, "imgPoint")
end

function SeniorRewardView:buildPanelRule()
	self._txtRank = goutil.findChildTextComponent(self._panelRule, "txtRank")
	self._txtRanking = goutil.findChildTextComponent(self._panelRule, "txtRanking")
	self._txtScore = goutil.findChildTextComponent(self._panelRule, "txtScore")
	self._txtAddPer = goutil.findChildTextComponent(self._panelRule, "txtAddPer")
	self._items = goutil.findChild(self._panelRule, "items")
end

function SeniorRewardView:onExit()
	SeniorRewardView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.SeniorPrizeReceived, self._updateUI, self)
	GlobalDispatcher:removeListener(GlobalNotify.RedPointUpdate, self._updateRedPoints, self)
end

function SeniorRewardView:onEnter()
	SeniorRewardView.super.onEnter(self)

	self._curIdx = 1

	self:_updateTab()
	SeniorArenaController.instance:reqPrizeInfo(self._updateUI, self)
	GlobalDispatcher:addListener(GlobalNotify.SeniorPrizeReceived, self._updateUI, self)
	GlobalDispatcher:addListener(GlobalNotify.RedPointUpdate, self._updateRedPoints, self)
end

function SeniorRewardView:_updateRedPoints()
	goutil.setActive(self._redPoint, RedPointModel.instance:isActive(73))
end

function SeniorRewardView:_onClickRank()
	self._curIdx = 2

	self:_updateUI()
end

function SeniorRewardView:_onClickRule()
	self._curIdx = 1

	self:_updateUI()
end

function SeniorRewardView:_updateUI()
	self:_updateTab()

	if self._curIdx == 1 then
		self:_updateRule()
	else
		self:_updateRank()
	end

	self:_updateRedPoints()
end

function SeniorRewardView:_updateRule()
	print("update rule")
	self._panelRule:SetActive(true)

	local myRank = SeniorArenaModel.instance:getMyRank()
	local rankCfg = SeniorArenaConfig.instance:getRankCfgByRank(myRank)

	self._txtRanking.text = string.format("当前排名：<color=#0776DEFF>%s</color>", myRank)
	self._txtRank.text = string.format("当前段位：<color=#0776DEFF>%s</color>", rankCfg.rankName)

	local addPerHour = SeniorArenaModel.instance:getAddPerSec() * 3600

	self._txtAddPer.text = string.format("%s/小时", addPerHour)
	self._txtScore.text = string.format("当前分数：<color=#0776DEFF>%s</color>", SeniorArenaModel.instance:getMyScore())

	local matArray = MaterialMgr.changeItemStrArr(rankCfg.dailyPrize)

	GameUtil.updateCells(self._items, matArray, function(go, data)
		MaterialMgr.setCellByCfg(data, go)
	end)
end

function SeniorRewardView:_updateRank()
	self._maxGroupId = SeniorArenaModel.instance:getMaxTopGroupId()

	print("self._maxGroupId = " .. self._maxGroupId)
	self._panelRank:SetActive(true)

	local cfgs = SeniorArenaConfig.instance:getRankCfgList()

	self._curViewDatas = {}

	for _, v in ipairs(cfgs) do
		table.insert(self._curViewDatas, v)
	end

	table.sort(self._curViewDatas, function(a, b)
		local canRecieveA = self:_getCanReceive(a.key)
		local canRecieveB = self:_getCanReceive(b.key)

		if canRecieveA ~= canRecieveB then
			return canRecieveA
		else
			return a.key > b.key
		end
	end)
	self:reloadData()
end

function SeniorRewardView:_getCanReceive(key)
	local received = SeniorArenaModel.instance:getBitGained(key)

	return key >= self._maxGroupId and not received
end

function SeniorRewardView:_updateCell(view, cell, data)
	local go = cell.gameObject
	local txtRank = goutil.findChildTextComponent(go, "txtRank")
	local txtRanking = goutil.findChildTextComponent(go, "txtRanking")
	local items = goutil.findChild(go, "items")
	local btnGet = Framework.ButtonAdapter.GetFrom(go, "btnGet")
	local imgGet = goutil.findChild(go, "Img_Get")

	txtRank.text = data.rankName
	txtRanking.text = data.rankSection

	local matArray = string.split(data.achievePrize, "#")

	GameUtil.updateCells(items, matArray, function(go, str)
		MaterialMgr.setCellByCfg(str, go)
	end)

	local received = SeniorArenaModel.instance:getBitGained(data.key)

	print("received = " .. tostring(received) .. " key = " .. data.key)

	local canRecieve = self._maxGroupId <= data.key

	btnGet.gameObject:SetActive(not received)
	uGuiUtil.setGoGrayState(btnGet.gameObject, not canRecieve)
	imgGet:SetActive(received)
	btnGet:AddClickListener(function()
		self:_onClickGet(data.key, canRecieve)
	end)
end

function SeniorRewardView:_onClickGet(key, canRecieve)
	print("click key = " .. key)

	if not canRecieve then
		FloatWordMgr.instance:show("还不能领取当前奖励")
	else
		SeniorArenaController.instance:reqReceivePrize(key)
	end
end

function SeniorRewardView:_updateTab()
	self:_setBtnSelected(self._btnRule.gameObject, self._curIdx == 1)
	self:_setBtnSelected(self._btnRank.gameObject, self._curIdx == 2)
	self._panelRank:SetActive(false)
	self._panelRule:SetActive(false)
end

function SeniorRewardView:_setBtnSelected(btn, selected)
	local sel = goutil.findChild(btn, "sel")
	local unSel = goutil.findChild(btn, "unSel")
	local graphic = btn:GetComponent(typeof(UnityEngine.UI.Graphic))

	if not goutil.isNil(graphic) then
		graphic.raycastTarget = not selected
	end

	sel:SetActive(selected)
	unSel:SetActive(not selected)
end

return SeniorRewardView
