-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Hero\\HeroShowRoomGrowUpDlg.lua

local BattleConst = require("Common/FrameBattle/BattleConst")
local MaterialItemGridChild = require("UI/Common/Grid/MaterialItemGridChild")
local HeroAttrPanel = require("UI/Hero/HeroAttrPanel")
local ResDevelopDesc = require("ClientData/ResDevelopDesc")
local ResDevelopMisc = require("ClientData/ResDevelopMisc")
local ResRelationLetterName = require("ClientData/ResRelationLetterName")
local ResItem = require("ClientData/ResItem")
local ResGuideGet = require("ClientData/ResGuideGet")
local ModelFactory = Framework.Entity.ModelFactory
local EventConst = require("EventConst")
local ModelTool = require("Entity/ModelTool")
local ResVowContent = require("ClientData/ResVowContent")
local ResBossTowerExpandLevel = require("ClientData/ResBossTowerExpandLevel")
local ResRandClient = require("ClientData/ResRandClient")
local ResColor = require("ClientData/ResColor")
local ResVowMisc = require("ClientData/ResVowMisc")
local STATUS_LOCKED = 1
local STATUS_UNLOCK = 2
local STATUS_CANLVUP = 3
local DEVELOP_EFFECT_PATHS = {
	{
		"Effects/UI/efx_ui_upgrade__model_01.prefab",
		"Effects/UI/efx_ui_upgrade__AttrPane_01.prefab",
		"Effects/UI/efx_ui_upgrade__Hero_01.prefab",
		"Effects/UI/efx_ui_upgrade__fly_01.prefab"
	},
	{
		"Effects/UI/efx_ui_upgrade__model_02.prefab",
		"Effects/UI/efx_ui_upgrade__AttrPane_02.prefab",
		"Effects/UI/efx_ui_upgrade__Hero_02.prefab",
		"Effects/UI/efx_ui_upgrade__fly_02.prefab"
	},
	{
		"Effects/UI/efx_ui_upgrade__model_02.prefab",
		"Effects/UI/efx_ui_upgrade__AttrPane_02.prefab",
		"Effects/UI/efx_ui_upgrade__Hero_02.prefab",
		"Effects/UI/efx_ui_upgrade__fly_02.prefab"
	}
}
local DEVELOP_TEXT_DATA = {
	{
		Lang.get(49876),
		Lang.get(49878),
		Lang.get(50650)
	},
	{
		Lang.get(63938),
		Lang.get(63939),
		Lang.get(66395)
	}
}
local TITLE_NOTICE_ID = {
	620,
	621,
	620,
	663
}
local CHOOSE_ANIM_NAME = {
	"ChooseBook",
	"ChooseEquip",
	"ChooseVideo",
	"ChooseLoveBook"
}
local strClassName = "GrowUpBtnTab"
local GrowUpBtnTab = Class(strClassName, UIControls.Panel)

function GrowUpBtnTab:ctor()
	self:initUI()
end

function GrowUpBtnTab:initUI()
	self.panelUnlock = UIControls.Panel(self, self.mPath .. "/UnlockPanel")
	self.txtNum = UIControls.Label(self, self.mPath .. "/TextPanel/TextNum")
	self.panelTxtNum = UIControls.Panel(self, self.mPath .. "/TextPanel")
	self.imgItemIcon = UIControls.Image(self, self.mPath .. "/UnlockPanel/Icon")
	self.panelLock = UIControls.Panel(self, self.mPath .. "/LockPanel")
	self.imgIconNew = UIControls.Panel(self, self.mPath .. "/UnlockPanel/Icon/IconNew")
	self.btnSelf = UIControls.Button(self, self.mPath)

	self.btnSelf:addEventClick(self.onBtnSelfClick)
end

function GrowUpBtnTab:setStatus(status, relationPoint)
	self.status = status
	self.relationPoint = relationPoint

	self.panelUnlock:setVisible(self.status == STATUS_UNLOCK or self.status == STATUS_CANLVUP)
	self.panelLock:setVisible(self.status == STATUS_LOCKED)
	self.panelTxtNum:setVisible(self.status == STATUS_CANLVUP)

	local packType = self.mWindow.roomHero:getPackTypeByRelationId(relationPoint)

	self.isVowPoint = packType == Const.RELATION_DESC_VOW

	local relationPointLv = self.mWindow.roomHero:getRelationPointLevel(self.relationPoint)
	local maxLevel = ResDevelopMisc[self.relationPoint].max_level

	if self.status == STATUS_CANLVUP then
		self.txtNum:setText(string.format("<color=#d86d25>%s</color>/%s", relationPointLv, maxLevel))
		self.imgIconNew:setVisible(CurAvatar.realtionHeroListTop3[self.mWindow.roomHero.id] ~= nil)
	else
		self.imgIconNew:setVisible(false)
	end

	if self.status == STATUS_UNLOCK then
		if relationPointLv < maxLevel then
			self:setImageToUnknown()
		elseif not self.isVowPoint then
			local itemIconPath = self.mWindow.roomHero:getRelationPlotIconPath(self.relationPoint)

			if itemIconPath then
				self.imgItemIcon:setImage(itemIconPath[1], itemIconPath[2])
			end
		else
			local colors = self.mWindow.roomHero:getRelationPlotDesc(relationPoint).color_bg

			self.imgItemIcon:setColorByRGBA(colors[1], colors[2], colors[3])
		end
	else
		self:setImageToUnknown()
	end

	if self.isVowPoint then
		local lastPointId = relationPoint - 1
		local lastLv = self.mWindow.roomHero:getRelationPointLevel(lastPointId)
		local lastMaxLevel = ResDevelopMisc[lastPointId].max_level

		if lastMaxLevel <= lastLv then
			self:setVisible(true)
		end
	end
end

function GrowUpBtnTab:setImageToUnknown()
	if self.isVowPoint then
		return
	end

	local unknownIconPath = self.mWindow.roomHero:getRelationPlotUnknownIconPath(self.relationPoint)

	if unknownIconPath then
		self.imgItemIcon:setImage(unknownIconPath[1], unknownIconPath[2])
	end
end

function GrowUpBtnTab:onBtnSelfClick(sender)
	if self.mWindow.isPlayingEfx then
		return
	end

	if self.relationPoint then
		if self.status == STATUS_LOCKED then
			MsgManager.clientNotice(622)
		else
			self.mWindow:onSelectGrowTab(self.relationPoint)
			self.mWindow:openGrowUpPanel(self.relationPoint)
		end
	end
end

local strClassName = "HeroShowRoomGrowUpDlg"
local HeroShowRoomGrowUpDlg = Class(strClassName, UIControls.Window)

function HeroShowRoomGrowUpDlg:ctor()
	self._slot4LoadNewModelEnd = Slot(self.loadNewModel, self)

	self:initUI()

	self.costIdList = {}
	self.costNumList = {}
end

function HeroShowRoomGrowUpDlg:initUI()
	self.isShowInfo = true
	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.btnTips = UIControls.Button(self, "BtnTips")

	self.btnTips:addEventClick(self.onBtnTipsClick)

	self.gridMaterialList = {}
	self.btnTabPanelList = {}

	for i = 1, 7 do
		local tabPanel = GrowUpBtnTab(self, "TabPanel/BtnTab" .. i)

		self.btnTabPanelList[i] = tabPanel
	end

	self.btnArticleList = {}

	for i = 1, 4 do
		local btnPath = "MainInfoPanel/InfoPanel/BtnArticle" .. i
		local btnArticle = UIControls.Button(self, btnPath)

		btnArticle:addEventClick(self.onBtnArticleClick)

		local efxArticle = UIControls.LazyEffectPlayer(self, btnPath .. "/Efx")
		local iconPath = i ~= 2 and btnPath .. "/Icon" or btnPath .. "/Icon/Icon"
		local imgArticleIcon = UIControls.Image(self, iconPath)
		local txtArticleName = UIControls.Label(self, btnPath .. "/TextName")

		self.btnArticleList[i] = {
			Btn = btnArticle,
			Efx = efxArticle,
			Icon = imgArticleIcon,
			Text = txtArticleName
		}

		if i == 3 then
			self.articleTipPanel = UIControls.Panel(self, btnPath .. "/BgProgress")
			self.textArticleTip = UIControls.Label(self, btnPath .. "/BgProgress/TextRule")
		end
	end

	self.btnClean = UIControls.Button(self, "MainInfoPanel/InfoPanel/BtnClean")

	self.btnClean:addEventClick(self.onBtnCleanClick)

	self.txtHeroName = UIControls.Label(self, "MainInfoPanel/InfoPanel/BgName/TextHeroName")
	self.aniInfoPanel = UIControls.UIAni(self, "MainInfoPanel/InfoPanel")
	self.txtProgress = UIControls.Label(self, "MainInfoPanel/InfoPanel/AttrPanel/LvPanel/TextNum")
	self.textLvDesc = UIControls.Label(self, "MainInfoPanel/InfoPanel/AttrPanel/LvPanel/Text")
	self.btnUpgrade = UIControls.Button(self, "MainInfoPanel/InfoPanel/BtnUpgrade")

	self.btnUpgrade:addEventClick(self.onBtnUpgradeClick)

	self.btnUniversal = UIControls.Button(self, "MainInfoPanel/InfoPanel/BtnUniversal")
	self.paneUniversallIconNew = UIControls.Panel(self, "MainInfoPanel/InfoPanel/BtnUniversal/IconNew")

	self.btnUniversal:addEventClick(self.onBtnUniversalClick)

	self.imgUpgradeNml = UIControls.Image(self, "MainInfoPanel/InfoPanel/BtnUpgrade/ImgNml")
	self.textUpgradeNml = UIControls.Label(self, "MainInfoPanel/InfoPanel/BtnUpgrade/ImgNml/Text")
	self.imgUpgradeLock = UIControls.Image(self, "MainInfoPanel/InfoPanel/BtnUpgrade/ImgLock")
	self.txtUpgradeLock = UIControls.Label(self, "MainInfoPanel/InfoPanel/BtnUpgrade/ImgLock/Text")
	self.panelEnergy = UIControls.Panel(self, "MainInfoPanel/InfoPanel/EnergyPanel")
	self.imgUpgradeIconNew = UIControls.Image(self, "MainInfoPanel/InfoPanel/BtnUpgrade/ImgNml/IconNew")
	self.efxModelUI = UIControls.LazyEffectPlayer(self, "ModelViewport/Efx")
	self.btnMaxArticle = UIControls.Button(self, "MainInfoPanel/InfoPanel/LvMaxPanel/BtnArticle")

	self.btnMaxArticle:addEventClick(self.onBtnArticleClick)

	self.textMax = UIControls.Label(self, "MainInfoPanel/InfoPanel/LvMaxPanel/BtnArticle/Text")
	self.gridCleanNumTxtList = {}

	for i = 1, 3 do
		local txtClean = UIControls.Label(self, "MainInfoPanel/InfoPanel/EnergyPanel/GridPanel" .. i .. "/TextNumClean")

		self.gridCleanNumTxtList[i] = txtClean
	end

	self.gridBtns = {}

	for i = 1, 3 do
		local btnGrid = UIControls.Button(self, "MainInfoPanel/InfoPanel/EnergyPanel/GridBtnGroup/Button" .. i)

		btnGrid:addEventClick(Functor(self.onBtnGridClick, self, i))

		self.gridBtns[i] = btnGrid
	end

	self.textCostPowerNum = UIControls.Label(self, "MainInfoPanel/InfoPanel/BtnClean/ImgCurrency/TextNum")
	self.panelLvMax = UIControls.Panel(self, "MainInfoPanel/InfoPanel/LvMaxPanel")
	self.attrPanelList = {}
	self.attrEfxComList = {}

	for i = 1, 2 do
		local attrPanel = HeroAttrPanel(self, "MainInfoPanel/InfoPanel/AttrPanel/AttrPanel" .. i)

		self.attrPanelList[i] = attrPanel

		local efxCom = UIControls.LazyEffectPlayer(self, "MainInfoPanel/InfoPanel/AttrPanel/AttrPanel" .. i .. "/Efx")

		self.attrEfxComList[i] = efxCom
	end

	self.modelViewport = UIControls.RawImage(self, "ModelViewport")
	self.uiAni = UIControls.UIAni(self, "")
	self.imgBgImage = UIControls.RawImage(self, "BgImage")
	self.imgCleanIconNew = UIControls.Image(self, "MainInfoPanel/InfoPanel/BtnClean/IconNew")
	self.slot4RefreshData = Slot(self.refreshItemGrid, self)

	EventCenter.addEventListener(EventConst.ITEM_UPDATE, self.slot4RefreshData)
end

function HeroShowRoomGrowUpDlg:onOpen()
	HeroShowRoomGrowUpDlg.super.onOpen(self)

	if self.openRefresh then
		self:refreshDetailInfo()

		self.openRefresh = false
	end
end

function HeroShowRoomGrowUpDlg:refreshItemGrid()
	if not self.isMaxLevel then
		self.openRefresh = true
	end

	self:refreshDetailInfo()
end

local DRAG_ROTATE_SPEED = 240

function HeroShowRoomGrowUpDlg:onDrag(delta)
	local deltaX = math.abs(delta.x)

	if not self.modelTransform then
		return
	end

	local angles = self.modelTransform.eulerAngles

	angles.y = angles.y - delta.x * DRAG_ROTATE_SPEED
	self.modelTransform.eulerAngles = angles
end

function HeroShowRoomGrowUpDlg:setRoomHero(roomHero)
	self.roomHero = roomHero

	if not self.roomShowChild then
		self.roomShowChild = UIControls.Child(self, "RoomShowTeamPanel", "System/HeroShowRoom/ChildRoomShowTeam0" .. self.roomHero.roomInfo.team_id, 0, 0, true)
	end

	self.imgBgImage:setImage("NoAlpha/HeroShowRoom/BgTeam0" .. self.roomHero.roomInfo.team_id)

	if not self.tab6LockPanel then
		self.tab6LockPanel = UIControls.Child(self, "TabPanel/BtnTab6/LockPanel", "System/HeroShowRoom/Tab6LockPanel0" .. self.roomHero.roomInfo.team_id, 0, 0, true)
	end

	if not self.modelStage then
		self.modelStage = ModelStageManager.createUIModelStage(self, "ModelStage/NewTeamDlgModelStage_01")

		self.modelStage:connectImage(self.modelViewport)
	end

	if self.curModelInsId then
		self.autoRotateComponent = nil

		self.modelStage:delModel(self.curModelInsId)
	end

	local modelId = self.roomHero:getShowModelId()
	local baseModelId = self.roomHero:getShowBaseModelId()

	self.curModelInsId = self.modelStage:showHeroByModId(modelId, Const.MODEL_TYPE.ShowStepOne, nil, self._slot4LoadNewModelEnd, nil, baseModelId)

	self.txtHeroName:setText(self.roomHero.name)

	self.curRelationPoint = self.roomHero:getCurRelationPoint()

	self:refreshGrowTabShowInfo()

	if self.curRelationPoint > 0 then
		if self.btnTabPanelList[self.curRelationPoint] then
			self:onSelectGrowTab(self.curRelationPoint)
		end
	else
		local unlockStage = self.roomHero:getRelationUnlockStage()
		local relationPointData = self.roomHero:getRelationPointData()
		local selRelation = 1

		if relationPointData then
			for relationPoint, pointData in ipairs(relationPointData) do
				if unlockStage >= ResDevelopMisc[relationPoint].develop_stage then
					selRelation = relationPoint
				end
			end
		end

		if self.btnTabPanelList[selRelation] then
			self:onSelectGrowTab(selRelation)
		end
	end
end

function HeroShowRoomGrowUpDlg:onSelectGrowTab(relationPoint)
	self.curSelectRelation = relationPoint

	for i, btnTab in ipairs(self.btnTabPanelList) do
		btnTab.btnSelf:setEnable(i ~= relationPoint)
	end

	self:refreshDetailInfo(true)
end

function HeroShowRoomGrowUpDlg:refreshGrowTabShowInfo()
	for relationPoint, btnTabPanel in ipairs(self.btnTabPanelList) do
		if self.curRelationPoint == relationPoint then
			btnTabPanel:setStatus(STATUS_CANLVUP, relationPoint)
		elseif ResDevelopMisc[relationPoint].develop_stage <= self.roomHero:getRelationUnlockStage() then
			btnTabPanel:setStatus(STATUS_UNLOCK, relationPoint)
		else
			btnTabPanel:setStatus(STATUS_LOCKED, relationPoint)
		end
	end
end

function HeroShowRoomGrowUpDlg:refreshArticleShow(plotData)
	local pos, titleDes, iconPath
	local pack_type = plotData.relation_pack_type

	if not self.isMaxLevel then
		local unknownIconPath = self.roomHero:getRelationPlotUnknownIconPath(self.curSelectRelation)

		if unknownIconPath then
			iconPath = unknownIconPath
		end

		local noticeId = TITLE_NOTICE_ID[pack_type]

		if noticeId then
			titleDes = ClientUtils.getClientNotice(noticeId)
		end

		if pack_type == Const.RELATION_DESC_ITEM then
			pos = 0
		end
	elseif pack_type == Const.RELATION_DESC_ITEM then
		local descInfo = self.roomHero:getRelationPlotDesc(self.curSelectRelation)

		titleDes = descInfo and descInfo.title
		iconPath = self.roomHero:getRelationPlotIconPath(self.curSelectRelation)
		pos = iconPath and iconPath[3] or 0
	else
		local descInfo = self.roomHero:getRelationPlotDesc(self.curSelectRelation)

		titleDes = descInfo and descInfo.letter_name
		iconPath = self.roomHero:getRelationPlotIconPath(self.curSelectRelation)
	end

	for i, btnArtivle in ipairs(self.btnArticleList) do
		local isCurType = i == pack_type

		btnArtivle.Btn:setVisible(isCurType)

		if isCurType then
			if iconPath then
				btnArtivle.Icon:setImage(iconPath[1], iconPath[2])

				if pos then
					btnArtivle.Icon:setPosition(nil, pos)
				end
			end

			if titleDes then
				btnArtivle.Text:setText(titleDes)
			end
		end
	end
end

function HeroShowRoomGrowUpDlg:refreshArticleTip()
	if self.packType == Const.RELATION_DESC_AVG and not self.isMaxLevel then
		local progressCount = self.curSelectRelationLv >= 5 and 10 or 5

		self.articleTipPanel:setVisible(true)

		local tipsDesc = string.format(Lang.get(68621), progressCount)

		self.textArticleTip:setText(tipsDesc)
	else
		self.articleTipPanel:setVisible(false)
	end
end

function HeroShowRoomGrowUpDlg:refreshDetailInfo(ignoreRefreshTab)
	if not ignoreRefreshTab then
		self.curRelationPoint = self.roomHero:getCurRelationPoint()

		self:refreshGrowTabShowInfo()
	end

	local plotData = self.roomHero.resDevelopPlotData[self.curSelectRelation]

	self.packType = plotData.relation_pack_type
	self.curSelectRelationLv = self.roomHero:getRelationPointLevel(self.curSelectRelation)

	local maxLevel = ResDevelopMisc[self.curSelectRelation].max_level

	self.txtProgress:setText(string.format("<color=#d86d25>%s</color>/%s", self.curSelectRelationLv, maxLevel))

	self.isMaxLevel = maxLevel <= self.curSelectRelationLv

	self:refreshArticleShow(plotData)
	self:refreshPropPanel()
	self:refreshArticleTip()

	local textIndex = self.packType ~= Const.RELATION_DESC_VOW and 1 or 2
	local textData = DEVELOP_TEXT_DATA[textIndex]

	if not self.isMaxLevel then
		self.panelEnergy:setVisible(true)
		self.panelLvMax:setVisible(false)

		self.curRelationPoint = self.roomHero:getCurRelationPoint()

		local materialEnough = self:refreshMaterialInfo()

		self:refreshSweepOrUpgrade(materialEnough, textData)
	else
		self.panelEnergy:setVisible(false)
		self.btnClean:setVisible(false)
		self.btnUpgrade:setVisible(false)
		self.panelLvMax:setVisible(true)
		self.textMax:setText(textData[3])
	end

	self.textLvDesc:setText(textData[1])
	self.btnUniversal:setVisible(CurAvatar.checkUniversalVowOpen and not self.isMaxLevel and self.curRelationPoint == self.curSelectRelation and self.packType ~= Const.RELATION_DESC_VOW)
end

function HeroShowRoomGrowUpDlg:refreshSweepOrUpgrade(materialEnough, textData)
	local isCurRelation = self.curRelationPoint == self.curSelectRelation

	self.btnUpgrade:setEnable(true)

	if isCurRelation and materialEnough then
		self.btnUpgrade:setVisible(true)
		self.imgUpgradeNml:setVisible(true)
		self.textUpgradeNml:setText(textData[2])
		self.imgUpgradeIconNew:setVisible(CurAvatar.realtionHeroListTop3[self.roomHero.id] ~= nil)
		self.imgUpgradeLock:setVisible(false)
		self.btnClean:setVisible(false)
	elseif isCurRelation then
		local lackMaterials = self.roomHero:getRelationPointNeedMaterial(self.curSelectRelation, true)

		self.curSweepMaterial = nil

		for _, idNum in ipairs(lackMaterials) do
			if CurAvatar:getRelationMaterialCanSweep(idNum.id) then
				self.curSweepMaterial = idNum.id

				break
			end
		end

		local canSweepAll, costAllPower, sweepTable, lackSweepTimes = self:checkCanSweepAllMaterial()

		self.btnClean:setEnable(not lackSweepTimes)
		self.textCostPowerNum:setText(costAllPower)

		local haveCostNum = ClientUtils.getMoney(Const.MONEY_ID_POWER)

		if haveCostNum < costAllPower then
			self.textCostPowerNum:setFontColor(ResColor.RED)
		else
			self.textCostPowerNum:setFontColor(ResColor.WHITE)
		end

		self.btnClean:setVisible(self.curSweepMaterial ~= nil)
		self.btnUpgrade:setVisible(self.curSweepMaterial == nil)

		if self.curSweepMaterial then
			self.imgCleanIconNew:setVisible(CurAvatar.realtionHeroListTop3[self.roomHero.id] ~= nil)
		else
			self.imgUpgradeNml:setVisible(false)
			self.imgUpgradeLock:setVisible(true)
			self.txtUpgradeLock:setText(ClientUtils.getClientNotice(618))
		end
	else
		self.btnUpgrade:setEnable(false)
		self.btnUpgrade:setVisible(true)
		self.imgUpgradeNml:setVisible(false)
		self.imgUpgradeLock:setVisible(true)
		self.txtUpgradeLock:setText(ClientUtils.getClientNotice(619))
		self.btnClean:setVisible(false)
	end
end

function HeroShowRoomGrowUpDlg:refreshMaterialInfo()
	self.costIdList = {}
	self.costNumList = {}
	self.relationMaterials = self.roomHero:getRelationPointNeedMaterial(self.curSelectRelation)

	local materialEnough = true
	local isNotVow = self.packType ~= Const.RELATION_DESC_VOW

	if self.relationMaterials then
		for i, _ in ipairs(self.gridCleanNumTxtList) do
			if self.gridCleanNumTxtList[i] then
				self.gridCleanNumTxtList[i]:setVisible(false)
			end
		end

		for i, idNum in ipairs(self.relationMaterials) do
			if not self.gridMaterialList[i] then
				self.gridMaterialList[i] = MaterialItemGridChild(self, "MainInfoPanel/InfoPanel/EnergyPanel/GridPanel" .. i, "System/Common/Grid/GridMaterialItem", 0, 0, true)
				self.gridMaterialList[i].uiConfig = {
					AutoOpenGuide = 1
				}
			end

			local curCount = CurAvatar:getItemNumById(idNum.id)

			self.gridMaterialList[i].imgAdd2:setVisible(curCount < idNum.num)
			table.insert(self.costIdList, idNum.id)
			table.insert(self.costNumList, math.max(idNum.num - curCount, 0))

			if isNotVow then
				local towerType, layer = CurAvatar:getRelationMaterialLayer(idNum.id)

				if curCount < idNum.num then
					materialEnough = false

					if not CurAvatar:checkBossExpandCanSweep(towerType, layer) then
						self.gridMaterialList[i]:setAddPanel(2)
						self.gridBtns[i]:setVisible(false)
					else
						self.gridBtns[i]:setVisible(true)

						if CurAvatar:getRelationMaterialCanSweep(idNum.id) then
							self.gridMaterialList[i]:setAddPanel(1)
						else
							self.gridMaterialList[i]:destroyAddPanel()
						end
					end
				end

				if CurAvatar:checkBossExpandCanSweep(towerType, layer) then
					if self.gridCleanNumTxtList[i] then
						self.gridCleanNumTxtList[i]:setVisible(true)

						local remainCount, totalCount = CurAvatar:getBossExpandSweepCount(towerType)

						self.gridCleanNumTxtList[i]:setText(string.format(Lang.get(50541), remainCount))

						local color = remainCount > 0 and ResColor.WHITE or ResColor.RED

						self.gridCleanNumTxtList[i]:setFontColor(color)
					end
				else
					self.gridBtns[i]:setVisible(false)
				end
			else
				self.gridBtns[i]:setVisible(false)
				self.gridMaterialList[i].imgAdd2:setVisible(false)
			end

			self.gridMaterialList[i].needNum = idNum.num

			self.gridMaterialList[i]:setMaterial(idNum.id, idNum.num)
		end

		for i = #self.relationMaterials + 1, #self.gridMaterialList do
			if self.gridMaterialList[i] then
				self.gridMaterialList[i]:destroy()

				self.gridMaterialList[i] = nil
			end
		end
	end

	self.needUniversalVowId = self:checkNeedUniversalVowId()

	self.paneUniversallIconNew:setVisible(self.needUniversalVowId and self:checkUniversalVowIdEnough())

	return materialEnough
end

function HeroShowRoomGrowUpDlg:checkNeedUniversalVowId()
	if not self.costIdList or #self.costIdList == 0 then
		return false
	end

	local totalNum = 0

	for _, num in ipairs(self.costNumList) do
		totalNum = totalNum + num
	end

	return totalNum > 0
end

function HeroShowRoomGrowUpDlg:checkUniversalVowIdEnough()
	local costIdList = utils.copyTable(self.costIdList)
	local costNumList = utils.copyTable(self.costNumList)
	local universalIdList = {}
	local universalDataList = {}
	local _, resVowMisc = next(ResVowMisc)
	local universalVowIdList = resVowMisc.universalVowIds

	if universalVowIdList then
		for _, universalId in ipairs(universalVowIdList) do
			local resItem = ResItem[universalId]
			local itemNum = CurAvatar:getItemNumById(universalId)

			if itemNum > 0 then
				for _, random_id in ipairs(resItem.extend_args3) do
					local resRandClient = ResRandClient[random_id]

					if ClientUtils.IsRandomValid(random_id) and resRandClient.show_ids then
						local id = resRandClient.show_ids[1]
						local num = resRandClient.show_nums[1]

						if num ~= 1 then
							-- block empty
						else
							for j, costId in ipairs(costIdList) do
								if id == costId then
									local costNum = costNumList[j]

									if costNum > 0 then
										if costNum <= itemNum then
											costNumList[j] = 0
											itemNum = itemNum - costNum
										else
											return false
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end

	for _, num in ipairs(costNumList) do
		if num > 0 then
			return false
		end
	end

	return true
end

function HeroShowRoomGrowUpDlg:checkCanSweepAllMaterial()
	local needMaterials = self.roomHero:getRelationPointNeedMaterial(self.curSelectRelation)
	local isNotVow = self.packType ~= Const.RELATION_DESC_VOW
	local canSweep = true
	local lackSweepTimes = false
	local costAllPower = 0
	local sweepTable = {}

	if needMaterials then
		for i, idNum in ipairs(needMaterials) do
			if isNotVow then
				local curCount = CurAvatar:getItemNumById(idNum.id)
				local towerType, layer = CurAvatar:getRelationMaterialLayer(idNum.id)

				if curCount < idNum.num then
					if not CurAvatar:checkBossExpandCanSweep(towerType, layer) then
						canSweep = false
						lackSweepTimes = true
					else
						local remainCount, totalCount = CurAvatar:getBossExpandSweepCount(towerType)

						if not CurAvatar:getRelationMaterialCanSweep(idNum.id) then
							canSweep = false

							if remainCount <= 0 then
								lackSweepTimes = true
							end
						else
							local bossExpandLevel = CurAvatar:getBossExpandSweepDiff(towerType, layer)
							local levelConfig = ResBossTowerExpandLevel[towerType][layer]
							local towerRes = levelConfig[bossExpandLevel]
							local getNumOnce = 1

							if towerRes then
								local costNum = towerRes.power_cost
								local rewardIdSweep = towerRes.clean_award
								local randItemSweep = ResRandClient[rewardIdSweep]

								for i, id in ipairs(randItemSweep.show_ids) do
									if id == idNum.id then
										getNumOnce = randItemSweep.show_nums and randItemSweep.show_nums[i] and randItemSweep.show_nums[i] or 1
									end
								end

								local needSweepTimes = math.ceil((idNum.num - curCount) / getNumOnce)

								costAllPower = costAllPower + costNum * needSweepTimes

								local haveCostNum = ClientUtils.getMoney(Const.MONEY_ID_POWER)

								if remainCount <= 0 or remainCount < needSweepTimes or haveCostNum < costAllPower then
									canSweep = false
								end

								if remainCount <= 0 or remainCount < needSweepTimes then
									lackSweepTimes = true
								end

								local data = {}

								data.tower = towerType
								data.layer = layer
								data.level = bossExpandLevel
								data.times = needSweepTimes

								table.insert(sweepTable, data)
							end
						end
					end
				end
			end
		end
	end

	return canSweep, costAllPower, sweepTable, lackSweepTimes
end

function HeroShowRoomGrowUpDlg:refreshPropPanel()
	local propCount = 0

	if self.isMaxLevel then
		if self.packType ~= Const.RELATION_DESC_VOW then
			local curPropData = self.roomHero:getRelationConfData(self.curSelectRelation, self.curSelectRelationLv).prop or {}

			for i, info in ipairs(curPropData) do
				local propName = BattleConst.PROP_TYPE_CONFIG[info.type]

				if self.attrPanelList[i] then
					self.attrPanelList[i]:setVisible(true)
					self.attrPanelList[i].txtOriValue:setVisible(true)
					self.attrPanelList[i]:setPropInfo(propName, info.value)
				end

				propCount = propCount + 1
			end
		else
			local vowContent = ResVowContent[self.roomHero.id]

			if vowContent then
				local battleStateDesc = vowContent.state_desc

				propCount = propCount + 1

				self.attrPanelList[propCount]:setVisible(true)
				self.attrPanelList[propCount]:setBattleStateDesc(battleStateDesc, vowContent.state_value .. "%")
			end
		end
	elseif self.packType ~= Const.RELATION_DESC_VOW then
		local nextPropData = self.roomHero:getRelationConfData(self.curSelectRelation, self.curSelectRelationLv + 1).prop or {}
		local curPropData = {}

		if self.curSelectRelationLv > 0 then
			curPropData = self.roomHero:getRelationConfData(self.curSelectRelation, self.curSelectRelationLv).prop or {}
		end

		local propInfos = {}

		for i, info in ipairs(nextPropData) do
			local propInfo = {}

			propInfo.propName = BattleConst.PROP_TYPE_CONFIG[info.type]

			if curPropData[i] then
				propInfo.value = curPropData[i].value
			else
				propInfo.value = 0
			end

			propInfo.targetValue = info.value

			table.insert(propInfos, propInfo)

			propCount = propCount + 1
		end

		for i, propInfo in ipairs(propInfos) do
			if self.attrPanelList[i] then
				self.attrPanelList[i]:setVisible(true)
				self.attrPanelList[i].txtOriValue:setVisible(true)
				self.attrPanelList[i]:setPropInfo(propInfo.propName, propInfo.value, propInfo.targetValue)
			end
		end
	else
		local vowContent = ResVowContent[self.roomHero.id]

		if vowContent then
			local battleStateDesc = vowContent.state_desc

			propCount = propCount + 1

			self.attrPanelList[propCount]:setVisible(true)
			self.attrPanelList[propCount]:setBattleStateDesc(battleStateDesc, 0, vowContent.state_value .. "%")
		end
	end

	for i = propCount + 1, #self.attrPanelList do
		self.attrPanelList[i]:setVisible(false)
	end
end

function HeroShowRoomGrowUpDlg:onBtnGridClick(index)
	if self.gridMaterialList[index] then
		local materialId = self.gridMaterialList[index].object.id
		local towerType, layer = CurAvatar:getRelationMaterialLayer(materialId)
		local sweepMainDlg = UIManager.getUI("sweepMainDlg", true)

		sweepMainDlg:sweepBossExpand(towerType .. "," .. layer, self.gridMaterialList[index])
	end
end

function HeroShowRoomGrowUpDlg:onDragStart()
	if self.autoRotateComponent then
		self.autoRotateComponent:EndRotate()
	end
end

function HeroShowRoomGrowUpDlg:onDragEnd()
	if self.autoRotateComponent then
		self.autoRotateComponent:StartRotate()
	end
end

function HeroShowRoomGrowUpDlg:loadNewModel(modelInsId, modelResID)
	self.curModelInsId = modelInsId

	if self.curModelInsId then
		self.modelStage:setOperateModel(self.curModelInsId)

		if modelInsId then
			local modelAux = ModelFactory.GetModelAux(modelInsId)

			if modelAux then
				modelAux:SetAnimatorNoCulling()
				modelAux:PlayAnimatorNow("Newshow_idle")

				self.modelTransform = modelAux.transform
			end
		end
	end

	ModelTool.modelPlayAnimationNow(modelInsId, "Newshow_idle")

	if modelResID then
		ModelTool.addBaseModel(modelInsId, modelResID, 1, Const.HERO_BASE_TYPE.Hero1)
	end
end

function HeroShowRoomGrowUpDlg:openShowArticleDlg(relationIdx)
	local openRelationIdx = relationIdx or self.curSelectRelation
	local plotData = self.roomHero.resDevelopPlotData[openRelationIdx]
	local descInfo
	local maxLevel = ResDevelopMisc[openRelationIdx].max_level
	local isMaxLevel = maxLevel <= self.curSelectRelationLv

	if relationIdx or isMaxLevel then
		descInfo = ResDevelopDesc[plotData.relation_pack_id]
	end

	local pack_type = plotData.relation_pack_type
	local teamId = self.roomHero.roomInfo.team_id
	local letterNameInfo = ResRelationLetterName[teamId][openRelationIdx]

	if pack_type == Const.RELATION_DESC_LETTER and letterNameInfo then
		local heroShowRoomStoryDlg = UIManager.getUI("heroShowRoomStoryDlg", true)

		heroShowRoomStoryDlg:setRelationDescResData(descInfo, letterNameInfo, self.roomHero, relationIdx ~= nil)
	elseif pack_type == Const.RELATION_DESC_ITEM then
		local heroShowRoomPartsDlg = UIManager.getUI("heroShowRoomPartsDlg", true)
		local itemIconPath = self.roomHero:getRelationPlotIconPath(openRelationIdx)

		heroShowRoomPartsDlg:setRelationDescResData(descInfo, itemIconPath, relationIdx ~= nil)
	elseif pack_type == Const.RELATION_DESC_AVG then
		local heroShowRoomVideoDlg = UIManager.getUI("heroShowRoomVideoDlg", true)
		local colorData = self.roomHero:getRelationTeamColor()

		if relationIdx then
			heroShowRoomVideoDlg:setCallBack(function()
				self.stopBtnClick = false
			end)

			local itemIconPath

			if isMaxLevel then
				itemIconPath = self.roomHero:getRelationPlotIconPath(relationIdx)
			end

			heroShowRoomVideoDlg:setAcquireIconPath(itemIconPath)
		end

		local letterNameInfo = ResRelationLetterName[self.roomHero.team][openRelationIdx]

		heroShowRoomVideoDlg:setVideoData(self.curSelectRelationLv, maxLevel, colorData, plotData, letterNameInfo.letter_name)
	elseif pack_type == Const.RELATION_DESC_VOW then
		local heroShowRoomLoveBookDlg = UIManager.getUI("heroShowRoomLoveBookDlg", true)
		local colorData = self.roomHero:getRelationTeamColor()

		heroShowRoomLoveBookDlg:setLoveBookData(self.roomHero.id, isMaxLevel, self.roomHero.name, colorData, plotData.avg_id[1])
	end
end

function HeroShowRoomGrowUpDlg:playUpgradeEffect(relation, level)
	if self.curModelInsId then
		local developStage = ResDevelopMisc[relation].develop_stage
		local effectPathData = DEVELOP_EFFECT_PATHS[developStage]
		local efxPath = effectPathData[1]
		local attrEfxPath = effectPathData[2]
		local modelUIEfxPath = effectPathData[3]
		local effectPath = effectPathData[4]

		self.btnArticleList[developStage].Efx:playEffectByPath(effectPath)
		self.efxModelUI:playEffectByPath(modelUIEfxPath)

		if self.modelLvUpEfxId then
			EffectManager:releaseEffect(self.modelLvUpEfxId)

			self.modelLvUpEfxId = nil
		end

		local model = self.modelStage:getModel(self.curModelInsId)

		if model then
			self.modelLvUpEfxId = EffectManager:playTransformEffect(model.transform, efxPath, Const.EFFECT_LIFE_MODE.LogicControl)
		end

		for i, efxCom in ipairs(self.attrEfxComList) do
			efxCom:playEffectByPath(attrEfxPath)
		end

		self.uiAni:startAni("AudioUpgrade", true)

		self.isPlayingEfx = true
		self.cacheUpgradeRelation = relation

		if self.autoOpenArticleTimer then
			self.autoOpenArticleTimer:Stop()

			self.autoOpenArticleTimer = nil
		end

		if self.packType == Const.RELATION_DESC_AVG and (level == 5 or level == 10) then
			self.stopBtnClick = true
		end

		self.autoOpenArticleTimer = Timer.New(Functor(self.autoOpenArticleTimerFunc, self, level), 1.8, 1)

		self.autoOpenArticleTimer:Start()
	end
end

function HeroShowRoomGrowUpDlg:autoOpenArticleTimerFunc(level)
	self.isPlayingEfx = false

	if not self.cacheUpgradeRelation then
		return
	end

	local plotData = self.roomHero.resDevelopPlotData[self.cacheUpgradeRelation]
	local maxLevel = ResDevelopMisc[self.cacheUpgradeRelation].max_level
	local isMaxLevel = maxLevel <= level

	if isMaxLevel then
		if self.packType == Const.RELATION_DESC_VOW then
			UIManager.playAVG(plotData.avg_id[1], nil, function()
				local heroShowRoomLoveBookDlg = UIManager.getUI("heroShowRoomLoveBookDlg", true)
				local colorData = self.roomHero:getRelationTeamColor()

				heroShowRoomLoveBookDlg:setLoveBookData(self.roomHero.id, true, self.roomHero.name, colorData, plotData.avg_id[1], true)
			end)
		else
			self:openShowArticleDlg(self.cacheUpgradeRelation)
		end
	elseif self.packType == Const.RELATION_DESC_AVG and level == 5 then
		self:openShowArticleDlg(self.cacheUpgradeRelation)
	end

	self.cacheUpgradeRelation = nil
end

function HeroShowRoomGrowUpDlg:onClose()
	HeroShowRoomGrowUpDlg.super.onClose(self)

	if self.autoOpenArticleTimer then
		self.autoOpenArticleTimer:Stop()

		self.autoOpenArticleTimer = nil
	end
end

function HeroShowRoomGrowUpDlg:checkJumpToFightBossExpand(sweepInfoList, func)
	local jumpData

	if CurAvatar:isBossExpandCleanMind() then
		for i, data in ipairs(sweepInfoList) do
			if CurAvatar:isBossExpandCanFightHigher(data.tower, data.layer) then
				if jumpData then
					if jumpData.layer ~= data.layer then
						if jumpData.layer < data.layer then
							jumpData = data
						end
					elseif jumpData.diff < data.diff then
						jumpData = data
					end
				else
					jumpData = data
				end
			end
		end
	end

	if jumpData then
		local function yesFunc(...)
			local ui = UIManager.getUI("bossExpandMainDlg", true)

			if ui then
				ui:jumpToTowerAndLayer(jumpData.tower, jumpData.layer)
			end

			RPC.campTowerUpdateStage()
		end

		local function noFunc(...)
			RPC.campTowerUpdateStage()
		end

		local function otherFunc(...)
			RPC.campTowerUpdateStage()
			func()
		end

		local content = ClientUtils.getClientNotice(633)

		UIManager.showConfirm(UIConst.CONFIRM_THREEBTN, "", content, {
			yesFunc,
			noFunc,
			otherFunc
		}, -1, {
			Lang.get(50277),
			Lang.get(50278),
			Lang.get(50279)
		})

		return true
	else
		return false
	end
end

function HeroShowRoomGrowUpDlg:onBtnArticleClick()
	if self.isPlayingEfx then
		return
	end

	self:openShowArticleDlg()
end

function HeroShowRoomGrowUpDlg:onBtnCleanClick()
	local canSweepAll, costAllPower, sweepTable, lackSweepTimes = self:checkCanSweepAllMaterial()

	if canSweepAll then
		RPC.campTowerSweep(sweepTable)
	else
		local haveCostNum = ClientUtils.getMoney(Const.MONEY_ID_POWER)

		if haveCostNum < costAllPower and not lackSweepTimes then
			UIManager.getUI("buyCapacityDlg", true):initBuyType()
		end
	end
end

function HeroShowRoomGrowUpDlg:onBtnElasticClick()
	if self.isShowInfo then
		self.aniInfoPanel:startAni("CloseGrowUpInfoPanel", true)
		self.btnBlock:setVisible(true)

		self.isShowInfo = false
	end
end

function HeroShowRoomGrowUpDlg:onBtnBlockClick()
	self:openGrowUpPanel()
end

function HeroShowRoomGrowUpDlg:openGrowUpPanel(relationIdx)
	if not self.isShowInfo then
		self.isShowInfo = true

		self.aniInfoPanel:startAni("OpenGrowUpInfoPanel", true)
		self.btnBlock:setVisible(false)
	elseif relationIdx then
		local plotData = self.roomHero.resDevelopPlotData[relationIdx]
		local aniName = CHOOSE_ANIM_NAME[plotData.relation_pack_type]

		self.aniInfoPanel:startAni(aniName, true)
	end
end

function HeroShowRoomGrowUpDlg:onBtnUpgradeClick()
	if self.stopBtnClick then
		return true
	end

	if self.roomHero and self.curSelectRelation then
		local notVowType = self.packType ~= Const.RELATION_DESC_VOW

		if utils.checkRelationLvUpMaterialEnough(self.roomHero, self.curSelectRelation) then
			if notVowType then
				RPC.heroDevelop(self.roomHero.id, self.curSelectRelation, self.curSelectRelationLv + 1)
			else
				UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, Lang.get(5), Lang.get(63941), function()
					RPC.heroDevelop(self.roomHero.id, self.curSelectRelation, self.curSelectRelationLv + 1)
				end, nil, nil, Lang.get(8), Lang.get(7))
			end
		elseif notVowType then
			MsgManager.clientNotice(623)
		else
			MsgManager.notice(Lang.get(63942))
		end
	end
end

function HeroShowRoomGrowUpDlg:onBtnUniversalClick()
	if self.needUniversalVowId then
		UIManager.getUI("universalTransitionDlg", true):setData(self.costIdList, self.costNumList)
	else
		MsgManager.clientNotice(683)
	end
end

function HeroShowRoomGrowUpDlg:onBtnTipsClick()
	UIManager.getUI("infoNotice", true):showSystemInfo(Const.INFO_NOTICE_RELATION_GROWUP)
end

function HeroShowRoomGrowUpDlg:onBtnCloseClick()
	self:setVisible(false)
end

function HeroShowRoomGrowUpDlg:onDestroy()
	if self.roomHero and CurAvatar.newRoomHeroIdDic and CurAvatar.newRoomHeroIdDic[self.roomHero.id] == 1 then
		CurAvatar.newRoomHeroIdDic[self.roomHero.id] = nil

		CurAvatar:checkRelationHeroNewHint()
	end

	EventCenter.removeEventListener(EventConst.ITEM_UPDATE, self.slot4RefreshData)
	HeroShowRoomGrowUpDlg.super.onDestroy(self)
end

return HeroShowRoomGrowUpDlg
