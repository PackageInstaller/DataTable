-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingway/view/KingWayMissionView.lua

module("logic.extensions.kingway.view.KingWayMissionView", package.seeall)

local KingWayMissionView = class("KingWayMissionView", MissionView)

function KingWayMissionView:ctor()
	KingWayMissionView.super.ctor(self)
end

function KingWayMissionView:onEnter()
	GlobalDispatcher:addListener(KingRoadAgent.PM_ChallengeStageRes, self._onMissionBattleResBack, self)

	self.batId, self.staId = KingWayModel.instance:GetKingBattleAndStageId()
	self.staId = self.staId + 1

	BulletScreenModel.instance:setEnum(GameEnum.BulletScene.Formation)
	BulletScreenModel.instance:setKey(string.format("kl_%s_%s", self.batId, self.staId))
	self:onEnterInherit()
	self:procMid()
end

function KingWayMissionView:procMid()
	local allCfgs = KingWayConfig.instance:GetWayStageCfg(self.batId)

	if allCfgs == nil or allCfgs[self.staId] == nil then
		error("sr_王者之路  KingWayMissionView:procMid()    获取配置空 = " .. self.batId .. self.staId)

		return
	end

	local cfg = allCfgs[self.staId]
	local titleStr = string.format("%s %s_%s", cfg.name, self.batId, self.staId)
	local levelStr = ""
	local ruleDesc

	self:_setDescStr(titleStr, levelStr, string.nilorempty(cfg.description) and "策划没有配置" or cfg.description)
	self:_setTitleName()
	self:_setRedPoint(cfg.redPoint)
end

function KingWayMissionView:_enterBattle()
	BattleSettlementModel.instance:setType(BattleSettlementModel.Enum.KingWay)
	BattleFacade.instance:startKingWay(self.batId, self.staId)
	KingWayController.instance:CSChallengeStageReq(self.batId, self.staId)

	KingWayModel.instance.isOpenKingView = true
end

function KingWayMissionView:onExit()
	KingWayMissionView.super.onExit(self)
	GlobalDispatcher:removeListener(KingRoadAgent.PM_ChallengeStageRes, self._onMissionBattleResBack, self)
end

function KingWayMissionView:_isShowBtnEvaluate()
	return true
end

return KingWayMissionView
