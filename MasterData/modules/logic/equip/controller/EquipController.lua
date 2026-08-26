-- chunkname: @modules/logic/equip/controller/EquipController.lua

module("modules.logic.equip.controller.EquipController", package.seeall)

local EquipController = class("EquipController", BaseController)

function EquipController:onInit()
	return
end

function EquipController:onInitFinish()
	return
end

function EquipController:addConstEvents()
	return
end

function EquipController:reInit()
	return
end

function EquipController:openEquipStrengthenAlertView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.EquipStrengthenAlertView, param, isImmediate)
end

function EquipController:openEquipView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.EquipView, param, isImmediate)
end

function EquipController:openEquipBreakResultView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.EquipBreakResultView, param, isImmediate)
end

function EquipController:openEquipSkillLevelUpView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.EquipSkillLevelUpView, param, isImmediate)
end

function EquipController:openEquipSkillTipView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.EquipSkillTipView, param, isImmediate)
end

function EquipController:closeEquipSkillTipView()
	ViewMgr.instance:closeView(ViewName.EquipSkillTipView)
end

function EquipController:openEquipInfoTeamView(viewParam)
	ViewMgr.instance:openView(ViewName.EquipInfoTeamShowView, viewParam)
end

function EquipController:openEquipTeamView(posIndex, viewParam)
	EquipTeamListModel.instance:openTeamEquip(posIndex, viewParam.heroMO)
	ViewMgr.instance:openView(ViewName.EquipTeamView, viewParam)
end

function EquipController:openEquipTeamShowView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.EquipTeamShowView, param, isImmediate)
end

function EquipController:openEquipDecomposeView()
	ViewMgr.instance:openView(ViewName.EquipDecomposeView)
end

function EquipController:closeEquipTeamShowView(isImmediate, closeManually)
	ViewMgr.instance:closeView(ViewName.EquipTeamShowView, isImmediate, closeManually)
end

EquipController.instance = EquipController.New()

return EquipController
