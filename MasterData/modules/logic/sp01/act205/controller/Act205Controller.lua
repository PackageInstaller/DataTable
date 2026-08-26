-- chunkname: @modules/logic/sp01/act205/controller/Act205Controller.lua

module("modules.logic.sp01.act205.controller.Act205Controller", package.seeall)

local Act205Controller = class("Act205Controller", BaseController)

function Act205Controller:onInit()
	return
end

function Act205Controller:reInit()
	return
end

function Act205Controller:addConstEvents()
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, self.onDailyRefresh, self)
end

function Act205Controller:onDailyRefresh()
	local isOpen = ActivityHelper.isOpen(Act205Enum.ActId)

	if not isOpen then
		return
	end

	Activity205Rpc.instance:sendAct205GetInfoRequest(Act205Enum.ActId, function()
		self:dispatchEvent(Act205Event.OnDailyRefresh)
	end, self)
end

function Act205Controller:openGameStartView(activityId)
	local isActOpen = Act205Model.instance:isAct205Open(true)

	if not isActOpen then
		return
	end

	self.activityId = activityId

	Activity205Rpc.instance:sendAct205GetInfoRequest(activityId, self.realOpenGameStartView, self)
end

function Act205Controller:realOpenGameStartView()
	local curOpenStageId = Act205Model.instance:getCurOpenGameStageId()

	if not curOpenStageId then
		GameFacade.showToast(ToastEnum.ActivityNotOpen)

		return
	end

	local viewParam = {}

	viewParam.activityId = self.activityId
	viewParam.gameStageId = curOpenStageId

	Activity205Rpc.instance:sendAct205GetGameInfoRequest(self.activityId)
	ViewMgr.instance:openView(ViewName.Act205GameStartView, viewParam)
end

function Act205Controller:openRuleTipsView()
	ViewMgr.instance:openView(ViewName.Act205RuleTipsView)
end

function Act205Controller:openOceanSelectView(param)
	local isGameOpen = Act205Model.instance:isGameStageOpen(Act205Enum.GameStageId.Ocean, true)

	if not isGameOpen then
		return
	end

	Activity205Rpc.instance:sendAct205GetGameInfoRequest(Act205Enum.ActId, function()
		ViewMgr.instance:openView(ViewName.Act205OceanSelectView, param)
	end, self)
end

function Act205Controller:openOceanShowView(param)
	local isGameOpen = Act205Model.instance:isGameStageOpen(Act205Enum.GameStageId.Ocean, true)

	if not isGameOpen then
		return
	end

	ViewMgr.instance:openView(ViewName.Act205OceanShowView, param)
	ViewMgr.instance:closeView(ViewName.Act205GameStartView)
end

function Act205Controller:openOceanResultView(param)
	ViewMgr.instance:openView(ViewName.Act205OceanResultView, param)
end

function Act205Controller:setPlayerPrefs(key, value)
	if string.nilorempty(key) or not value then
		return
	end

	local isNumber = type(value) == "number"

	if isNumber then
		GameUtil.playerPrefsSetNumberByUserId(key, value)
	else
		GameUtil.playerPrefsSetStringByUserId(key, value)
	end
end

function Act205Controller:getPlayerPrefs(key, defaultValue)
	local value = defaultValue or ""

	if string.nilorempty(key) then
		return value
	end

	local isNumber = type(value) == "number"

	value = isNumber and GameUtil.playerPrefsGetNumberByUserId(key, value) or GameUtil.playerPrefsGetStringByUserId(key, value)

	return value
end

Act205Controller.instance = Act205Controller.New()

return Act205Controller
