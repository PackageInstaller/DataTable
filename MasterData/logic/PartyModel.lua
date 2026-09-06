-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/party/model/PartyModel.lua

module("logic.extensions.party.model.PartyModel", package.seeall)

local PartyModel = class("PartyModel", BaseModel)

function PartyModel:ctor()
	return
end

function PartyModel:onInit()
	self:onReset()
end

function PartyModel:onReset()
	self._isHasGain = false
end

function PartyModel:getHasGainStaus()
	return self._isHasGain
end

function PartyModel:onGetInfo(msg)
	self._isHasGain = msg.gainedPrize
end

function PartyModel:onGainPrize(msg)
	self._isHasGain = true
end

PartyModel.instance = PartyModel.New()

return PartyModel
