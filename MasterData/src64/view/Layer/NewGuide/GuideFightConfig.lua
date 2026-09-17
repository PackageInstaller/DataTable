local var_0_0
local var_0_1
local var_0_2
local var_0_3
local var_0_4 = "video/pv_B0.mp4"
local var_0_5 = {
	"fightbg5_1",
	"fightbg5_2",
	"fightbg5_3"
}
local var_0_6 = config._DEBUG and 0 or 1
local var_0_7 = {
	{
		soulid = 1,
		servantid = 22120,
		contract = 0,
		science_point = 1600,
		uiconfig = {
			pos = -100,
			offset = -40
		}
	},
	{
		soulid = 2,
		servantid = 21204,
		contract = 0,
		science_point = 1500,
		uiconfig = {
			pos = -220,
			offset = 10
		}
	},
	{
		soulid = 3,
		servantid = 21920,
		contract = 0,
		science_point = 1680,
		uiconfig = {
			pos = -260,
			offset = -30
		}
	},
	{
		soulid = 4,
		servantid = 20100,
		contract = 0,
		science_point = 1800,
		uiconfig = {
			pos = -50,
			offset = 10
		}
	}
}
local var_0_8 = {
	{
		soulid = 1,
		servantid = 30100,
		contract = 0,
		science_point = 800,
		uiconfig = {
			pos = 1000,
			offset = -40
		}
	},
	{
		soulid = 2,
		servantid = 30100,
		contract = 0,
		science_point = 800,
		uiconfig = {
			pos = 1000,
			offset = 40
		}
	},
	{
		soulid = 3,
		servantid = 42000,
		contract = 0,
		science_point = 400,
		uiconfig = {
			pos = 3000,
			offset = 0
		}
	}
}
local item_data = require("data.item_data")
local major_factor_data = require("data.major_factor_data")
local servant_data = require("data.servant_data")

require("view.Layer.TalkLayer")
require("view.Layer.VideoPlayerLayer")

local FightEventManager = require("fight.FightEventManager")
local audio_manager = require("controller.audio_manager")

local function var_0_14(arg_1_0)
	local var_1_0 = {
		majorlist = {
			science_point = arg_1_0.science_point,
			servantid = arg_1_0.servantid,
			soulid = arg_1_0.soulid,
			contract = arg_1_0.contract
		},
		component = arg_1_0.component,
		horcrux = arg_1_0.horcrux
	}

	if arg_1_0.weapon then
		var_1_0.weapon = {
			itemid = arg_1_0.weapon.itemid,
			weapon_attr = {
				exp = arg_1_0.weapon.exp,
				level = arg_1_0.weapon.level,
				nowStars = arg_1_0.weapon.nowStars
			}
		}
	end

	var_1_0.pos = arg_1_0.uiconfig.pos
	var_1_0.offset = arg_1_0.uiconfig.offset

	return var_1_0
end

return {
	init = function(arg_2_0)
		arg_2_0.guide_use_xp = false
	end,
	haveGuideXP = function(self)
		return self.guide_use_xp
	end,
	getGuidePlayer = function(arg_4_0)
		local var_4_0 = {}

		for iter_4_0 = 1, #var_0_7 do
			var_4_0[iter_4_0] = var_0_14(var_0_7[iter_4_0])
		end

		return var_4_0
	end,
	getGuidePlayerConf = function(arg_5_0)
		local var_5_0 = {}

		for iter_5_0 = 1, 3 do
			local var_5_1 = var_0_7[iter_5_0].horcrux and var_0_7[iter_5_0].horcrux.itemid

			var_5_0[iter_5_0] = {
				modelid = servant_data[var_0_7[iter_5_0].servantid].modelid,
				horcrux = var_5_1
			}
		end

		return var_5_0
	end,
	getGuideEnemy = function(arg_6_0)
		local var_6_0 = {}

		for iter_6_0 = 1, #var_0_8 do
			var_6_0[iter_6_0] = var_0_14(var_0_8[iter_6_0])
		end

		return var_6_0
	end,
	getFightBg = function(arg_7_0)
		return var_0_5
	end,
	guideUseXP = function(arg_8_0, arg_8_1)
		arg_8_0.guide_use_xp = true

		FightManager.pauseBattleField()

		local var_8_0, var_8_1 = arg_8_1:getPosition()
		local var_8_2 = arg_8_1:getParent()
		local var_8_3 = var_8_2:convertToWorldSpace(cc.p(var_8_0, var_8_1))
		local var_8_4 = ccui.Button:create("public/text3_bg.png", "public/text3_bg.png", "public/text3_bg.png", var_0_6)

		var_8_4.setScale9Enabled(var_8_2, true)
		var_8_4:setContentSize(cc.size(640, 1136))
		var_8_4:setAnchorPoint(cc.p(0, 0))
		var_8_4:setOpacity(0)
		var_8_4:setCascadeOpacityEnabled(false)
		var_8_4:setSwallowTouches(false)
		global_basic_scene:addChild(var_8_4, 1000)
		var_8_4:addTouchEventListener(function(arg_9_0, arg_9_1)
			if arg_9_1 ~= ccui.TouchEventType.ended then
				return
			end

			FightManager.resumeBattleField()
			var_8_4:runAction(cc.RemoveSelf:create())
		end)
		require("view.Layer.Guide.GuideFinger")
		require("view.Layer.Guide.GuideClipping")

		local var_8_5 = arg_8_1:getBoundingBox()
		local var_8_6 = cc.rect(var_8_3.x - var_8_5.width / 2, var_8_3.y - var_8_5.height / 2, var_8_5.width, var_8_5.height)

		var_8_4:addChild(GuideClipping:create({
			pos = var_8_3,
			rect = var_8_6
		}, {
			alphathreshold = 1,
			resource = "FightLayer/bg_role_part1-3.png",
			pos = var_8_3,
			rect = var_8_6
		}, {
			pos = var_8_3,
			rect = var_8_6
		}), 1)
		var_8_4:addChild(GuideFinger:create(var_8_3, var_8_6, false), 5)
	end,
	onStartFight = function(self)
		FightManager.pauseBattleField()

		if DeviceManager.platform == "ios" or DeviceManager.platform == "android" then
			self:playStartPV()
		else
			self:triggerTalkBefore()
		end
	end,
	playStartPV = function(arg_11_0)
		local var_11_0 = cc.LayerColor:create(cc.c4b(0, 0, 0, 255), 640, 1136)

		var_11_0:setAnchorPoint(cc.p(0, 0))
		var_11_0:setPosition(cc.p(0, 0))
		global_basic_scene:addChild(var_11_0, ZORDER_TALKLAYER - 1)

		local var_11_1 = audio_manager.music_volume

		audio_manager.music_volume = 0

		audio_manager:setMusicVolume()

		local var_11_2 = VideoPlayerLayer:create(var_0_4, true)

		global_basic_scene:addChild(var_11_2, ZORDER_TALKLAYER)

		local function var_11_3()
			var_11_2:runAction(cc.RemoveSelf:create())
			var_11_0:runAction(cc.RemoveSelf:create())

			audio_manager.music_volume = var_11_1

			audio_manager:setMusicVolume()
			arg_11_0:triggerTalkBefore()
		end

		var_11_2:registerEventHandler(3, var_11_3)
		var_11_2:registerEventHandler(2, var_11_3)
		var_11_2:play()
	end,
	triggerTalkBefore = function(self)
		if var_0_2 then
			global_basic_scene:addChild(TalkLayer:create(var_0_2, nil, TALK_TYPE_BEFORE_BOSS, "", function()
				self:triggerTheaterBefore()
			end), ZORDER_TALKLAYER)
		else
			self:triggerTheaterBefore()
		end
	end,
	triggerTheaterBefore = function(arg_15_0)
		if var_0_0 then
			FightLayer.getInstance():addTheaterLayer(var_0_0, function()
				FightManager.resumeBattleField()
			end)
		else
			FightManager.resumeBattleField()
		end
	end,
	onEndFight = function(self)
		self:triggerTheaterAfter()
	end,
	triggerTalkAfter = function(self)
		if var_0_3 then
			global_basic_scene:addChild(TalkLayer:create(var_0_3, nil, TALK_TYPE_BEFORE_BOSS, "", function()
				self:playEndPV()
			end), ZORDER_TALKLAYER)
		else
			self:playEndPV()
		end
	end,
	triggerTheaterAfter = function(self)
		if var_0_1 then
			FightManager.pauseBattleField()
			FightLayer.getInstance():addTheaterLayer(var_0_1, function()
				self:triggerTalkAfter()
			end)
		else
			FightManager.pauseBattleField()
			self:triggerTalkAfter()
		end
	end,
	playEndPV = function(arg_22_0)
		if PV_AFTER and (DeviceManager.platform == "ios" or DeviceManager.platform == "android") then
			local var_22_0 = cc.LayerColor:create(cc.c4b(0, 0, 0, 255), 640, 1136)

			var_22_0:setAnchorPoint(cc.p(0, 0))
			var_22_0:setPosition(cc.p(0, 0))
			global_basic_scene:addChild(var_22_0, ZORDER_TALKLAYER - 1)

			local var_22_1 = audio_manager.music_volume

			audio_manager.music_volume = 0

			audio_manager:setMusicVolume()

			local var_22_2 = VideoPlayerLayer:create(PV_AFTER, true)

			global_basic_scene:addChild(var_22_2, ZORDER_TALKLAYER)

			local function var_22_3()
				var_22_2:runAction(cc.RemoveSelf:create())
				var_22_0:runAction(cc.RemoveSelf:create())

				audio_manager.music_volume = var_22_1

				audio_manager:setMusicVolume()
				FightManager.resumeBattleField()
				ListButtonLayer.getInstance():showLayer()
				TopcostLayer.getInstance():showTopcostLayer()
				FightEventManager:triggerFightEventListener(FIGHT_LISTENER_ON_JOINCHAPTER)
			end

			var_22_2:registerEventHandler(3, var_22_3)
			var_22_2:registerEventHandler(2, var_22_3)
			var_22_2:play()
		else
			FightManager.resumeBattleField()
			ListButtonLayer.getInstance():showLayer()
			TopcostLayer.getInstance():showTopcostLayer()
			FightEventManager:triggerFightEventListener(FIGHT_LISTENER_ON_JOINCHAPTER)
		end
	end
}
