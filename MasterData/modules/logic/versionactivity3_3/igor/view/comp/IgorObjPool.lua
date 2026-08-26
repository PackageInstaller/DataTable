-- chunkname: @modules/logic/versionactivity3_3/igor/view/comp/IgorObjPool.lua

module("modules.logic.versionactivity3_3.igor.view.comp.IgorObjPool", package.seeall)

local IgorObjPool = class("IgorObjPool", LuaObjPool)

function IgorObjPool:ctor(maxCount, newFunc, releaseFunc, resetFunc, funcObj, funcParam)
	IgorObjPool.super.ctor(self, maxCount, newFunc, releaseFunc, resetFunc)

	self._funcObj = funcObj
	self._funcParam = funcParam
end

function IgorObjPool:getObject()
	local curCount = #self._cacheList

	if curCount < 1 then
		return self._newFunc(self._funcObj, self._funcParam)
	else
		return table.remove(self._cacheList)
	end
end

function IgorObjPool:putObject(luaObj)
	local curCount = #self._cacheList

	self._resetFunc(self._funcObj, luaObj)

	if curCount >= self._maxCount then
		self._releaseFunc(self._funcObj, luaObj)
	elseif not tabletool.indexOf(self._cacheList, luaObj) then
		table.insert(self._cacheList, luaObj)
	end
end

function IgorObjPool:dispose()
	local curCount = #self._cacheList

	if curCount == 0 then
		return
	end

	local luaObj

	for idx = 1, curCount do
		self._releaseFunc(self._funcObj, self._cacheList[idx])

		self._cacheList[idx] = nil
	end
end

return IgorObjPool
