-- chunkname: @modules/logic/scene/udimo/scenecomp/UdimoSceneLevelComp.lua

module("modules.logic.scene.udimo.scenecomp.UdimoSceneLevelComp", package.seeall)

local UdimoSceneLevelComp = class("UdimoSceneLevelComp", CommonSceneLevelComp)

function UdimoSceneLevelComp:init(sceneId, levelId)
	self:loadLevel(levelId)
end

function UdimoSceneLevelComp:onSceneStart(sceneId, levelId)
	self._sceneId = sceneId
	self._levelId = levelId
end

function UdimoSceneLevelComp:onScenePrepared(sceneId, levelId)
	return
end

function UdimoSceneLevelComp:getSceneColorCtrl()
	if not self._colorCtrl and not gohelper.isNil(self._instGO) then
		self._colorCtrl = self._instGO:GetComponent(typeof(ZProj.FightSceneMainColorCtrl))
	end

	return self._colorCtrl
end

function UdimoSceneLevelComp:addGameObjectToColorCtrl(go, isContainChildren)
	local colorCtrl = self:getSceneColorCtrl()

	if not colorCtrl or gohelper.isNil(go) then
		return
	end

	colorCtrl:OnAdd(go, isContainChildren)
end

function UdimoSceneLevelComp:removeGameObjectToColorCtrl(go, isContainChildren)
	local colorCtrl = self:getSceneColorCtrl()

	if not colorCtrl or gohelper.isNil(go) then
		return
	end

	colorCtrl:OnRemove(go, isContainChildren)
end

function UdimoSceneLevelComp:onSceneClose()
	if self._colorCtrl then
		self._colorCtrl:Clear()
	end

	self._colorCtrl = nil

	UdimoSceneLevelComp.super.onSceneClose(self)
end

return UdimoSceneLevelComp
