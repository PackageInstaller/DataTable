SubstitutionLayer = class("SubstitutionLayer", function()
	return cc.Layer:create()
end)

local playermodel = require("model.playermodel")
local photo_manager = require("controller.photo_manager")
local model_data = require("data.model_data")
local major_factor_data = require("data.major_factor_data")
local item_data = require("data.item_data")
local array_manager = require("controller.array_manager")
local level_manager = require("controller.level_manager")
local horcrux_manager = require("controller.horcrux_manager")
local var_0_8 = require("controller.formation.formation_manager"):getInstance()
local l2utils = require("controller.l2utils")
local servant_data = require("data.servant_data")
local levelmode_data = require("data.levelmode_data")
local total_skill_data = require("data.total_skill_data")
local chapter_data = require("data.chapter_data")
local var_0_14 = config._DEBUG and 0 or 1

require("view.Sprite.BottomBtnList")
require("view.Sprite.TitleSprite")

local substitution_manager = require("controller.substitution_manager")
local var_0_16
local var_0_19 = "NewSubstitutionLayer/"

local function var_0_20(arg_2_0)
	local var_2_0 = string.len(arg_2_0)
	local var_2_1
	local var_2_2 = 255

	if var_2_0 == 6 then
		var_2_1 = 1
	elseif var_2_0 == 7 then
		var_2_1 = 2
	else
		var_2_2 = (var_2_0 == 8 or var_2_0 == 9) and tonumber(string.sub(arg_2_0, var_2_0 - 1, var_2_0), 16) or var_2_2
	end

	if var_2_1 then
		return (cc.c4b(tonumber(string.sub(arg_2_0, var_2_1, var_2_1 + 1), 16) or 0, tonumber(string.sub(arg_2_0, var_2_1 + 2, var_2_1 + 3), 16) or 0, tonumber(string.sub(arg_2_0, var_2_1 + 4, var_2_1 + 5), 16) or 0, var_2_2))
	end
end

function SubstitutionLayer.create(arg_3_0, arg_3_1)
	local var_3_0 = SubstitutionLayer.new()

	var_3_0:init(arg_3_1)

	return var_3_0
end

function SubstitutionLayer.getInstance()
	return var_0_16
end

function SubstitutionLayer:getBossLevel()
	self.levelTbl = {}

	for iter_5_0 = 1, levelmode_data[self.mode].totalchapter do
		self.levelTbl[#self.levelTbl + 1] = level_manager.getCurMonsterData(self.mode, level_manager.getCurMonsterTeamData(self.mode, level_manager.getCurLevelData(self.mode, iter_5_0 .. "-1").boss_team).boss).level
	end
end

function SubstitutionLayer:getCurLevelFullBossHp(arg_6_1)
	return level_manager.getCurMonsterData(self.mode, level_manager.getCurMonsterTeamData(self.mode, level_manager.getCurLevelData(self.mode, arg_6_1 .. "-1").boss_team).boss).hp
end

function SubstitutionLayer:getBossList()
	self.bossInfo = {}

	table.insert(self.bossInfo, {
		modelid = level_manager.getCurMonsterData(self.mode, level_manager.getCurMonsterTeamData(self.mode, level_manager.getCurLevelData(self.mode, "1-1").boss_team).boss).modelid,
		mode = self.mode
	})
	print("self.bossInfo======", dump(self.bossInfo))
	self:setBossFight()
end

function SubstitutionLayer.moveAni(arg_8_0, arg_8_1, arg_8_2)
	arg_8_2:setVisible(true)

	if arg_8_1 == "left" then
		local var_8_0 = arg_8_2:getContentSize().width

		arg_8_2:setPositionX(arg_8_2:getPositionX() - var_8_0)
		arg_8_2:runAction(cc.MoveBy:create(0.4, cc.p(var_8_0, 0)))
	elseif arg_8_1 == "right" then
		local var_8_1 = arg_8_2:getContentSize().width

		arg_8_2:setPositionX(arg_8_2:getPositionX() + var_8_1)
		arg_8_2:runAction(cc.MoveBy:create(0.4, cc.p(-var_8_1, 0)))
	end
end

function SubstitutionLayer.showAni(arg_9_0, arg_9_1)
	arg_9_1:setVisible(true)
	arg_9_1:setOpacity(0)
	arg_9_1:runAction(cc.FadeIn:create(0.4))
end

function SubstitutionLayer:createAni()
	self:moveAni("right", self.level_select_title)
	self:moveAni("right", self.image_level_choice)
	self:moveAni("right", self.level_score_bg)
	self:moveAni("left", self.score_up_bg)
	self:moveAni("left", self.image_attr)
	self:moveAni("left", self.button_boss_photo)
	self:showAni(self.image_score_boss_bottom)
	self:showAni(self.panel_16)
	self:showAni(self.image_boss_shake)
	l2utils:shakeNode(self.image_boss_shake, {
		scanlinethreshold = 0.025,
		driftpixel = 0,
		waitframe = 0,
		shakeframe = 12,
		restoreframe = 12,
		scanlinedriftfac = 5
	})
	self:runAction(cc.Sequence:create(cc.DelayTime:create(0.4), cc.CallFunc:create(function()
		l2utils:removeNodeShake(self.image_boss_shake)
	end)))
end

function SubstitutionLayer.updateTime(arg_12_0, arg_12_1, arg_12_2)
	local var_12_5 = math.floor(arg_12_2 / 24 / 3600)
	local var_12_6 = math.floor((arg_12_2 - var_12_5 * 24 * 3600) / 3600)
	local var_12_7 = math.floor((arg_12_2 - var_12_5 * 24 * 3600 - var_12_6 * 3600) / 60)

	arg_12_1:setString(0 ~= 0 and string.format(L_TIME_TEXT[1], var_12_5, var_12_6) or var_12_6 ~= 0 and string.format(L_TIME_TEXT[2], var_12_6, var_12_7) or string.format(L_TIME_TEXT[3], var_12_7))
end

function SubstitutionLayer:initEndTime()
	if not self.endtime then
		self.remain_time_label:setVisible(false)
		self.remain_time:setVisible(false)

		return
	end

	self:updateTime(self.remain_time, self.endtime)
end

function SubstitutionLayer:init(arg_14_1)
	var_0_16 = self

	self:initUI()

	self.mode = arg_14_1.mode
	self.endtime = arg_14_1.endtime
	self.recommendRank = arg_14_1.recommendRank
	self.image_boss = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_boss")
	self.image_boss_shake = cc.Sprite:create()

	self.image_boss_shake:setScale(1)
	self.image_boss_shake:setPosition(cc.p(self.image_boss:getPositionX(), self.image_boss:getPositionY()))
	self.panel_16:addChild(self.image_boss_shake, 0)
	self.button_boss_photo:addTouchEventListener(function(arg_15_0, arg_15_1)
		local var_15_0

		if arg_15_1 ~= ccui.TouchEventType.ended then
			do return end

			var_15_0 = {
				id = model_data[self.modelid].photofile_model,
				modelid = self.modelid
			}
		end

		var_15_0.contentType = {
			contentType = photo_manager:getFileType(model_data[self.modelid].photofile_type)
		}

		if photo_manager:isBigPicture(model_data[self.modelid].photofile_type) then
			LayerManager:pushInLayer("PhotoFileRoleFileLayer", var_15_0)
		else
			LayerManager:pushInLayer("PhotoFileHelpGirlLayer", var_15_0)
		end
	end)
	substitution_manager:setEndTime(self.endtime)
	self:initResetBtn()
	self:initEndTime()
	self:getBossList()
	self:startFight()
	self:registerScriptHandler(function(arg_16_0)
		if arg_16_0 == "exit" then
			var_0_16 = nil

			l2utils:removeNodeShake(self.image_boss_shake)
			substitution_manager:setBossHp(nil)
		end
	end)
end

function SubstitutionLayer:initUI()
	self.rootLayer = ccui.Layout:create()

	self:addChild(self.rootLayer)
	self.rootLayer:setAnchorPoint(0, 0)
	self.rootLayer:setPositionY(-GameDisplay.fix_y)

	self.bg = ccui.ImageView:create("mainScenebg/NewSubstitutionLayer_bg.png")

	self:addChild(self.bg, -1)
	self.bg:setAnchorPoint(0, 1)
	self.bg:setPositionY(GameDisplay.height + 110 - 1.4 * GameDisplay.fix_y)

	local var_17_0 = ccui.Layout:create()

	self.rootLayer:addChild(var_17_0, 0)
	var_17_0:setPosition(320, GameDisplay.height - 400)
	var_17_0:setName("Panel_16")

	self.panel_16 = var_17_0

	var_17_0:setScale(0.6)

	local var_17_1 = ccui.Button:create(var_0_19 .. "title.png", nil, var_0_19 .. "title.png", var_0_14)

	self.rootLayer:addChild(var_17_1)
	var_17_1:setAnchorPoint(0, 1)
	var_17_1:setPosition(0, GameDisplay.height - 10)

	local var_17_2 = cc.Label:createWithTTF("剩余时间：", FONT_DES, 22)

	var_17_2:setPosition(300, GameDisplay.height - 25)
	var_17_2:setAnchorPoint(0, 1)
	self.rootLayer:addChild(var_17_2)

	self.remain_time_label = var_17_2

	var_17_2:setColor(var_0_20("5E4AB4"))

	local var_17_3 = cc.Label:createWithTTF("5天", FONT_DES, 18)

	var_17_3:setPosition(300, GameDisplay.height - 55)
	var_17_3:setAnchorPoint(0, 1)
	self.rootLayer:addChild(var_17_3)

	self.remain_time = var_17_3

	var_17_3:setColor(var_0_20("5E4AB4"))

	local var_17_4 = ccui.Button:create(var_0_19 .. "rank_btn.png", nil, var_0_19 .. "rank_btn.png", var_0_14)

	self.rootLayer:addChild(var_17_4)
	var_17_4:setAnchorPoint(1, 1)
	var_17_4:setPosition(620, GameDisplay.height - 40)

	self.btn_rank = var_17_4

	local var_17_5 = ccui.ImageView:create(var_0_19 .. "boss_title.png", var_0_14)

	self.rootLayer:addChild(var_17_5)
	var_17_5:setAnchorPoint(0, 1)
	var_17_5:setPosition(80, GameDisplay.height - 120)

	local var_17_6 = cc.Label:createWithTTF("耶梦加得", FONT_DES, 28)

	var_17_6:setPosition(0, 10)
	var_17_6:setAnchorPoint(0, 0)
	var_17_5:addChild(var_17_6)
	var_17_6:setName("Label_boss_name")

	self.label_boss_name = var_17_6

	local var_17_7 = ccui.ImageView:create(var_0_19 .. "image_attr.png", var_0_14)

	self.rootLayer:addChild(var_17_7)
	var_17_7:setAnchorPoint(0, 1)
	var_17_7:setPosition(0, GameDisplay.height - 120)

	self.image_attr = var_17_7

	local var_17_8 = ccui.ImageView:create(var_0_19 .. "level_select_title.png", var_0_14)

	self.rootLayer:addChild(var_17_8)
	var_17_8:setAnchorPoint(1, 1)
	var_17_8:setPosition(620, GameDisplay.height - 200)

	self.level_select_title = var_17_8

	local var_17_9 = ccui.ImageView:create(var_0_19 .. "image_level_choice.png", var_0_14)

	self.rootLayer:addChild(var_17_9)
	var_17_9:setAnchorPoint(1, 1)
	var_17_9:setPosition(620, var_17_8:getPositionY() - var_17_8:getContentSize().height - 10)

	self.image_level_choice = var_17_9

	local var_17_10 = ccui.ListView:create()

	var_17_10:setAnchorPoint(1, 1)
	var_17_10:setDirection(ccui.ScrollViewDir.vertical)
	var_17_10:setContentSize(var_17_8:getContentSize().width, 200)
	var_17_10:setPosition(620, var_17_8:getPositionY() - var_17_8:getContentSize().height - 17)
	self.rootLayer:addChild(var_17_10)
	var_17_10:setBackGroundColorOpacity(100)
	var_17_10:setBounceEnabled(true)
	var_17_10:setName("level_select_list")

	self.level_select_list = var_17_10

	local var_17_11 = ccui.ImageView:create(var_0_19 .. "level_score_bg.png", var_0_14)

	self.rootLayer:addChild(var_17_11)
	var_17_11:setAnchorPoint(1, 1)
	var_17_11:setPosition(620, var_17_10:getPositionY() - var_17_10:getContentSize().height - 20)

	self.level_score_bg = var_17_11

	local var_17_12 = cc.Label:createWithTTF("0", FONT_DES, 20)

	var_17_12:setPosition(var_17_11:getContentSize().width / 2, var_17_11:getContentSize().height / 2)
	var_17_11:addChild(var_17_12)
	var_17_12:setName("level_score_label")
	var_17_12:setAnchorPoint(0.5, 0.5)

	self.level_score_label = var_17_12

	var_17_12:setColor(var_0_20("79D4FF"))

	local var_17_13 = ccui.ImageView:create(var_0_19 .. "blood_bottom.png", var_0_14)

	self.rootLayer:addChild(var_17_13)
	var_17_13:setAnchorPoint(0, 1)
	var_17_13:setPosition(80, GameDisplay.height - 170)

	self.Image_hp = var_17_13

	local var_17_14 = cc.Label:createWithTTF("0.00%", FONT_DES, 20)

	var_17_14:setPosition(var_17_13:getContentSize().width / 2, var_17_13:getContentSize().height / 2)
	var_17_13:addChild(var_17_14, 10)
	var_17_14:setName("label_hp_percent")
	var_17_14:setAnchorPoint(0.5, 0.5)

	self.label_hp_percent = var_17_14

	local var_17_15 = ccui.ImageView:create(var_0_19 .. "score_up_title.png", var_0_14)

	self.rootLayer:addChild(var_17_15)
	var_17_15:setAnchorPoint(0, 1)
	var_17_15:setPosition(10, 600)

	self.score_up_title = var_17_15

	local var_17_16 = ccui.ImageView:create(var_0_19 .. "score_up_bg.png", var_0_14)

	self.rootLayer:addChild(var_17_16)
	var_17_16:setAnchorPoint(0, 1)
	var_17_16:setPosition(10, 600 - var_17_15:getContentSize().height)

	self.score_up_bg = var_17_16

	local var_17_17 = ccui.ListView:create()

	var_17_17:setDirection(ccui.ScrollViewDir.horizontal)
	var_17_17:setContentSize(var_17_16:getContentSize().width - 40, var_17_16:getContentSize().height - 20)
	var_17_17:setPosition(cc.p(20, 10))
	var_17_16:addChild(var_17_17)
	var_17_17:setBackGroundColorOpacity(100)
	var_17_17:setBounceEnabled(true)
	var_17_17:setName("score_up_list")

	self.score_up_list = var_17_17

	local var_17_18 = ccui.ImageView:create(var_0_19 .. "bottom_bg.png", var_0_14)

	self.rootLayer:addChild(var_17_18)
	var_17_18:setAnchorPoint(0, 1)
	var_17_18:setPosition(0, var_17_16:getPositionY() - var_17_16:getContentSize().height)

	self.image_score_boss_bottom = var_17_18

	local var_17_19 = cc.Label:createWithTTF("999999", FONT_DES, 30)

	var_17_18:addChild(var_17_19)
	var_17_19:setAnchorPoint(1, 1)
	var_17_19:setPosition(105, 105)

	self.label_boss_score = var_17_19

	var_17_19:setColor(var_0_20("C29FF6"))

	local var_17_20 = ccui.ListView:create()

	var_17_20:setDirection(ccui.ScrollViewDir.horizontal)
	var_17_20:setContentSize(420, 160)
	var_17_20:setPosition(cc.p(185, 20))
	var_17_18:addChild(var_17_20)
	var_17_20:setBackGroundColorOpacity(100)
	var_17_20:setBounceEnabled(true)
	var_17_20:setName("rewardList")

	self.rewardList = var_17_20

	local var_17_21 = ccui.ImageView:create(var_0_19 .. "reward_preview.png", var_0_14)

	var_17_18:addChild(var_17_21)
	var_17_21:setAnchorPoint(1, 0.5)
	var_17_21:setPosition(640, var_17_18:getContentSize().height / 2)

	self.reward_preview = var_17_21

	local var_17_22 = ccui.Button:create(var_0_19 .. "fight_btn.png", nil, var_0_19 .. "fight_btn.png", var_0_14)

	self.rootLayer:addChild(var_17_22)
	var_17_22:setPosition(320, 180)

	self.fight_btn = var_17_22

	local var_17_23 = cc.Label:createWithTTF(L_SUBSTITUTION_FIGHT, FONT_DES, 30)

	var_17_22:addChild(var_17_23)
	var_17_23:setPosition(var_17_22:getContentSize().width / 2, var_17_22:getContentSize().height / 2 - 5)

	self.fight_label = var_17_23

	local var_17_24 = ccui.Button:create(var_0_19 .. "reset_btn.png", nil, var_0_19 .. "reset_btn.png", var_0_14)

	self.rootLayer:addChild(var_17_24)
	var_17_24:setPosition(510, 173)

	self.resetBtn = var_17_24

	local var_17_25 = ccui.Button:create(var_0_19 .. "return_bg.png", nil, var_0_19 .. "return_bg.png", var_0_14)

	self.rootLayer:addChild(var_17_25)
	var_17_25:setAnchorPoint(0, 0)

	local var_17_26 = ccui.Button:create(var_0_19 .. "return_btn.png", nil, var_0_19 .. "return_btn.png", var_0_14)

	var_17_25:addChild(var_17_26)
	var_17_26:setAnchorPoint(0, 0)
	var_17_26:setPosition(10, 10)

	self.return_btn = var_17_26

	var_17_26:addTouchEventListener(function(arg_18_0, arg_18_1)
		if arg_18_1 ~= ccui.TouchEventType.ended then
			return
		end

		KeyCodeManager:onKeyReleasedCallFunc()
	end)

	local var_17_27 = ccui.Layout:create()

	var_17_0:addChild(var_17_27)
	var_17_27:setName("Image_boss")

	local var_17_28 = ccui.ImageView:create(var_0_19 .. "level_select_line.png", var_0_14)

	var_17_28:setAnchorPoint(1, 1)
	var_17_28:setPosition(var_17_8:getContentSize().width, -3)
	var_17_8:addChild(var_17_28)

	local var_17_29 = ccui.Button:create(var_0_19 .. "boss_info.png", nil, var_0_19 .. "boss_info.png", var_0_14)

	self.rootLayer:addChild(var_17_29)
	var_17_29:setAnchorPoint(0, 1)
	var_17_29:setPosition(35, GameDisplay.height - 210)

	self.button_boss_photo = var_17_29

	local var_17_30 = ccui.ImageView:create(var_0_19 .. "boss_photo_line.png", var_0_14)

	var_17_30:setAnchorPoint(0, 1)
	var_17_30:setPosition(0, 0)
	var_17_29:addChild(var_17_30)
	var_17_1:setTouchEnabled(true)
	var_17_1:addTouchEventListener(function(arg_19_0, arg_19_1)
		if arg_19_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopActivityDetail", {
			key = "newsubstitution"
		})
	end)
end

function SubstitutionLayer:initResetBtn()
	self.resetBtn:addTouchEventListener(function(arg_21_0, arg_21_1)
		local var_21_0

		if arg_21_1 ~= ccui.TouchEventType.ended then
			do return end

			var_21_0 = {
				surecallback = function()
					substitution_manager:reset_last_substitution(self.mode, callback)
				end
			}
		end

		var_21_0.labels = {
			button = L_BUTTON_TEXT.Sure,
			title = L_SUBSTITUTION_RESET_TIP.title,
			des = L_SUBSTITUTION_RESET_TIP.des
		}

		LayerManager:pushInLayer("PopDoLayer", var_21_0)
	end)
	self.resetBtn:setVisible(false)
end

function SubstitutionLayer:getSubArrayData(arg_23_1)
	substitution_manager:get_substitution_battlearrays(self.mode, arg_23_1)
end

function SubstitutionLayer:startFight()
	self.fight_btn:addTouchEventListener(function(arg_25_0, arg_25_1)
		if arg_25_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:getSubArrayData(function(arg_26_0, arg_26_1, arg_26_2)
			var_0_8:pushFormationLayer("FormationOverclockLayer", {
				mode = self.mode,
				level = self.level,
				fightcount = arg_26_0,
				arraydata = arg_26_1,
				usingarrays = arg_26_2
			})
		end)
	end)
end

function SubstitutionLayer:initLevelChoiceUI(arg_27_1)
	local var_27_0 = RoleDefault:getInstance():getIntegerForKey("sub_choose_level", 0)

	self.level = self.subStatus == 0 and (var_27_0 == 0 or nil) and (self.recommendRank or var_27_0) or self.level

	if self.level > #self.levelTbl then
		self.level = #self.levelTbl
	end

	RoleDefault:getInstance():setIntegerForKey("sub_choose_level", self.level)
	self.level_select_list:removeAllChildren()

	for iter_27_0 = 1, #self.levelTbl do
		local var_27_2 = ccui.Layout:create()

		var_27_2:setContentSize(cc.size(77, 38))

		local var_27_3 = ccui.Button:create(var_0_19 .. "level_off.png", var_0_19 .. "level_off.png", var_0_19 .. "level_off.png", var_0_14)

		var_27_3:setAnchorPoint(0, 0)

		local var_27_4 = cc.Label:createWithTTF(self.levelTbl[iter_27_0] .. L_LV, FONT_DES, 20)

		var_27_4:setPosition(var_27_3:getContentSize().width / 2, var_27_3:getContentSize().height / 2)
		var_27_3:addChild(var_27_4)
		var_27_3:setPosition(5, 0)
		var_27_2:addChild(var_27_3)
		self.level_select_list:pushBackCustomItem(var_27_2)

		var_27_3.levelid = iter_27_0

		if iter_27_0 == self.level then
			var_27_3:loadTextures(var_0_19 .. "level_on.png", var_0_19 .. "level_on.png", var_0_19 .. "level_on.png", var_0_14)

			self.curlevelBtn = var_27_3
		end

		var_27_3:addTouchEventListener(function(arg_28_0, arg_28_1)
			if arg_28_1 ~= ccui.TouchEventType.ended then
				return
			end

			if arg_27_1.fightcount ~= 0 then
				global_ShowBlockWords(L_SUBSTITUTION_LEVEL_LOCK)

				return
			end

			if self.curlevelBtn then
				self.curlevelBtn:loadTextures(var_0_19 .. "level_off.png", var_0_19 .. "level_off.png", var_0_19 .. "level_off.png", var_0_14)
			end

			arg_28_0:loadTextures(var_0_19 .. "level_on.png", var_0_19 .. "level_on.png", var_0_19 .. "level_on.png", var_0_14)

			self.curlevelBtn = arg_28_0
			self.level = arg_28_0.levelid

			RoleDefault:getInstance():setIntegerForKey("sub_choose_level", self.level)
			l2utils:shakeNode(self.image_boss_shake, {
				scanlinethreshold = 0.025,
				driftpixel = 0,
				waitframe = 0,
				shakeframe = 12,
				restoreframe = 12,
				scanlinedriftfac = 5
			})
			self.image_boss_shake:runAction(cc.Sequence:create(cc.DelayTime:create(0.4), cc.CallFunc:create(function()
				l2utils:removeNodeShake(self.image_boss_shake)
			end)))
			self:updateChapterBattlefieldstatus()
			self:updateBossScore()
		end)
	end
end

function SubstitutionLayer:updateChapterBattlefieldstatus()
	if not self.battlefieldstatusBg then
		self.battlefieldstatusBg = ccui.ImageView:create(var_0_19 .. "battlefieldstatusBg.png", var_0_14)

		self.battlefieldstatusBg:setPosition(cc.p(620, self.image_score_boss_bottom:getPositionY()))
		self.battlefieldstatusBg:setAnchorPoint(1, 0)
		self.rootLayer:addChild(self.battlefieldstatusBg)

		local var_30_0 = ccui.ImageView:create(var_0_19 .. "battlefieldstatus_title.png", var_0_14)

		self.rootLayer:addChild(var_30_0)
		var_30_0:setAnchorPoint(1, 0)
		var_30_0:setPosition(620, self.image_score_boss_bottom:getPositionY() + self.battlefieldstatusBg:getContentSize().height + 5)

		local var_30_1 = ccui.ListView:create()

		var_30_1:setAnchorPoint(0, 0)
		var_30_1:setDirection(ccui.ScrollViewDir.horizontal)
		var_30_1:setContentSize(self.battlefieldstatusBg:getContentSize().width - 20, self.battlefieldstatusBg:getContentSize().height - 10)
		var_30_1:setPosition(10, 5)
		self.battlefieldstatusBg:addChild(var_30_1)
		var_30_1:setBackGroundColorOpacity(100)
		var_30_1:setBounceEnabled(true)
		var_30_1:setName("battlefieldstatus_list")

		self.battlefieldstatus_list = var_30_1
	end

	local var_30_2 = level_manager.loadMonsterTeamData(self.mode)[chapter_data[self.mode .. "-" .. self.level].bigboss].boss
	local var_30_3 = level_manager.loadMonsterData(self.mode)
	local var_30_4 = {}

	while var_30_3[var_30_2]["horcruxskill_" .. 1] do
		table.insert(var_30_4, var_30_3[var_30_2]["horcruxskill_" .. 1])
	end

	if not next(var_30_4) then
		self.battlefieldstatusBg:setVisible(false)

		return
	end

	self.battlefieldstatus_list:removeAllChildren()

	for iter_30_0, iter_30_1 in pairs(var_30_4) do
		local var_30_6 = ccui.Layout:create()

		var_30_6:setContentSize(cc.size(55, 60))

		local var_30_7 = ccui.ImageView:create("GUI/Image.png", var_0_14)

		var_30_7:setScale(0.4)
		var_30_7:setPosition(30, 38)
		var_30_6:addChild(var_30_7)
		var_30_7:setTouchEnabled(true)
		var_30_7:addTouchEventListener(function(arg_31_0, arg_31_1)
			if arg_31_1 ~= ccui.TouchEventType.ended then
				return
			end

			self:showSkillInfo(arg_31_0.skillid)
		end)

		local var_30_8 = cc.Label:createWithTTF("", FONT_DES, 40)

		var_30_8:setHorizontalAlignment(cc.TEXT_ALIGNMENT_CENTER)
		var_30_8:setVerticalAlignment(cc.TEXT_ALIGNMENT_CENTER)
		var_30_8:setAnchorPoint(0.5, 0.5)
		var_30_8:setPositionY(-24)
		var_30_8:setPositionX(var_30_7:getContentSize().width / 2)
		var_30_7:addChild(var_30_8)
		var_30_8:setName("skillNameLabel")
		var_30_7:setVisible(true)
		var_30_7:loadTexture("skill_new/skill/" .. total_skill_data[iter_30_1].icon .. ".png", var_0_14)

		var_30_7.skillid = iter_30_1

		var_30_7:getChildByName("skillNameLabel"):setPositionX(var_30_7:getContentSize().width / 2)
		var_30_7:getChildByName("skillNameLabel"):setString(total_skill_data[iter_30_1].name)
		self.battlefieldstatus_list:pushBackCustomItem(var_30_6)
	end
end

function SubstitutionLayer:updateBossScore()
	if not chapter_data[self.mode .. "-" .. self.level].passscore then
		self.image_score_boss_bottom:setVisible(false)
	else
		self.image_score_boss_bottom:setVisible(true)
		self.level_score_label:setString(global_trans_number(chapter_data[self.mode .. "-" .. self.level].passscore) .. "积分")
	end
end

function SubstitutionLayer:showSkillInfo(arg_33_1)
	local var_33_0 = ccui.Layout:create()

	var_33_0:setTouchEnabled(true)
	var_33_0:setContentSize(cc.Director:getInstance():getVisibleSize())
	var_33_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_33_0:setPosition(cc.p(cc.Director:getInstance():getVisibleSize().width / 2, cc.Director:getInstance():getVisibleSize().height / 2))
	var_33_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_33_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_33_0:setBackGroundColorOpacity(120)
	var_33_0:addTouchEventListener(function(arg_34_0, arg_34_1)
		if arg_34_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_33_0:runAction(cc.RemoveSelf:create())
	end)
	;(function()
		local var_35_0 = ccui.ImageView:create("EquipLayer/skill_des_bg.png", var_0_14)

		var_35_0:setPosition(cc.p(320, 672))
		var_35_0:setAnchorPoint(cc.p(0.5, 0.5))
		var_33_0:addChild(var_35_0)

		local var_35_1 = ccui.Layout:create()

		var_35_1:setContentSize(cc.size(500, 124))
		var_35_1:setAnchorPoint(cc.p(0, 0))
		var_35_1:setPosition(cc.p(70, 600))
		var_35_1:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
		var_35_1:setBackGroundColor(cc.c3b(0, 0, 0))
		var_35_1:setBackGroundColorOpacity(0)
		var_33_0:addChild(var_35_1, 2)

		local var_35_2 = ccui.ImageView:create("EquipLayer/normal_skill_frame.png", var_0_14)

		var_35_2:setPosition(cc.p(58, 63))
		var_35_2:setAnchorPoint(cc.p(0.5, 0.5))
		var_35_1:addChild(var_35_2)

		local var_35_3 = ccui.ImageView:create("skill_new/skill/" .. total_skill_data[arg_33_1].icon .. ".png", var_0_14)

		var_35_3:setScale(0.88)
		var_35_3:setPosition(cc.p(58, 63))
		var_35_1:addChild(var_35_3)

		local var_35_4 = cc.Label:createWithTTF(total_skill_data[arg_33_1].name, FONT_DES, 24)

		var_35_4:setAnchorPoint(cc.p(0, 0.5))
		var_35_4:setPosition(cc.p(121, 96))
		var_35_1:addChild(var_35_4)
		var_35_4:setColor(var_0_20("C29FF6"))

		if total_skill_data[arg_33_1].cd then
			local var_35_5 = cc.Label:createWithTTF(L_SIKILL_CD .. total_skill_data[arg_33_1].cd .. "s", FONT_DES, 20)

			var_35_5:setAnchorPoint(cc.p(1, 0.5))
			var_35_5:setPosition(cc.p(473, 96))
			var_35_1:addChild(var_35_5)
		end

		local var_35_6 = transSkillDesToRichText(total_skill_data[arg_33_1].description)
		local var_35_7 = RichTextPro:create()

		var_35_7:setMaxWidth(380)
		var_35_7:setSize(20)
		var_35_7:setColor(cc.c3b(220, 251, 241))
		var_35_7:setLineSpace(0)
		var_35_7:setText(var_35_6)
		var_35_7:setName("richText")
		var_35_7:setPosition(cc.p(120, 86))
		var_35_1:addChild(var_35_7)
	end)()
	self.rootLayer:addChild(var_33_0, 1000)
end

function SubstitutionLayer:updateLevelChoiceBtn()
	self:initLevelData()
	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_level"):setString(self.levelTbl[self.level] .. L_LV)
end

function SubstitutionLayer:initLevelChoiceBtn()
	local var_37_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_level")
	local var_37_1 = ccui.Helper:seekWidgetByName(self.rootLayer, "Label_level")
	local var_37_2 = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_12")

	ccui.Helper:seekWidgetByName(self.rootLayer, "Button_boss_info"):addTouchEventListener(function(arg_38_0, arg_38_1)
		if arg_38_1 ~= ccui.TouchEventType.ended then
			return
		end

		if var_37_0:getPositionY() ~= 195 then
			var_37_0:runAction(cc.MoveTo:create(0.1, cc.p(99, 195)))
		end
	end)

	local var_37_3 = var_37_2:getContentSize()
	local var_37_4 = cc.rect(0, 0, var_37_3.width, var_37_3.height)
	local var_37_5 = cc.EventListenerTouchOneByOne:create()

	var_37_5:setSwallowTouches(false)
	var_37_5:registerScriptHandler(function(arg_39_0, arg_39_1)
		return true
	end, cc.Handler.EVENT_TOUCH_BEGAN)
	var_37_5:registerScriptHandler(function(arg_40_0, arg_40_1)
		if cc.rectContainsPoint(var_37_4, (var_37_2:convertToNodeSpace(arg_40_0:getLocation()))) then
			-- block empty
		else
			var_37_0:runAction(cc.MoveTo:create(0.1, cc.p(99, 595)))
			var_37_1:setString(self.levelTbl[self.level] .. L_LV)
		end
	end, cc.Handler.EVENT_TOUCH_ENDED)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(var_37_5, var_37_2)
end

function SubstitutionLayer:initLevelData()
	self.levelTable = {}

	for iter_41_0, iter_41_1 in pairs(ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_12"):getChildren()) do
		self.levelTable[#self.levelTable + 1] = iter_41_1
	end

	self.middle = math.ceil(#self.levelTable / 2)

	for iter_41_2, iter_41_3 in pairs(self.levelTable) do
		local var_41_0 = string.split(iter_41_3:getName(), "_")[2]

		iter_41_3:setOpacity(255 * (1 - math.abs(self.middle - tonumber(var_41_0)) / self.middle))
		iter_41_3:setFontSize(20 - math.abs(self.middle - tonumber(var_41_0)))

		if iter_41_2 <= self.unlockLevel then
			iter_41_3:setString(self.levelTbl[iter_41_2])
		else
			iter_41_3:setString("???")
		end
	end

	self:updateLevel()
end

function SubstitutionLayer:updateLevel()
	for iter_42_0, iter_42_1 in pairs(self.levelTable) do
		local var_42_0 = tonumber(string.split(iter_42_1:getName(), "_")[2])

		if self.levelTbl[var_42_0 - self.middle + self.level] then
			if var_42_0 - self.middle + self.level <= self.unlockLevel then
				iter_42_1:setString(self.levelTbl[var_42_0 - self.middle + self.level] .. L_LV)
			else
				iter_42_1:setString("???")
			end

			iter_42_1:setVisible(true)
		else
			iter_42_1:setString("")
			iter_42_1:setVisible(false)
		end
	end
end

function SubstitutionLayer:panelMove()
	local var_43_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_12")
	local var_43_1 = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_select"):getContentSize().height
	local var_43_2 = var_43_0:getPositionY()
	local var_43_3
	local var_43_4
	local var_43_5 = false
	local var_43_6
	local var_43_7 = false

	var_43_0:addTouchEventListener(function(arg_44_0, arg_44_1)
		if arg_44_1 == ccui.TouchEventType.began then
			var_43_3 = arg_44_0:getTouchBeganPosition()
			var_43_5 = true
		elseif arg_44_1 == ccui.TouchEventType.moved then
			if var_43_5 == true then
				var_43_4 = arg_44_0:getTouchMovePosition()
				var_43_6 = var_43_4.y - var_43_3.y
				var_43_3 = var_43_4

				arg_44_0:setPositionY(arg_44_0:getPositionY() + var_43_6)

				if math.abs(var_43_2 - arg_44_0:getPositionY()) >= var_43_1 / 1.2 then
					if var_43_2 - arg_44_0:getPositionY() < 0 then
						self.level = self.level + 1

						if self.level > self.unlockLevel and var_43_7 == false then
							var_43_7 = true

							global_ShowBlockWords(L_SUBSTITUTION_LEVEL_OPEN)
						end
					else
						var_43_7 = false
						self.level = self.level - 1
					end

					if self.level <= 1 then
						self.level = 1
					end

					if self.level > self.unlockLevel then
						self.level = self.unlockLevel
					end

					if self.level > 0 and self.level <= #self.levelTbl then
						self:updateLevel()
					end

					arg_44_0:setPositionY(var_43_2)
				end
			end
		elseif arg_44_1 == ccui.TouchEventType.canceled then
			var_43_5 = false

			arg_44_0:setPositionY(var_43_2)
		elseif arg_44_1 == ccui.TouchEventType.ended then
			var_43_5 = false

			arg_44_0:setPositionY(var_43_2)
		end
	end)
end

function SubstitutionLayer:getPlayerSubData(arg_45_1)
	self.mode = arg_45_1.mode

	substitution_manager:get_player_substitution_data(self.mode, function(arg_46_0)
		self:initData(arg_46_0, arg_45_1)
		self:updateChapterBattlefieldstatus()
		self:updateBossScore()
	end)
end

function SubstitutionLayer.updateBossHead(arg_47_0, arg_47_1, arg_47_2)
	if model_data[arg_47_2.modelid].role_image then
		arg_47_1:loadTexture("roleimage/role/shop_image/" .. model_data[arg_47_2.modelid].role_image .. ".png")
		arg_47_1:setPosition(cc.p(60, 0))
	else
		arg_47_1:loadTexture("roleimage/role/wuji/" .. model_data[arg_47_2.modelid].cute_role .. ".png")
		arg_47_1:setScale(1.2)
		arg_47_1:setPosition(cc.p(60, 40))
	end
end

function SubstitutionLayer:initUpList(arg_48_1)
	for iter_48_0, iter_48_1 in pairs(arg_48_1) do
		local var_48_0 = ccui.Layout:create()

		var_48_0:setContentSize(cc.size(77, 100))
		var_48_0:setAnchorPoint(0, 0)

		local var_48_1 = ccui.ImageView:create(var_0_19 .. "imageRole_bg.png", var_0_14)

		var_48_0:addChild(var_48_1)
		var_48_1:setPosition(36, 50)

		local var_48_2 = ccui.ImageView:create("equipment/" .. item_data[servant_data[iter_48_1.servantid].itemid].image_id .. ".png")

		var_48_1:addChild(var_48_2)
		var_48_2:setScale(0.4)
		var_48_2:setAnchorPoint(0, 0)

		local var_48_3 = var_48_2:getChildByName("imageUp")

		if not var_48_3 then
			var_48_3 = iter_48_1.up == "0.25" and ccui.ImageView:create("SubstitutionLayer/fifty_percent.png", var_0_14) or ccui.ImageView:create("SubstitutionLayer/thirty_percent.png", var_0_14)

			var_48_3:setName("imageUp")
			var_48_3:setPosition(cc.p(80, 80))
			var_48_2:addChild(var_48_3)
		else
			if iter_48_1.up == "0.25" then
				var_48_3:loadTexture("SubstitutionLayer/fifty_percent.png", var_0_14)
			else
				var_48_3:loadTexture("SubstitutionLayer/thirty_percent.png", var_0_14)
			end

			var_48_3:setVisible(true)
		end

		self.score_up_list:pushBackCustomItem(var_48_0)
		var_48_2:setTouchEnabled(true)
		var_48_2:addTouchEventListener(function(arg_49_0, arg_49_1)
			if arg_49_1 ~= ccui.TouchEventType.ended then
				return
			end

			LayerManager:pushInLayer("PopSubScoreUpLayer", {
				uplist = arg_48_1
			})
		end)
	end

	self.score_up_title:setTouchEnabled(true)
	self.score_up_title:addTouchEventListener(function(arg_50_0, arg_50_1)
		if arg_50_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopSubScoreUpLayer", {
			uplist = arg_48_1
		})
	end)
end

function SubstitutionLayer:updateUI(arg_51_1)
	if arg_51_1.fightcount ~= 0 then
		self.resetBtn:setVisible(true)
		self.fight_label:setString(L_SUBSTITUTION_CONTINUE_FIGHT)
	else
		self.resetBtn:setVisible(false)
		self.fight_label:setString(L_SUBSTITUTION_FIGHT)
	end

	self.label_boss_score:setString(global_trans_number(arg_51_1.score))
end

function SubstitutionLayer:initData(arg_52_1, arg_52_2)
	self.btn_rank:addTouchEventListener(function(arg_53_0, arg_53_1)
		if arg_53_1 ~= ccui.TouchEventType.ended then
			return
		end

		arg_53_0:setBright(false)
		LayerManager:pushInLayer("SubRankListLayer", {
			callback = function()
				if var_0_16 then
					arg_53_0:setBright(true)
				end
			end,
			mode = self.mode,
			playerinfo = arg_52_1
		})
	end)

	self.level = arg_52_1.curlevel
	self.subStatus = arg_52_1.status
	self.unlockLevel = arg_52_1.unlocklevel

	self:initUpList(arg_52_1.uplist)
	self:getBossLevel()
	self:initLevelChoiceUI(arg_52_1)
	self:updateUI(arg_52_1)
	self:initBloodBar(arg_52_1, arg_52_2)

	if arg_52_1.awardlist then
		self:updateListView(arg_52_1)
	end
end

function SubstitutionLayer.createItem(arg_55_0, arg_55_1, arg_55_2)
	local var_55_0 = arg_55_2.drop.dropid and ccui.ImageView:create(var_0_19 .. "reward_bg.png", var_0_14) or ccui.ImageView:create(var_0_19 .. "reward_bg.png", var_0_14)

	var_55_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_55_0:setPosition(cc.p(60, 50))
	arg_55_1:addChild(var_55_0, 5)

	local var_55_2
	local var_55_3

	if arg_55_2.drop.dropid then
		if arg_55_2.drop.dropid == 0 then
			var_55_3 = ccui.ImageView:create("equipment/1000000.png")
			var_55_2 = 100 / var_55_3:getContentSize().width
		elseif arg_55_2.drop.dropid == 1 then
			var_55_3 = ccui.ImageView:create("equipment/1000001.png")
			var_55_2 = 100 / var_55_3:getContentSize().width
		else
			local var_55_4 = item_data[arg_55_2.drop.dropid].bag_item_type

			if item_data[arg_55_2.drop.dropid].bag_item_type == kITEM_HORCRUX then
				var_55_3 = ccui.ImageView:create(CUTE_ROLE_IMAGE_PATH .. horcrux_manager:getHorcruxRoleImage(arg_55_2.drop.dropid) .. ".png")
				var_55_2 = 100 / var_55_3:getContentSize().width
			elseif var_55_4 == kITEM_MEDAL then
				var_55_3 = ItemSprite:create_medal_icon(arg_55_2.drop.dropid)
			elseif var_55_4 == kITEM_SCULTURE then
				var_55_3 = ccui.ImageView:create("role/wuji/" .. item_data[arg_55_2.drop.dropid].image_id .. ".png")
				var_55_2 = 150 / var_55_3:getContentSize().width
			else
				var_55_3 = ccui.ImageView:create("equipment/" .. item_data[arg_55_2.drop.dropid].image_id .. ".png")
				var_55_2 = 100 / var_55_3:getContentSize().width
			end
		end
	end

	var_55_3:setScale((var_55_2 or 1) * 0.68)
	var_55_3:setPosition(cc.p(60, 60))
	arg_55_1:addChild(var_55_3, 6)

	local var_55_5 = cc.Label:createWithTTF(arg_55_2.drop.dropNum, FONT_DES, 24)

	var_55_5:setAnchorPoint(cc.p(1, 0.5))
	var_55_5:setPosition(cc.p(96, 32))
	arg_55_1:addChild(var_55_5, 7)
	var_55_3:setTouchEnabled(true)
	var_55_3:addTouchEventListener(function(arg_56_0, arg_56_1)
		if arg_56_1 ~= ccui.TouchEventType.ended then
			return
		end

		arg_55_0:showDetailsofItems(arg_55_2.drop.dropid, "item")
	end)
end

function SubstitutionLayer:updateListView(arg_57_1)
	local var_57_0 = arg_57_1.awardlist
	local var_57_1 = self.rewardList

	self.rewardList:setItemsMargin(0)
	var_57_1:removeAllChildren()

	local function var_57_2(arg_58_0)
		if not arg_58_0 then
			self.reward_preview:setVisible(false)
		end

		self.reward_preview:removeAllChildren()

		local var_58_0 = ccui.Layout:create()

		var_58_0:setContentSize(cc.size(90, 100))
		var_58_0:setPosition(30, 50)

		local var_58_1 = self:createItem(var_58_0, arg_58_0)
		local var_58_2 = cc.Label:createWithTTF(global_trans_number(arg_58_0.need), FONT_DES, 18)

		var_58_2:setAnchorPoint(cc.p(0.5, 0.5))
		var_58_2:setPosition(cc.p(58, 8))
		var_58_0:addChild(var_58_2, 6)
		self.reward_preview:addChild(var_58_0)
	end

	print("panel_item_clonepanel_item_clone", self.panel_item_clone)

	for iter_57_0 = 1, #arg_57_1.awardlist do
		local var_57_3 = ccui.Layout:create()

		var_57_3:setContentSize(cc.size(90, 100))

		local var_57_4 = var_57_3

		self:createItem(var_57_3, arg_57_1.awardlist[iter_57_0])

		if arg_57_1.score_toweek >= arg_57_1.awardlist[iter_57_0].need and arg_57_1.awardlist[iter_57_0].stat == 1 then
			var_57_4:addTouchEventListener(function(arg_59_0, arg_59_1)
				if arg_59_1 ~= ccui.TouchEventType.ended then
					return
				end

				substitution_manager:get_substitution_award(var_57_0[iter_57_0].id, function(arg_60_0)
					if tolua.isnull(self) then
						return
					end

					if arg_60_0 == 1 then
						local var_60_0 = ccui.ImageView:create("public/panelbg/fragment_tic_new.png", var_0_14)

						var_60_0:setScale(4)
						var_60_0:setAnchorPoint(cc.p(0.5, 0.5))
						var_60_0:setPosition(cc.p(75, 90))
						arg_59_0:addTouchEventListener(function(arg_61_0, arg_61_1)
							if arg_61_1 ~= ccui.TouchEventType.ended then
								return
							end
						end)
						var_57_2(var_57_0[iter_57_0 + 1])
					end
				end)
			end)
		else
			var_57_4:addTouchEventListener(function(arg_62_0, arg_62_1)
				if arg_62_1 ~= ccui.TouchEventType.ended then
					return
				end
			end)

			if arg_57_1.awardlist[iter_57_0].stat == 0 then
				-- block empty
			else
				local var_57_5 = ccui.ImageView:create("public/panelbg/fragment_tic_new.png", var_0_14)

				var_57_5:setAnchorPoint(cc.p(0.5, 0.5))
				var_57_5:setPosition(cc.p(80, 75))
				var_57_5:setScale(0.5)
				var_57_4:addChild(var_57_5, 10)
			end
		end

		local var_57_6 = cc.Label:createWithTTF(global_trans_number(arg_57_1.awardlist[iter_57_0].need), FONT_DES, 18)

		var_57_6:setAnchorPoint(cc.p(0.5, 0.5))
		var_57_6:setPosition(cc.p(58, 8))
		var_57_4:addChild(var_57_6, 6)
		var_57_1:pushBackCustomItem(var_57_4)
	end

	local var_57_7

	for iter_57_1 = 1, #arg_57_1.awardlist do
		if arg_57_1.score_toweek >= arg_57_1.awardlist[iter_57_1].need then
			var_57_7 = iter_57_1 + 1
		else
			var_57_7 = iter_57_1

			break
		end
	end

	var_57_2(arg_57_1.awardlist[var_57_7])
end

function SubstitutionLayer:showDetailsofItems(arg_63_1, arg_63_2)
	local function var_63_1()
		self.rootLayer:setVisible(true)
	end

	if arg_63_2 == "item" then
		if item_data[arg_63_1].bag_item_type == kITEM_HORCRUX then
			local var_63_2 = -1
			local horcrux_data = require("data.horcrux_data")

			for iter_63_0, iter_63_1 in pairs((require("data.photofile_HelpGirl_data"))) do
				if iter_63_1.model_id == horcrux_data[arg_63_1].model then
					var_63_2 = iter_63_0

					break
				end
			end

			if var_63_2 == -1 then
				print("did not find id")

				return
			end

			LayerManager:pushInLayer("DetailsofHelpGirlLayer", {
				id = var_63_2,
				itemid = arg_63_1,
				callback = var_63_1
			})
			self.rootLayer:setVisible(false)
		elseif item_data[arg_63_1].bag_item_type == kITEM_HERO then
			LayerManager:pushInLayer("SoulsLayer", {
				showtype = 6,
				layertype = "DropDetailsLayer",
				cursoul = item_data[arg_63_1].servant,
				exitCallback = var_63_1
			})
			self.rootLayer:setVisible(false)
		else
			LayerManager:pushInLayer("PopItemLayer", {
				itemid = arg_63_1
			})
		end
	elseif arg_63_2 == "gold" then
		-- block empty
	elseif arg_63_2 == "diamond" then
		-- block empty
	end
end

function SubstitutionLayer:setBossFight()
	if model_data[self.bossInfo[1].modelid].role_image then
		self.image_boss_shake:setTexture("role/" .. model_data[self.bossInfo[1].modelid].role_image .. ".png")
	else
		self.image_boss_shake:setTexture("role1/" .. model_data[self.bossInfo[1].modelid].cute_role .. ".png")
	end

	self.mode = self.bossInfo[1].mode

	substitution_manager:get_player_substitution_data(self.bossInfo[1].mode, function(arg_66_0)
		self:initData(arg_66_0, self.bossInfo[1])
		self:updateChapterBattlefieldstatus()
		self:updateBossScore()
	end)

	self.modelid = self.bossInfo[1].modelid

	self.image_boss_shake:setPosition(cc.p(self.image_boss_shake:getPositionX() + (model_data[self.modelid].substitution_offset_x or 0), self.image_boss_shake:getPositionY() + (model_data[self.modelid].substitution_offset_y or 0)))
	self.label_boss_name:setString(model_data[self.bossInfo[1].modelid].name)
	self.image_attr:loadTexture("public/career_icon/" .. global_get_model_attr(self.bossInfo[1].modelid) .. ".png", var_0_14)
end

function SubstitutionLayer:initBloodBar(arg_67_1, arg_67_2)
	local var_67_0 = self.Image_hp
	local var_67_1

	if not self.Image_hp:getChildByName("exp_bar") then
		var_67_1 = cc.ProgressTimer:create((config._DEBUG or nil) and (cc.Sprite:create("SubstitutionLayer/hp.png") or cc.Sprite:createWithSpriteFrameName("SubstitutionLayer/hp.png")))

		var_67_1:setType(cc.PROGRESS_TIMER_TYPE_BAR)
		var_67_1:setBarChangeRate(cc.p(1, 0))
		var_67_1:setMidpoint(cc.p(0, 0))
		var_67_1:setAnchorPoint(cc.p(0.5, 0.5))
		var_67_1:setPosition(cc.p(var_67_0:getContentSize().width / 2, var_67_0:getContentSize().height / 2))
		var_67_1:setName("exp_bar")
		var_67_0:addChild(var_67_1, 5)
		var_67_1:setOpacity(150)
	else
		var_67_1 = var_67_0:getChildByName("exp_bar")
	end

	if not arg_67_1.bosshp then
		var_67_1:setPercentage(100)
		self.label_hp_percent:setString("100.0%")
	elseif arg_67_1.bosshp == "0" then
		var_67_1:setPercentage(100)
		self.label_hp_percent:setString(string.format("%0.1f", 100) .. "%")
	else
		self.bossHp = substitution_manager:get_first_blood()

		substitution_manager:setBossHp(nil)

		local var_67_3 = tonumber(self.bossHp)
		local var_67_4 = self:getCurLevelFullBossHp(self.level)

		if self.bossHp then
			if var_67_3 <= 0 then
				var_67_3 = var_67_4
			end

			local var_67_5 = math.ceil((var_67_3 - tonumber(arg_67_1.bosshp)) / var_67_4 * 100)

			if var_67_5 > 2 then
				var_67_1:setPercentage(var_67_3 / var_67_4 * 100)
				self.label_hp_percent:setString(self:getPercent(var_67_3 / var_67_4 * 100) .. "%")
				self:updateBloodBar(arg_67_1, arg_67_2, var_67_5)
			else
				local var_67_6 = tonumber(arg_67_1.bosshp) / var_67_4 * 100

				var_67_1:setPercentage(var_67_6)
				self.label_hp_percent:setString(self:getPercent(var_67_6) .. "%")
			end
		else
			local var_67_7 = tonumber(arg_67_1.bosshp) / var_67_4 * 100

			var_67_1:setPercentage(var_67_7)
			self.label_hp_percent:setString(self:getPercent(var_67_7) .. "%")
		end
	end
end

function SubstitutionLayer.getPercent(arg_68_0, arg_68_1)
	local var_68_0 = string.split(tostring(arg_68_1), ".")

	if #var_68_0 == 1 then
		return var_68_0[1]
	end

	return var_68_0[1] .. "." .. string.sub(var_68_0[2], 1, 1)
end

function SubstitutionLayer:updateBloodBar(arg_69_1, arg_69_2, arg_69_3)
	local var_69_0 = self.Image_hp:getChildByName("exp_bar")
	local var_69_1 = self.label_hp_percent
	local var_69_2 = var_69_0:getPercentage()
	local var_69_3 = {}
	local var_69_4 = self:getCurLevelFullBossHp(self.level)

	for iter_69_0 = 1, arg_69_3 do
		var_69_3[iter_69_0] = cc.Sequence:create(cc.CallFunc:create(function()
			var_69_2 = var_69_2 - 1

			if iter_69_0 == arg_69_3 then
				var_69_2 = tonumber(arg_69_1.bosshp) / var_69_4 * 100

				var_69_1:setString(self:getPercent(var_69_2) .. "%")
			else
				var_69_1:setString(self:getPercent(var_69_2) .. "%")
			end

			var_69_0:setPercentage(var_69_2)
		end), cc.DelayTime:create(0.05))
	end

	var_69_0:runAction((cc.EaseExponentialOut:create(cc.Sequence:create(var_69_3))))
end

function SubstitutionLayer:initBottomList()
	self.bottomList = BottomBtnList:create(function(arg_72_0, arg_72_1)
		if arg_72_1 ~= ccui.TouchEventType.ended then
			return
		end

		KeyCodeManager:onKeyReleasedCallFunc()
	end)

	self.bottomList:setName("bottomlist")
	self:addChild(self.bottomList, 999)
end

function SubstitutionLayer:fullScreen(arg_73_1)
	arg_73_1:setContentSize((GameDisplay.getScreenSize()))
	arg_73_1:setPositionY(arg_73_1:getPositionY() - GameDisplay.fix_y)
	self.top_title:setPosition(cc.p(GameDisplay.getUiScreenSize().width / 2, GameDisplay.getUiScreenSize().height - self.top_title:getContentSize().height / 2))
	self.panel_info:setPositionY(self.panel_info:getPositionY() + GameDisplay.fix_y)
	self.panel_down:setPositionY(self.panel_down:getPositionY() + GameDisplay.fix_y / 2)

	local var_73_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_boss_info")
	local var_73_1 = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_hp")

	var_73_0:setPositionY(var_73_0:getPositionY() + GameDisplay.fix_y)
	var_73_1:setPositionY(var_73_1:getPositionY() + GameDisplay.fix_y)
	self.bottomList:setPositionY(self.bottomList:getPositionY() - GameDisplay.fix_y)
end
