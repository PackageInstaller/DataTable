-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinekunlun/model/DivineKunlunModel.lua

module("logic.extensions.divinekunlun.model.DivineKunlunModel", package.seeall)

local DivineKunlunModel = class("DivineKunlunModel", BaseModel)

function DivineKunlunModel:onInit()
	self:onReset()
end

function DivineKunlunModel:onReset()
	self._msgPool = {}
	self._norFightPool = {}
	self._extFightPool = {}
end

function DivineKunlunModel:onGetInfo(msg)
	self._msgPool[msg.activityId] = GameUtil.pbToTable(msg)
end

function DivineKunlunModel:getInfo(activityId)
	return self._msgPool[activityId]
end

function DivineKunlunModel:onGetNorPrize(msg)
	local activityId = msg.activityId
	local prizeId = msg.prizeId
	local info = self._msgPool[activityId]

	if info then
		info.gainNormalPrizeIds = info.gainNormalPrizeIds or {}

		table.insert(info.gainNormalPrizeIds, prizeId)
	end
end

function DivineKunlunModel:onGetExtPrize(msg)
	local activityId = msg.activityId
	local info = self._msgPool[activityId]

	if info then
		info.gainExtremePrize = true
	end
end

function DivineKunlunModel:handleNorFightRes(msg)
	self._norFightPool[msg.activityId] = GameUtil.pbToTable(msg)
end

function DivineKunlunModel:handleExtFightRes(msg)
	self._extFightPool[msg.activityId] = GameUtil.pbToTable(msg)
end

function DivineKunlunModel:getNorFightPb(activityId)
	return self._norFightPool[activityId]
end

function DivineKunlunModel:getExtFightPb(activityId)
	return self._extFightPool[activityId]
end

DivineKunlunModel.instance = DivineKunlunModel.New()

return DivineKunlunModel
