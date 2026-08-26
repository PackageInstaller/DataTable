-- chunkname: @modules/logic/fight/entity/comp/skill/FightTLEventCameraRotate.lua

module("modules.logic.fight.entity.comp.skill.FightTLEventCameraRotate", package.seeall)

local FightTLEventCameraRotate = class("FightTLEventCameraRotate", FightTimelineTrackItem)

function FightTLEventCameraRotate:onTrackStart(fightStepData, duration, paramsArr)
	local yaw = tonumber(paramsArr[1]) or 0
	local pitch = tonumber(paramsArr[2]) or 0
	local isImmediate = paramsArr[3] == "1"

	if GameSceneMgr.instance:getCurSceneType() == SceneType.Fight then
		local sceneCameraComp = GameSceneMgr.instance:getCurScene().camera

		sceneCameraComp:setEaseTime(isImmediate and 0 or duration)
		sceneCameraComp:setRotate(yaw, pitch)
	end
end

return FightTLEventCameraRotate
