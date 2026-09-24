-- chunkname: @modules/logic/abyss/view/AbyssStageHeroItem.lua

module("modules.logic.abyss.view.AbyssStageHeroItem", package.seeall)

local AbyssStageHeroItem = class("AbyssStageHeroItem", LuaCompBase)

function AbyssStageHeroItem:init(go)
	self.go = go
	self._simagehero = gohelper.findChildSingleImage(self.go, "#simage_hero")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AbyssStageHeroItem:_editableInitView()
	return
end

function AbyssStageHeroItem:setInfo(heroData)
	local heroId = heroData.heroId
	local haveSkinId = heroData.skinId ~= nil and heroData.skinId ~= 0
	local skinConfig

	if haveSkinId then
		skinConfig = SkinConfig.instance:getSkinCo(heroData.skinId)
	else
		local heroMo = HeroModel.instance:getByHeroId(heroId)

		if heroMo then
			skinConfig = SkinConfig.instance:getSkinCo(heroMo.skin)
		else
			local heroConfig = HeroConfig.instance:getHeroCO(heroId)

			skinConfig = SkinConfig.instance:getSkinCo(heroConfig.skinId)
		end
	end

	self._simagehero:LoadImage(ResUrl.getHeadIconSmall(skinConfig.headIcon))
end

function AbyssStageHeroItem:onDestroy()
	return
end

return AbyssStageHeroItem
