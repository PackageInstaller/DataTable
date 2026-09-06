-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/welfareequiprecycle/model/WelfareRecycleModel.lua

module("logic.extensions.welfareequiprecycle.model.WelfareRecycleModel", package.seeall)

local WelfareRecycleModel = class("WelfareRecycleModel", BaseModel)

function WelfareRecycleModel:ctor()
	return
end

function WelfareRecycleModel:onInit()
	self:onReset()
end

function WelfareRecycleModel:onReset()
	return
end

WelfareRecycleModel.instance = WelfareRecycleModel.New()

return WelfareRecycleModel
