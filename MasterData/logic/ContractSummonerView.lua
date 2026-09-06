-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/contract/view/ContractSummonerView.lua

module("logic.extensions.contract.view.ContractSummonerView", package.seeall)

local ContractSummonerView = class("ContractSummonerView", ViewComponent)

function ContractSummonerView:ctor()
	ContractSummonerView.super.ctor(self)
end

function ContractSummonerView:bindEvents()
	ContractSummonerView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
	GameUtil.addClickHandler(self.btnSure, self.onBtnSure, self)
	GameUtil.addClickHandler(self.btnList, self.onBtnList, self)
	GameUtil.addClickHandler(self.btnRule, self._onClickRule, self)
	GameUtil.addClickHandler(self._btnBook, self._onClickBook, self)
end

function ContractSummonerView:unbindEvents()
	ContractSummonerView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	GameUtil.rmClickHandler(self.btnSure)
	GameUtil.rmClickHandler(self.btnList)
	GameUtil.rmClickHandler(self.btnRule)
	GameUtil.rmClickHandler(self._btnBook)
end

function ContractSummonerView:buildUI()
	ContractSummonerView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self._roleGo = self:getGo("role")
	self._leftGo = self:getGo("left")
	self._rareGo = self:getGo("left/info/rare")
	self._attrChange = self:getGo("left/info/attr/img"):GetComponent(typeof(UIImageSpriteChange))
	self._career1 = self:getGo("left/info/career/img"):GetComponent(typeof(UIImageSpriteChange))
	self._career2 = self:getGo("left/info/career2/img"):GetComponent(typeof(UIImageSpriteChange))
	self._careerGo2 = self:getGo("left/info/career2")
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
	self.btnCancel = self:getGo("right/btnCancel")
	self.btnSure = self:getGo("right/btnSure")
	self._btnBook = self:getGo("left/btnBook")
	self.btnRule = self:getBtn("btnRule")
	self.scrollList = ScrollerList.create(self.tableview, self.cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self.clearCell, self))
end

function ContractSummonerView:onEnter()
	ContractSummonerView.super.onEnter(self)
	self:refreshUI()
end

function ContractSummonerView:onExit()
	ContractSummonerView.super.onExit(self)
	self.scrollList:dispose()

	self._loader = RoleObjectPool.instance:removeRole(self._loader)
end

function ContractSummonerView:_onClickClose()
	self:close()
end

function ContractSummonerView:_updateCell(view, cell, data, tag)
	local con = goutil.findChild(cell, "con")
	local select = goutil.findChild(cell, "select")
	local top = goutil.findChild(cell, "top")

	MaterialMgr.setCellByMo(data, con)
	GameUtil.SetActive(select, data.petId == self.currSelectPetId)
	GameUtil.addClickHandler(top, GameUtil.handler(self.onClickCell, self, data))
end

function ContractSummonerView:clearCell(cell)
	local con = goutil.findChild(cell, "con")

	MaterialMgr.resetAll(con)
end

function ContractSummonerView:onBtnSure()
	local petId = checknumber(self.currSelectPetId)

	if petId > 0 then
		UIStateManager.instance:push(ViewName.ContractSignView, petId)
		self:close()
	else
		TipsFacade.instance:openCommonTips(lang("请先选择一个召唤师"))
	end
end

function ContractSummonerView:onBtnList()
	if checknumber(self.currSelectPetId) > 0 then
		local petMo = BagModel.instance:getBagPetById(checknumber(self.currSelectPetId))

		UIStateManager.instance:push(ViewName.ContractListView, petMo)
	else
		TipsFacade.instance:openCommonTips(lang("请先选择一个召唤师"))
	end
end

function ContractSummonerView:_onClickRule()
	UIStateManager.instance:open(ViewName.RulesView, "contractselect")
end

function ContractSummonerView:_onClickBook()
	UIStateManager.instance:push(ViewName.ContractBookView)
end

function ContractSummonerView:onClickCell(petMo)
	if self.currSelectPetId ~= petMo.petId then
		self.currSelectPetId = petMo.petId

		self.scrollList:refresh()
		self:updateLeftView()
	end
end

function ContractSummonerView:refreshUI()
	self.currSelectPetId = nil

	local list = {}
	local limitLv = checknumber(ContractConfig.instance:getConstValueByKey("SUMMON_MASTER_MIN_LVL"))

	self.txtTip.text = langPara("召唤师等级达到%s级时才能签订契约", limitLv)

	local arr = BagPetsController.instance:getBagAndBorrowPets()

	for i, petMo in ipairs(arr) do
		if limitLv <= petMo.level and PetSkinConfig.instance:checkHasJob(petMo.curFaceId, GameEnum.CareerType.Zhaohuanshi) then
			if #list == 0 then
				self.currSelectPetId = petMo.petId
			end

			table.insert(list, petMo)
		end
	end

	GameUtil.SetActive(self.rightEmpty, #list == 0)
	self.scrollList:reloadData(list)
	self:updateLeftView()
end

function ContractSummonerView:updateLeftView()
	local petMo = MaterialMgr.getModel(MatType.Pet, self.currSelectPetId)

	self._loader = RoleObjectPool.instance:removeRole(self._loader)

	GameUtil.SetActive(self._leftGo, false)
	GameUtil.SetActive(self.leftEmpty, true)

	if petMo then
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

		local petSkinCfg = PetSkinConfig.instance:getPetSkinCfg(petMo.curFaceId)

		if checknumber(petSkinCfg.summonSkillId) > 0 then
			GameUtil.SetActive(self.summonSkill, true)
			MaterialMgr.setCell(MatType.Skill, petSkinCfg.summonSkillId, self.skillicon)

			self.txtSkillName.text = ""
			self.txtSkillDesc.text = ""

			local cfg = MaterialMgr.getMatCfg(MatType.Skill, petSkinCfg.summonSkillId)

			if cfg then
				self.txtSkillName.text = cfg.name
				self.txtSkillDesc.text = cfg.desc
			end
		end

		local modelCfg = CharactorFacade.instance:getPetDisplayModelUIPosAndScale(skinId)

		if not modelCfg[1] then
			if not modelCfg[2] then
				local y = 0

				if not modelCfg[3] then
					local scale = 1

					self._loader = RoleObjectPool.instance:addRoleToParent(self._loader, skinId, self._roleGo, scale, nil, true, modelCfg[1], y)
				end
			end
		end
	end
end

return ContractSummonerView
