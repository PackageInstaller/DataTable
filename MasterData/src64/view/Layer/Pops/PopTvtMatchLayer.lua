PopTvtMatchLayer = class("PopTvtMatchLayer", function()
	return PopBaseLayer:create()
end)

require("view.Sprite.TvTRankSprite")
require("view.Sprite.AvatarSprite")

local armature_manager = require("controller.armature_manager")
local arenatft_manager = require("controller.arenatft_manager")
local audio_manager = require("controller.audio_manager")
local item_data = require("data.item_data")
local var_0_5 = 1
local var_0_6 = 2
local var_0_7 = {
	"equipment/medal1.png",
	"equipment/medal2.png",
	"equipment/medal3.png",
	"equipment/medal4.png",
	"equipment/medal5.png",
	"equipment/medal6.png"
}
local var_0_8 = {
	cc.c4b(240, 240, 240, 150),
	cc.c4b(54, 255, 82, 150),
	cc.c4b(56, 122, 255, 150),
	cc.c4b(255, 12, 246, 150),
	cc.c4b(255, 84, 0, 150),
	cc.c4b(255, 0, 0, 150)
}
local var_0_9

function PopTvtMatchLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopTvtMatchLayer.new()

	var_2_0:initBg(arg_2_1)

	return var_2_0
end

function PopTvtMatchLayer:init(arg_3_1)
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "PopTvtMatchLayer.json" or "PopTvtMatchLayer.ExportJson")

	self.rootLayer:setTouchEnabled(false)
	self:addChild(self.rootLayer)

	self.stat = var_0_5
	var_0_9 = self

	self:initTouchEventListener()
	self:startMatching()
	self:playMatchAni()
	audio_manager:playeffectMusicTest("sound/daijizhong")
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" then
			var_0_9 = nil

			arenatft_manager:setLayerState(nil)

			if arg_3_1 and arg_3_1.callback then
				arg_3_1.callback()
			end
		end
	end)
end

function PopTvtMatchLayer:initTouchEventListener()
	self:getChildByName("layer"):addTouchEventListener(function(arg_6_0, arg_6_1)
		if arg_6_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.stat == var_0_5 then
			if not self.anicomplete then
				return
			end

			self.fightAni:removeFromParent()
			self:showEnemyInfosEffect()

			self.stat = var_0_6
		end
	end)
end

function PopTvtMatchLayer.startMatching(arg_7_0)
	arenatft_manager:arenatft_match_enemy(function(arg_8_0)
		if not var_0_9 then
			return
		end

		if arg_8_0.result == 1 then
			arg_7_0:updateEnemyUI()

			return
		end

		if arg_8_0.result == 2 then
			global_ShowBlockWords(L_TVT_MATCH_ENEMY_TIMES)
		elseif arg_8_0.result == 3 then
			global_ShowBlockWords(L_TVT_MATCH_ENEMY_TIMES)
		elseif arg_8_0.result == 4 then
			global_ShowBlockWords(L_TVT_DEFENCE_ARRAY)
		end

		LayerManager:removePopLayer(arg_7_0.__queueindex)
	end)
end

function PopTvtMatchLayer:playMatchAni()
	self.fightAni = armature_manager:createAndPlayArmature("TVTMatchAnim")

	self.rootLayer:addChild(self.fightAni)
	self:runAction(cc.Sequence:create(cc.DelayTime:create(3.2), cc.CallFunc:create(function()
		self.anicomplete = true

		if self.stat == var_0_5 then
			if not self.anicomplete then
				return
			end

			self.fightAni:removeFromParent()
			self:showEnemyInfosEffect()

			self.stat = var_0_6

			audio_manager:playeffectMusicTest("sound/daijichenggong")
			self:checkAutoFight()
		end
	end)))
end

function PopTvtMatchLayer:updateEnemyUI()
	local var_11_0 = arenatft_manager:getEnemyInfo()
	local var_11_1 = self.rootLayer:getChildByName("succ_panel")
	local var_11_2 = var_11_1:getChildByName("enemy_panel")

	var_11_2:getChildByName("lbl_name"):setString(var_11_0.name)
	var_11_2:getChildByName("lbl_lv"):setString(var_11_0.level or 100)

	local var_11_3 = AvatarSprite:create(var_11_0.head_sculpture)

	var_11_3:setScale(0.7)
	var_11_3:setPosition(cc.p(40, 100))
	var_11_2:addChild(var_11_3)

	local var_11_4 = TvTRankSprite:create(var_11_0.score)

	var_11_4:setPosition(cc.p(290, 42))
	var_11_2:addChild(var_11_4)

	local var_11_5 = {}

	var_11_5[1] = var_11_0.medal_1 or 0
	var_11_5[2] = var_11_0.medal_2 or 0
	var_11_5[3] = var_11_0.medal_3 or 0

	for iter_11_0 = 1, 3 do
		local var_11_6 = item_data[var_11_5[iter_11_0]] or item_data[9100011]
		local var_11_7 = ccui.ImageView:create((var_11_6.bg or nil) and ("equipment/" .. var_11_6.bg .. ".png" or var_0_7[var_11_6.equip_quality]))

		var_11_7:setName("medal_" .. iter_11_0)
		var_11_7:setScale(0.7)
		var_11_7:setPosition(cc.p(380 + 60 * iter_11_0, 150))
		var_11_2:addChild(var_11_7)

		if var_11_5[iter_11_0] == 0 then
			var_11_7:setVisible(false)
		else
			var_11_7:setVisible(true)

			if not var_11_7:getChildByName("medalname") then
				local var_11_8 = cc.Label:createWithTTF("", FONT_DES, 54)

				var_11_8:setAnchorPoint(cc.p(0.5, 0.5))
				var_11_8:setPosition(cc.p(var_11_7:getContentSize().width / 2 + 5, var_11_7:getContentSize().height / 2 - 3))
				var_11_8:setName("medalname")
				var_11_7:addChild(var_11_8)
			end

			var_11_7:getChildByName("medalname"):setString(var_11_6.name)
			var_11_7:getChildByName("medalname"):enableOutline(var_0_8[var_11_6.equip_quality], 1)
			var_11_7:getChildByName("medalname"):enableShadow(var_0_8[var_11_6.equip_quality], cc.size(0, 0))
		end
	end

	var_11_1:getChildByName("Button_38"):addTouchEventListener(function(arg_12_0, arg_12_1)
		if arg_12_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:startTvtFight()
	end)
	var_11_1:getChildByName("Button_37"):addTouchEventListener(function(arg_13_0, arg_13_1)
		if arg_13_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:exit()
	end)
end

function PopTvtMatchLayer.startTvtFight(arg_14_0)
	arenatft_manager:get_enemy_defence_array(function(arg_15_0)
		if arg_15_0.result == 1 then
			arenatft_manager:setLayerState(CONFIG_TYPE_TVT_ATTACK_FORM)
			LayerManager:removePopLayer(arg_14_0.__queueindex)
			require("controller.formation.formation_manager"):getInstance():pushFormationLayer("Formation3V3Layer", {
				enemy_fight_info = arg_15_0.fightinfo,
				enemy_arrays = arg_15_0.arrays,
				configtype = CONFIG_TYPE_TVT_ATTACK_FORM,
				configcallback = function()
					return
				end
			})
		end
	end)
end

function PopTvtMatchLayer:showEnemyInfosEffect()
	local var_17_0 = self.rootLayer:getChildByName("succ_panel")
	local var_17_1 = var_17_0:getChildByName("enemy_panel")
	local var_17_2 = var_17_0:getChildByName("titie_img")
	local var_17_3 = var_17_0:getChildByName("Button_38")
	local var_17_4 = var_17_0:getChildByName("Button_37")

	var_17_2:setOpacity(0)
	var_17_3:setOpacity(0)
	var_17_4:setOpacity(0)
	var_17_1:setOpacity(0)
	var_17_1:setScaleX(0.1)
	var_17_0:setVisible(true)
	var_17_1:runAction(cc.Spawn:create(cc.ScaleTo:create(0.2, 1, 1), cc.FadeIn:create(0.1)))
	var_17_2:runAction(cc.Sequence:create(cc.DelayTime:create(0.2), cc.FadeIn:create(0.1)))
	var_17_3:runAction(cc.Sequence:create(cc.DelayTime:create(0.2), cc.FadeIn:create(0.1)))
	var_17_4:runAction(cc.Sequence:create(cc.DelayTime:create(0.2), cc.FadeIn:create(0.1)))
end

function PopTvtMatchLayer.exit(arg_18_0)
	local var_18_0 = {
		surecallback = function()
			arenatft_manager:setLayerBtnLock(false)
			arenatft_manager:giveup_match_enemy(function()
				LayerManager:switchShowLayer("ThreeVsThreeLayer")
				LayerManager:removePopLayer(arg_18_0.__queueindex)
			end)
		end
	}
	local var_18_1 = {
		title = L_TVT_EIXT_TITLE
	}

	var_18_1.des = arenatft_manager:isPlayerCanRefuse() and string.format(L_TVT_EIXT_CONFIRM_1, (arenatft_manager:getRemainRefuseTime())) or L_TVT_EIXT_CONFIRM_2
	var_18_0.labels = var_18_1

	LayerManager:pushInLayer("PopDoLayer", var_18_0)
end

function PopTvtMatchLayer:initBg(arg_21_1)
	local var_21_0 = ccui.Layout:create()

	var_21_0:setTouchEnabled(true)
	var_21_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_21_0:setAnchorPoint(cc.p(0, 0))
	var_21_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_21_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_21_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_21_0:setName("layer")
	var_21_0:setOpacity(0)
	self:addChild(var_21_0, -1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_22_0)
		self:addChild(arg_22_0, -2)
		arg_22_0:setPositionY(arg_22_0:getPositionY() - GameDisplay.fix_y)

		local var_22_0 = ccui.ImageView:create("mainScenebg/blur_mask.png")

		var_22_0:setAnchorPoint(cc.p(0, 0))
		var_22_0:setPositionY(-GameDisplay.fix_y)
		self:addChild(var_22_0, -1)
		self:init(arg_21_1)
		var_21_0:setOpacity(102)
	end)
end

function PopTvtMatchLayer.checkAutoFight(arg_23_0)
	if RoleDefault:getInstance():getBoolForKey("TvtAutoFight", false) then
		global_count_down_layer(4, function()
			arg_23_0:startTvtFight()
		end, function()
			RoleDefault:getInstance():setBoolForKey("TvtAutoFight", false)
		end)
	end
end
