-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originpowersclg/view/OriginPowersClgExtResultView.lua

module("logic.extensions.originpowersclg.view.OriginPowersClgExtResultView", package.seeall)

local OriginPowersClgExtResultView = class("OriginPowersClgExtResultView", ViewComponent)

function OriginPowersClgExtResultView:ctor()
	OriginPowersClgExtResultView.super.ctor(self)
end

function OriginPowersClgExtResultView:unbindEvents()
	OriginPowersClgExtResultView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
end

function OriginPowersClgExtResultView:bindEvents()
	OriginPowersClgExtResultView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
end

function OriginPowersClgExtResultView:buildUI()
	OriginPowersClgExtResultView.super.buildUI(self)

	self._tableView = self:getGo("tableView")
	self._tableCell = self:getGo("tableCell")
	self._tableList = ScrollerList.create(self._tableView, self._tableCell, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))

	self._tableList:setCenterMode(true)

	self._emptyGo = self:getGo("empty")
	self._btnSure = self:getGo("btnSure")
	self._imgChangeResult1 = self:getGo("imgResult1"):GetComponent(ComponentType.UIImageSpriteChange)
	self._imgChangeResult2 = self:getGo("imgResult2"):GetComponent(ComponentType.UIImageSpriteChange)
	self._txtCondition_1 = self:getTxt("txtCondition_1")
	self._txtCondition_2 = self:getTxt("txtCondition_2")
	self._txtTitle = self:getTxt("txtTitle")
end

function OriginPowersClgExtResultView:onExit()
	OriginPowersClgExtResultView.super.onExit(self)
end

function OriginPowersClgExtResultView:onEnter()
	OriginPowersClgExtResultView.super.onEnter(self)

	local resultInfo = OriginPowersClgModel.instance:getTempBattleResult()
	local enemys = BattleModel.instance:getEnemyUnits()
	local totalNum = 0
	local curNum = 0

	for k, v in pairs(enemys) do
		if not v.attrs:isFakePet() then
			totalNum = totalNum + 1

			if v.attrs:getCurHp() <= 0 then
				curNum = curNum + 1
			end
		end
	end

	local isKillReach = totalNum <= curNum

	if isKillReach == true then
		self._imgChangeResult1:SetState(0)

		self._txtCondition_1.text = langPara("击败敌阵所有敌人(<color=#1CFF5FFF>%d</color>/%d)", curNum, totalNum)
	else
		self._imgChangeResult1:SetState(1)

		self._txtCondition_1.text = langPara("击败敌阵所有敌人(<color=#FF1C21FF>%d</color>/%d)", curNum, totalNum)
	end

	local stageCfg = OriginPowersClgConfig.instance:getExtremeStageCfg(resultInfo.activityId, resultInfo.stageId)
	local isScoreReach = stageCfg.buffNum <= resultInfo.buffNum

	if isScoreReach == true then
		self._imgChangeResult2:SetState(0)

		self._txtCondition_2.text = langPara("克制击杀数量≥%d(<color=#1CFF5FFF>%d</color>/%d)", stageCfg.buffNum, resultInfo.buffNum, stageCfg.buffNum)
	else
		self._imgChangeResult2:SetState(1)

		self._txtCondition_2.text = langPara("克制击杀数量≥%d(<color=#FF1C21FF>%d</color>/%d)", stageCfg.buffNum, resultInfo.buffNum, stageCfg.buffNum)
	end

	self._txtTitle.text = resultInfo.isWin and lang("挑战成功") or lang("挑战失败")

	if not resultInfo.lockPetRaceIds then
		local petList = {}

		GameUtil.SetActive(self._emptyGo, #petList <= 0)
		self._tableList:reloadData(petList)
	end
end

function OriginPowersClgExtResultView:_updatePetCell(view, cell, data, tag)
	local go = cell.gameObject

	MaterialMgr.setCell(MatType.Pet, data, go)
end

function OriginPowersClgExtResultView:_clearPetCell(cell)
	local go = cell.gameObject

	MaterialMgr.resetAll(go)
end

function OriginPowersClgExtResultView:_onClickSure()
	OriginPowersClgModel.instance:resestBattleResult()
	BattleController.instance:endBattle()
end

return OriginPowersClgExtResultView
