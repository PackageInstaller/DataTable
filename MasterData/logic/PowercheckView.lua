-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/handbook/view/PowercheckView.lua

module("logic.extensions.handbook.view.PowercheckView", package.seeall)

local PowercheckView = class("PowercheckView", ViewComponent)

function PowercheckView:ctor()
	PowercheckView.super.ctor(self)
end

function PowercheckView:bindEvents()
	PowercheckView.super.bindEvents(self)
	GameUtil.addClickHandler(self.btnClose, self.onClickClose, self)
	GameUtil.addClickHandler(self.btnShare, self.onShare, self)
	GameUtil.addClickHandler(self.btnGoto, self.onGoto, self)
	GameUtil.addClickHandler(self.btnTip, self.onRule, self)
end

function PowercheckView:unbindEvents()
	PowercheckView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self.btnClose)
	GameUtil.rmClickHandler(self.btnShare)
	GameUtil.rmClickHandler(self.btnGoto)
	GameUtil.rmClickHandler(self.btnTip)
end

function PowercheckView:buildUI()
	PowercheckView.super.buildUI(self)

	self.btnClose = self:getGo("btnClose")
	self.btnTip = self:getGo("btnTip")
	self.txtTitle = self:getTxt("txtTitle")
	self.empty = self:getGo("empty")
	self.txtDesc = self:getTxt("empty/tipDesc/txtDesc")
	self.powerCheck = self:getGo("powerCheck")
	self.con = self:getGo("powerCheck/con")
	self.rare = self:getGo("powerCheck/petInfo/rare")
	self.txtName = self:getTxt("powerCheck/petInfo/txtName")
	self.txtPower = self:getTxt("powerCheck/maxPower/txtPower")
	self.btnShare = self:getGo("powerCheck/btnShare")
	self.petPower = self:getGo("powerCheck/petPower")
	self.imgFullNum = self:getGo("powerCheck/petPower/value/imgNum"):GetComponent(typeof(UIImgNumeralText))
	self.imgPureNum = self:getGo("powerCheck/petPower/value/imgNum2"):GetComponent(typeof(UIImgNumeralText))
	self.txtTip = self:getTxt("powerCheck/petPower/txtTip")
	self.infoDesc = self:getGo("powerCheck/infoDesc")
	self.imgScore = self:getGo("powerCheck/infoDesc/score/imgScore")
	self.cell = self:getGo("powerCheck/infoDesc/detail/cell")
	self.tableview = self:getGo("powerCheck/infoDesc/detail/tableview")
	self.itemTemp = self:getGo("powerCheck/infoDesc/detail/itemTemp")
	self.cellTemp = self:getGo("powerCheck/infoDesc/detail/cellTemp")
	self.skillTemp = self:getGo("powerCheck/infoDesc/detail/skillTemp")
	self.detail = self:getGo("powerCheck/infoDesc/detail")
	self.items = {}

	local conentGo = self:getGo("powerCheck/infoDesc/detail/tableviewStrength/Viewport/Content")

	for i = 1, 10 do
		local go = goutil.findChild(conentGo, "item_" .. i)

		table.insert(self.items, go)
	end

	self.btnGoto = self:getGo("powerCheck/infoDesc/commonPower/btnGoto")
	self.scrollList = ScrollerList.create(self.tableview, self.cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self.clearCell, self))
end

function PowercheckView:onExit()
	PowercheckView.super.onExit(self)
	MaterialMgr.resetAll(self.rare)

	self._loader = RoleObjectPool.instance:removeRole(self._loader)

	GlobalDispatcher:removeListener(GlobalNotify.HandBookPowerCheck, self.onRefreshUI, self)
end

function PowercheckView:onEnter()
	PowercheckView.super.onEnter(self)

	self.currSelectPetId = checknumber(self:getFirstParam())

	GlobalDispatcher:addListener(GlobalNotify.HandBookPowerCheck, self.onRefreshUI, self)

	if self.currSelectPetId > 0 then
		self:sendGetPetInfo(self.currSelectPetId)
	elseif PowerCheckModel.instance.currSelectedPetId > 0 then
		self.currSelectPetId = PowerCheckModel.instance.currSelectedPetId

		self:sendGetPetInfo(self.currSelectPetId)
	end

	self:onRefreshUI()
end

function PowercheckView:onRefreshUI()
	MaterialMgr.resetAll(self.rare)

	self._loader = RoleObjectPool.instance:removeRole(self._loader)

	GameUtil.SetActive(self.empty, true)
	GameUtil.SetActive(self.powerCheck, false)

	local petMo = MaterialMgr.getModel(MatType.Pet, self.currSelectPetId)

	if checknumber(self.currSelectPetId) > 0 and petMo then
		GameUtil.SetActive(self.empty, false)
		GameUtil.SetActive(self.powerCheck, true)

		self.curPetMo = petMo
		self.maxPetMo = FightingPowerFormula.instance:getRealMaxFightingPowerPetMo(petMo.raceId)

		local skinId = petMo.curFaceId
		local modelCfg = CharactorFacade.instance:getPetDisplayModelUIPosAndScale(skinId)

		if not modelCfg[1] then
			if not modelCfg[2] then
				local y = 0

				if not modelCfg[3] then
					local scale = 1

					self._loader = RoleObjectPool.instance:addRoleToParent(self._loader, skinId, self.con, scale, nil, true, modelCfg[1], y)

					local proxy = MaterialMgr.setCell(MatType.Rare, petMo.raceId, self.rare)

					if proxy then
						proxy.binder:setRare(petMo.rare)
					end

					self.txtName.text = MaterialMgr.getMaterialsName(MatType.PET_SKIN, skinId)

					local serverZdl = checknumber(PowerCheckModel.instance.areaMaxZdl)
					local overValue = checknumber(PowerCheckModel.instance.overPercent)
					local str = HandbookConfig.instance:getPowerCheckCommon("RATING_RANK_KEY")
					local arr = string.splitToNumber(str, "#")
					local idx = 0

					for i, v in ipairs(arr) do
						if overValue <= v then
							idx = i - 2

							break
						end
					end

					self.txtPower.text = serverZdl

					local zdl = petMo:getFightingPower()
					local petMoDuplicated = petMo:GetClone()

					petMoDuplicated.attrMo:resetPublicAttr()
					petMoDuplicated.attrMo:calcTotalAttrs()
					petMoDuplicated:refreshAllAttr()

					local baseZdl = petMoDuplicated:getFightingPower()

					self.imgFullNum:SetNum(zdl)
					self.imgPureNum:SetNum(baseZdl)

					self.txtTip.text = langPara("powercheckview__desc", overValue)

					GameUtil.setUIImageSpriteIdx(self.imgScore, idx)

					for k, v in pairs(self.items) do
						GameUtil.SetActive(v, false)
					end

					self:setLvlInfo(1, petMo)
					self:setTalentInfo(2, petMo)
					self:setEquipInfo(4, petMo)
					self:setStargodInfo(5, petMo)
					self:setHolyStripeInfo(8, petMo)
					self:setCutePetInfo(9, petMo)

					local petCfg = CharacterConfig.instance:getPetCo(petMo.raceId)

					if PetSkinConfig.instance:checkHasJob(petCfg.raceId, GameEnum.JobZhDefine.SourceTrace) then
						self:setSourceTraceInfo(10, petMo)
					end

					local list = HandbookConfig.instance:getPowerCheckDetailList()
					local temp = {}

					for i, v in ipairs(list) do
						if v.tag == 1 then
							-- block empty
						elseif v.group == 2 then
							table.insert(temp, v)
						end
					end

					self.scrollList:reloadData(temp)
				end
			end
		end
	end
end

function PowercheckView:clearCell(cell)
	return
end

function PowercheckView:_updateCell(view, cell, data, tag)
	local img = goutil.findChild(cell, "icon/img")
	local txtName = goutil.findChildTextComponent(cell, "txt")
	local txtValue = goutil.findChildTextComponent(cell, "txtValue")
	local sliderGo = goutil.findChild(cell, "slider")
	local maxGo = goutil.findChild(cell, "slider/MAX")
	local slider = Framework.SliderAdapter.Get(sliderGo)
	local arrow = goutil.findChild(cell, "arrow")

	GameUtil.setUIImageSpriteIdx(img, data.id - 7)
	GameUtil.setUIImageColorIdx(cell, (data.id + 1) % 2)

	txtName.text = data.keyName

	local zdl = 0
	local maxZdl = 1
	local attrMo = self.curPetMo.attrMo
	local attr = attrMo[data.value]
	local maxMo = self.maxPetMo.attrMo
	local attr2 = maxMo[data.value]

	if data.value == "assistAttr" then
		zdl = Mathf.Ceil(PetAssistModel.instance:GetTotalPowerCount() / 5)
		maxZdl = Mathf.Ceil(AttrMo.calcFightPowerByAttrs(attr2))
	else
		zdl = AttrMo.calcFightPowerByAttrs(attr)
		maxZdl = AttrMo.calcFightPowerByAttrs(attr2)
	end

	local per = zdl / maxZdl

	GameUtil.SetActive(maxGo, math.ceil(per * 100) >= 100)

	txtValue.text = math.ceil(per * 100) .. "%"

	slider:SetValue(math.min(1, per))
	self:setArrow(arrow, per, 1)
end

function PowercheckView:setArrow(arrow, per, idx)
	local top = goutil.findChild(arrow, "top")
	local arrowTxt = goutil.findChildTextComponent(arrow, "txt")
	local str = HandbookConfig.instance:getPowerCheckCommon("PROMOTE_KEY")
	local arr = string.splitToNumber(str, "#")
	local value1 = arr[1] / 100
	local value2 = arr[2] / 100
	local type = PowerCheckModel.TYPE_NONE

	if per <= value1 then
		GameUtil.SetActive(arrow, true)

		arrowTxt.text = lang("powercheckview__tips1")

		GameUtil.setUIGroupIdx(arrow, 1)

		type = PowerCheckModel.TYPE_LOW
	elseif value1 < per and per <= value2 then
		GameUtil.SetActive(arrow, true)
		GameUtil.setUIGroupIdx(arrow, 0)

		type = PowerCheckModel.TYPE_HIGH
		arrowTxt.text = lang("powercheckview__tips2")
	else
		GameUtil.SetActive(arrow, false)
	end

	GameUtil.rmClickHandler(top)
	GameUtil.addClickHandler(top, GameUtil.handler(self.onClickArrow, self, idx, type, per))
end

function PowercheckView:setLvlInfo(idx, petMo)
	local cell = self.items[idx]

	GameUtil.SetActive(cell, true)

	local arrow = goutil.findChild(cell, "arrow")
	local txtValue = goutil.findChildTextComponent(cell, "txtValue")
	local silder = Framework.SliderAdapter.GetFrom(cell, "slider")
	local maxGo = goutil.findChild(cell, "slider/MAX")

	txtValue.text = "Lv." .. petMo.level

	local petCo = CharacterConfig.instance:getPetCo(petMo.raceId)
	local max = petCo.maxLv
	local per = petMo.level / max

	silder:SetValue(per)
	GameUtil.SetActive(maxGo, per >= 1)
	self:setArrow(arrow, per, 3)
end

function PowercheckView:setTalentInfo(idx, petMo)
	local cell = self.items[idx]

	GameUtil.SetActive(cell, true)

	local arrow = goutil.findChild(cell, "arrow")
	local txtValue = goutil.findChildTextComponent(cell, "txtValue")
	local silder = Framework.SliderAdapter.GetFrom(cell, "slider")
	local maxGo = goutil.findChild(cell, "slider/MAX")

	txtValue.text = CharacterConfig.instance:getTalentName(petMo.raceId, petMo.talentLevel)

	local max = FightingPowerPetMo._getMaxTalentLevel(petMo.raceId) or 1
	local per = checknumber(petMo.talentLevel) / max

	silder:SetValue(per)
	GameUtil.SetActive(maxGo, per >= 1)
	self:setArrow(arrow, per, 4)
end

function PowercheckView:setHolyStripeInfo(idx, petMo)
	local cell = self.items[idx]

	GameUtil.SetActive(cell, true)

	local arrow = goutil.findChild(cell, "arrow")
	local txtValue = goutil.findChildTextComponent(cell, "txtValue")
	local silder = Framework.SliderAdapter.GetFrom(cell, "slider")
	local maxGo = goutil.findChild(cell, "slider/MAX")
	local petHolyStripesAttr = HolyStripeModel.instance:calcByHolyStripeAttrs(petMo.holyStripes, true)
	local num = AttrMo.calcFightPowerByAttrs(petMo.attrMo.petHolyStripesAttr)
	local max = AttrMo.calcFightPowerByAttrs(self.maxPetMo.attrMo.petHolyStripesAttr)
	local per = 0

	if num ~= 0 then
		per = num / max
	end

	silder:SetValue(per)

	txtValue.text = math.floor(per * 100) .. "%"

	GameUtil.SetActive(maxGo, per >= 1)
	self:setArrow(arrow, per, 8)
end

function PowercheckView:setEquipInfo(idx, petMo)
	local cell = self.items[idx]

	GameUtil.SetActive(cell, true)

	local arrow = goutil.findChild(cell, "arrow")
	local itemCon = goutil.findChild(cell, "itemCon")
	local txtValue = goutil.findChildTextComponent(cell, "txtValue")
	local silder = Framework.SliderAdapter.GetFrom(cell, "slider")
	local maxGo = goutil.findChild(cell, "slider/MAX")
	local maxEquips = FightingPowerFormula.instance:parsEequipmentsClient("&100", petMo.raceId, petMo.curFaceId)

	txtValue.text = ""

	local list = {}
	local exclInfo = {}

	for _, v in pairs(petMo.equipments) do
		if v.defineId and v.lv then
			local equipInfo = EquipInfoMo.New()

			exclInfo.exclRaceId = checknumber(v.bonusRaceId)
			exclInfo.wearOnlyId = checknumber(petMo.petId)

			equipInfo:GetTemporaryEquip(v.defineId, v.lv, exclInfo)
			table.insert(list, equipInfo)
		else
			local equip = PetEquipModel.instance:GetEquipInfo(v.id)

			if equip then
				table.insert(list, equip)
			end
		end
	end

	goutil.clearChildren(itemCon)

	for i, v in ipairs(list) do
		local item = goutil.clone(self.itemTemp)

		GameUtil.SetActive(item, true)
		MaterialMgr.setCellByMo(v, item)
		goutil.addChildToParent(item, itemCon)
	end

	local num = FightingPowerFormula.instance:getEquipFightingPower(petMo.raceId, petMo.curFaceId, petMo.equipments)
	local max = FightingPowerFormula.instance:getEquipFightingPower(petMo.raceId, petMo.curFaceId, maxEquips)
	local per = num / max

	self:setArrow(arrow, per, 6)
	silder:SetValue(per)
	GameUtil.SetActive(maxGo, per >= 1)

	txtValue.text = math.floor(per * 100) .. "%"
end

function PowercheckView:setStargodInfo(idx, petMo)
	local cell = self.items[idx]

	GameUtil.SetActive(cell, true)

	local arrow = goutil.findChild(cell, "arrow")
	local itemCon = goutil.findChild(cell, "itemCon")
	local txtValue = goutil.findChildTextComponent(cell, "txtValue")
	local silder = Framework.SliderAdapter.GetFrom(cell, "slider")
	local maxGo = goutil.findChild(cell, "slider/MAX")

	txtValue.text = ""

	goutil.clearChildren(itemCon)

	local slotDatas = petMo:getStarGodPlusSlots()

	for _, slotData in ipairs(slotDatas) do
		if slotData.fillerDefineId > 0 then
			local item = goutil.clone(self.itemTemp)

			GameUtil.SetActive(item, true)

			local cell = goutil.clone(self.cellTemp)

			GameUtil.SetActive(cell, true)
			goutil.addChildToParent(cell, item)
			GameUtil.setLocalPos(cell, 0, 0, 0)
			goutil.addChildToParent(item, itemCon)

			local iconGo = goutil.findChild(cell, "icon")
			local raycast = goutil.findChild(cell, "raycast")
			local lockGo = goutil.findChild(cell, "lock")
			local lvText = goutil.findChildTextComponent(cell, "lvText")
			local lv = StargodplusModel.instance:getSlotLv(slotData.slot, slotData.exp)

			lvText.text = "Lv." .. lv

			MaterialMgr.setIcon(iconGo, MatType.StarGodPlus, slotData.fillerDefineId)
		end
	end

	local starGodPlusSlots = {}
	local petCo = MaterialMgr.getMatCfg(MatType.Pet, petMo.raceId) or {}
	local petskinCfg = PetSkinConfig.instance:getPetSkinCfg(petMo.curFaceId)
	local starIds = petskinCfg.recommendClient

	for i, v in ipairs(starIds or {}) do
		if StargodplusConfig.instance:getFillerCfg(v) then
			local star = {}

			star.slot = i

			local _, exp = StargodplusModel.instance:getMaxSlotLevel(i)

			star.exp = exp
			star.fillerDefineId = v

			table.insert(starGodPlusSlots, star)
		else
			printError(">>>>>>>>>>>>>>>>>>>> 配置的推荐星神错误，faceId_starId:", petMo.curFaceId, v)
		end
	end

	local attrs = StargodplusModel.instance:calcStarGodPlusAttrs(slotDatas)
	local attrsMax = StargodplusModel.instance:calcStarGodPlusAttrs(starGodPlusSlots)
	local num = AttrMo.calcFightPowerByAttrs(attrs)
	local max = AttrMo.calcFightPowerByAttrs(attrsMax)
	local per = num / max

	self:setArrow(arrow, per, 5)

	txtValue.text = math.floor(per * 100) .. "%"

	silder:SetValue(per)
	GameUtil.SetActive(maxGo, per >= 1)
end

function PowercheckView:setCutePetInfo(idx, petMo)
	local cell = self.items[idx]

	GameUtil.SetActive(cell, true)

	local arrow = goutil.findChild(cell, "arrow")
	local txtValue = goutil.findChildTextComponent(cell, "txtValue")
	local silder = Framework.SliderAdapter.GetFrom(cell, "slider")
	local maxGo = goutil.findChild(cell, "slider/MAX")
	local petCutePetAttr = CutePetModel.instance:calcByCutePetAttrs(petMo.cutePetShelter, true)
	local num = AttrMo.calcFightPowerByAttrs(petMo.attrMo.petCutePetAttr)
	local max = AttrMo.calcFightPowerByAttrs(self.maxPetMo.attrMo.petCutePetAttr)
	local per = 0

	if num ~= 0 then
		per = num / max
	end

	per = math.min(per, 1)

	silder:SetValue(per)

	txtValue.text = math.floor(per * 100) .. "%"

	GameUtil.SetActive(maxGo, per >= 1)
	self:setArrow(arrow, per, 9)
end

function PowercheckView:setSourceTraceInfo(idx, petMo)
	local cell = self.items[idx]

	GameUtil.SetActive(cell, true)

	local arrow = goutil.findChild(cell, "arrow")
	local txtValue = goutil.findChildTextComponent(cell, "txtValue")
	local silder = Framework.SliderAdapter.GetFrom(cell, "slider")
	local maxGo = goutil.findChild(cell, "slider/MAX")
	local petSourceTraceAttr = SourceTraceController.instance:calcBySourceTracesAttrs(petMo.sourceTraces, true)
	local num = AttrMo.calcFightPowerByAttrs(petMo.attrMo.petSourceTraceAttr)
	local max = AttrMo.calcFightPowerByAttrs(self.maxPetMo.attrMo.petSourceTraceAttr)
	local per = 0

	if num ~= 0 then
		per = num / max
	end

	per = math.min(per, 1)

	silder:SetValue(per)

	txtValue.text = math.floor(per * 100) .. "%"

	GameUtil.SetActive(maxGo, per >= 1)
	self:setArrow(arrow, per, 10)
end

function PowercheckView:onClickArrow(idx, type, per)
	print(">>>>>>>>>>>>>>>>>>>>>>>>>>> onClickArrowonClickArrow", idx, type)
	StrongerFacade.instance:openStrongerView(idx)
end

function PowercheckView:onRule()
	UIStateManager.instance:open(ViewName.RulesView, "powercheck_rule")
end

function PowercheckView:onClickClose()
	self:close()
end

function PowercheckView:sendGetPetInfo(petId)
	local petMo = BagPetsController.instance:getPet(petId)

	if petMo and petMo:isExist() then
		PowerCheckModel.instance:resetInfo()

		PowerCheckModel.instance.currSelectedPetId = petId

		PowerCheckController.instance:sendCalZdlAndRankReq(petId)
	else
		PowerCheckModel.instance.currSelectedPetId = -1
	end
end

function PowercheckView:onShare()
	local petMo = MaterialMgr.getModel(MatType.Pet, self.currSelectPetId)

	if self.currSelectPetId > 0 and petMo then
		if checknumber(PowerCheckModel.instance.overPercent) >= 0 then
			local obj = {}

			obj.petName = petMo.name
			obj.zdl = petMo:getFightingPower()
			obj.overPercent = checknumber(PowerCheckModel.instance.overPercent)

			UIStateManager.instance:push(ViewName.Share, GameEnum.ShareType.PowerCheck, obj)
		else
			TipsFacade.instance:openCommonTips(lang("powercheckview__err_tips"))
		end
	end
end

function PowercheckView:onGoto()
	local petMo = MaterialMgr.getModel(MatType.Pet, self.currSelectPetId)

	if self.currSelectPetId > 0 and petMo then
		UIStateManager.instance:push(ViewName.ExtremepowerView, petMo)
	end
end

return PowercheckView
