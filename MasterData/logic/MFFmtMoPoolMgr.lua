-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/masterform/view/fmtmgr/fmtmo/MFFmtMoPoolMgr.lua

module("logic.extensions.masterform.view.fmtmgr.fmtmo.MFFmtMoPoolMgr", package.seeall)

local MFFmtMoPoolMgr = class("MFFmtMoPoolMgr")

function MFFmtMoPoolMgr:ctor()
	self._moPools = {}
end

function MFFmtMoPoolMgr:onClear()
	for _, moPool in pairs(self._moPools) do
		moPool:clear()
	end
end

function MFFmtMoPoolMgr:onDestroy()
	table.clear(self._moPools)

	self._moPools = nil
end

function MFFmtMoPoolMgr:fetchFmtMo(fmtType, fmtId, ...)
	local args = {
		...
	}

	if self._moPools[fmtType] == nil then
		self._moPools[fmtType] = self:_creatMoPool(fmtType)
	end

	local mo = self._moPools[fmtType]:fetchObject()

	mo:onInit(fmtType, fmtId, GameUtil.unpack10(args))

	return mo
end

function MFFmtMoPoolMgr:returnFmtMo(mo)
	self._moPools[mo:getFmtType()]:returnObject(mo)
end

function MFFmtMoPoolMgr:_creatMoPool(fmtType)
	local function createFunc()
		local cls = MasterFormMgr.FmtMoCls[fmtType]

		return cls.New()
	end

	local function disposeFunc(mo)
		mo:onDispose()
	end

	local function resetFunc(mo)
		mo:onReset()
	end

	return ObjectPool.New(200, createFunc, disposeFunc, resetFunc)
end

return MFFmtMoPoolMgr
