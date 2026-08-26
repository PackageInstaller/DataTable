-- chunkname: @modules/logic/versionactivity2_4/pinball/view/PinballBaseSceneView.lua

module("modules.logic.versionactivity2_4.pinball.view.PinballBaseSceneView", package.seeall)

local PinballBaseSceneView = class("PinballBaseSceneView", BaseView)

function PinballBaseSceneView:onOpen()
	local sceneRoot = CameraMgr.instance:getSceneRoot()

	self._sceneRoot = UnityEngine.GameObject.New(self.__cname)

	gohelper.setActive(self._sceneRoot, false)

	self.isLoading = true

	self:beforeLoadScene()
	gohelper.addChild(sceneRoot, self._sceneRoot)

	self._loader = PrefabInstantiate.Create(self._sceneRoot)

	transformhelper.setLocalPos(self._sceneRoot.transform, 0, 5.8, 0)
	MainCameraMgr.instance:addView(self.viewName, self._initCamera, nil, self)
	self._loader:startLoad(self:getScenePath(), self._onSceneLoadEnd, self)
end

function PinballBaseSceneView:beforeLoadScene()
	return
end

function PinballBaseSceneView:getScenePath()
	return ""
end

function PinballBaseSceneView:_onSceneLoadEnd()
	local go = self._loader:getInstGO()

	go.name = "Scene"

	transformhelper.setLocalPos(go.transform, 0, 0, 10)
	self:onSceneLoaded(go)

	self.isLoading = false

	gohelper.setActive(self._sceneRoot, not self._isHide)
end

function PinballBaseSceneView:onSceneLoaded(sceneGo)
	return
end

function PinballBaseSceneView:_initCamera()
	local camera = CameraMgr.instance:getMainCamera()
	local scale = GameUtil.getAdapterScale(true)

	camera.orthographic = true
	camera.orthographicSize = 7 * scale
end

function PinballBaseSceneView:setSceneVisible(isVisible)
	self._isHide = not isVisible

	gohelper.setActive(self._sceneRoot, isVisible and not self.isLoading)
end

function PinballBaseSceneView:onDestroyView()
	if self._loader then
		self._loader:dispose()

		self._loader = nil
	end

	if self._sceneRoot then
		gohelper.destroy(self._sceneRoot)

		self._sceneRoot = nil
	end
end

return PinballBaseSceneView
