-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mmteampassport/model/MMTeamPassportModel.lua

module("logic.extensions.mmteampassport.model.MMTeamPassportModel", package.seeall)

local MMTeamPassportModel = class("MMTeamPassportModel", BaseModel)

function MMTeamPassportModel:onInit()
	self:onReset()
end

function MMTeamPassportModel:onReset()
	self._moPool = self._moPool or {}

	for key, mo in pairs(self._moPool) do
		mo:dispose()

		self._moPool[key] = nil
	end
end

function MMTeamPassportModel:getSubMo(activityId)
	if self._moPool[activityId] == nil then
		self._moPool[activityId] = MMTeamPassportSubMo.New(activityId)
	end

	return self._moPool[activityId]
end

MMTeamPassportModel.instance = MMTeamPassportModel.New()

return MMTeamPassportModel
