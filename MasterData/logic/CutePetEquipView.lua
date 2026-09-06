-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cutepet/view/CutePetEquipView.lua

module("logic.extensions.cutepet.view.CutePetEquipView", package.seeall)

local CutePetEquipView = class("CutePetEquipView", ViewComponent)
local bagViewPos = {
	empty = {
		x = -14,
		y = -33
	},
	info = {
		x = -180,
		y = -33
	}
}
local btnChangePos = {
	x = 75,
	y = -35
}
local fixShowList = {
	"生命",
	"攻击",
	"物防",
	"魔防"
}

function CutePetEquipView:ctor()
	CutePetEquipView.super.ctor(self)

	self._fixShowAttrMap = {}

	for i, v in ipairs(fixShowList) do
		self._fixShowAttrMap[FightingPowerFormula.instance:getAttrTypeByName(v)] = true
	end
end

function CutePetEquipView:buildUI()
	CutePetEquipView.super.buildUI(self)

	self._bag = self:getGo("bag")
	self._select = self:getGo("select")
	self._info = self:getGo("info")
	self._blackMask = self:getGo("blackMask")
	self._btnAdd = self:getGo("select/btnAdd")
	self._btnClocseBag = self:getGo("btnCloseBag")
	self._bagTable = self:getGo("bag/tableview")
	self._bagCell = self:getGo("bag/tableCell")
	self._bagEmpty = self:getGo("bag/empty")
	self._btnRemove = self:getGo("info/petBtnGroup/btnRemove")
	self._btnStrengthen = self:getGo("info/petBtnGroup/btnStrengthen")
	self._btnEquip = self:getGo("info/petBtnGroup/btnEquip")
	self._txtEquip = self:getTxt("info/petBtnGroup/btnEquip/txt")
	self._headCon = self:getGo("info/basicInfo/headCon")
	self._imgQualityChange = goutil.findChildComponent(self.mainGO, "info/basicInfo/imgQuality", "UIImageSpriteChange")
	self._imgType = goutil.findChildComponent(self.mainGO, "info/basicInfo/imgType", "UIImageSpriteChange")
	self._txtPetName = self:getTxt("info/basicInfo/txtName")
	self._txtLevel = self:getTxt("info/basicInfo/txtLv")
	self._starList = {}

	for i = 1, 6 do
		table.insert(self._starList, {
			star = self:getGo("info/basicInfo/starLv/star_" .. i),
			starChange = goutil.findChildComponent(self.mainGO, "info/basicInfo/starLv/star_" .. i, "UIImageSpriteChange")
		})
	end

	self._txtScore = self:getTxt("info/basicInfo/score/txt")
	self._attrTable = self:getGo("info/attrInfo/ScrollView")
	self._attrCell = self:getGo("info/attrInfo/attrCell")
	self._txtTalent = self:getTxt("info/talentSkill/txtDesc")
	self._txtSkillDesc = self:getTxt("info/starSkill/skillCell/bg/txtDesc")
	self._txtSkillStar = self:getTxt("info/starSkill/skillCell/star/txt")
	self._conditionSortGo = self:getGo("bag/btnSort/bg")
	self._btnConditionSort = self:getGo("bag/btnSort/bg")
	self._txtConditionSortName = self:getTxt("bag/btnSort/bg/text")
	self._imgChangeConditionSort = goutil.findChildComponent(self.mainGO, "bag/btnSort", "UIChangeGroup")
	self._filterGo = self:getGo("bag/btnFilter/bg")
	self._btnFilter = self:getGo("bag/btnFilter/bg")
	self._txtFilter = self:getTxt("bag/btnFilter/bg/text")
	self._inputSearch = self:getInput("bag/InputC_Search")
	self._btnClearInput = self:getGo("bag/InputC_Search/BtnClear")
	self._tableviewBagGo = self:getGo("bag/tableviewBag")
	self._tablecellBagGo = self:getGo("tablecellBag")
	self._bagScrollerList = ScrollerList.create(self._tableviewBagGo, self._tablecellBagGo, GameUtil.handler(self._updateBagBoxCell, self), GameUtil.handler(self._clearBagBoxCell, self))

	goutil.setActive(self._tableviewBagGo, false)
	goutil.setActive(self._tablecellBagGo, false)

	self._btnStatTip = self:getGo("info/attrInfo/btnTip")
	self._skillIntroCell = self:getGo("skillIntroduce/starSkill/skillCell")
	self._skillIntroScrollView = self:getGo("skillIntroduce/starSkill/ScrollView")
	self._skillIntroList = ScrollerList.create(self._skillIntroScrollView, self._skillIntroCell, GameUtil.handler(self._updateSkillCell, self), GameUtil.handler(self._clearSkillCell, self))

	self._skillIntroList:regReloadFinish(GameUtil.handler(self._skillReloadFinish, self))
	self._skillIntroList:regGetCellSize(GameUtil.handler(self._skillCellSize, self))

	self._btnSkillIntroTip = self:getGo("info/starSkill/btnTip")
	self._btnSkillIntroClose = self:getGo("skillIntroduce/btnClose")
	self._skillIntroduce = self:getGo("skillIntroduce")
	self._skillSizeImmediate = goutil.findChildComponent(self._skillIntroCell, "bg", "ContentSizeImmediate")

	GameUtil.SetActive(self._skillIntroduce, false)

	self._customInputBtnSkillIntro = UICustomInput.Get(self._skillIntroduce)
end

function CutePetEquipView:destroyUI()
	CutePetShowInfoView.super.destroyUI(self)
	self._statAttrList:dispose()
	self._skillIntroList:dispose()
end

function CutePetEquipView:bindEvents()
	CutePetEquipView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnAdd, self._onClickOpenBag, self)
	GameUtil.addClickHandler(self._btnClocseBag, self._onClickBagClose, self)
	GameUtil.addClickHandler(self._btnEquip, self._onClickEquip, self)
	GameUtil.addClickHandler(self._btnRemove, self._onClickRemove, self)
	GameUtil.addClickHandler(self._btnStrengthen, self._onClickStrengthen, self)
	GameUtil.addClickHandler(self._conditionSortGo, self._onClickSort, self)
	GameUtil.addClickHandler(self._filterGo, self._onClickFillter, self)
	GameUtil.addClickHandler(self._btnClearInput, self._onClickClearInput, self)
	self._inputSearch:AddOnValueChanged(self._onSearchTextChanged, self)
	GameUtil.addClickHandler(self._btnStatTip, self._onClickBtnStat, self)
	GameUtil.addClickHandler(self._btnSkillIntroTip, self._onClickBtnSkillIntro, self)
	GameUtil.addClickHandler(self._btnSkillIntroClose, self._onClickBtnSkillIntroClose, self)
	self._customInputBtnSkillIntro:AddListener(function(view, hover)
		if not hover then
			GameUtil.SetActive(self._skillIntroduce, not GameUtil.GetActive(self._skillIntroduce))
		end
	end, self)
end

function CutePetEquipView:unbindEvents()
	CutePetEquipView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnAdd)
	GameUtil.rmClickHandler(self._btnClocseBag)
	GameUtil.rmClickHandler(self._btnEquip)
	GameUtil.rmClickHandler(self._btnRemove)
	GameUtil.rmClickHandler(self._btnStrengthen)
	GameUtil.rmClickHandler(self._conditionSortGo)
	GameUtil.rmClickHandler(self._filterGo)
	GameUtil.rmClickHandler(self._btnStatTip)
	self._inputSearch:RemoveOnValueChanged()
	GameUtil.addClickHandler(self._btnClearInput)
	self._customInputBtnSkillIntro:RemoveListener()
end

function CutePetEquipView:onExit()
	CutePetEquipView.super.onExit(self)

	self._curShowCutePetMo = nil

	MaterialMgr.resetAll(self._headCon)
	self._bagScrollerList:dispose()
	self._bagList:dispose()
	self._attrList:dispose()
end

function CutePetEquipView:destroyUI()
	CutePetEquipView.super.destroyUI(self)
end

function CutePetEquipView:onEnter()
	CutePetEquipView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.handlePM_EnterGameLoadInfoResp, self._refreshCutePetInfo, self)
	self.addGEvent(self, GlobalNotify.handlePM_CutePetEquipOnPetResp, self._PM_CutePetEquipResp, self)
	self.addGEvent(self, GlobalNotify.handlePM_CutePetUnloadFromPetResp, self._PM_CutePetEquipResp, self)
	self.addGEvent(self, GlobalNotify.CutePetBagFilterSelect, self._onFilterSelect, self)
	self.addGEvent(self, GlobalNotify.CutePetBagSortSelect, self._onSortSelect, self)
	self.addGEvent(self, GlobalNotify.OnPetSelect, self._onClickBagClose, self)
	self.addGEvent(self, GlobalNotify.OnMaterialGet, self._refreshCutePetInfo, self)
	self.addGEvent(self, GlobalNotify.CutePetFilterClose, self._onFilterViewClose, self)
	self.addGEvent(self, GlobalNotify.CloseCutePetEquipViewBlackMask, self._handleCloseCutePetEquipViewBlackMask, self)
	GameUtil.SetActive(self._blackMask, false)

	self._filterType = CutePetFilterMgr.TYPE_CUTEPETVIEW

	self:_initView()
end

function CutePetEquipView:_initView()
	self._bagShow = false

	GameUtil.SetActive(self._btnClocseBag, false)
	GameUtil.SetActive(self._bag, false)
	GameUtil.SetActive(self._select, false)
	GameUtil.SetActive(self._info, false)
	goutil.setActive(self._tableviewBagGo, false)

	self._allPetList = CutePetModel.instance:getAllCutePetsList()
	self._bagList = ScrollerList.create(self._bagTable, self._bagCell, GameUtil.handler(self._updateBagCell, self), GameUtil.handler(self._clearBagCell, self))
	self._attrList = ScrollerList.create(self._attrTable, self._attrCell, GameUtil.handler(self._updateAttrCell, self), GameUtil.handler(self._clearAttrCell, self))
	self._fillterName = ""
	self._sortReverse = false

	self:_onClickBagClose()
end

function CutePetEquipView:_refreshView()
	self._petId = BagPetsController.instance:GetCurPetId()

	if checknumber(self._petId) <= 0 then
		return
	end

	if self._curShowCutePetMo == nil then
		for i, v in ipairs(self._allPetList) do
			if v.equippedPetId == self._petId then
				self._curShowCutePetMo = v
			end
		end
	end

	if self._curShowCutePetMo ~= nil then
		GameUtil.SetActive(self._select, false)
		GameUtil.SetActive(self._info, true)
		GameUtil.setAnchoredPos(self._bag, bagViewPos.info.x, bagViewPos.info.y)
		self:_refreshPetInfo()
		self:_updatePetSkill()
		self:_refreshPetBtnGroup()

		self._txtEquip.text = lang("替 换")
	else
		GameUtil.SetActive(self._select, true)
		GameUtil.SetActive(self._info, false)
		GameUtil.setAnchoredPos(self._bag, bagViewPos.empty.x, bagViewPos.empty.y)

		self._txtEquip.text = lang("庇 护")
	end

	local result = self:_petFillter(self._allPetList)

	self._bagList:reloadData(result)

	local isEmpty = #(result or {}) <= 0
	local hasBagBox = false

	if isEmpty then
		hasBagBox = self._bagShow and self:_calAndShowBagCell()
	end

	if hasBagBox then
		isEmpty = false
	end

	goutil.setActive(self._tableviewBagGo, hasBagBox)
	GameUtil.SetActive(self._bagEmpty, isEmpty)

	self._txtFilter.text = lang("筛选")

	GameUtil.SetActive(self._imgFilterType, false)

	self._txtConditionSortName.text = lang("排列")

	if self._sortCondition and checknumber(self._sortCondition) ~= 0 then
		self._imgChangeConditionSort:SetState(0)

		if self._sortCondition == CutePetModel.SortType.Level then
			self._txtConditionSortName.text = lang("等级")
		elseif self._sortCondition == CutePetModel.SortType.Quality then
			self._txtConditionSortName.text = lang("品质")
		elseif self._sortCondition == CutePetModel.SortType.Star then
			self._txtConditionSortName.text = lang("星级")
		elseif self._sortCondition == CutePetModel.SortType.Time then
			self._txtConditionSortName.text = lang("最新")
		elseif self._sortCondition == CutePetModel.SortType.Score then
			self._txtConditionSortName.text = lang("评分")
		end
	else
		self._imgChangeConditionSort:SetState(1)
	end
end

function CutePetEquipView:_refreshPetInfo()
	self:_refreshBasicInfo()
	self:_refreshAttrInfo()
	self:_refreshAssistanceSkill()
end

function CutePetEquipView:_refreshBasicInfo()
	local petTypeCfg = CutePetConfig.instance:getPetTypeCfg(self._curShowCutePetMo.config.type)

	self._imgQualityChange:SetState(self._curShowCutePetMo.curQuality - 1)
	self._imgType:SetState(self._curShowCutePetMo.config.type - 1)

	self._txtPetName.text = self._curShowCutePetMo.name
	self._txtLevel.text = string.format("%d", self._curShowCutePetMo.curLvl)

	MaterialMgr.resetAll(self._headCon)

	local proxy = MaterialMgr.setCellByMo(self._curShowCutePetMo, self._headCon)

	if proxy then
		proxy.binder:setLvl(0)
	end

	self._maxStar = CutePetConfig.instance:getMaxStar(self._curShowCutePetMo.config.starUpPlan, self._curShowCutePetMo.curQuality)

	for i = 1, #self._starList do
		if i <= self._curShowCutePetMo.curStar then
			self._starList[i].starChange:SetState(0)
		else
			self._starList[i].starChange:SetState(1)
		end

		if i <= self._maxStar then
			GameUtil.SetActive(self._starList[i].star, true)
		else
			GameUtil.SetActive(self._starList[i].star, false)
		end
	end

	self._txtScore.text = langPara("宠物评分：%d", self._curShowCutePetMo.score)
end

function CutePetEquipView:_refreshAttrInfo()
	local attr = {}
	local result = self._curShowCutePetMo.attr
	local attrSort = self._curShowCutePetMo:getSortAttrList()

	for i, v in ipairs(attrSort) do
		table.insert(attr, {
			attrType = v,
			num = result[v]
		})
	end

	for i, v in ipairs(attr) do
		v.index = i
	end

	self._initProps = self._curShowCutePetMo:getInitialActiveProps()

	self._attrList:reloadData(attr)
end

function CutePetEquipView:_refreshAssistanceSkill()
	local talentCfg = CutePetConfig.instance:getTalentCfg(self._curShowCutePetMo.initialTalent)

	self._txtTalent.text = talentCfg.desc
end

function CutePetEquipView:_refreshCutePetInfo()
	self._allPetList = CutePetModel.instance:getAllCutePetsList()

	self:_refreshView()
end

function CutePetEquipView:_updateAttrCell(view, cell, data, tag)
	local go = cell.gameObject
	local bgChange = go:GetComponent(ComponentType.UIImageColorChange)
	local txtName = goutil.findChildTextComponent(go, "txtType")
	local txtNum = goutil.findChildTextComponent(go, "txtNum")
	local txtQuality = goutil.findChildTextComponent(go, "txtQuality")
	local txtColorChange = goutil.findChildComponent(go, "txtQuality", "UITextColorChange")
	local typeChange = goutil.findChildComponent(go, "icon", "UIImageSpriteChange")

	typeChange:SetState(data.attrType - 1)

	txtNum.text = data.num >= 1 and string.format("%d", math.floor(data.num)) or string.format("%.2f%%", data.num * 100)

	bgChange:SetState(data.index % 2)

	txtName.text = GameEnum.AttrTypeName[data.attrType]

	local gradingCfgs = CutePetConfig.instance:getPropertyGradingCfg(GameEnum.AttrTypeName[data.attrType])

	txtQuality.text = ""

	if gradingCfgs and self._initProps[data.attrType] then
		for i, v in ipairs(gradingCfgs) do
			if self._initProps[data.attrType] >= v.genRange[1] and self._initProps[data.attrType] < v.genRange[2] then
				txtQuality.text = v.grade

				txtColorChange:SetState(v.color - 1)

				break
			end
		end
	end
end

function CutePetEquipView:_clearAttrCell(cell)
	return
end

function CutePetEquipView:_updatePetSkill()
	local skillCfg = CutePetConfig.instance:getStarSkillCfgs(self._curShowCutePetMo.raceId)
	local curSkillCfg = skillCfg[self._curShowCutePetMo.curStar]

	self._txtSkillDesc.text = curSkillCfg.starBuffsDesc
	self._txtSkillStar.text = curSkillCfg.star
end

function CutePetEquipView:_updateSkillCell(view, cell, data, tag)
	local go = cell.gameObject
	local lock = goutil.findChild(go, "lock")
	local txtDesc = goutil.findChildTextComponent(go, "bg/txtDesc")
	local colorChange = goutil.findChildComponent(go, "bg/txtDesc", "UITextColorChange")
	local txtStar = goutil.findChildTextComponent(go, "star/txt")

	for i = 1, 6 do
		local star = goutil.findChild(go, "starLv/star_" .. i)

		GameUtil.SetActive(star, i <= data.star)
	end

	local isLock = data.star > self._curShowCutePetMo.curStar

	GameUtil.SetActive(lock, isLock)

	if isLock == true then
		colorChange:SetState(1)
	else
		colorChange:SetState(0)
	end

	txtDesc.text = data.starBuffsDesc
	txtStar.text = data.star
end

function CutePetEquipView:_clearSkillCell(cell)
	return
end

function CutePetEquipView:_skillReloadFinish()
	if self._curShowCutePetMo then
		self._skillIntroList:MoveCellInView(self._curShowCutePetMo.curStar - 1, true)
	end
end

function CutePetEquipView:_skillCellSize(view, index)
	local height = self.heightList[index + 1]

	return 326, height
end

function CutePetEquipView:_recordHeight(skillList)
	goutil.setActive(self._skillIntroCell, true)

	self.heightList = {}

	for k, data in ipairs(skillList) do
		self:_updateSkillCell(nil, self._skillIntroCell, data)

		local size = self._skillSizeImmediate:GetPreferredSize()

		table.insert(self.heightList, math.max(25, size.y))
	end

	goutil.setActive(self._skillIntroCell, false)
end

function CutePetEquipView:_updateBagCell(view, cell, data, tag)
	local go = cell.gameObject
	local imgSelect = goutil.findChild(go, "imgSelect")
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local txtLevel = goutil.findChildTextComponent(go, "txtLevel")
	local petIconRoot = goutil.findChild(go, "petIconGo")
	local petIconGo = goutil.findChild(go, "petIconGo/petIcon")
	local cutePetIcon = goutil.findChild(go, "headCon")
	local imgType = goutil.findChildComponent(go, "imgType", "UIImageSpriteChange")
	local imgRecommend = goutil.findChild(go, "imgRecommend")
	local maxStar = CutePetConfig.instance:getMaxStar(data.config.starUpPlan, data.curQuality)

	for i = 1, 6 do
		local star = goutil.findChild(go, "starLv/star_" .. i)
		local starChange = goutil.findChildComponent(go, "starLv/star_" .. i, "UIImageSpriteChange")

		GameUtil.SetActive(star, i <= maxStar)

		if i <= data.curStar then
			starChange:SetState(0)
		else
			starChange:SetState(1)
		end
	end

	txtLevel.text = string.format("Lv.%d", data.curLvl)
	txtName.text = data.name

	GameUtil.SetActive(imgSelect, self._curShowCutePetMo and data.id == self._curShowCutePetMo.id)
	imgType:SetState(data.config.type - 1)
	MaterialMgr.clearIcon(petIconGo)
	GameUtil.SetActive(petIconRoot, checknumber(data.equippedPetId) > 0)

	if checknumber(data.equippedPetId) > 0 then
		local petMo = BagPetsController.instance:getPet(data.equippedPetId)

		MaterialMgr.setIcon(petIconGo, MatType.Pet, petMo.raceId)
	end

	MaterialMgr.setCellByMo(data, cutePetIcon)

	local btnClick = goutil.findChild(go, "raycast")

	GameUtil.addClickHandler(btnClick, function()
		self:onClickPetItem(data)
	end, self)

	local isRecommend = false
	local talentCfg = CutePetConfig.instance:getTalentCfg(data.initialTalent)
	local raceName = ""
	local jobName = ""
	local isMatchYuan = false

	if not string.nilorempty(talentCfg.petValidator) then
		local strSpilt = string.split(talentCfg.petValidator, "$")

		if strSpilt[1] == "RaceType" then
			raceName = strSpilt[2]
		elseif strSpilt[1] == "Job" then
			jobName = strSpilt[2]
		elseif strSpilt[1] == "StrengthenRaceType" then
			raceName = strSpilt[2]
			isMatchYuan = true
		end
	end

	if GameEnum.Races[raceName] and GameEnum.Races[raceName] == self._curPetRaceIndex then
		isRecommend = true
	end

	if isMatchYuan and self._curPetRaceIndex == GameEnum.RaceType.Yuan then
		isRecommend = true
	end

	if GameEnum.JobZh[jobName] then
		for i, v in ipairs(self._curPetJobIndex) do
			if v > 0 and GameEnum.JobZh[jobName] == v then
				isRecommend = true
			end
		end
	end

	GameUtil.SetActive(imgRecommend, isRecommend)
end

function CutePetEquipView:_clearBagCell(cell)
	local go = cell.gameObject
	local btnClick = goutil.findChild(go, "raycast")
	local petIconGo = goutil.findChild(go, "petIconGo/petIcon")
	local cutePetIcon = goutil.findChild(go, "headCon")

	GameUtil.rmClickHandler(btnClick)
	MaterialMgr.clearIcon(petIconGo)
	MaterialMgr.resetAll(cutePetIcon)
end

function CutePetEquipView:_petFillter(list)
	local resultList = {}

	for i, mo in ipairs(list) do
		local insertResult = CutePetFilterMgr.instance:checkIsMatch(self._filterType, mo.cfg, mo.id) == true

		if not string.nilorempty(self._fillterName) then
			local success, result = pcall(function()
				return {
					string.find(mo.name, self._fillterName)
				}
			end)

			if success then
				if #result <= 0 or not result then
					insertResult = false
				end
			else
				insertResult = false
			end
		end

		if insertResult == true then
			table.insert(resultList, mo)
		end
	end

	local petMo = BagPetsController.instance:GetCurPetMo()
	local racdIdx = PetSkinConfig.instance:getFisrtEleAttrIdx(petMo.curFaceId)

	racdIdx = racdIdx % 10

	local firstJobIdx = PetSkinConfig.instance:getFirstJobIdx(petMo.curFaceId)
	local secondJobIdx = PetSkinConfig.instance:getSecondJobIdx(petMo.curFaceId)
	local thirdJobIdx = PetSkinConfig.instance:getThirdJobIdx(petMo.curFaceId)

	self._curPetJobIndex = {
		firstJobIdx,
		secondJobIdx,
		thirdJobIdx
	}
	self._curPetRaceIndex = racdIdx

	table.sort(resultList, function(a, b)
		return self:_comparePet(a, b, self._sortCondition, self._sortReverse)
	end)

	return resultList
end

function CutePetEquipView:_comparePet(a, b, conditionId, isReverse)
	if conditionId == CutePetModel.SortType.Level then
		return self:_compareLv(a, b, isReverse)
	elseif conditionId == CutePetModel.SortType.Quality then
		return self:_compareQuality(a, b, isReverse)
	elseif conditionId == CutePetModel.SortType.Star then
		return self:_compareStar(a, b, isReverse)
	elseif conditionId == CutePetModel.SortType.Time then
		return self:_compareTime(a, b, isReverse)
	elseif conditionId == CutePetModel.SortType.Score then
		return self:_compareScore(a, b, isReverse)
	end

	return self:_compareDefult(a, b, isReverse)
end

function CutePetEquipView:_compareLv(a, b, isReverse)
	if a.curLvl > b.curLvl then
		return not isReverse
	elseif a.curLvl < b.curLvl then
		return isReverse
	else
		return self:_compareQuality(a, b, false)
	end
end

function CutePetEquipView:_compareQuality(a, b, isReverse)
	if a.curQuality > b.curQuality then
		return not isReverse
	elseif a.curQuality < b.curQuality then
		return isReverse
	else
		return self:_compareStar(a, b, false)
	end
end

function CutePetEquipView:_compareStar(a, b, isReverse)
	if a.curStar > b.curStar then
		return not isReverse
	elseif a.curStar < b.curStar then
		return isReverse
	else
		return self:_compareTime(a, b, false)
	end
end

function CutePetEquipView:_compareTime(a, b, isReverse)
	if a.gainTime == b.gainTime then
		return self:_compId(a, b, false)
	elseif not isReverse then
		return a.gainTime > b.gainTime
	else
		return a.gainTime < b.gainTime
	end
end

function CutePetEquipView:_compareScore(a, b, isReverse)
	if a.score == b.score then
		return self:_compareTime(a, b, false)
	elseif not isReverse then
		return a.score > b.score
	else
		return a.score < b.score
	end
end

function CutePetEquipView:_compId(a, b, isReverse)
	if not isReverse then
		return a.id < b.id
	else
		return a.id > b.id
	end
end

function CutePetEquipView:_compareDefult(a, b, isReverse)
	local aEquippedPetId = checknumber(a.equippedPetId)
	local bEquippedPetId = checknumber(b.equippedPetId)
	local curPetId = BagPetsController.instance:GetCurPetId()

	if aEquippedPetId == curPetId or bEquippedPetId == curPetId then
		return aEquippedPetId == curPetId
	else
		return self:_compareRecommend(a, b, false)
	end
end

function CutePetEquipView:_compareRecommend(a, b, isReverse)
	local talentCfgA = CutePetConfig.instance:getTalentCfg(a.initialTalent)
	local talentCfgB = CutePetConfig.instance:getTalentCfg(b.initialTalent)
	local hitA = 0
	local hitB = 0
	local raceName = ""
	local jobName = ""
	local isMatchYuan = false

	if not string.nilorempty(talentCfgA.petValidator) then
		local strSpilt = string.split(talentCfgA.petValidator, "$")

		if strSpilt[1] == "RaceType" then
			raceName = strSpilt[2]
		elseif strSpilt[1] == "Job" then
			jobName = strSpilt[2]
		elseif strSpilt[1] == "StrengthenRaceType" then
			raceName = strSpilt[2]
			isMatchYuan = true
		end
	end

	if GameEnum.Races[raceName] and GameEnum.Races[raceName] == self._curPetRaceIndex then
		hitA = 1
	end

	if isMatchYuan and self._curPetRaceIndex == GameEnum.RaceType.Yuan then
		hitA = 1
	end

	if GameEnum.JobZh[jobName] then
		for i, v in ipairs(self._curPetJobIndex) do
			if v > 0 and GameEnum.JobZh[jobName] == v then
				hitA = 1
			end
		end
	end

	raceName = ""
	jobName = ""
	isMatchYuan = false

	if not string.nilorempty(talentCfgB.petValidator) then
		local strSpilt = string.split(talentCfgB.petValidator, "$")

		if strSpilt[1] == "RaceType" then
			raceName = strSpilt[2]
		elseif strSpilt[1] == "Job" then
			jobName = strSpilt[2]
		elseif strSpilt[1] == "StrengthenRaceType" then
			raceName = strSpilt[2]
			isMatchYuan = true
		end
	end

	if GameEnum.Races[raceName] and GameEnum.Races[raceName] == self._curPetRaceIndex then
		hitB = 1
	end

	if isMatchYuan and self._curPetRaceIndex == GameEnum.RaceType.Yuan then
		hitB = 1
	end

	if GameEnum.JobZh[jobName] then
		for i, v in ipairs(self._curPetJobIndex) do
			if v > 0 and GameEnum.JobZh[jobName] == v then
				hitB = 1
			end
		end
	end

	if hitB ~= hitA then
		return hitB < hitA
	else
		return self:_compareEquip(a, b, false)
	end
end

function CutePetEquipView:_compareEquip(a, b, isReverse)
	local aEquippedPetId = checknumber(a.equippedPetId)
	local bEquippedPetId = checknumber(b.equippedPetId)
	local curPetId = BagPetsController.instance:GetCurPetId()

	if aEquippedPetId == bEquippedPetId then
		return self:_compareScore(a, b, false)
	elseif aEquippedPetId == curPetId or bEquippedPetId == curPetId then
		return aEquippedPetId == curPetId
	else
		return aEquippedPetId < bEquippedPetId
	end
end

function CutePetEquipView:_getPosAndSizeDelta(go)
	local rect = go.gameObject:GetComponent("RectTransform")
	local pos = go.gameObject.transform.position
	local uiCamera = CameraTargetMgr.instance:getUICameraTarget():getCamera()

	pos = uiCamera:WorldToScreenPoint(pos)

	return pos, (rect ~= nil or nil) and {
		rect.sizeDelta.x,
		rect.sizeDelta.y
	}
end

function CutePetEquipView:onClickPetItem(mo)
	self._curShowCutePetMo = mo

	self:_refreshView()
end

function CutePetEquipView:_refreshPetBtnGroup()
	if self._bagShow then
		if self._curShowCutePetMo then
			local isMyPet = checknumber(self._curShowCutePetMo.equippedPetId) == self._petId

			GameUtil.SetActive(self._btnEquip, not isMyPet)
			GameUtil.SetActive(self._btnStrengthen, isMyPet)
			GameUtil.SetActive(self._btnRemove, isMyPet)
		end
	else
		GameUtil.SetActive(self._btnClocseBag, false)
		GameUtil.SetActive(self._bag, false)
		GameUtil.SetActive(self._btnRemove, false)
		GameUtil.SetActive(self._btnStrengthen, true)
		GameUtil.SetActive(self._btnEquip, true)
	end
end

function CutePetEquipView:_onClickBagClose()
	self._bagShow = false

	CutePetFilterMgr.instance:resetDataByType(self._filterType)

	self._curShowCutePetMo = nil

	self:_setBtnPosOnBagViewClose()
	self:_refreshView()
end

function CutePetEquipView:_onClickOpenBag()
	self._bagShow = true

	GameUtil.SetActive(self._btnClocseBag, true)
	GameUtil.SetActive(self._bag, true)
	self:_setBtnPosOnBagViewOpen()
	self:_refreshView()
end

function CutePetEquipView:_onClickEquip()
	if self._curShowCutePetMo.equippedPetId == self._petId then
		self:_onClickOpenBag()
	elseif checknumber(self._curShowCutePetMo.equippedPetId) > 0 then
		local showPetMo = BagPetsController.instance:getPet(self._curShowCutePetMo.equippedPetId)
		local targetPetMo = BagPetsController.instance:getPet(self._petId)
		local tipContent = langPara("是否把%s的【%s】替换到%s？", showPetMo.name, self._curShowCutePetMo.name, targetPetMo.name)
		local targetPetId = self._petId
		local targetCutePetId = self._curShowCutePetMo.id

		TipsFacade.instance:openPopupWindow(lang("提示"), tipContent, function()
			CutePetGardenAgent.instance:sendPM_CutePetEquipOnPetReq(targetCutePetId, targetPetId)
		end)
	else
		CutePetGardenAgent.instance:sendPM_CutePetEquipOnPetReq(self._curShowCutePetMo.id, self._petId)
	end
end

function CutePetEquipView:_onClickRemove()
	if checknumber(self._curShowCutePetMo.equippedPetId) > 0 then
		CutePetGardenAgent.instance:sendPM_CutePetUnloadFromPetReq(self._curShowCutePetMo.equippedPetId)
	else
		FloatWordMgr.instance:show(lang("当前没有可以解除庇护的萌宠"))
	end
end

function CutePetEquipView:_onClickStrengthen()
	CutePetController.instance:openBagPetView(self._curShowCutePetMo.id)
end

function CutePetEquipView:_onClickFillter()
	GameUtil.SetActive(self._btnClocseBag, false)

	local pos, sizeDelta = self:_getPosAndSizeDelta(self._filterGo)

	CutePetFilterMgr.instance:openFilterViewByType(self._viewPresentor, self._filterType, pos, sizeDelta, GameUtil.handler(self._refreshView, self))
end

function CutePetEquipView:_onClickSort()
	GameUtil.SetActive(self._btnClocseBag, false)

	local pos, sizeDelta = self:_getPosAndSizeDelta(self._conditionSortGo)

	UIStateManager.instance:open(ViewName.CutePetSortView, pos, sizeDelta, self._viewPresentor, self._sortCondition)
end

function CutePetEquipView:_onClickBtnStat()
	self:_showDetail()
end

function CutePetEquipView:_onClickBtnSkillIntro()
	if GameUtil.GetActive(self._skillIntroduce) then
		GameUtil.SetActive(self._skillIntroduce, false)

		return
	end

	GameUtil.SetActive(self._skillIntroduce, true)

	local skillCfg = CutePetConfig.instance:getStarSkillCfgs(self._curShowCutePetMo.raceId)

	self:_recordHeight(skillCfg)
	self._skillIntroList:reloadData(skillCfg)
	self._skillIntroList:MoveCellToCenter(1)
end

function CutePetEquipView:_onClickBtnSkillIntroClose()
	GameUtil.SetActive(self._skillIntroduce, false)
end

function CutePetEquipView:_onFilterSelect(typeIds)
	self._fillterTypes = #(typeIds or {}) > 0 and typeIds or nil

	self:_refreshView()
end

function CutePetEquipView:_onSortSelect(condition, isReverse)
	if checknumber(condition) ~= 0 then
		self._sortCondition = checknumber(condition)
		self._sortReverse = isReverse
	else
		self._sortCondition = nil
		self._sortReverse = false
	end

	self:_refreshView()
end

function CutePetEquipView:_onSearchTextChanged()
	local text = self._inputSearch:GetText()

	if text ~= self._fillterName then
		self._fillterName = text

		self:_refreshView()
	end
end

function CutePetEquipView:_onClickClearInput()
	self._inputSearch:SetText("")

	self._fillterName = ""

	self:_refreshView()
end

function CutePetEquipView:_onFilterViewClose()
	GameUtil.SetActive(self._btnClocseBag, true)
end

function CutePetEquipView:_PM_CutePetEquipResp()
	self:_refreshView()
end

function CutePetEquipView:_updateBagBoxCell(view, cell, data, tag)
	local btnUse = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnUse")
	local txtDesc = goutil.findChildTextComponent(cell.gameObject, "txtDesc")
	local matName = MaterialMgr.getMaterialsName(data.matType, data.matId)

	txtDesc.text = string.format("背包-%s\n(库存：%s)", matName, data.matNum)

	btnUse:AddClickListener(function()
		ItemBagController.instance:openUsePanel(data.mo)
	end)
end

function CutePetEquipView:_clearBagBoxCell(cell)
	return
end

function CutePetEquipView:_calAndShowBagCell()
	local list = MaterialModel.instance:getMaterialsByTypeExceptSub(MatType.Item_GoodFeel) or {}
	local bagBoxList = {}
	local isPass = false
	local content = ""

	for i, v in ipairs(list) do
		local type, id = v:getMatType(), v:getDefineId()
		local matCfg = MaterialMgr.getMatCfg(type, id)

		isPass = false

		if matCfg and matCfg.useType == 1 then
			local useCfg = MaterialConfig.instance:getCfgByMatAndId(type, id)

			if useCfg and ItemBagController.instance:checkCanUseNotWithTips(useCfg) then
				if useCfg.materialUseType == MatUseType.PACK or useCfg.materialUseType == MatUseType.MIX_SELECT then
					content = useCfg.content

					if self:_checkUseContentMatch(useCfg.content, MatType.CutePet) then
						isPass = true
					elseif self:_checkUseContentMatch(useCfg.content, MatType.DROP_ITEM) then
						local matStr = MaterialMgr.changeIfDrop(useCfg.content)

						content = matStr
						isPass = self:_checkUseContentMatch(matStr, MatType.CutePet)
					end
				end

				if isPass then
					local hasNum = MaterialFacade.instance:getMatNumber(type, id)

					table.insert(bagBoxList, {
						bagBox = true,
						matType = type,
						matId = id,
						matNum = hasNum,
						mo = v
					})
				end
			end
		end
	end

	table.sort(bagBoxList, function(a, b)
		return a.matNum > b.matNum
	end)
	self._bagScrollerList:reloadData(bagBoxList)

	return #bagBoxList > 0
end

function CutePetEquipView:_checkUseContentMatch(content, type)
	local match = string.match(content, string.format("^%s:%%d+:%%d+", type))

	match = match or string.match(content, string.format("[%%D]%s:%%d+:%%d+", type))

	return match
end

function CutePetEquipView:_showDetail()
	local goOrPos = self._info
	local pos = goOrPos
	local sizeDelta = {
		0,
		0
	}

	if goOrPos and goOrPos.gameObject then
		local rect = goOrPos.gameObject:GetComponent("RectTransform")

		if rect ~= nil then
			sizeDelta = {
				rect.sizeDelta.x,
				rect.sizeDelta.y
			}
		end

		pos = goOrPos.gameObject.transform.position

		local uiCamera = CameraTargetMgr.instance:getUICameraTarget():getCamera()

		pos = uiCamera:WorldToScreenPoint(pos)
	end

	GameUtil.SetActive(self._blackMask, true)
	UIStateManager.instance:open(ViewName.CutePetAttrPopUpView, pos, sizeDelta, self._viewPresentor, self._curShowCutePetMo.id, self._fixShowAttrMap)
end

function CutePetEquipView:_handleCloseCutePetEquipViewBlackMask()
	GameUtil.SetActive(self._blackMask, false)
end

function CutePetEquipView:_setBtnPosOnBagViewOpen()
	GameUtil.setAnchoredPos(self._btnEquip, 0, btnChangePos.y)
	GameUtil.setAnchoredPos(self._btnRemove, btnChangePos.x, btnChangePos.y)
	GameUtil.setAnchoredPos(self._btnStrengthen, -btnChangePos.x, btnChangePos.y)
end

function CutePetEquipView:_setBtnPosOnBagViewClose()
	GameUtil.setAnchoredPos(self._btnEquip, -btnChangePos.x, btnChangePos.y)
	GameUtil.setAnchoredPos(self._btnRemove, btnChangePos.x, btnChangePos.y)
	GameUtil.setAnchoredPos(self._btnStrengthen, btnChangePos.x, btnChangePos.y)
end

return CutePetEquipView
