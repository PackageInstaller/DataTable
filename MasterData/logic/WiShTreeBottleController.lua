-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wishtreebottle/controller/WiShTreeBottleController.lua

module("logic.extensions.wishtreebottle.controller.WiShTreeBottleController", package.seeall)

local WiShTreeBottleController = class("WiShTreeBottleController", BaseController)

function WiShTreeBottleController:ctor()
	return
end

function WiShTreeBottleController:onInit()
	self:onReset()
	GlobalDispatcher:addListener(GlobalNotify.OnMaterialGet, self.lightRd, self)
end

function WiShTreeBottleController:onReset()
	self.wishTreeBottleInfo = {}
end

function WiShTreeBottleController:sendPM_WishTreeBottleInfoReq(activityId)
	WishTreeBottleAgent.instance:sendPM_WishTreeBottleInfoReq(activityId)
end

function WiShTreeBottleController:handlePM_WishTreeBottleInfoRes(status, msg)
	WiShTreeBottleModel.instance:setInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.WishTreeBottleInfoRes, msg)
end

function WiShTreeBottleController:sendPM_WishTreeBottleViewReq(activityId)
	WishTreeBottleAgent.instance:sendPM_WishTreeBottleViewReq(activityId)
end

function WiShTreeBottleController:handlePM_WishTreeBottleViewRes(status, msg)
	WiShTreeBottleModel.instance:setRankInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.WishTreeBottleViewRes)
end

function WiShTreeBottleController:sendPM_WishTreeBottleLikeReq(activityId, targetUserId)
	WishTreeBottleAgent.instance:sendPM_WishTreeBottleLikeReq(activityId, targetUserId)
end

function WiShTreeBottleController:handlePM_WishTreeBottleLikeRes(status, msg)
	WiShTreeBottleModel.instance:addDailylikeNum()
	WiShTreeBottleModel.instance:addLikeIds(msg.targetUserId)

	local myWish = WiShTreeBottleModel.instance:getWishBottle()

	if myWish and msg.targetUserId == myWish.userId then
		myWish.likeNum = myWish.likeNum + 1
	end

	GlobalDispatcher:dispatch(GlobalNotify.WishTreeBottleLikeRes)
end

function WiShTreeBottleController:sendPM_WishTreeBottleSendReq(activityId, typeId, titleId, content)
	WishTreeBottleAgent.instance:sendPM_WishTreeBottleSendReq(activityId, typeId, titleId, content)
end

function WiShTreeBottleController:handlePM_WishTreeBottleSendRes(status, msg)
	GlobalDispatcher:dispatch(GlobalNotify.WishTreeBottleSendRes)
end

function WiShTreeBottleController:lightRd()
	local itemStr = OperationSummaryConfig.instance:getPluginProgressPlanCfg(328001, 1).materialId
	local matType, matId, matNum = MaterialMgr.getMatParams(itemStr)
	local hasCount = MaterialModel.instance:getMaterialsNumber(matType, matId)

	if hasCount > 0 then
		RedPointController.instance:setRedPointInfo(RedPointModel.ID_WISHTREEBOTTLE, true)
	else
		RedPointController.instance:setRedPointInfo(RedPointModel.ID_WISHTREEBOTTLE, false)
	end
end

function WiShTreeBottleController:isSendWish()
	local myBottle = WiShTreeBottleModel.instance:getWishBottle()

	return checkbool(myBottle)
end

function WiShTreeBottleController:bottleIsLiked(userId)
	local likeIds = WiShTreeBottleModel.instance:getDailyLikeIds()

	if likeIds then
		for i, v in ipairs(likeIds) do
			if checknumber(v) == checknumber(userId) then
				return true
			end
		end
	end

	return false
end

function WiShTreeBottleController:getMyBottleIdInTree(treeData)
	local myBottle = WiShTreeBottleModel.instance:getWishBottle()

	if myBottleId == nil then
		return 0
	end

	for i, v in ipairs(treeData) do
		if v.userId == myBottle.userId then
			return i
		end
	end

	return 0
end

function WiShTreeBottleController:bottleRefreshData(activityId, baseData, wishTotalCount, refreshBottleList)
	local treeData = baseData
	local refershCount = #refreshBottleList

	if refershCount <= 0 then
		refershCount = wishTotalCount
	end

	local refreshData = self:bottleRankData(activityId, treeData, refershCount)

	if #refreshBottleList > 0 then
		for i, v in ipairs(refreshBottleList) do
			if refreshData[i] then
				treeData[v] = refreshData[i]
			end
		end
	else
		treeData = refreshData
	end

	return treeData
end

function WiShTreeBottleController:bottleRankData(activityId, baseData, count)
	local hotsData = WiShTreeBottleModel.instance:getHotRankInfo()
	local newsData = WiShTreeBottleModel.instance:getHotRankInfo()
	local systemData = WiShTreeBottleConfig.instance:getWtbSystemCfg(activityId)
	local wishTreeData = {}
	local wishData = {}
	local index = 0

	for _, base in ipairs(baseData) do
		wishTreeData[base.userId] = base
	end

	if hotsData or newsData then
		for i, hot in ipairs(hotsData) do
			if count <= index then
				return wishData
			else
				local data = {}

				data = checknumber(hot.userId) < 0 and self:bottleInsertCfg(activityId, hot.userId, hot.likeNum) or hot

				if wishTreeData[data.userId] == nil then
					wishTreeData[data.userId] = data

					table.insert(wishData, data)

					index = index + 1
				end
			end
		end

		for _, new in ipairs(newsData) do
			if count <= index then
				return wishData
			else
				local data = {}

				data = checknumber(new.userId) < 0 and self:bottleInsertCfg(activityId, new.userId, new.likeNum) or new

				if wishTreeData[data.userId] == nil then
					wishTreeData[data.userId] = data

					table.insert(wishData, data)

					index = index + 1
				end
			end
		end

		for i, sys in ipairs(systemData) do
			if count <= index then
				return wishData
			else
				local data = self:bottleInsertCfg(activityId, sys.id, 0)
				local isAdd = true

				if #wishData > 0 then
					for _, tree in ipairs(wishData) do
						if sys.id == tree.userId then
							isAdd = false

							break
						end
					end
				end

				if isAdd and #baseData > 0 then
					for _, base in ipairs(baseData) do
						if sys.id == base.userId then
							isAdd = false

							break
						end
					end
				end

				if isAdd then
					index = index + 1

					table.insert(wishData, data)
				end
			end
		end
	end

	return wishData
end

function WiShTreeBottleController:bottleInsertCfg(activityId, id, likeNum)
	local data = {}
	local systemData = WiShTreeBottleConfig.instance:getWtbSystemCfg(activityId)
	local cfg = systemData[Mathf.Abs(id)]

	data.userId = id
	data.likeNum = likeNum
	data.typeId = cfg.typeId
	data.titleId = cfg.titleId
	data.content = cfg.content
	data.opHeadInfo = cfg.headicon
	data.name = cfg.name

	return data
end

WiShTreeBottleController.instance = WiShTreeBottleController.New()

return WiShTreeBottleController
