-- chunkname: @modules/logic/survival/view/handbook/SurvivalHandbookViewComp.lua

module("modules.logic.survival.view.handbook.SurvivalHandbookViewComp", package.seeall)

local SurvivalHandbookViewComp = class("SurvivalHandbookViewComp", LuaCompBase)

function SurvivalHandbookViewComp:init(go)
	self.go = go
	self.canvasGroup = gohelper.onceAddComponent(go, gohelper.Type_CanvasGroup)
end

function SurvivalHandbookViewComp:onOpen()
	return
end

function SurvivalHandbookViewComp:onClose()
	return
end

return SurvivalHandbookViewComp
