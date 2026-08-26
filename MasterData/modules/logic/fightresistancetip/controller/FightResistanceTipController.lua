-- chunkname: @modules/logic/fightresistancetip/controller/FightResistanceTipController.lua

module("modules.logic.fightresistancetip.controller.FightResistanceTipController", package.seeall)

local FightResistanceTipController = class("FightResistanceTipController")

function FightResistanceTipController:openFightResistanceTipView(resistanceDict, screenPos)
	ViewMgr.instance:openView(ViewName.FightResistanceTipView, {
		resistanceDict = resistanceDict,
		screenPos = screenPos
	})
end

FightResistanceTipController.instance = FightResistanceTipController.New()

return FightResistanceTipController
