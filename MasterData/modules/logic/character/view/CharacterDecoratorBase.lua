-- chunkname: @modules/logic/character/view/CharacterDecoratorBase.lua

module("modules.logic.character.view.CharacterDecoratorBase", package.seeall)

local CharacterDecoratorBase = class("CharacterDecoratorBase", RougeSimpleItemBase)

function CharacterDecoratorBase:ctor(...)
	CharacterDecoratorBase.super.ctor(self, ...)
end

function CharacterDecoratorBase:onDestroyView()
	CharacterDecoratorBase.super.onDestroyView(self)
end

function CharacterDecoratorBase:setData(mo)
	CharacterDecoratorBase.super.setData(self, mo)

	return self
end

function CharacterDecoratorBase:_getHeroCO(optHeroId)
	return HeroConfig.instance:getHeroCO(optHeroId or self:heroId())
end

function CharacterDecoratorBase:_getNameAndEnByHeroCO(optHeroCO)
	optHeroCO = optHeroCO or self:heroCO()

	return optHeroCO.name, optHeroCO.nameEng
end

function CharacterDecoratorBase:_getName4(optHeroCO)
	optHeroCO = optHeroCO or self:heroCO()

	local name = optHeroCO.name
	local nameEng = optHeroCO.nameEng
	local oriHeroCO = self:_getHeroCO(optHeroCO.oriHeroId or 0)

	if oriHeroCO then
		if not oriHeroCO.name then
			local oriName = name

			if oriHeroCO then
				if not oriHeroCO.nameEng then
					local oriNameEng = nameEng

					return name, nameEng, oriName, oriNameEng
				end
			end
		end
	end
end

function CharacterDecoratorBase:_bindObjImpl(assertCheckedClass, memName, optObj)
	if self[memName] == optObj then
		return
	end

	GameUtil.onDestroyViewMember(self, memName)

	if optObj == nil then
		return
	end

	assert(isTypeOf(optObj, assertCheckedClass), debug.traceback())

	self[memName] = optObj
end

function CharacterDecoratorBase:heroId()
	return (self._mo or nil) and (self._mo.heroId or 0)
end

function CharacterDecoratorBase:heroCO()
	self._heroCO = self._heroCO or self:_getHeroCO()

	return self._heroCO
end

function CharacterDecoratorBase:oriHeroId()
	return self:heroCO().oriHeroId or 0
end

function CharacterDecoratorBase:oriHeroCO()
	return self:_getHeroCO(self:oriHeroId())
end

function CharacterDecoratorBase:spName()
	return self:heroCO().spName or ""
end

function CharacterDecoratorBase:bEmptySpName()
	return string.nilorempty(self:spName())
end

return CharacterDecoratorBase
