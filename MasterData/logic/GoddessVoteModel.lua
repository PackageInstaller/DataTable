-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddessvote/model/GoddessVoteModel.lua

module("logic.extensions.goddessvote.model.GoddessVoteModel", package.seeall)

local GoddessVoteModel = class("GoddessVoteModel", BaseModel)

function GoddessVoteModel:ctor()
	self._goddessInfo = nil
end

function GoddessVoteModel:onInit()
	GoddessVoteModel.super.onInit(self)
	self:onReset()
end

function GoddessVoteModel:onReset()
	self._goddessInfo = nil
	self._randomTimer = nil
	self._racesCacheList = nil
end

function GoddessVoteModel:getGoddessInfo(isReset)
	if isReset or self._goddessInfo == nil then
		self._goddessInfo = {}
		self._goddessInfo.activityId = GoddessVoteConfig.instance:getOpenActivityId()
		self._goddessInfo.voteInfos = {}
		self._goddessInfo.buyCount = 0
	end

	return self._goddessInfo
end

function GoddessVoteModel:getVoteRaceList(actId, isSort)
	local cfgs = GoddessVoteConfig.instance:GetGoddessAllRaces(actId)

	if cfgs == nil then
		return
	end

	self:getGoddessInfo()

	if self._racesCacheList == nil then
		self._racesCacheList = {}

		for _, item in pairs(cfgs) do
			if item and item.raceId > 0 then
				table.insert(self._racesCacheList, {
					rankId = 0,
					voteCount = 0,
					raceId = item.raceId
				})
			end
		end
	end

	for i = 1, #self._racesCacheList do
		if self._racesCacheList[i] and self._racesCacheList[i].raceId and self._goddessInfo.voteInfos[self._racesCacheList[i].raceId] then
			self._racesCacheList[i].voteCount = checknumber(self._goddessInfo.voteInfos[self._racesCacheList[i].raceId])
		end
	end

	local haveCount = #self._racesCacheList

	if haveCount <= 1 then
		return self._racesCacheList
	end

	if isSort then
		self:_calculateSortList(self._racesCacheList)

		return self._racesCacheList
	end

	if self._randomTimer == nil or self._randomTimer + 300 < ServerTime.now() then
		self._randomTimer = ServerTime.now()

		local pool = {}

		math.randomseed(tonumber(tostring(os.time()):reverse():sub(1, 6)))
		self:_calculateSortList(self._racesCacheList)

		for i = 1, haveCount do
			local rand = math.random(i, haveCount)

			if not pool[rand] then
				pool[rand] = pool[i] or i
				pool[i] = pool[rand]
				self._racesCacheList[i].randomId = pool[rand]
			end
		end

		table.sort(self._racesCacheList, function(a, b)
			return a.randomId < b.randomId
		end)
	else
		local tempList = {}

		for i = 1, haveCount do
			table.insert(tempList, {
				rankId = 0,
				raceId = self._racesCacheList[i].raceId,
				voteCount = self._racesCacheList[i].voteCount
			})
		end

		self:_calculateSortList(tempList)

		for i = 1, haveCount do
			self._racesCacheList[i].rankId = self:_getNextRankId(self._racesCacheList[i].raceId, tempList)
		end
	end

	return self._racesCacheList
end

function GoddessVoteModel:_calculateSortList(list)
	table.sort(list, function(a, b)
		if a.voteCount == b.voteCount then
			return a.raceId < b.raceId
		end

		return a.voteCount > b.voteCount
	end)

	for i = 1, #list do
		local index = i

		list[index].rankId = index
	end
end

function GoddessVoteModel:_getNextRankId(raceId, list)
	if list == nil or #list == 0 then
		return 0
	end

	for i = 1, #list do
		local index = i

		if list[index] and list[index].raceId == raceId then
			return list[index].rankId
		end
	end

	return 0
end

function GoddessVoteModel:getGoddessVoteRedpoint()
	local actId = GoddessVoteConfig.instance:getOpenActivityId()

	if checknumber(actId) <= 0 then
		return false
	end

	local cfg = GoddessVoteConfig.instance:getGoddessActivityCfg(actId)

	if cfg == nil or string.nilorempty(cfg.voteItem) then
		return false
	end

	local modTime = GameUtil.string2time(cfg.awakenStartTime)

	if modTime <= ServerTime.now() then
		return false
	end

	local have = MaterialMgr.getMatCount(cfg.voteItem)

	return checknumber(have) > 0
end

function GoddessVoteModel:scPushGVGetInfo(msg)
	self:getGoddessInfo(true)

	if msg == nil then
		return
	end

	self._goddessInfo.voteInfos = {}

	for _, info in pairs(msg.voteInfos) do
		if info and checknumber(info.raceId) > 0 and checknumber(info.voteCount) > 0 then
			self._goddessInfo.voteInfos[info.raceId] = info.voteCount
		end
	end

	self._goddessInfo.buyCount = checknumber(msg.todayBuyVoteItemCount)
	self._goddessInfo.activityId = checknumber(msg.activityId)
end

function GoddessVoteModel:scPushGVBuyVoteItem(msg)
	self:getGoddessInfo()

	if msg == nil or msg.todayBuyVoteItemCount == nil then
		return
	end

	self._goddessInfo.buyCount = checknumber(msg.todayBuyVoteItemCount)
end

function GoddessVoteModel:scPushGVVote(raceId, count)
	return
end

GoddessVoteModel.instance = GoddessVoteModel.New()

return GoddessVoteModel
