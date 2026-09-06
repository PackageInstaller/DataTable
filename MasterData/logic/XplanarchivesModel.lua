-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xplanarchives/model/XplanarchivesModel.lua

module("logic.extensions.xplanarchives.view.XplanarchivesModel", package.seeall)

local XplanarchivesModel = class("XplanarchivesModel", BaseModel)

function XplanarchivesModel:ctor()
	return
end

function XplanarchivesModel:onInit()
	self:onReset()
end

function XplanarchivesModel:onReset()
	self._msgInfos = {}
end

function XplanarchivesModel:setInfo(msg)
	self._msgInfos[msg.activityId] = GameUtil.pbToTable(msg)
end

function XplanarchivesModel:getInfo(activityId)
	return self._msgInfos[activityId]
end

function XplanarchivesModel:isGainPrize(activityId, prizeId)
	local info = self:getInfo(activityId)

	if not info.gainedPrizeId then
		return false
	end

	for i, v in ipairs(info.gainedPrizeId) do
		if v == prizeId then
			return true
		end
	end
end

function XplanarchivesModel:canGainPrize(activityId, prizeId)
	if self:isGainPrize(activityId, prizeId) then
		return false
	end

	local info = self:getInfo(activityId)
	local prizeCfg = XplanarchivesConfig.instance:getProgressCfg(activityId, prizeId)
	local progress = 0

	for i, v in ipairs(info.types) do
		progress = progress + v.curId

		if progress >= prizeCfg.need then
			return true
		end
	end
end

function XplanarchivesModel:updateGainPrizeId(msg)
	local info = self:getInfo(msg.activityId)

	info.gainedPrizeId = info.gainedPrizeId or {}

	table.insert(info.gainedPrizeId, msg.prizeId)
end

function XplanarchivesModel:unlockArchives(activityId, typeId, id)
	local info = self:getInfo(activityId)

	for i, v in ipairs(info.types) do
		if v.typeId == typeId then
			v.curId = id

			break
		end
	end
end

function XplanarchivesModel:getProgress(activityId)
	local info = self:getInfo(activityId)

	if not info then
		return 0
	end

	local progress = 0

	for i, v in ipairs(info.types) do
		progress = progress + v.curId
	end

	return progress
end

XplanarchivesModel.instance = XplanarchivesModel.New()

return XplanarchivesModel
