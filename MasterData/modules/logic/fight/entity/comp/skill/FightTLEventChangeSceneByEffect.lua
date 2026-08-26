-- chunkname: @modules/logic/fight/entity/comp/skill/FightTLEventChangeSceneByEffect.lua

module("modules.logic.fight.entity.comp.skill.FightTLEventChangeSceneByEffect", package.seeall)

local FightTLEventChangeSceneByEffect = class("FightTLEventChangeSceneByEffect", FightTimelineTrackItem)

function FightTLEventChangeSceneByEffect:onTrackStart(fightStepData, duration, paramsArr)
	local actEffect = FightHelper.getActEffectData(FightEnum.EffectType.CHANGESCENE, fightStepData)

	if not actEffect then
		return
	end

	local levelId = actEffect.effectNum

	if levelId < 1 then
		return
	end

	self:com_registFightEvent(FightEvent.OnSceneLevelLoaded, self._onLevelLoaded)

	local fightScene = GameSceneMgr.instance:getScene(SceneType.Fight)

	FightGameMgr.sceneLevelMgr:loadScene(nil, levelId)
end

function FightTLEventChangeSceneByEffect:_onLevelLoaded()
	local entityDic = FightGameMgr.entityMgr:getAllEntity()

	if entityDic then
		for _, entity in pairs(entityDic) do
			entity:resetStandPos()
		end
	end
end

function FightTLEventChangeSceneByEffect:onTrackEnd()
	return
end

function FightTLEventChangeSceneByEffect:onDestructor()
	return
end

return FightTLEventChangeSceneByEffect
