-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newyearpray/model/NewYearPrayModel.lua

module("logic.extensions.newyearpray.model.NewYearPrayModel", package.seeall)

local NewYearPrayModel = class("NewYearPrayModel", BaseModel)

function NewYearPrayModel:ctor()
	return
end

function NewYearPrayModel:onInit()
	self:onReset()
end

function NewYearPrayModel:onReset()
	self._nypMoPool = self._nypMoPool or {}

	table.clear(self._nypMoPool)

	self._nypPlayerMoPool = self._nypPlayerMoPool or {}

	table.clear(self._nypPlayerMoPool)
end

function NewYearPrayModel:getNypMo(activityId)
	if self._nypMoPool[activityId] == nil then
		self._nypMoPool[activityId] = NewYearPrayMo.New(activityId)
	end

	return self._nypMoPool[activityId]
end

function NewYearPrayModel:getNypPlayerMo(activityId)
	if self._nypPlayerMoPool[activityId] == nil then
		self._nypPlayerMoPool[activityId] = NewYearPrayPlayerMo.New(activityId)
	end

	return self._nypPlayerMoPool[activityId]
end

NewYearPrayModel.instance = NewYearPrayModel.New()

return NewYearPrayModel
