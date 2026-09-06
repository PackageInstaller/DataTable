-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/viewlib/pool/CommonObjectMgr.lua

module("logiccommon.common.viewlib.pool.CommonObjectMgr", package.seeall)

local CommonObjectMgr = class("CommonObjectMgr")

function CommonObjectMgr:init()
	self._container = goutil.create("CommonObjectPool")

	goutil.addChildToParent(self._container, SceneMgr.instance:getRoot())

	self.shadowPool = CommonObjectPool.New(self._container, CommonResPath.CharacterShadow, 30)

	self.shadowPool:init()
end

function CommonObjectMgr:clear()
	if self.shadowPool then
		self.shadowPool:clear()

		self.shadowPool = nil
	end
end

CommonObjectMgr.instance = CommonObjectMgr.New()

return CommonObjectMgr
