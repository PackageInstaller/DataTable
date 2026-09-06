-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/contract/view/ContractSummonPetView.lua

module("logic.extensions.contract.view.ContractSummonPetView", package.seeall)

local ContractSummonPetView = class("ContractSummonPetView", ViewComponent)

function ContractSummonPetView:ctor()
	ContractSummonPetView.super.ctor(self)
end

function ContractSummonPetView:bindEvents()
	ContractSummonPetView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
	GameUtil.addClickHandler(self.btnSure, self.onBtnSure, self)
	GameUtil.addClickHandler(self.btnList, self.onBtnList, self)
end

function ContractSummonPetView:unbindEvents()
	ContractSummonPetView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	GameUtil.rmClickHandler(self.btnSure)
	GameUtil.rmClickHandler(self.btnList)
end

function ContractSummonPetView:buildUI()
	ContractSummonPetView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self._roleGo = self:getGo("role")
	self._leftGo = self:getGo("left")
	self._rareGo = self:getGo("left/info/rare")
	self._attrChange = self:getGo("left/info/attr/img"):GetComponent(typeof(UIImageSpriteChange))
	self._career1 = self:getGo("left/info/career/img"):GetComponent(typeof(UIImageSpriteChange))
	self._careerGo2 = self:getGo("left/info/career2")
	self._career2 = self:getGo("left/info/career2/img"):GetComponent(typeof(UIImageSpriteChange))
	self._txtName = self:getTxt("left/info/txtName")
	self._txtDesc = self:getTxt("left/info/txtDesc")
	self.btnList = self:getGo("left/btnList")
	self.summonSkill = self:getGo("left/summonSkill")
	self.skillicon = self:getGo("left/summonSkill/skillicon")
	self.txtSkillName = self:getTxt("left/summonSkill/txtName")
	self.txtSkillDesc = self:getTxt("left/summonSkill/txtDesc")
	self.txtPower = self:getGo("left/power/powerTxt"):GetComponent(typeof(UIImgNumeralText))
	self.txtTip = self:getTxt("right/tip/txtTip")
	self.tableview = self:getGo("right/tableview")
	self.cell = self:getGo("right/cell")
	self.rightEmpty = self:getGo("rightEmpty")
	self.leftEmpty = self:getGo("leftEmpty")
	self.attrGo = self:getGo("left/attr")
	self.item_attr = self:getGo("left/attr/item_attr")
	self.attrGroup = self:getGo("left/attr/attrGroup")

	GameUtil.SetActive(self.item_attr, false)

	self.btnCancel = self:getGo("right/btnCancel")
	self.btnSure = self:getGo("right/btnSure")
	self.scrollList = ScrollerList.create(self.tableview, self.cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self.clearCell, self))

	GameUtil.SetActive(self.btnList, true)
end

function ContractSummonPetView:onEnter()
	ContractSummonPetView.super.onEnter(self)

	self.masterPetId = nil
	self.callback = nil

	local param = self:getOpenParam()

	if param then
		self.masterPetId = checknumber(param[1])
		self.callback = param[2]
	end

	if checknumber(self.masterPetId) > 0 then
		self:refreshUI()
	else
		self:close()
	end
end

function ContractSummonPetView:onExit()
	ContractSummonPetView.super.onExit(self)
	self.scrollList:dispose()

	self._loader = RoleObjectPool.instance:removeRole(self._loader)
end

function ContractSummonPetView:_onClickClose()
	self:close()
end

function ContractSummonPetView:_updateCell(view, cell, data, tag)
	local con = goutil.findChild(cell, "con")
	local select = goutil.findChild(cell, "select")
	local sign = goutil.findChild(cell, "sign")
	local signNot = goutil.findChild(cell, "signNot")
	local top = goutil.findChild(cell, "top")
	local mask = goutil.findChild(cell, "mask")
	local icon = goutil.findChild(cell, "mask/icon")
	local petMo = data.petMo

	MaterialMgr.setCellByMo(petMo, con)
	GameUtil.SetActive(select, petMo.petId == self.currSelectPetId)
	GameUtil.addClickHandler(top, GameUtil.handler(self.onClickCell, self, petMo))
	GameUtil.SetActive(sign, false)
	GameUtil.SetActive(signNot, false)

	if petMo.summonMasterId == self.masterPetId then
		GameUtil.SetActive(sign, true)
	else
		GameUtil.SetActive(signNot, not data.hasContract)
	end

	GameUtil.SetActive(mask, false)

	local masterId = checknumber(petMo.summonMasterId)

	if masterId > 0 then
		local mmo = MaterialMgr.getModel(MatType.Pet, masterId)

		if mmo then
			GameUtil.SetActive(mask, true)
			MaterialMgr.setIcon(icon, MatType.Pet, petMo.raceId)
		end
	end
end

function ContractSummonPetView:clearCell(cell)
	local con = goutil.findChild(cell, "con")
	local icon = goutil.findChild(cell, "mask/icon")

	MaterialMgr.resetAll(con)
	MaterialMgr.clearIcon(icon)
end

function ContractSummonPetView:onBtnSure()
	local petId = checknumber(self.currSelectPetId)

	if petId > 0 then
		local petMo = MaterialMgr.getModel(MatType.Pet, petId)

		if petMo and petMo.summonMasterId > 0 then
			if petMo.summonMasterId == self.masterPetId then
				GameUtil.callBack(self.callback, petId)
				self:close()
			else
				local mmo = MaterialMgr.getModel(MatType.Pet, petMo.summonMasterId)

				if mmo then
					local n = mmo.name

					TipsFacade.instance:openPopupWindow(lang("tip"), langPara("当前精灵和%s绑定中，如果要契约此精灵，会先解除原契约后重新跟新的召唤师签订契约", n), function()
						GameUtil.callBack(self.callback, petId)
						self:close()
					end)
				else
					GameUtil.callBack(self.callback, petId)
					self:close()
				end
			end
		else
			GameUtil.callBack(self.callback, petId)
			self:close()
		end
	else
		TipsFacade.instance:openCommonTips(lang("请先选择一个召唤师"))
	end
end

function ContractSummonPetView:onBtnList()
	if checknumber(self.masterPetId) > 0 then
		TipsFacade.instance:openCommonTips("功能未开放")
	end
end

function ContractSummonPetView:onClickCell(petMo)
	if self.currSelectPetId ~= petMo.petId then
		self.currSelectPetId = petMo.petId

		self.scrollList:refresh()
		self:updateLeftView()
	end
end

function ContractSummonPetView:refreshUI()
	self.currSelectPetId = nil

	local list = {}
	local limitLv = checknumber(ContractConfig.instance:getConstValueByKey("SUMMONED_PET_MIN_LVL"))
	local masterId = self.masterPetId
	local masterPetMo = MaterialMgr.getModel(MatType.Pet, masterId)
	local arr = ContractConfig.instance:getContractList()
	local map = ContractModel.instance:getContractInfoMap()
	local allPets = BagPetsController.instance:getBagAndBorrowPets()

	for i, cc in ipairs(arr) do
		if not cc.summonMasterRaceIds then
			if table.indexof(cc.summonMasterRaceIds, masterPetMo.raceId) ~= false then
				local summonedRaceIds = cc.summonedRaceIds
				local hasContract = map[cc.groupId] ~= nil

				for j, raceId in ipairs(summonedRaceIds) do
					for i, petMo in pairs(allPets) do
						if petMo.raceId == raceId and limitLv <= petMo.level then
							if #list == 0 then
								self.currSelectPetId = petMo.petId
							end

							local obj = {}

							obj.petMo = petMo
							obj.hasContract = hasContract

							table.insert(list, obj)
						end
					end
				end
			end
		end
	end

	self.txtTip.text = langPara("契约精灵等级达到%s级时才能签订契约", limitLv)

	GameUtil.SetActive(self.rightEmpty, #list == 0)
	GameUtil.SetActive(self.btnSure, #list > 0)
	self.scrollList:reloadData(list)
	self:updateLeftView()
end

function ContractSummonPetView:updateLeftView()
	local petMo = MaterialMgr.getModel(MatType.Pet, self.currSelectPetId)
	local masterMo = MaterialMgr.getModel(MatType.Pet, self.masterPetId)

	self._loader = RoleObjectPool.instance:removeRole(self._loader)

	GameUtil.SetActive(self._leftGo, false)
	GameUtil.SetActive(self.leftEmpty, true)
	GameUtil.SetActive(self.attrGo, false)
	goutil.clearChildren(self.attrGroup)

	if petMo and masterMo then
		local contractCfg = ContractConfig.instance:getGroupCfg(masterMo.raceId, petMo.raceId)

		if contractCfg and not string.nilorempty(contractCfg.summonExtProperties) then
			GameUtil.SetActive(self.attrGo, true)

			local str = contractCfg.summonExtProperties
			local arr = FightingPowerFormula.instance:parseAttrValues(str)

			for k, v in pairs(arr) do
				local item = goutil.clone(self.item_attr, "item_attr" .. k)

				GameUtil.SetActive(item, true)
				goutil.addChildToParent(item, self.attrGroup)

				local icon = goutil.findChild(item, "icon")
				local txtAttr = goutil.findChildTextComponent(item, "txtAttr")
				local txtNum = goutil.findChildTextComponent(item, "txtNum")

				GameUtil.setUIImageSpriteIdx(icon, checknumber(k) - 1)

				local attrStr = ConstString.Attr[checknumber(k)]
				local value = checknumber(v)
				local showValue = ""
				local isPosNum = value > 0
				local isDecNum = math.abs(value) < 1

				if isPosNum and isDecNum then
					attrStr = attrStr .. "增加"
					showValue = value * 100 .. "%"
				elseif not isPosNum and isDecNum then
					attrStr = attrStr .. "保留"
					showValue = (1 + value) * 100 .. "%"
				elseif isPosNum and not isDecNum then
					attrStr = attrStr .. "增加"
					showValue = math.abs(value)
				else
					attrStr = attrStr .. "减少"
					showValue = math.abs(value)
				end

				txtAttr.text = attrStr
				txtNum.text = showValue
			end
		end

		GameUtil.SetActive(self.leftEmpty, false)
		GameUtil.SetActive(self._leftGo, true)

		local skinId = petMo.curFaceId
		local petCfg = MaterialMgr.getMatCfg(MatType.Pet, petMo.raceId)

		self._txtName.text = MaterialMgr.getMaterialsName(MatType.PET_SKIN, skinId)

		local petInfoCfg = CharacterConfig.instance:getPetInfoCo(petMo.raceId)

		self._txtDesc.text = string.gsub(petInfoCfg.stragegy, "\n", "，")

		local proxy = MaterialMgr.setCell(MatType.Rare, petMo.raceId, self._rareGo)

		if proxy then
			proxy.binder:setRare(petMo.rare)
		end

		self.txtPower:SetNum(petMo:getFightingPower())

		local firstJobIdx = PetSkinConfig.instance:getFirstJobIdx(petMo.curFaceId)

		self._career1:SetState(firstJobIdx - 1)

		local secondJobIdx = PetSkinConfig.instance:getSecondJobIdx(petMo.curFaceId)

		GameUtil.SetActive(self._careerGo2, false)

		if secondJobIdx > 20 then
			GameUtil.SetActive(self._careerGo2, true)
			self._career2:SetState(secondJobIdx - 1 - 20)
		end

		local race = PetSkinConfig.instance:getFisrtEleAttrIdx(petMo.curFaceId)

		race = math.fmod(race, 10)

		local targetValue = race - 1

		self._attrChange:SetState(targetValue)
		GameUtil.SetActive(self.summonSkill, false)

		local modelCfg = CharactorFacade.instance:getPetDisplayModelUIPosAndScale(skinId)

		if not modelCfg[1] then
			local x = 0

			if not modelCfg[2] then
				local y = 0

				if not modelCfg[3] then
					self._loader = RoleObjectPool.instance:addRoleToParent(self._loader, skinId, self._roleGo, (skinId == 10381 or nil) and {
						1.1,
						1.1,
						1.1
					}, nil, true, x, y)
				end
			end
		end
	end
end

return ContractSummonPetView
