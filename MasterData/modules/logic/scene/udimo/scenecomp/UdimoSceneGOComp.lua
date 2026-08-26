-- chunkname: @modules/logic/scene/udimo/scenecomp/UdimoSceneGOComp.lua

module("modules.logic.scene.udimo.scenecomp.UdimoSceneGOComp", package.seeall)

local UdimoSceneGOComp = class("UdimoSceneGOComp", BaseSceneComp)

function UdimoSceneGOComp:onInit()
	self:_clear()
end

function UdimoSceneGOComp:onSceneStart(sceneId, levelId)
	self:_clear()
end

function UdimoSceneGOComp:onScenePrepared(sceneId, levelId)
	return
end

function UdimoSceneGOComp:_getGO(parent, name)
	local go = gohelper.findChild(parent, name)

	if gohelper.isNil(go) then
		go = gohelper.create3d(parent, name)
	end

	return go
end

function UdimoSceneGOComp:getUdimoRoot()
	if gohelper.isNil(self._udimoRoot) then
		local scene = self:getCurScene()
		local sceneContainer = scene:getSceneContainerGO()

		self._udimoRoot = self:_getGO(sceneContainer, UdimoEnum.SceneGOName.UdimoRoot)
	end

	return self._udimoRoot
end

function UdimoSceneGOComp:getDecorationRoot()
	if gohelper.isNil(self._decorationRoot) then
		local scene = self:getCurScene()
		local sceneContainer = scene:getSceneContainerGO()

		self._decorationRoot = self:_getGO(sceneContainer, UdimoEnum.SceneGOName.DecorationRoot)
		self._decorationSiteGO = self:_getGO(self._decorationRoot, UdimoEnum.SceneGOName.DecorationSiteGO)
	end

	return self._decorationRoot
end

function UdimoSceneGOComp:getDecorationSiteGO()
	self:getDecorationRoot()

	if gohelper.isNil(self._decorationSiteGO) then
		self._decorationSiteGO = self:_getGO(self._decorationRoot, UdimoEnum.SceneGOName.DecorationSiteGO)
	end

	return self._decorationSiteGO
end

function UdimoSceneGOComp:getInteractPointRoot()
	if gohelper.isNil(self._interactPointRoot) then
		local scene = self:getCurScene()
		local sceneContainer = scene:getSceneContainerGO()

		self._interactPointRoot = self:_getGO(sceneContainer, UdimoEnum.SceneGOName.InteractPointRoot)
	end

	return self._interactPointRoot
end

function UdimoSceneGOComp:_clear()
	self._udimoRoot = nil
	self._decorationRoot = nil
	self._decorationSiteGO = nil
	self._interactPointRoot = nil
end

function UdimoSceneGOComp:onSceneClose()
	self:_clear()
end

return UdimoSceneGOComp
