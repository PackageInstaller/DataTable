-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/model/StoryConst.lua

module("logic.extensions.story.model.StoryConst", package.seeall)

local StoryConst = {}

StoryConst.DirLeft = "left"
StoryConst.DirRight = "right"
StoryConst.DirMiddle = "middle"
StoryConst.SpeakAsideMode_FadeIn_FadeOut = 0
StoryConst.SpeakAsideMode_FadeIn_Disappear = 1
StoryConst.SpeakAsideMode_TypeWriterIn_FadeOut = 2
StoryConst.SpeakAsideMode_TypeWriterIn_Disappear = 3
StoryConst.SpeakAsideMode_NextAppear_Disappear = 0
StoryConst.SpeakAsideMode_NextAppear_Hold = 1
StoryConst.Op_PlayerPosition = 1
StoryConst.Op_PlayStory = 2
StoryConst.Op_TransScene = 3
StoryConst.Op_NpcIntrod = 4
StoryConst.Story_Drama = "剧情"
StoryConst.Story_Drama_Model = "剧情-模型"
StoryConst.Story_Option = "选项"
StoryConst.Story_SpeakAside = "旁白"
StoryConst.Story_ImageSpeakAside = "旁白-美术字"
StoryConst.Story_Animation = "动画"
StoryConst.Story_Battle = "战斗"
StoryConst.Story_Movie = "视频"
StoryConst.Story_Brief = "梗概"
StoryConst.Story_Image = "道具展示"
StoryConst.Story_ChapterStart = "章节开启"
StoryConst.Story_ChapterEnd = "章节结束"
StoryConst.Story_BG_Black = "黑屏"
StoryConst.Story_BG_Gray = "灰屏"
StoryConst.Story_BG_SceneBlur = "场景模糊"
StoryConst.Story_BG_None = "无"
StoryConst.Story_Effect_None = "无"
StoryConst.Story_Effect_Red = "红光"
StoryConst.Story_Effect_Effect = "特效"
StoryConst.StoryPath_BigImgBg = "ui/bigbg/story/story_bg/"
StoryConst.StoryPath_BigImg = "ui/bigbg/story/story_images/"
StoryConst.StoryPath_Effects = "effect/prefabs/story/"
StoryConst.StoryPath_IconImgBg = "ui/bigbg/story/story_icons/"
StoryConst.StoryPath_NpcIconImgBg = "ui/bigbg/story/story_icons_npc/"
StoryConst.StoryPath_Assets = "ui/bigbg/story/story_assets/"
StoryConst.Story_FadeIn = "淡入"
StoryConst.Story_FadeOut = "淡出"
StoryConst.Story_TranslateIn = "飞入"
StoryConst.Story_TranslateOut = "飞出"
StoryConst.Story_Shake = "震动"
StoryConst.Story_ScaneIn = "放大"
StoryConst.Story_ScaleOut = "缩小"
StoryConst.Story_Move = "移动"
StoryConst.FadeIn_Time = 0.5
StoryConst.FadeOut_Time = 0.5

function StoryConst.isBgWithoutImage(bgImg)
	return not bgImg or #bgImg == 0 or bgImg == StoryConst.Story_BG_Black or bgImg == StoryConst.Story_BG_Gray or bgImg == StoryConst.Story_BG_SceneBlur or bgImg == StoryConst.Story_BG_None
end

function StoryConst.getSpineUrl(path)
	local resPath

	return string.find(path, "_lihui") and GameUrl.getLihuiSpineUrl(path) or GameUrl.getSpineUrl(path)
end

function StoryConst.getStoryModelConfig(storyCo)
	if storyCo.name == "#username#" then
		local gender = RoleModel.instance:getGender()

		if gender == 0 and storyCo.model_female and #storyCo.model_female > 0 then
			return StoryConfig.instance:getStoryConfig(storyCo.model_female, storyCo.direction)
		end
	end

	if storyCo.model and #storyCo.model > 0 then
		return StoryConfig.instance:getStoryConfig(storyCo.model, storyCo.direction)
	end
end

function StoryConst.getStoryModelActions(storyCo)
	if storyCo.name == "#username#" then
		local gender = RoleModel.instance:getGender()

		if gender == 0 and storyCo.action_female and #storyCo.action_female then
			return storyCo.action_female
		end
	end

	return storyCo.action
end

function StoryConst.handleStoriesBackground(storyConfig)
	local cnt = #storyConfig
	local preImgBg, preBgEff

	for i = 1, cnt do
		local story = storyConfig[i]

		if story.type == StoryConst.Story_ChapterStart or story.type == StoryConst.Story_ChapterEnd then
			story.bgImg = "story_chapter_bg.png"
		end

		if string.nilorempty(story.bgImg) then
			preImgBg = preImgBg or StoryConst.getDefaultStoryBg(story)
			story.bgImg = preImgBg
		end

		if string.nilorempty(story.bgImg) then
			story.bgImg = StoryConst.Story_BG_None
		end

		if string.nilorempty(story.bgEff) then
			if preBgEff then
				story.bgEff = preBgEff
			end
		else
			preBgEff = story.bgEff
		end

		preImgBg = story.bgImg
	end
end

function StoryConst.getDefaultStoryBg(currConfig)
	local bgImg = currConfig.bgImg

	if not bgImg or #bgImg == 0 then
		currStoryType = currConfig.type and #currConfig.type > 0 and currConfig.type or StoryConst.Story_Drama

		if currStoryType == StoryConst.Story_Drama or currStoryType == StoryConst.Story_Option then
			return StoryConst.Story_BG_SceneBlur
		end

		if currStoryType == StoryConst.Story_SpeakAside or currStoryType == StoryConst.Story_ImageSpeakAside then
			return StoryConst.Story_BG_Black
		end

		if currStoryType == StoryConst.Story_ChapterStart or currStoryType == StoryConst.Story_ChapterEnd then
			return "story_chapter_bg.png"
		end

		bgImg = StoryConst.Story_BG_None
	end

	return bgImg
end

function StoryConst.executeOp(op, params)
	if op == StoryConst.Op_PlayerPosition then
		local scene = SceneMgr.instance:getCurScene()
		local hasPos, x, y = scene.stage.wholeScene:GetPositionNodePos(tonumber(params[1]), nil, nil)

		if hasPos then
			local mainPlayer = SceneMainPlayer.instance:getMainPlayer()

			if mainPlayer then
				mainPlayer:stopAllActions()
				mainPlayer.transform:setPos(x, y, nil, true)
			end
		end
	elseif op == StoryConst.Op_PlayStory then
		local storyId = tonumber(params[1])

		StoryController.instance:startStory(storyId)
	elseif op == StoryConst.Op_NpcIntrod then
		local npcInstrodId = tonumber(params[1])

		ViewMgr.instance:open(ViewName.NpcIntrodView, npcInstrodId)

		return {
			npcInstrod = true
		}
	elseif op == StoryConst.Op_TransScene then
		if not NetConnMgr.instance:isConnected(ConnectionType.Logic) then
			ReConnectionMgr.instance:promptAndReturnToLogin("tip", "tip_network_disconnect")

			return {
				transitionScene = true
			}
		end

		local sceneId = tonumber(params[1])
		local mainPlayer = SceneMainPlayer.instance:getMainPlayer()

		if mainPlayer then
			mainPlayer:stopAllActions()

			local scene = SceneMgr.instance:getCurScene()

			if sceneId == scene:getSceneId() and params[2] and params[3] then
				mainPlayer.transform:setPos(tonumber(params[2]), tonumber(params[3]), nil, true)
			else
				local hasTrans, destX, destY = scene:getTransmitPoint(sceneId, nil, nil)

				if hasTrans then
					scene:setIngoreTransmitPoint(true)
				end

				local posX, posY

				if params[2] and params[3] then
					posX = tonumber(params[2])
					posY = tonumber(params[3])
				end

				UnlockFacade.dontcheckTaskUnlockScene = true

				GlobalFacade.instance:enterCity(sceneId, scene:getSceneId(), posX, posY)

				UnlockFacade.dontcheckTaskUnlockScene = nil

				return {
					transitionScene = true
				}
			end
		end
	end
end

return StoryConst
