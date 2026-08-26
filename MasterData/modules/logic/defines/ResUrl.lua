-- chunkname: @modules/logic/defines/ResUrl.lua

module("modules.logic.defines.ResUrl", package.seeall)

local ResUrl = _M

function ResUrl.getSceneLevelUrl(levelId)
	local levelCO = lua_scene_level.configDict[levelId]

	if levelCO then
		return string.format("scenes/%s/%s_p.prefab", levelCO.resName, levelCO.resName)
	else
		logError("scene level config not exist, levelId = " .. levelId)
	end
end

function ResUrl.getExploreSceneLevelUrl(levelId)
	local levelCO = lua_scene_level.configDict[levelId]

	if levelCO then
		return string.format("modules/explore/scene/prefab/%s_p.prefab", levelCO.resName)
	else
		logError("scene level config not exist, levelId = " .. levelId)
	end
end

function ResUrl.getSurvivalSceneLevelUrl(levelId)
	local levelCO = lua_scene_level.configDict[levelId]

	if levelCO then
		return string.format("survival/common/%s.prefab", levelCO.resName)
	else
		logError("scene level config not exist, levelId = " .. levelId)
	end
end

function ResUrl.getSceneUrl(sceneName)
	return string.format("scenes/%s/%s_p.prefab", sceneName, sceneName)
end

function ResUrl.getSpineFightPrefab(spineName)
	return ResUrl.getRolesPrefab(spineName, "fight")
end

function ResUrl.getRolesPrefab(spineName, suffix)
	local spinePath
	local isPath = string.find(spineName, "/")

	return string.format("roles/%s_%s.prefab", isPath and spineName or string.format("%s/%s", spineName, spineName), suffix)
end

function ResUrl.getRolesBustPrefab(spineName)
	local spinePath
	local isPath = string.find(spineName, "/")

	return string.format("roles_bust/%s.prefab", isPath and spineName or string.format("%s/%s", spineName, spineName))
end

function ResUrl.getSpineFightPrefabBySkin(skinCO)
	if not skinCO then
		return ""
	end

	local skinId = skinCO.id

	if lua_fight_monster_3d.configDict[skinId] then
		return skinCO.spine .. ".prefab"
	end

	local spinePath
	local isPath = string.find(skinCO.spine, "/")

	spinePath = isPath and skinCO.spine or string.format("%s/%s", skinCO.spine, skinCO.spine)

	if skinCO.fight_special == 1 then
		return string.format("roles/%s_fight_special.prefab", spinePath)
	else
		return string.format("roles/%s_fight.prefab", spinePath)
	end
end

function ResUrl.getRolesPrefabStory(spineName)
	local url = string.format("rolesstory/rolesprefab/%s/%s.prefab", SkinConfig.instance:getFolderName(spineName), spineName)

	return AvProMgr.instance:getRolesprefabUrl(url)
end

function ResUrl.getRolesCgStory(spineName, dirName)
	return string.format("rolesstory/rolescg/%s/%s.prefab", dirName or SkinConfig.instance:getFolderName(spineName), spineName)
end

function ResUrl.getLightSpine(spineName)
	local url = string.format("rolesstory/rolesprefab/%s/%s_light.prefab", SkinConfig.instance:getFolderName(spineName), spineName)

	return AvProMgr.instance:getRolesprefabUrl(url)
end

function ResUrl.getLightLive2d(name)
	return string.format("live2d/roles/%s/%s.prefab", SkinConfig.instance:getFolderName(name), name)
end

function ResUrl.getLightLive2dFolder(name)
	return string.format("live2d/roles/%s/", SkinConfig.instance:getFolderName(name))
end

function ResUrl.getRolesPrefabStoryFolder(name)
	return string.format("rolesstory/rolesprefab/%s/", SkinConfig.instance:getFolderName(name))
end

function ResUrl.getSpineRoomPrefab(spineName)
	return ResUrl.getRolesPrefab(spineName, "room")
end

function ResUrl.getSpineUIPrefab(spineName)
	return ResUrl.getRolesPrefab(spineName, "ui")
end

function ResUrl.getUdimoPrefab(spineName, suffix)
	if string.nilorempty(suffix) then
		return string.format("roles_special/roles_ytm/%s.prefab", spineName)
	else
		return string.format("roles_special/roles_ytm/%s_%s.prefab", spineName, suffix)
	end
end

function ResUrl.getUdimoSingleBg(resName)
	return string.format("singlebg/udimo_singlebg/%s.png", resName)
end

function ResUrl.getSkillTimeline(timelineName)
	return string.format("rolestimeline/%s.playable", timelineName)
end

function ResUrl.getRolesTimeline()
	return "rolestimeline"
end

function ResUrl.getPartyGameTimelineUrl(timelineName)
	return string.format("modules/party_game/scene/game100/timelines/%s.playable", timelineName)
end

function ResUrl.getPartyGameTimelineAbName(timelineName)
	return ResUrl.getPartyGameTimelineUrl(timelineName)
end

function ResUrl.getPartyTrialPlayPath(gameId)
	return string.format("modules/party_game/ui/singlebg/v3a4_party_singlebg/trialplay/partygame_trialplay_game_%s.png", gameId)
end

function ResUrl.getLoginBg(bgNameWithExt)
	return string.format("singlebg/loginbg/%s.png", bgNameWithExt)
end

function ResUrl.getLoadingBg(bgName)
	return string.format("singlebg/loading/%s.png", bgName)
end

function ResUrl.getMailBg(resName)
	return string.format("singlebg/mail/%s.png", resName)
end

function ResUrl.getCommonViewBg(resName)
	return string.format("singlebg/common/viewbg/%s.jpg", resName)
end

function ResUrl.getCommonIcon(resName)
	return string.format("singlebg/common/%s.png", resName)
end

function ResUrl.getDungeonIcon(resName)
	return string.format("singlebg/dungeon/%s.png", resName)
end

function ResUrl.getDungeonChapterBg(resName)
	return string.format("ui/viewres/dungeon/chapter/bg/%s.prefab", resName)
end

function ResUrl.getDungeonInteractiveItemBg(resName)
	return string.format("singlebg/dungeon/interactiveitem/%s.png", resName)
end

function ResUrl.getDungeonRuleIcon(resName)
	return string.format("singlebg/dungeon/level_rule/%s.png", resName)
end

function ResUrl.getDungeonFragmentIcon(resName)
	return string.format("singlebg/dungeon/fragmenticon/%s.png", resName)
end

function ResUrl.getFightQuitResultIcon(resName)
	return string.format("singlebg/fight/result/%s.png", resName)
end

function ResUrl.getFightGuideIcon(index)
	return string.format("singlebg/fight/fightguide/bg_zhiying_%s.png", index)
end

function ResUrl.getFightGuideDir()
	return "Assets/ZResourcesLib/singlebg/fight/fightguide"
end

function ResUrl.getBackpackItemIcon(resName)
	return string.format("singlebg/backpackitem/%s.png", resName)
end

function ResUrl.getSummonHeroIcon(resName)
	return string.format("singlebg/summon/hero/%s.png", resName)
end

function ResUrl.getSummonEquipIcon(resName)
	return string.format("singlebg/summon/equip/%s.png", resName)
end

function ResUrl.getSummonEquipGetIcon(resName)
	return string.format("singlebg/summon/equipget/%s.png", resName)
end

function ResUrl.getSummonBannerFullPath(resName)
	return string.format("Assets/ZResourcesLib/singlebg_lang/txt_summon/banner/%s.png", resName)
end

function ResUrl.getAdventureTaskLangPath(resName)
	return string.format("Assets/ZResourcesLib/singlebg_lang/txt_adventuretask/%s.png", resName)
end

function ResUrl.getSummonCoverBg(resName)
	return string.format("singlebg/summon/%s.png", resName)
end

function ResUrl.getSummonHeroMask(resName)
	return string.format("singlebg/summon/mask/%s.png", resName)
end

function ResUrl.getSummonSceneTexture(iconPath)
	return string.format("scenes/dynamic/m_s06_summon/%s.png", iconPath)
end

function ResUrl.getSignature(resName, viewName)
	if viewName then
		return string.format("singlebg/signature/%s/%s.png", viewName, resName)
	else
		return string.format("singlebg/signature/%s.png", resName)
	end
end

function ResUrl.getSceneUIPrefab(scene, resName)
	return string.format("ui/sceneui/%s/%s.prefab", scene, resName)
end

function ResUrl.getCharacterIcon(resName)
	return string.format("singlebg/character/%s.png", resName)
end

function ResUrl.getCharacterItemIcon(resName)
	return string.format("singlebg/characteritem/%s.png", resName)
end

function ResUrl.getCharacterDataIcon(resName)
	return string.format("singlebg/characterdata/%s", resName)
end

function ResUrl.getCharacterExskill(resName)
	return string.format("singlebg/characterexskill/%s.png", resName)
end

function ResUrl.getCharacterGetIcon(resName)
	return string.format("singlebg/characterget/%s.png", resName)
end

function ResUrl.getCharacterSkinIcon(resName)
	return string.format("singlebg/characterskin/%s.png", resName)
end

function ResUrl.getCharacterSkinLive2dBg(resName)
	return string.format("singlebg/characterskin/live2dbg/%s.png", resName)
end

function ResUrl.getCharacterSkinStoryBg(suitId)
	return string.format("singlebg/skinhandbook_singlebg/skinhandbook_leftbg_%d.png", suitId)
end

function ResUrl.getCharacterSkinSwitchBg(suitId)
	return string.format("singlebg/characterskin/img_yulan_bg_%d.png", suitId)
end

function ResUrl.getHeadSkinIconMiddle(resName)
	return string.format("singlebg/headskinicon_middle/%s.png", resName)
end

function ResUrl.getHeadSkinIconUnique(resName)
	return string.format("singlebg/headskinicon_unique/%s.png", resName)
end

function ResUrl.getHeadSkinIconLarge(resName)
	return string.format("singlebg/headskinicon_large/%s.jpg", resName)
end

function ResUrl.getSkillEffect(effectName)
	return string.format("singlebg/characteritem/skilleffect/effect_%s.png", effectName)
end

function ResUrl.getCharacterRareBg(rare)
	return string.format("singlebg/characteritem/jskp_0%d.png", rare)
end

function ResUrl.getCharacterRareBgNew(rare)
	return string.format("singlebg/characteritem/jskp_0%d.png", rare)
end

function ResUrl.getTipsBg(rare)
	return string.format("singlebg/tips/%s.png", rare)
end

function ResUrl.getTipsCharacterRareBg(rare)
	return string.format("singlebg/tips/jskp_0%d.png", rare)
end

function ResUrl.getTipsCharacterColorBg(color)
	return string.format("singlebg/tips/pfkp_00%d.png", color)
end

function ResUrl.getPropItemIcon(resName)
	return string.format("singlebg/propitem/prop/%s.png", resName)
end

function ResUrl.getPropItemIconSmall(resName)
	return string.format("singlebg/propitem/prop_small/%s.png", resName)
end

function ResUrl.getAntiqueIcon(resName)
	return string.format("singlebg/antique_singlebg/%s.png", resName)
end

function ResUrl.getSpecialPropItemIcon(resName)
	return string.format("singlebg/propitem/special/%s.png", resName)
end

function ResUrl.getCurrencyItemIcon(resName)
	return string.format("singlebg/currencyitem/%s.png", resName)
end

function ResUrl.getCritterItemIcon(resName)
	return string.format("singlebg/propitem/critter/%s.png", resName)
end

function ResUrl.getEffect(effectName)
	return string.format("effects/prefabs/%s.prefab", effectName)
end

function ResUrl.getPartyGameEffectPath(effectName)
	return string.format("modules/party_game/scene/effects/%s.prefab", effectName)
end

function ResUrl.getEffectName(effectPath)
	if string.nilorempty(effectPath) then
		return
	end

	local effectName = string.gsub(effectPath, "effects/prefabs/", "", 1)

	effectName = string.gsub(effectName, ".prefab", "", 1)

	return effectName
end

function ResUrl.getStoryPrefabRes(resName)
	return string.format("ui/viewres/story/%s.prefab", resName)
end

function ResUrl.getStoryPrefabViewRes(resName)
	return string.format("ui/viewres/story/view/%s.prefab", resName)
end

function ResUrl.getStoryPrefabOptionRes(resName)
	return string.format("ui/viewres/story/option/%s.prefab", resName)
end

function ResUrl.getStoryBgEffect(effectName)
	return string.format("ui/viewres/story/bg/%s.prefab", effectName)
end

function ResUrl.getStoryBgMaterial(matName)
	return string.format("ui/materials/storybg/%s.mat", matName)
end

function ResUrl.getUIEffect(effectName)
	return string.format("ui/viewres/effect/%s.prefab", effectName)
end

function ResUrl.getSceneEffect(effectName)
	return string.format("effects/prefabs/buff/%s.prefab", effectName)
end

function ResUrl.getFightLoadingIcon(icon)
	return string.format("singlebg/fight/loading/%s.png", tostring(icon))
end

local isEditor = SLFramework.FrameworkSettings.IsEditor

function ResUrl.getSkillIcon(icon)
	if isEditor then
		if not icon then
			logError("icon is nil")
		end

		if tostring(icon) == "0" then
			logError("icon is 0")
		end
	end

	return string.format("singlebg/fight/skill/%s.png", tostring(icon))
end

function ResUrl.getPassiveSkillIcon(icon)
	return string.format("singlebg/fight/passive/%s.png", tostring(icon))
end

function ResUrl.getClothSkillIcon(icon)
	return string.format("singlebg/fight/cloth/%s.png", tostring(icon))
end

function ResUrl.getAttributeIcon(icon)
	return string.format("singlebg/fight/attribute/%s.png", tostring(icon))
end

function ResUrl.getFightCardDescIcon(icon)
	return string.format("singlebg/fight/carddesc/%s.png", tostring(icon))
end

function ResUrl.getFightResultcIcon(icon)
	return string.format("singlebg/fight/result/%s.png", tostring(icon))
end

function ResUrl.getFightSkillTargetcIcon(icon)
	return string.format("singlebg/fight/skilltarget/%s.png", tostring(icon))
end

function ResUrl.getStoryRes(resName)
	return string.format("singlebg/storybg/%s", tostring(resName))
end

function ResUrl.getStoryBg(resName)
	return string.format("singlebg/storybg/%s", tostring(resName))
end

function ResUrl.getStoryPrologueSkip(resName)
	return string.format("singlebg/storybg/prologueskip/%s.png", tostring(resName))
end

function ResUrl.getStorySmallBg(resName)
	return string.format("singlebg/storybg/smallbg/%s", tostring(resName))
end

function ResUrl.getStoryEpisodeIcon(resName)
	return string.format("ui/viewres/storynavigate/%s", tostring(resName))
end

function ResUrl.getStoryItem(resName)
	return string.format("singlebg/storybg/item/%s", tostring(resName))
end

function ResUrl.getStoryLangPath(resName)
	return string.format("singlebg_lang/txt_story/%s.png", tostring(resName))
end

function ResUrl.getCameraAnim(resName)
	return string.format("effects/cameraanim/%s.controller", resName)
end

function ResUrl.getCameraAnimABUrl()
	return "effects/cameraanim"
end

function ResUrl.getEntityAnim(resName)
	return string.format("effects/entityanim/%s.anim", resName)
end

function ResUrl.getEntityAnimABUrl()
	return "effects/entityanim"
end

function ResUrl.getHeadIconSmall(resName)
	return string.format("singlebg/headicon_small/%s.png", resName)
end

function ResUrl.getEquipIconSmall(resName)
	return string.format("scenes/dynamic/m_s03_xx/equipicon_small/%s.png", resName)
end

function ResUrl.getHeadIconNew(resName)
	return string.format("singlebg/propitem/hero/%s.png", resName)
end

function ResUrl.getHeroSkinPropIcon(resName)
	return string.format("singlebg/propitem/heroskin/%s.png", resName)
end

function ResUrl.getHeadIconMiddle(resName)
	return string.format("singlebg/headicon_middle/%s.png", resName)
end

function ResUrl.getHeadIconLarge(resName)
	return string.format("singlebg/headicon_large/%s.png", resName)
end

function ResUrl.getHeadIconImg(resName)
	return string.format("singlebg/headicon_img/%s.png", resName)
end

function ResUrl.getHeadSkinSmall(resName)
	return string.format("singlebg/headskinicon_small/%s.png", resName)
end

function ResUrl.getCharacterDataPic(resName)
	return string.format("singlebg/data_pic/%s.png", resName)
end

function ResUrl.getHeroGroupBg(resName)
	return string.format("singlebg/herogroup/%s.png", resName)
end

function ResUrl.getHeroDefaultEquipIcon(resName)
	return string.format("singlebg/equip_defaulticon/%s.png", resName)
end

function ResUrl.getTaskBg(resName)
	return string.format("singlebg/task/%s.png", resName)
end

function ResUrl.getEquipRareIcon(resName)
	return string.format("singlebg/equipment/rare/%s.png", resName)
end

function ResUrl.getEquipIcon(resName)
	return string.format("singlebg/equipment/icon/%s.png", resName)
end

function ResUrl.getEquipSuit(resName)
	return string.format("singlebg/equipment/suit/%s.png", resName)
end

function ResUrl.getEquipRes(resName)
	return string.format("singlebg/equipment/%s.png", resName)
end

function ResUrl.getHelpItem(resName, isCn)
	if isCn then
		return string.format("singlebg_lang/txt_help/%s.png", resName)
	else
		return string.format("singlebg/help/%s.png", resName)
	end
end

function ResUrl.getVersionActivityHelpItem(resName, isCn)
	if isCn then
		return string.format("singlebg_lang/txt_versionactivityhelp/%s.png", resName)
	else
		return string.format("singlebg/versionactivityhelp/%s.png", resName)
	end
end

function ResUrl.getBannerIcon(resName)
	return string.format("singlebg/banner/%s.png", resName)
end

function ResUrl.getRoleSpineMat(matName)
	return string.format("rolesbuff/%s.mat", matName)
end

function ResUrl.getRoleSpineMatTex(texName)
	return string.format("rolesbuff/%s.png", texName)
end

function ResUrl.getSettingsBg(resName)
	return string.format("singlebg/settings/%s", resName)
end

function ResUrl.getAdventureBg(resName)
	return string.format("singlebg/adventure/%s.png", resName)
end

function ResUrl.getExploreBg(resName)
	return string.format("modules/explore/singlebg/%s.png", resName)
end

function ResUrl.getAdventureIcon(resName)
	return string.format("singlebg/adventure/iconnew/%s.png", resName)
end

function ResUrl.getAdventureEntrance(resName)
	return string.format("singlebg/adventure/entrance/%s.png", resName)
end

function ResUrl.getAdventureTarotIcon(resName)
	return string.format("singlebg/adventure/tarot/%s.png", resName)
end

function ResUrl.getAdventureTarotSmallIcon(resName)
	return string.format("singlebg/adventure/tarotsmall/%s.png", resName)
end

function ResUrl.getAdventureMagicIcon(id, resName)
	return string.format("singlebg/adventure/magic/%s/%s.png", id, resName)
end

function ResUrl.getAdventureTarotQuality(id)
	return string.format("singlebg/adventure/tarot_quality/tarot_quality_%s.png", id)
end

function ResUrl.getAdventureTask(resName)
	return string.format("singlebg/adventure/task/%s.png", resName)
end

function ResUrl.getPlayerClothIcon(resName)
	return string.format("singlebg/player/cloth/%s.png", resName)
end

function ResUrl.getPlayerBg(resName)
	return string.format("singlebg/player/%s.png", resName)
end

function ResUrl.getPlayerCardIcon(resName)
	return string.format("singlebg/playercard/%s.png", resName)
end

function ResUrl.getStoreBottomBgIcon(resName)
	return string.format("singlebg/store/%s.png", resName)
end

function ResUrl.getStoreGiftPackBg(resName)
	return string.format("singlebg/store/giftpacksview/%s.png", resName)
end

function ResUrl.getStorePackageIcon(resName)
	if string.nilorempty(resName) then
		return ResUrl.getCurrencyItemIcon(201)
	else
		return string.format("singlebg/store/package/%s.png", resName)
	end
end

function ResUrl.getStoreTagIcon(resName)
	return string.format("singlebg/store/tag_%s.png", resName)
end

function ResUrl.getStoreRecommend(resName)
	return string.format("singlebg/store/recommend/%s.png", resName)
end

function ResUrl.getStoreWildness(resName)
	return string.format("singlebg/store/wildness/%s.png", resName)
end

function ResUrl.getStoreSkin(resName)
	return string.format("singlebg/store/skin/%s.png", resName)
end

function ResUrl.getNoticeBg(resName)
	return string.format("singlebg/notice/%s.png", resName)
end

function ResUrl.getNoticeContentIcon(typeid, id)
	return string.format("singlebg/notice/hd_%d_%d.png", typeid, id)
end

function ResUrl.getSignInBg(resName)
	return string.format("singlebg/signin/%s.png", resName)
end

function ResUrl.getActivityBg(resName)
	return string.format("singlebg/activity/%s.png", resName)
end

function ResUrl.getActivityMapBg(resName)
	return string.format("singlebg/activity/%s", resName)
end

function ResUrl.getPowerBuyBg(resName)
	return string.format("singlebg/powerbuy/%s.png", resName)
end

function ResUrl.getEquipBg(resName)
	return string.format("singlebg/equip/%s", resName)
end

function ResUrl.getMessageIcon(resName)
	return string.format("singlebg/message/%s.png", resName)
end

function ResUrl.getSocialIcon(resName)
	return string.format("singlebg/social/%s", resName)
end

function ResUrl.getFightIcon(resName)
	return string.format("singlebg/fight/icon/%s", resName)
end

function ResUrl.getFightImage(resName)
	return string.format("singlebg/fight/%s", resName)
end

function ResUrl.getFightSpecialTipIcon(resName)
	return string.format("singlebg/fight/specialtip/%s", resName)
end

function ResUrl.getNickNameIcon(resName)
	return string.format("singlebg/nickname/%s.png", resName)
end

function ResUrl.getRoomRes(resName)
	return string.format("scenes/m_s07_xiaowu/prefab/%s.prefab", resName)
end

function ResUrl.getRoomResAB(resName)
	return string.format("scenes/m_s07_xiaowu/prefab/%s", resName)
end

function ResUrl.getRoomGetIcon(resName)
	return string.format("singlebg/roomget/%s.png", resName)
end

function ResUrl.getRoomBlockPackageRewardIcon(resName)
	return string.format("singlebg/roomget/blockpackage/%s.jpg", resName)
end

function ResUrl.getRoomBuildingRewardIcon(resName)
	return string.format("singlebg/roomget/building/%s.jpg", resName)
end

function ResUrl.getRoomThemeRewardIcon(resName)
	return string.format("singlebg/roomget/theme/%s.jpg", resName)
end

function ResUrl.getSpineBxhyPrefab(spineName)
	return ResUrl.getRolesPrefab(spineName, "room")
end

function ResUrl.getSpineUIBxhyPrefab(spineName)
	return ResUrl.getRolesPrefab(spineName, "ui")
end

function ResUrl.getSpineBxhyMaterial(spineName)
	local spinePath
	local isPath = string.find(spineName, "/")

	return string.format("roles/%s_bxhy_material.mat", isPath and spineName or string.format("%s/%s", spineName, spineName))
end

function ResUrl.getSceneRes(resName)
	return string.format("scenes/%s/%s_p.prefab", resName, resName)
end

function ResUrl.getDungeonMapRes(resName)
	return string.format("scenes/%s.prefab", resName)
end

function ResUrl.getRoomImage(resName)
	return string.format("singlebg/room/%s.png", resName)
end

function ResUrl.getMainImage(resName)
	return string.format("singlebg/main/%s.png", resName)
end

function ResUrl.getMainActivityIcon(resName)
	return string.format("singlebg_lang/txt_main/%s.png", resName)
end

function ResUrl.getHandbookBg(resName)
	return string.format("singlebg/handbook/%s.png", resName)
end

function ResUrl.getHandbookCharacterIcon(resName)
	return string.format("singlebg/handbook/character/%s.png", resName)
end

function ResUrl.getHandbookheroIcon(resName)
	return string.format("singlebg/handbookheroicon/%s.png", resName)
end

function ResUrl.getHandbookEquipImage(resName)
	return string.format("singlebg/handbook/equip/%s.png", resName)
end

function ResUrl.getSkinHandbookFestivalSkinImage(resName)
	return string.format("singlebg/skinhandbook_singlebg/festival/%s.png", resName)
end

function ResUrl.getCharacterTalentUpIcon(resName)
	return string.format("singlebg/charactertalentup/%s.png", resName)
end

function ResUrl.getWeekWalkBg(resName)
	return string.format("singlebg/weekwalk/%s", resName)
end

function ResUrl.getVideo(resName)
	return string.format("videos/%s.mp4", resName)
end

function ResUrl.getCharacterTalentUpTexture(resName)
	return string.format("singlebg/textures/charactertalentup/%s.png", resName)
end

function ResUrl.getWeatherEffect(resName)
	return string.format("effects/prefabs/roleeffects/%s.prefab", resName)
end

function ResUrl.getArcadeGameEffect(resName)
	return string.format("effects/prefabs/v3a3_bfjwl/%s.prefab", resName)
end

function ResUrl.getPlayerViewTexture(resName)
	return string.format("singlebg/textures/playerview/%s.png", resName)
end

function ResUrl.getCommonitemEffect(resName)
	return string.format("ui/viewres/common/effect/%s.prefab", resName)
end

function ResUrl.getDungeonPuzzleBg(resName)
	return string.format("singlebg/dungeon/puzzle/%s.png", resName)
end

function ResUrl.getUIMaskTexture(resName)
	return string.format("singlebg/textures/uimask/%s.png", resName)
end

function ResUrl.getRoomTexture(resName)
	return string.format("singlebg/textures/room/%s", resName)
end

function ResUrl.getActivityTexture(resName)
	return string.format("singlebg/textures/activity/%s", resName)
end

function ResUrl.getTeachNoteImage(resName)
	return string.format("singlebg/teachnote/%s", resName)
end

function ResUrl.getWeekWalkTarotIcon(resName)
	return string.format("singlebg/weekwalk/tarot/%s.png", resName)
end

function ResUrl.getFightTechniqueGuide(resName, isActivityVersion)
	if isActivityVersion then
		return string.format("singlebg/versionactivitytechniqueguide/%s.png", resName)
	else
		return string.format("singlebg/fight/techniqueguide/%s.png", resName)
	end
end

function ResUrl.getFightEquipFloatIcon(resName)
	return string.format("singlebg/fight/equipeffect/%s.png", resName)
end

function ResUrl.getFightGuideLangIcon(index)
	return string.format("singlebg_lang/txt_fightguide/bg_zhiying_%s.png", index)
end

function ResUrl.getFightGuideLangDir()
	return "Assets/ZResourcesLib/singlebg_lang/txt_fightguide"
end

function ResUrl.getLoginBgLangIcon(resName)
	return string.format("singlebg_lang/txt_loginbg/%s.png", resName)
end

function ResUrl.getTechniqueLangIcon(resName, isCn)
	if isCn then
		return string.format("singlebg_lang/txt_fighttechniquetips/%s.png", resName)
	else
		return string.format("singlebg/fighttechniquetips/%s.png", resName)
	end
end

function ResUrl.getTechniqueBg(resName)
	return string.format("singlebg/fight/techniquetips/%s.png", resName)
end

function ResUrl.getHandbookCharacterImage(resName)
	return string.format("Assets/ZResourcesLib/singlebg_lang/txt_handbook/%s.png", resName)
end

function ResUrl.getFightBattleDialogBg(resName)
	return string.format("singlebg/fight/battledialog/%s.png", resName)
end

function ResUrl.getBpBg(resName)
	return string.format("singlebg/battlepass/%s.png", resName)
end

function ResUrl.getAct114Image(resName)
	return string.format("singlebg_lang/txt_versionactivity114_1_2/%s.png", resName)
end

function ResUrl.getDreamTailImage(resName)
	return string.format("singlebg/versionactivitydreamtail_1_2/%s.png", resName)
end

function ResUrl.getAct114MeetIcon(resName)
	return string.format("singlebg/versionactivity114_1_2/meet/%s.png", resName)
end

function ResUrl.getAct114Icon(resName)
	return string.format("singlebg/versionactivity114_1_2/%s.png", resName)
end

function ResUrl.getYaXianImage(resName)
	return string.format("singlebg/versionactivitytooth_1_2/%s.png", resName)
end

function ResUrl.getFightDiceBg(resName)
	return string.format("singlebg/fight/fightdice/%s.png", resName)
end

function ResUrl.getWeekWalkLayerIcon(resName)
	return string.format("singlebg/weekwalk/layer/%s.png", resName)
end

function ResUrl.getRoomCharacterPlaceIcon(resName)
	return string.format("singlebg/room/characterplace/%s.png", resName)
end

function ResUrl.getRoomHeadIcon(resName)
	return string.format("singlebg/room/headicon/%s.png", resName)
end

function ResUrl.getRoomBlockPackagePropIcon(resName)
	return string.format("singlebg/propitem/blockpackage/%s.png", resName)
end

function ResUrl.getRoomBlockPropIcon(resName)
	return string.format("singlebg/propitem/block/%s.png", resName)
end

function ResUrl.getRoomBuildingPropIcon(resName)
	return string.format("singlebg/propitem/building/%s.png", resName)
end

function ResUrl.getRoomThemePropIcon(resName)
	return string.format("singlebg/propitem/roomtheme/%s.png", resName)
end

function ResUrl.getRoomTaskBonusIcon(resName)
	return string.format("singlebg/room/taskbonus/%s.png", resName)
end

function ResUrl.getRoomFunctionIcon(resName)
	return string.format("singlebg/room/function/%s.png", resName)
end

function ResUrl.getRoomProductline(resName)
	return string.format("singlebg/room/productline/%s.png", resName)
end

function ResUrl.getSeasonIcon(resName)
	return string.format("singlebg/season/%s", resName)
end

function ResUrl.getV1A2SeasonIcon(resName)
	return string.format("singlebg/v1a2_season/%s", resName)
end

function ResUrl.getV1A3SeasonIcon(resName)
	return string.format("singlebg/v1a3_season/%s", resName)
end

function ResUrl.getV1A3DungeonIcon(resName)
	return string.format("singlebg/v1a3_dungeon_singlebg/%s.png", resName)
end

function ResUrl.getToastIcon(resName)
	return string.format("singlebg/toast/%s.png", resName)
end

function ResUrl.getSdkIcon(resName)
	return string.format("singlebg/sdk/%s.png", resName)
end

function ResUrl.getPlayerHeadIcon(resName)
	return string.format("singlebg/playerheadicon/%s.png", resName)
end

function ResUrl.getVersionActivityIcon(resName)
	return string.format("singlebg/versionactivity/%s.png", resName)
end

function ResUrl.getVersionActivityEnter1_2Icon(resName)
	return string.format("singlebg/versionactivityenter_1_2/%s.png", resName)
end

function ResUrl.getVersionActivityEnter1_2LangIcon(resName)
	return string.format("singlebg_lang/txt_versionactivityenter_1_2/%s.png", resName)
end

function ResUrl.getMeilanniIcon(resName)
	return string.format("singlebg/versionactivitymeilanni/%s.png", resName)
end

function ResUrl.getMeilanniLangIcon(resName)
	return string.format("singlebg_lang/txt_versionactivitymeilanni/%s.png", resName)
end

function ResUrl.getActivityWarmUpBg(resName)
	return string.format("singlebg/activitywarmup/%s.png", resName)
end

function ResUrl.getPushBoxPre(resName)
	return string.format("scenes/m_s11_txz/prefab/%s.prefab", resName)
end

function ResUrl.getArcadeSceneRes(resName)
	return string.format("scenes/v3a3_m_s12_bf/prefab/%s.prefab", resName)
end

function ResUrl.getPushBoxResultIcon(resName)
	return string.format("singlebg_lang/txt_versionactivitypushbox/%s.png", resName)
end

function ResUrl.getVersionactivitychessIcon(resName)
	return string.format("singlebg/versionactivitychess/%s.png", resName)
end

function ResUrl.gettxt_versionactivitychessIcon(resName)
	return string.format("singlebg_lang/txt_versionactivitychess/%s.png", resName)
end

function ResUrl.getVersionActivityExchangeIcon(resName)
	return string.format("singlebg/versionactivityexchange/%s.png", resName)
end

function ResUrl.getVersionActivityDungeonIcon(resName)
	return string.format("singlebg/versionactivitydungeon/%s.png", resName)
end

function ResUrl.getBattlePassBg(resName)
	return string.format("singlebg/battlepass/%s.png", resName)
end

function ResUrl.getVersionActivityWhiteHouse_1_2_Bg(resName)
	return string.format("singlebg/versionactivitywhitehouse_1_2/%s", resName)
end

function ResUrl.getVersionTradeBargainBg(resName)
	return string.format("singlebg/versionactivitytrade_1_2/%s.png", resName)
end

function ResUrl.getVersionActivity1_2TaskImage(resName)
	return string.format("singlebg/versionactivitytask_1_2/%s.png", resName)
end

function ResUrl.getRoomIconLangPath(resName)
	return string.format("singlebg_lang/txt_room/%s.png", resName)
end

function ResUrl.getWeekWalkIconLangPath(resName)
	return string.format("singlebg_lang/txt_weekwalk/%s.png", resName)
end

function ResUrl.getExploreEffectPath(resName)
	return string.format("modules/explore/effects/scenes/mishi_prefabs/%s.prefab", resName)
end

function ResUrl.getSeasonCelebrityCard(resName)
	return string.format("singlebg/seasoncelebritycard/%s.png", resName)
end

function ResUrl.getSeasonMarketIcon(resName)
	return string.format("singlebg/season/market/%s.png", resName)
end

function ResUrl.getActivityChapterLangPath(resName)
	return string.format("singlebg_lang/txt_versionactivityopen/%s.png", resName)
end

function ResUrl.getVersionActivityOpenPath(resName)
	return string.format("singlebg/versionactivityopen/%s.png", resName)
end

function ResUrl.getVersionActivityStoryCollect_1_2(resName)
	return string.format("singlebg/versionactivitystorycollect_1_2/%s.png", resName)
end

function ResUrl.getActivityWarmUpLangIcon(resName)
	return string.format("singlebg_lang/txt_activitywarmup/%s.png", resName)
end

function ResUrl.getVersionActivityDungeon_1_2(resName)
	return string.format("singlebg/versionactivitydungeon_1_2/%s.png", resName)
end

function ResUrl.getRadioIcon_1_3(resName)
	return string.format("singlebg/v1a3_radio_singlebg/%s.png", resName)
end

function ResUrl.getVersionActivityTrip_1_2(resName)
	return string.format("singlebg/versionactivitytrip_1_2/%s.png", resName)
end

function ResUrl.getActivityLangIcon(resName)
	return string.format("singlebg_lang/txt_activity/%s.png", resName)
end

function ResUrl.getActivityFullBg(resName)
	return string.format("singlebg/activity/full/%s.png", resName)
end

function ResUrl.getActivitiy119Icon(resName)
	return string.format("singlebg/v1a3_bookview_singlebg/%s.png", resName)
end

function ResUrl.getActivity1_3BuffIcon(resName)
	return string.format("singlebg/v1a3_buffview_singlebg/%s.png", resName)
end

function ResUrl.getJiaLaBoNaIcon(resName)
	return string.format("singlebg/v1a3_role1_singlebg/%s.png", resName)
end

function ResUrl.getJiaLaBoNaRoleModsIcon(resName)
	return string.format("singlebg/v1a3_role1_mods_singlebg/%s.png", resName)
end

function ResUrl.getFairyLandIcon(resName)
	return string.format("singlebg/v1a3_fairyland_singlebg/%s.png", resName)
end

function ResUrl.get1_3ChessMapIcon(resName)
	return string.format("singlebg/v1a3_role2_singlebg/%s.png", resName)
end

function ResUrl.getActivity1_3EnterIcon(resName)
	return string.format("singlebg/v1a3_enterview_singlebg/%s.png", resName)
end

function ResUrl.getV1a3TaskViewSinglebg(resName)
	return string.format("singlebg/v1a3_taskview_singlebg/%s.png", resName)
end

function ResUrl.getV1a3ArmSinglebg(resName)
	return string.format("singlebg/v1a3_arm_singlebg/%s.png", resName)
end

function ResUrl.getV1a3AstrologySinglebg(resName)
	return string.format("singlebg/v1a3_astrology_singlebg/%s.png", resName)
end

function ResUrl.getActivity133Icon(resName)
	return string.format("singlebg/v1a4_shiprepair/%s.png", resName)
end

function ResUrl.getRoleStoryIcon(resName)
	return string.format("singlebg/dungeon/rolestory_singlebg/%s.png", resName)
end

function ResUrl.getRoleStoryPhotoIcon(resName)
	return string.format("singlebg/dungeon/rolestory_photo_singlebg/%s.png", resName)
end

function ResUrl.getTurnbackIcon(resName)
	return string.format("singlebg/turnback/%s.png", resName)
end

function ResUrl.getV1a4BossRushSinglebg(resName)
	return string.format("singlebg/v1a4_bossrush_singlebg/%s.png", resName)
end

function ResUrl.getV1a4BossRushIcon(resName)
	return string.format("singlebg/v1a4_bossrush_bossicon_singlebg/%s.png", resName)
end

function ResUrl.getV1a4BossRushLangPath(resName)
	return string.format("singlebg_lang/txt_v1a4_bossrush_singlebg/%s.png", resName)
end

function ResUrl.getBossRushDetailPath(resName)
	return string.format("singlebg/bossrush/bossdetail/%s.png", resName)
end

function ResUrl.getBossRushBossPath(resName)
	return string.format("singlebg/bossrush/boss/%s.png", resName)
end

function ResUrl.getBossRushBossBGPath(resName)
	return string.format("singlebg/bossrush/bossbg/%s.png", resName)
end

function ResUrl.getBossRushHandbookSinglebg(resName)
	return string.format("singlebg/bossrush/bosshandbook/%s.png", resName)
end

function ResUrl.getBossRushRankSinglebg(resName)
	return string.format("singlebg/bossrush/rank/%s.png", resName)
end

function ResUrl.getV1a4BossRushAssessIcon(resName)
	return string.format("singlebg/bossrush_assess_singlebg/%s.png", resName)
end

function ResUrl.getBossRushSinglebg(resName)
	return string.format("singlebg/bossrush/%s.png", resName)
end

function ResUrl.getV1a4Role37SingleBg(resName)
	return string.format("singlebg/v1a4_role37_singlebg/%s.png", resName)
end

function ResUrl.getV1a4Role6SingleBg(resName)
	return string.format("singlebg/v1a4_role37_singlebg/%s.png", resName)
end

function ResUrl.getV1a4DustRecordsIcon(resName)
	return string.format("singlebg/v1a4_dustyrecordsview/%s.png", resName)
end

function ResUrl.getV1Aa4DailyAllowanceIcon(resName)
	return string.format("singlebg/v1a4_gold_singlebg/%s.png", resName)
end

function ResUrl.getV1a5DungeonSingleBg(resName)
	return string.format("singlebg/v1a5_dungeon_singlebg/%s.png", resName)
end

function ResUrl.getV1a5EnterSingleBg(resName)
	return string.format("singlebg/v1a5_enterview_singlebg/%s.png", resName)
end

function ResUrl.getV1a5RevivalTaskSingleBg(resName)
	return string.format("singlebg/v1a5_revival_singlebg/%s.png", resName)
end

function ResUrl.getV1a5BuildSingleBg(resName)
	return string.format("singlebg/v1a5_building_singlebg/%s.png", resName)
end

function ResUrl.getDialogueSingleBg(resName)
	return string.format("singlebg/dialogue/%s.png", resName)
end

function ResUrl.getSummonFreeButton()
	return "ui/viewres/summon/summonfreebutton.prefab"
end

function ResUrl.getAchievementIcon(resName)
	return string.format("singlebg/achievement/%s.png", resName)
end

function ResUrl.getAchievementLangIcon(resName)
	return string.format("singlebg_lang/txt_achievement/%s.png", resName)
end

function ResUrl.getV1a4SignSingleBg(resName)
	return string.format("singlebg/v1a4_sign_singlebg/%s.png", resName)
end

function ResUrl.getV1a4SignSingleBgLang(resName)
	return string.format("singlebg_lang/txt_v1a4_sign_singlebg/%s.png", resName)
end

function ResUrl.getSummonBanner(resName)
	return string.format("singlebg/summon/banner/%s.png", resName)
end

function ResUrl.getSummonBannerLine(resName)
	return string.format("singlebg/summon/banner/bannerline/%s.png", resName)
end

function ResUrl.getV1a5News(resName)
	return string.format("singlebg/v1a5_news_singlebg/%s.png", resName)
end

function ResUrl.getV1a5SignSingleBg(resName)
	return string.format("singlebg/v1a5_sign_singlebg/%s.png", resName)
end

function ResUrl.getV1a5SignSingleBgLang(resName)
	return string.format("singlebg_lang/txt_v1a5_sign_singlebg/%s.png", resName)
end

function ResUrl.getV1a5AiZiLaItemIcon(resName)
	return string.format("singlebg/v1a5_aizila_icon/%s.png", resName)
end

function ResUrl.getV1a6DungeonSingleBg(resName)
	return string.format("singlebg/v1a6_dungeon_singlebg/%s.png", resName)
end

function ResUrl.getV1a6CachotIcon(resName)
	return string.format("singlebg/v1a6_cachot_singlebg/%s.png", resName)
end

function ResUrl.getV1a6SignSingleBg(resName)
	return string.format("singlebg/v1a6_sign_singlebg/%s.png", resName)
end

function ResUrl.getV1a6SignSingleBgLang(resName)
	return string.format("singlebg_lang/txt_v1a6_sign_singlebg/%s.png", resName)
end

function ResUrl.getV1a7SignSingleBg(resName)
	return string.format("singlebg/v1a7_signinview/%s.png", resName)
end

function ResUrl.getV1a7SignSingleBgLang(resName)
	return string.format("singlebg_lang/txt_v1a7_sign_singlebg/%s.png", resName)
end

function ResUrl.getSeason123Scene(folder, resName)
	return string.format("scenes/%s/scene_prefab/%s.prefab", folder, resName)
end

function ResUrl.getSeason123LayerDetailBg(folder, pic)
	return string.format("singlebg/%s/level/%s.png", folder, pic)
end

function ResUrl.getV1a8SignSingleBg(resName)
	return string.format("singlebg/v1a8_signinview/%s.png", resName)
end

function ResUrl.getV1a8DungeonSingleBg(resName)
	return string.format("singlebg/v1a8_dungeon_singlebg/%s.png", resName)
end

function ResUrl.getV1a8SignSingleBgLang(resName)
	return string.format("singlebg_lang/txt_v1a8_sign_singlebg/%s.png", resName)
end

function ResUrl.getSeason123RetailPrefab(folder, resName)
	return string.format("scenes/%s/prefab/%s.prefab", folder, resName)
end

function ResUrl.getSeason123ResetStageIcon(folder, stage)
	return string.format("singlebg/%s/reset/area/pic_%s.png", folder, stage)
end

function ResUrl.getSeason123EpisodeIcon(folder, pic)
	return string.format("singlebg/%s/loading/%s.png", folder, pic)
end

function ResUrl.getSeason123Icon(folder, resName)
	return string.format("singlebg/%s/%s.png", folder, resName)
end

function ResUrl.getTurnbackRecommendLangPath(resName)
	return string.format("Assets/ZResourcesLib/singlebg_lang/txt_turnbackrecommend/%s.png", resName)
end

function ResUrl.getV1a9SignSingleBg(resName)
	return string.format("singlebg/v1a9_sign_singlebg/%s.png", resName)
end

function ResUrl.getV1a9LogoSingleBg(resName)
	return string.format("singlebg/v1a9_logo_singlebg/%s.png", resName)
end

function ResUrl.getV1a9WarmUpSingleBg(resName)
	return string.format("singlebg/v1a9_warmup_singlebg/v1a9_warmup_day%s.png", resName)
end

function ResUrl.getPermanentSingleBg(resName)
	return string.format("singlebg/dungeon/reappear/%s.png", resName)
end

function ResUrl.getMainSceneSwitchIcon(resName)
	return string.format("singlebg/mainsceneswitch_singlebg/%s.png", resName)
end

function ResUrl.getMainSceneSwitchLangIcon(resName)
	return string.format("singlebg_lang/txt_mainsceneswitch_singlebg/%s.png", resName)
end

function ResUrl.getSceneUIPackageIcon(resName)
	return string.format("singlebg/sceneuipackage_singlebg/%s.png", resName)
end

function ResUrl.getRougeIcon(resName)
	return string.format("singlebg/rouge/%s.png", resName)
end

function ResUrl.getRouge2Icon(resName)
	return string.format("singlebg/rouge2/%s.png", resName)
end

function ResUrl.getRougeBattleRoleIcon(resName)
	return string.format("singlebg/toughbattle_singlebg/role/%s.png", resName)
end

function ResUrl.getRougeSingleBgCollection(resName)
	return string.format("singlebg/rouge/collection/%s.png", resName)
end

function ResUrl.getRougeSingleBgDLC(resName)
	return string.format("singlebg/rouge/dlc/%s.png", resName)
end

function ResUrl.getRougeDLCLangImage(resName)
	return string.format("singlebg_lang/txt_rouge/dlc/%s.png", resName)
end

function ResUrl.getGraffitiIcon(resName)
	return string.format("singlebg/v2a0_graffiti_singlebg/%s.png", resName)
end

function ResUrl.getV2a0SignSingleBg(resName)
	return string.format("singlebg/v2a0_sign_singlebg/%s.png", resName)
end

function ResUrl.getV2a0SignSingleBgLang(resName)
	return string.format("singlebg_lang/txt_v2a0_sign_singlebg/%s.png", resName)
end

function ResUrl.getV2a0WarmUpSingleBg(resName)
	return string.format("singlebg/v2a0_warmup_singlebg/%s.png", resName)
end

function ResUrl.getV2a1SignSingleBg(resName)
	return string.format("singlebg/v2a1_sign_singlebg/%s.png", resName)
end

function ResUrl.getV2a1SignSingleBgLang(resName)
	return string.format("singlebg_lang/txt_v2a1_sign_singlebg/%s.png", resName)
end

function ResUrl.getV2a1AergusiSingleBg(resName)
	return string.format("singlebg/v2a1_aergusi_singlebg/%s.png", resName)
end

function ResUrl.getV2a1MoonFestivalSignSingleBg(resName)
	return string.format("singlebg/v2a1_moonfestival_singlebg/%s.png", resName)
end

function ResUrl.getV2a1MoonFestivalSignSingleBgLang(resName)
	return string.format("singlebg_lang/txt_v2a1_moonfestival_singlebg/%s.png", resName)
end

function ResUrl.getV2a1WarmUpSingleBg(resName)
	return string.format("singlebg/v2a1_warmup_singlebg/%s.png", resName)
end

function ResUrl.getV2a2SignSingleBg(resName)
	return string.format("singlebg/v2a2_sign_singlebg/%s.png", resName)
end

function ResUrl.getV2a2SignSingleBgLang(resName)
	return string.format("singlebg_lang/txt_v2a2_logo/%s.png", resName)
end

function ResUrl.getV2a2RedLeafFestivalSignSingleBg(resName)
	return string.format("singlebg/v2a2_redleaffestival_singlebg/%s.png", resName)
end

function ResUrl.getV2a2RedLeafFestivalSignSingleBgLang(resName)
	return string.format("singlebg_lang/txt_v2a2_redleaffestival_singlebg/%s.png", resName)
end

function ResUrl.getV2a3SignSingleBg(resName)
	return string.format("singlebg/v2a3_sign_singlebg/%s.png", resName)
end

function ResUrl.getV2a3SignSingleBgLang(resName)
	return string.format("singlebg_lang/txt_v2a3_sign_singlebg/%s.png", resName)
end

function ResUrl.getV2a3WarmUpSingleBg(resName)
	return string.format("singlebg/v2a3_warmup_singlebg/%s.png", resName)
end

function ResUrl.getV2a4SignSingleBg(resName)
	return string.format("singlebg/v2a4_sign_singlebg/%s.png", resName)
end

function ResUrl.getV2a4SignSingleBgLang(resName)
	return string.format("singlebg_lang/txt_v2a4_sign_singlebg/%s.png", resName)
end

function ResUrl.getChessDialogueSingleBg(resName)
	return string.format("singlebg/dialogue/chess/%s.png", resName)
end

function ResUrl.getV2a5SignSingleBg(resName)
	return string.format("singlebg/v2a5_sign_singlebg/%s.png", resName)
end

function ResUrl.getV2a5SignSingleBgLang(resName)
	return string.format("singlebg_lang/txt_v2a5_sign_singlebg/%s.png", resName)
end

local AssetsZResourcesLib = "Assets/ZResourcesLib/"
local AssetsZResourcesLibLen = string.len(AssetsZResourcesLib)

function ResUrl.getPathWithoutAssetLib(path)
	local start = string.find(path, AssetsZResourcesLib)

	if start then
		return string.sub(path, start + AssetsZResourcesLibLen)
	end

	return path
end

function ResUrl.getV2a1Act165SingleBgLang(resName)
	return string.format("singlebg/v2a1_strangetale_singlebg/%s.png", resName)
end

function ResUrl.monsterHeadIcon(resName)
	return string.format("singlebg/headicon_monster/%s.png", tostring(resName))
end

function ResUrl.roomHeadIcon(resName)
	return string.format("singlebg/headicon_room/%s.png", tostring(resName))
end

function ResUrl.getCritterHedaIcon(resName)
	return string.format("singlebg/headicon_critter/%s.png", tostring(resName))
end

function ResUrl.getCritterLargeIcon(resName)
	return string.format("singlebg/largeicon_critter/%s.png", tostring(resName))
end

function ResUrl.getRoomCritterIcon(resName)
	return string.format("singlebg/room/critter/%s.png", tostring(resName))
end

function ResUrl.getRoomCritterEggPrefab(res)
	return string.format("ui/viewres/room/critter/egg/%s.prefab", res)
end

function ResUrl.getBgmEggIcon(resName)
	return string.format("singlebg/bgmtoggle_singlebg/%s.png", tostring(resName))
end

function ResUrl.getTowerIcon(res)
	return string.format("singlebg/tower_singlebg/%s.png", tostring(res))
end

function ResUrl.getAct174BadgeIcon(resName, state)
	return string.format("singlebg/act174/badgeicon/%s_%s.png", resName, state)
end

function ResUrl.getAct174BuffIcon(resName)
	return string.format("singlebg/act174/bufficon/%s.png", resName)
end

function ResUrl.getV2a4WuErLiXiIcon(resName)
	return string.format("singlebg/v2a4_wuerlixi_singlebg/%s.png", resName)
end

function ResUrl.getAutoChessIcon(resName, path)
	if path then
		return string.format("singlebg/v2a5_autochess_singlebg/%s/%s.png", path, resName)
	else
		return string.format("singlebg/v2a5_autochess_singlebg/%s.png", resName)
	end
end

function ResUrl.getMovingChessIcon(resName, path)
	if path then
		return string.format("singlebg/movingchess/%s/%s.png", path, resName)
	else
		return string.format("singlebg/movingchess/%s.png", resName)
	end
end

function ResUrl.getChallengeIcon(resName)
	return string.format("singlebg/v2a5_challenge_singlebg/%s.png", resName)
end

function ResUrl.getAct184LanternIcon(resName)
	return string.format("singlebg/v2a5_lanternfestival_singlebg/%s.png", resName)
end

function ResUrl.getV2a5FeiLinShiDuoBg(resName)
	return string.format("singlebg/v2a5_feilinshiduo_singlebg/%s.png", resName)
end

function ResUrl.getLiveHeadIconPrefab(resName)
	return (string.format("ui/viewres/dynamichead/%s.prefab", tostring(resName)))
end

function ResUrl.getAntiqueEffect(resName)
	return (string.format("ui/viewres/antique/effect/%s.prefab", tostring(resName)))
end

function ResUrl.getDestinyIcon(resName)
	return (string.format("singlebg/characterdestiny/stone/%s.png", tostring(resName)))
end

function ResUrl.getTxtDestinyIcon(resName)
	return (string.format("singlebg_lang/txt_characterdestiny/%s.png", resName))
end

function ResUrl.getV2a4WarmUpSingleBg(resName)
	return string.format("singlebg/v2a4_warmup_singlebg/%s.png", resName)
end

function ResUrl.getDecorateStoreImg(resName)
	return (string.format("singlebg/store/decorate/%s.png", tostring(resName)))
end

function ResUrl.getV2a5LiangYueImg(resName)
	return (string.format("singlebg_lang/txt_v2a5_liangyue_singlebg/%s.png", tostring(resName)))
end

function ResUrl.getShortenActSingleBg(resName)
	return string.format("singlebg/shortenact_singlebg/%s.png", resName)
end

function ResUrl.getAct191SingleBg(resName)
	return string.format("singlebg/act191/%s.png", resName)
end

function ResUrl.getV2a7WarmUpSingleBg(resName)
	return string.format("singlebg/v2a7_warmup_singlebg/%s.png", resName)
end

function ResUrl.getSp01AssassinSingleBg(resName)
	return string.format("singlebg/assassin2_singlebg/%s.png", resName)
end

function ResUrl.getSp01OdysseySingleBg(resName)
	return string.format("singlebg/odyssey_singlebg/%s.png", resName)
end

function ResUrl.getSp01OdysseyItemSingleBg(resName)
	return string.format("singlebg/odyssey_singlebg/equip/%s.png", resName)
end

function ResUrl.getV2a9VersionSummonSingleBg(resName)
	return string.format("singlebg/v2a9_versionsummon_singlebg/%s.png", resName)
end

function ResUrl.getV2a9VersionSummonSingleBgLang(resName)
	return string.format("singlebg_lang/txt_v2a9_versionsummon_singlebg/%s.png", resName)
end

function ResUrl.getV2a9ActSingleBg(resName)
	return string.format("singlebg/v2a9_act_singlebg/%s.png", resName)
end

function ResUrl.getV2a9ActOceanSingleBg(resName)
	return string.format("singlebg/v2a9_act_singlebg/ocean/%s.png", resName)
end

function ResUrl.getSurvivalItemIcon(resName)
	return string.format("singlebg/survival_singlebg/collection/%s.png", resName)
end

function ResUrl.getSurvivalTeamIcon(resName)
	return string.format("singlebg/survival_singlebg/team/%s.png", resName)
end

function ResUrl.getSurvivalTechIcon(resName)
	return string.format("singlebg/survival_singlebg/tech/%s.png", resName)
end

function ResUrl.getSurvivalTalentIcon(resName)
	return string.format("singlebg/survival_singlebg/talent/%s.png", resName)
end

function ResUrl.getSurvivalMapIcon(resName)
	return string.format("singlebg/survival_singlebg/map/%s.png", resName)
end

function ResUrl.getSurvivalNpcIcon(resName)
	return string.format("singlebg/survival_singlebg/npc/%s.png", resName)
end

function ResUrl.getSurvivalEquipIcon(resName)
	return string.format("singlebg/survival_singlebg/equip/icon/%s.png", resName)
end

function ResUrl.getSurvivalShopItemLevelIcon(resName)
	return string.format("singlebg/survival_singlebg/shop/%s.png", resName)
end

function ResUrl.getNuoDiKaSingleBg(resName)
	return string.format("singlebg/v2a8_nuodika_singlebg/%s.png", resName)
end

function ResUrl.getNuoDiKaItemIcon(resName)
	return string.format("singlebg/v2a8_nuodika_singlebg/item/%s.png", resName)
end

function ResUrl.getNuoDiKaMonsterIcon(resName)
	return string.format("singlebg/v2a8_nuodika_singlebg/monster/%s.png", resName)
end

function ResUrl.getActivity2ndTakePhotoSingleBg(resName)
	return string.format("singlebg/v2a8_gift_singlebg/%s", resName)
end

function ResUrl.getDecorateStoreBuyBannerFullPath(resName)
	return string.format("singlebg_lang/txt_playercard_singlebg/%s.png", resName)
end

function ResUrl.getV2a8WarmUpSingleBg(resName)
	return string.format("singlebg/v2a8_warmup_singlebg/%s.png", resName)
end

function ResUrl.getCommandStationPaperIcon(resName)
	return string.format("singlebg/commandstation/paper/%s.png", resName)
end

function ResUrl.getV3a0WarmUpSingleBg(resName)
	return string.format("singlebg/v3a0_warmup_singlebg/%s.png", resName)
end

function ResUrl.getV2a9WarmUpSingleBg(resName)
	return string.format("singlebg/v2a9_warmup_singlebg/%s.png", resName)
end

function ResUrl.getRoleSignSingleBg(resName)
	return string.format("singlebg/sign_singlebg/%s.png", resName)
end

function ResUrl.getRoleSignSingleBgLang(resName)
	return string.format("singlebg_lang/txt_sign_singlebg/%s.png", resName)
end

function ResUrl.getV3a1YeShuMeiSingleBg(resName)
	return string.format("singlebg/v3a1_yeshumei_singlebg/%s.png", resName)
end

function ResUrl.getNecrologistStoryPicBg(resName)
	return string.format("singlebg/dungeon/rolestory_singlebg/storypic/%s.png", resName)
end

function ResUrl.getRoleDynamicTexture(resName)
	return string.format("roles/dynamic/textures/%s.png", resName)
end

function ResUrl.getSkin2dBg(resName)
	return string.format("singlebg/skin2dbg/%s.png", resName)
end

function ResUrl.getV3a1WarmUpSingleBg(resName)
	return string.format("singlebg/v3a1_warmup_singlebg/%s.png", resName)
end

function ResUrl.getVersionSummonSingleBg(resName)
	return string.format("singlebg/versionsummon_singlebg/%s.png", resName)
end

function ResUrl.getVersionSummonSingleBgLang(resName)
	return string.format("singlebg_lang/txt_versionsummon/%s.png", resName)
end

function ResUrl.getBeilierIcon(resName)
	return string.format("singlebg/v3a2_beilier_singlebg/puzzle/%s.png", resName)
end

function ResUrl.getEliminateIcon(resName)
	return string.format("singlebg/v3a3_eliminate_singlebg/%s.png", resName)
end

function ResUrl.getV3a4SingleBg(resName)
	return string.format("singlebg/v3a4_dungeon_singlebg/%s.png", resName)
end

function ResUrl.getTowerComposeModIcon(resName)
	return string.format("singlebg/tower2_singlebg/mod/%s.png", resName)
end

function ResUrl.getV3a4PartySingleBg(resName, path)
	if path then
		return string.format("modules/party_game/ui/singlebg/v3a4_party_singlebg/%s/%s.png", path, resName)
	else
		return string.format("modules/party_game/ui/singlebg/v3a4_party_singlebg/%s.png", resName)
	end
end

function ResUrl.getV3a5LamonaSingleBg(resName)
	return string.format("singlebg/v3a5_lamona_singlebg/%s.png", resName)
end

function ResUrl.getLorentzIcon(resName)
	return string.format("singlebg/v3a5_lorentz_singlebg/puzzle/%s.png", resName)
end

function ResUrl.getV3a6YaMiHeroSingleBg(resName)
	return string.format("singlebg/v3a6_dormitorymode_singlebg/chess/%s.png", resName)
end

function ResUrl.getV3a6YaMiCollectionSingleBg(resName)
	return string.format("singlebg/v3a6_dormitorymode_singlebg/collection/%s.png", resName)
end

function ResUrl.getV3a6YaMiHeroHandbookSingleBg(resName)
	return string.format("singlebg/chess/%s.png", resName)
end

function ResUrl.getV3a6YaMiItemSingleBg(resName)
	return string.format("singlebg/survival_singlebg/collection/%s.png", resName)
end

function ResUrl.getV3a6WarmUpSingleBg(resName)
	return string.format("singlebg/v3a6_warmup_singlebg/%s.png", resName)
end

function ResUrl.getUISpinePrefabBySkin(skinCO)
	if not skinCO then
		return ""
	end

	local spinePath
	local isPath = string.find(skinCO.spine, "/")

	return string.format("roles/%s_ui.prefab", isPath and skinCO.spine or string.format("%s/%s", skinCO.spine, skinCO.spine))
end

function ResUrl.getSummonPoolPackageItemPath(type)
	return string.format("ui/viewres/summon/summonpoolpackage/summonpoolpackageitem_%s.prefab", type)
end

function ResUrl.getSodacheSingleBg(resName, path)
	if path then
		return string.format("modules/sodache/ui/singlebg/%s/%s.png", path, resName)
	else
		return string.format("modules/sodache/ui/singlebg/%s.png", resName)
	end
end

function ResUrl.getAct236SingleBg(resName, path)
	if path then
		return string.format("singlebg_lang/txt_v3a7_cumulativerecharge_singlebg/%s/%s.png", path, resName)
	else
		return string.format("singlebg_lang/txt_v3a7_cumulativerecharge_singlebg/%s.png", resName)
	end
end

function ResUrl.getTravelGoSingleBg(res)
	return string.format("singlebg/v3a7_xiaoruiannong_singlebg/%s.png", res)
end

function ResUrl.getGiftMultipleHeroSingleBg(resName, path)
	return string.format("singlebg/store/cumulativerechargeselect/role/%s.png", resName)
end

function ResUrl.getGiftMultipleHeroNameSingleBg(resName, path)
	return string.format("singlebg_lang/txt_store/cumulativerechargeselect/%s.png", resName)
end

function ResUrl.getV3a7WmzGameSingleBg(resName)
	return ResUrl.getV3a7WmzSingleBg("game/" .. resName)
end

function ResUrl.getV3a7WmzSingleBg(resName)
	return string.format("singlebg/v3a7_wmz_singlebg/%s.png", resName)
end

function ResUrl.getV3a8DianJiShiSingleBg(resName)
	return string.format("singlebg/v3a8_dianjishi_singlebg/%s.png", resName)
end

function ResUrl.getV3a8WarmUpSingleBg(resName)
	return string.format("singlebg/v3a8_warmup_singlebg/%s.png", resName)
end

function ResUrl.getV3a9HedoneSingleBg(resName)
	return string.format("singlebg/v3a9_hedone_singlebg/%s.png", resName)
end

function ResUrl.getAtomicSingleBg(resName)
	return string.format("singlebg/sp02_atomic_singlebg/%s.png", resName)
end

function ResUrl.getAtomicForyouSingleBg(path)
	return string.format("singlebg/sp02_atomicforyou/%s.png", path)
end

function ResUrl.getS02PaoMianSingleBg(path)
	return string.format("singlebg/sp02_paomian_singlebg/%s.png", path)
end

return ResUrl
