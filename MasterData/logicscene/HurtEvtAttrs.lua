-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/battle/skills/hurts/evts/HurtEvtAttrs.lua

module("logicscene.scene.battle.skills.hurts.evts.HurtEvtAttrs", package.seeall)

local HurtEvtAttrs = class("HurtEvtAttrs", HurtEvtBase)

function HurtEvtAttrs:handleEvt(hurtData)
	hurtData.target:onAttrTransform(self.attrs)
	HurtEvtAttrs.super.handleEvt(self, hurtData)
end

function HurtEvtAttrs:getEvtType()
	return HurtEvtType.EvtAttrs
end

return HurtEvtAttrs
