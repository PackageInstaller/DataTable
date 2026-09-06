-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cutepet/view/CutePetSelectView.lua

module("logic.extensions.cutepet.view.CutePetSelectView", package.seeall)

local CutePetSelectView = class("CutePetSelectView", ViewComponent)

function CutePetSelectView:unbindEvents()
	CutePetSelectView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnCancel)
	GameUtil.rmClickHandler(self._btnSumbit)
	GameUtil.rmClickHandler(self._btnFilter)
	GameUtil.rmClickHandler(self._btnConditionSort)
	GameUtil.rmClickHandler(self._btnOneKeyCancel)
	GameUtil.rmClickHandler(self._btnOneKey)
end

function CutePetSelectView:bindEvents()
	CutePetSelectView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnCancel, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnSumbit, self._onClickSumbit, self)
	GameUtil.addClickHandler(self._btnFilter, self._onClickFillter, self)
	GameUtil.addClickHandler(self._btnConditionSort, self._onClickSort, self)
	GameUtil.addClickHandler(self._btnOneKeyCancel, self._onClickOneKeyCancel, self)
	GameUtil.addClickHandler(self._btnOneKey, self._onClickOneKey, self)
end

function CutePetSelectView:onExit()
	CutePetSelectView.super.onExit(self)
	CutePetFilterMgr.instance:resetDataByType(self._filterType)
	self._tableList:dispose()
	self._returnMatsList:dispose(self._clearReturnMatCell, self)
	GlobalDispatcher:dispatch(GlobalNotify.CutePetStarUpViewRefresh)
	GlobalDispatcher:removeListener(GlobalNotify.CutePetSelectSortSelect, self._onSortSelect, self)
end

function CutePetSelectView:buildUI()
	CutePetSelectView.super.buildUI(self)

	self._txtTitle = self:getTxt("Title/title")
	self._txtDesc = self:getTxt("Nego_Title/TxtC_Title")
	self._btnSumbit = self:getBtn("Btn_Submit")
	self._btnClose = self:getBtn("Btn_Close")
	self._btnCancel = self:getBtn("Btn_Cancel")
	self._btnOneKeyCancel = self:getBtn("btnOneKeyCancel")
	self._btnOneKey = self:getBtn("btnOneKey")
	self._conditionSortGo = self:getGo("btnSort")
	self._btnConditionSort = self:getGo("btnSort/bg")
	self._txtConditionSortName = self:getTxt("btnSort/bg/text")
	self._imgChangeConditionSort = self._conditionSortGo:GetComponent(ComponentType.UIChangeGroup)
	self._tableView = self:getGo("SrlC_Pet")
	self._tableCell = self:getGo("itemCutePetSelect")
	self._returnMatGo = self:getGo("returnMat")
	self._returnMatsEmpty = self:getGo("returnMat/txtEmpty")
	self._returnTableView = self:getGo("returnMat/returnTableView")
	self._returnTableCell = self:getGo("returnMat/returnTableView/returnCell")
	self._returnMatsList = ItemGroup.New(self._returnTableView, self._returnTableCell)
	self._filterGo = self:getGo("btnFilter")
	self._btnFilter = self:getGo("btnFilter/bg")
	self._txtFilter = self:getTxt("btnFilter/bg/text")
	self._imgFilter = self._filterGo:GetComponent(ComponentType.UIChangeGroup)
	self._imgType = goutil.findChildComponent(self._filterGo, "imgType", "UIImageSpriteChange")
end

function CutePetSelectView:onEnter()
	CutePetSelectView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.handlePM_SetCutePetLockStateResp, self.refreshView, self)
	self.addGEvent(self, GlobalNotify.handlePM_CutePetChangeReadyToDiscardRes, self.refreshView, self)

	self._filterType = CutePetFilterMgr.TYPE_CUTESELECT

	CutePetFilterMgr.instance:resetDataByType(self._filterType)

	self._firstEnter = false
	self._sortCondition = 0
	self._sortReverse = false

	self:initView()

	self._tableList = ScrollerList.create(self._tableView, self._tableCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	GlobalDispatcher:addListener(GlobalNotify.CutePetSelectSortSelect, self._onSortSelect, self)
	self:refreshView()
end

function CutePetSelectView:initView()
	local params = self:getOpenParam()

	self._onlyOne = params[1]
	self._selectedLimit = params[2]
	self._txtTitle.text = params[3] or lang("宠物选择")
	self._textDesc = params[4]

	local funcList = params[5]

	self._filterFunc = funcList.filterFunc
	self._submitFunc = funcList.submitFunc
	self._cancelFunc = funcList.cancelFunc
	self._totalCostFunc = funcList.totalCostFunc
	self._descChangeFunc = funcList.descChangeFunc
	self._selectMap = {}
	self._selectCount = 0

	for i, v in ipairs(params[6] or {}) do
		self._selectMap[v] = true
		self._selectCount = self._selectCount + 1
	end
end

function CutePetSelectView:refreshView()
	local allCutePet = CutePetModel.instance:getAllCutePet()

	allCutePet = self:_petFillter(allCutePet)
	self._showPetList = {}
	self._backPetList = {}

	for i, mo in pairs(allCutePet) do
		if not self._filterFunc or self._filterFunc(mo.id) == true then
			if mo:getState(CutePetMo.STATE_IN_ADVENTURE) == true or checknumber(mo.equippedPetId) > 0 or mo:getState(CutePetMo.LOCKED) == true then
				table.insert(self._backPetList, mo)
			else
				table.insert(self._showPetList, mo)
			end
		end
	end

	self._showPetList = ArraySort.sortOn(self._showPetList, {
		"score",
		"curQuality",
		"curStar",
		"curLvl"
	}, {
		ArraySort.NONE,
		ArraySort.NONE,
		ArraySort.NONE,
		ArraySort.NONE
	})
	self._backPetList = ArraySort.sortOn(self._backPetList, {
		"score",
		"curQuality",
		"curStar",
		"curLvl"
	}, {
		ArraySort.NONE,
		ArraySort.NONE,
		ArraySort.NONE,
		ArraySort.NONE
	})

	table.sort(self._showPetList, function(a, b)
		return self:_comparePet(a, b, self._sortCondition, self._sortReverse)
	end)
	table.sort(self._backPetList, function(a, b)
		return self:_comparePet(a, b, self._sortCondition, self._sortReverse)
	end)

	for i, mo in ipairs(self._backPetList) do
		table.insert(self._showPetList, mo)
	end

	local color = "33b57fFF"

	if self._selectedLimit > self._selectCount then
		color = "df5757FF"
	end

	if self._descChangeFunc then
		local selectList = {}

		for i, v in pairs(self._selectMap) do
			if v == true then
				table.insert(selectList, i)
			end
		end

		self._textDesc = self._descChangeFunc(selectList)
	end

	self._txtDesc.text = self._textDesc and langPara(self._textDesc .. "<color=#%s>(%s/%s)</color>", self._selectedLimit, color, self._selectCount, self._selectedLimit) or langPara("(%s/%s)", self._selectCount, self._selectedLimit)

	self:_refreshReturn()
	GameUtil.SetActive(self._empty, #self._showPetList == 0)

	local result = {}

	for i, v in ipairs(self._showPetList) do
		table.insert(result, v)
	end

	self._tableList:reloadData(result)

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
		elseif self._sortCondition == CutePetModel.SortType.Discard then
			self._txtConditionSortName.text = lang("弃置")
		end
	else
		self._imgChangeConditionSort:SetState(1)
	end

	self._firstEnter = true
end

function CutePetSelectView:_refreshReturn()
	GameUtil.SetActive(self._returnMatGo, self._totalCostFunc ~= nil)

	if not self._totalCostFunc then
		return
	end

	local totalCost = {}

	for id, isSelect in pairs(self._selectMap) do
		if isSelect == true then
			local mo = CutePetModel.instance:getCutePeMo(id)

			if mo and self._totalCostFunc then
				GameUtil.callBack(self._totalCostFunc, totalCost, mo)
			end
		end
	end

	local resultList = {}

	for matType, v in pairs(totalCost) do
		for matId, matNum in pairs(v) do
			local matData = {
				matType = matType,
				matId = matId,
				matNum = matNum
			}

			table.insert(resultList, matData)
		end
	end

	GameUtil.SetActive(self._returnMatsEmpty, #resultList <= 0)
	self._returnMatsList:updateWithMoArray(resultList, self._updateReturnMatCell, self)
end

function CutePetSelectView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local petCon = goutil.findChild(go, "Nego_Info")
	local selectGo = goutil.findChild(go, "img_select")
	local txtName = goutil.findChildTextComponent(go, "TxtC_Name")
	local txtLevel = goutil.findChildTextComponent(go, "TxtC_Level")
	local btn = GameUtil.asBtn(goutil.findChild(go, "btnClick"))
	local itemProtectPet = goutil.findChild(go, "itemProtectPet")
	local imgAdv = goutil.findChild(go, "imgAdv")
	local imgLock = goutil.findChild(go, "lock")
	local imgDiscard = goutil.findChild(go, "discard")
	local txtScore = goutil.findChildTextComponent(go, "txtScore")
	local mo = data

	txtName.text = mo.name
	txtLevel.text = langPara("Lv.%s", mo.curLvl)
	txtScore.text = langPara("评分:%s", mo.score)

	local maxStar = CutePetConfig.instance:getMaxStar(mo.config.starUpPlan, mo.curQuality)

	for i = 1, 6 do
		local star = goutil.findChild(go, "starLv/star_" .. i)
		local starChange = goutil.findChildComponent(go, "starLv/star_" .. i, "UIImageSpriteChange")

		if i <= mo.curStar then
			starChange:SetState(0)
		else
			starChange:SetState(1)
		end

		if i <= maxStar then
			GameUtil.SetActive(star, true)
		else
			GameUtil.SetActive(star, false)
		end
	end

	local isLock = mo:getState(CutePetMo.LOCKED)
	local proxy = MaterialMgr.setCellByMo(mo, petCon)

	if proxy then
		proxy.binder:setCallBack(nil)
		proxy.binder:setAutoTips(true)
	end

	GameUtil.SetActive(imgLock, isLock)
	GameUtil.SetActive(imgDiscard, mo:getIsReadyToDiscard())
	GameUtil.SetActive(imgAdv, mo:getState(CutePetMo.STATE_IN_ADVENTURE))
	GameUtil.SetActive(itemProtectPet, checknumber(mo.equippedPetId) > 0)

	if mo.equippedPetId > 0 then
		local bagPetMo = BagPetsController.instance:getPet(mo.equippedPetId)

		MaterialMgr.setCell(MatType.Pet, bagPetMo.curFaceId, itemProtectPet)
	end

	if self._selectMap[mo.id] == true then
		GameUtil.SetActive(selectGo, true)
	else
		GameUtil.SetActive(selectGo, false)
	end

	btn:AddClickListener(function()
		self:_onClickPet(mo)
	end, self)
end

function CutePetSelectView:_clearCell(cell)
	local go = cell.gameObject
	local btn = GameUtil.asBtn(go)
	local petCon = goutil.findChild(go, "Nego_Info")
	local itemProtectPet = goutil.findChild(go, "itemProtectPet")

	MaterialMgr.resetAll(petCon)
	MaterialMgr.resetAll(itemProtectPet)
	btn:RemoveClickListener()
end

function CutePetSelectView:_updateReturnMatCell(cell, data, index)
	local go = cell.mainGO
	local con = goutil.findChild(go, "con")
	local txtNum = goutil.findChildTextComponent(go, "txt")

	MaterialMgr.setIcon(con, data.matType, data.matId)

	txtNum.text = data.matNum
end

function CutePetSelectView:_clearReturnMatCell(cell)
	local go = cell.mainGO
	local con = goutil.findChild(go, "con")

	MaterialMgr.resetAll(con)
end

function CutePetSelectView:_petFillter(list)
	local resultList = {}

	for i, mo in pairs(list) do
		if ((CutePetFilterMgr.instance:checkIsMatch(self._filterType, mo.cfg, mo.id) == true or nil) and true) == true then
			table.insert(resultList, mo)
		end
	end

	return resultList
end

function CutePetSelectView:_getPosAndSizeDelta(go)
	local rect = go.gameObject:GetComponent("RectTransform")
	local pos = go.gameObject.transform.position
	local uiCamera = CameraTargetMgr.instance:getUICameraTarget():getCamera()

	pos = uiCamera:WorldToScreenPoint(pos)

	return pos, (rect ~= nil or nil) and {
		rect.sizeDelta.x,
		rect.sizeDelta.y
	}
end

function CutePetSelectView:_onClickPet(mo, isAuto)
	if mo:getState(CutePetMo.STATE_IN_ADVENTURE) == true then
		FloatWordMgr.instance:show(lang("不可选择处于上锁、庇护或冒险中的宠物"))

		return
	elseif checknumber(mo.equippedPetId) > 0 then
		FloatWordMgr.instance:show(lang("不可选择处于上锁、庇护或冒险中的宠物"))

		return
	elseif mo:getState(CutePetMo.LOCKED) == true then
		TipsFacade.instance:openPopupWindow(lang("提示"), lang("萌宠上锁中，是否解锁？"), function()
			CutePetController.instance:sendPM_SetCutePetLockStateReq(mo, false)
		end)

		return
	end

	if not self._selectMap[mo.id] then
		if self._selectCount < self._selectedLimit then
			if self._onlyOne == true then
				self._onlySelectId = mo.id
			end

			self._selectMap[mo.id] = true
			self._selectCount = self._selectCount + 1
		elseif self._onlyOne == true and checknumber(self._onlySelectId) > 0 then
			self._selectMap[self._onlySelectId] = false
			self._onlySelectId = mo.id
			self._selectMap[mo.id] = true
		else
			FloatWordMgr.instance:show(lang("已达可选上限"))
		end
	else
		self._selectMap[mo.id] = false
		self._selectCount = self._selectCount - 1
	end

	if not isAuto then
		self:refreshView()
	end
end

function CutePetSelectView:_onClickClose()
	local selectList = {}

	for i, v in pairs(self._selectMap) do
		if v == true then
			table.insert(selectList, i)
		end
	end

	if self._cancelFunc then
		if self._onlyOne == true then
			if #selectList > 0 then
				GameUtil.callBack(self._cancelFunc, self, selectList[1])
			else
				GameUtil.callBack(self._cancelFunc, self, nil)
			end
		else
			GameUtil.callBack(self._cancelFunc, self, selectList)
		end
	end

	CutePetFilterMgr.instance:resetDataByType(self._filterType)
	self:close()
end

function CutePetSelectView:_onClickFillter()
	local pos, sizeDelta = self:_getPosAndSizeDelta(self._filterGo)

	CutePetFilterMgr.instance:openFilterViewByType(self._viewPresentor, self._filterType, pos, sizeDelta, GameUtil.handler(self.refreshView, self))
end

function CutePetSelectView:_onClickSort()
	local pos, sizeDelta = self:_getPosAndSizeDelta(self._conditionSortGo)

	UIStateManager.instance:open(ViewName.CutePetSelectSortView, pos, sizeDelta, self._viewPresentor, self._sortCondition, self._sortReverse)
end

function CutePetSelectView:_onClickSumbit()
	local selectList = {}

	for i, v in pairs(self._selectMap) do
		if v == true then
			table.insert(selectList, i)
		end
	end

	if self._submitFunc then
		if self._onlyOne == true then
			if #selectList > 0 then
				GameUtil.callBack(self._submitFunc, self, selectList[1])
			else
				GameUtil.callBack(self._submitFunc, self, nil)
			end
		else
			GameUtil.callBack(self._submitFunc, self, selectList)
		end
	end
end

function CutePetSelectView:_onClickOneKeyCancel()
	for i, v in pairs(self._selectMap) do
		self._selectMap[i] = false
	end

	self._selectCount = 0

	self:refreshView()
end

function CutePetSelectView:_onClickOneKey()
	if self._selectedLimit > self._selectCount then
		for i, mo in ipairs(self._showPetList) do
			if self._selectedLimit <= self._selectCount then
				break
			end

			if not mo:getState(CutePetMo.STATE_IN_ADVENTURE) and checknumber(mo.equippedPetId) <= 0 and not self._selectMap[mo.id] then
				self:_onClickPet(mo, true)
			end
		end

		self:refreshView()
	end
end

function CutePetSelectView:_onSortSelect(sortCondition, isReverse)
	self._sortCondition = sortCondition
	self._sortReverse = isReverse

	self:refreshView()
end

function CutePetSelectView:_comparePet(a, b, conditionId, isReverse)
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

	return self:_compareDiscard(a, b, false)
end

function CutePetSelectView:_compareLv(a, b, isReverse)
	if a.curLvl > b.curLvl then
		return not isReverse
	elseif a.curLvl < b.curLvl then
		return isReverse
	end

	return self:_compareQuality(a, b, false)
end

function CutePetSelectView:_compareQuality(a, b, isReverse)
	if a.curQuality > b.curQuality then
		return not isReverse
	elseif a.curQuality < b.curQuality then
		return isReverse
	end

	return self:_compareStar(a, b, false)
end

function CutePetSelectView:_compareStar(a, b, isReverse)
	if a.curStar > b.curStar then
		return not isReverse
	elseif a.curStar < b.curStar then
		return isReverse
	end

	return self:_compareTime(a, b, false)
end

function CutePetSelectView:_compareTime(a, b, isReverse)
	if a.gainTime == b.gainTime then
		return self:_compId(a, b, false)
	elseif not isReverse then
		return a.gainTime > b.gainTime
	else
		return a.gainTime < b.gainTime
	end
end

function CutePetSelectView:_compareScore(a, b, isReverse)
	if a.score == b.score then
		return self:_compareTime(a, b, false)
	elseif not isReverse then
		return a.score > b.score
	else
		return a.score < b.score
	end
end

function CutePetSelectView:_compareDiscard(a, b, isReverse)
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

function CutePetSelectView:_compId(a, b, isReverse)
	if not isReverse then
		return a.id < b.id
	end

	return a.id > b.id
end

return CutePetSelectView
