-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/niannianchall/view/NianNianChallResultView.lua

module("logic.extensions.niannianchall.view.NianNianChallResultView", package.seeall)

local NianNianChallResultView = class("NianNianChallResultView", TLCBattleResultView)

function NianNianChallResultView:unbindEvents()
	NianNianChallResultView.super.unbindEvents(self)
	self._btnOk:RemoveClickListener()
	self._btnCancel:RemoveClickListener()
end

function NianNianChallResultView:bindEvents()
	NianNianChallResultView.super.bindEvents(self)
	self._btnOk:AddClickListener(self._onClickOk, self)
	self._btnCancel:AddClickListener(self._onClickOk, self)
end

function NianNianChallResultView:buildUI()
	self._txtTitle = self:getTxt("txtTitle")
	self._btnOk = self:getBtn("btnGroup/btnOk")
	self._btnCancel = self:getBtn("btnGroup/btnCancel")
	self._btnReGame = self:getBtn("btnGroup/btnReGame")
	self._txtOk = goutil.findChildTextComponent(self._btnOk.gameObject, "Text")
	self._txtCancel = goutil.findChildTextComponent(self._btnCancel.gameObject, "Text")
	self._txtWin = self:getTxt("win/Text")
	self._winTrue = self:getGo("win/true")
	self._winFalse = self:getGo("win/false")
	self._txtPerfect = self:getTxt("perfectWin/Text")
	self._perfectTrue = self:getGo("perfectWin/true")
	self._perfectFalse = self:getGo("perfectWin/false")
	self._failure = self:getGo("failure")
	self._txtTips = self:getTxt("txtTips")
	self._rewards = self:getGo("rewards")
	self._itemsView = self:getGo("rewards/itemsView/Viewport/Content").transform
	self._itemsLayout = self:getGo("rewards/itemsView/Viewport/Content/items"):GetComponent(typeof(UILayoutMulLines))
end

function NianNianChallResultView:onEnter()
	self._cells = {}

	local win1 = true
	local enemyUnits = BattleModel.instance:getEnemyUnits()

	for i, v in pairs(enemyUnits) do
		if not v:isDead() and v.attrs:getCurHp() ~= 0 then
			win1 = false
		end
	end

	local win2 = false
	local units = BattleModel.instance:getUnits()
	local raceId = checknumber(NianNianChallConfig.instance:getCommonCfg("RANK_PET_RACE_ID"))

	for i, v in pairs(units) do
		if v.attrs:getOriginRaceId() == raceId then
			win2 = not v:isDead() and v.attrs:getCurHp() ~= 0
		end
	end

	local allWin = win1 and win2

	self._failure:SetActive(not allWin)
	self._rewards:SetActive(allWin)
	self._winTrue:SetActive(win1)
	self._winFalse:SetActive(not win1)
	self._perfectTrue:SetActive(win2)
	self._perfectFalse:SetActive(not win2)

	local stageId = NianNianChallModel.instance:getStageId()

	if not allWin then
		stageId = stageId + 1
	end

	local stageCfg = NianNianChallConfig.instance:getStageCfg(stageId)

	self._txtPerfect.text = stageCfg.missionDesc
	self._txtTips.text = ""

	self._btnCancel.gameObject:SetActive(not allWin)
	self._btnOk.gameObject:SetActive(allWin)
	self._btnReGame.gameObject:SetActive(false)

	if not allWin then
		self._txtTitle.text = "战斗失败"
	else
		self._txtTitle.text = "战斗胜利"

		local items = {}
		local rewardList = BattleSettlementModel.instance:getRewardList()

		for _, v in ipairs(rewardList) do
			table.insert(items, v.item)
		end

		self:_updateRewards(items)
	end

	self._isWin = allWin
	self._isPerfectWin = win2
end

function NianNianChallResultView:onExit()
	NianNianChallResultView.super.onExit(self)
end

function NianNianChallResultView:_onClickOk()
	BattleController.instance:endBattle()
end

return NianNianChallResultView
