-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/warriortower/view/WTMissionView.lua

module("logic.extensions.mission.view.WTMissionView", package.seeall)

local WTMissionView = class("WTMissionView", MissionView)

function WTMissionView:ctor()
	WTMissionView.super.ctor(self)
end

function WTMissionView:onEnter()
	GlobalDispatcher:addListener(WarriorTowerAgent.handleFightRes, self._onMissionBattleResBack, self)

	local towerIndex = checknumber(self._viewPresentor._openParam[1])
	local towerId = WTowerModel.instance:getTowerId()

	BulletScreenModel.instance:setEnum(GameEnum.BulletScene.Formation)
	BulletScreenModel.instance:setKey(string.format("wt_%s", towerIndex))
	self:onEnterInherit()

	if WTowerModel.TowerType.Warrior == towerId then
		FastFormation.instance:setGetCurPetList(function()
			local pets = BagPetsController.instance:getFightBagPet() or {}
			local towerId = WTowerModel.instance:getTowerId()

			if towerId == WTowerModel.TowerType.Warrior then
				pets = PetHireModel.instance:appendListByHirePets(pets)
			end

			return pets
		end)
		FastFormation.instance:setCurFormFunc(function()
			return WTowerModel.instance:_getCurFormation()
		end)
	end

	self:procMid()
	self._videoButton.gameObject:SetActive(BattleRecordRankController.instance:isWTowerWithBattleRecord(towerIndex, towerId))
	WTowerModel.instance:setTowerFromFmt(towerId, true)
end

function WTMissionView:onExit()
	WTMissionView.super.onExit(self)
	GlobalDispatcher:removeListener(WarriorTowerAgent.FightRes, self._onMissionBattleResBack, self)
end

function WTMissionView:procMid()
	local towerIndex = checknumber(self._viewPresentor._openParam[1])
	local titleStr = lang("挑战")
	local levelStr = tostring(towerIndex)
	local towerId = WTowerModel.instance:getTowerId()
	local levelCfg = WTowerConfig.instance:getCfgById(towerIndex, towerId)
	local ruleDesc = levelCfg.passDesc

	self:_setDescStr(titleStr, levelStr, ruleDesc)
	self:_setTitleName()
end

function WTMissionView:_setBattleResultTxtTitle()
	local str = string.format("勇者之塔 第%s关", self:_getLevelStr())

	BattleSettlementModel.instance:setTxtTitle(str)

	local towerIndex = checknumber(self._viewPresentor._openParam[1])
	local towerId = WTowerModel.instance:getTowerId()
	local levelCfg = WTowerConfig.instance:getCfgById(towerIndex, towerId)
	local params = {}

	params.fightWinExp = levelCfg.fightWinExp
	params.isFinalLevel = towerIndex >= WTowerConfig.instance:getCfgCount(towerId)

	if BattleRecordRankController.instance:isWTowerWithBattleRecord(towerIndex, towerId) then
		params.videoKey = BattleRecordRankController.instance:getWTowerRankKey(towerId, towerIndex)
	end

	BattleSettlementModel.instance:setType(BattleSettlementModel.Enum.WarriorTower, params)
end

function WTMissionView:_enterBattle()
	local towerId = checknumber(WTowerModel.instance:getTowerId())

	WTowerController.instance:startBattle(towerId)
	BattleFacade.instance:startWTower(checknumber(self._viewPresentor._openParam[1]), towerId)
	UIJumper.instance:pushOneStack(ViewName.warriortower, true)
end

function WTMissionView:_onClickVideo()
	local towerIndex = checknumber(self._viewPresentor._openParam[1])
	local ranKey = BattleRecordRankController.instance:getWTowerRankKey(checknumber(WTowerModel.instance:getTowerId()), towerIndex)

	BattleRecordRankController.instance:enterView2(ranKey)
end

function WTMissionView:_onClickOneKey()
	SurveyController.instance:reportBehavior(SurveyBehaviorID.ClickAutoFormationButton)

	local towerId = WTowerModel.instance:getTowerId()

	if WTowerModel.TowerType.Warrior == towerId then
		FastFormation.instance:setFormation(MissionModel.instance:getForceResetOneKey())
	else
		WTFastFormation.instance:setFormation(MissionModel.instance:getForceResetOneKey())
	end

	MissionModel.instance:setForceResetOneKey(false)
end

function WTMissionView:_onClickClean()
	printInfo("_onClickClean")

	local towerId = WTowerModel.instance:getTowerId()

	if WTowerModel.TowerType.Warrior == towerId then
		FastFormation.instance:clean()
	else
		WTFastFormation.instance:clean()
	end
end

function WTMissionView:_startClg()
	local towerId = WTowerModel.instance:getTowerId()

	if WTowerModel.TowerType.Warrior ~= towerId then
		self:_setMaskBlock(true)
		GlobalDispatcher:addListener(GlobalNotify.FormationRefresh, self._startNow, self)
		WTowerModel.instance:saveCurrFormation()
	else
		WTMissionView.super._startClg(self)
	end
end

function WTMissionView:_onClickStart()
	local towerId = WTowerModel.instance:getTowerId()

	if WTowerModel.TowerType.Warrior == towerId then
		WTMissionView.super._onClickStart(self)
	else
		local hasOneKey = GameUtil.GetActive(self._btnOneKey)

		if WTowerModel.instance:isCurFormationEmpty() then
			if hasOneKey then
				TipsFacade.instance:openPopupWindow(lang("tip"), lang("fight_unformation"), function()
					return
				end, function()
					self:_onClickOneKey()
				end, lang("fight_goto_fmt"), lang("一键布阵"))
			else
				TipsFacade.instance:openPopupWindow(lang("tip"), lang("fight_unformation"), function()
					return
				end, nil, lang("fight_goto_fmt"))
			end

			return
		end

		if self:_checkFormationPosNumber(function()
			self:_startClg()
		end) then
			return
		end

		self:_startClg()
	end
end

function WTMissionView:_checkFormationPosNumber(posLimitCallback)
	local towerId = WTowerModel.instance:getTowerId()

	if WTowerModel.TowerType.Warrior == towerId then
		local mo

		return FormationFacade.instance:checkFormationPosNumber(posLimitCallback, false, nil, (WTowerModel.instance:_getCurFormation()))
	else
		local formation = WTowerModel.instance:getCurFormation()
		local numPos = formation:getCurExistPetNumber()
		local totalPos = 5
		local petsNum = WTowerModel.instance:diffRacePetCount()
		local showNum = -1
		local boo = false

		if totalPos <= petsNum and numPos < totalPos then
			showNum = totalPos
			boo = true
		elseif petsNum < totalPos and petsNum > 0 and numPos < petsNum then
			showNum = petsNum
			boo = true
		end

		if showNum > 0 then
			local hasOneKey = GameUtil.GetActive(self._btnOneKey)

			if hasOneKey then
				TipsFacade.instance:openPopupWindow(lang("tip"), string.format(lang("fight_fmt_num"), tostring(showNum)), posLimitCallback, function()
					self:_onClickOneKey()
				end, lang("确定"), lang("一键布阵"))
			else
				TipsFacade.instance:openPopupWindow(lang("tip"), string.format(lang("fight_fmt_num"), tostring(showNum)), posLimitCallback)
			end
		end

		return boo
	end
end

function WTMissionView:_saveFormationEx()
	PetHireController.instance:sendSetHrieFormByFormId(PetHireModel.ID_TYPE_NORMAL)

	return WTMissionView.super._saveFormationEx(self)
end

function WTMissionView:_getCurFormation()
	return WTowerModel.instance:_getCurFormation()
end

function WTMissionView:_isCurFormationEmpty()
	local formation = WTowerModel.instance:_getCurFormation()

	if not formation then
		return true
	end

	for i = 1, 9 do
		local pos = formation:GetPosition(i)

		if not pos then
			return true
		end

		if pos > 0 then
			return false
		end
	end

	return true
end

function WTMissionView:checkFormationEmptyAndPosNumLimit(callback, hasOneKey, onekeyCallBack)
	local formation = WTowerModel.instance:_getCurFormation()

	return FormationFacade.instance:checkFormationEmptyAndPosNumLimitByFmo(formation, callback, hasOneKey, onekeyCallBack)
end

return WTMissionView
