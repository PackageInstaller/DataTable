-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/view/statistic/AirWorkStatisticAttackItem.lua

module("logic.extensions.airworkshop.flow.defflow.view.statistic.AirWorkStatisticAttackItem", package.seeall)

local M = class("AirWorkStatisticAttackItem")

function M:ctor(container)
	self._go = container.gameObject
	self._itemHero = goutil.findChild(self._go, "hero_item")
	self._txtNumber = goutil.findChildTextComponent(self._go, "txtNum")
	self._thoughtGo = goutil.findChild(self._go, "btnThought")
	self._imgThought = goutil.findChildImageComponent(self._go, "btnThought/imgIcon")
	self._item2Go = goutil.findChild(self._go, "backpack_item2")

	self:_bindEvents()
end

function M:_bindEvents()
	return
end

function M:_unbindEvents()
	IconLoader.clearSprite(self._imgThought)

	for i, v in ipairs(self._heroItemViewList or {}) do
		v:unbindEvents()
		v:onExit()
	end
end

function M:OnDestroy()
	self:_unbindEvents()
end

function M:updateData(data)
	self._data = data

	local heroId = self._data.heroId
	local count = self._data.count
	local thinkingId = self._data.thinkingId
	local echoItemId = self._data.echoItemId
	local cfg = ThinkingConfig.instance:getThinkingCO(thinkingId)
	local icon = cfg and cfg.icon or ""

	goutil.setActive(self._thoughtGo, thinkingId > 0)
	goutil.setActive(self._item2Go, echoItemId > 0)

	self._heroItemViewList = {}
	self._txtNumber.text = count

	local shower = Astral.LuaComponentContainer.Add(self._itemHero, HeroHeadItem)
	local heroData = CharacterUtil.getPreviewHeroData(heroId)

	shower:setHeroMO(heroData)
	shower:showLevel(false)
	table.insert(self._heroItemViewList, shower)

	if thinkingId > 0 then
		IconLoader.setSprite(self._imgThought, IconType.Thought, icon)
	end

	if echoItemId > 0 then
		itemView = Astral.LuaComponentContainer.Add(self._item2Go, ItemCell)

		itemView:setShowSelectedEffect(false)
		itemView:updateData(ItemUtil.createItemData({
			count = 0,
			itemId = echoItemId
		}))
		itemView:setIsShowTips(false)
	end
end

return M
