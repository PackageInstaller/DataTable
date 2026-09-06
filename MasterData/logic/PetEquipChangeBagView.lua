-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/equipment/view/PetEquipChangeBagView.lua

module("logic.extensions.equipment.view.PetEquipChangeBagView", package.seeall)

local PetEquipChangeBagView = class("PetEquipChangeBagView", ViewComponent)
local defaultAttr = {
	GameEnum.AttrType.Attack,
	GameEnum.AttrType.DefensePhysical,
	GameEnum.AttrType.DefenseMagic,
	GameEnum.AttrType.Hp
}

function PetEquipChangeBagView:ctor()
	PetEquipChangeBagView.super.ctor(self)

	self.equipItemList = nil
	self.equipInfoList = nil
	self.decorationInfo = nil
	self.isRedPoint = false
end

function PetEquipChangeBagView:bindEvents()
	PetEquipChangeBagView.super.bindEvents(self)
	GameUtil.addClickHandler(self.wearAllBtnGo, self.OnClickWearAllBtn, self)
	GameUtil.addClickHandler(self.takeOffBtnGo, self._onBtnClickInTakeOff, self)

	for index, v in pairs(self.equipItemList) do
		if v.itemGo then
			GameUtil.addClickHandler(v.itemGo, function()
				self:OnClickEquipItem(index)
			end, self)
		end
	end

	self._closeBtn:AddClickListener(self.close, self)
	self._btnRule:AddClickListener(self._onClickRule, self)
	GameUtil.addClickHandler(self._btn_left, self._onBtnLeftClick, self)
	GameUtil.addClickHandler(self._btn_right, self._onBtnRightClick, self)
	GameUtil.addClickHandler(self._btnHeadIcon, self._onClickPetIcon, self)
	GameUtil.addClickHandler(self._btnMask, self._onClickMask, self)
	GameUtil.addClickHandler(self._showAllBtn, self._onClickShowAll, self)
	GameUtil.addClickHandler(self._filterBtn, self._onClickfilterBtn, self)
end

function PetEquipChangeBagView:unbindEvents()
	PetEquipChangeBagView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self.wearAllBtnGo)
	GameUtil.rmClickHandler(self.takeOffBtnGo)

	if self.equipItemList == nil and #self.equipItemList == 0 then
		return
	end

	for i = 1, #self.equipItemList do
		if self.equipItemList[i] and self.equipItemList[i].itemGo then
			GameUtil.rmClickHandler(self.equipItemList[i].itemGo)
		end
	end

	self._closeBtn:RemoveClickListener()
	self._btnRule:RemoveClickListener()
	GameUtil.rmClickHandler(self._btn_left)
	GameUtil.rmClickHandler(self._btn_right)
	GameUtil.rmClickHandler(self._btnHeadIcon)
	GameUtil.rmClickHandler(self._btnMask)
	GameUtil.rmClickHandler(self._showAllBtn)
	GameUtil.rmClickHandler(self._filterBtn)
end

function PetEquipChangeBagView:onExit()
	PetEquipChangeBagView.super.onExit(self)
end

function PetEquipChangeBagView:destroyUI()
	PetEquipChangeBagView.super.destroyUI(self)

	self.equipItemList = nil
	self.equipInfoList = nil
	self.decorationInfo = nil
end

function PetEquipChangeBagView:buildUI()
	PetEquipChangeBagView.super.buildUI(self)

	local bgGo = self:getGo("rightRoot")
	local equipAllGo = goutil.findChild(bgGo, "equipAll")

	self.takeOffBtnGo = self:getGo("oneKeyTakeoffBtn")
	self.wearAllBtnGo = self:getGo("oneKeyTakeOnBtn")
	self.waRedPointGo = goutil.findChild(self.wearAllBtnGo, "waRedPoint")

	self.waRedPointGo:SetActive(false)

	self.allPowerGo = goutil.findChild(bgGo, "allPowerGo")
	self.powerTxt = goutil.findChildTextComponent(self.allPowerGo, "powerTxt")

	self.allPowerGo:SetActive(false)

	if self.equipItemList and #self.equipItemList > 0 then
		return
	end

	if equipAllGo.transform.childCount ~= 6 then
		print("sr_ (错误)PetEquipChangeBagView:buildUI()  精灵装备槽不为6个，请检查！")

		return
	end

	self.equipItemList = {}

	for i = 1, 6 do
		local go = equipAllGo.transform:GetChild(i - 1).gameObject
		local names = string.split(go.name, "_")
		local index = tonumber(names[2])

		self.equipItemList[index] = {}
		self.equipItemList[index].itemGo = go
		self.equipItemList[index].stateSpt = goutil.findChildComponent(go, "stateSpt", "UIImageSpriteChange")
		self.equipItemList[index].redPointGo = goutil.findChild(go, "redPoint")
		self.equipItemList[index].showSignGo = goutil.findChild(go, "showSignGo")
		self.equipItemList[index].selectGo = goutil.findChild(go, "select")

		if i >= 5 then
			self.equipItemList[index].kuangIma = goutil.findChildComponent(go, "kuangIma", "UIImageSpriteChange")
		end

		self.equipItemList[index].redPointGo:SetActive(false)
		self.equipItemList[index].showSignGo:SetActive(false)
	end

	self._headIcon = self:getGo("head/con")
	self._btnHeadIcon = GameUtil.asBtn(self._headIcon)
	self._petName = self:getTxt("head/txtName")
	self._patBag = self:getGo("petBag")
	self._closeBtn = self:getBtn("closeBtn")
	self._btnRule = self:getBtn("btnRule")
	self._mask = self:getGo("mask")
	self._btnMask = GameUtil.asBtn(self._mask)
	self._btn_left = self:getGo("rightRoot/btn_left")
	self._btn_right = self:getGo("rightRoot/btn_right")
	self._bagTableview = self:getGo("petBag/itemScr")
	self._bagTablecell = self:getGo("petBag/itemcell")
	self._bagPetList = ScrollerList.create(self._bagTableview, self._bagTablecell, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))
	self._equipTableview = self:getGo("bagRoot/tableview")
	self._equipTablecell = self:getGo("bagRoot/tablecell")
	self._equipTableList = ScrollerList.create(self._equipTableview, self._equipTablecell, GameUtil.handler(self._updateEquipCell, self), GameUtil.handler(self._clearEquipCell, self))
	self._empty = self:getGo("bagRoot/empty")
	self.noEquipListTxt = self:getTxt("bagRoot/empty/txtEmpty")
	self._tableviewBagGo = self:getGo("tableviewBag")
	self._tablecellBagGo = self:getGo("tablecellBag")
	self._bagScrollerList = ScrollerList.create(self._tableviewBagGo, self._tablecellBagGo, GameUtil.handler(self._updateBagCell, self), GameUtil.handler(self._clearBagCell, self))

	goutil.setActive(self._tableviewBagGo, false)
	goutil.setActive(self._tablecellBagGo, false)

	self._attrTableview = self:getGo("rightRoot/attrRoot/tableview")
	self._attrTablecell = self:getGo("rightRoot/attrRoot/tablecell")
	self._attrTableList = ScrollerList.create(self._attrTableview, self._attrTablecell, GameUtil.handler(self._updateAttrCell, self), GameUtil.handler(self._clearAttrCell, self))
	self._filterBtn = self:getGo("filterBtn")
	self._filtercon = self:getGo("filtercon")
	self._showAllBtn = self:getGo("showAllBtn")
	self._textShowAll = self:getTxt("showAllBtn/text")
end

function PetEquipChangeBagView:onEnter()
	PetEquipChangeBagView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.OnPetSelect, self.UpdataAllInfoMos, self)
	self.addGEvent(self, GlobalNotify.OnMaterialGet, self.UpdataAllInfoMos, self)
	self.addGEvent(self, GlobalNotify.PET_EQUIP_CHANGES, self.UpdataAllInfoMos, self)
	self.addGEvent(self, GlobalNotify.BagPetChanged, self.UpdataPetChanged, self)
	self.addGEvent(self, GlobalNotify.EquipChangeRaceTypeFilter, self._onRaceTypeFilter, self)

	local params = self:getOpenParam()

	self._curPos = checknumber(params[1]) or 1
	self._isSQ = self._curPos > 4
	self._isShowAll = false
	self._raceTypeFilter = nil
	self.isRedPoint = false

	self:UpdataAllInfoMos()
end

function PetEquipChangeBagView:UpdataAllInfoMos()
	local petInfo = BagPetsController.instance:GetCurPetMo()

	if not petInfo then
		return
	end

	local allPower = 0

	self.equipInfoList = {}

	if PetEquipController.instance.isEquipInit then
		self.equipInfoList = PetEquipModel.instance:GetWearEquipInfosByPetInfo(petInfo)
		allPower = PetEquipModel.instance:GetWearEquipAllPower(petInfo, self.equipInfoList)
	end

	if allPower > 0 then
		self.powerTxt.text = tostring(allPower)

		self.allPowerGo:SetActive(true)
	else
		self.powerTxt.text = ""

		self.allPowerGo:SetActive(false)
	end

	if not self.isRedPoint then
		self.waRedPointGo:SetActive(false)
	end

	if self.equipItemList == nil or #self.equipItemList == 0 then
		return
	end

	for i = 1, #self.equipInfoList do
		if self.equipItemList[i] and self.equipItemList[i].itemGo then
			MaterialMgr.resetAll(self.equipItemList[i].itemGo)
			self.equipItemList[i].redPointGo:SetActive(false)
			self.equipItemList[i].showSignGo:SetActive(false)
			GameUtil.SetActive(self.equipItemList[i].selectGo, i == self._curPos)

			if not self.equipInfoList[i].isOpen then
				self.equipItemList[i].stateSpt.gameObject:SetActive(true)
				self.equipItemList[i].stateSpt:SetState(1)

				if i >= 5 then
					self.equipItemList[i].kuangIma:SetState(0)
				end
			else
				if not self.equipInfoList[i].isWear then
					self.equipItemList[i].stateSpt.gameObject:SetActive(true)
					self.equipItemList[i].stateSpt:SetState(0)

					if i >= 5 then
						self.equipItemList[i].kuangIma:SetState(0)
					end
				else
					self.equipItemList[i].stateSpt.gameObject:SetActive(false)

					local subLua = MaterialMgr.setCellByData(MatType.Equipment, self.equipInfoList[i].info, self.equipItemList[i].itemGo)

					if subLua then
						subLua.binder:CancelBtnClick()

						if self.equipInfoList[i].isAddSttr then
							subLua.binder:SetView(self)
							subLua.binder:PlayAttrTypeEffect()
						else
							subLua.binder:PlayAttrTypeEffect(true)
						end
					end

					if i >= 5 then
						self.equipItemList[i].kuangIma:SetState(1)
					end
				end

				if PetEquipController.instance:GetPetEquipPosRedPoint(petInfo.petId, i, PetEquipModel.PetEquipRedType.Wear) or PetEquipController.instance:GetPetEquipPosRedPoint(petInfo.petId, i, PetEquipModel.PetEquipRedType.TuPo) then
					self.equipItemList[i].redPointGo.transform:SetAsLastSibling()

					self.isRedPoint = true

					self.equipItemList[i].redPointGo:SetActive(true)
				end

				if PetEquipController.instance:GetPetEquipPosRedPoint(petInfo.petId, i, PetEquipModel.PetEquipRedType.Strengthen) then
					self.equipItemList[i].showSignGo.transform:SetAsLastSibling()
					self.equipItemList[i].showSignGo:SetActive(true)
				end
			end
		end
	end

	self.waRedPointGo:SetActive(self.isRedPoint)

	self.curPetIndex = BagPetsController.instance:getPetIndex()

	local state = BagPetsController.instance:checkState(self.curPetIndex)

	GameUtil.SetActive(self._btn_left, state ~= BagPetsController.NO_LEFT and state ~= BagPetsController.NO_LEFT_AND_RIGHT)
	GameUtil.SetActive(self._btn_right, state ~= BagPetsController.NO_RIGHT and state ~= BagPetsController.NO_LEFT_AND_RIGHT)

	local petMo = BagPetsController.instance:GetCurPetMo()

	MaterialMgr.setIcon(self._headIcon, MatType.Pet, petMo.curFaceId)

	self._petName.text = BagPetsController.instance:GetCurPetMo().name

	self._bagPetList:reloadData(BagModel.instance:getCurPetViewList())

	local curViewDatas = PetEquipModel.instance:GetWearInfoMoList(self._curPos, petInfo, true, self._isShowAll)
	local resultList = {}
	local filterRaceTypeTxt = GameEnum.RaceTxt[self._raceTypeFilter]

	for i, v in ipairs(curViewDatas) do
		if not filterRaceTypeTxt or v.attrType == filterRaceTypeTxt then
			table.insert(resultList, v)
		end
	end

	self._equipTableList:reloadData(resultList)

	self._textShowAll.text = self._isShowAll == true and lang("显示全部") or lang("未装备")

	local isEmpty = resultList == nil or #resultList == 0
	local hasBagBox = false

	if isEmpty then
		hasBagBox = self:_calAndShowBagCell()
	end

	if hasBagBox then
		isEmpty = false
	end

	goutil.setActive(self._tableviewBagGo, hasBagBox)
	GameUtil.SetActive(self._empty, isEmpty)

	if isEmpty then
		self.noEquipListTxt.text = self._isSQ and "当前没有可穿戴神器" or "当前没有可穿戴装备"
	end

	local attrs = AttrMo.instance:getEquipmentAttr(petMo)
	local attrList = {}
	local beginattrs = {}
	local headattrs = {}

	for i, v in pairs(attrs) do
		if ConstString.Attr[i] then
			if self:_isDefaultAttr(i) then
				table.insert(headattrs, {
					type = i,
					value = v,
					name = ConstString.Attr[i]
				})
			else
				table.insert(beginattrs, {
					type = i,
					value = v,
					name = ConstString.Attr[i]
				})
			end
		end
	end

	table.sort(headattrs, function(a, b)
		return a.type < b.type
	end)

	for i, v in ipairs(beginattrs) do
		table.insert(attrList, 1, v)
	end

	for i, v in ipairs(headattrs) do
		table.insert(attrList, 1, v)
	end

	if #attrList == 0 then
		for i, v in ipairs(defaultAttr) do
			table.insert(attrList, {
				value = 0,
				type = v,
				name = ConstString.Attr[v]
			})
		end
	end

	self._attrTableList:reloadData(attrList)
end

function PetEquipChangeBagView:_isDefaultAttr(type)
	for i, v in ipairs(defaultAttr) do
		if type == v then
			return true
		end
	end

	return false
end

function PetEquipChangeBagView:UpdataPetChanged(ids)
	local petId = BagPetsController.instance:GetCurPetId()

	for id, value in pairs(ids or {}) do
		if id and value and id == petId then
			self:UpdataEquipPosRedPoint()

			return
		end
	end
end

function PetEquipChangeBagView:UpdataEquipPosRedPoint()
	self.isRedPoint = false

	local petInfo = BagPetsController.instance:GetCurPetMo()

	if self.equipItemList == nil or petInfo == nil then
		self.waRedPointGo:SetActive(self.isRedPoint)

		return
	end

	for i = 1, #self.equipItemList do
		if self.equipItemList[i] and self.equipItemList[i].redPointGo then
			local redPoint = PetEquipController.instance:GetPetEquipPosRedPoint(petInfo.petId, i, PetEquipModel.PetEquipRedType.Wear) or PetEquipController.instance:GetPetEquipPosRedPoint(petInfo.petId, i, PetEquipModel.PetEquipRedType.TuPo)
			local showSign = PetEquipController.instance:GetPetEquipPosRedPoint(petInfo.petId, i, PetEquipModel.PetEquipRedType.Strengthen)

			self.equipItemList[i].redPointGo:SetActive(redPoint)
			self.equipItemList[i].showSignGo:SetActive(showSign)

			if redPoint then
				self.equipItemList[i].redPointGo.transform:SetAsLastSibling()

				self.isRedPoint = true
			end

			if showSign then
				self.equipItemList[i].showSignGo.transform:SetAsLastSibling()
			end
		end
	end

	self.waRedPointGo:SetActive(self.isRedPoint)
end

function PetEquipChangeBagView:_updateEquipCell(view, cell, data, tag)
	local go = cell.gameObject
	local itemCon = goutil.findChild(go, "itemCon")
	local equipNameTxt = goutil.findChildTextComponent(go, "nameText")
	local petIconGo = goutil.findChild(go, "petIconGo")
	local petIcon = goutil.findChild(petIconGo, "icon")
	local curEquip = goutil.findChild(go, "curEquip")

	MaterialMgr.resetAll(itemCon)

	local matType = data.matType
	local isWear = data.isWear
	local subLua = MaterialMgr.setCellByData(matType, data, itemCon)

	if subLua then
		subLua.binder:setAutoTips(false)
		subLua.binder:setCallBack(GameUtil.handler(function()
			UIStateManager.instance:open(ViewName.PetEquipInfo, data)
		end, self))
	end

	equipNameTxt.text = data.name

	if isWear then
		local petMo = BagPetsController.instance:getPet(data.equipPetId)

		MaterialMgr.setIcon(petIcon, MatType.Pet, petMo.raceId)
		GameUtil.SetActive(petIconGo, true)
		GameUtil.SetActive(curEquip, data.equipPetId == BagPetsController.instance:GetCurPetId())
	else
		GameUtil.SetActive(petIconGo, false)
		GameUtil.SetActive(curEquip, false)
	end
end

function PetEquipChangeBagView:_clearEquipCell(cell)
	local go = cell.gameObject
	local itemCon = goutil.findChild(go, "itemCon")
	local petIconGo = goutil.findChild(go, "petIconGo")
	local petIcon = goutil.findChild(petIconGo, "icon")

	MaterialMgr.resetAll(itemCon)
	MaterialMgr.resetAll(petIcon)
end

function PetEquipChangeBagView:OnClickEquipItem(index)
	if self.equipInfoList == nil or self.equipInfoList[index] == nil then
		return
	end

	local info = self.equipInfoList[index]

	if not info.isOpen then
		FloatWordMgr.instance:show(lang("text_equip_not_open"))

		return
	end

	if self._curPos == index then
		if info.info then
			UIStateManager.instance:open(ViewName.PetEquipInfo, info.info)

			return
		end
	else
		self._curPos = index
		self._isSQ = self._curPos > 4

		self:UpdataAllInfoMos()
	end
end

function PetEquipChangeBagView:OnClickTakeoffBtn()
	local petInfo = BagPetsController.instance:GetCurPetMo()
	local unloadList = PetEquipModel.instance:ClickTakeoffAllEquips(petInfo)

	if unloadList == nil or #unloadList == 0 then
		FloatWordMgr.instance:show(lang("text_equip_desc_84"))

		return
	end

	PetEquipController.instance:CSOneKeyUnloadEquipReq({
		petInfo.petId
	})
end

function PetEquipChangeBagView:_onBtnClickInTakeOff()
	self:OnClickTakeoffBtn()
end

function PetEquipChangeBagView:OnClickWearAllBtn()
	local petInfo = BagPetsController.instance:GetCurPetMo()
	local equipList, dectInfo, isHave, isBest = PetEquipModel.instance:ClickWearAllBestEquips(petInfo)

	if not isHave then
		FloatWordMgr.instance:show(lang("text_equip_desc_85"))

		return
	end

	if not isBest then
		FloatWordMgr.instance:show(lang("text_equip_desc_86"))

		return
	end

	local ids = {}

	for i = 1, #equipList do
		if equipList[i].info then
			table.insert(ids, equipList[i].info.onlyId)
		end
	end

	if dectInfo and dectInfo.info and dectInfo.isBest then
		PetEquipController.instance:CSOneKeyWearEquipReq(petInfo.petId, ids, dectInfo.info.onlyId)
	else
		local tips = ""

		if ids and #ids > 0 then
			for i = 1, #ids do
				local tempMo = PetEquipModel.instance:GetEquipInfo(ids[i])

				if tempMo == nil then
					tips = string.format("%s +   出错装备id=%s, 类型=%s, 精灵信息id=%s", tips, ids[i], type(ids[i]), petInfo.petId)
				end
			end
		end

		if not string.nilorempty(tips) then
			forcePrint("sr===========================装备一键穿戴===============forcePrint", tips)
			printError("sr===========================装备一键穿戴====================printError", tips)
		end

		PetEquipController.instance:CSOneKeyWearEquipReq(petInfo.petId, ids)
	end
end

function PetEquipChangeBagView:_updatePetCell(view, cell, data, tag)
	local go = cell.gameObject
	local proxy = MaterialMgr.setCellByMo(data, go)

	if proxy then
		proxy.binder:setNumStr("")
		proxy.binder:setAutoTips(false)

		if data:getId() == BagPetsController.instance:GetCurPetId() then
			proxy.binder:setSelected(true)
		else
			proxy.binder:setSelected(false)
		end

		proxy.binder:setCallBack(function()
			self:_onCLickBagPet(data:getId())
		end)
	end
end

function PetEquipChangeBagView._clearPetCell(cell)
	local go = cell.gameObject

	MaterialMgr.resetAll(go)
end

function PetEquipChangeBagView:_updateBagCell(view, cell, data, tag)
	local btnUse = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnUse")
	local txtDesc = goutil.findChildTextComponent(cell.gameObject, "txtDesc")
	local matName = MaterialMgr.getMaterialsName(data.matType, data.matId)

	txtDesc.text = string.format("背包-%s\n(库存：%s)", matName, data.matNum)

	btnUse:AddClickListener(function()
		ItemBagController.instance:openUsePanel(data.mo)
	end)
end

function PetEquipChangeBagView:_clearBagCell(cell)
	return
end

function PetEquipChangeBagView:_onCLickBagPet(petId)
	BagPetsController.instance:SetCurPetId(petId)
	GlobalDispatcher:dispatch(GlobalNotify.OnPetSelect)
end

function PetEquipChangeBagView:_onClickRule()
	UIStateManager.instance:push(ViewName.RulesView, "holystripe_rule")
end

function PetEquipChangeBagView:_onBtnLeftClick()
	self._curPos = 1
	self._isSQ = self._curPos > 4

	BagPetsController.instance:goNextPet(false)
end

function PetEquipChangeBagView:_onBtnRightClick()
	self._curPos = 1
	self._isSQ = self._curPos > 4

	BagPetsController.instance:goNextPet(true)
end

function PetEquipChangeBagView:_onClickPetIcon()
	GameUtil.SetActive(self._mask, true)
	GameUtil.SetActive(self._patBag, true)
end

function PetEquipChangeBagView:_onClickMask()
	GameUtil.SetActive(self._mask, false)
	GameUtil.SetActive(self._patBag, false)
end

function PetEquipChangeBagView:_calAndShowBagCell()
	if not self._isSQ then
		return false
	end

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

					if self:_checkUseContentMatch(useCfg.content, MatType.Equipment) then
						isPass = true
					elseif self:_checkUseContentMatch(useCfg.content, MatType.DROP_ITEM) then
						local matStr = MaterialMgr.changeIfDrop(useCfg.content)

						content = matStr
						isPass = self:_checkUseContentMatch(matStr, MatType.Equipment)
					end

					if isPass then
						local arr

						if useCfg.materialUseType == MatUseType.PACK then
							arr = string.split(content, "#")
						elseif useCfg.materialUseType == MatUseType.MIX_SELECT then
							arr = string.split(content, ";")
						end

						isPass = false

						for i, subStr in ipairs(arr or {}) do
							local mt, mi = MaterialMgr.getMatParams(subStr)
							local ecfg = EquipmentConfig.instance:GetEquipDefineInfoById(mi)
							local petMo = BagPetsController.instance:GetCurPetMo()

							if ecfg and (ecfg.positionType == 5 or ecfg.positionType == 6) and ecfg.throneRelatedSkinId == petMo.raceId then
								isPass = true

								break
							end
						end
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

function PetEquipChangeBagView:_checkUseContentMatch(content, type)
	local match = string.match(content, string.format("^%s:%%d+:%%d+", type))

	match = match or string.match(content, string.format("[%%D]%s:%%d+:%%d+", type))

	return match
end

function PetEquipChangeBagView:_updateAttrCell(view, cell, data, tag)
	local go = cell.gameObject
	local nameTxt = goutil.findChildTextComponent(go, "nameText")
	local valueTxt = goutil.findChildTextComponent(go, "valueText")
	local iconGo = goutil.findChild(go, "attr")
	local icon = goutil.findChildComponent(go, "attr", "UIImageSpriteChange")

	if data.type then
		goutil.setActive(iconGo, true)
		icon:SetState(data.type - 1)
	else
		goutil.setActive(iconGo, false)
	end

	valueTxt.text = data.value > 0 and data.value < 1 and string.format("%s%%", data.value * 100) or data.value
	nameTxt.text = data.name
end

function PetEquipChangeBagView:_clearAttrCell(cell)
	return
end

function PetEquipChangeBagView:_onClickShowAll()
	self._isShowAll = not self._isShowAll

	self:UpdataAllInfoMos()
end

function PetEquipChangeBagView:_onRaceTypeFilter(raceType)
	self._raceTypeFilter = raceType

	self:UpdataAllInfoMos()
end

function PetEquipChangeBagView:_onClickfilterBtn()
	self:showTabAt(self._filtercon, ViewName.PetEquipFilterView)
end

return PetEquipChangeBagView
