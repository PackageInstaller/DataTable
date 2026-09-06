-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sunranbattle/model/SunranBattleModel.lua

module("logic.extensions.sunranbattle.model.SunranBattleModel", package.seeall)

local SunranBattleModel = class("SunranBattleModel", BaseModel)

function SunranBattleModel:ctor()
	self._stageInfoList = nil
	self._singleStageInfo = nil
	self._battleRankList = nil
	self._cacheBuffInfo = nil
	self._battleEndInfo = nil
	self.cacheStageId = nil
end

function SunranBattleModel:onInit()
	SunranBattleModel.super.onInit(self)
	self:onReset()
end

function SunranBattleModel:onReset()
	self._stageInfoList = nil
	self._singleStageInfo = nil
	self._cacheBuffInfo = nil
	self._battleEndInfo = nil
	self.cacheStageId = nil
end

function SunranBattleModel:isSunranBattleOpen()
	local openCfg = SunranBattleConfig.instance:getOpenTimeCfg()

	return openCfg ~= nil
end

function SunranBattleModel:getBattleStageList()
	local openCfg = SunranBattleConfig.instance:getOpenTimeCfg()

	if openCfg == nil then
		return
	end

	local stageCfgs = SunranBattleConfig.instance:getBattleStageCfg(openCfg.seasonId)

	if stageCfgs == nil then
		return
	end

	local targetList = {}
	local nowTime = ServerTime.now()
	local allScore = 0

	for _, cfg in pairs(stageCfgs) do
		if cfg and cfg.seasonId == openCfg.seasonId then
			cfg.isOpen = nowTime >= checknumber(cfg.startTime)

			if self._stageInfoList and self._stageInfoList[cfg.stageId] then
				cfg.bestScore = self._stageInfoList[cfg.stageId].bestScore
				allScore = allScore + cfg.bestScore
			else
				cfg.bestScore = 0
			end

			table.insert(targetList, cfg)
		end
	end

	if #targetList > 1 then
		table.sort(targetList, function(a, b)
			return a.stageId < b.stageId
		end)
	end

	return targetList, allScore
end

function SunranBattleModel:getAllScorePrizeCfg(seasonId, allScore)
	local allCfgs = SunranBattleConfig.instance:getScorePrizeCfg(seasonId)

	if allCfgs == nil then
		return
	end

	local targetList = {}

	for _, cfg in pairs(allCfgs) do
		if cfg and checknumber(cfg.seasonId) == seasonId then
			local info = {}

			info.seasonId = seasonId
			info.score = cfg.score
			info.matList = {}

			if not string.nilorempty(cfg.prize) then
				info.matList = string.split(cfg.prize, "#")
			end

			info.isFinish = allScore >= cfg.score

			table.insert(targetList, info)
		end
	end

	if #targetList > 1 then
		table.sort(targetList, function(a, b)
			return a.score < b.score
		end)
	end

	return targetList
end

function SunranBattleModel:getNextScorePrizeCfg(seasonId, allScore)
	local list = self:getAllScorePrizeCfg(seasonId, allScore)

	if list == nil or #list == 0 then
		return
	end

	for i = 1, #list do
		if list[i] and not list[i].isFinish then
			return list[i]
		end
	end

	return nil
end

function SunranBattleModel:setCacheStageBuffInfo(info)
	self._cacheBuffInfo = info
end

function SunranBattleModel:getCacheStageBuffInfo()
	return self._cacheBuffInfo
end

function SunranBattleModel:getStageHistoryBestScore(stageId)
	if checknumber(stageId) <= 0 or self._stageInfoList == nil then
		return 0
	end

	if self._stageInfoList[stageId] == nil then
		return 0
	end

	return checknumber(self._stageInfoList[stageId].bestScore)
end

function SunranBattleModel:getStageBuffInfoList(seasonId, stageId)
	local moshiCfgs = SunranBattleConfig.instance:getStageMoshiCfg(seasonId, stageId)

	if moshiCfgs == nil then
		return
	end

	local targetList = {}
	local nowTime = ServerTime.now()

	for _, cfg in pairs(moshiCfgs) do
		if cfg and checknumber(cfg.optionGroup) > 0 then
			local info = {
				choIndex = 0,
				needScore = 0,
				groupId = cfg.optionGroup,
				groupList = {},
				choTime = nowTime
			}

			info.needScore = cfg.openGroupScore

			local num = self:_isHaveChoiseBuffItem(stageId, cfg.optionGroup)

			if checknumber(num) > 0 then
				info.choIndex = num
			end

			local groupList = SunranBattleConfig.instance:getMoshiGroupCfg(cfg.optionGroup)

			if groupList and #groupList > 0 then
				info.groupList = groupList
			else
				printError("sr---挑战 SunranBattleModel:getStageBuffInfoList()  选择组没有 = ", info.groupId, cfg.optionGroup)
			end

			table.insert(targetList, info)
		end
	end

	if #targetList > 1 then
		table.sort(targetList, function(a, b)
			if a.needScore == b.needScore then
				return a.groupId < b.groupId
			end

			return a.needScore < b.needScore
		end)
	end

	return targetList
end

function SunranBattleModel:_isHaveChoiseBuffItem(stageId, groupId)
	if self._singleStageInfo == nil then
		return 0
	end

	if checknumber(self._singleStageInfo.stageId) ~= stageId then
		return 0
	end

	local list = self._singleStageInfo.bestOption

	if list == nil then
		return 0
	end

	for _, info in pairs(list) do
		if info and info.optionGroup == groupId then
			return info.optionId
		end
	end

	return 0
end

function SunranBattleModel:getStageMissionFmtInfo()
	if self._cacheBuffInfo == nil or checknumber(self._cacheBuffInfo.stageId) <= 0 then
		return
	end

	local tempInfo = {
		masterId = -1,
		seasonId = self._cacheBuffInfo.seasonId,
		stageId = self._cacheBuffInfo.stageId,
		groupList = self._cacheBuffInfo.groupList,
		conList = {}
	}

	if not self._cacheBuffInfo.groupList then
		local list = {}

		for i = 1, #list do
			if list[i] and checknumber(list[i].optionGroup) > 0 and checknumber(list[i].optionId) > 0 then
				local cfg = SunranBattleConfig.instance:getMoshiGroupCfg(list[i].optionGroup, list[i].optionId)

				if cfg and not string.nilorempty(cfg.param) then
					if cfg.type == 1 then
						if checknumber(tempInfo.masterId) <= 0 then
							tempInfo.masterId = checknumber(cfg.param)
						else
							printError("sr---挑战 SunranBattleModel:getStageMissionFmtInfo()  同一个挑战配置多个 替换阵型")
						end
					elseif cfg.type == 4 then
						if #tempInfo.conList > 0 then
							if table.indexof(tempInfo.conList, checknumber(cfg.param)) == false then
								table.insert(tempInfo.conList, checknumber(cfg.param))
							else
								printError("sr---挑战 SunranBattleModel:getStageMissionFmtInfo()  同一个挑战配置多个 一样条件")
							end
						else
							table.insert(tempInfo.conList, checknumber(cfg.param))
						end
					end
				end
			end
		end

		if checknumber(tempInfo.masterId) <= 0 then
			tempInfo.masterId = self._cacheBuffInfo.masterId
		end

		return tempInfo
	end
end

function SunranBattleModel:getStageRankTabList(seasonId)
	local stageCfgs = SunranBattleConfig.instance:getBattleStageCfg(seasonId)

	if stageCfgs == nil then
		printError("sr---挑战 SunranBattleModel:getStageRankTabList()  赛季的关卡配置空 = ", seasonId)

		return
	end

	local targetList = {}

	for _, cfg in pairs(stageCfgs) do
		if cfg and checknumber(cfg.stageId) > 0 then
			table.insert(targetList, {
				stageId = cfg.stageId,
				startTime = cfg.startTime,
				stageName = cfg.stageName,
				unlockTips = cfg.unlockTips
			})
		end
	end

	if #targetList == 0 then
		printError("sr---挑战 SunranBattleModel:getStageRankTabList()  计算赛季关卡出错 = ", seasonId)

		return
	end

	if #targetList > 1 then
		table.sort(targetList, function(a, b)
			return a.stageId < b.stageId
		end)
	end

	return targetList
end

function SunranBattleModel:getStageRankInfoList(stageId)
	if self._battleRankList == nil or checknumber(self._battleRankList.stageId) ~= stageId then
		return
	end

	return self._battleRankList
end

function SunranBattleModel:isOpenBattleResultView()
	if self._battleEndInfo == nil or checknumber(self._battleEndInfo.stageId) <= 0 then
		return false
	end

	local openCfg = SunranBattleConfig.instance:getOpenTimeCfg()

	if openCfg == nil then
		return false
	end

	if not self._battleEndInfo.isBest then
		self:resetBattleEndInfo()

		return false
	end

	self._battleEndInfo.seasonId = openCfg.seasonId

	UIStateManager.instance:push(ViewName.SunranResult, self._battleEndInfo)

	return true
end

function SunranBattleModel:resetBattleEndInfo()
	if self._battleEndInfo and self._battleEndInfo.matId then
		MaterialController.instance:showChangeSetInTemp(self._battleEndInfo.matId)
	end

	self._battleEndInfo = nil
end

function SunranBattleModel:scSendDarkDragonInfo(msg)
	self._stageInfoList = {}

	for _, info in pairs(msg) do
		if info and checknumber(info.bestScore) > 0 then
			self._stageInfoList[info.stageId] = info
		end
	end

	GlobalDispatcher:dispatch(GlobalNotify.MainBattleInfo)
end

function SunranBattleModel:scSendDarkDragonStageInfo(msg, stageId)
	self._singleStageInfo = {}
	self._singleStageInfo.stageId = stageId
	self._singleStageInfo.bestScore = checknumber(msg.bestScore)
	self._singleStageInfo.bestOption = {}

	if self._cacheBuffInfo and checknumber(self._cacheBuffInfo.stageId) == stageId and self._cacheBuffInfo.groupList and #self._cacheBuffInfo.groupList > 0 then
		for i = 1, #self._cacheBuffInfo.groupList do
			if self._cacheBuffInfo.groupList[i] then
				table.insert(self._singleStageInfo.bestOption, {
					optionId = self._cacheBuffInfo.groupList[i].optionId,
					optionGroup = self._cacheBuffInfo.groupList[i].optionGroup
				})
			end
		end
	elseif msg.bestOption then
		self._singleStageInfo.bestOption = msg.bestOption
	end

	self._cacheBuffInfo = nil
	self._stageInfoList = self._stageInfoList or {}
	self._stageInfoList[stageId] = {
		stageId = stageId,
		bestScore = checknumber(msg.bestScore)
	}

	GlobalDispatcher:dispatch(GlobalNotify.SingleStageInfo)
end

function SunranBattleModel:scSendDarkDragonRankInfo(msg, stageId)
	self._battleRankList = {
		myRank = -1,
		stageId = stageId,
		rankList = {}
	}

	if msg and msg.rank then
		self._battleRankList.myRank = checknumber(msg.myRank)
		self._battleRankList.rankList = msg.rank
	end

	if #self._battleRankList.rankList > 1 then
		table.sort(self._battleRankList.rankList, function(a, b)
			return a.rank < b.rank
		end)
	end

	GlobalDispatcher:dispatch(GlobalNotify.BattleRankInfo)
end

function SunranBattleModel:scSendNotifyChallengeEnd(msg)
	self._battleEndInfo = nil

	if msg and msg.isSuccess then
		self._battleEndInfo = {}
		self._battleEndInfo.matId = msg.changeSetId
		self._battleEndInfo.stageId = msg.stageId
		self._battleEndInfo.score = msg.score
		self._battleEndInfo.isBest = msg.isBest
		self._battleEndInfo.oldScore = 0
		self._battleEndInfo.seasonId = 0
		self._stageInfoList = self._stageInfoList or {}
		self._stageInfoList[msg.stageId] = self._stageInfoList[msg.stageId] or {}
		self._battleEndInfo.oldScore = checknumber(self._stageInfoList[msg.stageId].bestScore)

		if checknumber(self._stageInfoList[msg.stageId].bestScore) < checknumber(msg.score) then
			self._stageInfoList[msg.stageId].bestScore = msg.score
		end

		MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
	end
end

SunranBattleModel.instance = SunranBattleModel.New()

return SunranBattleModel
