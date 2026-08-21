-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/core/utils/StoryLogicResPathUtils.lua

module("logic.extensions.story.core.utils.StoryLogicResPathUtils", package.seeall)

function GetFreeCamUrl()
	return "story/sys/free_cam.prefab"
end

function GetCharcterLight()
	return "story/light/story_character_light.prefab"
end

function Get2DSceneTextureUrl(name)
	return string.format("ui/bigbg/plot/%s", name)
end

function Get3dEffectSceneUrl(name)
	return string.format("effect3d/prefab/story/%s.prefab", name)
end

function GetStoryStageUrl(name)
	return string.format("story/stagetpl/%s", name)
end

function Get2DSceneUrl(name)
	return string.format("story/scene2d/%s", name)
end

function GetVolumeUrl(name)
	return string.format("story/comm/volume/%s", name)
end

function GetScenePath(sceName)
	if GameUtils.isEmptyString(sceName) then
		return nil
	end

	return StoryLogicResPathUtils.GetSPXScenePath(sceName)
end

function GetSPXScenePath(sceneName)
	local falgIndex = string.find(sceneName, "_")
	local nextIndex = string.find(sceneName, "_", falgIndex + 1)
	local folderName = sceneName

	if nextIndex and type(nextIndex) == "number" and nextIndex > 0 then
		folderName = string.sub(sceneName, 1, nextIndex - 1)
	end

	return GameUrl.getSceneRunUrl(folderName, sceneName)
end

function GetIconPath(iconName)
	if GameUtils.isEmptyString(iconName) then
		return nil
	end

	return GameUrl.getStoryHeadIconUrl(iconName)
end

function GetCharacterFaceAnimPath(characterName, clipName)
	return GameUrl.GetCharacterFaceAnimPath(characterName, clipName)
end

function GetMouthAnimationClipPath(storyId, clipName)
	return GameUrl.GetMouthAnimationClipPath(storyId, clipName)
end

function GetIdelAnimClipPath(clipName)
	return GameUrl.GetIdelAnimClipPath(clipName)
end

function GetBlushPath()
	return GameUrl.GetBlushPath()
end

function GetXinMaoPath(characterName, heroName)
	return GameUrl.GetXinMaoPath(characterName, heroName)
end
