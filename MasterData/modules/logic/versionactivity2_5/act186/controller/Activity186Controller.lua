-- chunkname: @modules/logic/versionactivity2_5/act186/controller/Activity186Controller.lua

module("modules.logic.versionactivity2_5.act186.controller.Activity186Controller", package.seeall)

local Activity186Controller = class("Activity186Controller", BaseController)

function Activity186Controller:onInit()
	return
end

function Activity186Controller:addConstEvents()
	return
end

function Activity186Controller:reInit()
	return
end

function Activity186Controller:setPlayerPrefs(key, value)
	if string.nilorempty(key) or not value then
		return
	end

	local isNumber = type(value) == "number"

	if isNumber then
		GameUtil.playerPrefsSetNumberByUserId(key, value)
	else
		GameUtil.playerPrefsSetStringByUserId(key, value)
	end

	self:dispatchEvent(Activity186Event.LocalKeyChange)
end

function Activity186Controller:getPlayerPrefs(key, defaultValue)
	local value = defaultValue or ""

	if string.nilorempty(key) then
		return value
	end

	local isNumber = type(value) == "number"

	value = isNumber and GameUtil.playerPrefsGetNumberByUserId(key, value) or GameUtil.playerPrefsGetStringByUserId(key, value)

	return value
end

function Activity186Controller:checkEnterGame(activityId, includeOldGame)
	local mo = Activity186Model.instance:getById(activityId)

	if not mo then
		return
	end

	local list = mo:getOnlineGameList()

	if not list or #list == 0 then
		return
	end

	local gameInfo = list[1]

	if not includeOldGame then
		gameInfo = nil

		for i, v in ipairs(list) do
			local value = Activity186Model.instance:getLocalPrefsState(Activity186Enum.LocalPrefsKey.GameMark, activityId, v.gameId, 0)

			if value == 0 then
				gameInfo = v

				break
			end
		end
	end

	if gameInfo then
		Activity186Model.instance:setLocalPrefsState(Activity186Enum.LocalPrefsKey.GameMark, activityId, gameInfo.gameId, 1)
		ViewMgr.instance:openView(ViewName.Activity186GameInviteView, {
			activityId = activityId,
			gameId = gameInfo.gameId,
			gameStatus = Activity186Enum.GameStatus.Start,
			gameType = gameInfo.gameTypeId
		})
	end
end

function Activity186Controller:enterGame(activityId, gameId)
	if not activityId or not gameId then
		return
	end

	local mo = Activity186Model.instance:getById(activityId)

	if not mo then
		return
	end

	if not mo:isGameOnline(gameId) then
		return
	end

	local gameInfo = mo:getGameInfo(gameId)

	if not gameInfo then
		return
	end

	if gameInfo.gameTypeId == 1 then
		ViewMgr.instance:openView(ViewName.Activity186GameInviteView, {
			activityId = activityId,
			gameId = gameId,
			gameStatus = Activity186Enum.GameStatus.Playing
		})
	else
		ViewMgr.instance:openView(ViewName.Activity186GameDrawlotsView, {
			activityId = activityId,
			gameId = gameId,
			gameStatus = Activity186Enum.GameStatus.Playing
		})
	end
end

function Activity186Controller:openTaskView()
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Activity173
	}, self._onOpenTaskView, self)
end

function Activity186Controller:_onOpenTaskView()
	local actId = Activity186Model.instance:getActId()

	ViewMgr.instance:openView(ViewName.Activity186TaskView, {
		actId = actId
	})
end

Activity186Controller.instance = Activity186Controller.New()

return Activity186Controller
