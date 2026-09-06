-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wisdomcourageclg/model/WisdomCourageClgModel.lua

module("logic.extensions.wisdomcourageclg.model.WisdomCourageClgModel", package.seeall)

local WisdomCourageClgModel = class("WisdomCourageClgModel", BaseModel)

function WisdomCourageClgModel:onInit()
	self:onReset()
end

function WisdomCourageClgModel:onReset()
	self._moPool = self._moPool or {}

	for key, mo in pairs(self._moPool) do
		mo:dispose()

		self._moPool[key] = nil
	end

	self._wisdomCourageClgBossFmtMo = nil
	self._wisdomCourageClgSupportFmtMo = nil
end

function WisdomCourageClgModel:getWisdomCourageClgMo(activityId)
	if self._moPool[activityId] == nil then
		self._moPool[activityId] = WisdomCourageClgMo.New(activityId)
	end

	return self._moPool[activityId]
end

function WisdomCourageClgModel:getWisdomCourageClgBossFmtMo()
	if self._wisdomCourageClgBossFmtMo == nil then
		self._wisdomCourageClgBossFmtMo = WisdomCourageClgBossFmtMo.New()
	end

	return self._wisdomCourageClgBossFmtMo
end

function WisdomCourageClgModel:getWisdomCourageClgSupportFmtMo()
	if self._wisdomCourageClgSupportFmtMo == nil then
		self._wisdomCourageClgSupportFmtMo = WisdomCourageClgSupportFmtMo.New()
	end

	return self._wisdomCourageClgSupportFmtMo
end

WisdomCourageClgModel.instance = WisdomCourageClgModel.New()

return WisdomCourageClgModel
