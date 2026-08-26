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

function AbyssStageHeroItem:setInfo(heroId)
	local heroMo = HeroModel.instance:getByHeroId(heroId)

	if heroMo then
		local skinConfig = SkinConfig.instance:getSkinCo(heroMo.skin)

		self._simagehero:LoadImage(ResUrl.getHeadIconSmall(skinConfig.headIcon))
	else
		local heroConfig = HeroConfig.instance:getHeroCO(heroId)

		self._simagehero:LoadImage(ResUrl.getHeadIconSmall(heroConfig.skinId))
	end
end

function AbyssStageHeroItem:onDestroy()
	return
end

return AbyssStageHeroItem
