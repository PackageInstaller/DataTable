-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petcv/model/PetCvModel.lua

module("logic.extensions.petcv.model.PetCvModel", package.seeall)

local PetCvModel = class("PetCvModel", BaseModel)

function PetCvModel:ctor()
	return
end

function PetCvModel:onInit()
	self:onReset()
end

function PetCvModel:onReset()
	self.hasLoadData = false
end

function PetCvModel:setHasLoadData(torf)
	self.hasLoadData = torf
end

function PetCvModel:getHasLoadData()
	return self.hasLoadData
end

PetCvModel.instance = PetCvModel.New()

return PetCvModel
