-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Pet\\PetMainDlg.lua

local ResPetDegreeLevel = require("ClientData/ResPetDegreeLevel")
local ResPetMisc = require("ClientData/ResPetMisc")
local ResCrystalMisc = require("ClientData/ResCrystalMisc")
local ModelTool = require("Entity/ModelTool")
local ResPetGashaponDrawUp = require("ClientData/ResPetGashaponDrawUp")
local ResPetGashaponDraw = require("ClientData/ResPetGashaponDraw")
local MAX_NUM_IN_PAGE = 8
local DEFAULT_MODEL_CREATE_POS = Const.REVIEW_VERSION and 0 or 6
local PetClickBtn = Class("PetClickBtn", UIControls.Button)

function PetClickBtn:ctor(...)
	self:addEventClick(self._onClickInteract)
end

function PetClickBtn:setInteractModel(modelStage, modelIndex)
	self.interactStage = modelStage
	self.interactIndex = modelIndex
end

local strClassName = "PetMainDlg"
local PetMainDlg = Class(strClassName, UIControls.Window)

function PetMainDlg:ctor()
	self._slotOfModelLoaded = Slot(self.onModelLoaded, self)

	self:initUI()
end

function PetMainDlg:initUI()
	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.btnTips = UIControls.Button(self, "BtnTips")

	self.btnTips:addEventClick(self.onBtnTipsClick)

	self.textLv = UIControls.Label(self, "MainInfoPanel/FashionLvPanel/TextTitel/TextLv")
	self.textSliderNum = UIControls.Label(self, "MainInfoPanel/FashionLvPanel/SliderExp/TextNum")
	self.sliderExp = UIControls.Slider(self, "MainInfoPanel/FashionLvPanel/SliderExp")
	self.imgCostIcon = UIControls.Image(self, "MainInfoPanel/FashionLvPanel/ImgConsume")
	self.textCostNum = UIControls.Label(self, "MainInfoPanel/FashionLvPanel/ImgConsume/TextNum")
	self.btnUpGrade = UIControls.Button(self, "MainInfoPanel/FashionLvPanel/BtnUpGrade")

	self.btnUpGrade:addEventClick(self.onBtnUpGradeClick)

	self.redUpDot = UIControls.RedDot(self, "MainInfoPanel/FashionLvPanel/BtnUpGrade/IconNew")

	self.redUpDot:addHint({
		UIConst.RD_HINT_PET_LEVEL_UP
	})

	self.btnLvTips = UIControls.Button(self, "MainInfoPanel/FashionLvPanel/BtnTips")

	self.btnLvTips:addEventClick(self.onBtnLvTipsClick)

	self.btnRecover = UIControls.Button(self, "MainInfoPanel/BtnRecover")

	self.btnRecover:addEventClick(self.onBtnRecoverClick)
	self.btnRecover:setVisible(true)

	self.btnStore = UIControls.Button(self, "MainInfoPanel/BtnStore")

	self.btnStore:addEventClick(self.onBtnStoreClick)
	self.btnStore:setVisible(true)

	self.btnSkill = UIControls.Button(self, "MainInfoPanel/BtnRightGroup/BtnSkill")

	self.btnSkill:addEventClick(self.onBtnSkillClick)

	self.maxNode = UIControls.Panel(self, "MainInfoPanel/FashionLvPanel/MaxNode")
	self.iconAmuletRedNew = UIControls.RedDot(self, "MainInfoPanel/BtnRightGroup/BtnSkill/IconNew")

	self.iconAmuletRedNew:addHint({
		UIConst.RD_HINT_PET_AMULET_STAR_UP
	})

	self.iconRecycleRedNew = UIControls.RedDot(self, "MainInfoPanel/BtnRecover/IconNew")

	self.iconRecycleRedNew:addHint({
		UIConst.RD_HINT_PET_AMULET_RECYCLE
	})

	self.btnGem = UIControls.Button(self, "MainInfoPanel/BtnRightGroup/BtnGem")

	self.btnGem:addEventClick(self.onBtnGemClick)
	self.btnGem:setVisible(CurAvatar:petGemSystemEnable())

	self.iconGemRedNew = UIControls.RedDot(self, "MainInfoPanel/BtnRightGroup/BtnGem/IconNew")

	self.iconGemRedNew:addHint({
		UIConst.RD_HINT_PET_GEM_UP
	})

	self.btnRune = UIControls.Button(self, "MainInfoPanel/BtnRightGroup/BtnRune")

	self.btnRune:addEventClick(self.onBtnRuneClick)
	self.btnRune:setVisible(CurAvatar:petRuneSystemEnable())

	self.iconRuneNew = UIControls.RedDot(self, "MainInfoPanel/BtnRightGroup/BtnRune/IconNew")

	self.iconRuneNew:addHint({
		UIConst.RD_HINT_PET_RUNE
	})

	self.btnPetPool = UIControls.Button(self, "MainInfoPanel/BtnPetPool")

	self.btnPetPool:addEventClick(self.onBtnPetPoolClick)
	self.btnPetPool:setVisible(Const.PET_POOL_OPEN == true)

	self.iconPetPoolNew = UIControls.RedDot(self, "MainInfoPanel/BtnPetPool/IconNew")

	self.iconPetPoolNew:addHint({
		UIConst.RD_HINT_PET_DRAW
	})

	self.btnPossess = UIControls.Button(self, "MainInfoPanel/BtnPetEnchant")

	self.btnPossess:addEventClick(self.onClickBtnPossess)

	self.redPossess = UIControls.RedDot(self, "MainInfoPanel/BtnPetEnchant/IconNew")

	self.redPossess:addHint({
		UIConst.RD_HINT_PET_POSSESS,
		UIConst.RD_HINT_PET_POSSESS_REPLACE
	})

	self.modelViewport = UIControls.RawImage(self, "ModelViewport")
	self.modelStage = ModelStageManager.createUIModelStage(self, "ModelStage/NewPetDlgModelStage_02", Slot(self.onModelStageLoaded, self))
	self.interactBtns = {}
	self.starGroups = {}

	for idx = 1, MAX_NUM_IN_PAGE do
		local interact = UIControls.Button(self, "ModelControlPanel/BtnAnchor" .. idx)

		interact:addEventClick(Functor(self._onClickInteract, self, idx))

		local iconNew = UIControls.Image(self, "ModelControlPanel/BtnAnchor" .. idx .. "/IconNew")

		self.interactBtns[idx] = {
			btn = interact,
			iconNew = iconNew
		}

		local stars = {}
		local panelStarGroup = UIControls.Panel(self, "ModelControlPanel/BtnAnchor" .. idx .. "/StartGroup")

		for i = 1, 5 do
			local checkmark = UIControls.Image(self, "ModelControlPanel/BtnAnchor" .. idx .. "/StartGroup/Start0" .. i .. "/Background/Checkmark")

			table.insert(stars, checkmark)
		end

		self.starGroups[idx] = {
			panelStarGroup = panelStarGroup,
			stars = stars
		}
	end

	self:getModelStageStarUI()

	self._petModelInsIDs = {}
	self.nowShowPetInfo = {}
	self.curPage = 1
end

function PetMainDlg:onModelStageLoaded()
	return
end

function PetMainDlg:getModelStageStarUI()
	self.petStarUIs = {}

	local root = UnityEngine.GameObject.Find("ModelStage_NewPetDlgModelStage_02")

	if root then
		for i = 1, MAX_NUM_IN_PAGE do
			local tran = root.transform:Find("ModelRoot/Anchor" .. i)
			local panelStarGroup = root.transform:Find("ModelRoot/Anchor" .. i .. "/StarGruop")

			panelStarGroup = panelStarGroup and panelStarGroup.gameObject

			local iconNew = root.transform:Find("ModelRoot/Anchor" .. i .. "/StarGruop/IconNew")

			iconNew = iconNew and iconNew.gameObject

			local stars = {}

			for index = 1, 5 do
				local star = root.transform:Find("ModelRoot/Anchor" .. i .. "/StarGruop/Star0" .. index)

				if star then
					table.insert(stars, star.gameObject)
				end
			end

			self.petStarUIs[i] = {
				panelStarGroup = panelStarGroup,
				iconNew = iconNew,
				stars = stars
			}
		end
	end
end

function PetMainDlg:onOpen()
	PetMainDlg.super.onOpen(self)
	self.modelStage:connectImage(self.modelViewport)
	self:refreshSwitchAndWash()
	CurAvatar:checkPetPossessRed()
	CurAvatar:checkPetPossessReplaceRed()
end

function PetMainDlg:refreshSwitchAndWash()
	local check = false

	if CurAvatar.petGemMainAttrCache then
		local gid = CurAvatar.petGemMainAttrCache.gid
		local gem = CurAvatar.petGemDic[gid]

		if gem then
			check = true

			local function cb()
				local ui = UIManager.getUI("petGemSwitchDlg", true)

				ui:setData(gem, true)

				local attrList = CurAvatar.petGemMainAttrCache.attr
				local attrs = {}

				for i = 1, #attrList do
					local attr = attrList[i]

					table.insert(attrs, attr.attr_id)
				end

				local showUi = UIManager.getUI("petGemChangeShowDlg", true)

				if showUi then
					showUi:setData(gid, Const.PET_GEM_RERAND_ATTR_TYPE_MAIN, attrs)
				end
			end

			UIManager.showConfirmWithId(1091, cb)
		end
	end

	if not check and CurAvatar.petGemSubAttrCache then
		local gid = CurAvatar.petGemSubAttrCache.gid
		local gem = CurAvatar.petGemDic[gid]

		if gem then
			check = true

			local function cb()
				local ui = UIManager.getUI("petGemWashDlg", true)

				ui:setData(gem, true)

				local attrList = CurAvatar.petGemSubAttrCache.attr
				local attrs = {}

				for i = 1, #attrList do
					local attr = attrList[i]

					table.insert(attrs, attr.attr_id)
				end

				local resUi = UIManager.getUI("petGemChangeShowDlg", true)

				if resUi then
					resUi:setData(gid, Const.PET_GEM_RERAND_ATTR_TYPE_SUB, attrs)
				end
			end

			UIManager.showConfirmWithId(1091, cb)
		end
	end
end

function PetMainDlg:setData()
	self:refreshDegreeUI()
	self:refreshModel()
	BeginnerManager.CheckPetGemCanLvUp()
end

function PetMainDlg:refreshDegreeUI()
	if Const.REVIEW_VERSION then
		self.textLv:setText(string.format(Lang.get(111361), CurAvatar.petDegreeLevel or 1))
	else
		self.textLv:setText(string.format("LV.%d", CurAvatar.petDegreeLevel or 1))
	end

	if CurAvatar.petDegreeLevel >= #ResPetDegreeLevel then
		self.maxNode:setVisible(true)
		self.imgCostIcon:setVisible(false)
		self.btnUpGrade:setVisible(false)
		self.sliderExp:setValue(1)
	elseif CurAvatar.petDegreeLevel == 0 then
		self.maxNode:setVisible(false)
		self.imgCostIcon:setVisible(false)
		self.textCostNum:setVisible(false)
		self.sliderExp:setValue(1)
	else
		self.maxNode:setVisible(false)
		self.imgCostIcon:setVisible(true)
		self.textCostNum:setVisible(true)
		self.btnUpGrade:setVisible(true)

		self.degreeItemId = ResPetMisc[1].degree_item_id

		local nowHaveItem = CurAvatar:getItemNumById(self.degreeItemId)
		local needItemNum = ResPetDegreeLevel[CurAvatar.petDegreeLevel + 1].degree

		self.textCostNum:setText(needItemNum)
		self.sliderExp:setValue(nowHaveItem / needItemNum)
	end

	self.btnPossess:setVisible(CurAvatar:checkPetPossessEnterOpen())
end

local REDDOT_TABLE = {
	"canWearAmuletPetsDic",
	"canStarUpPetsDic",
	"canStarUpWearingAmuletPetDic",
	"canWearGemPetsDic"
}

function PetMainDlg:refreshModel(needReloadPetId)
	self.petList = CurAvatar:getAllSortedPets()

	for pos = 1, MAX_NUM_IN_PAGE do
		local index = (self.curPage - 1) * MAX_NUM_IN_PAGE + pos

		self:setPetOrDefault(pos, self.petList[index], needReloadPetId)
	end
end

function PetMainDlg:setPetOrDefault(tgtPos, pet, needReloadPetId)
	if tgtPos == nil then
		return
	end

	if self.petStarUIs[tgtPos].iconNew then
		self.petStarUIs[tgtPos].iconNew:SetActive(false)
	end

	local modelResID, baseId

	if pet == nil then
		modelResID = Const.DEFAULT_PET_MODEL_ID

		if self.petStarUIs[tgtPos].panelStarGroup then
			self.petStarUIs[tgtPos].panelStarGroup:SetActive(false)
		end
	else
		modelResID = pet:getShowModelId()
		baseId = pet:getShowBaseModelId()

		if self.petStarUIs[tgtPos].panelStarGroup then
			self.petStarUIs[tgtPos].panelStarGroup:SetActive(true)
		end

		local stars = self.petStarUIs[tgtPos].stars

		for i, v in ipairs(stars) do
			if v then
				v:SetActive(i <= pet.star)
			end
		end

		for _, table in ipairs(REDDOT_TABLE) do
			if CurAvatar[table] and CurAvatar[table][pet.id] then
				if self.petStarUIs[tgtPos].iconNew then
					self.petStarUIs[tgtPos].iconNew:SetActive(true)
				end

				break
			end
		end
	end

	local preModel = self.nowShowPetInfo[tgtPos]

	if not preModel or preModel.modelID ~= modelResID or needReloadPetId and pet and needReloadPetId == pet.id then
		local modelID = self._petModelInsIDs[tgtPos]

		if modelID then
			self.modelStage:delModel(modelID)
		end

		if tgtPos > DEFAULT_MODEL_CREATE_POS and pet == nil then
			self.nowShowPetInfo[tgtPos] = nil
			self._petModelInsIDs[tgtPos] = nil
		else
			self.nowShowPetInfo[tgtPos] = {}
			self.nowShowPetInfo[tgtPos].modelID = modelResID
			self.nowShowPetInfo[tgtPos].baseId = baseId

			if modelResID then
				self._petModelInsIDs[tgtPos] = self.modelStage:showHeroByModId(modelResID, Const.MODEL_TYPE.ShowMain, tgtPos, self._slotOfModelLoaded, nil, baseId)
			end
		end
	end
end

function PetMainDlg:onModelLoaded(modelInstID, baseId)
	if baseId then
		ModelTool.addBaseModel(modelInstID, baseId, 1, Const.HERO_BASE_TYPE.Main)
	end

	self:_checkAllModelLoaded()
end

function PetMainDlg:_checkAllModelLoaded()
	local allLoaded = true

	for i = (self.curPage - 1) * MAX_NUM_IN_PAGE + 1, self.curPage * MAX_NUM_IN_PAGE do
		if self.petList[i] then
			local posIdx = i - (self.curPage - 1) * MAX_NUM_IN_PAGE
			local modelInsId = self._petModelInsIDs[posIdx]

			if not modelInsId then
				allLoaded = false

				break
			end

			local modelAux = self.modelStage:getModel(modelInsId)

			if not modelAux then
				allLoaded = false

				break
			end
		end
	end
end

function PetMainDlg:onBtnUpGradeClick()
	if CurAvatar.petDegreeLevel == 0 then
		RPC.petDegreeLevelUp()
	else
		local nowHaveItem = CurAvatar:getItemNumById(self.degreeItemId)
		local needItemNum = ResPetDegreeLevel[CurAvatar.petDegreeLevel + 1].degree

		if nowHaveItem < needItemNum then
			MsgManager.notice(Lang.get(73230))

			return
		end

		local unlockCrystalLevel = ResPetDegreeLevel[CurAvatar.petDegreeLevel + 1].unlock_crystal_level

		if CurAvatar:isCrystalSecondPartNew() then
			local nowLevel = ResCrystalMisc[1].maxLevel + CurAvatar.crystalNewLevel

			if nowLevel < unlockCrystalLevel then
				local noticeLevel = math.floor((unlockCrystalLevel - ResCrystalMisc[1].maxLevel) / 10)

				MsgManager.notice(string.format(Lang.get(74710), noticeLevel))

				return
			end
		elseif unlockCrystalLevel > CurAvatar.crystalData.level then
			MsgManager.notice(string.format(Lang.get(74711), unlockCrystalLevel))

			return
		end

		RPC.petDegreeLevelUp()
	end
end

function PetMainDlg:onBtnLvTipsClick()
	UIManager.getUI("petDegreeLevelAwardDlg", true):setData()
end

function PetMainDlg:onBtnRecoverClick()
	local petRecycleDlg = UIManager.getUI("petRecycleDlg", true)

	petRecycleDlg:setData()
end

function PetMainDlg:onBtnStoreClick()
	UIManager.getUI("petMallDlg", true):onShow()
end

function PetMainDlg:onBtnSkillClick()
	local petAmuletMainDlg = UIManager.getUI("petAmuletMainDlg", true)

	petAmuletMainDlg:setData()
end

function PetMainDlg:onBtnGemClick()
	local petGemListDlg = UIManager.getUI("petGemListDlg", true)

	petGemListDlg:setData()
end

function PetMainDlg:onBtnRuneClick()
	local petRuneMainDlg = UIManager.getUI("petRuneMainDlg", true)

	if CurAvatar:checkGetExclusiveRuneItem() and ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_PET_RUNE_SYSYTEM) then
		petRuneMainDlg:setData(Const.PET_RUNE_TYPE_EXCLUSIVE)
		petRuneMainDlg:hideChangeBtn()
	else
		petRuneMainDlg:setData(Const.PET_RUNE_TYPE_NORMAL)
	end
end

function PetMainDlg:_onClickInteract(idx)
	local index = (self.curPage - 1) * MAX_NUM_IN_PAGE + idx

	if self.petList[index] then
		local pet = self.petList[index]

		UIManager.getUI("petInfoTips", true):_setObj(pet, index)
	end
end

function PetMainDlg:onBtnPetPoolClick()
	UIManager.replacePrefabOfDlg("petPoolMainDlg", 6319)

	for actId, v in pairs(ResPetGashaponDrawUp) do
		local actObj = CurAvatar:getActivityObj(actId)

		if actObj and actObj:isValid() then
			actObj:checkWindowReplace()
		end
	end

	UIManager.getUI("petPoolMainDlg", true):setData()
end

function PetMainDlg:onBtnTipsClick()
	UIManager.getUI("infoNotice", true):showSystemInfo(Const.INFO_NOTICE_PET_MAIN)
end

function PetMainDlg:onBtnCloseClick()
	self:setVisible(false)
end

function PetMainDlg:onClickBtnPossess()
	local ui = UIManager.getUI("petPossessMainDlg", true)
end

return PetMainDlg
