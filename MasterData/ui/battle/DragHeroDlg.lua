-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Battle\\DragHeroDlg.lua

local DragPlane = require("UI/Control/Com/DragPlane")
local UserData = require("Helper/UserData")
local ResColor = require("ClientData/ResColor")
local BattleConst = require("Common/FrameBattle/BattleConst")
local ResClientNotice = require("ClientData/ResClientNotice")
local ResStageMisc = require("ClientData/ResStageMisc")
local CampEnhanceInfoPanel = require("UI/Battle/CampEnhanceInfoPanel")
local DragHeroMixin = require("UI/Battle/DragHeroMixin")
local ResBattleTarget = require("ClientData/ResBattleTarget")
local WorldBossCommon = require("Logic/WorldBoss/WorldBossCommon")
local RentTaskUtils = require("UI/RentTask/RentTaskUtils")
local HeroScrollCell = Class("HeroScrollCell", UIControls.HeroCardLoop)
local ResPetMazeCondition = require("ClientData/ResPetMazeCondition")
local ResBattleStateShow = require("ClientData/ResBattleStateShow")
local ResWorldBossMisc = require("ClientData/ResWorldBossMisc")

function HeroScrollCell:ctor()
	self.sensor = UIControls.Panel(self, "")

	self.sensor:addEventDragOnGet(self.onDragGet)
	self.sensor:addEventDragOnClick(self.onDragClick)

	self.imgIconNew = UIControls.Image(self, "InfoPanel/IconNew")
	self.dragEnable = true
	self.checkHeroEnhance = true
end

function HeroScrollCell:onDragGet(sender)
	if not self.dragEnable then
		return
	end

	local obj = DragPlane.addDragObj(true, self.hero, nil, BattleConst.CAMP_PLAYER)

	DragPlane.showBlock(obj, self.hero)

	if self.selectCallback then
		self.selectCallback(self)
	end
end

function HeroScrollCell:setHero(hero)
	HeroScrollCell.super.setHero(self, hero)

	if self.mWindow.fiveUpStarNotInTeamHeroDic then
		self.imgIconNew:setVisible(self.mWindow.fiveUpStarNotInTeamHeroDic[hero.gid] ~= nil)
	end

	local heroRec = self.mWindow.recommendHeroIds

	if heroRec and heroRec[hero.id] then
		self.panelHeroEnhance:setVisible(true)
	end

	local teamNumLimit = self.mWindow.teamNumLimit

	if teamNumLimit and teamNumLimit.limitTeam then
		for index, team in ipairs(teamNumLimit.limitTeam) do
			if hero.team == team then
				self.panelHeroEnhance:setVisible(true)

				break
			end
		end
	end

	if self.battleSpecialPanel then
		local heroPutFilter = GameFsm.getCurState().heroPutFilter or {}

		if heroPutFilter[hero.id] then
			self.battleSpecialPanel:setVisible(true)
		else
			self.battleSpecialPanel:setVisible(false)
		end
	end
end

function HeroScrollCell:onDragClick(sender)
	local tips = UIManager.getUI("battleDragHeroTips")

	tips:show(self)
	tips:correctPos(true)

	if self.selectCallback then
		self.selectCallback(self)
	end
end

function HeroScrollCell:setSelected(isSelected)
	self.beSelected = isSelected
end

local SneakBattleHeroScrollCell = Class("SneakBattleHeroScrollCell", HeroScrollCell)

function SneakBattleHeroScrollCell:ctor(...)
	self.bgPreSel = UIControls.Image(self, "InfoPanel/SneakBattlePanel/BgPreSel")
end

function SneakBattleHeroScrollCell:setHero(hero)
	SneakBattleHeroScrollCell.super.setHero(self, hero)

	if hero and hero.recommend and hero.recommend == 1 then
		self.bgPreSel:setVisible(true)
	else
		self.bgPreSel:setVisible(false)
	end
end

local HeroTeamLimitTitle = Class("HeroTeamLimitTitle", UIControls.Panel)

function HeroTeamLimitTitle:ctor()
	self.imgTeam = UIControls.Image(self, self.mPath .. "/Img")
end

function HeroTeamLimitTitle:setTeam(team)
	if UIConst.HERO_TEAM_CONFIG[team] then
		self.imgTeam:setImage(UIConst.HERO_TEAM_CONFIG[team].iconPath, UIConst.HERO_TEAM_CONFIG[team].iconSS)
	end
end

local HeroCheckTeamLimit = Class("HeroCheckTeamLimit", UIControls.Panel)

function HeroCheckTeamLimit:ctor()
	self.imgBg = UIControls.Image(self, self.mPath)
end

function HeroCheckTeamLimit:setHas(has)
	if has then
		self.imgBg:setImage("Atlas/TeamSetAtlas/TeamSetAtlas", "IconLimitSel")
	else
		self.imgBg:setImage("Atlas/TeamSetAtlas/TeamSetAtlas", "IconLimitDis")
	end
end

local PET_MAZE_BUFF_MAX_NUM = 3
local PanelPetMazeBuff = Class("PanelPetMazeBuff", UIControls.Panel)

function PanelPetMazeBuff:ctor()
	self.btnPetMazeBuff = UIControls.Button(self, self.mPath)

	self.btnPetMazeBuff:addEventClick(self.onPetMazeBuffClick)

	self.btnPetMazeBuffClose = UIControls.Button(self, self.mPath .. "/BtnClose")

	self.btnPetMazeBuffClose:addEventClick(self.onPetMazeBuffCloseClick)

	self.panelBuff = UIControls.Panel(self, self.mPath .. "/BuffPanel")
	self.buffLabels = {}

	for index = 1, PET_MAZE_BUFF_MAX_NUM do
		self.buffLabels[index] = UIControls.Label(self, self.mPath .. "/BuffPanel/TextBuff" .. index)
	end

	self.panelBuffNothing = UIControls.Panel(self, self.mPath .. "/BuffPanel/TextNothing")
end

function PanelPetMazeBuff:setData(petMazeData)
	self.petMazeData = petMazeData

	if petMazeData then
		self:setVisible(true)
		self.btnPetMazeBuffClose:setVisible(false)
		self.panelBuff:setVisible(false)

		if petMazeData.conditionOkList then
			self.bossBuffs = nil

			local hasBuff = false

			for index, buffLabel in ipairs(self.buffLabels) do
				if petMazeData.conditionOkList[index] and petMazeData.conditionOkList[index][2] then
					local buffId = petMazeData.conditionOkList[index][1]

					if ResPetMazeCondition[buffId] then
						local buff_id = ResPetMazeCondition[buffId].buff_id

						if ResBattleStateShow[buff_id] then
							buffLabel:setText(ResBattleStateShow[buff_id].desc or "")
							buffLabel:setVisible(true)

							hasBuff = true
						end
					end
				end
			end

			self.panelBuffNothing:setVisible(not hasBuff)
		else
			self.bossBuffs = petMazeData.buffs
		end
	else
		self:setVisible(false)
	end
end

function PanelPetMazeBuff:onPetMazeBuffClick()
	if self.bossBuffs then
		UIManager.getUI("simpleBuffDlg", true):setData(self.bossBuffs)
	else
		self.btnPetMazeBuffClose:setVisible(true)
		self.panelBuff:setVisible(true)
	end
end

function PanelPetMazeBuff:onPetMazeBuffCloseClick()
	self.btnPetMazeBuffClose:setVisible(false)
	self.panelBuff:setVisible(false)
end

local strClassName = "DragHeroDlg"
local DragHeroDlg = Class(strClassName, UIControls.Window)

MixinClass(DragHeroDlg, DragHeroMixin)

function DragHeroDlg:ctor()
	self.maxNumber = 5

	local modeStr = UserData.loadCommonData(BattleConst.INFO_SHOW_TIPS)

	if modeStr == "1" then
		DragPlane.showTips = true
	else
		DragPlane.showTips = false
	end

	self:initUI()
end

function DragHeroDlg:_initUI()
	self.btnQuickBattle = UIControls.Button(self, "BtnSkip")

	self.btnQuickBattle:addEventClick(self.onBtnQuickBattle)
	self.btnQuickBattle:setVisible(false)

	self.textQuick = UIControls.Label(self, "BtnSkip/Text")
	self.aniTime = UIControls.UIAni(self, "BgGroupBuff/BgTime")
	self.txtTime = UIControls.Label(self, "BgGroupBuff/BgTime/Text")

	local stateBattle = GameFsm.getCurState()

	if stateBattle.battleConfig and stateBattle.battleConfig.num_limit then
		self.maxNumber = stateBattle.battleConfig.num_limit
	end

	self:_initTeamLimit()

	if self.campLimit then
		self.listHeros:initHeroList(HeroScrollCell, "System/Hero/GridHeroCard", nil, UIConst.HERO_NO_CAMP_FILTER_PANEL_MAP, self.robotHeros, self.heroTopFunc)
		self.listHeros:setHeroAttrFilter({
			{
				"camp",
				self.campLimit
			},
			{
				"specialCamp",
				self.campLimit
			}
		})
	elseif stateBattle.onlyUseTeam then
		self.teamHeros = {}

		local forms = CurAvatar:getNowFormation(stateBattle.onlyUseTeam)

		for gid, pos in pairs(forms) do
			local hero = CurAvatar.heroDic[gid]

			table.insert(self.teamHeros, hero)
		end

		self.listHeros:initHeroList(HeroScrollCell, "System/Hero/GridHeroCard", nil, nil, self.teamHeros)
	elseif stateBattle.fixedHeros then
		self.fixedHeros = stateBattle.fixedHeros
		self.teamHeros = {}

		for _, heroInfo in pairs(stateBattle.fixedHeros) do
			table.insert(self.teamHeros, heroInfo[2])
		end

		self.listHeros:initHeroList(HeroScrollCell, "System/Hero/GridHeroCard", nil, nil, self.teamHeros)
	elseif stateBattle.defineHeros then
		self.defineHeros = stateBattle.defineHeros
		self.teamHeros = {}

		for _, hero in pairs(stateBattle.defineHeros) do
			table.insert(self.teamHeros, hero)
		end

		if self.battleType == BattleConst.BATTLE_TYPE_SNEAK_BATTLE then
			self.listHeros:initHeroList(SneakBattleHeroScrollCell, "System/Hero/GridHeroCardSneakBattle", UIConst.HERO_SNEAK_BATTLE_FORMATION_SORT_MAP, UIConst.CLAN_CLEAR_FILTER_PANEL_MAP, self.teamHeros)
			self.textHeroTitle:setVisible(false)
			self.listHeros:updateHeroFilter()
		else
			self.listHeros:initHeroList(HeroScrollCell, "System/Hero/GridHeroCard", nil, nil, self.teamHeros)
		end
	elseif stateBattle.teamLimit then
		local limits = {}

		for _, team in ipairs(stateBattle.teamLimit) do
			table.insert(limits, {
				"team",
				team
			})
		end

		self.listHeros:initHeroList(HeroScrollCell, "System/Hero/GridHeroCard", nil, UIConst.HERO_NO_CAMP_FILTER_PANEL_MAP, self.robotHeros)
		self.listHeros:setHeroAttrFilter(limits)
	elseif stateBattle.teamNumLimit then
		self.listHeros:initHeroList(HeroScrollCell, "System/Hero/GridHeroCard", nil, UIConst.HERO_NO_CAMP_FILTER_PANEL_MAP, self.robotHeros, self.heroTopFunc)
	else
		self.listHeros:initHeroList(HeroScrollCell, "System/Hero/GridHeroCard", nil, nil, self.robotHeros)
	end

	self.panelNumLimit = UIControls.Panel(self, "SpePanel/SpeLimit")

	self.panelNumLimit:setVisible(true)

	self.textNumLimit = UIControls.Label(self, "SpePanel/SpeLimit/TextNum")
	self.panelPetMaze = PanelPetMazeBuff(self, "SpePanel/BtnBuffMazzPet")
	self.btnRecommendForm = UIControls.Button(self, "BtnRecommend")

	self.btnRecommendForm:addEventClick(self.onRecommendFormClick)

	if stateBattle.retryCanRecommend then
		self.btnRecommendForm:setVisible(true)
	else
		self.btnRecommendForm:setVisible(false)
	end

	self:_initMultiTeamMode()

	self.btnGuide = UIControls.Button(self, "BtnGuide")

	self.btnGuide:addEventClick(self.onClickBtnGuide)
end

function DragHeroDlg:checkTimeDown(...)
	if self.battleType == BattleConst.BATTLE_TYPE_CIRCLE then
		if not self.battlePreInfo or not self.battlePreInfo.circleBattleData or self.battlePreInfo.circleBattleData.isBoss then
			-- block empty
		else
			self.aniTime:setVisible(true)

			local leftTime = CurAvatar:getCircleBattleFomationLeftTime(self.battlePreInfo.circleBattleData.optick)

			self.aniTime:startAni("ResetTeamSetTime")

			if leftTime > 0 then
				if self.timer then
					self.timer:Stop()
				end

				self.timer = Timer.New(Slot(self._timeDown, self), 1, -1)

				self.timer:Start()
			end

			self:_timeDown()
		end
	else
		self.aniTime:setVisible(false)
	end
end

function DragHeroDlg:_timeDown(...)
	if self.battleType == BattleConst.BATTLE_TYPE_CIRCLE then
		local leftTime = 0

		if self.battlePreInfo and self.battlePreInfo.circleBattleData then
			leftTime = CurAvatar:getCircleBattleFomationLeftTime(self.battlePreInfo.circleBattleData.optick)
		end

		self.txtTime:setText(utils.calcTimeTxt(leftTime, true))

		if leftTime >= 0 then
			if leftTime <= Const.CIRCLE_FORMATION_TIP_TIME then
				self.aniTime:startAni("LoopTeamSetTime")
			else
				self.aniTime:stopAni("LoopTeamSetTime")
			end
		else
			if self.timer then
				self.timer:Stop()
			end

			local content = ClientUtils.getClientNotice(537)

			UIManager.showConfirm(UIConst.CONFIRM_ONEBTN, Lang.get(38576), content, Slot(self._exitBattle, self))
		end
	end
end

local MAX_TARGET_NUM = 3

function DragHeroDlg:_initBattleConfig(battleConfig)
	if not self.panelBattleTarget then
		self.panelBattleTarget = UIControls.Panel(self, "TargetPanel")
		self.battleTargetCells = {}

		for index = 1, MAX_TARGET_NUM do
			local newCell = UIControls.Panel(self, "TargetPanel/Target" .. index)
			local newDesc = UIControls.Label(self, "TargetPanel/Target" .. index .. "/TextTitle")

			table.insert(self.battleTargetCells, {
				newCell,
				newDesc
			})
		end
	end

	if battleConfig and battleConfig.target_id then
		self.panelBattleTarget:setVisible(true)

		local targetData = ResBattleTarget[battleConfig.target_id] or {}
		local targets = targetData.targets or {}

		for index, cInfo in ipairs(self.battleTargetCells) do
			local t = targets[index]

			if t then
				cInfo[1]:setVisible(true)
				cInfo[2]:setText(t.desc or "")
			else
				cInfo[1]:setVisible(false)
			end
		end
	else
		self.panelBattleTarget:setVisible(false)
	end

	if self.robotHeros then
		self.panelRobotBattle = UIControls.Panel(self, self.HERO_LIST_PATH .. "/ImgRobotDes")

		self.panelRobotBattle:setVisible(true)
	elseif self.panelRobotBattle then
		self.panelRobotBattle:setVisible(false)
	end
end

function DragHeroDlg:handleSpecBattle()
	self.strQuickBattleTip = Lang.get(60948)

	if self.battleType == BattleConst.BATTLE_TYPE_STAGE and utils.stagePreSuppressLevel and self.battlePreInfo.stageData then
		local stageData = self.battlePreInfo.stageData[4]

		if stageData and stageData.levelBoss ~= 1 and (ResStageMisc[1].skip_suppress_condition == nil or not ConditionLimitManager.inLimitState(ResStageMisc[1].skip_suppress_condition)) and (ResStageMisc[1].skip_suppress_upbound == nil or ConditionLimitManager.inLimitState(ResStageMisc[1].skip_suppress_upbound)) then
			local offset = ResStageMisc[1].skip_suppress_offset
			local configLevel = self.battleConfig.suppress_level

			self:setBtnQuickState(configLevel and configLevel <= utils.stagePreSuppressLevel - offset)
		end
	elseif self.battleType == BattleConst.BATTLE_TYPE_SNEAK_BATTLE then
		local actData = CurAvatar:getSneakBattleActivityData()

		if self.btnWearingPlan then
			self.btnWearingPlan:setVisible(false)
		end

		if self.panelBattleTarget then
			self.panelBattleTarget:setVisible(false)
		end

		if self.btnSneakBattleBuff and actData then
			local buffData = actData:getBuffResData()

			if buffData then
				self.imgSneakbattleBuff:setImage(buffData.icon_path, buffData.icon_name)
				self.txtBuffName:setText(buffData.name)
				self.txtBuffEffect:setText(buffData.desc)
			end
		end

		if self.sneakBattleTargetPanel and self.battleConfig then
			local targetData = ResBattleTarget[self.battleConfig.target_id] or {}
			local targets = targetData.targets

			if targets then
				self.sneakBattleTargetPanel:setVisible(true)

				if targets[1] then
					self.txtSneakTargetPerfect:setText(targets[1].desc)
				end

				if targets[2] then
					self.txtSneakTargetFinish:setText(targets[2].desc)
				end
			end
		end

		if self.battlePreInfo then
			if self.battlePreInfo.need_limit == 1 and self.battlePreInfo.limit and self.sneakBattleLimitPanel and actData then
				local resData = actData:getLimitResDataById(self.battlePreInfo.limit)

				if resData then
					self.sneakBattleLimitPanel:setVisible(true)
					self.imgSneakBattleLimit:setImage(resData.icon_path, resData.icon_name)
					self.txtSneakBattleLimitTitle:setText(resData.name)
					self.txtSneakBattleLmitDesc:setText(resData.desc)
				end
			end

			if self.battlePreInfo.formation and self.battlePreInfo.formation.pet_id and self.battlePreInfo.formation.pet_id ~= 0 then
				for _, pet in pairs(self.petData or {}) do
					if pet.id == self.battlePreInfo.formation.pet_id then
						self.nowSelectPet = pet
						self.nowSelectPetId = self.battlePreInfo.formation.pet_id

						self:refreshPetPart()

						break
					end
				end
			end
		end

		BeginnerManager.CheckSneakBattleFormation()
	elseif self.battlePreInfo.seasonTowerData then
		self:setBtnQuickState(self.battlePreInfo.seasonTowerData.score_need <= self.battlePreInfo.seasonTowerData.sweepMaxLayer)
	elseif self.battleType == BattleConst.BATTLE_TYPE_WORLD_BOSS and self.battlePreInfo.worldBossData.layer == 3 then
		self:setBtnQuickState(self.battlePreInfo.worldBossData.checkQuickFightOpen, true)

		self.strQuickBattleTip = string.format(ResClientNotice[766].notice, ResWorldBossMisc[1].hard_time_limit)
	end

	self.panelPetMaze:setData(self.battlePreInfo.petMazeData)
	self:checkTimeDown()

	local checkGuide = self.battlePreInfo.guideUid ~= nil

	self.btnGuide:setVisible(checkGuide)

	if checkGuide then
		self.btnWearingPlan:setVisible(false)
		self.btnConfirm:setVisible(false)
		self.btnQuickBattle:setVisible(false)
		self.btnQuickPet:setVisible(false)
		self.btnPetChange:setVisible(false)
	end
end

function DragHeroDlg:setBtnQuickState(isShow, specialShow)
	local btnImageName, textColorR
	local isShowedQuickBtn = UserData.loadCommonData(CurAvatar.uid .. BattleConst.INFO_SHOW_QUICK_BTN) == "1"

	local function setBtnData(btnImageName, textColorR)
		local colorRGB = textColorR / 255

		self.btnQuickBattle:setImage("Atlas/CommonAtlas/BtnAtlas2", btnImageName)
		self.textQuick:setColorByRGBA(colorRGB, colorRGB, colorRGB)

		self.canSkipBattle = isShow

		self.btnQuickBattle:setVisible(true)
	end

	if isShow then
		setBtnData("BtnCommonSec00Nml", 106)

		if not isShowedQuickBtn then
			UserData.saveCommonData(CurAvatar.uid .. BattleConst.INFO_SHOW_QUICK_BTN, "1")
		end
	elseif isShowedQuickBtn or specialShow then
		setBtnData("BtnCommonSec01Dis", 60)
	end
end

local MAX_TEAM_LIMIT = 2
local MAX_CHECK_TEAM_LIMIT = 5

function DragHeroDlg:_initTeamLimit()
	self.titlePanelTeam = UIControls.Panel(self, self.HERO_LIST_PATH .. "/TitlePanel2")
	self.titleTeamPanels = {}

	for index = 1, MAX_TEAM_LIMIT do
		local newPanel = HeroTeamLimitTitle(self, self.HERO_LIST_PATH .. "/TitlePanel2/ImgGame" .. index)

		table.insert(self.titleTeamPanels, newPanel)
	end

	self.panelCheckTeamNum = UIControls.Panel(self, "SpePanel/SpeLimitGame")
	self.textCheckTeam = UIControls.Label(self, self.HERO_LIST_PATH .. "/TitlePanel2/TextTitle")
	self.textLimitTeam = UIControls.Label(self, "SpePanel/SpeLimitGame/TextTitle")
	self.checkTeamPanels = {}

	for index = 1, MAX_CHECK_TEAM_LIMIT do
		local newPanel = HeroCheckTeamLimit(self, "SpePanel/SpeLimitGame/ImgCheck" .. index)

		table.insert(self.checkTeamPanels, newPanel)
	end

	self.teamLimit = GameFsm.getCurState().teamLimit
	self.teamNumLimit = GameFsm.getCurState().teamNumLimit

	self:refreshLimitUI()
end

function DragHeroDlg:refreshLimitUI()
	if self.teamLimit then
		self.titlePanelTeam:setVisible(true)
		self.panelTitle:setVisible(false)
		self.textCheckTeam:setText("")

		for order, pan in ipairs(self.titleTeamPanels) do
			if self.teamLimit[order] then
				pan:setVisible(true)
				pan:setTeam(self.teamLimit[order])
			else
				pan:setVisible(false)
			end
		end
	elseif self.teamNumLimit then
		self.teamNumLimit = self.teamNumLimit

		self.titlePanelTeam:setVisible(true)
		self.panelTitle:setVisible(false)

		for order, pan in ipairs(self.titleTeamPanels) do
			if self.teamNumLimit.limitTeam[order] then
				pan:setVisible(true)
				pan:setTeam(self.teamNumLimit.limitTeam[order])
			else
				pan:setVisible(false)
			end
		end

		self.panelCheckTeamNum:setVisible(true)
		self.textCheckTeam:setText(Lang.get(30146))
		self.textLimitTeam:setText(Lang.get(30147))

		for order, pan in ipairs(self.checkTeamPanels) do
			pan:setVisible(order <= self.teamNumLimit.noTeamNumber)
			pan:setHas(false)
		end
	else
		self.panelCheckTeamNum:setVisible(false)
		self.titlePanelTeam:setVisible(false)
		self.panelTitle:setVisible(true)
	end
end

function DragHeroDlg:onBtnCloseClick(sender)
	local result = {}

	for pos, obj in pairs(DragPlane.fieldObjs) do
		if pos > 0 and obj.hero then
			table.insert(result, {
				idx = pos,
				gid = obj.hero.gid
			})
		end
	end

	if #result < 1 and self.formationIdx == Const.FORMATION_MAIN_STAGE and self.battleType ~= BattleConst.BATTLE_TYPE_SNEAK_BATTLE then
		UIManager.showConfirm(UIConst.CONFIRM_ONEBTN, "", ResClientNotice[117].notice)
	else
		if self.battleType == BattleConst.BATTLE_TYPE_SEASON_TOWER and self.multiTeamsIndex and self.multiTeamsIndex[1] == nil then
			UIManager.showConfirmWithId(1024, Slot(self._exitBattle, self))

			return
		end

		if self.teamFormations then
			self:updateTeamFormations()
		elseif self.battleType == BattleConst.BATTLE_TYPE_RENT and self.teamHeros then
			-- block empty
		elseif self.battleType == BattleConst.BATTLE_TYPE_SNEAK_BATTLE then
			-- block empty
		elseif self.formationIdx ~= Const.FORMATION_FORCE_EMPTY then
			RPC.formationUpdate(self.formationIdx, result, self.nowSelectPetId)
		end

		self:_exitBattle()
	end
end

function DragHeroDlg:_exitBattle()
	DragPlane.stop()
	UIManager.getUI("battleDragHeroTips", false)
	self:checkExitBattle()
	self:setVisible(false)

	if not GameFsm.isInState(Const.STATE_BATTLE) then
		return
	end

	GameFsm.getCurState():exitBattle()
end

function DragHeroDlg:checkExitBattle(...)
	if self.battleType == BattleConst.BATTLE_TYPE_CIRCLE and self.battlePreInfo and self.battlePreInfo.circleBattleData then
		local data = self.battlePreInfo.circleBattleData

		CurAvatar:checkExitCircleBattleFormation(data.layer, data.serverGridPos)
	end
end

function DragHeroDlg:_getNowHeros()
	local herosField = {}

	for pos, obj in pairs(DragPlane.fieldObjs or {}) do
		if obj.hero and pos > 0 then
			herosField[obj.hero.gid] = true
		end
	end

	if self.teamFormations then
		for nowIndex, form in ipairs(self.teamFormations) do
			if nowIndex ~= self.selectTeam then
				for gid, pos in pairs(form) do
					herosField[gid] = true
				end
			end
		end
	end

	return herosField
end

function DragHeroDlg:_updateHeroBag()
	self.textNumLimit:setText(DragPlane.getObjectEnableNum())

	if self.teamNumLimit then
		local hasNum = DragPlane.getObjectNoTeamNum()

		for order, pan in ipairs(self.checkTeamPanels) do
			pan:setHas(order <= hasNum)
		end
	end
end

function DragHeroDlg:chooseOnceTowerRelic(chooseIndex)
	self.chooseRelic = chooseIndex

	self:_RealStartBattle()
end

function DragHeroDlg:ConfirmBattleFormation()
	if self.validResultCount and DragPlane.MAX_PUT_COUNT and self.validResultCount > DragPlane.MAX_PUT_COUNT then
		MsgManager.clientNotice(635)

		return false
	end

	if self.battlePreInfo.type == BattleConst.BATTLE_TYPE_ONCETOWER then
		if self.battlePreInfo.onceTowerData then
			local layerData = self.battlePreInfo.onceTowerData.layerData

			if layerData.relics and #layerData.relics > 0 then
				self.onceTowerLayer = layerData.layer

				UIManager.getUI("onceTowerChooseDlg", true):onShow(self.onceTowerLayer, self.chooseRelic)

				return
			end
		end
	elseif self.battleType == BattleConst.BATTLE_TYPE_CIRCLE then
		if self.battlePreInfo and self.battlePreInfo.circleBattleData then
			local data = self.battlePreInfo.circleBattleData
			local result, desc = CurAvatar:isCircleBattleStartValid(data.layer, data.serverGridPos)

			if not result and desc then
				MsgManager.notice(desc)

				return
			else
				self:stopTimeDown()
			end
		end
	elseif self.battleType == BattleConst.BATTLE_TYPE_SNEAK_BATTLE then
		local actObj = CurAvatar:getActivityObjByType(Const.ACT_TYPE_SNEAK_BATTLE)
		local checkOpen = actObj ~= nil and actObj:isValid()

		if not checkOpen then
			MsgManager.notice(Lang.get(1870))

			return
		end

		if actObj.actData:isInFrozenTime() then
			MsgManager.notice(Lang.get(32793))

			return
		end

		if self.battlePreInfo.limit ~= 0 then
			local heros = {}

			for pos, obj in pairs(DragPlane.fieldObjs or {}) do
				if obj.hero and pos > 0 then
					table.insert(heros, obj.hero)
				end
			end

			local check = utils.checkFormationConditionLimit(self.battlePreInfo.limit, heros)

			if not check then
				MsgManager.notice(Lang.get(96438))

				return
			end
		end

		local needCheck = false

		if self.battlePreInfo and self.battlePreInfo.formation and self.battlePreInfo.formation.hero and #self.battlePreInfo.formation.hero ~= 0 then
			for pos, obj in pairs(DragPlane.fieldObjs or {}) do
				if obj.hero and pos > 0 and obj.hero.recommend ~= 1 then
					needCheck = true
				end
			end
		end

		if needCheck then
			UIManager.showConfirmWithId(1120, nil, Slot(self._RealStartBattle, self))

			return
		end

		self:_RealStartBattle()
	end

	local checkHeroEquipOK = self:checkHeroEquipWear()

	if not checkHeroEquipOK then
		UIManager.showConfirmWithId(1044, nil, Slot(self._RealStartBattle, self))
	else
		self:_RealStartBattle()
	end
end

function DragHeroDlg:_RealStartBattle()
	if self.robotHeros then
		GameFsm.getCurState().preActivityBattle = self.battleConfig.id
		GameFsm.getCurState().activityFormation = self.result
	elseif self.teamFormations then
		self:updateTeamFormations()
	elseif self.battleType == BattleConst.BATTLE_TYPE_RENT and self.teamHeros then
		local rentData = self.battlePreInfo.rentData
		local posList = {}

		for _, hero in ipairs(self.fixedHeros) do
			table.insert(posList, 0)
		end

		for pos, obj in pairs(DragPlane.fieldObjs) do
			if pos > 0 and obj.hero and obj.hero.order then
				posList[obj.hero.order] = pos
			end
		end

		RentTaskUtils.updateTeamFormation(rentData.gtId, rentData.teamUid, rentData.teamId, posList)
	elseif #self.result > 0 then
		if self.battleType ~= BattleConst.BATTLE_TYPE_SNEAK_BATTLE then
			RPC.formationUpdate(self.formationIdx, self.result, self.nowSelectPetId)
		else
			RPC.formationUpdate(Const.FORMATION_SNEAK_BATTLE, self.result, self.nowSelectPetId)
		end
	end

	local boss_data = {}
	local async_pvp = {}
	local newBie = {}

	if self.battlePreInfo.asyncPVPData then
		async_pvp.uid = self.battlePreInfo.asyncPVPData.pvpId
	elseif self.battlePreInfo.beginnerData then
		newBie.pve_id = self.battlePreInfo.beginnerData.pveId
	end

	local specData = {}

	specData.tower = self.battlePreInfo.data
	specData.boss_tower = self.battlePreInfo.bossTowerData
	specData.async_pvp = async_pvp
	specData.newbie = newBie

	if self.battlePreInfo.type == BattleConst.BATTLE_TYPE_ONCETOWER then
		specData.once_tower = {}
		specData.once_tower.relics_index = self.chooseRelic or 0
	elseif self.battlePreInfo.type == BattleConst.BATTLE_TYPE_EQUIPTOWER then
		specData.equip_tower = {}
		specData.equip_tower.type = self.battlePreInfo.equipTowerData.type
		specData.equip_tower.layer = self.battlePreInfo.equipTowerData.layer
		specData.equip_tower.index = self.battlePreInfo.equipTowerData.curSeason
	elseif self.battleType == BattleConst.BATTLE_TYPE_WORLD_BOSS then
		local world_boss = {}

		if self.battlePreInfo.worldBossData then
			world_boss.is_mode_two = 0
			world_boss.team = 0
			world_boss.type = self.battlePreInfo.worldBossData.type
			world_boss.hard = self.battlePreInfo.worldBossData.layer
			world_boss.week_index = self.battlePreInfo.worldBossData.week_index
		end

		specData.world_boss = world_boss
	elseif self.battleType == BattleConst.BATTLE_TYPE_ACTIVITY then
		local plot = {}

		if self.battlePreInfo.actData then
			plot.act_id = self.battlePreInfo.actData.opId
			plot.index = self.battlePreInfo.actData.nodeIndex
		end

		specData.plot = plot
	elseif self.battleType == BattleConst.BATTLE_TYPE_RENT then
		local rent = {}

		rent.data = {}

		local rentData = self.battlePreInfo.rentData

		rent.data.gtid = rentData.gtId
		rent.data.teamid = rentData.teamId
		rent.data.team_uid = rentData.teamUid
		rent.data.taskid = rentData.taskId
		rent.data.pveid = rentData.pveId
		specData.rent = rent
	elseif self.battleType == BattleConst.BATTLE_TYPE_SEASON_TOWER then
		local opact_tower = {}

		opact_tower.data = {}

		if self.battlePreInfo.seasonTowerData then
			opact_tower.data.act_id = self.battlePreInfo.seasonTowerData.opId
			opact_tower.data.layer = self.battlePreInfo.seasonTowerData.layer
			opact_tower.data.tower_id = self.battlePreInfo.seasonTowerData.towerId
		end

		if self.multiTeamsIndex and self.multiTeamsIndex[1] == nil then
			opact_tower.data.cur_round = 2
		else
			local actObj = CurAvatar:getActivityObjByOpId(self.battlePreInfo.seasonTowerData.opId)

			opact_tower.data.cur_round = 1

			if actObj and actObj.actData:getRemainOpenTime() < 0 then
				MsgManager.clientNotice(344)
				self:onBtnCloseClick()

				return
			elseif actObj and actObj.actData:isTowerLocked(self.battlePreInfo.seasonTowerData.towerId) then
				MsgManager.clientNotice(348)
				self:onBtnCloseClick()

				return
			end

			if actObj and actObj.actData:getEnergy() <= 0 then
				MsgManager.clientNotice(346)
				self:onBtnCloseClick()

				return
			end
		end

		specData.opact_tower = opact_tower
	elseif self.battleType == BattleConst.BATTLE_TYPE_CIRCLE then
		local clan = {
			data = {}
		}

		if self.battlePreInfo.circleBattleData then
			clan.data.layer = self.battlePreInfo.circleBattleData.layer
			clan.data.grid_pos = self.battlePreInfo.circleBattleData.serverGridPos
		end

		specData.clan = clan
	elseif self.battleType == BattleConst.BATTLE_TYPE_BOSSTOWER_EXPAND then
		local data = {}

		if self.battlePreInfo.bossTowerExpandData then
			data.tower = self.battlePreInfo.bossTowerExpandData.towerId
			data.layer = self.battlePreInfo.bossTowerExpandData.layer
			data.level = self.battlePreInfo.bossTowerExpandData.level
			data.pve_id = self.battlePreInfo.bossTowerExpandData.pveId
		end

		specData.camp_tower = data
	elseif self.battleType == BattleConst.BATTLE_TYPE_MAZE_PET then
		local petMaze = {
			data = {}
		}

		if self.battlePreInfo.petMazeData then
			petMaze.data.act_id = self.battlePreInfo.petMazeData.act_id
			petMaze.data.level = self.battlePreInfo.petMazeData.level
			petMaze.data.boss_id = self.battlePreInfo.petMazeData.boss_id
			petMaze.data.stage_id = self.battlePreInfo.petMazeData.stage_id
			petMaze.data.season = self.battlePreInfo.petMazeData.season
		end

		specData.pet_maze = petMaze

		if self.battlePreInfo.fixedHeros and self.result then
			for _, preInfo in ipairs(self.battlePreInfo.fixedHeros) do
				local gid = preInfo[2].gid
				local formPos = 0

				for _, info in ipairs(self.result) do
					if info.gid == gid then
						formPos = info.idx

						break
					end
				end

				preInfo[1] = formPos
			end
		end
	elseif self.battleType == BattleConst.BATTLE_TYPE_SNEAK_BATTLE then
		local newPve = {
			data = {}
		}
		local actData = CurAvatar:getSneakBattleActivityData()

		if actData then
			newPve.data.week_index = actData.modeIndex
			newPve.data.type = actData.type
			newPve.data.level = actData.nowSelectLevel
			newPve.data.stage = self.battlePreInfo.stage
		end

		specData.new_pve = newPve
	end

	if self.robotHeros then
		local robots = {}

		for _, info in ipairs(self.result) do
			local idx = tonumber(info.gid)
			local pos = info.idx

			if idx and pos then
				table.insert(robots, {
					index = idx,
					pos = pos
				})
			end
		end

		specData.robot = robots
	end

	RPC.pVEStart(self.battlePreInfo.type, specData)
	CurAvatar:battleMiscReq()

	if self.quickMode then
		GameFsm.getCurState():onQuickEndGame()
	else
		UIManager.getUI("battleStartDlg", true)
	end

	self:setVisible(false)
end

function DragHeroDlg:onBtnQuickBattle(sender)
	if not self.canSkipBattle then
		MsgManager.notice(self.strQuickBattleTip)
	else
		self.quickMode = true

		self:_confirmEnterBattle()
	end
end

function DragHeroDlg:onRecommendFormClick(sender)
	DragPlane.enterRecommendForms()
end

function DragHeroDlg:onBattleConfirm(sender)
	if self.teamFormations and self.selectTeam == 1 then
		self:onClickTeamBtn(self.teamBtns[self.selectTeam + 1])

		return
	end

	self.quickMode = false

	self:_confirmEnterBattle()
end

function DragHeroDlg:_confirmEnterBattle()
	local heroPutFilter = GameFsm.getCurState().heroPutFilter or {}
	local resultCount = 0

	self.result = {}

	for pos, obj in pairs(DragPlane.fieldObjs) do
		if pos > 0 and obj.hero then
			if not heroPutFilter[obj.hero.id] then
				resultCount = resultCount + 1
			end

			table.insert(self.result, {
				idx = pos,
				gid = obj.hero.gid
			})
		end
	end

	self.validResultCount = resultCount

	if self.multiTeamsIndex then
		for index, formationIdx in pairs(self.multiTeamsIndex) do
			if index ~= self.selectTeam then
				local nResult = {}

				for gid, pos in pairs(self.teamFormations[index] or {}) do
					if pos > 0 then
						table.insert(nResult, {
							idx = pos,
							gid = gid
						})
					end
				end

				resultCount = math.min(#nResult, resultCount)
			end
		end
	end

	if self.battlePreInfo.type ~= BattleConst.BATTLE_TYPE_BEGINNER and resultCount < 1 then
		MsgManager.notice(ResClientNotice[148].notice)

		return
	end

	if ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_FORMATION_LIMIT) then
		self:ConfirmBattleFormation()
	elseif self.battleType == BattleConst.BATTLE_TYPE_WORLD_BOSS and WorldBossCommon.isInFrozenTime() then
		UIManager.showConfirm(UIConst.CONFIRM_ONEBTN, "", ClientUtils.getClientNotice(279), Slot(self.onBtnCloseClick, self))
	elseif self.battleType == BattleConst.BATTLE_TYPE_SNEAK_BATTLE then
		self:ConfirmBattleFormation()
	else
		local hasCount = CurAvatar:getHeroCount()

		if self.robotHeros then
			hasCount = #self.robotHeros
		end

		if self.fixedHeros then
			hasCount = #self.fixedHeros
		end

		if self.campLimit then
			hasCount = CurAvatar:getHeroCampCount(self.campLimit, true)
		end

		local noticeId = 109
		local _isZombieBattle = GameFsm.getCurState().isZombieBattle and GameFsm.getCurState():isZombieBattle()
		local content = ClientUtils.getClientNotice(109)

		if _isZombieBattle then
			content = string.format(ClientUtils.getClientNotice(196), self.maxNumber)
		end

		if hasCount >= self.maxNumber and resultCount < self.maxNumber then
			UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, "", content, Slot(self.ConfirmBattleFormation, self))
		elseif hasCount < self.maxNumber and resultCount < hasCount then
			UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, "", content, Slot(self.ConfirmBattleFormation, self))
		else
			self:ConfirmBattleFormation()
		end
	end
end

local MAX_TEAM_NUM = 2

function DragHeroDlg:_initMultiTeamMode()
	local state = GameFsm.getCurState()

	if state.battleType == BattleConst.BATTLE_TYPE_SEASON_TOWER then
		self.btnBuff = UIControls.Button(self, "SpePanel/BtnBuff")

		self.btnBuff:addEventClick(self.onBattleBuffClick)

		self.battleBuffs = state.battlePreInfo.seasonTowerData.buffs
		self.battleBuffArgs = state.battlePreInfo.seasonTowerData.buffArgs

		self.btnBuff:setVisible(self.battleBuffs and #self.battleBuffs > 0)

		if state.multiTeamsIndex then
			self.multiTeamsIndex = state.multiTeamsIndex
			self.formationNumber = #self.multiTeamsIndex
			self.teamFormations = {}
			self.teamBtns = {}

			for index = 1, MAX_TEAM_NUM do
				local newButton = UIControls.Button(self, "TeamPanel/BtnTeam" .. index)

				newButton:addEventClick(self.onClickTeamBtn)

				newButton.team = index

				table.insert(self.teamBtns, newButton)

				if self.multiTeamsIndex[index] then
					self.teamFormations[index] = utils.copyTable(CurAvatar:getNowFormation(self.multiTeamsIndex[index]))
				end
			end

			if self.teamFormations[1] and self.teamFormations[2] then
				for gid, pos in pairs(self.teamFormations[2]) do
					local hero = CurAvatar.heroDic[gid]

					for gid1, pos1 in pairs(self.teamFormations[1]) do
						local hero1 = CurAvatar.heroDic[gid1]

						if hero and hero1 and hero1.id == hero.id then
							self.teamFormations[2][gid] = nil

							break
						end
					end
				end
			end

			self.panelTeam = UIControls.Panel(self, "TeamPanel")

			self.panelTeam:setVisible(true)

			if self.multiTeamsIndex[1] == nil then
				self.btnTeam1Dead = UIControls.Button(self, "TeamPanel/BtnTeam1Die")

				self.btnTeam1Dead:addEventClick(self.onClickTeamDead)
				self.btnTeam1Dead:setVisible(true)
				self.teamBtns[1]:setVisible(false)
				self.teamBtns[2]:setEnable(false)
				self:onClickTeamBtn(self.teamBtns[2])
			else
				self:onClickTeamBtn(self.teamBtns[1])
			end
		end
	end
end

function DragHeroDlg:saveNowFormation()
	local form = {}

	for pos, obj in pairs(DragPlane.fieldObjs or {}) do
		if obj.hero and pos > 0 then
			form[obj.hero.gid] = pos
		end
	end

	self.teamFormations[self.selectTeam] = form
end

function DragHeroDlg:onClickTeamBtn(sender)
	if self.selectTeam == sender.team then
		return
	end

	if self.selectTeam then
		self:saveNowFormation()
	end

	self.selectTeam = sender.team

	for index, btn in ipairs(self.teamBtns) do
		btn:setEnable(sender ~= btn)
	end

	if self.selectTeam == MAX_TEAM_NUM then
		self.btnConfirm:setText(Lang.get(699))
	else
		self.btnConfirm:setText(Lang.get(30148))
	end

	self:refreshTeamObjects()
end

function DragHeroDlg:refreshTeamObjects()
	if self.battleType == BattleConst.BATTLE_TYPE_SEASON_TOWER then
		if self.selectTeam == 1 then
			DragPlane.setTeamLimitCheck(GameFsm.getCurState().teamNumLimit)

			self.teamNumLimit = GameFsm.getCurState().teamNumLimit
		else
			self.teamNumLimit = nil

			DragPlane.setTeamLimitCheck()
		end

		self:refreshLimitUI()
	end

	DragPlane.clearObject(true)
	DragPlane.startObjEntering()

	local teams = self.teamFormations[self.selectTeam]

	for gid, pos in pairs(teams) do
		local hero = CurAvatar.heroDic[gid]

		if hero then
			DragPlane.addDragObj(true, hero, pos, BattleConst.CAMP_PLAYER)
		end
	end

	self:updateHeroBag()
	self:updatePlayerCampEnhance()
	self:updateMonsterCampEnhance()
end

function DragHeroDlg:isHeroIdInTeam(heroId)
	if self.teamFormations then
		for nowIndex, form in ipairs(self.teamFormations) do
			if nowIndex ~= self.selectTeam then
				for gid, pos in pairs(form) do
					local hero = CurAvatar.heroDic[gid]

					if hero and hero.id == heroId then
						return nowIndex
					end
				end
			end
		end
	end
end

function DragHeroDlg:onBattleBuffClick()
	UIManager.getUI("activitySeasonTowerBuffAllDlg", true):onShow(self.battleBuffs, self.battleBuffArgs[1])
end

function DragHeroDlg:onClickTeamDead()
	MsgManager.clientNotice(343)
end

function DragHeroDlg:updateTeamFormations()
	if self.selectTeam then
		self:saveNowFormation()
	end

	for index, formationIdx in pairs(self.multiTeamsIndex) do
		local result = {}

		for gid, pos in pairs(self.teamFormations[index] or {}) do
			if pos > 0 then
				table.insert(result, {
					idx = pos,
					gid = gid
				})
			end
		end

		RPC.formationUpdate(formationIdx, result, self.nowSelectPetId)
	end
end

function DragHeroDlg:stopTimeDown(...)
	if self.timer then
		self.timer:Stop()
	end

	self.timer = nil
end

function DragHeroDlg:onClickBtnGuide()
	local result = {}

	for pos, obj in pairs(DragPlane.fieldObjs) do
		if pos > 0 and obj.hero then
			table.insert(result, {
				idx = pos,
				gid = obj.hero.gid
			})
		end
	end

	local function yesFunc()
		RPC.masterSetBattleGuide(self.battlePreInfo.guideUid, self.battlePreInfo.guideStage, result)
		self:_exitBattle()
	end

	if #result < self.maxNumber then
		UIManager.showConfirmWithId(1147, yesFunc)
	else
		UIManager.showConfirmWithId(1146, yesFunc)
	end
end

function DragHeroDlg:destroy(...)
	DragHeroDlg.super.destroy(self)
	self:stopTimeDown()
end

return DragHeroDlg
