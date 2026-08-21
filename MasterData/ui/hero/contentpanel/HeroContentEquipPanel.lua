-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Hero\\ContentPanel\\HeroContentEquipPanel.lua

local ResEquipSuit = require("ClientData/ResEquipSuit")
local HeroEquipSuitPanel = Class("HeroEquipSuitPanel", UIControls.Panel)
local ResEquipTowerCustomEquipEffect = require("ClientData/ResEquipTowerCustomEquipEffect")
local ResEquipQuality = require("ClientData/ResEquipQuality")
local Relic = require("Common/Object/Relic")

function HeroEquipSuitPanel:ctor()
	self:initUI()
end

function HeroEquipSuitPanel:initUI()
	self.imgIcon = UIControls.Image(self, self.mPath .. "/Icon")
	self.txtTitle = UIControls.Label(self, self.mPath .. "/TextName")
	self.btnSelf = UIControls.Button(self, self.mPath)

	self.btnSelf:addEventClick(self.onBtnSelfClick)

	self.txtDesBg = UIControls.Panel(self, self.mPath .. "/BgTextDes")
	self.txtDes = UIControls.Label(self, self.mPath .. "/BgTextDes/TextDes")
end

function HeroEquipSuitPanel:onBtnSelfClick()
	self.txtDesBg:setVisible(true)
	self.mParent.suitSensor:setVisible(true)
end

function HeroEquipSuitPanel:setData(suitId)
	local suitInfo = ResEquipSuit[suitId]

	if suitInfo then
		self.imgIcon:setImage(UIConst.COMMON_ICON_PATH .. suitInfo.big_icon_path, suitInfo.big_icon)
		self.txtTitle:setText(suitInfo.name)
		self.txtDes:setText(suitInfo.des)
	end
end

local EquipPanelGridArtifact = Class("EquipPanelGridArtifact", UIControls.ArtifactGridPanel)

function EquipPanelGridArtifact:setArtifact(obj)
	self:setObj(obj)
end

function EquipPanelGridArtifact:clearArtifact()
	self:clear()
end

local EquipPanelWearGrid = Class("EquipPanelWearGrid", UIControls.EquipGridPanel)

function EquipPanelWearGrid:ctor()
	self:_initWearGrid()
end

function EquipPanelWearGrid:_initWearGrid()
	self.imgStripe = UIControls.Image(self, self.mPath .. "/ImgQuality/ImgStripe")
end

function EquipPanelWearGrid:setEquip(obj)
	self:setObj(obj)
	self.imgQuality:setImage("Atlas/HeroAtlas/HeroEquipAtlas", self:getEquipQualitySprite()[1])
	self.imgQuality:setObjColor(self.object:getQualityColor())

	if self.object:getQualityIsPlus() then
		self.imgStripe:setImage("Atlas/HeroAtlas/HeroEquipAtlas", self:getEquipQualitySprite()[2])
		self.imgStripe:setColorByRGBA(self:getStripeColorRGBA()[1], self:getStripeColorRGBA()[2], self:getStripeColorRGBA()[3])
		self.imgStripe:setVisible(true)
	else
		self.imgStripe:setVisible(false)
	end

	self:setVisible(true)
end

function EquipPanelWearGrid:getStripeColorRGBA()
	if self.object.quality == Const.EQUIP_QUALITY_GREEN_PLUS then
		return {
			27,
			113,
			49
		}
	end

	if self.object.quality == Const.EQUIP_QUALITY_BLUE_PLUS then
		return {
			44,
			65,
			127
		}
	end

	if self.object.quality == Const.EQUIP_QUALITY_FUCHSIA then
		return {
			255,
			219,
			74
		}
	end

	if self.object.quality == Const.EQUIP_QUALITY_GOLD_PLUS then
		return {
			241,
			137,
			25
		}
	end

	if self.object.quality == Const.EQUIP_QUALITY_PINK_PLUS then
		return {
			253,
			120,
			157
		}
	end

	if self.object.quality == Const.EQUIP_QUALITY_RED_PLUS then
		return {
			253,
			120,
			157
		}
	end
end

function EquipPanelWearGrid:getEquipQualitySprite()
	if self.object.subType == 1 or self.object.subType == 4 then
		return {
			"BgSpecialItem011",
			"BgSpecialItem012"
		}
	elseif self.object.subType == 2 or self.object.subType == 5 then
		return {
			"BgSpecialItem021",
			"BgSpecialItem022"
		}
	elseif self.object.subType == 3 or self.object.subType == 6 then
		return {
			"BgSpecialItem031",
			"BgSpecialItem032"
		}
	end
end

function EquipPanelWearGrid:clearEquip()
	self:clear()
	self:setVisible(false)
end

local EquipWearGridPanel = Class("EquipWearGridPanel", UIControls.Panel)

function EquipWearGridPanel:ctor()
	self.imgNone = UIControls.Image(self, self.mPath .. "/ImgNone")
	self.gridWear = EquipPanelWearGrid(self, self.mPath .. "/GridEquipWearItem")
end

function EquipWearGridPanel:setEquip(obj)
	self.gridWear.mEnableTips = true

	self.gridWear:setEquip(obj)
	self.imgNone:setVisible(false)
end

function EquipWearGridPanel:clearEquip()
	self.imgNone:setVisible(true)
	self.gridWear:clearEquip()
end

local RelicTipsInfoPanel = require("UI/Common/Tips/RelicTipsInfoPanel")
local RelicTabInfoPanel = Class("RelicTabInfoPanel", UIControls.Panel)

function RelicTabInfoPanel:ctor()
	self.imgBgQuality = UIControls.Image(self, self.mPath .. "/BgQuality")
	self.imgIcon = UIControls.Image(self, self.mPath .. "/Icon")
	self.txtName = UIControls.Label(self, self.mPath .. "/TextName")
	self.txtLv = UIControls.Label(self, self.mPath .. "/TextLv")
	self.imgMax = UIControls.Panel(self, self.mPath .. "/ImgMax")
	self.panelRelicInfo = RelicTipsInfoPanel(self, self.mPath)
end

function RelicTabInfoPanel:setRelic(relic)
	self.relic = relic

	self.panelRelicInfo:setRelic(self.relic)

	local bgQualityPath = self.relic:getBgQualityPath()

	self.imgBgQuality:setImage(bgQualityPath[1], bgQualityPath[2])

	local iconPath = self.relic:getIconPath()

	if iconPath then
		self.imgIcon:setImage(iconPath[1], iconPath[2])
	end

	self.txtName:setText(self.relic.name)
	self.imgMax:setVisible(self.relic:isEnhanceLvMax())

	if self.relic.enhanceLevel > 0 and self.relic.enhanceLevel < self.relic.maxLevel then
		self.txtLv:setVisible(true)
		self.txtLv:setText(string.format(Lang.get(30171), self.relic.enhanceLevel))
	else
		self.txtLv:setVisible(false)
	end
end

local ResArtifact = require("ClientData/ResArtifact")
local ResPassiveSkill = require("ClientData/ResPassiveSkill")
local HeroAttrPanel = require("UI/Hero/HeroAttrPanel")
local PropHelper = require("Common/FrameBattle/BattleObject/PropHelper")
local ResArtifactLevelUp = require("ClientData/ResArtifactLevelUp")
local ResColor = require("ClientData/ResColor")
local UIUtils = Framework.UI.UIUtils
local TAB_BADGE = 1
local TAB_RELIC = 2
local TAB_SEASON = 3
local strClassName = "HeroContentEquipPanel"
local HeroContentEquipPanel = Class(strClassName, UIControls.Child)

function HeroContentEquipPanel:ctor()
	self:initUI()

	self.tipsFuncItem = UIControls.TipsConfig()

	self.tipsFuncItem:addConfig(self, Lang.get(932), self.onLockEquip, self.onItemLockCheck, self.onItemLockCheck, 1)
	self.tipsFuncItem:addConfig(self, Lang.get(1832), self.onDestroyEquip, self.onItemVisibleCheck, nil, 2)
	self.tipsFuncItem:addConfig(self, Lang.get(1602), self.onTakeOffEquip, nil, self.onItemTakeOffCheck, 3)
	self.tipsFuncItem:addConfig(self, Lang.get(1189), self.onReplaceEquip, nil, self.onItemReplaceCheck, 4)
	self.tipsFuncItem:addConfig(self, Lang.get(920), self.onUpgradeEquip, self.onUpgradeEquipCheck, self.onUpgradeEnableCheck, 5)
	self.tipsFuncItem:addConfig(self, Lang.get(1833), self.onUpgradeEquip, self.onBreakArtifactCheck, nil, 5)
end

function HeroContentEquipPanel:initUI()
	self.attrPanel = UIControls.Panel(self, "AttrPanel")
	self.attrLessPanel = UIControls.Panel(self, "AttrLessPanel")
	self.btnMore = UIControls.Button(self, "AttrLessPanel/BtnMore")

	self.btnMore:addEventClick(self.onBtnMoreClick)

	self.btnLess = UIControls.Button(self, "AttrPanel/BtnMore")

	self.btnLess:addEventClick(self.onBtnLessClick)

	self.equipAttrPanelList = {}
	self.lessAttrPanelList = {}
	self.equipAttrDiff = {}

	for i = 1, 8 do
		local attrChildPanel = HeroAttrPanel(self, "AttrPanel/Attr0" .. i)

		self.equipAttrPanelList[i] = attrChildPanel

		local lessAttrPanel = HeroAttrPanel(self, "AttrLessPanel/Attr0" .. i)

		self.lessAttrPanelList[i] = lessAttrPanel
	end

	self.suitPanelList = {}
	self.suitPanelOri = UIControls.Panel(self, "SuitPanel")
	self.suitPanel2 = UIControls.Panel(self, "SuitPanel2")

	if Const.EQUIP_TOWER_OPEN_CUSTOM_LAYER then
		self.suitPanelOri:setVisible(false)
		self.suitPanel2:setVisible(true)

		self.suitPanel = self.suitPanel2

		for i = 1, 3 do
			local suitPanel = HeroEquipSuitPanel(self, "SuitPanel2/SuitNmlPanel/Suit0" .. i)

			self.suitPanelList[i] = suitPanel
		end

		self.suitSensor = UIControls.Button(self, "SuitPanel2/SuitNmlPanel/UIClickThrough")

		self.suitSensor:addEventClick(self.onSuitSensorClick)

		self.suitNone = UIControls.Label(self, "SuitPanel2/SuitNmlPanel/TextNone")
		self.suitNmlPanel = UIControls.Panel(self, "SuitPanel2/SuitNmlPanel")
		self.btnTabSuitNml = UIControls.Button(self, "SuitPanel2/TabPanel/TabSuitNml")

		self.btnTabSuitNml:addEventClick(self.onTabSuitNmlClick)

		self.btnTabSuitSpe = UIControls.Button(self, "SuitPanel2/TabPanel/TabSuitSpe")

		self.btnTabSuitSpe:addEventClick(self.onTabSuitSpeClick)

		self.txtTabSuitSpe = UIControls.Label(self, "SuitPanel2/TabPanel/TabSuitSpe/Text")
		self.btnTabSuitSpeDis = UIControls.Button(self, "SuitPanel2/TabPanel/TabSuitSpeDis")

		self.btnTabSuitSpeDis:addEventClick(self.onTabSuitSpeDisClick)

		self.textSpeNum = UIControls.Label(self, "SuitPanel2/SuitSpePanel/TextNum")
		self.textSpeAttr = UIControls.Label(self, "SuitPanel2/SuitSpePanel/TextAttr")
		self.textSpeNone = UIControls.Label(self, "SuitPanel2/SuitSpePanel/TextNone")
		self.suitSpePanel = UIControls.Panel(self, "SuitPanel2/SuitSpePanel")

		self:onTabSuitNmlClick()
	else
		self.suitPanelOri:setVisible(true)
		self.suitPanel2:setVisible(false)

		self.suitPanel = self.suitPanelOri

		for i = 1, 3 do
			local suitPanel = HeroEquipSuitPanel(self, "SuitPanel/Suit0" .. i)

			self.suitPanelList[i] = suitPanel
		end

		self.suitSensor = UIControls.Button(self, "SuitPanel/UIClickThrough")

		self.suitSensor:addEventClick(self.onSuitSensorClick)

		self.suitNone = UIControls.Label(self, "SuitPanel/TextNone")
	end

	self.btnArtifactGrid = UIControls.Button(self, "EquipPanel/BadgeGrid")

	self.btnArtifactGrid:addEventClick(self.onArtifactGridClick)

	self.btnRelicGrid = UIControls.Button(self, "EquipPanel/RelicGrid")

	self.btnRelicGrid:addEventClick(self.onRelicGridClick)

	self.btnEquipGridList = {}
	self.imgEquipNewList = {}
	self.imgEquipEvoNewList = {}

	for i = 1, 6 do
		local btnEquipGrid = UIControls.Button(self, "EquipPanel/EquipGrid" .. i)

		btnEquipGrid:addEventClick(self.onEquipGridClick)

		self.btnEquipGridList[i] = btnEquipGrid
		self.imgEquipNewList[i] = UIControls.Image(self, "EquipPanel/EquipGrid" .. i .. "/IconNew")
		self.imgEquipEvoNewList[i] = UIControls.Image(self, "EquipPanel/EquipGrid" .. i .. "/IconNew1")
	end

	self.btnEquip = UIControls.Button(self, "EquipPanel/BtnEquip")

	self.btnEquip:addEventClick(self.onBtnEquipClick)

	self.imgIconEquipNew = UIControls.Image(self, "EquipPanel/BtnEquip/IconNew")
	self.btnEquipOff = UIControls.Button(self, "EquipPanel/BtnEquipOff")

	self.btnEquipOff:addEventClick(self.onBtnEquipOffClick)

	self.panelNum = UIControls.Panel(self, "EquipPanel/NumPanel")
	self.artifactSkillPanel = UIControls.Panel(self, "SkillPanel")
	self.txtArtifactSkillName = UIControls.Label(self, "SkillPanel/TextName")
	self.txtArtifactSkillDes = UIControls.Label(self, "SkillPanel/TextDesPanel/Content/TextDes")
	self.txtArtifactSkillLv = UIControls.Label(self, "SkillPanel/TextLvMax/TextLv")
	self.txtArtifactSkillLvMax = UIControls.Label(self, "SkillPanel/TextLvMax")
	self.imgArtifactiBgIcon = UIControls.Image(self, "SkillPanel/BgBadge")
	self.imgArtifactiIcon = UIControls.Image(self, "SkillPanel/BgBadge/IconBadge")
	self.bgSkillNone = UIControls.Panel(self, "BgSkillNone")
	self.relicTabInfoPanel = RelicTabInfoPanel(self, "RelicPanel")
	self.bgRelicNone = UIControls.Panel(self, "BgReliclNone")
	self.seasonRelicPanel = UIControls.Panel(self, "SeasonPanel")
	self.txtSeasonRelicName = UIControls.Label(self, "SeasonPanel/TextName")
	self.txtSeasonRelicLv = UIControls.Label(self, "SeasonPanel/TextLvMax/TextLv")
	self.txtSeasonRelicDes = UIControls.Label(self, "SeasonPanel/TextDesPanel/Content/TextDes")
	self.iconSeasonLogo = UIControls.Image(self, "SeasonPanel/BgSensonLogo/IconLogo")
	self.showSeasonUnLock = UIControls.Panel(self, "SeasonPanel/ShowUnLock")
	self.panelSeasonPrice = UIControls.Panel(self, "SeasonPanel/PricePanel")
	self.iconSeasonPrice1 = UIControls.Image(self, "SeasonPanel/PricePanel/Icon")
	self.txtSeasonPriceNum1 = UIControls.Label(self, "SeasonPanel/PricePanel/TextNum")
	self.iconSeasonPrice2 = UIControls.Image(self, "SeasonPanel/PricePanel/Icon2")
	self.txtSeasonPriceNum2 = UIControls.Label(self, "SeasonPanel/PricePanel/TextNum2")
	self.txtSeaonRelicConfirm = UIControls.Label(self, "SeasonPanel/BtnConfirm/Text")
	self.btnSeaonRelicConfirm = UIControls.Button(self, "SeasonPanel/BtnConfirm")

	self.btnSeaonRelicConfirm:addEventClick(self.onBtnSeasonRelicConfirmClick)

	self.txtHeroName = UIControls.Label(self, "TextName")
	self.gridArtifactImgNone = UIControls.Image(self, "EquipPanel/BadgeGrid/ImgNone")
	self.gridRelicImgNone = UIControls.Image(self, "EquipPanel/RelicGrid/ImgNone")
	self.imgArtifactNew = UIControls.Image(self, "EquipPanel/BadgeGrid/IconNew")
	self.imgRelicNew = UIControls.Image(self, "EquipPanel/RelicGrid/IconNew")
	self.btnTabBadge = UIControls.Button(self, "RelicBadeTabPanel/BtnBadge")

	self.btnTabBadge:addEventClick(self.onBtnTabBadgeClick)

	self.btnTabRelic = UIControls.Button(self, "RelicBadeTabPanel/BtnRelic")

	self.btnTabRelic:addEventClick(self.onBtnTabRelicClick)

	self.btnSeason = UIControls.Button(self, "RelicBadeTabPanel/BtnSeason")

	self.btnSeason:addEventClick(self.onBtnSeasonClick)

	self.iconNewbtnSeason = UIControls.Image(self, "RelicBadeTabPanel/BtnSeason/IconNew")

	self:onBtnTabBadgeClick()

	self.efxEquipGridList = {}
	self.efxSuitGridList = {}
	self.equipGridPanelList = {}

	for part = 1, 6 do
		local equipGridEfx = UIControls.LazyEffectPlayer(self, "EquipPanel/EquipGrid" .. part .. "/EfxEquipGrid")

		self.efxEquipGridList[part] = equipGridEfx

		local suitGridEfx = UIControls.LazyEffectPlayer(self, "EquipPanel/EquipGrid" .. part .. "/EfxEquipGrid02")

		self.efxSuitGridList[part] = suitGridEfx

		local equipGrid = EquipWearGridPanel(self, "EquipPanel/EquipGrid" .. part)

		self.equipGridPanelList[part] = equipGrid
	end

	self.efxArtifactGrid = UIControls.LazyEffectPlayer(self, "EquipPanel/BadgeGrid/EfxBadgeGrid")
	self.seasonReliceLvUpEfx = UIControls.LazyEffectPlayer(self, "SeasonPanel/BgSensonLogo/LvUpEfx")
	self.efxRelicGrid = UIControls.LazyEffectPlayer(self, "EquipPanel/RelicGrid/EfxRelicGrid")
	self.btnGofor = UIControls.Button(self, "SuitPanel2/SuitSpePanel/BtnGofor")

	self.btnGofor:addEventClick(self.onBtnGoforClick)
end

function HeroContentEquipPanel:onBtnSeasonRelicConfirmClick()
	local cannotUp = false
	local showItemId

	for index = 1, 2 do
		local haveNum = CurAvatar:getItemNumById(self.seasonRelicNeed[index].id)

		if haveNum < self.seasonRelicNeed[index].num then
			cannotUp = true
			showItemId = showItemId or self.seasonRelicNeed[index].id
		end
	end

	if not cannotUp then
		if self.lockSeasonRelic then
			RPC.seasonRelicOp(self.hero.seasonRelicId, Const.SEASON_RELIC_UNLOCK, 1)
		else
			local relic = self.hero:getSeasonRelic()

			if relic then
				RPC.seasonRelicOp(self.hero.seasonRelicId, Const.SEASON_RELIC_UPLEVEL, relic.enhanceLevel + 1)
			end
		end
	else
		CurAvatar:jumpToShowItem(showItemId, self.mWindow)
		MsgManager.notice(Lang.get(30678))
	end
end

function HeroContentEquipPanel:onTabSuitNmlClick()
	self.suitNmlPanel:setVisible(true)
	self.suitSpePanel:setVisible(false)
	self.btnTabSuitNml:setEnable(false)
	self.btnTabSuitSpe:setEnable(true)
end

function HeroContentEquipPanel:onTabSuitSpeClick()
	self.suitNmlPanel:setVisible(false)
	self.suitSpePanel:setVisible(true)
	self.btnTabSuitNml:setEnable(true)
	self.btnTabSuitSpe:setEnable(false)
end

function HeroContentEquipPanel:onTabSuitSpeDisClick()
	MsgManager.clientNotice(497)
end

function HeroContentEquipPanel:onSuitSensorClick()
	for i, v in ipairs(self.suitPanelList) do
		self.suitPanelList[i].txtDesBg:setVisible(false)
	end

	self.suitSensor:setVisible(false)
end

function HeroContentEquipPanel:onBtnMoreClick()
	self.attrPanel:setVisible(true)
	self.attrLessPanel:setVisible(false)
	self.suitPanel:setVisible(false)
end

function HeroContentEquipPanel:onBtnLessClick()
	self.attrPanel:setVisible(false)
	self.attrLessPanel:setVisible(true)
	self.suitPanel:setVisible(true)
end

function HeroContentEquipPanel:setHero(hero)
	local isSameHero = self.hero ~= nil and self.hero.gid == hero.gid or false

	self.hero = hero

	self.txtHeroName:setText(self.hero.name)

	if self.btnTabSuitSpe then
		self.btnTabSuitSpe:setVisible(CurAvatar:isOpenCustomEquip(self.hero.id))
		self.btnTabSuitSpeDis:setVisible(not self.btnTabSuitSpe:getVisible())
	end

	if not isSameHero then
		local haveCanWear = CurAvatar:isHaveCanWearRelic(self.hero)

		self.btnRelicGrid:setVisible(haveCanWear)
	end

	self:refreshArtifactAndRelicInfo()

	self.equipList = self.hero:getEquips()

	if self.equipList then
		self:refreshEquipInfo()
	else
		self:clearEquipInfo()
	end

	self:refreshEquipAttrPanel()

	if self.btnTabSuitSpe and not self.btnTabSuitSpe:getVisible() then
		self:onTabSuitNmlClick()
	end

	for i, _ in ipairs(self.imgEquipNewList) do
		self.imgEquipNewList[i]:setVisible(false)
	end

	for i, _ in ipairs(self.imgEquipEvoNewList) do
		self.imgEquipEvoNewList[i]:setVisible(false)
	end

	self.imgIconEquipNew:setVisible(false)
	self.imgArtifactNew:setVisible(false)
	self.imgRelicNew:setVisible(false)

	local canEquipPartList = CurAvatar:getHeroCanEquipPart(self.hero, nil, nil, nil, nil, true)

	for _, part in ipairs(canEquipPartList) do
		if part == Const.PART_OF_RELIC then
			self.imgRelicNew:setVisible(true)
		elseif part == Const.PART_OF_ARTIFACT then
			self.imgArtifactNew:setVisible(true)
			self.imgIconEquipNew:setVisible(true)
		else
			self.imgEquipNewList[part]:setVisible(true)
			self.imgIconEquipNew:setVisible(true)
		end
	end

	if not self.imgRelicNew:getVisible() and self.hero:getRelic() then
		self.imgRelicNew:setVisible(CurAvatar:relicCanLvUp(self.hero:getRelic()))
	end

	local canEquipEvoPartList = CurAvatar:getCanEvoEquipPart(self.hero)

	for _, part in ipairs(canEquipEvoPartList) do
		if not self.imgEquipNewList[part]:getVisible() then
			self.imgEquipEvoNewList[part]:setVisible(true)
		end
	end

	if self.mWindow:isInShow() and not self.mWindow.mOpening then
		self.mWindow:showEquipWall()
	end
end

function HeroContentEquipPanel:onBtnTabBadgeClick()
	self.btnTabRelic:setEnable(true)
	self.btnTabBadge:setEnable(false)
	self.btnSeason:setEnable(true)

	self.curSkillInfoTab = TAB_BADGE

	if self.hero then
		self:refreshArtifactAndRelicInfo()
	end
end

function HeroContentEquipPanel:onBtnTabRelicClick()
	self.btnTabRelic:setEnable(false)
	self.btnTabBadge:setEnable(true)
	self.btnSeason:setEnable(true)

	self.curSkillInfoTab = TAB_RELIC

	if self.hero then
		self:refreshArtifactAndRelicInfo()
	end
end

function HeroContentEquipPanel:onBtnSeasonClick()
	self.btnTabRelic:setEnable(true)
	self.btnTabBadge:setEnable(true)
	self.btnSeason:setEnable(false)

	self.curSkillInfoTab = TAB_SEASON

	if self.hero then
		self:refreshArtifactAndRelicInfo()
	end
end

function HeroContentEquipPanel:refreshArtifactAndRelicInfo()
	if self.hero:checkSeasonRelicOpen() then
		self.btnSeason:setVisible(true)
	else
		self.btnSeason:setVisible(false)

		if self.curSkillInfoTab == TAB_SEASON then
			self:onBtnTabBadgeClick()
		end
	end

	self:refreshSeasonRelicInfo()

	self.artifact = self.hero:getArtifact()

	if self.artifact then
		self:refreshArtifactInfo()
	else
		self:clearArtifactInfo()
	end

	self.relic = self.hero:getRelic()

	if self.relic then
		self:refreshRelicInfo()
	else
		self:clearRelicInfo()
	end
end

function HeroContentEquipPanel:playEquipPartEfx(effectPartList, suitEffPartList)
	if self.mWindow:isInShow() and not self.mWindow.mOpening then
		self:playPartEfx(effectPartList, suitEffPartList)
	else
		self.effectPartList = effectPartList
		self.suitEffPartList = suitEffPartList
	end
end

function HeroContentEquipPanel:playEquipAttrNum(equipAttrDiff)
	for _, data in ipairs(equipAttrDiff) do
		table.insert(self.equipAttrDiff, data)
	end

	if self.mWindow:isInShow() and not self.mWindow.mOpening then
		self:realPlayEquipAttrNum()
	end
end

function HeroContentEquipPanel:realPlayEquipAttrNum()
	return
end

function HeroContentEquipPanel:playEquipAttrQueue()
	self.panelNum:showTopNumAuxNum(tostring(self.equipAttrDiff[1][3]), Const.NUM_TYPE.EQUIP_ATTR, "", self.panelNum)
	table.remove(self.equipAttrDiff, 1)

	if #self.equipAttrDiff == 0 then
		self:clearAttrNumShow()
	end
end

function HeroContentEquipPanel:playPartEfx(effectPartList, suitEffPartList)
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

function HeroContentEquipPanel:playSeasonRelicEfx(...)
	if self.mWindow:isInShow() and not self.mWindow.mOpening then
		self.willPlaySeasonRelicEfx = true

		self:realPlaySeasonRelicEfx()
	else
		self.willPlaySeasonRelicEfx = true
	end

	self:refreshArtifactAndRelicInfo()
end

function HeroContentEquipPanel:realPlaySeasonRelicEfx(...)
	if self.willPlaySeasonRelicEfx then
		self.seasonReliceLvUpEfx:playEffect()

		self.willPlayArtifactEfx = nil
	end

	if self.mWindow:isInShow() and not self.mWindow.mOpening then
		self.mWindow:showEquipWall()
	end
end

function HeroContentEquipPanel:playArtifactEfx()
	if self.mWindow:isInShow() and not self.mWindow.mOpening then
		self.willPlayArtifactEfx = true

		self:realPlayArtifactEfx()
	else
		self.willPlayArtifactEfx = true
	end
end

function HeroContentEquipPanel:realPlayArtifactEfx()
	if self.willPlayArtifactEfx then
		self.efxArtifactGrid:playEffect()

		self.willPlayArtifactEfx = nil
	end
end

function HeroContentEquipPanel:playRelicEfx()
	if self.mWindow:isInShow() and not self.mWindow.mOpening then
		self.willPlayRelicEfx = true

		self:realPlayRelicEfx()
	else
		self.willPlayRelicEfx = true
	end
end

function HeroContentEquipPanel:realPlayRelicEfx()
	if self.willPlayRelicEfx then
		self.efxRelicGrid:playEffect()

		self.willPlayRelicEfx = nil
	end

	self.mWindow:showEquipWall()
end

function HeroContentEquipPanel:setVisible(isVisible)
	self:clearEfx()
	self:clearAttrNumShow()
	HeroContentEquipPanel.super.setVisible(self, isVisible)
end

function HeroContentEquipPanel:clearEfx()
	self.effectPartList = nil
	self.suitEffPartList = nil
	self.willPlayArtifactEfx = nil

	self.efxArtifactGrid:stopEffect()

	self.willPlayRelicEfx = nil

	self.efxRelicGrid:stopEffect()

	for part, _ in ipairs(self.efxEquipGridList) do
		self.efxEquipGridList[part]:stopEffect()
		self.efxSuitGridList[part]:stopEffect()
	end
end

function HeroContentEquipPanel:clearAttrNumShow()
	if self.timerEquipAttr then
		self.timerEquipAttr:Stop()

		self.timerEquipAttr = nil
	end

	self.equipAttrDiff = {}
end

function HeroContentEquipPanel:onBtnEquipClick()
	CurAvatar:heroQuickWear(self.hero)
end

function HeroContentEquipPanel:onBtnEquipOffClick()
	CurAvatar:heroQuickUnload(self.hero)
end

function HeroContentEquipPanel:onClose()
	HeroContentEquipPanel.super.onClose(self)
	self.mWindow:delEquipWall()
end

local HERO_EQUIP_SHOW_ATTR = {
	"mhp",
	"atk",
	"p_def",
	"cri_rate",
	"cri_dmg",
	"assist_enhance",
	"effect_hit"
}

function HeroContentEquipPanel:refreshEquipAttrPanel()
	self.realHeroAttr = PropHelper.getHeroPanelAttrContainer(self, self.hero.id, self.hero:getPropLevel(), self.hero.battleStep, self.hero.star, self.equipList, self.hero:getArtifact(), self.hero, self.hero:getSkinData(), self.hero:getBaseData(), self.hero:getRelic(), self.hero:getPaintData(), self.hero:getRelationPointData())
	self.nakedHeroAttr = PropHelper.getHeroPanelAttrContainer(self, self.hero.id, self.hero:getPropLevel(), self.hero.battleStep, self.hero.star, {}, nil, self.hero, self.hero:getSkinData(), self.hero:getBaseData(), self.hero:getRelic(), self.hero:getPaintData(), self.hero:getRelationPointData())

	for i = #HERO_EQUIP_SHOW_ATTR + 1, 8 do
		self.equipAttrPanelList[i]:setVisible(false)
		self.lessAttrPanelList[i]:setVisible(false)
	end

	local propUpLimit = PropHelper.getEquipAttrUplimit(self.equipList)

	for i, _ in ipairs(HERO_EQUIP_SHOW_ATTR) do
		local attrName = HERO_EQUIP_SHOW_ATTR[i]
		local realValue = self.realHeroAttr[attrName] or 0
		local realZhName, realValueStr = ClientUtils.getRolePropZhName(attrName, realValue, true)
		local nakedValue = self.nakedHeroAttr[attrName] or 0
		local diffValue = realValue - nakedValue
		local diffZhName, diffValueStr = ClientUtils.getRolePropZhName(attrName, diffValue, true)
		local iconInfo = ClientUtils.getRolePropIcon(attrName)

		self.lessAttrPanelList[i]:setData(realZhName, diffValueStr, nil)
		self.equipAttrPanelList[i]:setData(realZhName, realValueStr, "+" .. diffValueStr)
		self.lessAttrPanelList[i].imgIcon:setImage(iconInfo[1], iconInfo[2])
		self.equipAttrPanelList[i].imgIcon:setImage(iconInfo[1], iconInfo[2])

		if propUpLimit[attrName] then
			self.lessAttrPanelList[i].txtOriValue:setFontColor(ResColor.QUALITYORANGE)
			self.equipAttrPanelList[i].txtTargetValue:setFontColor(ResColor.QUALITYORANGE)
		else
			self.lessAttrPanelList[i].txtOriValue:setFontColor(ResColor.WHITE)
			self.equipAttrPanelList[i].txtTargetValue:setFontColor(ResColor.GREEN)
		end
	end
end

function HeroContentEquipPanel:refreshArtifactInfo()
	if not self.gridArtifact then
		self.gridArtifact = EquipPanelGridArtifact(self, "EquipPanel/BadgeGrid/GridBadgeSmallWearItem")
		self.gridArtifact.mEnableTips = true
		self.gridArtifact.mTipsConfig = self.tipsFuncItem

		self.gridArtifact:setVisible(true)
	end

	self.artifactSkillPanel:setVisible(self.curSkillInfoTab == TAB_BADGE)
	self.bgSkillNone:setVisible(false)
	self.btnArtifactGrid:setEnable(false)
	self.gridArtifact:setArtifact(self.artifact)
	self.gridArtifactImgNone:setVisible(not self.artifact)

	local artifactPath = self.gridArtifact.object:getIconPath()

	self.imgArtifactiIcon:setImage(artifactPath[1], artifactPath[2])

	local artifactBgPath = self.gridArtifact.object:getCareerBgIconPath()

	self.imgArtifactiBgIcon:setImage(artifactBgPath[1], artifactBgPath[2])

	local skill = self.gridArtifact.object.skill

	if skill then
		self.txtArtifactSkillName:setText(skill.name)
		self.txtArtifactSkillDes:setText(skill.desc)
		self.txtArtifactSkillLv:setText(skill.level)
		self.txtArtifactSkillLvMax:setText(string.format(Lang.get(30171), #ResPassiveSkill[self.artifact.resData.passive_id]))
	end
end

function HeroContentEquipPanel:clearArtifactInfo()
	if self.gridArtifact then
		self.gridArtifact:setVisible(false)
	end

	self.artifactSkillPanel:setVisible(false)
	self.bgSkillNone:setVisible(self.curSkillInfoTab == TAB_BADGE)
	self.btnArtifactGrid:setEnable(true)
	self.gridArtifactImgNone:setVisible(true)

	self.gridArtifact = nil
end

function HeroContentEquipPanel:refreshRelicInfo()
	if not self.gridRelic then
		self.gridRelic = UIControls.RelicGridPanel(self, "EquipPanel/RelicGrid/GridRelicSmallItem")
		self.gridRelic.mEnableTips = false

		self.gridRelic:setVisible(true)

		self.gridRelic.mEventClick = Slot(self.onRelicGridClick, self)
	end

	self.bgRelicNone:setVisible(false)
	self.relicTabInfoPanel:setVisible(self.curSkillInfoTab == TAB_RELIC)
	self.relicTabInfoPanel:setRelic(self.relic)
	self.gridRelic:setObj(self.relic)
	self.gridRelic:hideLimitInfo()

	local panelQualityPath = self.relic:getPanelQualityPath()

	self.gridRelic.imgQuality:setImage(panelQualityPath[1], panelQualityPath[2])
	self.btnRelicGrid:setEnable(false)
	self.gridRelicImgNone:setVisible(not self.relic)
end

function HeroContentEquipPanel:clearRelicInfo()
	if self.gridRelic then
		self.gridRelic:setVisible(false)
	end

	self.btnRelicGrid:setEnable(true)
	self.bgRelicNone:setVisible(self.curSkillInfoTab == TAB_RELIC)
	self.relicTabInfoPanel:setVisible(false)
	self.gridRelicImgNone:setVisible(true)

	self.gridRelic = nil
end

function HeroContentEquipPanel:refreshSeasonRelicInfo(...)
	self.seasonRelicPanel:setVisible(self.curSkillInfoTab == TAB_SEASON)

	if self.curSkillInfoTab == TAB_SEASON then
		if CurAvatar:checkFirstSeasonShow(self.hero.id) then
			self.showSeasonUnLock:setVisible(true)
			CurAvatar:removeFirstShowSeasonRelicHero(self.hero.id)
		else
			self.showSeasonUnLock:setVisible(false)
		end
	end

	self.iconNewbtnSeason:setVisible(CurAvatar:getSeasonRelicRedDotByHeroId(self.hero.id))

	local relic, costItemData

	self.lockSeasonRelic = true

	if self.hero:checkMyHeroUnlockSeasonRelic() then
		self.lockSeasonRelic = false

		self.txtSeaonRelicConfirm:setText(Lang.get(290))

		relic = self.hero:getSeasonRelic()
		costItemData = relic:getSeasonLvUpNeed()

		self.txtSeasonRelicLv:setText(utils.format(Lang.get(90278), relic.enhanceLevel + 1))

		if relic:isEnhanceLvMax() then
			self.panelSeasonPrice:setVisible(false)
			self.btnSeaonRelicConfirm:setVisible(false)
		else
			self.panelSeasonPrice:setVisible(true)
			self.btnSeaonRelicConfirm:setVisible(true)
		end
	else
		self.panelSeasonPrice:setVisible(true)
		self.btnSeaonRelicConfirm:setVisible(true)

		if self.hero.seasonRelicId and self.hero.seasonRelicId ~= 0 then
			relic = Relic({
				id = self.hero.seasonRelicId
			})

			self.txtSeasonRelicLv:setText(Lang.get(110743))
			self.txtSeaonRelicConfirm:setText(Lang.get(482))

			costItemData = relic:getSeasonUnlockResData()
		end
	end

	if costItemData then
		local use = costItemData.use

		self.seasonRelicNeed = {}

		for index = 1, 2 do
			self.seasonRelicNeed[index] = {}
			self.seasonRelicNeed[index].id = use[index].id
			self.seasonRelicNeed[index].num = use[index].num
		end

		self.txtSeasonPriceNum1:setText(use[1].num)
		self.txtSeasonPriceNum2:setText(use[2].num)

		local haveNum1 = CurAvatar:getItemNumById(use[1].id)

		if haveNum1 >= use[1].num then
			self.txtSeasonPriceNum1:setFontColor(ResColor.WHITE)
		else
			self.txtSeasonPriceNum1:setFontColor(ResColor.RED)
		end

		local haveNum2 = CurAvatar:getItemNumById(use[2].id)

		if haveNum2 >= use[2].num then
			self.txtSeasonPriceNum2:setFontColor(ResColor.WHITE)
		else
			self.txtSeasonPriceNum2:setFontColor(ResColor.RED)
		end

		local iconData1 = BaseObject.getItemIconPath(use[1].id)

		if iconData1 then
			self.iconSeasonPrice1:setImage(iconData1[1], iconData1[2])
		end

		local iconData2 = BaseObject.getItemIconPath(use[2].id)

		if iconData2 then
			self.iconSeasonPrice2:setImage(iconData2[1], iconData2[2])
		end
	end

	if relic then
		local passiveResData = relic:getPassiveResData()

		if passiveResData then
			self.txtSeasonRelicName:setText(relic.name)
			self.txtSeasonRelicDes:setText(passiveResData.desc)
		end

		local logoData = relic:getSeasonLogoResData()

		if logoData then
			self.iconSeasonLogo:setImage(logoData[1], logoData[2])
		end
	end
end

function HeroContentEquipPanel:clearEquipInfo()
	if self.equipGridPanelList then
		for i, v in pairs(self.equipGridPanelList) do
			self.equipGridPanelList[i]:clearEquip()
		end
	end
end

function HeroContentEquipPanel:refreshEquipInfo()
	self:clearEquipInfo()

	for i, v in ipairs(self.btnEquipGridList) do
		self.btnEquipGridList[i]:setEnable(true)
	end

	for subType = 1, 6 do
		if self.equipList[subType] then
			self.equipGridPanelList[subType]:setEquip(self.equipList[subType])

			self.equipGridPanelList[subType].gridWear.mTipsConfig = self.tipsFuncItem

			self.btnEquipGridList[subType]:setEnable(false)
		else
			self.equipGridPanelList[subType]:clearEquip()
		end
	end

	self:refreshSuitPanel()
end

function HeroContentEquipPanel:refreshSuitPanel()
	local suits = self.hero:getSuits()

	if suits and #suits > 0 then
		for i = #suits + 1, #self.suitPanelList do
			self.suitPanelList[i]:setVisible(false)
		end

		for i, v in ipairs(suits) do
			self.suitPanelList[i]:setVisible(true)
			self.suitPanelList[i]:setData(v)
		end

		self.suitNone:setVisible(false)
	else
		self.suitNone:setVisible(true)

		for i, v in ipairs(self.suitPanelList) do
			self.suitPanelList[i]:setVisible(false)
		end
	end

	if Const.EQUIP_TOWER_OPEN_CUSTOM_LAYER then
		local speSuits = self.hero:getSpeSuitCounts()
		local activeSuitsInfo = self.hero:getActiveSpeSuitsInfo()

		if activeSuitsInfo then
			local speSuitsNum = self.hero:getRealSpeSuitCounts(speSuits[activeSuitsInfo.effect_id], #speSuits[activeSuitsInfo.effect_id])

			self.textSpeNone:setVisible(false)
			self.textSpeNum:setVisible(true)
			self.textSpeAttr:setVisible(true)

			local effectInfo = ResEquipTowerCustomEquipEffect[activeSuitsInfo.effect_id]

			self.txtTabSuitSpe:setText(utils.format(Lang.get(51265), speSuitsNum, effectInfo[#effectInfo].num))
			self.textSpeNum:setText(string.format(Lang.get(51266), activeSuitsInfo.num))
			self.textSpeAttr:setText(activeSuitsInfo.effect_desc)
		else
			self.textSpeNone:setVisible(true)
			self.textSpeNum:setVisible(false)
			self.textSpeAttr:setVisible(false)
		end
	end

	self.btnGofor:setVisible(CurAvatar:hasEquipTowerGetCustomLayer())
end

function HeroContentEquipPanel:onBtnGoforClick()
	UIManager.getUI("equipSuitSpeInquireDlg", true):setData(true, self.hero)
end

function HeroContentEquipPanel:onEquipGridClick(sender)
	local clickSubType = 0

	for i, v in ipairs(self.btnEquipGridList) do
		if self.btnEquipGridList[i] == sender then
			clickSubType = i
		end
	end

	CurAvatar:openWearDlg(Const.WEAR_TYPE_EQUIP, self.hero, clickSubType)
end

local function confirmOffEquip(obj)
	RPC.equipOff(obj.inWearing, {
		obj.subType - 1
	})
end

function HeroContentEquipPanel:onTakeOffEquip(grid)
	local obj = grid ~= nil and grid.object or nil

	if obj and obj.itemType == Const.ITEM_TYPE_ARTIFACT then
		RPC.artifactOff(self.hero.gid, obj.gid)
	elseif obj and obj.itemType == Const.ITEM_TYPE_EQUIP then
		RPC.equipOff(obj.inWearing, {
			obj.subType - 1
		})
	end
end

function HeroContentEquipPanel:onReplaceEquip(grid)
	local obj = grid.object

	if obj and obj.inWearing then
		local wearType = 0
		local filterAttr = 0

		if obj.itemType == Const.ITEM_TYPE_ARTIFACT then
			wearType = Const.WEAR_TYPE_ARTIFACT
			filterAttr = self.hero.career
		elseif obj.itemType == Const.ITEM_TYPE_EQUIP then
			wearType = Const.WEAR_TYPE_EQUIP
			filterAttr = obj.subType
		end

		CurAvatar:openWearDlg(wearType, CurAvatar.heroDic[obj.inWearing], filterAttr)
	end
end

function HeroContentEquipPanel:onLockEquip(grid)
	local obj = grid.object

	if obj then
		if obj.itemType == Const.ITEM_TYPE_ARTIFACT then
			CurAvatar:onLockArtifact(grid)
		elseif obj.itemType == Const.ITEM_TYPE_EQUIP then
			CurAvatar:onLockEquip(grid)
		end
	end

	return true
end

function HeroContentEquipPanel:onItemTakeOffCheck(grid)
	local obj = grid.object

	if obj.inWearing then
		return true
	else
		return false
	end
end

function HeroContentEquipPanel:onUpgradeEquip(grid)
	local obj = grid.object

	if obj then
		local upgradeType = 0

		if obj.itemType == Const.ITEM_TYPE_ARTIFACT then
			upgradeType = Const.WEAR_TYPE_ARTIFACT
		elseif obj.itemType == Const.ITEM_TYPE_EQUIP then
			upgradeType = Const.WEAR_TYPE_EQUIP
		end

		CurAvatar:openUpgradeEquipDlg(upgradeType, obj)
	end
end

function HeroContentEquipPanel:onUpgradeEquipCheck(grid)
	local obj = grid.object

	if obj then
		if obj.itemType == Const.ITEM_TYPE_ARTIFACT then
			local limitLevel = ResArtifactLevelUp[obj.breakLevel].limit_level

			return limitLevel > obj.enhanceLevel
		elseif obj.itemType == Const.ITEM_TYPE_EQUIP then
			return true
		end
	end
end

function HeroContentEquipPanel:onUpgradeEnableCheck(grid)
	local obj = grid.object

	if obj then
		if obj.itemType == Const.ITEM_TYPE_ARTIFACT then
			return true
		elseif obj.itemType == Const.ITEM_TYPE_EQUIP then
			if obj.canEnhance and obj.canEnhance == 1 then
				return true
			else
				return false
			end
		end
	end
end

function HeroContentEquipPanel:onBreakArtifactCheck(grid)
	local obj = grid.object

	if obj then
		if obj.itemType == Const.ITEM_TYPE_ARTIFACT then
			local limitLevel = ResArtifactLevelUp[obj.breakLevel].limit_level

			return limitLevel == obj.enhanceLevel
		elseif obj.itemType == Const.ITEM_TYPE_EQUIP then
			return false
		end
	end
end

function HeroContentEquipPanel:onItemReplaceCheck(grid)
	local obj = grid.object

	if obj.inWearing then
		return true
	else
		return false
	end
end

function HeroContentEquipPanel:onItemLockCheck(grid)
	return true
end

function HeroContentEquipPanel:onItemVisibleCheck(grid)
	local obj = grid.object

	if obj then
		if obj.itemType == Const.ITEM_TYPE_ARTIFACT then
			return false
		elseif obj.itemType == Const.ITEM_TYPE_EQUIP then
			return true
		end
	end
end

function HeroContentEquipPanel:onItemDestroyCheck(grid)
	return false
end

function HeroContentEquipPanel:destroy()
	UIUtils.ClearBattleStackByType(Const.NUM_TYPE.EQUIP_ATTR)
	self:clearAttrNumShow()
	self:clearEfx()
	HeroContentEquipPanel.super.destroy(self)
end

function HeroContentEquipPanel:onDestroyEquip(grid)
	local obj = grid.object

	if obj and obj.itemType and obj.itemType == Const.ITEM_TYPE_EQUIP then
		MsgManager.clientNotice(285)

		return true
	elseif obj then
		MsgManager.clientNotice(286)

		return true
	end
end

function HeroContentEquipPanel:onArtifactGridClick(sender)
	CurAvatar:openWearDlg(Const.WEAR_TYPE_ARTIFACT, self.hero, self.hero.resData.career)
end

function HeroContentEquipPanel:onRelicGridClick(sender)
	CurAvatar:openWearDlg(Const.WEAR_TYPE_RELIC, self.hero)
end

return HeroContentEquipPanel
