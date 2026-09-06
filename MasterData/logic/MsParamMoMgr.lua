-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/spineinterface/param/MsParamMoMgr.lua

module("logic.extensions.spineinterface.param.MsParamMoMgr", package.seeall)

local MsParamMoMgr = class("MsParamMoMgr")

function MsParamMoMgr:ctor()
	self._paramMoListGroup = {}
	self._skinId = 0
end

function MsParamMoMgr:onReload(skinId)
	self:onUnReload()

	self._skinId = checknumber(skinId)
	self._paramMoListGroup[MsEnum.ParamMgrType.Public] = self._paramMoListGroup[MsEnum.ParamMgrType.Public] or {}

	local paramsDataList = SpineInterfaceConfig.instance:getMsPubParamsDataList(self._skinId)

	if paramsDataList then
		for _, data in ipairs(paramsDataList) do
			local paramId = data.publicParamId
			local mo = MsPubParamMo.New()

			mo:onInit(self._skinId, paramId)

			self._paramMoListGroup[MsEnum.ParamMgrType.Public][paramId] = mo
		end
	end

	self._paramMoListGroup[MsEnum.ParamMgrType.Spine] = self._paramMoListGroup[MsEnum.ParamMgrType.Spine] or {}

	local paramsDataList = SpineInterfaceConfig.instance:getMsSpParamsDataList(self._skinId)

	if paramsDataList then
		for _, data in ipairs(paramsDataList) do
			local paramId = data.spineParamId
			local mo = MsSpParamMo.New()

			mo:onInit(self._skinId, paramId)

			self._paramMoListGroup[MsEnum.ParamMgrType.Spine][paramId] = mo
		end
	end
end

function MsParamMoMgr:onUnReload()
	for _, moList in pairs(self._paramMoListGroup) do
		for _, mo in ipairs(moList) do
			mo:onClear()
		end

		table.clear(moList)
	end

	if self._paramMoList then
		table.clear(self._paramMoList)
	end

	self._skinId = 0
end

function MsParamMoMgr:onDestroy()
	self:onUnReload()
end

function MsParamMoMgr:getParamMo(paramType, paramId)
	return self._paramMoListGroup[paramType][paramId]
end

function MsParamMoMgr:getParamMoList(paramType)
	return self._paramMoListGroup[paramType]
end

function MsParamMoMgr:getParamValue(paramType, paramId)
	return self:getParamMo(paramType, paramId):getValue()
end

function MsParamMoMgr:setParamValue(paramType, paramId, value)
	return self:getParamMo(paramType, paramId):setValue(value)
end

return MsParamMoMgr
