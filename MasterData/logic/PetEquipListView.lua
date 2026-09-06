-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/equipment/view/PetEquipListView.lua

module("logic.extensions.equipment.view.PetEquipListView", package.seeall)

local PetEquipListView = class("PetEquipListView", TableViewComponent)

function PetEquipListView:ctor()
	PetEquipListView.super.ctor(self)

	self.equipInfo = nil
	self.petInfo = nil
end

function PetEquipListView:bindEvents()
	PetEquipListView.super.bindEvents(self)
	GameUtil.asBtn(self.viewBoxGo):AddClickListener(self.close, self)
	self.huanjingBtn:AddClickListener(function()
		self:close()
		StrongerFacade.instance:openStrongerView(6, true)
	end, self)
end

function PetEquipListView:unbindEvents()
	PetEquipListView.super.unbindEvents(self)
	GameUtil.asBtn(self.viewBoxGo):RemoveClickListener()
	self.huanjingBtn:RemoveClickListener()
end

function PetEquipListView:onExit()
	self._curViewDatas = nil

	self._bagScrollerList:dispose()
end

function PetEquipListView:destroyUI()
	PetEquipListView.super.destroyUI(self)

	self.equipInfo = nil
	self.petInfo = nil
end

function PetEquipListView:buildUI()
	PetEquipListView.super.buildUI(self)

	self.viewBoxGo = self:getGo("viewBoxGo")
	self.noEquipListGo = self:getGo("viewBg/noEquipListGo")
	self.noEquipListTxt = goutil.findChildTextComponent(self.noEquipListGo, "noEquipListTxt")
	self.noEquipListTxt.text = ""

	self.noEquipListGo:SetActive(false)

	self.huanjingBtn = self:getBtn("huanjingBtn")
	self.huanjingTxt = goutil.findChildTextComponent(self.huanjingBtn.gameObject, "huanjingTxt")

	GameUtil.SetActive(self.huanjingBtn, false)

	local titleEquipShowGo = self:getGo("viewBg/titleEquipShowGo")

	self.noneEquipGo = goutil.findChild(titleEquipShowGo, "noneEquipGo")
	self.noneEquipTxt = goutil.findChildTextComponent(self.noneEquipGo, "noneEquipTxt")
	self.haveEquipGo = goutil.findChild(titleEquipShowGo, "haveEquipGo")
	self.haveEquipSpt = self.haveEquipGo:GetComponent("UIImageSpriteChange")
	self.haveItemGo = goutil.findChild(self.haveEquipGo, "haveItemGo")
	self.haveNameTxt = goutil.findChildTextComponent(self.haveEquipGo, "haveNameTxt")
	self.havePowerTxt = goutil.findChildTextComponent(self.haveEquipGo, "havePowerTxt")
	self._tableviewBagGo = self:getGo("tableviewBag")
	self._tablecellBagGo = self:getGo("tablecellBag")
	self._bagScrollerList = ScrollerList.create(self._tableviewBagGo, self._tablecellBagGo, GameUtil.handler(self._updateBagCell, self), GameUtil.handler(self._clearBagCell, self))

	goutil.setActive(self._tableviewBagGo, false)
	goutil.setActive(self._tablecellBagGo, false)
end

function PetEquipListView:onEnter()
	PetEquipListView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.OnMaterialGet, self._updateUI, self)

	local param = self._viewPresentor._openParam
	local posNum = 1

	self.equipInfo = nil

	if param then
		if param[1] then
			posNum = tonumber(param[1])
		end

		if param[2] then
			self.equipInfo = param[2]
		end
	end

	GameUtil.SetActive(self.huanjingBtn, true)

	self._posNum = posNum
	self._isSQ = posNum > 4
	self.huanjingTxt.text = self._isSQ and "神器获取" or "装备获取"

	if param then
		self.petInfo = param[3] or BagPetsController.instance:GetCurPetMo()
	end

	if self.equipInfo == nil then
		self.noneEquipGo:SetActive(true)
		self.haveEquipGo:SetActive(false)

		self.noneEquipTxt.text = self._isSQ and "当前没有穿戴神器" or lang("text_equip_desc_38")
	else
		self.noneEquipTxt.text = ""

		self.noneEquipGo:SetActive(false)
		self.haveEquipGo:SetActive(true)
		self.haveEquipSpt:SetState(self.equipInfo.qualityBase)

		local subLua = MaterialMgr.setCellByData(self.equipInfo.matType, self.equipInfo, self.haveItemGo)
		local _, colorStr = PetEquipController.instance:GetQualityStrByNum(self.equipInfo.qualityBase, true)

		self.haveNameTxt.text = string.format("<color=%s>%s</color>", colorStr, self.equipInfo.name)

		local power = self.equipInfo.commPower
		local isAdd = false

		if self.petInfo then
			isAdd = PetSkinConfig.instance:checkHasEleAttr(self.petInfo.curFaceId, self.equipInfo.attrType) or AttrMo.checkHasYuanEle(self.petInfo.curFaceId, self.equipInfo.attrType)
		end

		if checknumber(self.equipInfo.exclRaceId) > 0 then
			if self.equipInfo:isEnableWearExcl() then
				power = self.equipInfo.exclPower
			end
		elseif isAdd then
			power = self.equipInfo.addPower

			subLua.binder:SetView(self)
			subLua.binder:PlayAttrTypeEffect()
		end

		self.havePowerTxt.text = tostring(power)
	end

	self:_updateUI()
end

function PetEquipListView:_getPath()
	return {
		cellPath = "viewBg/listItem",
		viewPath = "viewBg/viewListSR"
	}
end

function PetEquipListView:_cellSize()
	return 350, 100
end

function PetEquipListView:_updateUI()
	self._curViewDatas = PetEquipModel.instance:GetWearInfoMoList(self._posNum, self.petInfo, true, false)

	self._tableview:ReloadData()

	local isEmpty = self._curViewDatas == nil or #self._curViewDatas == 0
	local hasBagBox = false

	if isEmpty then
		hasBagBox = self:_calAndShowBagCell()
	end

	if hasBagBox then
		isEmpty = false
	end

	goutil.setActive(self._tableviewBagGo, hasBagBox)
	self.noEquipListGo:SetActive(isEmpty)

	if isEmpty then
		self.noEquipListTxt.text = self._isSQ and "当前没有可穿戴神器" or "当前没有可穿戴装备"
	end
end

function PetEquipListView:_updateCell(view, cell, data)
	local equipItemGo = goutil.findChild(cell, "equipItemGo")
	local equipNameTxt = goutil.findChildTextComponent(cell, "equipNameTxt")
	local equipPowerTxt = goutil.findChildTextComponent(cell, "equipPowerTxt")
	local lvLimitTxt = goutil.findChildTextComponent(cell, "lvLimitTxt")
	local petShowGo = goutil.findChild(cell, "petShowGo")
	local iconGo = goutil.findChild(petShowGo, "iconGo")
	local equipWearBtnGo = goutil.findChild(cell, "equipWearBtn")
	local equipWearSpt = equipWearBtnGo:GetComponent("UIImageSpriteChange")
	local equipWearTxt = goutil.findChildTextComponent(cell, "equipWearBtn/equipWearTxt")
	local ewRedPoint = goutil.findChild(cell, "equipWearBtn/ewRedPoint")

	MaterialMgr.resetAll(equipItemGo)
	MaterialMgr.resetAll(iconGo)

	local matType = data.matType
	local isWear = data.isWear

	if self.petInfo then
		if not self.petInfo.petId then
			local petId = 1

			if self.petInfo then
				if not self.petInfo.level then
					local petLv = 1
					local onlyId = data.onlyId
					local subLua = MaterialMgr.setCellByData(matType, data, equipItemGo)

					equipNameTxt.text = data.name

					local power = data.commPower

					if checknumber(data.exclRaceId) > 0 then
						if data:isEnableIdleExcl(self.petInfo.raceId) then
							power = data.exclPower
						end
					elseif self.petInfo and self.petInfo:checkHasRace(data.attrType) then
						power = data.addPower
					end

					equipPowerTxt.text = tostring(power)
					lvLimitTxt.text = checknumber(data.limitLevel) > 0 and (petLv >= data.limitLevel and langPara("text_equip_desc_40", data.limitLevel) or langPara("text_equip_desc_41", data.limitLevel)) or lang("text_equip_desc_42")

					if isWear then
						petShowGo:SetActive(true)

						local petMo = BagPetsController.instance:getPet(data.equipPetId)

						MaterialMgr.setIcon(iconGo, MatType.Pet, petMo.raceId)

						equipWearTxt.text = lang("text_equip_replace")
					else
						petShowGo:SetActive(false)

						equipWearTxt.text = lang("text_equip_name")
					end

					ewRedPoint:SetActive(false)
					Framework.TransformUtil.SetLocalScale(equipItemGo.transform, 0.85, 0.85, 0.85)
					GameUtil.asBtn(equipWearBtnGo):AddClickListener(function()
						if petLv < data.limitLevel then
							if matType == MatType.Equipment then
								FloatWordMgr.instance:show(lang("text_equip_desc_43"))
							elseif matType == MatType.Decoration then
								FloatWordMgr.instance:show(lang("text_equip_desc_44"))
							end

							return
						end

						local function sureClick()
							self:close()

							if matType == MatType.Equipment then
								PetEquipController.instance:CSWearOneEquipReq(petId, onlyId)
							elseif matType == MatType.Decoration then
								PetEquipController.instance:CSWearDecorationReq(petId, onlyId)
							end
						end

						if isWear then
							local tempPetInfo = BagPetsController.instance:getPet(data.equipPetId)

							if tempPetInfo then
								if not tempPetInfo.name then
									local tempPetName = tostring(data.equipPetId)

									if self.petInfo then
										if not self.petInfo.name then
											local curPetName = tostring(data.baseId)
											local desStr = langPara("text_equip_desc_45", tempPetName, data.name, curPetName)

											UIStateManager.instance:open(ViewName.PetEquipTips, lang("text_equip_desc_46"), desStr, sureClick)
										end
									end
								end
							end
						else
							sureClick()
						end
					end, self)
				end
			end
		end
	end
end

function PetEquipListView:OnClickHuanjingBtn()
	if PetEquipModel.instance:OpenEquipHuanjingView() then
		self:close()
		MaterialChallengeController.instance:openChapterView(4)
	end
end

function PetEquipListView:_updateBagCell(view, cell, data, tag)
	local btnUse = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnUse")
	local txtDesc = goutil.findChildTextComponent(cell.gameObject, "txtDesc")
	local matName = MaterialMgr.getMaterialsName(data.matType, data.matId)

	txtDesc.text = string.format("背包-%s\n(库存：%s)", matName, data.matNum)

	btnUse:AddClickListener(function()
		ItemBagController.instance:openUsePanel(data.mo)
	end)
end

function PetEquipListView:_clearBagCell(cell)
	return
end

function PetEquipListView:_calAndShowBagCell()
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

							if ecfg and (ecfg.positionType == 5 or ecfg.positionType == 6) and ecfg.throneRelatedSkinId == self.petInfo.raceId then
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

function PetEquipListView:_checkUseContentMatch(content, type)
	local match = string.match(content, string.format("^%s:%%d+:%%d+", type))

	match = match or string.match(content, string.format("[%%D]%s:%%d+:%%d+", type))

	return match
end

return PetEquipListView
