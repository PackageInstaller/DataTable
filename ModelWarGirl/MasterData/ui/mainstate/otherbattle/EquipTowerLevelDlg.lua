-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\OtherBattle\\EquipTowerLevelDlg.lua

local DragTwoPages = require("UI/Control/DragTwoPages")
local ResEquipTower = require("ClientData/ResEquipTower")
local ResRandClient = require("ClientData/ResRandClient")
local BattleConst = require("Common/FrameBattle/BattleConst")
local ResBattleConfig = require("ClientData/ResBattleConfig")
local ResColor = require("ClientData/ResColor")
local ResClientNotice = require("ClientData/ResClientNotice")
local ResEquipTowerLimitHero = require("ClientData/ResEquipTowerLimitHero")
local ResHero = require("ClientData/ResHero")
local ResEquipTowerCustomEquipDrop = require("ClientData/ResEquipTowerCustomEquipDrop")
local ResEquipTowerCustomEquipEffect = require("ClientData/ResEquipTowerCustomEquipEffect")
local ResEquipSuit = require("ClientData/ResEquipSuit")
local EquipTowerLevelBtn = Class("EquipTowerLevelBtn", UIControls.Child)

function EquipTowerLevelBtn:ctor()
	self.imgLabel = UIControls.Image(self, "LabelPanel/Icon")
	self.aniPanelLabel = UIControls.UIAni(self, "LabelPanel")
	self.isFinal = false
	self.panelBtnLv = UIControls.Panel(self, "BtnLv")
	self.panelBtnLvDis = UIControls.Panel(self, "BtnLvDis")
	self.btnChoose = UIControls.Button(self, "BtnLv", "TextLv")

	self.btnChoose:addEventClick(self.onChooseClick)

	self.numChoose = UIControls.Label(self, "BtnLv/TextNum")
	self.btnDis = UIControls.Button(self, "BtnLvDis", "TextLv")

	self.btnDis:addEventClick(self.onDisClick)

	self.numChooseDis = UIControls.Label(self, "BtnLvDis/TextNum")
	self.iconNew = UIControls.RedDot(self, "BtnLv/IconNew")
	self.iconNewSpe = UIControls.RedDot(self, "BtnLv/IconNewSpe")
	self.imgMaterial = UIControls.Image(self, "BtnLv/ImgMaterial")
	self.imgBgTri = UIControls.Image(self, "BtnLv/BgTri")
	self.imgBgGroup = UIControls.Image(self, "BtnLv/BgGroup")
	self.aniBtnFinal = UIControls.UIAni(self, "BtnFinalLv")
	self.panelBtnLvFinal = UIControls.Panel(self, "BtnFinalLv")
	self.panelBtnLvDisFinal = UIControls.Panel(self, "BtnFinalLvDis")
	self.btnChooseFinal = UIControls.Button(self, "BtnFinalLv", "TextLv")

	self.btnChooseFinal:addEventClick(self.onChooseClick)

	self.btnDisFinal = UIControls.Button(self, "BtnFinalLvDis", "TextLv")

	self.btnDisFinal:addEventClick(self.onDisClick)

	self.iconNewFinal = UIControls.RedDot(self, "BtnFinalLv/IconNew")
	self.iconNewSpeFinal = UIControls.RedDot(self, "BtnFinalLv/IconNewSpe")
end

function EquipTowerLevelBtn:setData(data)
	self.data = data

	local layerData = data.data

	self.layerData = layerData

	local layer = layerData.layer

	self.layer = layerData.layer

	local passedLayer = self.mParent.mParent.passedLevel
	local typeOfTower

	if passedLayer ~= 0 then
		typeOfTower = self.mParent.mParent.resData[passedLayer].layer_type or {}
	end

	self.isLayerOpen = layer <= passedLayer

	if layerData.layer_type ~= Const.EQUIP_TOWER_LAYER_TYPE_FINAL then
		if layerData then
			if layer <= passedLayer + 1 then
				self.btnChoose:setVisible(true)
				self.btnDis:setVisible(false)
				self.btnChoose:setText("")
				self.numChoose:setText(layer)
				self.numChooseDis:setText("")
			else
				self.btnChoose:setVisible(false)
				self.btnDis:setVisible(true)
				self.btnDis:setText("")
				self.numChoose:setText("")
				self.numChooseDis:setText(layer)
			end

			self.iconNew:clearHint()
			self.iconNew:setVisible(false)
			self.iconNewSpe:setVisible(false)

			if self.layerData.layer_type == Const.EQUIP_TOWER_LAYER_TYPE_WEEK and CurAvatar:isEquipTowerLimitNew(layerData.type, layerData.layer) then
				self.iconNewSpe:setVisible(true)
			end

			local isHideIcon = self.layerData.layer_type == Const.EQUIP_TOWER_LAYER_TYPE_WEEK and not Const.EQUIP_TOWER_OPEN_CUSTOM_LAYER

			self.aniPanelLabel:setVisible(self.layerData.key_layer_atlas ~= "0" and self.layerData.key_layer_atlas ~= nil and passedLayer < self.layer and not isHideIcon)

			if self.aniPanelLabel:getVisible() then
				self.imgLabel:setImage(self.layerData.key_layer_atlas, self.layerData.key_layer_sprite)
				self.aniPanelLabel:startAni("ShowLvLabel", true)
			end
		else
			self:setVisible(false)
		end
	else
		self.isFinal = true

		self.panelBtnLv:setVisible(false)
		self.panelBtnLvDis:setVisible(false)
		self.panelBtnLvFinal:setVisible(true)

		if layerData then
			if layer <= passedLayer + 1 then
				self.btnChooseFinal:setVisible(true)
			else
				self.btnChooseFinal:setVisible(false)
			end

			if typeOfTower == Const.EQUIP_TOWER_LAYER_TYPE_FINAL then
				self.btnDisFinal:setVisible(false)
			elseif passedLayer + 1 ~= self.mParent.mParent.firstFinalLevel then
				self.btnDisFinal:setVisible(true)
			end

			self.iconNewFinal:clearHint()
			self.iconNewFinal:setVisible(false)
			self.iconNewSpeFinal:setVisible(false)

			local isHideIcon = self.layerData.layer_type == Const.EQUIP_TOWER_LAYER_TYPE_WEEK and not Const.EQUIP_TOWER_OPEN_CUSTOM_LAYER

			self.aniBtnFinal:setVisible(self.layerData.key_layer_atlas ~= "0" and self.layerData.key_layer_atlas ~= nil and passedLayer < self.layer and not isHideIcon)

			if self.aniBtnFinal:getVisible() then
				self.imgLabel:setImage(self.layerData.key_layer_atlas, self.layerData.key_layer_sprite)
				self.aniBtnFinal:startAni("ShowLvLabel", true)
			end
		else
			self:setVisible(false)
		end
	end

	self:checkSweepFlag()
	self:checkEquipEvolve()
	self:onSelected(data.isSelect)
end

function EquipTowerLevelBtn:setSuperSweep(superTimes)
	if self.isFinal then
		self.iconNewFinal:setVisible(superTimes > 0)
	else
		self.iconNew:setVisible(superTimes > 0)
	end
end

function EquipTowerLevelBtn:checkEquipEvolve(...)
	if self.awardId == self.layerData.normal_sweep_award then
		return
	end

	self.awardId = self.layerData.normal_sweep_award
	self.euiqpEvolveItem = nil

	local items = ClientUtils.getObjectByRandId(self.layerData.normal_sweep_award)

	for i, item in ipairs(items) do
		if item.subType == Const.ITEM_STYPE_EQUIP_EVOLVE_MATERIAL then
			self.euiqpEvolveItem = item

			break
		end
	end
end

function EquipTowerLevelBtn:refreshEquipEvolveShow(isSelect)
	if self.isFinal then
		-- block empty
	elseif self.euiqpEvolveItem then
		self.imgBgTri:setVisible(false)
		self.imgBgGroup:setVisible(false)

		if self.isLayerOpen then
			self.imgMaterial:setVisible(true)

			local name = "A"

			if self.euiqpEvolveItem.resData.extend_args1 == 2 then
				name = "B"
			end

			if isSelect then
				self.imgMaterial:setImage("Atlas/OtherBattleAtlas/EquipTowerAtlas3", "BgMaterialSel0" .. self.layerData.type .. name)
			else
				self.imgMaterial:setImage("Atlas/OtherBattleAtlas/EquipTowerAtlas3", "BgMaterialNml0" .. self.layerData.type .. name)
			end
		else
			self.imgMaterial:setVisible(false)
		end
	else
		self.imgBgGroup:setVisible(true)
		self.imgBgTri:setVisible(true)
		self.imgMaterial:setVisible(false)
	end
end

function EquipTowerLevelBtn:checkSweepFlag(...)
	local times = CurAvatar:getEquipTowerSuperSweepTimes(self.mParent.mParent.towerType)

	if self.isFinal then
		local preSweepIndex = self.mParent.mParent.preSweepIndex
		local typeOfTower

		if preSweepIndex then
			typeOfTower = self.mParent.mParent.resData[preSweepIndex].layer_type
		end

		if typeOfTower == Const.EQUIP_TOWER_LAYER_TYPE_FINAL and times > 0 then
			self.iconNewFinal:setVisible(true)
		else
			self.iconNewFinal:setVisible(false)
		end
	elseif self.mParent.mParent.preSweepIndex == self.data.data.layer and times > 0 then
		self.iconNew:setVisible(true)
	else
		self.iconNew:setVisible(false)
	end
end

function EquipTowerLevelBtn:onChooseClick()
	self.mParent.mParent:onEquipTowerLevelBtnClick(self.data)
end

function EquipTowerLevelBtn:onDisClick()
	self.mParent.mParent:onEquipTowerLevelBtnClick(self.data)
end

function EquipTowerLevelBtn:onSelected(selected)
	if self.isFinal then
		self.btnChooseFinal:setEnable(not selected)
		self.btnDisFinal:setEnable(not selected)
	else
		self.btnChoose:setEnable(not selected)
		self.btnDis:setEnable(not selected)
	end

	self:refreshEquipEvolveShow(selected)
end

local constTowerName = {
	Lang.get(4469),
	Lang.get(4472),
	Lang.get(4475)
}
local EquipTowerLevelBtnWrap = Class("EquipTowerLevelBtnWrap", UIControls.ScrollViewLoopCell)

function EquipTowerLevelBtnWrap:ctor()
	return
end

function EquipTowerLevelBtnWrap:setData(data)
	self.data = data
	self.towerType = self.mParent.towerType

	if not self.cell then
		self.cell = EquipTowerLevelBtn(self, "", "System/EquipTower/EquipTowerLvCell0" .. self.towerType, 0, 0, true)
		self.cell.cellType = self.mParent.towerType
	elseif self.cell.cellType ~= self.mWindow.towerType then
		self.cell:destroy()

		self.cell = EquipTowerLevelBtn(self, "", "System/EquipTower/EquipTowerLvCell0" .. self.towerType, 0, 0, true)
		self.cell.cellType = self.mParent.towerType
	end

	self.cell:setData(data)
end

function EquipTowerLevelBtnWrap:setSuperSweep(superTimes)
	if self.cell then
		self.cell:setSuperSweep(superTimes)
	end
end

function EquipTowerLevelBtnWrap:onSelected(selected)
	if self.cell then
		self.cell:onSelected(selected)
	end
end

local EquipTowerLevelPage = Class("EquipTowerLevelPage", UIControls.Child)

function EquipTowerLevelPage:ctor()
	self.aniInfoPanel = UIControls.UIAni(self, "")
	self.lvInfoPanel = UIControls.Panel(self, "LvInfoPanel")
	self.textName = UIControls.Label(self, "LvInfoPanel/TextNum/TextLv")
	self.textNum = UIControls.Label(self, "LvInfoPanel/TextNum")
	self.textDesc = UIControls.Label(self, "LvInfoPanel/BgDes/TextDes")
	self.textDescGroup = UIControls.Label(self, "LvInfoPanel/BgDes/TextEngName")
	self.imgDescGroup = UIControls.Image(self, "LvInfoPanel/BgDes/ImgLine")
	self.textEngGroup = UIControls.Label(self, "LvInfoPanel/BgDes/TextEng")
	self.firstAwardGrids = {}
	self.awardGrids = {}
	self.btnAwardMore = UIControls.Button(self, "LvInfoPanel/AwardPanel/BtnMore")

	self.btnAwardMore:addEventClick(self.onBtnAwardMoreClick)

	self.panelFunc = UIControls.Panel(self, "LvInfoPanel/FuncPanel")
	self.btnClean = UIControls.Button(self, "LvInfoPanel/FuncPanel/BtnClean", "TextNum")

	self.btnClean:addEventClick(self.onCleanClick)

	self.txtCantClean = UIControls.Label(self, "LvInfoPanel/FuncPanel/BtnClean/TextNum")
	self.btnBattle = UIControls.Button(self, "LvInfoPanel/FuncPanel/BtnBattle", "Text")

	self.btnBattle:addEventClick(self.onBattleClick)

	self.imgBattleNew = UIControls.Panel(self, "LvInfoPanel/FuncPanel/BtnBattle/IconNewSpe")
	self.txtBattlePower = UIControls.Label(self, "LvInfoPanel/FuncPanel/BtnBattle/TextNum")
	self.imgBattlePower = UIControls.Image(self, "LvInfoPanel/FuncPanel/BtnBattle/IconEnergy")
	self.labelLock = UIControls.Label(self, "LvInfoPanel/TextLock")

	self.labelLock:setVisible(true)

	self.levelCells = {}
	self.btnAutoBattle = UIControls.Button(self, "LvInfoPanel/FuncPanel/BtnAutoChallenge")

	self.btnAutoBattle:addEventClick(self.onBtnAutoFightClick)

	self.btnReplay = UIControls.Button(self, "LvInfoPanel/FuncPanel/BtnReplay")

	self.btnReplay:addEventClick(self.onReplayClick)
	self.btnReplay:setVisible(true)

	self.imgRole = UIControls.Role(self, "LvInfoPanel/GridHeroPortrait", 0, 0)
	self.imgCleanUp = UIControls.Panel(self, "LvInfoPanel/FuncPanel/BtnClean/IconUp")
	self.panelCleanUp = UIControls.Panel(self, "LvInfoPanel/FuncPanel/CleanPanel")
	self.textCLeanUp = UIControls.Label(self, "LvInfoPanel/FuncPanel/CleanPanel/TextClean")
	self.textCleanUpTime = UIControls.Label(self, "LvInfoPanel/FuncPanel/CleanPanel/TextTime")
	self.bgGroup = UIControls.Image(self, "LvInfoPanel/BgGroup")
	self.bgTitle = UIControls.Image(self, "LvInfoPanel/BgTitle")
	self.textPassDesc = UIControls.Label(self, "LvInfoPanel/TextUp")
	self.labelFirstAward = UIControls.Label(self, "LvInfoPanel/AwardFirstPanel/TextTitle")
	self.panelSweepBonus = UIControls.Panel(self, "LvInfoPanel/AwardPanel")
	self.panelSpecialBonus = UIControls.Panel(self, "LvInfoPanel/SpeAwardPanel")
	self.imgSpecialBonus = UIControls.Image(self, "LvInfoPanel/SpeAwardPanel/ImgTitleS")
	self.panelDesc = UIControls.Panel(self, "LvInfoPanel/BgDes")
	self.panelSpecDesc1 = UIControls.Panel(self, "LvInfoPanel/BgDesSpe")
	self.textLimitName = UIControls.Label(self, "LvInfoPanel/BgDesSpe/TextName")
	self.textLimitDesc = UIControls.Label(self, "LvInfoPanel/BgDesSpe/TextDes")
	self.textLimitEng = UIControls.Label(self, "LvInfoPanel/BgDesSpe/TextEng")
	self.imgLimitLine = UIControls.Image(self, "LvInfoPanel/BgDesSpe/ImgLine")
	self.imgLimitUp = UIControls.Image(self, "LvInfoPanel/BgDesSpe/ImgUp")
	self.btnLimitAwardMore = UIControls.Button(self, "LvInfoPanel/SpeAwardPanel/BtnMore")

	self.btnLimitAwardMore:addEventClick(self.onBtnLimitAwardMoreClick)

	self.limitAwardGrids = {}
	self.panelSpecDesc2 = UIControls.Panel(self, "LvInfoPanel/BgSpeDec")
	self.imgSpec2UL = UIControls.Image(self, "LvInfoPanel/BgSpeDec/ImgUL")
	self.imgSpec2BR = UIControls.Image(self, "LvInfoPanel/BgSpeDec/ImgBR")
	self.btnAdd = UIControls.Button(self, "LvInfoPanel/AwardPanel/BtnAdd")

	self.btnAdd:addEventClick(self.onBtnAddClick)

	self.btnChange = UIControls.Button(self, "LvInfoPanel/AwardPanel/BtnChange")

	self.btnChange:addEventClick(self.onBtnChangeClick)

	self.txtEquipSpeDesc = UIControls.Label(self, "LvInfoPanel/BgInfoSpe/TextDes")
	self.imgHero = UIControls.Image(self, "LvInfoPanel/BgEquipSpe/IconHero")
	self.imgSuit = UIControls.Image(self, "LvInfoPanel/BgEquipSpe/IconSuit")
	self.panelEquipSpe = UIControls.Panel(self, "LvInfoPanel/BgEquipSpe")
	self.panelHeroStone = UIControls.Panel(self, "LvInfoPanel/BgHeroStone")
	self.imgStoneHero = UIControls.Image(self, "LvInfoPanel/BgHeroStone/IconHero")
	self.panelEquipInfoSpe = UIControls.Panel(self, "LvInfoPanel/BgInfoSpe")
	self.panelAward = UIControls.Panel(self, "LvInfoPanel/AwardPanel/GridPanel")
	self.scrollViewLevel = UIControls.ScrollViewLoopV(self, "LvChooseList", 0, self.onCellChanged)
	self.configDatas = {}

	self.panelEquipSpe:setVisible(false)
	self.panelHeroStone:setVisible(false)

	self.lvInfoPanelFinal = UIControls.Panel(self, "LvInfoFinalPanel")
	self.bgGroupFinal = UIControls.Image(self, "LvInfoFinalPanel/BgGroup")
	self.bgTitleFinal = UIControls.Image(self, "LvInfoFinalPanel/BgTitle")
	self.textNameFinal = UIControls.Label(self, "LvInfoFinalPanel/TextLv/TextNum")
	self.labelFirstAwardFinal = UIControls.Label(self, "LvInfoFinalPanel/AwardFirstPanel/TextTitle")
	self.firstAwardGridsFinal = {}
	self.labelLockFinal = UIControls.Label(self, "LvInfoFinalPanel/TextLock")

	self.labelLockFinal:setVisible(true)

	self.btnAddFinal = UIControls.Button(self, "LvInfoFinalPanel/AwardPanel/BtnAdd")

	self.btnAddFinal:addEventClick(self.onBtnAddClick)

	self.btnChangeFinal = UIControls.Button(self, "LvInfoFinalPanel/AwardPanel/BtnChange")

	self.btnChangeFinal:addEventClick(self.onBtnChangeClick)

	self.btnAwardMoreFinal = UIControls.Button(self, "LvInfoFinalPanel/AwardPanel/BtnMore")

	self.btnAwardMoreFinal:addEventClick(self.onBtnAwardMoreClick)

	self.panelHeroStoneFinal = UIControls.Panel(self, "LvInfoFinalPanel/AwardPanel/BgHeroStone")
	self.imgStoneHeroFinal = UIControls.Image(self, "LvInfoFinalPanel/AwardPanel/BgHeroStone/IconHero")

	self.panelHeroStone:setVisible(false)

	self.panelCleanFinal = UIControls.Panel(self, "LvInfoFinalPanel/FinalCleanPanel")
	self.btnCleanFinal = UIControls.Button(self, "LvInfoFinalPanel/FinalCleanPanel/BtnClean", "TextNum")
	self.imgCleanUpFinal = UIControls.Panel(self, "LvInfoFinalPanel/FinalCleanPanel/BtnClean/IconUp")

	self.btnCleanFinal:addEventClick(self.onCleanClick)

	self.txtCantCleanFinal = UIControls.Label(self, "LvInfoFinalPanel/FinalCleanPanel/BtnClean/TextNum")
	self.panelCleanUpFinal = UIControls.Panel(self, "LvInfoFinalPanel/FinalCleanPanel/CleanPanel")
	self.textCLeanUpFinal = UIControls.Label(self, "LvInfoFinalPanel/FinalCleanPanel/CleanPanel/TextClean")
	self.textCLeanUpTimeFinal = UIControls.Label(self, "LvInfoFinalPanel/FinalCleanPanel/CleanPanel/TextTime")
	self.panelFuncFinal = UIControls.Panel(self, "LvInfoFinalPanel/FuncPanel")
	self.btnBattleFinal = UIControls.Button(self, "LvInfoFinalPanel/FuncPanel/BtnBattle", "Text")

	self.btnBattleFinal:addEventClick(self.onBattleClick)

	self.imgBattleNewFinal = UIControls.Panel(self, "LvInfoFinalPanel/FuncPanel/BtnBattle/IconNewSpe")
	self.txtBattlePowerFinal = UIControls.Label(self, "LvInfoFinalPanel/FuncPanel/BtnBattle/TextNum")
	self.imgBattlePowerFinal = UIControls.Image(self, "LvInfoFinalPanel/FuncPanel/BtnBattle/IconEnergy")
	self.txtBuffDescFinal = UIControls.Label(self, "LvInfoFinalPanel/FuncPanel/TextBuff")
	self.aniRefreshBuffDesc = UIControls.UIAni(self, "LvInfoFinalPanel")
	self.btnReplayFainal = UIControls.Button(self, "LvInfoFinalPanel/FuncPanel/BtnReplay")

	self.btnReplayFainal:addEventClick(self.onReplayClick)
	self.btnReplayFainal:setVisible(true)

	self.labelTextLimitFinal = UIControls.Label(self, "LvInfoFinalPanel/AwardPanel/TextLimit")
	self.btnFinalAutoBattle = UIControls.Button(self, "LvInfoFinalPanel/FuncPanel/BtnAutoChallenge")

	self.btnFinalAutoBattle:addEventClick(self.onBtnAutoFightClick)

	self.btnsRank = {}

	local lvBasePath = "LvInfoFinalPanel/LvList/LvPanel"

	for i = 1, 5 do
		local path = lvBasePath .. i .. "/BtnLv"
		local btnRank = UIControls.Panel(self, path)

		btnRank.text = UIControls.Label(self, path .. "/TextLv")

		if i ~= 3 then
			btnRank.dis = UIControls.Image(self, path .. "Dis")
		end

		btnRank.idx = i
		self.btnsRank[i] = btnRank
	end
end

local MAX_LEVEL = 7

function EquipTowerLevelPage:setData(towerType)
	self.inOperation = false
	self.levelCells = {}
	self.configDatas = {}
	self.towerType = towerType
	self.towerData = CurAvatar.equipTowerData[towerType] or {}
	self.towerLimitInfo = self.towerData.limitTowerInfo or {}
	self.passedLevel = self.towerData.layer or 0

	local resData = ResEquipTower[towerType]

	self.resData = {}

	for index = 1, #resData do
		if resData[index].layer_type ~= Const.EQUIP_TOWER_LAYER_TYPE_FINAL then
			table.insert(self.resData, resData[index])
		end
	end

	if Const.OPEN_EQUIPTOWER_FINAL_LEVEL then
		local firstFinalLevel

		for index = 1, #resData do
			if resData[index].layer_type == Const.EQUIP_TOWER_LAYER_TYPE_FINAL then
				firstFinalLevel = index

				break
			end
		end

		self.firstFinalLevel = firstFinalLevel

		local nowLevel = self.passedLevel + 1

		if nowLevel == #resData + 1 then
			nowLevel = #resData
		end

		if firstFinalLevel then
			local defaultLevel = firstFinalLevel <= nowLevel and nowLevel or firstFinalLevel

			table.insert(self.resData, resData[defaultLevel])
		end
	end

	local maxLevel = #self.resData
	local startLevel = math.max(1, self.passedLevel - 1)

	startLevel = math.min(startLevel, maxLevel - MAX_LEVEL + 1)
	self.preSweepIndex = nil

	if not Const.EQUIP_TOWER_OPEN_CUSTOM_LAYER then
		for index = 1, MAX_LEVEL do
			local nIndex = startLevel + index - 1
			local levelData = self.resData[nIndex]

			table.insert(self.configDatas, {
				isSelect = false,
				data = levelData
			})
		end

		self.scrollViewLevel:cancelScroll()
	else
		for i, data in ipairs(self.resData) do
			table.insert(self.configDatas, {
				isSelect = false,
				data = data
			})
		end
	end

	if Const.OPEN_EQUIPTOWER_FINAL_LEVEL then
		self.resData = ResEquipTower[towerType]
	end

	self.finalLevelData = {}

	for index = 1, #self.resData do
		if self.resData[index].layer_type == Const.EQUIP_TOWER_LAYER_TYPE_FINAL then
			table.insert(self.finalLevelData, self.resData[index])
		end
	end

	self.preSweepIndex = self:getHighestLevelCanSweep()
	self.superTimes = CurAvatar:getEquipTowerSuperSweepTimes(self.towerType)

	local focusLayer = self.passedLevel

	if self.resData[self.passedLevel + 1] then
		self:AutoSelectLevel(self.passedLevel + 1)

		focusLayer = self.passedLevel + 1
	else
		self:AutoSelectLevel(self.passedLevel)
	end

	if Const.EQUIP_TOWER_OPEN_CUSTOM_LAYER then
		if self.towerData.hasSweepTimes then
			if self.preSweepIndex then
				self:refreshList(self.preSweepIndex)
			else
				self:refreshList(focusLayer)
			end
		else
			self:refreshList(focusLayer)
		end
	else
		self:refreshList()
	end
end

function EquipTowerLevelPage:AutoSelectLevel(level)
	for index, data in ipairs(self.configDatas) do
		if data.data.layer == level then
			if data.data.layer_type == Const.EQUIP_TOWER_LAYER_TYPE_FINAL then
				self.lvInfoPanel:setVisible(false)
				self.lvInfoPanelFinal:setVisible(true)
			else
				self.lvInfoPanel:setVisible(true)
				self.lvInfoPanelFinal:setVisible(false)
			end

			self:onSelectLevel(data)

			return
		end
	end
end

function EquipTowerLevelPage:onEquipTowerLevelBtnClick(checkData)
	for index, data in ipairs(self.configDatas) do
		data.isSelect = data == checkData
	end

	self.selectLevel = checkData.data.layer

	self:refreshList(self.selectLevel)

	self.delaySenderData = checkData

	self.aniInfoPanel:startAni("HideLvInfo", true)
	self.aniInfoPanel:addEventFinish(Slot(self.delaySelect, self))
end

function EquipTowerLevelPage:delaySelect()
	self.aniInfoPanel:clearEventFinish()

	if self.delaySenderData.data.layer_type ~= Const.EQUIP_TOWER_LAYER_TYPE_FINAL then
		self.lvInfoPanel:setVisible(true)
		self.lvInfoPanelFinal:setVisible(false)
	else
		self.lvInfoPanelFinal:setVisible(true)
		self.lvInfoPanel:setVisible(false)
	end

	self.aniInfoPanel:startAni("ShowLvInfo", true)

	if self.delaySenderData then
		self:_refreshLevelCommon()
	end
end

local MAX_GRID_NUM = 6

function EquipTowerLevelPage:onSelectLevel(checkData)
	self.selectLevel = checkData.data.layer

	for index, data in ipairs(self.configDatas) do
		data.isSelect = data == checkData
	end

	self:_refreshLevelCommon()
end

function EquipTowerLevelPage:refreshNowData()
	self.towerData = CurAvatar.equipTowerData[self.towerType] or {}

	self:_refreshLevelCommon()
end

function EquipTowerLevelPage:_refreshLevelCommon(...)
	if Const.EQUIP_TOWER_OPEN_CUSTOM_LAYER then
		self:_refreshCustomEquipLevel()
	else
		self:_refreshLevel()
	end
end

function EquipTowerLevelPage:refreshHeroChoose(...)
	self:_refreshCustomEquipLevel()
end

function EquipTowerLevelPage:refreshUI(...)
	self:refreshNowData()
	self:refreshList()
end

function EquipTowerLevelPage:getDropInfoByHeroId(heroId)
	for eId, info in pairs(ResEquipTowerCustomEquipEffect) do
		if info and #info > 0 and info[1].hero_id == heroId then
			local dropInfo = ResEquipTowerCustomEquipDrop[self.towerType]

			if dropInfo and dropInfo[heroId] then
				return dropInfo[heroId]
			end
		end
	end
end

function EquipTowerLevelPage:getHighestLevelCanSweep(...)
	for i = self.passedLevel, 1, -1 do
		local info = self.resData[i]

		if info and info.super_sweep_award then
			return i
		end
	end
end

function EquipTowerLevelPage:refreshList(focusLayer)
	local focusIndex

	if focusLayer then
		local isInSight = false
		local max, min = 0, math.huge

		for i, cell in pairs(self.levelCells) do
			if cell.data.data.layer == focusLayer then
				isInSight = true
			end

			max = math.max(max, cell.data.data.layer)
			min = math.min(min, cell.data.data.layer)
		end

		if not Const.EQUIP_TOWER_OPEN_CUSTOM_LAYER and (focusLayer == min or focusLayer == max) then
			isInSight = nil
		end

		if not isInSight then
			for i, data in ipairs(self.configDatas) do
				if focusLayer == data.data.layer then
					focusIndex = i

					break
				end
			end
		end
	end

	if self.firstFinalLevel and focusLayer and focusLayer >= self.firstFinalLevel then
		focusIndex = self.firstFinalLevel - 1
	end

	self.scrollViewLevel:setTotalCount(#self.configDatas, focusIndex)
end

function EquipTowerLevelPage:onCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = EquipTowerLevelBtnWrap(sender, "System/EquipTower/EquipTowerLvCell", newIdx, 0, 0)
		targetCell.index = newIdx
	end

	self.levelCells[targetCell.index] = nil
	self.levelCells[newIdx] = targetCell
	targetCell.index = newIdx

	targetCell:setData(self.configDatas[newIdx])
end

function EquipTowerLevelPage:_refreshCustomEquipLevel(...)
	self.levelData = self.resData[self.selectLevel] or {}

	if self.levelData.layer_type == Const.EQUIP_TOWER_LAYER_TYPE_FINAL then
		self.lvInfoPanel:setVisible(false)
		self.lvInfoPanelFinal:setVisible(true)
		self:_refreshFinalLevel()

		return
	end

	self.lvInfoPanel:setVisible(true)
	self.lvInfoPanelFinal:setVisible(false)
	self.panelSpecDesc1:setVisible(false)
	self.panelSpecDesc2:setVisible(false)

	self.superTimes = CurAvatar:getEquipTowerSuperSweepTimes(self.towerType)
	self.delaySenderData = nil
	self.isNormalTower = self.levelData.layer_type ~= Const.EQUIP_TOWER_LAYER_TYPE_CUSTOM and self.levelData.layer_type ~= Const.EQUIP_TOWER_LAYER_TYPE_STONE and self.levelData.layer_type ~= Const.EQUIP_TOWER_LAYER_TYPE_FINAL
	self.isStoneTower = self.levelData.layer_type == Const.EQUIP_TOWER_LAYER_TYPE_STONE
	self.isFinalTower = self.levelData.layer_type == Const.EQUIP_TOWER_LAYER_TYPE_FINAL
	self.pveId = self.levelData.pve_id

	if not self.isNormalTower then
		self.curSeason = CurAvatar:getEquipTowerLimitNumber()
		self.limitLayerState = self.towerLimitInfo[self.levelData.layer]
	else
		self.curSeason = nil
		self.limitHeroData = nil
	end

	local pveConfig = ResBattleConfig[self.pveId]
	local camp, fontColor

	if pveConfig and pveConfig.camp_limit then
		camp = pveConfig.camp_limit

		local campIcon = UIConst.getHeroCampBgIconPath(camp)

		self.bgGroup:setImage(campIcon[1], campIcon[2])
		self.bgTitle:setImage("Atlas/OtherBattleAtlas/EquipTowerAtlas", "BgBack0" .. camp)

		fontColor = ResColor["GROUP0" .. camp]

		self.textName:setFontColor(fontColor)
	end

	self.superNotice = utils.format(Lang.get(30501), self.levelData.name or "", self.superTimes)

	if not self.levelData.super_sweep_award or not (self.levelData.super_sweep_award > 0) then
		self.superTimes = 0
	end

	ClientUtils.CreateBonusGrid(self, self.firstAwardGrids, "LvInfoPanel/AwardFirstPanel/GridPanel", self.levelData.pass_award, true, nil, true)

	local passedBonusGot = false
	local isPassed = self.selectLevel <= self.passedLevel
	local canBattle = self.selectLevel == self.passedLevel + 1
	local remainTime = ClientUtils.getServerTimeNextDay() - ClientUtils.getServerTime() + 5
	local isChooseHero = self.towerData.resId > 0

	if self.isNormalTower then
		self.labelFirstAward:setText(Lang.get(995))
		self.imgRole:showRole(self.levelData.role_id)
		self.panelDesc:setVisible(true)
		self.panelEquipSpe:setVisible(false)
		self.panelHeroStone:setVisible(false)
		self.textCLeanUp:setVisible(true)
		self.btnClean:setVisible(true)
		self.panelEquipInfoSpe:setVisible(false)
		self.btnAdd:setVisible(false)
		self.btnChange:setVisible(false)

		if camp then
			self.textDescGroup:setText(Const.CAMP_CONFIG[camp].en_name)
			self.textDesc:setText(self.levelData.desc or "")
			self.textDescGroup:setFontColor(fontColor)
			self.textEngGroup:setFontColor(fontColor)
			self.imgDescGroup:setObjColor(fontColor)
		end

		self.imgBattleNew:setVisible(false)
		self.panelSweepBonus:setVisible(true)
		self.panelSpecialBonus:setVisible(false)
	else
		if not isChooseHero then
			self.btnAdd:setVisible(true)
			self.btnChange:setVisible(false)
			self.panelEquipInfoSpe:setVisible(false)
			self.imgHero:setVisible(false)
			self.imgSuit:setVisible(false)
			self.imgStoneHero:setVisible(false)
		else
			self.btnAdd:setVisible(false)
			self.btnChange:setVisible(true)
			self.panelEquipInfoSpe:setVisible(true)
			self.imgHero:setVisible(true)
			self.imgSuit:setVisible(true)
			self.imgStoneHero:setVisible(true)

			local heroId = self.towerData.resId
			local dropInfo = self:getDropInfoByHeroId(heroId)

			self.dropInfo = dropInfo

			local suitInfo

			if dropInfo then
				suitInfo = ResEquipSuit[dropInfo.suit_id]

				self.imgSuit:setImage("Atlas/CommonAtlas/" .. suitInfo.iconPath, suitInfo.icon)
			end

			local hero = CurAvatar.heroDic[self.towerData.gid]

			hero = hero or BaseObject.GetObject(heroId)

			if hero then
				local path = hero:getIconPath()

				self.imgHero:setImage(path[1], path[2])
				self.imgStoneHero:setImage(path[1], path[2])
			end

			if hero and suitInfo then
				if self.isStoneTower then
					self.txtEquipSpeDesc:setText(utils.format(ClientUtils.getClientNotice(657), hero.name, suitInfo.name))
				else
					self.txtEquipSpeDesc:setText(utils.format(ClientUtils.getClientNotice(494), hero.name, suitInfo.name))
				end
			end
		end

		self.imgRole:setVisible(false)

		if self.isStoneTower then
			self.panelEquipSpe:setVisible(false)
			self.panelHeroStone:setVisible(true)
		else
			self.panelEquipSpe:setVisible(true)
			self.panelHeroStone:setVisible(false)
		end

		self.panelDesc:setVisible(false)
		self.textCLeanUp:setVisible(true)
		self.btnClean:setVisible(true)

		if camp then
			self.textLimitName:setFontColor(fontColor)
			self.textLimitEng:setText(Const.CAMP_CONFIG[camp].en_name)
			self.textLimitEng:setFontColor(fontColor)
			self.imgLimitLine:setObjColor(fontColor)
			self.imgLimitUp:setObjColor(fontColor)
			self.imgSpec2UL:setObjColor(fontColor)
			self.imgSpec2BR:setObjColor(fontColor)
			self.imgSpecialBonus:setObjColor(fontColor)
		end

		self.panelSweepBonus:setVisible(true)
		self.panelSpecialBonus:setVisible(false)
	end

	if self.isNormalTower or isChooseHero then
		self.panelAward:setVisible(true)
		ClientUtils.CreateBonusGrid(self, self.awardGrids, "LvInfoPanel/AwardPanel/GridPanel", self.levelData.normal_sweep_award, false, MAX_GRID_NUM, true)

		if not self.isNormalTower then
			for i, grid in ipairs(self.awardGrids) do
				if grid:getVisible() and grid.object.itemType == Const.ITEM_TYPE_EQUIP_TEMPLETE and grid.object.isHeroDefine == 1 then
					grid.object:setDefineEffectId(self.dropInfo.effect_id)
					grid.object:setSuitIds({
						self.dropInfo.suit_id
					})
					grid:setObj(grid.object)
				end

				if self.isStoneTower and grid.object.resData.subtype == Const.ITEM_STYPE_BUILD_STONE and isChooseHero then
					grid.grid:showBgHero(self.towerData.resId)
				end
			end
		end
	else
		self.panelAward:setVisible(false)
	end

	local bonus = ResRandClient[self.levelData.normal_sweep_award] or {}
	local showIds = bonus.show_ids or {}

	if self.isNormalTower then
		self.btnAwardMore:setVisible(#showIds > MAX_GRID_NUM)
	else
		self.btnAwardMore:setVisible(#showIds > MAX_GRID_NUM and isChooseHero)
	end

	self.checkCanEnter = false

	if isPassed then
		self.btnAutoBattle:setVisible(false)
		self.labelLock:setText("")
		self.panelFunc:setVisible(true)
		self.btnClean:setEnable(true)
		self.txtCantClean:setVisible(false)
		self.btnBattle:setVisible(true)
		self.btnBattle:setEnable(false)
		self.txtBattlePower:setVisible(false)
		self.imgBattlePower:setVisible(false)
		self.btnBattle:setText(Lang.get(724))
		self.textPassDesc:setVisible(false)

		passedBonusGot = true

		self.panelCleanUp:setVisible(true)
		self.textCLeanUp:setText(self.superNotice)
		ClientTimerManager.AddSecondFormatTickUI(self.textCleanUpTime, remainTime, false, Lang.get(48670))

		if self.superTimes > 0 then
			self.imgCleanUp:setVisible(true)
		else
			self.imgCleanUp:setVisible(false)
		end
	elseif canBattle then
		self.checkCanEnter = true

		self.labelLock:setText("")
		self.panelFunc:setVisible(true)
		self.btnClean:setEnable(false)
		self.txtCantClean:setVisible(true)
		self.btnBattle:setVisible(true)
		self.btnBattle:setEnable(true)
		self.txtBattlePower:setVisible(true)
		self.txtBattlePower:setText("0")
		self.imgBattlePower:setVisible(true)
		self.btnBattle:setText(Lang.get(699))
		self.imgCleanUp:setVisible(false)
		self.panelCleanUp:setVisible(false)
		self.textPassDesc:setVisible(true)
		self.textPassDesc:setText(self.levelData.pass_desc or "")
		self.btnClean:setVisible(false)

		if self.passedLevel >= 39 then
			self.btnAutoBattle:setVisible(true)
		else
			self.btnAutoBattle:setVisible(false)
		end
	else
		self.btnAutoBattle:setVisible(false)
		self.btnBattle:setVisible(false)

		if self.resData[self.selectLevel - 1] then
			self.labelLock:setText(utils.format(Lang.get(30502), self.selectLevel - 1, self.resData[self.selectLevel - 1].name or ""))
		end

		self.panelFunc:setVisible(false)
		self.imgCleanUp:setVisible(false)
		self.panelCleanUp:setVisible(false)
		self.textPassDesc:setVisible(true)
		self.textPassDesc:setText(self.levelData.pass_desc or "")
	end

	self.btnClean:setText(self.levelData.power_cost or 0)
	self.textNum:setText(self.selectLevel)
	self.textName:setText(self.levelData.name or "")

	for index, grid in ipairs(self.firstAwardGrids) do
		grid:setGet(passedBonusGot)
	end
end

function EquipTowerLevelPage:_refreshFinalLevel()
	self.lvInfoPanel:setVisible(false)
	self.lvInfoPanelFinal:setVisible(true)

	self.superTimes = CurAvatar:getEquipTowerSuperSweepTimes(self.towerType)
	self.delaySenderData = nil
	self.levelData = self.resData[self.selectLevel] or {}
	self.isNormalTower = false
	self.isFinalTower = true
	self.isStoneTower = true
	self.pveId = self.levelData.pve_id
	self.curSeason = CurAvatar:getEquipTowerLimitNumber()
	self.limitLayerState = self.towerLimitInfo[self.levelData.layer]

	local pveConfig = ResBattleConfig[self.pveId]
	local camp, fontColor

	if pveConfig and pveConfig.camp_limit then
		camp = pveConfig.camp_limit

		local campIcon = UIConst.getHeroCampBgIconPath(camp)

		self.bgGroupFinal:setImage(campIcon[1], campIcon[2])
		self.bgTitleFinal:setImage("Atlas/OtherBattleAtlas/EquipTowerAtlas5", "BgFinalBack0" .. camp)

		fontColor = ResColor["GROUP0" .. camp]
	end

	self.superNotice = utils.format(Lang.get(30501), self.levelData.name or "", self.superTimes)

	ClientUtils.CreateBonusGrid(self, self.firstAwardGridsFinal, "LvInfoFinalPanel/AwardFirstPanel/GridPanel", self.levelData.pass_award, true, nil, true)

	local passedBonusGot = false
	local isPassed = self.selectLevel <= self.passedLevel
	local canBattle = self.selectLevel == self.passedLevel + 1
	local remainTime = ClientUtils.getServerTimeNextDay() - ClientUtils.getServerTime() + 5
	local isChooseHero = self.towerData.resId > 0

	for index, grid in ipairs(self.firstAwardGridsFinal) do
		grid:setGet(isPassed)
	end

	if not isChooseHero then
		self.btnAddFinal:setVisible(true)
		self.btnChangeFinal:setVisible(false)
		self.imgStoneHeroFinal:setVisible(false)
	else
		self.btnAddFinal:setVisible(false)
		self.btnChangeFinal:setVisible(true)

		local heroId = self.towerData.resId
		local dropInfo = self:getDropInfoByHeroId(heroId)

		self.dropInfo = dropInfo

		local suitInfo

		if dropInfo then
			suitInfo = ResEquipSuit[dropInfo.suit_id]
		end

		local hero = CurAvatar.heroDic[self.towerData.gid]

		hero = hero or BaseObject.GetObject(heroId)

		if hero then
			local path = hero:getIconPath()

			self.imgStoneHeroFinal:setVisible(true)
			self.imgStoneHeroFinal:setImage(path[1], path[2])
		end
	end

	self.panelHeroStoneFinal:setVisible(true)
	self.textCLeanUpFinal:setVisible(true)
	self.btnCleanFinal:setVisible(true)
	self.btnAwardMoreFinal:setVisible(isChooseHero)

	self.checkCanEnter = false

	if isPassed then
		self.labelLockFinal:setText("")
		self.panelFuncFinal:setVisible(true)
		self.panelCleanFinal:setVisible(true)
		self.btnCleanFinal:setEnable(true)
		self.txtCantCleanFinal:setVisible(false)
		self.btnBattleFinal:setVisible(true)
		self.btnBattleFinal:setEnable(false)
		self.txtBattlePowerFinal:setVisible(false)
		self.imgBattlePowerFinal:setVisible(false)
		self.btnBattleFinal:setText(Lang.get(724))

		passedBonusGot = true

		self.panelCleanUpFinal:setVisible(true)
		self.textCLeanUpFinal:setText(self.superNotice)
		ClientTimerManager.AddSecondFormatTickUI(self.textCLeanUpTimeFinal, remainTime, false, Lang.get(48670))

		if self.levelData.layer ~= self.firstFinalLevel then
			if self.superTimes > 0 then
				self.imgCleanUpFinal:setVisible(true)
			else
				self.imgCleanUpFinal:setVisible(false)
			end
		end

		self.btnFinalAutoBattle:setVisible(false)
	elseif canBattle then
		if self.levelData.layer ~= self.firstFinalLevel then
			if self.superTimes > 0 then
				self.imgCleanUpFinal:setVisible(true)
			else
				self.imgCleanUpFinal:setVisible(false)
			end
		end

		self.labelLockFinal:setText("")

		self.checkCanEnter = true

		self.panelFuncFinal:setVisible(true)
		self.panelCleanFinal:setVisible(true)
		self.btnCleanFinal:setEnable(false)
		self.txtCantCleanFinal:setVisible(true)
		self.btnBattleFinal:setVisible(true)
		self.btnBattleFinal:setEnable(true)
		self.txtBattlePowerFinal:setVisible(true)
		self.txtBattlePowerFinal:setText("0")
		self.imgBattlePowerFinal:setVisible(true)
		self.panelCleanUpFinal:setVisible(true)
		self.textCLeanUpFinal:setText(self.superNotice)
		ClientTimerManager.AddSecondFormatTickUI(self.textCLeanUpTimeFinal, remainTime, false, Lang.get(48670))
		self.btnBattleFinal:setText(Lang.get(699))

		if self.passedLevel >= 39 then
			self.btnFinalAutoBattle:setVisible(true)
		else
			self.btnFinalAutoBattle:setVisible(false)
		end
	else
		self.btnFinalAutoBattle:setVisible(false)
		self.btnBattleFinal:setVisible(false)

		if self.resData[self.selectLevel - 1] then
			self.labelLockFinal:setText(utils.format(Lang.get(30502), self.selectLevel - 1, self.resData[self.selectLevel - 1].name or ""))
		end

		self.panelFuncFinal:setVisible(false)
		self.panelCleanFinal:setVisible(false)
		self.panelCleanUpFinal:setVisible(false)
	end

	self.btnCleanFinal:setText(self.levelData.power_cost or 0)

	for index, grid in ipairs(self.firstAwardGrids) do
		grid:setGet(passedBonusGot)
	end

	if self.levelData.layer ~= self.firstFinalLevel then
		self.btnCleanFinal:setEnable(true)
		self.txtCantCleanFinal:setVisible(false)
		self.labelTextLimitFinal:setVisible(false)
	else
		if self.passedLevel < self.firstFinalLevel - 1 then
			self.labelTextLimitFinal:setVisible(false)
		else
			self.labelTextLimitFinal:setVisible(true)
			self.labelTextLimitFinal:setText(utils.format(Lang.get(75650), constTowerName[self.levelData.type]))
		end

		self.panelCleanUpFinal:setVisible(false)
		self.btnCleanFinal:setVisible(false)
	end

	if EquipTowerLevelPage[self.towerType] and self.passedLevel ~= EquipTowerLevelPage[self.towerType] then
		if self.passedLevel ~= #self.resData then
			self.aniRefreshBuffDesc:startAni("FinalChallenge", true)
		end

		EquipTowerLevelPage[self.towerType] = self.passedLevel
	end

	self.txtBuffDescFinal:setText(self.levelData.buff_desc)

	self.tgtRank = math.max(self.passedLevel + 2 - self.firstFinalLevel, 1)

	if self.tgtRank > #self.finalLevelData then
		self.tgtRank = #self.finalLevelData
	end

	if self.tgtRank < 10 then
		self.textNameFinal:setText(string.format("0%s", self.tgtRank))
	else
		self.textNameFinal:setText(string.format("%s", self.tgtRank))
	end

	local sizeOfFinal = 0

	for k, v in pairs(self.resData) do
		if v.layer_type == Const.EQUIP_TOWER_LAYER_TYPE_FINAL then
			sizeOfFinal = sizeOfFinal + 1
		end
	end

	local startrank = self.tgtRank - 3

	for i = 1, 5 do
		local rank = startrank + i
		local textRank

		if rank < 10 then
			textRank = string.format("0%s", rank)
		else
			textRank = string.format("%s", rank)
		end

		if i ~= 3 then
			if rank < 1 or sizeOfFinal < rank then
				self.btnsRank[i]:setVisible(false)
				self.btnsRank[i].dis:setVisible(true)
			else
				self.btnsRank[i].dis:setVisible(false)
				self.btnsRank[i]:setVisible(true)
				self.btnsRank[i].text:setText(textRank)
			end
		else
			self.btnsRank[i]:setVisible(true)
			self.btnsRank[i].text:setText(textRank)
		end
	end
end

function EquipTowerLevelPage:_refreshLevel()
	self.superTimes = CurAvatar:getEquipTowerSuperSweepTimes(self.towerType)
	self.delaySenderData = nil
	self.levelData = self.resData[self.selectLevel] or {}
	self.isNormalTower = self.levelData.layer_type ~= Const.EQUIP_TOWER_LAYER_TYPE_WEEK
	self.pveId = self.levelData.pve_id

	if not self.isNormalTower then
		self.curSeason = CurAvatar:getEquipTowerLimitNumber()
		self.limitLayerState = self.towerLimitInfo[self.levelData.layer]
		self.limitHeroData = ResEquipTowerLimitHero[self.towerType][self.curSeason][self.levelData.layer]
		self.pveId = self.limitHeroData.battle_id
	else
		self.curSeason = nil
		self.limitHeroData = nil
	end

	local pveConfig = ResBattleConfig[self.pveId]
	local camp, fontColor

	if pveConfig and pveConfig.camp_limit then
		camp = pveConfig.camp_limit

		local campIcon = UIConst.getHeroCampBgIconPath(camp)

		self.bgGroup:setImage(campIcon[1], campIcon[2])
		self.bgTitle:setImage("Atlas/OtherBattleAtlas/EquipTowerAtlas", "BgBack0" .. camp)

		fontColor = ResColor["GROUP0" .. camp]

		self.textName:setFontColor(fontColor)
	end

	self.superNotice = utils.format(Lang.get(30501), self.levelData.name or "", self.superTimes)

	if not self.levelData.super_sweep_award or not (self.levelData.super_sweep_award > 0) then
		self.superTimes = 0
	end

	ClientUtils.CreateBonusGrid(self, self.firstAwardGrids, "LvInfoPanel/AwardFirstPanel/GridPanel", self.levelData.pass_award, true, nil, true)

	local passedBonusGot = false
	local isPassed = self.selectLevel <= self.passedLevel
	local canBattle = self.selectLevel == self.passedLevel + 1
	local remainTime = ClientUtils.getServerTimeNextDay() - ClientUtils.getServerTime() + 5

	if self.isNormalTower then
		self.labelFirstAward:setText(Lang.get(995))
		self.imgRole:showRole(self.levelData.role_id)
		self.panelDesc:setVisible(true)
		self.panelSpecDesc1:setVisible(false)
		self.panelSpecDesc2:setVisible(false)
		self.textCLeanUp:setVisible(true)
		self.btnClean:setVisible(true)

		if camp then
			self.textDescGroup:setText(Const.CAMP_CONFIG[camp].en_name)
			self.textDesc:setText(self.levelData.desc or "")
			self.textDescGroup:setFontColor(fontColor)
			self.textEngGroup:setFontColor(fontColor)
			self.imgDescGroup:setObjColor(fontColor)
		end

		self.imgBattleNew:setVisible(false)
		self.panelSweepBonus:setVisible(true)
		self.panelSpecialBonus:setVisible(false)
		ClientUtils.CreateBonusGrid(self, self.awardGrids, "LvInfoPanel/AwardPanel/GridPanel", self.levelData.normal_sweep_award, false, MAX_GRID_NUM, true)

		local bonus = ResRandClient[self.levelData.normal_sweep_award] or {}
		local showIds = bonus.show_ids or {}

		self.btnAwardMore:setVisible(#showIds > MAX_GRID_NUM)
	else
		self.labelFirstAward:setText(Lang.get(30503))
		self.imgRole:showRole(self.limitHeroData.role_id)
		self.textLimitDesc:setText(self.limitHeroData.buff_desc or "")

		local heroId = self.limitHeroData.limit_hero_id

		if ResHero[heroId] then
			self.textLimitName:setText(ResHero[heroId].hero_name or "")
		end

		self.panelDesc:setVisible(false)
		self.panelSpecDesc1:setVisible(true)
		self.panelSpecDesc2:setVisible(true)
		self.textCLeanUp:setVisible(false)
		self.btnClean:setVisible(false)

		if camp then
			self.textLimitName:setFontColor(fontColor)
			self.textLimitEng:setText(Const.CAMP_CONFIG[camp].en_name)
			self.textLimitEng:setFontColor(fontColor)
			self.imgLimitLine:setObjColor(fontColor)
			self.imgLimitUp:setObjColor(fontColor)
			self.imgSpec2UL:setObjColor(fontColor)
			self.imgSpec2BR:setObjColor(fontColor)
			self.imgSpecialBonus:setObjColor(fontColor)
		end

		self.panelSweepBonus:setVisible(false)
		self.panelSpecialBonus:setVisible(true)
		ClientUtils.CreateBonusGrid(self, self.limitAwardGrids, "LvInfoPanel/SpeAwardPanel/GridPanel", self.levelData.limit_hero_award, true, MAX_GRID_NUM, true)

		local bonus = ResRandClient[self.levelData.limit_hero_award] or {}
		local showIds = bonus.show_ids or {}

		self.btnLimitAwardMore:setVisible(#showIds > MAX_GRID_NUM)

		local limitBonusGot = false

		if self.limitLayerState == 3 then
			passedBonusGot = true
			limitBonusGot = true
			isPassed = true
			canBattle = false
			remainTime = CurAvatar:getEquipTowerLimitRefreshTick()
		else
			if self.limitLayerState == 1 then
				passedBonusGot = true
			end

			isPassed = false
			canBattle = self.selectLevel <= self.passedLevel + 1
		end

		for index, grid in ipairs(self.limitAwardGrids) do
			grid:setGet(limitBonusGot)
		end

		if CurAvatar:isEquipTowerLimitNew(self.levelData.type, self.levelData.layer) then
			self.imgBattleNew:setVisible(true)
		else
			self.imgBattleNew:setVisible(false)
		end
	end

	self.checkCanEnter = false

	if isPassed then
		self.labelLock:setText("")
		self.panelFunc:setVisible(true)
		self.btnClean:setEnable(true)
		self.txtCantClean:setVisible(false)
		self.btnBattle:setVisible(true)
		self.btnBattle:setEnable(false)
		self.txtBattlePower:setVisible(false)
		self.imgBattlePower:setVisible(false)
		self.btnBattle:setText(Lang.get(724))
		self.textPassDesc:setVisible(false)

		passedBonusGot = true

		self.panelCleanUp:setVisible(true)
		self.textCLeanUp:setText(self.superNotice)
		ClientTimerManager.AddSecondFormatTickUI(self.textCleanUpTime, remainTime, false, Lang.get(48670))

		if self.superTimes > 0 then
			self.imgCleanUp:setVisible(true)
		else
			self.imgCleanUp:setVisible(false)
		end
	elseif canBattle then
		self.checkCanEnter = true

		self.labelLock:setText("")
		self.panelFunc:setVisible(true)
		self.btnClean:setEnable(false)
		self.txtCantClean:setVisible(true)
		self.btnBattle:setVisible(true)
		self.btnBattle:setEnable(true)
		self.txtBattlePower:setVisible(true)
		self.txtBattlePower:setText("0")
		self.imgBattlePower:setVisible(true)
		self.btnBattle:setText(Lang.get(699))
		self.imgCleanUp:setVisible(false)
		self.panelCleanUp:setVisible(false)
		self.textPassDesc:setVisible(true)
		self.textPassDesc:setText(self.levelData.pass_desc or "")
	else
		self.btnBattle:setVisible(false)

		if self.resData[self.selectLevel - 1] then
			self.labelLock:setText(utils.format(Lang.get(30502), self.selectLevel - 1, self.resData[self.selectLevel - 1].name or ""))
		end

		self.panelFunc:setVisible(false)
		self.imgCleanUp:setVisible(false)
		self.panelCleanUp:setVisible(false)
		self.textPassDesc:setVisible(true)
		self.textPassDesc:setText(self.levelData.pass_desc or "")
	end

	self.btnClean:setText(self.levelData.power_cost or 0)
	self.textNum:setText(self.selectLevel)
	self.textName:setText(self.levelData.name or "")

	for index, grid in ipairs(self.firstAwardGrids) do
		grid:setGet(passedBonusGot)
	end
end

function EquipTowerLevelPage:refreshCleanTimes()
	if self.levelData and self.levelData.power_cost then
		self.enableTimers = math.min(10, math.floor(CurAvatar.realPowerNum / self.levelData.power_cost))
	end
end

function EquipTowerLevelPage:destroy(...)
	EquipTowerLevelPage.super.destroy(self)

	if self.coSelectLevel then
		coroutine.stop(self.coSelectLevel)

		self.coSelectLevel = nil
	end
end

function EquipTowerLevelPage:onBtnChangeClick(...)
	UIManager.getUI("equipTowerChooseSuitDlg", true):show(self.towerType, self.selectLevel)
end

function EquipTowerLevelPage:onBtnAddClick(...)
	UIManager.getUI("equipTowerChooseSuitDlg", true):show(self.towerType, self.selectLevel)
end

function EquipTowerLevelPage:onCleanClick()
	if self.levelData and self.levelData.power_cost then
		local needPower = self.levelData.power_cost

		if needPower <= CurAvatar.realPowerNum then
			if self.levelData.no_equip_bag ~= 1 and CurAvatar:getEquipRemainBlankNum() <= 0 then
				CurAvatar:confirmBagAdd(Const.BAG_TYPE_EQUIP)

				return
			end

			local defaultMutilSweep = self.levelData.layer >= Const.EQUIP_TOWER_HIGH_DEF_SWEEP_LAYER and 10 or 3

			UIManager.getUI("sweepMainDlg", true):initForSweepInfo(Const.GAME_PLAY_NOTICE_EQUIP_TOWER, Slot(self.sweepEquipTower, self), Const.MONEY_ID_POWER, self.levelData.power_cost, {
				superTimes = self.superTimes,
				superNotice = self.superNotice,
				defSweepCount = defaultMutilSweep
			})

			self.inOperation = true
		else
			UIManager.getUI("buyCapacityDlg", true):initBuyType()
		end
	end
end

local function NoSweepCb()
	local sweepMainDlg = UIManager.getUI("sweepMainDlg", nil, false)

	if sweepMainDlg then
		sweepMainDlg.lastSweepTick = 0
	end
end

function EquipTowerLevelPage:sweepEquipTower(times)
	local layer = self.levelData.layer
	local type = self.levelData.type

	if self.isFinalTower then
		for index = layer, 1, -1 do
			if index <= self.passedLevel and self.resData[index].super_sweep_award then
				layer = index

				break
			end
		end
	end

	if not self.levelData.no_equip_bag and CurAvatar:getEquipRemainBlankNum() <= 0 then
		local sweepMainDlg = UIManager.getUI("sweepMainDlg", nil, false)

		if sweepMainDlg then
			sweepMainDlg:setVisible(false)
		end

		CurAvatar:confirmBagAdd(Const.BAG_TYPE_EQUIP)

		return
	end

	local superTimes = CurAvatar:getEquipTowerSuperSweepTimes(self.levelData.type)

	if superTimes and times <= superTimes or not self.levelData.super_sweep_award then
		RPC.equipTowerSweep(type, layer, times)
	else
		UIManager.showConfirmWithId(1046, Functor(RPC.equipTowerSweep, type, layer, times), NoSweepCb)
	end
end

function EquipTowerLevelPage:onBattleClick()
	EquipTowerLevelPage[self.towerType] = self.passedLevel

	if Const.EQUIP_TOWER_OPEN_CUSTOM_LAYER and self.levelData and self.levelData.layer_type == Const.EQUIP_TOWER_LAYER_TYPE_CUSTOM and (not self.towerData.resId or self.towerData.resId == 0) then
		local content = ClientUtils.getClientNotice(495)

		UIManager.showConfirmWithId(1066, Slot(self.onBtnAddClick, self))

		return
	end

	if self.levelData then
		local battleData = {}

		battleData.equipTowerData = {}
		battleData.equipTowerData.type = self.levelData.type
		battleData.equipTowerData.layer = self.levelData.layer
		battleData.equipTowerData.limitHeroData = self.limitHeroData
		battleData.equipTowerData.curSeason = self.curSeason

		if self.levelData.no_equip_bag ~= 1 and CurAvatar:getEquipRemainBlankNum() <= 0 then
			CurAvatar:confirmBagAdd(Const.BAG_TYPE_EQUIP)
		else
			if self.levelData.layer_type == Const.EQUIP_TOWER_LAYER_TYPE_WEEK then
				if not Const.EQUIP_TOWER_LIMIT_LOOKED[self.levelData.type] then
					Const.EQUIP_TOWER_LIMIT_LOOKED[self.levelData.type] = {}
				end

				Const.EQUIP_TOWER_LIMIT_LOOKED[self.levelData.type][self.levelData.layer] = true

				CurAvatar:checkEquipTowerRD()
			end

			CurAvatar:enterFormation(self.pveId, BattleConst.BATTLE_TYPE_EQUIPTOWER, battleData)
		end
	end
end

function EquipTowerLevelPage:onBtnAutoFightClick()
	local battleAutoChallengeDlg = UIManager.getUI("battleAutoChallengeDlg", true)

	battleAutoChallengeDlg:setData(BattleConst.BATTLE_TYPE_EQUIPTOWER, {
		towerType = self.levelData.type
	})
	battleAutoChallengeDlg:bindWindow(self.mWindow)
end

function EquipTowerLevelPage:onReplayClick()
	if self.levelData then
		self.mParent:onReplayClick(self.levelData.type, self.levelData.layer, self.checkCanEnter, Slot(self.onBattleClick, self))
	end
end

function EquipTowerLevelPage:onBtnAwardMoreClick()
	local ui = UIManager.getUI("equipTowerMoreAwardDlg", true)

	if self.levelData.layer_type ~= Const.EQUIP_TOWER_LAYER_TYPE_FINAL then
		ui:setData(self.levelData.normal_sweep_award)
	else
		for index = self.levelData.layer, 1, -1 do
			if self.resData[index].normal_sweep_award then
				ui:setData(self.resData[index].normal_sweep_award)

				break
			end
		end
	end

	if Const.EQUIP_TOWER_OPEN_CUSTOM_LAYER then
		local heroId = self.towerData.resId
		local dropInfo = self:getDropInfoByHeroId(heroId)

		if dropInfo then
			ui:checkCustomEquip(dropInfo.suit_id, dropInfo.effect_id, heroId)
		end
	end
end

function EquipTowerLevelPage:onBtnLimitAwardMoreClick()
	UIManager.getUI("equipTowerMoreAwardDlg", true):setData(self.levelData.limit_hero_award)
end

local strClassName = "EquipTowerLevelDlg"
local EquipTowerLevelDlg = Class(strClassName, UIControls.Window)

function EquipTowerLevelDlg:ctor()
	self:initUI()
end

function EquipTowerLevelDlg:onOpen()
	EquipTowerLevelDlg.super.onOpen(self)
	CurAvatar:checkPushGiftTrigger(self.mUIName, Const.ON_WINDOW_OPEN)
end

function EquipTowerLevelDlg:initUI()
	self.btnClose = UIControls.Button(self, "BtnClose", "Text")

	self.btnClose:addEventClick(self.onCloseClick)

	self.dragPages = DragTwoPages(self, "MainInfoPanel/Mask/ContentPanel1", "MainInfoPanel/Mask/ContentPanel2", "MainInfoPanel/BtnPre", "MainInfoPanel/BtnNext")
	self.dragPages.dragEvent = Slot(self.onDragEvent, self)

	local page1 = EquipTowerLevelPage(self, "MainInfoPanel/Mask/ContentPanel1", "System/EquipTower/EquipTowerLvInfoPanel")

	page1:setVisible(true)

	local page2 = EquipTowerLevelPage(self, "MainInfoPanel/Mask/ContentPanel2", "System/EquipTower/EquipTowerLvInfoPanel")

	page2:setVisible(true)

	self.pages = {
		page1,
		page2
	}
	self.imgPriVilege = UIControls.Image(self, "ImgPrivilege")
end

function EquipTowerLevelDlg:onCloseClick()
	self:setVisible(false)
	CurAvatar:checkPushGiftTrigger(self.mUIName, Const.ON_WINDOW_CLOSE)
end

function EquipTowerLevelDlg:refreshBgImg(towerType)
	return
end

function EquipTowerLevelDlg:playImgAnim()
	return
end

function EquipTowerLevelDlg:onbgAnimFinish(sender, aniName)
	return
end

function EquipTowerLevelDlg:onReplayClick(eType, layer, checkCanEnter, onBattleClick)
	self.checkCanEnter = checkCanEnter
	self.onBattleClick = onBattleClick

	if self.recordData and self.recordData[eType] and self.recordData[eType][layer] then
		self:onEquipTowerReplayRecordResp(eType, layer, self.recordData[eType][layer])
	else
		RPC.equipTowerReplayRecord(eType, layer)
	end
end

function EquipTowerLevelDlg:onEquipTowerReplayRecordResp(eType, layer, data)
	if not self.recordData then
		self.recordData = {}
	end

	if not self.recordData[eType] then
		self.recordData[eType] = {}
	end

	self.recordData[eType][layer] = data

	local extra = {
		battleType = BattleConst.BATTLE_TYPE_EQUIPTOWER,
		checkCanEnter = self.checkCanEnter,
		onBattleClick = self.onBattleClick,
		type = eType
	}

	UIManager.getUI("onceTowerRecordDlg", true):setData(Const.BATTLE_REPLAY_EQUIP_TOWER, data, {
		eType,
		layer
	}, extra)
end

function EquipTowerLevelDlg:refreshData(towerType)
	self.dragPages:initPage(3, towerType)
	self.imgPriVilege:setVisible(CurAvatar:checkPrivielgeMonthCardEffect())
end

function EquipTowerLevelDlg:jumpToTowerLayer(jumpArg)
	local args = utils.splitString(jumpArg, ",")
	local equipTowerType = args[1]
	local layer = args[2]

	self:showTowerLayer(equipTowerType, layer)
end

function EquipTowerLevelDlg:showTowerLayer(equipTowerType, layer)
	self.dragPages:initPage(3, equipTowerType)
	self.pages[self.currentPanelIndex]:AutoSelectLevel(layer)
end

function EquipTowerLevelDlg:onDragEvent(sender, currentPageIndex, panelIndex, isOnOpen)
	if self.pages[panelIndex].delaySenderData then
		self.pages[panelIndex].delaySenderData = nil
	end

	self.currentPageIndex = currentPageIndex

	if isOnOpen == nil then
		self:playImgAnim()
	end

	if Const.CAMP_CONFIG[self.currentPageIndex] then
		self.btnClose:setText(Const.CAMP_CONFIG[self.currentPageIndex].name)
	end

	self.currentPanelIndex = panelIndex

	self.pages[panelIndex]:setData(self.currentPageIndex)
end

function EquipTowerLevelDlg:onEquipTowerDataNotify(equipTowerType, layer)
	if self.currentPageIndex == equipTowerType then
		self.pages[self.currentPanelIndex]:setData(self.currentPageIndex)
	end
end

function EquipTowerLevelDlg:onEquipTowerSweepResp()
	if self.currentPanelIndex then
		self.pages[self.currentPanelIndex].inOperation = false

		self.pages[self.currentPanelIndex]:refreshUI()
	end
end

function EquipTowerLevelDlg:onEquipTowerSuperSweepDataNotify()
	if self.currentPanelIndex then
		local page = self.pages[self.currentPanelIndex]

		page:refreshNowData()

		local sweepMainDlg = UIManager.tryGetUI("sweepMainDlg")

		if sweepMainDlg then
			sweepMainDlg:refreshEquipTowerSweepInfo(page.superTimes, page.superNotice)
		end
	end
end

function EquipTowerLevelDlg:onEquipTowerChooseHeroResp(type, layer, hero_id, gid)
	if self.currentPanelIndex then
		self.pages[self.currentPanelIndex]:refreshHeroChoose()
	end
end

return EquipTowerLevelDlg
