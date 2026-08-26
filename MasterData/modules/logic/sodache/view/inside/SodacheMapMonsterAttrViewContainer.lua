-- chunkname: @modules/logic/sodache/view/inside/SodacheMapMonsterAttrViewContainer.lua

module("modules.logic.sodache.view.inside.SodacheMapMonsterAttrViewContainer", package.seeall)

local SodacheMapMonsterAttrViewContainer = class("SodacheMapMonsterAttrViewContainer", BaseViewContainer)

function SodacheMapMonsterAttrViewContainer:buildViews()
	return {
		SodacheMapMonsterAttrView.New()
	}
end

return SodacheMapMonsterAttrViewContainer
