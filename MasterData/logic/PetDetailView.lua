-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/share/view/PetDetailView.lua

module("logic.extensions.share.view.PetDetailView", package.seeall)

local PetDetailView = class("PetDetailView", TableViewComponent)

function PetDetailView:_getPath()
	return {
		cellPath = "equips/tablecell",
		viewPath = "equips/tableview"
	}
end

local AttrRank = {
	GameEnum.AttrType.Hp,
	GameEnum.AttrType.Attack,
	GameEnum.AttrType.DefensePhysical,
	GameEnum.AttrType.DefenseMagic
}
local AttrName = {
	[GameEnum.AttrType.Attack] = "_attack",
	[GameEnum.AttrType.DefensePhysical] = "_physicalDefence",
	[GameEnum.AttrType.DefenseMagic] = "_magicDefence",
	[GameEnum.AttrType.Hp] = "_maxHp",
	[GameEnum.AttrType.Speed] = "_speed",
	[GameEnum.AttrType.HitRate] = "_hitRate",
	[GameEnum.AttrType.DodgeRate] = "_dodgeRate",
	[GameEnum.AttrType.StrikeRate] = "_strikeRate",
	[GameEnum.AttrType.BlockRate] = "_blockRate",
	[GameEnum.AttrType.CriticalRate] = "_criticalRate",
	[GameEnum.AttrType.AntiCriticalRate] = "_antiCriticalRate"
}

function PetDetailView:unbindEvents()
	PetDetailView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnRune:RemoveClickListener()
	GameUtil.rmClickHandler(self._Btn_CutePet)
	GameUtil.rmClickHandler(self._searchGo)
	GameUtil.rmClickHandler(self._searchBtnClear)
	GameUtil.rmClickHandler(self._btnPut)
	self._inputSearch:RemoveOnValueChanged()
end

function PetDetailView:bindEvents()
	PetDetailView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnTip:AddClickListener(self._onClickMore, self)
	self._btnRune:AddClickListener(self._onClickRune, self)
	GameUtil.addClickHandler(self._Btn_CutePet, self._OnClickCutePet, self)
	GameUtil.addClickHandler(self._searchGo, self._OnSearchTextChanged, self)
	GameUtil.addClickHandler(self._searchBtnClear, self._onClearSearch, self)
	self._inputSearch:AddOnValueChanged(self._OnSearchTextChanged, self)
	GameUtil.addClickHandler(self._btnPut, self._OnClickPut, self)
end

function PetDetailView:onExit()
	PetDetailView.super.onExit(self)
	MaterialMgr.resetAll(self.itemCon)

	for i = 1, #self.starGodPlus do
		local cell = self.starGodPlus[i]
		local iconGo = goutil.findChild(cell, "icon")

		MaterialMgr.clearIcon(iconGo)
	end

	for i = 1, #self._Skills do
		local go = self._Skills[i]
		local con = goutil.findChild(go, "icon")

		MaterialMgr.resetAll(con)
		GameUtil.asBtn(go):RemoveClickListener()
	end

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
	end

	self._cutePetMo = nil

	MaterialMgr.clearIcon(self._cutePetIcon)

	if self._matList then
		for k, v in pairs(self._matList) do
			goutil.destroy(v)

			self._matList[k] = nil
		end
	end

	self:_onClearHolyStripesUI()
end

function PetDetailView:buildUI()
	PetDetailView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self.itemCon = self:getGo("itemPet")
	self._txtName = goutil.findChildTextComponent(self.mainGO, "txtName")
	self._rarePoint = goutil.findChild(self.mainGO, "rarePoint")
	self._txtRare = goutil.findChildTextComponent(self.mainGO, "txtRare")
	self._txtTalent = goutil.findChildTextComponent(self.mainGO, "talent/txtTalent")
	self._btnRune = self:getBtn("rune/btnRune")
	self._runeGo = self:getGo("rune/btnRune/runeGo")
	self._imgRuneChange = goutil.findChildComponent(self._runeGo, "imgIcon", "UIImageSpriteChange")
	self._txtRuneName = goutil.findChildTextComponent(self._runeGo, "txtName")
	self._rolePoint = self:getGo("mask/rolePoint")
	self._emptyEquips = self:getGo("equips/empty")
	self._emptyStarGod = self:getGo("starGod/empty")
	self._emptyHolyStripes = self:getGo("holyStripes/empty")
	self._txtPower = goutil.findChildTextComponent(self.mainGO, "power/txtPower")

	local _Nego_Attr = self:getGo("attrs/Attrs")

	self._Nego_Attr = _Nego_Attr
	self._Attrs = {}

	for k, _ in ipairs(AttrRank) do
		local go = self._viewPresentor:getResInstance(ItemAttr.ResPath)

		go.transform:SetParent(_Nego_Attr.transform, false)
		go.transform:SetAsLastSibling()

		self._Attrs[#self._Attrs + 1] = go
	end

	self._btnTip = self:getBtn("attrs/btnTip")
	self._imgAttr = goutil.findChildComponent(self.mainGO, "attr/icon", "UIImageSpriteChange")
	self._imgJob = goutil.findChildComponent(self.mainGO, "job/icon", "UIImageSpriteChange")
	self._imgJob1 = goutil.findChildComponent(self.mainGO, "job1/icon", "UIImageSpriteChange")
	self._goJob1 = self:getGo("job1")
	self.awake = self:getGo("awake")
	self.btnAwake = self:getGo("awake/btnAwake")
	self.imgAwake = self:getGo("awake/btnAwake/imgLv")
	self.starGodPlus = {}

	for i = 1, 4 do
		local starGodCell = self:getGo("starGod/cell_" .. i)

		table.insert(self.starGodPlus, starGodCell)
		GameUtil.SetActive(starGodCell, false)
	end

	self:_buildSkillsView()

	self._txtPetTitle = self:getTxt("petTitle/txtPetTitle")
	self._Btn_CutePet = goutil.findChild(self.mainGO, "Btn_CutePet"):GetComponent("UIImageSpriteChange")
	self._cutePetIcon = goutil.findChild(self.mainGO, "Btn_CutePet/Icon")
	self._emptyPetIcon = goutil.findChild(self.mainGO, "Btn_CutePet/empty")
	self._hsScrView = goutil.findChild(self.mainGO, "holyStripes/scrView")
	self._hsScrCell = goutil.findChild(self.mainGO, "holyStripes/scrCell")
	self._hsScrollerList = ScrollerList.create(self._hsScrView, self._hsScrCell, GameUtil.handler(self._updateHsCell, self), GameUtil.handler(self._clearHsCell, self))
	self._searchGo = goutil.findChild(self.mainGO, "InputC_Search")
	self._searchBtnClear = goutil.findChild(self.mainGO, "InputC_Search/BtnClear")
	self._inputSearch = self:getInput("InputC_Search")
	self._btnPut = goutil.findChild(self.mainGO, "btnPut")
end

function PetDetailView:_buildSkillsView()
	local skillCell = goutil.findChild(self.mainGO, "skills/Viewport/Content/cell")

	goutil.setActive(skillCell, false)

	self._skillViewContent = goutil.findChild(self.mainGO, "skills/Viewport/Content").transform
	self._Skills = {}

	local sortedKeys = MaterialMgr.getAllSkillsSortedKeys()

	for index, skillType in ipairs(sortedKeys) do
		local go = goutil.clone(skillCell)

		go.transform:SetParent(self._skillViewContent, false)

		self._Skills[#self._Skills + 1] = go
	end
end

function PetDetailView:onEnter()
	PetDetailView.super.onEnter(self)

	local petMo = self:getFirstParam()

	self._mo = petMo

	if not self._mo.cutePetShelter then
		local cutePetShelter = {}
		local cutePetRaceId = checknumber(cutePetShelter.cutePetRaceId)
		local cutePetId = checknumber(cutePetShelter.cutePetId)

		if cutePetRaceId > 0 then
			self._cutePetMo = CutePetMo.New()

			self._cutePetMo:initDataByMsg(cutePetShelter)
		elseif cutePetId > 0 then
			self._cutePetMo = CutePetModel.instance:getCutePeMo(cutePetId)
		end

		self._holyStripes = petMo.holyStripes

		local proxy = MaterialMgr.setCellByData(MatType.Pet, petMo, self.itemCon)

		if proxy then
			proxy.binder:setAutoTips(false)
		end

		GameUtil.setUIImageSpriteIdx(self.imgAwake, petMo.awakeLevel)
		self:_updateStarGodPlus(petMo)

		if petMo.runeSuit and petMo.runeSuit.runeSuitId > 0 then
			GameUtil.SetActive(self._runeGo, true)

			local cfg = MaterialMgr.getMatCfg(MatType.Rune_Suit, petMo.runeSuit.runeSuitId)

			self._imgRuneChange:SetState(petMo.runeSuit.runeSuitId - 1)

			self._txtRuneName.text = cfg.name
		else
			GameUtil.SetActive(self._runeGo, false)
		end

		local petCfg = CharacterConfig.instance:getPetCo(petMo.raceId)

		self:_updateRole(checknumber(petMo.curFaceId))
		self:_updateAttrs(petMo)
		self:_updateSkill(petMo)

		self._txtName.text = not string.nilorempty(petMo.skinOtherName) and petMo.skinOtherName or petMo.name
		self._txtTalent.text = CharacterConfig.instance:getTalentName(petMo.raceId, petMo.talentLevel)

		self:_updateEquips(petMo)

		self._txtRare.text = ConstString.PetRareLang[petMo.rare]

		self:_updateRace(petMo.raceId, petMo.curFaceId)

		self._txtPower.text = petMo:getFightingPower()

		Framework.TransformUtil.SetAnchoredPos(self._skillViewContent, 0, 0)
		self:_updatePetTitle(petMo)
		self:_setCutePet()
		self:_onUpdateHolyStripesUI()
		GameUtil.SetActive(self._searchGo, enableDebug)
		GameUtil.SetActive(self._btnPut, enableDebug)
	end
end

function PetDetailView:_updatePetTitle(petMo)
	local petTitleName = lang("暂无称号")

	if petMo and petMo.petTitleId and petMo.petTitleId > 0 then
		local petTitleConf = PetTitleConfig.instance:getPetTitleConfig(petMo.petTitleId)

		if petTitleConf then
			petTitleName = petTitleConf.name
		end
	end

	self._txtPetTitle.text = petTitleName
end

function PetDetailView:_updateRole(raceId)
	local displayBagOffset = CharactorFacade.instance:getCommonLiHuiUIPosAndScale(raceId)

	if not displayBagOffset[3] then
		local x, y, scale = checknumber(displayBagOffset[1]), checknumber(displayBagOffset[2]), 1

		self._role = RoleObjectPool.instance:addRoleToParent(self._role, raceId, self._rolePoint, displayBagOffset[3], function(go)
			if self._matList == nil then
				self._matList = {}
			end

			local list = go:GetComponentsInChildren(typeof(Spine.Unity.SkeletonGraphic), true)

			for i = 0, list.Length - 1 do
				local skeletonGraphic = list[i]
				local mat = self._matList[i]

				if mat == nil then
					mat = UnityEngine.Material.New(Framework.ShaderCache.Find("Spine/SkeletonGraphic (Premultiply Alpha)"))
					self._matList[i] = mat
				end

				mat.mainTexture = skeletonGraphic.material.mainTexture
				skeletonGraphic.material = mat
			end
		end, true, x, y)
	end
end

function PetDetailView:_updateStarGodPlus(petMo)
	local actCount = 0

	if petMo then
		local slotDatas = petMo:getStarGodPlusSlots()

		for i = 1, #self.starGodPlus do
			local cell = self.starGodPlus[i]

			GameUtil.rmClickHandler(cell)

			if slotDatas then
				if not slotDatas[i] then
					local slotData

					if slotData and slotData.fillerDefineId > 0 then
						actCount = actCount + 1

						GameUtil.SetActive(cell, true)

						local iconGo = goutil.findChild(cell, "icon")
						local effectGo = goutil.findChild(cell, "effect")
						local raycast = goutil.findChild(cell, "raycast")
						local btn = GameUtil.asBtn(cell)
						local lockGo = goutil.findChild(cell, "lock")
						local addGo = goutil.findChild(cell, "add")
						local nameText = goutil.findChildTextComponent(cell, "nameText")
						local lvText = goutil.findChildTextComponent(cell, "lvText")
						local lockTip = goutil.findChildTextComponent(lockGo, "lockTip")
						local nameTextColorChange = nameText.gameObject:GetComponent(ComponentType.UITextColorChange)
						local lv = StargodplusModel.instance:getSlotLv(slotData.slot, slotData.exp)

						lvText.text = "Lv." .. lv
						nameText.text = MaterialMgr.getMaterialsName(MatType.StarGodPlus, slotData.fillerDefineId)

						MaterialMgr.setIcon(iconGo, MatType.StarGodPlus, slotData.fillerDefineId)

						local cfg = StargodplusConfig.instance:getFillerCfg(slotData.fillerDefineId)
						local quality = checknumber(cfg.quality)

						nameTextColorChange:SetState(quality)
						GameUtil.addClickHandler(cell, GameUtil.handler(self.onClickStarGodPlusCell, self, cell, slotData))
					else
						GameUtil.SetActive(cell, false)
					end
				end
			end
		end
	end

	GameUtil.SetActive(self._emptyStarGod, actCount <= 0)
end

function PetDetailView:onClickStarGodPlusCell(cell, slotData)
	local lv = StargodplusModel.instance:getSlotLv(slotData.slot, slotData.exp)

	CommonTipsMgr.instance:openMaterialTips(cell, MatType.StarGodPlus, slotData.fillerDefineId, lv)
end

function PetDetailView:_updateAttrs(data)
	for k, v in ipairs(AttrRank) do
		local na = AttrName[v]
		local itemAttr = ItemAttr.Get(self._Attrs[k])
		local value = data[na]

		itemAttr:SetIsRate(value > 0 and value < 1)
		itemAttr:SetValue(v, value)
	end
end

function PetDetailView:_onClickClose()
	self:close()
end

function PetDetailView:_updateSkill(data)
	local petCo = PetSkinConfig.instance:getPetSkinCfg(data.curFaceId)
	local sortedKeys = MaterialMgr.getAllSkillsSortedKeys()

	for index, skillType in ipairs(sortedKeys) do
		local v = MaterialMgr.getSkillKeyNameByType(skillType)
		local go = self._Skills[index]
		local con = goutil.findChild(go, "icon")
		local txt = goutil.findChildTextComponent(go, "txt_skillname")
		local skillId = petCo[v]
		local txtSkillLv = goutil.findChildTextComponent(go, "txt_skill_lv")
		local txtSkillType = goutil.findChildTextComponent(go, "txt_skill_type")
		local skillCfg = BattleConfig.instance:getSkillCo(skillId, data.curFaceId)

		GameUtil.asBtn(go):RemoveClickListener()
		MaterialMgr.resetAll(con)

		if skillId == 0 then
			go:SetActive(false)
		else
			go:SetActive(true)

			local proxy = MaterialMgr.setSkillByFaceId(skillId, data.curFaceId, con)

			if proxy then
				proxy:setAutoTips(false)
			end

			GameUtil.asBtn(go):AddClickListener(GameUtil.handler(self._OnClickSkill, self, skillType, skillId, go))

			txtSkillType.text = MaterialMgr.getSkillTypeName(skillId, data.curFaceId)

			local lvKey = MaterialMgr.SkillLvlKey[skillType]

			txtSkillLv.text = tostring(self._mo[lvKey] or 1)
			txt.text = skillCfg.name
		end
	end
end

function PetDetailView:_updateEquips(data)
	self._curViewDatas = {}

	local exclInfo = {}

	for _, v in pairs(self._mo.equipments) do
		if v.defineId and v.lv then
			local equipInfo = EquipInfoMo.New()

			exclInfo.exclRaceId = checknumber(v.bonusRaceId)
			exclInfo.wearOnlyId = checknumber(self._mo.petId)

			equipInfo:GetTemporaryEquip(v.defineId, v.lv, exclInfo)
			table.insert(self._curViewDatas, equipInfo)
		else
			local equip = PetEquipModel.instance:GetEquipInfo(v.id)

			if equip then
				table.insert(self._curViewDatas, equip)
			end
		end
	end

	local decoration = self._mo.decoration

	if decoration then
		if checknumber(decoration.defineId) > 0 and decoration.lv then
			local equipInfo = EquipInfoMo.New(nil, MatType.Decoration)

			equipInfo:GetTemporaryDectn(checknumber(decoration.defineId), checknumber(decoration.lv), decoration.propertyApps)
			table.insert(self._curViewDatas, equipInfo)
		else
			local equip = PetEquipModel.instance:GetDecorationInfoByOnlyId(checknumber(decoration.id))

			if equip then
				table.insert(self._curViewDatas, equip)
			end
		end
	end

	self:reloadData()
	GameUtil.SetActive(self._emptyEquips, #self._curViewDatas <= 0)
end

function PetDetailView:_updateCell(view, cell, data)
	local point = goutil.findChild(cell.gameObject, "point")
	local proxy = MaterialMgr.setCellByData(data.matType, data, point)

	if data.matType == MatType.Equipment and proxy then
		proxy.binder:setBewearPetIds(self._mo.petId, self._mo.curFaceId)
	end
end

function PetDetailView:_clearTableview(cell)
	local point = goutil.findChild(cell.gameObject, "point")

	MaterialMgr.resetAll(point)
end

function PetDetailView:_OnClickSkill(skillType, skillId, go)
	local skillLv = 1
	local key = MaterialMgr.SkillLvlKey[skillType]

	if not string.nilorempty(key) then
		local v = MaterialMgr.getSkillKeyNameByType(skillType)

		skillLv = self._mo[key] or 1

		local skillInfocfg = CharacterConfig.instance:getSkillInfoByLvl(self._mo.curFaceId, skillLv)

		if skillInfocfg then
			skillId = checknumber(skillInfocfg[v])
		end
	end

	CommonTipsMgr.instance:openMaterialTips(go, MatType.Skill, skillId, self._mo.curFaceId, skillLv, self._mo)
end

function PetDetailView:_updateRace(raceId, skinId)
	local cfg = CharacterConfig.instance:getPetCo(raceId)
	local firstJobIdx = PetSkinConfig.instance:getFirstJobIdx(skinId)

	self._imgJob:SetState(firstJobIdx - 1)

	local race = PetSkinConfig.instance:getFisrtEleAttrIdx(skinId)

	race = race % 10

	self._imgAttr:SetState(race - 1)
	goutil.setActive(self._goJob1, false)

	local secondJobIdx = PetSkinConfig.instance:getSecondJobIdx(skinId)

	if secondJobIdx > 20 then
		goutil.setActive(self._goJob1, true)
		self._imgJob1:SetState(secondJobIdx - 1 - 20)
	end
end

function PetDetailView:_onClickMore()
	local go = self._btnTip.gameObject
	local rect = go.gameObject:GetComponent("RectTransform")
	local pos = go.gameObject.transform.position
	local uiCamera = CameraTargetMgr.instance:getUICameraTarget():getCamera()

	pos = uiCamera:WorldToScreenPoint(pos)

	UIStateManager.instance:open(ViewName.PetAttrPopUpView, pos, (rect ~= nil or nil) and {
		rect.sizeDelta.x,
		rect.sizeDelta.y
	}, self._mo)
end

function PetDetailView:_onClickRune()
	local petMo = self._mo

	if petMo.runeSuit and petMo.runeSuit.runeSuitId > 0 then
		RuneController.instance:showGainViewByPetMo(petMo)
	end
end

function PetDetailView:_setCutePet()
	local cutePetRaceId = self._cutePetMo and self._cutePetMo:getDefineId() or 0
	local cutePetQuality = self._cutePetMo and self._cutePetMo:getQuality() or 0

	if cutePetRaceId > 0 then
		MaterialMgr.setIcon(self._cutePetIcon, MatType.CutePet, cutePetRaceId)
		GameUtil.SetActive(self._cutePetIcon, true)
	else
		MaterialMgr.clearIcon(self._cutePetIcon)
		GameUtil.SetActive(self._cutePetIcon, false)
	end

	GameUtil.SetActive(self._emptyPetIcon, not GameUtil.GetActive(self._cutePetIcon))
end

function PetDetailView:_OnClickCutePet()
	if self._cutePetMo == nil then
		return
	end

	local matType = MatType.CutePet
	local matId = self._cutePetMo:getDefineId()
	local level = self._cutePetMo.curLvl
	local quality = self._cutePetMo.curQuality

	CommonTipsMgr.instance:openMaterialTips(self._Btn_CutePet, matType, matId, level, quality, self._cutePetMo)
end

function PetDetailView:_onUpdateHolyStripesUI()
	local list = TableUtil.toList(self._holyStripes)

	self._hsScrollerList:reloadData(list)
	GameUtil.SetActive(self._emptyHolyStripes, #list <= 0)
end

function PetDetailView:_onClearHolyStripesUI()
	self._hsScrollerList:dispose()
end

function PetDetailView:_updateHsCell(view, cell, data, tag)
	local id = checknumber(data.id)
	local matId = checknumber(data.configId)
	local mainGo = cell.gameObject
	local point = goutil.findChild(mainGo, "point")

	if matId > 0 then
		local holyStripeMo = HolyStripeMo.New()

		holyStripeMo:initDataByMsg(data)

		local proxy = MaterialMgr.setCell(MatType.HolyStripe, matId, point)

		if proxy then
			proxy:setAutoTips(false)
			proxy:setCallBack(function()
				UIStateManager.instance:push(ViewName.HolyStripeTipsView, holyStripeMo)
			end)
		end
	elseif id > 0 then
		MaterialMgr.setCellByGId(MatType.HolyStripe, id, point)
	else
		MaterialMgr.resetAll(point)
	end
end

function PetDetailView:_clearHsCell(cell)
	local mainGo = cell.gameObject
	local point = goutil.findChild(mainGo, "point")

	MaterialMgr.resetAll(point)
end

function PetDetailView:_OnSearchTextChanged()
	local text = self._inputSearch:GetText()

	if text ~= self._currSearching then
		self._currSearching = text

		local raceId = checknumber(self._currSearching)
		local cfg = CharacterConfig.instance:getModelCo(raceId)

		if cfg then
			self:_updateRole(raceId)
		end
	end
end

function PetDetailView:_onClearSearch()
	self._inputSearch.input.text = ""
end

function PetDetailView:_OnClickPut()
	if self._role then
		local asset = self._role.asset

		if goutil.isNil(asset) then
			return
		end

		local scale = GameUtil.getLocalScale(asset)
		local pos = GameUtil.getLocalPos(asset)
		local str = string.format("[%.2f, %.2f, %.2f]", pos.x, pos.y, scale.x)

		printInfo(str)
	end
end

return PetDetailView
