-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battlesettlement/view/familyhouding/FamilyHoudingClgSettlementSuccessView.lua

module("logic.extensions.battlesettlement.view.familyhouding.FamilyHoudingClgSettlementSuccessView", package.seeall)

local FamilyHoudingClgSettlementSuccessView = class("FamilyHoudingClgSettlementSuccessView", BattleSettlementBaseView)

function FamilyHoudingClgSettlementSuccessView:ctor()
	FamilyHoudingClgSettlementSuccessView.super.ctor(self)
end

function FamilyHoudingClgSettlementSuccessView:buildUI()
	self:_buildUIOfNew()

	self._settlementBossDmage = SettlementBossDmage.New()

	self._settlementBossDmage:buildUI(self:getGo("part2/right/bossDmage"))

	self._settlementBossReward = SettlementBossReward.New()

	self._settlementBossReward:buildUI(self:getGo("part2/right/bossReward"))
	table.insert(self._settlementList, self._settlementBossDmage)
	table.insert(self._settlementList, self._settlementBossReward)

	self._isSuccess = true
end

function FamilyHoudingClgSettlementSuccessView:destroyUI()
	FamilyHoudingClgSettlementSuccessView.super.destroyUI(self)

	self._settlementBossDmage = nil
	self._settlementBossReward = nil
end

function FamilyHoudingClgSettlementSuccessView:onEnter()
	FamilyHoudingClgSettlementSuccessView.super.onEnter(self)
end

function FamilyHoudingClgSettlementSuccessView:onExit()
	FamilyHoudingClgSettlementSuccessView.super.onExit(self)
end

function FamilyHoudingClgSettlementSuccessView:customSettlementInfo()
	local enumType = BattleSettlementModel.instance:getType()

	if enumType == BattleSettlementModel.Enum.FamilyHoudingClg then
		self:_onEnumFamilyHoudingClg()
	else
		printError("挑战 enumType 错误, 请联系开发")
	end
end

function FamilyHoudingClgSettlementSuccessView:_onEnumFamilyHoudingClg()
	local params = BattleSettlementModel.instance:getParams()
	local bossDmageParams = params.bossDmageParams
	local bossRewardParams = params.bossRewardParams

	self:enqueueQueue(self._settlementBossDmage, bossDmageParams)
	self:enqueueQueue(self._settlementBossReward, bossRewardParams)
	self:_doOnEnter()

	self._totalTimeForClickEnd = self._delayTime + 1

	self:_delayOnBtnClose()
end

function FamilyHoudingClgSettlementSuccessView:getAudioId()
	return 30201
end

return FamilyHoudingClgSettlementSuccessView
