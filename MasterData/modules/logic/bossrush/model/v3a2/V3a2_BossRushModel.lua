-- chunkname: @modules/logic/bossrush/model/v3a2/V3a2_BossRushModel.lua

module("modules.logic.bossrush.model.v3a2.V3a2_BossRushModel", package.seeall)

local V3a2_BossRushModel = class("V3a2_BossRushModel", BaseModel)

function V3a2_BossRushModel:init()
	self._config = BossRushConfig.instance
	self._gainMilestoneLevel = 0
	self._rank = 0
end

function V3a2_BossRushModel:onRefresh128InfosReply(msg)
	self:initRankInfo(msg)
end

function V3a2_BossRushModel:onReceiveAct128GetExpReply(msg)
	local mo = self:getHandBookMo(msg.type)

	if mo then
		mo:setAcceptExp(msg.acceptExpPoint)
	end

	self._rank = msg.playerLevel
end

function V3a2_BossRushModel:_onReceiveAct128GetMilestoneBonusReply(msg)
	self._gainMilestoneLevel = msg.gainMilestoneLevel

	self:_refreshGainMilestoneLevel()
end

function V3a2_BossRushModel:getSortStages(actId)
	local lockInfoList = {}
	local unlockInfoList = {}
	local newOpenStage
	local _infoList = {}
	local dataList = V3a9_BossRushModel.instance:getStageMos(actId)

	if dataList then
		for _, mo in ipairs(dataList) do
			local isOpen = mo:isOpen()

			if isOpen then
				newOpenStage = mo

				table.insert(unlockInfoList, mo)
			else
				table.insert(lockInfoList, mo)
			end
		end

		table.insert(_infoList, newOpenStage)

		for _, info in ipairs(unlockInfoList) do
			if newOpenStage ~= info then
				table.insert(_infoList, info)
			end
		end

		for _, info in ipairs(lockInfoList) do
			table.insert(_infoList, info)
		end
	end

	return _infoList
end

function V3a2_BossRushModel:getRank()
	return self._rank
end

function V3a2_BossRushModel:initRankInfo(info)
	self._rank = info.playerLevel or 0
	self._gainMilestoneLevel = info.gainMilestoneLevel

	self:_refreshGainMilestoneLevel()
end

function V3a2_BossRushModel:_refreshGainMilestoneLevel()
	local mos = self:getRankMos()

	for _, mo in pairs(mos) do
		mo:setInfo(self._rank, self._gainMilestoneLevel)
	end
end

function V3a2_BossRushModel:getRankExpCurrency()
	return self._expCurrency
end

function V3a2_BossRushModel:getRankExp()
	if not self._expCurrency then
		local _, value = self._config:getConst(V3a2BossRushEnum.BossRankExpCurrencyConst)

		if string.nilorempty(value) then
			return 0
		end

		self._expCurrency = string.splitToNumber(value, "#")
	end

	return (ItemModel.instance:getItemQuantity(self._expCurrency[1], self._expCurrency[2]))
end

function V3a2_BossRushModel:getRankExpProgress()
	local rankMo = self:getRankMo(self._rank + 1)
	local exp = self:getRankExp()

	if rankMo then
		return exp - rankMo.preExp, rankMo.config.needExp
	end

	rankMo = self:getRankMo(self._rank)

	return 0, rankMo.config.needExp
end

function V3a2_BossRushModel:getRankMos()
	if not self._rankMOs then
		self._rankMOs = {}

		local needExp = 0
		local cos = self._config:getAllLevelCos()

		if cos then
			for i, co in ipairs(cos) do
				local mo = V3a2_BossRush_RankMO.New()
				local preExp = needExp

				needExp = needExp + co.needExp

				mo:initMO(co, preExp, needExp)

				self._rankMOs[co.playerLevel] = mo
			end
		end
	end

	return self._rankMOs
end

function V3a2_BossRushModel:refreshRankMos()
	self:_refreshGainMilestoneLevel()
end

function V3a2_BossRushModel:isCanClaimRankBonus()
	return self._gainMilestoneLevel < self._rank
end

function V3a2_BossRushModel:getRankMo(level)
	local mos = self:getRankMos()

	return mos and mos[level]
end

function V3a2_BossRushModel:getRankLevelBg(rank)
	local rankMo = self:getRankMo(rank) or self:getRankMo(1)

	return rankMo.config.levelBg
end

function V3a2_BossRushModel:getRankSpLevelBg(rank)
	local rankMo = self:getRankMo(rank) or self:getRankMo(1)

	return rankMo.config.spLevelBg
end

function V3a2_BossRushModel:onRefreshHandBookInfo(info)
	for _, v in ipairs(info.galleryDetail) do
		local mo = self:getHandBookMo(v.type)

		mo:setInfo(v)
	end
end

function V3a2_BossRushModel:getHandBookMos()
	if not self._handbookMOs then
		self._handbookMOs = {}

		local cos = self._config:getAllGalleryBossCos()

		if cos then
			for i, co in ipairs(cos) do
				local mo = V3a2_BossRush_HandBookMO.New()

				mo:initMO(co)

				self._handbookMOs[co.type] = mo
			end
		end
	end

	return self._handbookMOs
end

function V3a2_BossRushModel:getHandBookMo(bossType)
	local mos = self:getHandBookMos()

	return mos and mos[bossType]
end

function V3a2_BossRushModel:getHandBookMoByStage(stage, activityId)
	local bossType = self._config:getV3a2BossTypeByStage(stage, activityId)

	return bossType and self:getHandBookMo(bossType)
end

function V3a2_BossRushModel:getStrategyByStage(stage)
	local bossType = self._config:getV3a2BossTypeByStage(stage)
	local mo = self:getHandBookMoByStage(bossType)

	if mo then
		return BossRushConfig.instance:getBossRecommendStrategy(bossType)
	end
end

function V3a2_BossRushModel:getHandBookGroupMos()
	if not self._handbookGroupMOs then
		self._handbookGroupMOs = {}

		local mos = self:getHandBookMos()

		if mos then
			for i, mo in pairs(mos) do
				if mo.config.offline == 0 then
					local minType = mo.config.minType
					local groupMos = self._handbookGroupMOs[minType]

					if not groupMos then
						groupMos = {
							bossGroup = {},
							config = lua_activity128_bosstype.configDict[minType]
						}
						self._handbookGroupMOs[minType] = groupMos
					end

					table.insert(groupMos.bossGroup, mo)
				end
			end
		end
	end

	return self._handbookGroupMOs
end

function V3a2_BossRushModel:setScore(extra)
	if extra then
		if not extra.baseScore then
			local baseScore = 0

			if extra then
				if not extra.ruleScore then
					local ruleScore = 0

					self._score = {
						baseScore = baseScore,
						ruleScore = ruleScore
					}
				end
			end
		end
	end
end

function V3a2_BossRushModel:getScore()
	return self._score or {}
end

function V3a2_BossRushModel:setAssistMo(assistMo, index)
	local stage, _, actId = BossRushModel.instance:getBattleStageAndLayer()

	self._assistMos = self._assistMos or {}
	self._assistMos[actId] = self._assistMos[actId] or {}

	if not self._assistMos[actId][stage] then
		local mo = HeroSingleGroupMO.New()

		mo:init(index, assistMo.heroUid)
		mo:setAssist(assistMo)

		self._assistMos[actId][stage] = mo

		self:setEditorAssistMo(assistMo)
	end
end

function V3a2_BossRushModel:getAssistMo()
	local stage, _, actId = BossRushModel.instance:getBattleStageAndLayer()

	if not stage or not actId then
		return
	end

	self._assistMos = self._assistMos or {}
	self._assistMos[actId] = self._assistMos[actId] or {}

	return self._assistMos[actId][stage]
end

function V3a2_BossRushModel:setEditorAssistMo(assistMo)
	local stage, _, actId = BossRushModel.instance:getBattleStageAndLayer()

	self._editorAssistMos = self._editorAssistMos or {}
	self._editorAssistMos[actId] = self._editorAssistMos[actId] or {}
	self._editorAssistMos[actId][stage] = assistMo
end

function V3a2_BossRushModel:getEditorAssistMo()
	local stage, _, actId = BossRushModel.instance:getBattleStageAndLayer()

	self._editorAssistMos = self._editorAssistMos or {}
	self._editorAssistMos[actId] = self._editorAssistMos[actId] or {}

	return self._editorAssistMos[actId][stage]
end

function V3a2_BossRushModel:clearAssist(isClearEditor)
	local stage, _, actId = BossRushModel.instance:getBattleStageAndLayer()

	if self._assistMos and self._assistMos[actId] and self._assistMos[actId][stage] then
		self._assistMos[actId][stage] = nil
	end

	if isClearEditor and self._editorAssistMos and self._editorAssistMos[actId] and self._editorAssistMos[actId][stage] then
		self._editorAssistMos[actId][stage] = nil
	end
end

function V3a2_BossRushModel:clearAllAssist()
	self._assistMos = nil
	self._editorAssistMos = nil
end

V3a2_BossRushModel.instance = V3a2_BossRushModel.New()

return V3a2_BossRushModel
