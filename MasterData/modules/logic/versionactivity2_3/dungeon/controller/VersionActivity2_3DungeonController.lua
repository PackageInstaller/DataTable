-- chunkname: @modules/logic/versionactivity2_3/dungeon/controller/VersionActivity2_3DungeonController.lua

module("modules.logic.versionactivity2_3.dungeon.controller.VersionActivity2_3DungeonController", package.seeall)

local VersionActivity2_3DungeonController = class("VersionActivity2_3DungeonController", BaseController)

function VersionActivity2_3DungeonController:onInit()
	return
end

function VersionActivity2_3DungeonController:reInit()
	return
end

function VersionActivity2_3DungeonController:openTaskView()
	local typeIds = {
		TaskEnum.TaskType.ActivityDungeon
	}

	TaskRpc.instance:sendGetTaskInfoRequest(typeIds, self._openTaskViewAfterRpc, self)
end

function VersionActivity2_3DungeonController:_openTaskViewAfterRpc()
	ViewMgr.instance:openView(ViewName.VersionActivity2_3TaskView)
end

function VersionActivity2_3DungeonController:openStoreView()
	local dungeonActId = VersionActivity2_3Enum.ActivityId.Dungeon
	local reactivityDefine = ReactivityEnum.ActivityDefine[dungeonActId]

	if reactivityDefine then
		ReactivityController.instance:openReactivityStoreView(dungeonActId, ViewName.V2a3_ReactivityStoreView)

		return
	end

	local dungeonStoreActId = VersionActivity2_3Enum.ActivityId.DungeonStore

	if not VersionActivityEnterHelper.checkCanOpen(dungeonStoreActId) then
		return
	end

	Activity107Rpc.instance:sendGet107GoodsInfoRequest(dungeonStoreActId, self._openStoreViewAfterRpc, self)
end

function VersionActivity2_3DungeonController:_openStoreViewAfterRpc()
	ViewMgr.instance:openView(ViewName.VersionActivity2_3StoreView)
end

function VersionActivity2_3DungeonController:openVersionActivityDungeonMapView(chapterId, episodeId, callback, callbackObj)
	self.dungeonMapViewParam = {
		chapterId = chapterId,
		episodeId = episodeId
	}
	self.openMapViewCallback = callback
	self.openMapViewCallbackObj = callbackObj

	VersionActivity2_3DungeonModel.instance:init()

	self.hasReceivedTaskInfo = false

	local typeIds = {
		TaskEnum.TaskType.ActivityDungeon
	}

	TaskRpc.instance:sendGetTaskInfoRequest(typeIds, self._onReceiveTaskInfoReply, self)
	Activity113Rpc.instance:sendGetAct113InfoRequest(VersionActivity2_3Enum.ActivityId.Dungeon)
end

function VersionActivity2_3DungeonController:_onReceiveTaskInfoReply()
	self.hasReceivedTaskInfo = true

	self:_internalOpenVersionActivityDungeonMapView()
end

function VersionActivity2_3DungeonController:_internalOpenVersionActivityDungeonMapView()
	if not self.hasReceivedTaskInfo then
		return
	end

	self.hasReceivedTaskInfo = false

	if not self.dungeonMapViewParam.episodeId then
		local unFinishEpisodeId = VersionActivity2_3DungeonModel.instance:getInitEpisodeId()

		if unFinishEpisodeId > 0 then
			self.dungeonMapViewParam.episodeId = unFinishEpisodeId
		end
	end

	ViewMgr.instance:openView(ViewName.VersionActivity2_3DungeonMapView, self.dungeonMapViewParam)
end

function VersionActivity2_3DungeonController:onVersionActivityDungeonMapViewOpen()
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

	return (string.format("2_3Dungeon_%s_%s", VersionActivity2_3Enum.ActivityId.Dungeon, key))
end

function VersionActivity2_3DungeonController:savePlayerPrefs(key, value)
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

function VersionActivity2_3DungeonController:getPlayerPrefs(key, defaultValue)
	local value = defaultValue or ""

	if string.nilorempty(key) then
		return value
	end

	local uniqueKey = prefabKeyAddActId(key)
	local isNumber = type(value) == "number"

	value = isNumber and GameUtil.playerPrefsGetNumberByUserId(uniqueKey, value) or GameUtil.playerPrefsGetStringByUserId(uniqueKey, value)

	return value
end

function VersionActivity2_3DungeonController:loadDictFromStr(jsonStr)
	return (not string.nilorempty(jsonStr) or nil) and cjson.decode(jsonStr)
end

VersionActivity2_3DungeonController.instance = VersionActivity2_3DungeonController.New()

return VersionActivity2_3DungeonController
