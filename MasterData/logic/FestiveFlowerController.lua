-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/festiveflower/controller/FestiveFlowerController.lua

module("logic.extensions.festiveflower.controller.FestiveFlowerController", package.seeall)

local FestiveFlowerController = class("FestiveFlowerController", BaseController)

FestiveFlowerController.E_InfoRes = "E_InfoRes"
FestiveFlowerController.E_FlowerInfoRes = "E_FlowerInfoRes"
FestiveFlowerController.E_GetRankRes = "E_GetRankRes"
FestiveFlowerController.E_BuyFlowerRes = "E_BuyFlowerRes"
FestiveFlowerController.E_GainPrizeRes = "E_GainPrizeRes"
FestiveFlowerController.E_FreeFlowerRes = "E_FreeFlowerRes"

function FestiveFlowerController:ctor()
	return
end

function FestiveFlowerController:onInit()
	GlobalDispatcher:addListener(GlobalNotify.RoleLogined, self._resetRedPoint, self)
	self:onReset()
end

function FestiveFlowerController:onReset()
	self:_clearCacheGroup()
end

function FestiveFlowerController:_resetRedPoint()
	local activityId = FestiveFlowerModel.instance:getActivityId()
	local activityConf = ActivityDefineConfig.instance:getCfgById(GameEnum.ActivityType.FESTIVE_FLOWER, activityId)

	if activityConf and GameUtil.checkIsInTimePeriod(activityConf.startTime, activityConf.endTime) then
		GameUtil.whenLocalDataInited(function()
			RedPointController.instance:regUserOnceRedPoint(RedPointModel.ID_FESTIVE_FLOWER_ONCE)
		end)
	end
end

function FestiveFlowerController:isIgnoreFlowerAnim()
	return FestiveFlowerModel.instance.ignoreFlowerAnim
end

function FestiveFlowerController:setIgnoreFlowerAnim(value)
	FestiveFlowerModel.instance.ignoreFlowerAnim = value
end

function FestiveFlowerController:handleFestiveFlowerInfoRes(status, msg)
	if status == 0 then
		FestiveFlowerModel.instance:handleFestiveFlowerInfoRes(msg)
		self:localNotify(FestiveFlowerController.E_InfoRes)
	end
end

function FestiveFlowerController:handleFestiveFlowerFlowerInfoRes(status, msg)
	if status == 0 then
		FestiveFlowerModel.instance:handleFestiveFlowerFlowerInfoRes(msg)
		self:localNotify(FestiveFlowerController.E_FlowerInfoRes)
	end
end

function FestiveFlowerController:handleFestiveFlowerFlowerGetRankRes(status, msg)
	self:localNotify(FestiveFlowerController.E_GetRankRes, status, msg)
end

function FestiveFlowerController:reqBuyFlower(flowerId)
	FestiveFlowerModel.instance:beforeBuyFlower(flowerId)
	FestiveFlowerAgent.instance:sendPM_FestiveFlowerBuyFlowerReq(FestiveFlowerModel.instance:getActivityId(), flowerId)
end

function FestiveFlowerController:handleFestiveFlowerBuyFlowerRes(status, msg)
	if status == 0 then
		FestiveFlowerModel.instance:handleFestiveFlowerBuyFlowerRes(msg)
		self:_showChangeSetNow(msg)
		self:localNotify(FestiveFlowerController.E_BuyFlowerRes)
	end
end

function FestiveFlowerController:reqGainPrize(prizeId)
	FestiveFlowerModel.instance:beforeGainPrize(prizeId)
	FestiveFlowerAgent.instance:sendPM_FestiveFlowerGainPrizeReq(FestiveFlowerModel.instance:getActivityId(), prizeId)
end

function FestiveFlowerController:handleFestiveFlowerGainPrizeRes(status, msg)
	if status == 0 then
		FestiveFlowerModel.instance:handleFestiveFlowerGainPrizeRes(msg)
		self:_showChangeSetNow(msg)
		self:localNotify(FestiveFlowerController.E_GainPrizeRes)
	end
end

function FestiveFlowerController:handleNotifyGainFreeFlowerRes(status, msg)
	if status == 0 then
		self:_showChangeSetNow(msg)
		FestiveFlowerModel.instance:handleNotifyGainFreeFlowerRes(msg)
		self:localNotify(FestiveFlowerController.E_FreeFlowerRes)
	end
end

function FestiveFlowerController:_showChangeSetNow(msg)
	local changeSetId = msg.changeSetId

	MaterialController.instance:saveChangeSetToTemp(changeSetId)
	MaterialController.instance:showChangeSetInTemp(changeSetId)
end

function FestiveFlowerController:_clearCacheGroup()
	self._cacheUserIdGroupArray = {}
	self._cacheUserIdGroupMap = {}
end

function FestiveFlowerController:_tryAdd2CacheGroup(userIdA, userIdB)
	local key = string.format("%s_%s", tostring(userIdA), tostring(userIdB))

	printInfo(key)

	local info = self._cacheUserIdGroupMap[key]
	local now = ServerTime.now()

	if not info then
		local actConfig = FestiveFlowerConfig.instance:getFestiveFlowerActConf(FestiveFlowerModel.instance:getActivityId()) or {}

		info = {
			key = key,
			cd = checknumber(actConfig.cacheMaxCD) + now
		}
		self._cacheUserIdGroupMap[key] = info

		table.insert(self._cacheUserIdGroupArray, info)

		if #self._cacheUserIdGroupArray > checknumber(actConfig.cacheMaxLength) then
			local infoT = self._cacheUserIdGroupArray[1]

			table.remove(self._cacheUserIdGroupArray, 1)

			if infoT and not string.nilorempty(infoT.key) then
				self._cacheUserIdGroupMap[infoT.key] = nil
			end
		end

		return true
	end

	return now > info.cd
end

function FestiveFlowerController:tryToPlayMainAnim(params)
	if not self:isIgnoreFlowerAnim() then
		local flowerId = checknumber(params.flowerId)
		local flowerDefine = SendFlowerConfig.instance:getFlowerCfg(flowerId)

		if flowerDefine and not string.nilorempty(flowerDefine.mainEffPath) and self:_tryAdd2CacheGroup(params.sdUId, params.recvUId) then
			local actConfig = FestiveFlowerConfig.instance:getFestiveFlowerActConf(FestiveFlowerModel.instance:getActivityId()) or {}

			MainUISequencePopupController.instance:regSequence({
				showType = MainUISequencePopupController.ViewType_Open,
				viewNameOrPath = ViewName.FlowerAnimaView,
				otherArg = params,
				cd = checknumber(actConfig.cacheMaxRecordCD) + ServerTime.now(),
				onBeforeStart = function()
					return self:isIgnoreFlowerAnim()
				end
			})
		end
	end
end

FestiveFlowerController.instance = FestiveFlowerController.New()

return FestiveFlowerController
