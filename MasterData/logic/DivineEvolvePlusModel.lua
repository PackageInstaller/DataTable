-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineevolveplus/model/DivineEvolvePlusModel.lua

module("logic.extensions.divineevolveplus.model.DivineEvolvePlusModel", package.seeall)

local DivineEvolvePlusModel = class("DivineEvolvePlusModel", BaseModel)

function DivineEvolvePlusModel:onInit()
	self:onReset()
end

function DivineEvolvePlusModel:onReset()
	return
end

DivineEvolvePlusModel.instance = DivineEvolvePlusModel.New()

return DivineEvolvePlusModel
