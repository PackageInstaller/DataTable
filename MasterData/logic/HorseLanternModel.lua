-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/horselantern/model/HorseLanternModel.lua

module("logic.extensions.horselantern.model.HorseLanternModel", package.seeall)

local HorseLanternModel = class("HorseLanternModel", BaseModel)

function HorseLanternModel:ctor()
	HorseLanternModel.super.ctor(self)
end

HorseLanternModel.instance = HorseLanternModel.New()

return HorseLanternModel
