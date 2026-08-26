-- chunkname: @modules/logic/versionactivity2_0/dungeon/controller/VersionActivity2_0DungeonController.lua

module("modules.logic.versionactivity2_0.dungeon.controller.VersionActivity2_0DungeonController", package.seeall)

local VersionActivity2_0DungeonController = class("VersionActivity2_0DungeonController", BaseController)

function VersionActivity2_0DungeonController:onInit()
	return
end

function VersionActivity2_0DungeonController:reInit()
	VersionActivityDungeonBaseController.instance:clearChapterIdLastSelectEpisodeId()
end

function VersionActivity2_0DungeonController:openTaskView()
	local typeIds = {
		TaskEnum.TaskType.ActivityDungeon
	}

	TaskRpc.instance:sendGetTaskInfoRequest(typeIds, self._openTaskViewAfterRpc, self)
end

function VersionActivity2_0DungeonController:_openTaskViewAfterRpc()
	ViewMgr.instance:openView(ViewName.VersionActivity2_0TaskView)
end

function VersionActivity2_0DungeonController:openStoreView()
	local actId = VersionActivity2_0Enum.ActivityId.DungeonStore

	if not VersionActivityEnterHelper.checkCanOpen(actId) then
		return
	end

	Activity107Rpc.instance:sendGet107GoodsInfoRequest(actId, self._openStoreViewAfterRpc, self)
end

function VersionActivity2_0DungeonController:_openStoreViewAfterRpc()
	ViewMgr.instance:openView(ViewName.VersionActivity2_0StoreView)
end

function VersionActivity2_0DungeonController:openVersionActivityDungeonMapView(chapterId, episodeId, callback, callbackObj)
	self.dungeonMapViewParam = {
		chapterId = chapterId,
		episodeId = episodeId
	}
	self.openMapViewCallback = callback
	self.openMapViewCallbackObj = callbackObj

	VersionActivity2_0DungeonModel.instance:init()

	self.hasReceivedTaskInfo = false
	self.hasReceivedAct161Info = false

	local typeIds = {
		TaskEnum.TaskType.ActivityDungeon
	}

	TaskRpc.instance:sendGetTaskInfoRequest(typeIds, self._onReceiveTaskInfoReply, self)
	Activity161Controller.instance:initAct161Info(false, true, self._onReceiveAct161InfoReply, self)
	Activity113Rpc.instance:sendGetAct113InfoRequest(VersionActivity2_0Enum.ActivityId.Dungeon)
end

function VersionActivity2_0DungeonController:_onReceiveTaskInfoReply()
	self.hasReceivedTaskInfo = true

	self:_internalOpenVersionActivityDungeonMapView()
end

function VersionActivity2_0DungeonController:_onReceiveAct161InfoReply()
	self.hasReceivedAct161Info = true

	self:_internalOpenVersionActivityDungeonMapView()
end

function VersionActivity2_0DungeonController:_internalOpenVersionActivityDungeonMapView()
	if not self.hasReceivedTaskInfo or not self.hasReceivedAct161Info then
		return
	end

	self.hasReceivedTaskInfo = false
	self.hasReceivedAct161Info = false

	local isEntranceUnlock = VersionActivity2_0DungeonModel.instance:getGraffitiEntranceUnlockState()
	local needDoElementId = VersionActivity2_0DungeonModel.instance:getCurNeedUnlockGraffitiElement()
	local saveEpisodeKey = VersionActivity2_0DungeonEnum.PlayerPrefsKey.DungeonLastSelectEpisode
	local saveEpisodeId = VersionActivity2_0DungeonController.instance:getPlayerPrefs(saveEpisodeKey, VersionActivity2_0DungeonEnum.restaurantChapterMap)

	if isEntranceUnlock and not self.dungeonMapViewParam.episodeId then
		if needDoElementId then
			self.dungeonMapViewParam.episodeId = VersionActivity2_0DungeonEnum.restaurantChapterMap or tonumber(saveEpisodeId)
		end
	end

	ViewMgr.instance:openView(ViewName.VersionActivity2_0DungeonMapView, self.dungeonMapViewParam)
end

function VersionActivity2_0DungeonController:onVersionActivityDungeonMapViewOpen()
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

	return (string.format("2_0Dungeon_%s_%s", VersionActivity2_0Enum.ActivityId.Dungeon, key))
end

function VersionActivity2_0DungeonController:savePlayerPrefs(key, value)
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

function VersionActivity2_0DungeonController:getPlayerPrefs(key, defaultValue)
	local value = defaultValue or ""

	if string.nilorempty(key) then
		return value
	end

	local uniqueKey = prefabKeyAddActId(key)
	local isNumber = type(value) == "number"

	value = isNumber and GameUtil.playerPrefsGetNumberByUserId(uniqueKey, value) or GameUtil.playerPrefsGetStringByUserId(uniqueKey, value)

	return value
end

function VersionActivity2_0DungeonController:loadDictFromStr(jsonStr)
	return (not string.nilorempty(jsonStr) or nil) and cjson.decode(jsonStr)
end

function VersionActivity2_0DungeonController:openDialogueView(dialogueId, callback, callbackTarget, callbackParams)
	ViewMgr.instance:openView(ViewName.VersionActivity2_0DialogueView, {
		dialogueId = dialogueId,
		callback = callback,
		callbackTarget = callbackTarget,
		callbackParams = callbackParams
	})
end

VersionActivity2_0DungeonController.instance = VersionActivity2_0DungeonController.New()

return VersionActivity2_0DungeonController
