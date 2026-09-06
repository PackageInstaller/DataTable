-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/contract/view/ContractSkillResetView.lua

module("logic.extensions.contract.view.ContractSkillResetView", package.seeall)

local ContractSkillResetView = class("ContractSkillResetView", TableViewComponent)

function ContractSkillResetView:buildUI()
	ContractSkillResetView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self._skillIcon = self:getGo("skill/skillIcon")
	self._txtName = self:getTxt("skill/txtName")
	self._txtDesc = self:getTxt("skill/txtDesc")
	self._itemIcon = self:getGo("txtCost/icon")
	self._goldBar = self:getGo("goldBarCon")
	self._btnReset = self:getBtn("btnReset")
	self._txtCost = self:getTxt("txtCost")
end

function ContractSkillResetView:bindEvents()
	ContractSkillResetView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnReset:AddClickListener(self._onClickReset, self)
end

function ContractSkillResetView:unbindEvents()
	ContractSkillResetView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._btnReset:RemoveClickListener()
end

function ContractSkillResetView:onEnter()
	ContractSkillResetView.super.onEnter(self)

	self._petMo = self:getFirstParam()

	local costStr = ContractConfig.instance:getConstValueByKey("RESET_CONTRACT_SKILL_COST")

	self._curCostStr = costStr
	self._costNum = self:_setGoldBar(costStr)

	self:_updateSkillList()
	self.addGEvent(self, GlobalNotify.NEW_CONTRACT_SKILL_INFO_UPDATE, self._onRefreshUI, self)
	self.addGEvent(self, GlobalNotify.NEW_CONTRACT_SKILL_INFO_RESET, self._onShowConfirmUI, self)
	self:_onRefreshUI()
	ContractController.instance:sendGetNewContractSkillInfo()
end

function ContractSkillResetView:onExit()
	ContractSkillResetView.super.onExit(self)
	self:_removeIcon()
end

function ContractSkillResetView:_onClickClose()
	self:close()
end

function ContractSkillResetView:_onRefreshUI()
	local info = ContractModel.instance:getNewTempSkill(self._petMo.petId)

	if info then
		self:_onShowConfirmUI()
	end

	self:_setCurContractSkillInfo(self._petMo.contractSkillId)
end

function ContractSkillResetView:_onShowConfirmUI()
	if not ViewMgr.instance:isOpen(ViewName.ContractSkillResetSureView) then
		UIStateManager.instance:push(ViewName.ContractSkillResetSureView, self._petMo)
	end
end

function ContractSkillResetView:_onClickReset()
	local matType, cfgId, num = MaterialMgr.getMatParams(self._curCostStr)
	local name = MaterialMgr.getMaterialsName(matType, cfgId)
	local content = string.format("是否消耗%s个%s，进行技能重置？", num, name)

	local function func()
		ContractController.instance:sendResetNewContractSkill(self._petMo.petId)
	end

	TipsFacade.instance:openPopupCostMatViewNew(matType, cfgId, num, content, func)
end

function ContractSkillResetView:_getPath()
	return {
		cellPath = "cell",
		viewPath = "tableview"
	}
end

function ContractSkillResetView:_updateCell(view, cell, data)
	local skillIcon = goutil.findChild(cell, "skillIcon")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtDesc = goutil.findChildTextComponent(cell, "txtDesc")

	MaterialMgr.setCell(MatType.Skill, data.contractSkillId, skillIcon)

	local cfg = MaterialMgr.getMatCfg(MatType.Skill, data.contractSkillId)

	if cfg then
		txtName.text = cfg.name
		txtDesc.text = cfg.desc
	end
end

function ContractSkillResetView:_clearTableview(cell)
	local skillIcon = goutil.findChild(cell, "skillIcon")

	MaterialMgr.resetAll(skillIcon)
end

function ContractSkillResetView:_updateSkillList()
	local cfgStrategys = ContractConfig.instance:getSkillStrategyById()

	self:updateListData(cfgStrategys)
end

function ContractSkillResetView:_setGoldBar(costStr)
	local matMo = string.splitToNumber(costStr, ":")
	local objList = {
		{
			showAdd = true,
			id = MaterialMgr.createSerName(matMo[1], matMo[2])
		}
	}

	MainUIController.instance:showGlodBar(self._goldBar, self._viewPresentor, objList)

	local spriteType = uGuiUtil.SpriteType.BigBg
	local iconUrl = ""
	local cfg = MaterialMgr.getMatCfg(matMo[1], matMo[2])

	if cfg then
		local icon = cfg.icon

		iconUrl = GameUrl.getItemIconUrl(icon)
	end

	uGuiUtil.setSpriteToImage(self._itemIcon, spriteType, iconUrl)

	local costNum = matMo[3]

	self._txtCost.text = costNum

	return costNum
end

function ContractSkillResetView:_removeIcon()
	Framework.ImageBigBG.Get(self._itemIcon):ClearImage()
	MaterialMgr.resetAll(self._skillIcon)
end

function ContractSkillResetView:_setCurContractSkillInfo(contractSkillId)
	MaterialMgr.setCell(MatType.Skill, contractSkillId, self._skillIcon)

	local cfg = MaterialMgr.getMatCfg(MatType.Skill, contractSkillId)

	if cfg then
		self._txtName.text = cfg.name
		self._txtDesc.text = cfg.desc
	end
end

return ContractSkillResetView
