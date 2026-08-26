-- chunkname: @modules/logic/scene/explore/comp/ExploreSceneSpineMat.lua

module("modules.logic.scene.explore.comp.ExploreSceneSpineMat", package.seeall)

local ExploreSceneSpineMat = class("ExploreSceneSpineMat", BaseSceneComp)

function ExploreSceneSpineMat:onSceneStart(sceneId, levelId)
	self:_setLevelCO(levelId)
	ExploreController.instance:registerCallback(ExploreEvent.OnSpineLoaded, self._onSpineLoaded, self)
end

function ExploreSceneSpineMat:onScenePrepared(sceneId, levelId)
	return
end

function ExploreSceneSpineMat:onSceneClose()
	ExploreController.instance:unregisterCallback(ExploreEvent.OnSpineLoaded, self._onSpineLoaded, self)

	self._spineColor = nil
end

function ExploreSceneSpineMat:_onSpineLoaded(unitSpine)
	if self._spineColor and unitSpine then
		local mat = unitSpine.unitSpawn.spineRenderer:getReplaceMat()

		MaterialUtil.setMainColor(mat, self._spineColor)
	end
end

function ExploreSceneSpineMat:_setLevelCO(levelId)
	self._spineColor = nil

	local levelCO = lua_scene_level.configDict[levelId]

	if levelCO.spineR ~= 0 or levelCO.spineG ~= 0 or levelCO.spineB ~= 0 then
		self._spineColor = Color.New(levelCO.spineR, levelCO.spineG, levelCO.spineB, 1)
	end
end

return ExploreSceneSpineMat
