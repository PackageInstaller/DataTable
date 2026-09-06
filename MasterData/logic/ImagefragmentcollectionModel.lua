-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/imagefragmentcollection/model/ImagefragmentcollectionModel.lua

module("logic.extensions.imagefragmentcollection.view.ImagefragmentcollectionModel", package.seeall)

local ImagefragmentcollectionModel = class("ImagefragmentcollectionModel", BaseModel)

function ImagefragmentcollectionModel:ctor()
	return
end

function ImagefragmentcollectionModel:onInit()
	self:onReset()
end

function ImagefragmentcollectionModel:onReset()
	self._images = {}
	self._imagePrizeStates = {}
	self._curRegardValue = 0
	self._receivedMassPrizeIds = {}
	self._isMass = false
	self._isLoadData = false
	self._todayActiveTimes = 0
end

function ImagefragmentcollectionModel:setCollectionInfo(msg)
	self._isLoadData = true
	self._images = msg.images
	self._isMass = msg.isMass
	self._receivedMassPrizeIds = msg.receivedMassPrizeIds
	self._curRegardValue = msg.curRegardValue
	self._todayActiveTimes = msg.activeTimes
	self._imagePrizeStates = #msg.imagePrizeStates > 0 and GameUtil.pbToTable(msg.imagePrizeStates) or self._imagePrizeStates
end

function ImagefragmentcollectionModel:getCollectionProgress(imgId)
	return (self._images[imgId] or nil) and (#self._images[imgId].activatedImageFragmentIds or 0)
end

function ImagefragmentcollectionModel:checkFragmentIsCollection(imgId, fragmentId)
	if self._images[imgId] then
		for i, v in ipairs(self._images[imgId].activatedImageFragmentIds) do
			if v == fragmentId then
				return true
			end
		end
	end

	return false
end

function ImagefragmentcollectionModel:hasGetCollectionProgressPrize(imgId)
	return self._imagePrizeStates[imgId] and self._imagePrizeStates[imgId] == 2
end

function ImagefragmentcollectionModel:ReceiveImagePrizeRes(imageId, imagePrizeState)
	self._imagePrizeStates[imageId] = imagePrizeState
end

function ImagefragmentcollectionModel:isMassToday()
	return self._isMass
end

function ImagefragmentcollectionModel:CollectionMassRes(curRegardValue)
	self._curRegardValue = curRegardValue
	self._isMass = true
end

function ImagefragmentcollectionModel:getMassNum()
	return self._curRegardValue
end

function ImagefragmentcollectionModel:hasGetMassProgressPrize(id)
	for i, v in ipairs(self._receivedMassPrizeIds) do
		if v == id then
			return true
		end
	end

	return false
end

function ImagefragmentcollectionModel:receiveMassPrizeRes(ids)
	self._receivedMassPrizeIds = ids
end

function ImagefragmentcollectionModel:collectionActiveFragmentRes(msg, imagePrizeState)
	self._images = msg.image
	self._imagePrizeStates[msg.imageId] = msg.imagePrizeState
	self._todayActiveTimes = msg.activeTimes
end

function ImagefragmentcollectionModel:getTodayActiveTimes()
	return self._todayActiveTimes
end

function ImagefragmentcollectionModel:checkFragmentIsOpen(funcParams)
	if funcParams and #funcParams == 2 then
		local cfg = ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.ImageFragmentCollection)

		if cfg then
			local imgId, fragmentId = funcParams[1], funcParams[2]
			local acfg = ImagefragmentcollectionConfig.instance:getCollectionCfg(cfg.activityId)
			local pcfgs = ImagefragmentcollectionConfig.instance:getPrizePlanCfgs(acfg.prizePlanId)
			local pcfg = pcfgs[imgId]
			local fcfgs = ImagefragmentcollectionConfig.instance:getFragmentPlanCfgs(pcfg.fragmentPlanId)
			local fcfg = fcfgs[fragmentId]
			local openTime = GameUtil.string2time(fcfg.openTime)

			return openTime < ServerTime.nowServerLook()
		else
			printInfo("checkFragmentIsOpen 活动未开启")
		end
	else
		printError("t_function_state funcParams 配错 只能类似这种{1,1}")
	end

	return false
end

function ImagefragmentcollectionModel:checkFragmentIsFinish(funcParams)
	if not self._isLoadData then
		return true
	end

	if funcParams and #funcParams == 2 then
		local cfg = ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.ImageFragmentCollection)

		if cfg then
			local imgId, fragmentId = funcParams[1], funcParams[2]

			return self:checkFragmentIsCollection(imgId, fragmentId)
		else
			printInfo("checkFragmentIsOpen 活动未开启")
		end
	else
		printError("t_function_state funcParams 配错 只能类似这种{1,1}")
	end

	return false
end

ImagefragmentcollectionModel.instance = ImagefragmentcollectionModel.New()

return ImagefragmentcollectionModel
