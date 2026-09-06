-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tabframework/model/TabFrameWorkModel.lua

module("logic.extensions.tabframework.model.TabFrameWorkModel", package.seeall)

local TabFrameWorkModel = class("TabFrameWorkModel", BaseModel)

function TabFrameWorkModel:ctor()
	return
end

function TabFrameWorkModel:onInit()
	self:onReset()
end

function TabFrameWorkModel:onReset()
	return
end

TabFrameWorkModel.instance = TabFrameWorkModel.New()

return TabFrameWorkModel
