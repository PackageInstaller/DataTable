-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\BtnEquipWearingPanel.lua

local BAG_ATLAS = "Atlas/BagAtlas/BagAtlas"
local ResColor = require("ClientData/ResColor")
local strClassName = "BtnEquipWearingPanel"
local BtnEquipWearingPanel = Class(strClassName, UIControls.ScrollViewLoopCell)

function BtnEquipWearingPanel:ctor()
	self:initUI()
end

function BtnEquipWearingPanel:initUI()
	self.equipSlots = {}

	for i = 1, 6 do
		local slot = UIControls.Button(self, "EquipPanel/EquipGrid" .. i)

		slot:addEventClick(self.onSlotClick)
		table.insert(self.equipSlots, slot)
	end

	self.panelEquip = UIControls.Panel(self, "EquipPanel")
	self.panelGame = UIControls.Panel(self, "GamePanel")
	self.panelLockEquip = UIControls.Panel(self, "UILock")
	self.imgLockArtifact = UIControls.Panel(self, "BgLock")
	self.panelLockRelic = UIControls.Panel(self, "RelicLock")
	self.panelConditionLockRelic = UIControls.Panel(self, "RelicNotUnLock")
	self.artifactSlot = UIControls.Button(self, "BadgeGrid")

	self.artifactSlot:addEventClick(self.onArtifactClick)

	self.btnRelicSlot = UIControls.Button(self, "RelicGrid")

	self.btnRelicSlot:addEventClick(self.onBtnRelicSlotClick)

	self.btnReplace = UIControls.Button(self, "BtnReplace", "Text")

	self.btnReplace:addEventClick(self.onBtnReplaceClick)

	self.txtEng = UIControls.Label(self, "BtnReplace/TextEng")
	self.imgBg = UIControls.Image(self, "")
	self.btnEquip = UIControls.Button(self, "BtnEquip")

	self.btnEquip:addEventClick(self.onBtnEquipClick)

	self.btnCustomEquip = UIControls.Button(self, "BtnCustomEquip")

	self.btnCustomEquip:setVisible(Const.CUSTOM_WEAR_OPEN)
	self.btnCustomEquip:addEventClick(self.onBtnCustomEquipClick)

	self.imgArtifactNew = UIControls.Image(self, "BadgeGrid/IconNew")
	self.imgRelicNew = UIControls.Image(self, "RelicGrid/IconNew")
	self.btnUnload = UIControls.Button(self, "BtnUnload")

	self.btnUnload:addEventClick(self.onBtnUnloadClick)

	self.imgEquipNewList = {}
	self.efxSuitGridList = {}
	self.effectPartList = {}

	for i = 1, 6 do
		local equipIconNew = UIControls.Image(self, "EquipPanel/EquipGrid" .. i .. "/IconNew")

		self.imgEquipNewList[i] = equipIconNew

		local suitGridEfx = UIControls.LazyEffectPlayer(self, "EquipPanel/EquipGrid" .. i .. "/EfxEquipGrid02")

		self.efxSuitGridList[i] = suitGridEfx
	end

	self.imgIconEquipNew = UIControls.Image(self, "BtnEquip/IconNew")

	if UIControls.checkControlFunc(self, "ImgOnField") then
		self.imgOnField = UIControls.Image(self, "ImgOnField")
	end

	self.equipGridDic = {}
end

function BtnEquipWearingPanel:playPartEfx(effectPartList, suitEffPartList)
	effectPartList = effectPartList or self.effectPartList
	suitEffPartList = suitEffPartList or self.suitEffPartList

	if effectPartList then
		for _, part in ipairs(effectPartList) do
			if self.efxEquipGridList[part] then
				self.efxEquipGridList[part]:playEffect()
			end
		end
	end

	if suitEffPartList then
		for _, part in ipairs(suitEffPartList) do
			if self.efxSuitGridList[part] then
				self.efxSuitGridList[part]:playEffect()
			end
		end
	end

	self.effectPartList = nil
	self.suitEffPartList = nil
end

function BtnEquipWearingPanel:clearEfx()
	self.effectPartList = nil
	self.suitEffPartList = nil
	self.willPlayArtifactEfx = nil
	self.willPlayRelicEfx = nil

	for part, _ in ipairs(self.efxSuitGridList) do
		self.efxSuitGridList[part]:stopEffect()
	end
end

function BtnEquipWearingPanel:onClear()
	BtnEquipWearingPanel.super.onClear(self)
	self:clearEfx()
end

function BtnEquipWearingPanel:onBtnCustomEquipClick()
	local customWearingDlg = UIManager.getUI("customWearingDlg", true)

	if self.isEditPlan then
		customWearingDlg:setCustomWearingShow(self.hero, Slot(self.customWearEquip, self), self.bagWears)
	else
		customWearingDlg:setCustomWearingShow(self.hero, Slot(self.customWearEquip, self))
	end
end

function BtnEquipWearingPanel:onBtnEquipClick()
	if self.isEditPlan then
		if not self.mWindow.panelWear:checkCanEditHero(self.hero) then
			MsgManager.clientNotice(373)

			return
		end

		local equipGids, betterArtifactGid, betterRelicId
		local equipInfo = CurAvatar:getQuickWearInfo(self.hero, self.bagWears)

		if equipInfo then
			equipGids = equipInfo.equipGids
			betterArtifactGid = equipInfo.artifactGid
			betterRelicId = equipInfo.relicId
		else
			return
		end

		if equipGids and #equipGids > 0 or betterArtifactGid or betterRelicId then
			if equipGids and #equipGids > 0 then
				local replacePart = self:refreshEquipGidList(equipGids)

				self:playGridHeroWear(replacePart)
			end

			if betterArtifactGid then
				CurAvatar:changeWearPartPlanData(self.hero, nil, betterArtifactGid)
			end

			if betterRelicId then
				CurAvatar:changeWearPartPlanData(self.hero, nil, nil, betterRelicId)
			end

			CurAvatar:changeWearPartPlanData(self.hero, nil, nil, nil, true)
			MsgManager.clientNotice(252)
		else
			MsgManager.clientNotice(253)
		end
	else
		CurAvatar:heroQuickWear(self.hero)
	end
end

function BtnEquipWearingPanel:refreshEquipGidList(equipGids, offEquipGids)
	local equipGidList = self.hero:getEquipGidList()
	local replacePart = {}

	for _, gid in ipairs(equipGids) do
		replacePart[self.bagWears.equips[gid].part] = true
	end

	for i = #equipGidList, 1, -1 do
		local gid = equipGidList[i]

		if replacePart[self.bagWears.equips[gid].part] then
			table.remove(equipGidList, i)
		end
	end

	if offEquipGids then
		for i, offGid in ipairs(offEquipGids) do
			for i = #equipGidList, 1, -1 do
				local gid = equipGidList[i]

				if offGid == gid then
					table.remove(equipGidList, i)

					break
				end
			end
		end
	end

	for _, gid in ipairs(equipGids) do
		table.insert(equipGidList, gid)
	end

	CurAvatar:changeWearPartPlanData(self.hero, equipGidList)

	return replacePart
end

function BtnEquipWearingPanel:playGridHeroWear(replacePart)
	if self.gridHero.heroEquipInfoPanel then
		local effectPartList = {}

		for i, v in pairs(replacePart) do
			table.insert(effectPartList, i)
		end

		self.gridHero.heroEquipInfoPanel:playWearOrOffAnim(effectPartList, Const.WEAR_EQUIP_ANIM)
	end
end

function BtnEquipWearingPanel:customWearEquip(suitIds)
	local equipGids, offEquipGids = CurAvatar:getCustomWearEquipGids(self.hero, suitIds, self.bagWears)

	MsgManager.clientNotice(639)

	if equipGids and #equipGids > 0 or offEquipGids and #offEquipGids > 0 then
		if self.isEditPlan then
			local replacePart = self:refreshEquipGidList(equipGids, offEquipGids)

			self:playGridHeroWear(replacePart)
			CurAvatar:changeWearPartPlanData(self.hero, nil, nil, nil, true)
		else
			local offPos = {}

			for _, gid in ipairs(offEquipGids) do
				if CurAvatar.bagEquips[gid] then
					table.insert(offPos, CurAvatar.bagEquips[gid].part - 1)
				end
			end

			if #offPos > 0 then
				RPC.equipOff(self.hero.gid, offPos)
			end

			if equipGids and #equipGids > 0 then
				RPC.equipWear(self.hero.gid, equipGids)
			end
		end
	end
end

function BtnEquipWearingPanel:onBtnUnloadClick()
	if self.isEditPlan then
		local needNotice = self.mWindow.panelWear:clearHeroWearInfo(self.hero, true)

		if needNotice then
			MsgManager.clientNotice(267)
		end
	else
		CurAvatar:heroQuickUnload(self.hero)
	end
end

function BtnEquipWearingPanel:onArtifactClick()
	if self.mWindow.panelWear:checkCanEditHero(self.hero) then
		if self.mParent.heroInfos then
			CurAvatar:openWearDlg(Const.WEAR_TYPE_ARTIFACT, self.hero, self.hero.career, self.isEditPlan, self.bagWears.artifacts, true)
		else
			CurAvatar:openWearDlg(Const.WEAR_TYPE_ARTIFACT, self.hero, self.hero.career, self.isEditPlan, self.bagWears.artifacts)
		end
	else
		MsgManager.clientNotice(373)
	end
end

function BtnEquipWearingPanel:onBtnRelicSlotClick()
	if self.isRelicLocked then
		MsgManager.notice(ConditionLimitManager.getLimitUnlockDesc(Const.CONDITION_LIMIT_WORLD_BOSS))

		return
	end

	if self.mWindow.panelWear:checkCanEditHero(self.hero) then
		if self.mParent.heroInfos then
			CurAvatar:openWearDlg(Const.WEAR_TYPE_RELIC, self.hero, nil, self.isEditPlan, self.bagWears.relics, true)
		else
			CurAvatar:openWearDlg(Const.WEAR_TYPE_RELIC, self.hero, nil, self.isEditPlan, self.bagWears.relics)
		end
	else
		MsgManager.clientNotice(373)
	end
end

function BtnEquipWearingPanel:onSlotClick(sender)
	if self.mWindow.panelWear:checkCanEditHero(self.hero) then
		for part, slot in ipairs(self.equipSlots) do
			if sender == slot then
				if self.mParent.heroInfos then
					CurAvatar:openWearDlg(Const.WEAR_TYPE_EQUIP, self.hero, part, self.isEditPlan, self.bagWears.equips, true)
				else
					CurAvatar:openWearDlg(Const.WEAR_TYPE_EQUIP, self.hero, part, self.isEditPlan, self.bagWears.equips)
				end
			end
		end
	else
		MsgManager.clientNotice(373)
	end
end

function BtnEquipWearingPanel:setHighlightTeamDic(highLightTeamDic)
	self.highLightTeamDic = highLightTeamDic
end

function BtnEquipWearingPanel:setHero(hero, bagEquipMaxRankDic, bagArtifactMaxRankDic, bagCustomMadeArtifactDic, isEditPlan, bagWears)
	self.hero = hero
	self.bagWears = bagWears
	self.isEditPlan = isEditPlan

	if not self.gridHero then
		self.gridHero = UIControls.GridHeroInfoChild(self, "HeroInfo", "System/Common/Grid/GridHeroInfo")

		self.gridHero.txtHeroLv:setFontColor(ResColor.GREYLIGHT)
		self.gridHero.txtHeroName:setFontColor(ResColor.GREYLIGHT)
	end

	self.isInBag = true

	self.gridHero:setHero(hero, nil, self.isInBag)

	if self.isEditPlan then
		self.gridHero.clickNotice = 377
	elseif self.mParent.heroInfos then
		self.gridHero.clickNotice = 377
	else
		self.gridHero.clickNotice = nil
	end

	self.equipList = self.hero:getEquips()

	local canEquipPartList = CurAvatar:getHeroCanEquipPart(self.hero, bagEquipMaxRankDic, bagArtifactMaxRankDic, bagCustomMadeArtifactDic, self.bagWears, true)
	local canEquipPartDic = {}

	self.imgIconEquipNew:setVisible(false)

	for _, part in ipairs(canEquipPartList) do
		canEquipPartDic[part] = true

		self.imgIconEquipNew:setVisible(true)
	end

	for part, equip in pairs(self.equipList) do
		if not self.equipGridDic[part] then
			self.equipGridDic[part] = UIControls.EquipGridChild(self, "EquipPanel/EquipGrid" .. part .. "/GridEquipItemPanel", "System/Common/Grid/GridEquipItem", 0, 0, true)
		end

		self.equipGridDic[part].inBag = true

		self.equipGridDic[part]:setObj(equip)
		self.equipGridDic[part].imgNew:setVisible(canEquipPartDic[part] ~= nil)

		self.equipGridDic[part].mTipsConfig = CurAvatar.commonEquipTipsFuncItem

		if self.isEditPlan then
			self.equipGridDic[part].uiConfig = {
				fromEditPlan = 1,
				bagEquips = self.bagWears.equips,
				wearHero = self.hero
			}
		else
			self.equipGridDic[part].uiConfig = nil
		end

		if self.mParent.heroInfos then
			if self.equipGridDic[part].uiConfig == nil then
				self.equipGridDic[part].uiConfig = {}
			end

			self.equipGridDic[part].uiConfig.fromBattle = 1
		end
	end

	for part, _ in pairs(self.equipGridDic) do
		if not self.equipList[part] then
			self.equipGridDic[part]:destroy()

			self.equipGridDic[part] = nil
		end
	end

	for part = 1, 6 do
		self.imgEquipNewList[part]:setVisible(not self.equipGridDic[part] and canEquipPartDic[part] ~= nil)
	end

	self.artifact = self.hero:getArtifact()

	if self.artifact then
		if not self.artifactGrid then
			self.artifactGrid = UIControls.ArtifactGridChild(self, "BadgeGrid", "System/Common/Grid/GridBadgeSmallItem", 0, 0, true)
		end

		self.artifactGrid.mTipsConfig = CurAvatar.commonArtifactTipsFuncItem

		self.artifactGrid:setObj(self.artifact)
		self.artifactGrid.imgNew:setVisible(canEquipPartDic[Const.PART_OF_ARTIFACT] ~= nil)

		if self.isEditPlan then
			self.artifactGrid.uiConfig = {
				fromEditPlan = 1,
				bagArtifacts = self.bagWears.artifacts,
				wearHero = self.hero
			}
		else
			self.artifactGrid.uiConfig = nil
		end

		if self.mParent.heroInfos then
			if self.artifactGrid.uiConfig == nil then
				self.artifactGrid.uiConfig = {}
			end

			self.artifactGrid.uiConfig.fromBattle = 1
		end
	elseif self.artifactGrid then
		self.artifactGrid:destroy()

		self.artifactGrid = nil
	end

	self.imgArtifactNew:setVisible(not self.artifactGrid and canEquipPartDic[Const.PART_OF_ARTIFACT] ~= nil)

	self.relic = self.hero:getRelic()

	if self.relic then
		if not self.relicGrid then
			self.relicGrid = UIControls.RelicGridChild(self, "RelicGrid", "System/Common/Grid/GridRelicSmallItem", 0, 0, true)
		end

		self.relicGrid:setObj(self.relic)
		self.relicGrid.imgNew:setVisible(canEquipPartDic[Const.PART_OF_RELIC] ~= nil)

		self.relicGrid.mEnableTips = false
		self.relicGrid.mEventClick = Slot(self.onBtnRelicSlotClick, self)

		if self.mParent.heroInfos then
			if self.relicGrid.uiConfig == nil then
				self.relicGrid.uiConfig = {}
			end

			self.relicGrid.uiConfig.fromBattle = 1
		end
	elseif self.relicGrid then
		self.relicGrid:destroy()

		self.relicGrid = nil
	end

	self.imgRelicNew:setVisible(not self.relicGrid and canEquipPartDic[Const.PART_OF_RELIC] ~= nil)

	self.panelStatus = self:getReplaceStatus()

	self.btnReplace:setVisible(self.panelStatus ~= Const.HERO_WEARPANEL_STATUS_NONE)
	self.btnEquip:setVisible(self.panelStatus == Const.HERO_WEARPANEL_STATUS_CANPRE or self.panelStatus == Const.HERO_WEARPANEL_STATUS_NONE)
	self.btnUnload:setVisible(self.panelStatus == Const.HERO_WEARPANEL_STATUS_CANPRE or self.panelStatus == Const.HERO_WEARPANEL_STATUS_NONE)

	local isShowLock = self.panelStatus == Const.HERO_WEARPANEL_STATUS_PRE or self.panelStatus == Const.HERO_WEARPANEL_STATUS_CANSWAP

	self.panelLockEquip:setVisible(isShowLock)
	self.imgLockArtifact:setVisible(isShowLock)

	self.isRelicLocked = utils.getTableElemCount(CurAvatar.bagRelics) == 0

	self.panelConditionLockRelic:setVisible(self.isRelicLocked)
	self.panelLockRelic:setVisible(isShowLock and not self.isRelicLocked)

	local panelPos = self.panelEquip:getPosition()

	if self.panelStatus == Const.HERO_WEARPANEL_STATUS_PRE then
		self.btnReplace:setImage(BAG_ATLAS, "BtnCancel")
		self.imgBg:setImage(BAG_ATLAS, "BgBagWearDel")
		self.txtEng:setFontColor(ResColor.WHITE)
		self.btnReplace:setFontColor(ResColor.GREYDIS)
		self.btnReplace:setText(Lang.get(7))
	elseif self.panelStatus == Const.HERO_WEARPANEL_STATUS_CANSWAP then
		self.btnReplace:setImage(BAG_ATLAS, "BtnExchange")
		self.imgBg:setImage(BAG_ATLAS, "BgBagWear")
		self.txtEng:setFontColor(ResColor.QUALITYPINK)
		self.btnReplace:setFontColor(ResColor.WHITE)
		self.btnReplace:setText(Lang.get(30468))
	elseif self.panelStatus == Const.HERO_WEARPANEL_STATUS_CANPRE then
		self.btnReplace:setImage(BAG_ATLAS, "BtnReplace")
		self.imgBg:setImage(BAG_ATLAS, "BgBagWear")
		self.txtEng:setFontColor(ResColor.QUALITYORANGE)
		self.btnReplace:setFontColor(ResColor.GREYMAIN)
		self.btnReplace:setText(Lang.get(563))
	end

	if self.highLightTeamDic then
		self.panelGame:setVisible(self.highLightTeamDic[self.hero.team] ~= nil)
	else
		self.panelGame:setVisible(false)
	end

	if self.imgOnField then
		if self.mParent.heroInfos and self.mParent.heroInfos[self.hero.gid] then
			self.imgOnField:setVisible(true)
		else
			self.imgOnField:setVisible(false)
		end
	end
end

local function confrimToSwap(gids)
	RPC.equipSwap(gids)
end

function BtnEquipWearingPanel:onBtnReplaceClick()
	if self.panelStatus == Const.HERO_WEARPANEL_STATUS_PRE then
		self.mWindow.panelWear.preReplaceHero = nil

		self.mWindow.panelWear:updateScroll()
	elseif self.panelStatus == Const.HERO_WEARPANEL_STATUS_CANSWAP then
		if #self.hero.equipList == 0 and #self.mWindow.panelWear.preReplaceHero.equipList == 0 then
			MsgManager.clientNotice(238)

			return
		elseif self.isEditPlan then
			local preReplaceHero = self.mWindow.panelWear.preReplaceHero
			local tempEquips = self.hero:getEquipGidList()
			local tempPreEquips = preReplaceHero:getEquipGidList()

			if #tempEquips == 0 and not self.hero:getArtifact() and not self.hero:getRelic() and #tempPreEquips ~= 0 and (preReplaceHero:getArtifact() ~= nil or preReplaceHero:getRelic() ~= nil) and not self.mWindow.panelWear:checkCanEditHero(self.hero) then
				MsgManager.clientNotice(373)

				return
			end

			if #tempPreEquips == 0 and not preReplaceHero:getArtifact() and not preReplaceHero:getRelic() and #tempEquips ~= 0 and (self.hero:getArtifact() ~= nil or self.hero:getRelic() ~= nil) and not self.mWindow.panelWear:checkCanEditHero(preReplaceHero) then
				MsgManager.clientNotice(373)

				return
			end

			CurAvatar:changeWearPartPlanData(self.hero, tempPreEquips)
			CurAvatar:changeWearPartPlanData(preReplaceHero, tempEquips)

			self.mWindow.panelWear.canSave = true

			self.mWindow.panelWear:refreshData()
			MsgManager.clientNotice(239)
		else
			RPC.equipSwap({
				self.hero.gid,
				self.mWindow.panelWear.preReplaceHero.gid
			})
		end
	elseif self.panelStatus == Const.HERO_WEARPANEL_STATUS_CANPRE then
		self.mWindow.panelWear.preReplaceHero = self.hero

		self.mWindow.panelWear:updateScroll()
	end
end

function BtnEquipWearingPanel:getReplaceStatus()
	if #self.mWindow.panelWear.wearedHeroList <= 1 then
		return Const.HERO_WEARPANEL_STATUS_NONE
	elseif self.mWindow.panelWear.preReplaceHero and self.mWindow.panelWear.preReplaceHero == self.hero then
		return Const.HERO_WEARPANEL_STATUS_PRE
	elseif self.mWindow.panelWear.preReplaceHero then
		return Const.HERO_WEARPANEL_STATUS_CANSWAP
	else
		return Const.HERO_WEARPANEL_STATUS_CANPRE
	end
end

return BtnEquipWearingPanel
