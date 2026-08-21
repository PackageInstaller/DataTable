-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/viewlib/sceneroot2d/SceneRoot2DMgr.lua

module("logic.common.viewlib.sceneroot2d.SceneRoot2DMgr", package.seeall)

local SceneRoot2DMgr = class("SceneRoot2DMgr")
local Type_Canvas = typeof(UnityEngine.Canvas)

function SceneRoot2DMgr:ctor()
	self._sceneUIRoot = goutil.find("SCENEROOT2D")
	self._subRootNames = {
		SceneRoot2DType.Map,
		SceneRoot2DType.NameBar,
		SceneRoot2DType.Bubble,
		SceneRoot2DType.Effect
	}
	self._subRoots = {}

	self:_init()
end

function SceneRoot2DMgr:_init()
	local rootsCount = #self._subRootNames
	local orgGo = goutil.findChild(self._sceneUIRoot, SceneRoot2DType.Map)

	for i = 1, rootsCount do
		local container = goutil.findChild(self._sceneUIRoot, self._subRootNames[i])

		self._subRoots[self._subRootNames[i]] = container

		local canvas = goutil.addComponentOnce(container, Type_Canvas)

		canvas.overrideSorting = true
		canvas.sortingLayerName = "Default"
		canvas.sortingOrder = i
	end
end

function SceneRoot2DMgr:getRoot(rootType)
	return self._subRoots[rootType]
end

function SceneRoot2DMgr:getSceneUIRoot()
	return self._sceneUIRoot
end

SceneRoot2DMgr.instance = SceneRoot2DMgr.New()

return SceneRoot2DMgr
