-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddessdelicacy/controller/GoddessDelicacyController.lua

module("logic.extensions.goddessdelicacy.controller.GoddessDelicacyController", package.seeall)

local GoddessDelicacyController = class("GoddessDelicacyController", BaseController)

function GoddessDelicacyController:ctor()
	self.lockFinish = 1
	self.unLockFinish = 2
end

function GoddessDelicacyController:onInit()
	GoddessDelicacyController.super.onInit(self)
	self:onReset()
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self._TickDailyRefreshData, self)
end

function GoddessDelicacyController:onReset()
	self._chosPrizeId = nil
end

function GoddessDelicacyController:_TickDailyRefreshData()
	if ViewMgr.instance:isOpen(ViewName.GoddessVote) then
		self:csRequestGVGetInfoReq()
	end
end

function GoddessDelicacyController:csRequestFoodNotesGetInfoReq(actId)
	FoodNotesAgent.instance:sendPM_FoodNotesGetInfoReq(actId)
end

function GoddessDelicacyController:scPushFoodNotesGetInfo(msg)
	GoddessDelicacyModel.instance:scPushFoodNotesGetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.UpdataGoddessDelicacyInfo)
end

function GoddessDelicacyController:csRequestFoodNotesCookReq(actId, foodIds)
	local req = FoodNotesExtension_pb.PM_FoodNotesCookReq()

	req.activityId = actId

	for i = 1, #foodIds do
		req.foodId:append(foodIds[i])
	end

	FoodNotesAgent.instance:sendPM_FoodNotesCookReq(req)
end

function GoddessDelicacyController:scPushFoodNotesCook(msg)
	if msg == nil then
		return
	end

	local isOpen = false
	local info = GoddessDelicacyModel.instance:getGoddessInfo()

	if msg.cookDishId > 0 and info and info.todayDishes and table.indexof(info.todayDishes, msg.cookDishId) then
		isOpen = true
	end

	MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
	GoddessDelicacyModel.instance:scPushFoodNotesCook(msg)

	local params = {
		cookDishId = msg.cookDishId,
		dishState = msg.dishState,
		changeSetId = msg.changeSetId,
		isOpen = isOpen
	}

	GlobalDispatcher:dispatch(GlobalNotify.UpdataGoddessDelicacyCook, params)
end

function GoddessDelicacyController:csRequestFoodNotesGainPrizeReq(actId, prizeId)
	self._chosPrizeId = prizeId

	FoodNotesAgent.instance:sendPM_FoodNotesGainPrizeReq(actId, prizeId)
end

function GoddessDelicacyController:scPushFoodNotesGainPrize(msg)
	GoddessDelicacyModel.instance:scPushFoodNotesGainPrize(self._chosPrizeId)
	GlobalDispatcher:dispatch(GlobalNotify.UpdataGoddessDelicacyPrize)

	self._chosPrizeId = nil
end

GoddessDelicacyController.instance = GoddessDelicacyController.New()

return GoddessDelicacyController
