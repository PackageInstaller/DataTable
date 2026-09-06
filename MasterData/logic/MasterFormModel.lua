-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/masterform/model/MasterFormModel.lua

module("logic.extensions.masterform.model.MasterFormModel", package.seeall)

local MasterFormModel = class("MasterFormModel", BaseModel)

function MasterFormModel:ctor()
	return
end

function MasterFormModel:onInit()
	self:onReset()
end

function MasterFormModel:onReset()
	return
end

MasterFormModel.instance = MasterFormModel.New()

return MasterFormModel
