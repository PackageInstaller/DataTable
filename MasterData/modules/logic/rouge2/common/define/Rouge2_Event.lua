-- chunkname: @modules/logic/rouge2/common/define/Rouge2_Event.lua

module("modules.logic.rouge2.common.define.Rouge2_Event", package.seeall)

local Rouge2_Event = _M
local _uid = 1

local function E(name)
	assert(Rouge2_Event[name] == nil, "[Rouge2_Event] error redefined Rouge2_Event." .. name)

	Rouge2_Event[name] = _uid
	_uid = _uid + 1
end

E("OnSelectDifficulty")
E("OnSwitchDifficultyPage")
E("OnSelectCareerAttribute")
E("OnUpdateAttributeInfo")
E("OnSelectCareer")
E("OnBeginDragSkill")
E("OnEndDragSkill")
E("OnSelectActiveSkillHole")
E("OnUpdateActiveSkillInfo")
E("OnLongPressEditSkill")
E("OnScrollRelicsBag")
E("OnScrollBuffBag")
E("OnScrollSkillBag")
E("OnSwitchAttrTabItem")
E("OnSwitchItemDescMode")
E("OnSelectSkillTalent")
E("OnSelectTalentStage")
E("OnUpdateAttrInfo")
E("onLightAttr")
E("OnSelectAttrTab")
E("OnSelectSkillAttrUpdate")
E("OnUpdateRougeInfo")
E("OnUpdateRougeInfoCoin")
E("OnUpdateRevivalCoin")
E("SwitchCollectionInfoType")
E("OpenRougeView")
E("OnUpdateTeamSystem")

return Rouge2_Event
