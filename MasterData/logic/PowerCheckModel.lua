-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/handbook/model/PowerCheckModel.lua

module("logic.extensions.handbook.model.PowerCheckModel", package.seeall)

local PowerCheckModel = class("PowerCheckModel", BaseModel)

PowerCheckModel.TYPE_NONE = 0
PowerCheckModel.TYPE_LOW = 1
PowerCheckModel.TYPE_HIGH = 2

function PowerCheckModel:ctor()
	PowerCheckModel.super.ctor(self)
end

function PowerCheckModel:onInit()
	self:onReset()
end

function PowerCheckModel:onReset()
	self.currSelectedPetId = -1

	self:resetInfo()

	self.rankList = {}
	self.myRank = -1
	self.bHasGainPrize = false
	self.rankSize = 0
end

function PowerCheckModel:resetInfo()
	self.areaMaxZdl = 0
	self.myZdl = 0
	self.overPercent = -1
	self.myExZdl = 0
end

function PowerCheckModel:setPetZdlInfo(msg)
	self.areaMaxZdl = msg.spaceMaxZdl
	self.myZdl = msg.myZdl
	self.overPercent = msg.overPercent
	self.myExZdl = msg.myExZdl
end

function PowerCheckModel:onGetRaceZdlRankReq(msg)
	self.rankList = msg.rankList
	self.myRank = msg.myRank
	self.bHasGainPrize = msg.isGainRankPrize
	self.rankSize = msg.rankSize
end

PowerCheckModel.instance = PowerCheckModel.New()

return PowerCheckModel
