-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/customfmt/view/customsummon/CustomSummonPopView.lua

module("logic.extensions.customfmt.view.customsummon.CustomSummonPopView", package.seeall)

local CustomSummonPopView = class("CustomSummonPopView", ViewComponent)

function CustomSummonPopView:buildUI()
	CustomSummonPopView.super.buildUI(self)

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

function CustomSummonPopView:bindEvents()
	CustomSummonPopView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnCancel:AddClickListener(self._onClickClose, self)
	self._btnSure:AddClickListener(self._onClickSure, self)
end

function CustomSummonPopView:unbindEvents()
	CustomSummonPopView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._btnCancel:AddClickListener(self._onClickClose, self)
	self._btnSure:AddClickListener(self._onClickSure, self)
end

function CustomSummonPopView:onEnter()
	CustomSummonPopView.super.onEnter(self)

	local params = self:getOpenParam()

	self.masterPetmoList = params[1]
	self.allPetList = params[2]
	self._curSummonMasterMo = params[3]
	self.limitLv = params[4]

	if self._curSummonMasterMo then
		self:_setSummonerId(self._curSummonMasterMo)
	elseif self.masterPetmoList then
		self:_setSummonerId(self.masterPetmoList[1])
	end

	self._curSummonedPetMo = nil
	self._curSummonedPetId = 0

	self:_setContractSkill(nil)
	self:_updateLeftList()
end

function CustomSummonPopView:onExit()
	CustomSummonPopView.super.onExit(self)
	self:_removeIcons()
end

function CustomSummonPopView:_onClickClose()
	self:close()
end

function CustomSummonPopView:_onClickSure()
	if self._curSummonerMasterId > 0 and self._curSummonedPetId > 0 and self._curSummonedPetMo then
		local summonerPetMo = self._curSummonMasterMo
		local summonPetMo = self._curSummonedPetMo

		if summonPetMo and summonerPetMo.summonedPetId and summonerPetMo.summonedPetId > 0 and summonerPetMo.summonedPetId == self._curSummonedPetId then
			self:_onMakeContractRes()

			return
		end

		if summonPetMo and summonPetMo.summonMasterId > 0 and summonPetMo.summonMasterId ~= summonerPetMo.petId then
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
			local summonerPetMo = self._curSummonMasterMo

			if summonerPetMo then
				GlobalDispatcher:dispatch(GlobalNotify.CancelContractInfo, self._curSummonerMasterId, summonerPetMo.summonedPetId)
			end
		end

		self:_onClickClose()
	end
end

function CustomSummonPopView:_onMakeContractRes()
	GlobalDispatcher:dispatch(GlobalNotify.PM_MakeContractRes, self._curSummonerMasterId, self._curSummonedPetId)
	self:_onClickClose()
end

function CustomSummonPopView:_updateLeftCell(view, cell, petMo)
	local node = goutil.findChild(cell, "node")
	local goSelect = goutil.findChild(cell, "select")
	local btnClick = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btn")

	btnClick:AddClickListener(function()
		self:_onClickLeftBtn(petMo)
	end)

	local proxy = MaterialMgr.setCellByMo(petMo, node)

	goSelect:SetActive(petMo.petId == self._curSummonerMasterId)
end

function CustomSummonPopView:_clearLeftCell(cell)
	local btnClick = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btn")
	local node = goutil.findChild(cell, "node")

	btnClick:RemoveClickListener()
	MaterialMgr.resetAll(node)
end

function CustomSummonPopView:_updateRightCell(view, cell, bagPetMo)
	local node = goutil.findChild(cell, "node")
	local goSelect = goutil.findChild(cell, "select")
	local btnClick = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btn")
	local passed = goutil.findChild(cell, "passed")

	btnClick:AddClickListener(function()
		self:_setSummonedPetId(bagPetMo)
		self:_onClickRightBtn(bagPetMo)
	end)

	local proxy = MaterialMgr.setCellByMo(bagPetMo, node)

	passed:SetActive((self._curSummonMasterMo or nil) and self._curSummonMasterMo and self._curSummonMasterMo > 0 and self._curSummonMasterMo == bagPetMo.petId)

	local select = bagPetMo.petId == self._curSummonedPetId

	goSelect:SetActive(select)
end

function CustomSummonPopView:_clearRightCell(cell)
	local btnClick = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btn")
	local node = goutil.findChild(cell, "node")

	btnClick:RemoveClickListener()
	MaterialMgr.resetAll(node)
end

function CustomSummonPopView:_getPetMo(petId)
	if self._getPetCallBack then
		return GameUtil.callBack(self._getPetCallBack, petId)
	else
		return self._leftView:_getPet(petId)
	end
end

function CustomSummonPopView:_updateLeftList()
	self._leftScrollList:reloadData(self.masterPetmoList)
	self:_updateRightList(self._curSummonerMasterId)
end

function CustomSummonPopView:_updateRightList(summonerId)
	local list = {}

	self:_setSummonedPetId(nil)

	local summonerPetMo = self._curSummonMasterMo
	local cfgList = {}

	if summonerPetMo then
		cfgList = ContractConfig.instance:getSummonBySummonMasterId(summonerPetMo.raceId)
	end

	if not self.allPetList then
		local bagPetMos = {}

		if #cfgList > 0 then
			for k, v in pairs(bagPetMos) do
				for i, cfg in ipairs(cfgList) do
					if v.raceId == cfg.summonRaceId and v.level >= self.limitLv then
						if summonerPetMo and summonerPetMo.summonedPetId and summonerPetMo.summonedPetId > 0 and summonerPetMo.summonedPetId == v.petId then
							self:_setSummonedPetId(v)
						end

						table.insert(list, v)

						break
					end
				end
			end
		end

		self._rightScrollList:reloadData(list)
	end
end

function CustomSummonPopView:_onClickLeftBtn(petMo)
	if petMo.petId == self._curSummonerMasterId then
		return
	end

	self:_setSummonerId(petMo)
	self._leftScrollList:refresh()
	self:_updateRightList(petMo.petId)
end

function CustomSummonPopView:_onClickRightBtn(data)
	self._rightScrollList:refresh()
end

function CustomSummonPopView:_setSummonSkill(raceId)
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

function CustomSummonPopView:_setContractSkill(petMo)
	self._contractTxtName.text = ""
	self._contractTxtDesc.text = ""

	MaterialMgr.resetAll(self._contractSkillIcon)
	GameUtil.SetActive(self._goContractSkill, false)

	local skillId = 0

	if petMo then
		if petMo.isMyPackPet then
			local groupId = ContractConfig.instance:getGroupId(self._curSummonMasterMo.raceId, petMo.raceId)

			skillId = ContractModel.instance:getSkillIdByGroupId(groupId)
		else
			skillId = petMo.contractSkillId
		end

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

function CustomSummonPopView:_removeIcons()
	MaterialMgr.resetAll(self._summonSkillIcon)
	MaterialMgr.resetAll(self._contractSkillIcon)
end

function CustomSummonPopView:_setSummonerId(petMo)
	self._curSummonMasterMo = petMo
	self._curSummonerMasterId = 0

	if petMo then
		self._curSummonerMasterId = petMo.petId

		self:_setSummonSkill(petMo.curFaceId)
	end
end

function CustomSummonPopView:_setSummonedPetId(petMo)
	if self._curSummonedPetMo == petMo then
		petMo = nil
	end

	self._curSummonedPetMo = petMo
	self._curSummonedPetId = 0

	if petMo then
		self._curSummonedPetId = petMo.petId
	end

	self:_setContractSkill(petMo)
end

return CustomSummonPopView
