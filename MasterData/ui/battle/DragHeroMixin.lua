-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Battle\\DragHeroMixin.lua

local DragPlane = require("UI/Control/Com/DragPlane")
local CommonHeroListPanel = require("UI/Battle/CommonHeroListPanel")
local UserData = require("Helper/UserData")
local ResColor = require("ClientData/ResColor")
local BattleConst = require("Common/FrameBattle/BattleConst")
local ResClientNotice = require("ClientData/ResClientNotice")
local CampEnhanceInfoPanel = require("UI/Battle/CampEnhanceInfoPanel")
local ResBattleTrap = require("ClientData/ResBattleTrap")
local FilterSelectPanel = require("UI/MainState/FilterSelectPanel")
local ResBattleRobot = require("ClientData/ResBattleRobot")
local ResBattleToolRobot = require("ClientData/ResBattleToolRobot")
local Hero = require("Common/Object/Hero")
local BtnWearingPlan = require("UI/MainState/BtnWearingPlan")
local PetSkillPart = require("UI/Pet/PetSkillPart")
local EventConst = require("EventConst")
local MODE_HERO = 1
local MODE_PET = 2
local RectTransformType = typeof(UnityEngine.RectTransform)
local DragHeroMixin = {}

function DragHeroMixin:initUI()
	self.HERO_LIST_PATH = "HeroListPanel"

	if UIControls.checkControlFunc(self, "HeroListPanel/PetNode") then
		self.PET_LIST_PATH = "HeroListPanel/PetNode"
		self.HERO_LIST_PATH = "HeroListPanel/HeroNode"
	end

	self.filterSelectPanel = FilterSelectPanel(self, self.HERO_LIST_PATH .. "/ListSelectPanel")
	self.btnClose = UIControls.Button(self, "BtnClose", "Text")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.btnConfirm = UIControls.Button(self, "BtnBattle", "Text")

	self.btnConfirm:addEventClick(self.onBattleConfirm)

	self.btnInfoMode = UIControls.Button(self, "BtnModeChange/BtnModeInfo")

	self.btnInfoMode:addEventClick(self.onClickInfoMode)

	self.btnSkillMode = UIControls.Button(self, "BtnModeChange/BtnModeSkill")

	self.btnSkillMode:addEventClick(self.onClickSkillMode)
	self:onClickSkillMode()

	self.panelSkillInfo = UIControls.UIAni(self, "SkillDesPanel")
	self.textSkillName = UIControls.Label(self, "SkillDesPanel/SkillDes/BgName/Bg/TextName")
	self.textSkillInfo = UIControls.Label(self, "SkillDesPanel/SkillDes/Text")
	self.btnListOpen = UIControls.Button(self, "BtnHeroListOpen")

	self.btnListOpen:addEventClick(self.onListToggle)

	if UIControls.checkControlFunc(self, "BtnHeroListOpen/IconNew") then
		self.imgIconNew = UIControls.Image(self, "BtnHeroListOpen/IconNew")
	end

	if UIControls.checkControlFunc(self, "HeroListPanel/BtnHeroListClose/IconNew") then
		self.imgIconNew2 = UIControls.Image(self, "HeroListPanel/BtnHeroListClose/IconNew")
	end

	self.btnListHide = UIControls.Button(self, "HeroListPanel/BtnHeroListClose")

	self.btnListHide:addEventClick(self.onListToggle)

	self.panelList = UIControls.Panel(self, "HeroListPanel")
	self.panelHeroList = UIControls.Panel(self, self.HERO_LIST_PATH)
	self.panelBlock = UIControls.Panel(self, self.HERO_LIST_PATH .. "/Panel")
	self.listHeros = CommonHeroListPanel(self, self.HERO_LIST_PATH)
	self.btnPlayerCampEnhance = UIControls.Button(self, "BgGroupBuff/BtnGroupBuffSelf")

	self.btnPlayerCampEnhance:addEventClick(self.onPlayerCampEnhanceClick)

	self.imgPlayerCampEnhance = UIControls.Image(self, "BgGroupBuff/BtnGroupBuffSelf/Icon")
	self.btnMonsterCampEnhance = UIControls.Button(self, "BgGroupBuff/BtnGroupBuffEnemy")

	self.btnMonsterCampEnhance:addEventClick(self.onMonsterCampEnhanceClick)

	self.imgMonsterCampEnhance = UIControls.Image(self, "BgGroupBuff/BtnGroupBuffEnemy/Icon")
	self.btnSensor = UIControls.Button(self, "BtnSensor")

	self.btnSensor:addEventClick(self.onClickSensor)

	self.panelCampEnhance = CampEnhanceInfoPanel(self, "GroupBuffInfoPanel")
	self.btnCampOverCome = UIControls.Button(self, "BtnGroupOrder")

	self.btnCampOverCome:addEventClick(self.onCampOverCome)

	self.panelCampOverCome = UIControls.Panel(self, "GroupOrderInfoPanel")
	self.labelCampOverCome1 = UIControls.Label(self, "GroupOrderInfoPanel/ImgOrder1/TextOrder")

	self.labelCampOverCome1:setText(ResClientNotice[159].notice)

	self.labelCampOverCome2 = UIControls.Label(self, "GroupOrderInfoPanel/ImgOrder2/TextOrder")

	self.labelCampOverCome2:setText(ResClientNotice[160].notice)

	self.efxOverComeChanged = UIControls.Panel(self, "BgGroupBuff/BtnGroupBuffSelf/Efx")
	self.panelTitle = UIControls.Panel(self, self.HERO_LIST_PATH .. "/TitlePanel")
	self.textHeroTitle = UIControls.Label(self, self.HERO_LIST_PATH .. "/TitlePanel/TextTitle")
	self.panelHeroTitleGroup = UIControls.Panel(self, self.HERO_LIST_PATH .. "/TitlePanel/ImgGroup")
	self.imgHeroTitleGroup = UIControls.Image(self, self.HERO_LIST_PATH .. "/TitlePanel/ImgGroup/Img")

	local stateBattle = GameFsm.getCurState()

	self.battleType = stateBattle.battleType
	self.battleConfig = stateBattle.battleConfig

	if stateBattle.battleConfig and stateBattle.battleConfig.camp_limit then
		self.campLimit = stateBattle.battleConfig.camp_limit
	end

	if self.campLimit then
		if Const.CAMP_CONFIG[self.campLimit] then
			local campIcon = UIConst.getHeroCampIconPath(self.campLimit)

			self.panelHeroTitleGroup:setVisible(true)
			self.imgHeroTitleGroup:setImage(campIcon[1], campIcon[2])
			self.textHeroTitle:setText(string.format(Lang.get(30149), Const.CAMP_CONFIG[self.campLimit].name))
			self.textHeroTitle:setFontColor(ResColor["GROUP0" .. self.campLimit])
		end
	else
		self.panelHeroTitleGroup:setVisible(false)
		self.textHeroTitle:setText(Lang.get(371))
		self.textHeroTitle:setFontColor(ResColor.ORANGEBTN)
	end

	self.btnTrap = UIControls.Button(self, "BtnTrap")

	self.btnTrap:addEventClick(self.onBtnTrapClick)

	self.panelTrap = UIControls.Panel(self, "TrapInfoPanel")
	self.textTrapName = UIControls.Label(self, "TrapInfoPanel/TextName")
	self.textTrapDesc = UIControls.Label(self, "TrapInfoPanel/TextEffect")

	self:playCustomBgm(self.battleType, "formation")
	self:initConfigData(stateBattle.battleConfig, stateBattle)
	self:_initUI()

	if self.robotHeros then
		self.panelHeroTitleGroup:setVisible(false)
		self.textHeroTitle:setText(Lang.get(37073))
		self.textHeroTitle:setFontColor(ResColor.ORANGEBTN)
	end

	if UIControls.checkControlFunc(self, "BtnWearingPlan") then
		self.btnWearingPlan = UIControls.Button(self, "BtnWearingPlan")

		self.btnWearingPlan:addEventClick(self.onBtnWearingPlan)

		self.wearIconNew = UIControls.RedDot(self, "BtnWearingPlan/IconNew")

		self.wearIconNew:addHint({
			UIConst.RD_HINT_BATTLE_EQUIP_WEAR,
			UIConst.RD_HINT_BATTLE_PET_WEAR
		})

		self.btnCloseWearList = UIControls.Button(self, "ListPanel/BtnClose")

		self.btnCloseWearList:addEventClick(self.onBtnCloseWearList)

		self.wearingPlanlist = UIControls.Panel(self, "ListPanel")
		self.bgList = UIControls.Panel(self, "ListPanel/BgList")

		self.wearingPlanlist:setVisible(false)

		self.scrollWearingPlanList = UIControls.ScrollViewLoopV(self, "ListPanel/BgList/ArrayEquipPlanList")

		self.scrollWearingPlanList:addEventCellChanged(self.onPlanListChanged)

		self.isOpenWearBtn = self:checkOpenWearBtn()
		self.isOpenWearInfo = self:checkOpenWearInfo()

		if not self.isOpenWearBtn then
			self.btnWearingPlan:setVisible(false)
			self.wearingPlanlist:setVisible(false)
		else
			self.btnWearingPlan:setVisible(true)
			self:initWearPlanList()
		end
	end

	if self.PET_LIST_PATH then
		self.panelPetList = UIControls.Panel(self, self.PET_LIST_PATH)
		self.petCells = {}
		self.scrollPetList = UIControls.ScrollViewLoopV(self, self.PET_LIST_PATH .. "/PetList")

		self.scrollPetList:addEventCellChanged(self.onPetListChanged)

		self.panelNonePet = UIControls.Panel(self, self.PET_LIST_PATH .. "/BgNothing")
		self.panelPetSkill = PetSkillPart(self, self.PET_LIST_PATH .. "/SkillList")

		self.panelPetSkill:setSkillGridCallBack(Slot(self.onPetSkillGridClick, self))
		self.panelPetSkill:setEmptySkillCallBack(Slot(self.onPetSkillEmptyClick, self))

		self.btnPetChange = UIControls.Button(self, "HeroListPanel/BtnChange")

		self.btnPetChange:addEventClick(self.onPetModeClick)

		self.imgBtnPetChange = UIControls.Image(self, "HeroListPanel/BtnChange/BgBtn")
		self.btnQuickPet = UIControls.Button(self, "BtnPet")

		self.btnQuickPet:addEventClick(self.onQuickPetClick)

		self.imgQuickPet = UIControls.Image(self, "BtnPet/ImgPetHead")

		if UIControls.checkControlFunc(self, "BtnPet/IconNew") then
			self.imgPetRedDot = UIControls.Image(self, "BtnPet/IconNew")
			self.txtPetRedDot = UIControls.Label(self, "BtnPet/IconNew/Image/Text")
		end
	end

	if UIManager.tryGetUI("avgBulletDlg") then
		local ui = UIManager.tryGetUI("avgBulletDlg")

		ui:clearCache()
		ui:setState(false)
	end

	if UIControls.checkControlFunc(self, "HeroListPanel/SneakBattleLimitPanel") then
		self.sneakBattleLimitPanel = UIControls.Panel(self, "HeroListPanel/SneakBattleLimitPanel")
		self.imgSneakBattleLimit = UIControls.Image(self, "HeroListPanel/SneakBattleLimitPanel/ImgIcon")
		self.txtSneakBattleLimitTitle = UIControls.Label(self, "HeroListPanel/SneakBattleLimitPanel/TextTitle")
		self.txtSneakBattleLmitDesc = UIControls.Label(self, "HeroListPanel/SneakBattleLimitPanel/TextDesc")
	end

	if UIControls.checkControlFunc(self, "SneakBattleTargetPanel") then
		self.sneakBattleTargetPanel = UIControls.Panel(self, "SneakBattleTargetPanel")
		self.txtSneakTargetFinish = UIControls.Label(self, "SneakBattleTargetPanel/TargetFinish/TextTitle")
		self.txtSneakTargetPerfect = UIControls.Label(self, "SneakBattleTargetPanel/TargetPerfect/TextTitle")
	end

	self.slotRefreshPetWearRed = Slot(self.refreshPetWearRed, self)

	EventCenter.addEventListener(EventConst.REFRESH_BATTLE_PET_WEAR_RED, self.slotRefreshPetWearRed)
end

function DragHeroMixin:onPetSkillGridClick(sender)
	if self.battlePreInfo.cannotChangePetSkill == 1 then
		return
	end

	if self.nowSelectPetId then
		UIManager.getUI("petAmuletWearDlg", true):setDataInBattle(sender.object, nil, self.nowSelectPetId)
	end
end

function DragHeroMixin:onPetSkillEmptyClick(index)
	if self.battlePreInfo.cannotChangePetSkill == 1 then
		return
	end

	if self.nowSelectPetId then
		UIManager.getUI("petAmuletWearDlg", true):setDataInBattle(nil, index, self.nowSelectPetId)
	end
end

local function sortPlanList(planA, planB)
	if planA.id == Const.EQUIP_PLAN_EDIT_ID ~= (planB.id == Const.EQUIP_PLAN_EDIT_ID) then
		return planA.id == Const.EQUIP_PLAN_EDIT_ID
	elseif CurAvatar.lastUsePlanID and planA.id == CurAvatar.lastUsePlanID ~= (planB.id == CurAvatar.lastUsePlanID) then
		return planA.id == CurAvatar.lastUsePlanID
	else
		return planA.id < planB.id
	end
end

function DragHeroMixin:initWearPlanList()
	self.planDataList = {}

	for _, plan in pairs(CurAvatar.equipPlanDic) do
		table.insert(self.planDataList, plan)
	end

	table.sort(self.planDataList, sortPlanList)
	table.insert(self.planDataList, 1, {
		name = ResClientNotice[610].notice,
		id = Const.EQUIP_PLAN_EDIT_ID
	})

	self.btnWearingPlanList = {}

	local rectSize = self.bgList:getRectSize()

	if #self.planDataList > 4 then
		self.bgList:setRectSize(rectSize.width, 400)

		self.scrollWearingPlanList:getComObj().vertical = true
	else
		self.bgList:setRectSize(rectSize.width, #self.planDataList * 96)

		self.scrollWearingPlanList:getComObj().vertical = false
	end
end

function DragHeroMixin:onPlanListChanged(sender, targetCell, newIdx)
	targetCell = targetCell or BtnWearingPlan(sender, "System/Bag/BtnArrayEquipPlan", newIdx)

	if not self.planDataList or #self.planDataList == 0 then
		return
	end

	if self.planDataList[newIdx] ~= nil then
		targetCell:setPlan(self.planDataList[newIdx])
		targetCell:setSelectCallback(Slot(self.selectPlanCallBack, self))
	end

	self.btnWearingPlanList[newIdx] = targetCell
end

function DragHeroMixin:selectPlanCallBack(btnPlan)
	if btnPlan.plan.id == Const.EQUIP_PLAN_EDIT_ID then
		local battleBeforeWearDlg = UIManager.getUI("battleBeforeWearDlg", true)
		local herosField = self:_getNowHeros()

		battleBeforeWearDlg:setData(herosField, self.battleType, self.nowSelectPetId)
		self.wearingPlanlist:setVisible(false)
		self.btnWearingPlan:setEnable(true)

		if self.isSetedInAnimTrap then
			self.isSetedInAnimTrap = false

			self:getController():SetInAnimName("InTeamSetMain")
		end
	else
		RPC.equipSchemeApply(btnPlan.plan.id, CurAvatar.equipPlanVersion)
		self.wearingPlanlist:setVisible(false)
		self.btnWearingPlan:setEnable(true)
	end
end

function DragHeroMixin:initConfigData(battleConfig, stateBattle)
	if battleConfig and battleConfig.traps then
		for index = 0, BattleConst.BATTLE_MAX_TRAP_INIT_NUM do
			local trapId = battleConfig.traps[index * 2 + 1]
			local trapPos = battleConfig.traps[index * 2 + 2]

			if trapId and trapPos then
				local trapData = ResBattleTrap[trapId]

				if trapData then
					self.btnTrap:setVisible(true)
					self.textTrapName:setText(trapData.name or "")
					self.textTrapDesc:setText(trapData.desc or "")

					self.panelTrapShow = UIControls.Panel(self, "TrapInfoShowPanel")

					self.panelTrapShow:setVisible(true)

					self.textTrapShowName = UIControls.Label(self, "TrapInfoShowPanel/TextName")
					self.textTrapShowDesc = UIControls.Label(self, "TrapInfoShowPanel/TextEffect")

					self.textTrapShowName:setText(trapData.name or "")
					self.textTrapShowDesc:setText(trapData.desc or "")
					self:getController():SetInAnimName("ShowTeamSetMainTrap")

					self.isSetedInAnimTrap = true

					break
				end
			else
				break
			end
		end
	end

	if (self.battleType == BattleConst.BATTLE_TYPE_ACTIVITY or self.battleType == BattleConst.BATTLE_TYPE_STEPTOWER) and battleConfig.robots then
		self.robotHeros = utils.getRobotHeroInfo(battleConfig.robots) or {}

		if GameFsm.getCurState().preActivityBattle == battleConfig.id then
			for _, heroInfo in ipairs(GameFsm.getCurState().activityFormation or {}) do
				local pos = heroInfo.idx
				local gid = heroInfo.gid

				for _, hero in ipairs(self.robotHeros) do
					if hero.gid == gid then
						DragPlane.addDragObj(true, hero, pos, BattleConst.CAMP_PLAYER)
					end
				end
			end
		elseif battleConfig.robot_default then
			for pos, robotIndex in ipairs(battleConfig.robot_default) do
				if robotIndex ~= 0 and self.robotHeros[robotIndex] then
					DragPlane.addDragObj(true, self.robotHeros[robotIndex], pos, BattleConst.CAMP_PLAYER)
				end
			end
		end
	elseif self.battleType == BattleConst.BATTLE_TYPE_EQUIPTOWER and stateBattle.battlePreInfo.equipTowerData and stateBattle.battlePreInfo.equipTowerData.limitHeroData then
		local heroId = stateBattle.battlePreInfo.equipTowerData.limitHeroData.limit_hero_id

		self.recommendHeroIds = {
			[heroId] = true
		}

		function self.heroTopFunc(heroA, heroB)
			if heroA.id ~= heroB.id then
				if heroA.id == heroId then
					return 1
				elseif heroB.id == heroId then
					return 2
				else
					return 0
				end
			else
				return 0
			end
		end
	elseif self.battleType == BattleConst.BATTLE_TYPE_SEASON_TOWER and stateBattle.battlePreInfo.seasonTowerData.teamNumLimit and stateBattle.battlePreInfo.seasonTowerData.teamNumLimit.limitTeam and #stateBattle.battlePreInfo.seasonTowerData.teamNumLimit.limitTeam > 0 then
		local limitTeam = stateBattle.battlePreInfo.seasonTowerData.teamNumLimit.limitTeam[1]

		function self.heroTopFunc(heroA, heroB)
			if heroA.level ~= heroB.level then
				if heroA.level > heroB.level then
					return 1
				else
					return 2
				end
			elseif heroA.team ~= heroB.team then
				if heroA.team == limitTeam then
					return 1
				elseif heroB.team == limitTeam then
					return 2
				else
					return 0
				end
			else
				return 0
			end
		end
	else
		self.robotHeros = nil
		self.heroTopFunc = nil
	end

	self:_initBattleConfig(battleConfig)
end

function DragHeroMixin:_initUI()
	return
end

function DragHeroMixin:_initBattleConfig(battleConfig)
	return
end

local CHECK_EQUIP_DICT = {
	[BattleConst.BATTLE_TYPE_ASYNC_PVP] = 1,
	[BattleConst.BATTLE_TYPE_THREE_TEAM_PVP] = 1,
	[BattleConst.BATTLE_TYPE_WORLD_BOSS] = 1,
	[BattleConst.BATTLE_TYPE_OPACT_PVP] = 1,
	[BattleConst.BATTLE_TYPE_MAZE_PET] = 1
}

function DragHeroMixin:checkHeroEquipWear()
	local checkHeroEquipOK = true

	if CHECK_EQUIP_DICT[self.battleType] then
		for pos, obj in pairs(DragPlane.fieldObjs) do
			if pos > 0 and obj.hero and (obj.hero:getHeroCanWearEquipEmptyPart() or obj.hero:getHeroCanWearArtifactEmptyPart()) then
				return false
			end
		end
	end

	return true
end

function DragHeroMixin:onCampOverCome()
	self:onBtnCloseWearList()
	self.btnSensor:setVisible(true)
	self.panelCampOverCome:setVisible(true)
end

function DragHeroMixin:onBtnTrapClick()
	self:onBtnCloseWearList()
	self.btnSensor:setVisible(true)
	self.panelTrap:setVisible(true)
end

function DragHeroMixin:updatePlayerCampEnhance()
	local prePlayerNum = self.playerCampMaxNum

	self.playerCampMaxNum, self.monsterCampMaxNum, self.specCampInfo = utils.getFormationCampMaxNum(DragPlane.fieldObjs or {})

	local pathPlayer = UIConst.CAMP_ENHANCE_BTN_IMG[self.playerCampMaxNum]

	if not pathPlayer then
		self.playerCampMaxNum = 0
		pathPlayer = UIConst.CAMP_ENHANCE_BTN_IMG[0]
	end

	self.imgPlayerCampEnhance:setImage(pathPlayer[1], pathPlayer[2])

	if prePlayerNum ~= nil and prePlayerNum ~= self.playerCampMaxNum then
		self.efxOverComeChanged:setVisible(false)
		self.efxOverComeChanged:setVisible(true)
	end
end

function DragHeroMixin:updateMonsterCampEnhance()
	local pathMonster = UIConst.CAMP_ENHANCE_BTN_IMG[self.monsterCampMaxNum] or UIConst.CAMP_ENHANCE_BTN_IMG[0]

	self.imgMonsterCampEnhance:setImage(pathMonster[1], pathMonster[2])
end

function DragHeroMixin:onPlayerCampEnhanceClick()
	self.btnSensor:setVisible(true)
	self.panelCampEnhance:setVisible(true)
	self.panelCampEnhance:onShow(self.playerCampMaxNum, self.specCampInfo[1], self.specCampInfo[2])
end

function DragHeroMixin:onMonsterCampEnhanceClick()
	if self.battlePreInfo.type ~= BattleConst.BATTLE_TYPE_ASYNC_PVP and self.battlePreInfo.type ~= BattleConst.BATTLE_TYPE_THREE_TEAM_PVP then
		MsgManager.notice(Lang.get(30129))
	else
		self.btnSensor:setVisible(true)
		self.panelCampEnhance:setVisible(true)
		self.panelCampEnhance:onShow(self.monsterCampMaxNum, self.specCampInfo[3], self.specCampInfo[4])
	end
end

function DragHeroMixin:onClickSensor()
	self:onBtnCloseWearList()
	self.btnSensor:setVisible(false)
	self.panelCampEnhance:setVisible(false)
	self.panelCampOverCome:setVisible(false)
	self.panelTrap:setVisible(false)
end

function DragHeroMixin:updateHeroInfo()
	self.listHeros.panelSort:refreshHeros()

	for pos, obj in pairs(DragPlane.fieldObjs or {}) do
		if obj.hero and obj.logo then
			obj.logo:setTarget(obj.hero)
		end
	end
end

function DragHeroMixin:_getNowHeros()
	local herosField = {}

	for pos, obj in pairs(DragPlane.fieldObjs or {}) do
		if obj.hero and pos > 0 then
			herosField[obj.hero.gid] = true
		end
	end

	return herosField
end

function DragHeroMixin:checkOpenWearBtn()
	if (self.battleType == BattleConst.BATTLE_TYPE_RENT or self.battleType == BattleConst.BATTLE_TYPE_SEASON_TOWER) and self.teamHeros then
		return false
	end

	local isLocked = ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_BAGWEAR)

	if not isLocked and not utils.tableIsContainsElement(BattleConst.HIDE_WEAR_TYPE, self.battleType) then
		return true
	end

	return false
end

function DragHeroMixin:checkOpenWearInfo()
	if self.battleType == BattleConst.BATTLE_TYPE_RENT and self.teamHeros then
		return false
	end

	local isLocked = ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_EQUIP_TOWER)

	if not isLocked and not utils.tableIsContainsElement(BattleConst.HIDE_WEAR_TYPE, self.battleType) then
		return true
	end

	return false
end

function DragHeroMixin:refreshWearRedDot()
	if self.isOpenWearBtn then
		local canWear = CurAvatar:checkHeroCanWearBetterEquip()

		RedDotManager.setKeyState(UIConst.RD_HINT_BATTLE_EQUIP_WEAR, canWear)
	end
end

function DragHeroMixin:updateHeroBag()
	local herosField = self:_getNowHeros()

	self.listHeros:updateHeroFilter(herosField)
	self:updatePlayerCampEnhance()
	self:_updateHeroBag()
	self:refreshWearRedDot()

	if self.battleType == BattleConst.BATTLE_TYPE_NEW_MAZE then
		self:refreshFettersUI()
	end
end

function DragHeroMixin:_updateHeroBag()
	self:refreshWearRedDot()
end

function DragHeroMixin:setPutInfos(battlePreInfo, formationIdx)
	self.battlePreInfo = battlePreInfo
	self.formationIdx = formationIdx

	self:initPetInfo(battlePreInfo)
	self:updateHeroBag()
	self:updateMonsterCampEnhance()
	self:handleSpecBattle()
end

function DragHeroMixin:handleSpecBattle()
	return
end

function DragHeroMixin:onBtnCloseClick(sender)
	self:onBtnCloseWearList()
	DragPlane.stop()
	UIManager.getUI("battleDragHeroTips", false)
	self:setVisible(false)

	if not GameFsm.isInState(Const.STATE_BATTLE) then
		return
	end

	GameFsm.getCurState():exitBattle()
	EventCenter.removeEventListener(EventConst.REFRESH_BATTLE_PET_WEAR_RED, self.slotRefreshPetWearRed)
end

function DragHeroMixin:onClickInfoMode(sender)
	self:onBtnCloseWearList()
	UserData.saveCommonData(BattleConst.INFO_SHOW_TIPS, "0")

	DragPlane.showTips = true

	DragPlane.closeTargEff()
	self.btnInfoMode:setEnable(false)
	self.btnSkillMode:setEnable(true)
end

function DragHeroMixin:onClickSkillMode(sender)
	self:onBtnCloseWearList()
	UserData.saveCommonData(BattleConst.INFO_SHOW_TIPS, "1")

	DragPlane.showTips = false

	self.btnSkillMode:setEnable(false)
	self.btnInfoMode:setEnable(true)
end

function DragHeroMixin:startShowSkillDesc(skillInfo)
	if skillInfo then
		if not self.inDescShow then
			self.panelSkillInfo:startAni("ShowSkillDes", true)
		end

		self.inDescShow = true

		self.textSkillName:setText(skillInfo.name)
		self.textSkillInfo:setText(skillInfo.skill_area_desc)
	elseif self.inDescShow then
		self:stopShowSkillDesc()
	end
end

function DragHeroMixin:stopShowSkillDesc()
	self.panelSkillInfo:startAni("HideSkillDes", true)

	self.inDescShow = false
end

function DragHeroMixin:onListToggle(sender)
	if self.wearingPlanlist and self.wearingPlanlist:getVisible() then
		self:playAni("CloseList", self.onWearListChangeFinished)

		self.sender = sender
	else
		self:changeHeroList(sender)
	end
end

function DragHeroMixin:changeHeroList(sender)
	if sender == self.btnListOpen then
		if not self.panelList:getVisible() then
			self:playAni("OpenHeroList", self.onListChangeFinished)
			self.panelList:setVisible(true)
		end
	elseif not self.btnListOpen:getVisible() then
		self:playAni("CloseHeroList", self.onListChangeFinished)
	end
end

function DragHeroMixin:setListOpend(opened)
	if opened == 1 then
		self:onListToggle(self.btnListOpen)
	else
		self:onListToggle(self.btnListHide)
	end
end

function DragHeroMixin:onListChangeFinished(aniName)
	if aniName == "OpenHeroList" then
		self.btnListOpen:setVisible(false)
	elseif aniName == "CloseHeroList" then
		self.panelList:setVisible(false)
		self.btnListOpen:setVisible(true)
	end
end

function DragHeroMixin:onBtnWearingPlan()
	if self.wearingPlanlist and not self.wearingPlanlist:getVisible() then
		self:playAni("ShowList", self.onWearListChangeFinished)
		self.btnWearingPlan:setEnable(false)
		self.wearingPlanlist:setVisible(true)
	end
end

function DragHeroMixin:onBtnCloseWearList()
	if self.wearingPlanlist and self.wearingPlanlist:getVisible() then
		self:playAni("CloseList", self.onWearListChangeFinished)
	end
end

function DragHeroMixin:onWearListChangeFinished(aniName)
	if aniName == "ShowList" then
		self:initWearPlanList()
		self.scrollWearingPlanList:setTotalCount(#self.planDataList, 1)
	elseif aniName == "CloseList" then
		self.wearingPlanlist:setVisible(false)
		self.scrollWearingPlanList:setTotalCount(0)
		self.btnWearingPlan:setEnable(true)

		if self.sender then
			self:changeHeroList(self.sender)

			self.sender = nil
		end
	end
end

function DragHeroMixin:initPetInfo(battlePreInfo)
	self.nowSelectPet = nil
	self.nowSelectPetId = nil
	self.petData = {}

	if self.panelPetList then
		if CurAvatar:petSystemEnable() then
			if battlePreInfo.petDisable or self.robotHeros then
				self.btnPetChange:setVisible(false)
				self.btnQuickPet:setVisible(false)

				self.mode = MODE_HERO

				self.imgBtnPetChange:setImage("Atlas/TeamSetAtlas/TeamSetAtlas4", "BgBtnHero")
				self.panelHeroList:setVisible(true)
				self.panelPetList:setVisible(false)
			else
				local pets = battlePreInfo.pets
				local otherFormationInfo = battlePreInfo.otherFormationInfo
				local defaultPetId

				if otherFormationInfo then
					defaultPetId = otherFormationInfo.petId
				end

				self.btnQuickPet:setVisible(true)
				self.btnPetChange:setVisible(true)

				self.petData = pets or {}

				if #self.petData > 0 then
					self.panelNonePet:setVisible(false)
					self.scrollPetList:setVisible(true)
					self.scrollPetList:setTotalCount(#self.petData)

					if defaultPetId then
						for _, pet in pairs(pets) do
							if pet.id == defaultPetId then
								self.nowSelectPet = pet
								self.nowSelectPetId = defaultPetId
							end
						end
					end

					self:refreshPetPart()
				else
					self.panelNonePet:setVisible(true)
					self.imgQuickPet:setVisible(false)

					if self.imgPetRedDot then
						self.imgPetRedDot:setVisible(false)
					end

					self.scrollPetList:setVisible(false)
					self.panelPetSkill:setVisible(false)
				end
			end
		elseif Const.OPEN_PET_SYSTEM then
			if battlePreInfo.type == BattleConst.BATTLE_TYPE_RENT and battlePreInfo.rentData.teamUid then
				if battlePreInfo.petDisable or self.robotHeros or self.teamHeros and battlePreInfo.type ~= BattleConst.BATTLE_TYPE_CIRCLE and battlePreInfo.type ~= BattleConst.BATTLE_TYPE_RENT then
					self.btnPetChange:setVisible(false)
					self.btnQuickPet:setVisible(false)

					self.mode = MODE_HERO

					self.imgBtnPetChange:setImage("Atlas/TeamSetAtlas/TeamSetAtlas4", "BgBtnHero")
					self.panelHeroList:setVisible(true)
					self.panelPetList:setVisible(false)
				else
					local pets = battlePreInfo.pets
					local otherFormationInfo = battlePreInfo.otherFormationInfo
					local defaultPetId

					if otherFormationInfo then
						defaultPetId = otherFormationInfo.petId
					end

					self.btnQuickPet:setVisible(true)
					self.btnPetChange:setVisible(true)

					self.petData = pets or {}

					if #self.petData > 0 then
						self.panelNonePet:setVisible(false)
						self.scrollPetList:setVisible(true)
						self.scrollPetList:setTotalCount(#self.petData)

						if defaultPetId then
							for _, pet in pairs(pets) do
								if pet.id == defaultPetId then
									self.nowSelectPet = pet
									self.nowSelectPetId = defaultPetId
								end
							end
						end

						self:refreshPetPart()
					else
						self.panelNonePet:setVisible(true)
						self.imgQuickPet:setVisible(false)

						if self.imgPetRedDot then
							self.imgPetRedDot:setVisible(false)
						end

						self.scrollPetList:setVisible(false)
						self.panelPetSkill:setVisible(false)
					end
				end
			else
				self.btnQuickPet:setVisible(false)
				self.panelNonePet:setVisible(true)
				self.imgQuickPet:setVisible(false)

				if self.imgPetRedDot then
					self.imgPetRedDot:setVisible(false)
				end

				self.scrollPetList:setVisible(false)
				self.panelPetSkill:setVisible(false)
			end
		else
			self.panelNonePet:setVisible(true)
			self.btnQuickPet:setVisible(false)
			self.imgQuickPet:setVisible(false)

			if self.imgPetRedDot then
				self.imgPetRedDot:setVisible(false)
			end

			self.scrollPetList:setVisible(false)
			self.panelPetSkill:setVisible(false)
		end
	end
end

function DragHeroMixin:onPetListChanged(sender, targetCell, newIdx)
	if not targetCell then
		targetCell = UIControls.PetCardLoop(sender, "System/Pet/GridPetCard", newIdx)

		targetCell:setSelectCallback(Slot(self.onPetCellClick, self))
	else
		self.petCells[targetCell.mIndex] = nil
		targetCell.mIndex = newIdx
	end

	self.petCells[newIdx] = targetCell

	local pet = self.petData[newIdx]

	targetCell:setPet(pet)
	targetCell:setSelected(pet == self.nowSelectPet)
end

function DragHeroMixin:onPetCellClick(sender)
	if self.battlePreInfo.cannotChangePetSkill == 1 then
		return
	end

	if self.nowSelectPet == sender.pet then
		self.nowSelectPet = nil
		self.nowSelectPetId = nil
	else
		self.nowSelectPet = sender.pet
		self.nowSelectPetId = self.nowSelectPet.id
	end

	self:refreshPetPart()
end

function DragHeroMixin:checkPetSkillRedDotLimit(...)
	if self.battleType ~= BattleConst.BATTLE_TYPE_RENT then
		return true
	else
		local stateBattle = GameFsm.getCurState()

		return not stateBattle.fixedHeros
	end
end

function DragHeroMixin:checkHasPetCanBattle(...)
	if self.teamPets then
		if self.petData and #self.petData ~= 0 then
			for _, pet in pairs(self.petData) do
				local hasTeam = false

				for index, pett in pairs(self.teamPets) do
					if pett.petId == pet.id then
						hasTeam = true

						break
					end
				end

				if not hasTeam then
					return true
				end
			end
		end
	else
		return self.petData and #self.petData ~= 0
	end
end

function DragHeroMixin:refreshPetPart()
	if self.nowSelectPet then
		self.panelPetSkill:setVisible(true)
		self.panelPetSkill:setSkill(self.nowSelectPet)

		for index, cell in pairs(self.petCells) do
			cell:setSelected(cell.pet == self.nowSelectPet)
		end

		local path = self.nowSelectPet:getIconPath()

		if path then
			self.imgQuickPet:setVisible(true)
			self.imgQuickPet:setImage(path[1], path[2])

			if self.imgPetRedDot then
				self.imgPetRedDot:setVisible(self:checkPetSkillRedDotLimit() and self.nowSelectPet:checkCanWearAmulet())
				self.txtPetRedDot:setText(ResClientNotice[764].notice)
			end
		end
	else
		self.imgQuickPet:setVisible(false)

		if self:checkHasPetCanBattle() then
			self.imgPetRedDot:setVisible(true)
			self.txtPetRedDot:setText(ResClientNotice[763].notice)
		else
			self.imgPetRedDot:setVisible(false)
		end

		self.panelPetSkill:setVisible(false)

		for index, cell in pairs(self.petCells) do
			cell:setSelected(false)
		end
	end

	self:refreshPetWearRed()
end

function DragHeroMixin:refreshPetWearRed()
	if self.isOpenWearBtn then
		local canWear = false

		if self.nowSelectPet then
			canWear = self.nowSelectPet:checkCanWearGem() or self.nowSelectPet:checkCanWearMainAmulet() or self.nowSelectPet:checkCanWearAssistAmulet()
		end

		RedDotManager.setKeyState(UIConst.RD_HINT_BATTLE_PET_WEAR, canWear)
	end
end

function DragHeroMixin:onQuickPetClick()
	self:changeHeroList(self.btnListOpen)

	if self.mode ~= MODE_PET then
		self:onPetModeClick()
	end
end

function DragHeroMixin:onPetModeClick()
	if self.mode == MODE_PET then
		self.mode = MODE_HERO

		self.imgBtnPetChange:setImage("Atlas/TeamSetAtlas/TeamSetAtlas4", "BgBtnHero")
		self.panelHeroList:setVisible(true)
		self.panelHeroList:playAnimator("ShowHeroNode")
		self.panelPetList:setVisible(false)
	else
		self.mode = MODE_PET

		self.imgBtnPetChange:setImage("Atlas/TeamSetAtlas/TeamSetAtlas4", "BgBtnPet")
		self.panelHeroList:setVisible(false)
		self.panelPetList:setVisible(true)
		self.panelPetList:playAnimator("ShowPetNode")
	end
end

return DragHeroMixin
