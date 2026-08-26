-- chunkname: @modules/logic/gm/model/GMFastAddHeroHadHeroItemModel.lua

module("modules.logic.gm.model.GMFastAddHeroHadHeroItemModel", package.seeall)

local GMFastAddHeroHadHeroItemModel = class("GMFastAddHeroHadHeroItemModel", ListScrollModel)

GMFastAddHeroHadHeroItemModel.ShowType = {
	Equip = 2,
	Hero = 1
}

function GMFastAddHeroHadHeroItemModel:refreshList(moList)
	table.sort(moList, self._sortMo)
	self:setList(moList)
end

function GMFastAddHeroHadHeroItemModel._sortMo(a, b)
	if a.config.id ~= b.config.id then
		return a.config.id > b.config.id
	end

	return a.uid > b.uid
end

function GMFastAddHeroHadHeroItemModel:setShowType(type)
	self.showType = type
end

function GMFastAddHeroHadHeroItemModel:getShowType()
	return self.showType
end

function GMFastAddHeroHadHeroItemModel:changeShowType()
	self.showType = self.showType == GMFastAddHeroHadHeroItemModel.ShowType.Hero and GMFastAddHeroHadHeroItemModel.ShowType.Equip or GMFastAddHeroHadHeroItemModel.ShowType.Hero
end

function GMFastAddHeroHadHeroItemModel:setFastAddHeroView(view)
	self.fastAddHeroView = view
end

function GMFastAddHeroHadHeroItemModel:changeSelectHeroItem(mo)
	if self.fastAddHeroView then
		self.fastAddHeroView:changeSelectHeroItemMo(mo)
	end
end

function GMFastAddHeroHadHeroItemModel:setSelectMo(mo)
	self.selectMo = mo

	GMController.instance:dispatchEvent(GMController.Event.ChangeSelectHeroItem)
end

function GMFastAddHeroHadHeroItemModel:getSelectMo()
	return self.selectMo
end

GMFastAddHeroHadHeroItemModel.instance = GMFastAddHeroHadHeroItemModel.New()

return GMFastAddHeroHadHeroItemModel
