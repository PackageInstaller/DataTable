-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\StepTower\\StepTowerBattleAwardDlg.lua

local ResRoleImageData = require("ClientData/ResRoleImageData")
local ResColor = require("ClientData/ResColor")
local ResRandClient = require("ClientData/ResRandClient")
local BattleAwardMixin = require("UI/Battle/BattleAwardMixin")
local strClassName = "StepTowerBattleAwardDlg"
local StepTowerBattleAwardDlg = Class(strClassName, UIControls.Window)
local ICON_PATH = "Atlas/BattleAtlas/BattleResultAtlas/BattleResultAtlasNew"

MixinClass(StepTowerBattleAwardDlg, BattleAwardMixin, true)

function StepTowerBattleAwardDlg:ctor(...)
	self:ctorMixin()
	self:initUI()
end

function StepTowerBattleAwardDlg:initUI(...)
	self.btnConfirm = UIControls.Button(self, "BgPanel/BtnConfirm")

	self.btnConfirm:addEventClick(self.onBtnConfirmClick)

	self.imgRole = UIControls.Role(self, "BgPanel/GridHeroPortrait", 0, 0)

	local path = {
		"AwardSuc",
		"AwardStar"
	}

	self.awardUI = {
		{},
		{}
	}

	for i, p in ipairs(path) do
		self.awardUI[i].imgBgTitle = UIControls.Image(self, "BgPanel/AwardPanel/" .. p .. "/BgTitle")
		self.awardUI[i].txtTitle = UIControls.Label(self, "BgPanel/AwardPanel/" .. p .. "/TextTitle")
		self.awardUI[i].txtState = UIControls.Label(self, "BgPanel/AwardPanel/" .. p .. "/TextState")
	end

	self.imgSucGet1 = UIControls.Image(self, "BgPanel/AwardPanel/AwardSuc/Award1/ImgGet")
	self.imgSucGet2 = UIControls.Image(self, "BgPanel/AwardPanel/AwardSuc/Award2/ImgGet")
	self.grid1 = UIControls.Panel(self, "BgPanel/AwardPanel/AwardSuc/Award1")
	self.grid2 = UIControls.Panel(self, "BgPanel/AwardPanel/AwardSuc/Award2")
	self.imgStarGet = UIControls.Image(self, "BgPanel/AwardPanel/AwardStar/ImgAward/ImgGet")
	self.txtStarNum = UIControls.Label(self, "BgPanel/AwardPanel/AwardStar/ImgAward/TextNum")
	self.imgStarAward = UIControls.Image(self, "BgPanel/AwardPanel/AwardStar/ImgAward")
end

function StepTowerBattleAwardDlg:show(itemBobus, bonus)
	self.itemBobus = itemBobus
	self.star = bonus.star
	self.layer = bonus.layer
	self.level = bonus.level

	local star = CurAvatar:getStepTowerStar(self.layer, self.level)

	self.star = math.max(star, self.star)
	self.svrData = CurAvatar.stepTowerLayerData[self.layer]

	local layerData = CurAvatar:getStepTowerLayerData(self.layer)
	local randomId = layerData.resData[self.level].star_award[1].award
	local starAwardId = layerData.resData[self.level].star_award[3].award
	local starAwardItem = ResRandClient[starAwardId]

	self.randomItem = ResRandClient[randomId]
	self.totalAwardNum = #self.randomItem.show_ids + #starAwardItem.show_ids

	self.txtStarNum:setText("x" .. starAwardItem.show_nums[1] or 1)
	self:initData(itemBobus)

	local battleState = GameFsm.getState(Const.STATE_BATTLE)
	local battleType = battleState.battleType

	self:playCustomBgm(battleType, "result_award")
end

function StepTowerBattleAwardDlg:onBtnConfirmClick()
	self:setVisible(false)

	if not GameFsm.isInState(Const.STATE_BATTLE) then
		return
	end

	GameFsm.getCurState():exitBattle(true)
end

function StepTowerBattleAwardDlg:getGridStageTowerReward(id, num, index)
	local newGrid = UIControls.getGridContainer(self, "BgPanel/AwardPanel/AwardSuc/Award" .. index .. "/Grid")
	local clientItem = BaseObject.GetObject(id, num)

	newGrid:setObj(clientItem)

	newGrid.grid.mDisableWays = true

	newGrid:setVisible(true)

	return newGrid
end

function StepTowerBattleAwardDlg:bgmOn()
	local battleState = GameFsm.getCurState()

	if battleState and battleState.relicHero then
		local battleBGM = battleState.relicHero:getRelicBgmIdByType(Const.RELIC_BGM_TYPE_VICTORY)

		if battleBGM then
			CueManager.playUIBGM(battleBGM)
		end
	else
		StepTowerBattleAwardDlg.super.bgmOn(self)
	end
end

function StepTowerBattleAwardDlg:initData(itemBobus)
	local awards = {}

	for i, id in ipairs(self.randomItem.show_ids) do
		if i <= 2 then
			local awardGrid = self:getGridStageTowerReward(id, self.randomItem.show_nums and self.randomItem.show_nums[i] and self.randomItem.show_nums[i] or 1, i)

			table.insert(awards, awardGrid)
		end
	end

	self.grid1:setVisible(false)
	self.grid2:setVisible(false)

	if self:isFirstPass() then
		self:setClaimState(1, 0)

		for i, grid in ipairs(awards) do
			self["imgSucGet" .. i]:setVisible(false)
			self["grid" .. i]:setVisible(true)
			grid:setObjGray(false)
		end
	else
		self:setClaimState(1, 1)

		for i, grid in ipairs(awards) do
			self["imgSucGet" .. i]:setVisible(true)
			self["grid" .. i]:setVisible(true)
			grid:setObjGray(true)
		end
	end

	if self.star == 3 then
		if StepTowerBattleAwardDlg.preStar == 3 then
			self:setClaimState(2, 1)
			self.imgStarAward:setImageGray(true)
		else
			self:setClaimState(2, 0)
		end
	elseif self.star < 3 then
		self:setClaimState(2, -1)
		self.imgStarAward:setImageGray(true)
	end

	local battleState = GameFsm.getState(Const.STATE_BATTLE)
	local mvp = battleState:getMVPActor()

	if mvp then
		local portId = mvp.hero:getShowPortId()

		self.imgRole:showRole(portId)
	end
end

function StepTowerBattleAwardDlg:isFirstPass(...)
	if self.star == 3 and #self.itemBobus == self.totalAwardNum then
		return true
	elseif self.star < 3 and #self.itemBobus > 0 then
		return true
	else
		return false
	end
end

function StepTowerBattleAwardDlg:setClaimState(index, flag)
	if flag == 1 then
		self.awardUI[index].imgBgTitle:setImage(ICON_PATH, "BgTitleDis")
		self.awardUI[index].txtTitle:setFontColor(ResColor.GREYMIDDLE)
		self.awardUI[index].txtState:setText(Lang.get(74))
		self.awardUI[index].txtState:setFontColor(ResColor.GREYLIGHT)
	elseif flag == 0 then
		self.awardUI[index].imgBgTitle:setImage(ICON_PATH, "BgTitleSel")
		self.awardUI[index].txtTitle:setFontColor(ResColor.BLACK)
		self.awardUI[index].txtState:setText(Lang.get(338))
		self.awardUI[index].txtState:setFontColor(ResColor.ORANGEBTN)
	else
		self.awardUI[index].imgBgTitle:setImage(ICON_PATH, "BgTitleNml")
		self.awardUI[index].txtTitle:setFontColor(ResColor.BLACK)
		self.awardUI[index].txtState:setText(Lang.get(30768))
		self.awardUI[index].txtState:setFontColor(ResColor.GREYMIDDLE)
	end
end

function StepTowerBattleAwardDlg.setPreStar(star)
	StepTowerBattleAwardDlg.preStar = star
end

function StepTowerBattleAwardDlg:destroy(...)
	StepTowerBattleAwardDlg.super.destroy(self)

	StepTowerBattleAwardDlg.preStar = nil
end

return StepTowerBattleAwardDlg
