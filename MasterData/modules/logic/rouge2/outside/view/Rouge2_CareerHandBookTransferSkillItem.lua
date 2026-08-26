-- chunkname: @modules/logic/rouge2/outside/view/Rouge2_CareerHandBookTransferSkillItem.lua

module("modules.logic.rouge2.outside.view.Rouge2_CareerHandBookTransferSkillItem", package.seeall)

local Rouge2_CareerHandBookTransferSkillItem = class("Rouge2_CareerHandBookTransferSkillItem", LuaCompBase)

function Rouge2_CareerHandBookTransferSkillItem:init(go)
	self.go = go
	self._imageSkillIcon = gohelper.findChildImage(self.go, "#image_SkillIcon")
	self._btnSearch = gohelper.findChildButtonWithAudio(self.go, "#btn_Search")
	self._txtskillName = gohelper.findChildText(self.go, "#txt_skillName")
	self._txtskillDesc = gohelper.findChildText(self.go, "#txt_skillDesc")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_CareerHandBookTransferSkillItem:addEventListeners()
	self._btnSearch:AddClickListener(self._btnSearchOnClick, self)
end

function Rouge2_CareerHandBookTransferSkillItem:addEventListeners()
	self._btnSearch:RemoveClickListener()
end

function Rouge2_CareerHandBookTransferSkillItem:_btnSearchOnClick()
	return
end

function Rouge2_CareerHandBookTransferSkillItem:_editableInitView()
	gohelper.setActive(self._btnSearch, false)

	self._simageSkillIcon = gohelper.findChildSingleImage(self.go, "#image_SkillIcon")
end

function Rouge2_CareerHandBookTransferSkillItem:setInfo(skillId)
	local config = Rouge2_CollectionConfig.instance:getActiveSkillConfig(skillId)

	Rouge2_IconHelper.setActiveSkillIcon(skillId, self._simageSkillIcon)

	self._txtskillName.text = config.name

	Rouge2_ItemDescHelper.setItemDescStr(Rouge2_Enum.ItemDataType.Config, config.id, self._txtskillDesc, Rouge2_Enum.ItemDescMode.Full)
end

function Rouge2_CareerHandBookTransferSkillItem:onDestroy()
	return
end

return Rouge2_CareerHandBookTransferSkillItem
