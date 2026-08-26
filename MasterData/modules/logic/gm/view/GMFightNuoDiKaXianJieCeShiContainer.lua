-- chunkname: @modules/logic/gm/view/GMFightNuoDiKaXianJieCeShiContainer.lua

module("modules.logic.gm.view.GMFightNuoDiKaXianJieCeShiContainer", package.seeall)

local GMFightNuoDiKaXianJieCeShiContainer = class("GMFightNuoDiKaXianJieCeShiContainer", BaseViewContainer)

function GMFightNuoDiKaXianJieCeShiContainer:buildViews()
	local views = {}

	table.insert(views, GMFightNuoDiKaXianJieCeShi.New())

	return views
end

return GMFightNuoDiKaXianJieCeShiContainer
