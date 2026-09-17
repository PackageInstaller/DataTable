PopCommunityIntroduceLayer = class("PopCommunityIntroduceLayer", function()
	return PopBaseLayer:create()
end)

require("view.Sprite.ItemSprite")
require("view.Layer.PopLayer")
require("view.Sprite.AvatarSprite")
require("view.Sprite.ConfirmDialogSprite")

local model_data = require("data.model_data")
local major_factor_data = require("data.major_factor_data")
local item_data = require("data.item_data")
local servant_data = require("data.servant_data")
local community_system_manager = require("controller.community_system_manager")
local level_manager = require("controller.level_manager")
local playermodel = require("model.playermodel")
local family_tag_data = require("data.family_tag_data")
local family_threshold_data = require("data.family_threshold_data")
local family_medal_data = require("data.family_medal_data")
local var_0_10
local var_0_11 = config._DEBUG and 0 or 1
local activity_manager = require("controller.activity_manager")
local var_0_13 = {
	{
		id = 1,
		type = 0,
		context = COMMUNITY_JOINCOMMUNITY.tips1
	},
	{
		id = 2,
		type = 1,
		context = COMMUNITY_JOINCOMMUNITY.tips2
	},
	{
		id = 3,
		type = 2,
		context = COMMUNITY_JOINCOMMUNITY.tips3
	}
}
local var_0_14 = {
	{
		off = "community_system/joinCommunityLayer/info_btn_datail_off.png",
		on = "community_system/joinCommunityLayer/info_btn_datail_on.png"
	},
	{
		off = "community_system/joinCommunityLayer/info_btn_member_off.png",
		on = "community_system/joinCommunityLayer/info_btn_member_on.png"
	}
}
local var_0_15 = {
	"community_system/communityMainLayer/member_shezhang.png",
	"community_system/communityMainLayer/member_fusz.png"
}
local var_0_16 = {
	meberover = "community_system/joinCommunityLayer/info_btn_full.png",
	apply = "community_system/joinCommunityLayer/info_apply.png",
	nomeed = "community_system/joinCommunityLayer/info_btn_dissatisfaction.png",
	notapply = "community_system/joinCommunityLayer/info_btn_noadd.png",
	cancel = "community_system/joinCommunityLayer/info_cancel.png"
}
local var_0_17 = {
	online = cc.c3b(0, 255, 18),
	offline = cc.c3b(0, 0, 0)
}
local var_0_18 = 640
local var_0_19 = 150

function PopCommunityIntroduceLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopCommunityIntroduceLayer.new()

	var_2_0:initBg(arg_2_1)

	return var_2_0
end

function PopCommunityIntroduceLayer:init(arg_3_1)
	var_0_10 = self
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "PopCommunityIntroduceLayer.json" or "PopCommunityIntroduceLayer.ExportJson")

	self.rootLayer:setBackGroundColorOpacity(0)
	self.rootLayer:setContentSize(GameDisplay.getScreenSize())
	self.rootLayer:setPosition(cc.p(0, -GameDisplay.fix_y))
	self:addChild(self.rootLayer, 2)

	self.panel_1 = ccui.Helper:seekWidgetByName(self.rootLayer, "panelinfo")
	self.panel_2 = ccui.Helper:seekWidgetByName(self.rootLayer, "panelmember")
	self.btn_1 = ccui.Helper:seekWidgetByName(self.rootLayer, "btn_info")
	self.btn_2 = ccui.Helper:seekWidgetByName(self.rootLayer, "btn_member")
	self.items = ccui.Helper:seekWidgetByName(self.rootLayer, "add_items")
	self.selectBtn = ccui.Helper:seekWidgetByName(self.rootLayer, "btn_apply")
	self.top_btn = {
		self.btn_1,
		self.btn_2
	}
	self.panels = {
		self.panel_1,
		self.panel_2
	}
	self.rootpanel = ccui.Helper:seekWidgetByName(self.rootLayer, "imagebg")

	self.rootpanel:setCascadeOpacityEnabled(false)
	ccui.Helper:seekWidgetByName(self.rootLayer, "panelbg"):setPositionY(197 + GameDisplay.fix_y)
	self:createFullScreenMask(function(arg_4_0, arg_4_1)
		if arg_4_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.hideActions.shrinkVertical(self, function()
			if not self.isapplylayer and self.callback then
				self.callback()
			end

			LayerManager:removePopLayer(self.__queueindex)
		end)
	end, 0)

	self.topindex = 1
	self.infodata = arg_3_1.data
	self.isapplylayer = arg_3_1.isApplyLayer or nil
	self.familyid = self.infodata.familyid
	self.member = self.infodata.member or 0
	self.status = 1
	self.callback = arg_3_1.callback or nil

	self:initUI()
	global_window_open_action(self.rootpanel)
	self:registerScriptHandler(function(arg_6_0)
		if arg_6_0 == "exit" then
			var_0_10 = nil
		end
	end)
end

function PopCommunityIntroduceLayer:initUI()
	self:addTopBtnListener()
	self:initSelectBtn()
	self:initIntroductionPanel()
	self:initMemberPanel()
	self:updateTopBtn()
end

function PopCommunityIntroduceLayer:addTopBtnListener()
	for iter_8_0, iter_8_1 in pairs(self.top_btn) do
		iter_8_1:addTouchEventListener(function(arg_9_0, arg_9_1)
			if arg_9_1 ~= ccui.TouchEventType.ended then
				return
			end

			if self.topindex == iter_8_0 then
				return
			end

			self.topindex = iter_8_0

			self:updateTopBtn()
		end)
	end
end

function PopCommunityIntroduceLayer:initSelectBtn()
	self.selectBtn:setLocalZOrder(10)
	self.selectBtn:setVisible(false)
	self.selectBtn:addTouchEventListener(function(arg_11_0, arg_11_1)
		if arg_11_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self:checkSelectStatus() then
			if self.status == 1 then
				global_basic_scene:addChild(ConfirmDialogSprite:create("", COMMUNITY_POPCOMMUNITYINTRODUCELAYER.tips11 .. "\"" .. self.infodata.familyname .. "\"" .. "?", {
					headImage = "community_system/joinCommunityLayer/tips_jiaru.png",
					layerType = "CommunityMainLayer",
					assgin = 2,
					surecallback = function()
						community_system_manager:apply_join_family(self.familyid, function(arg_14_0)
							if arg_14_0.result == 1 then
								if var_0_10 then
									if not self.isapplylayer then
										community_system_manager:updateCommunityStatus(self.familyid, 0)
									end

									if arg_14_0.type == 1 then
										global_ShowBlockWords(COMMUNITY_POPCOMMUNITYINTRODUCELAYER.tips1)
										self:exit()
									elseif arg_14_0.type == 2 then
										global_ShowBlockWords(COMMUNITY_POPCOMMUNITYINTRODUCELAYER.tips2)
										LayerManager:switchShowLayer("CommunityMainLayer")
									end
								end
							elseif arg_14_0.result == 11 then
								global_ShowBlockWords(COMMUNITY_POPCOMMUNITYINTRODUCELAYER.tips3)
							elseif arg_14_0.result == 12 then
								global_ShowBlockWords((string.format(COMMUNITY_POPCOMMUNITYINTRODUCELAYER.tips4, community_system_manager:getNextApplyTimeSting())))
							elseif arg_14_0.result == 13 then
								global_ShowBlockWords(COMMUNITY_POPCOMMUNITYINTRODUCELAYER.tips5)
							elseif arg_14_0.result == 14 then
								global_ShowBlockWords(COMMUNITY_POPCOMMUNITYINTRODUCELAYER.tips6)
							elseif arg_14_0.result == 15 then
								global_ShowBlockWords(COMMUNITY_POPCOMMUNITYINTRODUCELAYER.tips7)
							elseif arg_14_0.result == 16 then
								global_ShowBlockWords(COMMUNITY_POPCOMMUNITYINTRODUCELAYER.tips8)
							elseif arg_14_0.result == 17 then
								global_ShowBlockWords(COMMUNITY_POPCOMMUNITYINTRODUCELAYER.tips9)
							elseif arg_14_0.result == 18 then
								global_ShowBlockWords(COMMUNITY_POPCOMMUNITYINTRODUCELAYER.tips10)
							end
						end)
					end,
					cancelcallback = function()
						return
					end
				}), 999)
			else
				community_system_manager:cancel_family_application(self.familyid, function(arg_15_0)
					if arg_15_0.result == 1 then
						if var_0_10 then
							global_ShowBlockWords(COMMUNITY_POPCOMMUNITYINTRODUCELAYER.tips12)

							if not self.isapplylayer then
								community_system_manager:updateCommunityStatus(self.familyid, 3)
							end

							self:exit()
						end
					else
						global_ShowBlockWords(COMMUNITY_POPCOMMUNITYINTRODUCELAYER.tips13)
					end
				end, self.status)
			end
		else
			return
		end
	end)
end

function PopCommunityIntroduceLayer:checkSelectStatus(arg_16_1)
	if not self.infodata then
		return false
	end

	if self.infodata.audit_type and self.infodata.audit_type == 2 then
		if not arg_16_1 then
			global_ShowBlockWords(COMMUNITY_POPCOMMUNITYINTRODUCELAYER.tips8)
		end

		return false, 3
	end

	if self.infodata.threshold_type and self.infodata.threshold_value and self.infodata.threshold_type ~= 0 then
		if playermodel.class >= self.infodata.threshold_value then
			if self.infodata.member and self.infodata.max_member then
				if self.infodata.member >= self.infodata.max_member then
					if not arg_16_1 then
						global_ShowBlockWords(COMMUNITY_POPCOMMUNITYINTRODUCELAYER.tips9)
					end

					return false, 2
				else
					return true, 1
				end
			else
				return true, 1
			end
		else
			if not arg_16_1 then
				global_ShowBlockWords(COMMUNITY_POPCOMMUNITYINTRODUCELAYER.tips7)
			end

			return false, 4
		end
	elseif self.infodata.member and self.infodata.max_member then
		if self.infodata.member >= self.infodata.max_member then
			if not arg_16_1 then
				global_ShowBlockWords(COMMUNITY_POPCOMMUNITYINTRODUCELAYER.tips10)
			end

			return false, 2
		else
			return true, 1
		end
	else
		return true, 1
	end
end

function PopCommunityIntroduceLayer:initIntroductionPanel()
	self.introductiontop = ccui.Helper:seekWidgetByName(self.panel_1, "toppanel")
	self.introductiondown = ccui.Helper:seekWidgetByName(self.panel_1, "downpanel")
	self.medal = ccui.Helper:seekWidgetByName(self.introductiontop, "medeal")
	self.communityname = ccui.Helper:seekWidgetByName(self.introductiontop, "name")
	self.communityid = ccui.Helper:seekWidgetByName(self.introductiontop, "communityid")
	self.lable1 = ccui.Helper:seekWidgetByName(self.introductiontop, "img_lable_1")
	self.lable2 = ccui.Helper:seekWidgetByName(self.introductiontop, "img_lable_2")
	self.lable3 = ccui.Helper:seekWidgetByName(self.introductiontop, "img_lable_3")
	self.levelbg = ccui.Helper:seekWidgetByName(self.introductiondown, "img_1")
	self.memberbg = ccui.Helper:seekWidgetByName(self.introductiondown, "img_2")
	self.activebg = ccui.Helper:seekWidgetByName(self.introductiondown, "img_3")
	self.conditionbg = ccui.Helper:seekWidgetByName(self.introductiondown, "img_4")
	self.verificationbg = ccui.Helper:seekWidgetByName(self.introductiondown, "img_5")
	self.declarationbg = ccui.Helper:seekWidgetByName(self.introductiondown, "Image_16")
	self.declaration = ccui.Helper:seekWidgetByName(self.declarationbg, "Label_19")

	ccui.Helper:seekWidgetByName(self.declarationbg, "Label_18"):setString("社团宣言")
	self.declaration:getVirtualRenderer():setMaxLineWidth(510)
	self.declaration:setString("")

	self.lables = {
		self.lable1,
		self.lable2,
		self.lable3
	}

	for iter_17_0, iter_17_1 in ipairs(self.lables) do
		iter_17_1:setVisible(false)
	end
end

function PopCommunityIntroduceLayer:initMemberPanel()
	self.membernum = ccui.Helper:seekWidgetByName(self.panel_2, "Label_140")
	self.tablelayer = ccui.Helper:seekWidgetByName(self.panel_2, "tableviewlayer")

	self.membernum:setString("")
end

function PopCommunityIntroduceLayer.dealWithID(arg_19_0, arg_19_1)
	if not arg_19_1 then
		return ""
	end

	if "" .. arg_19_1 then
		local var_19_0 = 0

		for iter_19_0 in ("" .. arg_19_1):gmatch("%d") do
			var_19_0 = var_19_0 + 1
		end

		if var_19_0 - 5 >= 0 then
			return arg_19_1
		else
			local var_19_1 = arg_19_1

			for iter_19_1 = 1, -1 * (var_19_0 - 5) do
				var_19_1 = "0" .. var_19_1
			end

			return var_19_1
		end
	else
		return arg_19_1
	end
end

function PopCommunityIntroduceLayer:updateIntroductionPanel()
	if not self.infodata or not next(self.infodata) then
		return
	end

	local var_20_0 = self.infodata

	self:initCommunityImage(self.medal, self.infodata.flag)
	self.communityname:setString(var_20_0.familyname)
	self.communityid:setString("编号:" .. self:dealWithID(var_20_0.familyid))
	self.levelbg:getChildByName("name2"):setString("等级" .. var_20_0.level)
	self.memberbg:getChildByName("name2"):setString(var_20_0.member)

	if var_20_0.active then
		self.activebg:getChildByName("name2"):setString(global_trans_number(var_20_0.active))
	else
		self.activebg:getChildByName("name2"):setString("")
	end

	if var_20_0.threshold_type then
		if var_20_0.threshold_type == 0 then
			self.conditionbg:getChildByName("name2"):setString(COMMUNITY_JOINCOMMUNITY.tips7)
		elseif var_20_0.threshold_type == 1 then
			self.conditionbg:getChildByName("name2"):setString(self:getThresholdValueString(var_20_0.threshold_type, var_20_0.threshold_value))
		elseif var_20_0.threshold_type == 2 then
			-- block empty
		end
	else
		self.conditionbg:getChildByName("name2"):setString("")
	end

	if var_20_0.audit_type then
		self.verificationbg:getChildByName("name2"):setString(var_0_13[var_20_0.audit_type + 1].context)
	else
		self.verificationbg:getChildByName("name2"):setString("")
	end

	if var_20_0.slogan then
		self.declaration:setString(var_20_0.slogan)
	else
		self.declaration:setString("")
	end

	self:updateCommunityLable(community_system_manager:deCodeTagsData(var_20_0.tags))
	self:updateSelectBtn()
end

function PopCommunityIntroduceLayer.initCommunityImage(arg_21_0, arg_21_1, arg_21_2)
	if not arg_21_2 or not arg_21_1 then
		return
	end

	arg_21_1:loadTexture((family_medal_data[arg_21_2] or nil) and "equipment/family/" .. family_medal_data[arg_21_2].image_id .. ".png")
end

function PopCommunityIntroduceLayer.getThresholdValueString(arg_22_0, arg_22_1, arg_22_2)
	if not arg_22_2 or not arg_22_1 then
		return ""
	end

	local var_22_0 = ""

	for iter_22_0, iter_22_1 in pairs(family_threshold_data) do
		if iter_22_1.type == arg_22_1 and iter_22_1.cond == arg_22_2 then
			var_22_0 = iter_22_1.des
		end
	end

	return var_22_0
end

function PopCommunityIntroduceLayer:updateCommunityLable(arg_23_1)
	if not arg_23_1 then
		return
	end

	for iter_23_0 = 1, 3 do
		if arg_23_1[iter_23_0] and family_tag_data[arg_23_1[iter_23_0]] then
			self.lables[iter_23_0]:setVisible(true)
			self.lables[iter_23_0]:getChildByName("labelname"):setString(family_tag_data[arg_23_1[iter_23_0]].des)
		else
			self.lables[iter_23_0]:setVisible(false)
		end
	end

	if #arg_23_1 == 1 then
		self.lables[1]:setPositionX(589)
	elseif #arg_23_1 == 2 then
		self.lables[1]:setPositionX(522)
		self.lables[2]:setPositionX(589)
	elseif #arg_23_1 == 3 then
		self.lables[1]:setPositionX(454)
		self.lables[2]:setPositionX(522)
		self.lables[3]:setPositionX(589)
	end
end

function PopCommunityIntroduceLayer:updateMemberPanel()
	if self.tablelayer:getChildByName("membertableview") then
		self.tablelayer:getChildByName("membertableview"):removeFromParent()
	end

	if not self.memberdata or not next(self.memberdata) then
		return
	end

	self.tableview1 = self:createTableView(cc.size(self.tablelayer:getContentSize().width, self.tablelayer:getContentSize().height), "membertableview")

	self.tablelayer:addChild(self.tableview1, 1)
	self.tableview1:setPosition(cc.p(0, 0))

	self.roleTableViewhight = self.tablelayer:getContentSize().height

	self:initTableViewMember()
end

function PopCommunityIntroduceLayer:createMemberNode()
	local var_25_0 = self.items:clone()
	local var_25_1 = AvatarSprite:create(tonumber(9200101))

	var_25_1:setPosition(cc.p(10, var_25_0:getContentSize().height / 2 - 70))
	var_25_1:setName("avatar_face_fl")
	var_25_1:setScale(0.75)
	var_25_0:addChild(var_25_1)

	return var_25_0
end

function PopCommunityIntroduceLayer.updatePlayerFace(arg_26_0, arg_26_1, arg_26_2, arg_26_3)
	if not arg_26_1 or not arg_26_2 or not arg_26_3 then
		return
	end

	local var_26_0 = arg_26_1:getChildByName("avatar_face_fl")

	var_26_0:switchShowAvatar(tonumber(arg_26_2))
	var_26_0:addTouchEventListener(function(arg_27_0, arg_27_1)
		if arg_27_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_27_0

		if arg_26_3 <= 0 then
			do return end

			var_27_0 = {
				ishidaddbtn = 1,
				playeruid = arg_26_3
			}
		end

		function var_27_0.callback()
			return
		end

		LayerManager:pushInLayer("PopFriendIntroduceLayer", var_27_0)
	end)
end

function PopCommunityIntroduceLayer.updateClassImage(arg_29_0, arg_29_1, arg_29_2)
	local var_29_0

	if arg_29_2 == 4 then
		var_29_0 = "TopcostLayer/new_master.png"
	elseif arg_29_2 == 3 then
		var_29_0 = "TopcostLayer/new_Univ.png"
	elseif arg_29_2 == 2 then
		var_29_0 = "TopcostLayer/new_Senior.png"
	elseif arg_29_2 == 1 then
		var_29_0 = "TopcostLayer/new_Junior.png"
	end

	arg_29_1:loadTexture(var_29_0, var_0_11)
end

function PopCommunityIntroduceLayer:updateSelectBtn()
	local var_30_0, var_30_1 = self:checkSelectStatus(true)
	local var_30_2 = community_system_manager:getCommunityStatus(self.familyid)

	if var_30_2 and var_30_2 == 0 then
		self.status = 2

		self.selectBtn:loadTextures(var_0_16.cancel, nil, var_0_16.cancel, var_0_11)
	elseif var_30_1 == 1 then
		self.selectBtn:loadTextures(var_0_16.apply, nil, var_0_16.apply, var_0_11)

		self.status = 1
	elseif var_30_1 == 2 then
		self.selectBtn:loadTextures(var_0_16.meberover, nil, var_0_16.meberover, var_0_11)
	elseif var_30_1 == 3 then
		self.selectBtn:loadTextures(var_0_16.notapply, nil, var_0_16.notapply, var_0_11)
	elseif var_30_1 == 4 then
		self.selectBtn:loadTextures(var_0_16.nomeed, nil, var_0_16.nomeed, var_0_11)
	end

	self.selectBtn:setVisible(true)
end

function PopCommunityIntroduceLayer:initTableViewMember()
	self.tableview1:registerScriptHandler(function(arg_33_0, arg_33_1)
		return var_0_18, var_0_19
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.tableview1:registerScriptHandler(function(arg_32_0, arg_32_1)
		local var_32_0 = arg_32_0:dequeueCell()

		if not var_32_0 then
			var_32_0 = cc.TableViewCell:create()

			local var_32_1 = self:createMemberNode()

			var_32_1:setName("node")
			var_32_1:setPosition(cc.p(5, 0))
			self:updateMemberNode(var_32_1, self.memberdata[arg_32_1 + 1])

			if arg_32_1 <= math.floor(self.roleTableViewhight / var_0_19) then
				var_32_1:setOpacity(0)
				var_32_1:runAction(cc.Sequence:create(cc.DelayTime:create(0.1 * arg_32_1), cc.FadeIn:create(0.1)))
			else
				var_32_1:setOpacity(255)
			end

			var_32_0:addChild(var_32_1)
		else
			local var_32_2 = var_32_0:getChildByName("node")

			var_32_2:setOpacity(255)
			self:updateMemberNode(var_32_2, self.memberdata[arg_32_1 + 1])
		end

		return var_32_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.tableview1:registerScriptHandler(function(arg_34_0, arg_34_1)
		return #self.memberdata
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.tableview1:reloadData()
end

function PopCommunityIntroduceLayer:updateMemberNode(arg_35_1, arg_35_2)
	local var_35_0 = ccui.Helper:seekWidgetByName(arg_35_1, "player_name")
	local var_35_1 = ccui.Helper:seekWidgetByName(arg_35_1, "class_img")
	local var_35_2 = ccui.Helper:seekWidgetByName(arg_35_1, "position")
	local var_35_3 = ccui.Helper:seekWidgetByName(arg_35_1, "online_time")

	var_35_0:setString(arg_35_2.name)
	ccui.Helper:seekWidgetByName(arg_35_1, "level"):setString("等级." .. arg_35_2.level)
	ccui.Helper:seekWidgetByName(arg_35_1, "power"):setString(global_trans_number(arg_35_2.fightpower))

	local var_35_4 = community_system_manager:getThePosition(arg_35_2.title)

	if var_35_4 and var_0_15[var_35_4] then
		var_35_2:loadTexture(var_0_15[var_35_4], var_0_11)
		var_35_2:setVisible(true)
	else
		var_35_2:setVisible(false)
	end

	var_35_2:setPositionX(var_35_0:getPositionX() + var_35_0:getContentSize().width + 10 + var_35_2:getContentSize().width / 2)

	if arg_35_2.lastlogin == "-1" then
		var_35_3:setColor(var_0_17.online)
	else
		var_35_3:setColor(var_0_17.offline)
	end

	var_35_3:setString(community_system_manager:dealTheOnlineTime(arg_35_2.lastlogin))
	self:updatePlayerFace(arg_35_1, arg_35_2.head_sculpture, arg_35_2.playerid)
	self:updateClassImage(var_35_1, arg_35_2.class)
end

function PopCommunityIntroduceLayer.createTableView(arg_36_0, arg_36_1, arg_36_2)
	local var_36_0 = cc.TableView:create(arg_36_1)

	;(nil):setName(arg_36_2)
	var_36_0:setDelegate()
	var_36_0:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	var_36_0:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)

	return var_36_0
end

function PopCommunityIntroduceLayer:updateTopBtn()
	for iter_37_0, iter_37_1 in pairs(self.top_btn) do
		if self.topindex == iter_37_0 then
			iter_37_1:loadTextures(var_0_14[iter_37_0].on, var_0_14[iter_37_0].on, var_0_14[iter_37_0].on, var_0_11)
			self.panels[iter_37_0]:setVisible(true)
			self:updateSelectLayer()
		else
			iter_37_1:loadTextures(var_0_14[iter_37_0].off, var_0_14[iter_37_0].off, var_0_14[iter_37_0].off, var_0_11)
			self.panels[iter_37_0]:setVisible(false)
		end
	end
end

function PopCommunityIntroduceLayer:updateSelectLayer()
	if self.topindex == 1 then
		self:updateIntroductionPanel()
	else
		community_system_manager:get_family_members(self.familyid, function(arg_39_0)
			if var_0_10 then
				if arg_39_0.result == 1 then
					self.memberdata = arg_39_0.list
				end

				self:updateMemberPanel()
			end
		end)
	end
end

function PopCommunityIntroduceLayer:initBg(arg_40_1)
	local var_40_0 = ccui.Layout:create()

	var_40_0:setTouchEnabled(true)
	var_40_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_40_0:setAnchorPoint(cc.p(0, 0))
	var_40_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_40_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_40_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_40_0:setOpacity(0)
	var_40_0:setCascadeOpacityEnabled(false)
	self:addChild(var_40_0, -1)

	local var_40_1 = ccui.ImageView:create("mainScenebg/blur_mask.png")

	var_40_1:setAnchorPoint(cc.p(0.5, 0.5))
	var_40_1:setPositionX(var_40_0:getContentSize().width / 2)
	var_40_1:setPositionY(var_40_0:getContentSize().height / 2)
	var_40_0:addChild(var_40_1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_41_0)
		self:addChild(arg_41_0, -2)
		arg_41_0:setPositionY(arg_41_0:getPositionY() - GameDisplay.fix_y)
		self:init(arg_40_1)
		var_40_0:setOpacity(102)
		var_40_0:setTouchEnabled(false)
	end)
end

function PopCommunityIntroduceLayer:exit()
	self.hideActions.shrinkVertical(self, function()
		if self.callback then
			self.callback()
		end

		LayerManager:removePopLayer(self.__queueindex)
	end)
end
