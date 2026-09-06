-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/battle/skills/hurts/evts/HurtEvtBtlEnergyChange.lua

module("logicscene.scene.battle.skills.hurts.evts.HurtEvtBtlEnergyChange", package.seeall)

local HurtEvtBtlEnergyChange = class("HurtEvtBtlEnergyChange", HurtEvtBase)

function HurtEvtBtlEnergyChange:getEvtType()
	return HurtEvtType.BtlItemEnergyChange
end

function HurtEvtBtlEnergyChange:handleEvt(hurtData)
	if self.playerTeam == BattleModel.instance.myTeamId then
		BattleItemsModel.instance:updateBattleItemEnergy(self.newBtlItemEnergy, hurtData.allUnits)
	end

	HurtEvtBtlEnergyChange.super.handleEvt(self, hurtData)
end

function HurtEvtBtlEnergyChange:getDesc(hurtData)
	return
end

return HurtEvtBtlEnergyChange
