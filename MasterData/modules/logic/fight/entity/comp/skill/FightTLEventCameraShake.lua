-- chunkname: @modules/logic/fight/entity/comp/skill/FightTLEventCameraShake.lua

module("modules.logic.fight.entity.comp.skill.FightTLEventCameraShake", package.seeall)

local FightTLEventCameraShake = class("FightTLEventCameraShake", FightTimelineTrackItem)

function FightTLEventCameraShake:onTrackStart(fightStepData, duration, paramsArr)
	local magnitude = tonumber(paramsArr[1]) or 0
	local decreaseRate = tonumber(paramsArr[2]) or 0
	local shakeType = tonumber(paramsArr[3]) or 0

	if GameSceneMgr.instance:getCurSceneType() == SceneType.Fight then
		local fightScene = GameSceneMgr.instance:getCurScene()

		fightScene.camera:shake(duration, magnitude, shakeType, decreaseRate)
	end
end

return FightTLEventCameraShake
