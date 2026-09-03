-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/petRace/view/component/PetRaceHeroIconCell.lua

PetRaceHeroIconCell = class("PetRaceHeroIconCell", objectlua.Object)

PetRaceHeroIconCell:has("_viewFactory", {
	is = "r"
}):injectWith("legs.ViewFactoryAdapter")
PetRaceHeroIconCell:has("_petRaceSystem", {
	is = "r"
}):injectWith("PetRaceSystem")

function PetRaceHeroIconCell:initialize(info)
	super.initialize(self)

	self._heroInfo = info.heroInfo
	self._mediator = info.mediator
end

function PetRaceHeroIconCell:userInject()
	self:setupView()
end

function PetRaceHeroIconCell:getView()
	return self._view
end

function PetRaceHeroIconCell:getHeroIcon()
	return self._heroIcon
end

function PetRaceHeroIconCell:update(data, index)
	if not tolua.isnull(self._heroIcon) then
		self._heroIcon:removeFromParent()
	end

	self._heroIcon = IconFactory:createHeroIcon({
		id = data.heroInfo:getId(),
		level = data.heroInfo:getLevel(),
		star = data.heroInfo:getStar(),
		quality = data.heroInfo:getQuality()
	}, {
		hideName = true,
		isRect = true,
		scale = 0.6,
		isWidget = true
	})

	self._view:addChild(self._heroIcon)

	self._heroInfo = data.heroInfo
end

function PetRaceHeroIconCell:getHeroId()
	return self._heroInfo:getId()
end

function PetRaceHeroIconCell:setupView()
	self._view = self:getViewFactory():createViewByResourceId("asset/ui/Node_heroHeadCell.csb")

	self._view:setPosition(50, 50)
end

function PetRaceHeroIconCell:updateLimateSta(sta)
	if sta then
		if self._heroIcon:getChildByName("race_cell_limit") == nil then
			local node = cc.Node:create()

			node:addTo(self._heroIcon, 9999)
			node:setName("race_cell_limit")

			local size = self._heroIcon:getContentSize()
			local maskLayer = cc.LayerColor:create(cc.c4b(0, 0, 0, 0), size.width, size.height)

			maskLayer:addTo(node, 1)

			local label = cc.Label:createWithTTF("不满足上阵要求", TTF_FONT_FZYH_R, 20)

			label:setDimensions(80, 0)
			label:addTo(node, 2)
		end

		self._heroIcon:getChildByName("race_cell_limit"):setVisible(true)
	elseif self._heroIcon:getChildByName("race_cell_limit") then
		self._heroIcon:getChildByName("race_cell_limit"):setVisible(true)
	end
end
