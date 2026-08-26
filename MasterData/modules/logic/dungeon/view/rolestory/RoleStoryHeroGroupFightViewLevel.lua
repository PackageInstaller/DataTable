-- chunkname: @modules/logic/dungeon/view/rolestory/RoleStoryHeroGroupFightViewLevel.lua

module("modules.logic.dungeon.view.rolestory.RoleStoryHeroGroupFightViewLevel", package.seeall)

local RoleStoryHeroGroupFightViewLevel = class("RoleStoryHeroGroupFightViewLevel", HeroGroupFightViewLevel)

function RoleStoryHeroGroupFightViewLevel:_showEnemyList()
	RoleStoryHeroGroupFightViewLevel.super._showEnemyList(self)

	self._txtrecommendlevel.text = luaLang("common_none")
end

function RoleStoryHeroGroupFightViewLevel:_onEnemyItemShow(obj, data, index)
	local icon = gohelper.findChildImage(obj, "icon")
	local kingIcon = gohelper.findChild(obj, "icon/kingIcon")
	local enemy_count = gohelper.findChildTextMesh(obj, "enemycount")

	UISpriteSetMgr.instance:setCommonSprite(icon, "lssx_" .. tostring(data.career))

	enemy_count.text = ""

	gohelper.setActive(kingIcon, index <= self._enemy_boss_end_index)
end

return RoleStoryHeroGroupFightViewLevel
