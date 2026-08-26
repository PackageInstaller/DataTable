-- chunkname: @modules/versionactivitybase/fixed/dungeon/controller/VersionActivityFixedDungeonController.lua

module("modules.versionactivitybase.fixed.dungeon.controller.VersionActivityFixedDungeonController", package.seeall)

local VersionActivityFixedDungeonController = class("VersionActivityFixedDungeonController", BaseController)

function VersionActivityFixedDungeonController:openTaskView()
	local typeIds = {
		TaskEnum.TaskType.ActivityDungeon
	}

	TaskRpc.instance:sendGetTaskInfoRequest(typeIds, self._openTaskViewAfterRpc, self)
end

function VersionActivityFixedDungeonController:_openTaskViewAfterRpc()
	local viewName = VersionActivityFixedHelper.getVersionActivityTaskViewName(self._bigVersion, self._smallVersion)

	ViewMgr.instance:openView(viewName)
end

function VersionActivityFixedDungeonController:openStoreView(customStoreActId, viewName)
	VersionActivityFixedHelper.setCustomDungeonStore()

	local actId = customStoreActId or VersionActivityFixedHelper.getVersionActivityDungeonStore(self._bigVersion, self._smallVersion)

	if not VersionActivityEnterHelper.checkCanOpen(actId) then
		return
	end

	VersionActivityFixedHelper.setCustomDungeonStore(customStoreActId)

	if viewName then
		Activity107Rpc.instance:sendGet107GoodsInfoRequest(actId, function()
			ViewMgr.instance:openView(viewName)
		end)

		return
	end

	Activity107Rpc.instance:sendGet107GoodsInfoRequest(actId, self._openStoreViewAfterRpc, self)
end

function VersionActivityFixedDungeonController:_openStoreViewAfterRpc()
	local viewName = VersionActivityFixedHelper.getVersionActivityStoreViewName(self._bigVersion, self._smallVersion)

	ViewMgr.instance:openView(viewName)
end

function VersionActivityFixedDungeonController:openVersionActivityDungeonMapView(chapterId, episodeId, callback, callbackObj)
	self:setEnterVerison()
	self:_openVersionActivityDungeonMapView(chapterId, episodeId, callback, callbackObj)
end

function VersionActivityFixedDungeonController:_openVersionActivityDungeonMapView(chapterId, episodeId, callback, callbackObj)
	self.dungeonMapViewParam = {
		chapterId = chapterId,
		episodeId = episodeId
	}
	self.openMapViewCallback = callback
	self.openMapViewCallbackObj = callbackObj

	VersionActivityFixedDungeonModel.instance:init()

	self.hasReceivedTaskInfo = false

	local typeIds = {
		TaskEnum.TaskType.ActivityDungeon
	}

	TaskRpc.instance:sendGetTaskInfoRequest(typeIds, self._onReceiveTaskInfoReply, self)
	Activity113Rpc.instance:sendGetAct113InfoRequest(VersionActivityFixedHelper.getVersionActivityEnum().ActivityId.Dungeon)
end

function VersionActivityFixedDungeonController:_onReceiveTaskInfoReply()
	self.hasReceivedTaskInfo = true

	self:_internalOpenVersionActivityDungeonMapView(self._bigVersion, self._smallVersion)
end

function VersionActivityFixedDungeonController:_internalOpenVersionActivityDungeonMapView(big, small)
	self:setEnterVerison(big, small)

	if not self.hasReceivedTaskInfo then
		return
	end

	self.hasReceivedTaskInfo = false

	if not self.dungeonMapViewParam.episodeId then
		local unFinishEpisodeId = VersionActivityFixedDungeonModel.instance:getInitEpisodeId()

		if unFinishEpisodeId > 0 then
			self.dungeonMapViewParam.episodeId = unFinishEpisodeId
		end
	end

	local viewName = VersionActivityFixedHelper.getVersionActivityDungeonMapViewName(big, small)

	ViewMgr.instance:openView(viewName, self.dungeonMapViewParam)
end

function VersionActivityFixedDungeonController:onVersionActivityDungeonMapViewOpen()
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

	local bigVersion, smallVersion = VersionActivityFixedDungeonController.instance:getEnterVerison()

	return (string.format("Dungeon_%s_%s", VersionActivityFixedHelper.getVersionActivityEnum(bigVersion, smallVersion).ActivityId.Dungeon, key))
end

function VersionActivityFixedDungeonController:savePlayerPrefs(key, value)
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

function VersionActivityFixedDungeonController:getPlayerPrefs(key, defaultValue)
	local value = defaultValue or ""

	if string.nilorempty(key) then
		return value
	end

	local uniqueKey = prefabKeyAddActId(key)
	local isNumber = type(value) == "number"

	value = isNumber and GameUtil.playerPrefsGetNumberByUserId(uniqueKey, value) or GameUtil.playerPrefsGetStringByUserId(uniqueKey, value)

	return value
end

function VersionActivityFixedDungeonController:loadDictFromStr(jsonStr)
	return (not string.nilorempty(jsonStr) or nil) and cjson.decode(jsonStr)
end

function VersionActivityFixedDungeonController:openVersionActivityReactivityDungeonMapView(big, small, chapterId, episodeId, callback, callbackObj)
	self:setEnterVerison(big, small)
	self:_openVersionActivityDungeonMapView(chapterId, episodeId, callback, callbackObj)
end

function VersionActivityFixedDungeonController:setEnterVerison(big, small)
	self._bigVersion, self._smallVersion = big, small
end

function VersionActivityFixedDungeonController:getEnterVerison()
	return self._bigVersion, self._smallVersion
end

function VersionActivityFixedDungeonController:isOpenActivityHardDungeonChapterAndGetToast(actId)
	local activityDungeonConfig = ActivityConfig.instance:getActivityDungeonConfig(actId)

	if not activityDungeonConfig then
		logError("act Id : " .. actId .. " not exist activity dungeon config, please check!!!")

		return false, 10301
	end

	local isTimeOpen = VersionActivityConfig.instance:getAct113DungeonChapterIsOpen(activityDungeonConfig.hardChapterId)

	if not isTimeOpen then
		return false, 20207
	end

	local isUnlock = DungeonModel.instance:chapterIsUnLock(activityDungeonConfig.hardChapterId)

	if not isUnlock then
		return false, 10302
	end

	return true
end

VersionActivityFixedDungeonController.instance = VersionActivityFixedDungeonController.New()

return VersionActivityFixedDungeonController
