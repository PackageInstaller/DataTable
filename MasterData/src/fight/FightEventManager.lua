local var_0_0 = {}
local var_0_2 = 2
local var_0_3 = 3

FIGHT_LISTENER_ON_REFRESH = 0
FIGHT_LISTENER_ON_START = 1
FIGHT_LISTENER_ON_END = 2
FIGHT_LISTENER_ON_SUCCESS = 3
FIGHT_LISTENER_ON_FAIL = 4
FIGHT_LISTENER_ON_PASSLEVEL = 5
FIGHT_LISTENER_ON_BOSSFIGHTSTART = 6
FIGHT_LISTENER_ON_HP = 7
FIGHT_LISTENER_ON_JOINLEVEL = 8
FIGHT_LISTENER_ON_JOINCHAPTER = 9
FIGHT_LISTENER_ON_ADVENTURE_PASSLEVEL = 10

local var_0_4 = false
local playermodel = require("model.playermodel")
local level_manager = require("controller.level_manager")
local conversation_class_data = require("data.conversation_class_data")
local role_conversation_data = require("data.role_conversation_data")
local script_class_data = require("data.script_class_data")
local chapter_data = require("data.chapter_data")
local levelmode_data = require("data.levelmode_data")

require("view.Layer.TalkLayer")

local function var_0_12(arg_15_0)
	if LayerManager:getCurrentLayerName() ~= "FightLayer" then
		if arg_15_0 then
			arg_15_0()
		end

		return
	end

	local var_15_0 = level_manager.getCurLevelData(playermodel.curMode, playermodel.curLevel).classification

	if var_15_0 and script_class_data[var_15_0] then
		local function var_15_1()
			FightManager.resumeBattleField()

			if arg_15_0 then
				arg_15_0()
			end
		end

		if script_class_data[var_15_0].classtype == var_0_3 then
			FightManager.pauseBattleField()
			FightLayer.getInstance():addTheaterLayer(var_15_0, var_15_1)
		elseif script_class_data[var_15_0].classtype == var_0_2 then
			FightManager.pauseBattleField()
			global_basic_scene:addChild(TalkLayer:create(var_15_0, nil, script_class_data[var_15_0].talktype or TALK_TYPE_BEFORE_BOSS, "", var_15_1, 1), ZORDER_TALKLAYER)
		end
	elseif arg_15_0 then
		arg_15_0()
	end
end

local var_0_13 = {
	[FIGHT_LISTENER_ON_REFRESH] = function()
		if var_0_4 then
			TextureManager:removeUnusedSpineTextures()

			var_0_4 = false
		end
	end,
	[FIGHT_LISTENER_ON_START] = function(...)
		return
	end,
	[FIGHT_LISTENER_ON_END] = function(...)
		return
	end,
	[FIGHT_LISTENER_ON_SUCCESS] = function()
		if math.random(10) > 4 then
			return
		end

		require("view.Sprite.TalkSprite")

		local var_4_0 = {}

		for iter_4_0, iter_4_1 in pairs(FightManager.players) do
			if iter_4_1._instance and iter_4_1:getStatus() ~= STATUS_DIED and iter_4_1:getAttribute("classtype") == 1 then
				table.insert(var_4_0, iter_4_1)
			end
		end

		if #var_4_0 <= 0 then
			return
		end

		local var_4_2 = var_4_0[#var_4_0 == 1 and 1 or math.random(#var_4_0)]
		local var_4_3 = GenerateRoleConversationClass(var_4_2:getAttribute("modelid"), ROLE_CONVERSATION_TYPE.win)

		if not var_4_3 then
			return
		end

		local var_4_4 = var_4_3 * 100 + 1

		if not role_conversation_data[var_4_3 * 100 + 1] then
			return
		end

		local var_4_5 = role_conversation_data[var_4_4].dec

		if var_4_2:getChildByName("TalkSprite") then
			var_4_2:getChildByName("TalkSprite"):touchDisappear()
		end

		local var_4_6 = TalkSprite:create(var_4_5, (var_4_2:getAttribute("model_height") + var_4_2:getRootOffsetY()) * STANDARD_SCALE * var_4_2:getAttribute("model_scale") + HPBAR_HEIGHT + 30)

		var_4_6:setName("TalkSprite")
		var_4_2:addChild(var_4_6)
	end,
	[FIGHT_LISTENER_ON_FAIL] = function(arg_5_0)
		if LayerManager:getCurrentLayerName() ~= "FightLayer" then
			if arg_5_0 then
				arg_5_0()
			end

			return
		end

		local var_5_0 = level_manager.getCurLevelData(playermodel.curMode, playermodel.curLevel).classificationfail

		if var_5_0 and script_class_data[var_5_0] then
			local function var_5_1()
				FightManager.resumeBattleField()
			end

			if script_class_data[var_5_0].classtype == var_0_3 then
				FightManager.pauseBattleField()
				FightLayer.getInstance():addTheaterLayer(var_5_0, var_5_1)
			elseif script_class_data[var_5_0].classtype == var_0_2 then
				FightManager.pauseBattleField()
				global_basic_scene:addChild(TalkLayer:create(var_5_0, nil, script_class_data[var_5_0].talktype or TALK_TYPE_BEFORE_BOSS, "", var_5_1, 1), ZORDER_TALKLAYER)
			end
		elseif arg_5_0 then
			arg_5_0()
		end
	end,
	[FIGHT_LISTENER_ON_PASSLEVEL] = function(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
		local var_7_0 = level_manager.getCurLevelData(arg_7_0, arg_7_1).classificationsuccess

		local function var_7_1()
			local autopop_manager = require("controller.autopop_manager")

			if autopop_manager:getNewRoleQueueIsEmpty() then
				autopop_manager:resumeAchievementPop()
			else
				autopop_manager:popGetNewRoleQueue(function(...)
					autopop_manager:resumeAchievementPop()
				end)
			end
		end

		if var_7_0 and script_class_data[var_7_0] then
			if LayerManager:getCurrentLayerName() ~= "FightLayer" then
				return
			end

			local function var_7_2()
				FightManager.resumeBattleField(FightManager.FightStatus == FIGHTSTATUS_NEXT)
				var_7_1()
			end

			if script_class_data[var_7_0].classtype == var_0_3 then
				FightManager.pauseBattleField()
				FightLayer.getInstance():addTheaterLayer(var_7_0, var_7_2, true)
			elseif script_class_data[var_7_0].classtype == var_0_2 then
				FightManager.pauseBattleField()
				global_basic_scene:addChild(TalkLayer:create(var_7_0, nil, script_class_data[var_7_0].talktype or TALK_TYPE_BEFORE_BOSS, "", var_7_2, 1), ZORDER_TALKLAYER)
			end
		elseif level_manager:isChapterComplete() then
			if LayerManager:getCurrentLayerName() ~= "FightLayer" then
				arg_7_2.playcallback(arg_7_3)
				var_7_1()

				return
			end

			local var_7_3 = chapter_data[arg_7_0 .. "-" .. level_manager:getCurChapter(arg_7_0)].passbigbossclassification

			if var_7_3 and script_class_data[var_7_3] then
				local function var_7_4()
					FightManager.resumeBattleField()
					arg_7_2.playcallback(arg_7_3)
					var_7_1()
				end

				if script_class_data[var_7_3].classtype == var_0_3 then
					FightManager.pauseBattleField()
					FightLayer.getInstance():addTheaterLayer(var_7_3, var_7_4)
				elseif script_class_data[var_7_3].classtype == var_0_2 then
					FightManager.pauseBattleField()
					global_basic_scene:addChild(TalkLayer:create(var_7_3, nil, script_class_data[var_7_3].talktype or TALK_TYPE_BEFORE_BOSS, "", var_7_4, 1), ZORDER_TALKLAYER)
				end
			else
				var_7_1()

				if arg_7_4 then
					arg_7_2.playcallback(arg_7_3, arg_7_2.continuecallback)
				else
					arg_7_2.playcallback(arg_7_3)
				end
			end
		else
			var_7_1()
		end
	end,
	[FIGHT_LISTENER_ON_BOSSFIGHTSTART] = function(arg_13_0)
		if LayerManager:getCurrentLayerName() ~= "FightLayer" then
			if arg_13_0 then
				arg_13_0()
			end

			return
		end

		local var_13_0 = playermodel.curMode
		local var_13_1 = level_manager:getCurChapter(playermodel.curMode)

		if var_13_1 <= RoleDefault:getInstance():getIntegerForKey("beforebosstalk" .. playermodel.curMode, 0) then
			if arg_13_0 then
				arg_13_0()
			end

			return
		end

		local var_13_2 = chapter_data[var_13_0 .. "-" .. var_13_1].bigbossclassification

		if chapter_data[var_13_0 .. "-" .. var_13_1].bigbossclassification and script_class_data[var_13_2] then
			local function var_13_3()
				RoleDefault:getInstance():setIntegerForKey("beforebosstalk" .. var_13_0, var_13_1)
				FightManager.resumeBattleField()

				if arg_13_0 then
					arg_13_0()
				end
			end

			if script_class_data[var_13_2].classtype == var_0_3 then
				FightManager.pauseBattleField()
				FightLayer.getInstance():addTheaterLayer(var_13_2, var_13_3)
			elseif script_class_data[var_13_2].classtype == var_0_2 then
				FightManager.pauseBattleField()
				global_basic_scene:addChild(TalkLayer:create(var_13_2, nil, script_class_data[var_13_2].talktype or TALK_TYPE_BEFORE_BOSS, "", var_13_3, 1), ZORDER_TALKLAYER)
			end
		elseif arg_13_0 then
			arg_13_0()
		end
	end,
	[FIGHT_LISTENER_ON_HP] = function(...)
		return
	end,
	[FIGHT_LISTENER_ON_JOINLEVEL] = var_0_12,
	[FIGHT_LISTENER_ON_JOINCHAPTER] = function(arg_17_0)
		local var_17_0 = chapter_data[playermodel.curMode .. "-" .. level_manager:getCurChapter(playermodel.curMode)].classification

		if var_17_0 then
			local function var_17_1()
				FightManager.resumeBattleField()

				if arg_17_0 then
					arg_17_0()
				end
			end

			FightManager.pauseBattleField()
			global_basic_scene:addChild(TalkLayer:create(var_17_0, nil, TALK_TYPE_BEFORE_BOSS, "", function()
				var_0_12(var_17_1)
			end, 1), ZORDER_TALKLAYER)
		else
			var_0_12(arg_17_0)
		end
	end,
	[FIGHT_LISTENER_ON_ADVENTURE_PASSLEVEL] = function(arg_20_0)
		local var_20_0 = level_manager:getChapterCanUnlock(playermodel.curMode) - 1

		if not chapter_data[playermodel.curMode .. "-" .. var_20_0] then
			arg_20_0(iscontinue)

			return
		end

		local var_20_1 = chapter_data[playermodel.curMode .. "-" .. var_20_0].passbigbossclassification

		print(">>>>>>>>>>>", playermodel.curMode, var_20_0, chapter_data[playermodel.curMode .. "-" .. var_20_0].passbigbossclassification)

		if var_20_1 and script_class_data[var_20_1] then
			local function var_20_2()
				FightManager.resumeBattleField()
				arg_20_0(iscontinue)
			end

			if script_class_data[var_20_1].classtype == var_0_3 then
				FightManager.pauseBattleField()
				FightLayer.getInstance():addTheaterLayer(var_20_1, var_20_2)
			elseif script_class_data[var_20_1].classtype == var_0_2 then
				FightManager.pauseBattleField()
				global_basic_scene:addChild(TalkLayer:create(var_20_1, nil, script_class_data[var_20_1].talktype or TALK_TYPE_BEFORE_BOSS, "", var_20_2, 1), ZORDER_TALKLAYER)
			end
		else
			arg_20_0(iscontinue)
		end
	end
}

function var_0_0.triggerFightEventListener(arg_22_0, arg_22_1, ...)
	var_0_13[arg_22_1](...)
end

function var_0_0.registerCleanSpineTextures(arg_23_0)
	var_0_4 = true
end

return var_0_0
