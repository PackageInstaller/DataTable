-- chunkname: @modules/logic/fight/entity/comp/skill/FightTLEventHideScene.lua

module("modules.logic.fight.entity.comp.skill.FightTLEventHideScene", package.seeall)

local FightTLEventHideScene = class("FightTLEventHideScene", FightTimelineTrackItem)

function FightTLEventHideScene:onTrackStart(fightStepData, duration, paramsArr)
	self.noRevert = paramsArr[1] == "1"

	local sceneLevelComp = FightGameMgr.sceneLevelMgr

	if sceneLevelComp then
		local sceneGO = sceneLevelComp:getSceneGo()

		self.sceneGO = sceneGO

		gohelper.setActive(sceneGO, false)
	end
end

function FightTLEventHideScene:onTrackEnd()
	if not self.noRevert then
		gohelper.setActive(self.sceneGO, true)
	end
end

function FightTLEventHideScene:onDestructor()
	self:onTrackEnd()
end

return FightTLEventHideScene
