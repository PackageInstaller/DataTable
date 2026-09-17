CommunityMainLayer = class("CommunityMainLayer", function()
	return cc.Layer:create()
end)

require("view.Sprite.ItemSprite")
require("view.Layer.PopLayer")
require("view.Sprite.AvatarSprite")
require("view.Sprite.ConfirmDialogSprite")

local model_data = require("data.model_data")
local major_factor_data = require("data.major_factor_data")
local item_data = require("data.item_data")
local servant_data = require("data.servant_data")
local score_arena_awards_data = require("data.score_arena_awards_data")
local community_system_manager = require("controller.community_system_manager")
local level_manager = require("controller.level_manager")
local chapter_data = require("data.chapter_data")
local family_tag_data = require("data.family_tag_data")
local family_medal_data = require("data.family_medal_data")
local activity_manager = require("controller.activity_manager")
local var_0_11
local var_0_13 = {
	COMMUNITY_POPCOMMUNITYCOMMUNITYMAINLAYER.tips1,
	COMMUNITY_POPCOMMUNITYCOMMUNITYMAINLAYER.tips2,
	COMMUNITY_POPCOMMUNITYCOMMUNITYMAINLAYER.tips3,
	COMMUNITY_POPCOMMUNITYCOMMUNITYMAINLAYER.tips4,
	COMMUNITY_POPCOMMUNITYCOMMUNITYMAINLAYER.tips5
}
local var_0_14 = COMMUNITY_POPCOMMUNITYCOMMUNITYMAINLAYER.tips6

function CommunityMainLayer.getInstance()
	return var_0_11
end

function CommunityMainLayer.create(arg_3_0, arg_3_1)
	local var_3_0 = CommunityMainLayer.new()

	var_3_0:init(arg_3_1)

	return var_3_0
end

function CommunityMainLayer:init(arg_4_1)
	var_0_11 = self
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "CommunityMainLayer.json" or "CommunityMainLayer.ExportJson")

	self:addChild(self.rootLayer)

	self.toppenel = ccui.Helper:seekWidgetByName(self.rootLayer, "toppanel")
	self.noticepenel = ccui.Helper:seekWidgetByName(self.rootLayer, "noticelayer")
	self.middlepenel = ccui.Helper:seekWidgetByName(self.rootLayer, "middlelayer")
	self.downpenel = ccui.Helper:seekWidgetByName(self.rootLayer, "downlayer")
	self.rolelayer = ccui.Helper:seekWidgetByName(self.rootLayer, "rolelayer")

	self.middlepenel:setLocalZOrder(3)
	self.toppenel:setCascadeOpacityEnabled(false)
	self:fullScreen(self.rootLayer)
	self:initUI()
	self:createChatSprite()
	self:registerActivityEventListener()
	self:getListData()
	self:registerScriptHandler(function(arg_5_0)
		if arg_5_0 == "exit" then
			var_0_11 = nil

			activity_manager:releaseEventListenerByName("CommunityMainLayer")
		end
	end)
end

function CommunityMainLayer:createChatSprite()
	local var_6_0 = require("view.Sprite.chatEntrySprite"):create()

	var_6_0:setName("commitychatEntrySP")
	self:addChild(var_6_0, 1000)
	var_6_0:initScrollChat()

	if require("controller.hexie_manager"):needHexieInput() then
		var_6_0:setVisible(false)
	end
end

function CommunityMainLayer.registerActivityEventListener(arg_7_0)
	activity_manager:registerEventListener("CommunityMainLayer", activity_manager.activityEventId.COMMUNITY_KICK_NOTICE, function(arg_8_0)
		if arg_8_0.familyid and arg_8_0.familyid == community_system_manager:getCurfamilyid() then
			global_ShowBlockWords(COMMUNITY_POPCOMMUNITYCOMMUNITYMAINLAYER.tips7)
			LayerManager:switchShowLayer("joinCommunityLayer")
		end
	end)
	activity_manager:registerEventListener("CommunityMainLayer", activity_manager.activityEventId.COMMUNITY_CHANGE_POSITION, function(arg_9_0)
		if arg_9_0.familyid and arg_9_0.familyid == community_system_manager:getCurfamilyid() then
			global_ShowBlockWords(COMMUNITY_POPCOMMUNITYCOMMUNITYMAINLAYER.tips8)

			if var_0_11 then
				arg_7_0:getListData()
			end
		end
	end)
	activity_manager:registerEventListener("CommunityMainLayer", activity_manager.activityEventId.COMMUNITY_WISH_NEW_AWARD, function(arg_10_0)
		if arg_10_0.tp and var_0_11 then
			arg_7_0:updateMiddleLayer()
		end
	end)
end

function CommunityMainLayer.getListData(arg_11_0, arg_11_1)
	community_system_manager:get_family_base_info(function(arg_12_0)
		if arg_12_0.result == 1 then
			if var_0_11 then
				arg_11_0.data = arg_12_0

				arg_11_0:updateUILayer()
			end
		elseif arg_12_0.result == 9999 then
			global_ShowBlockWords("社团系统已关闭~~")
			LayerManager:switchShowLayer("MainLayer")
		end
	end)
end

function CommunityMainLayer:initUI()
	self:initTopInfoLayer()
	self:initNoticesLayer()
	self:initMiddleLayer()
	self:initDownLayer()
	self:initRoleTalklayer()
end

function CommunityMainLayer:updateUILayer()
	self:updateTopInfoLayer()
	self:updateDownLayer()
	self:updateNoticesLayer()
	self:updateMiddleLayer()

	if self.data.active_weekly then
		self.ptpont:setString(COMMUNITY_POPCOMMUNITYCOMMUNITYMAINLAYER.huoyue .. global_trans_number(self.data.active_weekly))
	end

	self.commitycoin:setString(COMMUNITY_POPCOMMUNITYCOMMUNITYMAINLAYER.coin .. global_trans_number(community_system_manager:getCommityCoinNum()))
end

function CommunityMainLayer:updateMiddleLayer()
	if self.activityred then
		if community_system_manager:isHaveRewardget() or community_system_manager:getRecordRedStatus() or community_system_manager:haveCommpeletAwardTask() then
			self.activityred:setVisible(true)
		else
			self.activityred:setVisible(false)
		end
	end
end

function CommunityMainLayer:initTopInfoLayer()
	self.medalimg = ccui.Helper:seekWidgetByName(self.toppenel, "medal")
	self.communityname = ccui.Helper:seekWidgetByName(self.toppenel, "Label_7")
	self.communityid = ccui.Helper:seekWidgetByName(self.toppenel, "conmid")
	self.memberbg = ccui.Helper:seekWidgetByName(self.toppenel, "memberbg")
	self.moneybg = ccui.Helper:seekWidgetByName(self.toppenel, "money")
	self.expbg = ccui.Helper:seekWidgetByName(self.toppenel, "exp_di")
	self.member = ccui.Helper:seekWidgetByName(self.memberbg, "Label_19")
	self.money = ccui.Helper:seekWidgetByName(self.moneybg, "Label_19")
	self.label_1 = ccui.Helper:seekWidgetByName(self.toppenel, "lable_img_1")
	self.label_2 = ccui.Helper:seekWidgetByName(self.toppenel, "lable_img_2")
	self.label_3 = ccui.Helper:seekWidgetByName(self.toppenel, "lable_img_3")
	self.level = ccui.Helper:seekWidgetByName(self.expbg, "Label_42")
	self.levelpress = ccui.Helper:seekWidgetByName(self.expbg, "ProgressBar_39")
	self.levelpont = ccui.Helper:seekWidgetByName(self.expbg, "point")
	self.btn_info = ccui.Helper:seekWidgetByName(self.toppenel, "btn_info")
	self.labels = {
		self.label_1,
		self.label_2,
		self.label_3
	}

	for iter_16_0, iter_16_1 in pairs(self.labels) do
		iter_16_1:setVisible(false)
	end

	self.member:setString("")
	self.money:setString("")
	self.level:setString("")
	self.levelpress:setPercent(0)
	self.btn_info:addTouchEventListener(function(arg_17_0, arg_17_1)
		if arg_17_1 ~= ccui.TouchEventType.ended then
			return
		end

		arg_17_0:setBright(false)

		local var_17_0 = {
			callback = function()
				if var_0_11 then
					arg_17_0:setBright(true)
				end
			end
		}

		var_17_0.key = "community_rule"

		if not require("data.detail_data")[var_17_0.key] then
			print("error:----------------> detail_data.lua is no data for this layer  找策划填写规则表")
		else
			LayerManager:pushInLayer("PopActivityDetail", var_17_0)
		end
	end)
end

function CommunityMainLayer:initNoticesLayer()
	self.noticelabel = ccui.Helper:seekWidgetByName(self.noticepenel, "Label_29")
	self.edit_btn = ccui.Helper:seekWidgetByName(self.noticepenel, "btn_edit")

	self.noticelabel:setString(var_0_14)
	self.noticelabel:getVirtualRenderer():setMaxLineWidth(374)
	self.noticelabel:getVirtualRenderer():setLineBreakWithoutSpace(true)
	self.edit_btn:setVisible(false)
	self.edit_btn:addTouchEventListener(function(arg_20_0, arg_20_1)
		local var_20_0

		if arg_20_1 ~= ccui.TouchEventType.ended then
			do return end

			var_20_0 = {
				familyid = self.data.familyid,
				notice = self.noticelabel:getString()
			}
		end

		function var_20_0.callback(arg_21_0)
			if var_0_11 then
				self.noticelabel:setString(arg_21_0)
			end
		end

		LayerManager:pushInLayer("PopCommunityNoticesLayer", var_20_0)
	end)
end

function CommunityMainLayer:updateMemberBtnAlert()
	if not self.data or not self.data.title then
		return
	end

	if not self.data or not self.data.title or self.data.title == 10 then
		if self.member_btn then
			global_remove_alert_tag(self.member_btn)
		end
	elseif community_system_manager:getApplyStatus() and self.member_btn then
		global_add_alert_tag(self.member_btn, (cc.p(100, 140)))
	elseif self.btn_manage then
		global_remove_alert_tag(self.member_btn)
	end
end

function CommunityMainLayer:initMiddleLayer()
	self.base_btn = ccui.Helper:seekWidgetByName(self.middlepenel, "btn_base")
	self.task_btn = ccui.Helper:seekWidgetByName(self.middlepenel, "btn_task")
	self.shop_btn = ccui.Helper:seekWidgetByName(self.middlepenel, "Button_34")
	self.ptpont = ccui.Helper:seekWidgetByName(self.task_btn, "Label_36")
	self.activityred = ccui.Helper:seekWidgetByName(self.task_btn, "Image_27")
	self.commitycoin = ccui.Helper:seekWidgetByName(self.shop_btn, "Label_24")

	self.ptpont:setString("")
	self.activityred:setVisible(false)
	self.shop_btn:getChildByName("Image_26"):setVisible(false)
	self.task_btn:addTouchEventListener(function(arg_24_0, arg_24_1)
		if arg_24_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:switchShowLayer("CommunityTaskShowLayer")
	end)
	self.shop_btn:addTouchEventListener(function(arg_26_0, arg_26_1)
		if arg_26_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:switchShowLayer("MarketLayer", {
			singleMarket = {
				"1-123000"
			}
		})
	end)
end

function CommunityMainLayer:initDownLayer()
	self.member_btn = ccui.Helper:seekWidgetByName(self.downpenel, "btn_member")
	self.log_btn = ccui.Helper:seekWidgetByName(self.downpenel, "btn_log")
	self.set_btn = ccui.Helper:seekWidgetByName(self.downpenel, "btn_shop")

	self.set_btn:setLocalZOrder(100)
	self.set_btn:setSwallowTouches(true)

	self.setbtnlayer = ccui.Helper:seekWidgetByName(self.downpenel, "setbtnlayer")

	self.member_btn:addTouchEventListener(function(arg_28_0, arg_28_1)
		if arg_28_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:switchShowLayer("CommunityMemberLayer", {
			familyid = self.data.familyid,
			positon = self.data.title
		})
	end)
	self.log_btn:addTouchEventListener(function(arg_29_0, arg_29_1)
		local var_29_0

		if arg_29_1 ~= ccui.TouchEventType.ended then
			do return end

			var_29_0 = {}
		end

		function var_29_0.callback()
			if var_0_11 then
				self:updateMemberMaxAndMoney()
			end
		end

		LayerManager:pushInLayer("PopCommunityBulidingLayer", var_29_0)
	end)
	self.set_btn:addTouchEventListener(function(arg_31_0, arg_31_1)
		if arg_31_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.setbtnlayer:setVisible(not self.setbtnlayer:isVisible())
	end)
	self:intSettingLayer()
end

function CommunityMainLayer:intSettingLayer()
	self.vloging = ccui.Helper:seekWidgetByName(self.downpenel, "btn_vlog")
	self.setting = ccui.Helper:seekWidgetByName(self.downpenel, "btn_set")
	self.finding = ccui.Helper:seekWidgetByName(self.downpenel, "btn_find")
	self.dissolution = ccui.Helper:seekWidgetByName(self.downpenel, "btn_dissolution")
	self.outing = ccui.Helper:seekWidgetByName(self.downpenel, "btn_out")

	self.vloging:setVisible(false)
	self.setting:setVisible(false)
	self.finding:setVisible(false)
	self.dissolution:setVisible(false)
	self.outing:setVisible(false)
	self.vloging:getChildByName("Label_49"):setString(var_0_13[1])
	self.setting:getChildByName("Label_49"):setString(var_0_13[2])
	self.finding:getChildByName("Label_49"):setString(var_0_13[3])
	self.dissolution:getChildByName("Label_49"):setString(var_0_13[4])
	self.outing:getChildByName("Label_49"):setString(var_0_13[5])
	self.vloging:addTouchEventListener(function(arg_33_0, arg_33_1)
		if arg_33_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopCommunityVlogLayer")
	end)
	self.setting:addTouchEventListener(function(arg_34_0, arg_34_1)
		local var_34_0

		if arg_34_1 ~= ccui.TouchEventType.ended then
			do return end

			var_34_0 = {
				data = self.data
			}
		end

		function var_34_0.callback(arg_35_0, arg_35_1, arg_35_2, arg_35_3, arg_35_4)
			self:getListData()
		end

		LayerManager:pushInLayer("PopCommunitySettingLayer", var_34_0)
	end)
	self.finding:addTouchEventListener(function(arg_36_0, arg_36_1)
		if arg_36_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:switchShowLayer("joinCommunityLayer", {
			showbottom = true
		})
	end)
	self.dissolution:addTouchEventListener(function(arg_37_0, arg_37_1)
		if arg_37_1 ~= ccui.TouchEventType.ended then
			return
		end

		local function var_37_0()
			community_system_manager:leave_family(function(arg_39_0)
				if var_0_11 then
					if arg_39_0.result == 1 then
						global_ShowBlockWords(COMMUNITY_POPCOMMUNITYCOMMUNITYMAINLAYER.tips10)
						community_system_manager:resetAllStatus()
						community_system_manager:get_family_data()
						LayerManager:switchShowLayer("joinCommunityLayer")
					elseif arg_39_0.result == 11 then
						global_ShowBlockWords("")
					end
				end
			end)
		end

		if self.data and self.data.member and self.data.member == 1 then
			(function()
				global_basic_scene:addChild(ConfirmDialogSprite:create("", COMMUNITY_POPCOMMUNITYCOMMUNITYMAINLAYER.tips13, {
					layerType = "CommunityMainLayer",
					headImage = "community_system/joinCommunityLayer/tips_jiesuan.png",
					assgin = 1,
					surecallback = var_37_0,
					cancelcallback = function()
						return
					end,
					btntext = {
						yes = COMMUNITY_POPCOMMUNITYCOMMUNITYMAINLAYER.tips11,
						no = COMMUNITY_POPCOMMUNITYCOMMUNITYMAINLAYER.tips12
					}
				}), 999)
			end)()
		else
			global_ShowBlockWords(COMMUNITY_POPCOMMUNITYCOMMUNITYMAINLAYER.tips14)
		end
	end)
	self.outing:addTouchEventListener(function(arg_43_0, arg_43_1)
		if arg_43_1 ~= ccui.TouchEventType.ended then
			return
		end

		local function var_43_0()
			community_system_manager:leave_family(function(arg_45_0)
				if var_0_11 then
					if arg_45_0.result == 1 then
						global_ShowBlockWords(COMMUNITY_POPCOMMUNITYCOMMUNITYMAINLAYER.tips15)
						community_system_manager:resetAllStatus()
						community_system_manager:get_family_data()
						LayerManager:switchShowLayer("joinCommunityLayer")
					elseif arg_45_0.result == 11 then
						global_ShowBlockWords(COMMUNITY_POPCOMMUNITYCOMMUNITYMAINLAYER.tips16)
					end
				end
			end)
		end

		;(function()
			global_basic_scene:addChild(ConfirmDialogSprite:create("", string.format(COMMUNITY_POPCOMMUNITYCOMMUNITYMAINLAYER.tips18, community_system_manager:getKickPepoleTime()), {
				layerType = "CommunityMainLayer",
				headImage = "community_system/joinCommunityLayer/tips_tuichu.png",
				assgin = 1,
				surecallback = var_43_0,
				cancelcallback = function()
					return
				end,
				btntext = {
					yes = COMMUNITY_POPCOMMUNITYCOMMUNITYMAINLAYER.tips17,
					no = COMMUNITY_POPCOMMUNITYCOMMUNITYMAINLAYER.tips12
				}
			}), 999)
		end)()
	end)

	local var_32_0 = cc.EventListenerTouchOneByOne:create()

	var_32_0:setSwallowTouches(false)
	var_32_0:registerScriptHandler(function(arg_49_0, arg_49_1)
		if LayerManager:getCurrentLayerName() ~= "CommunityMainLayer" then
			return false
		end

		if self.setbtnlayer:isVisible() then
			return true
		else
			return false
		end
	end, cc.Handler.EVENT_TOUCH_BEGAN)
	var_32_0:registerScriptHandler(function(arg_50_0, arg_50_1)
		self.setbtnlayer:setVisible(not self.setbtnlayer:isVisible())
	end, cc.Handler.EVENT_TOUCH_ENDED)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(var_32_0, self.setbtnlayer)
end

function CommunityMainLayer:initRoleTalklayer()
	self.talkbg = ccui.Helper:seekWidgetByName(self.rolelayer, "talkbg")
	self.talklevel = ccui.Helper:seekWidgetByName(self.talkbg, "Label_43")

	self.talkbg:setVisible(true)
	self.talklevel:setPositionX(self.talklevel:getPositionX() - 20)
	self.talklevel:getVirtualRenderer():setMaxLineWidth(200)

	self.talkdata = community_system_manager:getTalklayerDataByType(2)

	if not self.talkdata then
		return
	end

	self.id = 1
	self.role = nil
	self.nowjsonfile, self.nowatlasfile = nil

	local function var_51_0()
		if self.id > #self.talkdata then
			self.id = 1
		end

		if self.rolelayer:getChildByName("node_eeeee") then
			self.rolelayer:getChildByName("node_eeeee"):removeFromParent()
		end

		local var_52_0 = self.talkdata[self.id].modelid
		local var_52_1 = self.talkdata[self.id].offx or 0
		local var_52_2 = self.talkdata[self.id].offy or 0
		local var_52_3 = self.talkdata[self.id].scale or 0.5

		self.talklevel:setString(self.talkdata[self.id].des)

		local var_52_4 = cc.Node:create()

		var_52_4:setName("node_eeeee")
		self.rolelayer:addChild(var_52_4, -1)

		if model_data[self.talkdata[self.id].modelid].rolespine and self.talkdata[self.id].ani then
			self.role = L2Skeleton:create(ROLE_SPINE_PATH .. model_data[self.talkdata[self.id].modelid].rolespine .. ".json", ROLE_SPINE_PATH .. model_data[self.talkdata[self.id].modelid].rolespine .. ".atlas")

			self.role:refreshSkeleton()
			self.role:play(self.talkdata[self.id].ani, true)
			self.role:setName("rolepp")

			self.nowjsonfile = ROLE_SPINE_PATH .. model_data[self.talkdata[self.id].modelid].rolespine .. ".json"
			self.nowatlasfile = ROLE_SPINE_PATH .. model_data[self.talkdata[self.id].modelid].rolespine .. ".atlas"
		else
			self.role = ccui.ImageView:create(ROLE_IMAGE_PATH .. model_data[var_52_0].role_image .. ".png")

			self.role:setName("rolepp")
		end

		self.role:setScale(var_52_3)
		self.role:setPosition(cc.p(160 + var_52_1, 468 + var_52_2))
		var_52_4:addChild(self.role, -1)

		self.id = self.id + 1
	end

	self.rootLayer:addTouchEventListener(function(arg_53_0, arg_53_1)
		if arg_53_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_51_0()
	end)
	var_51_0()
end

function CommunityMainLayer:initShowgirl()
	local playermodel = require("model.playermodel")

	self.showgirlLayer = require("view.Layer.ShowGirlLayer"):create(playermodel.showgirl, SHOW_DORM)

	self.rolelayer:addChild(self.showgirlLayer, -1)
	self.showgirlLayer:setPositionX(-200)
end

function CommunityMainLayer.dealWithID(arg_58_0, arg_58_1)
	if not arg_58_1 then
		return ""
	end

	if "" .. arg_58_1 then
		local var_58_0 = 0

		for iter_58_0 in ("" .. arg_58_1):gmatch("%d") do
			var_58_0 = var_58_0 + 1
		end

		if var_58_0 - 5 >= 0 then
			return arg_58_1
		else
			local var_58_1 = arg_58_1

			for iter_58_1 = 1, -1 * (var_58_0 - 5) do
				var_58_1 = "0" .. var_58_1
			end

			return var_58_1
		end
	else
		return arg_58_1
	end
end

function CommunityMainLayer:updateTopInfoLayer()
	if not self.data then
		return
	end

	local var_59_0 = community_system_manager:getNextLevelNeedExp(self.data.level)

	self.communityname:setString(self.data.familyname)

	local var_59_1 = community_system_manager:getMaxMember()

	if var_59_1 and var_59_1 ~= "" then
		self.member:setString(self.data.member .. "/" .. var_59_1)
	else
		self.member:setString(self.data.member)
	end

	if self.data.money then
		self.money:setString(global_trans_number(self.data.money))
	else
		self.money:setString("0")
	end

	self.communityid:setString("编号:" .. self:dealWithID(self.data.familyid))
	self.level:setString("等级." .. self.data.level)
	self.levelpress:setPercent(self.data.exp / var_59_0 * 100)
	self.levelpont:setPositionX(105 + self.data.exp / var_59_0 * 241)

	if self.data.level >= community_system_manager:getMaxCommunityLevel() then
		self.levelpress:setPercent(100)
		self.levelpont:setPositionX(346)
	end

	self:updateMedalImage()
	self:updateCommunityLable()
end

function CommunityMainLayer:updateMemberMaxAndMoney()
	local var_60_0 = community_system_manager:getMaxMember()

	if var_60_0 and var_60_0 ~= "" then
		self.member:setString(self.data.member .. "/" .. var_60_0)
	else
		self.member:setString(self.data.member)
	end

	local var_60_1 = community_system_manager:getCommunityMoney()

	if var_60_1 then
		self.money:setString(global_trans_number(var_60_1))
	else
		self.money:setString("0")
	end
end

function CommunityMainLayer:updateMedalImage()
	if not self.data.flag then
		return
	end

	local var_61_0 = "equipment/family/communitymedal1.png"

	if family_medal_data[self.data.flag] then
		var_61_0 = "equipment/family/" .. family_medal_data[self.data.flag].image_id .. ".png"
	end

	self.medalimg:loadTextures(var_61_0, var_61_0, var_61_0)

	if self.data and self.data.title == 100 then
		self.medalimg:setTouchEnabled(true)
	else
		self.medalimg:setTouchEnabled(false)
	end

	self.medalimg:addTouchEventListener(function(arg_62_0, arg_62_1)
		local var_62_0

		if arg_62_1 ~= ccui.TouchEventType.ended then
			do return end

			var_62_0 = {
				data = self.data
			}
		end

		function var_62_0.callback(arg_63_0, arg_63_1, arg_63_2, arg_63_3, arg_63_4)
			self:getListData()
		end

		LayerManager:pushInLayer("PopCommunitySettingLayer", var_62_0)
	end)
end

function CommunityMainLayer:updateMedalData(arg_64_1)
	if not self.data or not self.data.flag or not arg_64_1 then
		return
	end

	self.data.flag = arg_64_1

	self:updateMedalImage()
end

function CommunityMainLayer:updateCommunityLable()
	if not self.data.tags then
		return
	end

	local var_65_0 = community_system_manager:deCodeTagsData(self.data.tags)

	for iter_65_0 = 1, 3 do
		if var_65_0[iter_65_0] then
			self.labels[iter_65_0]:setVisible(true)

			if family_tag_data[var_65_0[iter_65_0]] and family_tag_data[var_65_0[iter_65_0]].des then
				self.labels[iter_65_0]:getChildByName("name"):setString(family_tag_data[var_65_0[iter_65_0]].des)
			else
				self.labels[iter_65_0]:getChildByName("name"):setString(family_tag_data[1].des)
			end
		else
			self.labels[iter_65_0]:setVisible(false)
		end
	end
end

function CommunityMainLayer:updateDownLayer()
	if not self.data.title then
		return
	end

	self:updateSettingLayer()
	self:updateMemberBtnAlert()
end

function CommunityMainLayer:updateNoticesLayer()
	if self.data.title == 100 or self.data.title == 90 then
		self.edit_btn:setVisible(true)
	else
		self.edit_btn:setVisible(false)
	end

	if not self.data.notice then
		return
	end

	if self.data.notice ~= "" then
		self.noticelabel:setString(self.data.notice)
	end
end

function CommunityMainLayer:updateSettingLayer()
	self.setbtnlayer:setScale9Enabled(true)

	local var_68_0 = community_system_manager:getThePosition(self.data.title)

	if var_68_0 then
		if var_68_0 == 1 then
			self.vloging:setVisible(true)
			self.setting:setVisible(true)
			self.finding:setVisible(true)
			self.dissolution:setVisible(true)
			self.outing:setVisible(false)
			self.vloging:setPositionY(177)
			self.setting:setPositionY(125)
			self.finding:setPositionY(75)
			self.dissolution:setPositionY(24)
			self.setbtnlayer:setContentSize(cc.size(147, 200))
			self.setbtnlayer:setPositionY(350)
		else
			self.vloging:setVisible(true)
			self.setting:setVisible(false)
			self.finding:setVisible(true)
			self.dissolution:setVisible(false)
			self.outing:setVisible(true)
			self.vloging:setPositionY(124)
			self.finding:setPositionY(72)
			self.outing:setPositionY(20)
			self.setbtnlayer:setContentSize(cc.size(147, 150))
			self.setbtnlayer:setPositionY(350)
		end
	else
		self.vloging:setVisible(true)
		self.setting:setVisible(false)
		self.finding:setVisible(true)
		self.dissolution:setVisible(false)
		self.outing:setVisible(true)
		self.finding:setPositionY(77)
		self.outing:setPositionY(31)
		self.setbtnlayer:setContentSize(cc.size(147, 100))
		self.setbtnlayer:setPositionY(229)
	end
end

function CommunityMainLayer:fullScreen(arg_69_1)
	local var_69_0 = GameDisplay.getScreenSize()

	arg_69_1:setContentSize(var_69_0)
	arg_69_1:setPositionY(arg_69_1:getPositionY() - GameDisplay.fix_y)
	self.toppenel:setPositionY(var_69_0.height - self.toppenel:getContentSize().height / 2)
	self.noticepenel:setPositionY(self.toppenel:getPositionY() - 130 - GameDisplay.fix_y)
	self.middlepenel:setPositionY(self.middlepenel:getPositionY() - GameDisplay.fix_y)
	self.rolelayer:setPositionY(self.rolelayer:getPositionY() + 2 * GameDisplay.fix_y)
	self.middlepenel:setPositionY(self.middlepenel:getPositionY() + 2 * GameDisplay.fix_y)
end
