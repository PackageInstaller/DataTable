ThreeVsThreeLayer = class("ThreeVsThreeLayer", function()
	return cc.Layer:create()
end)

require("view.Sprite.TvTRankSprite")
require("view.Sprite.AvatarSprite")

local TempWidget = require("view.Sprite.TempWidget")
local item_data = require("data.item_data")
local playermodel = require("model.playermodel")
local arenatft_rank_data = require("data.arenatft.arenatft_rank_data")
local arenatft_manager = require("controller.arenatft_manager")
local audio_manager = require("controller.audio_manager")
local var_0_6 = require("controller.formation.formation_manager"):getInstance()
local var_0_7 = config._DEBUG and 0 or 1
local var_0_8 = 130
local var_0_9 = {
	"ThreeVsThreeLayer/rank_1.png",
	"ThreeVsThreeLayer/rank_2.png",
	"ThreeVsThreeLayer/rank_3.png",
	"ThreeVsThreeLayer/rank_4.png"
}
local var_0_10 = {
	"equipment/medal1.png",
	"equipment/medal2.png",
	"equipment/medal3.png",
	"equipment/medal4.png",
	"equipment/medal5.png",
	"equipment/medal6.png"
}
local var_0_11 = {
	cc.c4b(240, 240, 240, 150),
	cc.c4b(54, 255, 82, 150),
	cc.c4b(56, 122, 255, 150),
	cc.c4b(255, 12, 246, 150),
	cc.c4b(255, 84, 0, 150),
	cc.c4b(255, 0, 0, 150)
}

setmetatable(var_0_9, {
	__index = function()
		return "ThreeVsThreeLayer/rank_4.png"
	end
})

local function var_0_12(arg_3_0)
	if not arg_3_0 then
		return
	end

	if arg_3_0 >= 86400 then
		return string.format(L_TIME_FORMAT[1], math.floor(arg_3_0 / 86400), math.floor(arg_3_0 % 86400 / 3600))
	elseif arg_3_0 >= 3600 then
		return string.format(L_TIME_FORMAT[2], math.floor(arg_3_0 / 3600), math.floor(arg_3_0 % 3600 / 60))
	else
		return string.format(L_TIME_FORMAT[3], math.floor(arg_3_0 / 60))
	end
end

local var_0_13

function ThreeVsThreeLayer.create(arg_4_0, arg_4_1)
	local var_4_0 = ThreeVsThreeLayer.new()

	var_4_0:init(arg_4_1)

	return var_4_0
end

function ThreeVsThreeLayer:init(arg_5_1)
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "ThreeVsThreeLayer.json" or "ThreeVsThreeLayer.ExportJson")

	self:addChild(self.rootLayer)

	var_0_13 = self

	self:initUI()
	self:initArrayInfo()
	self:updatePlayerInfos()
	self:updateTitleSprite()
	self:getRankListFromSever()
	self:fullScreen()
	self:registerScriptHandler(function(arg_6_0)
		if arg_6_0 == "exit" then
			var_0_13 = nil

			arenatft_manager:setLayerState(nil)
		end
	end)
end

function ThreeVsThreeLayer:initUI()
	self:initTitleSprite()
	self:initBottomList()
	self:initPlayerPanel()
	self:updateTaskAlert()
	self:updateArenaTftBattleFieldStatus()
end

function ThreeVsThreeLayer:updateArenaTftBattleFieldStatus()
	local var_8_0 = arenatft_manager:get_arenatft_battlefield_status()

	if not var_8_0 then
		return
	end

	if not next(var_8_0) then
		return
	end

	local var_8_1 = ccui.ImageView:create("Array/btn_element_on.png", var_0_7)

	var_8_1:setAnchorPoint(cc.p(1, 0.5))
	var_8_1:setPosition(cc.p(GameDisplay.width, 300 - GameDisplay.fix_y))
	self.rootLayer:addChild(var_8_1, 20)

	local var_8_2 = arenatft_manager:get_arenatft_battlefield_status_info()[1] or ""
	local var_8_3 = ccui.ImageView:create(arenatft_manager:get_arenatft_battlefield_status_icon(var_8_0[1]), var_0_7)

	var_8_3:setPosition(cc.p(35, 33))
	var_8_1:addChild(var_8_3)

	local var_8_4 = cc.Label:createWithTTF(var_8_2, FONT_DES, 20)

	var_8_4:setAnchorPoint(cc.p(0, 0.5))
	var_8_4:setPosition(cc.p(70, var_8_1:getContentSize().height / 2 - 5))
	var_8_4:setScale((math.min(1, 220 / var_8_4:getContentSize().width)))
	var_8_1:addChild(var_8_4)
	var_8_1:setTouchEnabled(true)
	var_8_1:addTouchEventListener(function(arg_9_0, arg_9_1)
		if arg_9_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopActivityDetail", {
			key = "tvt_arena_status"
		})
	end)
end

function ThreeVsThreeLayer:initTitleSprite()
	require("view.Sprite.TitleSprite")

	self.titleSprite = TitleSprite:create("ThreeVsThreeLayer/title_three_vs_three.png", 2)

	self.titleSprite:setPosition(cc.p(0, 1136 + GameDisplay.fix_y * 2 - self.titleSprite:getContentSize().height))
	self.rootLayer:addChild(self.titleSprite, 999)

	local var_10_0 = self.titleSprite:getChildByName("title")

	var_10_0:setTouchEnabled(true)
	var_10_0:addTouchEventListener(function(arg_11_0, arg_11_1)
		if arg_11_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopActivityDetail", {
			key = "three_teams_battle"
		})
	end)

	local var_10_1 = ccui.Button:create("ThreeVsThreeLayer/new_sahngchen.png", nil, "ThreeVsThreeLayer/new_sahngchen.png", var_0_7)

	var_10_1:setPosition(cc.p(590, 26))
	self.titleSprite:addChild(var_10_1)
	var_10_1:addTouchEventListener(function(arg_12_0, arg_12_1)
		if arg_12_1 ~= ccui.TouchEventType.ended then
			return
		end

		if require("controller.time_check_manager"):getCurTime() < global_get_time_by_date("2023-03-01 00:00:00") then
			LayerManager:switchShowLayer("MarketLayer", {
				singleMarket = "1-50"
			})
		else
			LayerManager:switchShowLayer("MarketLayer", {
				singleMarket = "1-49"
			})
		end
	end)

	local var_10_2 = TempWidget:CreateTempBtn("ThreeVsThreeLayer/history.png", self.titleSprite)

	var_10_2:move(cc.p(500, 26))
	var_10_2:_addEvent(function()
		LayerManager:pushInLayer("ThreeVsThreeHistoryLayer")
	end)
	var_10_2:setVisible(false)

	self.timeLbl = cc.Label:createWithTTF("", FONT_NAME, 20)

	self.timeLbl:setPosition(cc.p(320, 30))
	self.titleSprite:addChild(self.timeLbl)
end

function ThreeVsThreeLayer.updateTitleSprite(arg_14_0)
	arenatft_manager:get_season_data(function()
		local var_15_1 = arenatft_manager:getSeasonLessTime()

		arg_14_0.timeLbl:setString((var_15_1 > 0 or nil) and L_SEASON_LESS_TIME .. var_0_12(var_15_1))
	end)
end

function ThreeVsThreeLayer:initBottomList()
	require("view.Sprite.BottomBtnList")

	self.bottomList = BottomBtnList:create(function(arg_17_0, arg_17_1)
		if arg_17_1 ~= ccui.TouchEventType.ended then
			return
		end

		KeyCodeManager:onKeyReleasedCallFunc()
	end, {
		{
			texture = "public/button/public_button_red.png",
			name = "start_fight",
			word = "",
			handler = function(arg_18_0, arg_18_1)
				if arg_18_1 ~= ccui.TouchEventType.ended then
					return
				end

				if arenatft_manager:isSeasonSleep() then
					global_ShowBlockWords(L_TVT_SEASON_END)

					return
				end

				if arenatft_manager:is_attack_array_empty() then
					arenatft_manager:setLayerState(CONFIG_TYPE_TVT_ATTACK_FORM)
					var_0_6:pushFormationLayer("Formation3V3SettingLayer", {
						configtype = CONFIG_TYPE_TVT_ATTACK_FORM
					})

					return
				end

				if arenatft_manager:getPlayerRemainTime() <= 0 then
					global_ShowBlockWords(L_TVT_MATCH_ENEMY_TIMES)

					return
				end

				local var_18_0 = {
					callback = function()
						if not var_0_13 then
							return
						end

						self:updatePlayerInfos()
						self:updateRankListUI()

						self.autoFight = RoleDefault:getInstance():getBoolForKey("TvtAutoFight", false)

						self.autoFightDui:setVisible(self.autoFight)
					end
				}

				arenatft_manager:setLayerBtnLock(true)
				LayerManager:pushInLayer("PopTvtMatchLayer", var_18_0)
			end
		}
	})

	self.rootLayer:addChild(self.bottomList, 6)
	self.bottomList:getChildByName("start_fight"):setPositionX(520)

	self.btnStartFight = self.bottomList:getChildByName("start_fight")

	local var_16_0 = cc.Label:createWithTTF(L_TVT_FIGHT[1], FONT_NAME, 30)

	var_16_0:setPosition(cc.p(self.btnStartFight:getContentSize().width / 2, self.btnStartFight:getContentSize().height / 2))
	var_16_0:setName("btn_fight_lbl")
	self.btnStartFight:addChild(var_16_0)

	local var_16_1 = ccui.ImageView:create("ThreeVsThreeLayer/less_num_bg.png", var_0_7)

	var_16_1:setPosition(cc.p(195, 28))
	self.bottomList:addChild(var_16_1)

	self.lblLessNum = cc.Label:createWithTTF("", FONT_NAME, 20)

	self.lblLessNum:setPosition(cc.p(105, 18))
	self.lblLessNum:setColor(cc.c3b(0, 186, 255))
	var_16_1:addChild(self.lblLessNum)

	self.btnaddLessNum = ccui.Button:create("ThreeVsThreeLayer/btn_add.png", nil, "ThreeVsThreeLayer/btn_add.png", var_0_7)

	self.btnaddLessNum:setPosition(cc.p(137, 17))
	var_16_1:addChild(self.btnaddLessNum)
	self.btnaddLessNum:addTouchEventListener(function(arg_20_0, arg_20_1)
		if arg_20_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arenatft_manager:isSeasonSleep() then
			global_ShowBlockWords(L_TVT_SEASON_END)

			return
		end

		if arenatft_manager:isHasAllData() then
			return
		end

		if arenatft_manager:getPlayerRemainTime() >= arenatft_manager:getPlayerTotalTime() then
			global_ShowBlockWords(L_TVT_CAN_NOT_REFUSE_2)

			return
		end

		local var_20_0 = arenatft_manager:getPlayerRefreshCost()
		local var_20_1

		if not var_20_0 then
			global_ShowBlockWords(L_TVT_CAN_NOT_REFUSE)

			do return end

			var_20_1 = {}
		end

		function var_20_1.surecallback()
			if playermodel.diamond < var_20_0 then
				LayerManager:pushInLayer("PopDoLayer", {
					surecallback = function()
						LayerManager:switchShowLayer("SupermarketLayer")
					end,
					labels = {
						button = L_BUTTON_TEXT.Sure,
						title = L_TOWER_DEFENCE_COST_ERROR[6],
						des = L_TVT_GO_BUG
					}
				})

				return
			end

			arenatft_manager:refresh_arenatft_dailytime(function()
				LayerManager:removePopLayer(self.__queueindex)

				if not var_0_13 then
					return
				end

				self.lblLessNum:setString(arenatft_manager:getPlayerRemainTime())
			end)
		end

		var_20_1.labels = {
			title = L_TVT_REFUSE_TITLE,
			des = string.format(L_TVT_REFUSE_DESC, arenatft_manager:getRefuseNum(), var_20_0)
		}

		LayerManager:pushInLayer("PopDoLayer", var_20_1)
	end)

	self.autoFight = RoleDefault:getInstance():getBoolForKey("TvtAutoFight", false)

	local var_16_2 = ccui.ImageView:create("ThreeVsThreeLayer/auto_fight_bg.png", var_0_7)

	var_16_2:setPosition(cc.p(350, 28))
	self.bottomList:addChild(var_16_2)

	local var_16_3 = ccui.ImageView:create("ThreeVsThreeLayer/auto_fight_choose.png", var_0_7)

	var_16_3:setPosition(cc.p(103, 16))
	var_16_2:addChild(var_16_3)

	local var_16_4 = ccui.ImageView:create("ThreeVsThreeLayer/auto_fight_on.png", var_0_7)

	var_16_4:setPosition(cc.p(15, 15))
	var_16_3:addChild(var_16_4)
	var_16_4:setVisible(self.autoFight)
	var_16_2:setTouchEnabled(true)
	var_16_2:addTouchEventListener(function(arg_24_0, arg_24_1)
		if arg_24_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.autoFight = not self.autoFight

		var_16_4:setVisible(self.autoFight)
		RoleDefault:getInstance():setBoolForKey("TvtAutoFight", self.autoFight)
	end)

	self.autoFightDui = var_16_4
end

function ThreeVsThreeLayer:initPlayerPanel()
	self.playerPanel = self.rootLayer:getChildByName("player_panel")

	self.playerPanel:setTouchEnabled(true)
	self.playerPanel:setLocalZOrder(5)

	self.avatarSprite = AvatarSprite:create(tonumber(playermodel.head_sculpture))

	self.avatarSprite:setPosition(cc.p(40, 93))
	self.avatarSprite:setScale(0.55)
	self.playerPanel:addChild(self.avatarSprite)
	self.playerPanel:getChildByName("lbl_name"):setString(playermodel.nickname)

	self.btnAward = self.playerPanel:getChildByName("btn_get_award")

	self.btnAward:addTouchEventListener(function(arg_26_0, arg_26_1)
		if arg_26_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not self.totalAward then
			return
		end

		if self.totalAward.dropNum == 0 then
			global_ShowBlockWords(L_TVT_GETTED_AWARD)
		end

		arenatft_manager:get_arenatft_daily_awards(function()
			if not var_0_13 then
				return
			end

			self:updatePlayerInfos()
		end)
	end)

	local var_25_0 = self.playerPanel:getChildByName("btn_conf")

	var_25_0:addTouchEventListener(function(arg_28_0, arg_28_1)
		if arg_28_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arenatft_manager:isHasAllData() then
			return
		end

		local var_28_0 = {
			configtype = CONFIG_TYPE_TVT_ATTACK_FORM
		}

		arenatft_manager:setLayerState(CONFIG_TYPE_TVT_ATTACK_FORM)
		var_0_6:pushFormationLayer("Formation3V3SettingLayer", var_28_0)
	end)

	local var_25_1 = self.playerPanel:getChildByName("btn_record")

	var_25_1:setPositionX(var_25_0:getPositionX() + 158)
	var_25_1:addTouchEventListener(function(arg_29_0, arg_29_1)
		if arg_29_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopTvtRecordLayer")
	end)

	local var_25_2 = ccui.Button:create("ThreeVsThreeLayer/btn_task.png", nil, "ThreeVsThreeLayer/btn_task.png", var_0_7)

	var_25_2:setPosition(cc.p(var_25_0:getPositionX() - 158, var_25_0:getPositionY()))
	self.playerPanel:addChild(var_25_2)
	var_25_2:addTouchEventListener(function(arg_30_0, arg_30_1)
		if arg_30_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:switchShowLayer("TVTTaskLayer")
	end)

	self.btnTask = var_25_2

	local var_25_3 = ccui.ImageView:create("ThreeVsThreeLayer/panel_up.png", var_0_7)

	var_25_3:setPosition(cc.p(320, 0))
	var_25_3:setAnchorPoint(cc.p(0.5, 0))
	self.playerPanel:addChild(var_25_3, -1)
end

function ThreeVsThreeLayer.initArrayInfo(arg_31_0)
	arenatft_manager:get_arenatft_attack_array()
end

function ThreeVsThreeLayer.updatePlayerInfos(arg_32_0)
	arenatft_manager:get_player_arenatft_info(function(arg_33_0)
		if not var_0_13 then
			return
		end

		local var_33_0 = arg_32_0.playerPanel:getChildByName("tvTRankSprite")

		if var_33_0 then
			var_33_0:removeFromParent()
		end

		local var_33_1 = TvTRankSprite:create(arg_33_0.succscore)

		var_33_1:setName("tvTRankSprite")
		var_33_1:setPosition(cc.p(400, 98))
		arg_32_0.playerPanel:addChild(var_33_1)
		arg_32_0.playerPanel:getChildByName("cur_rank"):setString((var_33_1:getCurRank()))
		arg_32_0.playerPanel:getChildByName("next_rank"):setString((var_33_1:getNextRank()))

		arg_32_0.totalAward = arg_33_0.total_award or {
			dropNum = 0,
			dropid = 1601000
		}

		arg_32_0.playerPanel:getChildByName("lbl_win_num"):setString(arg_32_0.totalAward.dropNum)
		arg_32_0.playerPanel:getChildByName("lbl_lv"):setString(arg_33_0.daily_award.dropNum .. "/小时")

		local var_33_2, var_33_3 = var_33_1:getPlayerRankPercent(arg_33_0.succscore)

		if not arg_32_0.progressBar then
			arg_32_0.progressBar = ccui.Slider:create()

			arg_32_0.progressBar:loadBarTexture("ThreeVsThreeLayer/progress_bg.png", var_0_7)
			arg_32_0.progressBar:loadProgressBarTexture("ThreeVsThreeLayer/progress.png", var_0_7)
			arg_32_0.progressBar:setPosition(cc.p(510, 30))
			arg_32_0.progressBar:setPercent(var_33_2)
			arg_32_0.playerPanel:addChild(arg_32_0.progressBar)

			arg_32_0.progressBarLbl = cc.Label:createWithTTF(var_33_3, FONT_DES, 18)

			arg_32_0.progressBarLbl:setColor(cc.c3b(255, 255, 255))
			arg_32_0.progressBarLbl:setPosition(cc.p(arg_32_0.progressBar:getContentSize().width / 2, arg_32_0.progressBar:getContentSize().height / 2))
			arg_32_0.progressBar:addChild(arg_32_0.progressBarLbl)
		else
			arg_32_0.progressBar:setPercent(var_33_2)
			arg_32_0.progressBarLbl:setString(var_33_3)
		end

		arg_32_0.daily_remain_count = arg_33_0.daily_remain_count

		arg_32_0.lblLessNum:setString(arg_32_0.daily_remain_count)

		if arenatft_manager:isSeasonSleep() then
			arg_32_0.btnStartFight:setColor(cc.c3b(82, 82, 82))
			arg_32_0.btnStartFight:getChildByName("btn_fight_lbl"):setString(L_TVT_FIGHT[2])
		else
			arg_32_0.btnStartFight:setColor(cc.c3b(255, 255, 255))
			arg_32_0.btnStartFight:getChildByName("btn_fight_lbl"):setString(L_TVT_FIGHT[1])
		end

		if arg_32_0.totalAward.dropNum <= 0 then
			arg_32_0.btnAward:setColor(cc.c3b(82, 82, 82))
		else
			arg_32_0.btnAward:setColor(cc.c3b(255, 255, 255))
		end

		if arg_33_0.isnewseason == true then
			arg_32_0:runAction(cc.Sequence:create(cc.DelayTime:create(0.5), cc.CallFunc:create(function()
				LayerManager:pushInLayer("PopTvtNewSeasonLayer", arg_33_0)
			end)))
		end
	end)
end

function ThreeVsThreeLayer.getRankListFromSever(arg_35_0)
	arenatft_manager:get_arenatft_ranklist(function(arg_36_0)
		if not var_0_13 then
			return
		end

		arg_35_0.rankList = arg_36_0.data
		arg_35_0.rankList[#arg_35_0.rankList + 1] = arg_35_0.rankList[#arg_35_0.rankList]

		arg_35_0:updateRankListUI()
	end)
end

function ThreeVsThreeLayer:updateRankListUI()
	if not self.rankList or #self.rankList <= 0 then
		return
	end

	if self.tableView then
		self.tableView:reloadData()

		return
	end

	local var_37_0 = self.bottomList:getPositionY() + 70
	local var_37_1 = 1000 + GameDisplay.height - 1136

	self.tableView = cc.TableView:create(cc.size(640, 1000 + GameDisplay.height - 1136))

	self.tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.tableView:setAnchorPoint(cc.p(0, 0))
	self.tableView:setPosition(0, var_37_0)
	self.tableView:setDelegate()
	self.rootLayer:addChild(self.tableView)
	self.tableView:registerScriptHandler(function(arg_40_0, arg_40_1)
		return 640, var_0_8
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.tableView:registerScriptHandler(function(arg_38_0, arg_38_1)
		local var_38_0 = arg_38_0:dequeueCell()
		local var_38_1

		if not var_38_0 then
			var_38_0 = cc.TableViewCell:create()
			var_38_1 = self:createRankListSprite(self.rankList[arg_38_1 + 1], arg_38_1 + 1)

			var_38_1:setAnchorPoint(cc.p(0.5, 0.5))
			var_38_1:setPosition(cc.p(320, var_0_8 / 2))
			var_38_0:addChild(var_38_1)

			if arg_38_1 <= math.floor(var_37_1 / var_0_8) then
				var_38_1:setOpacity(0)
				var_38_1:getChildByName("avatar"):setVisible(false)
				var_38_1:runAction(cc.Sequence:create(cc.DelayTime:create(0.05 * arg_38_1), cc.FadeIn:create(0.1), cc.CallFunc:create(function()
					var_38_1:getChildByName("avatar"):setVisible(true)
				end)))
			else
				var_38_1:setOpacity(255)
			end
		else
			var_38_1 = var_38_0:getChildByTag(100)

			self:updateRankListSprite(var_38_1, self.rankList[arg_38_1 + 1], arg_38_1 + 1)
		end

		var_38_1:setVisible(arg_38_1 + 1 ~= #self.rankList)

		return var_38_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.tableView:registerScriptHandler(function(arg_41_0, arg_41_1)
		return #self.rankList
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.tableView:reloadData()
end

function ThreeVsThreeLayer.createRankListSprite(arg_42_0, arg_42_1, arg_42_2)
	local var_42_1 = ccui.Button:create(var_0_9[arg_42_2 == 1 and 1 or arg_42_2 <= 3 and 2 or arg_42_2 <= 10 and 3 or 4], var_0_9[arg_42_2 == 1 and 1 or arg_42_2 <= 3 and 2 or arg_42_2 <= 10 and 3 or 4], var_0_9[arg_42_2 == 1 and 1 or arg_42_2 <= 3 and 2 or arg_42_2 <= 10 and 3 or 4], var_0_7)

	var_42_1:setTag(100)
	var_42_1:setTouchEnabled(true)
	var_42_1:setSwallowTouches(false)
	var_42_1:addTouchEventListener(function(arg_43_0, arg_43_1)
		if arg_43_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_43_0

		if math.abs(arg_43_0:getTouchBeganPosition().y - arg_43_0:getTouchEndPosition().y) > 50 then
			do return end

			var_43_0 = {
				pvptype = 3,
				playeruid = arg_42_1.playerid
			}
		end

		function var_43_0.callback()
			return
		end

		LayerManager:pushInLayer("PopFriendIntroduceLayer", var_43_0)
	end)

	if arg_42_2 > 100 then
		var_42_1:setVisible(false)
	else
		var_42_1:setVisible(true)
	end

	local var_42_2 = 25
	local var_42_3 = cc.c4b(46, 32, 32, 255)
	local var_42_4 = FONT_W5

	if arg_42_2 == 1 then
		var_42_2 = 28
	else
		var_42_3 = arg_42_2 <= 3 and cc.c4b(98, 70, 15, 255) or arg_42_2 <= 10 and cc.c4b(98, 70, 15, 255) or cc.c4b(255, 255, 255, 255)
	end

	local var_42_5 = cc.Label:createWithTTF(arg_42_2, var_42_4, var_42_2)

	var_42_5:setTextColor(var_42_3)
	var_42_5:setPosition(cc.p(37, 70))
	var_42_5:setName("title")
	var_42_5:setString(arg_42_2)
	var_42_1:addChild(var_42_5)

	local var_42_6 = AvatarSprite:create(arg_42_1.head_sculpture)

	var_42_6:setName("avatar")
	var_42_6:setScale(0.65)
	var_42_6:setPositionX(80)
	var_42_6:addTouchEventListener(function(arg_45_0, arg_45_1)
		if arg_45_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_45_0

		if math.abs(arg_45_0:getTouchBeganPosition().y - arg_45_0:getTouchEndPosition().y) > 50 then
			do return end

			var_45_0 = {
				pvptype = 3,
				playeruid = arg_42_1.playerid
			}
		end

		function var_45_0.callback()
			return
		end

		LayerManager:pushInLayer("PopFriendIntroduceLayer", var_45_0)
	end)
	var_42_1:addChild(var_42_6)

	local var_42_7 = cc.Label:createWithTTF(arg_42_1.name, FONT_NAME, 24)

	var_42_7:setAnchorPoint(cc.p(0, 0.5))
	var_42_7:setPosition(cc.p(230, 90))
	var_42_7:setName("lbl_name")
	var_42_1:addChild(var_42_7)

	local var_42_8 = cc.Label:createWithTTF(L_ARENA_CREDITS, FONT_NAME, 24)

	var_42_8:setPosition(cc.p(280, 30))
	var_42_8:setName("lbl_rank")
	var_42_1:addChild(var_42_8)

	local var_42_9 = TvTRankSprite:create(arg_42_1.score)

	var_42_9:setScale(0.4)
	var_42_9:setPosition(cc.p(230, 60))
	var_42_9:setName("tvt_sprite")
	var_42_1:addChild(var_42_9)

	local var_42_10 = cc.Label:createWithTTF(arg_42_1.score, FONT_NAME, 24)

	var_42_10:setColor(cc.c3b(255, 220, 126))
	var_42_10:setPosition(cc.p(338, 28))
	var_42_10:setAnchorPoint(cc.p(0, 0.5))
	var_42_10:setName("lbl_num")
	var_42_1:addChild(var_42_10)

	local var_42_11 = {}

	var_42_11[1] = arg_42_1.medal_1 or 0
	var_42_11[2] = arg_42_1.medal_2 or 0
	var_42_11[3] = arg_42_1.medal_3 or 0

	for iter_42_0 = 1, 3 do
		local var_42_12 = item_data[var_42_11[iter_42_0]] or item_data[9100011]
		local var_42_13 = ccui.ImageView:create((var_42_12.bg or nil) and ("equipment/" .. var_42_12.bg .. ".png" or var_0_10[var_42_12.equip_quality]))

		var_42_13:setName("medal_" .. iter_42_0)
		var_42_13:setScale(0.7)
		var_42_13:setPosition(cc.p(397 + 60 * iter_42_0, 60))
		var_42_1:addChild(var_42_13)

		if var_42_11[iter_42_0] == 0 then
			var_42_13:setVisible(false)
		else
			var_42_13:setVisible(true)

			if not var_42_13:getChildByName("medalname") then
				local var_42_14 = cc.Label:createWithTTF("", FONT_DES, 54)

				var_42_14:setAnchorPoint(cc.p(0.5, 0.5))
				var_42_14:setPosition(cc.p(var_42_13:getContentSize().width / 2 + 5, var_42_13:getContentSize().height / 2 - 3))
				var_42_14:setName("medalname")
				var_42_13:addChild(var_42_14)
			end

			var_42_13:getChildByName("medalname"):setString(var_42_12.name)
			var_42_13:getChildByName("medalname"):enableOutline(var_0_11[var_42_12.equip_quality], 1)
			var_42_13:getChildByName("medalname"):enableShadow(var_0_11[var_42_12.equip_quality], cc.size(0, 0))
			var_42_13:getChildByName("medalname"):setPosition(cc.p(var_42_13:getContentSize().width / 2 + 5, var_42_13:getContentSize().height / 2 - 3))
		end
	end

	return var_42_1
end

function ThreeVsThreeLayer.updateRankListSprite(arg_47_0, arg_47_1, arg_47_2, arg_47_3)
	local var_47_1 = arg_47_3 == 1 and 1 or arg_47_3 <= 3 and 2 or arg_47_3 <= 10 and 3 or 4

	arg_47_1:setTag(100)
	arg_47_1:loadTextures(var_0_9[var_47_1], var_0_9[var_47_1], var_0_9[var_47_1], var_0_7)
	arg_47_1:addTouchEventListener(function(arg_48_0, arg_48_1)
		if arg_48_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_48_0

		if math.abs(arg_48_0:getTouchBeganPosition().y - arg_48_0:getTouchEndPosition().y) > 50 then
			do return end

			var_48_0 = {
				pvptype = 3,
				playeruid = arg_47_2.playerid
			}
		end

		function var_48_0.callback()
			return
		end

		LayerManager:pushInLayer("PopFriendIntroduceLayer", var_48_0)
	end)

	if arg_47_3 > 100 then
		arg_47_1:setVisible(false)
	else
		arg_47_1:setVisible(true)
	end

	local var_47_3 = cc.c4b(46, 32, 32, 255)

	if arg_47_3 == 1 then
		-- block empty
	else
		var_47_3 = arg_47_3 <= 3 and cc.c4b(98, 70, 15, 255) or arg_47_3 <= 10 and cc.c4b(98, 70, 15, 255) or cc.c4b(255, 255, 255, 255)
	end

	local var_47_6 = arg_47_1:getChildByName("title")

	var_47_6:setString(arg_47_3 or "")
	var_47_6:setTextColor(var_47_3)

	local var_47_7 = arg_47_1:getChildByName("avatar")

	var_47_7:switchShowAvatar(arg_47_2.head_sculpture)
	var_47_7:addTouchEventListener(function(arg_50_0, arg_50_1)
		if arg_50_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_50_0

		if math.abs(arg_50_0:getTouchBeganPosition().y - arg_50_0:getTouchEndPosition().y) > 50 then
			do return end

			var_50_0 = {
				pvptype = 3,
				playeruid = arg_47_2.playerid
			}
		end

		function var_50_0.callback()
			return
		end

		LayerManager:pushInLayer("PopFriendIntroduceLayer", var_50_0)
	end)
	arg_47_1:getChildByName("lbl_name"):setString(arg_47_2.name)
	arg_47_1:getChildByName("lbl_num"):setString(arg_47_2.score)
	arg_47_1:getChildByName("tvt_sprite"):update(arg_47_2.score)

	local var_47_8 = {}

	var_47_8[1] = arg_47_2.medal_1 or 0
	var_47_8[2] = arg_47_2.medal_2 or 0
	var_47_8[3] = arg_47_2.medal_3 or 0

	for iter_47_0 = 1, 3 do
		if var_47_8[iter_47_0] == 0 then
			arg_47_1:getChildByName("medal_" .. iter_47_0):setVisible(false)
		else
			local var_47_9 = arg_47_1:getChildByName("medal_" .. iter_47_0)

			var_47_9:setVisible(true)

			if not var_47_9:getChildByName("medalname") then
				local var_47_10 = cc.Label:createWithTTF("", FONT_DES, 54)

				var_47_10:setAnchorPoint(cc.p(0.5, 0.5))
				var_47_10:setPosition(cc.p(var_47_9:getContentSize().width / 2 + 5, var_47_9:getContentSize().height / 2 - 3))
				var_47_10:setName("medalname")
				var_47_9:addChild(var_47_10)
			end

			local var_47_11 = item_data[var_47_8[iter_47_0]] or item_data[9100011]

			var_47_9:loadTexture((var_47_11.bg or nil) and ("equipment/" .. var_47_11.bg .. ".png" or var_0_10[var_47_11.equip_quality]))
			var_47_9:getChildByName("medalname"):setString(var_47_11.name)
			var_47_9:getChildByName("medalname"):enableOutline(var_0_11[var_47_11.equip_quality], 1)
			var_47_9:getChildByName("medalname"):enableShadow(var_0_11[var_47_11.equip_quality], cc.size(0, 0))
			var_47_9:getChildByName("medalname"):setPosition(cc.p(var_47_9:getContentSize().width / 2 + 5, var_47_9:getContentSize().height / 2 - 3))
		end
	end
end

local function var_0_14(arg_52_0)
	for iter_52_0, iter_52_1 in pairs(arg_52_0) do
		if iter_52_1.status < 1 and iter_52_1.percent >= 100 then
			return true
		end
	end

	return false
end

function ThreeVsThreeLayer.updateTaskAlert(arg_53_0)
	arenatft_manager:get_player_arenatft_task(function(arg_54_0)
		if not var_0_13 then
			return
		end

		if var_0_14(arg_54_0) then
			global_add_alert_tag(arg_53_0.btnTask, {
				x = 163,
				y = 65
			})
		else
			global_remove_alert_tag(arg_53_0.btnTask)
		end
	end)
end

function ThreeVsThreeLayer:fullScreen(arg_55_1)
	self.titleSprite:setPositionY(self.titleSprite:getPositionY() - GameDisplay.fix_y)
	self.bottomList:setPositionY(self.bottomList:getPositionY() - GameDisplay.fix_y)
	self.playerPanel:setPositionY(self.bottomList:getPositionY() + 140)
end
