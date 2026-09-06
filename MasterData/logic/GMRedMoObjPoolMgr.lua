-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/gm/view/gmredpoint/GMRedMoObjPoolMgr.lua

module("logic.extensions.gm.view.gmredpoint.GMRedMoObjPoolMgr", package.seeall)

local GMRedMoObjPoolMgr = class("GMRedMoObjPoolMgr")

function GMRedMoObjPoolMgr:ctor()
	local function createFunc()
		return GMRedMo.New()
	end

	local function disposeFunc(mo)
		mo:reset()
	end

	local function resetFunc(mo)
		mo:reset()
	end

	self._moPool = ObjectPool.New(50, createFunc, disposeFunc, resetFunc)
end

function GMRedMoObjPoolMgr:onEnter()
	return
end

function GMRedMoObjPoolMgr:onExit()
	return
end

function GMRedMoObjPoolMgr:destroy()
	self._moPool:clear()

	self._moPool = nil
end

function GMRedMoObjPoolMgr:fetchRedMo(redId)
	local mo = self._moPool:fetchObject()

	mo:update(redId)

	return mo
end

function GMRedMoObjPoolMgr:returnRedMo(mo)
	self._moPool:returnObject(mo)
end

return GMRedMoObjPoolMgr
