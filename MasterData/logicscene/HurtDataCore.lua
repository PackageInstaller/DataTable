-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/battle/skills/hurts/HurtDataCore.lua

module("logicscene.scene.battle.skills.hurts.HurtDataCore", package.seeall)

local HurtDataCore = class("HurtDataCore", HurtDataBase)

function HurtDataCore:generateFromCharactorResult(result)
	self:generateFromResultNum(result.targetNum)
end

function HurtDataCore:generateFromResultNum(targetNum)
	HurtDataCore.super.generateFromResultNum(self, targetNum)
	self:generateAfterHurtEvtsFromResultNum(targetNum)
end

return HurtDataCore
