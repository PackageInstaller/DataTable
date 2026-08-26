-- chunkname: @modules/logic/story/view/StorySceneView.lua

module("modules.logic.story.view.StorySceneView", package.seeall)

local StorySceneView = class("StorySceneView", BaseView)

function StorySceneView:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function StorySceneView:addEvents()
	return
end

function StorySceneView:removeEvents()
	return
end

function StorySceneView:_editableInitView()
	self._cameraComp = GameSceneMgr.instance:getCurScene().camera
	self._sceneRoot = CameraMgr.instance:getSceneRoot()
end

function StorySceneView:onOpen()
	self:_initScene()
end

function StorySceneView:onClose()
	self:_disposeScene()
end

function StorySceneView:_initScene()
	local levelId = self.viewParam.levelId
	local levelConfig = lua_scene_level.configDict[levelId]

	self._sceneContainer = gohelper.create3d(self._sceneRoot, "StoryScene")

	if not levelConfig then
		return
	end

	local sceneRes = ResUrl.getSceneUrl(levelConfig.resName)

	self._sceneLoader = MultiAbLoader.New()

	self._sceneLoader:addPath(sceneRes)
	self._sceneLoader:startLoad(function(multiAbLoader)
		local assetItem = multiAbLoader:getAssetItem(sceneRes)

		if not assetItem then
			return
		end

		local oldAsstet = self._assetItem

		self._assetItem = assetItem

		self._assetItem:Retain()

		if oldAsstet then
			oldAsstet:Release()
		end

		local scenePrefab = self._assetItem:GetResource(sceneRes)
		local sceneGO = gohelper.clone(scenePrefab, self._sceneContainer, levelConfig.resName)

		if levelId == 10101 then
			local storyMainSceneView = self.viewContainer:getStoryMainSceneView()

			if storyMainSceneView then
				storyMainSceneView:setSceneId(1)
				storyMainSceneView:initSceneGo(sceneGO, levelConfig.resName)
			end
		end
	end)

	local cameraConfig = lua_camera.configDict[levelConfig.cameraId]

	self._cameraComp:setCameraTraceEnable(true)
	self._cameraComp:resetParam(cameraConfig)
	self._cameraComp:applyDirectly()
	self._cameraComp:setCameraTraceEnable(false)
	PostProcessingMgr.instance:setLocalBloomColor(Color.New(levelConfig.bloomR, levelConfig.bloomG, levelConfig.bloomB, levelConfig.bloomA))
end

function StorySceneView:_disposeScene()
	if self._sceneContainer then
		gohelper.destroy(self._sceneContainer)

		self._sceneContainer = nil
	end

	if self._assetItem then
		self._assetItem:Release()

		self._assetItem = nil
	end

	if self._sceneLoader then
		self._sceneLoader:dispose()

		self._sceneLoader = nil
	end

	self._cameraComp:setCameraTraceEnable(true)
	self._cameraComp:resetParam()
	self._cameraComp:applyDirectly()
	self._cameraComp:setCameraTraceEnable(false)

	local curLevelId = GameSceneMgr.instance:getCurLevelId()
	local curLevelConfig = lua_scene_level.configDict[curLevelId]

	PostProcessingMgr.instance:setLocalBloomColor(Color.New(curLevelConfig.bloomR, curLevelConfig.bloomG, curLevelConfig.bloomB, curLevelConfig.bloomA))
end

return StorySceneView
