-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pettitle/model/PetTitleItem.lua

module("logic.extensions.pettitle.model", package.seeall)

local PetTitleItem = class("PetTitleItem", MaterialMo)

function PetTitleItem:ctor()
	self._titleId = nil
	self._gainTime = nil
	self._configId = 0
	self._type = 0
	self._id = 0
	self._num = 0
end

function PetTitleItem:onReset()
	self._titleId = nil
	self._gainTime = nil
	self._configId = 0
	self._type = 0
	self._id = 0
	self._num = 0
end

function PetTitleItem:initData(params)
	self._titleId = params.titleId
	self._gainTime = params.gainTime
	self._configId = self._titleId
	self._type = MatType.PetTitle
	self._id = self._titleId
end

function PetTitleItem:getTitleId()
	return self._titleId
end

function PetTitleItem:getGainTime()
	return self._gainTime
end

function PetTitleItem:getMatType()
	return self._type
end

function PetTitleItem:getDefineId()
	return self._configId
end

function PetTitleItem:getId()
	return self._id
end

return PetTitleItem
