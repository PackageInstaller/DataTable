-- chunkname: @modules/logic/main/view/ActCenterItem_SpringSignViewBtn_1_6.lua

module("modules.logic.main.view.ActCenterItem_SpringSignViewBtn_1_6", package.seeall)

local ActCenterItem_SpringSignViewBtn_1_6 = class("ActCenterItem_SpringSignViewBtn_1_6", Activity101SignViewBtnBase)

function ActCenterItem_SpringSignViewBtn_1_6:onRefresh()
	self:_setMainSprite("v1a6_act_icon2")
end

function ActCenterItem_SpringSignViewBtn_1_6:_gm_ActIds()
	return {
		ActivityEnum.Activity.SpringSign
	}
end

return ActCenterItem_SpringSignViewBtn_1_6
