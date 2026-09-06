-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/contract/view/ContractPetPopView.lua

module("logic.extensions.contract.view.ContractPetPopView", package.seeall)

local ContractPetPopView = class("ContractPetPopView", ViewComponent)

function ContractPetPopView:ctor()
	ContractPetPopView.super.ctor(self)
end

function ContractPetPopView:destroyUI()
	ContractPetPopView.super.destroyUI(self)
end

function ContractPetPopView:onExitFinished()
	ContractPetPopView.super.onExitFinished(self)
end

function ContractPetPopView:onEnterFinished()
	ContractPetPopView.super.onEnterFinished(self)
end

function ContractPetPopView:unbindEvents()
	ContractPetPopView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	GameUtil.rmClickHandler(self.btnList)
	GameUtil.rmClickHandler(self.btnGoto)
end

function ContractPetPopView:bindEvents()
	ContractPetPopView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
	GameUtil.addClickHandler(self.btnList, self.onClickList, self)
	GameUtil.addClickHandler(self.btnGoto, self.onClickGo, self)
end

function ContractPetPopView:onExit()
	ContractPetPopView.super.onExit(self)

	self.currMasterPetId = nil
end

function ContractPetPopView:buildUI()
	ContractPetPopView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self.summonskill = self:getGo("summonskill")
	self.skillicon = self:getGo("summonskill/skillicon")
	self.txtName = self:getTxt("summonskill/txtName")
	self.txtDesc = self:getTxt("summonskill/txtDesc")
	self.itemTop = self:getGo("summonskill/item")
	self.petGoTop = self:getGo("summonskill/pet")
	self.txtTop = self:getTxt("summonskill/pet/txt")
	self.empty = self:getGo("empty")
	self.btnList = self:getGo("btnList")
	self.btnGoto = self:getGo("btnGoto")
	self.contract = self:getGo("contract")
	self.item = self:getGo("contract/item")
	self.petGo = self:getGo("contract/pet")
	self.txt = self:getTxt("contract/pet/txt")
	self.c_skillicon = self:getGo("contract/skillicon")
	self.c_txtName = self:getTxt("contract/txtName")
	self.c_txtDesc = self:getTxt("contract/txtDesc")
end

function ContractPetPopView:onEnter()
	ContractPetPopView.super.onEnter(self)

	local mo = self:getFirstParam()

	if mo then
		self:refreshUI(mo)
	else
		self:close()
	end
end

function ContractPetPopView:_onClickClose()
	self:close()
end

function ContractPetPopView:onClickList()
	if self.currMasterPetId then
		TipsFacade.instance:openCommonTips("功能未开放")
	end
end

function ContractPetPopView:onClickGo()
	if self.currMasterPetId then
		local mo = MaterialMgr.getModel(MatType.Pet, self.currMasterPetId)
		local canContractLvl = ContractConfig.instance:getConstValueByKey("SUMMON_MASTER_MIN_LVL")

		if mo.level >= checknumber(canContractLvl) then
			UIStateManager.instance:push(ViewName.ContractSignView, self.currMasterPetId)
			self:close()
		else
			FloatWordMgr.instance:show(langPara("等级还没达到%s级不可以契约", canContractLvl))
		end
	end
end

function ContractPetPopView:refreshUI(mo)
	if mo.summonMasterId > 0 then
		local masterPet = MaterialMgr.getModel(MatType.Pet, mo.summonMasterId)

		self:showMasterSkill(masterPet)
		self:setSummonPet(mo)
		self:showTopPetIcon(masterPet)
		self:showDownPetIcon(nil)

		self.currMasterPetId = masterPet.petId
	else
		local cfg = MaterialMgr.getMatCfg(MatType.Pet, mo.raceId)
		local secondJobIdx = PetSkinConfig.instance:getSecondJobIdx(mo.curFaceId)

		if secondJobIdx > 20 and secondJobIdx == GameEnum.CareerType.Zhaohuanshi then
			self:showMasterSkill(mo)
			self:showTopPetIcon(nil)

			self.currMasterPetId = mo.petId

			if mo.summonedPetId > 0 then
				local pet = MaterialMgr.getModel(MatType.Pet, mo.summonedPetId)

				self:showDownPetIcon(pet)
				self:setSummonPet(pet)
			else
				self:showDownPetIcon(nil)
				self:setSummonPet(nil)
			end
		end
	end
end

function ContractPetPopView:showMasterSkill(mo)
	local cfg = PetSkinConfig.instance:getPetSkinCfg(mo.curFaceId)

	self.txtName.text = ""
	self.txtDesc.text = ""

	MaterialMgr.resetAll(self.skillicon)

	if cfg and cfg.summonSkillId then
		local skillCfg = BattleConfig.instance:getSkillCo(cfg.summonSkillId, mo.curFaceId)
		local proxy = MaterialMgr.setCell(MatType.Skill, cfg.summonSkillId, self.skillicon)

		if proxy then
			proxy:setAutoTips(false)
		end

		self.txtName.text = skillCfg.name
		self.txtDesc.text = skillCfg.desc
	end
end

function ContractPetPopView:showDownPetIcon(mo)
	MaterialMgr.resetAll(self.item)
	GameUtil.SetActive(self.petGo, false)

	if mo then
		GameUtil.SetActive(self.petGo, true)
		MaterialMgr.setCellByMo(mo, self.item)

		self.txt.text = mo.summonMasterId > 0 and lang("契约精灵") or lang("召唤师")
	end
end

function ContractPetPopView:showTopPetIcon(mo)
	MaterialMgr.resetAll(self.itemTop)
	GameUtil.SetActive(self.petGoTop, false)

	if mo then
		GameUtil.SetActive(self.petGoTop, true)
		MaterialMgr.setCellByMo(mo, self.itemTop)

		self.txtTop.text = mo.summonMasterId > 0 and lang("契约精灵") or lang("召唤师")
	end
end

function ContractPetPopView:setSummonPet(mo)
	if mo then
		GameUtil.SetActive(self.empty, false)
		GameUtil.SetActive(self.contract, true)

		self.c_txtName.text = ""
		self.c_txtDesc.text = ""

		MaterialMgr.resetAll(self.c_skillicon)

		local skillId = mo.contractSkillId

		if skillId > 0 then
			local skillCfg = BattleConfig.instance:getSkillCo(skillId, mo.curFaceId)
			local proxy = MaterialMgr.setCell(MatType.Skill, skillId, self.c_skillicon)

			if proxy then
				proxy:setAutoTips(false)
			end

			self.c_txtName.text = skillCfg.name
			self.c_txtDesc.text = skillCfg.desc
		end
	else
		GameUtil.SetActive(self.empty, true)
		GameUtil.SetActive(self.contract, false)
	end
end

return ContractPetPopView
