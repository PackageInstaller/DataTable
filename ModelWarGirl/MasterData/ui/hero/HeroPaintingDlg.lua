-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Hero\\HeroPaintingDlg.lua

local ATTR_PANEL_PROP_MAP = {
	"e_atk",
	"e_mhp",
	"star_atk_percent",
	"star_mhp_percent"
}
local HeroAttrPanel = require("UI/Hero/HeroAttrPanel")
local PropHelper = require("Common/FrameBattle/BattleObject/PropHelper")
local MaterialItemGridChild = require("UI/Common/Grid/MaterialItemGridChild")
local ResHeroPaint = require("ClientData/ResHeroPaint")
local HeroPaintAbilityPanel = require("UI/Hero/HeroPaintAbilityPanel")
local ModelFactory = Framework.Entity.ModelFactory
local ModelTool = require("Entity/ModelTool")
local HeroPaintPlusPanel = require("UI/Hero/HeroPaintPlusPanel")
local strClassName = "HeroPaintingDlg"
local HeroPaintingDlg = Class(strClassName, UIControls.Window)

function HeroPaintingDlg:ctor()
	self:initUI()

	self._slot4LoadNewModelEnd = Slot(self.loadNewModel, self)
end

function HeroPaintingDlg:initUI()
	self.gridMaterialList = {}
	self.btnConfirm = UIControls.Button(self, "GroupInfoPanel/CoatingPanel/BtnConfirm")

	self.btnConfirm:addEventClick(self.onBtnConfirmClick)

	self.btnTips = UIControls.Button(self, "BtnTips")

	self.btnTips:addEventClick(self.onBtnTipsClick)

	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.lockTips = UIControls.Panel(self, "GroupInfoPanel/CoatingPanel/LockTips")
	self.maxNode = UIControls.Panel(self, "GroupInfoPanel/CoatingPanel/MaxNode")
	self.txtNothing = UIControls.Label(self, "GroupInfoPanel/CoatingPanel/LockTips/NothingTips")
	self.btnJumpToHandbook = UIControls.Button(self, "GroupInfoPanel/CoatingPanel/LockTips/BtnInfo")

	self.btnJumpToHandbook:addEventClick(self.onBtnJumpToHandbookClick)

	self.uiAniGroupInfo = UIControls.UIAni(self, "GroupInfoPanel")
	self.txtAbilityUnlock = UIControls.Panel(self, "GroupInfoPanel/CoatingPanel/AttrMainPanel/TextUnlock")
	self.panelItemNode = UIControls.Panel(self, "ItemNode")
	self.nowPaintName = UIControls.Label(self, "GroupInfoPanel/CoatingPanel/GridHeroNode/GridHeroNow/StartLvNode/LvNum")
	self.panelHeroNowNode = UIControls.Panel(self, "GroupInfoPanel/CoatingPanel/GridHeroNode/GridHeroNow")
	self.nextPaintName = UIControls.Label(self, "GroupInfoPanel/CoatingPanel/GridHeroNode/GridHeroNext/StartLvNode/LvNum")
	self.nowLvInfoComNode = UIControls.Panel(self, "GroupInfoPanel/CoatingPanel/GridHeroNode/GridHeroNow/StartLvNode")
	self.nextLvInfoComNode = UIControls.Panel(self, "GroupInfoPanel/CoatingPanel/GridHeroNode/GridHeroNext/StartLvNode")
	self.panelUnlockNewCardShow = UIControls.Panel(self, "GroupInfoPanel/CoatingPanel/GridHeroNode/GridHeroNext/NewUnlcok")
	self.modelViewport = UIControls.RawImage(self, "ModelViewport")
	self.modelStage = ModelStageManager.createUIModelStage(self, "ModelStage/HeroCoatingModelStage")
	self.btnCloseProperSensor = UIControls.Button(self, "GroupInfoPanel/UIClickThrough")

	self.btnCloseProperSensor:addEventClick(self.onBtnCloseProperSensorClick)

	self.modelControl = UIControls.Panel(self, "ModelControl")

	self.modelStage:initOperation(self.modelControl)

	self.modelStage.mEventOprDrag = Slot(self.onDrag, self)
	self.panelNextGridHero = UIControls.Panel(self, "GroupInfoPanel/CoatingPanel/GridHeroNode/GridHeroNext")
	self.imgIconNew = UIControls.Image(self, "GroupInfoPanel/CoatingPanel/BtnConfirm/IconNew")
	self.uiAni = UIControls.UIAni(self, "GroupInfoPanel/CoatingPanel/GridHeroNode")

	self.uiAni:addEventAnimateCue(self.paintingUpCue)
	self.uiAni:addEventFinish(self._onAniFinish)

	self.panelAbility = HeroPaintAbilityPanel(self, "GroupInfoPanel/EnablingPanel")
	self.nowLvInfoComList = {}
	self.nextLvInfoComList = {}
	self.efxCard = UIControls.LazyEffectPlayer(self, "GroupInfoPanel/CoatingPanel/GridHeroNode/GridHeroNow/Efx")

	for i = 1, 6 do
		local lvContainer = UIControls.Panel(self, "GroupInfoPanel/CoatingPanel/GridHeroNode/GridHeroNow/StartLvNode/Start0" .. i)
		local lvLight = UIControls.Image(self, "GroupInfoPanel/CoatingPanel/GridHeroNode/GridHeroNow/StartLvNode/Start0" .. i .. "/StartLight")
		local efx = UIControls.LazyEffectPlayer(self, "GroupInfoPanel/CoatingPanel/GridHeroNode/GridHeroNow/StartLvNode/Start0" .. i .. "/Efx")

		table.insert(self.nowLvInfoComList, {
			lvContainer,
			lvLight,
			efx
		})
	end

	for i = 1, 6 do
		local lvContainer = UIControls.Panel(self, "GroupInfoPanel/CoatingPanel/GridHeroNode/GridHeroNext/StartLvNode/Start0" .. i)
		local lvLight = UIControls.Image(self, "GroupInfoPanel/CoatingPanel/GridHeroNode/GridHeroNext/StartLvNode/Start0" .. i .. "/StartLight")

		table.insert(self.nextLvInfoComList, {
			lvContainer,
			lvLight
		})
	end

	self.attrPanelList = {}

	for i = 1, 4 do
		local attrPanel = HeroAttrPanel(self, "GroupInfoPanel/CoatingPanel/AttrMainPanel/ArrrItem0" .. i .. "/AttrMain")

		table.insert(self.attrPanelList, attrPanel)
	end

	self.btnSwitch = UIControls.Button(self, "GroupInfoPanel/BtnSwitch")

	self.btnSwitch:addEventClick(self.onBtnSwitchClick)

	self.coatingPanel = UIControls.Image(self, "GroupInfoPanel/CoatingPanel")
	self.coating02Panel = HeroPaintPlusPanel(self, "GroupInfoPanel/Coating02Panel")
	self.uiAniSwitch = UIControls.UIAni(self, "")

	self.uiAniSwitch:addEventAnimateCue(self.onAnimateCue)
end

local DRAG_ROTATE_SPEED = 240

function HeroPaintingDlg:onDrag(delta)
	local deltaX = math.abs(delta.x)

	if not self.modelTransform then
		return
	end

	local angles = self.modelTransform.eulerAngles

	angles.y = angles.y - delta.x * DRAG_ROTATE_SPEED
	self.modelTransform.eulerAngles = angles
end

function HeroPaintingDlg:onBtnCloseProperSensorClick()
	if self.panelAbility.panelPropertiesList:getVisible() then
		self.panelAbility.selectAbilityDic = {}

		self.panelAbility:refreshOptionShow()
		self.panelAbility.panelProperAni:startAni("HidePropertiesList", true)
		self.btnCloseProperSensor:setVisible(false)
	end
end

function HeroPaintingDlg:showHeroModel(hero)
	self.modelHero = hero

	local modelId = hero:getShowModelId()
	local baseModelId = hero:getShowBaseModelId()

	self.curModelInsId = self.modelStage:showHeroByModId(modelId, Const.MODEL_TYPE.ShowStepOne, nil, self._slot4LoadNewModelEnd, nil, baseModelId, true)
end

function HeroPaintingDlg:delHeroModel()
	if self.curModelInsId then
		self.modelStage:delModel(self.curModelInsId)

		self.curModelInsId = nil
	end
end

function HeroPaintingDlg:loadNewModel(modelInsId, modelResID)
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

	self.modelStage:setTonemapping(self.curModelInsId, true)
end

function HeroPaintingDlg:onOpen()
	HeroPaintingDlg.super.onOpen(self)
	self.modelStage:connectImage(self.modelViewport)

	if self.hero then
		self:refreshPaintUI()
	end
end

function HeroPaintingDlg:playPatingLvUp(isSuperLvUp, unlockAbility)
	self.notJump = true

	if self.curPaintData and self.curPaintData.level + 1 >= #ResHeroPaint[self.curPaintData.resData.paint_id] then
		self.uiAni:startAni("CoatingLvMax", true)

		return
	end

	self.isSuperLvUp = isSuperLvUp

	if not self.isSuperLvUp then
		self:refreshPaintUI(true)
		self.efxCard:playEffectByPath("Effects/UI/efx_ui_tuzhuangshengji_02.prefab")
	else
		self.btnConfirm:setEnable(false)
		self.uiAni:startAni("CoatingLvUp", true)
	end

	self.unlockAbility = unlockAbility
end

function HeroPaintingDlg:_onAniFinish(aniCom, aniName)
	if aniName == "CoatingLvUp" then
		self.btnConfirm:setEnable(true)
	end
end

function HeroPaintingDlg:paintingUpCue(aniCom, eventKey)
	if eventKey == "CoatingLvUp" then
		self:refreshPaintUI(true)

		if self.unlockAbility then
			self.panelAbility:playUnlockAbility(self.unlockAbility)

			self.unlockAbility = nil
		end

		self.efxCard:playEffectByPath("Effects/UI/efx_ui_tuzhuangshengji_03.prefab")
	end
end

function HeroPaintingDlg:refreshPaintUI(playEfx)
	self:setHero(self.hero, playEfx)
end

function HeroPaintingDlg:setHero(hero, playEfx)
	self.lockClick = false
	self.hero = hero

	for _, attrPanel in ipairs(self.attrPanelList) do
		attrPanel:setVisible(false)
	end

	if not self.cardCurHero then
		self.cardCurHero = UIControls.HeroCardChild(self, "GroupInfoPanel/CoatingPanel/GridHeroNode/GridHeroNow", "System/Hero/GridHeroCard", 0, 0, true)
	end

	self.cardCurHero:setHero(self.hero)

	local curProp = {}
	local isUnlockAbility = false

	if self.curPaintData then
		isUnlockAbility = (self.curPaintData.resData.ability_count or 0) == 0 and self.hero:getPaintData().resData.ability_count == 1
	end

	self.curPaintData = utils.deepcopy(self.hero:getPaintData())

	local curAbilityCount = 0

	if self.curPaintData then
		self.isMaxPaintLv = self.curPaintData.level >= #ResHeroPaint[self.curPaintData.resData.paint_id]
		curProp = PropHelper.getPaintAttr(self.curPaintData, true)
		curAbilityCount = self.curPaintData.resData.ability_count or 0
	else
		self.isMaxPaintLv = false
	end

	if not self.isMaxPaintLv then
		self.lockTips:setVisible(true)
		self.maxNode:setVisible(false)

		if not self.cardFakeHero then
			self.cardFakeHero = UIControls.HeroCardChild(self, "GroupInfoPanel/CoatingPanel/GridHeroNode/GridHeroNext", "System/Hero/GridHeroCard", 0, 0, true)
		end

		self.panelNextGridHero:setVisible(true)

		self.nextPaintData = utils.getPaintData(self.hero.id, (self.curPaintData ~= nil and self.curPaintData.level or 0) + 1)

		local nextAbilityCount = self.nextPaintData.resData.ability_count or 0

		self.cardFakeHero:setHero(self.hero)

		local paintPath = self.hero:getPaintPath(Const.PAINT_HERO_CARD, self.nextPaintData)
		local paintEfxPath = self.hero:getPaintEfxPath(Const.PAINT_HERO_CARD, self.nextPaintData)

		self.cardFakeHero:setPaintShow(paintPath, paintEfxPath)

		local nextProp = PropHelper.getPaintAttr(self.nextPaintData, true)
		local attrPanelIdx = 0

		for i, panelPropName in ipairs(ATTR_PANEL_PROP_MAP) do
			if nextProp[panelPropName] then
				attrPanelIdx = attrPanelIdx + 1

				self.attrPanelList[attrPanelIdx]:setVisible(true)
				self.attrPanelList[attrPanelIdx]:setPropInfo(panelPropName, curProp[panelPropName] or 0, nextProp[panelPropName])

				if (curProp[panelPropName] or 0) == nextProp[panelPropName] then
					self.attrPanelList[attrPanelIdx].txtTargetValue:setVisible(false)
				end
			end
		end

		self.txtAbilityUnlock:setVisible(curAbilityCount ~= nextAbilityCount)
		self.nowLvInfoComNode:setVisible(true)

		local containerCount, levelIdx = CurAvatar:getPaintStarContainerInfo(self.nextPaintData)

		if levelIdx ~= 0 then
			self.panelUnlockNewCardShow:setVisible(false)
			self.nextLvInfoComNode:setVisible(true)

			for idx, comList in ipairs(self.nextLvInfoComList) do
				comList[1]:setVisible(idx <= containerCount)
				comList[2]:setVisible(idx <= levelIdx)

				local color = idx == levelIdx and {
					127,
					244,
					54
				} or {
					6,
					147,
					227
				}

				comList[2]:setColorByRGBA(color[1], color[2], color[3])
			end
		else
			self.nextLvInfoComNode:setVisible(false)
			self.panelUnlockNewCardShow:setVisible(true)
		end

		self.nextPaintName:setText(self.nextPaintData.resData.name)

		if self.curPaintData then
			containerCount, levelIdx = CurAvatar:getPaintStarContainerInfo(self.curPaintData)

			if CurAvatar:canPaintIgnoreProficientLv(self.hero) then
				self.btnConfirm:setVisible(self.nextPaintData.resData.proficient_level - 1 <= CurAvatar:getProficientLevelByTeamIndex(self.hero.team))
				self.txtNothing:setText(string.format(Lang.get(30345), self.nextPaintData.resData.proficient_level - 1))
			else
				self.btnConfirm:setVisible(self.nextPaintData.resData.proficient_level <= CurAvatar:getProficientLevelByTeamIndex(self.hero.team))
				self.txtNothing:setText(string.format(Lang.get(30345), self.nextPaintData.resData.proficient_level))
			end

			self.btnJumpToHandbook:setVisible(not self.btnConfirm:getVisible())
			self.txtNothing:setVisible(not self.btnConfirm:getVisible())
			self.nowPaintName:setText(self.curPaintData.resData.name)
		else
			levelIdx = levelIdx - 1

			self.btnConfirm:setVisible(true)
			self.txtNothing:setVisible(false)
			self.nowPaintName:setText(self.nextPaintData.resData.name)
		end

		for idx, comList in ipairs(self.nowLvInfoComList) do
			comList[1]:setVisible(idx <= containerCount)
			comList[2]:setVisible(idx <= levelIdx)

			if playEfx and idx == levelIdx then
				comList[3]:playEffect()
			end
		end

		self.panelItemNode:setVisible(true)
		self:refreshMaterialInfo()
		self.imgIconNew:setVisible(self.hero.star >= self.nextPaintData.resData.limit_star and #self.lackInfo == 0)

		if self.curPaintData and self.curPaintData.resData.ability_count and self.curPaintData.resData.ability_count > 0 then
			self.panelAbility:setVisible(true)

			if isUnlockAbility then
				self.uiAniGroupInfo:startAni("ShowEnablingUnlock", true)
			end

			self.panelAbility:setPaintData(self.curPaintData, self.hero)
		else
			self.panelAbility:setVisible(false)
		end
	else
		self.panelHeroNowNode:setPosition(0)
		self.panelAbility:setVisible(true)
		self.panelAbility:setPaintData(self.curPaintData, self.hero)
		self.panelUnlockNewCardShow:setVisible(false)
		self.nextLvInfoComNode:setVisible(false)
		self.panelItemNode:setVisible(false)
		self.panelNextGridHero:setVisible(false)
		self.btnConfirm:setVisible(false)
		self.nowLvInfoComNode:setVisible(false)
		self.txtAbilityUnlock:setVisible(false)

		if Const.PAINT_PLUS_OPEN then
			self.lockTips:setVisible(false)
			self.maxNode:setVisible(true)
		else
			self.maxNode:setVisible(false)
			self.lockTips:setVisible(true)
			self.txtNothing:setVisible(true)
			self.txtNothing:setText(Lang.get(1134))
		end

		local attrPanelIdx = 0

		for i, panelPropName in ipairs(ATTR_PANEL_PROP_MAP) do
			if curProp[panelPropName] then
				attrPanelIdx = attrPanelIdx + 1

				self.attrPanelList[attrPanelIdx]:setVisible(true)
				self.attrPanelList[attrPanelIdx].txtTargetValue:setVisible(false)
				self.attrPanelList[attrPanelIdx]:setPropInfo(panelPropName, curProp[panelPropName])
			end
		end
	end

	if not self.curModelInsId then
		self:showHeroModel(self.hero)
	else
		local curModelInsId = self.hero:getShowModelId()

		if self.curModelInsId ~= curModelInsId then
			self:delHeroModel()
			self:showHeroModel(self.hero)
		end
	end

	self:setPaintPlusDefaultShow()
end

function HeroPaintingDlg:setPaintPlusDefaultShow()
	self.curPaintData = utils.deepcopy(self.hero:getPaintData())

	if self.curPaintData then
		self.isMaxPaintLv = self.curPaintData.level >= #ResHeroPaint[self.curPaintData.resData.paint_id]
	end

	if Const.PAINT_PLUS_OPEN then
		if self.isMaxPaintLv then
			if self.showPlusFlag == nil then
				self.coating02Panel:setHero(self.hero)
				self.btnSwitch:setVisible(true)

				if BeginnerManager.isBeginnerFinished(382) then
					if not self.notJump then
						self:setShowState(not self.showPlusFlag)
					end
				else
					BeginnerManager.CheckPaintPlusCanUnlock()
				end
			else
				self.coating02Panel:setHero(self.hero)
				self.btnSwitch:setVisible(true)
				self:setShowState(self.showPlusFlag)
			end
		else
			local pos = self.panelHeroNowNode:getPosition()

			if pos and pos.x == 0 then
				self.panelHeroNowNode:setPosition(-168)
			end

			local nextPos = self.panelNextGridHero:getPosition()

			if pos and pos.x == 0 then
				self.panelNextGridHero:setPosition(168)
			end

			self.btnSwitch:setVisible(false)
			self:setShowState(false)
		end
	else
		self.btnSwitch:setVisible(false)
	end
end

function HeroPaintingDlg:onBtnCloseClick()
	self:setVisible(false)
end

function HeroPaintingDlg:onBtnJumpToHandbookClick()
	local isLocked = ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_HANDBOOK_TEAM)

	if isLocked then
		MsgManager.notice(ConditionLimitManager.getLimitUnlockDesc(Const.CONDITION_LIMIT_HANDBOOK_TEAM))

		return
	end

	UIManager.getUI("handBookTeamDetailDlg", true):show(self.hero.team)
	self:setVisible(false)
end

function HeroPaintingDlg:onBtnTipsClick()
	UIManager.getUI("infoNotice", true):showSystemInfo(Const.INFO_NOTICE_HERO_PAINT)
end

function HeroPaintingDlg:onBtnConfirmClick()
	if self.lockClick then
		return
	end

	if self.hero.star < self.nextPaintData.resData.limit_star then
		MsgManager.notice(Lang.get(30346))

		return
	end

	if not CurAvatar.heroPaintNoConfirm then
		CurAvatar.heroPaintNoConfirm = {}
	end

	if #self.lackInfo == 0 then
		if not CurAvatar.heroPaintNoConfirm[self.hero.id] then
			local function yesFunc()
				CurAvatar.heroPaintNoConfirm[self.hero.id] = self.confirmui.attentionSwitch:isOn()

				RPC.heroPaint(self.hero.id, self.nextPaintData.level)

				self.lockClick = true
			end

			local function noFunc()
				CurAvatar.heroPaintNoConfirm[self.hero.id] = self.confirmui.attentionSwitch:isOn()
			end

			local msgContent = ClientUtils.getClientNotice(341)

			UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, Lang.get(1126), msgContent, yesFunc, noFunc, -1)

			self.confirmui = UIManager.getUI("confirmui", nil, false)

			self.confirmui:showToggle(Lang.get(30272), CurAvatar.heroPaintNoConfirm[self.hero.id] or true)

			return
		else
			RPC.heroPaint(self.hero.id, self.nextPaintData.level)

			self.lockClick = true
		end
	else
		MsgManager.notice(string.format(Lang.get(30029), self.lackInfo[1]))
	end
end

function HeroPaintingDlg:setShowState(state)
	self.showPlusFlag = state

	if self.curPaintData and self.curPaintData.resData.ability_count and self.curPaintData.resData.ability_count > 0 then
		self.panelAbility:setVisible(not state)
	else
		self.panelAbility:setVisible(false)
	end

	if state then
		self.panelAbility.panelPropertiesList:setVisible(not state)
		self.btnCloseProperSensor:setVisible(not state and self.panelAbility.panelPropertiesList:getVisible())
	end

	self.coatingPanel:setVisible(not state)
	self.coating02Panel:setVisible(state)
end

function HeroPaintingDlg:onAnimateCue(...)
	self:setShowState(not self.showPlusFlag)
end

function HeroPaintingDlg:onBtnSwitchClick()
	self.uiAniSwitch:startAni("SwitchCoatingPanel", true)
end

function HeroPaintingDlg:checkRefreshMaterialInfo(...)
	if self.coating02Panel and self.coating02Panel:getVisible() then
		self.coating02Panel:refreshMaterialShow()
	else
		self:refreshMaterialInfo()
	end
end

function HeroPaintingDlg:refreshMaterialInfo()
	self.lackInfo = {}

	local materialList = CurAvatar:getPaintNeedMaterialList(self.hero.id, self.nextPaintData)

	for i, materialInfo in ipairs(materialList) do
		if not self.gridMaterialList[i] then
			self.gridMaterialList[i] = MaterialItemGridChild(self, "ItemNode", "System/Common/Grid/GridMaterialItem", 0, 0, true)
		end

		local enough = self.gridMaterialList[i]:setMaterial(materialInfo.id, materialInfo.num)

		self.gridMaterialList[i].needNum = materialInfo.num
		self.gridMaterialList[i].uiConfig = {
			AutoOpenGuide = 1
		}

		local hasNum = CurAvatar:getItemNumById(materialInfo.id)

		if hasNum < materialInfo.num then
			self.gridMaterialList[i].lackNum = materialInfo.num - hasNum
		else
			self.gridMaterialList[i].lackNum = nil
		end

		self.gridMaterialList[i].selectHero = self.hero.id

		if self.gridMaterialList[i].lackNum and self.gridMaterialList[i].lackNum > 0 and CurAvatar:canConvertPaintItem(materialInfo.id, self.hero.id) then
			self.gridMaterialList[i]:setAddPanel(1)
			self.gridMaterialList[i].imgAdd2:setVisible(true)
			self.gridMaterialList[i].addPanel.textAdd:setText(Lang.get(56188))
		else
			self.gridMaterialList[i].imgAdd2:setVisible(false)
		end

		if not enough then
			table.insert(self.lackInfo, Lang.get(30293))
		end
	end

	for i = #materialList + 1, #self.gridMaterialList do
		self.gridMaterialList[i]:destroy()

		self.gridMaterialList[i] = nil
	end
end

return HeroPaintingDlg
