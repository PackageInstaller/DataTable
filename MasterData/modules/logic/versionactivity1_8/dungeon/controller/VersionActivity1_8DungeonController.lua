-- chunkname: @modules/logic/versionactivity1_8/dungeon/controller/VersionActivity1_8DungeonController.lua

module("modules.logic.versionactivity1_8.dungeon.controller.VersionActivity1_8DungeonController", package.seeall)

local VersionActivity1_8DungeonController = class("VersionActivity1_8DungeonController", BaseController)

function VersionActivity1_8DungeonController:onInit()
	return
end

function VersionActivity1_8DungeonController:reInit()
	VersionActivityDungeonBaseController.instance:clearChapterIdLastSelectEpisodeId()
end

function VersionActivity1_8DungeonController:openVersionActivityDungeonMapView(chapterId, episodeId, callback, callbackObj)
	self.dungeonMapViewParam = {
		chapterId = chapterId,
		episodeId = episodeId
	}
	self.openMapViewCallback = callback
	self.openMapViewCallbackObj = callbackObj

	VersionActivity1_8DungeonModel.instance:init()

	self.hasReceivedTaskInfo = false
	self.hasReceivedDispatchInfo = false
	self.hasReceivedAct157Info = false

	local typeIds = {
		TaskEnum.TaskType.ActivityDungeon
	}

	TaskRpc.instance:sendGetTaskInfoRequest(typeIds, self._onReceiveTaskInfoReply, self)
	DispatchRpc.instance:sendGetDispatchInfoRequest(self._onReceiveDispatchInfoReply, self)
	Activity157Controller.instance:getAct157ActInfo(false, true, self._onReceiveAct157InfoReply, self)
	Activity113Rpc.instance:sendGetAct113InfoRequest(VersionActivity1_8Enum.ActivityId.Dungeon)
end

function VersionActivity1_8DungeonController:_onReceiveTaskInfoReply()
	self.hasReceivedTaskInfo = true

	self:_internalOpenVersionActivityDungeonMapView()
end

function VersionActivity1_8DungeonController:_onReceiveDispatchInfoReply()
	self.hasReceivedDispatchInfo = true

	self:_internalOpenVersionActivityDungeonMapView()
end

function VersionActivity1_8DungeonController:_onReceiveAct157InfoReply()
	self.hasReceivedAct157Info = true

	self:_internalOpenVersionActivityDungeonMapView()
end

function VersionActivity1_8DungeonController:_internalOpenVersionActivityDungeonMapView()
	if not self.hasReceivedTaskInfo or not self.hasReceivedDispatchInfo or not self.hasReceivedAct157Info then
		return
	end

	self.hasReceivedTaskInfo = false
	self.hasReceivedDispatchInfo = false
	self.hasReceivedAct157Info = false

	ViewMgr.instance:openView(ViewName.VersionActivity1_8DungeonMapView, self.dungeonMapViewParam)
end

function VersionActivity1_8DungeonController:openTaskView()
	local typeIds = {
		TaskEnum.TaskType.ActivityDungeon
	}

	TaskRpc.instance:sendGetTaskInfoRequest(typeIds, self._openTaskViewAfterRpc, self)
end

function VersionActivity1_8DungeonController:_openTaskViewAfterRpc()
	ViewMgr.instance:openView(ViewName.VersionActivity1_8TaskView)
end

function VersionActivity1_8DungeonController:openStoreView()
	local actId = VersionActivity1_8Enum.ActivityId.DungeonStore

	if not VersionActivityEnterHelper.checkCanOpen(actId) then
		return
	end

	Activity107Rpc.instance:sendGet107GoodsInfoRequest(actId, self._openStoreViewAfterRpc, self)
end

function VersionActivity1_8DungeonController:_openStoreViewAfterRpc()
	ViewMgr.instance:openView(ViewName.VersionActivity1_8StoreView)
end

function VersionActivity1_8DungeonController:onVersionActivityDungeonMapViewOpen()
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

	return (string.format("1_8Dungeon_%s_%s", VersionActivity1_8Enum.ActivityId.Dungeon, key))
end

function VersionActivity1_8DungeonController:savePlayerPrefs(key, value)
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

function VersionActivity1_8DungeonController:getPlayerPrefs(key, defaultValue)
	local value = defaultValue or ""

	if string.nilorempty(key) then
		return value
	end

	local uniqueKey = prefabKeyAddActId(key)
	local isNumber = type(value) == "number"

	value = isNumber and GameUtil.playerPrefsGetNumberByUserId(uniqueKey, value) or GameUtil.playerPrefsGetStringByUserId(uniqueKey, value)

	return value
end

function VersionActivity1_8DungeonController:loadDictFromStr(jsonStr)
	return (not string.nilorempty(jsonStr) or nil) and cjson.decode(jsonStr)
end

VersionActivity1_8DungeonController.instance = VersionActivity1_8DungeonController.New()

return VersionActivity1_8DungeonController
