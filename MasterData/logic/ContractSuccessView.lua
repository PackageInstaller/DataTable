-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/contract/view/ContractSuccessView.lua

module("logic.extensions.contract.view.ContractSuccessView", package.seeall)

local ContractSuccessView = class("ContractSuccessView", ViewComponent)

function ContractSuccessView:buildUI()
	ContractSuccessView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self._leftHead = self:getGo("leftHead")
	self._rightHead = self:getGo("rightHead")
	self._skillIcon = self:getGo("skill/icon")
	self._txtName = self:getTxt("skill/txtName")
	self._txtDesc = self:getTxt("skill/txtDesc")
end

function ContractSuccessView:bindEvents()
	ContractSuccessView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
end

function ContractSuccessView:unbindEvents()
	ContractSuccessView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
end

function ContractSuccessView:onEnter()
	ContractSuccessView.super.onEnter(self)

	local params = self:getOpenParam()

	if not params or not params[1] or not params[2] then
		return
	end

	self._summonerId = params[1]
	self._summonId = params[2]

	local summonerPetMo = BagPetsController.instance:getPet(self._summonerId)
	local summonPetMo = BagPetsController.instance:getPet(self._summonId)

	if summonerPetMo and summonPetMo then
		MaterialMgr.setCell(MatType.Pet, summonerPetMo.raceId, self._leftHead)
		MaterialMgr.setCell(MatType.Pet, summonPetMo.raceId, self._rightHead)

		local contractCfg = ContractConfig.instance:getGroupCfg(summonerPetMo.raceId, summonPetMo.raceId)

		if contractCfg then
			local skillId = ContractModel.instance:getSkillIdByGroupId(contractCfg.groupId)

			MaterialMgr.setCell(MatType.Skill, skillId, self._skillIcon)

			local cfg = MaterialMgr.getMatCfg(MatType.Skill, skillId)

			if cfg then
				self._txtName.text = cfg.name
				self._txtDesc.text = cfg.desc
			end
		end
	end
end

function ContractSuccessView:onExit()
	ContractSuccessView.super.onExit(self)
	MaterialMgr.resetAll(self._leftHead)
	MaterialMgr.resetAll(self._rightHead)
	MaterialMgr.resetAll(self._skillIcon)
end

function ContractSuccessView:_onClickClose()
	self:close()
end

return ContractSuccessView
