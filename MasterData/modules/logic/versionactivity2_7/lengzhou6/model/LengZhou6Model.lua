-- chunkname: @modules/logic/versionactivity2_7/lengzhou6/model/LengZhou6Model.lua

module("modules.logic.versionactivity2_7.lengzhou6.model.LengZhou6Model", package.seeall)

local LengZhou6Model = class("LengZhou6Model", BaseModel)

function LengZhou6Model:onInit()
	self._actInfoMap = {}
	self._actNewestEpisodeDict = {}
end

function LengZhou6Model:reInit()
	self._actInfoMap = {}
	self._actNewestEpisodeDict = {}
end

function LengZhou6Model:onGetActInfo(msg)
	self._activityId = msg.activityId

	local infos = msg.episodes

	if not infos or #infos <= 0 then
		return
	end

	if self._actInfoMap == nil or tabletool.len(self._actInfoMap) == 0 then
		if self._actInfoMap == nil then
			self._actInfoMap = {}
		end

		local allEpisode = lua_activity190_episode.configDict[self._activityId]

		for episodeId, _ in pairs(allEpisode) do
			if self._actInfoMap[episodeId] == nil then
				local mo = LengZhou6InfoMo.New()

				mo:init(self:getCurActId(), episodeId, false)

				self._actInfoMap[episodeId] = mo
			end
		end
	end

	for _, info in ipairs(infos) do
		local episodeId = info.episodeId

		self._actInfoMap[episodeId]:updateInfo(info)
	end

	self:updateNewestEpisode()
end

function LengZhou6Model:onFinishActInfo(msg)
	self._activityId = msg.activityId

	local episodeId = msg.episodeId

	if episodeId == nil then
		return
	end

	if self._actInfoMap ~= nil then
		local mo = self._actInfoMap[episodeId]

		if mo then
			mo:updateIsFinish(true)
			mo:updateProgress(msg.progress)
		end
	end
end

function LengZhou6Model:onPushActInfo(msg)
	self._activityId = msg.activityId

	local infos = msg.episodes

	if not infos or #infos <= 0 then
		return
	end

	if self._actInfoMap == nil or tabletool.len(self._actInfoMap) == 0 then
		if self._actInfoMap == nil then
			self._actInfoMap = {}
		end

		local allEpisode = lua_activity190_episode.configDict[self._activityId]

		for episodeId, _ in pairs(allEpisode) do
			if self._actInfoMap[episodeId] == nil then
				local mo = LengZhou6InfoMo.New()

				mo:init(self:getCurActId(), episodeId, false)

				self._actInfoMap[episodeId] = mo
			end
		end
	end

	for _, info in ipairs(infos) do
		local episodeId = info.episodeId
		local mo = self._actInfoMap[episodeId]
		local preEpisodeId = mo.preEpisodeId

		if self._actInfoMap[preEpisodeId] then
			self._actInfoMap[preEpisodeId]:updateIsFinish(true)
		end
	end

	self:updateNewestEpisode()
end

function LengZhou6Model:updateNewestEpisode()
	local newestEpisodeId, endLessEpisodeId

	for id, _ in pairs(self._actInfoMap) do
		local isUnlock = self:isUnlockEpisode(id)
		local isFinished = self:isFinishedEpisode(id)

		if isUnlock and not isFinished then
			newestEpisodeId = id
		end

		local episodeMo = self._actInfoMap[id]

		if episodeMo:isEndlessEpisode() then
			endLessEpisodeId = id
		end
	end

	local actId = self:getCurActId()

	self._actNewestEpisodeDict[actId] = newestEpisodeId == nil and endLessEpisodeId or newestEpisodeId
end

function LengZhou6Model:getAllEpisodeIds()
	local configs = lua_activity190_episode.configDict[self._activityId]
	local allIds = {}

	for id, _ in pairs(configs) do
		table.insert(allIds, id)
	end

	table.sort(allIds, function(a, b)
		return a < b
	end)

	return allIds
end

function LengZhou6Model:getEpisodeInfoMo(episodeId)
	return self._actInfoMap[episodeId]
end

function LengZhou6Model:getActInfoDic()
	return self._actInfoMap
end

function LengZhou6Model:isEpisodeFinish(episodeId)
	local episodeMo = self._actInfoMap[episodeId]

	if episodeMo == nil then
		return false
	end

	return episodeMo.isFinish
end

function LengZhou6Model:setCurEpisodeId(id)
	self._curEpisodeId = id
end

function LengZhou6Model:getCurEpisodeId()
	return self._curEpisodeId
end

function LengZhou6Model:getCurActId()
	return self._activityId
end

function LengZhou6Model:getEpisodeIsEndLess(config)
	local enemyId = config.enemyId

	if not string.nilorempty(enemyId) then
		return enemyId == "2"
	end

	return false
end

function LengZhou6Model:getAct190Id()
	return VersionActivity2_7Enum.ActivityId.LengZhou6
end

function LengZhou6Model:isAct190Open(isToast)
	local actId = self:getAct190Id()
	local status, toastId, toastParam
	local actInfoMo = ActivityModel.instance:getActivityInfo()[actId]

	if actInfoMo then
		status, toastId, toastParam = ActivityHelper.getActivityStatusAndToast(actId)
	else
		toastId = ToastEnum.ActivityEnd
	end

	if isToast and toastId then
		GameFacade.showToast(toastId, toastParam)
	end

	return status == ActivityEnum.ActivityStatus.Normal
end

function LengZhou6Model:isUnlockEpisode(episodeId)
	local episodeMo = self._actInfoMap[episodeId]

	return episodeMo ~= nil and episodeMo:unLock()
end

function LengZhou6Model:isFinishedEpisode(episodeId)
	local episodeMo = self._actInfoMap[episodeId]

	return episodeMo ~= nil and episodeMo.isFinish
end

function LengZhou6Model:getNewestEpisodeId(actId)
	return self._actNewestEpisodeDict[actId]
end

LengZhou6Model.instance = LengZhou6Model.New()

return LengZhou6Model
