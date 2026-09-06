-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/collectclothes/model/CollectClothesModel.lua

module("logic.extensions.collectclothes.model.CollectClothesModel", package.seeall)

local CollectClothesModel = class("CollectClothesModel", BaseModel)

function CollectClothesModel:ctor()
	self:onReset()
end

function CollectClothesModel:onInit()
	self:onReset()
end

function CollectClothesModel:onReset()
	self._gainPrizeMap = {}
	self.activityId = 0
	self.bInitData = false
	self.bLoadMountData = false
end

function CollectClothesModel:handleInfoRes(msg)
	local cfg = ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.COLLECT_CLOTHES_ACTIVITY)

	if cfg then
		self.activityId = cfg.activityId
	end

	self._gainPrizeMap = {}

	if not msg.hasGainPrizeId then
		for i, v in ipairs(msg.hasGainPrizeId) do
			self._gainPrizeMap[v] = true
		end

		self.bInitData = true
	end
end

function CollectClothesModel:handleGainPrizeRes(msg)
	self._gainPrizeMap[msg.prizeId] = true
end

function CollectClothesModel:isGainPrize(prizeId)
	return self._gainPrizeMap[prizeId] == true
end

function CollectClothesModel:getTotalProgress(confs)
	local result = 0

	for i, conf in ipairs(confs) do
		if self:isHasCollectGroup(conf) then
			result = result + 1
		end
	end

	return result
end

function CollectClothesModel:isHasCollectGroup(conf)
	if conf.type == 1 then
		for i, v in ipairs(conf.collections) do
			if not DressModel.instance:getIsOwnDressById(v) then
				return false
			end
		end

		return true
	elseif conf.type == 2 then
		for i, v in ipairs(conf.collections) do
			if not MountModel.instance:getLockmountsById(v) then
				return false
			end
		end

		return true
	else
		printError("类型错误，未实现", debug.traceback())
	end
end

CollectClothesModel.instance = CollectClothesModel.New()

return CollectClothesModel
