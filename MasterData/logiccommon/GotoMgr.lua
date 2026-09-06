-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/util/GotoMgr.lua

module("logiccommon.common.util.GotoMgr", package.seeall)

local GotoMgr = class("GotoMgr")

GotoMgr._procFuncs = {
	ui = function(name, ...)
		if name == "mainui" then
			UIStateManager.instance:clear(true)
		else
			FuncOpenController.instance:openFuncByViewName(name, ...)
		end
	end,
	petshowview = function(name)
		FuncOpenController.instance:openFuncByViewName("petshowview", name)
	end,
	infinfulevelsview = function(actId, viewName)
		InfinitefutureController.instance:checkOpenLevelView(actId, viewName)
	end,
	infinfu2npc = function(npcId)
		InfinitefutureController.instance:sceneGotoNPC(npcId)
	end,
	scene = function(sceneId)
		SceneFacade.instance:enterCityFromThisScene(checknumber(sceneId))
	end,
	npc = function(npcId)
		UIStateManager.instance:clear()

		npcId = checknumber(npcId)

		TaskController.instance:foreceClearState()
		TaskController.instance:gotoNpc(npcId)
	end,
	event = function(eventName, ...)
		local param = ...
		local para

		GlobalDispatcher:dispatch(eventName, (param or nil) and {
			...
		})
	end,
	func = function(id, ...)
		local param = ...
		local args

		if param then
			args = {
				...
			}
		end

		print("click func = " .. id)

		if args then
			FuncOpenController.instance:openFunc(id, unpack(args))
		else
			FuncOpenController.instance:openFunc(id)
		end
	end,
	fb = function(chapterId, stageId)
		PlotCopyController.instance:enterStateView(checknumber(chapterId), checknumber(stageId))
	end,
	fb_res = function(chapterId, stageId)
		MaterialChallengeController.instance:enterStageView(checknumber(chapterId), checknumber(stageId))
	end,
	ch_npc = function(npcId)
		GotoMgr._dealWith_ch_npc(npcId)
	end,
	catch = function(monsterId)
		monsterId = checknumber(monsterId)

		TaskController.instance:foreceClearState()
		UIStateManager.instance:clear(true)
		TaskController.instance:gotoMonster(monsterId)
	end,
	chapter = function(chapterId)
		PlotCopyController.instance:enterCopy(checknumber(chapterId))
	end,
	reschapter = function(chapterId)
		MaterialChallengeController.instance:enterChapterView(checknumber(chapterId))
	end,
	kt_npc = function(npcId)
		npcId = checknumber(npcId)

		TaskController.instance:foreceClearState()

		local mainPlayer = SceneMainPlayer.instance:getMainPlayer()

		if mainPlayer then
			mainPlayer:gotoNpcCrossScene(npcId)
		end
	end,
	zz_npc = function(npcId)
		npcId = checknumber(npcId)

		local mainPlayer = SceneMainPlayer.instance:getMainPlayer()

		TaskController.instance:foreceClearState()

		if mainPlayer then
			mainPlayer:gotoNpcCrossSceneWithFullScenePath(npcId)
		end
	end,
	url = function(url)
		UnityEngine.Application.OpenURL(url)
	end,
	mibao = function(...)
		FuncOpenController.instance:openFunc(95, ...)
	end,
	goodid = function(goodId)
		PayShopController.instance:buyShopItemWithTips(goodId)
	end,
	legend = function(challengeId, npcId)
		GotoMgr._dealWithLegend(challengeId, npcId)
	end,
	share_npc = function(para)
		ShareTaskModel.instance:GotoNpcCrossScene()
	end,
	itemsource = function(para)
		MaterialMgr.openGetSourceByStr(para)
	end,
	report_behavior = function(...)
		local param = ...
		local args

		if param then
			args = {
				...
			}
		end

		if args then
			SurveyController.instance:reportBehavior(unpack(args))
		end
	end,
	new_mission = function(moName, ...)
		local param = ...
		local custom
		local cls = CustomFmtController.instance:getMoName(moName)

		if cls then
			custom = cls.New()

			if param then
				custom:initParams(param)
			end

			CustomFmtController.instance:showMissionView(custom)
		end
	end,
	preview_battle = function(...)
		local param = ...
		local args

		if param then
			args = {
				...
			}
		end

		if args then
			PetbookController.instance:previewBattle(unpack(args))
		end
	end,
	push_story = function(storyId, storyType)
		storyId = checknumber(storyId)
		storyType = checknumber(storyType)

		if storyType == 0 then
			storyType = StoryModel.StoryType.MainTask
		end

		GlobalDispatcher:dispatch(GlobalNotify.PushStory, storyId, storyType)
	end,
	C_MJ_hand = function(activityId, ...)
		activityId = checknumber(activityId)

		local param = ...

		MahjongBattleController.instance:gmCoverHand(checknumber(activityId), (param or nil) and {
			...
		})
	end,
	C_MJ_system = function(activityId, ...)
		activityId = checknumber(activityId)

		local param = ...

		MahjongBattleController.instance:gmCoverSystemCard(checknumber(activityId), (param or nil) and {
			...
		})
	end
}

function GotoMgr._dealWith_ch_npc(npcId)
	npcId = checknumber(npcId)

	local challengeId = UnlockConfig.instance:getNpcChallenge(npcId)
	local challengeCfg

	if checknumber(challengeId) > 0 then
		challengeCfg = ChallengeConfig.instance:getChallengeCfg(challengeId)
	end

	if not challengeCfg or MofangModel.instance:getCurLv() >= checknumber(challengeCfg.mofangLv) then
		TaskController.instance:foreceClearState()
		UIStateManager.instance:clear(true)
		TaskController.instance:gotoNpc(npcId)
	else
		local tips = string.format("<color=#3260c9>[%s]</color>将在\n<color=#e58a29>人物等级</color>达到<color=#e58a29>%s</color>级后解锁", challengeCfg.name, checknumber(challengeCfg.mofangLv))

		UIStateManager.instance:open(ViewName.SceneUnlockView, tips)
	end
end

function GotoMgr._dealWithLegend(challengeId, npcId)
	if LegendController.instance:dealWithLegend(checknumber(challengeId)) then
		return
	end

	GotoMgr._dealWith_ch_npc(npcId)
end

function GotoMgr.gotoByString(str, mo)
	if not string.nilorempty(str) then
		print("str = " .. str)

		GotoMgr.curItemMo = mo

		if mo then
			print(">>>&&&&&&&&&&&&&&&&&&&&&&&&&&& <color='#ff00ff'>记录了物品</color>", mo.type .. ":" .. mo.id)
		end

		local list = string.split(str, "&&")

		for i, v in ipairs(list) do
			local params = string.split(v, "#")
			local key = table.remove(params, 1)

			GotoMgr.callGotoFunction(key, params)
		end
	else
		printError(">>>>>>> GotoMgr.gotoByString: str is nil")
	end
end

function GotoMgr.callGotoFunction(key, params)
	if SceneMgr.instance.isGogingToEnterBattleScene then
		FloatWordMgr.instance:show(lang("当前场景暂时不能进行此操作"))
	elseif GotoMgr._procFuncs[key] then
		GotoMgr._procFuncs[key](unpack(params))
	end
end

function GotoMgr.gotoOnlyFuncCtrl(str)
	local params = string.split(str, "#")
	local key = table.remove(params, 1)

	if key == "func" then
		error(">>>>>>>   功能开启表配置错误，jumpTo 不能配置 :" .. str)
	else
		GotoMgr.callGotoFunction(key, params)
	end
end

return GotoMgr
