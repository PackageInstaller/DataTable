-- chunkname: @modules/logic/versionactivity2_2/lopera/view/LoperaBaseSceneView.lua

module("modules.logic.versionactivity2_2.lopera.view.LoperaBaseSceneView", package.seeall)

local LoperaBaseSceneView = class("LoperaBaseSceneView", BaseView)

function LoperaBaseSceneView:onOpen()
	local sceneRoot = CameraMgr.instance:getSceneRoot()

	self._sceneRoot = UnityEngine.GameObject.New(self.__cname)

	self:beforeLoadScene()
	gohelper.addChild(sceneRoot, self._sceneRoot)

	self._loader = PrefabInstantiate.Create(self._sceneRoot)

	transformhelper.setLocalPos(self._sceneRoot.transform, 0, 5, 0)
	MainCameraMgr.instance:addView(self.viewName, self._initCamera, nil, self)
	self._loader:startLoad(self:getScenePath(), self._onSceneLoadEnd, self)
end

function LoperaBaseSceneView:beforeLoadScene()
	return
end

function LoperaBaseSceneView:getScenePath()
	return ""
end

function LoperaBaseSceneView:_onSceneLoadEnd()
	local go = self._loader:getInstGO()

	go.name = "Scene"

	transformhelper.setLocalPos(go.transform, 0, 0, 5)
	self:onSceneLoaded(go)
end

function LoperaBaseSceneView:onSceneLoaded(sceneGo)
	return
end

function LoperaBaseSceneView:_initCamera()
	local camera = CameraMgr.instance:getMainCamera()
	local scale = GameUtil.getAdapterScale(true)

	camera.orthographic = true
	camera.orthographicSize = 5 * scale
end

function LoperaBaseSceneView:setSceneVisible(isVisible)
	gohelper.setActive(self._sceneRoot, isVisible)
end

function LoperaBaseSceneView:onDestroyView()
	if self._loader then
		self._loader:dispose()

		self._loader = nil
	end

	if self._sceneRoot then
		gohelper.destroy(self._sceneRoot)

		self._sceneRoot = nil
	end
end

return LoperaBaseSceneView
