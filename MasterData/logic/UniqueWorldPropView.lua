-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/uniqueworld/view/UniqueWorldPropView.lua

module("logic.extensions.uniqueworld.view.UniqueWorldPropView", package.seeall)

local UniqueWorldPropView = class("UniqueWorldPropView", ViewComponent)

function UniqueWorldPropView:ctor()
	UniqueWorldPropView.super.ctor(self)
end

function UniqueWorldPropView:unbindEvents()
	UniqueWorldPropView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnUse)
	GameUtil.rmClickHandler(self._btnUsePet)
end

function UniqueWorldPropView:bindEvents()
	UniqueWorldPropView.super.bindEvents(self)
	self._customInput:AddListener(self._onCustomInputCallback, self)
	GameUtil.addClickHandler(self._btnUse, self._onClickBtnUse, self)
	GameUtil.addClickHandler(self._btnUsePet, self._onClickBtnUsePet, self)
end

function UniqueWorldPropView:buildUI()
	UniqueWorldPropView.super.buildUI(self)

	self._Nego_Content = self:getGo("Nego_Content")
	self._customInput = UICustomInput.Get(self._Nego_Content)
	self._propDesc = self:getGo("Nego_Content/propDesc")
	self._txtDesc = self:getTxt("Nego_Content/propDesc/tip/txtDesc")
	self._txtName = self:getTxt("Nego_Content/propDesc/tip/txtName")
	self._item = self:getGo("Nego_Content/propDesc/item")
	self._btnUse = self:getGo("Nego_Content/propDesc/btnUse")
	self._propDescPet = self:getGo("Nego_Content/propDescPet")
	self._pet = self:getGo("Nego_Content/propDescPet/select/pet")
	self._dead = self:getGo("Nego_Content/propDescPet/select/dead")
	self._txtDescPet = self:getTxt("Nego_Content/propDescPet/tip/txtDesc")
	self._empty = self:getGo("Nego_Content/propDescPet/select/empty")
	self._emptyPetList = self:getGo("Nego_Content/propDescPet/empty")
	self._txtBlood = self:getTxt("Nego_Content/propDescPet/select/txtBlood")
	self._slider = self:getGo("Nego_Content/propDescPet/select/slider"):GetComponent(ComponentType.Slider)
	self._bloodChangeComp = self:getGo("Nego_Content/propDescPet/select/slider/FillArea/Fill"):GetComponent(ComponentType.UIImageColorChange)
	self._itemPet = self:getGo("Nego_Content/propDescPet/item")
	self._btnUsePet = self:getGo("Nego_Content/propDescPet/btnUse")
	self._txtNamePet = self:getTxt("Nego_Content/propDescPet/tip/txtName")
	self._tableview = self:getGo("Nego_Content/propDescPet/tableview")
	self._tablecell = self:getGo("Nego_Content/propDescPet/tableview/tablecell")
	self._scrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function UniqueWorldPropView:onExit()
	UniqueWorldPropView.super.onExit(self)
	self._scrollList:dispose()
	MaterialMgr.resetAll(self._item)
	MaterialMgr.resetAll(self._itemPet)
end

function UniqueWorldPropView:onEnter()
	UniqueWorldPropView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_UniqueWorldUseItemRes, self._onUseItemRes, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 584001
	end

	local pos = params[2]

	self._itemId = checknumber(params[3])

	local isPetProp = checkbool(params[4])
	local sizeData = {
		0,
		0
	}
	local itemCfg = UniqueWorldConfig.instance:getItemCfg(self._itemId)

	if itemCfg then
		if not itemCfg.effects then
			local effects = ""
			local effectArr = string.split(effects, "$")

			self._effectType = effectArr[1]
			self._selectCreepsId = 0

			local rect = self.mainGO.transform.rect

			GameUtil.AdjustWithSize(self._Nego_Content, pos, sizeData[1], sizeData[2], rect.width, rect.height, false)

			self._petHpMap = UniqueWorldModel.instance:getPetHpMap(self._activityId)
			self._itemMap = UniqueWorldModel.instance:getItemMap(self._activityId)

			if isPetProp then
				self:_setPetPropUI()
			else
				self:_setPropUI()
			end

			GameUtil.SetActive(self._propDesc, not isPetProp)
			GameUtil.SetActive(self._propDescPet, isPetProp)
		end
	end
end

function UniqueWorldPropView:_setPropUI()
	self._itemCfg = UniqueWorldConfig.instance:getItemCfg(self._itemId)

	local matStr = self._itemCfg.matStr

	self._txtName.text = self._itemCfg.name
	self._txtDesc.text = self._itemCfg.desc

	MaterialMgr.setCellByCfg(matStr, self._item)
end

function UniqueWorldPropView:_setPetPropUI()
	self._itemCfg = UniqueWorldConfig.instance:getItemCfg(self._itemId)

	local name = self._itemCfg.name
	local desc = self._itemCfg.desc
	local matStr = self._itemCfg.matStr
	local creepsIdList

	if self._effectType == UniqueWorldEnum.EffectType.AddHp then
		creepsIdList = UniqueWorldController.instance:getCurLoseHpPetCreepsIdList(self._activityId)
	elseif self._effectType == UniqueWorldEnum.EffectType.Recover then
		creepsIdList = UniqueWorldController.instance:getCurDiePetCreepsIdList(self._activityId)
	end

	creepsIdList = creepsIdList or {}
	self._txtNamePet.text = name
	self._txtDescPet.text = desc

	if #creepsIdList > 0 then
		self._scrollList:reloadData(creepsIdList)
	end

	GameUtil.SetActive(self._emptyPetList, #creepsIdList <= 0)
	GameUtil.SetActive(self._tableview, #creepsIdList > 0)
	GameUtil.SetActive(self._empty, true)
	GameUtil.SetActive(self._slider.gameObject, false)
	GameUtil.SetActive(self._dead, false)
	GameUtil.SetActive(self._pet, false)
	MaterialMgr.setCellByCfg(matStr, self._itemPet)
end

function UniqueWorldPropView:_updateCell(view, cell, data)
	local pet = goutil.findChild(cell, "pet")
	local dead = goutil.findChild(cell, "dead")
	local btnChoose = goutil.findChild(cell, "btnChoose")
	local slider = goutil.findChild(cell, "slider"):GetComponent(ComponentType.Slider)
	local sliderChangeComp = goutil.findChild(cell, "slider/FillArea/Fill"):GetComponent(ComponentType.UIImageColorChange)
	local txtBlood = goutil.findChildTextComponent(cell, "txtBlood")
	local petHp = checknumber(self._petHpMap[data])
	local petCfg = UniqueWorldConfig.instance:getSystemPetCfg(data)
	local raceId = petCfg.raceId
	local val = petHp / 10000

	if val < 0.01 and val > 0 then
		val = 0.01
	end

	local colorIdx = 2

	if val > 0.6 then
		colorIdx = 0
	elseif val >= 0.21 then
		colorIdx = 1
	end

	slider.value = val

	sliderChangeComp:SetState(colorIdx)

	txtBlood.text = string.format("%d%%", math.floor(val * 100))

	MaterialMgr.setCell(MatType.Pet, raceId, pet)
	GameUtil.SetActive(dead, petHp <= 0)
	GameUtil.SetActive(slider.gameObject, petHp > 0)
	GameUtil.SetActive(txtBlood.gameObject, petHp > 0)
	GameUtil.addClickHandler(btnChoose, function()
		self._selectCreepsId = data

		self:_updatePetPropDesc()
		GameUtil.SetActive(self._pet, true)
	end, self)
end

function UniqueWorldPropView:_clearCell(cell)
	local pet = goutil.findChild(cell, "pet")
	local btnChoose = goutil.findChild(cell, "btnChoose")

	GameUtil.rmClickHandler(btnChoose)
	MaterialMgr.resetAll(pet)
end

function UniqueWorldPropView:_updatePetPropDesc()
	local creepsId = checknumber(self._selectCreepsId)
	local petHp = 0

	if creepsId > 0 then
		local petCfg = UniqueWorldConfig.instance:getSystemPetCfg(creepsId)
		local raceId = petCfg.raceId

		petHp = checknumber(self._petHpMap[creepsId])

		local val = petHp / 10000

		if val < 0.01 and val > 0 then
			val = 0.01
		end

		local colorIdx = 2

		if val > 0.6 then
			colorIdx = 0
		elseif val >= 0.21 then
			colorIdx = 1
		end

		self._slider.value = val

		self._bloodChangeComp:SetState(colorIdx)

		self._txtBlood.text = string.format("%d%%", val * 100)

		MaterialMgr.setCell(MatType.Pet, raceId, self._pet)
	else
		MaterialMgr.resetAll(self._pet)
	end

	GameUtil.SetActive(self._dead, petHp <= 0 and creepsId > 0)
	GameUtil.SetActive(self._slider.gameObject, petHp > 0 and creepsId > 0)
	GameUtil.SetActive(self._txtBlood.gameObject, petHp > 0 and creepsId > 0)
	GameUtil.SetActive(self._empty, creepsId <= 0)
end

function UniqueWorldPropView:_onClickBtnUse()
	if self._itemId <= 0 then
		FloatWordMgr.instance:show("请选择要使用的道具")

		return
	end

	local itemNum = checknumber(self._itemMap[self._itemId])

	if itemNum <= 0 then
		FloatWordMgr.instance:show("道具数量不足，无法使用")

		return
	end

	local param = ""

	UniqueWorldController.instance:sendPM_UniqueWorldUseItemReq(self._activityId, self._itemId, param)
end

function UniqueWorldPropView:_onClickBtnUsePet()
	if self._selectCreepsId <= 0 then
		FloatWordMgr.instance:show("请选择要使用的精灵")

		return
	end

	local itemNum = checknumber(self._itemMap[self._itemId])

	if itemNum <= 0 then
		FloatWordMgr.instance:show("道具数量不足，无法使用")

		return
	end

	local curPetHp = checknumber(self._petHpMap[self._selectCreepsId])

	if self._effectType == UniqueWorldEnum.EffectType.AddHp then
		if curPetHp <= 0 then
			FloatWordMgr.instance:show("精灵已死亡，无法使用")

			return
		end
	elseif self._effectType == UniqueWorldEnum.EffectType.Recover and curPetHp > 0 then
		FloatWordMgr.instance:show("精灵尚未死亡，无法使用")

		return
	end

	local param = self._selectCreepsId .. ""

	UniqueWorldController.instance:sendPM_UniqueWorldUseItemReq(self._activityId, self._itemId, param)
end

function UniqueWorldPropView:_onUseItemRes()
	self._selectCreepsId = 0
	self._itemMap = UniqueWorldModel.instance:getItemMap(self._activityId)

	local name = self._itemCfg.name
	local creepsIdList

	if self._effectType == UniqueWorldEnum.EffectType.AddHp then
		creepsIdList = UniqueWorldController.instance:getCurLoseHpPetCreepsIdList(self._activityId)
	elseif self._effectType == UniqueWorldEnum.EffectType.Recover then
		creepsIdList = UniqueWorldController.instance:getCurDiePetCreepsIdList(self._activityId)
	end

	creepsIdList = creepsIdList or {}

	if #creepsIdList > 0 then
		self._scrollList:reloadData(creepsIdList)
	end

	GameUtil.SetActive(self._emptyPetList, #creepsIdList <= 0)
	GameUtil.SetActive(self._tableview, #creepsIdList > 0)
	GameUtil.SetActive(self._slider.gameObject, false)
	GameUtil.SetActive(self._txtBlood.gameObject, false)
	GameUtil.SetActive(self._dead, false)
	GameUtil.SetActive(self._pet, false)
	GameUtil.SetActive(self._empty, true)
	FloatWordMgr.instance:show(string.format("%s使用成功！", name))
end

function UniqueWorldPropView:_onCustomInputCallback(hover)
	if not hover then
		CommonTipsMgr.instance:doWillClose(self, hover)
	end
end

return UniqueWorldPropView
