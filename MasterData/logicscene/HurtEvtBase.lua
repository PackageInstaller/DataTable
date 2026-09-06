-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/battle/skills/hurts/evts/HurtEvtBase.lua

module("logicscene.scene.battle.skills.hurts.evts.HurtEvtBase", package.seeall)

local HurtEvtBase = class("HurtEvtBase")

function HurtEvtBase:ctor()
	self.sequenceId = 0
end

function HurtEvtBase:handleEvt(hurtData)
	hurtData:pushHurtEvtRecord(self)
	HurtEvtsPool.instance:recycleEvt(self)
end

function HurtEvtBase:getEvtType()
	return
end

function HurtEvtBase:getDesc(hurtData)
	return
end

return HurtEvtBase
