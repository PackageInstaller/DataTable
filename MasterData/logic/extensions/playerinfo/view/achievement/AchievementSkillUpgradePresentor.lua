-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/achievement/AchievementSkillUpgradePresentor.lua

module("logic.extensions.playerinfo.view.achievement.AchievementSkillUpgradePresentor", package.seeall)

local M = class("AchievementSkillUpgradePresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Achievement_achievement_upgrade_show_panel,
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_Task)
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, AchievementSkillUpgrade.New())

	return views
end

return M
