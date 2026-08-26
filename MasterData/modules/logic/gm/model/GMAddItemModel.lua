-- chunkname: @modules/logic/gm/model/GMAddItemModel.lua

module("modules.logic.gm.model.GMAddItemModel", package.seeall)

local GMAddItemModel = class("GMAddItemModel", ListScrollModel)

function GMAddItemModel:setFastAddHeroView(view)
	self.fastAddHeroView = view
end

function GMAddItemModel:onOnClickItem(characterCo)
	if self.fastAddHeroView then
		self.fastAddHeroView:onAddItemOnClick(characterCo)
	end
end

GMAddItemModel.instance = GMAddItemModel.New()

return GMAddItemModel
