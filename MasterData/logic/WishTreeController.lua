-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wishtree/controller/WishTreeController.lua

module("logic.extensions.wishtree.controller.WishTreeController", package.seeall)

local WishTreeController = class("WishTreeController", BaseController)

function WishTreeController:ctor()
	return
end

function WishTreeController:onInit()
	return
end

function WishTreeController:onReset()
	self._wishTreeRpCache = nil
end

function WishTreeController:sendWishTreeInfoReq(activityId)
	IntoTheCarAgent.instance:sendPM_IntoTheCarWishTreeInfoReq(activityId)
end

function WishTreeController:handleWishTreeInfoRes(status, msg)
	if status == 0 then
		WishTreeModel.instance:handleWishTreeInfoRes(msg)
		RedPointController.instance:setRedPointInfo(RedPointModel.ID_WISH_TREE_CAN_WISH, self:checkWishTreeRp())
		GlobalDispatcher:dispatch(GlobalNotify.WishTreeGetInfoRes)
	end
end

function WishTreeController:sendSelectWishPrizeReq(activityId, indexId, prizeId)
	IntoTheCarAgent.instance:sendPM_IntoTheCarSelectWishPrizeReq(activityId, indexId, prizeId)
end

function WishTreeController:handleSelectWishPrizeRes(status, msg)
	if status == 0 then
		self._wishTreeRpCache = nil

		self:sendWishTreeInfoReq(WishTreeModel.instance:getActivityId())
	end
end

function WishTreeController:sendWishTreeGainPrizeReq(activityId, indexId)
	IntoTheCarAgent.instance:sendPM_IntoTheCarWishTreeGainPrizeReq(activityId, indexId)
end

function WishTreeController:handleWishTreeGainPrizeRes(status, msg)
	if status == 0 then
		local changeSetId = checknumber(msg.changeSetId)
		local matMos = MaterialModel.instance:getMaterialMos(changeSetId)
		local prizeStrList = {}

		for _, mo in ipairs(matMos) do
			local prizeStr = mo:toString()

			table.insert(prizeStrList, prizeStr)
		end

		MaterialController.instance:saveChangeSetToTemp(changeSetId)

		self._wishTreeRpCache = nil

		GlobalDispatcher:dispatch(GlobalNotify.WishTreeGainPrizeRes, changeSetId, prizeStrList)
		self:sendWishTreeInfoReq(WishTreeModel.instance:getActivityId())
	end
end

function WishTreeController.isGetAllWish()
	local activityId = WishTreeModel.instance:getActivityId()
	local cfgs = WishTreeConfig.instance:getWishTreeCfgsByActId(activityId)
	local wishList = WishTreeConfig.instance:getWishTreeWishCfgs(cfgs.wishPlanId)
	local items = WishTreeModel.instance:getItems()

	for i, v in ipairs(wishList) do
		local unlockTime = v.unlockTime
		local day = GameUtil.getDaysByTimestamp(ServerTime.now(), GameUtil.string2time(unlockTime)) - 1

		if day > 0 then
			return false
		else
			local isRecharge = WishTreeModel.instance:isRecharge()

			if items[i].gainedPrizeState == 2 or items[i].gainedPrizeState == 1 and not isRecharge then
				-- block empty
			else
				return false
			end
		end
	end

	return true
end

function WishTreeController:isEnoughAllWish()
	local activityId = WishTreeModel.instance:getActivityId()
	local cfgs = WishTreeConfig.instance:getWishTreeCfgsByActId(activityId)
	local wishList = WishTreeConfig.instance:getWishTreeWishCfgs(cfgs.wishPlanId)
	local items = WishTreeModel.instance:getItems()
	local type, id, num = MaterialMgr.getMatParams(cfgs.wishCost)
	local needCost = 0
	local haveNum = MaterialFacade.instance:getMatNumber(type, id)

	for i, v in ipairs(wishList) do
		local unlockTime = v.unlockTime
		local day = GameUtil.getDaysByTimestamp(ServerTime.now(), GameUtil.string2time(unlockTime)) - 1

		if day > 0 then
			return false
		else
			local isRecharge = WishTreeModel.instance:isRecharge()

			if items[i].gainedPrizeState == 2 or items[i].gainedPrizeState == 1 and not isRecharge then
				-- block empty
			else
				needCost = needCost + num
			end
		end
	end

	return needCost <= haveNum
end

function WishTreeController:checkWishTreeRp()
	if RedPointModel.instance:isActive(RedPointModel.ID_WISHTREE_TASK) then
		return true
	end

	if self._wishTreeRpCache then
		return self._wishTreeRpCache
	end

	local activityId = WishTreeModel.instance:getActivityId()
	local cfgs = WishTreeConfig.instance:getWishTreeCfgsByActId(activityId)
	local wishList = WishTreeConfig.instance:getWishTreeWishCfgs(cfgs.wishPlanId)
	local items = WishTreeModel.instance:getItems()

	self._wishTreeRpCache = false

	for i, v in ipairs(wishList) do
		local unlockTime = v.unlockTime
		local unlockCost = cfgs.wishCost
		local day = GameUtil.getDaysByTimestamp(ServerTime.now(), GameUtil.string2time(unlockTime)) - 1

		if day <= 0 then
			if items[i].selectedPrizeId == -1 then
				self._wishTreeRpCache = true

				break
			else
				local isEnough = self:isEnough(unlockCost)
				local isRecharge = WishTreeModel.instance:isRecharge()

				if items[i].gainedPrizeState == 0 and isEnough or items[i].gainedPrizeState == 1 and isEnough and isRecharge then
					self._wishTreeRpCache = true

					break
				end
			end
		end
	end

	return self._wishTreeRpCache
end

function WishTreeController:isEnough(unlockCost)
	local arr = string.split(unlockCost, "#")

	for i, v in ipairs(arr) do
		local type, id, num = MaterialMgr.getMatParams(v)

		if not MaterialModel.instance:IsEnough(type, id, num) then
			return false
		end
	end

	return true
end

WishTreeController.instance = WishTreeController.New()

return WishTreeController
