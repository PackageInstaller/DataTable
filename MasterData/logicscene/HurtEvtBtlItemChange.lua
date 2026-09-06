-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/battle/skills/hurts/evts/HurtEvtBtlItemChange.lua

module("logicscene.scene.battle.skills.hurts.evts.HurtEvtBtlItemChange", package.seeall)

local HurtEvtBtlItemChange = class("HurtEvtBtlItemChange", HurtEvtBase)

function HurtEvtBtlItemChange:getEvtType()
	return HurtEvtType.BtlItemChange
end

function HurtEvtBtlItemChange:handleEvt(hurtData)
	if self.playerTeam == BattleModel.instance.myTeamId then
		BattleItemsModel.instance:updateItem(self.curItemView)
	end

	HurtEvtBtlItemChange.super.handleEvt(self, hurtData)
end

function HurtEvtBtlItemChange:getDesc(hurtData)
	return
end

return HurtEvtBtlItemChange
