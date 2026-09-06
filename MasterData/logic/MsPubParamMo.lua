-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/spineinterface/param/mo/MsPubParamMo.lua

module("logic.extensions.spineinterface.param.mo.MsPubParamMo", package.seeall)

local MsPubParamMo = class("MsPubParamMo", MsBaseParamMo)

function MsPubParamMo:ctor()
	MsPubParamMo.super.ctor(self)
end

function MsPubParamMo:onInit(skinId, publicParamId)
	self._skinId = checknumber(skinId)
	self._publicParamId = checknumber(publicParamId)
	self._paramsData = SpineInterfaceConfig.instance:getMsPubParamsData(self._skinId, self._publicParamId)

	MsPubParamMo.super.onInit(self)
end

function MsPubParamMo:onClear()
	MsPubParamMo.super.onClear(self)

	self._skinId = 0
	self._publicParamId = 0
	self._paramsData = nil
end

function MsPubParamMo:_getDataTypeOfDefault()
	return self._paramsData.dataType
end

function MsPubParamMo:getMinOfDefault()
	local min

	return (not string.nilorempty(self._paramsData.min) or nil) and checknumber(self._paramsData.min)
end

function MsPubParamMo:getMaxOfDefault()
	local max

	return (not string.nilorempty(self._paramsData.max) or nil) and checknumber(self._paramsData.max)
end

return MsPubParamMo
