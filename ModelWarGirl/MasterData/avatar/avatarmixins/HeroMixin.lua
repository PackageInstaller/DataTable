-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Avatar\\AvatarMixins\\HeroMixin.lua

local UIManager = UIManager
local Hero = require("Common/Object/Hero")
local UserData = require("Helper/UserData")
local ResHero = require("ClientData/ResHero")
local ResStar = require("ClientData/ResStar")
local ResStep = require("ClientData/ResStep")
local ResHeroPropRank = require("ClientData/ResHeroPropRank")
local ResHeroStepProp = require("ClientData/ResHeroStepProp")
local ResHeroLevelProp = require("ClientData/ResHeroLevelProp")
local ResStarUpCondition = require("ClientData/ResStarUpCondition")
local ResHeroRecharge = require("ClientData/ResHeroRecharge")
local ResStepCost = require("ClientData/ResStepCost")
local ResStarCost = require("ClientData/ResStarCost")
local ResDrawFakeRand = require("ClientData/ResDrawFakeRand")
local ResRechargeCost = require("ClientData/ResRechargeCost")
local PropHelper = require("Common/FrameBattle/BattleObject/PropHelper")
local DrawCardConfig = require("DesignerScript/DrawCardConfig")
local UIMiscConfig = require("DesignerScript/UIMiscConfig")
local ResItem = require("ClientData/ResItem")
local ResGuideGet = require("ClientData/ResGuideGet")
local ResLevelCost = require("ClientData/ResLevelCost")
local ResHeroMisc = require("ClientData/ResHeroMisc")
local ResEquipSuit = require("ClientData/ResEquipSuit")
local ResColor = require("ClientData/ResColor")
local ResHeroResetMisc = require("ClientData/ResHeroResetMisc")
local ResTower = require("ClientData/ResTower")
local ResRandClient = require("ClientData/ResRandClient")
local ResStarUpRevert = require("ClientData/ResStarUpRevert")
local RearHouseModelCenter = require("Logic/RearHouse/RearHouseModelCenter")
local ResHeroPaint = require("ClientData/ResHeroPaint")
local ResRelationNewHero = require("ClientData/ResRelationNewHero")
local ResAbilityStore = require("ClientData/ResAbilityStore")
local Equip = require("Common/Object/Equip")
local LuaToolkit = Framework.Tools.LuaToolkit
local Artifact = require("Common/Object/Artifact")
local ResRoomHeroShow = require("ClientData/ResRoomHeroShow")
local ResHandBookHero = require("ClientData/ResHandBookHero")
local ResDevelopMisc = require("ClientData/ResDevelopMisc")
local ResWishListHeroControl = require("ClientData/ResWishListHeroControl")
local ResTurnTableMisc = require("ClientData/ResTurnTableMisc")
local ResEquipRecSuit = require("ClientData/ResEquipRecSuit")
local ResDrawPoolClient = require("ClientData/ResDrawPoolClient")
local ResHeroNewPaint = require("ClientData/ResHeroNewPaint")
local ResEquipTowerCustomEquipDrop = require("ClientData/ResEquipTowerCustomEquipDrop")
local ResEquipTowerCustomEquipEffect = require("ClientData/ResEquipTowerCustomEquipEffect")
local ResPetRune = require("ClientData/ResPetRune")
local ResWishListRecommend = require("ClientData/ResWishListRecommend")
local DrawCardUtils = require("UI/DrawCard/DrawCardUtils")
local ResStick = require("ClientData/ResStick")
local ResStickLevel = require("ClientData/ResStickLevel")
local ResClientNotice = require("ClientData/ResClientNotice")
local HeroMixin = {}
local DEFALUT_SORT_HERO_CONFIG = {
	{
		sequence = 0,
		property = "level"
	},
	{
		sequence = 0,
		property = "star"
	},
	{
		sequence = 0,
		property = "inCry"
	},
	{
		sequence = 0,
		property = "step"
	},
	{
		sequence = 0,
		property = "quality"
	}
}

function HeroMixin:initBaseHeroMixin(baseData)
	self.heroDic = {}
end

function HeroMixin:initHeroMixin(baseData, syncData)
	self:resetSortConfig()

	self.bagSize = {}
	self.bagSize[Const.BAG_TYPE_HERO] = syncData.bag.hero.hero_max
	self.fiveUpStarHeroGidList = {}

	self:initHeroData(syncData.bag.hero.hero)
	self:initDrawData(baseData.necessary.draw)
	self:initWishData(syncData.other.rand_common)
	self:initPaintData(syncData.other.hero_paint)

	if Const.PAINT_PLUS_OPEN then
		self:initPaintPlusData(syncData.other.hero_new_paint)
	end

	self:initRelationData(syncData.other.develop)
	self:initStickData(syncData.other.hero_stick)

	self.poolSeqDict = {}
	self.opActSeqDict = {}
	self.poolRecordDict = {}
	self.opActRecordDict = {}
	self.nextStepResetTick = {}

	for pos = 1, 3 do
		self.nextStepResetTick[pos] = 0
	end

	for i, resetRecord in ipairs(baseData.necessary.misc.hero_reset_record) do
		self.nextStepResetTick[i] = resetRecord.step_tick
	end

	self.freeStarRevertTick = baseData.necessary.misc.star_back_card_tick
	self.cacheShowHeros = {}
	self.cacheDelHeros = {}
end

function HeroMixin:getNextStepTick(pos)
	return self.nextStepResetTick[pos] or 0
end

function HeroMixin:getMostEarlyStepTick()
	return self:getNextStepTick(self:getMostEarlyStepPos())
end

function HeroMixin:getMostEarlyStepPos()
	local minTickPos = 1
	local minTick = -1

	for pos, tick in ipairs(self.nextStepResetTick) do
		local limitId = ResHeroResetMisc[2].condition_id[pos]
		local isLocked = ConditionLimitManager.inLimitState(limitId)

		if not isLocked then
			if minTick < 0 then
				minTick = tick
			elseif tick < minTick then
				minTick = tick
				minTickPos = pos
			end
		end
	end

	return minTickPos
end

function HeroMixin:postinitHeroMixin(baseData, syncData)
	self:postInitDrawData()
end

function HeroMixin:resetSortConfig()
	local heroCardSortConfigJson = ClientUtils.table2String(DEFALUT_SORT_HERO_CONFIG)

	UserData.saveCommonData("HeroSort", heroCardSortConfigJson)

	self.heroCardSortConfig = ClientUtils.string2Table(heroCardSortConfigJson)
end

function HeroMixin:initHeroData(heroData)
	self.heroDic = {}
	self.handBookHeroDic = {}
	self.heroStoryStateDic = {}

	self:addNewHero(heroData, nil, true)
end

function HeroMixin:initPaintData(hero_paint)
	self.heroPaintData = {}

	for _, heroPaint in ipairs(hero_paint.data) do
		if heroPaint.level > 0 then
			self.heroPaintData[heroPaint.resid] = {}
			self.heroPaintData[heroPaint.resid].level = heroPaint.level
			self.heroPaintData[heroPaint.resid].abilityList = utils.getAbilityList(heroPaint.resid, heroPaint.ability)

			local paintRecipeId = ResHero[heroPaint.resid].paint_id

			self.heroPaintData[heroPaint.resid].recipeId = paintRecipeId
			self.heroPaintData[heroPaint.resid].resData = ResHeroPaint[paintRecipeId][heroPaint.level]
			self.heroPaintData[heroPaint.resid].changeTick = heroPaint.change_time
		end
	end
end

function HeroMixin:initPaintPlusData(hero_new_paint)
	self.heroPaintPlusData = {}

	if hero_new_paint and hero_new_paint.data then
		for _, heroNewPaint in pairs(hero_new_paint.data) do
			local id = heroNewPaint.resid

			self.heroPaintPlusData[id] = {}
			self.heroPaintPlusData[id].level = heroNewPaint.level
			self.heroPaintPlusData[id].relateLevel = heroNewPaint.relate_level
		end
	end
end

function HeroMixin:initRelationData(relationData)
	self.heroRelationData = {}
	self.newRoomHeroIdDic = {}

	if not self:checkRelationRegionPass() then
		return
	end

	for _, relationDev in ipairs(relationData.item) do
		self.heroRelationData[relationDev.resid] = {}
		self.heroRelationData[relationDev.resid].pointDevData = utils.getRelationPointData(relationDev.point)
	end

	self:initRelationHintData(relationData.open.team_status, relationData.open.stage_status)
end

function HeroMixin:initStickData(stickData)
	self.stickData = {}

	for _, stick in ipairs(stickData.data or {}) do
		self.stickData[stick.id] = {
			id = stick.id,
			level = stick.stick_level
		}
	end
end

function HeroMixin:getStickAttrInfo(heroId)
	local stickData = self.stickData[heroId] or {}
	local props = PropHelper.getStickAttr(heroId, stickData)
	local attrZhNameList = {}

	for attrName, attrValue in pairs(props) do
		local attr, value = ClientUtils.getRolePropZhName(attrName, attrValue)

		table.insert(attrZhNameList, {
			zhName = attr,
			value = value
		})
	end

	return attrZhNameList
end

function HeroMixin:checkHasStick(bindHeroId)
	if self.stickData[bindHeroId] and self.stickData[bindHeroId].level > 0 then
		return true
	end

	return false
end

function HeroMixin:getStickDataByHeroId(bindHeroId)
	return self.stickData[bindHeroId]
end

function HeroMixin:isStickMaxLv(bindHeroId)
	if not self:checkHasStick(bindHeroId) then
		return false
	end

	if not Const.HERO_STICK_LV_UP_OPEN then
		return true
	end

	return self.stickData[bindHeroId].level == ResStick[bindHeroId].max_lv
end

function HeroMixin:checkHeroStickCanLvUpByHero(hero)
	return self:checkHeroStickCanLvUp(hero.id)
end

function HeroMixin:checkHeroStickCanLvUp(bindHeroId)
	if not Const.HERO_STICK_LV_UP_OPEN or self:isStickMaxLv() then
		return false
	end

	if self:checkHasStick(bindHeroId) then
		local stickData = self:getStickDataByHeroId(bindHeroId)

		if ResStickLevel[stickData.level + 1] then
			local cost = ResStickLevel[stickData.level + 1].cost
			local needItemId = ResStick[bindHeroId].item_id

			return cost <= CurAvatar:getItemNumById(needItemId)
		end
	end

	return false
end

function HeroMixin:checkHasHeroStickCanLvUp()
	self.canLvUpStickHeroDic = {}
	self.canLvUpStickHeroList = {}

	for heroId, data in pairs(self.stickData) do
		if self:checkHeroStickCanLvUp(heroId) then
			self.canLvUpStickHeroDic[heroId] = true

			table.insert(self.canLvUpStickHeroList, heroId)
		end
	end

	RedDotManager.setKeyState(UIConst.RD_HINT_HERO_STICK_LVUP, #self.canLvUpStickHeroList > 0)
end

function HeroMixin:onHeroStickLevelNotify(heroId, level)
	if self.stickData[heroId] then
		self.stickData[heroId].level = level
	else
		self.stickData[heroId] = {
			id = heroId,
			level = level
		}
	end

	self:checkHasHeroStickCanLvUp()

	if level == 1 then
		local function yesFunc()
			local ui = UIManager.tryGetUI("heroMainDlg")

			ui = ui or UIManager.getUI("heroMainDlg", true)

			ui:jumpToHeroStickPanel(heroId)
		end

		local hero = BaseObject.GetObject(heroId)
		local str = string.format(ResClientNotice[800].notice, hero.name)

		UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, Lang.get(5), str, yesFunc, nil)
	else
		MsgManager.notice(Lang.get(30712))

		local ui = UIManager.tryGetUI("heroMainDlg")

		if ui and ui:getVisible() and ui.heroContentPanel and ui.heroContentPanel:getVisible() then
			ui.heroContentPanel:refreshContentPanel()
		end
	end
end

function HeroMixin:haveNewHeroRelation()
	for heroId, info in pairs(ResRelationNewHero) do
		if ClientUtils.isTimeConfigPassed(info.valid_time_id) and ResHero[heroId] then
			return true
		end
	end

	return false
end

function HeroMixin:initRelationHintData(team_status, stage_status)
	if not self:checkRelationRegionPass() then
		return
	end

	self.relationTeamHintSvrData = {}

	for team_id, statusInfo in ipairs(team_status) do
		self.relationTeamHintSvrData[team_id] = statusInfo.status
	end

	local curTimeId = self:getRelationNewStageCurTimeId()

	if curTimeId then
		for heroId, info in pairs(ResRelationNewHero) do
			if curTimeId == info.valid_time_id and ResHero[heroId] and self.relationTeamHintSvrData[ResHero[heroId].belong_team] == 1 and self.handBookHeroDic[heroId] and self.handBookHeroDic[heroId] == 1 then
				self.newRoomHeroIdDic[heroId] = 1
			end
		end
	end

	self.relationAutoOpenDlg = stage_status
end

local function _sortNewStageTimeId(a, b)
	if a.tick ~= b.tick then
		return a.tick > b.tick
	end
end

function HeroMixin:getRelationNewStageCurTimeId()
	local timeIdInfoList = {}

	for _, heroIdInfo in pairs(ResRelationNewHero) do
		if ClientUtils.isTimeConfigPassed(heroIdInfo.valid_time_id) then
			local timeIdInfo = {}

			timeIdInfo.id = heroIdInfo.valid_time_id
			timeIdInfo.tick = ClientUtils.getTimeConfigTimestamp(timeIdInfo.id)

			table.insert(timeIdInfoList, timeIdInfo)
		end
	end

	table.sort(timeIdInfoList, _sortNewStageTimeId)

	if timeIdInfoList and #timeIdInfoList > 0 then
		return timeIdInfoList[1].id
	end
end

function HeroMixin:getRealtionIdTeamDic()
	local idTeamDic = {}
	local roomHeroListDic = self:getRoomHeroListDic()

	for teamId, heroList in pairs(roomHeroListDic) do
		for i, hero in ipairs(heroList) do
			idTeamDic[hero.id] = teamId
		end
	end

	return idTeamDic
end

local function _sortForRealtionHint(heroA, heroB)
	if heroA.star ~= heroB.star then
		return heroA.star > heroB.star
	else
		return heroA.id < heroB.id
	end
end

function HeroMixin:checkRelationHeroNewHint()
	if not self:checkRelationRegionPass() then
		return
	end

	self.hintNewTeamIdDic = {}

	for heroId, status in pairs(self.newRoomHeroIdDic) do
		if status and status == 1 then
			self.hintNewTeamIdDic[ResHero[heroId].belong_team] = 1
		end
	end

	self.realtionHeroListTop3 = {}
	self.hintRelationSweepTeamDic = {}

	local teamIdHeroListDic = {}

	for gid, hero in pairs(self.heroDic) do
		if hero and hero.team > 0 and hero.team <= 6 then
			if not teamIdHeroListDic[hero.team] then
				teamIdHeroListDic[hero.team] = {}
			end

			table.insert(teamIdHeroListDic[hero.team], hero)
		end
	end

	local teamAllHero = {}

	for teamId, heroList in pairs(teamIdHeroListDic) do
		local counter = 0
		local alreadyExistId = {}

		for idx, hero in ipairs(heroList) do
			local curRelation = hero:getCurRelationPoint()
			local pointData = hero:getRelationPointData()

			if curRelation > 0 and pointData and pointData[1] and pointData[1].level >= 1 and not alreadyExistId[hero.id] then
				if not teamAllHero[teamId] then
					teamAllHero[teamId] = {}
				end

				table.insert(teamAllHero[teamId], hero)

				alreadyExistId[hero.id] = true
			end
		end
	end

	for teamId, heroList in pairs(teamAllHero) do
		table.sort(heroList, _sortForRealtionHint)

		local count = 0
		local canSweepHeroList = {}

		for _, hero in ipairs(heroList) do
			local pointData = hero:getRelationPointData()
			local curRelation = hero:getCurRelationPoint()

			if utils.checkRelationLvUpMaterialEnough(hero, curRelation) then
				self.realtionHeroListTop3[hero.id] = 1
				count = count + 1

				if count >= 3 then
					break
				end
			end

			local canFastSweep, needPower = self:getCanFastSweepRelationMaterials(hero, curRelation)

			if canFastSweep and needPower <= self.realPowerNum then
				canSweepHeroList[hero.id] = 1
			end
		end

		if count < 3 and next(canSweepHeroList) then
			for heroId, _ in pairs(canSweepHeroList) do
				self.realtionHeroListTop3[heroId] = 1
				count = count + 1

				if count >= 3 then
					break
				end
			end
		end
	end

	for heroId, value in pairs(self.realtionHeroListTop3) do
		if value and value == 1 then
			self.hintRelationSweepTeamDic[ResHero[heroId].belong_team] = 1
		end
	end

	local relationHint = utils.getTableElemCount(self.hintRelationSweepTeamDic) > 0 or utils.getTableElemCount(self.hintNewTeamIdDic) > 0

	RedDotManager.setKeyState(UIConst.RD_HINT_RELATION, relationHint)

	local heroShowRoomMainDlg = UIManager.getUI("heroShowRoomMainDlg", nil, false)

	if heroShowRoomMainDlg then
		heroShowRoomMainDlg:refreshHintShow()
	end

	local heroShowRoomListDlg = UIManager.getUI("heroShowRoomListDlg", nil, false)

	if heroShowRoomListDlg then
		heroShowRoomListDlg:refreshHintShow()
	end
end

function HeroMixin:checkRelationRegionPass()
	return RegionUtils.isCN() or RegionUtils.isTW() or RegionUtils.isJP() or RegionUtils.isKR() or RegionUtils.isSEA()
end

function HeroMixin:checkIsNewStageRelationHero(new_list)
	for i, svrData in ipairs(new_list) do
		if not self.handBookHeroDic or not self.handBookHeroDic[svrData.resid] then
			local hero = BaseObject.GetObject(svrData.resid)

			if hero:getRelationUnlockStage() > 0 then
				self.newRoomHeroIdDic[svrData.resid] = 1
			end
		end
	end

	self:checkRelationHeroNewHint()
end

function HeroMixin:clearRelationNewTeamHint(teamId)
	local teamHeros = self:getConfigTeamHeros(true)

	if teamHeros[teamId] then
		for _, heroId in ipairs(teamHeros[teamId]) do
			if self.newRoomHeroIdDic[heroId] then
				self.newRoomHeroIdDic[heroId] = nil
			end
		end

		self:checkRelationHeroNewHint()
	end
end

function HeroMixin:onHeroDevelopOpenNotify(team_status, stage_status)
	self:initRelationHintData(team_status, stage_status)
	self:checkRelationHeroNewHint()
end

function HeroMixin:onHeroDevelopUpdateRedPointResp(op_type, pos)
	if op_type == Const.RELATION_HINT_OPEN_TYPE_TEAM then
		self.relationTeamHintSvrData[pos] = 0

		self:clearRelationNewTeamHint(pos)
	end

	if op_type == Const.RELATION_HINT_OPEN_TYPE_STAGE and self.relationAutoOpenDlg and self.relationAutoOpenDlg == 1 then
		self.relationAutoOpenDlg = 0
	end
end

function HeroMixin:getRelationDataByHeroId(heroId)
	if self.heroRelationData and self.heroRelationData[heroId] then
		return self.heroRelationData[heroId]
	end
end

function HeroMixin:getPaintDataByHeroId(heroId)
	return self.heroPaintData[heroId]
end

function HeroMixin:getPaintPlusDataByHeroId(heroId)
	if self.heroPaintPlusData then
		return self.heroPaintPlusData[heroId]
	end
end

function HeroMixin:getPaintPlusShowLevelByHeroId(heroId, level)
	if heroId and level and ResHero[heroId] then
		local typeId = ResHero[heroId].new_paint_id

		if typeId and ResHeroNewPaint[typeId] then
			local resData = ResHeroNewPaint[typeId]

			if resData[level] and resData[level].paint_show_level then
				return resData[level].paint_show_level
			end
		end
	end

	return 0
end

function HeroMixin:getPaintNeedMaterialList(heroId, paintData)
	local materialList = {}

	if paintData.resData then
		for idx, itemId in ipairs(paintData.resData.paint_item_id) do
			table.insert(materialList, {
				id = itemId,
				num = paintData.resData.paint_item_num[idx]
			})
		end

		if ResHero[heroId] and ResHero[heroId].paint_item_id and paintData.resData.same_paint_item_num and paintData.resData.same_paint_item_num > 0 then
			table.insert(materialList, {
				id = ResHero[heroId].paint_item_id,
				num = paintData.resData.same_paint_item_num
			})
		end
	end

	return materialList
end

function HeroMixin:canShowPaintEntry(hero)
	local paintRecipeId = ResHero[hero.id].paint_id

	return hero.quality > 3 and hero.star >= ResHeroPaint[paintRecipeId][1].limit_star
end

function HeroMixin:haveHeroCanPaint()
	for _, hero in pairs(self.heroDic) do
		if self:canShowPaintEntry(hero) then
			return true
		end
	end

	return false
end

function HeroMixin:onHeroPaintNotify(res_id, paint_level, change_time)
	if paint_level > 0 then
		local paintRecipeId = ResHero[res_id].paint_id
		local oriCardShowId = 0
		local oriAbilityCount = 0

		if self.heroPaintData[res_id] then
			oriCardShowId = self.heroPaintData[res_id].resData.card_show_id or 0
			oriAbilityCount = self.heroPaintData[res_id].resData.ability_count or 0
		else
			self.heroPaintData[res_id] = {}
			self.heroPaintData[res_id].abilityList = {}
		end

		self.heroPaintData[res_id].level = paint_level
		self.heroPaintData[res_id].resData = ResHeroPaint[paintRecipeId][paint_level]
		self.heroPaintData[res_id].changeTick = change_time

		local curCardShowId = self.heroPaintData[res_id].resData.card_show_id or 0
		local curAbilityCount = self.heroPaintData[res_id].resData.ability_count or 0

		self:refreshHeroDetail()

		local heroPaintingDlg = UIManager.getUI("heroPaintingDlg", nil, false)

		if heroPaintingDlg then
			if oriAbilityCount == curAbilityCount then
				heroPaintingDlg:playPatingLvUp(curCardShowId ~= oriCardShowId)
			else
				heroPaintingDlg:playPatingLvUp(curCardShowId ~= oriCardShowId, curAbilityCount)
			end
		end

		if Const.PAINT_PLUS_OPEN then
			self:checkCanUnLockPaintPlusMainLevelHeros()
		end
	end
end

function HeroMixin:onHeroNewPaintNotify(res_id, paint_level)
	if paint_level > 0 then
		if not self.heroPaintPlusData[res_id] then
			self.heroPaintPlusData[res_id] = {}
		end

		if self.heroPaintPlusData[res_id] then
			self.heroPaintPlusData[res_id].level = paint_level

			local heroPaintingDlg = UIManager.tryGetUI("heroPaintingDlg")

			if heroPaintingDlg and heroPaintingDlg.coating02Panel and heroPaintingDlg.coating02Panel:getVisible() then
				heroPaintingDlg.coating02Panel:onUpPaintMainLevel()
			end
		end

		if paint_level == 1 then
			self:removeCanUnLockPaintPlusMainLevelHero(res_id)
		end

		self:checkCanUpPaintPlusRelateLevelHeros()

		local ui = UIManager.tryGetUI("heroMainDlg")

		if ui and ui:getVisible() and ui.heroContentPanel and ui.heroContentPanel:getVisible() then
			ui.heroContentPanel:refreshContentPanel()
		end
	end
end

function HeroMixin:onHeroPaintRelateUnlockNotify(res_id, relate_level)
	if relate_level > 0 then
		if self.heroPaintPlusData[res_id] then
			self.heroPaintPlusData[res_id].relateLevel = relate_level

			local heroPaintingDlg = UIManager.tryGetUI("heroPaintingDlg")

			if heroPaintingDlg and heroPaintingDlg.coating02Panel and heroPaintingDlg.coating02Panel:getVisible() then
				heroPaintingDlg.coating02Panel:onUpPaintRelateLevel()
			end
		end

		self:removeCanUpPaintPlusRelateLevelHero(res_id)

		local ui = UIManager.tryGetUI("heroMainDlg")

		if ui and ui:getVisible() and ui.heroContentPanel and ui.heroContentPanel:getVisible() then
			ui.heroContentPanel:refreshContentPanel()
		end
	end
end

function HeroMixin:removeCanUnLockPaintPlusMainLevelHero(heroId)
	if self.canUnLockPaintPlusMainPropDic and self.canUnLockPaintPlusMainPropDic[heroId] then
		self.canUnLockPaintPlusMainPropDic[heroId] = false

		for index, id in ipairs(self.canUnLockPaintPlusMainPropList or {}) do
			if id == heroId then
				table.remove(self.canUnLockPaintPlusMainPropList, index)

				break
			end
		end
	end

	RedDotManager.setKeyState(UIConst.RD_HINT_PAINT_PLUS_MAIN_LEVEL, #self.canUnLockPaintPlusMainPropList > 0)
end

function HeroMixin:removeCanUpPaintPlusRelateLevelHero(heroId)
	local hero

	for _, h in pairs(CurAvatar.heroDic) do
		if h.id == heroId then
			hero = h

			break
		end
	end

	if hero then
		local canUp = hero:canUpPaintPlusRelateLevel()

		if not canUp and self.canUpPaintPlusRelateLevelDic and self.canUpPaintPlusRelateLevelDic[hero.id] then
			self.canUpPaintPlusRelateLevelDic[hero.id] = false

			for index, id in ipairs(self.canUpPaintPlusRelateLevelList or {}) do
				if id == heroId then
					table.remove(self.canUpPaintPlusRelateLevelList, index)

					break
				end
			end
		end
	end

	RedDotManager.setKeyState(UIConst.RD_HINT_PAINT_PLUS_RELATE_LEVEL, #self.canUpPaintPlusRelateLevelList > 0)
end

function HeroMixin:checkCanUnLockPaintPlusMainLevelHeros()
	self.canUnLockPaintPlusMainPropDic = {}
	self.canUnLockPaintPlusMainPropList = {}

	if Const.PAINT_PLUS_OPEN then
		for _, hero in pairs(CurAvatar.heroDic) do
			local canUnLock = hero:checkCanUnlockedMainLevel()

			if canUnLock and not self.canUnLockPaintPlusMainPropDic[hero.id] then
				self.canUnLockPaintPlusMainPropDic[hero.id] = true

				table.insert(self.canUnLockPaintPlusMainPropList, hero.id)
			end
		end
	end

	RedDotManager.setKeyState(UIConst.RD_HINT_PAINT_PLUS_MAIN_LEVEL, #self.canUnLockPaintPlusMainPropList > 0)
end

function HeroMixin:checkCanUpPaintPlusRelateLevelHeros()
	self.canUpPaintPlusRelateLevelDic = {}
	self.canUpPaintPlusRelateLevelList = {}

	if Const.PAINT_PLUS_OPEN then
		for _, hero in pairs(CurAvatar.heroDic) do
			local canUp = hero:canUpPaintPlusRelateLevel()

			if canUp and not self.canUpPaintPlusRelateLevelDic[hero.id] then
				self.canUpPaintPlusRelateLevelDic[hero.id] = true

				table.insert(self.canUpPaintPlusRelateLevelList, hero.id)
			end
		end
	end

	RedDotManager.setKeyState(UIConst.RD_HINT_PAINT_PLUS_RELATE_LEVEL, #self.canUpPaintPlusRelateLevelList > 0)
end

function HeroMixin:checkSeasonRelicRedDot(...)
	self:checkCanUnLockSeasonRelicHeros()
	self:checkCanLvUpSeasonRelicHeros()
	self:checkFirstShowSeasonRelicHeros()
end

function HeroMixin:checkCanUnLockSeasonRelicHeros(...)
	self.canUnLockSeasonRelicHeroDic = {}
	self.canUnLockSeasonRelicHeroList = {}

	for _, hero in pairs(CurAvatar.heroDic or {}) do
		local canUnLock = hero:checkSeasonRelicCanUnLock()

		if canUnLock and not self.canUnLockSeasonRelicHeroDic[hero.id] then
			self.canUnLockSeasonRelicHeroDic[hero.id] = true

			table.insert(self.canUnLockSeasonRelicHeroList, hero.id)
		end
	end

	RedDotManager.setKeyState(UIConst.RD_HINT_HERO_SEASON_RELIC_UNLOCK, #self.canUnLockSeasonRelicHeroList > 0)
end

function HeroMixin:checkCanLvUpSeasonRelicHeros(...)
	self.canLvUpSeasonRelicHeroDic = {}
	self.canLvUpSeasonRelicHeroList = {}

	for _, hero in pairs(CurAvatar.heroDic or {}) do
		local canUp = hero:checkSeasonRelicCanLvUp()

		if canUp and not self.canLvUpSeasonRelicHeroDic[hero.id] then
			self.canLvUpSeasonRelicHeroDic[hero.id] = true

			table.insert(self.canLvUpSeasonRelicHeroList, hero.id)
		end
	end

	RedDotManager.setKeyState(UIConst.RD_HINT_HERO_SEASON_RELIC_UPLV, #self.canLvUpSeasonRelicHeroList > 0)
end

function HeroMixin:checkFirstShowSeasonRelicHeros(...)
	self.firstShowSeasonRelicHeroDic = {}
	self.firstShowSeasonRelicHeroList = {}

	local visMap = CurAvatar:getClientUserData("SeasonRelicFistShow") or {}

	for _, hero in pairs(CurAvatar.heroDic or {}) do
		if not visMap[hero.id] and hero:checkSeasonRelicOpen() and not hero:checkMyHeroUnlockSeasonRelic() then
			self.firstShowSeasonRelicHeroDic[hero.id] = true

			table.insert(self.firstShowSeasonRelicHeroList, hero.id)
		end
	end

	RedDotManager.setKeyState(UIConst.RD_HINT_HERO_SEASON_RELIC_FIRST_SHOW, #self.firstShowSeasonRelicHeroList > 0)
end

function HeroMixin:removeFirstShowSeasonRelicHero(heroId)
	if self.firstShowSeasonRelicHeroDic and self.firstShowSeasonRelicHeroDic[heroId] then
		self.firstShowSeasonRelicHeroDic[heroId] = false

		local visMap = CurAvatar:getClientUserData("SeasonRelicFistShow")

		visMap = visMap or {}
		visMap[heroId] = true

		CurAvatar:setClientUserData("SeasonRelicFistShow", visMap)

		for _, id in ipairs(self.firstShowSeasonRelicHeroList or {}) do
			if id == heroId then
				table.remove(self.firstShowSeasonRelicHeroList, _)

				break
			end
		end
	end

	RedDotManager.setKeyState(UIConst.RD_HINT_HERO_SEASON_RELIC_FIRST_SHOW, #self.firstShowSeasonRelicHeroList > 0)
end

function HeroMixin:getHeroPaintPlusProficientAddLevelListById(heroId)
	if not heroId then
		return
	end

	local typeId = ResHero[heroId].new_paint_id

	if not typeId then
		return
	end

	if not ResHeroNewPaint[typeId] then
		return
	end

	local list = {}

	for _, data in ipairs(ResHeroNewPaint[typeId]) do
		if data.proficient_add and data.proficient_add == 1 then
			table.insert(list, data.paint_show_level)
		end
	end

	return list
end

function HeroMixin:onHeroDevelopResp(res_id, relation_point, level)
	if self.heroRelationData[res_id] and self.heroRelationData[res_id].pointDevData and self.heroRelationData[res_id].pointDevData[relation_point] then
		self.heroRelationData[res_id].pointDevData[relation_point].level = level
	else
		self.heroRelationData[res_id] = {}
		self.heroRelationData[res_id].pointDevData = {}

		for relationPoint = 1, 6 do
			self.heroRelationData[res_id].pointDevData[relationPoint] = {}

			local newLevel = relationPoint == relation_point and level or 0

			self.heroRelationData[res_id].pointDevData[relationPoint].level = newLevel
		end
	end

	self:checkRelationHeroNewHint()

	local heroShowRoomGrowUpDlg = UIManager.getUI("heroShowRoomGrowUpDlg", nil, false)

	if heroShowRoomGrowUpDlg then
		heroShowRoomGrowUpDlg:refreshDetailInfo()
		heroShowRoomGrowUpDlg:playUpgradeEffect(relation_point, level)
	end

	local heroShowRoomListDlg = UIManager.getUI("heroShowRoomListDlg", nil, false)

	if heroShowRoomListDlg then
		heroShowRoomListDlg:refreshForHeroInfo()
	end

	if relation_point == 7 then
		RPC.roleCommGet({
			CurAvatar.uid
		}, Const.ROLECOMM_GET_TPYE.SIMPLE_POWER)
		UserData.saveCommonDataInt(CurAvatar.uid .. "new_vow_sign", 1)
		RedDotManager.setKeyState(UIConst.RD_HINT_SIGN, true)
	end
end

function HeroMixin:onHeroPaintAbilityNotify(res_id, ability, change_time)
	self.heroPaintData[res_id].changeTick = change_time
	self.heroPaintData[res_id].abilityList = {}

	for _, idx in ipairs(ability) do
		table.insert(self.heroPaintData[res_id].abilityList, ResAbilityStore[res_id].ability_store[idx])
	end

	local heroPaintingDlg = UIManager.getUI("heroPaintingDlg", nil, false)

	if heroPaintingDlg then
		heroPaintingDlg:refreshPaintUI()
	end

	self:refreshHeroDetail()
end

function HeroMixin:getPaintLimitLv(paintData)
	return 99
end

function HeroMixin:getPaintStarContainerInfo(paintData)
	local containerCount = 0
	local levelIdx = 0

	for idx, paintRes in ipairs(ResHeroPaint[paintData.resData.paint_id]) do
		if paintRes.card_show_id == paintData.resData.card_show_id then
			containerCount = containerCount + 1

			if paintRes.paint_level == paintData.resData.paint_level then
				levelIdx = containerCount - 1
			end
		end
	end

	if paintData.resData.card_show_id == 0 then
		containerCount = containerCount + 1
		levelIdx = levelIdx + 1
	end

	return containerCount, levelIdx
end

function HeroMixin:canPaintIgnoreProficientLv(hero)
	local paintLvEnoughIdDic = {}

	for gid, _hero in pairs(self.heroDic) do
		if hero.team == _hero.team and _hero:getPaintData() and hero:getPaintData() and _hero:getPaintData().level >= hero:getPaintData().level then
			paintLvEnoughIdDic[_hero.id] = 1
		end
	end

	for id, heroRes in pairs(ResHero) do
		if ClientUtils.isTimeConfigPassed(heroRes.valid_time_id) and not paintLvEnoughIdDic[heroRes.id] and heroRes.quality > 3 and hero.team == heroRes.belong_team then
			return false
		end
	end

	return true
end

function HeroMixin:initHeroTeamInfo()
	for k, v in pairs(self.heroDic) do
		self.heroDic[k]:initTeamInfo()
	end

	self:checkCanStepUpInTeamHeros()
	self:checkCanEquipInTeamHeros()
	self:checkCanStarUpInTeamHeros()
	self:checkHaveNewFiveHero()
end

function HeroMixin:initHeroCrystalInfo()
	for k, v in pairs(self.heroDic) do
		self.heroDic[k]:initCrystalData()
	end

	self:checkCanStepUpInTeamHeros()
	self:checkCanEquipInTeamHeros()
	self:checkCanStarUpInTeamHeros()
	self:checkAllStepTowerCanBattle()
end

function HeroMixin:initHeroLoginInfo()
	for k, v in pairs(self.heroDic) do
		self.heroDic[k]:initTeamInfo()
		self.heroDic[k]:initCrystalData()
	end

	self:checkCanStepUpInTeamHeros()
	self:checkHaveNewFiveHero()
	self:checkCanStarUpInTeamHeros()
	self:checkCanHintSellHeros()
	self:checkCanEquipInTeamHeros()

	if Const.PAINT_PLUS_OPEN then
		self:checkCanUnLockPaintPlusMainLevelHeros()
		self:checkCanUpPaintPlusRelateLevelHeros()
	end

	self:checkSeasonRelicRedDot()
end

function HeroMixin:getInTeamHeros(formationIndex, cantOnlyFormation)
	local heros = {}

	for _, hero in pairs(self.heroDic) do
		if hero.inTeam == 1 and (formationIndex == nil or hero.formationIndex == formationIndex) then
			if cantOnlyFormation and hero.formationIndex == cantOnlyFormation then
				for idx, gidIdxDic in pairs(self.formation) do
					if idx ~= cantOnlyFormation and gidIdxDic[hero.gid] then
						heros[hero.gid] = hero
					end
				end

				if CurAvatar and (formationIndex or CurAvatar.asyncPVPDefendFormation[self.gid]) then
					heros[hero.gid] = hero
				end
			else
				heros[hero.gid] = hero
			end
		end
	end

	return heros
end

function HeroMixin:getCrystalPriestsHeros(isIncludeSlot, needInTeam, cantOnlyFormation)
	local heros = {}
	local inTeamHeros = {}

	if needInTeam then
		inTeamHeros = self:getInTeamHeros(nil, cantOnlyFormation)
	end

	if self.crystalPriestsDic then
		for gid, _ in pairs(self.crystalPriestsDic) do
			local hero = self.heroDic[gid]

			if hero and (not needInTeam or inTeamHeros[gid]) then
				heros[hero.gid] = hero
			end
		end
	end

	if isIncludeSlot and self.crystalSlotDic then
		for gid, _ in pairs(self.crystalSlotDic) do
			local hero = self.heroDic[gid]

			if hero and (not needInTeam or inTeamHeros[gid]) then
				heros[hero.gid] = hero
			end
		end
	end

	return heros
end

function HeroMixin:saveHeroSortConfig(sortInfo)
	self.heroCardSortConfig = sortInfo

	UserData.saveCommonData("HeroSort", ClientUtils.table2String(sortInfo))
end

function HeroMixin:getHeroCountByResId(resId)
	local count = 0

	for _, hero in pairs(self.heroDic) do
		if hero.id == resId then
			count = count + 1
		end
	end

	return count
end

function HeroMixin:getHeroSpeciesCount()
	local species = 0
	local map = {}

	for _, hero in pairs(self.heroDic) do
		if not map[hero.id] then
			map[hero.id] = true
			species = species + 1
		end
	end

	return species
end

function HeroMixin:getHeroCount()
	local count = 0

	for k, v in pairs(self.heroDic) do
		count = count + 1
	end

	return count
end

function HeroMixin:getHeroCampCount(camp, includeSPecialHero)
	local count = 0

	for _, hero in pairs(self.heroDic) do
		if not camp or hero.camp == camp then
			count = count + 1
		elseif includeSPecialHero and hero.specialCamp == camp then
			count = count + 1
		end
	end

	return count
end

function HeroMixin:getHeroQuickLvTarget(hero, isSecond)
	local maxStarLv = hero:getMaxStarLv()
	local maxPriestsLv = self:getCrystalPriestsMaxLv(hero.realLevel)
	local tarMaxLv = math.min(maxPriestsLv, maxStarLv)
	local maxStep = hero:getMaxStep()

	for step = maxStep, 1, -1 do
		if ResStep[step] then
			local limitLv = ResStep[step].level_limit

			if tarMaxLv >= limitLv - 1 then
				if not isSecond then
					do
						local lvStep = math.max(step - 1, 1)

						tarMaxLv = ResStep[lvStep].level_limit - 1
					end

					break
				end

				tarMaxLv = limitLv - 1

				break
			end
		end
	end

	if tarMaxLv - hero.realLevel < ResHeroMisc[1].quick_lv_diff and not isSecond then
		return hero.realLevel
	end

	local materialIdNums = {}
	local haveNumDic = {}
	local targetLv = tarMaxLv

	for level = hero.realLevel, tarMaxLv - 1 do
		local isBreak = false
		local levelCost = ResLevelCost[hero.quality][level]

		for idx, id in ipairs(levelCost.res_id) do
			if not materialIdNums[id] then
				materialIdNums[id] = levelCost.res_num[idx]
			else
				materialIdNums[id] = materialIdNums[id] + levelCost.res_num[idx]
			end

			if not haveNumDic[id] then
				haveNumDic[id] = self:getItemNumById(id)
			end

			if haveNumDic[id] < materialIdNums[id] then
				targetLv = level
				isBreak = true

				break
			end
		end

		if isBreak then
			break
		end

		if not materialIdNums[Const.MONEY_ID_GOLD] then
			materialIdNums[Const.MONEY_ID_GOLD] = levelCost.gold
		else
			materialIdNums[Const.MONEY_ID_GOLD] = materialIdNums[Const.MONEY_ID_GOLD] + levelCost.gold
		end

		if self:getMoneyByType(Const.MONEY_TYPE_GOLD) < materialIdNums[Const.MONEY_ID_GOLD] then
			targetLv = level

			break
		end
	end

	for step = maxStep, 1, -1 do
		local limitLv = ResStep[step].level_limit

		if targetLv >= limitLv - 1 then
			targetLv = limitLv - 1

			break
		end
	end

	if targetLv - hero.realLevel < ResHeroMisc[1].quick_lv_diff and not isSecond then
		return hero.realLevel
	end

	return targetLv
end

function HeroMixin:addNewHero(heroList, getType, noRefreshUI)
	local heros = {}

	for _, svrData in ipairs(heroList) do
		if ResHero[svrData.resid] then
			local tempHero = Hero(svrData)

			tempHero:setCrystalStoryData(self.crystalNewLevel, self.heroStoryStateDic[tempHero.id])

			self.heroDic[tempHero.gid] = tempHero
			self.handBookHeroDic[tempHero.id] = 1

			if getType and Const.NEED_NOTICE_HERO_GET_TYPE[getType] then
				MsgManager.notice(string.format(Lang.get(1858), tempHero.name))
			end

			if getType and Const.NEED_CACHE_HERO_FOR_DLG[getType] then
				if not self.cacheShowHeros then
					self.cacheShowHeros = {}
				end

				self.cacheShowHeros[getType] = tempHero
			end

			table.insert(heros, tempHero)
		end
	end

	if getType and Const.NEED_DLG_HERO_GET_TYPE[getType] and #heros > 0 then
		if #heros <= 1 then
			self:showLimitStarHeroForGetNewDlg(heros, 3)
		else
			UIManager.getUI("commonHeroBonusDlg", true):onShow(heros)
		end
	end

	if getType and (getType == Const.HERO_GET_TYPE_FRAG_COMPOUND or getType == Const.HERO_GET_TYPE_RAND_FRAG_COMPOUND) and #heros > 0 then
		if #heros <= 1 then
			self:showLimitStarHeroForGetNewDlg(heros, 5)
		end

		UIManager.getUI("commonHeroBonusDlg", true):onShow(heros)
	end

	if #heros > 0 then
		for _, hero in ipairs(heros) do
			if hero.star >= 5 then
				table.insert(self.fiveUpStarHeroGidList, hero.gid)
			end
		end
	end

	if not noRefreshUI then
		self:checkHaveNewFiveHero()
	end

	self:resetOpenBoxDlg()
	self:checkCanStarUpInTeamHeros()
	self:checkCanHintSellHeros()

	local heroMainDlg = UIManager.getUI("heroMainDlg", nil, false)

	if not noRefreshUI and heroMainDlg then
		heroMainDlg:regularUpdateHeroCardList(heroMainDlg.selectedHero.gid)
	end
end

function HeroMixin:showLimitStarHeroForGetNewDlg(heros, starLimit, fromDraw)
	starLimit = starLimit or 0

	local heroListDic = {}
	local slimNightId = 0

	for _, hero in ipairs(heros) do
		if starLimit <= hero.star then
			if hero:isLightOrDark() and hero.resData.ori_star > 4 then
				slimNightId = hero.id

				if not heroListDic[hero.id] then
					heroListDic[hero.id] = {}
				end

				table.insert(heroListDic[hero.id], hero)
			else
				if not heroListDic[0] then
					heroListDic[0] = {}
				end

				table.insert(heroListDic[0], hero)
			end
		end
	end

	if slimNightId == 0 then
		if heroListDic[0] and #heroListDic[0] > 0 then
			local getNewHeroDlg = UIManager.getUI("getNewHeroDlg", true)

			getNewHeroDlg:setHeroList(heroListDic[0])
		end
	else
		local uiName = "getLightBlackHeroDlg_" .. slimNightId
		local getLightBlackHeroDlg = UIManager.getUI(uiName, true)

		getLightBlackHeroDlg:setHeroListDic(heroListDic, slimNightId, fromDraw)
	end
end

function HeroMixin:removeHero(heroGid, type)
	if self.cacheDelHeros and not self.cacheDelHeros[type] then
		self.cacheDelHeros[type] = {}
	end

	local realHero = self.heroDic[heroGid]
	local cacheFakeHero = BaseObject.CopyObject(realHero)

	cacheFakeHero:setEquips(realHero:getEquips(), realHero:getArtifact(), realHero:getRelic())
	table.insert(self.cacheDelHeros[type], cacheFakeHero)
	self:offAllEquip(self.heroDic[heroGid])

	self.heroDic[heroGid] = nil
end

function HeroMixin:getBestHeroByRid(rid, value)
	if not self.handBookHeroDic[rid] then
		return nil
	end

	local gid
	local tempValue = 0

	for idx, tempHero in pairs(self.heroDic) do
		if tempHero.id == rid and tempHero[value] and tempValue < tempHero[value] then
			tempValue = tempHero[value]
			gid = tempHero.gid
		end
	end

	if gid ~= nil then
		return self.heroDic[gid]
	end
end

function HeroMixin:onHeroGetNotify(new_list, type)
	self:checkNewHead(new_list)
	self:checkIsNewStageRelationHero(new_list)
	self:addNewHero(new_list, type)
	self:checkPvpFormationRedHint()
	self:checkSeniorPvpFormationRedHint()
	self:checkOpactPvpFormationRedHind()
	self:checkRentFormationRedHind()
	self:checkRelationHeroNewHint()
	self:checkPutHero()
	self:revertHeroStarUpDlg()
end

function HeroMixin:onHeroDelNotify(gid_list, type)
	for _, gid in ipairs(gid_list) do
		self:removeHero(gid, type)
	end

	self:checkCanStarUpInTeamHeros()
	self:checkCanHintSellHeros()

	local heroMainDlg = UIManager.getUI("heroMainDlg", nil, false)

	if heroMainDlg then
		heroMainDlg:clearCardFilter()

		local selectExist = heroMainDlg.selectedHero and self.heroDic[heroMainDlg.selectedHero.gid]

		if selectExist then
			heroMainDlg:regularUpdateHeroCardList(heroMainDlg.selectedHero.gid)
		else
			heroMainDlg:regularUpdateHeroCardList(nil, 1)
		end
	end

	self:checkCanEquipInTeamHeros(true)
	self:checkPvpFormationRedHint()
	self:checkSeniorPvpFormationRedHint()
	self:checkOpactPvpFormationRedHind()
	self:checkRentFormationRedHind()
	self:checkPutHero()
	self:refreshRearHouseHero(gid_list)
	self:refreshMyRoleInfoHeros(gid_list)
end

function HeroMixin:onHeroLevelUpNotify(hero_gid, level)
	local lvDiff = level - self.heroDic[hero_gid].realLevel

	self.heroDic[hero_gid]._serverData.level = level

	self.heroDic[hero_gid]:initCrystalData()
	self.heroDic[hero_gid]:refreshSkillInfo()

	local hero = self.heroDic[hero_gid]
	local levelCostInfo = ResLevelCost[hero.quality][hero.level - 1]
	local needMaterial2 = levelCostInfo ~= nil and levelCostInfo.res_id[2] ~= nil
	local isSuperLvUp = lvDiff > 1 or needMaterial2

	if lvDiff > 1 then
		CueManager.playHeroVocal(hero.id, Const.HERO_VOCAL_QUICK_UPGRADE)
	elseif needMaterial2 then
		CueManager.playHeroVocal(hero.id, Const.HERO_VOCAL_UPGRADE)
	end

	local lvUpAudioPath = isSuperLvUp and "Audios/SFX/UI/ui_hero_uparde_fast.ogg" or "Audios/SFX/UI/ui_hero_uparde.ogg"

	CueManager.playUiSfx(lvUpAudioPath)
	self:checkCanStepUpInTeamHeros()
	self:checkHaveNewFiveHero()
	self:checkAllStepTowerCanBattle()

	local heroMainDlg = UIManager.getUI("heroMainDlg", nil, false)

	if heroMainDlg then
		local basePanel = heroMainDlg.heroContentPanel.panelList[Const.HERO_CONTENT_PANEL.BASE_INFO]

		if basePanel and basePanel:getVisible() then
			local effectAttrList = {}

			basePanel:playUpgradeEfx(effectAttrList, isSuperLvUp)

			if lvDiff > 1 and basePanel.hero.gid == hero_gid then
				basePanel.isSecondLvTarget = true
			end
		end
	end

	self:refreshHeroDetail(hero_gid)

	local dragDlg = UIManager.getUI("battleDragHeroDlg", nil, false)

	if dragDlg then
		dragDlg:updateHeroInfo()
	end

	UIManager.tryHideUI("heroUpgradeDlg")
	UIManager.tryHideUI("heroUpgradeFastDlg")
end

function HeroMixin:onHeroStepUpNotify(hero_gid, step)
	self.heroDic[hero_gid].step = step
	self.heroDic[hero_gid]._serverData.step = step

	self.heroDic[hero_gid]:initStep()
	CueManager.playHeroVocal(self.heroDic[hero_gid].id, Const.HERO_VOCAL_SKILLUP)
	self:checkCanStepUpInTeamHeros()
	self:checkDispatchRedHint()

	self.heroDic[hero_gid].recharge = step

	local heroMainDlg = UIManager.getUI("heroMainDlg", nil, false)

	if heroMainDlg then
		heroMainDlg:refreshDetailForHero(hero_gid, true)

		local stepUpPanel = heroMainDlg.heroContentPanel.panelList[Const.HERO_CONTENT_PANEL.STAGE_UP]

		if stepUpPanel and stepUpPanel:getVisible() then
			if not stepUpPanel.showSkill then
				stepUpPanel:onBtnSkillClick()
				heroMainDlg.heroContentPanel:delayPlaySkillUpEfx(self.heroDic[hero_gid].recharge)
			else
				heroMainDlg.heroContentPanel:playSkillUpEfx(self.heroDic[hero_gid].recharge)
			end
		end
	end

	BeginnerManager.HeroStepUp(self.heroDic[hero_gid])
end

function HeroMixin:onHeroStarUpNotify(hero_gid, star)
	self.heroDic[hero_gid].star = star
	self.heroDic[hero_gid]._serverData.star = star

	self:checkCanStarUpInTeamHeros()
	self:checkCrystalUpHint()
	self:checkBagRedHintOpen()

	local heroStarUpInfoDlg = UIManager.getUI("heroStarUpInfoDlg", nil, false)

	if heroStarUpInfoDlg then
		heroStarUpInfoDlg:setVisible(false)

		local heroStarUpAnimationDlg = UIManager.getUI("heroStarUpAnimationDlg", true)

		if heroStarUpAnimationDlg then
			heroStarUpAnimationDlg:setHero(self.heroDic[hero_gid], true)
		end
	end

	local heroMainDlg = UIManager.getUI("heroMainDlg", nil, false)

	if heroMainDlg then
		heroMainDlg:regularUpdateHeroCardList(heroMainDlg.selectedHero.gid)
	end
end

function HeroMixin:onHeroVoidStarChangeNotify(hero_gid, new_star)
	local hero = self.heroDic[hero_gid]

	if hero then
		local preStar = hero.star

		hero.star = new_star
		hero._serverData.star = new_star

		self:onHeroStarChanged(hero.id, preStar, new_star)

		local heroMainDlg = UIManager.getUI("heroMainDlg", nil, false)

		if heroMainDlg then
			heroMainDlg:regularUpdateHeroCardList(hero_gid)
		end
	end
end

function HeroMixin:onHeroStarChanged(heroId, preStar, nowStar)
	if Const.UNIQUE_HERO[heroId] and preStar ~= nowStar then
		local drawCardMainDlg = UIManager.tryGetUI("drawCardMainDlg")

		if drawCardMainDlg and drawCardMainDlg:isInShow() or UIManager.tryGetUI("drawCardOperateDlg") or UIManager.tryGetUI("drawCardOptLightDlg") then
			self.cachedVoidHeroChanged = {
				heroId,
				preStar,
				nowStar
			}
		else
			UIManager.onGetBonusNotice("relatedHeroStarChangeDlg", "showHero", {
				heroId,
				preStar,
				nowStar
			})
		end
	end
end

function HeroMixin:checkVoidHeroStarChanged()
	if self.cachedVoidHeroChanged then
		UIManager.onGetBonusNotice("relatedHeroStarChangeDlg", "showHero", self.cachedVoidHeroChanged)

		self.cachedVoidHeroChanged = nil
	end
end

function HeroMixin:onHeroStarUpBatchResp(data)
	local heroList = {}
	local cacheAniHero

	for _, info in ipairs(data) do
		local hero_gid = info.gid
		local star = info.star

		self.heroDic[hero_gid].star = star
		self.heroDic[hero_gid]._serverData.star = star

		if #data <= 1 then
			cacheAniHero = self.heroDic[hero_gid]
		elseif self.cacheFastStarUpHero and hero_gid == self.cacheFastStarUpHero.gid then
			cacheAniHero = self.heroDic[hero_gid]
		elseif cacheAniHero == nil then
			cacheAniHero = self.heroDic[hero_gid]
		end

		table.insert(heroList, self.heroDic[hero_gid])
	end

	self:onSkinCheckNew()
	self:checkCanStarUpInTeamHeros()
	self:checkRelationHeroNewHint()
	self:checkCrystalUpHint()
	self:checkBagRedHintOpen()

	local heroStarUpDlg = UIManager.getUI("heroStarUpDlg", nil, false)

	if heroStarUpDlg then
		heroStarUpDlg:showUIPanel(false)
	end

	if not self.cacheFastStarUpHero then
		UIManager.tryHideUI("heroStarUpInfoDlg")

		local heroStarUpAnimationDlg = UIManager.getUI("heroStarUpAnimationDlg", true)

		if heroStarUpAnimationDlg then
			heroStarUpAnimationDlg:setHero(cacheAniHero, true)
		end
	elseif cacheAniHero then
		UIManager.tryHideUI("heroStarUpFastDlg")
		self:revertHeroStarUpDlg()
		UIManager.getUI("commonHeroBonusDlg", true):onShow(heroList)

		self.cacheFastStarUpHero = nil

		local heroStarUpAnimationDlg = UIManager.getUI("heroStarUpAnimationDlg", true)

		if heroStarUpAnimationDlg then
			heroStarUpAnimationDlg:setHero(cacheAniHero)
		end
	end

	local heroMainDlg = UIManager.getUI("heroMainDlg", nil, false)

	if heroMainDlg then
		heroMainDlg:regularUpdateHeroCardList(heroMainDlg.selectedHero.gid)
	end
end

local function sortEatsMaterial(a, b)
	if a.id == Const.MONEY_ID_GOLD or b.id == Const.MONEY_ID_GOLD then
		return a.id == Const.MONEY_ID_GOLD
	elseif a.id == Const.MONEY_ID_HERO_EXP or b.id == Const.MONEY_ID_HERO_EXP then
		return a.id == Const.MONEY_ID_HERO_EXP
	elseif ResItem[a.id].quality ~= ResItem[b.id].quality then
		return ResItem[a.id].quality > ResItem[b.id].quality
	else
		return a.id < b.id
	end
end

function HeroMixin:setMaterialHerosEated(eatedHeros)
	local materialIdNums = {}

	for _, hero in ipairs(eatedHeros) do
		local heroMaterialIdNums = utils.getHeroLevelStepCost(hero, Const.HERO_RESET_ALL)

		for id, num in pairs(heroMaterialIdNums) do
			if materialIdNums[id] then
				materialIdNums[id] = materialIdNums[id] + num
			else
				materialIdNums[id] = num
			end
		end
	end

	self.cacheEatsMaterialHeros = {}

	for id, num in pairs(materialIdNums) do
		table.insert(self.cacheEatsMaterialHeros, {
			id = id,
			num = num
		})
	end

	table.sort(self.cacheEatsMaterialHeros, sortEatsMaterial)
end

function HeroMixin:showHeroSellReward()
	if self.cacheEatsMaterialHeros and #self.cacheEatsMaterialHeros > 0 then
		local heroSellRewardDlg = UIManager.getUI("heroSellRewardDlg", true)

		heroSellRewardDlg:setEatedMaterialsData(self.cacheEatsMaterialHeros)
	end

	self.cacheEatsMaterialHeros = {}
end

function HeroMixin:revertHeroStarUpDlg()
	local heroStarUpDlg = UIManager.getUI("heroStarUpDlg", nil, false)

	if heroStarUpDlg then
		heroStarUpDlg:showUIPanel(true)
		heroStarUpDlg.exchangePanel:clearHero()
		heroStarUpDlg:refreshHeroList(true)
	end
end

function HeroMixin:HasUniqueHero()
	for _, hero in pairs(self.heroDic) do
		if hero:isUniqueHero() then
			return true
		end
	end
end

function HeroMixin:onHeroRecycleResp()
	local recycleHeroData = CurAvatar.cacheDelHeros[Const.HERO_DEL_TYPE_RECYCLE]
	local wearedList = {}

	for _, hero in ipairs(recycleHeroData) do
		local equipedList = hero:getEquipedList()

		for _, equipedItem in ipairs(equipedList) do
			table.insert(wearedList, equipedItem)
		end
	end

	if #wearedList > 0 then
		MsgManager.clientNotice(179)
	end

	if self.recycleMaterials and #self.recycleMaterials > 0 then
		local heroSellRewardDlg = UIManager.getUI("heroSellRewardDlg", true)

		heroSellRewardDlg:refreshData()
	end

	self:refreshHeroBagSize()

	local heroSellDlg = UIManager.getUI("heroSellDlg", nil, false)

	if heroSellDlg then
		heroSellDlg:refreshData()
	end
end

function HeroMixin:_receiveRecycleHeroData(attrs, items)
	self.recycleMaterials = {}

	for _, attrs in ipairs(attrs) do
		local idNum = {}

		idNum.id = Const.MONEY_TYPE2ID[attrs.type]
		idNum.num = attrs.value

		table.insert(self.recycleMaterials, idNum)
	end

	for _, item in ipairs(items) do
		table.insert(self.recycleMaterials, item)
	end
end

function HeroMixin:onHeroResetResp(hero_gid, item)
	self:resetHeroByGid(hero_gid, Const.HERO_RESET_ALL)
end

function HeroMixin:onHeroLevelResetResp(hero_gid)
	self:resetHeroByGid(hero_gid, Const.HERO_RESET_LEVEL)
end

function HeroMixin:onHeroStepResetResp(hero_gid, next_tick, pos)
	self.nextStepResetTick[pos + 1] = next_tick

	self:resetHeroByGid(hero_gid, Const.HERO_RESET_STEP)
end

function HeroMixin:onHeroResetNotify(next_tick, pos)
	self.nextStepResetTick[pos + 1] = next_tick
end

function HeroMixin:onHeroExchangeResp(source_hero, target_hero, is_sympathizer)
	local updateHeroList = {
		source_hero,
		target_hero
	}

	for _, heroSvrData in ipairs(updateHeroList) do
		if self.heroDic[heroSvrData.gid] then
			self:offAllEquip(self.heroDic[heroSvrData.gid])
		end
	end

	for _, heroSvrData in ipairs(updateHeroList) do
		self:updateHeroData(heroSvrData)
	end

	self:checkCanEquipInTeamHeros()
	self:checkCanStepUpInTeamHeros()

	local heroMainDlg = UIManager.getUI("heroMainDlg", nil, false)

	if heroMainDlg then
		heroMainDlg:regularUpdateHeroCardList(target_hero.gid)
	end

	self:refreshHeroRecGrowDlg()
	UIManager.tryHideUI("heroGrowBecomeLeaderDlg")
	UIManager.tryHideUI("heroBecomeLeaderDlg")
	MsgManager.clientNotice(313)
end

function HeroMixin:refreshHeroRecGrowDlg()
	local heroGrowRecommendDlg = UIManager.getUI("heroGrowRecommendDlg", nil, false)

	if heroGrowRecommendDlg then
		heroGrowRecommendDlg:refreshRecommendData()
	end
end

function HeroMixin:updateHeroData(heroSvrData)
	local hero = Hero(heroSvrData)

	hero:setCrystalStoryData(self.crystalNewLevel, self.heroStoryStateDic[hero.id])

	local equips = hero:getEquips()

	if equips then
		for _, equip in pairs(equips) do
			equip.inWearing = hero.gid
		end
	end

	local artifact = hero:getArtifact()

	if artifact then
		artifact.inWearing = hero.gid
	end

	local relic = hero:getRelic()

	if relic then
		relic.inWearing = hero.gid
	end

	if self.heroDic[heroSvrData.gid].mazeHp then
		hero:setMazeAttr(self.heroDic[heroSvrData.gid].mazeHp)
	end

	self.heroDic[heroSvrData.gid] = hero

	self.heroDic[heroSvrData.gid]:initTeamInfo()
	self.heroDic[heroSvrData.gid]:initCrystalData()
end

function HeroMixin:onHeroStarBackResp(heroSvrData, op_tick)
	self.freeStarRevertTick = op_tick

	local hero_gid = heroSvrData.gid

	if self.heroDic[hero_gid] then
		local resetStep = heroSvrData.step ~= self.heroDic[hero_gid].step
		local revertItems = CurAvatar:getStarRevertMaterial(self.heroDic[hero_gid], resetStep, true)

		if #revertItems > 0 then
			local equipedList = self.heroDic[hero_gid]:getEquipedList()

			for _, equipedItem in ipairs(equipedList) do
				local fakeEquipedItem = BaseObject.CopyObject(equipedItem)

				fakeEquipedItem.inWearing = nil

				table.insert(revertItems, fakeEquipedItem)
			end
		end

		self:offAllEquip(self.heroDic[hero_gid])

		self.heroDic[hero_gid] = utils.getRevertedHero(self.heroDic[hero_gid], resetStep)

		self.heroDic[hero_gid]:initTeamInfo()
		self.heroDic[hero_gid]:initCrystalData()
		self:checkCanEquipInTeamHeros()
		self:checkCanStepUpInTeamHeros()
		self:checkHaveNewFiveHero()
		self:checkPvpFormationRedHint()
		self:refreshHeroDetail(hero_gid)
		self:revertHeroStarUpDlg()

		local heroDataList = CurAvatar:getCanRevertStarHeroList()

		if #heroDataList > 0 then
			local heroStarUpRevertDlg = UIManager.getUI("heroStarUpRevertDlg", nil, false)

			if heroStarUpRevertDlg then
				heroStarUpRevertDlg:refreshHeroList(heroDataList)
			end
		else
			UIManager.tryHideUI("heroStarUpRevertDlg")
		end

		if #revertItems > 0 then
			local heroSellRewardDlg = UIManager.getUI("heroSellRewardDlg", true)

			heroSellRewardDlg:setEatedMaterialsItem(revertItems)
		end
	end
end

function HeroMixin:resetHeroByGid(hero_gid, resetType)
	MsgManager.clientNotice(152)
	self:offAllEquip(self.heroDic[hero_gid])

	self.heroDic[hero_gid] = utils.getResetedHero(self.heroDic[hero_gid], resetType)

	self.heroDic[hero_gid]:initTeamInfo()
	self.heroDic[hero_gid]:initCrystalData()
	self:checkCanEquipInTeamHeros()
	self:checkCanStepUpInTeamHeros()
	self:checkHaveNewFiveHero()

	if resetType ~= Const.HERO_RESET_STEP then
		local heroMainDlg = UIManager.getUI("heroMainDlg", nil, false)

		if heroMainDlg then
			local basePanel = heroMainDlg.heroContentPanel.panelList[Const.HERO_CONTENT_PANEL.BASE_INFO]

			if basePanel and basePanel:getVisible() and basePanel.hero.gid == hero_gid then
				basePanel.isSecondLvTarget = false
			end
		end
	end

	if resetType == Const.HERO_RESET_LEVEL then
		RearHouseModelCenter:refreshHeroData(hero_gid)
	end

	self:refreshHeroDetail(hero_gid)
	self:refreshItemBag()
	self:checkPvpFormationRedHint()
	UIManager.tryHideUI("heroResetDlg")
	UIManager.tryHideUI("heroResetOrderDlg")
end

function HeroMixin:refreshHeroBagSize()
	local heroMainDlg = UIManager.getUI("heroMainDlg", nil, false)

	if heroMainDlg then
		heroMainDlg.heroListFunPanel:refreshBagBlankNum()
	end
end

function HeroMixin:getHeroMaxStarLv(hero)
	if hero then
		return ResStar[hero.resData.star_prop_id][hero.star].max_level
	end
end

function HeroMixin:getMaxStartLvHeroByHeroId(heroId)
	if not heroId then
		return
	end

	local maxStarLv = 0
	local heroGid

	for gid, hero in pairs(self.heroDic) do
		if hero.id == heroId and maxStarLv < hero.star then
			maxStarLv = hero.star
			heroGid = gid
		end
	end

	if heroGid and self.heroDic[heroGid] then
		return self.heroDic[heroGid]
	end
end

function HeroMixin:getHeroEquips(hero_gid)
	if self.heroDic[hero_gid] then
		return self.heroDic[hero_gid]:getEquips()
	end
end

function HeroMixin:refreshHeroDetail(gidRefreshFor)
	local heroMainDlg = UIManager.getUI("heroMainDlg", nil, false)

	if heroMainDlg then
		heroMainDlg:refreshDetailForHero(gidRefreshFor or heroMainDlg.selectedHero.gid)
	end
end

function HeroMixin:isHeroCanStarUp(hero)
	local needLevel = ResStarUpCondition[hero.star].level
	local needStep = ResStarUpCondition[hero.star].step

	return needLevel <= hero.level and needStep <= hero.step
end

function HeroMixin:getHeroPropRank(attrName, value)
	local rank = 1

	for _, rankInfo in ipairs(ResHeroPropRank) do
		if value > rankInfo[attrName] then
			rank = rankInfo.rank + 1
		end
	end

	return rank
end

function HeroMixin:getIdMaxStarDic()
	local heroIdMaxStarDic = {}

	for _, hero in pairs(self.heroDic) do
		if not heroIdMaxStarDic[hero.id] then
			heroIdMaxStarDic[hero.id] = hero.star
		elseif hero.star > heroIdMaxStarDic[hero.id] then
			heroIdMaxStarDic[hero.id] = hero.star
		end
	end

	return heroIdMaxStarDic
end

function HeroMixin:getHeroPropValueByStep(attrName, hero, step, star)
	local calStep = step or hero.battleStep
	local calStar = star or hero.star
	local fakeHero = BaseObject.GetObject(hero.id)

	fakeHero.step = math.min(calStep, 6)
	fakeHero.battleStep = math.min(calStep, 6)
	fakeHero.recharge = math.min(calStep, 6)
	fakeHero.star = math.min(calStar, 6)
	fakeHero.level = 101
	fakeHero.realLevel = 101

	fakeHero:initStep()
	fakeHero:refreshSkillInfo()

	local heroAttr = PropHelper.getHeroPanelAttrContainer({}, fakeHero.id, fakeHero.level, fakeHero.battleStep, fakeHero.star, nil, nil, fakeHero)

	return heroAttr[attrName] or 0
end

function HeroMixin:getHeroFilterMaterial(filterInfo, needHeroGid)
	for k, v in pairs(filterInfo) do
		-- block empty
	end

	local filterProp = {
		"star",
		"id",
		"camp"
	}
	local materialHeroList = {}

	for _, hero in pairs(self.heroDic) do
		local canAdd = true

		for _, prop in ipairs(filterProp) do
			if hero[prop] ~= filterInfo[prop] and filterInfo[prop] ~= 0 or hero.gid == needHeroGid then
				canAdd = false
			end
		end

		if canAdd then
			table.insert(materialHeroList, hero)
		end
	end

	local function sortByLevel(a, b)
		if a.level ~= b.level then
			return a.level < b.level
		else
			return a.id < b.id
		end
	end

	table.sort(materialHeroList, sortByLevel)

	return materialHeroList
end

local function sortWearedOrInTeamHero(heroA, heroB)
	for _, pSortData in ipairs(UIConst.HERO_DEFAULT_SORT_MAP) do
		local pName = pSortData.name
		local vA = heroA[pName]
		local vB = heroB[pName]

		if vA and vB then
			if vA ~= vB then
				return vB < vA
			end
		elseif vA or vB then
			return vA ~= nil
		end
	end

	if heroA.id ~= heroB.id then
		return heroA.id > heroB.id
	else
		return heroA.gid > heroB.gid
	end
end

local function sortWearedOrInTeamPlanHero(heroA, heroB)
	if heroA.inDrag ~= heroB.inDrag then
		return heroA.inDrag == 1
	end

	if heroA.weared ~= heroB.weared then
		return heroA.weared > heroB.weared
	end

	for _, pSortData in ipairs(UIConst.HERO_DEFAULT_SORT_MAP) do
		local pName = pSortData.name
		local vA = heroA[pName]
		local vB = heroB[pName]

		if vA and vB then
			if vA ~= vB then
				return vB < vA
			end
		elseif vA or vB then
			return vA ~= nil
		end
	end

	if heroA.id ~= heroB.id then
		return heroA.id > heroB.id
	else
		return heroA.gid > heroB.gid
	end
end

function HeroMixin:canShowStarRevertHelp()
	if #CurAvatar:getFastStarUpHeroList(true) > 0 then
		return nil
	end

	local heroList = {}

	for _, hero in pairs(self.heroDic) do
		table.insert(heroList, hero)
	end

	table.sort(heroList, sortWearedOrInTeamHero)

	local eightUpStarHeroCount = 0
	local nineUpStarHeroCount = 0
	local idQuality4Star6HeroDic = {}
	local camp7StarHeroDic = {}
	local camp8StarHeroDic = {}
	local camp7or8StarHeroList = {}

	for _, hero in ipairs(heroList) do
		if hero.star >= 8 then
			eightUpStarHeroCount = eightUpStarHeroCount + 1
		end

		if hero.star >= 9 then
			nineUpStarHeroCount = nineUpStarHeroCount + 1
		end

		if not hero:isLightOrDark() and hero.quality == 4 then
			if hero.star == 6 then
				if not idQuality4Star6HeroDic[hero.id] then
					idQuality4Star6HeroDic[hero.id] = {}
				end

				table.insert(idQuality4Star6HeroDic[hero.id], hero)
			end

			if hero.star == 7 then
				if not camp7StarHeroDic[hero.camp] then
					camp7StarHeroDic[hero.camp] = {}
				end

				table.insert(camp7StarHeroDic[hero.camp], hero)
			end

			if hero.star == 8 and not camp8StarHeroDic[hero.camp] then
				camp8StarHeroDic[hero.camp] = hero
			end

			if hero.star == 7 or hero.star == 8 and camp8StarHeroDic[hero.camp].gid ~= hero.gid then
				if not camp7or8StarHeroList[hero.camp] then
					camp7or8StarHeroList[hero.camp] = {}
				end

				table.insert(camp7or8StarHeroList[hero.camp], hero)
			end
		end
	end

	if eightUpStarHeroCount < 5 then
		local sameIdHighQ6StarHeroList, sevenStarHero

		for heroId, heroList in pairs(idQuality4Star6HeroDic) do
			if #heroList >= 2 and camp7StarHeroDic[heroList[1].camp] then
				for _, hero in ipairs(camp7StarHeroDic[heroList[1].camp]) do
					if hero.id ~= heroList[1].id then
						sameIdHighQ6StarHeroList = heroList
						sevenStarHero = hero

						break
					end
				end
			end
		end

		if sameIdHighQ6StarHeroList and sevenStarHero then
			local guideData = {}

			guideData.reason = Const.STAR_REVERT_HELP_REASON_EIGHT
			guideData.needRevertHero = sevenStarHero
			guideData.starUpHeroList = sameIdHighQ6StarHeroList

			return guideData
		end
	end

	if nineUpStarHeroCount < 5 then
		local star7or8HeroList, eightStarHero

		for camp, heroList in pairs(camp7or8StarHeroList) do
			if #heroList >= 2 and camp8StarHeroDic[heroList[1].camp] then
				star7or8HeroList = heroList
				eightStarHero = camp8StarHeroDic[heroList[1].camp]
			end
		end

		if star7or8HeroList and eightStarHero then
			local guideData = {}

			guideData.reason = Const.STAR_REVERT_HELP_REASON_NINE
			guideData.needRevertHeroList = star7or8HeroList
			guideData.starUpHero = eightStarHero

			return guideData
		end
	end
end

function HeroMixin:getRevertedOnlyMaterial(hero)
	if ResStarUpRevert[hero.resData.star_up_id] and ResStarUpRevert[hero.resData.star_up_id][hero.star] then
		local revertInfo = ResStarUpRevert[hero.resData.star_up_id][hero.star]

		if revertInfo.return_item_num and revertInfo.return_item_num > 0 then
			local itemId = ResHeroMisc[1].star_return_item[hero.camp]

			if itemId then
				local materialItem = BaseObject.GetObject(itemId, revertInfo.return_item_num)

				return materialItem
			end
		end
	end
end

function HeroMixin:getWearedOrInTeamHero(planData, heroInfos)
	local bagEquips = {}
	local bagArtifacts = {}
	local bagRelics = {}

	if planData then
		for gid, equip in pairs(self.bagEquips) do
			bagEquips[gid] = BaseObject.CopyObject(equip)
			bagEquips[gid].inWearing = nil
		end

		for gid, artifact in pairs(self.bagArtifacts) do
			bagArtifacts[gid] = BaseObject.CopyObject(artifact)
			bagArtifacts[gid].inWearing = nil
		end

		for id, relic in pairs(self.bagRelics) do
			bagRelics[id] = BaseObject.CopyObject(relic)
			bagRelics[id].inWearing = nil
		end
	end

	local heros = {}

	for heroGid, hero in pairs(self.heroDic) do
		if not planData then
			if self:canBeQuickWear(hero) then
				if #hero.equipList > 0 or self.bagArtifacts[hero.artifactGid] or self.bagRelics[hero.relicId] then
					hero.weared = 1
				else
					hero.weared = 0
				end

				hero.inDrag = 0

				if heroInfos and heroInfos[heroGid] then
					hero.inDrag = 1
				end

				table.insert(heros, hero)
			end
		else
			local planHero = self:getEquipPlanHero(planData, hero, bagEquips, bagArtifacts, bagRelics)

			if self:canBeQuickWear(planHero) or heroInfos and heroInfos[heroGid] then
				if #planHero.equipList > 0 or self.bagArtifacts[planHero.artifactGid] or self.bagRelics[planHero.relicId] then
					planHero.weared = 1
				else
					planHero.weared = 0
				end

				planHero.inDrag = 0

				if heroInfos and heroInfos[heroGid] then
					planHero.inDrag = 1
				end

				table.insert(heros, planHero)
			end
		end
	end

	table.sort(heros, sortWearedOrInTeamPlanHero)

	return heros, bagEquips, bagArtifacts, bagRelics
end

function HeroMixin:genNewPlanData(planName)
	local planData = {}

	planData.equipInfoDic = {}

	local heroList = {}

	for _, hero in pairs(self.heroDic) do
		if #hero.equipList > 0 or self.bagArtifacts[hero.artifactGid] or self.bagRelics[hero.relicId] then
			table.insert(heroList, hero)
		end
	end

	table.sort(heroList, sortWearedOrInTeamHero)

	for i = 1, Const.EQUIP_PLAN_MAX_HERO_COUNT do
		local hero = heroList[i]

		if hero then
			local equipInfo = {}

			equipInfo.equipGids = hero:getEquipGidList()
			equipInfo.artifactGid = hero.artifactGid
			equipInfo.relicId = hero.relicId
			planData.equipInfoDic[hero.gid] = equipInfo
		else
			break
		end
	end

	planData.petWearDic = {}

	for _, pet in pairs(CurAvatar.petDic) do
		if pet:checkHaveWear() then
			local info = {}
			local mainAmulet, assistAmulet = pet:getBattleFightAmulet()

			info.amulet1 = mainAmulet and mainAmulet.id ~= Const.PET_DEFAULT_AMULET and mainAmulet.id or 0
			info.amulet2 = assistAmulet and assistAmulet.id or 0
			info.gemList = {}

			local gemList = pet:getBattlePetGem()

			for _, gem in ipairs(gemList) do
				table.insert(info.gemList, gem.gid)
			end

			planData.petWearDic[pet.id] = info
		end
	end

	planData.runeList = {}

	local exclusiveRuneList = CurAvatar:getExclusiveRuneList()
	local exclusiveRuneNodeDic = {}

	for _, rune in ipairs(exclusiveRuneList) do
		local runeConfig = ResPetRune[rune.id]

		if runeConfig then
			if exclusiveRuneNodeDic[runeConfig.node_id] then
				local oldruneConfig = ResPetRune[exclusiveRuneNodeDic[runeConfig.node_id].id]

				if oldruneConfig.level < runeConfig.level then
					exclusiveRuneNodeDic[runeConfig.node_id] = rune
				end
			else
				exclusiveRuneNodeDic[runeConfig.node_id] = rune
			end
		end
	end

	for nodeId, rune in pairs(exclusiveRuneNodeDic) do
		if rune.hero_gid and CurAvatar.heroDic[rune.hero_gid] then
			local info = {}

			info.nodeId = ResPetRune[rune.id].node_id
			info.heroGid = rune.hero_gid

			table.insert(planData.runeList, info)
		end
	end

	planData.name = planName

	return planData
end

function HeroMixin:canBeQuickWear(hero)
	return hero.inTeam == 1 or #hero.equipList > 0 or self.bagArtifacts[hero.artifactGid] or self.bagRelics[hero.relicId] or hero.level > 1
end

function HeroMixin:getEquipPlanHero(planData, _hero, bagEquips, bagArtifacts, bagRelics)
	local planHero = utils.getPlanHero(_hero)

	if planData.equipInfoDic and planData.equipInfoDic[_hero.gid] then
		local wearDic = {}

		wearDic.equips = bagEquips
		wearDic.artifacts = bagArtifacts
		wearDic.relics = bagRelics

		planHero:setWearDic(wearDic)

		local equipInfo = planData.equipInfoDic[_hero.gid]

		planHero:setEquipGidList(equipInfo.equipGids)

		if bagArtifacts[equipInfo.artifactGid] then
			planHero.artifactGid = equipInfo.artifactGid
			bagArtifacts[equipInfo.artifactGid].inWearing = planHero.gid
		end

		if bagRelics[equipInfo.relicId] then
			planHero.relicId = equipInfo.relicId
			bagRelics[equipInfo.relicId].inWearing = planHero.gid
		end

		return planHero
	end

	return planHero
end

function HeroMixin:getCanSellHeroList(ignoreHighQ, ignoreDogFood)
	local heros = {}
	local maxStarQuality4IdList = {}
	local maxStarQuality4IdDic = {}
	local resIdHeroListDic = {}
	local campHeroListDic = {}
	local tenStarIdDic = {}

	for _, hero in pairs(self.heroDic) do
		if hero.resData.quality > 3 and hero.star >= 10 then
			tenStarIdDic[hero.id] = 1
		end

		if hero.quality >= 4 and hero.star == hero:getMaxStar() and not maxStarQuality4IdDic[hero.id] then
			table.insert(maxStarQuality4IdList, hero.id)

			maxStarQuality4IdDic[hero.id] = true
		end

		if not ignoreDogFood and hero.star == hero.resData.ori_star and hero.resData.can_sell and hero.resData.can_sell == 1 and hero.inCry == 0 and hero.lock == 0 then
			table.insert(heros, hero)
		end

		if not resIdHeroListDic[hero.id] then
			resIdHeroListDic[hero.id] = {}
		end

		table.insert(resIdHeroListDic[hero.id], hero)

		if not campHeroListDic[hero.camp] then
			campHeroListDic[hero.camp] = {}
		end

		table.insert(campHeroListDic[hero.camp], hero)
	end

	if not ignoreHighQ then
		for _, heroId in ipairs(maxStarQuality4IdList) do
			if resIdHeroListDic[heroId] then
				for _, hero in ipairs(resIdHeroListDic[heroId]) do
					if (hero.star == 5 or hero.star == 6) and hero.inCry == 0 and hero.lock == 0 and hero.resData.can_sell and hero.resData.can_sell == 2 then
						table.insert(heros, hero)
					end
				end
			end
		end

		local passCampList = {
			1,
			1,
			1,
			1,
			1
		}

		for id, heroRes in pairs(ResHero) do
			if ClientUtils.isTimeConfigPassed(heroRes.valid_time_id) then
				local bNotHaveLimitHero = heroRes.ban_star_material == 1 and heroRes.quality > 3 and not resIdHeroListDic[heroRes.id]

				if not bNotHaveLimitHero and not tenStarIdDic[heroRes.id] and heroRes.quality > 3 then
					passCampList[heroRes.camp] = 0
				end
			end
		end

		for camp, pass in ipairs(passCampList) do
			if pass == 1 and campHeroListDic[camp] then
				for _, hero in ipairs(campHeroListDic[camp]) do
					if hero.resData.ori_star <= 4 and hero.inCry == 0 and hero.lock == 0 and hero.resData.can_sell and hero.resData.can_sell == 2 then
						table.insert(heros, hero)
					end
				end
			end
		end
	end

	return heros
end

function HeroMixin:getRechargeNeedStep(recharge)
	if not self.rechargeStepMap then
		self.rechargeStepMap = {}

		for step, info in ipairs(ResStep) do
			self.rechargeStepMap[info.recharge_times] = step
		end
	end

	return self.rechargeStepMap[recharge] or 0
end

function HeroMixin:checkCanHintSellHeros()
	local isLocked = ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_HERO_RECYCLE)

	if isLocked then
		return
	end

	RedDotManager.setKeyState(UIConst.RD_HINT_HERO_SELL, #self:getCanSellHeroList(true) >= UIMiscConfig.HINT_HERO_SELL_COUNT)
end

function HeroMixin:haveOverflowHero()
	return #self:getCanSellHeroList(nil, true) > 0
end

function HeroMixin:checkCanStepUpInTeamHeros()
	self:checkCanSweepStepInTeamHeros()

	self.canStepUpInTeamHerosDic = {}
	self.canStepUpInTeamHerosList = {}

	for _, hero in pairs(self:getCrystalPriestsHeros(true, true, Const.FORMATION_MAZE)) do
		local canStep = self:checkHeroCanStepUp(hero)

		if canStep then
			self.canStepUpInTeamHerosDic[hero.gid] = true

			table.insert(self.canStepUpInTeamHerosList, hero.gid)
		end
	end

	RedDotManager.setKeyState(UIConst.RD_HINT_HERO_STEP_UP, #self.canStepUpInTeamHerosList > 0)
end

function HeroMixin:checkHeroCanStepUp(hero)
	local heroMaxStep = hero:getMaxStep()

	if heroMaxStep > hero.step and hero.level >= ResStep[hero.step + 1].level_limit then
		local stepCostInfo = ResStepCost[hero.resData.step_up_id][hero.step + 1]

		if self:getMoneyByType(Const.MONEY_TYPE_GOLD) < stepCostInfo.gold then
			return false
		end

		for _, idNum in ipairs(stepCostInfo.materials) do
			local haveCount = self:getItemNumById(idNum.id)
			local needCount = idNum.num

			if haveCount < needCount then
				return false
			end
		end

		return true
	else
		return false
	end
end

function HeroMixin:getMaterialTowerCanSweep(itemId)
	if ResItem[itemId].get_ids then
		for _, getId in ipairs(ResItem[itemId].get_ids) do
			local args = ResGuideGet[getId].condition_args
			local conditionOutput = self:getStepTowerCondition(args)

			if self:getIsConditionAllPass(conditionOutput) then
				return true
			end
		end

		return false
	else
		return false
	end
end

function HeroMixin:checkHeroCanRecharge(hero)
	local rechargeTimes = ResStep[hero.step] and ResStep[hero.step].recharge_times or 0

	if rechargeTimes > hero.recharge then
		local stepCostInfo = ResRechargeCost[hero.recharge + 1]

		if not stepCostInfo then
			return false
		end

		for _, idNum in ipairs(stepCostInfo.materials) do
			local haveCount = self:getItemNumById(idNum.id)
			local needCount = idNum.num

			if haveCount < needCount then
				return false
			end
		end

		return true
	else
		return false
	end
end

function HeroMixin:checkCanSweepStepInTeamHeros()
	self:checkCanQuickSweepInTeamHeros()

	self.canSweepStepInTeamHerosDic = {}
	self.canSweepStepInTeamHerosList = {}

	local powerLimit = self:getIsHeroStepNeedHighPower() and 110 or 50
	local isLocked = ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_STEP_TOWER)

	if not isLocked and powerLimit <= self.realPowerNum then
		for _, hero in pairs(self:getCrystalPriestsHeros(true, true, Const.FORMATION_MAZE)) do
			local canSweep = self:checkHeroCanSweepStep(hero)

			if canSweep then
				self.canSweepStepInTeamHerosDic[hero.gid] = true

				table.insert(self.canSweepStepInTeamHerosList, hero.gid)
			end
		end

		RedDotManager.setKeyState(UIConst.RD_HINT_HERO_STEP_CAN_SWEEP, #self.canSweepStepInTeamHerosList > 0)
	else
		RedDotManager.setKeyState(UIConst.RD_HINT_HERO_STEP_CAN_SWEEP, false)
	end
end

function HeroMixin:checkCanQuickSweepInTeamHeros()
	self.canQuickSweepInTeamHerosDic = {}
	self.canQuickSweepInTeamHerosList = {}

	local isLocked = ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_STEP_TOWER)

	if not isLocked then
		for _, hero in pairs(self:getCrystalPriestsHeros(true, true, Const.FORMATION_MAZE)) do
			local canSweep = self:checkHeroCanSweepTowerAndPowerEnough(hero)

			if canSweep then
				self.canQuickSweepInTeamHerosDic[hero.gid] = true

				table.insert(self.canQuickSweepInTeamHerosList, hero.gid)
			end
		end

		RedDotManager.setKeyState(UIConst.RD_HINT_HERO_STEP_QUICK_SWEEP, #self.canQuickSweepInTeamHerosList > 0)
	else
		RedDotManager.setKeyState(UIConst.RD_HINT_HERO_STEP_QUICK_SWEEP, false)
	end
end

function HeroMixin:getIsHeroStepNeedHighPower()
	for _, hero in pairs(self.heroDic) do
		if hero.step > 3 then
			return true
		end
	end

	return false
end

function HeroMixin:checkHeroCanSweepStep(hero, includeCanStepUp)
	local heroMaxStep = hero:getMaxStep()

	if heroMaxStep > hero.step and hero.level >= ResStep[hero.step + 1].level_limit then
		if includeCanStepUp or not self:checkHeroCanStepUp(hero) then
			local stepCostInfo = ResStepCost[hero.resData.step_up_id][hero.step + 1]

			for _, idNum in ipairs(stepCostInfo.materials) do
				if not self:getMaterialTowerCanSweep(idNum.id) then
					return false
				end
			end

			return true
		end

		return false
	else
		return false
	end
end

function HeroMixin:checkHeroCanSweepTower(hero)
	local powerLimit = self:getIsHeroStepNeedHighPower() and 110 or 50
	local isLocked = ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_STEP_TOWER)

	if not isLocked and powerLimit <= self.realPowerNum then
		return self:checkHeroCanSweepStep(hero)
	else
		return false
	end
end

function HeroMixin:checkHeroCanSweepTowerAndPowerEnough(hero)
	local powerLimit = self:getHeroStepUpNeedPower(hero)
	local heroMaxStep = hero:getMaxStep()
	local isLocked = ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_STEP_TOWER)

	if not isLocked and powerLimit > 0 and powerLimit <= self.realPowerNum and heroMaxStep > hero.step and hero.level >= ResStep[hero.step + 1].level_limit then
		return true
	else
		return false
	end
end

function HeroMixin:getStepTowerLayerByHero(hero, step, ignoreTowerLock)
	local layerInfoList = {}

	step = step or hero.step + 1

	local stepCostInfo = ResStepCost[hero.resData.step_up_id][step]
	local lackMaterialCount = 0

	if stepCostInfo then
		for _, idNum in ipairs(stepCostInfo.materials) do
			local materialId = idNum.id
			local needCount = math.max(0, idNum.num - ClientUtils.getMoney(materialId))

			if needCount > 0 then
				lackMaterialCount = lackMaterialCount + 1

				if ResItem[materialId].get_ids then
					for i = #ResItem[materialId].get_ids, 1, -1 do
						local args = ResGuideGet[ResItem[materialId].get_ids[i]].condition_args
						local layer = args[1]
						local level = args[2]

						if ResTower[layer] and ResTower[layer][level] then
							local rewardIdSweep = ResTower[layer][level].award
							local randItemSweep = ResRandClient[rewardIdSweep]
							local onceCount = 0

							for i, id in ipairs(randItemSweep.show_ids) do
								if id == materialId and randItemSweep.show_nums then
									onceCount = randItemSweep.show_nums[i] or 0

									break
								end
							end

							if onceCount ~= 0 then
								local needTimes = math.ceil(needCount / onceCount)
								local passCount = self.stepTowerLayerData[layer].stage[level] ~= nil and self.stepTowerLayerData[layer].stage[level].num or 0

								if ResTower[layer][level] and (ignoreTowerLock or needTimes <= ResTower[layer][level].times - passCount and self:checkStepTowerCanSweep(layer, level)) then
									table.insert(layerInfoList, {
										layer,
										level,
										needCount,
										needTimes
									})

									break
								end
							end
						end
					end
				end
			end
		end
	end

	if stepCostInfo and #layerInfoList == lackMaterialCount then
		return layerInfoList
	end
end

function HeroMixin:getHeroStepUpNeedPower(hero, step, ignoreTowerLock)
	local needPower = -1

	step = step or hero.step + 1

	local layerInfoList = self:getStepTowerLayerByHero(hero, step, ignoreTowerLock)

	if layerInfoList then
		needPower = 0

		for _, layerInfo in ipairs(layerInfoList) do
			local needTimes = layerInfo[4]
			local layer = layerInfo[1]
			local level = layerInfo[2]

			needPower = needPower + needTimes * ResTower[layer][level].power_cost
		end
	end

	return needPower
end

function HeroMixin:checkCanEquipInTeamHeros(noRefreshUI)
	self.canEquipInTeamHerosDic = {}
	self.canEquipInTeamHerosList = {}

	local bagEquipMaxRankDic, bagArtifactMaxRankDic, bagCustomMadeArtifactDic = self:getBagEquipMaxRank()
	local formationIdx = tonumber(UserData.loadCommonData("LastFormationIdx") or 0)
	local lastFormationHeros = self:getFormationHeros(formationIdx)

	for _, hero in pairs(lastFormationHeros) do
		local canEquip = self:checkHeroCanEquip(hero, bagEquipMaxRankDic, bagArtifactMaxRankDic, bagCustomMadeArtifactDic)

		if canEquip then
			self.canEquipInTeamHerosDic[hero.gid] = true

			table.insert(self.canEquipInTeamHerosList, hero.gid)
		end
	end

	RedDotManager.setKeyState(UIConst.RD_HINT_HERO_EQUIP, #self.canEquipInTeamHerosList > 0)

	if GameFsm.isInBattleState() then
		local canWear = self:checkHeroCanWearBetterEquip()

		RedDotManager.setKeyState(UIConst.RD_HINT_BATTLE_EQUIP_WEAR, canWear)
	end

	if not noRefreshUI then
		self:refreshHeroDetail()
	end
end

function HeroMixin:getHeroCanEquipPart(hero, bagEquipMaxRankDic, bagArtifactMaxRankDic, bagCustomMadeArtifactDic, bagWears, ignoreRelicLevel)
	if not bagEquipMaxRankDic then
		bagEquipMaxRankDic, bagArtifactMaxRankDic, bagCustomMadeArtifactDic = self:getBagEquipMaxRank(nil, bagWears)
	end

	local canEquipPartList = {}
	local equips = hero:getEquips()
	local banType = hero:getEquipBanPropType()
	local bagEquipMaxSuitRankDic = bagEquipMaxRankDic[banType]

	for part = 1, 6 do
		if not equips[part] or not equips[part]:getDefineHeroId() or hero.id ~= equips[part]:getDefineHeroId() then
			local maxEquip

			if equips[part] and equips[part]:isActiveSuit(hero) then
				maxEquip = bagEquipMaxSuitRankDic[equips[part].suitId][part]
			else
				maxEquip = bagEquipMaxSuitRankDic[0][part]
			end

			local maxRank = maxEquip and maxEquip:getRankScore(banType) or 0
			local equipScore = equips[part] and equips[part]:getRankScore(banType) or 0
			local hintThreshold = 0

			if equips[part] and equips[part].quality >= Const.EQUIP_QUALITY_PINK then
				hintThreshold = 1000
			elseif equips[part] then
				hintThreshold = 500
			end

			if maxRank > equipScore + hintThreshold then
				table.insert(canEquipPartList, part)
			end
		end
	end

	local artifactRankScore = hero:getArtifactRankScore()
	local artifact = hero:getArtifact()
	local maxRank = 0

	if artifact then
		if bagArtifactMaxRankDic[hero.career] and bagArtifactMaxRankDic[hero.career][artifact.mechanismType] then
			maxRank = bagArtifactMaxRankDic[hero.career][artifact.mechanismType].rank

			if artifactRankScore < maxRank then
				table.insert(canEquipPartList, Const.PART_OF_ARTIFACT)
			end
		elseif bagArtifactMaxRankDic[Const.CAREER_TYPE.ALL] and bagArtifactMaxRankDic[Const.CAREER_TYPE.ALL][artifact.mechanismType] then
			maxRank = bagArtifactMaxRankDic[Const.CAREER_TYPE.ALL][artifact.mechanismType].rank

			if artifactRankScore < maxRank then
				table.insert(canEquipPartList, Const.PART_OF_ARTIFACT)
			end
		elseif bagCustomMadeArtifactDic[hero.id] then
			maxRank = bagCustomMadeArtifactDic[hero.id].rank

			if artifactRankScore < maxRank then
				table.insert(canEquipPartList, Const.PART_OF_ARTIFACT)
			end
		end
	elseif bagArtifactMaxRankDic[hero.career] or bagArtifactMaxRankDic[Const.CAREER_TYPE.ALL] or bagCustomMadeArtifactDic[hero.id] then
		table.insert(canEquipPartList, Const.PART_OF_ARTIFACT)
	end

	local bestRelic = self:getBestRelic(hero, bagWears, false, ignoreRelicLevel)
	local wearedRelic = hero:getRelic()

	if bestRelic and bestRelic ~= wearedRelic then
		table.insert(canEquipPartList, Const.PART_OF_RELIC)
	end

	return canEquipPartList
end

function HeroMixin:checkHeroCanEquip(hero, bagEquipMaxRankDic, bagArtifactMaxRankDic, bagCustomMadeArtifactDic)
	local canEquipPartList = self:getHeroCanEquipPart(hero, bagEquipMaxRankDic, bagArtifactMaxRankDic, bagCustomMadeArtifactDic, nil, true)

	return #canEquipPartList ~= 0
end

function HeroMixin:checkFirstSeasonShow(heroId)
	if self.firstShowSeasonRelicHeroDic and self.firstShowSeasonRelicHeroDic[heroId] then
		return true
	end

	return false
end

function HeroMixin:getSeasonRelicRedDotByHeroId(heroId)
	if self:checkFirstSeasonShow(heroId) then
		return true
	end

	if self.canUnLockSeasonRelicHeroDic and self.canUnLockSeasonRelicHeroDic[heroId] then
		return true
	end

	if self.canLvUpSeasonRelicHeroDic and self.canLvUpSeasonRelicHeroDic[heroId] then
		return true
	end

	return false
end

function HeroMixin:checkHeroCanEquipOrSeasonRelic(hero)
	if self:checkHeroCanEquip(hero) or self:getSeasonRelicRedDotByHeroId(hero.id) then
		return true
	end

	return false
end

local function _sortSuitEquipByRankScore(a, b)
	if a.rankDefineScore ~= b.rankDefineScore then
		return a.rankDefineScore > b.rankDefineScore
	else
		return a.id < b.id
	end
end

local function _sortSuitId(a, b)
	if ResEquipSuit[a].need_num ~= ResEquipSuit[b].need_num then
		return ResEquipSuit[a].need_num > ResEquipSuit[b].need_num
	else
		return a < b
	end
end

function HeroMixin:getPosEquipListBySuitId(banType, suitId, bagEquipMaxSuitRankDic)
	local suitPosDic = bagEquipMaxSuitRankDic[suitId]
	local posEquipList = {}

	for pos, equip in pairs(suitPosDic) do
		equip.rankDefineScore = equip:getRankScore(banType)

		table.insert(posEquipList, equip)
	end

	table.sort(posEquipList, _sortSuitEquipByRankScore)

	return posEquipList
end

function HeroMixin:getCircleBattleHeroList()
	local heroDic = self:getCircleBattleHeroDic()
	local heroList = {}

	for _, hero in pairs(heroDic) do
		table.insert(heroList, hero)
	end

	table.sort(heroList, sortWearedOrInTeamHero)

	return heroList
end

function HeroMixin:getBestRelic(hero, bagWearDic, ignoreWearing, ignoreLevel)
	local tempRelic = not ignoreWearing and hero:getRelic() or nil
	local tempScore = tempRelic and tempRelic:getRankScore(hero, ignoreLevel) or 0
	local bagRelics = bagWearDic and bagWearDic.relics or self.bagRelics

	for _, relic in pairs(bagRelics) do
		if (not relic.inWearing or ignoreWearing) and relic:isCanBeWear(hero) then
			local score = relic:getRankScore(hero, ignoreLevel)

			if tempRelic then
				if tempScore < score then
					tempRelic = relic
					tempScore = score
				end
			else
				tempRelic = relic
				tempScore = score
			end
		end
	end

	return tempRelic
end

local function confirmWearEquip(wearInfo)
	if wearInfo.equipGids and #wearInfo.equipGids > 0 then
		RPC.equipWear(wearInfo.heroGid, wearInfo.equipGids)

		if wearInfo.betterArtifactGid then
			RPC.artifactWear(wearInfo.heroGid, wearInfo.betterArtifactGid)
		end

		if wearInfo.betterRelicId then
			RPC.relicWear(wearInfo.heroGid, wearInfo.betterRelicId)
		end

		MsgManager.clientNotice(252)
	elseif wearInfo.betterArtifactGid or wearInfo.betterRelicId then
		if wearInfo.betterArtifactGid then
			RPC.artifactWear(wearInfo.heroGid, wearInfo.betterArtifactGid)
		end

		if wearInfo.betterRelicId then
			RPC.relicWear(wearInfo.heroGid, wearInfo.betterRelicId)
		end

		MsgManager.clientNotice(252)
	else
		MsgManager.clientNotice(253)
	end
end

local function _sortSuitByExtraPos(a, b)
	if a.extraPosInfo.extraPosCnt ~= b.extraPosInfo.extraPosCnt then
		return a.extraPosInfo.extraPosCnt < b.extraPosInfo.extraPosCnt
	elseif a.extraPosInfo.oriIdx ~= b.extraPosInfo.oriIdx then
		return a.extraPosInfo.oriIdx < b.extraPosInfo.oriIdx
	end
end

local function _sortSuitPosList(a, b)
	if a.maxScore ~= b.maxScore then
		return a.maxScore > b.maxScore
	elseif a.pos ~= b.pos then
		return a.pos < b.pos
	end
end

function HeroMixin:getBestEquipsBySuits(banType, suitEquipsDic, suitNeedNumDic, nowPos, wearDic, bestEquipDic)
	if wearDic == nil then
		wearDic = wearDic or {}
	end

	if bestEquipDic == nil then
		bestEquipDic = bestEquipDic or {}
		bestEquipDic.equipDic = nil
		bestEquipDic.maxScore = 0
	end

	local totalNeedNum = 0

	for _, needNum in pairs(suitNeedNumDic) do
		totalNeedNum = totalNeedNum + needNum
	end

	for suitId, suitEquips in pairs(suitEquipsDic) do
		local needNum = suitNeedNumDic[suitId] or 0
		local equip = suitEquips[nowPos] or nil

		if needNum > 0 and equip ~= nil then
			local newWearDic = utils.copyTable(wearDic)

			newWearDic[nowPos] = equip

			if totalNeedNum == 1 then
				local tmpScore = 0

				for _, tmpEquip in pairs(newWearDic) do
					tmpScore = tmpScore + tmpEquip:getRankScore(banType)
				end

				if tmpScore > bestEquipDic.maxScore then
					bestEquipDic.equipDic = newWearDic
					bestEquipDic.maxScore = tmpScore
				end
			elseif nowPos < 6 then
				local newNowPos = nowPos + 1
				local newSuitNeedNumDic = utils.copyTable(suitNeedNumDic)

				newSuitNeedNumDic[suitId] = needNum - 1

				self:getBestEquipsBySuits(banType, suitEquipsDic, newSuitNeedNumDic, newNowPos, newWearDic, bestEquipDic)
			end
		end
	end

	if totalNeedNum <= 6 - nowPos then
		local newNowPos = nowPos + 1

		self:getBestEquipsBySuits(banType, suitEquipsDic, suitNeedNumDic, newNowPos, wearDic, bestEquipDic)
	end

	if nowPos == 1 then
		return bestEquipDic.equipDic, bestEquipDic.maxScore
	end
end

function HeroMixin:getCustomWearEquipGids(hero, suitIds, bagWearDic)
	local equipGids = {}
	local bagEquipMaxRankDic, bagArtifactMaxRankDic, bagCustomMadeArtifactDic = self:getBagEquipMaxRank(hero, bagWearDic, hero.id)
	local banType = hero:getEquipBanPropType()
	local bagEquipMaxSuitRankDic = bagEquipMaxRankDic[banType]
	local extraPosInfoDic = {}
	local posEquipsList = {}

	for idx, suitId in ipairs(suitIds) do
		local extraPosInfo = extraPosInfoDic[suitId] or {}

		extraPosInfo.includePos = {}
		extraPosInfo.totalNeedNum = ResEquipSuit[suitId].need_num + (extraPosInfo.totalNeedNum or 0)

		for pos, equip in pairs(bagEquipMaxSuitRankDic[suitId]) do
			equip.rankDefineScore = equip:getRankScore(banType)
			extraPosInfo.includePos[pos] = equip

			if not posEquipsList[pos] then
				posEquipsList[pos] = {}
			end

			table.insert(posEquipsList[pos], equip)
			table.sort(posEquipsList[pos], _sortSuitEquipByRankScore)
		end

		extraPosInfoDic[suitId] = extraPosInfo
	end

	local suitPosList = {}

	for pos, equips in pairs(posEquipsList) do
		local suitPosInfo = {}

		suitPosInfo.pos = pos
		suitPosInfo.maxScore = equips[1].rankDefineScore

		table.insert(suitPosList, suitPosInfo)
	end

	table.sort(suitPosList, _sortSuitPosList)

	local wearedSuitCntDic = {}
	local wearedPosDic = {}
	local noExtraSuitIds = self:getNoExtraSuitId(extraPosInfoDic, wearedSuitCntDic, wearedPosDic)

	for _, suitId in ipairs(noExtraSuitIds) do
		self:forceWearBySuitId(suitId, extraPosInfoDic[suitId], wearedPosDic, posEquipsList, wearedSuitCntDic)
	end

	for _, suitPosInfo in ipairs(suitPosList) do
		if not wearedPosDic[suitPosInfo.pos] then
			for _, equip in ipairs(posEquipsList[suitPosInfo.pos]) do
				if (wearedSuitCntDic[equip.suitId] or 0) < extraPosInfoDic[equip.suitId].totalNeedNum then
					wearedSuitCntDic[equip.suitId] = (wearedSuitCntDic[equip.suitId] or 0) + 1
					wearedPosDic[suitPosInfo.pos] = equip

					break
				end
			end

			local noExtraSuitIds = self:getNoExtraSuitId(extraPosInfoDic, wearedSuitCntDic, wearedPosDic)

			for _, suitId in ipairs(noExtraSuitIds) do
				self:forceWearBySuitId(suitId, extraPosInfoDic[suitId], wearedPosDic, posEquipsList, wearedSuitCntDic)
			end
		end
	end

	for pos, equip in pairs(wearedPosDic) do
		if not equip.inWearing then
			table.insert(equipGids, equip.gid)
		end
	end

	local offEquipGids = {}
	local equips = hero:getEquips()

	for pos, equip in pairs(equips) do
		if not wearedPosDic[pos] then
			table.insert(offEquipGids, equip.gid)
		end
	end

	return equipGids, offEquipGids
end

function HeroMixin:forceWearBySuitId(suitId, extraPosInfo, wearedPosDic, posEquipsList, wearedSuitCntDic)
	for pos, equips in pairs(extraPosInfo.includePos) do
		if not wearedPosDic[pos] then
			for _, equip in ipairs(posEquipsList[pos]) do
				if suitId == equip.suitId then
					wearedSuitCntDic[equip.suitId] = (wearedSuitCntDic[equip.suitId] or 0) + 1
					wearedPosDic[pos] = equip

					break
				end
			end
		end
	end
end

function HeroMixin:getNoExtraSuitId(extraPosInfoDic, wearedSuitCntDic, wearedPosDic)
	local noExtraSuitIds = {}

	for suitId, extraPosInfo in pairs(extraPosInfoDic) do
		local validPosCnt = 0

		for pos, equips in pairs(extraPosInfo.includePos) do
			if not wearedPosDic[pos] then
				validPosCnt = validPosCnt + 1
			end
		end

		if validPosCnt - (extraPosInfo.totalNeedNum - (wearedSuitCntDic[suitId] or 0)) == 0 then
			table.insert(noExtraSuitIds, suitId)
		end
	end

	for k, v in pairs(noExtraSuitIds) do
		-- block empty
	end

	return noExtraSuitIds
end

function HeroMixin:canSuitCoexist(suitIds, bagEquipMaxSuitRankDic)
	local totalNeed = 0
	local totalDuplicate = 0
	local totalExist = 0
	local alreadyPosDic = {}

	for _, suitId in ipairs(suitIds) do
		totalNeed = totalNeed + ResEquipSuit[suitId].need_num

		for pos, equip in pairs(bagEquipMaxSuitRankDic[suitId]) do
			if alreadyPosDic[pos] then
				totalDuplicate = totalDuplicate + 1
			else
				alreadyPosDic[pos] = true
			end

			totalExist = totalExist + 1
		end
	end

	return totalNeed <= totalExist - totalDuplicate
end

function HeroMixin:getQuickWearInfo(hero, bagWearDic)
	local bagEquipMaxRankDic, bagArtifactMaxRankDic, bagCustomMadeArtifactDic = self:getBagEquipMaxRank(hero, bagWearDic, hero.id)
	local equipInfo = {}
	local banType = hero:getEquipBanPropType()
	local bagEquipMaxSuitRankDic = bagEquipMaxRankDic[banType]
	local allSuitsPosEquipDic = {}

	for pos, equip in pairs(bagEquipMaxSuitRankDic[0]) do
		allSuitsPosEquipDic[pos] = equip
	end

	local canEquipPartList = self:getHeroCanEquipPart(hero, nil, nil, nil, bagWearDic)

	if #canEquipPartList == 0 then
		MsgManager.clientNotice(253)
	else
		local suits = hero:getSuits()
		local equipGids = {}

		if #suits > 0 then
			table.sort(suits, _sortSuitId)

			local canRetainSuit = true
			local allreadyWear = {}

			for _, suitId in ipairs(suits) do
				local posEquipList = self:getPosEquipListBySuitId(banType, suitId, bagEquipMaxSuitRankDic)
				local reSuitData = ResEquipSuit[suitId]

				for i = 1, reSuitData.need_num do
					if posEquipList[i] and not allreadyWear[posEquipList[i].part] then
						allreadyWear[posEquipList[i].part] = posEquipList[i]
					else
						canRetainSuit = false

						break
					end
				end
			end

			if canRetainSuit then
				for part = 1, 6 do
					if allreadyWear[part] then
						if not allreadyWear[part].inWearing then
							table.insert(equipGids, allreadyWear[part].gid)
						end
					elseif allSuitsPosEquipDic[part] and not allSuitsPosEquipDic[part].inWearing then
						table.insert(equipGids, allSuitsPosEquipDic[part].gid)
					end
				end
			else
				local equips = hero:getEquips()

				for _, part in ipairs(canEquipPartList) do
					if equips[part] and equips[part]:isActiveSuit(hero) then
						if bagEquipMaxSuitRankDic[equips[part].suitId][part] then
							table.insert(equipGids, bagEquipMaxSuitRankDic[equips[part].suitId][part].gid)
						end
					elseif allSuitsPosEquipDic[part] then
						table.insert(equipGids, allSuitsPosEquipDic[part].gid)
					end
				end
			end
		else
			local recEquipConfig = ResEquipRecSuit[hero.career]
			local fourSuitList = recEquipConfig.four_suits
			local twoSuitList = recEquipConfig.two_suits
			local curWearDic = {}
			local maxFourEquipList = {}
			local maxFourEquipScore = 0
			local needTwoSuitCount = 3

			for _, suitId in ipairs(fourSuitList) do
				local equipList = self:getPosEquipListBySuitId(banType, suitId, bagEquipMaxSuitRankDic)

				if #equipList >= 4 then
					local tmpMaxScore = 0

					for i = 1, 4 do
						tmpMaxScore = tmpMaxScore + equipList[i].rankDefineScore
					end

					if maxFourEquipScore < tmpMaxScore then
						maxFourEquipScore = tmpMaxScore

						for i = 1, 4 do
							maxFourEquipList[i] = equipList[i]
						end
					end
				end
			end

			if #maxFourEquipList == 4 then
				for i = 1, 4 do
					local equip = maxFourEquipList[i]

					table.insert(equipGids, equip.gid)

					curWearDic[equip.part] = equip
				end

				needTwoSuitCount = 1
			end

			local twoSuitMaxEquipDic = {}

			for _, suitId in ipairs(twoSuitList) do
				local equipList = self:getPosEquipListBySuitId(banType, suitId, bagEquipMaxSuitRankDic)

				if #equipList >= 2 then
					twoSuitMaxEquipDic[suitId] = equipList
				end
			end

			for i = 1, needTwoSuitCount do
				local bestEquip1, bestEquip2
				local maxScore = 0

				for _, suitId in ipairs(twoSuitList) do
					local equipList = twoSuitMaxEquipDic[suitId]

					if not equipList then
						-- block empty
					else
						local equip1, equip2
						local score = 0

						for _, equip in ipairs(equipList) do
							if not curWearDic[equip.part] then
								if equip1 then
									equip2 = equip

									break
								else
									equip1 = equip
								end
							end
						end

						if equip1 and equip2 then
							score = equip1.rankDefineScore + equip2.rankDefineScore

							if maxScore < score then
								bestEquip1 = equip1
								bestEquip2 = equip2
								maxScore = score
							end
						end
					end
				end

				if bestEquip1 and bestEquip2 then
					curWearDic[bestEquip1.part] = bestEquip1
					curWearDic[bestEquip2.part] = bestEquip1

					table.insert(equipGids, bestEquip1.gid)
					table.insert(equipGids, bestEquip2.gid)
				end
			end

			for part = 1, 6 do
				if not curWearDic[part] and allSuitsPosEquipDic[part] and not allSuitsPosEquipDic[part].inWearing then
					table.insert(equipGids, allSuitsPosEquipDic[part].gid)
				end
			end
		end

		local betterArtifactGid
		local artifact = hero:getArtifact()

		if artifact then
			local maxRankScore = artifact.rankScore

			if bagCustomMadeArtifactDic[hero.id] then
				maxRankScore = bagCustomMadeArtifactDic[hero.id].rank
				betterArtifactGid = bagCustomMadeArtifactDic[hero.id].obj.gid
			end

			if bagArtifactMaxRankDic[artifact.career] and bagArtifactMaxRankDic[artifact.career][artifact.mechanismType] and maxRankScore < bagArtifactMaxRankDic[artifact.career][artifact.mechanismType].rank then
				maxRankScore = bagArtifactMaxRankDic[artifact.career][artifact.mechanismType].rank
				betterArtifactGid = bagArtifactMaxRankDic[artifact.career][artifact.mechanismType].obj.gid
			end

			if bagArtifactMaxRankDic[Const.CAREER_TYPE.ALL] and bagArtifactMaxRankDic[Const.CAREER_TYPE.ALL][artifact.mechanismType] and maxRankScore < bagArtifactMaxRankDic[Const.CAREER_TYPE.ALL][artifact.mechanismType].rank then
				maxRankScore = bagArtifactMaxRankDic[Const.CAREER_TYPE.ALL][artifact.mechanismType].rank
				betterArtifactGid = bagArtifactMaxRankDic[Const.CAREER_TYPE.ALL][artifact.mechanismType].obj.gid
			end
		elseif not artifact and (bagArtifactMaxRankDic[Const.CAREER_TYPE.ALL] or bagArtifactMaxRankDic[hero.career] or bagCustomMadeArtifactDic[hero.id]) then
			local maxRankScore = 0

			if bagCustomMadeArtifactDic[hero.id] then
				maxRankScore = bagCustomMadeArtifactDic[hero.id].rank
				betterArtifactGid = bagCustomMadeArtifactDic[hero.id].obj.gid
			end

			if bagArtifactMaxRankDic[hero.career] then
				for mechanismType, maxInfo in pairs(bagArtifactMaxRankDic[hero.career]) do
					if maxRankScore < maxInfo.rank then
						maxRankScore = maxInfo.rank
						betterArtifactGid = maxInfo.obj.gid
					end
				end
			end

			if bagArtifactMaxRankDic[Const.CAREER_TYPE.ALL] then
				for mechanismType, maxInfo in pairs(bagArtifactMaxRankDic[Const.CAREER_TYPE.ALL]) do
					if maxRankScore < maxInfo.rank then
						maxRankScore = maxInfo.rank
						betterArtifactGid = maxInfo.obj.gid
					end
				end
			end
		end

		local bestRelic = self:getBestRelic(hero, bagWearDic)
		local betterRelicId = bestRelic ~= nil and bestRelic.id or nil

		equipInfo.equipGids = equipGids
		equipInfo.artifactGid = betterArtifactGid
		equipInfo.relicId = betterRelicId

		return equipInfo
	end
end

function HeroMixin:heroQuickWear(hero)
	local equipGids, betterArtifactGid, betterRelicId
	local equipInfo = self:getQuickWearInfo(hero)

	if equipInfo then
		equipGids = equipInfo.equipGids
		betterArtifactGid = equipInfo.artifactGid
		betterRelicId = equipInfo.relicId
	else
		return
	end

	local checkChange = false

	if equipGids and #equipGids > 0 then
		local bagEquips = CurAvatar.bagEquips
		local equips = hero:getEquips()
		local wearEquipGidList = {}
		local offEquipPosList = {}

		for _, gid in pairs(equipGids) do
			local equip = bagEquips[gid]

			if equip.inWearing ~= hero.gid then
				if equips and equips[equip.part] then
					table.insert(offEquipPosList, equip.part - 1)
				end

				table.insert(wearEquipGidList, gid)
			end
		end

		if #offEquipPosList > 0 then
			RPC.equipOff(hero.gid, offEquipPosList)
		end

		if #wearEquipGidList > 0 then
			checkChange = true

			RPC.equipWear(hero.gid, wearEquipGidList)
		end
	end

	if betterArtifactGid then
		local artifact = hero:getArtifact()

		if not artifact or artifact.gid ~= betterArtifactGid then
			if artifact then
				RPC.artifactOff(hero.gid, artifact.gid)
			end

			checkChange = true

			RPC.artifactWear(hero.gid, betterArtifactGid)
		end
	end

	if betterRelicId then
		local relic = hero:getRelic()

		if not relic or relic.id ~= betterRelicId then
			if relic then
				RPC.relicOff(hero.gid)
			end

			checkChange = true

			RPC.relicWear(hero.gid, betterRelicId)
		end
	end

	if checkChange then
		MsgManager.clientNotice(252)
	else
		MsgManager.clientNotice(253)
	end
end

local function confirmOffEquip(offInfo)
	local isEquipOff = false

	if offInfo.subTypes and #offInfo.subTypes > 0 then
		isEquipOff = true

		RPC.equipOff(offInfo.hero.gid, offInfo.subTypes)
	end

	local artifact = offInfo.hero:getArtifact()

	if artifact then
		isEquipOff = true

		RPC.artifactOff(offInfo.hero.gid, artifact.gid)
	end

	local relic = offInfo.hero:getRelic()

	if relic then
		isEquipOff = true

		RPC.relicOff(offInfo.hero.gid)
	end

	if not isEquipOff then
		MsgManager.clientNotice(267)
	end
end

function HeroMixin:heroQuickUnload(hero)
	local equips = hero:getEquips()

	if utils.getTableElemCount(equips) > 0 then
		local subTypes = {}
		local unEvolvedEquipParts = {}
		local costId = 0
		local costNum = 0

		for subType, equip in pairs(equips) do
			table.insert(subTypes, subType - 1)

			if equip.evolve > 0 then
				local materialNeedInfo = equip:getOffMaterialNeed()

				costId = materialNeedInfo[1]
				costNum = costNum + materialNeedInfo[2]
			else
				table.insert(unEvolvedEquipParts, subType - 1)
			end
		end

		RPC.equipOff(hero.gid, subTypes)

		local artifact = hero:getArtifact()

		if artifact then
			RPC.artifactOff(hero.gid, artifact.gid)
		end

		local relic = hero:getRelic()

		if relic then
			RPC.relicOff(hero.gid)
		end
	else
		local artifact = hero:getArtifact()
		local relic = hero:getRelic()
		local isEquipOff = false

		if artifact then
			RPC.artifactOff(hero.gid, artifact.gid)

			isEquipOff = true
		end

		if relic then
			RPC.relicOff(hero.gid)

			isEquipOff = true
		end

		if not isEquipOff then
			MsgManager.clientNotice(267)
		end
	end
end

function HeroMixin:tryShowConfirmEquipPri()
	local isLocked = ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_RECYCLESHOP)

	if not isLocked and not self:isActPrivilegeValid(Const.ACT_PRIVILEGE_TYPE_EQUIP_COST_OFF) then
		UIManager.showConfirmSepcForPrivilege(Const.EQUIP_OFF_PRIVILEGE_ID, CurAvatar.slotJumpToRecycleShop)
	end
end

function HeroMixin:checkGrowRecommendClose()
	local totalMaxLvHeroCount = 0

	for i, info in ipairs(CurAvatar.crystalData.priests) do
		local hero = CurAvatar.heroDic[info.hero]

		if hero and hero.quality >= 4 and hero.level >= hero:getMaxLv() then
			totalMaxLvHeroCount = totalMaxLvHeroCount + 1
		end
	end

	return totalMaxLvHeroCount == 5
end

function HeroMixin:checkCanStarUpInTeamHeros()
	self.canStarUpInTeamHerosDic = {}
	self.canStarUpInTeamHerosList = {}

	RedDotManager.setKeyState(UIConst.RD_HINT_HERO_STAR_UP, #self.canStarUpInTeamHerosList > 0)
end

function HeroMixin:checkHaveNewFiveHero()
	self.fiveUpStarNewHeroDic = {}
	self.fiveUpStarNewHeroList = {}
	self.fiveUpStarHeroDic = {}
	self.fiveUpStarHeroIdDic = {}
	self.upedHeroDic = {}

	for gid, hero in pairs(self.heroDic) do
		if hero.level > 1 then
			self.upedHeroDic[hero.id] = true
		end
	end

	if #self.fiveUpStarHeroGidList < 3 then
		for _, gid in ipairs(self.fiveUpStarHeroGidList) do
			local hero = self.heroDic[gid]

			if hero and hero.star >= 5 then
				if hero.level == 1 and not self.upedHeroDic[hero.id] then
					table.insert(self.fiveUpStarNewHeroList, hero)

					self.fiveUpStarNewHeroDic[gid] = hero
				end

				if not self.fiveUpStarHeroIdDic[hero.id] then
					self.fiveUpStarHeroIdDic[hero.id] = hero
					self.fiveUpStarHeroDic[gid] = hero
				else
					local oldHero = self.fiveUpStarHeroIdDic[hero.id]

					if hero.level > oldHero.level then
						self.fiveUpStarHeroDic[oldHero.gid] = nil
						self.fiveUpStarHeroIdDic[hero.id] = hero
						self.fiveUpStarHeroDic[gid] = hero
					end
				end
			end
		end
	end

	RedDotManager.setKeyState(UIConst.RD_HINT_HERO_NEW_FIVE, #self.fiveUpStarNewHeroList > 0)
end

function HeroMixin:checkHeroCanStarUp(hero)
	local sameStarCount = 0
	local campStarCount = 0
	local anyStarCount = 0

	if hero.star >= hero:getMaxStar() then
		return false
	end

	local starCostInfo = ResStarCost[hero.resData.star_up_id][hero.star + 1]

	if not starCostInfo then
		return false
	end

	for _, _hero in pairs(self.heroDic) do
		local continue = _hero.gid == hero.gid or _hero.inTeam == 1

		if continue == false and starCostInfo.same_num - sameStarCount > 0 and _hero.id == hero.id and _hero.star == starCostInfo.same_star then
			sameStarCount = sameStarCount + 1
			continue = true
		end

		if continue == false and starCostInfo.camp_num - campStarCount > 0 and _hero.camp == hero.camp and _hero.star == starCostInfo.camp_star then
			campStarCount = campStarCount + 1
			continue = true
		end

		if continue == false and starCostInfo.any_num - anyStarCount > 0 and _hero.star == starCostInfo.any_star then
			anyStarCount = anyStarCount + 1
		end
	end

	return sameStarCount == starCostInfo.same_num and campStarCount == starCostInfo.camp_num and anyStarCount == starCostInfo.any_num
end

function HeroMixin:getHeroStarUpNeedGids(hero, ignoreLastDefend)
	local sameStarList = {}
	local campStarList = {}
	local anyStarList = {}

	if hero.star >= hero:getMaxStar() then
		return sameStarList, campStarList, anyStarList
	end

	local starCostInfo = ResStarCost[hero.resData.star_up_id][hero.star + 1]

	if not starCostInfo then
		return sameStarList, campStarList, anyStarList
	end

	for _, _hero in pairs(self.heroDic) do
		local continue = _hero.gid == hero.gid

		if continue == false and ignoreLastDefend then
			-- block empty
		end

		if continue == false and starCostInfo.same_num - #sameStarList > 0 and _hero.id == hero.id and _hero.star == starCostInfo.same_star then
			table.insert(sameStarList, _hero.gid)

			continue = true
		end

		if continue == false and starCostInfo.camp_num - #campStarList > 0 and _hero.camp == hero.camp and _hero.star == starCostInfo.camp_star and _hero.banStarMaterial == 0 then
			table.insert(campStarList, _hero.gid)

			continue = true
		end

		if continue == false and starCostInfo.any_num - #anyStarList > 0 and _hero.star == starCostInfo.any_star then
			table.insert(anyStarList, _hero.gid)
		end
	end

	return sameStarList, campStarList, anyStarList
end

function HeroMixin:isStarUpNeed(hero, materialHero)
	if hero.star >= hero:getMaxStar() then
		return nil
	end

	local passTypes
	local starCostInfo = ResStarCost[hero.resData.star_up_id][hero.star + 1]

	if starCostInfo.same_num and starCostInfo.same_num > 0 and hero.id == materialHero.id and materialHero.star == starCostInfo.same_star then
		passTypes = passTypes or {}
		passTypes[Const.HERO_STARUP_MATERIAL_TYPE.SAME_ID] = 1
	end

	if starCostInfo.camp_num and starCostInfo.camp_num > 0 and hero.camp == materialHero.camp and materialHero.star == starCostInfo.camp_star then
		passTypes = passTypes or {}
		passTypes[Const.HERO_STARUP_MATERIAL_TYPE.SAME_CAMP] = 1
	end

	if starCostInfo.any_num and starCostInfo.any_num > 0 and materialHero.star == starCostInfo.any_star then
		passTypes = passTypes or {}
		passTypes[Const.HERO_STARUP_MATERIAL_TYPE.ANY_ID] = 1
	end

	return passTypes
end

local function sortForFastStarUp(a, b)
	if a.level ~= b.level then
		return a.level < b.level
	elseif a.lock ~= b.lock then
		return a.lock < b.lock
	elseif a.quality ~= b.quality then
		return a.quality < b.quality
	elseif a.inCry ~= b.inCry then
		return a.inCry < b.inCry
	elseif a.id ~= b.id then
		return a.id < b.id
	end
end

function HeroMixin:getFastStarUpHeroList(onlyForHint)
	local fastStarUpList = {}
	local tempList = {}
	local continueDic = {}
	local mDict = {}

	for starUpId, costList in pairs(ResStarCost) do
		if not mDict[starUpId] then
			mDict[starUpId] = 0
		end

		for star, costInfo in pairs(costList) do
			if costInfo.same_num > 0 and costInfo.same_star > mDict[starUpId] then
				mDict[starUpId] = costInfo.same_star
			end
		end
	end

	local xDict = {}
	local singleStarUpLimitIdDic = {}
	local singleStarUpLimitStar = 5
	local hadIdStarDic = {}

	for _, hero in pairs(self.heroDic) do
		if not hadIdStarDic[hero.id] then
			hadIdStarDic[hero.id] = {}
		end

		if not hadIdStarDic[hero.id][hero.star] then
			hadIdStarDic[hero.id][hero.star] = 0
		end

		hadIdStarDic[hero.id][hero.star] = hadIdStarDic[hero.id][hero.star] + 1

		if hero.star < hero:getMaxStar() then
			if not xDict[hero.id] then
				xDict[hero.id] = 0
			end

			if hero.star > xDict[hero.id] then
				xDict[hero.id] = hero.star
			end

			table.insert(tempList, hero)
		end
	end

	table.sort(tempList, sortForFastStarUp)

	for i = #tempList, 1, -1 do
		local hero = tempList[i]

		if not singleStarUpLimitIdDic[hero.id] and singleStarUpLimitStar < hero.star then
			singleStarUpLimitIdDic[hero.id] = hero
		elseif singleStarUpLimitIdDic[hero.id] and hero.star > singleStarUpLimitIdDic[hero.id].star then
			singleStarUpLimitIdDic[hero.id] = hero
		end
	end

	for i = #tempList, 1, -1 do
		local hero = tempList[i]
		local continue = continueDic[hero.gid] ~= nil and true or false
		local starCostInfo = ResStarCost[hero.resData.star_up_id][hero.star + 1]

		if not starCostInfo then
			continue = true
		end

		if singleStarUpLimitIdDic[hero.id] and singleStarUpLimitStar < hero.star then
			continue = (hero.star ~= 7 or not hadIdStarDic[hero.id][9] or hadIdStarDic[hero.id][8] or false) and singleStarUpLimitIdDic[hero.id].gid ~= hero.gid
		end

		if not continue and starCostInfo.same_num and starCostInfo.same_num > 0 and (not starCostInfo.camp_num or starCostInfo.camp_num == 0) and (not starCostInfo.any_num or starCostInfo.any_num == 0) and CurAvatar:checkCanStarUp(hero, mDict, xDict) then
			local materials = {}

			for idx, materialHero in ipairs(tempList) do
				if #materials == starCostInfo.same_num then
					break
				end

				if materialHero.id == hero.id and materialHero.star == starCostInfo.same_star and hero.gid ~= materialHero.gid and not continueDic[materialHero.gid] and materialHero.lock == 0 then
					local asyncCount = utils.getTableElemCount(self.asyncPVPDefendFormation)
					local preAsyncCount = 0

					for _, preHero in ipairs(materials) do
						if self.asyncPVPDefendFormation[preHero.gid] then
							preAsyncCount = preAsyncCount + 1
						end
					end

					if preAsyncCount ~= asyncCount - 1 or not self.asyncPVPDefendFormation[materialHero.gid] then
						table.insert(materials, materialHero)
					end
				end
			end

			if #materials == starCostInfo.same_num then
				continueDic[hero.gid] = true

				for _, materialHero in ipairs(materials) do
					continueDic[materialHero.gid] = true
				end

				local fastStarUpCell = {}

				fastStarUpCell.hero = hero
				fastStarUpCell.materials = materials

				table.insert(fastStarUpList, fastStarUpCell)

				if onlyForHint then
					return fastStarUpList
				end
			end
		end
	end

	return fastStarUpList
end

function HeroMixin:getStarUpLimitParm()
	local mDict = {}
	local nDict = {}

	for starUpId, costList in pairs(ResStarCost) do
		if not mDict[starUpId] then
			mDict[starUpId] = 0
		end

		if not nDict[starUpId] then
			nDict[starUpId] = 0
		end

		for star, costInfo in pairs(costList) do
			if costInfo.same_num > 0 and costInfo.same_star > mDict[starUpId] then
				mDict[starUpId] = costInfo.same_star
			end

			if costInfo.camp_num > 0 and costInfo.camp_star > nDict[starUpId] then
				nDict[starUpId] = costInfo.camp_star
			end
		end
	end

	local xDict = {}

	for _, hero in pairs(self.heroDic) do
		if not xDict[hero.id] then
			xDict[hero.id] = 0
		end

		if hero.star > xDict[hero.id] and hero.star < hero:getMaxStar() then
			xDict[hero.id] = hero.star
		end
	end

	return mDict, nDict, xDict
end

function HeroMixin:checkCanStarUp(hero, mDic, xDic)
	local m = mDic[hero.resData.star_up_id]
	local x = xDic[hero.id]

	if m < x and x > hero.star and m <= hero.star then
		return false
	else
		return true
	end
end

function HeroMixin:isHaveUpSomeOneStar(star, heroId)
	for _, hero in pairs(self.heroDic) do
		if (not heroId or heroId and hero.id == heroId) and star <= hero.star then
			return true
		end
	end

	return false
end

local function _sortIntelList(a, b)
	if a.inCry ~= b.inCry then
		return a.inCry > b.inCry
	elseif a.level ~= b.level then
		return a.level > b.level
	end
end

local function _sortMatrixList(a, b)
	local priorityA = a[2]
	local priorityB = b[2]
	local heroA = a[1]
	local heroB = b[1]

	if priorityA ~= priorityB then
		return priorityB < priorityA
	else
		return heroA.id < heroB.id
	end
end

local function _sortIntelMaterialList(a, b)
	local priorityA = a[2]
	local priorityB = b[2]
	local heroA = a[1]
	local heroB = b[1]

	if priorityA ~= priorityB then
		return priorityA < priorityB
	else
		return heroA.id > heroB.id
	end
end

local function _sortIntelStarUpList(a, b)
	local heroA = a.hero
	local heroB = b.hero

	if heroA.camp ~= heroB.camp then
		return heroA.camp > heroB.camp
	elseif heroA.starUpPriority ~= heroB.starUpPriority then
		return heroA.starUpPriority > heroB.starUpPriority
	else
		return heroA.id < heroB.id
	end
end

function HeroMixin:getIntelStarUpHeroList()
	local intelStarUpList = {}
	local intelList = {}
	local intelHeroIdListDic = {}
	local hadIdStarDic = {}
	local hadBigStarIdDic = {}

	for _, hero in pairs(self.heroDic) do
		if hero.star == 4 and hero.star < hero:getMaxStar() and hero.camp ~= Const.CAMP_TYPE.NINE_NIGHT and hero.camp ~= Const.CAMP_TYPE.SLIM_SNOW then
			table.insert(intelList, hero)

			if not intelHeroIdListDic[hero.id] then
				intelHeroIdListDic[hero.id] = {}
			end

			table.insert(intelHeroIdListDic[hero.id], hero)
		end

		if not hadIdStarDic[hero.id] then
			hadIdStarDic[hero.id] = {}
		end

		if not hadIdStarDic[hero.id][hero.star] then
			hadIdStarDic[hero.id][hero.star] = 0
		end

		hadIdStarDic[hero.id][hero.star] = hadIdStarDic[hero.id][hero.star] + 1

		if hero.star >= 6 then
			hadBigStarIdDic[hero.id] = true
		end
	end

	table.sort(intelList, _sortIntelList)

	local matrixList = {}
	local matrixDic = {}
	local matrixNoGroupNum = {}
	local cryFllowDic = {}

	for _, hero in ipairs(intelList) do
		if not matrixNoGroupNum[hero.id] then
			matrixNoGroupNum[hero.id] = 0
		end

		local intelHeroIdList = intelHeroIdListDic[hero.id]

		if hero.inCry == 1 and intelHeroIdList and #intelHeroIdList >= 1 then
			matrixNoGroupNum[hero.id] = matrixNoGroupNum[hero.id] + 1

			table.insert(matrixList, {
				hero,
				hero.starUpPriority + 100000
			})

			matrixDic[hero.gid] = true

			for i = #intelHeroIdList, 1, -1 do
				if intelHeroIdList[i].gid == hero.gid then
					table.remove(intelHeroIdList, i)

					break
				end
			end

			if intelHeroIdList and #intelHeroIdList >= 1 then
				for i = #intelHeroIdList, 1, -1 do
					local fllowHero = intelHeroIdList[i]

					if fllowHero.inCry == 0 then
						table.insert(matrixList, {
							fllowHero,
							fllowHero.starUpPriority + 50000
						})

						cryFllowDic[fllowHero.gid] = true
						matrixNoGroupNum[hero.id] = matrixNoGroupNum[hero.id] + 1
						matrixDic[fllowHero.gid] = true

						table.remove(intelHeroIdList, i)

						break
					end
				end
			end
		elseif hadIdStarDic[hero.id] and hadIdStarDic[hero.id][5] and intelHeroIdList and #intelHeroIdList >= 1 then
			matrixNoGroupNum[hero.id] = matrixNoGroupNum[hero.id] + 1

			table.insert(matrixList, {
				intelHeroIdList[1],
				intelHeroIdList[1].starUpPriority + 10000
			})

			matrixDic[intelHeroIdList[1].gid] = true

			table.remove(intelHeroIdList, 1)

			hadIdStarDic[hero.id][5] = hadIdStarDic[hero.id][5] - 1

			if hadIdStarDic[hero.id][5] == 0 then
				hadIdStarDic[hero.id][5] = nil
			end
		elseif (hadIdStarDic[hero.id] and hadIdStarDic[hero.id][6] or hadIdStarDic[hero.id] and hadIdStarDic[hero.id][7]) and intelHeroIdList and #intelHeroIdList >= 2 then
			for idx = 1, 2 do
				table.insert(matrixList, {
					intelHeroIdList[1],
					intelHeroIdList[1].starUpPriority + 1000
				})

				matrixDic[intelHeroIdList[1].gid] = true

				table.remove(intelHeroIdList, 1)
			end

			for star = 6, 7 do
				if hadIdStarDic[hero.id][star] then
					hadIdStarDic[hero.id][star] = hadIdStarDic[hero.id][star] - 1

					if hadIdStarDic[hero.id][star] == 0 then
						hadIdStarDic[hero.id][star] = nil
					end

					break
				end
			end
		elseif intelHeroIdList and #intelHeroIdList >= 2 then
			for idx = 1, 2 do
				table.insert(matrixList, {
					intelHeroIdList[1],
					intelHeroIdList[1].starUpPriority
				})

				matrixDic[intelHeroIdList[1].gid] = true

				table.remove(intelHeroIdList, 1)
			end
		end
	end

	if #matrixList > 0 then
		table.sort(matrixList, _sortMatrixList)

		local materialList = {}

		for _, hero in ipairs(intelList) do
			local priorityPlus = 0

			if hero.inCry == 1 then
				priorityPlus = priorityPlus + 100000
			end

			if cryFllowDic[hero.gid] then
				priorityPlus = priorityPlus + 50000
			end

			if matrixDic[hero.gid] then
				priorityPlus = priorityPlus + 10000
			end

			if hadBigStarIdDic[hero.id] then
				priorityPlus = priorityPlus + 1000
			end

			table.insert(materialList, {
				hero,
				hero.starUpPriority + priorityPlus
			})
		end

		table.sort(materialList, _sortIntelMaterialList)

		local continueDic = {}
		local matrixIdNumDic = {}

		for _, matrixInfo in ipairs(matrixList) do
			local matrixHero = matrixInfo[1]
			local continue = continueDic[matrixHero.gid] ~= nil
			local starCostInfo = ResStarCost[matrixHero.resData.star_up_id][matrixHero.star + 1]

			if not continue and starCostInfo then
				local materials = {}

				for _, materialInfo in ipairs(materialList) do
					local materialHero = materialInfo[1]

					if #materials == starCostInfo.camp_num then
						break
					end

					if materialHero.camp == matrixHero.camp and materialHero.star == starCostInfo.camp_star and matrixHero.gid ~= materialHero.gid and not continueDic[materialHero.gid] and materialHero.lock == 0 then
						local asyncCount = utils.getTableElemCount(self.asyncPVPDefendFormation)
						local preAsyncCount = 0

						for _, preHero in ipairs(materials) do
							if self.asyncPVPDefendFormation[preHero.gid] then
								preAsyncCount = preAsyncCount + 1
							end
						end

						if preAsyncCount ~= asyncCount - 1 or not self.asyncPVPDefendFormation[materialHero.gid] then
							table.insert(materials, materialHero)
						end
					end
				end

				if #materials == starCostInfo.camp_num then
					continueDic[matrixHero.gid] = true

					if not matrixIdNumDic[matrixHero.id] then
						matrixIdNumDic[matrixHero.id] = 0
					end

					matrixIdNumDic[matrixHero.id] = matrixIdNumDic[matrixHero.id] + 1

					for _, materialHero in ipairs(materials) do
						continueDic[materialHero.gid] = true
					end

					local intelStarUpCell = {}

					intelStarUpCell.hero = matrixHero
					intelStarUpCell.materials = materials

					table.insert(intelStarUpList, intelStarUpCell)
				end
			end
		end

		local needFixMatrixIdDic = {}

		for heroId, num in pairs(matrixIdNumDic) do
			if num - matrixNoGroupNum[heroId] > 0 and (num - matrixNoGroupNum[heroId]) % 2 ~= 0 then
				needFixMatrixIdDic[heroId] = true
			end
		end

		for idx = #intelStarUpList, 1, -1 do
			if needFixMatrixIdDic[intelStarUpList[idx].hero.id] then
				needFixMatrixIdDic[intelStarUpList[idx].hero.id] = nil

				table.remove(intelStarUpList, idx)
			end
		end

		table.sort(intelStarUpList, _sortIntelStarUpList)

		return intelStarUpList
	else
		return intelStarUpList
	end
end

function HeroMixin:fixIntelStarUpHero(matrixIdNumDic, matrixHero, matrixNoGroupNum, intelStarUpList, continueDic)
	local needFixMatrixIdDic = false

	if matrixIdNumDic and matrixIdNumDic[matrixHero.id] then
		local num = matrixIdNumDic[matrixHero.id]

		if num - matrixNoGroupNum[matrixHero.id] > 0 and (num - matrixNoGroupNum[matrixHero.id]) % 2 ~= 0 then
			matrixIdNumDic[matrixHero.id] = matrixIdNumDic[matrixHero.id] - 1
			needFixMatrixIdDic = true
		end
	end

	if needFixMatrixIdDic then
		for idx = #intelStarUpList, 1, -1 do
			if intelStarUpList[idx].hero.id == matrixHero.id then
				continueDic[intelStarUpList[idx].hero.gid] = nil

				for _, materialHero in ipairs(intelStarUpList[idx].materials) do
					continueDic[materialHero.gid] = nil
				end

				table.remove(intelStarUpList, idx)

				break
			end
		end
	end
end

local function _sortMatrixForSuperIntelStarUp(heroA, heroB)
	if heroA.starUpPriority ~= heroB.starUpPriority then
		return heroA.starUpPriority > heroB.starUpPriority
	elseif heroA.level ~= heroB.level then
		return heroA.level > heroB.level
	else
		return heroA.id < heroB.id
	end
end

function HeroMixin:getSuperIntelStarUpHeroList()
	local intelStarUpList = {}
	local starQualityCampHeroDic = {}

	for _, hero in pairs(self.heroDic) do
		if not hero:isLightOrDark() then
			if not starQualityCampHeroDic[hero.star] then
				starQualityCampHeroDic[hero.star] = {}
			end

			if not starQualityCampHeroDic[hero.star][hero.quality] then
				starQualityCampHeroDic[hero.star][hero.quality] = {}
			end

			if not starQualityCampHeroDic[hero.star][hero.quality] then
				starQualityCampHeroDic[hero.star][hero.quality] = {}
			end

			if not starQualityCampHeroDic[hero.star][hero.quality][hero.camp] then
				starQualityCampHeroDic[hero.star][hero.quality][hero.camp] = {}
			end

			table.insert(starQualityCampHeroDic[hero.star][hero.quality][hero.camp], hero)
		end
	end

	for camp = 1, 3 do
		local matrixHeroList = {}
		local matrixHeroDic = {}
		local unlockMaterialHeroList = {}

		if starQualityCampHeroDic[6] and starQualityCampHeroDic[6][3] and starQualityCampHeroDic[6][3][camp] then
			for _, hero in ipairs(starQualityCampHeroDic[6][3][camp]) do
				if hero.lock == 0 then
					table.insert(unlockMaterialHeroList, hero)
				end
			end
		end

		if starQualityCampHeroDic[8] and starQualityCampHeroDic[8][4] and starQualityCampHeroDic[8][4][camp] and (not starQualityCampHeroDic[8][3] or not starQualityCampHeroDic[8][3][camp]) and (not starQualityCampHeroDic[7] or not starQualityCampHeroDic[7][3] or not starQualityCampHeroDic[7][3][camp]) and #unlockMaterialHeroList >= 4 then
			local idHeroListDic = {}

			for _, hero in ipairs(unlockMaterialHeroList) do
				if not idHeroListDic[hero.id] then
					idHeroListDic[hero.id] = {}
				end

				table.insert(idHeroListDic[hero.id], hero)

				if #idHeroListDic[hero.id] == 2 then
					table.insert(matrixHeroList, idHeroListDic[hero.id][1])
					table.insert(matrixHeroList, hero)
				elseif #idHeroListDic[hero.id] > 2 then
					table.insert(matrixHeroList, hero)
				end
			end
		end

		if #matrixHeroList > 0 then
			table.sort(matrixHeroList, _sortMatrixForSuperIntelStarUp)

			local intelStarUpCell = {}

			intelStarUpCell.hero = matrixHeroList[1]

			local materialList = unlockMaterialHeroList

			table.sort(materialList, _sortMatrixForSuperIntelStarUp)

			intelStarUpCell.materials = {}

			local beMaterialDic = {}

			for i = #materialList, 1, -1 do
				local tempHero = materialList[i]

				if tempHero.gid ~= intelStarUpCell.hero.gid and tempHero.id ~= intelStarUpCell.hero.id then
					self:addToListIfNotAsyncLastOne(intelStarUpCell.materials, tempHero, beMaterialDic)

					if #intelStarUpCell.materials >= 2 then
						break
					end
				end
			end

			if #intelStarUpCell.materials < 2 then
				for i = #materialList, 1, -1 do
					local tempHero = materialList[i]

					if tempHero.gid ~= intelStarUpCell.hero.gid and not beMaterialDic[tempHero.gid] then
						self:addToListIfNotAsyncLastOne(intelStarUpCell.materials, tempHero, beMaterialDic)

						if #intelStarUpCell.materials >= 2 then
							break
						end
					end
				end
			end

			if #intelStarUpCell.materials >= 2 then
				table.insert(intelStarUpList, intelStarUpCell)
			end
		end
	end

	return intelStarUpList
end

function HeroMixin:addToListIfNotAsyncLastOne(heroList, hero, beMaterialDic)
	local asyncCount = utils.getTableElemCount(self.asyncPVPDefendFormation)
	local preAsyncCount = 0

	for _, preHero in ipairs(heroList) do
		if self.asyncPVPDefendFormation[preHero.gid] then
			preAsyncCount = preAsyncCount + 1
		end
	end

	if preAsyncCount ~= asyncCount - 1 or not self.asyncPVPDefendFormation[hero.gid] then
		table.insert(heroList, hero)

		if beMaterialDic then
			beMaterialDic[hero.gid] = hero
		end
	end
end

local function sortPower(powerA, powerB)
	return powerB < powerA
end

local function _sortNoLowQualityHeroList(heroInfoA, heroInfoB)
	local heroA = heroInfoA[1]
	local lvSecScoreA = heroInfoA[2]
	local careerScoreA = heroInfoA[3]
	local heroB = heroInfoB[1]
	local lvSecScoreB = heroInfoB[2]
	local careerScoreB = heroInfoB[3]

	if lvSecScoreA ~= lvSecScoreB then
		return lvSecScoreB < lvSecScoreA
	elseif heroA.quality ~= heroB.quality then
		return heroA.quality > heroB.quality
	elseif careerScoreA ~= careerScoreB then
		return careerScoreB < careerScoreA
	elseif heroA.star ~= heroB.star then
		return heroA.star > heroB.star
	elseif heroA.level ~= heroB.level then
		return heroA.level > heroB.level
	end
end

function HeroMixin:getBeginnerHintLvUpHero(useWillGetAward)
	local noLowQualityHeroList = {}
	local lvSectionScoreList = {
		{
			1,
			40,
			100
		},
		{
			41,
			60,
			90
		},
		{
			61,
			80,
			80
		},
		{
			81,
			100,
			70
		},
		{
			100,
			nil,
			60
		}
	}
	local formationHeros = self:getFormationHeros()

	for _, hero in pairs(formationHeros) do
		if hero.quality >= 3 and not hero:isCrystalSlot() then
			local lvSectionScore = 0

			for _, scoreInfo in ipairs(lvSectionScoreList) do
				local minLv = scoreInfo[1]
				local maxLv = scoreInfo[2]
				local lvSecScore = scoreInfo[3]

				if maxLv and minLv <= hero.level and maxLv >= hero.level then
					lvSectionScore = lvSecScore
				elseif not maxLv then
					lvSectionScore = lvSecScore
				end
			end

			local careerScore = 0

			careerScore = hero.career == Const.CAREER_TYPE.SUPPORT and 0 or hero.isFront and 100 or 50

			table.insert(noLowQualityHeroList, {
				hero,
				lvSectionScore,
				careerScore
			})
		end
	end

	table.sort(noLowQualityHeroList, _sortNoLowQualityHeroList)

	for _, heroInfo in ipairs(noLowQualityHeroList) do
		local hero = heroInfo[1]
		local needMaterialDic = {}

		for addLv = 0, 2 do
			local levelCostInfo = ResLevelCost[hero.quality][hero.level + addLv]

			if not needMaterialDic[Const.MONEY_ID_GOLD] then
				needMaterialDic[Const.MONEY_ID_GOLD] = 0
			end

			needMaterialDic[Const.MONEY_ID_GOLD] = needMaterialDic[Const.MONEY_ID_GOLD] + levelCostInfo.gold

			if levelCostInfo.res_id[1] then
				if not needMaterialDic[levelCostInfo.res_id[1]] then
					needMaterialDic[levelCostInfo.res_id[1]] = 0
				end

				needMaterialDic[levelCostInfo.res_id[1]] = needMaterialDic[levelCostInfo.res_id[1]] + levelCostInfo.res_num[1]
			end

			if levelCostInfo.res_id[2] then
				if not needMaterialDic[levelCostInfo.res_id[2]] then
					needMaterialDic[levelCostInfo.res_id[2]] = 0
				end

				needMaterialDic[levelCostInfo.res_id[2]] = needMaterialDic[levelCostInfo.res_id[2]] + levelCostInfo.res_num[2]
			end
		end

		local canLvUp3 = true

		for itemId, needNum in pairs(needMaterialDic) do
			local hadMaterialNum = 0

			if useWillGetAward then
				local mainStageAwards = CurAvatar:getMainStageHookAward()

				hadMaterialNum = ClientUtils.getMoney(itemId)

				for awardId, awardNum in pairs(mainStageAwards.base) do
					if itemId == awardId then
						hadMaterialNum = hadMaterialNum + awardNum
					end
				end
			else
				hadMaterialNum = ClientUtils.getMoney(itemId)
			end

			if hadMaterialNum < needNum then
				canLvUp3 = false

				break
			end
		end

		if canLvUp3 then
			return hero
		end
	end
end

local function _sortRecommendFormationHero(a, b)
	if a.previewStar ~= b.previewStar then
		return a.previewStar > b.previewStar
	elseif a.career ~= b.career then
		return a.career < b.career
	elseif a.quality ~= b.quality then
		return a.quality > b.quality
	elseif a.isCryPriests ~= b.isCryPriests then
		return a.isCryPriests > b.isCryPriests
	elseif a.isCrySlot ~= b.isCrySlot then
		return a.isCrySlot > b.isCrySlot
	else
		return a.id < b.id
	end
end

local function _sortHeroForSetRecGrid(a, b)
	if a.previewStar ~= b.previewStar then
		return a.previewStar > b.previewStar
	elseif a.quality ~= b.quality then
		return a.quality > b.quality
	elseif a.isCryPriests ~= b.isCryPriests then
		return a.isCryPriests > b.isCryPriests
	elseif a.isCrySlot ~= b.isCrySlot then
		return a.isCrySlot > b.isCrySlot
	else
		return a.id < b.id
	end
end

function HeroMixin:getRecommendFormationDic(priestsDic)
	local recommendHeroList = {}
	local recommendHeroDic = {}
	local previewStarDic = {}
	local starUpIsLocked = ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_HERO_STARUP)

	if not starUpIsLocked then
		local fastStarUpList = self:getFastStarUpHeroList()
		local intelStarUpList = self:getIntelStarUpHeroList()

		for _, starUpInfo in ipairs(fastStarUpList) do
			local hero = starUpInfo.hero

			previewStarDic[hero.gid] = hero.star + 1
		end

		for _, starUpInfo in ipairs(intelStarUpList) do
			local hero = starUpInfo.hero

			previewStarDic[hero.gid] = hero.star + 1
		end
	end

	local totalHeroList = {}
	local starHeroListDic = {}

	for gid, hero in pairs(self.heroDic) do
		hero.previewStar = previewStarDic[hero.gid] or hero.star

		table.insert(totalHeroList, hero)
	end

	table.sort(totalHeroList, _sortRecommendFormationHero)

	local starHeroListDicList = {}

	for _, hero in ipairs(totalHeroList) do
		if not starHeroListDic[hero.previewStar] then
			starHeroListDic[hero.previewStar] = {}

			table.insert(starHeroListDicList, starHeroListDic[hero.previewStar])
		end

		table.insert(starHeroListDic[hero.previewStar], hero)
	end

	local recommendHeroCareer = {}
	local recommendHeroPos = {}

	recommendHeroPos[1] = 0
	recommendHeroPos[2] = 0

	local recommendListMax
	local recedHeroDic = {}

	for _, starHeroListDic in ipairs(starHeroListDicList) do
		if recommendListMax then
			break
		end

		for _, hero in ipairs(starHeroListDic) do
			if recommendListMax then
				break
			end

			local isFront = hero.career == Const.CAREER_TYPE.TANK or hero.career == Const.CAREER_TYPE.WORRIOR
			local isFrontIdx = isFront and 1 or 2

			if recommendHeroPos[isFrontIdx] < 3 and not recommendHeroCareer[hero.career] and not recedHeroDic[hero.id] then
				table.insert(recommendHeroList, hero)

				recedHeroDic[hero.id] = true
				recommendListMax = #recommendHeroList == 5
				recommendHeroCareer[hero.career] = true
				recommendHeroPos[isFrontIdx] = recommendHeroPos[isFrontIdx] + 1
			end
		end

		for _, hero in ipairs(starHeroListDic) do
			if recommendListMax then
				break
			end

			local isFront = hero.career == Const.CAREER_TYPE.TANK or hero.career == Const.CAREER_TYPE.WORRIOR
			local isFrontIdx = isFront and 1 or 2

			if recommendHeroPos[isFrontIdx] < 3 and not recedHeroDic[hero.id] then
				table.insert(recommendHeroList, hero)

				recedHeroDic[hero.id] = true
				recommendListMax = #recommendHeroList == 5
				recommendHeroPos[isFrontIdx] = recommendHeroPos[isFrontIdx] + 1
			end
		end
	end

	if recommendListMax then
		recommendHeroDic = self:setHeroDicForRecDlg(recommendHeroList, priestsDic)

		return recommendHeroDic
	else
		for _, starHeroListDic in ipairs(starHeroListDicList) do
			if recommendListMax then
				break
			end

			for _, hero in ipairs(starHeroListDic) do
				if recommendListMax then
					break
				end

				if not recedHeroDic[hero.id] then
					table.insert(recommendHeroList, hero)

					recommendListMax = #recommendHeroList == 5
				end
			end
		end

		table.sort(recommendHeroList, _sortHeroForSetRecGrid)

		recommendHeroDic = self:setHeroDicForRecDlg(recommendHeroList, priestsDic)

		return recommendHeroDic
	end
end

local function _sortPriestsForSetRecGrid(a, b)
	if a.star ~= b.star then
		return a.star > b.star
	elseif a.quality ~= b.quality then
		return a.quality > b.quality
	elseif a.isCryPriests ~= b.isCryPriests then
		return a.isCryPriests > b.isCryPriests
	elseif a.isCrySlot ~= b.isCrySlot then
		return a.isCrySlot > b.isCrySlot
	else
		return a.id < b.id
	end
end

function HeroMixin:getPriestsFormationDic()
	local priestsList = {}

	for _, info in ipairs(self.crystalData.priests) do
		table.insert(priestsList, self.heroDic[info.hero])
	end

	table.sort(priestsList, _sortPriestsForSetRecGrid)

	local priestsDic = self:setHeroDicForRecDlg(priestsList)

	return priestsDic
end

local function _sortPriestsForRecLvUp(a, b)
	local heroA = a[1]
	local lvMaxStepA = a[2]
	local canUpToNextStepA = a[3]
	local heroB = b[1]
	local lvMaxStepB = b[2]
	local canUpToNextStepB = b[3]

	if lvMaxStepA ~= lvMaxStepB then
		return lvMaxStepA < lvMaxStepB
	elseif canUpToNextStepA ~= canUpToNextStepB then
		return canUpToNextStepB < canUpToNextStepA
	elseif heroA.level ~= heroB.level then
		return heroA.level > heroB.level
	elseif heroA.career ~= heroB.career then
		return heroA.career < heroB.career
	else
		return heroA.id < heroB.id
	end
end

function HeroMixin:getRecLvUpPriest()
	local priestsList = {}

	for _, info in ipairs(self.crystalData.priests) do
		local hero = self.heroDic[info.hero]
		local canUpToNextStep = 0
		local maxPriestsLv = self:getCrystalPriestsMaxLv(hero.realLevel)

		if hero:getLvMaxStep() < hero:getMaxStep() and math.min(maxPriestsLv, hero:getMaxStarLv()) >= ResStep[hero:getLvMaxStep() + 1].level_limit then
			canUpToNextStep = 1
		end

		table.insert(priestsList, {
			hero,
			hero:getLvMaxStep(),
			canUpToNextStep
		})
	end

	table.sort(priestsList, _sortPriestsForRecLvUp)

	for _, heroStepInfo in ipairs(priestsList) do
		local hero = heroStepInfo[1]
		local lvMaxStep = heroStepInfo[2]
		local canUpToNextStep = heroStepInfo[3]
		local stepInfo = ResStep[lvMaxStep + 1] ~= nil and ResStep[lvMaxStep + 1] or ResStep[lvMaxStep]
		local levelCost = ResLevelCost[hero.quality][hero.level]
		local lackToNextLv = self:getItemNumById(Const.MONEY_ID_GOLD) < levelCost.gold

		for idx, id in ipairs(levelCost.res_id) do
			if self:getItemNumById(id) < levelCost.res_num[idx] then
				lackToNextLv = true

				break
			end
		end

		local maxPriestsLv = self:getCrystalPriestsMaxLv(hero.realLevel)

		if not lackToNextLv and canUpToNextStep == 1 then
			return hero, stepInfo.level_limit
		elseif not lackToNextLv and hero.realLevel < stepInfo.level_limit - 1 and math.min(maxPriestsLv, hero:getMaxStarLv()) >= stepInfo.level_limit - 1 then
			return hero, stepInfo.level_limit - 1
		end
	end
end

function HeroMixin:onHeroPaintItemConvertResp(paint_item)
	local ui = UIManager.tryGetUI("heroPaintingDlg")

	if ui then
		ui:checkRefreshMaterialInfo()
	end

	self:onGetBonusNotice("commonBonusDlg", "onShow", {
		nil,
		{},
		{
			paint_item
		},
		{},
		{},
		{},
		{},
		Lang.get(55862)
	})
end

function HeroMixin:setHeroDicForRecDlg(heroList, templePosDic)
	local heroDicForRecDlg = {}
	local removePos = {}

	if templePosDic then
		local gidPosDic = {}

		for pos, hero in pairs(templePosDic) do
			gidPosDic[hero.gid] = pos
		end

		for i, hero in ipairs(heroList) do
			if gidPosDic[hero.gid] and not heroDicForRecDlg[gidPosDic[hero.gid]] then
				heroDicForRecDlg[gidPosDic[hero.gid]] = hero

				table.insert(removePos, 1, i)
			end
		end

		for _, pos in ipairs(removePos) do
			table.remove(heroList, pos)
		end
	end

	removePos = {}

	for i, hero in ipairs(heroList) do
		if not heroDicForRecDlg[hero.career] then
			heroDicForRecDlg[hero.career] = hero

			table.insert(removePos, 1, i)
		end
	end

	for _, pos in ipairs(removePos) do
		table.remove(heroList, pos)
	end

	for pos = 1, 5 do
		if not heroDicForRecDlg[pos] and heroList[1] then
			heroDicForRecDlg[pos] = heroList[1]

			table.remove(heroList, 1)
		end
	end

	return heroDicForRecDlg
end

local function _sortFirstFilterHeroList(a, b)
	if a.star ~= b.star then
		return a.star > b.star
	elseif a.level ~= b.level then
		return a.level > b.level
	elseif a.inTeam ~= b.inTeam then
		return a.inTeam > b.inTeam
	else
		return a.id < b.id
	end
end

local function _sortCanRevertHeroList(a, b)
	if a.reverReasonSimple ~= b.reverReasonSimple then
		return a.reverReasonSimple < b.reverReasonSimple
	elseif a.star ~= b.star then
		return a.star > b.star
	else
		return a.id < b.id
	end
end

function HeroMixin:getCanRevertStarHeroList()
	local canRevertHeroList = {}
	local alreadyAddHeroDic = {}
	local firstFilterHeroList = {}
	local heroIdNumDic = {}

	for _, hero in pairs(self.heroDic) do
		if hero.quality >= 4 and hero.star > 6 and not hero:isUniqueHero() then
			if not heroIdNumDic[hero.id] then
				heroIdNumDic[hero.id] = 0
			end

			heroIdNumDic[hero.id] = heroIdNumDic[hero.id] + 1

			table.insert(firstFilterHeroList, hero)
		end

		if hero.quality >= 4 and hero.star >= 7 and hero.star <= 9 and not hero:isUniqueHero() then
			hero.reverReasonSimple = 1

			table.insert(canRevertHeroList, hero)

			alreadyAddHeroDic[hero.gid] = true
		end
	end

	table.sort(firstFilterHeroList, _sortFirstFilterHeroList)

	local ignoredMVPHeroDic = {}

	for _, hero in ipairs(firstFilterHeroList) do
		if heroIdNumDic[hero.id] > 1 and ignoredMVPHeroDic[hero.id] then
			if not alreadyAddHeroDic[hero.gid] then
				hero.reverReasonSimple = 0

				table.insert(canRevertHeroList, 1, hero)
			end
		elseif heroIdNumDic[hero.id] > 1 then
			ignoredMVPHeroDic[hero.id] = true
		end
	end

	table.sort(canRevertHeroList, _sortCanRevertHeroList)

	return canRevertHeroList
end

function HeroMixin:getStarRevertMaterial(hero, _canResetStep, includeGrowMaterial)
	local revertInfo

	if ResStarUpRevert[hero.resData.star_up_id] and ResStarUpRevert[hero.resData.star_up_id][hero.star] then
		revertInfo = ResStarUpRevert[hero.resData.star_up_id][hero.star]
	end

	local revertItems = {}

	if revertInfo then
		local resetStepReasonList = self:canResetStep(hero)
		local canResetStep = _canResetStep ~= nil and _canResetStep or #resetStepReasonList == 0
		local revertHero = utils.getRevertedHero(hero, canResetStep)

		table.insert(revertItems, revertHero)

		if revertInfo.return_same_star then
			for i = 1, revertInfo.return_same_num do
				local hero = BaseObject.GetObject(hero.id, revertInfo.return_same_star)

				table.insert(revertItems, hero)
			end
		end

		if revertInfo.return_item_num and revertInfo.return_item_num > 0 then
			local itemId = ResHeroMisc[1].star_return_item[hero.camp]

			if itemId then
				local materialItem = BaseObject.GetObject(itemId, revertInfo.return_item_num)

				table.insert(revertItems, materialItem)
			end
		end

		if includeGrowMaterial then
			local materialIdNumList = {}

			if canResetStep then
				materialIdNumList = utils.getHeroResetReturnMaterialList(hero, Const.HERO_RESET_ALL)
			else
				materialIdNumList = utils.getHeroResetReturnMaterialList(hero, Const.HERO_RESET_LEVEL)
			end

			for _, idNum in ipairs(materialIdNumList) do
				local item = BaseObject.GetObject(idNum.id, idNum.num)

				table.insert(revertItems, item)
			end
		end
	end

	return revertItems
end

function HeroMixin:getFreeStarRevertTick()
	return self.freeStarRevertTick or 0
end

function HeroMixin:getHighestFivePower()
	local powerList = {}

	for _, hero in pairs(self.heroDic) do
		table.insert(powerList, hero:getCapacity())
	end

	table.sort(powerList, sortPower)

	local totalPower = 0

	for i = 1, math.min(5, #powerList) do
		totalPower = totalPower + powerList[i]
	end

	return totalPower
end

local function sortHeroByPower(heroA, heroB)
	return heroA:getCapacity() > heroB:getCapacity()
end

function HeroMixin:getHighestPowerHero()
	local powerHeroList = {}

	for _, hero in pairs(self.heroDic) do
		table.insert(powerHeroList, hero)
	end

	table.sort(powerHeroList, sortHeroByPower)

	return powerHeroList[1]
end

function HeroMixin:onHeroLockResp(hero_gid)
	MsgManager.clientNotice(194)

	self.heroDic[hero_gid]._serverData.lock = 1
	self.heroDic[hero_gid].lock = 1

	self:refreshHeroDetail(hero_gid)
end

function HeroMixin:onHeroUnlockResp(hero_gid)
	MsgManager.clientNotice(195)

	self.heroDic[hero_gid]._serverData.lock = 0
	self.heroDic[hero_gid].lock = 0

	self:refreshHeroDetail(hero_gid)
end

function HeroMixin:isHaveMaxStar(heroId)
	for _, hero in pairs(self.heroDic) do
		if hero.id == heroId and hero.star == hero:getMaxStar() then
			return true
		end
	end

	return false
end

function HeroMixin:canResetStep(hero)
	local reasonList = {}

	if hero.step >= Const.HERO_RESET_CLOSE_STEP then
		table.insert(reasonList, Const.HERO_CANT_RESET_STEP_REASON.CLOSE_STEP)
	end

	local isLocked = ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_HERO_RESET)

	if not isLocked then
		if hero:getResetStepCD() > 0 and ClientUtils.getServerTime() < self:getMostEarlyStepTick() then
			table.insert(reasonList, Const.HERO_CANT_RESET_STEP_REASON.IS_INCD)
		end
	else
		table.insert(reasonList, Const.HERO_CANT_RESET_STEP_REASON.IS_LOCKED)
	end

	return reasonList
end

function HeroMixin:initDrawData(roleDrawData)
	self.roleDrawData = {}

	local freeData = roleDrawData.free

	self.roleDrawData[Const.DrawTypeFree] = {
		totalDrawCount = freeData.count,
		lastDrawTick = freeData.tick
	}

	local standardData = roleDrawData.standard

	self.roleDrawData[Const.DrawTypeStandard] = {
		totalDrawCount = standardData.count,
		lastDrawTick = standardData.tick
	}

	local newbieData = roleDrawData.newbie

	self.roleDrawData[Const.DrawTypeNewbie] = {
		drawCount = math.floor(newbieData.count / 10),
		chooseFlag = newbieData.flag,
		records = self:_handleNewbieDrawRecords(newbieData.record),
		bestIndex = math.floor(newbieData.record_count / 10),
		resetCount = newbieData.reset_count
	}
	self.newbieDrawHasChoosen = newbieData.flag == 1

	local groupData = roleDrawData.camp

	self.roleDrawData[Const.DrawTypeGroup] = {
		totalDrawCount = groupData.count,
		lastUnlockTime = groupData.last_unlock_time
	}

	local lightDarkData = roleDrawData.camp_lightdark

	self.roleDrawData[Const.DrawTypeLightDark] = {
		totalDrawCount = lightDarkData.count,
		lastUnlockTime = lightDarkData.last_unlock_time
	}

	if Const.OPEN_TURN_TABLE then
		local turnTableDrawData = roleDrawData.turntable

		self.roleDrawData[Const.DrawTypeTurnTable] = {
			totalDrawCount = turnTableDrawData.count,
			rareRoundCont = turnTableDrawData.rare_round_count
		}
	end

	if Const.PET_POOL_OPEN then
		local drawSelectData = {}

		for i, v in pairs(roleDrawData.pet.drawed_selects or {}) do
			table.insert(drawSelectData, {
				gashapon_id = v.gashapon_id,
				select_item_id = v.select_item_id
			})
		end

		local drawRecordData = {}

		for i, v in ipairs(roleDrawData.pet.drawed_record or {}) do
			table.insert(drawRecordData, {
				gashapon_id = v.gashapon_id,
				drawed_num = v.drawed_num
			})
		end

		self.roleDrawData[Const.DrawTypePet] = {
			drawSelect = drawSelectData,
			drawRecord = drawRecordData,
			count = roleDrawData.pet.count
		}
	end

	self:_initDrawCardFreeTicket()
	self:_checkDrawCardFreeTicket()
end

function HeroMixin:postInitDrawData()
	self:_initDrawCardItemReddot()
end

function HeroMixin:initCheckHeroMixin()
	self:_initTurnTableDrawItemReddot()
end

function HeroMixin:onDrawDataNotify(draw)
	self:initDrawData(draw)
	self:_refreshDrawMainDlg()
end

function HeroMixin:_handleNewbieDrawRecords(records)
	for i, record in ipairs(records) do
		record.index = i
	end

	return records
end

function HeroMixin:manualDecNewbieCount()
	self.roleDrawData[Const.DrawTypeNewbie].drawCount = self.roleDrawData[Const.DrawTypeNewbie].drawCount + 1
end

function HeroMixin:checkDrawItem(poolId, drawCount, skipNotice)
	local poolInfo = ResDrawFakeRand[poolId]

	if not poolInfo then
		return
	end

	local failCostItem
	local failCostItemNum = 0
	local failMsg = Lang.get(200)
	local needItemId = poolInfo.item_id

	if needItemId ~= nil then
		local totalNeedItemNum = poolInfo.item_num * drawCount
		local curItemNum = self:getItemNumById(needItemId)

		if totalNeedItemNum <= curItemNum then
			return Const.DrawCostTypeItem, needItemId, totalNeedItemNum
		end

		if needItemId ~= Const.MONEY_ID_DRAW_BY_DIAMOND then
			failCostItem = needItemId
			failCostItemNum = totalNeedItemNum
		end
	end

	local needMoneyId = poolInfo.consume_id

	if needMoneyId ~= nil then
		failMsg = Lang.get(1859)

		local totalNeedMoneyNum = poolInfo.consume_num * drawCount

		if drawCount == 10 and poolInfo.ten_consume_num then
			totalNeedMoneyNum = poolInfo.ten_consume_num
		end

		local curMoneyNum = ClientUtils.getMoney(needMoneyId)

		if totalNeedMoneyNum <= curMoneyNum then
			return Const.DrawCostTypeConsume, needMoneyId, totalNeedMoneyNum
		end

		if not failCostItem then
			failCostItem = needMoneyId
			failCostItemNum = totalNeedMoneyNum
		end
	end

	if not skipNotice then
		MsgManager.notice(failMsg)
	end

	return false, failCostItem, failCostItemNum
end

function HeroMixin:drawConfirmShow(poolId, drawCount, func)
	local poolInfo = ResDrawFakeRand[poolId]

	if not poolInfo then
		return
	end

	local needItemId = poolInfo.item_id
	local needMoneyId = poolInfo.consume_id
	local needConfirm = true

	if needItemId ~= nil then
		local totalNeedItemNum = poolInfo.item_num * drawCount
		local curItemNum = self:getItemNumById(needItemId)

		if totalNeedItemNum <= curItemNum then
			needConfirm = false
		end
	end

	if Const.DRAW_CONFIRM_OPEN and needConfirm and needMoneyId and needMoneyId == Const.MONEY_ID_DIAMOND then
		local needItemObj = BaseObject.GetObject(needItemId)
		local itemName = Lang.get(7706)

		if needItemObj then
			itemName = needItemObj.name
		end

		local totalNeedMoneyNum = poolInfo.consume_num * drawCount

		if drawCount == 10 and poolInfo.ten_consume_num then
			totalNeedMoneyNum = poolInfo.ten_consume_num
		end

		local notice = utils.format(Lang.get(111352), totalNeedMoneyNum, drawCount, itemName)

		MsgManager.notice(notice)
	end

	if func then
		func()
	end
end

function HeroMixin:setDrawCache(drawCount, drawNeedItemId, drawNeedItemNum, poolId, group, actId)
	self.lastDrawCount = drawCount
	self.drawNeedItemId = drawNeedItemId
	self.drawNeedItemNum = drawNeedItemNum
	self.drawPoolId = poolId
	self.drawDroup = group
	self.drawOpActId = actId
end

function HeroMixin:_clearDrawCache()
	self.lastDrawCount = nil
	self.drawNeedItemId = nil
	self.drawNeedItemNum = nil
	self.drawPoolId = nil
	self.drawDroup = nil
	self.drawOpActId = nil
end

function HeroMixin:onDrawResp(drawType, items)
	if self.SkipDrawCardOperate then
		return
	end

	if drawType == Const.DrawTypeNewbie then
		local newbieOptDlg = UIManager.getUI("drawNewbieOptDlg", true)

		newbieOptDlg:onNewbieDraw(items)
	elseif drawType == Const.DrawTypeLightDark then
		if not self.lastDrawItems then
			ClientUtils.trySendException(Lang.get(1860))

			return
		end

		self:_receiveDrawLightHeroData(items)

		local drawOptDlg = UIManager.getUI("drawCardOptLightDlg", true)

		drawOptDlg:showDrawCardOperate(drawType, self.lastDrawCount == 1, self.drawDroup)
	elseif drawType == Const.DrawTypeTurnTable then
		local mallUI = UIManager.getUI("mallDlg", nil, false)

		if mallUI then
			mallUI:onTurnTableDrawResp(items)
		end
	elseif drawType == Const.DrawTypePet then
		local petPoolMainDlg = UIManager.tryGetUI("petPoolMainDlg")

		if petPoolMainDlg then
			petPoolMainDlg:onPetDrawResp(items)
		end
	else
		if not self.lastDrawItems or #self.lastDrawItems == 0 then
			ClientUtils.trySendException(Lang.get(1860))

			return
		end

		if drawType == Const.DrawTypeFree then
			self:showDrawResultDlg(drawType, self.lastDrawItems)
		elseif drawType == Const.DrawTypeGroup then
			local drawOptDlg = UIManager.getUI("drawCardOperateDlg", true)

			drawOptDlg:showDrawCardOperate(drawType, #self.lastDrawItems == 1, self.drawDroup)
		else
			local drawOptDlg = UIManager.getUI("drawCardOperateDlg", true)

			drawOptDlg:showDrawCardOperate(drawType, #self.lastDrawItems == 1)
		end
	end

	self:_refreshDrawMainDlg()
end

function HeroMixin:onOpActDrawResp(act_id, item)
	if self.SkipDrawCardOperate then
		return
	end

	local drawPoolClientConfig = ResDrawPoolClient[self.drawPoolId]

	if drawPoolClientConfig and drawPoolClientConfig.check_direct_res == 1 then
		self:_receiveDrawLightHeroData(item)

		local drawOptDlg = UIManager.getUI("drawCardOptUpDlg", true)

		drawOptDlg:showDrawCardOperate(Const.DrawTypeCustom, self.lastDrawCount == 1)
	else
		if not self.lastDrawItems or #self.lastDrawItems == 0 then
			ClientUtils.trySendException(Lang.get(1860))

			return
		end

		local drawOptDlg = UIManager.getUI("drawCardOperateDlg", true)

		drawOptDlg:showDrawCardOperate(Const.DrawTypeCustom, #self.lastDrawItems == 1, nil, 0)
	end
end

function HeroMixin:onOpActDrawNewbieCampDrawResp(act_id, item)
	if self.SkipDrawCardOperate then
		return
	end

	local drawPoolClientConfig = ResDrawPoolClient[self.drawPoolId]

	if drawPoolClientConfig and drawPoolClientConfig.check_direct_res == 1 then
		self:_receiveDrawLightHeroData(item)

		local drawOptDlg = UIManager.getUI("drawCardOptUpDlg", true)

		drawOptDlg:showDrawCardOperate(Const.DrawTypeCustom, self.lastDrawCount == 1)
	else
		self:_receiveDrawLightHeroData(item)

		if not self.lastDrawGroupItems or #self.lastDrawGroupItems == 0 then
			ClientUtils.trySendException(Lang.get(92519))

			return
		end

		local drawOptDlg = UIManager.getUI("drawCardOptLightDlg", true)

		drawOptDlg:showDrawCardOperate(Const.DrawTypeCustom, self.lastDrawCount == 1, Const.DrawNewBieCampLightDark)
	end
end

function HeroMixin:onOpActDrawNewbieUpDrawResp(act_id, career_id, item)
	if self.SkipDrawCardOperate then
		return
	end

	local drawPoolClientConfig = ResDrawPoolClient[self.drawPoolId]

	if drawPoolClientConfig and drawPoolClientConfig.check_direct_res == 1 then
		self:_receiveDrawLightHeroData(item)

		local drawOptDlg = UIManager.getUI("drawCardOptUpDlg", true)

		drawOptDlg:showDrawCardOperate(Const.DrawTypeCustom, self.lastDrawCount == 1)
	else
		if not self.lastDrawItems or #self.lastDrawItems == 0 then
			ClientUtils.trySendException(Lang.get(91263))

			return
		end

		local drawOptDlg = UIManager.getUI("drawCardOperateDlg", true)

		drawOptDlg:showDrawCardOperate(Const.DrawTypeCustom, #self.lastDrawItems == 1, nil, 0)
	end
end

function HeroMixin:onDrawRecordResp(poolId, opId, seq, record, param)
	if not record or #record == 0 then
		return
	end

	if poolId ~= 0 then
		self.poolSeqDict[poolId] = seq
		self.poolRecordDict[poolId] = nil
	elseif opId then
		self.opActSeqDict[opId] = seq
		self.opActRecordDict[opId] = nil
	end

	local actObj = self:getActivityObjByOpId(opId)
	local recordList = {}

	if poolId == Const.DrawTypePet then
		for i, drawRecord in ipairs(record) do
			local timeStamp = drawRecord.time
			local drawItem = drawRecord.item

			table.insert(recordList, {
				drawItem.id,
				timeStamp,
				drawItem.temp_param,
				false
			})
		end
	elseif actObj and actObj.actType == Const.ACT_TYPE_SEASON_DRAW then
		for i, drawRecord in ipairs(record) do
			local timeStamp = drawRecord.time
			local drawItem = drawRecord.item

			table.insert(recordList, {
				drawItem.id,
				timeStamp,
				drawItem.common_param,
				false
			})
		end
	else
		for i, drawRecord in ipairs(record) do
			local timeStamp = drawRecord.time
			local drawItem = drawRecord.item
			local item = BaseObject.GetObject(drawItem.id, drawItem.common_param)

			if item:isHero() then
				table.insert(recordList, {
					item.id,
					timeStamp,
					item.star,
					true
				})
			else
				table.insert(recordList, {
					item.id,
					timeStamp,
					item.quality,
					false
				})
			end
		end
	end

	if #recordList > DrawCardConfig.MAX_RECORD_NUM then
		for i = #recordList, DrawCardConfig.MAX_RECORD_NUM + 1, -1 do
			recordList[i] = nil
		end
	end

	if poolId ~= 0 then
		self.poolRecordDict[poolId] = recordList
	elseif opId then
		self.opActRecordDict[opId] = recordList
	end

	local drawCardMainDlg = UIManager.getUI("drawCardMainDlg", nil, false)

	if drawCardMainDlg and drawCardMainDlg.recordPanel and drawCardMainDlg.recordPanel:getVisible() then
		drawCardMainDlg.recordPanel:setRecordData(recordList)
	end

	if drawCardMainDlg and drawCardMainDlg.poolPage and drawCardMainDlg.poolPage.countNoticePanel then
		drawCardMainDlg.poolPage.countNoticePanel:refreshCountNotice()
	end

	local heroPoolDrawLogDlg = UIManager.tryGetUI("heroPoolDrawLogDlg")

	if heroPoolDrawLogDlg then
		heroPoolDrawLogDlg.recordPanel:setRecordData(recordList)
	end

	local petPoolDrawLogDlg = UIManager.tryGetUI("petPoolDrawLogDlg")

	if petPoolDrawLogDlg then
		petPoolDrawLogDlg:setRecordData(recordList)
	end

	local seasonPlayDrawLogDlg = UIManager.tryGetUI("seasonPlayDrawLogDlg")

	if seasonPlayDrawLogDlg then
		seasonPlayDrawLogDlg:setRecordData(recordList)
	end
end

function HeroMixin:onDrawNewbieResetResp(resetCount)
	self.roleDrawData[Const.DrawTypeNewbie].resetCount = resetCount

	DrawCardUtils.realDrawCard(Const.DrawTypeNewbie, 10)
end

function HeroMixin:_receiveDrawHeroData(attrs, items, heros, equip, artifact)
	self.lastDrawItems = {}

	if self.drawDroup == Const.DrawCampLightDark or self.drawDroup == Const.DrawNewBieCampLightDark then
		for i, v in ipairs(heros) do
			local tempHero = Hero(v)

			if tempHero.star >= 5 then
				table.insert(self.lastDrawItems, tempHero)
			end
		end
	else
		for i, v in ipairs(heros) do
			local tempHero = Hero(v)

			table.insert(self.lastDrawItems, tempHero)
		end
	end

	if self.drawNewbieRetrieve then
		local newbieOptDlg = UIManager.getUI("drawNewbieOptDlg", nil, false)

		if newbieOptDlg then
			newbieOptDlg:setVisible(false)
		end

		self:showDrawResultDlg(Const.DrawTypeNewbie, self.lastDrawItems)

		self.drawNewbieRetrieve = nil
	end
end

function HeroMixin:_receiveDrawLightHeroData(items)
	self.lastDrawGroupItems = {}

	for _, drawItem in ipairs(items) do
		local item = BaseObject.GetObject(drawItem.id, drawItem.common_param)

		table.insert(self.lastDrawGroupItems, item)
	end
end

function HeroMixin:showOpAwards(attrs, items, heros, equip, artifact)
	if items and #items > 0 or equip and #equip > 0 or artifact and #artifact > 0 then
		self:onGetBonusNotice("commonBonusDlg", "onShow", {
			[2] = attrs,
			[3] = items,
			[4] = heros,
			[5] = equip,
			[6] = artifact
		})
	else
		self:_showNoticeBonus(attrs, items, heros, equip, artifact)
	end

	self:_showListAttrHeros(heros)
end

function HeroMixin:_receiveOpDrawAward(attrs, items, heros, equip, artifact)
	if not self.opDrawAwards then
		self.opDrawAwards = {
			attrs,
			items,
			heros,
			equip,
			artifact
		}
	else
		for i, listattr in ipairs({
			attrs,
			items,
			heros,
			equip,
			artifact
		}) do
			if #listattr > 0 then
				for _, attr in ipairs(listattr) do
					table.insert(self.opDrawAwards[i], attr)
				end
			end
		end
	end

	self:checkOpAwardToShow()
end

function HeroMixin:checkOpAwardToShow(...)
	if not self.opDrawAwards then
		return
	end

	self:showOpAwards(self.opDrawAwards[1], self.opDrawAwards[2], self.opDrawAwards[3], self.opDrawAwards[4], self.opDrawAwards[5])

	self.opDrawAwards = nil
end

function HeroMixin:onDrawNewbieResp()
	self.roleDrawData[Const.DrawTypeNewbie].chooseFlag = 1
	self.newbieDrawHasChoosen = true

	self:refreshNewbiePoolReddot()
	self:getNewbieTaskAward(DrawCardConfig.NEWBIE_DRAWCARD_TASKID)

	local drawCardMainDlg = UIManager.getUI("drawCardMainDlg", nil, false)

	if drawCardMainDlg then
		drawCardMainDlg:initPools()
		drawCardMainDlg:selectDefaultPool()
	end
end

function HeroMixin:newDayDrawGroup(todayGroup)
	self:onDrawDayCampNotify(todayGroup)
end

function HeroMixin:onDrawDayCampNotify(todayGroup)
	self.todayDrawGroup = todayGroup

	self:_refreshDrawMainDlg()
end

function HeroMixin:isAllGroupUnlock()
	local typeData = self.roleDrawData[Const.DrawTypeGroup]

	if not typeData then
		return false
	end

	return typeData.lastUnlockTime >= ClientUtils.getServerTimeTodayStart()
end

function HeroMixin:_refreshDrawMainDlg(...)
	local drawCardMainDlg = UIManager.getUI("drawCardMainDlg", nil, false)

	if drawCardMainDlg then
		if drawCardMainDlg and drawCardMainDlg.poolPage and drawCardMainDlg.poolPage.countNoticePanel then
			drawCardMainDlg.poolPage.countNoticePanel:syncRecord()
		end

		drawCardMainDlg:refreshPool()
	end
end

function HeroMixin:showDrawResultDlg(drawType, items)
	local drawCardResultDlg = UIManager.getUI("drawCardResultDlg", true)

	drawCardResultDlg:showDrawCardResult(drawType, items)
	self:_clearDrawCache()
	self:checkVoidHeroStarChanged()
end

function HeroMixin:showDrawLightResutlDlg(skipHero)
	if self.lastDrawItems and #self.lastDrawItems > 0 and not skipHero then
		self:showLimitStarHeroForGetNewDlg(self.lastDrawItems, 1, true)
	elseif (self.drawDroup == Const.DrawCampLightDark or self.drawDroup == Const.DrawNewBieCampLightDark) and self.lastDrawGroupItems and #self.lastDrawGroupItems > 0 then
		local resultDlg = UIManager.getUI("drawCardResultLightDlg", true)

		resultDlg:showDrawCardResult(self.lastDrawGroupItems)
		self:_clearDrawCache()
		self:checkVoidHeroStarChanged()
	end
end

function HeroMixin:showDrawUpResutlDlg(skipHero)
	local heros = self.lastDrawItems
	local heroListDic = {}
	local slimNightId = 0

	for _, hero in ipairs(heros) do
		if hero:isLightOrDark() and hero.resData.ori_star > 4 then
			slimNightId = hero.id

			if not heroListDic[hero.id] then
				heroListDic[hero.id] = {}
			end

			table.insert(heroListDic[hero.id], hero)
		end
	end

	if slimNightId ~= 0 and not skipHero then
		local uiName = "getUpLightBlackHeroDlg_" .. slimNightId
		local getLightBlackHeroDlg = UIManager.getUI(uiName, true)

		getLightBlackHeroDlg:setHeroListDic(heroListDic, slimNightId, true)
	elseif self.lastDrawGroupItems and #self.lastDrawGroupItems > 0 then
		local resultDlg = UIManager.getUI("drawCardResultUpDlg", true)

		resultDlg:showDrawCardResult(self.lastDrawGroupItems)
		self:_clearDrawCache()
		self:checkVoidHeroStarChanged()
	end
end

function HeroMixin:refreshNewbiePoolReddot(...)
	local newbiePoolEnable = self:newbiePoolEnable()

	RedDotManager.setKeyState(UIConst.RD_HINT_DRAWCARD_NEWBIE, newbiePoolEnable)
end

function HeroMixin:newbiePoolEnable()
	return not ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_NEWBIE_DRAWCARD) and not self.newbieDrawHasChoosen
end

function HeroMixin:newbiePoolVisible()
	return not ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_NEWBIE_DRAW_VISIBLE) and not self.newbieDrawHasChoosen
end

function HeroMixin:hasBoughtNewbieDraw()
	return self.roleDrawData[Const.DrawTypeNewbie] and self.roleDrawData[Const.DrawTypeNewbie].drawCount > 0
end

function HeroMixin:_initDrawCardFreeTicket()
	if self.freeDrawFreeTicketCD and self.standardDrawFreeTicketCD then
		return
	end

	local freeDrawPoolId = Const.DrawPoolIdFree
	local standardDrawPoolId = Const.DrawPoolIdStandard

	if not freeDrawPoolId or not standardDrawPoolId or not ResDrawFakeRand[freeDrawPoolId] or not ResDrawFakeRand[standardDrawPoolId] then
		return
	end

	self.freeDrawFreeTicketCD = (ResDrawFakeRand[freeDrawPoolId].free_time or 24) * 3600
	self.standardDrawFreeTicketCD = (ResDrawFakeRand[standardDrawPoolId].free_time or 24) * 3600
end

local function _freeTicketTimerEnd(drawType)
	if drawType == Const.DrawTypeFree then
		local drawData = CurAvatar.roleDrawData[Const.DrawTypeFree]
		local needTick = drawData.lastDrawTick + CurAvatar.freeDrawFreeTicketCD - ClientUtils.getServerTime()
		local hasFreeCount = needTick <= 0

		RedDotManager.setKeyState(UIConst.RD_HINT_DRAWCARD_FREE, hasFreeCount)
	elseif drawType == Const.DrawTypeStandard then
		local drawData = CurAvatar.roleDrawData[Const.DrawTypeStandard]
		local needTick = drawData.lastDrawTick + CurAvatar.standardDrawFreeTicketCD - ClientUtils.getServerTime()
		local hasFreeCount = needTick <= 0

		RedDotManager.setKeyState(UIConst.RD_HINT_DRAWCARD_STANDARD, hasFreeCount)
	end
end

function HeroMixin:_checkDrawCardFreeTicket(drawType)
	local checkFree, checkStandard

	if not drawType then
		checkFree = true
		checkStandard = true
	else
		checkFree = drawType == Const.DrawTypeFree
		checkStandard = drawType == Const.DrawTypeStandard
	end

	if checkFree then
		local drawData = self.roleDrawData[Const.DrawTypeFree]
		local needTick = drawData.lastDrawTick + self.freeDrawFreeTicketCD - ClientUtils.getServerTime()
		local hasFreeCount = needTick <= 0

		RedDotManager.setKeyState(UIConst.RD_HINT_DRAWCARD_FREE, hasFreeCount)

		if hasFreeCount then
			ClientTimerManager.stopGlobalTimer("FreeDrawFreeTicket")
		else
			ClientTimerManager.startGlobalTimer("FreeDrawFreeTicket", needTick, Functor(_freeTicketTimerEnd, Const.DrawTypeFree))
		end
	end

	if checkStandard then
		local drawData = self.roleDrawData[Const.DrawTypeStandard]
		local needTick = drawData.lastDrawTick + self.standardDrawFreeTicketCD - ClientUtils.getServerTime()
		local hasFreeCount = needTick <= 0

		RedDotManager.setKeyState(UIConst.RD_HINT_DRAWCARD_STANDARD, hasFreeCount)

		if hasFreeCount then
			ClientTimerManager.stopGlobalTimer("StandardFreeTicket")
		else
			ClientTimerManager.startGlobalTimer("StandardFreeTicket", needTick, Functor(_freeTicketTimerEnd, Const.DrawTypeStandard))
		end
	end
end

local POOL_RD_DICT = {
	UIConst.RD_HINT_DRAWCARD_STANDARD_ITEM,
	[4] = UIConst.RD_HINT_DRAWCARD_GROUP,
	[6] = UIConst.RD_HINT_DRAWCARD_GROUP,
	[201] = UIConst.RD_HINT_TURNTABLE
}

function HeroMixin:_initDrawCardItemReddot(...)
	for poolId, poolInfo in ipairs(ResDrawFakeRand) do
		if poolInfo.item_id then
			self:registerItemChangedCallBack(poolInfo.item_id, Functor(self._checkDrawcardItemReddot, poolId))
			self._checkDrawcardItemReddot(poolId)
		end
	end
end

function HeroMixin._checkDrawcardItemReddot(poolId, oldValue, newValue)
	if (oldValue == nil or oldValue < newValue) and POOL_RD_DICT[poolId] then
		local itemEnough = false
		local poolInfo = ResDrawFakeRand[poolId]

		if poolInfo.item_id then
			local nowCount = CurAvatar:getItemNumById(poolInfo.item_id)

			if nowCount >= poolInfo.item_num then
				itemEnough = true
			end
		end

		RedDotManager.setKeyState(POOL_RD_DICT[poolId], itemEnough)
	end
end

function HeroMixin._checkDrawcardActItemReddot(actId, itemId, needNum, oldValue, newValue)
	local actObj = CurAvatar:getActivityObj(actId)

	if actObj and actObj:isOpen() then
		local itemEnough = false

		if oldValue == nil or oldValue < newValue then
			local nowCount = CurAvatar:getItemNumById(itemId)

			if nowCount and needNum <= nowCount then
				itemEnough = true
			end

			if actObj.redDotId then
				RedDotManager.setKeyState(actObj.redDotId, itemEnough)
			end
		end
	end
end

function HeroMixin:unsetDrawCardItemReddot(poolId)
	if POOL_RD_DICT[poolId] then
		RedDotManager.setKeyState(POOL_RD_DICT[poolId], false)
	end
end

function HeroMixin:_initTurnTableDrawItemReddot()
	if Const.OPEN_TURN_TABLE and not ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_TURNTABLE) then
		local poolId = ResTurnTableMisc[1].pool_id
		local itemId = ResTurnTableMisc[1].turn_item_id

		self:registerItemChangedCallBack(itemId, Functor(self._checkDrawcardItemReddot, poolId))
		self._checkDrawcardItemReddot(poolId)
	end
end

function HeroMixin:hasMaxStarHeroId(heroId)
	for _, hero in pairs(self.heroDic) do
		if hero.id == heroId and hero.star >= hero:getMaxStar() then
			return true
		end
	end

	return false
end

function HeroMixin:hasLimitStarByHeroId(heroId, limitStar)
	for _, hero in pairs(self.heroDic) do
		if hero.id == heroId and limitStar <= hero.star then
			return true
		end
	end

	return false
end

function HeroMixin:getHeroIdMaxStarHeroDic()
	local idMaxStarHeroDic = {}

	for _, hero in pairs(self.heroDic) do
		if not idMaxStarHeroDic[hero.id] then
			idMaxStarHeroDic[hero.id] = hero
		elseif idMaxStarHeroDic[hero.id].star < hero.star then
			idMaxStarHeroDic[hero.id] = hero
		end
	end

	return idMaxStarHeroDic
end

function HeroMixin:initWishData(rand_common)
	local idList = {}

	for i, desire in ipairs(rand_common.desire) do
		local heroId = desire.resid

		table.insert(idList, heroId)
	end

	self.wishList = self:unpackWishList(idList)
	self.newHeroSeenList = self:loadNewWishFlag()
end

function HeroMixin:onDrawSetDesireResp(desire_list)
	self.wishList = self:unpackWishList(desire_list)
end

function HeroMixin:onDesireRecommendNotify(desire_recommend)
	self.desireRecommendList = self:unpackDesireRecommendList(desire_recommend)
end

function HeroMixin:unpackDesireRecommendList(serverData)
	local campList = {
		Const.CAMP_TYPE.CLASS,
		Const.CAMP_TYPE.POPULAR,
		Const.CAMP_TYPE.LEGEND
	}
	local recommendList = {}

	if serverData and serverData.data and #serverData.data ~= 0 then
		local desireRecommed = serverData.data

		for i, camp in ipairs(campList) do
			recommendList[camp] = {}

			local index = (i - 1) * 5 + 1

			for j = index, index + 4 do
				if desireRecommed[j] and desireRecommed[j].resid then
					table.insert(recommendList[camp], desireRecommed[j].resid)
				end
			end
		end
	else
		recommendList = self:unpackDefaultDesireRecommendList()
	end

	return recommendList
end

function HeroMixin:unpackDefaultDesireRecommendList()
	local recommendList = {
		[Const.CAMP_TYPE.CLASS] = {},
		[Const.CAMP_TYPE.POPULAR] = {},
		[Const.CAMP_TYPE.LEGEND] = {}
	}

	for _, heroid in ipairs(ResWishListRecommend[1].class_recommend) do
		table.insert(recommendList[Const.CAMP_TYPE.CLASS], heroid)
	end

	for _, heroid in ipairs(ResWishListRecommend[1].popular_recommend) do
		table.insert(recommendList[Const.CAMP_TYPE.POPULAR], heroid)
	end

	for _, heroid in ipairs(ResWishListRecommend[1].legend_recommend) do
		table.insert(recommendList[Const.CAMP_TYPE.LEGEND], heroid)
	end

	return recommendList
end

function HeroMixin:packWishList(clientData)
	local idList = {}

	for camp, list in pairs(clientData) do
		for _, heroId in ipairs(list) do
			table.insert(idList, heroId)
		end
	end

	return idList
end

function HeroMixin:unpackWishList(serverData)
	local wishList = {
		[Const.CAMP_TYPE.CLASS] = {},
		[Const.CAMP_TYPE.POPULAR] = {},
		[Const.CAMP_TYPE.LEGEND] = {}
	}

	for i, heroId in ipairs(serverData) do
		if ResHero[heroId] and ResHero[heroId].camp and ResHero[heroId].launch == 1 then
			table.insert(wishList[ResHero[heroId].camp], heroId)
		end
	end

	return wishList
end

function HeroMixin:loadNewWishFlag()
	local recordStr = UserData.loadCommonData("NewWish" .. self.uid)
	local seenList = ClientUtils.string2Table(recordStr) or {}

	if #seenList > 0 then
		for i = #seenList, 1, -1 do
			local heroId = seenList[i]

			if ResHero[heroId] and ResHero[heroId].new_wish_hero ~= 1 then
				table.remove(seenList, i)
			end
		end
	end

	return seenList
end

function HeroMixin:saveNewWishFlag(wishSeenList)
	UserData.saveCommonData("NewWish" .. self.uid, ClientUtils.table2String(wishSeenList))
end

function HeroMixin:seenNewHero(heroIdList)
	for i, heroId in ipairs(heroIdList) do
		table.insert(self.newHeroSeenList, heroId)
	end

	self:saveNewWishFlag(self.newHeroSeenList)

	local drawCardDlg = UIManager.getUI("drawCardMainDlg", nil, false)

	if drawCardDlg then
		drawCardDlg:wishListHasNew()
	end
end

function HeroMixin:checkWishListNew()
	local newHeroDict = {}

	for heroId, heroInfo in pairs(ResHero) do
		if heroInfo.new_wish_hero == 1 and self:wishHeroTimeValid(heroId) then
			newHeroDict[heroId] = heroInfo.camp
		end
	end

	for _, seenId in ipairs(self.newHeroSeenList) do
		newHeroDict[seenId] = nil
	end

	return next(newHeroDict) ~= nil, newHeroDict
end

function HeroMixin:wishHeroTimeValid(heroId)
	local heroTimeValidId

	if ResWishListHeroControl[heroId] and ResWishListHeroControl[heroId].valid_time_id then
		heroTimeValidId = ResWishListHeroControl[heroId].valid_time_id
	elseif ResHandBookHero[heroId] and ResHandBookHero[heroId].valid_time_id then
		heroTimeValidId = ResHandBookHero[heroId].valid_time_id
	end

	if heroTimeValidId and not ClientUtils.isTimeConfigPassed(heroTimeValidId) then
		return false
	end

	return true
end

function HeroMixin:beginnerHeroResetEnable()
	for _, hero in pairs(self.heroDic) do
		if hero.star < 4 and hero.realLevel > 1 and not self:heroInFormation(hero.gid, Const.FORMATION_MAIN_STAGE) then
			return true
		end
	end
end

function HeroMixin:beginnerHeroResetEnable2()
	local formationHeros = self:getFormationHeros()

	if #formationHeros < 5 then
		return false
	end

	local minStar = 999

	for _, hero in pairs(formationHeros) do
		if hero.realLevel <= 1 then
			return false
		end

		if minStar > hero.star then
			minStar = hero.star
		end
	end

	for _, hero in pairs(self.heroDic) do
		if minStar >= hero.star and hero.realLevel > 1 and not self:heroInFormation(hero.gid, Const.FORMATION_MAIN_STAGE) then
			return true
		end
	end
end

function HeroMixin:isAllLightBlackMaxStar()
	local lightBlackMaxStarIdDic = {}

	for gid, hero in pairs(self.heroDic) do
		if hero.resData.ori_star > 4 and hero:isLightOrDark() and hero.star == hero:getMaxStar() then
			lightBlackMaxStarIdDic[hero.id] = 1
		end
	end

	for id, heroRes in pairs(ResHero) do
		if ClientUtils.isTimeConfigPassed(heroRes.valid_time_id) and not lightBlackMaxStarIdDic[heroRes.id] and heroRes.ori_star > 4 and utils.campIsLightOrDark(heroRes.camp) and heroRes.launch then
			return false
		end
	end

	return true
end

function HeroMixin:getHeroRecommendFormation(allHeros)
	if not allHeros then
		local allHeros = {}

		for gid, hero in pairs(self.heroDic) do
			table.insert(allHeros, hero)
		end
	end

	local function sortByLevel(a, b)
		if a.level ~= b.level then
			return a.level > b.level
		else
			return a.id < b.id
		end
	end

	table.sort(allHeros, sortByLevel)

	local forms = {}

	for index, hero in ipairs(allHeros) do
		if hero.isFront then
			forms[2] = table.remove(allHeros, index)

			break
		end
	end

	if not forms[2] then
		for index, hero in ipairs(allHeros) do
			if hero.career == Const.CAREER_TYPE.SUPPORT then
				forms[2] = table.remove(allHeros, index)

				break
			end
		end
	end

	if not forms[2] then
		forms[2] = table.remove(allHeros, 1)
	end

	for index, hero in ipairs(allHeros) do
		if hero.career == Const.CAREER_TYPE.SUPPORT then
			forms[5] = table.remove(allHeros, index)

			break
		end
	end

	if not forms[5] then
		for index, hero in ipairs(allHeros) do
			if not hero.isFront then
				forms[5] = table.remove(allHeros, index)

				break
			end
		end
	end

	for index, hero in ipairs(allHeros) do
		if hero.isFront then
			forms[4] = table.remove(allHeros, index)

			break
		end
	end

	for index, hero in ipairs(allHeros) do
		if hero.isFront then
			forms[6] = table.remove(allHeros, index)

			break
		end
	end

	if not forms[5] then
		forms[5] = table.remove(allHeros, 1)
	end

	if not forms[4] then
		forms[4] = table.remove(allHeros, 1)
	end

	forms[8] = table.remove(allHeros, 1)

	if not forms[6] then
		forms[7] = table.remove(allHeros, 1)
	end

	return forms
end

function HeroMixin:getConfigTeamHeros(includeUr)
	local data = {}

	for i = 1, 6 do
		local teamData = {}

		for hid, info in pairs(ResHero) do
			if info.belong_team == i and ClientUtils.isTimeConfigPassed(info.valid_time_id) and (includeUr or info.quality ~= Const.HERO_QUALITY_SS) then
				table.insert(teamData, hid)
			end
		end

		data[i] = teamData
	end

	return data
end

function HeroMixin:getConfigOtherTeamHeros(...)
	local data = {}

	if Const.IS_SHOW_OTHER_TEAM_PROFICIENT then
		local list = {}

		for hid, info in pairs(ResHero) do
			if (not info.belong_team or (info.belong_team < 1 or info.belong_team > 6) and ClientUtils.isTimeConfigPassed(info.valid_time_id)) and info.quality ~= Const.HERO_QUALITY_SS then
				table.insert(list, hid)
			end
		end

		data[Const.OTHER_TEAM_INDEX] = list
	end

	return data
end

function HeroMixin:getConfigURTeamHeros()
	local data = {}
	local teamData = {}

	for hid, info in pairs(ResHero) do
		if ClientUtils.isTimeConfigPassed(info.valid_time_id) and info.quality == Const.HERO_QUALITY_SS then
			table.insert(teamData, hid)
		end
	end

	data[Const.UR_TEAM_INDEX] = teamData

	return data
end

function HeroMixin:getRoomHeroListDic()
	local roomHeros = {}
	local spMark = LuaToolkit.GetPatchSPMark()

	for team_id, teamRoomInfo in pairs(ResRoomHeroShow) do
		for _, roomInfo in pairs(teamRoomInfo) do
			if ResHandBookHero[roomInfo.hero_id] and ClientUtils.isTimeConfigPassed(ResHandBookHero[roomInfo.hero_id].valid_time_id) then
				self:addHeroToRooms(roomHeros, roomInfo)
			end
		end
	end

	return roomHeros
end

function HeroMixin:addHeroToRooms(roomHeros, roomInfo)
	local hero = {}

	hero = self:getRoomHero(roomInfo)

	local geted = self.handBookHeroDic and self.handBookHeroDic[hero.id] ~= nil

	hero.isGeted = geted
	hero.isRoomHero = true

	if not roomHeros[roomInfo.team_id] then
		roomHeros[roomInfo.team_id] = {}
	end

	table.insert(roomHeros[roomInfo.team_id], hero)
end

function HeroMixin:getRoomHero(roomInfo)
	local hero = BaseObject.GetObject(roomInfo.hero_id)

	hero.roomInfo = roomInfo

	return hero
end

local function _sortNewStageHero(a, b)
	if a.sortPriority ~= b.sortPriority then
		return a.sortPriority < b.sortPriority
	else
		return a.id < b.id
	end
end

function HeroMixin:getNewStageHeroList()
	local timeIdHeroListDic = {}

	for _, heroIdInfo in pairs(ResRelationNewHero) do
		if ClientUtils.isTimeConfigPassed(heroIdInfo.valid_time_id) then
			local hero = BaseObject.GetObject(heroIdInfo.hero_id)

			hero.sortPriority = heroIdInfo.index_priority

			if heroIdInfo.valid_time_id and not timeIdHeroListDic[heroIdInfo.valid_time_id] then
				timeIdHeroListDic[heroIdInfo.valid_time_id] = {}
			end

			table.insert(timeIdHeroListDic[heroIdInfo.valid_time_id], hero)
		end
	end

	for _, heroList in pairs(timeIdHeroListDic) do
		table.sort(heroList, _sortNewStageHero)
	end

	local curTimeId = self:getRelationNewStageCurTimeId()

	if curTimeId then
		return timeIdHeroListDic[curTimeId]
	end
end

function HeroMixin:getNewStageHeroListDic()
	local heroListDic = {}
	local newStageHeroList = self:getNewStageHeroList()

	if newStageHeroList then
		for _, hero in pairs(newStageHeroList) do
			if ResHandBookHero[hero.id] and ClientUtils.isTimeConfigPassed(ResHandBookHero[hero.id].valid_time_id) then
				if not heroListDic[hero.team] then
					heroListDic[hero.team] = {}
				end

				table.insert(heroListDic[hero.team], hero)
			end
		end

		for _, heroList in pairs(heroListDic) do
			table.sort(heroList, _sortNewStageHero)
		end
	end

	return heroListDic
end

function HeroMixin:getHeroMaxStar(heroId)
	local star = 0

	for _, hero in pairs(self.heroDic) do
		if hero.id == heroId and star < hero.star then
			star = hero.star
		end
	end

	if star == 0 and ResHero[heroId] then
		star = ResHero[heroId].ori_star
	end

	return star
end

function HeroMixin:getHeroMaxStarHero(heroId)
	local star = 0
	local maxStarHero

	for _, hero in pairs(self.heroDic) do
		if hero.id == heroId and star < hero.star then
			star = hero.star
			maxStarHero = hero
		end
	end

	return maxStarHero
end

function HeroMixin:getHeroMaxPaintHero(heroId)
	local paint = 0
	local maxPaintHero

	for _, hero in pairs(self.heroDic) do
		if hero.id == heroId and hero.star >= hero:getMaxStar() then
			local nowLevel = hero:getPaintLevel()

			if paint <= nowLevel then
				paint = nowLevel
				maxPaintHero = hero
			end
		end
	end

	return maxPaintHero
end

local function _sortForSpeSuitHero(heroA, heroB)
	if heroA.star ~= heroB.star then
		return heroA.star > heroB.star
	else
		return heroA.id < heroB.id
	end
end

function HeroMixin:getSpeSuitHeroList()
	local heroList = {}
	local heroDic = {}
	local sortHeroDic = self:getIdGrowthestHeroDic()

	for i, infos in ipairs(ResEquipTowerCustomEquipDrop) do
		for id, info in pairs(infos or {}) do
			local config = ResEquipTowerCustomEquipEffect[info.effect_id]

			if config and next(config) then
				local key = next(config)
				local heroId = config[key].hero_id

				if ResHero[heroId] and ClientUtils.isTimeConfigPassed(ResHero[heroId].valid_time_id) then
					local hero = sortHeroDic[heroId]

					if hero == nil then
						hero = Hero({
							resid = heroId
						})
					end

					heroDic[heroId] = hero
				end
			end
		end
	end

	for i, hero in pairs(heroDic) do
		table.insert(heroList, hero)
	end

	table.sort(heroList, _sortForSpeSuitHero)

	return heroList
end

return HeroMixin
