-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\RoleInfo\\RoleInfoHeroDlg.lua

local HeroAttrPanel = require("UI/Hero/HeroAttrPanel")
local ResStarUpCondition = require("ClientData/ResStarUpCondition")
local ModelTool = require("Entity/ModelTool")
local PropHelper = require("Common/FrameBattle/BattleObject/PropHelper")
local ModelFactory = Framework.Entity.ModelFactory
local GameSettings = require("Helper/GameSettings")
local STAGE_CAMERA_MOVE_DUR = 0.8
local HERO_STAGE_CAMERA_RIGHT = {
	16.54,
	11.87,
	109.95
}
local HERO_STAGE_CAMERA_LEFT = {
	10.54,
	11.87,
	109.95
}
local SHADOW_DISTANCE_DEFAULT = 25
local ATTR_PANEL_PROP_MAP = {
	{
		prop = "atk"
	},
	{
		prop = "mhp"
	},
	{
		prop = "p_def"
	},
	{
		prop = "cri_rate"
	},
	{
		prop = "cri_dmg"
	},
	{
		prop = "assist_enhance"
	},
	{
		prop = "effect_hit"
	}
}
local HERO_MAIN_DLG_SHOW_STATE = {
	HERO_LIST = 0,
	DETAIL_INFO = 1,
	HERO_SKIN = 2
}
local InfoEquipGrid = Class("InfoEquipGrid", UIControls.EquipGridPanel)

function InfoEquipGrid:setEquip(obj, equipList)
	obj.equipList = equipList

	self:setObj(obj)
	self.imgQuality:setImage("Atlas/HeroAtlas/HeroEquipAtlas", self:getEquipQualitySprite())
	self.imgQuality:setObjColor(self.object:getQualityColor())
	self:setVisible(true)
end

function InfoEquipGrid:getEquipQualitySprite()
	if self.object.subType == 1 or self.object.subType == 4 then
		return "BgSpecialItem011"
	elseif self.object.subType == 2 or self.object.subType == 5 then
		return "BgSpecialItem021"
	elseif self.object.subType == 3 or self.object.subType == 6 then
		return "BgSpecialItem031"
	end
end

function InfoEquipGrid:clearEquip()
	self:clear()
	self:setVisible(false)
end

local InfoEquipPanel = Class("InfoEquipPanel", UIControls.Panel)

function InfoEquipPanel:ctor()
	self.gridWear = InfoEquipGrid(self, self.mPath .. "/GridEquipWearItem")
end

function InfoEquipPanel:setEquip(obj, equipList)
	self.gridWear.mEnableTips = true

	self.gridWear:setEquip(obj, equipList)
end

function InfoEquipPanel:clearEquip()
	self.gridWear:clearEquip()
end

local InfoArtifact = Class("InfoArtifact", UIControls.ArtifactGridPanel)

function InfoArtifact:setArtifact(obj)
	self:setObj(obj)
end

function InfoArtifact:clearArtifact()
	self:clear()
end

local strClassName = "RoleInfoHeroDlg"
local RoleInfoHeroDlg = Class(strClassName, UIControls.Window)

function RoleInfoHeroDlg:ctor(...)
	self:initUI()

	self._slot4LoadNewModelEnd = Slot(self.deleteOtherModel, self)
end

function RoleInfoHeroDlg:initUI(...)
	self.btnClose = UIControls.Button(self, "BtnClose", "Text")

	self.btnClose:addEventClick(self.onCloseClick)

	if UIControls.checkControlFunc(self, "BtnTips") then
		self.btnTips = UIControls.Button(self, "BtnTips")

		self.btnTips:addEventClick(self.onTipsClick)
		self:setTipId(nil)
	end

	self.modelViewport = UIControls.RawImage(self, "ModelViewport")
	self.modelStage = ModelStageManager.createUIModelStage(self, "ModelStage/RoleInfoHeroDlgModelStage")
	self.modelControl = UIControls.Panel(self, "ModelControl")

	self.modelStage:initOperation(self.modelControl)

	self.modelStage.mEventOprFingerDown = Slot(self.onDragStart, self)
	self.modelStage.mEventOprFingerUp = Slot(self.onDragEnd, self)
	self.btnHeroNext = UIControls.Button(self, "BtnHeroNext")

	self.btnHeroNext:addEventClick(self.onHeroNextClick)

	self.btnHeroLast = UIControls.Button(self, "BtnHeroLast")

	self.btnHeroLast:addEventClick(self.onHeroLastClick)

	self.uiAni = UIControls.UIAni(self, "")

	if CurAvatar then
		self.currentEntity = CurAvatar
	end

	self.gridSkillList = {}

	local path = "HeroContentPanel/HeroContentBaseInfoPanel/"

	self.imgCareerIcon = UIControls.Image(self, path .. "InfoPanel/IconCareer/Icon")
	self.txtCareer = UIControls.Label(self, path .. "InfoPanel/IconCareer/Text")
	self.txtHeroLv = UIControls.Label(self, path .. "InfoPanel/TextLvPanel/TextLv")
	self.bgStage = UIControls.Label(self, path .. "InfoPanel/BgStageLv")
	self.txtStage = UIControls.Label(self, path .. "InfoPanel/BgStageLv/Text")
	self.txtName = UIControls.Label(self, path .. "InfoPanel/TextName")
	self.txtGroup = UIControls.Label(self, path .. "InfoPanel/IconGroup/Text")
	self.imgGroup = UIControls.Image(self, path .. "InfoPanel/IconGroup/Icon")
	self.txtPowerNum = UIControls.Label(self, path .. "InfoPanel/ImgPower/TextTitle/TextPower")
	self.imgIconHead = UIControls.Image(self, path .. "InfoPanel/BgHead/IconHead")
	self.imgIconHeadBg = UIControls.Image(self, path .. "InfoPanel/BgHead/Bg")
	self.btnInfo = UIControls.Button(self, path .. "InfoPanel/BtnInfo")

	self.btnInfo:addEventClick(self.onBtnInfoClick)

	self.imgLvMax = UIControls.Image(self, path .. "InfoPanel/IconLvMax")
	self.imgHeroStar = UIControls.Image(self, path .. "InfoPanel/ImgStar")

	if UIControls.checkControlFunc(self, path .. "InfoPanel/TextLvPanel/ImgCrystalLv") then
		self.imgCrystalLv = UIControls.Image(self, path .. "InfoPanel/TextLvPanel/ImgCrystalLv")
		self.txtCrystalLv = UIControls.Label(self, path .. "InfoPanel/TextLvPanel/ImgCrystalLv/TextCrystalLv")
	end

	self.btnDetail = UIControls.Button(self, path .. "AttrPanel/BtnDetail", "Text")

	self.btnDetail:addEventClick(self.onBtnDetailClick)

	self.attrList = {}
	self.attrMoreList = {}
	self.panelLessAttr = UIControls.Panel(self, path .. "AttrPanel/AttrLessPanel")
	self.panelMoreAttr = UIControls.Panel(self, path .. "AttrPanel/AttrMorePanel")

	for i = 1, 3 do
		local attrPanel = HeroAttrPanel(self, path .. "AttrPanel/AttrLessPanel/Attr" .. i)

		table.insert(self.attrList, attrPanel)
	end

	local attrPanel = HeroAttrPanel(self, path .. "AttrPanel/AttrLessPanel/Attr4")

	attrPanel:setVisible(false)

	for i = 1, 8 do
		local attrPanel = HeroAttrPanel(self, path .. "AttrPanel/AttrMorePanel/Attr0" .. i)

		table.insert(self.attrMoreList, attrPanel)
	end

	self.imgPaint = UIControls.Image(self, path .. "InfoPanel/BgHead/CoatingImg")

	if UIControls.checkControlFunc(self, path .. "InfoPanel/BgHead/IconCoating02") then
		self.iconCoating02 = UIControls.Image(self, path .. "InfoPanel/BgHead/IconCoating02")
		self.txtPaintPlusLv = UIControls.Label(self, path .. "InfoPanel/BgHead/IconCoating02/Text")
	end

	if UIControls.checkControlFunc(self, path .. "InfoPanel/BgHead/IconUR") then
		self.iconUR = UIControls.Panel(self, path .. "InfoPanel/BgHead/IconUR")
	end

	self.efxPainting = UIControls.Panel(self, path .. "InfoPanel/BgHead/CoatingImg/EfxCoating")
	self.panelSkill = UIControls.Panel(self, path .. "SkillPanel")
	path = "HeroContentPanel/HeroContentEquipPanel/"
	self.btnEquipGridList = {}

	for i = 1, 6 do
		local btnEquipGrid = UIControls.Button(self, path .. "EquipPanel/EquipGrid" .. i)

		self.btnEquipGridList[i] = btnEquipGrid
	end

	self.gridEquipList = {}
	self.txtPlayerName = UIControls.Label(self, "HeroContentPanel/TextPlayerName")
	self.btnHead = UIControls.PlayerHeadGridChild(self, "HeroContentPanel/GridPlayer", "System/Common/Grid/GridPlayerCommon")

	self.btnHead:setEnable(false)
	self.btnHead:setVisible(false)
	self.txtPlayerName:setVisible(false)

	self.btnRelicGrid = UIControls.Button(self, "HeroContentPanel/HeroContentEquipPanel/EquipPanel/RelicGrid")

	self.btnRelicGrid:addEventClick(self.onRelicGridClick)

	self.imgRelicNew = UIControls.Image(self, "HeroContentPanel/HeroContentEquipPanel/EquipPanel/RelicGrid/IconNew")
	self.gridRelicImgNone = UIControls.Image(self, "HeroContentPanel/HeroContentEquipPanel/EquipPanel/RelicGrid/ImgNone")

	self.gridRelicImgNone:setVisible(false)

	self.panelGame = UIControls.Panel(self, "HeroContentPanel/GamePanel")
	self.panelImgDes = UIControls.Panel(self, "HeroContentPanel/ImgDes")
	self.txtGamePlayDes = UIControls.Label(self, "HeroContentPanel/ImgDes/TxtDes")
end

function RoleInfoHeroDlg:onOpen()
	RoleInfoHeroDlg.super.onOpen(self)
	self.modelStage:connectImage(self.modelViewport)
	self.modelStage:moveCameraSmooth(HERO_STAGE_CAMERA_LEFT, 0)
end

function RoleInfoHeroDlg:onClose()
	GameSettings.resetShadowDistance("RoleInfoDlg")
	RoleInfoHeroDlg.super.onClose(self)
end

function RoleInfoHeroDlg:setData(heros, idx, orderCell)
	self.heros = heros
	idx = idx or 1

	self:setSelectHero(idx)

	local baseOrder = 0

	self.orderCell = orderCell

	if orderCell and orderCell.mWindow then
		baseOrder = orderCell.mWindow:getOrder()
	end

	self:setOrder(baseOrder + 5)
	self:setVisible(true)
end

function RoleInfoHeroDlg:setPlayerInfo(roleInfo)
	self.btnHead:setVisible(true)
	self.txtPlayerName:setVisible(true)
	self.btnHead:setPlayer(roleInfo.commInfo, false, self)
	self.txtPlayerName:setText(roleInfo.commInfo.name)
end

function RoleInfoHeroDlg:refreshUIForNewHero(newHero)
	for idx, hero in ipairs(self.heros) do
		if hero.gid == newHero.gid then
			self.heros[idx] = newHero
		end
	end

	self:setSelectHero(self.curCardIdx)
end

function RoleInfoHeroDlg:setSelectHero(idx)
	local hero = self.heros[idx]
	local isSameHero = self.selectedHero ~= nil and self.selectedHero.gid == hero.gid or false

	self.curCardIdx = idx

	self.btnHeroNext:setVisible(idx ~= #self.heros)
	self.btnHeroLast:setVisible(idx ~= 1)

	local isSameModel = self.selectedHero ~= nil and self.selectedHero:getShowModelId() == hero:getShowModelId()

	self.selectedHero = hero
	self.equipList = hero:getEquips()

	if isSameModel == false then
		if self.curModelInsId then
			self.autoRotateComponent = nil

			self.modelStage:delModel(self.curModelInsId)
		end

		local modelId = self.selectedHero:getShowModelId()
		local baseModelId = self.selectedHero:getShowBaseModelId()

		self.curModelInsId = self.modelStage:showHeroByModId(modelId, Const.MODEL_TYPE.ShowStepOne, nil, self._slot4LoadNewModelEnd, nil, baseModelId)

		if self.curModelInsId then
			self.modelStage:setOperateModel(self.curModelInsId)
		end
	elseif not isSameHero then
		self:playShowAnimation(self.curModelInsId)

		if self.autoRotateComponent then
			self.autoRotateComponent:ResetRotate()
		end
	end

	self:showEquipWall()
	self:refreshUI()
	GameSettings.setShadowDistance(SHADOW_DISTANCE_DEFAULT, "RoleInfoDlg")
end

function RoleInfoHeroDlg:deleteOtherModel(modelInsId, modelResID)
	self.autoRotateComponent = ModelTool.addAutoRotateComponent(modelInsId)

	if modelResID then
		ModelTool.addBaseModel(modelInsId, modelResID, 1, Const.HERO_BASE_TYPE.Hero1)
	end

	if modelInsId then
		local modelAux = ModelFactory.GetModelAux(modelInsId)

		if modelAux then
			modelAux:SetAnimatorNoCulling()
			modelAux:PlayAnimatorNow("Newshow_idle")
		end
	end
end

function RoleInfoHeroDlg:playShowAnimation(modelInsId)
	if modelInsId then
		local modelAux = ModelFactory.GetModelAux(modelInsId)

		if modelAux then
			modelAux:PlayAnimatorNow("Newshow_idle")
		end
	end
end

function RoleInfoHeroDlg:showEquipWall()
	if self.equipWallPath then
		local newWallPath = self.selectedHero:getWallPath()

		if newWallPath ~= self.equipWallPath then
			self:delEquipWall()

			self.equipWallPath = newWallPath
			self.equipWallId = self.modelStage:showModelByModelData(self.equipWallPath, "", {
				x = -0.02,
				y = -0.09
			}, nil, 0.7, 1)
		end
	else
		self.equipWallPath = self.selectedHero:getWallPath()
		self.equipWallId = self.modelStage:showModelByModelData(self.equipWallPath, "", {
			x = -0.02,
			y = -0.09
		}, nil, 0.7, 1)
	end

	local bgmId = self.selectedHero:getRelicBgmIdByType(Const.RELIC_BGM_TYPE_HERO_DLG)

	if bgmId then
		self:playLogicBGM(bgmId)
	end

	if self.seasonWallPath then
		local newLockSeasonWallPath = self.selectedHero:getSeasonRelicWallPath()

		if newLockSeasonWallPath ~= self.seasonWallPath then
			self:delLockSeasonWall()

			self.seasonWallPath = newLockSeasonWallPath

			if self.seasonWallPath then
				self.lockSeasonWallId = self.modelStage:showModelByModelData(self.seasonWallPath, "", {
					x = -0.02,
					y = -0.09
				}, nil, 0.7, 1)
			end
		end
	else
		self.seasonWallPath = self.selectedHero:getSeasonRelicWallPath()

		if self.seasonWallPath then
			self.lockSeasonWallId = self.modelStage:showModelByModelData(self.seasonWallPath, "", {
				x = -0.02,
				y = -0.09
			}, nil, 0.7, 1)
		else
			self:delLockSeasonWall()
		end
	end
end

function RoleInfoHeroDlg:delLockSeasonWall(...)
	if self.lockSeasonWallId then
		self.modelStage:delModel(self.lockSeasonWallId)

		self.lockSeasonWallId = nil
		self.seasonWallPath = nil
	end
end

function RoleInfoHeroDlg:delEquipWall()
	if self.equipWallId then
		self.modelStage:delModel(self.equipWallId)

		self.equipWallId = nil
		self.equipWallPath = nil
	end

	self:delLockSeasonWall()
end

function RoleInfoHeroDlg:refreshUI(...)
	self:refreshBaseInfo()
	self:refreshStarPanel()
	self:refreshPropPanel()
	self:refreshGridSkill()
	self:refreshArtifactInfo()
	self:refreshEquipInfo()
end

function RoleInfoHeroDlg:refreshArtifactInfo(...)
	self.artifact = nil
	self.artifact = self.selectedHero:getArtifact()

	if self.artifact then
		self:_refreshArtifactInfo()
	else
		self:clearArtifactInfo()
	end

	self.relic = self.selectedHero:getRelic()

	if self.relic then
		self:refreshRelicInfo()
	else
		self:clearRelicInfo()
	end
end

function RoleInfoHeroDlg:_refreshArtifactInfo()
	if not self.gridArtifact then
		self.gridArtifact = InfoArtifact(self, "HeroContentPanel/HeroContentEquipPanel/EquipPanel/BadgeGrid/GridBadgeSmallWearItem")
		self.gridArtifact.mEnableTips = true
		self.gridArtifact.mTipsConfig = self.tipsFuncItem

		self.gridArtifact:setVisible(true)
	end

	self.gridArtifact:setArtifact(self.artifact)
end

function RoleInfoHeroDlg:refreshEquipInfo()
	self:clearEquipInfo()

	for i, v in ipairs(self.btnEquipGridList) do
		self.btnEquipGridList[i]:setEnable(true)
	end

	local equipGrid

	for subType = 1, 6 do
		if not self.gridEquipList[subType] then
			self.gridEquipList[subType] = InfoEquipPanel(self, "HeroContentPanel/HeroContentEquipPanel/EquipPanel/EquipGrid" .. subType)
		end

		if self.equipList[subType] then
			self.gridEquipList[subType]:setEquip(self.equipList[subType], self.equipList)

			self.gridEquipList[subType].gridWear.mTipsConfig = self.tipsFuncItem

			self.btnEquipGridList[subType]:setEnable(false)
		else
			self.gridEquipList[subType]:clearEquip()
		end
	end
end

function RoleInfoHeroDlg:refreshGridSkill()
	for i = 1, 4 do
		if self.selectedHero[Const.SKILL_FIELD_LIST[i]] then
			if not self.gridSkillList[i] then
				self.gridSkillList[i] = UIControls.HeroSkillGridChild(self, "HeroContentPanel/HeroContentBaseInfoPanel/SkillPanel/SkillList", "System/Hero/GridHeroSkill", 0, 0, true)
			end

			self.gridSkillList[i].gridPanel = UIConst.SKILL_PANEL_ROLE_INFO

			local skill = self.selectedHero[Const.SKILL_FIELD_LIST[i]]

			self.gridSkillList[i]:setObj(skill, self.selectedHero)
		end
	end
end

function RoleInfoHeroDlg:refreshPropPanel()
	if self.imgCrystalLv then
		if self.selectedHero.crystalSecondLevel and self.selectedHero.crystalSecondLevel > 9 then
			self.imgCrystalLv:setVisible(true)
			self.txtCrystalLv:setText(math.floor(self.selectedHero.crystalSecondLevel / 10))
		else
			self.imgCrystalLv:setVisible(false)
		end
	end

	local equips = self.selectedHero:getEquips()
	local artifact = self.selectedHero:getArtifact()
	local propLevel = self.selectedHero:getPropLevel()

	self.container = PropHelper.getHeroPanelAttrContainer(self, self.selectedHero.id, propLevel, self.selectedHero.step, self.selectedHero.star, equips, artifact, self.selectedHero, self.selectedHero:getSkinData(), self.selectedHero:getBaseData(), self.selectedHero:getRelic(), self.selectedHero:getPaintData(), self.selectedHero:getRelationPointData())

	for i = 1, #ATTR_PANEL_PROP_MAP do
		local attrName = ATTR_PANEL_PROP_MAP[i].prop
		local value = self.container[attrName] or 0
		local zhName, valueStr = ClientUtils.getRolePropZhName(attrName, value, true)
		local attriconInfo = ClientUtils.getRolePropIcon(attrName)

		self.attrMoreList[i].imgIcon:setImage(attriconInfo[1], attriconInfo[2])
		self.attrMoreList[i]:setData(zhName, valueStr)

		if self.attrList[i] then
			self.attrList[i].imgIcon:setImage(attriconInfo[1], attriconInfo[2])
			self.attrList[i]:setData(zhName, valueStr)

			local rankValue = CurAvatar:getHeroPropValueByStep(attrName, self.selectedHero)
			local attrRank = CurAvatar:getHeroPropRank(attrName, rankValue)
			local rankIconInfo = UIConst.HERO_PROP_RANK_ICON[attrRank]
			local imgRank = UIControls.Image(self.attrList[i], self.attrList[i].mPath .. "/IconScore")

			imgRank:setImage(rankIconInfo[1], rankIconInfo[2])
		end
	end

	for i = #ATTR_PANEL_PROP_MAP + 1, #self.attrMoreList do
		self.attrMoreList[i]:setVisible(false)
	end
end

function RoleInfoHeroDlg:refreshStarPanel()
	local starPath = self.selectedHero:getStarPath()

	if starPath then
		self.imgHeroStar:setImage(starPath[1], starPath[2])
	end
end

function RoleInfoHeroDlg:refreshBaseInfo()
	self.txtName:setText(self.selectedHero.fullName)

	local headPath = self.selectedHero:getIconPath(true)

	if headPath then
		self.imgIconHead:setImage(headPath[1], headPath[2])
	end

	local stepImgIdx = ResStarUpCondition[self.selectedHero.star].step_img_idx or 1
	local stepImgInfo = UIConst.HERO_CARD_SPRITE_BY_STEP[stepImgIdx]

	self.imgIconHeadBg:setImage(stepImgInfo.BG_HEAD[1], stepImgInfo.BG_HEAD[2])

	local careerPath = self.selectedHero:getCareerPath()

	self.imgCareerIcon:setImage(careerPath[1], careerPath[2])
	self.txtCareer:setText(Const.CAREER_CONFIG[self.selectedHero.career].name)
	self.txtHeroLv:setText(string.format(Lang.get(30171), self.selectedHero.level))
	self.bgStage:setVisible(self.selectedHero.step > 0)

	if self.selectedHero.step > 0 then
		self.selectedHero:setHeroStepUI(nil, self.txtStage)
	end

	self.txtGroup:setText(Const.CAMP_CONFIG[self.selectedHero.resData.camp].name)

	local groupPath = self.selectedHero:getGroupPath()

	self.imgGroup:setImage(groupPath[1], groupPath[2])
	self.txtPowerNum:setText(self.selectedHero:getCapacity())

	local paintPath = self.selectedHero:getPaintPath(Const.PAINT_HERO_BASEPANEL)

	if paintPath then
		self.imgPaint:setVisible(true)
		self.imgPaint:setImage(paintPath[1], paintPath[2])
	else
		self.imgPaint:setVisible(false)
	end

	local paintEfxPath = self.selectedHero:getPaintEfxPath(Const.PAINT_HERO_BASEPANEL)

	if paintEfxPath then
		self.efxPainting:playEffect(paintEfxPath)
		self.efxPainting:setVisible(true)
	else
		self.efxPainting:setVisible(false)
	end

	if Const.PAINT_PLUS_OPEN and self.iconCoating02 then
		local level = self.selectedHero:getPaintPlusShowLevel()

		if level and level ~= 0 then
			self.iconCoating02:setVisible(true)
			self.txtPaintPlusLv:setText(level)
		else
			self.iconCoating02:setVisible(false)
		end
	end

	if self.iconUR then
		self.iconUR:setVisible(self.selectedHero:isURHero())
	end
end

function RoleInfoHeroDlg:refreshRelicInfo()
	if not self.gridRelic then
		self.gridRelic = UIControls.RelicGridPanel(self, "HeroContentPanel/HeroContentEquipPanel/EquipPanel/RelicGrid/GridRelicSmallItem")
		self.gridRelic.mEnableTips = false
		self.gridRelic.mEventClick = Slot(self.onRelicGridClick, self)
	end

	self.gridRelic:setVisible(true)
	self.gridRelic:setObj(self.relic)
	self.gridRelic:hideLimitInfo()

	local panelQualityPath = self.relic:getPanelQualityPath()

	self.gridRelic.imgQuality:setImage(panelQualityPath[1], panelQualityPath[2])
	self.btnRelicGrid:setEnable(false)
	self.imgRelicNew:setVisible(false)
end

function RoleInfoHeroDlg:clearRelicInfo()
	if self.gridRelic then
		self.gridRelic:setVisible(false)
	end

	self.btnRelicGrid:setEnable(true)
end

function RoleInfoHeroDlg:clearArtifactInfo()
	if self.gridArtifact then
		self.gridArtifact:setVisible(false)
	end

	self.gridArtifact = nil
end

function RoleInfoHeroDlg:clearEquipInfo()
	if self.gridEquipList then
		for i, v in pairs(self.gridEquipList) do
			self.gridEquipList[i]:clearEquip()
		end
	end
end

function RoleInfoHeroDlg:onRelicGridClick(sender)
	if self.selectedHero:getRelic() and self.gridRelic then
		UIManager.getUI("relicTips"):showObj(self, self.relic)
	end
end

function RoleInfoHeroDlg:onBtnDetailClick()
	local txtStr = self.panelSkill:getVisible() and Lang.get(466) or Lang.get(963)

	self.btnDetail:setText(txtStr)
	self.panelSkill:changeVisible()
	self.panelLessAttr:changeVisible()
	self.panelMoreAttr:changeVisible()
end

function RoleInfoHeroDlg:onBtnInfoClick()
	UIManager.getUI("heroGroupCareerInfoDlg", true)
end

function RoleInfoHeroDlg:onDragEnd(...)
	if self.autoRotateComponent then
		self.autoRotateComponent:StartRotate()
	end
end

function RoleInfoHeroDlg:onDragStart(...)
	if self.autoRotateComponent then
		self.autoRotateComponent:EndRotate()
	end
end

function RoleInfoHeroDlg:onCloseClick()
	self:delEquipWall()
	self:setVisible(false)
end

function RoleInfoHeroDlg:onHeroNextClick()
	if self.curCardIdx < #self.heros then
		self:setSelectHero(self.curCardIdx + 1)
	end
end

function RoleInfoHeroDlg:onHeroLastClick()
	if self.curCardIdx > 1 then
		self:setSelectHero(self.curCardIdx - 1)
	end
end

function RoleInfoHeroDlg:onDestroy()
	RoleInfoHeroDlg.super.onDestroy(self)
end

function RoleInfoHeroDlg:setTipId(tipsId)
	self.tipId = tipsId

	if self.btnTips then
		self.btnTips:setVisible(self.tipId and true or false)
	end
end

function RoleInfoHeroDlg:onTipsClick()
	UIManager.getUI("infoNotice", true):showSystemInfo(self.tipId)
end

return RoleInfoHeroDlg
