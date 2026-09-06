-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/gathertask/model/GatherTaskModel.lua

module("logic.extensions.gathertask.model.GatherTaskModel", package.seeall)

local GatherTaskModel = class("GatherTaskModel", BaseModel)

function GatherTaskModel:ctor()
	GatherTaskModel.super.ctor(self)
end

function GatherTaskModel:onInit()
	self:onReset()
end

function GatherTaskModel:onReset()
	self.matMap = {}
	self.score = 0
end

function GatherTaskModel:onGetInfo(msg)
	local curMaterialId = GameUtil.pbToTable(msg.curMaterialId)

	self.gainedPrizeIds = msg.CurGainProgressPrizeIds
	self.matMap = {}
	self.score = 0

	for i, v in ipairs(curMaterialId) do
		self.matMap[v.materialId] = v.gainNum
		self.score = self.score + v.gainNum
	end
end

function GatherTaskModel:getMatNum(id)
	return checknumber(self.matMap[id])
end

function GatherTaskModel:addMaterial(id)
	self.matMap[id] = checknumber(self.matMap[id]) + 1
	self.score = checknumber(self.score) + 1
end

function GatherTaskModel:addPrizeId(id)
	self.gainedPrizeIds = self.gainedPrizeIds or {}

	table.insert(self.gainedPrizeIds, id)
end

GatherTaskModel.instance = GatherTaskModel.New()

return GatherTaskModel
