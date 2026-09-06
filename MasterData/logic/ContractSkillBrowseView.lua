-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/contract/view/ContractSkillBrowseView.lua

module("logic.extensions.contract.view.ContractSkillBrowseView", package.seeall)

local ContractSkillBrowseView = class("ContractSkillBrowseView", TableViewComponent)

function ContractSkillBrowseView:buildUI()
	ContractSkillBrowseView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
end

function ContractSkillBrowseView:bindEvents()
	ContractSkillBrowseView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
end

function ContractSkillBrowseView:unbindEvents()
	ContractSkillBrowseView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
end

function ContractSkillBrowseView:onEnter()
	ContractSkillBrowseView.super.onEnter(self)

	local params = self:getOpenParam()

	self._summonerId = params[1]
	self._summonId = params[2]

	self:_updateSkillList()
end

function ContractSkillBrowseView:onExit()
	ContractSkillBrowseView.super.onExit(self)
end

function ContractSkillBrowseView:_onClickClose()
	self:close()
end

function ContractSkillBrowseView:_getPath()
	return {
		cellPath = "cell",
		viewPath = "tableview"
	}
end

function ContractSkillBrowseView:_updateCell(view, cell, data)
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

function ContractSkillBrowseView:_clearTableview(cell)
	local skillIcon = goutil.findChild(cell, "skillIcon")

	MaterialMgr.resetAll(skillIcon)
end

function ContractSkillBrowseView:_updateSkillList()
	local cfgStrategys = ContractConfig.instance:getSkillStrategyById()

	self:updateListData(cfgStrategys)
end

return ContractSkillBrowseView
