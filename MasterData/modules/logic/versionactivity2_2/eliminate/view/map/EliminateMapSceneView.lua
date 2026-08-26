-- chunkname: @modules/logic/versionactivity2_2/eliminate/view/map/EliminateMapSceneView.lua

module("modules.logic.versionactivity2_2.eliminate.view.map.EliminateMapSceneView", package.seeall)

local EliminateMapSceneView = class("EliminateMapSceneView", BaseView)

function EliminateMapSceneView:onOpen()
	self._oldSceneResList = self:getUserDataTb_()

	self.addEventCb(self, EliminateMapController.instance, EliminateMapEvent.OnSelectChapterChange, self.onSelectChapterChange, self)
	self:_initSceneRoot()
	self:_loadScene()
end

function EliminateMapSceneView:_initSceneRoot()
	local sceneRoot = CameraMgr.instance:getSceneRoot()

	self._sceneRoot = UnityEngine.GameObject.New(self.__cname)

	gohelper.addChild(sceneRoot, self._sceneRoot)

	local mainTrans = CameraMgr.instance:getMainCameraTrs().parent
	local x, y, z = transformhelper.getLocalPos(mainTrans)

	transformhelper.setLocalPos(self._sceneRoot.transform, 0, y, 0)
end

function EliminateMapSceneView:onSelectChapterChange()
	self:_loadScene()
end

function EliminateMapSceneView:_loadScene()
	self.chapterId = self.viewContainer.chapterId

	local chapterRoot = UnityEngine.GameObject.New(tostring(self.chapterId))

	gohelper.addChild(self._sceneRoot, chapterRoot)
	table.insert(self._oldSceneResList, self._chapterRoot)

	self._chapterRoot = chapterRoot
	self._loader = PrefabInstantiate.Create(chapterRoot)

	MainCameraMgr.instance:addView(self.viewName, self._initCamera, nil, self)
	self._loader:startLoad(self:getScenePath(), self._onSceneLoadEnd, self)
end

function EliminateMapSceneView:getScenePath()
	return lua_eliminate_chapter.configDict[self.chapterId].map
end

function EliminateMapSceneView:_onSceneLoadEnd(loader)
	if loader ~= self._loader then
		return
	end

	local go = self._loader:getInstGO()

	go.name = "Scene"

	transformhelper.setLocalPos(go.transform, 0, 0, 5)
	self:_disposeOldRes()
end

function EliminateMapSceneView:_disposeOldRes()
	for _, v in ipairs(self._oldSceneResList) do
		gohelper.destroy(v)
	end

	self._oldSceneResList = self:getUserDataTb_()
end

function EliminateMapSceneView:_initCamera()
	local camera = CameraMgr.instance:getMainCamera()
	local scale = GameUtil.getAdapterScale(true)

	camera.orthographic = true
	camera.orthographicSize = 5 * scale
end

function EliminateMapSceneView:setSceneVisible(isVisible)
	self._sceneVisible = isVisible

	gohelper.setActive(self._sceneRoot, isVisible)
end

function EliminateMapSceneView:onDestroyView()
	self:_disposeOldRes()

	if self._loader then
		self._loader:dispose()

		self._loader = nil
	end

	if self._sceneRoot then
		gohelper.destroy(self._sceneRoot)

		self._sceneRoot = nil
	end
end

return EliminateMapSceneView
