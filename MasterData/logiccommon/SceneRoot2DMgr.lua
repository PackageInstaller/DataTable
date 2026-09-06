-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/viewlib/sceneroot2d/SceneRoot2DMgr.lua

module("logiccommon.common.viewlib.sceneroot2d.SceneRoot2DMgr", package.seeall)

local SceneRoot2DMgr = class("SceneRoot2DMgr")

function SceneRoot2DMgr:ctor()
	self._sceneUIRoot = goutil.find("SCENEROOT2D")
	self._subRootNames = {
		"MAP",
		"ENTITY",
		"EFFECT",
		"NAMEBAR",
		"BUBBLE"
	}
	self._subRoots = {}

	self:_init()

	self._isShow = true
	self._namebar = nil
	self._bubble = nil
end

function SceneRoot2DMgr:_init()
	local rootsCount = #self._subRootNames

	for i = 1, rootsCount do
		local container = goutil.findChild(self._sceneUIRoot, self._subRootNames[i])

		if container then
			self._subRoots[i] = container
		end
	end
end

function SceneRoot2DMgr:getRoot(rootType)
	return self._subRoots[rootType]
end

function SceneRoot2DMgr:getSceneUIRoot()
	return self._sceneUIRoot
end

function SceneRoot2DMgr:isShow()
	return self._isShow
end

function SceneRoot2DMgr:show()
	self._isShow = true

	self._subRoots[4]:SetActive(true)
	self._subRoots[5]:SetActive(true)
end

function SceneRoot2DMgr:hide()
	self._isShow = false

	self._subRoots[4]:SetActive(false)
	self._subRoots[5]:SetActive(false)
end

SceneRoot2DMgr.instance = SceneRoot2DMgr.New()

return SceneRoot2DMgr
