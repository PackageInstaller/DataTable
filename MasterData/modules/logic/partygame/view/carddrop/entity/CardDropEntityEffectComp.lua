-- chunkname: @modules/logic/partygame/view/carddrop/entity/CardDropEntityEffectComp.lua

module("modules.logic.partygame.view.carddrop.entity.CardDropEntityEffectComp", package.seeall)

local CardDropEntityEffectComp = class("CardDropEntityEffectComp", CardDropEntityCompBase)

function CardDropEntityEffectComp:init(uid, entity)
	CardDropEntityEffectComp.super.init(self, uid, entity)

	self.localEffectList = {}
	self.globalEffectList = {}
end

function CardDropEntityEffectComp:addLocalEffect(effectName, posX, posY, posZ, side)
	local effectWrap = CardDropEntityEffectWrap.New()

	effectWrap:init(self.uid, self.entity)
	effectWrap:setSide(side)
	effectWrap:createEffect(effectName, self.entity:getSpineGo())
	effectWrap:setLocalPos(posX or 0, posY or 0, posZ or 0)
	table.insert(self.localEffectList, effectWrap)

	return effectWrap
end

function CardDropEntityEffectComp:addGlobalEffect(effectName, posX, posY, posZ, side)
	local effectWrap = CardDropEntityEffectWrap.New()

	effectWrap:init(self.uid, self.entity)
	effectWrap:setSide(side)

	local parent = CardDropTimelineController.instance:getEffectRoot()

	effectWrap:createEffect(effectName, parent)
	effectWrap:setLocalPos(posX or 0, posY or 0, posZ or 0)
	table.insert(self.globalEffectList, effectWrap)

	return effectWrap
end

function CardDropEntityEffectComp:removeLocalEffect(effectWrap)
	if not effectWrap then
		return
	end

	for index, _effectWrap in ipairs(self.localEffectList) do
		if _effectWrap.uid == effectWrap.uid then
			table.remove(self.localEffectList, index)

			break
		end
	end

	self:_removeEffectWrap(effectWrap)
end

function CardDropEntityEffectComp:removeGlobalEffect(effectWrap)
	if not effectWrap then
		return
	end

	for index, _effectWrap in ipairs(self.globalEffectList) do
		if _effectWrap.uid == effectWrap.uid then
			table.remove(self.globalEffectList, index)

			break
		end
	end

	self:_removeEffectWrap(effectWrap)
end

function CardDropEntityEffectComp:_removeEffectWrap(effectWrap)
	if not effectWrap then
		return
	end

	effectWrap:destroy()
end

function CardDropEntityEffectComp:destroy()
	for _, effectWrap in ipairs(self.localEffectList) do
		effectWrap:destroy()
	end

	tabletool.clear(self.localEffectList)

	for _, effectWrap in ipairs(self.globalEffectList) do
		effectWrap:destroy()
	end

	tabletool.clear(self.globalEffectList)
	CardDropEntityEffectComp.super.destroy(self)
end

return CardDropEntityEffectComp
