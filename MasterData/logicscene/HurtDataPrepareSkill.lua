-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/battle/skills/hurts/HurtDataPrepareSkill.lua

module("logicscene.scene.battle.skills.hurts.HurtDataPrepareSkill", package.seeall)

local HurtDataPrepareSkill = class("HurtDataPrepareSkill", HurtDataBase)

function HurtDataPrepareSkill:ctor()
	HurtDataPrepareSkill.super.ctor(self)

	self.skill = nil
end

function HurtDataPrepareSkill:generateFromCharactorResult(result)
	self:generateBeforeHurtEvtsFromResultNum(result.targetNum)
end

return HurtDataPrepareSkill
