-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/itembag/stack/ItemequipstackView.lua

module("logic.extensions.itembag.stack.ItemequipstackView", package.seeall)

local ItemequipstackView = class("ItemequipstackView", ViewComponent)

function ItemequipstackView:ctor()
	ItemequipstackView.super.ctor(self)
end

function ItemequipstackView:buildUI()
	ItemequipstackView.super.buildUI(self)

	self.layoutGroup = self:getGo("info/btnsGrid"):GetComponent("GridLayoutGroup")
	self.layoutGroup.enabled = false
	self._sellButton = self:getBtn("info/btnsGrid/BtnSell")
	self._useButton = self:getBtn("info/btnsGrid/BtnUse")
	self._mergeButton = self:getBtn("info/btnsGrid/BtnMerge")
	self._sourceBtn = self:getBtn("info/btnSource")
	self._nameTxt = self:getTxt("info/txtName")
	self.group = self:getGo("info/txtName"):GetComponent("UIChangeGroup")
	self._descTxt = self:getGo("info/bottom/ScrollView/Viewport/content/txtDesc"):GetComponent("Text")
	self.itemCell = self:getGo("info/item_equip")
	self.txtNum = self:getTxt("info/txtPower")
	self.ImgC_Line = self:getGo("info/ImgC_Line")
	self.jobcell = self:getGo("info/jobcell")
	self.attrcell = self:getGo("info/attrcell")
	self.attrupcell = self:getGo("info/attrupcell")
	self.txtJob = self:getTxt("info/jobcell/txtJob")
	self.txtAttr = self:getTxt("info/attrcell/txtAttr")
	self.txtDesc = self:getTxt("info/attrupcell/txtDesc")
	self.cell = self:getGo("info/cell")
	self.ScrollView = self:getGo("info/ScrollView")
	self._tableview = ScrollerList.create(self.ScrollView, self.cell, GameUtil.handler(self._updateCell, self))
end

function ItemequipstackView:bindEvents()
	ItemequipstackView.super.bindEvents(self)
	self._sellButton:AddClickListener(self._onClickSell, self)
	self._useButton:AddClickListener(self._onClickUse, self)
	self._mergeButton:AddClickListener(self._onClickMerge, self)
	self._sourceBtn:AddClickListener(self._onClickSource, self)
end

function ItemequipstackView:unbindEvents()
	ItemequipstackView.super.unbindEvents(self)
	self._sellButton:RemoveClickListener()
	self._useButton:RemoveClickListener()
	self._mergeButton:RemoveClickListener()
	self._sourceBtn:RemoveClickListener()
end

function ItemequipstackView:destroyUI()
	ItemequipstackView.super.destroyUI(self)
end

function ItemequipstackView:onEnter()
	ItemequipstackView.super.onEnter(self)
	self:_refreshList()
	GlobalDispatcher:addListener(ItemBagModel.UPDATE_SELECT_ITEM, self._refreshList, self)
end

function ItemequipstackView:onEnterFinished()
	ItemequipstackView.super.onEnterFinished(self)
end

function ItemequipstackView:onExit()
	ItemequipstackView.super.onExit(self)
	GlobalDispatcher:removeListener(ItemBagModel.UPDATE_SELECT_ITEM, self._refreshList, self)
	self._tableview:dispose()
end

function ItemequipstackView:onExitFinished()
	ItemequipstackView.super.onExitFinished(self)
end

function ItemequipstackView:_onClickSell()
	return
end

function ItemequipstackView:_onClickUse()
	local data = ItemBagModel.instance:getCurrItem()

	if data then
		PetEquipController.instance:setCurrentEquipInfoMo(data)
		UIStateManager.instance:push(ViewName.EquipFunction, PetEquipModel.FunctionType.SttnType)
	end
end

function ItemequipstackView:_onClickMerge()
	local data = ItemBagModel.instance:getCurrItem()

	if data and data:isCanTupo() then
		PetEquipController.instance:setCurrentEquipInfoMo(data)
		UIStateManager.instance:push(ViewName.EquipFunction, PetEquipModel.FunctionType.TupoType)
	end
end

function ItemequipstackView:_onClickSource()
	local data = ItemBagModel.instance:getCurrItem()

	if data then
		FloatWordMgr.instance:show(lang("暂无物品来源"))
	end
end

function ItemequipstackView:_updateCell(view, cell, data)
	local colorSp = GameUtil.getUIImageColorChange(cell)
	local attrIconSpt = goutil.findChildComponent(cell, "attrIcon", "UIImageSpriteChange")
	local qhNameTxt = goutil.findChildTextComponent(cell, "attrName")
	local qhNowCountTxt = goutil.findChildTextComponent(cell, "txtNum")
	local name = data.name
	local value = data.value
	local idx = table.indexof(GameEnum.AttrTypeName, name)

	if idx == false then
		print(">>>>>>>>>>>", dump(data))
	end

	attrIconSpt:SetState(idx - 1)
	colorSp:SetState((cell.data + 1) % 2)

	qhNameTxt.text = name
	qhNowCountTxt.text = GameUtil.getValueOrPercent(value)
end

function ItemequipstackView:_refreshList()
	local data = ItemBagModel.instance:getCurrItem()
	local type = MaterialMgr.getMoType(data)

	if type == MatType.Equipment then
		self:_refreshTip(data)
	elseif type == MatType.Decoration then
		self:_refreshTip2(data)
	end
end

function ItemequipstackView:_refreshTip2(data)
	self._nameTxt.text = data.name
	self.txtJob.text = table.concat(data.jobTypeList, "、")
	self.txtAttr.text = data.limitLevel > 0 and data.limitLevel or lang("无")

	local cfgId = data:getDefineId()
	local type = MaterialMgr.getMoType(data)
	local cfg = MaterialMgr.getMatCfg(type, cfgId)
	local mo = MaterialMgr.getModel(type, data.onlyId)

	self.txtDesc.text = ""

	self.group:SetState(1 + (data.qualityBase or 0))

	local proxy = MaterialMgr.setCellByMo(mo, nil, self.itemCell)

	if proxy then
		proxy:setAutoTips(false)
	end

	local attrValues = {}

	for i = 1, #data.addAttrs do
		if data.addAttrs[i] and data.addAttrs[i].proertyType and checknumber(data.addAttrs[i].value) > 0 then
			local valueType = data.addAttrs[i].proertyType
			local k = GameEnum.AttrTypeName[valueType]

			table.insert(attrValues, {
				name = k,
				value = data.addAttrs[i].value
			})
		end
	end

	self._tableview:reloadData(attrValues)

	self.txtNum.text = data.commPower

	self._sellButton.gameObject:SetActive(false)
	self._useButton.gameObject:SetActive(false)
	self._mergeButton.gameObject:SetActive(false)

	if FuncOpenModel.instance:getFuncIsOpen(50) then
		if data:isCanStrengthen() then
			self._useButton.gameObject:SetActive(true)
		end

		if data:isCanTupo() then
			self._mergeButton.gameObject:SetActive(true)
		end
	end

	self.layoutGroup:CalculateLayoutInputHorizontal()
	self.layoutGroup:CalculateLayoutInputVertical()
	self.layoutGroup:SetLayoutHorizontal()
	self.layoutGroup:SetLayoutVertical()
end

function ItemequipstackView:_refreshTip(data)
	self._nameTxt.text = data.name
	self.txtJob.text = data:isEquipArtifact() and (PetSkinConfig.instance:getPetSkinCfg(data.sqSkinId) and MaterialMgr.getMaterialsName(MatType.PET_SKIN, data.sqSkinId) or MaterialMgr.getMaterialsName(MatType.Pet, data.sqSkinId)) or table.concat(data.jobTypeList, "、")
	self.txtAttr.text = data.limitLevel > 0 and data.limitLevel or lang("无")

	local cfgId = data:getDefineId()
	local lvl = data.starCount
	local cfg = EquipmentConfig.instance:GetEquipDefineInfoById(cfgId)
	local equipInfo = EquipmentConfig.instance:GetEquipInfoByLvl(cfg.equipmentLvStrategy, lvl)
	local ratioStr = data:getEquipAddPercent()

	if checknumber(data.exclRaceId) > 0 then
		do
			local petCfg = MaterialMgr.getMatCfg(MatType.Pet, data.exclRaceId)

			if petCfg then
				if not petCfg.name then
					local petName = "精灵"

					self.txtDesc.text = langPara("text_equip_desc_34", petName, ratioStr)
				end
			end
		end
	elseif string.nilorempty(data.attrType) or data.attrType == "无" then
		self.txtDesc.text = string.format("该装备无特殊加成")
	end

	self.txtDesc.text = string.format("%s属性精灵成功穿戴后，装备属性提升<color=#059A50FF>%s</color>", data.attrType, ratioStr)

	self.group:SetState(1 + (cfg.qualityBase or 0))

	local proxy = MaterialMgr.setCellByMo(data, nil, self.itemCell)

	if proxy then
		proxy:setAutoTips(false)
	end

	local curArr = GameUtil.propToList({
		equipInfo.propertyApp
	})

	self._tableview:reloadData(curArr)

	local res = FightingPowerFormula.instance:parseAttrValues(equipInfo.propertyApp) or {}

	self.txtNum.text = AttrMo.calcFightPowerByAttrs(res)

	self._sellButton.gameObject:SetActive(false)
	self._useButton.gameObject:SetActive(false)
	self._mergeButton.gameObject:SetActive(false)

	if FuncOpenModel.instance:getFuncIsOpen(50) then
		if data:isCanStrengthen() then
			self._useButton.gameObject:SetActive(true)
		end

		if data:isCanTupo() then
			self._mergeButton.gameObject:SetActive(true)
		end
	end

	self.layoutGroup:CalculateLayoutInputHorizontal()
	self.layoutGroup:CalculateLayoutInputVertical()
	self.layoutGroup:SetLayoutHorizontal()
	self.layoutGroup:SetLayoutVertical()
end

return ItemequipstackView
