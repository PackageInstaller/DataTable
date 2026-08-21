-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/config/BattleConfig.lua

module("logic.battle.config.BattleConfig", package.seeall)

local BattleConfig = class("BattleConfig", BaseConfig)

function BattleConfig:ctor()
	self._cfgCareerRestrain = false
	self._cfgColorRestrain = false
	self._cfgBattleConst = false
	self._cfgCampBuff = false
	self._cfgBattleReport = false
	self._cfgBattlePlotEvent = false
	self._cfgBattlePlot3dEvent = false
	self._cfgBattleClientEventTrigger = false
	self._cfgCheckerBoard = {}
	self._cfgLevel = {}
	self._cfgTagPerformance = {}
end

function BattleConfig:getNames()
	return {
		ConfigName.CareerRestrain,
		ConfigName.ColorRestrain,
		ConfigName.CampBuff,
		ConfigName.BattleReportDesc,
		ConfigName.BattleConst,
		ConfigName.BattlePlotEventChain,
		ConfigName.BattlePlotEventChain3d,
		ConfigName.BattleClientEventTrigger,
		ConfigName.TagPerformance
	}
end

function BattleConfig:handleConfig(name, content)
	if name == ConfigName.CareerRestrain then
		self._cfgCareerRestrain = content
	elseif name == ConfigName.ColorRestrain then
		self._cfgColorRestrain = content
	elseif name == ConfigName.CampBuff then
		self._cfgCampBuff = content
	elseif name == ConfigName.BattleReportDesc then
		self._cfgBattleReport = content
	elseif name == ConfigName.BattleConst then
		self._cfgBattleConst = content
	elseif name == ConfigName.BattlePlotEventChain then
		self._cfgBattlePlotEvent = content
	elseif name == ConfigName.BattlePlotEventChain3d then
		self._cfgBattlePlot3dEvent = content
	elseif name == ConfigName.BattleClientEventTrigger then
		self._cfgBattleClientEventTrigger = content
	elseif name == ConfigName.TagPerformance then
		self._cfgTagPerformance = content
	elseif enableErrorLog then
		printError("unhandle config", name)
	end
end

function BattleConfig:getCareerRestrainRelation(aCareer, bCareer)
	local t = self._cfgCareerRestrain[aCareer]

	if t and t[bCareer] then
		return BattleEnum.Restrain.RESTRAIN, BattleEnum.Restrain.BE_RESTRAIN
	end

	t = self._cfgCareerRestrain[bCareer]

	if t and t[aCareer] then
		return BattleEnum.Restrain.BE_RESTRAIN, BattleEnum.Restrain.RESTRAIN
	end

	return BattleEnum.Restrain.NONE, BattleEnum.Restrain.NONE
end

function BattleConfig:getColorRestrainRelation(aColorType, bColorType)
	local t = self._cfgColorRestrain[aColorType]

	if t and t[bColorType] then
		return BattleEnum.Restrain.RESTRAIN, BattleEnum.Restrain.BE_RESTRAIN
	end

	t = self._cfgColorRestrain[bColorType]

	if t and t[aColorType] then
		return BattleEnum.Restrain.BE_RESTRAIN, BattleEnum.Restrain.RESTRAIN
	end

	return BattleEnum.Restrain.NONE, BattleEnum.Restrain.NONE
end

function BattleConfig:getColorRestrainRelationCO(aColorType, bColorType)
	local t = self._cfgColorRestrain[aColorType]

	if t then
		return t[bColorType]
	end

	t = self._cfgColorRestrain[bColorType]

	if t then
		return t[aColorType]
	end

	return false
end

function BattleConfig:getBattleConstCO(key)
	local battleConstCO = self._cfgBattleConst[key]

	if not battleConstCO and enableErrorLog then
		printError("Cannot find battle const config for code", key)
	end

	return battleConstCO
end

function BattleConfig:getCampBuffCO(orderCode)
	local campBuffCO = self._cfgCampBuff[orderCode]

	if not campBuffCO and enableErrorLog then
		printError("Cannot find camp buff config for order", orderCode)
	end

	return campBuffCO
end

function BattleConfig:getBattlePlotEventChain3dResPath(chainCode)
	local chainCOList = self._cfgBattlePlot3dEvent[chainCode]

	if not chainCOList then
		if enableErrorLog then
			printError("Cannot find [t_battle_plot_event_chain3d] config for code:", chainCode)
		end

		return
	end

	for _, chainCO in pairs(chainCOList) do
		if not string.nilorempty(chainCO.resPath) then
			return chainCO.resPath
		end
	end

	if enableErrorLog then
		printError("Cannot find [resPath] from [t_battle_plot_event_chain3d], config code:", chainCode)
	end
end

function BattleConfig:getAllCampBuffConfig()
	return self._cfgCampBuff.dataList
end

function BattleConfig:getCampBuffCOByCount(campCount)
	local allCampBuffCO = self:getAllCampBuffConfig()

	for i = #allCampBuffCO, 1, -1 do
		local campBuffCO = allCampBuffCO[i]

		if campCount >= campBuffCO.count then
			return campBuffCO
		end
	end

	return false
end

function BattleConfig:getBattleReportDesc(type)
	local reportCO = self._cfgBattleReport[type]

	if not reportCO and enableErrorLog then
		printError("Cannot find battle report config ", reportCO)
	end

	return reportCO
end

function BattleConfig:getAllBattleReportConfig()
	return self._cfgBattleReport.dataList
end

function BattleConfig:getBattleLevelCO(levelCode)
	local levelCO = self._cfgLevel[levelCode]

	if not levelCO then
		local path = "logic.config.leveleditor.t_level_config_" .. levelCode

		levelCO = require(path)
		self._cfgLevel[levelCode] = levelCO
	end

	return levelCO
end

function BattleConfig:getCheckerBoardCO(checkerBoardCode)
	local checkerBoardCO = self._cfgCheckerBoard[checkerBoardCode]

	if not checkerBoardCO then
		local path = "logic.config.leveleditor.t_checkerboard_" .. checkerBoardCode

		checkerBoardCO = require(path)
		self._cfgCheckerBoard[checkerBoardCode] = checkerBoardCO
	end

	return checkerBoardCO
end

function BattleConfig:getBattleAnswer(answerStr)
	local hasFind = false

	for _, v in pairs(self._cfgBattlePlotEvent.dataList) do
		if not string.nilorempty(v.answer) and v.answer == answerStr then
			hasFind = true

			break
		end
	end

	return hasFind
end

function BattleConfig:getBattlePlotEventChainCO(groupCode, chainCode)
	local groupData = groupCode and self._cfgBattlePlotEvent[groupCode] or false

	if groupData then
		local chainData = chainCode and groupData[chainCode] or false

		if chainData then
			return chainData
		end
	end

	return false
end

function BattleConfig:hasAnswerByGroupCode(groupCode)
	local hasFind = false

	for _, v in pairs(self._cfgBattlePlotEvent.dataList) do
		if v.groupCode == groupCode and not string.nilorempty(v.answer) then
			hasFind = true

			break
		end
	end

	return hasFind
end

function BattleConfig:getClientEventTriggerCO(code)
	local eventTriggerCO = self._cfgBattleClientEventTrigger[code]

	if not eventTriggerCO and enableErrorLog then
		printError("Cannot find battle client event trigger config ", code)
	end

	return eventTriggerCO
end

function BattleConfig:getTagPerformanceCO(modelCode, tagType)
	local tagsOfModel = self._cfgTagPerformance[modelCode]

	if tagsOfModel then
		return tagsOfModel[tagType]
	end

	return false
end

BattleConfig.instance = BattleConfig.New()

return BattleConfig
