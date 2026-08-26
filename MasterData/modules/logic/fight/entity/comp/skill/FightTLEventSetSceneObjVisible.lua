-- chunkname: @modules/logic/fight/entity/comp/skill/FightTLEventSetSceneObjVisible.lua

module("modules.logic.fight.entity.comp.skill.FightTLEventSetSceneObjVisible", package.seeall)

local FightTLEventSetSceneObjVisible = class("FightTLEventSetSceneObjVisible", FightTimelineTrackItem)

function FightTLEventSetSceneObjVisible:onTrackStart(fightStepData, duration, paramsArr)
	self.fightStepData = fightStepData
	self._paramsArr = paramsArr

	if self._paramsArr[3] == "1" then
		return
	end

	self:_setVisible()
end

function FightTLEventSetSceneObjVisible:_setVisible()
	if self._paramsArr[4] == "1" then
		local entity = FightHelper.getEntity(self.fightStepData.fromId)

		if entity and entity.skinSpineEffect then
			if self._paramsArr[2] == "1" then
				entity.skinSpineEffect:showEffects()
			else
				entity.skinSpineEffect:hideEffects()
			end
		end

		return
	end

	local fightScene = GameSceneMgr.instance:getCurScene()

	if fightScene then
		local sceneObj = FightGameMgr.sceneLevelMgr:getSceneGo()

		if sceneObj then
			local tarObj = gohelper.findChild(sceneObj, self._paramsArr[1])

			if tarObj then
				gohelper.setActive(tarObj, self._paramsArr[2] == "1")
			end
		end
	end
end

function FightTLEventSetSceneObjVisible:onTrackEnd()
	return
end

function FightTLEventSetSceneObjVisible:onDestructor()
	if self._paramsArr and self._paramsArr[3] == "1" then
		self:_setVisible()
	end
end

return FightTLEventSetSceneObjVisible
