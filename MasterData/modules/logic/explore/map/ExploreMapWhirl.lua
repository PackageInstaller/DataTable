-- chunkname: @modules/logic/explore/map/ExploreMapWhirl.lua

module("modules.logic.explore.map.ExploreMapWhirl", package.seeall)

local ExploreMapWhirl = class("ExploreMapWhirl")

function ExploreMapWhirl:ctor()
	self._whirlDict = {}
	self.typeToCls = {
		[ExploreEnum.WhirlType.Rune] = ExploreWhirlRune
	}
end

function ExploreMapWhirl:init(mapGo)
	self._mapGo = mapGo
	self._whirlRoot = gohelper.create3d(mapGo, "whirl")

	ExploreController.instance:registerCallback(ExploreEvent.UseItemChanged, self._onUseItemChange, self)
	self:_onUseItemChange(ExploreModel.instance:getUseItemUid())
end

function ExploreMapWhirl:_onUseItemChange(itemUid)
	local itemMo = ExploreBackpackModel.instance:getById(itemUid)

	if itemMo and itemMo.config.type == ExploreEnum.BackPackItemType.Rune then
		self:addWhirl(ExploreEnum.WhirlType.Rune)
	else
		self:removeWhirl(ExploreEnum.WhirlType.Rune)
	end
end

function ExploreMapWhirl:addWhirl(whirlType)
	if self._whirlDict[whirlType] then
		return self._whirlDict[whirlType]
	end

	local cls = self.typeToCls[whirlType]

	cls = cls or ExploreWhirlBase
	self._whirlDict[whirlType] = cls.New(self._whirlRoot, whirlType)

	return self._whirlDict[whirlType]
end

function ExploreMapWhirl:removeWhirl(whirlType)
	if self._whirlDict[whirlType] then
		self._whirlDict[whirlType]:destroy()

		self._whirlDict[whirlType] = nil
	end
end

function ExploreMapWhirl:getWhirl(whirlType)
	return self._whirlDict[whirlType] or nil
end

function ExploreMapWhirl:unloadMap()
	self:destroy()
end

function ExploreMapWhirl:destroy()
	ExploreController.instance:unregisterCallback(ExploreEvent.UseItemChanged, self._onUseItemChange, self)

	for _, v in pairs(self._whirlDict) do
		v:destroy()
	end

	self._whirlDict = {}
	self._mapGo = nil
end

return ExploreMapWhirl
