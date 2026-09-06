-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/spineinterface/param/mo/MsBaseParamMo.lua

module("logic.extensions.spineinterface.param.mo.MsBaseParamMo", package.seeall)

local MsBaseParamMo = class("MsBaseParamMo")

function MsBaseParamMo:ctor()
	return
end

function MsBaseParamMo:onInit()
	self._dataType = self:_getDataTypeOfDefault()
	self._min = self:getMinOfDefault()
	self._max = self:getMaxOfDefault()

	self:setValueOfDefault()
end

function MsBaseParamMo:onClear()
	self._value = nil
	self._dataType = nil
	self._min = nil
	self._max = nil
end

function MsBaseParamMo:_getDataTypeOfDefault()
	return
end

function MsBaseParamMo:getMinOfDefault()
	return
end

function MsBaseParamMo:getMaxOfDefault()
	return
end

function MsBaseParamMo:setValueOfDefault()
	if self._dataType == MsEnum.DataType.Int then
		self:setValue(0)
	elseif self._dataType == MsEnum.DataType.Float then
		self:setValue(0)
	elseif self._dataType == MsEnum.DataType.Bool then
		self:setValue(false)
	elseif self._dataType == MsEnum.DataType.Trigger then
		self:setValue(false)
	end
end

function MsBaseParamMo:getValue()
	return self._value
end

function MsBaseParamMo:setValue(value)
	if self._dataType == MsEnum.DataType.Int or self._dataType == MsEnum.DataType.Float then
		value = checknumber(value)
		self._value = self._min ~= nil and self._max ~= nil and Mathf.Clamp(value, self._min, self._max) or self._min ~= nil and Mathf.Min(value, self._min) or self._max ~= nil and Mathf.Max(value, self._max) or value
	else
		self._value = self._dataType == MsEnum.DataType.Bool and checkbool(value and (value == true or value == "true")) or self._dataType == MsEnum.DataType.Trigger and checkbool(value and (value == true or value == "true")) or value
	end
end

function MsBaseParamMo:getDataType()
	return self._dataType
end

return MsBaseParamMo
