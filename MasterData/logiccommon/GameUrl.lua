-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/util/GameUrl.lua

module("logiccommon.common.util.GameUrl", package.seeall)

local GameUrl = {}
local endBoss = "_boss"
local endBossLen = string.len(endBoss)

GameUrl.EmptySkill = "skillconfig/empty_skill.txt"

function GameUrl.getSpineUrl(resName, ext)
	local dic = GameUrl._handleSpineDic(resName)
	local path = string.format("character/%s/%s_p.prefab", dic, resName)

	if not string.nilorempty(ext) then
		path = string.format("character/%s/%s_p.prefab", dic, ext)
	end

	if Framework.OSDef.isEditor and rescache.resLoadMode == Framework.ResourceLoadMode.Direct then
		return GameUrl._checkDefultSpinePath(path)
	end

	return path
end

function GameUrl.checkSpineUIUrl(path)
	local resPath

	return string.find(path, "_lihui") and GameUrl.getLihuiSpineUIUrl(path) or GameUrl.getSpineUIUrl(path)
end

function GameUrl.checkSpineUrl(path)
	local resPath

	return string.find(path, "_lihui") and GameUrl.getLihuiSpineUrl(path) or GameUrl.getSpineUrl(path)
end

function GameUrl._handleSpineDic(resName)
	return (string.sub(resName, -endBossLen) == endBoss or nil) and string.sub(resName, 1, -endBossLen - 1)
end

function GameUrl._checkDefultSpinePath(path)
	if not GoUtil.IsAssetExist(path) then
		printError(">>>>><color='#ff0000'>要上线的精灵必须留意</color>， 暂时 使用默认spine 因为 缺少：", path)

		if string.find(path, "_gensui") then
			return "character/10002_xiaobao_gensui/10002_xiaobao_gensui_p.prefab"
		else
			return "character/10002_xiaobao/10002_xiaobao_p.prefab"
		end
	end

	return path
end

function GameUrl._checkDefultSpineUIPath(path)
	if not GoUtil.IsAssetExist(path) then
		printError(">>>>>  使用默认资源 因为 缺少资源：", path)

		return "character/10002_xiaobao/10002_xiaobao-ui_p.prefab"
	end

	return path
end

function GameUrl.getSpineUIUrl(resName)
	local dic = GameUrl._handleSpineDic(resName)
	local path = string.format("character/%s/%s-ui_p.prefab", dic, resName)

	if Framework.OSDef.isEditor and rescache.resLoadMode == Framework.ResourceLoadMode.Direct then
		return GameUrl._checkDefultSpineUIPath(path)
	end

	return path
end

function GameUrl.getHeadSpineUIUrl(resName)
	local path = string.format("head_spine/%s/%s.prefab", resName, resName)

	if Framework.OSDef.isEditor and rescache.resLoadMode == Framework.ResourceLoadMode.Direct then
		return GameUrl._checkDefultSpineUIPath(path)
	end

	return path
end

function GameUrl.getViewSpineUIUrl(resName)
	local path = string.format("view_spine/%s/%s-ui_p.prefab", resName, resName)

	if Framework.OSDef.isEditor and rescache.resLoadMode == Framework.ResourceLoadMode.Direct then
		return GameUrl._checkDefultSpineUIPath(path)
	end

	return path
end

function GameUrl.getLihuiSpineUrl(resName)
	local dic = GameUrl._handleSpineDic(resName)
	local path = string.format("lihui_spine/%s/%s_p.prefab", dic, resName)

	if Framework.OSDef.isEditor and rescache.resLoadMode == Framework.ResourceLoadMode.Direct then
		return GameUrl._checkDefultSpinePath(path)
	end

	return path
end

function GameUrl.getPosterSpineUrl(resName)
	local dic = GameUrl._handleSpineDic(resName)
	local path = string.format("haibao_spine/%s/%s_p.prefab", dic, resName)

	if Framework.OSDef.isEditor and rescache.resLoadMode == Framework.ResourceLoadMode.Direct then
		return GameUrl._checkDefultSpinePath(path)
	end

	return path
end

function GameUrl.getPosterUISpineUrl(resName)
	local dic = GameUrl._handleSpineDic(resName)
	local path = string.format("haibao_spine/%s/%s-ui_p.prefab", dic, resName)

	if Framework.OSDef.isEditor and rescache.resLoadMode == Framework.ResourceLoadMode.Direct then
		return GameUrl._checkDefultSpineUIPath(path)
	end

	return path
end

function GameUrl.getLihuiSpineUIUrl(resName)
	local dic = GameUrl._handleSpineDic(resName)
	local path = string.format("lihui_spine/%s/%s-ui_p.prefab", dic, resName)

	if Framework.OSDef.isEditor and rescache.resLoadMode == Framework.ResourceLoadMode.Direct then
		return GameUrl._checkDefultSpineUIPath(path)
	end

	return path
end

function GameUrl.getSpineAssetRrl(resName)
	local path = string.format("character/%s/%s_skeletondata.asset", resName, resName)

	if Framework.OSDef.isEditor and rescache.resLoadMode == Framework.ResourceLoadMode.Direct and not GoUtil.IsAssetExist(path) then
		return "character/10002_xiaobao/10002_xiaobao_skeletondata.asset"
	end

	return path
end

function GameUrl.getEffectUrl(resName)
	return string.format("effect/prefabs/%s.prefab", resName)
end

function GameUrl.getSceneEffectUrl(resName)
	return string.format("effect/prefabs/scene/%s.prefab", resName)
end

function GameUrl.getCharacterIconUrl(resName)
	local path = string.format("ui/icon/character/%s.png", resName)

	if Framework.OSDef.isEditor and rescache.resLoadMode == Framework.ResourceLoadMode.Direct and not GoUtil.IsAssetExist(path) then
		return "ui/icon/character/icon_10002_xiaobao.png"
	end

	return path
end

function GameUrl.getDressIconUrl(resName, isbig)
	resName = isbig and resName .. "_big" or resName

	local path = string.format("ui/icon/dress/%s.png", resName)

	if Framework.OSDef.isEditor and rescache.resLoadMode == Framework.ResourceLoadMode.Direct and not GoUtil.IsAssetExist(path) then
		return "ui/icon/dress/icon_xg_nan.png"
	end

	return path
end

function GameUrl.getCutePetIconUrl(resName)
	local path = string.format("ui/icon/cutepet/%s.png", resName)

	if Framework.OSDef.isEditor and rescache.resLoadMode == Framework.ResourceLoadMode.Direct and not GoUtil.IsAssetExist(path) then
		return "ui/icon/cutepet/icon_mengchong_01.png"
	end

	return path
end

function GameUrl.getPetImgUrl(resName)
	local path = string.format("ui/bigbg/pet/%s.png", resName)

	if Framework.OSDef.isEditor and rescache.resLoadMode == Framework.ResourceLoadMode.Direct and not GoUtil.IsAssetExist(path) then
		return "ui/bigbg/pet/img_10002_xiaobao.png"
	end

	return path
end

function GameUrl.getCutepetImgUrl(resName)
	local path = string.format("ui/bigbg/cutepet/%s.png", resName)

	if Framework.OSDef.isEditor and rescache.resLoadMode == Framework.ResourceLoadMode.Direct and not GoUtil.IsAssetExist(path) then
		return "ui/bigbg/cutepet/img_mengchong_01.png"
	end

	return path
end

function GameUrl.getRankRaceIconUrl(resName)
	return string.format("ui/bigbg/rankrace/%s.png", resName)
end

function GameUrl.getPetTalentIconUrl(resName)
	return string.format("ui/bigbg/pettalent/%s.png", resName)
end

function GameUrl.getLotteryPetImgUrl(faceId)
	local modelCo = CharacterConfig.instance:getModelCo(checknumber(faceId))

	return string.format("ui/bigbg/pet/%s.png", modelCo.cardName)
end

function GameUrl.getPetDrawUrl(resName)
	return string.format("ui/bigbg/pet_draw/%s.png", resName)
end

function GameUrl.getSkillIconUrl(resName)
	return string.format("ui/icon/skill/%s.png", resName)
end

function GameUrl.getLoadingbgUrl(idx)
	return BootstrapResPreLoad.bootstrapBackground
end

function GameUrl.getCopyChapterBgUrl(resName)
	return string.format("ui/bigbg/copychapter/%s.png", resName)
end

function GameUrl.getIconUrl(resName)
	return string.format("ui/icon/%s.png", resName)
end

function GameUrl.getItemIconUrl(resName)
	return string.format("ui/icon/items/%s.png", resName)
end

function GameUrl.getIconFolderUrl(folder, resName)
	return string.format("ui/icon/%s/%s.png", folder, resName)
end

function GameUrl.getJumpIconUrl(resName)
	return string.format("ui/icon/jump/%s.png", resName)
end

function GameUrl.getJumpRightIconUrl(resName)
	return string.format("ui/icon/jumpright/%s.png", resName)
end

function GameUrl.getImpressionStickersIconUrl(resName)
	return string.format("ui/bigbg/impressionstickers/%s.png", resName)
end

function GameUrl.getBonusIconUrl(resName)
	return string.format("ui/bigbg/bonus/%s.png", resName)
end

function GameUrl.getPassportBGUrl(resName)
	return string.format("ui/bigbg/passport/%s.png", resName)
end

function GameUrl.getFirstChargeBGUrl(resName)
	return string.format("ui/bigbg/firstcharge/%s.png", resName)
end

function GameUrl.getMiniGameBgUrl(resName)
	return string.format("ui/bigbg/amusementpark/%s.png", resName)
end

function GameUrl.getBigbgPngUrl(resName)
	return string.format("ui/bigbg/%s.png", resName)
end

function GameUrl.getPetPosterBigbgPngUrl(resName)
	return string.format("ui/bigbg/petposter/%s.png", resName)
end

function GameUrl.getXinshenIconUrl(resName)
	return string.format("ui/bigbg/stargod/xinshen%s.png", resName)
end

function GameUrl.getBigbgFolderUrl(folder, resName)
	return string.format("ui/bigbg/%s/%s.png", folder, resName)
end

function GameUrl.getSkillIconUrl(resName)
	return string.format("ui/icon/skill/%s.png", resName)
end

function GameUrl.getFuncIconUrl(resName)
	return "effect/prefabs/" .. resName .. ".prefab"
end

function GameUrl.getBattleEffUrl(resName)
	return string.format("ui/icon/func/%s.png", resName)
end

function GameUrl.getExpEventUrl(resName)
	return string.format("ui/icon/expevents/%s.png", resName)
end

function GameUrl.getEmojiUrl(prefix, resName)
	return string.format("ui/emoji/%s/%s.png", prefix, resName)
end

function GameUrl.getZoneResUrl(zoneId)
	local zoneCO = SceneConfig.instance:getZoneCO(zoneId)
	local sceneId = zoneCO.sceneId
	local sceneCO = SceneConfig.instance:getSceneCO(sceneId)

	return string.format("scene/prefabs/%s/%s/zone.prefab", sceneCO.resName, zoneCO.resName)
end

function GameUrl.getSceneStageResUrl(sceneId)
	local sceneCo = SceneConfig.instance:getSceneCo(sceneId)

	return string.format("scene/prefabs/%s.prefab", sceneCo.resName)
end

function GameUrl.getBattleStageUrl(battlePlace)
	return "scene/battle/" .. battlePlace .. "/" .. battlePlace .. "_p.prefab"
end

function GameUrl.getScenCityStageResUrls(sceneId, festival)
	local resName

	if festival then
		local festivalCo = SceneConfig.instance:getSceneFestivalCo(sceneId, festival)

		if festivalCo then
			resName = festivalCo.resName
		end
	end

	if not resName then
		local sceneCo = SceneConfig.instance:getSceneCo(sceneId)

		resName = sceneCo.resName
	end

	local urls = {}
	local cnt = #resName

	for i = 1, cnt do
		local url = string.format("scene/configs/%s/%s.txt", resName[i], resName[i])

		table.insert(urls, url)
	end

	return urls
end

function GameUrl.getSceneDynElemXmlUrl(sceneId)
	local sceneCO = SceneConfig.instance:getSceneCO(sceneId)

	return string.format("scene/prefabs/%s/%s.xml", sceneCO.resName, sceneCO.resName)
end

function GameUrl.getSkillAnimTakePath(path, debugSkillId, debugSkin)
	local path = "skillconfig/" .. path .. ".txt"

	if Framework.OSDef.isEditor and rescache.resLoadMode == Framework.ResourceLoadMode.Direct then
		if not GoUtil.IsAssetExist(path) then
			FloatWordMgr.instance:show(lang("gameurl_1") .. path .. "|skillId=" .. tostring(debugSkillId) .. "|skin" .. tostring(debugSkin))
			printError("技能配置文件不存在=" .. path .. "|skillId=" .. tostring(debugSkillId) .. "|skin" .. tostring(debugSkin))

			return "skillconfig/skill_xiaobao/skill_xiaobao_01.txt"
		end
	elseif not AMPlayer.IsTakeResLoaded(path) then
		return GameUrl.EmptySkill
	end

	return path
end

function GameUrl.getSceneIconUrl(resName)
	return string.format("scene/scene_icons/%s", resName)
end

function GameUrl.getSceneMiscUrl(resName)
	return string.format("scene/misc/prefabs/%s.prefab", resName)
end

function GameUrl.getRankRaceBuffIconUrl(resName)
	return string.format("ui/icon/rankracebuff/%s.png", resName)
end

function GameUrl.getAvatarSkel(avatarType, resName)
	if avatarType == AvatarType.UI then
		resName = resName .. "_hpm"
	end

	return string.format("avatars/skeletons/%s/%s_p.prefab", resName, resName)
end

function GameUrl.getAvatarSkeleton(resName, useType)
	if useType == AvatarUseType.UI then
		resName = resName .. "_hpm"
	end

	return string.format("avatars/skeletons/%s/%s_p.prefab", resName, resName)
end

function GameUrl.getAvatarPart(resName, typeName, useType, isResSame)
	if useType == AvatarUseType.UI and not isResSame then
		resName = resName .. "_hpm"
	end

	return string.format("avatars/skinedmeshes/%s/%s.prefab", typeName, resName)
end

function GameUrl.getAvatarPlayerFaceMat(resName, coverTypeName)
	resName = resName .. "_hpm_m"
	resName = string.gsub(resName, coverTypeName, "face")

	return string.format("avatars/playerfacemats/%s.mat", resName)
end

function GameUrl.getSkinMesh(avatarType, typeName, resName)
	if avatarType == AvatarType.UI then
		resName = resName .. "_hpm"
	end

	return string.format("avatars/skinedmeshes/%s/%s.prefab", typeName, resName)
end

function GameUrl.getSkinMeshIcon(typeName, resName)
	return string.format("ui/icon/avatar/%s/%s.jpg", typeName, resName)
end

function GameUrl.getMountUrl(avatarType, resName)
	if avatarType == AvatarType.UI then
		resName = resName .. "_hpm"
	end

	return string.format("mounts/%s/%s.prefab", resName, resName)
end

function GameUrl.getMountUrlNew(resName, useType)
	if useType == AvatarUseType.UI then
		resName = resName .. "_hpm"
	end

	return string.format("mounts/%s/%s.prefab", resName, resName)
end

function GameUrl.getUIBGPicUrl(resName)
	return string.format("ui/bigbg/avatar/%s.png", resName)
end

function GameUrl.getPlotRecallUrl(resName)
	return string.format("ui/icon/cg/%s.png", resName)
end

function GameUrl.getTaskUrl(resName)
	return string.format("ui/icon/task/%s.png", resName)
end

function GameUrl.getAnimClipPath(modelName, resName)
	return string.format("avatars/animationclips/%s/%s@resName.anim", modelName, modelName, resName)
end

function GameUrl.getScenarioCopyUrl(resName)
	return string.format("ui/icon/yyfb/%s.png", resName)
end

function GameUrl.getScenarioCopyBigBgUrl(resName)
	return string.format("ui/bigbg/yyfb/%s.png", resName)
end

function GameUrl.getOperationSummaryIconUrl(resName)
	return string.format("ui/icon/hdhz/%s.png", resName)
end

function GameUrl.getOperationSummaryBGUrl(resName)
	return string.format("ui/bigbg/operationsummary/%s.png", resName)
end

function GameUrl.getHuoDongUrl(resName)
	return string.format("ui/bigbg/views/huodong/%s.png", resName)
end

function GameUrl.getAccconsumeUrl(resName)
	return string.format("ui/bigbg/accconsume/%s.png", resName)
end

function GameUrl.getTheaterUrl(resName)
	return string.format("ui/icon/dreamtheater/%s.png", resName)
end

function GameUrl.getMiruikeIcon(resName)
	return string.format("ui/icon/miruike/%s.png", resName)
end

function GameUrl.getDDKUrl(resName)
	return string.format("ui/bigbg/anlonggame/%s.png", resName)
end

function GameUrl.getPlotSonIcon(resName)
	return string.format("ui/bigbg/plotmemories/%s.png", resName)
end

function GameUrl.getDialog(resName)
	return string.format("ui/bigbg/heartmoneycat/%s.png", resName)
end

function GameUrl.getChallengeUrl(resName)
	return string.format("ui/bigbg/challenge/%s.png", resName)
end

function GameUrl.getLionCultureUrl(resName)
	return string.format("ui/bigbg/lionculture/%s.png", resName)
end

function GameUrl.getLionEmojiUrl(resName)
	return string.format("ui/emoji/xingshi/%s.png", resName)
end

function GameUrl.getGoddessRedpackUrl(resName)
	return string.format("ui/bigbg/goddessredpack/%s.png", resName)
end

function GameUrl.getImpressionStickerUrl(resName)
	return string.format("effect/prefabs/yinxiangtie/%s/%s-ui_p.prefab", resName, resName)
end

function GameUrl.getPetFrameAnimUrl(resName, index)
	return string.format("ui/bigbg/petframeanim/%s/%s_%s.png", resName, resName, index)
end

function GameUrl.getPetHeadIconFrameUrl(resName)
	return string.format("ui/icon/petheadframe/%s.png", resName)
end

function GameUrl.getPetCarFrameUrl(resName)
	return string.format("ui/bigbg/petcardframe/%s.png", resName)
end

function GameUrl.getFrameAnimAltasUrl(resName)
	return string.format("ui/spriteatlas/frameanimatlas/%s.prefab", resName)
end

function GameUrl.getShiJieBeiJingCaiIconUrl(resName)
	local path = string.format("ui/icon/shijiebeijingcai/%s.png", resName)

	if Framework.OSDef.isEditor and not GoUtil.IsAssetExist(path) then
		return "ui/icon/shijiebeijingcai/icon_sjbjc_01.png"
	end

	return path
end

function GameUrl.getSpiriteInvocationPetUrl(resName)
	return string.format("ui/bigbg/spiritinvocation/%s.png", resName)
end

return GameUrl
