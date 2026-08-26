-- chunkname: @modules/logic/fight/entity/comp/skill/FightTLEventMarkSceneDefaultRoot.lua

module("modules.logic.fight.entity.comp.skill.FightTLEventMarkSceneDefaultRoot", package.seeall)

local FightTLEventMarkSceneDefaultRoot = class("FightTLEventMarkSceneDefaultRoot", FightTimelineTrackItem)

function FightTLEventMarkSceneDefaultRoot:onTrackStart(fightStepData, duration, paramsArr)
	FightTLEventMarkSceneDefaultRoot.sceneId = GameSceneMgr.instance:getCurSceneId()
	FightTLEventMarkSceneDefaultRoot.levelId = GameSceneMgr.instance:getCurLevelId()
	FightTLEventMarkSceneDefaultRoot.rootName = paramsArr[1]
end

function FightTLEventMarkSceneDefaultRoot:onTrackEnd()
	return
end

function FightTLEventMarkSceneDefaultRoot:onDestructor()
	return
end

return FightTLEventMarkSceneDefaultRoot
