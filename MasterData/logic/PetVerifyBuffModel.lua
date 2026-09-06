-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petverify/model/PetVerifyBuffModel.lua

module("logic.extensions.petverify.model.PetVerifyBuffModel", package.seeall)

local PetVerifyBuffModel = class("PetVerifyBuffModel")

function PetVerifyBuffModel:ctor()
	return
end

function PetVerifyBuffModel:onInit()
	self:onReset()
end

function PetVerifyBuffModel:onReset()
	return
end

PetVerifyBuffModel.instance = PetVerifyBuffModel.New()

return PetVerifyBuffModel
