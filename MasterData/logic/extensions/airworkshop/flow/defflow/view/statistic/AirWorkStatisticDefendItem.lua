-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/view/statistic/AirWorkStatisticDefendItem.lua

module("logic.extensions.airworkshop.flow.defflow.view.statistic.AirWorkStatisticDefendItem", package.seeall)

local M = class("AirWorkStatisticDefendItem")

function M:ctor(container)
	self._go = container.gameObject
	self._itemHero = goutil.findChild(self._go, "hero_item")
	self._groupGo = goutil.findChild(self._go, "heroScrollView/viewPort/group")
	self._groupItemGo = goutil.findChild(self._groupGo, "hero_item")

	goutil.addChildToParent(self._groupItemGo, self._groupGo.transform.parent.gameObject)
	goutil.setActive(self._groupItemGo, false)
	self:_bindEvents()
end

function M:_bindEvents()
	return
end

function M:_unbindEvents()
	for i, v in ipairs(self._heroItemViewList or {}) do
		v:unbindEvents()
		v:onExit()
	end
end

function M:OnDestroy()
	self:_unbindEvents()
end

function M:updateData(data, isKill)
	self._data = data

	local heroId = self._data.heroId
	local heroIdList = isKill and self._data.killList or self._data.beKillList

	if not heroIdList then
		self:_unbindEvents()
		goutil.clearChildren(self._groupGo)

		return
	end

	self:_unbindEvents()

	self._heroItemViewList = {}

	local shower1 = Astral.LuaComponentContainer.Add(self._itemHero, HeroHeadItem)
	local heroData = CharacterUtil.getPreviewHeroData(heroId)

	shower1:setHeroMO(heroData)
	shower1:showLevel(false)
	table.insert(self._heroItemViewList, shower1)
	goutil.clearChildren(self._groupGo)

	for i, v in ipairs(heroIdList or {}) do
		local itemGo = goutil.cloneAndSetParent(self._groupItemGo, self._groupGo.transform, "heroItem" .. i)

		goutil.setActive(itemGo, true)

		local heroGo = goutil.findChild(itemGo, "hero_item")
		local txtNumber = goutil.findChildTextComponent(itemGo, "txtNum")

		txtNumber.text = v.count

		local shower = Astral.LuaComponentContainer.Add(heroGo, HeroHeadItem)
		local heroData = CharacterUtil.getPreviewHeroData(v.heroId)

		shower:setHeroMO(heroData)
		shower:showLevel(false)
		table.insert(self._heroItemViewList, shower)
	end
end

return M
