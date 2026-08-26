-- chunkname: @modules/logic/versionactivity2_2/tianshinana/view/TianShiNaNaBaseSceneView.lua

module("modules.logic.versionactivity2_2.tianshinana.view.TianShiNaNaBaseSceneView", package.seeall)

local TianShiNaNaBaseSceneView = class("TianShiNaNaBaseSceneView", BaseView)

function TianShiNaNaBaseSceneView:onOpen()
	local sceneRoot = CameraMgr.instance:getSceneRoot()

	self._sceneRoot = UnityEngine.GameObject.New(self.__cname)

	gohelper.setActive(self._sceneRoot, false)

	self.isLoading = true

	self:beforeLoadScene()
	gohelper.addChild(sceneRoot, self._sceneRoot)

	self._loader = PrefabInstantiate.Create(self._sceneRoot)

	transformhelper.setLocalPos(self._sceneRoot.transform, 0, 5, 0)
	MainCameraMgr.instance:addView(self.viewName, self._initCamera, nil, self)
	self._loader:startLoad(self:getScenePath(), self._onSceneLoadEnd, self)
end

function TianShiNaNaBaseSceneView:beforeLoadScene()
	return
end

function TianShiNaNaBaseSceneView:getScenePath()
	return ""
end

function TianShiNaNaBaseSceneView:_onSceneLoadEnd()
	local go = self._loader:getInstGO()

	go.name = "Scene"

	transformhelper.setLocalPos(go.transform, 0, 0, 10)
	self:onSceneLoaded(go)

	self.isLoading = false

	gohelper.setActive(self._sceneRoot, not self._isHide)
end

function TianShiNaNaBaseSceneView:onSceneLoaded(sceneGo)
	return
end

function TianShiNaNaBaseSceneView:_initCamera()
	local camera = CameraMgr.instance:getMainCamera()
	local scale = GameUtil.getAdapterScale(true)

	camera.orthographic = true
	camera.orthographicSize = 7 * scale
end

function TianShiNaNaBaseSceneView:setSceneVisible(isVisible)
	self._isHide = not isVisible

	gohelper.setActive(self._sceneRoot, isVisible and not self.isLoading)
end

function TianShiNaNaBaseSceneView:onDestroyView()
	if self._loader then
		self._loader:dispose()

		self._loader = nil
	end

	if self._sceneRoot then
		gohelper.destroy(self._sceneRoot)

		self._sceneRoot = nil
	end
end

return TianShiNaNaBaseSceneView
