-- chunkname: @modules/logic/gm/view/GMFightNuoDiKaXianJieAnNiuContainer.lua

module("modules.logic.gm.view.GMFightNuoDiKaXianJieAnNiuContainer", package.seeall)

local GMFightNuoDiKaXianJieAnNiuContainer = class("GMFightNuoDiKaXianJieAnNiuContainer", BaseViewContainer)

function GMFightNuoDiKaXianJieAnNiuContainer:buildViews()
	local views = {}

	table.insert(views, GMFightNuoDiKaXianJieAnNiu.New())

	return views
end

return GMFightNuoDiKaXianJieAnNiuContainer
