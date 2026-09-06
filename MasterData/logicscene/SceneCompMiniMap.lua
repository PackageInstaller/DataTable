-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/component/season/SceneCompMiniMap.lua

module("logicscene.scene.component.season.SceneCompMiniMap", package.seeall)

local SceneCompMiniMap = class("SceneCompMiniMap", SceneComponentBase)

SceneCompMiniMap.minimapStepNone = 0
SceneCompMiniMap.minimapStepBasic = 1
SceneCompMiniMap.minimapStepEverything = 2
SceneCompMiniMap.minimapStepEverythingFinished = 3

local minimapStepNone = SceneCompMiniMap.minimapStepNone
local minimapStepBasic = SceneCompMiniMap.minimapStepBasic
local minimapStepEverything = SceneCompMiniMap.minimapStepEverything
local minimapStepEverythingFinished = SceneCompMiniMap.minimapStepEverythingFinished

function SceneCompMiniMap:ctor(scene)
	SceneCompMiniMap.super.ctor(self, scene)

	self._miniMapStep = minimapStepNone
end

function SceneCompMiniMap:onEnterScene(sceneId, bornX, bornZ)
	GlobalDispatcher:addListener(GlobalNotify.SeasonMinimapOpenedOrClosed, self._onSeasonMinimapOpenedOrClosed, self)
end

function SceneCompMiniMap:onEnterSceneFinished(sceneId, bornX, bornZ)
	SceneCompMiniMap.super.onEnterSceneFinished(self, sceneId, bornX, bornZ)
	self:_calMiniMapParams()
end

function SceneCompMiniMap:onExitScene()
	self._generatedCallback = nil
	self._generatedCallbackObj = nil
	self._bounds = nil
	self._uvParams = nil
	self._minimapCameara = nil
	self._rendererTex = nil
	self._regionIndex = nil
	self._miniMapStep = minimapStepNone

	self:_clearDectector()
	SeasonController.instance:setMinimapOpened(false)
	GlobalDispatcher:removeListener(GlobalNotify.SeasonMinimapOpenedOrClosed, self._onSeasonMinimapOpenedOrClosed, self)
end

function SceneCompMiniMap:generateRegionMinimap(index, camera, callback, callbackObj)
	SeasonController.instance:setMinimapOpened(true)

	self._generatedCallback = callback
	self._generatedCallbackObj = callbackObj
	self._minimapCameara = camera
	self._regionIndex = index
	self._rendererTex = SeasonMiniMapModel.instance:getRegionMinimapTexture(index)

	if not self._rendererTex then
		self._miniMapStep = minimapStepBasic
		self._rendererTex = UnityEngine.RenderTexture.GetTemporary(1024, 1024)

		SeasonMiniMapModel.instance:setRegionMinimapTexture(index, self._rendererTex)
	else
		self._miniMapStep = minimapStepEverything
	end

	local mainCamera = GlobalModel.instance.mainCamera

	self._minimapCameara.cullingMask = mainCamera.cullingMask
	self._minimapCameara.nearClipPlane = mainCamera.nearClipPlane
	self._minimapCameara.farClipPlane = mainCamera.farClipPlane

	local bounds = self._regionBounds[index]
	local size = self._scene:getSceneSize()

	Framework.TransformUtil.SetPos(self._minimapCameara.transform, bounds.centerx, bounds.centery, mainCamera.transform.position.z)
	self._scene.stage.wholeScene:SetDetector(self._minimapCameara.gameObject, bounds.originSize.width + 2, bounds.originSize.height + 2)
	self._scene.stage.wholeScene:ForceDetect()
	self._minimapCameara.gameObject:SetActive(false)
	self:_notyfyStatusChange()
end

function SceneCompMiniMap:getRenderTexture()
	return self._rendererTex
end

function SceneCompMiniMap:stopGenerateMinimap()
	SeasonController.instance:setMinimapOpened(false)

	self._miniMapStep = minimapStepNone
	self._minimapCameara = nil
	self._generatedCallback = nil
	self._generatedCallbackObj = nil

	self:_clearDectector()
end

function SceneCompMiniMap:update(deltaTime)
	if not self._miniMapStep or self._miniMapStep == minimapStepNone or self._miniMapStep == minimapStepEverythingFinished then
		return
	end

	if self._miniMapStep == minimapStepBasic then
		self:_generateBasicMinimap()
	elseif self._miniMapStep == minimapStepEverything then
		self:_generateEverythingMinimap()
	end
end

function SceneCompMiniMap:isUnitInCurRegionMinimapRange(unit)
	if not self._regionIndex or not self._regionBounds then
		return
	end

	local bounds = self._regionBounds[self._regionIndex]

	if not bounds then
		return
	end

	return self:_isUnitInRegion(bounds, unit)
end

function SceneCompMiniMap:_isUnitInRegion(bounds, unit)
	local posx, posy = unit.transform:getPos()
	local minx = bounds.centerx - bounds.originSize.width * 0.5
	local miny = bounds.centery - bounds.originSize.height * 0.5
	local maxx = minx + bounds.originSize.width
	local maxy = miny + bounds.originSize.height

	if minx <= posx and posx <= maxx and miny <= posy and posy <= maxy then
		return true
	end
end

function SceneCompMiniMap:_generateBasicMinimap()
	local gridUnits = self._scene.gridUnitsMgr:getGridUnits()
	local bounds = self._regionBounds[self._regionIndex]

	for k, v in pairs(gridUnits) do
		for k1, v1 in pairs(v) do
			if self:_isUnitInRegion(bounds, v1) and v1:isClipping() then
				return
			end
		end
	end

	self:_renderMinimap()

	self._miniMapStep = minimapStepEverything

	self:_notyfyStatusChange()
end

function SceneCompMiniMap:_generateEverythingMinimap()
	local gridUnits = self._scene.gridUnitsMgr:getGridUnits()
	local bounds = self._regionBounds[self._regionIndex]

	for k, v in pairs(gridUnits) do
		for k1, v1 in pairs(v) do
			if self:_isUnitInRegion(bounds, v1) and (v1:isClipping() or v1.prepareMiniMapReady and not v1:prepareMiniMapReady()) then
				return
			end
		end
	end

	self:_renderMinimap()
	SeasonController.instance:setMinimapOpened(false)
	self:_clearDectector()

	self._miniMapStep = minimapStepEverythingFinished

	self:_notyfyStatusChange()
end

function SceneCompMiniMap:_renderMinimap()
	local mainCamera = GlobalModel.instance.mainCamera
	local bounds = self._regionBounds[self._regionIndex]

	self._minimapCameara.orthographicSize = bounds.size * 0.5

	Framework.TransformUtil.SetPos(self._minimapCameara.transform, bounds.centerx, bounds.centery, mainCamera.transform.position.z)
	self._minimapCameara:Render()
end

function SceneCompMiniMap:_calMiniMapParams()
	if self._bounds and self._uvParams then
		return
	end

	local camRange = self._scene.camera:getCameraOriginRange()
	local bounds = {
		minx = camRange[1],
		miny = camRange[2],
		maxx = camRange[3],
		maxy = camRange[4]
	}
	local boundsWidth = bounds.maxx - bounds.minx
	local boundsHeight = bounds.maxy - bounds.miny
	local boundsCenterX = bounds.minx + boundsWidth * 0.5
	local boundsCenterY = bounds.miny + boundsHeight * 0.5
	local size = math.max(boundsHeight, boundsWidth)

	self._bounds = {
		centerx = boundsCenterX,
		centery = boundsCenterY,
		size = size,
		originSize = {
			width = boundsWidth,
			height = boundsHeight
		}
	}
	self._uvParams = {
		minx = boundsCenterX - size * 0.5,
		miny = boundsCenterY - size * 0.5,
		scale = 1 / size
	}
	self._regionBounds = {}
	self._regionUVParams = {}

	local seasonId = SeasonModel.instance:getSeasonId()
	local regionsParams = SeasonConfig.instance:getMiniMapRegionParams(seasonId)

	for k, v in pairs(regionsParams) do
		local minx = v.regionParams[1]
		local maxx = v.regionParams[2]
		local miny = v.regionParams[3]
		local maxy = v.regionParams[4]
		local regionWidth = maxx - minx
		local regionHeight = maxy - miny
		local size = math.max(regionWidth, regionHeight)
		local boundsRegion = {
			centerx = minx + regionWidth * 0.5,
			centery = miny + regionHeight * 0.5,
			size = size,
			originSize = {
				width = regionWidth,
				height = regionHeight
			}
		}

		self._regionBounds[v.Id] = boundsRegion
		self._regionUVParams[v.Id] = {
			minx = boundsRegion.centerx - size * 0.5,
			miny = boundsRegion.centery - size * 0.5,
			scale = 1 / size
		}
	end
end

function SceneCompMiniMap:getMiniMapParams()
	return self._bounds, self._uvParams
end

function SceneCompMiniMap:UVToWorldPosition(uvx, uvy)
	if not self._uvParams then
		return 0, 0
	end

	return self._uvParams.minx + uvx / self._uvParams.scale, self._uvParams.miny + uvy / self._uvParams.scale
end

function SceneCompMiniMap:worldPositionToUV(x, y)
	if not self._uvParams then
		return 0, 0
	end

	local dx = x - self._uvParams.minx
	local dy = y - self._uvParams.miny

	return dx * self._uvParams.scale, dy * self._uvParams.scale
end

function SceneCompMiniMap:getRegionMiniMapParams(index)
	if not self._regionBounds then
		return
	end

	return self._regionBounds[index], self._regionUVParams[index]
end

function SceneCompMiniMap:regionUVToWorldPosition(uvParams, uvx, uvy)
	if not uvParams then
		return 0, 0
	end

	return uvParams.minx + uvx / uvParams.scale, uvParams.miny + uvy / uvParams.scale
end

function SceneCompMiniMap:worldPositionToRegionUV(uvParams, x, y)
	if not uvParams then
		return 0, 0
	end

	local dx = x - uvParams.minx
	local dy = y - uvParams.miny

	return dx * uvParams.scale, dy * uvParams.scale
end

function SceneCompMiniMap:_onSeasonMinimapOpenedOrClosed(opened)
	local gridUnits = self._scene.gridUnitsMgr:getGridUnits()

	if gridUnits then
		for k, v in pairs(gridUnits) do
			for k1, v1 in pairs(v) do
				v1:onSeasonMinimapOpenedOrClosed(opened)
			end
		end
	end
end

function SceneCompMiniMap:_notyfyStatusChange()
	if self._generatedCallback then
		if self._generatedCallbackObj then
			self._generatedCallback(self._generatedCallbackObj, self._miniMapStep)
		else
			self._generatedCallback(self._miniMapStep)
		end
	end
end

function SceneCompMiniMap:_clearDectector()
	if self._scene.stage.wholeScene then
		self._scene.stage:updateDetectors()
		self._scene.stage.wholeScene:ForceDetect()
	end
end

return SceneCompMiniMap
