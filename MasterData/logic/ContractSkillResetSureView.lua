-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/contract/view/ContractSkillResetSureView.lua

module("logic.extensions.contract.view.ContractSkillResetSureView", package.seeall)

local ContractSkillResetSureView = class("ContractSkillResetSureView", ViewComponent)

function ContractSkillResetSureView:ctor()
	ContractSkillResetSureView.super.ctor(self)
end

function ContractSkillResetSureView:buildUI()
	ContractSkillResetSureView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self._txtCost = self:getTxt("txtCost")
	self._icon = self:getGo("txtCost/icon")
	self._newSkillIcon = self:getGo("newItem/skillIcon")
	self._newTxtName = self:getTxt("newItem/txtName")
	self._newTxtDesc = self:getTxt("newItem/txtDesc")
	self._nowSkillIcon = self:getGo("nowItem/skillIcon")
	self._nowTxtName = self:getTxt("nowItem/txtName")
	self._nowTxtDesc = self:getTxt("nowItem/txtDesc")
	self._btnReset = self:getBtn("btnReset")
	self._btnCancel = self:getBtn("btnCancel")
	self._btnSure = self:getBtn("btnSure")
end

function ContractSkillResetSureView:bindEvents()
	ContractSkillResetSureView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnReset:AddClickListener(self._onClickReset, self)
	self._btnCancel:AddClickListener(self._onClickCancel, self)
	self._btnSure:AddClickListener(self._onClickSure, self)
end

function ContractSkillResetSureView:unbindEvents()
	ContractSkillResetSureView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._btnReset:RemoveClickListener()
	self._btnCancel:RemoveClickListener()
	self._btnSure:RemoveClickListener()
end

function ContractSkillResetSureView:onEnter()
	ContractSkillResetSureView.super.onEnter(self)

	self._petMo = self:getFirstParam()
	self._curCostStr = ContractConfig.instance:getConstValueByKey("RESET_CONTRACT_SKILL_COST")

	self.addGEvent(self, GlobalNotify.NEW_CONTRACT_SKILL_INFO_RESET, self._onPetSingleContractInfoRes, self)

	self._costNum = self:_setCostItem()

	self:_setNowSkillInfo()
	self:_setNewSkillInfo()
end

function ContractSkillResetSureView:onExit()
	ContractSkillResetSureView.super.onExit(self)
	self:_removeIcon()
end

function ContractSkillResetSureView:_onClickClose()
	self:close()
end

function ContractSkillResetSureView:_onClickReset()
	local matType, cfgId, num = MaterialMgr.getMatParams(self._curCostStr)
	local name = MaterialMgr.getMaterialsName(matType, cfgId)
	local content = string.format("是否消耗%d个%s，进行技能重置？", self._costNum, name)

	local function func()
		ContractController.instance:sendResetNewContractSkill(self._petMo.petId)
	end

	TipsFacade.instance:openPopupWindow(lang("tip"), content, func)
end

function ContractSkillResetSureView:_onClickCancel()
	local content = "是否放弃替换新的契约技?"

	local function func()
		ContractController.instance:sendNewConfirmContractSkill(self._petMo.petId, false)
		self:_onClickClose()
	end

	TipsFacade.instance:openPopupWindow(lang("tip"), content, func)
end

function ContractSkillResetSureView:_onClickSure()
	local info = ContractModel.instance:getNewTempSkill(self._petMo.petId) or {}
	local newSkillId = checknumber(info.tempContractSkillId)

	if newSkillId > 0 then
		self._petMo.contractSkillId = newSkillId
	end

	ContractController.instance:sendNewConfirmContractSkill(self._petMo.petId, true)
	self:_onClickClose()
end

function ContractSkillResetSureView:_onPetSingleContractInfoRes()
	self:_setNewSkillInfo()
end

function ContractSkillResetSureView:_setCostItem()
	local matMo = string.splitToNumber(self._curCostStr, ":")
	local spriteType = uGuiUtil.SpriteType.BigBg
	local iconUrl = ""
	local cfg = MaterialMgr.getMatCfg(matMo[1], matMo[2])

	if cfg then
		local icon = cfg.icon

		iconUrl = GameUrl.getItemIconUrl(icon)
	end

	uGuiUtil.setSpriteToImage(self._icon, spriteType, iconUrl)

	self._txtCost.text = matMo[3]

	return matMo[3]
end

function ContractSkillResetSureView:_removeIcon()
	Framework.ImageBigBG.Get(self._icon):ClearImage()
	MaterialMgr.resetAll(self._nowSkillIcon)
	MaterialMgr.resetAll(self._newSkillIcon)
end

function ContractSkillResetSureView:_setNowSkillInfo()
	MaterialMgr.resetAll(self._nowSkillIcon)

	local curSkillId = self._petMo.contractSkillId

	MaterialMgr.setCell(MatType.Skill, curSkillId, self._nowSkillIcon)

	local cfgNow = MaterialMgr.getMatCfg(MatType.Skill, curSkillId)

	if cfgNow then
		self._nowTxtName.text = cfgNow.name
		self._nowTxtDesc.text = cfgNow.desc
	end
end

function ContractSkillResetSureView:_setNewSkillInfo()
	MaterialMgr.resetAll(self._newSkillIcon)

	local info = ContractModel.instance:getNewTempSkill(self._petMo.petId) or {}
	local newSkillId = checknumber(info.tempContractSkillId)

	if newSkillId > 0 then
		MaterialMgr.setCell(MatType.Skill, newSkillId, self._newSkillIcon)

		local cfgNew = MaterialMgr.getMatCfg(MatType.Skill, newSkillId)

		if cfgNew then
			self._newTxtName.text = cfgNew.name
			self._newTxtDesc.text = cfgNew.desc
		end
	end
end

return ContractSkillResetSureView
