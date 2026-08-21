-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/util/CharacterSkinUtil.lua

module("logic.extensions.charactersystem.util.CharacterSkinUtil", package.seeall)

function getSkinDungeonId(heroId, skinId)
	if not skinId or skinId == 0 then
		return 180000 + heroId % 1000
	else
		return HeroSkinModel.instance:getSkinMo(heroId, skinId):getLevelId()
	end
end

function getHeroUsingSkinId(heroId)
	local heroData = HeroDepotModel.instance:getHeroInfoByID(heroId)

	if heroData then
		return heroData:getSkinId()
	end

	return 0
end

return M
