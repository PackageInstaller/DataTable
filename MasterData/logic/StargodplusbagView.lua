-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/stargodplus/view/StargodplusbagView.lua

module("logic.extensions.stargodplus.view.StargodplusbagView", package.seeall)

local StargodplusbagView = class("StargodplusbagView", TableViewComponent)
local QUILITY_RED = 5

function StargodplusbagView:ctor()
	StargodplusbagView.super.ctor(self)
end

function StargodplusbagView:buildUI()
	StargodplusbagView.super.buildUI(self)

	self._clostBtn = self:getBtn("clostBtn")
	self._filterBtn = self:getBtn("filterBtn")
	self._showAllBtn = self:getBtn("showAllBtn")
	self._okBtn = self:getBtn("rightCon/okBtn")
	self._nexticonGo = self:getGo("leftCon/next/itemcon")
	self._nextGo = self:getGo("leftCon/next")
	self._currGo = self:getGo("leftCon/curr")
	self._curriconGo = self:getGo("leftCon/curr/itemcon")
	self._currnameText = goutil.findChildTextComponent(self.mainGO, "leftCon/curr/nameText")
	self._currnameTextChange = self._currnameText.gameObject:GetComponent(ComponentType.UITextColorChange)
	self._currlvText = goutil.findChildTextComponent(self.mainGO, "leftCon/curr/lvText")
	self._nextnameText = goutil.findChildTextComponent(self.mainGO, "leftCon/next/nameText")
	self._nextlvText = goutil.findChildTextComponent(self.mainGO, "leftCon/next/lvText")
	self._nextnameTextChange = self._nextnameText.gameObject:GetComponent(ComponentType.UITextColorChange)
	self._recommendConGo = self:getGo("leftCon/recommendCon/rect/content")
	self._recommendcellGo = self:getGo("leftCon/recommendCon/cell")
	self._recommendGroup = ItemGroup.New(self._recommendConGo, self._recommendcellGo, nil, nil, true)
	self._emptyTipGo = self:getGo("leftCon/emptyTip")
	self._filterconGo = self:getGo("filtercon")
	self._btnClear = self:getBtn("btnClear")
	self._searchInput = self:getInput("InputC_Search")
	self._showAllBtntext = goutil.findChildTextComponent(self.mainGO, "showAllBtn/text")
	self._currAttrcellGo = self:getGo("leftCon/curr/attrCon/cell")
	self._currAttrConGo = self:getGo("leftCon/curr/attrCon")
	self._nextAttrcellGo = self:getGo("leftCon/next/attrCon/cell")
	self._nextAttrConGo = self:getGo("leftCon/next/attrCon")
	self._currAttrGroup = ItemGroup.New(self._currAttrConGo, self._currAttrcellGo, nil, nil, true)
	self._nextAttrGroup = ItemGroup.New(self._nextAttrConGo, self._nextAttrcellGo, nil, nil, true)
	self._nextEmptipGo = self:getGo("leftCon/nextEmptip")
	self._equipEmptyTipGo = self:getGo("rightCon/emptyTip")
	self._jumpBtnGo = self:getGo("rightCon/emptyTip/jumpBtn")
	self._jumpBtn = self:getBtn("rightCon/emptyTip/jumpBtn")
	self._txtEmpty = self:getTxt("rightCon/emptyTip/text")
	self._txtTips = self:getTxt("rightCon/text")
	self._btnTip = self:getBtn("btnTip")
	self._tableviewBagGo = self:getGo("rightCon/tableviewBag")
	self._tablecellBagGo = self:getGo("rightCon/tablecellBag")
	self._bagScrollerList = ScrollerList.create(self._tableviewBagGo, self._tablecellBagGo, GameUtil.handler(self._updateBagCell, self), GameUtil.handler(self._clearBagCell, self))

	goutil.setActive(self._tableviewBagGo, false)
	goutil.setActive(self._tablecellBagGo, false)

	self._limit = self:getGo("limit")
	self._tipBtn = self:getGo("limit/tipBtn")
	self._txtNum = self:getTxt("limit/txtNum")
end

function StargodplusbagView:bindEvents()
	StargodplusbagView.super.bindEvents(self)
	self._clostBtn:AddClickListener(self._onClickclostBtn, self)
	self._filterBtn:AddClickListener(self._onClickfilterBtn, self)
	self._showAllBtn:AddClickListener(self._onClickshowAllBtn, self)
	self._okBtn:AddClickListener(self._onClickokBtn, self)
	self._btnClear:AddClickListener(self._onClickbtnClear, self)
	self._searchInput:AddOnValueChanged(self._onInputValueChange, self)
	self._jumpBtn:AddClickListener(self._onClickjumpBtn, self)
	self._btnTip:AddClickListener(self._onClickbtnTip, self)
	GameUtil.addClickHandler(self._tipBtn, self._onClickTips, self)
end

function StargodplusbagView:unbindEvents()
	StargodplusbagView.super.unbindEvents(self)
	self._clostBtn:RemoveClickListener()
	self._filterBtn:RemoveClickListener()
	self._showAllBtn:RemoveClickListener()
	self._okBtn:RemoveClickListener()
	self._btnClear:RemoveClickListener()
	self._searchInput:RemoveOnValueChanged()
	self._jumpBtn:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	GameUtil.rmClickHandler(self._tipBtn)
end

function StargodplusbagView:onEnter()
	StargodplusbagView.super.onEnter(self)
	self.addGEvent(self, StargodplusController.On_Select_FilterType, self._updateItems, self)
	self.addGEvent(self, GlobalNotify.OnMaterialGet, self._updateView, self)

	local params = self:getOpenParam()

	self._showAllFiller = false
	self._currSelectFillerId = false
	self._petId = StargodplusModel.instance:getCurrShowPetId()

	local petMo = BagPetsController.instance:getPet(self._petId)

	self._equipSlotDatas = {}

	local tempSlotDatas = petMo:getStarGodPlusSlots()

	for i, v in ipairs(tempSlotDatas) do
		if v.fillerId > 0 then
			self._equipSlotDatas[v.slot] = StargodplusModel.instance:getStarGodMo(v.fillerId)
		end
	end

	self._slotId = params[1]
	self._slotData = params[2]
	self._slotCfg = self._slotData and StargodplusConfig.instance:getFillerCfg(self._slotData.fillerDefineId) or nil
	self._slotLv = self._slotData and StargodplusModel.instance:getSlotLv(self._slotId, self._slotData.exp) or 1
	self._slotFillerId = self._slotData and self._slotData.fillerId

	self:_updateView()
	self:_updateRecommend()
	self:_setShowAllBtnText()
end

function StargodplusbagView:_onClickTips()
	local type = MatType.StarGodPlus

	ItemBagController.instance:showLimitTipsWithType(type)
end

function StargodplusbagView:_showCurrLiitWithType()
	local type = MatType.StarGodPlus
	local cur, total = ItemBagController.instance:getCurrLiitWithType(type)

	self._txtNum.text = cur > total * 0.9 and langPara("<color=#eb4642>%s</color>/%s", cur, total) or langPara("%s/%s", cur, total)
end

function StargodplusbagView:onExit()
	StargodplusbagView.super.onExit(self)
	MaterialMgr.resetAll(self._curriconGo)
	MaterialMgr.resetAll(self._nexticonGo)
	self._recommendGroup:dispose(function(item)
		local icon = goutil.findChild(item.mainGO, "icon")

		MaterialMgr.resetAll(icon)
	end)
	self._bagScrollerList:dispose()
end

function StargodplusbagView:onExitFinished()
	StargodplusbagView.super.onExitFinished(self)
end

function StargodplusbagView:_onClickjumpBtn()
	StargodplusModel.instance:jumpStarGod(self)
end

function StargodplusbagView:_onClickclostBtn()
	self:close()
end

function StargodplusbagView:_onClickfilterBtn()
	self:showTabAt(self._filterconGo, ViewName.StargodplusfilterView)
end

function StargodplusbagView:_onClickshowAllBtn()
	self._showAllFiller = not self._showAllFiller

	self:_setShowAllBtnText()
	self:_updateView()
end

function StargodplusbagView:_onClickbtnTip()
	TipsFacade.instance:openRulesView("stargodplusbagview")
end

function StargodplusbagView:_onClickokBtn()
	if not self._currSelectFillerId then
		FloatWordMgr.instance:show("请选择替换的星神")

		return
	end

	local replaceLeastQuality = 0
	local unloadCostA = ""
	local preContent = ""

	if self._slotData and self._slotData.fillerDefineId then
		local cfg = StargodplusConfig.instance:getFillerCfg(self._slotData.fillerDefineId) or {}

		replaceLeastQuality = checknumber(cfg.replaceLeastQuality)
		unloadCostA = cfg.unloadCost

		if checkbool(cfg.needDestroy) then
			preContent = langPara("【%s】被替换后会<color=#ff0000>销毁</color>，请谨慎操作！\n", self._slotCfg and self._slotCfg.name)
		end

		if cfg.quality == QUILITY_RED then
			TipsFacade.instance:openCommonTips(lang("该星神无法卸下"))

			return
		end
	end

	local mo = StargodplusModel.instance:getStarGodMo(self._currSelectFillerId)

	if mo and replaceLeastQuality > mo:getQuality() then
		TipsFacade.instance:openCommonTips(langPara("星神品质达到%s以上才能替换原有的【%s】", qStr, self._slotCfg and self._slotCfg.name))

		return
	end

	local petMo = BagPetsController.instance:getPet(self._petId)

	if mo:getBindPetId() > 0 and petMo.raceId ~= mo:getBindPetId() then
		TipsFacade.instance:openCommonTips(lang("非绑定精灵不允许穿戴"))

		return
	end

	if not string.nilorempty(mo:getEquipPetChecker()) and FightingPowerFormula.instance:OnFilter(petMo, mo:getEquipPetChecker()) == false then
		TipsFacade.instance:openCommonTips(lang("未满足该星神穿戴条件"))

		return
	end

	local function okFunc()
		StarGodPlusAgent.instance:sendPM_EquipFillerReq(self._petId, self._slotId, self._currSelectFillerId)
		self:close()
	end

	local needReplaceLeastQuality = 0
	local needDestroyB = false
	local isWithBindRace = false
	local unloadCostB = ""

	if mo then
		local cfg = StargodplusConfig.instance:getFillerCfg(mo:getDefineId()) or {}

		needDestroyB = checkbool(cfg.needDestroy)
		needReplaceLeastQuality = checknumber(cfg.replaceLeastQuality)
		isWithBindRace = checkbool(cfg.bindRace)
		unloadCostB = cfg.unloadCost
	end

	if mo:getUsePetId() > 0 then
		if needDestroyB then
			local petMo1 = BagPetsController.instance:getPet(mo:getUsePetId())

			TipsFacade.instance:openCommonTips(langPara("%s身上的【%s】不能被替换", petMo1:getName(), mo:getName()))
		else
			local petMo1 = BagPetsController.instance:getPet(mo:getUsePetId())
			local petMo2 = BagPetsController.instance:getPet(self._petId)

			if not string.nilorempty(unloadCostA) then
				local type, id, num = MaterialMgr.getMatParams(unloadCostA)
				local na = MaterialMgr.getMaterialsName(type, id)
				local content = langPara("是否消耗%sx%s把%s的【%s】替换给%s?", na, num, petMo1:getName(), mo:getName(), petMo2:getName())

				TipsFacade.instance:openPopupCostMatViewNew(type, id, num, preContent .. content, okFunc)
			else
				local content = langPara("是否把%s的【%s】替换给%s?", petMo1:getName(), mo:getName(), petMo2:getName())

				TipsFacade.instance:openPopupWindow("替换确认", preContent .. content, okFunc)
			end
		end
	elseif needDestroyB then
		if needReplaceLeastQuality > 0 then
			local qStr = ConstString.Quality[needReplaceLeastQuality + 1]

			if not string.nilorempty(unloadCostA) then
				local type, id, num = MaterialMgr.getMatParams(unloadCostA)
				local na = MaterialMgr.getMaterialsName(type, id)
				local content = string.format("是否消耗%sx%s装上【%s】?\n注意：装上【%s】后只能被未镶嵌的%s星神替换，而且替换后本【%s】会被<color=#ff0000>销毁</color>，是否确认继续此操作？", na, num, mo:getName(), mo:getName(), qStr, mo:getName())

				TipsFacade.instance:openPopupCostMatViewNew(type, id, num, preContent .. content, okFunc)
			else
				local content = langPara("装上【%s】后只能被未镶嵌的%s星神替换，而且替换后本【%s】会被<color=#ff0000>销毁</color>，是否确认继续此操作？", mo:getName(), qStr, mo:getName())

				TipsFacade.instance:openPopupWindow(lang("tip"), preContent .. content, okFunc)
			end
		elseif not string.nilorempty(unloadCostA) then
			local type, id, num = MaterialMgr.getMatParams(unloadCostA)
			local na = MaterialMgr.getMaterialsName(type, id)
			local content = langPara("是否消耗%sx%s装上【%s】?\n注意：装上【%s】后若被其他星神替换，本【%s】会被<color=#ff0000>销毁</color>，是否确认继续此操作？", na, num, mo:getName(), mo:getName(), mo:getName())

			TipsFacade.instance:openPopupCostMatViewNew(type, id, num, preContent .. content, okFunc)
		else
			local content = langPara("装上【%s】后若被其他星神替换，本【%s】会被<color=#ff0000>销毁</color>，是否确认继续此操作？", mo:getName(), mo:getName())

			TipsFacade.instance:openPopupWindow(lang("tip"), preContent .. content, okFunc)
		end
	elseif not string.nilorempty(preContent) then
		local content = lang("是否确认要替换本星神？")

		TipsFacade.instance:openPopupWindow(lang("tip"), preContent .. content, okFunc)
	elseif isWithBindRace == true and mo:getBindPetId() <= 0 then
		local content = langPara("穿戴后该星神将与%s绑定，不可给其他精灵穿戴，是否确认穿戴？", petMo:getName())

		TipsFacade.instance:openPopupWindow(lang("tip"), preContent .. content, okFunc)
	else
		okFunc()
	end
end

function StargodplusbagView:_onClickbtnClear()
	local str = self._searchInput:GetText()

	if string.nilorempty(str) then
		return
	end

	self._searchInput:SetText("")

	self._searchStr = ""

	self:_filterBySearch()
end

function StargodplusbagView:_setShowAllBtnText()
	self._showAllBtntext.text = self._showAllFiller and "未镶嵌" or "显示全部"
end

function StargodplusbagView:_updateView()
	self:_updateItems()
	self:_updateLeft()
end

function StargodplusbagView:_updateItems(filterType)
	local petMo = BagPetsController.instance:getPet(self._petId)

	self._curOriDataList = {}

	if filterType then
		local moList = StargodplusModel.instance:getFillerMoList()

		for i, mo in pairs(moList) do
			if mo:getQuality() == QUILITY_RED and mo:getUsePetId() > 0 or mo:getBindPetId() > 0 and petMo.raceId ~= mo:getBindPetId() or not string.nilorempty(mo:getEquipPetChecker()) and FightingPowerFormula.instance:OnFilter(petMo, mo:getEquipPetChecker()) == false then
				-- block empty
			elseif filterType == mo:getEquipType() then
				table.insert(self._curOriDataList, mo)
			end
		end
	elseif self._showAllFiller then
		local moList = StargodplusModel.instance:getFillerMoList()

		for i, mo in pairs(moList) do
			if mo:getQuality() == QUILITY_RED and mo:getUsePetId() > 0 or mo:getBindPetId() > 0 and petMo.raceId ~= mo:getBindPetId() or not string.nilorempty(mo:getEquipPetChecker()) and FightingPowerFormula.instance:OnFilter(petMo, mo:getEquipPetChecker()) == false then
				-- block empty
			else
				table.insert(self._curOriDataList, mo)
			end
		end
	else
		local slotDatas = petMo:getStarGodPlusSlots()
		local equipTypeList = {}

		for i, v in ipairs(slotDatas) do
			if v.fillerId > 0 and v.fillerDefineId > 0 then
				local cfg = StargodplusConfig.instance:getFillerCfg(v.fillerDefineId)

				equipTypeList[cfg.type] = cfg.quality
			end
		end

		local moList = StargodplusModel.instance:getFillerMoList()

		for i, mo in pairs(moList) do
			local equipType = mo:getEquipType()

			if mo:getBindPetId() > 0 and petMo.raceId ~= mo:getBindPetId() or not string.nilorempty(mo:getEquipPetChecker()) and FightingPowerFormula.instance:OnFilter(petMo, mo:getEquipPetChecker()) == false then
				-- block empty
			elseif mo:getUsePetId() <= 0 and (not equipTypeList[equipType] or self._slotCfg and self._slotCfg.type == equipType) then
				if self._slotCfg and self._slotCfg.quality == QUILITY_RED then
					if mo:getQuality() == QUILITY_RED then
						table.insert(self._curOriDataList, mo)
					end
				else
					table.insert(self._curOriDataList, mo)
				end
			end
		end
	end

	self:_filterBySearch()
	self:_showCurrLiitWithType()
end

function StargodplusbagView:_filterBySearch()
	if not string.nilorempty(self._searchStr) then
		local temp = {}
		local str = StringUtil.RelpaceEscapeChar(self._searchStr)

		for i, mo in ipairs(self._curOriDataList) do
			local name = mo:getName()

			if string.find(name, str) then
				table.insert(temp, mo)
			end
		end

		self._curViewDatas = temp
	else
		self._curViewDatas = self._curOriDataList
	end

	table.sort(self._curViewDatas, function(a, b)
		return a:getQuality() > b:getQuality()
	end)
	self:reloadData()

	local isEmpty = not self._curViewDatas or #self._curViewDatas <= 0

	goutil.setActive(self._jumpBtnGo, true)

	self._txtEmpty.text = lang("当前没有闲置星神可镶嵌，可前往星神幻境获取")

	if isEmpty and self._slotCfg and self._slotCfg.quality == QUILITY_RED then
		self._txtEmpty.text = lang("当前没有闲置红色星神可镶嵌")

		goutil.setActive(self._jumpBtnGo, false)
	end

	local hasBagBox = false

	if isEmpty then
		hasBagBox = self:_calAndShowBagCell()
	end

	if hasBagBox then
		isEmpty = false
	end

	goutil.setActive(self._equipEmptyTipGo, isEmpty)
	goutil.setActive(self._tableviewBagGo, hasBagBox)
end

function StargodplusbagView:_updateLeft()
	local isNoData = not self._slotData or self._slotData.fillerDefineId <= 0

	goutil.setActive(self._emptyTipGo, isNoData)
	goutil.setActive(self._currGo, not isNoData)

	if not isNoData then
		local proxy = self._slotData.fillerId > 0 and MaterialMgr.setCellByGId(MatType.StarGodPlus, self._slotData.fillerId, self._curriconGo) or MaterialMgr.setCell(MatType.StarGodPlus, self._slotData.fillerDefineId, self._curriconGo)

		if proxy then
			proxy.binder:setNum(0)
		end

		self._currnameText.text = self._slotCfg and self._slotCfg.name
		self._currlvText.text = "Lv." .. self._slotLv

		self._currnameTextChange:SetState((self._slotCfg or nil) and (self._slotCfg.quality or 0))
	end

	local list

	self._currAttrGroup:updateWithMoArray((not isNoData or nil) and StargodplusModel.instance:getAttrList(self._slotData.fillerDefineId, self._slotLv), function(item, data)
		local nameText = goutil.findChildTextComponent(item.mainGO, "nameText")
		local numText = goutil.findChildTextComponent(item.mainGO, "numText")
		local name, value = GameUtil.getPropertyInfo(data.id, data.value)

		nameText.text = name .. (data.id == GameEnum.AttrType.OriginalVigour and "增加" or "")
		numText.text = value
	end)
	self:_updateRelace()
end

function StargodplusbagView:_updateRelace()
	goutil.setActive(self._nextGo, self._currSelectFillerId)
	goutil.setActive(self._nextEmptipGo, not self._currSelectFillerId)

	local list

	if self._currSelectFillerId then
		local mo = StargodplusModel.instance:getStarGodMo(self._currSelectFillerId)
		local proxy = MaterialMgr.setCellByMo(mo, self._nexticonGo)

		proxy.binder:setNum(0)
		proxy.binder:setAutoTips(false)
		proxy.binder:setCallBack(function()
			CommonTipsMgr.instance:openMaterialTips(self._nexticonGo, MatType.StarGodPlus, mo:getDefineId(), self._slotLv, mo:getBindPetId())
		end)

		self._nextnameText.text = mo:getName()
		self._nextlvText.text = "Lv." .. self._slotLv
		list = StargodplusModel.instance:getAttrList(mo:getDefineId(), self._slotLv)

		self._nextnameTextChange:SetState(mo:getQuality())
	end

	self._nextAttrGroup:updateWithMoArray(list, function(item, data)
		local nameText = goutil.findChildTextComponent(item.mainGO, "nameText")
		local numText = goutil.findChildTextComponent(item.mainGO, "numText")
		local name, value = GameUtil.getPropertyInfo(data.id, data.value)

		nameText.text = name .. (data.id == GameEnum.AttrType.OriginalVigour and "增加" or "")
		numText.text = value
	end)
end

function StargodplusbagView:_getPath()
	return {
		cellPath = "rightCon/tablecell",
		viewPath = "rightCon/tableview"
	}
end

function StargodplusbagView:_cellSize(view, index)
	return 100, 100
end

function StargodplusbagView:_updateCell(view, cell, mo)
	local raycast = goutil.findChild(cell.gameObject, "raycast")
	local petMask = goutil.findChild(cell.gameObject, "petIconBg")
	local petIcon = goutil.findChild(cell.gameObject, "petIconBg/mask/petIcon")
	local itemCon = goutil.findChild(cell.gameObject, "itemCon")
	local selectGo = goutil.findChild(cell.gameObject, "select")
	local descBgGo = goutil.findChild(cell.gameObject, "descBg")
	local btn = GameUtil.asBtn(raycast)
	local nameText = goutil.findChildTextComponent(cell.gameObject, "nameText")
	local nameChange = nameText.gameObject:GetComponent(ComponentType.UITextColorChange)
	local descText = goutil.findChildTextComponent(cell.gameObject, "descBg/descText")
	local petId = mo:getUsePetId()

	nameChange:SetState(mo:getQuality())
	goutil.setActive(selectGo, mo:getId() == self._currSelectFillerId)
	goutil.setActive(petMask, petId > 0)

	if petId > 0 then
		local petMo = BagPetsController.instance:getPet(petId)

		MaterialMgr.setIcon(petIcon, MatType.Pet, petMo.raceId)
	end

	local proxy = MaterialMgr.setCellByMo(mo, itemCon)

	proxy.binder:setNumStr("")
	proxy.binder:setSelected(self._currSelectFillerId == mo:getId())

	local descStr = ""
	local isWearSolt = false

	if mo:getId() == self._slotFillerId then
		descStr = "当前星神"
	else
		for slot, v in pairs(self._equipSlotDatas) do
			if mo:getId() == v:getId() then
				isWearSolt = slot
				descStr = string.format("%s号栏位\n已镶嵌", slot)

				break
			end
		end
	end

	goutil.setActive(descBgGo, not string.nilorempty(descStr))

	nameText.text = mo:getName()
	descText.text = descStr

	btn:RemoveClickListener()
	btn:AddClickListener(function()
		if isWearSolt then
			FloatWordMgr.instance:show(string.format("%s号栏位已镶嵌", isWearSolt))

			return
		end

		if mo:getId() == self._slotFillerId then
			FloatWordMgr.instance:show("当前栏位已镶嵌")

			return
		end

		for slot, emo in pairs(self._equipSlotDatas) do
			if not (self._slotCfg and self._slotCfg.type == mo:getEquipType()) and emo:getEquipType() == mo:getEquipType() then
				FloatWordMgr.instance:show("同类型星神只能镶嵌一种，此星神与" .. slot .. "号栏位星神同类型")

				return
			end
		end

		self:_onClickItem(mo:getId())
	end)
end

function StargodplusbagView:_clearTableview(cell)
	local petIcon = goutil.findChild(cell.gameObject, "petIconBg/mask/petIcon")
	local itemCon = goutil.findChild(cell.gameObject, "itemCon")

	MaterialMgr.resetAll(petIcon)
	MaterialMgr.resetAll(itemCon)
end

function StargodplusbagView:_onClickItem(fillerId)
	self._currSelectFillerId = fillerId

	self:reloadData()
	self:_updateRelace()
end

function StargodplusbagView:_updateRecommend()
	local raceId = StargodplusModel.instance:getCurrShowPetRaceId()
	local co = CharacterConfig.instance:getPetCo(raceId)
	local rcfg = StargodplusConfig.instance:getRecommendCfg(co.SGPRecommendId, self._slotId)

	self._recommendGroup:updateWithMoArray(rcfg.recommend, function(item, id)
		local icon = goutil.findChild(item.mainGO, "icon")
		local btn = GameUtil.asBtn(icon)

		MaterialMgr.setIcon(icon, MatType.StarGodPlus, id)
		btn:AddClickListener(function()
			CommonTipsMgr.instance:openMaterialTips(icon, MatType.StarGodPlus, id)
		end)
	end)
end

function StargodplusbagView:_onInputValueChange(str)
	self._searchStr = str

	self:_filterBySearch()
end

function StargodplusbagView:_updateBagCell(view, cell, data, tag)
	local btnUse = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnUse")
	local txtDesc = goutil.findChildTextComponent(cell.gameObject, "txtDesc")
	local matName = MaterialMgr.getMaterialsName(data.matType, data.matId)

	txtDesc.text = string.format("背包-%s\n(库存：%s)", matName, data.matNum)

	btnUse:AddClickListener(function()
		ItemBagController.instance:openUsePanel(data.mo)
	end)
end

function StargodplusbagView:_clearBagCell(cell)
	return
end

function StargodplusbagView:_calAndShowBagCell()
	local list = MaterialModel.instance:getMaterialsByTypeExceptSub(MatType.Item_GoodFeel) or {}
	local bagBoxList = {}
	local isPass = false

	for i, v in ipairs(list) do
		local type, id = v:getMatType(), v:getDefineId()
		local matCfg = MaterialMgr.getMatCfg(type, id)

		isPass = false

		if matCfg and matCfg.useType == 1 then
			local useCfg = MaterialConfig.instance:getCfgByMatAndId(type, id)

			if useCfg and ItemBagController.instance:checkCanUseNotWithTips(useCfg) then
				if self:_checkUseContentMatch(useCfg.content, MatType.StarGodPlus) then
					isPass = true
				elseif self:_checkUseContentMatch(useCfg.content, MatType.DROP_ITEM) then
					local matStr = MaterialMgr.changeIfDrop(useCfg.content)

					isPass = self:_checkUseContentMatch(matStr, MatType.StarGodPlus)
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

function StargodplusbagView:_checkUseContentMatch(content, type)
	local match = string.match(content, string.format("^%s:%%d+:%%d+", type))

	match = match or string.match(content, string.format("[%%D]%s:%%d+:%%d+", type))

	return match
end

return StargodplusbagView
