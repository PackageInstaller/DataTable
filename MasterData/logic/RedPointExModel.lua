-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/redpointex/model/RedPointExModel.lua

module("logic.extensions.redpointex.model.RedPointExModel", package.seeall)

local RedPointExModel = class("RedPointExModel", BaseModel)

function RedPointExModel:ctor()
	return
end

function RedPointExModel:onInit()
	self:onReset()
end

function RedPointExModel:onReset()
	return
end

RedPointExModel.instance = RedPointExModel.New()

return RedPointExModel
