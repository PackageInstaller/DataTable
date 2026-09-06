-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/contract/view/ContractSelectPopView.lua

module("logic.extensions.contract.view.ContractSelectPopView", package.seeall)

local ContractSelectPopView = class("ContractSelectPopView", ViewComponent)

function ContractSelectPopView:buildUI()
	ContractSelectPopView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self._tableviewLeft = self:getGo("left/tableview")
	self._tableviewRight = self:getGo("right/tableview")
	self._cell = self:getGo("item")
	self._summonSkillIcon = self:getGo("right/summonSkill/skillIcon")
	self._summonTxtName = self:getTxt("right/summonSkill/txtName")
	self._summonTxtDesc = self:getTxt("right/summonSkill/txtDesc")
	self._goContractSkill = self:getGo("right/contractSkill")
	self._contractSkillIcon = self:getGo("right/contractSkill/skillIcon")
	self._contractTxtName = self:getTxt("right/contractSkill/txtName")
	self._contractTxtDesc = self:getTxt("right/contractSkill/txtDesc")
	self._leftScrollList = ScrollerList.create(self._tableviewLeft, self._cell, GameUtil.handler(self._updateLeftCell, self), GameUtil.handler(self._clearLeftCell, self))
	self._rightScrollList = ScrollerList.create(self._tableviewRight, self._cell, GameUtil.handler(self._updateRightCell, self), GameUtil.handler(self._clearRightCell, self))
	self._btnCancel = self:getBtn("btnCancel")
	self._btnSure = self:getBtn("btnSure")
end

function ContractSelectPopView:bindEvents()
	ContractSelectPopView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnCancel:AddClickListener(self._onClickClose, self)
	self._btnSure:AddClickListener(self._onClickSure, self)
end

function ContractSelectPopView:unbindEvents()
	ContractSelectPopView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._btnCancel:AddClickListener(self._onClickClose, self)
	self._btnSure:AddClickListener(self._onClickSure, self)
end

function ContractSelectPopView:onEnter()
	ContractSelectPopView.super.onEnter(self)

	local params = self:getOpenParam()

	self._leftView = params[1]
	self._getPetCallBack = params[2]
	self._getPetListCallBack = params[3]
	self._formationMo = self._leftView:_getCurFormation()

	if not self._formationMo then
		return
	end

	self._curSummonerMasterId = 0
	self._curSummonedPetId = 0

	self:_setContractSkill(nil)
	self:_updateLeftList()
end

function ContractSelectPopView:onExit()
	ContractSelectPopView.super.onExit(self)

	self._formationMo = nil
	self._leftView = nil

	self:_removeIcons()
end

function ContractSelectPopView:_onClickClose()
	self:close()
end

function ContractSelectPopView:_onClickSure()
	if self._curSummonerMasterId > 0 and self._curSummonedPetId > 0 then
		local summonerPetMo = self:_getPetMo(self._curSummonerMasterId)
		local summonPetMo = self:_getPetMo(self._curSummonedPetId)

		if summonPetMo and summonerPetMo.summonedPetId and summonerPetMo.summonedPetId > 0 and summonerPetMo.summonedPetId == summonPetMo:getPetId() then
			self:_onMakeContractRes()

			return
		end

		if summonPetMo and summonPetMo.summonMasterId > 0 and summonPetMo.summonMasterId ~= summonerPetMo:getPetId() then
			local mmo = MaterialMgr.getModel(MatType.Pet, summonPetMo.summonMasterId)

			if mmo then
				local name = mmo.name

				TipsFacade.instance:openPopupWindow(lang("tip"), langPara("当前精灵和%s绑定中，如果要契约此精灵，会先解除原契约后重新跟新的召唤师签订契约", name), function()
					GlobalDispatcher:dispatch(GlobalNotify.SetContractInfo, self._curSummonerMasterId, self._curSummonedPetId)
					self:_onClickClose()
				end)

				return
			end
		end

		GlobalDispatcher:dispatch(GlobalNotify.SetContractInfo, self._curSummonerMasterId, self._curSummonedPetId)
		self:_onClickClose()
	else
		if self._curSummonerMasterId > 0 then
			local summonerPetMo = self:_getPetMo(self._curSummonerMasterId)

			if summonerPetMo then
				GlobalDispatcher:dispatch(GlobalNotify.CancelContractInfo, self._curSummonerMasterId, summonerPetMo.summonedPetId)
			end
		end

		self:_onClickClose()
	end
end

function ContractSelectPopView:_onMakeContractRes()
	GlobalDispatcher:dispatch(GlobalNotify.PM_MakeContractRes, self._curSummonerMasterId, self._curSummonedPetId)
	self:_onClickClose()
end

function ContractSelectPopView:_updateLeftCell(view, cell, data)
	local node = goutil.findChild(cell, "node")
	local goSelect = goutil.findChild(cell, "select")
	local btnClick = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btn")

	btnClick:AddClickListener(function()
		self:_onClickLeftBtn(data)
	end)

	local petMo = self:_getPetMo(data.summonerId)

	if petMo then
		local proxy = MaterialMgr.setCellByMo(petMo, node)

		if data.isSelect then
			self:_setSummonSkill(petMo.curFaceId)
		end
	end

	goSelect:SetActive(data.summonerId == self._curSummonerMasterId)
end

function ContractSelectPopView:_clearLeftCell(cell)
	local btnClick = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btn")
	local node = goutil.findChild(cell, "node")

	btnClick:RemoveClickListener()
	MaterialMgr.resetAll(node)
end

function ContractSelectPopView:_updateRightCell(view, cell, data)
	local node = goutil.findChild(cell, "node")
	local goSelect = goutil.findChild(cell, "select")
	local btnClick = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btn")
	local passed = goutil.findChild(cell, "passed")

	btnClick:AddClickListener(function()
		self:_onClickRightBtn(data)
	end)

	local proxy = MaterialMgr.setCellByMo(data.bagPetMo, node)

	passed:SetActive(data.isContract)

	local select = data.bagPetMo:getPetId() == self._curSummonedPetId

	goSelect:SetActive(data.isSelect)
end

function ContractSelectPopView:_clearRightCell(cell)
	local btnClick = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btn")
	local node = goutil.findChild(cell, "node")

	btnClick:RemoveClickListener()
	MaterialMgr.resetAll(node)
end

function ContractSelectPopView:_getPetMo(petId)
	if self._getPetCallBack then
		return GameUtil.callBack(self._getPetCallBack, petId)
	else
		return self._leftView:_getPet(petId)
	end
end

function ContractSelectPopView:_getPetList()
	local bagPetMos = BagPetsController.instance:getFightBagPet()

	if self._getPetListCallBack then
		bagPetMos = GameUtil.callBack(self._getPetListCallBack)
	else
		local rightView = self._leftView._RightView

		if rightView and rightView.getAllShowPetList then
			bagPetMos = rightView:getAllShowPetList()
		end
	end

	return bagPetMos
end

function ContractSelectPopView:_updateLeftList()
	local list = {}
	local positions = self._formationMo:GetPositions()
	local selectIndex = 1
	local count = 0
	local limitLv = checknumber(ContractConfig.instance:getConstValueByKey("SUMMON_MASTER_MIN_LVL"))

	self:_setSummonerId(0)

	for i, v in ipairs(positions) do
		if v > 0 then
			local petMo = self._formationMo:_getPet(v)

			if petMo and petMo.isMyPackPet and limitLv <= petMo.level and PetSkinConfig.instance:checkHasJob(petMo.curFaceId, GameEnum.CareerType.Zhaohuanshi) then
				count = count + 1

				local element = {}

				element.index = count
				element.summonerId = v
				element.isSelect = false

				if count == 1 then
					self:_setSummonerId(v)
				end

				if self._formationMo:GetSummonPetId() == petMo.summonedPetId then
					selectIndex = count

					self:_setSummonerId(v)
				end

				table.insert(list, element)
			end
		end
	end

	if selectIndex <= #list then
		list[selectIndex].isSelect = true
	end

	self._leftScrollList:reloadData(list)
	self:_updateRightList(self._curSummonerMasterId)
end

function ContractSelectPopView:_updateRightList(summonerId)
	local list = {}

	self._curSummonedPetId = 0

	self:_setContractSkill(nil)

	if summonerId > 0 then
		local summonerPetMo = self:_getPetMo(summonerId)
		local summonedPetList = ContractConfig.instance:getSummonBySummonMasterId(summonerPetMo.raceId)
		local bagPetMos = self:_getPetList()
		local limitLv = checknumber(ContractConfig.instance:getConstValueByKey("SUMMONED_PET_MIN_LVL"))

		if #summonedPetList > 0 then
			local selectIndex = 1
			local count = 0

			for k, v in pairs(bagPetMos) do
				for i, summonedPet in ipairs(summonedPetList) do
					if v.raceId == summonedPet.summonRaceId and limitLv <= v.level then
						count = count + 1

						local element = {}

						element.index = count
						element.groupId = summonedPet.groupId
						element.bagPetMo = v
						element.isSelect = false
						element.isContract = false

						if summonerPetMo.summonedPetId and summonerPetMo.summonedPetId > 0 and summonerPetMo.summonedPetId == v:getPetId() then
							selectIndex = count
							element.isContract = true
							element.isSelect = true
							self._curSummonedPetId = v:getPetId()

							self:_setContractSkill(element)
						end

						table.insert(list, element)

						break
					end
				end
			end
		end
	end

	self._rightScrollList:reloadData(list)
end

function ContractSelectPopView:_onClickLeftBtn(data)
	if data.isSelect then
		return
	end

	self:_setSummonerId(data.summonerId)
	self:_updateLeftSelect(data.index)
	self:_updateRightList(data.summonerId)
end

function ContractSelectPopView:_updateLeftSelect(newSelectIndex)
	for i, v in ipairs(self._leftScrollList:getData()) do
		if v.isSelect and v.index ~= newSelectIndex then
			v.isSelect = false

			self._leftScrollList:getView():UpdateCellAtIndex(i - 1)
		end

		if v.index == newSelectIndex then
			v.isSelect = true

			self._leftScrollList:getView():UpdateCellAtIndex(i - 1)
		end
	end
end

function ContractSelectPopView:_onClickRightBtn(data)
	if data.isSelect then
		self:_setSummonedPetId(0)

		for i, v in ipairs(self._rightScrollList:getData()) do
			if v.isSelect then
				v.isSelect = false

				self._rightScrollList:getView():UpdateCellAtIndex(i - 1)
			end
		end

		self:_setContractSkill(nil)
	else
		self:_setSummonedPetId(data.bagPetMo:getPetId())
		self:_updateRightSelect(data.index)
		self:_setContractSkill(data)
	end
end

function ContractSelectPopView:_updateRightSelect(newSelectIndex)
	for i, v in ipairs(self._rightScrollList:getData()) do
		if v.isSelect and v.index ~= newSelectIndex then
			v.isSelect = false

			self._rightScrollList:getView():UpdateCellAtIndex(i - 1)
		end

		if v.index == newSelectIndex then
			v.isSelect = true

			self._rightScrollList:getView():UpdateCellAtIndex(i - 1)
		end
	end
end

function ContractSelectPopView:_setSummonSkill(raceId)
	local petCfg = PetSkinConfig.instance:getPetSkinCfg(raceId)

	if checknumber(petCfg.summonSkillId) > 0 then
		MaterialMgr.setCell(MatType.Skill, petCfg.summonSkillId, self._summonSkillIcon)

		local cfg = BattleConfig.instance:getSkillCo(petCfg.summonSkillId, raceId)

		if cfg then
			self._summonTxtName.text = cfg.name
			self._summonTxtDesc.text = cfg.desc
		end
	end
end

function ContractSelectPopView:_setContractSkill(data)
	self._contractTxtName.text = ""
	self._contractTxtDesc.text = ""

	MaterialMgr.resetAll(self._contractSkillIcon)
	GameUtil.SetActive(self._goContractSkill, false)

	if data == nil then
		return
	end

	local skillId = 0
	local petMo = data.bagPetMo

	if petMo then
		skillId = petMo.isMyPackPet and ContractModel.instance:getSkillIdByGroupId(data.groupId) or petMo.contractSkillId

		if skillId > 0 then
			GameUtil.SetActive(self._goContractSkill, true)
			MaterialMgr.setCell(MatType.Skill, skillId, self._contractSkillIcon)

			local cfg = BattleConfig.instance:getSkillCo(skillId, petMo.curFaceId)

			if cfg then
				self._contractTxtName.text = cfg.name
				self._contractTxtDesc.text = cfg.desc
			end
		end
	end
end

function ContractSelectPopView:_removeIcons()
	MaterialMgr.resetAll(self._summonSkillIcon)
	MaterialMgr.resetAll(self._contractSkillIcon)
end

function ContractSelectPopView:_setSummonerId(id)
	self._curSummonerMasterId = id
end

function ContractSelectPopView:_setSummonedPetId(id)
	self._curSummonedPetId = id
end

return ContractSelectPopView
