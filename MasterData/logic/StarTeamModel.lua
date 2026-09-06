-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/starteam/model/StarTeamModel.lua

module("logic.extensions.starteam.model.StarTeamModel", package.seeall)

local StarTeamModel = class("StarTeamModel", BaseModel)

function StarTeamModel:ctor()
	StarTeamModel.super.ctor(self)
end

function StarTeamModel:onInit()
	self:onReset()
end

function StarTeamModel:onReset()
	self.hasGain = nil
end

function StarTeamModel:initData(msg)
	self.hasGain = msg.hasGain
end

function StarTeamModel:getHasGain()
	return self.hasGain
end

function StarTeamModel:setPrize(idx)
	self.hasGain[idx] = true
end

StarTeamModel.instance = StarTeamModel.New()

return StarTeamModel
