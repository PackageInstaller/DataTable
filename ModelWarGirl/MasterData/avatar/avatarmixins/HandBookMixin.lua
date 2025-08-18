-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Avatar\\AvatarMixins\\HandBookMixin.lua

local ResBookTask = require("ClientData/ResBookTask")
local ResHandBookHero = require("ClientData/ResHandBookHero")
local ResSkillConfig = require("ClientData/ResSkillConfig")
local ResHandBookArtifact = require("ClientData/ResHandBookArtifact")
local ResMonument = require("ClientData/ResMonument")
local HeroSkill = require("Common/Object/HeroSkill")
local ResColor = require("ClientData/ResColor")
local ResCampScore = require("ClientData/ResCampScore")
local ResRentTeamConfig = require("ClientData/ResRentTeamConfig")
local ResHeroProficientLevel = require("ClientData/ResHeroProficientLevel")
local PlotRewindUtils = require("UI/PlotRewind/PlotRewindUtils")
local ResHero = require("ClientData/ResHero")
local ResBookGemAttr = require("ClientData/ResBookGemAttr")
local ResBookGemAttrLimit = require("ClientData/ResBookGemAttrLimit")
local ResBookGemGroupLevelLimit = require("ClientData/ResBookGemGroupLevelLimit")
local ResBookGemAttrLevelLimit = require("ClientData/ResBookGemAttrLevelLimit")
local UserData = require("Helper/UserData")
local LuaToolkit = Framework.Tools.LuaToolkit
local EventConst = require("EventConst")
local HandBookMixin = {}

function HandBookMixin:initHandBookMixin(baseData, syncData)
	self:initHankBookData(syncData.other.book)
	self:initMonumentData(syncData.other.monument)
	self:initProficientData(syncData.other.proficient)
	self:initPlotRewindData()
end

function HandBookMixin:initCheckHandBookMixin()
	self:refreshTeamPatchRed()
	self:checkProficientRedHint()

	self.slotHandBookTeamOpen = Slot(self.checkProficientRedHint, self)
	self.slotRefreshTeamPatchRed = Slot(self.refreshTeamPatchRed, self)

	EventCenter.addEventListener(EventConst.CONDITION_LOCK_CHANGED, self.slotHandBookTeamOpen, Const.CONDITION_LIMIT_HANDBOOK_TEAM)
	EventCenter.addEventListener(EventConst.ITEM_UPDATE, self.slotRefreshTeamPatchRed)
	EventCenter.addEventListener(EventConst.CONDITION_LOCK_CHANGED, self.slotRefreshTeamPatchRed)
end

function HandBookMixin:destroyHandBookMixin()
	EventCenter.removeEventListener(EventConst.CONDITION_LOCK_CHANGED, self.slotHandBookTeamOpen, Const.CONDITION_LIMIT_HANDBOOK_TEAM)
	EventCenter.removeEventListener(EventConst.ITEM_UPDATE, self.slotRefreshTeamPatchRed)
	EventCenter.removeEventListener(EventConst.CONDITION_LOCK_CHANGED, self.slotRefreshTeamPatchRed)
end

function HandBookMixin:initHankBookData(bookData)
	for _, info in ipairs(bookData.hero) do
		self.handBookHeroDic[info.id] = 1
		self.heroStoryStateDic[info.id] = utils.getBitsDictFromByteString(info.crystal_unlock)
	end

	for _, info in ipairs(bookData.artifact) do
		self.handBookArtifactDic[info.id] = 1
	end

	self.handBookTaskDic = {}

	for taskId, taskItem in ipairs(bookData.task.item) do
		self.handBookTaskDic[taskId] = {}
		self.handBookTaskDic[taskId].progress = taskItem.progress
		self.handBookTaskDic[taskId].status = taskItem.status
	end

	self:checkHandBookCanGet()
end

function HandBookMixin:onHeroCrystalStoryUnlockResp(heroId, crystal_unlock)
	self.heroStoryStateDic[heroId] = utils.getBitsDictFromByteString(crystal_unlock)

	for _, hero in pairs(self.heroDic) do
		if hero.id == heroId then
			hero:setCrystalStoryData(nil, self.heroStoryStateDic[heroId])
		end
	end

	local heroMainDlg = UIManager.tryGetUI("heroMainDlg")

	if heroMainDlg then
		local storyPanel = heroMainDlg.heroContentPanel.panelList[Const.HERO_CONTENT_PANEL.CRYSTAL_STORY]

		if storyPanel and storyPanel:getVisible() then
			storyPanel:onHeroCrystalStoryUnlockResp(heroId)
		end
	end
end

function HandBookMixin:initMonumentData(monumentData)
	self.monumentAwardGetList = self:getHandBookRankAwardGet(monumentData.awarded.bits)
	self.rankAchieveDic = {}

	for id, achieveInfo in pairs(ResMonument) do
		local achieve = {}

		achieve.resData = achieveInfo
		achieve.svrData = {}
		achieve.svrData.status = self.monumentAwardGetList[id] and Const.TASK_STATUS.AWARD_GOT or Const.TASK_STATUS.IN_PROCESS

		if not self.rankAchieveDic[achieveInfo.type] then
			self.rankAchieveDic[achieveInfo.type] = {}
		end

		self.rankAchieveDic[achieveInfo.type][achieveInfo.id] = achieve
	end

	self:checkHandBookMonumentCanGet()
end

function HandBookMixin:getIdGrowthestHeroDic()
	local idHeroDic = {}

	for _, hero in pairs(self.heroDic) do
		if not idHeroDic[hero.id] then
			idHeroDic[hero.id] = hero
		elseif hero.star ~= idHeroDic[hero.id].star and hero.star > idHeroDic[hero.id].star then
			idHeroDic[hero.id] = hero
		elseif hero.level ~= idHeroDic[hero.id].level and hero.level > idHeroDic[hero.id].level then
			idHeroDic[hero.id] = hero
		elseif hero.step ~= idHeroDic[hero.id].step and hero.step > idHeroDic[hero.id].step then
			idHeroDic[hero.id] = hero
		end
	end

	return idHeroDic
end

local function _sortHandBookObj(a, b)
	if a.isShowGray ~= b.isShowGray then
		return a.isShowGray < b.isShowGray
	elseif a.handInfo.id ~= b.handInfo.id then
		return a.handInfo.id < b.handInfo.id
	end
end

function HandBookMixin:getHandBookHeroList(isGrowth)
	local handHeros = {}
	local spMark = LuaToolkit.GetPatchSPMark()
	local idHeroDic = {}

	if isGrowth then
		idHeroDic = self:getIdGrowthestHeroDic()
	end

	for i, handInfo in pairs(ResHandBookHero) do
		if ClientUtils.isTimeConfigPassed(handInfo.valid_time_id) then
			if spMark and handInfo.show_spmark and not LuaToolkit.IsEditor() then
				for _, showMark in ipairs(handInfo.show_spmark) do
					if showMark == spMark then
						self:addHeroToHands(handHeros, handInfo, idHeroDic, isGrowth)

						break
					end
				end
			else
				self:addHeroToHands(handHeros, handInfo, idHeroDic, isGrowth)
			end
		end
	end

	table.sort(handHeros, _sortHandBookObj)

	return handHeros
end

function HandBookMixin:addHeroToHands(handHeros, handInfo, idHeroDic, isGrowth)
	local hero = {}

	if isGrowth then
		if idHeroDic[handInfo.hero_id] then
			hero = idHeroDic[handInfo.hero_id]
		else
			hero = self:getHandBookHero(handInfo)
		end

		hero.handInfo = handInfo
	else
		hero = self:getHandBookHero(handInfo)
	end

	local geted = self.handBookHeroDic and self.handBookHeroDic[hero.id] ~= nil
	local bagHad = idHeroDic and idHeroDic[hero.id] ~= nil

	if isGrowth then
		hero.isShowGray = (not geted or isGrowth and not bagHad) and 1 or 0
	else
		hero.isShowGray = 0
	end

	if Const.REVIEW_VERSION and handInfo.review_show and handInfo.review_show == 1 then
		if geted then
			table.insert(handHeros, hero)
		end
	else
		table.insert(handHeros, hero)
	end
end

function HandBookMixin:getHandBookHero(handInfo)
	local hero = BaseObject.GetObject(handInfo.hero_id)

	hero.star = handInfo.show_star
	hero.handInfo = handInfo
	hero.skillBase = HeroSkill(hero.resData.attack_id, utils.getHeroMaxSkillLevel(hero, Const.HERO_SKILL_FIELD.ATTACK), Const.HERO_SKILL_FIELD.ATTACK)
	hero.skillLast = HeroSkill(hero.resData.skill_id, utils.getHeroMaxSkillLevel(hero, Const.HERO_SKILL_FIELD.SKILL), Const.HERO_SKILL_FIELD.SKILL)
	hero.skillPassive1 = HeroSkill(hero.resData.enter_passive, utils.getHeroMaxSkillLevel(hero, Const.HERO_SKILL_FIELD.ENTER_PASSIVE), Const.HERO_SKILL_FIELD.ENTER_PASSIVE)
	hero.skillPassive2 = HeroSkill(hero.resData.hero_passive, utils.getHeroMaxSkillLevel(hero, Const.HERO_SKILL_FIELD.HERO_PASSIVE), Const.HERO_SKILL_FIELD.HERO_PASSIVE)

	return hero
end

function HandBookMixin:getHandBookHeroById(heroId)
	for i, handInfo in pairs(ResHandBookHero) do
		if heroId == handInfo.hero_id then
			return self:getHandBookHero(handInfo)
		end
	end
end

function HandBookMixin:getIdGrowthestArtifactDic()
	local idArtifactDic = {}

	for _, artifact in pairs(self.bagArtifacts) do
		if not idArtifactDic[artifact.id] then
			idArtifactDic[artifact.id] = artifact
		elseif artifact.enhanceLevel ~= idArtifactDic[artifact.id].enhanceLevel and artifact.enhanceLevel > idArtifactDic[artifact.id].enhanceLevel then
			idArtifactDic[artifact.id] = artifact
		elseif artifact.breakLevel ~= idArtifactDic[artifact.id].breakLevel and artifact.breakLevel > idArtifactDic[artifact.id].breakLevel then
			idArtifactDic[artifact.id] = artifact
		elseif artifact.enhanceExp ~= idArtifactDic[artifact.id].enhanceExp and artifact.enhanceExp > idArtifactDic[artifact.id].enhanceExp then
			idArtifactDic[artifact.id] = artifact
		end
	end

	return idArtifactDic
end

function HandBookMixin:getHandBookArtifactList(isGrowth)
	local handArtifacts = {}
	local idArtifactDic = {}

	if isGrowth then
		idArtifactDic = self:getIdGrowthestArtifactDic()
	end

	for i, handInfo in pairs(ResHandBookArtifact) do
		if ClientUtils.isTimeConfigPassed(handInfo.valid_time_id) then
			local artifact = {}

			if isGrowth then
				if idArtifactDic[handInfo.artifact_id] then
					artifact = idArtifactDic[handInfo.artifact_id]
					artifact.handInfo = handInfo
				else
					artifact = self:getHandBookArtifactByHandInfo(handInfo)
				end
			else
				artifact = self:getHandBookArtifactByHandInfo(handInfo)
			end

			table.insert(handArtifacts, artifact)
		end
	end

	table.sort(handArtifacts, _sortHandBookObj)

	return handArtifacts
end

function HandBookMixin:getHandBookArtifactByHandInfo(handInfo)
	local artifact = BaseObject.GetObject(handInfo.artifact_id)

	artifact.handInfo = handInfo
	artifact.enhanceLevel = handInfo.show_level
	artifact.breakLevel = self:getBreakLvByEnhanceLv(artifact)
	artifact.skillLevel = artifact:getSkillLevel()
	artifact.skill = HeroSkill(artifact.resData.passive_id, artifact.skillLevel, Const.HERO_SKILL_FIELD.ENTER_PASSIVE)

	return artifact
end

function HandBookMixin:onBookTaskProgressNotify(taskIds, tasks)
	for idx, id in ipairs(taskIds) do
		self.handBookTaskDic[id] = tasks[idx]
	end

	self:refreshHandBookTask()
end

function HandBookMixin:onBookTaskGetAwardResp(taskId, status)
	self.handBookTaskDic[taskId].status = status

	if ResBookTask[taskId].type == Const.HANDBOOK_AWARD_CAMPDEFINE then
		self:checkHandBookCanGet()

		local handBookAwardDlg = UIManager.getUI("handBookAwardDlg", nil, false)

		if handBookAwardDlg then
			handBookAwardDlg:refreshForTotalAwardPanel()
		end
	elseif ResBookTask[taskId].type == Const.HANDBOOK_AWARD_HERODEFINE then
		self:checkHandBookCanGet()

		local handBookAwardDlg = UIManager.getUI("handBookAwardDlg", nil, false)

		if handBookAwardDlg then
			handBookAwardDlg:refreshHintNew()
		end
	end

	MsgManager.clientNotice(Const.HANDBOOK_GET_AWARD_NOTICE)
end

function HandBookMixin:refreshHandBookTask()
	self:checkHandBookCanGet()

	local handBookAwardDlg = UIManager.getUI("handBookAwardDlg", nil, false)

	if handBookAwardDlg then
		handBookAwardDlg:refreshShow()
	end
end

function HandBookMixin:checkHandBookCanGet()
	self.handbookAwardCanGet = {}

	local haveAward = false

	for taskId, taskItem in pairs(self.handBookTaskDic) do
		if ResBookTask[taskId] and taskItem.status == Const.TASK_STATUS.COMPLETE then
			haveAward = true

			local page = ResBookTask[taskId].page

			if not self.handbookAwardCanGet[page] then
				self.handbookAwardCanGet[page] = {}
			end

			self.handbookAwardCanGet[page][taskId] = 1
		end
	end

	RedDotManager.setKeyState(UIConst.RD_HINT_HANDBOOK_AWARD, haveAward)
end

function HandBookMixin:checkHandBookMonumentCanGet()
	local haveAward = false

	self.handbookMonumentCanGet = {}

	for monuType, achieveDic in pairs(self.rankAchieveDic) do
		for _, achieveInfo in pairs(achieveDic) do
			if achieveInfo.svrData.status == Const.TASK_STATUS.COMPLETE then
				haveAward = true

				if not self.handbookMonumentCanGet[monuType] then
					self.handbookMonumentCanGet[monuType] = {}
				end

				self.handbookMonumentCanGet[monuType][achieveInfo.resData.id] = 1
			end
		end
	end

	RedDotManager.setKeyState(UIConst.RD_HINT_HANDBOOK_MONUMENT, haveAward)
end

function HandBookMixin:getHandBookAwardInfo()
	local awardInfo = {}
	local spMark = LuaToolkit.GetPatchSPMark()
	local isEditor = LuaToolkit.IsEditor()

	for _, taskinfo in pairs(ResBookTask) do
		if ClientUtils.isTimeConfigPassed(taskinfo.valid_time_id) then
			local needTask = false

			if taskinfo.show_spmark then
				for _, showMark in ipairs(taskinfo.show_spmark) do
					if showMark == spMark then
						needTask = true

						break
					end
				end
			else
				needTask = true
			end

			if needTask or isEditor then
				if not awardInfo[taskinfo.page] then
					awardInfo[taskinfo.page] = {}
				end

				if taskinfo.type == Const.HANDBOOK_AWARD_HERODEFINE then
					if not awardInfo[taskinfo.page].herosDefine then
						awardInfo[taskinfo.page].herosDefine = {}
					end

					local heroDefineInfo = {}

					heroDefineInfo.heroIds = {}

					for i, heroInfo in ipairs(taskinfo.hero) do
						table.insert(heroDefineInfo.heroIds, heroInfo.id)
					end

					for k, v in pairs(taskinfo) do
						heroDefineInfo[k] = v
					end

					heroDefineInfo.status = self.handBookTaskDic[heroDefineInfo.id] and self.handBookTaskDic[heroDefineInfo.id].status or 0

					table.insert(awardInfo[taskinfo.page].herosDefine, heroDefineInfo)
				end

				if taskinfo.type == Const.HANDBOOK_AWARD_CAMPDEFINE then
					if not awardInfo[taskinfo.page].campDefine then
						awardInfo[taskinfo.page].campDefine = {}
					end

					awardInfo[taskinfo.page].campDefine = taskinfo
				end
			end
		end
	end

	return awardInfo
end

function HandBookMixin:getHandBookRankAwardGet(award_bit)
	local award_get = {}

	for i, v in pairs(ResMonument) do
		award_get[i] = false
	end

	if award_bit ~= 0 then
		local awardGetList = ClientUtils.getBitsListFromByteString(award_bit)

		for i, pos in ipairs(awardGetList) do
			award_get[pos] = true
		end
	end

	return award_get
end

function HandBookMixin:onMonumentMsgGetAwardResp(ids)
	for _, id in ipairs(ids) do
		local monuType = ResMonument[id].type

		self.rankAchieveDic[monuType][id].svrData.status = Const.TASK_STATUS.AWARD_GOT
	end

	self:checkHandBookMonumentCanGet()

	local handBookRankSelectDlg = UIManager.getUI("handBookRankSelectDlg", nil, false)

	if handBookRankSelectDlg then
		handBookRankSelectDlg:refreshForAward()
	end

	local masterApprenticeMainDlg = UIManager.getUI("masterApprenticeMainDlg", nil, false)

	if masterApprenticeMainDlg then
		masterApprenticeMainDlg:refreshForAward()
	end

	local handBookRankInfoDlg = UIManager.getUI("handBookRankInfoDlg", nil, false)

	if handBookRankInfoDlg then
		handBookRankInfoDlg.curPage:refreshRankCell(true)
	end
end

function HandBookMixin:refreshRecordDatas(records)
	for _, record in ipairs(records) do
		if self.rankAchieveDic[record.type][record.id].svrData.status == Const.TASK_STATUS.IN_PROCESS then
			self.rankAchieveDic[record.type][record.id].svrData.status = Const.TASK_STATUS.COMPLETE
		end

		self.rankAchieveDic[record.type][record.id].svrData.tick = record.tick
		self.rankAchieveDic[record.type][record.id].svrData.comm = record.comm
	end
end

function HandBookMixin:onMonumentMsgGetResp(records)
	self:refreshRecordDatas(records)
	self:checkHandBookMonumentCanGet()
end

function HandBookMixin:onMonumentMsgCompleteNotify(records)
	self:refreshRecordDatas(records)

	for _, record in ipairs(records) do
		local playerName = utils.GetPlayerName(record.comm.name)
		local colorfulPlayerName = utils.getColorfulStr(playerName, ResColor.BLUE)
		local monumentRes = ResMonument[record.id]
		local scoreStr = UIConst.getRankScoreStr(Const.MONUMENT_RANK_TYPE[monumentRes.type], monumentRes.param)
		local colorfulScoreStr = utils.getColorfulStr(scoreStr, ResColor.QUALITYORANGE)
		local msg = ""

		if monumentRes.type == Const.MONUMENT_TYPE_GROUP1 then
			msg = utils.format(Lang.get(1851), colorfulPlayerName, utils.getColorfulStr(Lang.get(1853), ResColor.QUALITYORANGE), colorfulScoreStr)
		elseif monumentRes.type == Const.MONUMENT_TYPE_GROUP2 then
			msg = utils.format(Lang.get(1851), colorfulPlayerName, utils.getColorfulStr(Lang.get(1854), ResColor.QUALITYORANGE), colorfulScoreStr)
		elseif monumentRes.type == Const.MONUMENT_TYPE_GROUP3 then
			msg = utils.format(Lang.get(1851), colorfulPlayerName, utils.getColorfulStr(Lang.get(1855), ResColor.QUALITYORANGE), colorfulScoreStr)
		elseif monumentRes.type == Const.MONUMENT_TYPE_STAGE then
			msg = utils.format(Lang.get(1852), colorfulPlayerName, utils.getColorfulStr(Lang.get(1856), ResColor.QUALITYORANGE), colorfulScoreStr)
		elseif monumentRes.type == Const.MONUMENT_TYPE_ONCE_TOWER then
			msg = utils.format(Lang.get(1852), colorfulPlayerName, utils.getColorfulStr(Lang.get(1857), ResColor.QUALITYORANGE), colorfulScoreStr)
		end

		CurAvatar:receiveFakeSystemMsg(msg)
	end

	self:checkHandBookMonumentCanGet()
end

function HandBookMixin:onMonumentMsgNotify(records)
	self:refreshRecordDatas(records)
	self:checkHandBookMonumentCanGet()
end

local function _sortByStar(a, b)
	if a.star ~= b.star then
		return a.star > b.star
	elseif a.id ~= b.id then
		return a.id > b.id
	end
end

function HandBookMixin:getHeroTotalCampScore(camp)
	local starScore = {}
	local totalScore = 0
	local heroStarInfoList = {}

	for _, hero in pairs(self.heroDic) do
		if camp == nil or hero.camp == camp then
			local heroStarInfo = {}

			heroStarInfo.star = hero.star
			heroStarInfo.id = hero.id

			table.insert(heroStarInfoList, heroStarInfo)
		end
	end

	table.sort(heroStarInfoList, _sortByStar)

	local tempIdDic = {}

	for _, hero in ipairs(heroStarInfoList) do
		if not tempIdDic[hero.id] and ResCampScore[hero.star] and ResCampScore[hero.star].score > 0 then
			totalScore = totalScore + ResCampScore[hero.star].score

			if not starScore[hero.star] then
				starScore[hero.star] = ResCampScore[hero.star].score
			else
				starScore[hero.star] = starScore[hero.star] + ResCampScore[hero.star].score
			end

			tempIdDic[hero.id] = true
		end
	end

	return totalScore, starScore
end

function HandBookMixin:initProficientData(data)
	self.proficientData = utils.deepcopy(data)
	self.proficientData.group = self.proficientData.group or {}

	for _, data in pairs(self.proficientData.group) do
		data.item = data.item or {}
	end

	self.proficientData.other = self.proficientData.other or {}
	self.proficientData.other.item = self.proficientData.other.item or {}
	self.proficientData.ur = self.proficientData.ur or {}
	self.proficientData.ur.item = self.proficientData.ur.item or {}

	self:initTeamPatchData(data.group)
end

function HandBookMixin:initTeamPatchData(groupList)
	if not Const.TEAM_PATCH_OPEN then
		return
	end

	self.teamPatchDataDic = {}

	if groupList then
		for _, group in pairs(groupList) do
			local attrData = group and group.attr_data

			if attrData then
				local teamId = group.group_id
				local patchData = {}
				local patchList = attrData.item

				if patchList then
					for _, patch in pairs(patchList) do
						patchData[patch.attr] = patch.total_value
					end
				end

				self.teamPatchDataDic[teamId] = patchData
			end
		end
	end
end

function HandBookMixin:getTeamPatchTotalNum(teamId)
	local patchData = self.teamPatchDataDic and self.teamPatchDataDic[teamId]
	local num = 0

	if patchData then
		for attr, value in pairs(patchData) do
			local bookGemAttrLimitConfig = ResBookGemAttrLimit[attr]

			num = num + math.ceil(value / bookGemAttrLimitConfig.rate)
		end
	end

	return num
end

function HandBookMixin:getTeamPatchAttrValue(teamId, attrId)
	local patchData = self.teamPatchDataDic and self.teamPatchDataDic[teamId]
	local value = patchData and patchData[attrId] or 0

	return value
end

function HandBookMixin:getTeamPatchAttrPatchNum(teamId, attrId)
	local patchData = self.teamPatchDataDic and self.teamPatchDataDic[teamId]
	local value = patchData and patchData[attrId] or 0
	local limitConfig = ResBookGemAttrLimit[attrId]
	local level = math.ceil(value / limitConfig.rate)

	return level
end

function HandBookMixin:checkTeamPatchFuncOpen()
	local check = Const.TEAM_PATCH_OPEN and not ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_REARHOUSE_POPULARITY_AWARD)

	return check
end

function HandBookMixin:refreshTeamPatchRed()
	local check = self.checkTeamPatchRed or false

	self.checkTeamPatchRed = false

	if self:checkTeamPatchFuncOpen() then
		for i = 1, 6 do
			for attr, configDic in pairs(ResBookGemAttr) do
				local value = self:getTeamPatchAttrValue(i, attr)
				local limitConfig = ResBookGemAttrLimit[attr]
				local left = limitConfig.limit - value

				for gem_id, config in pairs(configDic) do
					if left > 0 then
						local gemNum = CurAvatar:getItemNumById(gem_id)

						if gemNum > 0 then
							self.checkTeamPatchRed = true

							goto label_36_0
						end
					end
				end
			end
		end
	end

	::label_36_0::

	if check ~= self.checkTeamPatchRed then
		RedDotManager.setKeyState(UIConst.RD_HINT_HANDBOOK_TEAM_PATCH, self.checkTeamPatchRed)
		self:checkProficientRedHint()
	end
end

function HandBookMixin:getTeamPatchLimitDueMaxValue(attrId)
	local limitConfig = ResBookGemAttrLimit[attrId]
	local limit = math.ceil(limitConfig.limit / limitConfig.rate)

	return limit
end

function HandBookMixin:getTeamPatchLimitDueOtherTeam(teamId)
	local minPatchNum = -1

	for i = 1, 6 do
		if i ~= teamId then
			local patchNum = self:getTeamPatchTotalNum(i)

			if minPatchNum == -1 or patchNum < minPatchNum then
				minPatchNum = patchNum
			end
		end
	end

	local limit = 0
	local nextPatchNum = 0

	for _, config in pairs(ResBookGemGroupLevelLimit) do
		if minPatchNum >= config.group_level and (limit == 0 or limit < config.other_limit_level) then
			limit = config.other_limit_level
		end

		if minPatchNum < config.group_level and (nextPatchNum == 0 or nextPatchNum > config.group_level) then
			nextPatchNum = config.group_level
		end
	end

	return limit, nextPatchNum
end

function HandBookMixin:getTeamPatchLimitDueOtherAttr(teamId, attrId)
	local minPatchNum = 0
	local dueAttr = 0
	local patchData = self.teamPatchDataDic and self.teamPatchDataDic[teamId]

	if patchData then
		for attr, value in pairs(patchData) do
			if attr ~= attrId then
				local limitConfig = ResBookGemAttrLimit[attr]
				local patchNum = math.ceil(value / limitConfig.rate)

				if minPatchNum == 0 or patchNum < minPatchNum then
					minPatchNum = patchNum
					dueAttr = attr
				end
			end
		end
	end

	if minPatchNum == 0 then
		for attr, _ in pairs(ResBookGemAttrLimit) do
			if attr ~= attrId then
				dueAttr = attr

				break
			end
		end
	end

	local limit = 0
	local nextPatchNum = 0

	for _, config in pairs(ResBookGemAttrLevelLimit) do
		if minPatchNum >= config.attr_level and (limit == 0 or limit < config.other_limit_level) then
			limit = config.other_limit_level
		end

		if minPatchNum < config.attr_level and (nextPatchNum == 0 or nextPatchNum > config.attr_level) then
			nextPatchNum = config.attr_level
		end
	end

	return limit, dueAttr, nextPatchNum
end

function HandBookMixin:onProficentGetScoreResp(item, score, group_id, is_ur)
	local gInfo = self:getProficientGInfo(group_id, is_ur == 1)

	if gInfo then
		gInfo.score = score

		for _, _pItem in ipairs(item) do
			for i, pItem in ipairs(gInfo.item) do
				if pItem.resid == _pItem.resid then
					gInfo.item[i] = _pItem

					break
				end
			end
		end
	end

	local ui = UIManager.getUI("handBookTeamGetGPDlg", nil, false)

	if ui then
		ui:refreshUI()
	end

	local ui = UIManager.getUI("handBookTeamDetailDlg", nil, false)

	if ui then
		ui:refreshUI()
	end

	self:checkProficientRedHint()
end

function HandBookMixin:onProficentGetOtherScoreResp(item, score)
	local gInfo = self:getOtherProficientGInfo()

	if gInfo then
		gInfo.score = score

		for _, _pItem in ipairs(item) do
			for i, pItem in ipairs(gInfo.item) do
				if pItem.resid == _pItem.resid then
					gInfo.item[i] = _pItem

					break
				end
			end
		end
	end

	local ui = UIManager.getUI("handBookTeamGetGPDlg", nil, false)

	if ui then
		ui:refreshUI()
	end

	local ui = UIManager.getUI("handBookTeamDetailDlg", nil, false)

	if ui then
		ui:refreshUI()
	end

	self:checkProficientRedHint()
end

function HandBookMixin:onProficentLevelUpResp(group_id, level, is_ur)
	local gInfo = self:getProficientGInfo(group_id, is_ur == 1)

	if gInfo then
		gInfo.level = level
	end

	local ui = UIManager.getUI("handBookTeamUpgradeDlg", nil, false)

	if ui then
		ui:refreshUI(true)
	end

	local ui = UIManager.getUI("handBookTeamDetailDlg", nil, false)

	if ui then
		ui:refreshUI(true)
	end

	self:checkProficientRedHint()
end

function HandBookMixin:onProficentItemNotify(item)
	if self.proficientData then
		local hero = BaseObject.GetObject(item.resid)

		if hero.isURHero and hero:isURHero() then
			local isFind = false

			for i, pInfo in ipairs(self.proficientData.ur.item or {}) do
				if pInfo.resid == item.resid then
					for k, v in pairs(item) do
						self.proficientData.ur.item[i][k] = v
					end

					isFind = true

					break
				end
			end

			if not isFind then
				table.insert(self.proficientData.ur.item, item)
			end
		else
			local groupIndex
			local teamData = self:getConfigTeamHeros()

			for i, data in ipairs(teamData) do
				for _, resid in ipairs(data) do
					if resid == item.resid then
						groupIndex = i

						break
					end
				end
			end

			local isFind = false

			if groupIndex then
				local gInfo = self:getProficientGInfo(groupIndex)

				if gInfo then
					for i, pInfo in ipairs(gInfo.item) do
						if pInfo.resid == item.resid then
							for k, v in pairs(item) do
								gInfo.item[i][k] = v
							end

							isFind = true

							break
						end
					end

					if not isFind then
						table.insert(gInfo.item, item)
					end
				else
					local data = {
						score = 0,
						level = 0,
						group_id = groupIndex,
						item = {
							item
						}
					}

					table.insert(self.proficientData.group, data)
				end
			end
		end
	end

	self:checkProficientRedHint()
	self:onCollectAchieveProgressNotify(Const.CRYSTAL_TYPE_HERO, item.resid, item.score, ClientUtils.getBitsDictFromByteString(item.collect_awarded))
end

function HandBookMixin:onProficentOtherItemNotify(item)
	if self.proficientData then
		local isFind = false
		local gInfo = self:getOtherProficientGInfo()

		if gInfo then
			for i, pInfo in ipairs(gInfo.item) do
				if pInfo.resid == item.resid then
					for k, v in pairs(item) do
						gInfo.item[i][k] = v
					end

					isFind = true

					break
				end
			end

			if not isFind then
				table.insert(gInfo.item, item)
			end
		else
			local data = {
				score = 0,
				level = 0,
				group_id = Const.OTHER_TEAM_INDEX,
				item = {
					item
				}
			}

			table.insert(self.proficientData.other, data)
		end
	end

	self:checkProficientRedHint()
end

function HandBookMixin:getProficientGInfo(teamIndex, isUR)
	if self.proficientData then
		if isUR then
			return self.proficientData.ur
		else
			for i, gInfo in ipairs(self.proficientData.group) do
				if gInfo.group_id == teamIndex then
					return gInfo
				end
			end
		end
	end
end

function HandBookMixin:getOtherProficientGInfo(...)
	if self.proficientData and self.proficientData.other and self.proficientData.other.item then
		return self.proficientData.other
	end
end

function HandBookMixin:getProficientLevelByTeamIndex(teamIndex, isUR)
	local gInfo = self:getProficientGInfo(teamIndex, isUR)

	if gInfo then
		return gInfo.level
	end

	return 0
end

function HandBookMixin:isNewProficient(teamIndex, isUR)
	if teamIndex ~= Const.UR_TEAM_INDEX and (teamIndex > 6 or teamIndex < 1) then
		return false
	end

	local gInfo = self:getProficientGInfo(teamIndex, isUR)

	if gInfo == nil then
		return false
	end

	local data = self:getNewProficientInfo(gInfo)

	return #data > 0
end

function HandBookMixin:isOtherNewProficient(...)
	local gInfo = self:getOtherProficientGInfo()

	if gInfo == nil then
		return false
	end

	local data = self:getNewProficientInfo(gInfo)

	return #data > 0
end

function HandBookMixin:isProficientLvUp(teamIndex, targetLevel, isUR)
	if teamIndex ~= Const.UR_TEAM_INDEX and (teamIndex > 6 or teamIndex < 1) then
		return false
	end

	local pInfo = self:getProficientGInfo(teamIndex, isUR)

	if pInfo == nil then
		return false
	end

	local info = self:getProficientInfo(teamIndex, isUR)

	if info == nil then
		return false
	end

	if targetLevel then
		return pInfo.level < info.level and targetLevel <= info.level
	else
		return pInfo.level < info.level
	end
end

function HandBookMixin:getNewProficientInfo(gInfo)
	local data = {}

	if gInfo == nil or gInfo.item == nil then
		return data
	end

	for i, item in ipairs(gInfo.item) do
		local bitMap = ClientUtils.getBitsDictFromByteString(item.awarded)

		for i = 1, item.score do
			if not bitMap[i] then
				table.insert(data, {
					info = item,
					pos = i
				})
			end
		end
	end

	return data
end

function HandBookMixin:checkProficientRedHint(...)
	if ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_HANDBOOK_TEAM) then
		return
	end

	local result = false

	for i = 1, 6 do
		result = self:isNewProficient(i)
		result = result or self:isProficientLvUp(i)

		if result then
			break
		end
	end

	if not result then
		result = self:isNewProficient(Const.UR_TEAM_INDEX, true)
		result = result or self:isProficientLvUp(Const.UR_TEAM_INDEX, nil, true)
	end

	if not result and Const.IS_SHOW_OTHER_TEAM_PROFICIENT then
		result = self:isOtherNewProficient()
	end

	result = result or self.checkTeamPatchRed or false

	RedDotManager.setKeyState(UIConst.RD_HINT_PROFICIENT, result)
	self:checkCrystalUpHint()
end

function HandBookMixin:getProficientInfo(teamIndex, isUR)
	local pData = self:getProficientGInfo(teamIndex, isUR)
	local teamScore = 0

	if pData then
		teamScore = pData.score
	end

	return utils.getProficientLevelInfo(teamScore, self:getTotalProficient(), isUR)
end

function HandBookMixin:getTotalProficient(...)
	local score = 0

	for i, gInfo in ipairs(self.proficientData.group) do
		score = score + gInfo.score
	end

	if self.proficientData.ur and self.proficientData.ur.score then
		score = score + self.proficientData.ur.score
	end

	return score
end

function HandBookMixin:getRentTeamCount(...)
	local totalScore = self:getTotalProficient()
	local totalCount = #ResRentTeamConfig

	for i = totalCount, 1, -1 do
		local info = ResRentTeamConfig[i]

		if totalScore >= info.total_score then
			local nextInfo = ResRentTeamConfig[math.min(totalCount, i + 1)]

			return info, nextInfo, i == totalCount
		end
	end
end

function HandBookMixin:initPlotRewindData()
	self:checkPlotRewindRedHint()

	local hasNew, nearestUnlockCountDown = PlotRewindUtils.CheckNewAllSiderLine()

	if nearestUnlockCountDown and nearestUnlockCountDown > 0 then
		if self.plotRewindCountdownTimer then
			self.plotRewindCountdownTimer:Stop()
		end

		self.plotRewindCountdownTimer = Timer.New(Slot(self.checkPlotRewindRedHint, self), nearestUnlockCountDown + 1)

		self.plotRewindCountdownTimer:Start()
	end
end

function HandBookMixin:checkPlotRewindRedHint()
	local state = false
	local plotRewindState = not ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_HANDBOOK_PLOTREWIND)
	local hasClicked = UserData.loadCommonData(CurAvatar.uid .. PlotRewindUtils.HasClickedString)

	if plotRewindState and not hasClicked then
		state = true
	end

	local hasNew = PlotRewindUtils.CheckNewAllSiderLine()

	if plotRewindState and hasNew then
		state = true
	end

	RedDotManager.setKeyState(UIConst.RD_HINT_PLOTREWIND, state)
end

function HandBookMixin:getHeroMaxStarEver(hid)
	local resData = ResHero[hid]
	local maxStar = -1

	if resData then
		local gInfo

		if resData.belong_team >= 1 and resData.belong_team <= 6 then
			local hero = BaseObject.GetObject(hid)

			gInfo = self:getProficientGInfo(resData.belong_team, hero:isURHero())
		else
			gInfo = self:getOtherProficientGInfo()
		end

		if gInfo then
			for i, item in ipairs(gInfo.item) do
				if item.resid == hid then
					maxStar = math.min(15, item.score + (resData.ori_star or 5) - 1)
				end
			end
		end
	end

	return maxStar
end

function HandBookMixin:getHeroStarFromProficient(heroId, proficient)
	local resData = ResHero[heroId]
	local pro = proficient + (resData.ori_star or 5) - 1

	return math.min(15, pro), math.max(0, pro - 15)
end

function HandBookMixin:isHeroStoryUnlocked(heroId, type)
	if self.heroStoryStateDic[heroId] and self.heroStoryStateDic[heroId][type] then
		return true
	end
end

function HandBookMixin:onProficentBookGemUseResp(teamId, attr_data)
	local patchData = {}
	local patchList = attr_data.item

	if patchList then
		for _, patch in pairs(patchList) do
			patchData[patch.attr] = patch.total_value
		end
	end

	self.teamPatchDataDic[teamId] = patchData

	self:refreshTeamPatchRed()
	EventCenter.sendEvent(EventConst.HANDBOOK_TEAM_PATCH_CHANGE, teamId)
end

return HandBookMixin
