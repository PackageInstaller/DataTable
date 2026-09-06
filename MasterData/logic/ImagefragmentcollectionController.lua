-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/imagefragmentcollection/controller/ImagefragmentcollectionController.lua

local ImagefragmentcollectionController = class("ImagefragmentcollectionController", BaseController)

ImagefragmentcollectionController.PM_ImageFragmentCollectionReceiveMassPrizeRes = "ImagefragmentcollectionController.PM_ImageFragmentCollectionReceiveMassPrizeRes"
ImagefragmentcollectionController.PM_ImageFragmentCollectionMassRes = "ImagefragmentcollectionController.PM_ImageFragmentCollectionMassRes"
ImagefragmentcollectionController.PM_ImageFragmentCollectionReceiveImagePrizeRes = "ImagefragmentcollectionController.PM_ImageFragmentCollectionReceiveImagePrizeRes"
ImagefragmentcollectionController.PM_ImageFragmentCollectionActiveFragmentRes = "ImagefragmentcollectionController.PM_ImageFragmentCollectionActiveFragmentRes"
ImagefragmentcollectionController.PM_ImageFragmentCollectionInfoRes = "ImagefragmentcollectionController.PM_ImageFragmentCollectionInfoRes"
ImagefragmentcollectionController.PlayFragmentActiveEffect = "ImagefragmentcollectionController.PlayFragmentActiveEffect"

function ImagefragmentcollectionController:ctor()
	return
end

function ImagefragmentcollectionController:onInit()
	self:onReset()
	GlobalDispatcher:addListener(ImageFragmentCollectionAgent.PM_ImageFragmentCollectionReceiveMassPrizeRes, self._PM_ImageFragmentCollectionReceiveMassPrizeRes, self)
	GlobalDispatcher:addListener(ImageFragmentCollectionAgent.PM_ImageFragmentCollectionMassRes, self._PM_ImageFragmentCollectionMassRes, self)
	GlobalDispatcher:addListener(ImageFragmentCollectionAgent.PM_ImageFragmentCollectionReceiveImagePrizeRes, self._PM_ImageFragmentCollectionReceiveImagePrizeRes, self)
	GlobalDispatcher:addListener(ImageFragmentCollectionAgent.PM_ImageFragmentCollectionActiveFragmentRes, self._PM_ImageFragmentCollectionActiveFragmentRes, self)
	GlobalDispatcher:addListener(ImageFragmentCollectionAgent.PM_ImageFragmentCollectionInfoRes, self._PM_ImageFragmentCollectionInfoRes, self)
	GlobalDispatcher:addListener(GlobalNotify.StartEnterGame, self._onStartEnterGame, self)
end

function ImagefragmentcollectionController:onReset()
	self._activeCacheData = nil
	self._isEnterGame = false
end

function ImagefragmentcollectionController:openView()
	local actType = GameEnum.ActivityType.ImageFragmentCollection
	local cfgs = ActivityDefineConfig.instance:getCfgByActivityTypeId(actType)

	if cfgs then
		local activityId = false

		for k, v in pairs(cfgs) do
			if ActivityDefineController.instance:isInActivityTimeById(actType, v.activityId) then
				activityId = v.activityId

				break
			end
		end

		if activityId then
			UIStateManager.instance:push(ViewName.ImagefragmentcollectionmainView, activityId)
		else
			FloatWordMgr.instance:show("不在活动开放时间内")
		end
	end
end

function ImagefragmentcollectionController:_PM_ImageFragmentCollectionReceiveMassPrizeRes(status, msg)
	if status == 0 then
		ImagefragmentcollectionModel.instance:receiveMassPrizeRes(msg.receivedMassPrizeIds)
	end

	GlobalDispatcher:dispatch(ImagefragmentcollectionController.PM_ImageFragmentCollectionReceiveMassPrizeRes, status, msg)
end

function ImagefragmentcollectionController:_PM_ImageFragmentCollectionMassRes(status, msg)
	if status == 0 then
		FloatWordMgr.instance:show("集结成功")
		ImagefragmentcollectionModel.instance:CollectionMassRes(msg.curRegardValue)
	end

	GlobalDispatcher:dispatch(ImagefragmentcollectionController.PM_ImageFragmentCollectionMassRes, status, msg)
end

function ImagefragmentcollectionController:_PM_ImageFragmentCollectionReceiveImagePrizeRes(status, msg)
	if status == 0 then
		ImagefragmentcollectionModel.instance:ReceiveImagePrizeRes(msg.imageId, msg.imagePrizeState)
	end

	GlobalDispatcher:dispatch(ImagefragmentcollectionController.PM_ImageFragmentCollectionReceiveImagePrizeRes, status, msg)
end

function ImagefragmentcollectionController:_PM_ImageFragmentCollectionActiveFragmentRes(status, msg)
	if status == 0 then
		ImagefragmentcollectionModel.instance:collectionActiveFragmentRes(msg)
		self:_onActiveFragment()
	end

	GlobalDispatcher:dispatch(ImagefragmentcollectionController.PM_ImageFragmentCollectionActiveFragmentRes, status, msg)
end

function ImagefragmentcollectionController:_PM_ImageFragmentCollectionInfoRes(status, msg)
	if status == 0 then
		ImagefragmentcollectionModel.instance:setCollectionInfo(msg)
	end

	GlobalDispatcher:dispatch(ImagefragmentcollectionController.PM_ImageFragmentCollectionInfoRes, status, msg)
end

function ImagefragmentcollectionController:sendActiveFragmentReq(funcParams)
	local cfg = ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.ImageFragmentCollection)

	if cfg then
		local imgId, fragmentId = funcParams[1], funcParams[2]

		self:_setActiveCache(imgId, fragmentId)
		ImageFragmentCollectionAgent.instance:sendPM_ImageFragmentCollectionActiveFragmentReq(cfg.activityId, imgId, fragmentId)
	end
end

function ImagefragmentcollectionController:_setActiveCache(imgId, fragmentId)
	self._activeCacheData = self._activeCacheData or {}
	self._activeCacheData[imgId] = {
		imgId = imgId,
		fragmentId = fragmentId
	}
end

function ImagefragmentcollectionController:getActiveCache()
	return self._activeCacheData
end

function ImagefragmentcollectionController:clearActiveCache()
	self._activeCacheData = nil
end

function ImagefragmentcollectionController:_onActiveFragment()
	if self._activeCacheData and next(self._activeCacheData) then
		for _, data in pairs(self._activeCacheData) do
			UIStateManager.instance:push(ViewName.ImagefragmentcollectiongetView, data.imgId, data.fragmentId)
		end
	end
end

function ImagefragmentcollectionController:_onStartEnterGame()
	self._isEnterGame = true

	settimer(2, self._onSecond, self)
end

function ImagefragmentcollectionController:_onSecond()
	if self._isEnterGame then
		self:_setNpcOpenState()
	end
end

function ImagefragmentcollectionController:_setNpcOpenState()
	local cfg = ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.ImageFragmentCollection)

	if cfg then
		local acfg = ImagefragmentcollectionConfig.instance:getCollectionCfg(cfg.activityId)
		local pcfgs = ImagefragmentcollectionConfig.instance:getPrizePlanCfgs(acfg.prizePlanId)

		for _, pcfg in ipairs(pcfgs) do
			local fcfgs = ImagefragmentcollectionConfig.instance:getFragmentPlanCfgs(pcfg.fragmentPlanId)

			for _, fcfg in ipairs(fcfgs) do
				local openTime = GameUtil.string2time(fcfg.openTime)
				local arr = string.split(fcfg.jumpTo, "#")
				local npcId = checknumber(arr[2])

				if npcId > 0 then
					if openTime < ServerTime.nowServerLook() then
						SceneNpcsMgr.instance:createNpc(npcId)
					else
						SceneNpcsMgr.instance:removeNpc(npcId)
					end
				end
			end
		end
	end
end

ImagefragmentcollectionController.instance = ImagefragmentcollectionController.New()

return ImagefragmentcollectionController
