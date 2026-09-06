-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originasheclg/view/OriginAsheClgResultView.lua

module("logic.extensions.originasheclg.view.OriginAsheClgResultView", package.seeall)

local OriginAsheClgResultView = class("OriginAsheClgResultView", ViewComponent)

function OriginAsheClgResultView:ctor()
	OriginAsheClgResultView.super.ctor(self)
end

function OriginAsheClgResultView:unbindEvents()
	OriginAsheClgResultView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.rmClickHandler(self._btnClose)
end

function OriginAsheClgResultView:bindEvents()
	OriginAsheClgResultView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
	GameUtil.addClickHandler(self._btnClose, self._onClickSure, self)
end

function OriginAsheClgResultView:buildUI()
	OriginAsheClgResultView.super.buildUI(self)

	self._txtResult = self:getTxt("txtResult")
	self._txtResultNum = self:getTxt("txtResultNum")
	self._btnSure = self:getGo("btnSure")
	self._btnClose = self:getGo("btnClose")
	self._enemyFormation = self:getGo("enemyFormation")

	local enemyTeamGo = self:getGo("enemyFormation/teamEnemy")

	self._enemyPetList = {}

	for i = 1, 9 do
		local go = goutil.findChild(enemyTeamGo, "cell_" .. i)

		self._enemyPetList[i] = {
			go = go,
			con = goutil.findChild(go, "icon"),
			txtHpRate = goutil.findChildTextComponent(go, "hp/txt"),
			deadTag = goutil.findChild(go, "deadTag")
		}
	end

	self._txtTitle = self:getTxt("txtTitle")
end

function OriginAsheClgResultView:onExit()
	OriginAsheClgResultView.super.onExit(self)
end

function OriginAsheClgResultView:onEnter()
	OriginAsheClgResultView.super.onEnter(self)

	local params = self:getOpenParam()

	self._activityId = checknumber(params[1])
	self._stageId = checknumber(params[2])
	self._battleIndex = checknumber(params[3])
	self._isPass = checkbool(params[4])

	self:_refreshView()
end

function OriginAsheClgResultView:_refreshView()
	self._txtTitle.text = self._isPass == true and lang("挑战胜利") or lang("挑战失败")

	local curStageCfg = OriginAsheClgConfig.instance:getStageCfg(self._activityId, self._stageId)
	local winDesc = curStageCfg.winDesc[self._battleIndex]
	local conditionType = BattleModel.instance:getConditionType()
	local needNum, curNum = self:getConditionResult(conditionType)

	if self._isPass then
		if not SettlementTarget.Colors.Sucess then
			local color = SettlementTarget.Colors.Fail

			self._txtResult.text = winDesc
			self._txtResultNum.text = string.format("(<color=#%s>%d</color>/%d)", color, checknumber(curNum), checknumber(needNum))

			self:_refreshEnemyFormation()
		end
	end
end

function OriginAsheClgResultView:_refreshEnemyFormation()
	for i = 1, 9 do
		MaterialMgr.resetAll(self._enemyPetList[i].con)
		GameUtil.SetActive(self._enemyPetList[i].go, false)
	end

	local curStageCfg = OriginAsheClgConfig.instance:getStageCfg(self._activityId, self._stageId)
	local enemyCreepCfg = OriginAsheClgConfig.instance:getCreepsCfg(curStageCfg.creepsMasterId)
	local stageInfo = OriginAsheClgModel.instance:getStageInfo(self._activityId, self._stageId)
	local hpMap = {}

	if OriginAsheClgModel.instance:getTempHpList() then
		for i, v in ipairs(OriginAsheClgModel.instance:getTempHpList()) do
			hpMap[v.left] = v.right
		end
	end

	for i, v in ipairs(enemyCreepCfg) do
		if self._enemyPetList[v.posId] then
			local posCell = self._enemyPetList[v.posId]

			GameUtil.setLocalScale(posCell.con, 0.8, 0.8, 0.8)

			local proxy = MaterialMgr.setCell(MatType.Pet, v.raceId, posCell.con)

			if proxy then
				proxy.binder:setAutoTips(false)
			end

			GameUtil.SetActive(posCell.go, true)

			if hpMap[v.creepsId] then
				posCell.txtHpRate.text = string.format("%.0f%%", math.ceil(hpMap[v.creepsId] / 100))

				GameUtil.SetActive(posCell.deadTag, hpMap[v.creepsId] <= 0)
			elseif not stageInfo or checknumber(stageInfo.info.passBattleSeq) <= 0 or not hpMap[v.creepsId] then
				posCell.txtHpRate.text = string.format("%d%%", 100)

				GameUtil.SetActive(posCell.deadTag, false)
			else
				posCell.txtHpRate.text = string.format("%.0f%%", math.ceil(hpMap[v.creepsId] / 100))

				GameUtil.SetActive(posCell.deadTag, hpMap[v.creepsId] <= 0)
			end
		end
	end
end

function OriginAsheClgResultView:_onClickSure()
	BattleController.instance:endBattle()
end

function OriginAsheClgResultView:getConditionResult(conditionType)
	local needNum, curNum = 0, 0
	local conditionParams = BattleModel.instance:getConditionParams()

	if conditionType == GameEnum.Evaluate.Combination then
		local jConditionParams = GameUtil.jsonToTable(conditionParams)

		for id, singleConditionParam in pairs(jConditionParams) do
			local cfgWinnerOp = BattleSettlementConfig.instance:getBattleWinnerOpCfgById(checknumber(id))

			if cfgWinnerOp then
				local cfg = BattleSettlementConfig.instance:getBattleWinnerOpTypeCfgByType(cfgWinnerOp.type)
				local singlejConditionParams = GameUtil.jsonToTable(singleConditionParam)

				curNum = 0

				if cfg.paramNames and cfg.paramNames[1] and singlejConditionParams and singlejConditionParams[cfg.paramNames[1]] then
					curNum = singlejConditionParams[cfg.paramNames[1]]
				end

				needNum = cfgWinnerOp.params

				break
			end
		end
	else
		local conditionTypeParams = BattleModel.instance:getConditionTypeParams()
		local cfg = BattleSettlementConfig.instance:getBattleWinnerOpTypeCfgByType(conditionType)
		local jConditionParams = GameUtil.jsonToTable(conditionParams)

		curNum = 0

		if cfg.paramNames and cfg.paramNames[1] and jConditionParams and jConditionParams[cfg.paramNames[1]] then
			curNum = jConditionParams[cfg.paramNames[1]]
		end

		needNum = conditionTypeParams
	end

	return needNum, curNum
end

return OriginAsheClgResultView
