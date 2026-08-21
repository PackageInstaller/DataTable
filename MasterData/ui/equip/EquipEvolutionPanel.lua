-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Equip\\EquipEvolutionPanel.lua

local MaterialItemGridChild = require("UI/Common/Grid/MaterialItemGridChild")
local SingleEquipTipsChild = require("UI/Common/Tips/SingleEquipTipsChild")
local ResEquipEvolve = require("ClientData/ResEquipEvolve")
local ResClientConfirm = require("ClientData/ResClientConfirm")
local ResItem = require("ClientData/ResItem")
local ResColor = require("ClientData/ResColor")
local Equip = require("Common/Object/Equip")
local strClassName = "EquipEvolutionPanel"
local EquipEvolutionPanel = Class(strClassName, SingleEquipTipsChild)

function EquipEvolutionPanel:ctor()
	self:initUI()
end

function EquipEvolutionPanel:initUI()
	self.gridMaterialList = {}
	self.textLevel = UIControls.Label(self, "BgUpgrade/Text")
	self.imgBgTitle = UIControls.Image(self, "BgLeft/Bg")
	self.btnUpgrade = UIControls.Button(self, "EquipEvolution/BtnUpgrade", "Text")

	self.btnUpgrade:addEventClick(self.onBtnUpgradeClick)

	self.currencyInfoList = {}

	for i = 1, 2 do
		local curIcon = UIControls.Image(self, "EquipEvolution/BtnUpgrade/IconMoney" .. i)
		local curTxtNum = UIControls.Label(self, "EquipEvolution/BtnUpgrade/TextNum" .. i)

		self.currencyInfoList[i] = {
			curIcon,
			curTxtNum
		}
	end

	self.txtMainPropChange = UIControls.Label(self, "InfoList/Content/AttrPanel/AttrMainPanel/AttrMain03/TextNum2")
	self.imgMainPropLockIcon = UIControls.Image(self, "InfoList/Content/AttrPanel/AttrMainPanel/AttrMain03/BgLock")
	self.panelGridMaterial = UIControls.Panel(self, "EquipEvolution/GridMaterialPanel")
	self.panelGrid = UIControls.Panel(self, "EquipEvolution/GridPanel")
	self.txtEquipName = UIControls.Label(self, "EquipEvolution/GridPanel/TextName")
	self.txtEvoEquipName = UIControls.Label(self, "EquipEvolution/GridPanel1/TextName")
	self.imgChange = UIControls.Image(self, "EquipEvolution/IconChange")
	self.imgBgBlack = UIControls.Image(self, "InfoList/Content/AttrPanel/AttrMainPanel/AttrMain03/BgBlack")
	self.efxMaterialList = {}

	for i = 1, 4 do
		local efxMaterial = UIControls.LazyEffectPlayer(self, "EquipEvolution/GridMaterialPanel/EfxPanel/EfxBg" .. i)

		self.efxMaterialList[i] = efxMaterial
	end

	self.efxEquipEvoList = {}

	for i = 1, 3 do
		local efxEquipEvo = UIControls.LazyEffectPlayer(self, "EquipEvolution/EfxEvolutionPanel/Efx" .. i)

		self.efxEquipEvoList[i] = efxEquipEvo
	end

	self.evoAni = UIControls.UIAni(self, "EquipEvolution/EfxEvolutionPanel")

	self.evoAni:addEventFinish(Slot(self._successAniEndCallBack, self))

	self.txtTitle = UIControls.Label(self, "EquipEvolution/TextTitle")
end

local function confrimToEvo(self)
	RPC.equipEvolve(self.equip.gid, self.equip.evolve + 1)

	self.lockClick = true
end

function EquipEvolutionPanel:onBtnUpgradeClick()
	if self.lockClick then
		return
	end

	if self.equip.evolve >= Const.EQUIP_EVO_MAX then
		MsgManager.clientNotice(270)

		return
	end

	if #self.lackInfo == 0 then
		local msgContent = ""
		local offNeedGold = self.evoEquip:getOffMaterialNeed(true) ~= nil and self.evoEquip:getOffMaterialNeed(true)[2] or 0

		if self.equip.evolve == 0 then
			msgContent = ResClientConfirm[1064].content

			UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, Lang.get(5), msgContent, Slot(confrimToEvo, self))
		else
			confrimToEvo(self)
		end

		if false then
			if self.equip.evolve == 0 then
				msgContent = string.format(Lang.get(30291), ClientUtils.getNumShortStr(offNeedGold))
			else
				msgContent = string.format(Lang.get(30292), ClientUtils.getNumShortStr(offNeedGold))
			end

			UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, Lang.get(5), msgContent, Slot(confrimToEvo, self))
		end
	else
		MsgManager.notice(string.format(Lang.get(30029), self.lackInfo[1]))
	end
end

function EquipEvolutionPanel:setEquip(equip)
	EquipEvolutionPanel.super.setItem(self, equip)

	self.lockClick = false
	self.equip = equip
	self.gridEquip.mEnableTips = true

	local titleImgPath = self:getTitleImgPath(self.equip.evolve)

	if titleImgPath then
		self.imgBgTitle:setImage(titleImgPath[1], titleImgPath[2])
	end

	if self.equip.evolve == Const.EQUIP_EVO_MAX then
		self:showMaxEvolveStatus()

		return
	end

	local evoServerData = utils.deepcopy(self.equip._serverData)

	evoServerData.evolve = evoServerData.evolve + 1
	self.evoEquip = Equip(evoServerData)

	if not self.gridEquipEvo then
		self.gridEquipEvo = UIControls.EquipGridChild(self, "EquipEvolution/GridPanel1", "System/Common/Grid/GridEquipItem", 0, 0, true)
	end

	self.gridEquipEvo:setObj(self.evoEquip)
	self.txtEquipName:setText(self.equip.name)
	self.txtEvoEquipName:setText(self.evoEquip.name)
	self.textLevel:setVisible(self.equip.enhanceLevel ~= 0)
	self.textLevel:setText("+" .. self.equip.enhanceLevel)
	self:refreshMaterialInfo()
	self:refreshPreviewShow()
end

function EquipEvolutionPanel:showMaxEvolveStatus()
	self.panelGridMaterial:setVisible(false)

	for _, currCom in ipairs(self.currencyInfoList) do
		currCom[1]:setVisible(false)
		currCom[2]:setVisible(false)
	end

	self.btnUpgrade:setEnable(false)
	self:setAttr3GroupColor(self.equip)
	self.panelGrid:setVisible(false)
	self.imgChange:setVisible(false)
	self.txtMainPropChange:setVisible(false)
	self.imgMainPropLockIcon:setVisible(false)
	self.txtTitle:setVisible(false)
	self.btnUpgrade:setText(Lang.get(467))
end

function EquipEvolutionPanel:getTitleImgPath(evolve)
	if evolve == 0 then
		return {
			"Atlas/HeroAtlas/HeroEquipEvolutionAtlas",
			"BgTitleTen"
		}
	elseif evolve == 1 then
		return {
			"Atlas/HeroAtlas/HeroEquipEvolutionAtlas",
			"BgTitleEleven"
		}
	elseif evolve == 2 then
		return {
			"Atlas/HeroAtlas/HeroEquipEvolutionAtlas",
			"BgTitleTwelve"
		}
	end
end

function EquipEvolutionPanel:playSuccessEfxAndAni(newEquip)
	self.equip = newEquip

	for i, v in ipairs(self.gridMaterialList) do
		self.efxMaterialList[i]:setVisible(true)
	end

	self.evoAni:startAni("AniEvolution", true)
end

function EquipEvolutionPanel:_successAniEndCallBack()
	self:clearAllEfx()
	self:setEquip(self.equip)

	local heroEquipEvolutionSuccessDlg = UIManager.getUI("heroEquipEvolutionSuccessDlg", true)

	if heroEquipEvolutionSuccessDlg then
		heroEquipEvolutionSuccessDlg:setEquip(self.equip)
	end
end

function EquipEvolutionPanel:clearAllEfx()
	for _, efxPanel in ipairs(self.efxMaterialList) do
		efxPanel:setVisible(false)
	end

	for _, efxPanel in ipairs(self.efxEquipEvoList) do
		efxPanel:setVisible(false)
	end
end

function EquipEvolutionPanel:refreshPreviewShow()
	self.panelMainAttr3:setVisible(true)

	local curMainPropValue = self.equip.mainProp3Value or 0
	local predictMainPropValue = self.evoEquip.mainProp3Value or 0
	local mainIcon = ClientUtils.getRolePropIconByType(self.evoEquip.mainProp3)

	if mainIcon then
		self.iconMainAttr3:setImage(mainIcon[1], mainIcon[2])
	end

	local attr3Color = {}
	local imgBackPath = {}

	if self.equip.evolve == 0 then
		self.imgMainPropLockIcon:setVisible(true)
		self.txtMainPropChange:setVisible(false)

		local zhName, zhValue = ClientUtils.getRolePropZhNameByType(self.evoEquip.mainProp3, predictMainPropValue)

		self.textMainAttr3Name:setText(zhName)
		self.textMainAttr3Num:setText(zhValue)
		self:setAttr3GroupColor(self.evoEquip)
	else
		local zhName, zhValue = ClientUtils.getRolePropZhNameByType(self.equip.mainProp3, predictMainPropValue)

		self.txtMainPropChange:setText(zhValue)
		self.txtMainPropChange:setVisible(true)
		self.imgMainPropLockIcon:setVisible(false)
		self:setAttr3GroupColor(self.equip)
	end
end

function EquipEvolutionPanel:setAttr3GroupColor(equip)
	local attr3Color = equip:getAttr3Color()
	local imgBackPath = equip:getAttr3BackImgPath()

	if imgBackPath then
		self.imgAttr3Bg:setImage(imgBackPath[1], imgBackPath[2])
	end

	if attr3Color then
		self.textMainAttr3Name:setColorByRGBA(attr3Color[1] / 255, attr3Color[2] / 255, attr3Color[3] / 255)
		self.textMainAttr3Num:setColorByRGBA(attr3Color[1] / 255, attr3Color[2] / 255, attr3Color[3] / 255)
		self.iconMainAttr3:setColorByRGBA(attr3Color[1], attr3Color[2], attr3Color[3])
	end
end

function EquipEvolutionPanel:refreshMaterialInfo()
	self.lackInfo = {}

	local evolveInfo = ResEquipEvolve[self.evoEquip.evolve][self.evoEquip.part]

	for i = 1, 2 do
		local haveNum = ClientUtils.getMoney(evolveInfo.cost[i].id)
		local needNum = evolveInfo.cost[i].num

		self.currencyInfoList[i][2]:setText(ClientUtils.getNumShortStr(needNum))

		if haveNum < needNum then
			self.currencyInfoList[i][2]:setFontColor(ResColor.RED)
			table.insert(self.lackInfo, ResItem[evolveInfo.cost[i].id].name)
		else
			self.currencyInfoList[i][2]:setFontColor(ResColor.WHITE)
		end

		local moneyInfo = UIConst.MONEY_ID2INFO[evolveInfo.cost[i].id]

		if moneyInfo then
			self.currencyInfoList[i][1]:setImage(moneyInfo[1], moneyInfo[2])
		else
			local tempItem = BaseObject.GetObject(evolveInfo.cost[i].id)
			local iconPath = tempItem:getIconPath()

			if iconPath then
				self.currencyInfoList[i][1]:setImage(iconPath[1], iconPath[2])
			end
		end
	end

	for i = 3, #evolveInfo.cost do
		if not self.gridMaterialList[i - 2] then
			self.gridMaterialList[i - 2] = MaterialItemGridChild(self, "EquipEvolution/GridMaterialPanel", "System/Common/Grid/GridMaterialItem", 0, 0, true)
		end

		local evoCostInfo = evolveInfo.cost[i]
		local enough = self.gridMaterialList[i - 2]:setMaterial(evoCostInfo.id, evoCostInfo.num)

		self.gridMaterialList[i - 2].needNum = evoCostInfo.num
		self.gridMaterialList[i - 2].uiConfig = {
			AutoOpenGuide = 1
		}

		self.gridMaterialList[i - 2].imgAdd2:setVisible(not enough)

		if not enough then
			table.insert(self.lackInfo, Lang.get(30293))

			local addPanelIdx = CurAvatar:getMaterialEquipTowerCanSweep(evoCostInfo.id) and 1 or 2

			self.gridMaterialList[i - 2]:setAddPanel(addPanelIdx)
		end
	end

	for i = #evolveInfo.cost - 1, #self.gridMaterialList do
		self.gridMaterialList[i]:destroy()

		self.gridMaterialList[i] = nil
	end
end

return EquipEvolutionPanel
