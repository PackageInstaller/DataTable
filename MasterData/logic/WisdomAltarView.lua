-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wisdomaltar/view/WisdomAltarView.lua

module("logic.extensions.wisdomaltar.view.WisdomAltarView", package.seeall)

local WisdomAltarView = class("WisdomAltarView", PetAwakeViewBase)
local UIImageSpriteChange = typeof(UIImageSpriteChange)

function WisdomAltarView:buildUI()
	self._goldBarCon = self:getGo("goldBarCon")
	self._tableview = self:getGo("listView/ScrollView"):GetComponent("UITableview")
	self._tableCell = self:getGo("listView/Cell")
	self._btnUpGrade = self:getBtn("btnStarUp")
	self._btnClose = self:getBtn("closeBG/btnClose")
	self._mask = self:getGo("mask")
	self._nonSprite = self:getGo("listView/NonSprite")
	self._textNon = goutil.findChildTextComponent(self._nonSprite, "Text")
	self._textTips = self:getTxt("TextTips")
	self._btnOneStarUp = self:getBtn("btnOneStarUp")
	self._btnDraw = self:getBtn("btnDraw")
	self._btnChallenge = self:getBtn("btnChallenge")
	self._oneName = self:getTxt("btnOneStarUp/txtName")
	self._btnHelp = self:getBtn("btnHelp")
	self._dropdown = DropDownAdapter.Get(self:getGo("Dropdown"))
	self._textUpGrade = goutil.findChildTextComponent(self._btnUpGrade.gameObject, "Text")

	goutil.setActive(self._mask, false)
	self._tableCell:SetActive(false)
	self:_initCardAndMats()
	self:_initMatItem()
	self:_initMatExtItem()
	self:_initRaceFilters()
	self:_initAwakenConditions()
end

function WisdomAltarView:_initCardAndMats()
	self._cardNode = self:getGo("lunpan/cardNode/point")
	self._matNode = self:getGo("lunpan/matNode")
	self._matLayout = goutil.findChildComponent(self._matNode, "matLayout", ComponentType.UILayoutSingleLine)
	self._tempCardNode = self:getGo("tempCardNode")
	self._curCardData = nil
	self._tempCardData = nil

	self._tempCardNode:SetActive(false)
	self._cardNode:SetActive(false)

	self._textCost = self:getTxt("txtMoney")
	self._costIcon = self:getGo("txtMoney/icon_diamotask")
	self._txtMaterialTips = self:getTxt("lunpan/matNode/txtMaterialTips")
	self._nameNode = self:getGo("lunpan/nameNode")
	self._cardName = self:getTxt("lunpan/nameNode/name")
	self._quality = self:getGo("lunpan/nameNode/con")
	self._rare = self:getGo("lunpan/nameNode/rare")
	self._leftRare = goutil.findChild(self._rare, "left_rare")
	self._rightRare = goutil.findChild(self._rare, "right_rare")
	self._matFlyItem = self:getGo("flyingRoot/matFly")

	self._matFlyItem:SetActive(false)

	self._awakenTips = self:getGo("lunpan/nameNode/awakenTips")
	self._txtAwakenTips = goutil.findChildTextComponent(self._awakenTips, "txtAwakenTips")
	self._btnDetail = Framework.ButtonAdapter.GetFrom(self._nameNode, "btn_detail")
end

function WisdomAltarView:_initRaceFilters()
	self._racesTypes = {}

	local btnGrids = self:getGo("listView/btnGrid")

	for i = 1, 5 do
		self._racesTypes[i] = self:getBtn("listView/btnGrid/btnAttr" .. i)
	end

	self._racesTypes[0] = self:getBtn("listView/btnGrid/btnAll")
	self._attrSelected = self:getGo("listView/btnGrid/gridSel")
end

function WisdomAltarView:_initMatItem()
	local matGo = self._matLayout.transform:GetChild(0).gameObject
	local matItemPet = self._viewPresentor:getResInstance(ItemPet.ResPath)

	matItemPet.transform:SetParent(matGo.transform)
	Framework.TransformUtil.SetLocalPos(matItemPet.transform, 0, 0, 0)
	Framework.TransformUtil.SetLocalRotation(matItemPet.transform, 0, 0, 0)
	Framework.TransformUtil.SetLocalScale(matItemPet.transform, 1, 1, 1)
	matItemPet.transform:SetAsFirstSibling()

	local validNodes = {
		ImgC_HeadIcon = true,
		Nego_Attr = true,
		stars = true,
		ImgC_Bg = true
	}

	matItemPet.name = "default"

	local destroyGos = {}
	local childCount = matItemPet.transform.childCount - 1

	for i = 0, childCount do
		local go = matItemPet.transform:GetChild(i).gameObject

		if not validNodes[go.name] then
			table.insert(destroyGos, go)
		end
	end

	for i = 1, #destroyGos do
		goutil.destroy(destroyGos[i])
	end

	local unkownQuality = goutil.findChild(matGo, "unkownQuality")
	local addNode = goutil.findChild(matGo, "add")
	local btton = goutil.findChild(matGo, "Button")

	unkownQuality.transform:SetParent(matItemPet.transform)
	addNode.transform:SetParent(matItemPet.transform)
	unkownQuality.transform:SetAsFirstSibling()
	addNode.transform:SetAsLastSibling()
	btton.transform:SetAsLastSibling()
end

function WisdomAltarView:_initMatExtItem()
	self._matExtItem = self:getGo("lunpan/matNode/matExt")
end

function WisdomAltarView:_initAwakenConditions()
	local parent = self:getGo("lunpan/nameNode/conditions")

	self._conditions = {}

	for i = 1, 2 do
		local condition = {}

		condition.target = goutil.findChild(parent, "condition_" .. i)
		condition.textCondition = goutil.findChildTextComponent(condition.target, "txt_condition")
		condition.textState = goutil.findChildTextComponent(condition.target, "txt_state")
		condition.textColorChange = goutil.findChildComponent(condition.target, "imgState", typeof(UIImageColorChange))

		table.insert(self._conditions, condition)
	end
end

function WisdomAltarView:bindEvents()
	self._btnUpGrade:AddClickListener(self._onClickUpGrade, self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnOneStarUp:AddClickListener(self._onClickOneStartUp, self)
	self._btnDraw:AddClickListener(self._onClickDraw, self)
	self._btnChallenge:AddClickListener(self._onClickChallenge, self)
	self._btnHelp:AddClickListener(self._onClickHelp, self)
	self._dropdown:AddOnValueChanged(self._onValueChanged, self)

	for k, v in pairs(self._racesTypes) do
		v:AddClickListener(function()
			self:_refreshPetList(k)
		end)
	end

	self._btnDetail:AddClickListener(self._onClickDetail, self)
end

function WisdomAltarView:unbindEvents()
	self._btnHelp:RemoveClickListener()
	self._btnUpGrade:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnOneStarUp:RemoveClickListener()
	self._btnDraw:RemoveClickListener()
	self._btnChallenge:RemoveClickListener()
	self._dropdown:RemoveOnValueChanged()

	for k, v in pairs(self._racesTypes) do
		v:RemoveClickListener()
	end

	self._btnDetail:RemoveClickListener()
end

function WisdomAltarView:_onClickDraw()
	FuncOpenController.instance:openFunc(43)
end

function WisdomAltarView:_onClickChallenge()
	FuncOpenController.instance:openFunc(99)
end

function WisdomAltarView:onEnter()
	WisdomAltarView.super.onEnter(self)
	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, {
		{
			showAdd = false,
			id = GameEnum.GoldType.Coin
		}
	})
	WisdomAltarModel.instance:recordPetsInfos()
	self:_updateOneStartUp()
	self._tableview:RegisterCallback(self._numInView, nil, self._cellAtIndex, self)
	self._tableview:RegisterUpdateCellCallback(self._onCellUpdate)
	self._tableview:RegisterReloadFinishCallback(self._onReloadFinish)
	self:_cancelCard()

	local petMo = WisdomAltarModel.instance:getCurPet()

	if petMo ~= nil then
		self._needLocation = true

		WisdomAltarModel.instance:setCurPet(nil)
		self:_selectCard(petMo)
	end

	self._dropdown:SetValue(0)
	self:_refreshPetList()
	GlobalDispatcher:addListener(PetAgent.PM_BatchPetAwakenRes, self._onBatchPetAwakenRes, self, NotifyPriority.High)
end

function WisdomAltarView:_onReloadFinish()
	if self._needLocation then
		self._needLocation = false

		self:_locateSelCard(nil, false)
	end
end

function WisdomAltarView:onExit()
	self._tableview:UnRegisterAllCallbacks()
	GlobalDispatcher:removeListener(PetAgent.PM_BatchPetAwakenRes, self._onBatchPetAwakenRes, self, NotifyPriority.High)
	WisdomAltarView.super.onExit(self)
	GuideController.instance:setViewVar("bag_petmo_list", nil)
end

function WisdomAltarView:onExitFinished()
	WisdomAltarView.super.onExitFinished(self)
	self:_clearStatus()
	self:_clearAllFlyMats()

	if self._tempCardData then
		ItemPet.Remove(self._tempCardNode)

		self._tempCardData = nil
	end

	if self._curCardData then
		ItemPet.Remove(self._cardNode)

		self._curCardData = nil
	end

	self._tableview:Travel(function(cell)
		local iconParent = goutil.findChild(cell.gameObject, "Icon")

		MaterialMgr.resetAll(iconParent)
	end, nil)

	self._lastFilterRace = nil
	self._lastFilterAwakenType = nil

	WisdomAltarModel.instance:clearPetsInfos()
end

function WisdomAltarView:_onValueChanged(value)
	if self._lastFilterAwakenType ~= value then
		self:_refreshPetList(nil, value)
	end
end

function WisdomAltarView:_refreshPetList(race, awakenType)
	race = race or self._lastFilterRace
	awakenType = awakenType or self._lastFilterAwakenType
	self._lastFilterRace = race
	self._lastFilterAwakenType = awakenType
	self._curViewDatas = {}

	local pets = BagPetsController.instance:getBagPets()

	for k, v in pairs(pets) do
		local cfg = CharacterConfig.instance:getPetCo(v.raceId)

		if checknumber(cfg.awakenCostStrategyId) >= 0 and self:_onFilterPetRace(race, v) and self:_onFilterPetAwakenType(awakenType, v) then
			self._curViewDatas[#self._curViewDatas + 1] = v
		end
	end

	self:_sortPetsList()
	self._nonSprite:SetActive(#self._curViewDatas == 0)

	if #self._curViewDatas == 0 then
		self:_updateEmptyTips(awakenType)
	end

	local itemCfgs = ItemConfig.instance:getAwakenItemExtCfgs()

	for i = 1, #itemCfgs do
		local matId = itemCfgs[i].id
		local matNum = MaterialModel.instance:getMaterialsNumber(MatType.Item, matId)

		table.insert(self._curViewDatas, i, matId)
	end

	race = race or 0

	local attrBtn = self._racesTypes[race]

	self._attrSelected.transform.position = attrBtn.transform.position

	if race == 0 then
		local x, y, z = Framework.TransformUtil.GetLocalPos(self._attrSelected.transform, 0, 0, 0)

		x = x - 1
		y = y + 1.3

		Framework.TransformUtil.SetLocalPos(self._attrSelected.transform, x, y, z)
	end

	self._tableview:ReloadData()
	GuideController.instance:setViewVar("bag_petmo_list", self._curViewDatas)
end

function WisdomAltarView:_updateEmptyTips(awakenType)
	local tips = ""

	if awakenType == GameEnum.PetAwakenType.UpStar then
		tips = "没有可升星的精灵"
	elseif awakenType == GameEnum.PetAwakenType.UpRare then
		tips = "没有可进行品质突破的超能精灵"
	elseif awakenType == GameEnum.PetAwakenType.UpRareUtl then
		tips = "没有可进行神启试炼的传说精灵"
	elseif awakenType == GameEnum.PetAwakenType.UpSun then
		tips = "没有可进行神启进阶的传说精灵"
	end

	self._textNon.text = tips
end

function WisdomAltarView:_sortPetsList()
	local function sort_func_common(x, y)
		if x == y then
			return false
		end

		local xAwakable = WisdomAltarModel.instance:isPetAwakable(x)
		local yAwakable = WisdomAltarModel.instance:isPetAwakable(y)

		if xAwakable and not yAwakable then
			return true
		end

		if yAwakable and not xAwakable then
			return false
		end

		return WisdomAltarModel.sortPetsFunc(x, y)
	end

	table.sort(self._curViewDatas, sort_func_common)
end

function WisdomAltarView:_onFilterPetRace(race, data)
	if not race or race == 0 then
		return true
	end

	return PetSkinConfig.instance:checkHasEleAttr(data.curFaceId, race)
end

function WisdomAltarView:_onFilterPetAwakenType(awakenType, data)
	if not awakenType or awakenType == 0 then
		return true
	end

	return awakenType == CharacterConfig.instance:getPetAwakenType(data.raceId, data.awakenLv)
end

function WisdomAltarView:_numInView()
	if not self._curViewDatas then
		return 0
	end

	return #self._curViewDatas
end

function WisdomAltarView:_cellAtIndex(view, idx)
	local cell = view:DequeueCell()

	if not cell then
		cell = view:AddChild(self._tableCell)

		local component = WisdomCardItem.AddOnce(cell.gameObject)
		local btnCell = Framework.ButtonAdapter.GetFrom(cell.gameObject, "top")
		local btnReduce = Framework.ButtonAdapter.GetFrom(cell.gameObject, "reduceBtn")

		btnCell:AddClickListener(function()
			self:_onClickCard(component)
		end)
		btnReduce:AddClickListener(function()
			self:_onClickReduce(component)
		end)
	end

	local data = self._curViewDatas[idx + 1]

	cell.data = idx + 1
	cell.index = idx

	self:_updateCell(view, cell, data)

	return cell
end

function WisdomAltarView:_onCellUpdate(view, cell)
	local idx = cell.index
	local data = self._curViewDatas[idx + 1]

	cell.data = idx + 1

	self:_updateCell(view, cell, data)
end

function WisdomAltarView:_updateCell(view, cell, data)
	self:_stopTweenMaterial(cell.gameObject)

	local component = WisdomCardItem.AddOnce(cell.gameObject)

	component:onSetMo(data)
	component:setStatus(self._selectedPetId, self._isMaterial, self.getMaterialSelectedNum, self, self:_getHasEmptyMatSlot())
end

function WisdomAltarView:_onClickReduce(component)
	print("click reduceBtn")
	self:_onSelectMaterial(component:getData(), component:getTarget(), true)
end

function WisdomAltarView:_onClickCard(component)
	local isPet = component:getIsPet()
	local data = component:getData()
	local target = component:getTarget()

	if not isPet then
		local matNum = MaterialModel.instance:getMaterialsNumber(MatType.Item, data)

		if matNum == 0 and (not self._selectedPetId or self:_isMaterial(data)) then
			MaterialMgr.openGetSource(MatType.Item, data)
		elseif not self._selectedPetId then
			local itemExtCfg = ItemConfig.instance:getAwakenItemExtCfgById(data)
			local lvText = CharacterConfig.instance:getAwakenLvText(itemExtCfg.level)
			local content

			FloatWordMgr.instance:show(itemExtCfg.isSameRace and string.format("该物品只可作为<color=#ebad32>%s同名</color>精灵替代材料被使用", lvText) or string.format("该物品只可作为<color=#ebad32>%s%s属性</color>精灵替代材料被使用", lvText, itemExtCfg.attr))
		else
			self:_onSelectMaterial(data, target)
		end
	elseif self._selectedPetId == data.petId then
		self:_cancelCard()
		self._tableview:Refresh()
	elseif not self._selectedPetId then
		self:_selectCard(data, target)
		self._tableview:Refresh()
	else
		self:_onSelectMaterial(data, target)
	end
end

function WisdomAltarView:_locateSelCard(matData, tween)
	local hasMaterial = false
	local idx

	if matData == nil and self._materials then
		matData = self._materials[1]
	end

	if matData == nil then
		return
	end

	for k, v in ipairs(self._curViewDatas) do
		if not self:_isMaterialSelected(v) and WisdomAltarModel.instance:isMaterialByMatAndData(matData, v) and v ~= self._curCardData:GetData() and self:_getLeftNum(v) > 0 then
			hasMaterial = true
			idx = k

			break
		end
	end

	if idx then
		self._tableview:MoveCellToCebter(idx)

		if tween == true or tween == nil then
			self:_tweenViewPortMats(matData)
		end
	end

	return hasMaterial
end

function WisdomAltarView:_getLeftNum(data)
	local selNum = self:getMaterialSelectedNum(data)

	if type(data) ~= "table" then
		return MaterialModel.instance:getMaterialsNumber(MatType.Item, data) - selNum
	else
		return 1 - selNum
	end
end

function WisdomAltarView:_onClickMaterial(i)
	local matData = self._materials[i]
	local hasMaterial

	if matData.petData then
		self:_calcelMaterial(matData.petData, i)
		self:_updateMaterials()
		self._tableview:Refresh()

		hasMaterial = true
	end

	hasMaterial = hasMaterial or self:_tweenViewPortMats(matData)
	hasMaterial = hasMaterial or self:_locateSelCard(matData)

	if not hasMaterial then
		local raceId = matData.raceId

		raceId = raceId or self._curCardData:GetData().raceId

		local petCo = CharacterConfig.instance:getPetCo(raceId)

		FloatWordMgr.instance:show("当前所需材料不足，" .. self:_getPetSelectTitle(petCo))
	end
end

function WisdomAltarView:_tweenViewPortMats(matData)
	local hasMaterial = false
	local cellsNum = self._tableview:GetVisibleCount()

	for idx = 0, cellsNum - 1 do
		local cell = self._tableview:GetCellByIndex(idx)
		local petData = self._curViewDatas[cell.index + 1]

		if WisdomAltarModel.instance:isMaterialByMatAndData(matData, petData) and petData ~= self._curCardData:GetData() and self:_getLeftNum(petData) > 0 then
			hasMaterial = true

			self:_tweenMaterial(cell.gameObject)
		end
	end

	return hasMaterial
end

function WisdomAltarView:_tweenMaterial(gameObject)
	self:_stopTweenMaterial(gameObject)

	UnityTweens.TweenScale.Create(gameObject, Vector3.New(1, 1, 1), Vector3.New(1.1, 1.1, 1.1), 0.1).autoDestroy = true

	local scaleTween = UnityTweens.TweenScale.StartTween(gameObject, Vector3.New(1.1, 1.1, 1.1), Vector3.New(1, 1, 1), 0.1, UnityTweens.EaseType.linear, 0.1)

	scaleTween.autoDestroy = true
end

function WisdomAltarView:_stopTweenMaterial(gameObject)
	UnityTweens.TweenBase.DestroyAllByType(gameObject, UnityTweensType.TweenScale)
	Framework.TransformUtil.SetLocalScale(gameObject.transform, 1, 1, 1)
end

function WisdomAltarView:_selectCard(data, target)
	print(">>>>>>>>>>>>>>>>> 精灵已经满星", data.raceId)

	self._costCfg = self:_getConfigs(data)

	if not self._costCfg then
		FloatWordMgr.instance:show("精灵已经满星")

		return
	end

	self._selectedPetId = data.petId

	self:_fillSelectCard(data)
	self:_prepareMaterials(data)
	self:_updateMaterials()
	self:_updateCost()

	local destPos = self._cardNode.transform.position

	if target == nil then
		self._tempCardNode.transform.position = destPos

		self:_onTweenFinished(true)
	else
		local startPos = target.transform.position
		local len = Vector3.Distance(startPos, destPos)
		local tween = UnityTweens.TweenPosition.StartTween(self._tempCardNode, startPos, destPos, len / 5, UnityTweens.EaseType.linear, 0, UnityTweens.CoordSpace.World)

		tween:AddListener(self._onTweenFinished, self)
		self._tempCardNode:SetActive(true)
	end

	local petCo = CharacterConfig.instance:getPetCo(data.raceId)

	self._cardName.text = petCo.name

	self._nameNode:SetActive(true)
end

function WisdomAltarView:_onTweenFinished(force)
	self._cardNode:SetActive(true)
	self._tempCardNode:SetActive(false)
	self._btnUpGrade.gameObject:SetActive(true)
	self._matNode.gameObject:SetActive(true)
	self._txtMaterialTips.gameObject:SetActive(true)
	self._textCost.gameObject:SetActive(true)
	self._costIcon:SetActive(true)
	Framework.TransformUtil.SetLocalScale(self._cardNode.transform, 1, 1, 1)

	if force then
		Framework.TransformUtil.SetLocalScale(self._cardNode.transform, 1.1, 1.1, 1.1)
	else
		UnityTweens.TweenScale.StartTween(self._cardNode, Vector3.New(1, 1, 1), Vector3.New(1.1, 1.1, 1.1), 0.1)
	end
end

function WisdomAltarView:_onSelectMaterial(data, target, isReduce)
	local isPet = type(data) == "table"

	if self:_isMaterialSelected(data) and (isPet or isReduce) then
		self:_calcelMaterial(data)
		self:_updateMaterials()
		self._tableview:Refresh()

		return
	end

	local index = self:_getSelMaterialIndex(data)

	if index then
		if not isPet then
			local leftNum = MaterialModel.instance:getMaterialsNumber(MatType.Item, data) - self:getMaterialSelectedNum(data)

			if leftNum <= 0 then
				MaterialMgr.openGetSource(MatType.Item, data)

				return
			end
		end

		self._materials[index].petData = data

		self:_doSelectMaterial(data, target, index)
	elseif self:_isMaterial(data) then
		FloatWordMgr.instance:show("升星材料已足够，无需再放入")
	else
		local petCo = CharacterConfig.instance:getPetCo(self._curCardData:GetData().raceId)

		FloatWordMgr.instance:show(self:_getPetSelectTitle(petCo))
	end
end

function WisdomAltarView:_doSelectMaterial(data, target, index)
	local cacheItem

	if self._flyItemsCache and #self._flyItemsCache > 0 then
		cacheItem = self._flyItemsCache[1]

		table.remove(self._flyItemsCache, 1)
	end

	if not cacheItem then
		local go = goutil.cloneAndSetParent(self._matFlyItem, self._matFlyItem.transform.parent)

		cacheItem = WisdomCardItem.AddOnce(go)

		cacheItem:setNum(1)
	end

	cacheItem:onSetMo(data)
	self:_doFlyMat(data, target, cacheItem, index)
end

function WisdomAltarView:_doFlyMat(data, target, cacheItem, index)
	local itemGo = cacheItem:getTarget()

	itemGo:SetActive(true)

	self._flyingMats = self._flyingMats or {}
	self._flyingMats[data] = cacheItem

	local goStart = self._matLayout.transform:GetChild(index - 1).gameObject
	local mat = goutil.findChild(goStart, "mat")
	local default = goutil.findChild(goStart, "default")

	mat:SetActive(false)
	default:SetActive(true)

	local cellGo = target
	local tween = UnityTweens.TweenPosition.StartTween(itemGo, cellGo.transform.position, goStart.transform.position, 0.3, UnityTweens.EaseType.linear, 0, UnityTweens.CoordSpace.World)

	tween:AddListener(function()
		self:_updateMaterials()

		local idx = cellGo:GetComponentInParent(typeof(UITableviewCell)).index

		self._tableview:UpdateCellAtIndex(idx)
		self:_cancelFlyingMat(data)
		itemGo:SetActive(false)
		mat:SetActive(true)
		default:SetActive(false)
	end)
end

function WisdomAltarView:_clearAllFlyingMats()
	if self._flyingMats then
		for k, v in pairs(self._flyingMats) do
			self._flyItemsCache = self._flyItemsCache or {}

			local itemGo = v:getTarget()

			itemGo:SetActive(false)
			table.insert(self._flyItemsCache, v)
		end

		self._flyingMats = nil
	end
end

function WisdomAltarView:_clearAllFlyMats()
	self:_clearAllFlyingMats()

	if self._flyItemsCache then
		for i = 1, #self._flyItemsCache do
			WisdomCardItem.Remove(self._flyItemsCache[i]:getTarget())
		end

		self._flyItemsCache = nil
	end
end

function WisdomAltarView:_cancelFlyingMat(data)
	if self._flyingMats then
		local itemPet = self._flyingMats[data]

		if itemPet then
			self._flyItemsCache = self._flyItemsCache or {}

			local itemGo = itemPet:getTarget()

			itemGo:SetActive(false)
			table.insert(self._flyItemsCache, itemPet)

			self._flyingMats[data] = nil
		end
	end
end

function WisdomAltarView:_fillSelectCard(data)
	self._tempCardData = self._tempCardData or ItemPet.AddOnce(self._tempCardNode)
	self._curCardData = self._curCardData or ItemPet.AddOnce(self._cardNode)

	self._tempCardData:Init(data)
	self._tempCardData:setSelected(false)
	self._tempCardData:SetInTeam(false)
	self._tempCardData:setGray(false)
	self._tempCardData:setUseLock(false)
	self._curCardData:Init(data)
	self._curCardData:setSelected(false)
	self._curCardData:SetInTeam(false)
	self._curCardData:setGray(false)
	self._curCardData:setUseLock(false)
	self._curCardData:removeAllListener(ItemPet.Events.Click)
	self._curCardData:addListener(ItemPet.Events.Click, function(data)
		self:_cancelCard()
		self._tableview:Refresh()
	end)
	self:_updateRare(data)
	self:_updateAwakenTypeText(data)
	self:_updateConditions(data)

	local awakenType = CharacterConfig.instance:getPetAwakenType(data.raceId, data.awakenLv)
	local awakenRareCfg = CharacterConfig.instance:getAwakenRareCfg(data.awakenLv + 1)

	self._txtAwakenTips.text = awakenType == GameEnum.PetAwakenType.UpRareUtl and "通过神启试炼，进阶到神启境界" or awakenType == GameEnum.PetAwakenType.UpRare and "通过品质突破，突破到" .. ConstString.PetRareLang[awakenRareCfg.rare] or string.format("通过%s，%s到%s", ConstString.PetAwakeUpTitle[awakenType], ConstString.PetAwakenTypeText[awakenType], awakenRareCfg.name)
end

function WisdomAltarView:_getConfigs(data)
	local cfg = CharacterConfig.instance:getPetCo(data.raceId)
	local awakenLv = data.awakeLevel

	return CharacterConfig.instance:getPetAwakenCostCfg(cfg.awakenCostStrategyId, awakenLv + 1)
end

function WisdomAltarView:_isMax(data)
	return self:_getConfigs(data) == nil
end

function WisdomAltarView:_prepareMaterials(data)
	self:_clearMaterials()

	self._materials = WisdomAltarModel.instance:getMaterials(data)
end

function WisdomAltarView:_clearMaterials()
	if not self._materials then
		return
	end

	for i = 1, #self._materials do
		local go = self._matLayout.transform:GetChild(i - 1).gameObject
		local mat = goutil.findChild(go, "mat")
		local defaultIcon = goutil.findChild(go, "default/ImgC_HeadIcon/con")
		local bagBg = defaultIcon:GetComponent(typeof(Framework.ImageBigBG))

		if bagBg then
			bagBg:ClearImage()
		end

		WisdomCardItem.Remove(mat)
	end

	self._materials = nil

	print("_getSelMaterialIndex _clearMaterials")
	MaterialMgr.resetAll(self._matExtItem)
end

function WisdomAltarView:_isMaterial(data)
	if not self._materials then
		return false
	end

	for i = 1, #self._materials do
		if WisdomAltarModel.instance:isMaterialByMatAndData(self._materials[i], data) then
			return true
		end
	end

	return false
end

function WisdomAltarView:_getSelMaterialIndex(data)
	if not self._materials then
		return
	end

	for i = 1, #self._materials do
		if not self._materials[i].petData and WisdomAltarModel.instance:isMaterialByMatAndData(self._materials[i], data) then
			return i
		end
	end
end

function WisdomAltarView:_getHasEmptyMatSlot()
	if not self._materials then
		return
	end

	for i = 1, #self._materials do
		if not self._materials[i].petData then
			return true
		end
	end

	return false
end

function WisdomAltarView:_isMaterialSelected(data)
	return self:getMaterialSelectedNum(data) > 0
end

function WisdomAltarView:getMaterialSelectedNum(data)
	if not self._materials then
		return 0
	end

	local count = 0

	for i = 1, #self._materials do
		if self._materials[i].petData == data then
			count = count + 1
		end
	end

	return count
end

function WisdomAltarView:_calcelMaterial(data, i)
	if not self._materials then
		return
	end

	if i then
		self._materials[i].petData = nil

		self:_cancelFlyingMat(data)
	else
		for i = 1, #self._materials do
			if self._materials[i].petData == data then
				self._materials[i].petData = nil

				self:_cancelFlyingMat(data)

				return
			end
		end
	end
end

function WisdomAltarView:_updateMaterials()
	local cnt = 0

	if self._materials then
		cnt = #self._materials
	end

	local childCount = self._matLayout.transform.childCount

	while childCount < cnt do
		childCount = childCount + 1

		local child = self._matLayout.transform:GetChild(0).gameObject

		UGUIToolHelper.AddChild(self._matLayout.gameObject, child)
	end

	local tag = 1

	if self._curCardData then
		local mo = self._curCardData:GetData()

		tag = self:_getCardTag(mo)
	end

	for i = 1, cnt do
		local matData = self._materials[i]
		local go = self._matLayout.transform:GetChild(i - 1).gameObject

		go:SetActive(true)

		local mat = goutil.findChild(go, "mat")
		local defaultNode = goutil.findChild(go, "default")
		local defaultIcon = goutil.findChild(go, "default/ImgC_HeadIcon/con")
		local bagBg = defaultIcon:GetComponent(typeof(Framework.ImageBigBG))
		local button = Framework.UIClickTrigger.Get(goutil.findChild(go, "Button"))
		local imgTagColorChange = goutil.findChildComponent(go, "Img_Tag", "UIImageColorChange")
		local txtTag = goutil.findChildTextComponent(imgTagColorChange.gameObject, "Text")

		txtTag.text = ConstString.AwakenCardTagTitle[tag]

		imgTagColorChange:SetState(tag - 1)

		if bagBg then
			bagBg:ClearImage()
		end

		mat:SetActive(matData.petData ~= nil)

		if matData.petData then
			local itemPet = WisdomCardItem.AddOnce(mat)

			itemPet:onSetMo(matData.petData)
			itemPet:setNum(0)
			defaultNode:SetActive(false)
		else
			defaultNode:SetActive(true)
			self:_fillEmptyMaterial(defaultNode, matData)
		end

		button:RemoveClickListener()
		button:AddClickListener(function()
			self:_onClickMaterial(i)
		end)
	end

	for i = cnt + 1, childCount do
		local go = self._matLayout.transform:GetChild(i - 1).gameObject

		go:SetActive(false)
	end

	local curParent = self._matExtItem.transform.parent

	goutil.setActive(self._matExtItem, false)

	if self._costCfg then
		local matStr = self._costCfg.extCostItem
		local arr = string.split(matStr, ":")
		local matType = checknumber(arr[1])
		local matId = checknumber(arr[2])
		local matNum = checknumber(arr[3])
		local curMatNum = MaterialModel.instance:getMaterialsNumber(matType, matId)

		if not string.nilorempty(matStr) then
			goutil.setActive(self._matExtItem, true)

			local proxy = MaterialMgr.setCellByCfg(matStr, self._matExtItem)

			proxy:setCallBack(function()
				self:_onClickMatExt(matStr)
			end)
			proxy:setGray(false)

			local color = matNum <= curMatNum and "00FF00" or "ff0000"
			local numStr = string.format("<color=#%s>%s</color>/%s", color, curMatNum, matNum)

			if curMatNum < matNum then
				proxy:setGray(true)
			end

			proxy:setNumStr(numStr)
			proxy:setAutoTips(false)
			proxy:setCallBack(function()
				MaterialMgr.openGetSource(matType, matId)
			end)
			goutil.addChildToParent(self._matExtItem, self._matLayout)
			Framework.TransformUtil.SetLocalScale(self._matExtItem.transform, 1, 1, 1)
			Framework.TransformUtil.SetLocalRotation(self._matExtItem.transform, 0, 0, 0)
			self._matExtItem.transform:SetAsFirstSibling()
		end
	end

	self._matLayout:Layout()

	local x, y, z = Framework.TransformUtil.GetPos(self._matExtItem.transform, 0, 0, 0)

	goutil.addChildToParent(self._matExtItem, curParent)
	self._matExtItem.transform:SetAsLastSibling()
	Framework.TransformUtil.SetPos(self._matExtItem.transform, x, y, z)
end

function WisdomAltarView:_onClickMatExt(matStr)
	print("click matStr = " .. matStr)
end

function WisdomAltarView:_updateCost()
	local raceId = self._curCardData:GetData().raceId
	local petCo = CharacterConfig.instance:getPetCo(raceId)

	self._txtMaterialTips.text = self:_getPetSelectTitle(petCo)
	self._textCost.text = self._costCfg.needCoinNum
end

function WisdomAltarView:_updateAwakenTypeText(data)
	local awakenType = CharacterConfig.instance:getPetAwakenType(data.raceId, data.awakenLv)
	local text = ConstString.PetAwakenTypeText[awakenType]

	if text then
		self._textUpGrade.text = text

		goutil.setActive(self._textTips.gameObject, true)

		self._textTips.text = "点击添加材料进行" .. text
	else
		self._textUpGrade.text = ""

		goutil.setActive(self._textTips.gameObject, false)
	end

	goutil.setActive(self._awakenTips, true)
end

function WisdomAltarView:_updateConditions(data)
	local cfg = self:_getConfigs(data)
	local i = 1

	self._conditionReached = true
	self._conditionRealReached = true

	if cfg and cfg.trialCondition then
		for k, v in pairs(cfg.trialCondition) do
			local condition = self._conditions[i]

			goutil.setActive(self._conditions[i].target, true)

			if condition then
				i = i + 1

				local isReached = true

				if k == "PetLv" then
					isReached = v <= data.curLv
					isRealReached = v <= data:getOriginLevel()
					condition.textCondition.text = string.format("等级达到%s级", v)
				elseif k == "TalentLv" then
					isReached = v <= data.talentLevel
					isRealReached = v <= data:getOriginTalentLv()

					local talentCfg = CharacterConfig.instance:getPetTalentCfg(data.raceId, v)

					condition.textCondition.text = string.format("天赋达到%s", talentCfg.talentName)
				end

				condition.textState.text = isReached and "完成" or "未完成"

				condition.textColorChange:SetState(isReached and 1 or 0)

				self._conditionReached = self._conditionReached and isReached
				self._conditionRealReached = self._conditionRealReached and isRealReached
			end
		end
	end

	while i <= #self._conditions do
		goutil.setActive(self._conditions[i].target, false)

		i = i + 1
	end
end

function WisdomAltarView:_updateRare(data)
	local awakenType = CharacterConfig.instance:getPetAwakenType(data.raceId, data.awakenLv)
	local isUpRare = awakenType == GameEnum.PetAwakenType.UpRare

	goutil.setActive(self._quality, not isUpRare)
	goutil.setActive(self._rare, isUpRare)

	local rareCfg = CharacterConfig.instance:getAwakenRareCfg(data.awakenLv)

	if rareCfg then
		if not rareCfg.rare then
			local curRare = 1

			if awakenType == GameEnum.PetAwakenType.UpRare then
				local proxy = MaterialMgr.setCell(MatType.Rare, data.raceId, self._leftRare)

				proxy.binder:setRare(curRare)

				proxy = MaterialMgr.setCell(MatType.Rare, data.raceId, self._rightRare)

				proxy.binder:setRare(curRare + 1)
			else
				local proxy = MaterialMgr.setCell(MatType.Rare, data.raceId, self._quality)

				proxy.binder:setRare(curRare)
			end
		end
	end
end

function WisdomAltarView:_fillEmptyMaterial(defaultNode, matData)
	local headIcon = goutil.findChild(defaultNode, "ImgC_HeadIcon/con")
	local attrGo = goutil.findChild(defaultNode, "Nego_Attr")
	local attrIcon = goutil.findChild(defaultNode, "Nego_Attr/Img_attr"):GetComponent(UIImageSpriteChange)
	local imgBg = goutil.findChild(defaultNode, "ImgC_Bg"):GetComponent(UIImageSpriteChange)
	local unkownQuality = goutil.findChild(defaultNode, "unkownQuality")

	if matData.raceId and matData.raceId ~= 0 then
		local petCo = CharacterConfig.instance:getPetCo(matData.raceId)
		local modelCo = CharacterConfig.instance:getModelCo(checknumber(petCo.faceIds))

		uGuiUtil.setSpriteToImage(headIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getCharacterIconUrl(modelCo.headName))
		GameUtil.SetGray(headIcon, true)
		GameUtil.SetGray(imgBg, true)
	else
		GameUtil.SetGray(headIcon, false)
		uGuiUtil.setSpriteToImage(headIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getCharacterIconUrl("icon_pet_unkown"))
	end

	local starItem = PetStarItem.New(goutil.findChild(defaultNode, "stars"), true)

	starItem:updateStar(matData.star)
	attrGo.gameObject:SetActive(false)
	unkownQuality:SetActive(false)
	imgBg.gameObject:SetActive(false)

	if matData.race then
		attrGo.gameObject:SetActive(true)

		local race = math.fmod(matData.race, 10)
		local targetValue = race - 1

		attrIcon:SetState(targetValue)
	end

	if matData.rare then
		imgBg.gameObject:SetActive(true)
		imgBg:SetState(matData.rare + 1)
	else
		unkownQuality:SetActive(true)
	end
end

function WisdomAltarView:_cancelCard()
	self:_clearStatus()
	self:_clearMaterials()
	self:_updateMaterials()
end

function WisdomAltarView:_clearStatus()
	self._materials = nil

	print(debug.traceback())
	print("_getSelMaterialIndex _clearMaterials")

	self._costCfg = nil
	self._selectedPetId = nil

	MaterialMgr.resetAll(self._quality)
	MaterialMgr.resetAll(self._leftRare)
	MaterialMgr.resetAll(self._rightRare)
	self._textCost.gameObject:SetActive(false)
	self._costIcon:SetActive(false)
	self._cardNode:SetActive(false)
	self._tempCardNode:SetActive(false)
	self._matNode.gameObject:SetActive(false)
	self._txtMaterialTips.gameObject:SetActive(false)
	self._btnUpGrade.gameObject:SetActive(false)
	self._nameNode:SetActive(false)
	self:_clearAllFlyingMats()

	self._textUpGrade.text = ""

	goutil.setActive(self._textTips.gameObject, false)
end

function WisdomAltarView:_updateOneStartUp()
	local mode = WisdomAltarModel.instance:getCurOneMode()
	local wisCo = WisdomAltarConfig.instance:getWisdomaltarCo(mode or 0)

	if not wisCo then
		self._btnOneStarUp.gameObject:SetActive(false)
	else
		self._btnOneStarUp.gameObject:SetActive(true)

		self._oneName.text = wisCo.name
	end
end

function WisdomAltarView:_onClickClose()
	self:close()
end

function WisdomAltarView:_onClickUpGrade()
	if not self._conditionRealReached then
		if self._conditionReached then
			FloatWordMgr.instance:show("不可通过力量水晶的精灵共鸣来达到试炼条件喔。")
		else
			FloatWordMgr.instance:show("请先完成全部的试炼条件。")
		end

		return
	end

	self._mo = BagPetsController.instance:getPet(self._selectedPetId)
	self._selectedPetIds = {}
	self._usedItemIds = {}

	if self._materials then
		for i = 1, #self._materials do
			local petData = self._materials[i].petData

			if petData then
				if type(self._materials[i].petData) == "table" then
					table.insert(self._selectedPetIds, self._materials[i].petData.petId)
				else
					table.insert(self._usedItemIds, self._materials[i].petData)
				end
			end
		end
	end

	self:startAwake()
end

function WisdomAltarView:_onClickOneStartUp()
	ViewMgr.instance:open(ViewName.WisdomAltarOneView)
end

function WisdomAltarView:_onClickHelp()
	ViewMgr.instance:open(ViewName.RulesView, "wisdomaltar")
end

function WisdomAltarView:_onAwakeSuccess(msg)
	WisdomAltarView.super._onAwakeSuccess(self, msg)
	self._dropdown:RemoveOnValueChanged()
	self._dropdown:SetValue(0)
	self._dropdown:AddOnValueChanged(self._onValueChanged, self)
	WisdomAltarModel.instance:recordPetsInfos()

	local data = self._mo

	self._costCfg = self:_getConfigs(data)

	if self._costCfg then
		self:_prepareMaterials(data)
		self:_fillSelectCard(data)
		self:_updateMaterials()
		self:_updateCost()
		self:_refreshPetList(nil, 0)
	else
		self:_cancelCard()
		self:_refreshPetList(nil, 0)
	end

	self:_updateOneStartUp()
end

function WisdomAltarView:_onBatchPetAwakenRes(status, msg)
	if status == 0 then
		WisdomAltarModel.instance:recordPetsInfos()
		self:_cancelCard()
		self:_refreshPetList()
		self:_updateOneStartUp()
	end
end

function WisdomAltarView:_onClickDetail()
	if self._selectedPetId then
		local petMo = BagPetsController.instance:getPet(self._selectedPetId)

		UIStateManager.instance:open(ViewName.PetAwakeListView, petMo)
	end
end

return WisdomAltarView
