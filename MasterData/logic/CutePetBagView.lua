-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cutepet/view/CutePetBagView.lua

module("logic.extensions.cutepet.view.CutePetBagView", package.seeall)

local CutePetBagView = class("CutePetBagView", ViewComponent)

function CutePetBagView:ctor()
	CutePetBagView.super.ctor(self)
end

function CutePetBagView:buildUI()
	CutePetBagView.super.buildUI(self)

	self._btnClose = self:getBtn("title/btnRtn")
	self._tableView = self:getGo("ScrollView")
	self._tableCell = self:getGo("Cell")
	self._txtPetCount = self:getTxt("limit/txtNum")
	self._tipBtn = self:getGo("limit/tipBtn")
	self._btnRule = self:getBtn("tipBtn")
	self._btnOneKeyRelease = self:getGo("btnOneKeyRelease")
	self._inputSearch = self:getInput("InputC_Search")
	self._btnClearInput = self:getGo("InputC_Search/BtnClear")
	self._conditionSortGo = self:getGo("btnSort")
	self._btnConditionSort = self:getGo("btnSort/bg")
	self._txtConditionSortName = self:getTxt("btnSort/bg/text")
	self._imgChangeConditionSort = self._conditionSortGo:GetComponent(ComponentType.UIChangeGroup)
	self._filterGo = self:getGo("btnFilter")
	self._btnFilter = self:getGo("btnFilter/bg")
	self._txtFilter = self:getTxt("btnFilter/bg/text")
	self._imgFilter = self._filterGo:GetComponent(ComponentType.UIChangeGroup)
	self._imgType = goutil.findChildComponent(self._filterGo, "imgType", "UIImageSpriteChange")
end

function CutePetBagView:bindEvents()
	CutePetBagView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnRule, self._onClickRule, self)
	GameUtil.addClickHandler(self._btnConditionSort, self._onClickSort, self)
	GameUtil.addClickHandler(self._btnFilter, self._onClickFillter, self)
	GameUtil.addClickHandler(self._btnClearInput, self._onClickClearInput, self)
	GameUtil.addClickHandler(self._btnOneKeyRelease, self._onClickOneKeyRelease, self)
	self._inputSearch:AddOnValueChanged(self._onSearchTextChanged, self)
	GameUtil.addClickHandler(self._tipBtn, self._onClickTips, self)
end

function CutePetBagView:unbindEvents()
	CutePetBagView.super.unbindEvents(self)
	self._inputSearch:RemoveOnValueChanged()
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnRule)
	GameUtil.rmClickHandler(self._btnConditionSort)
	GameUtil.rmClickHandler(self._btnFilter)
	GameUtil.rmClickHandler(self._btnClearInput)
	GameUtil.rmClickHandler(self._btnOneKeyRelease)
	GameUtil.rmClickHandler(self._tipBtn)
end

function CutePetBagView:onExit()
	CutePetBagView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.handlePM_EnterGameLoadInfoResp, self.refreshView, self)
	GlobalDispatcher:removeListener(GlobalNotify.CutePetBagFilterSelect, self._onFilterSelect, self)
	GlobalDispatcher:removeListener(GlobalNotify.CutePetBagSortSelect, self._onSortSelect, self)
end

function CutePetBagView:destroyUI()
	CutePetBagView.super.destroyUI(self)
end

function CutePetBagView:_onClickClose()
	CutePetFilterMgr.instance:resetDataByType(self._filterType)
	self:close()
end

function CutePetBagView:_onClickTips()
	local managementLevel = CutePetModel.instance:getBuildingLevel(CutePetBuildingType.Management)
	local managementCfg = CutePetConfig.instance:getGardenCfg(managementLevel)
	local num = 0
	local name = "萌宠园"
	local type = MatType.CutePet
	local petCount = ItemBagModel.instance:getMaxLvlSSRPetNum()

	num = checknumber(CutePetConfig.instance:getCommonValue("GardenMaxCapacityLimit"))

	local list = MaterialMgr.getModelList(type) or {}
	local total, addPercent = CutePetModel.instance:getLimitTotalNum(petCount, num)
	local petStartLine = CutePetModel.instance:getPetStartLine()
	local incrCapacityPetGap = CutePetModel.instance:getIncrCapacityPetGap()
	local gapAddPercent = CutePetModel.instance:getGapAddPercent()
	local maxCapacity = CutePetModel.instance:getMaxCapacity()
	local cur = langPara("%s/%s", #list, total)
	local str = "%s初始容量为<color=#C54949>%s</color>。\n当拥有<color=#C54949>%s只满级传说精灵</color>时，每超出<color=#C54949>%s</color>只增加<color=#C54949>%s%%</color>的容量上限，最多可以达到<color=#C54949>%s</color>。\n当前增加比例:<color=#C54949>%s%%</color>\n当前容量:<color=#C54949>%s</color>"
	local content = langPara(str, name, num, petStartLine, incrCapacityPetGap, gapAddPercent, maxCapacity, addPercent, cur)

	TipsFacade.instance:openTipWindowNoXBig(lang("tip"), content, nil, "知道了", UnityEngine.TextAnchor.MiddleLeft)
end

function CutePetBagView:onEnter()
	CutePetBagView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.handlePM_EnterGameLoadInfoResp, self.refreshView, self)
	GlobalDispatcher:addListener(GlobalNotify.handlePM_ReleaseCutePetResp, self.refreshView, self)
	GlobalDispatcher:addListener(GlobalNotify.CutePetBagFilterSelect, self._onFilterSelect, self)
	GlobalDispatcher:addListener(GlobalNotify.CutePetBagSortSelect, self._onSortSelect, self)

	self._filterType = CutePetFilterMgr.TYPE_CUTEPETVIEW

	if FuncOpenController.instance:checkFuncIdOrShowLockTips(910) == false then
		self:close()

		return
	end

	self._sortReverse = false
	self._tableList = ScrollerList.create(self._tableView, self._tableCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self:refreshView()
end

function CutePetBagView:refreshView()
	local managementLevel = CutePetModel.instance:getBuildingLevel(CutePetBuildingType.Management)
	local managementCfg = CutePetConfig.instance:getGardenCfg(managementLevel)

	self._curResultList = CutePetModel.instance:getAllCutePetsList()

	GameUtil.SetActive(self._tipBtn, false)

	if not self._txtPetCount then
		return
	end

	if managementCfg then
		self._txtPetCount.text = langPara("%d/%d", #self._curResultList, managementCfg.cutePetCapacity)

		local GardenMaxCapacityLimit = checknumber(CutePetConfig.instance:getCommonValue("GardenMaxCapacityLimit"))

		GameUtil.SetActive(self._tipBtn, GardenMaxCapacityLimit <= managementCfg.cutePetCapacity)

		if GardenMaxCapacityLimit <= managementCfg.cutePetCapacity then
			local petCount = ItemBagModel.instance:getMaxLvlSSRPetNum()
			local total, addPercent = CutePetModel.instance:getLimitTotalNum(petCount, GardenMaxCapacityLimit)
			local cur = #self._curResultList

			self._txtPetCount.text = cur > total * 0.9 and langPara("<color=#eb4642>%s</color>/%s", cur, total) or langPara("%s/%s", cur, total)
		end
	end

	self._curResultList = self:_petFillter(self._curResultList)

	self._tableList:reloadData(self._curResultList)

	self._txtFilter.text = lang("筛选")

	GameUtil.SetActive(self._imgType, false)

	if self._fillterTypes and #self._fillterTypes > 0 then
		self._imgFilter:SetState(0)

		if #self._fillterTypes == 1 then
			local typeCfg = CutePetConfig.instance:getPetTypeCfg(self._fillterTypes[1])

			self._txtFilter.text = typeCfg.name

			self._imgType:SetState(self._fillterTypes[1] - 1)
			GameUtil.SetActive(self._imgType, true)
		end
	else
		self._imgFilter:SetState(1)
	end

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
		elseif self._sortCondition == CutePetModel.SortType.Discard then
			self._txtConditionSortName.text = lang("弃置")
		end
	else
		self._imgChangeConditionSort:SetState(1)
	end
end

function CutePetBagView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local name = goutil.findChildTextComponent(go, "container/cover/txtName")
	local txtLevel = goutil.findChildTextComponent(go, "container/cover/txtLvl")
	local con = goutil.findChild(go, "container/mask/con")
	local btn = GameUtil.asBtn(goutil.findChild(go, "container"))
	local qualityChange = goutil.findChildComponent(go, "container/cover/qualitybg", "UIChangeGroup")
	local itemProtectPet = goutil.findChild(go, "container/cover/itemProtectPet")
	local petTypeCfg = CutePetConfig.instance:getPetTypeCfg(data.config.type)
	local imgShouHu = goutil.findChild(go, "container/cover/imgShouHu")
	local lockGo = goutil.findChild(go, "container/cover/lock")
	local discardGo = goutil.findChild(go, "container/cover/discard")

	GameUtil.SetActive(lockGo, data:getState(CutePetMo.LOCKED))
	GameUtil.SetActive(discardGo, data:getIsReadyToDiscard())

	txtLevel.text = data.curLvl
	name.text = data.name

	local maxStar = CutePetConfig.instance:getMaxStar(data.config.starUpPlan, data.curQuality)

	for i = 1, 6 do
		local star = goutil.findChild(go, "container/cover/starLv/star_" .. i)
		local starChange = goutil.findChildComponent(go, "container/cover/starLv/star_" .. i, "UIImageSpriteChange")

		GameUtil.SetActive(star, i <= maxStar)

		if i <= data.curStar then
			starChange:SetState(0)
		else
			starChange:SetState(1)
		end
	end

	GameUtil.SetActive(itemProtectPet, checknumber(data.equippedPetId) > 0)
	GameUtil.SetActive(imgShouHu, checknumber(data.equippedPetId) > 0)

	if checknumber(data.equippedPetId) > 0 then
		local bagPetMo = BagPetsController.instance:getPet(data.equippedPetId)

		MaterialMgr.setCell(MatType.Pet, bagPetMo.curFaceId, itemProtectPet)
	end

	qualityChange:SetState(data.curQuality - 1)
	uGuiUtil.setSpriteToImage(con, nil, GameUrl.getCutepetImgUrl(data.config.cardName))
	btn:AddClickListener(function()
		CutePetController.instance:openBagPetView(data.id, 0, self._curResultList)
	end)
end

function CutePetBagView:_clearCell(cell)
	local itemProtectPet = goutil.findChild(cell.gameObject, "container/cover/itemProtectPet")
	local go = cell.gameObject

	MaterialMgr.resetAll(itemProtectPet)

	local btn = GameUtil.asBtn(goutil.findChild(go, "container"))

	btn:RemoveClickListener()
end

function CutePetBagView:_petFillter(list)
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

	table.sort(resultList, function(a, b)
		return self:_comparePet(a, b, self._sortCondition, self._sortReverse)
	end)

	return resultList
end

function CutePetBagView:_comparePet(a, b, conditionId, isReverse)
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
	elseif conditionId == CutePetModel.SortType.Discard then
		return self:_compareDiscard(a, b, isReverse)
	end

	return self:_compareEquip(a, b, isReverse)
end

function CutePetBagView:_compareDiscard(a, b, isReverse)
	local aDiscard = a:getIsReadyToDiscard()
	local bDiscard = b:getIsReadyToDiscard()

	if aDiscard == bDiscard then
		if a.score == b.score then
			return self:_compareTime(a, b, false)
		end

		return a.score < b.score
	elseif not isReverse then
		return aDiscard
	else
		return bDiscard
	end
end

function CutePetBagView:_compareLv(a, b, isReverse)
	if a.curLvl > b.curLvl then
		return not isReverse
	elseif a.curLvl < b.curLvl then
		return isReverse
	else
		return self:_compareQuality(a, b, false)
	end
end

function CutePetBagView:_compareQuality(a, b, isReverse)
	if a.curQuality > b.curQuality then
		return not isReverse
	elseif a.curQuality < b.curQuality then
		return isReverse
	else
		return self:_compareStar(a, b, false)
	end
end

function CutePetBagView:_compareStar(a, b, isReverse)
	if a.curStar > b.curStar then
		return not isReverse
	elseif a.curStar < b.curStar then
		return isReverse
	else
		return self:_compareTime(a, b, false)
	end
end

function CutePetBagView:_compareTime(a, b, isReverse)
	if a.gainTime == b.gainTime then
		return self:_compId(a, b, false)
	elseif not isReverse then
		return a.gainTime > b.gainTime
	else
		return a.gainTime < b.gainTime
	end
end

function CutePetBagView:_compareScore(a, b, isReverse)
	if a.score == b.score then
		return self:_compareTime(a, b, false)
	elseif not isReverse then
		return a.score > b.score
	else
		return a.score < b.score
	end
end

function CutePetBagView:_compId(a, b, isReverse)
	if not isReverse then
		return a.id < b.id
	else
		return a.id > b.id
	end
end

function CutePetBagView:_compareEquip(a, b, isReverse)
	if checknumber(a.equippedPetId) > 0 and checknumber(b.equippedPetId) > 0 or checknumber(a.equippedPetId) == 0 and checknumber(b.equippedPetId) == 0 then
		return self:_compareTime(a, b, false)
	elseif not isReverse then
		return checknumber(a.equippedPetId) > checknumber(b.equippedPetId)
	else
		return checknumber(a.equippedPetId) < checknumber(b.equippedPetId)
	end
end

function CutePetBagView:_getPosAndSizeDelta(go)
	local rect = go.gameObject:GetComponent("RectTransform")
	local pos = go.gameObject.transform.position
	local uiCamera = CameraTargetMgr.instance:getUICameraTarget():getCamera()

	pos = uiCamera:WorldToScreenPoint(pos)

	return pos, (rect ~= nil or nil) and {
		rect.sizeDelta.x,
		rect.sizeDelta.y
	}
end

function CutePetBagView:_onSearchTextChanged()
	local text = self._inputSearch:GetText()

	if text ~= self._fillterName then
		self._fillterName = text

		self:refreshView()
	end
end

function CutePetBagView:_onClickRule()
	UIStateManager.instance:open(ViewName.RulesView, "cute_pet_bag_rule")
end

function CutePetBagView:_onClickOneKeyRelease()
	local title = "一键放生"
	local descStr = langPara("可以放生最多%%d只处于庇护或冒险协会以外的宠物，返还%d%%%%养成材料和一定数量的乐园币", CutePetConfig.instance:getCommonValue("CutePetLvlReturnRateWhenDeleted", true) * 100)
	local funcList = {
		submitFunc = GameUtil.handler(self._onSelectCutePet, self),
		totalCostFunc = GameUtil.handler(self._onGetTotalCost, self)
	}

	CutePetController.instance:openCutePetSelectView(100, title, descStr, nil, funcList)
end

function CutePetBagView:_onSelectCutePet(view, petIds)
	if PasswordLockController.instance:checkNeedOpenVerifyView() then
		return false
	end

	local hasTip = false
	local checkTip = false

	if type(petIds) == "number" then
		checkTip = checknumber(petIds) > 0
	elseif type(petIds) == "table" then
		checkTip = #petIds > 0
	end

	if checkTip == true then
		local content = lang("放生后所选宠物将消失，返还乐园币与已消耗的部分培养材料\n\n<color=#eb4642>放生后在双人出游中预设的萌宠将自动撤销</color>")

		TipsFacade.instance:openPopupWindow(lang("提示"), content, function()
			self:_onSelectPet(petIds)
			view:close()
		end)

		hasTip = true
	else
		self:_onSelectPet(petIds)
		view:close()
	end
end

function CutePetBagView:_onSelectPet(petIds)
	if type(petIds) == "table" then
		if #petIds > 0 then
			CutePetController.instance:sendPM_ReleaseCutePetReq(petIds)
		end
	elseif type(petIds) == "number" then
		local id = checknumber(petIds)

		if id > 0 then
			CutePetController.instance:sendPM_ReleaseCutePetReq({
				id
			})
		end
	end
end

function CutePetBagView:_onGetTotalCost(totalCost, mo)
	local levelCfgs = CutePetConfig.instance:getLevelUpCfgs(mo.config.lvlUpPlan)
	local levelMats = {}

	for i = 1, mo.curLvl do
		if levelCfgs[i] and not string.nilorempty(levelCfgs[i].materialCost) then
			local matType, matId, matNum = MaterialMgr.getMatParams(levelCfgs[i].materialCost)

			levelMats[matType] = levelMats[matType] or {}
			levelMats[matType][matId] = checknumber(levelMats[matType][matId]) + matNum
		end
	end

	local levelReturnRate = CutePetConfig.instance:getCommonValue("CutePetLvlReturnRateWhenDeleted", true)

	for matType, v in pairs(levelMats) do
		for matId, matNum in pairs(v) do
			if checknumber(matNum) > 0 then
				totalCost[matType] = totalCost[matType] or {}
				totalCost[matType][matId] = math.ceil(matNum * levelReturnRate) + checknumber(totalCost[matType][matId])
			end
		end
	end

	local qualityCfgs = CutePetConfig.instance:getQualityUpPlan(mo.config.qualityUpPlan)
	local qualityMats = {}

	for i = 1, mo.curQuality do
		if qualityCfgs[i] and not string.nilorempty(qualityCfgs[i].materialCost) then
			local matType, matId, matNum = MaterialMgr.getMatParams(qualityCfgs[i].materialCost)

			qualityMats[matType] = qualityMats[matType] or {}
			qualityMats[matType][matId] = checknumber(qualityMats[matType][matId]) + matNum
		end
	end

	local qualityReturnRate = CutePetConfig.instance:getCommonValue("CutePetQualityReturnRateWhenDeleted", true)

	for matType, v in pairs(qualityMats) do
		for matId, matNum in pairs(v) do
			if checknumber(matNum) > 0 then
				totalCost[matType] = totalCost[matType] or {}
				totalCost[matType][matId] = math.ceil(matNum * qualityReturnRate) + checknumber(totalCost[matType][matId])
			end
		end
	end

	local curStarCfg = CutePetConfig.instance:getStarUpCfg(mo.config.starUpPlan, mo.curStar)
	local initStarCfg = CutePetConfig.instance:getStarUpCfg(mo.config.starUpPlan, 1)
	local starMatNum = curStarCfg.returnValue4Delete
	local starMat = CutePetConfig.instance:getCommonValue("CutePetStarReturnMaterialWhenDeleted", false)
	local starMatType, starMatId, _ = MaterialMgr.getMatParams(starMat)

	if starMatNum > 0 then
		totalCost[starMatType] = totalCost[starMatType] or {}
		totalCost[starMatType][starMatId] = starMatNum + checknumber(totalCost[starMatType][starMatId])
	end
end

function CutePetBagView:_onClickFillter()
	local pos, sizeDelta = self:_getPosAndSizeDelta(self._filterGo)

	CutePetFilterMgr.instance:openFilterViewByType(self._viewPresentor, self._filterType, pos, sizeDelta, GameUtil.handler(self.refreshView, self))
end

function CutePetBagView:_onClickSort()
	local pos, sizeDelta = self:_getPosAndSizeDelta(self._conditionSortGo)

	UIStateManager.instance:open(ViewName.CutePetSortView, pos, sizeDelta, self._viewPresentor, self._sortCondition, self._sortReverse)
end

function CutePetBagView:_onClickClearInput()
	self._inputSearch:SetText("")

	self._fillterName = ""

	self:refreshView()
end

function CutePetBagView:_onFilterSelect(typeIds)
	self._fillterTypes = #(typeIds or {}) > 0 and typeIds or nil

	self:refreshView()
end

function CutePetBagView:_onSortSelect(condition, isReverse)
	if checknumber(condition) ~= 0 then
		self._sortCondition = checknumber(condition)
		self._sortReverse = isReverse
	else
		self._sortCondition = nil
		self._sortReverse = false
	end

	self:refreshView()
end

return CutePetBagView
