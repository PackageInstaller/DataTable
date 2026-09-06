-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holylight/model/HolyLightModel.lua

module("logic.extensions.holylight.model.HolyLightModel", package.seeall)

local HolyLightModel = class("HolyLightModel", BaseModel)

function HolyLightModel:ctor()
	return
end

function HolyLightModel:onInit()
	self:onReset()
end

function HolyLightModel:onReset()
	self._customFmtMo = nil
	self._rankMsg = nil
end

function HolyLightModel:handlePM_HolyLightGetInfoRes(msg)
	return
end

function HolyLightModel:handlePM_HolyLightGoRes(msg)
	return
end

function HolyLightModel:handlePM_HolyLightRandCreepsRes(msg)
	return
end

function HolyLightModel:handlePM_HolyLightChoiceCreepsRes(msg)
	return
end

function HolyLightModel:handlePM_HolyLightChallengeRes(status, msg)
	return
end

function HolyLightModel:handlePM_HolyLightChallengeResultRes(msg)
	return
end

function HolyLightModel:handlePM_HolyLightGetRankRes(msg)
	self._rankMsg = msg
end

function HolyLightModel:getCustomFmtMoAsHolyLight()
	if self._customFmtMo == nil then
		self._customFmtMo = HolyLightCustomFmtMo.New()
	end

	return self._customFmtMo
end

function HolyLightModel:getRankMsg()
	return self._rankMsg
end

HolyLightModel.instance = HolyLightModel.New()

return HolyLightModel
