-- chunkname: @modules/logic/versionactivity2_4/dungeon/controller/VersionActivity2_4DungeonController.lua

module("modules.logic.versionactivity2_4.dungeon.controller.VersionActivity2_4DungeonController", package.seeall)

local VersionActivity2_4DungeonController = class("VersionActivity2_4DungeonController", BaseController)

function VersionActivity2_4DungeonController:onInit()
	return
end

function VersionActivity2_4DungeonController:reInit()
	return
end

function VersionActivity2_4DungeonController:openTaskView()
	local typeIds = {
		TaskEnum.TaskType.ActivityDungeon
	}

	TaskRpc.instance:sendGetTaskInfoRequest(typeIds, self._openTaskViewAfterRpc, self)
end

function VersionActivity2_4DungeonController:_openTaskViewAfterRpc()
	ViewMgr.instance:openView(ViewName.VersionActivity2_4TaskView)
end

function VersionActivity2_4DungeonController:openStoreView()
	local actId = VersionActivity2_4Enum.ActivityId.DungeonStore

	if not VersionActivityEnterHelper.checkCanOpen(actId) then
		return
	end

	Activity107Rpc.instance:sendGet107GoodsInfoRequest(actId, self._openStoreViewAfterRpc, self)
end

function VersionActivity2_4DungeonController:_openStoreViewAfterRpc()
	ViewMgr.instance:openView(ViewName.VersionActivity2_4StoreView)
end

function VersionActivity2_4DungeonController:openVersionActivityDungeonMapView(chapterId, episodeId, callback, callbackObj)
	self.dungeonMapViewParam = {
		chapterId = chapterId,
		episodeId = episodeId
	}
	self.openMapViewCallback = callback
	self.openMapViewCallbackObj = callbackObj

	VersionActivity2_4DungeonModel.instance:init()

	self.hasReceivedTaskInfo = false

	local typeIds = {
		TaskEnum.TaskType.ActivityDungeon
	}

	TaskRpc.instance:sendGetTaskInfoRequest(typeIds, self._onReceiveTaskInfoReply, self)
	Activity113Rpc.instance:sendGetAct113InfoRequest(VersionActivity2_4Enum.ActivityId.Dungeon)
end

function VersionActivity2_4DungeonController:_onReceiveTaskInfoReply()
	self.hasReceivedTaskInfo = true

	self:_internalOpenVersionActivityDungeonMapView()
end

function VersionActivity2_4DungeonController:_internalOpenVersionActivityDungeonMapView()
	if not self.hasReceivedTaskInfo then
		return
	end

	self.hasReceivedTaskInfo = false

	if not self.dungeonMapViewParam.episodeId then
		local unFinishEpisodeId = VersionActivity2_4DungeonModel.instance:getUnFinishElementEpisodeId()

		if unFinishEpisodeId > 0 then
			self.dungeonMapViewParam.episodeId = unFinishEpisodeId
		end
	end

	ViewMgr.instance:openView(ViewName.VersionActivity2_4DungeonMapView, self.dungeonMapViewParam)
end

function VersionActivity2_4DungeonController:onVersionActivityDungeonMapViewOpen()
	if not self.openMapViewCallback then
		return
	end

	self.openMapViewCallback(self.openMapViewCallbackObj)

	self.openMapViewCallback = nil
	self.openMapViewCallbackObj = nil
end

local function prefabKeyAddActId(key)
	if string.nilorempty(key) then
		return key
	end

	return (string.format("2_0Dungeon_%s_%s", VersionActivity2_4Enum.ActivityId.Dungeon, key))
end

function VersionActivity2_4DungeonController:savePlayerPrefs(key, value)
	if string.nilorempty(key) or not value then
		return
	end

	local uniqueKey = prefabKeyAddActId(key)
	local isNumber = type(value) == "number"

	if isNumber then
		GameUtil.playerPrefsSetNumberByUserId(uniqueKey, value)
	else
		GameUtil.playerPrefsSetStringByUserId(uniqueKey, value)
	end
end

function VersionActivity2_4DungeonController:getPlayerPrefs(key, defaultValue)
	local value = defaultValue or ""

	if string.nilorempty(key) then
		return value
	end

	local uniqueKey = prefabKeyAddActId(key)
	local isNumber = type(value) == "number"

	value = isNumber and GameUtil.playerPrefsGetNumberByUserId(uniqueKey, value) or GameUtil.playerPrefsGetStringByUserId(uniqueKey, value)

	return value
end

function VersionActivity2_4DungeonController:loadDictFromStr(jsonStr)
	return (not string.nilorempty(jsonStr) or nil) and cjson.decode(jsonStr)
end

VersionActivity2_4DungeonController.instance = VersionActivity2_4DungeonController.New()

return VersionActivity2_4DungeonController
