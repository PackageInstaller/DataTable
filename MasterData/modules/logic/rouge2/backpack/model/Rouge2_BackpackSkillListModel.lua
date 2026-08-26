-- chunkname: @modules/logic/rouge2/backpack/model/Rouge2_BackpackSkillListModel.lua

module("modules.logic.rouge2.backpack.model.Rouge2_BackpackSkillListModel", package.seeall)

local Rouge2_BackpackSkillListModel = class("Rouge2_BackpackSkillListModel", ListScrollModel)

function Rouge2_BackpackSkillListModel:initList()
	local skillList = Rouge2_BackpackModel.instance:getItemList(Rouge2_Enum.BagType.ActiveSkill)

	self:setList(skillList)
end

Rouge2_BackpackSkillListModel.instance = Rouge2_BackpackSkillListModel.New()

return Rouge2_BackpackSkillListModel
