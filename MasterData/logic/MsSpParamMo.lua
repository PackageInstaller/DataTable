-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/spineinterface/param/mo/MsSpParamMo.lua

module("logic.extensions.spineinterface.param.mo.MsSpParamMo", package.seeall)

local MsSpParamMo = class("MsSpParamMo", MsBaseParamMo)

function MsSpParamMo:ctor()
	MsSpParamMo.super.ctor(self)
end

function MsSpParamMo:onInit(skinId, spineParamId)
	self._skinId = checknumber(skinId)
	self._spineParamId = checknumber(spineParamId)
	self._paramsData = SpineInterfaceConfig.instance:getMsSpParamsData(self._skinId, self._spineParamId)
	self._paramsDicData = SpineInterfaceConfig.instance:getMsSpParamsDicData(self._paramsData.spineParamDicId)

	MsSpParamMo.super.onInit(self)
end

function MsSpParamMo:onClear()
	MsSpParamMo.super.onClear(self)

	self._skinId = 0
	self._spineParamId = 0
	self._paramsData = nil
	self._paramsDicData = nil
end

function MsSpParamMo:_getDataTypeOfDefault()
	return self._paramsDicData.dataType
end

function MsSpParamMo:getMinOfDefault()
	local min

	return (not string.nilorempty(self._paramsData.min) or nil) and checknumber(self._paramsData.min)
end

function MsSpParamMo:getMaxOfDefault()
	local max

	return (not string.nilorempty(self._paramsData.max) or nil) and checknumber(self._paramsData.max)
end

return MsSpParamMo
