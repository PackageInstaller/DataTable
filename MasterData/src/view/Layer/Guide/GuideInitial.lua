local var_0_0 = {}
local var_0_1 = "video/pv_B0.mp4"
local var_0_2 = 100001

require("view.Layer.TalkLayer")
require("view.Layer.VideoPlayerLayer")
require("view.Layer.AskForGuideLayer")

local FightEventManager = require("fight.FightEventManager")
local audio_manager = require("controller.audio_manager")
local GuideListener = require("view.Layer.Guide.GuideListener")

function var_0_0:onStart()
	FightManager.pauseBattleField()
	self:triggerTalk()
end

function var_0_0.playStartPV(arg_2_0)
	local var_2_0 = cc.LayerColor:create(cc.c4b(0, 0, 0, 255), 640, 1136)

	var_2_0:setAnchorPoint(cc.p(0, 0))
	var_2_0:setPosition(cc.p(0, 0))
	global_basic_scene:addChild(var_2_0, ZORDER_TALKLAYER - 1)

	local var_2_1 = audio_manager.music_volume

	audio_manager.music_volume = 0

	audio_manager:setMusicVolume()

	local var_2_2 = VideoPlayerLayer:create(var_0_1, true)

	global_basic_scene:addChild(var_2_2, ZORDER_TALKLAYER)

	local var_2_3 = false

	local function var_2_4()
		if var_2_3 then
			return
		end

		var_2_3 = true

		var_2_2:runAction(cc.RemoveSelf:create())
		var_2_0:runAction(cc.RemoveSelf:create())

		audio_manager.music_volume = var_2_1

		audio_manager:setMusicVolume()
		arg_2_0:triggerTalk()
	end

	var_2_2:registerEventHandler(3, var_2_4)
	var_2_2:registerEventHandler(2, var_2_4)
	var_2_2:play()
end

function var_0_0:triggerTalk()
	if var_0_2 then
		global_basic_scene:addChild(TalkLayer:create(var_0_2, nil, TALK_TYPE_BEFORE_BOSS, "", function()
			self:guideEnd()
		end), ZORDER_TALKLAYER)
	else
		self:guideEnd()
	end
end

function var_0_0.guideEnd(arg_6_0)
	local playermodel = require("model.playermodel")

	local function var_6_1()
		FightManager.resumeBattleField()
		playermodel:setPlayerGuide(-2)
		FightEventManager:triggerFightEventListener(FIGHT_LISTENER_ON_JOINCHAPTER, function()
			LayerManager:updateGuidesOnSwitchLayer()
		end)
	end

	if require("controller.account_manager"):getAccountPlayerRealCount() <= 1 then
		var_6_1()
	else
		local var_6_2 = AskForGuideLayer:create()

		global_basic_scene:addChild(var_6_2, ZORDER_TALKLAYER)
		var_6_2:addNewPlayerTouchListener(function(arg_9_0, arg_9_1)
			if arg_9_1 ~= ccui.TouchEventType.ended then
				return
			end

			arg_9_0:setBright(false)

			playermodel.is_new_player_guide = true

			var_6_2:runAction(cc.RemoveSelf:create())
			var_6_1()
			AnalyticManager.player_select_guide({
				guideType = "new_player"
			})
		end)
		var_6_2:addOldPlayerTouchListener(function(arg_10_0, arg_10_1)
			if arg_10_1 ~= ccui.TouchEventType.ended then
				return
			end

			require("network.network"):rpc("set_old_player_guide", {}, function(arg_11_0)
				arg_10_0:setBright(false)

				if arg_11_0.result == 1 then
					playermodel.is_new_player_guide = false

					var_6_2:runAction(cc.RemoveSelf:create())
					var_6_1()
					GuideListener.removeNewPlayerGuide()
					AnalyticManager.player_select_guide({
						guideType = "old_player"
					})
				end
			end)
		end)
	end
end

return var_0_0
