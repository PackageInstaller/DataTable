-- chunkname: @modules/logic/social/view/SocialHeroItem.lua

module("modules.logic.social.view.SocialHeroItem", package.seeall)

local SocialHeroItem = class("SocialHeroItem", LuaCompBase)

function SocialHeroItem:init(go)
	self.go = go
	self._imagerare = gohelper.findChildImage(go, "Role/#image_Rare")
	self._imagecareer = gohelper.findChildImage(go, "Role/#image_Career")
	self._simageheroicon = gohelper.findChildSingleImage(go, "Role/#simage_HeroIcon")
	self._txtlv = gohelper.findChildTextMesh(go, "Lv/#txt_Lv")

	for i = 1, 5 do
		self["_goexSkillFull" .. i] = gohelper.findChild(go, "Lv/SuZao/" .. i .. "/FG")
	end

	self._gorank = gohelper.findChild(go, "Rank")

	for i = 1, 3 do
		self["_gorank" .. i] = gohelper.findChild(self._gorank, "rank" .. i)
	end
end

function SocialHeroItem:setActive(isActive)
	gohelper.setActive(self.go, isActive)
end

function SocialHeroItem:updateMo(mo)
	self:setActive(true)

	local level = mo.level
	local exSkillLv = mo.exSkillLevel
	local heroCo = lua_character.configDict[mo.heroId]
	local skinId = mo.skin

	if skinId == 0 then
		skinId = heroCo.skinId
	end

	local skinCo = lua_skin.configDict[skinId]
	local showLevel, rank = HeroConfig.instance:getShowLevel(level)

	self._simageheroicon:LoadImage(ResUrl.getRoomHeadIcon(skinCo.headIcon))
	UISpriteSetMgr.instance:setCommonSprite(self._imagecareer, "lssx_" .. tostring(heroCo.career))
	UISpriteSetMgr.instance:setCommonSprite(self._imagerare, "bgequip" .. CharacterEnum.Star[heroCo.rare])

	if rank == 1 then
		gohelper.setActive(self._gorank, false)
	else
		gohelper.setActive(self._gorank, true)

		for i = 1, 3 do
			gohelper.setActive(self["_gorank" .. i], i == rank - 1)
		end
	end

	for i = 1, 5 do
		gohelper.setActive(self["_goexSkillFull" .. i], i <= exSkillLv)
	end

	self._txtlv.text = "Lv." .. showLevel
end

function SocialHeroItem:onDestroy()
	self._simageheroicon:UnLoadImage()
end

return SocialHeroItem
