PopFriendIntroduceLayer = class("PopFriendIntroduceLayer", function()
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
local score_arena_awards_data = require("data.score_arena_awards_data")
local friend_system_manager = require("controller.friend_system_manager")
local level_manager = require("controller.level_manager")
local bond_manager = require("controller.bond_manager")
local chapter_data = require("data.chapter_data")
local substitution_manager = require("controller.substitution_manager")
local fight_capacity_manager = require("controller.fight_capacity_manager")
local var_0_11 = config._DEBUG and 0 or 1
local activity_manager = require("controller.activity_manager")
local var_0_13 = (GameDisplay.getUiScreenSize().height - config._DESIGN_HEIGHT) * 0.8
local var_0_14 = {
	"equipment/medal1.png",
	"equipment/medal2.png",
	"equipment/medal3.png",
	"equipment/medal4.png",
	"equipment/medal5.png",
	"equipment/medal6.png"
}
local var_0_15 = {
	cc.c4b(240, 240, 240, 150),
	cc.c4b(54, 255, 82, 150),
	cc.c4b(56, 122, 255, 150),
	cc.c4b(255, 12, 246, 150),
	cc.c4b(255, 84, 0, 150),
	cc.c4b(255, 0, 0, 150)
}
local var_0_17 = {
	"friendsystem/info_panel1_bg.png",
	"friendsystem/info_panel2_bg.png",
	"friendsystem/info_panel3_bg.png"
}
local var_0_18 = {
	{
		off = "friendsystem/info_btn_jj_off.png",
		on = "friendsystem/info_btn_jj_on.png"
	},
	{
		off = "friendsystem/info_btn_ll_off.png",
		on = "friendsystem/info_btn_ll_on.png"
	},
	{
		off = "friendsystem/info_btn_dw_off.png",
		on = "friendsystem/info_btn_dw_on.png"
	}
}
local var_0_19 = {
	delet = "friendsystem/info_btn_remove.png",
	apply = "friendsystem/info_btn_apply.png",
	appling = "friendsystem/info_btn_ing.png"
}
local var_0_20 = {
	{
		subname1 = "",
		name = ""
	},
	{
		subname1 = "进攻阵容",
		name = "抢位赛"
	},
	{
		subname1 = "前锋队",
		name = "团体赛",
		subname2 = "近卫队",
		subname3 = "压阵队"
	},
	{
		subname1 = "队伍一",
		name = "超频战场",
		subname2 = "队伍二",
		subname5 = "队伍五",
		subname3 = "队伍三",
		subname4 = "队伍四"
	}
}

function PopFriendIntroduceLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopFriendIntroduceLayer.new()

	var_2_0:initBg(arg_2_1)

	return var_2_0
end

function PopFriendIntroduceLayer:init(arg_3_1)
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "PopFriendIntroduceLayer.json" or "PopFriendIntroduceLayer.ExportJson")

	self.rootLayer:setBackGroundColorOpacity(0)
	self.rootLayer:setContentSize(GameDisplay.getScreenSize())
	self.rootLayer:setPosition(cc.p(0, -GameDisplay.fix_y))
	self:addChild(self.rootLayer, 2)

	self.panel_1 = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_jianjie")
	self.panel_2 = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_liuli")
	self.lahei = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_67")
	self.panel_3 = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_showpvp")
	self.btn_1 = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_jianjie")
	self.btn_2 = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_luli")
	self.btn_3 = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_pvp")
	self.btn_select = ccui.Helper:seekWidgetByName(self.rootLayer, "btn_select")
	self.items = ccui.Helper:seekWidgetByName(self.rootLayer, "array_items")
	self.listview = ccui.Helper:seekWidgetByName(self.panel_3, "ListView_146")
	self.top_btn = {
		self.btn_1,
		self.btn_2,
		self.btn_3
	}
	self.panels = {
		self.panel_1,
		self.panel_2,
		self.panel_3
	}
	self.rootpanel = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_bg")

	self.rootpanel:setCascadeOpacityEnabled(false)
	self.btn_3:setVisible(false)
	ccui.Helper:seekWidgetByName(self.rootLayer, "panel_bg"):setPositionY(250 + GameDisplay.fix_y)
	self:createFullScreenMask(function(arg_4_0, arg_4_1)
		if arg_4_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_4_0:isBright() then
			return
		end

		arg_4_0:setBright(false)
		self.hideActions.shrinkVertical(self, function()
			LayerManager:removePopLayer(self.__queueindex)
		end)
	end, 0)

	if arg_3_1 then
		if arg_3_1.callback then
			self.callback = arg_3_1.callback or nil
		end

		if arg_3_1.select_index then
			self.select_index = arg_3_1.select_index or 1
		end

		self.playeruid = arg_3_1.playeruid
		self.layername = arg_3_1.layerName
		self.openlalei = arg_3_1.openlalei
		self.reportinfo = arg_3_1.reportinfo
		self.ishidaddbtn = arg_3_1.ishidaddbtn
		self.Submode = arg_3_1.submodemode
		self.pvptype = arg_3_1.pvptype
		self.showType = arg_3_1.showType
	else
		self.select_index = 1
	end

	if self.openlalei then
		self.lahei:setVisible(true)
		self.lahei:addTouchEventListener(function(arg_6_0, arg_6_1)
			if arg_6_1 ~= ccui.TouchEventType.ended then
				return
			end

			LayerManager:pushInLayer("PopCommunityChartReportLayer", {
				playerinfo = self.reportinfo
			})
		end)
		self.btn_select:setVisible(false)
	else
		self.lahei:setVisible(false)
	end

	if self.pvptype then
		self.btn_3:setVisible(true)

		self.select_index = 3
	else
		self.btn_3:setVisible(false)

		self.select_index = 1
	end

	if self.ishidaddbtn then
		self.btn_select:setVisible(false)
	end

	for iter_3_0, iter_3_1 in ipairs(self.top_btn) do
		iter_3_1:addTouchEventListener(function(arg_7_0, arg_7_1)
			if arg_7_1 ~= ccui.TouchEventType.ended then
				return
			end

			self.select_index = iter_3_0

			self:updateTopBtn(self.select_index)
		end)
	end

	self:getListData()
	global_window_open_action(self.rootpanel)
	self:registerScriptHandler(function(arg_8_0)
		if arg_8_0 == "exit" then
			-- block empty
		end
	end)
end

function PopFriendIntroduceLayer:initUIByManual()
	local var_9_0 = self:getPanelData()

	self.dorm_visit = ccui.Button:create("friendsystem/drom_visit_btn.png", nil, "friendsystem/drom_visit_btn.png", var_0_11)

	self.btn_select:getParent():addChild(self.dorm_visit)
	self.dorm_visit:addTouchEventListener(function(arg_10_0, arg_10_1)
		if arg_10_1 ~= ccui.TouchEventType.ended then
			return
		end

		arg_10_0.isLock = true

		friend_system_manager:getFriendDormData(var_9_0.playerid, function(arg_11_0)
			if arg_11_0.result == 1 then
				LayerManager:pushInLayer("DormVisitLayer", {
					name = self.data.name,
					msg = arg_11_0,
					playerid = var_9_0.playerid,
					faceid = var_9_0.head_sculpture
				})
			else
				arg_10_0.isLock = false
			end
		end)
	end)

	if self.status == 1 then
		self.chat_btn = ccui.Button:create("friendsystem/friend_chat.png", nil, "friendsystem/friend_chat.png", var_0_11)

		self.chat_btn:setScale9Enabled(true)
		self.chat_btn:setContentSize(self.btn_select:getContentSize())
		self.btn_select:getParent():addChild(self.chat_btn)
		self.chat_btn:addTouchEventListener(function(arg_12_0, arg_12_1)
			if arg_12_1 ~= ccui.TouchEventType.ended then
				return
			end

			LayerManager:pushInLayer("PopChatInterfaceLayer", {
				friendid = var_9_0.playerid
			})
		end)
	end

	self:updateBtnsPos()
end

function PopFriendIntroduceLayer:updateBtnsPos()
	local var_13_0 = self.dorm_visit:getParent():getContentSize().width / 2

	if self.openlalei or self.ishidaddbtn then
		self.chat_btn:setVisible(false)
		self.dorm_visit:setPosition(var_13_0, self.btn_select:getPositionY())

		if self.showType == 1 then
			self.dorm_visit:setVisible(false)
		else
			self.dorm_visit:setVisible(true)
		end
	elseif self.status == 1 then
		self.btn_select:setPositionX(var_13_0 - 150)
		self.chat_btn:setPosition(var_13_0, self.btn_select:getPositionY())
		self.dorm_visit:setPosition(var_13_0 + 150, self.btn_select:getPositionY())

		if self.showType == 1 then
			self.dorm_visit:setVisible(false)
			self.btn_select:setPositionX(var_13_0 - 75)
			self.chat_btn:setPosition(var_13_0 + 75, self.btn_select:getPositionY())
		else
			self.dorm_visit:setVisible(true)
		end
	elseif self.status == 3 then
		self.btn_select:setPositionX(var_13_0 - 75)
		self.dorm_visit:setPosition(var_13_0 + 75, self.btn_select:getPositionY())

		if self.showType == 1 then
			self.dorm_visit:setVisible(false)
			self.btn_select:setPositionX(var_13_0)
		else
			self.dorm_visit:setVisible(true)
		end
	elseif self.status == -1 then
		if self.data.robot then
			self.dorm_visit:setVisible(false)
		else
			self.btn_select:setPositionX(var_13_0 - 75)
			self.dorm_visit:setPosition(var_13_0 + 75, self.btn_select:getPositionY())

			if self.showType == 1 then
				self.dorm_visit:setVisible(false)
				self.btn_select:setPositionX(var_13_0)
			else
				self.dorm_visit:setVisible(true)
			end
		end
	else
		self.btn_select:setVisible(false)
		self.dorm_visit:setVisible(false)
	end
end

function PopFriendIntroduceLayer:getListData()
	if self.playeruid then
		friend_system_manager:get_friend_information(self.playeruid, function(arg_15_0)
			if arg_15_0.result == 1 then
				self.data = arg_15_0.data
				self.status = arg_15_0.relation

				bond_manager:initEnemyBond(arg_15_0.data.bond)
				self:initUI()
			end
		end)
	end
end

function PopFriendIntroduceLayer:initUI()
	if self.data.robot then
		self.btn_3:setVisible(false)
		self.panel_3:setVisible(false)

		self.select_index = 1
	end

	self:initIntroductionPanel()
	self:initCurriculumPanel()
	self:updateTopBtn(self.select_index)
	self:initFriendBtn()
	self:initUIByManual()
end

function PopFriendIntroduceLayer:initFriendBtn(arg_17_1)
	local var_17_0 = self:getPanelData()

	if not var_17_0 or not next(var_17_0) then
		return
	end

	arg_17_1 = arg_17_1 or self.status

	if arg_17_1 == 1 then
		self.btn_select:loadTextures(var_0_19.delet, nil, var_0_19.delet, var_0_11)
	elseif arg_17_1 == 3 then
		self.btn_select:loadTextures(var_0_19.appling, nil, var_0_19.appling, var_0_11)
	elseif arg_17_1 == -1 then
		self.btn_select:loadTextures(var_0_19.apply, nil, var_0_19.apply, var_0_11)
	else
		self.btn_select:setVisible(false)
	end

	if var_17_0.robot then
		self.btn_select:setVisible(false)

		return
	end

	self:dealWithSelectBtn(arg_17_1, var_17_0.playerid)
end

function PopFriendIntroduceLayer:dealWithSelectBtn(arg_18_1, arg_18_2)
	if not arg_18_1 or not arg_18_2 then
		return
	end

	if arg_18_1 == -1 then
		self.btn_select:addTouchEventListener(function(arg_19_0, arg_19_1)
			if arg_19_1 ~= ccui.TouchEventType.ended then
				return
			end

			friend_system_manager:apply_add_friend(arg_18_2, function(arg_20_0)
				if arg_20_0.result == 1 then
					global_ShowBlockWords(L_FRIEND_MANAGEMENT_LAYER.add_friend_success)
					self:initFriendBtn(3)

					self.status = 3
				elseif arg_20_0.result == 2 then
					global_ShowBlockWords(L_FRIEND_MANAGEMENT_LAYER.add_max_limit)
				elseif arg_20_0.result == 3 then
					global_ShowBlockWords(L_FRIEND_MANAGEMENT_LAYER.add_is_friend)
				elseif arg_20_0.result == 4 then
					global_ShowBlockWords(L_FRIEND_MANAGEMENT_LAYER.add_is_self)
				elseif arg_20_0.result == 5 then
					global_ShowBlockWords(L_FRIEND_MANAGEMENT_LAYER.apply_list_limit)
				else
					global_ShowBlockWords(L_FRIEND_MANAGEMENT_LAYER.add_friend_fail)
				end
			end)
		end)
	elseif arg_18_1 == 1 then
		local function var_18_0()
			friend_system_manager:delete_add_friend(arg_18_2, function(arg_22_0)
				if arg_22_0.result == 1 then
					global_ShowBlockWords(L_FRIEND_INTRODUCE_LAYER.delet_friend_success)
					self:initFriendBtn(-1)

					self.status = -1

					if self.callback then
						self.callback()
					end
				else
					global_ShowBlockWords(L_FRIEND_INTRODUCE_LAYER.delet_friend_fail)
				end
			end)
		end

		local function var_18_1()
			self:addChild(ConfirmDialogSprite:create("", L_FRIEND_INTRODUCE_LAYER.delet_sure_tips, {
				headImage = "friendsystem/info_remove_title.png",
				layerType = "PopFriendIntroduceLayer",
				surecallback = var_18_0,
				cancelcallback = function()
					return
				end
			}), 999)
		end

		self.btn_select:addTouchEventListener(function(arg_26_0, arg_26_1)
			if arg_26_1 ~= ccui.TouchEventType.ended then
				return
			end

			var_18_1()
		end)
	elseif arg_18_1 == 3 then
		self.btn_select:addTouchEventListener(function(arg_27_0, arg_27_1)
			if arg_27_1 ~= ccui.TouchEventType.ended then
				return
			end

			global_ShowBlockWords(L_FRIEND_INTRODUCE_LAYER.applying_tips)
		end)
	end
end

function PopFriendIntroduceLayer:updateTopBtn(arg_28_1)
	if not arg_28_1 then
		return
	end

	self.rootpanel:loadTexture(var_0_17[arg_28_1], var_0_11)
	;(function()
		for iter_29_0 = 1, #self.top_btn do
			if iter_29_0 == self.select_index then
				self.top_btn[iter_29_0]:loadTextures(var_0_18[iter_29_0].on, var_0_18[iter_29_0].on, var_0_18[iter_29_0].on, var_0_11)
				self.panels[iter_29_0]:setVisible(true)
			else
				self.top_btn[iter_29_0]:loadTextures(var_0_18[iter_29_0].off, var_0_18[iter_29_0].off, var_0_18[iter_29_0].off, var_0_11)
				self.panels[iter_29_0]:setVisible(false)
			end
		end
	end)()

	if arg_28_1 ~= 3 or self.pvptype == 1 then
		-- block empty
	elseif self.pvptype == 2 then
		friend_system_manager:get_someone_array(1, self.playeruid, function(arg_30_0)
			if arg_30_0 and type(arg_30_0) == "table" then
				self.pvpdata = arg_30_0
			end

			self:initPVPPanel()
		end)
	elseif self.pvptype == 3 then
		friend_system_manager:get_enemy_defence_array(self.playeruid, function(arg_31_0)
			if arg_31_0 and type(arg_31_0) == "table" then
				self.pvpdata = arg_31_0
			end

			self:initPVPPanel()
		end)
	elseif self.pvptype == 4 then
		substitution_manager:get_substitution_battlearray_data(self.Submode, self.playeruid, function(arg_32_0)
			if arg_32_0 and type(arg_32_0) == "table" then
				self.pvpdata = arg_32_0
			end

			self:initPVPPanel()
		end)
	end
end

function PopFriendIntroduceLayer:initPVPPanel()
	local var_33_0 = self:getPanelData()

	if not var_33_0 or not next(var_33_0) then
		print("no  data !!!!!!!!!!!")
	end

	local var_33_1 = ccui.Helper:seekWidgetByName(self.panel_3, "panel_top")
	local var_33_2 = ccui.Helper:seekWidgetByName(var_33_1, "img_class")
	local var_33_3 = ccui.Helper:seekWidgetByName(var_33_1, "Label_23")
	local var_33_4 = ccui.Helper:seekWidgetByName(var_33_1, "Label_24")
	local var_33_5 = ccui.Helper:seekWidgetByName(var_33_1, "face_node")

	ccui.Helper:seekWidgetByName(var_33_1, "label_name"):setString(var_33_0.name)

	if not var_33_0.level then
		var_33_3:setString(" ")
	else
		var_33_3:setString("等级." .. var_33_0.level)
	end

	if not var_33_0.grade then
		var_33_4:setString("")
	else
		var_33_4:setString(var_33_0.grade)

		local var_33_6 = var_33_0.grade

		if var_33_0.grade < 0 then
			var_33_6 = -var_33_6
		end

		if var_33_6 < 1000 then
			var_33_4:setString(string.format("%04d", var_33_6))
		else
			var_33_4:setString(var_33_6)
		end
	end

	ccui.Helper:seekWidgetByName(var_33_1, "Label_63"):setString(L_FRIEND_INTRODUCE_LAYER.class_lable)
	self:initPlayerFace(var_33_0.head_sculpture, var_33_5)
	self:initPlayerGrade(var_33_0.class, var_33_2)
	self.listview:removeAllChildren()
	self.listview:setItemsMargin(1)

	if not self.pvpdata then
		return
	end

	if self.pvptype == 1 then
		-- block empty
	elseif self.pvptype == 2 then
		local var_33_7 = self.items:clone()

		self:updateArrayNode3(var_33_7, self.pvpdata, 1, friend_system_manager:getFrindArrayCapacityData(2, 1))
		self.listview:pushBackCustomItem(var_33_7)
	elseif self.pvptype == 3 then
		local var_33_8 = 1

		while self.pvpdata[var_33_8] do
			local var_33_9 = self.items:clone()

			self:updateArrayNode3(var_33_9, self.pvpdata[var_33_8].battlearray, var_33_8, self.pvpdata[var_33_8].fightpower)
			self.listview:pushBackCustomItem(var_33_9)

			var_33_8 = var_33_8 + 1
		end
	elseif self.pvptype == 4 then
		local var_33_10 = 1

		while self.pvpdata["array_" .. var_33_10] do
			local var_33_11 = self.items:clone()

			self:updateArrayNode3(var_33_11, self.pvpdata["array_" .. var_33_10].array, var_33_10)
			self.listview:pushBackCustomItem(var_33_11)

			var_33_10 = var_33_10 + 1
		end
	end
end

function PopFriendIntroduceLayer:updateArrayNode3(arg_34_1, arg_34_2, arg_34_3, arg_34_4)
	local var_34_0 = arg_34_1:getChildByName("arrayname")
	local var_34_1 = arg_34_1:getChildByName("arrayname_1")
	local var_34_2 = arg_34_1:getChildByName("fightpower")
	local var_34_3 = arg_34_1:getChildByName("array_edit")
	local var_34_4 = arg_34_1:getChildByName("add_btn")

	var_34_2:getVirtualRenderer():setBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA)
	var_34_0:setString(var_0_20[self.pvptype].name)
	var_34_1:setString(var_0_20[self.pvptype]["subname" .. arg_34_3])
	var_34_0:setPositionX(var_34_2:getPositionX() + 10 + var_34_2:getContentSize().width)
	var_34_1:setPositionX(var_34_0:getPositionX() + 10 + var_34_0:getContentSize().width)

	if arg_34_4 then
		var_34_2:setString(global_trans_bitmapnumber(arg_34_4))
	else
		var_34_2:setString(global_trans_bitmapnumber((fight_capacity_manager:getSubUsingArrayFightCapacity((substitution_manager:getSubArraysData(arg_34_3))))))
	end

	for iter_34_0 = 1, FORMATION_SHOW_GIRL_NUM do
		local var_34_5 = ccui.Helper:seekWidgetByName(arg_34_1, "pos_" .. iter_34_0)
		local var_34_6 = ccui.Helper:seekWidgetByName(var_34_5, "level")
		local var_34_7 = ccui.Helper:seekWidgetByName(var_34_5, "class")
		local var_34_8 = ccui.Helper:seekWidgetByName(var_34_5, "level_bg")
		local var_34_9 = ccui.Helper:seekWidgetByName(var_34_5, "add_btn")

		var_34_9:setVisible(false)

		if arg_34_2[iter_34_0] and arg_34_2[iter_34_0].servantid then
			var_34_8:setVisible(true)
			var_34_7:setVisible(true)
			var_34_7:setScale(0.3)
			var_34_9:setVisible(true)
			var_34_7:loadTexture("Array/icon_" .. global_get_all_servant_attrs(arg_34_2[iter_34_0].servantid).main .. ".png", var_0_11)
			var_34_7:setScale(0.65)
			var_34_6:setString("等级" .. arg_34_2[iter_34_0].servantlevel)

			local var_34_10 = self:createArrayRole(arg_34_2[iter_34_0].servantid)

			var_34_10:setPosition(cc.p(var_34_5:getContentSize().width / 2, var_34_5:getContentSize().height / 2))
			var_34_5:addChild(var_34_10)
		else
			var_34_8:setVisible(false)
			var_34_7:setVisible(false)
			var_34_9:setVisible(false)
		end
	end

	var_34_3.id = arg_34_3

	var_34_3:addTouchEventListener(function(arg_35_0, arg_35_1)
		if arg_35_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("ShowFrinendArrayLayer", {
			mode = self.mode,
			configtype = CONFIG_TYPE_SUBSTITUTION,
			arraydata = self.pvpdata,
			infotype = self.pvptype,
			initindex = arg_35_0.id
		})
	end)
	var_34_3:setVisible(false)
end

function PopFriendIntroduceLayer.createArrayRole(arg_36_0, arg_36_1)
	if not arg_36_1 then
		return
	end

	local var_36_0 = servant_data[arg_36_1].modelid

	if not servant_data[arg_36_1].modelid then
		return
	end

	local var_36_1 = model_data[var_36_0].portrait_image
	local var_36_2 = ccui.ImageView:create("GUI/image.png", var_0_11)

	var_36_2:setAnchorPoint(cc.p(0.5, 0.5))
	var_36_2:setScale(60 / var_36_2:getContentSize().height)
	var_36_2:setName("girlHeadImg")
	var_36_2:loadTexture(ROLE_PORTRAIT_PATH .. var_36_1 .. ".png")

	return var_36_2
end

function PopFriendIntroduceLayer:getPanelData()
	return self.data
end

function PopFriendIntroduceLayer:initIntroductionPanel()
	local var_38_0 = self:getPanelData()

	if not var_38_0 or not next(var_38_0) then
		print("no  data !!!!!!!!!!!")
	end

	local var_38_1 = ccui.Helper:seekWidgetByName(self.panel_1, "panel_top")
	local var_38_2 = ccui.Helper:seekWidgetByName(self.panel_1, "panel_down")
	local var_38_3 = ccui.Helper:seekWidgetByName(var_38_1, "label_name")
	local var_38_4 = ccui.Helper:seekWidgetByName(var_38_1, "label_uid")
	local var_38_5 = ccui.Helper:seekWidgetByName(var_38_1, "img_class")
	local var_38_6 = ccui.Helper:seekWidgetByName(var_38_1, "Label_23")
	local var_38_7 = ccui.Helper:seekWidgetByName(var_38_1, "Label_24")
	local var_38_8 = ccui.Helper:seekWidgetByName(var_38_1, "Label_25")
	local var_38_9 = ccui.Helper:seekWidgetByName(var_38_1, "face_node")
	local var_38_10 = ccui.Helper:seekWidgetByName(var_38_2, "Label_59")
	local var_38_11 = ccui.Helper:seekWidgetByName(var_38_1, "img_class_bg_0")
	local var_38_12 = ccui.Helper:seekWidgetByName(var_38_11, "Label_24")

	var_38_12:setColor(cc.c3b(255, 255, 255))
	ccui.Helper:seekWidgetByName(var_38_11, "Label_63"):setString(COMMUNITY_CHAT_SYSTEM.tips13)

	if var_38_0.familyname then
		if var_38_0.familyname ~= "" then
			var_38_12:setString(var_38_0.familyname)
		else
			var_38_12:setString(COMMUNITY_POPCOMMUNITYDONATIONLAYER.tips5)
			var_38_12:setColor(cc.c3b(128, 122, 123))
		end
	else
		var_38_12:setString(COMMUNITY_POPCOMMUNITYDONATIONLAYER.tips5)
		var_38_12:setColor(cc.c3b(128, 122, 123))
	end

	var_38_8:setVisible(false)

	self.btn_bondBuff = ccui.Button:create("Array/btn_effect_bond.png", "Array/btn_effect_bond.png", "Array/btn_effect_bond.png", var_0_11)

	self.btn_bondBuff:setPosition(cc.p(470, 220))
	var_38_2:addChild(self.btn_bondBuff)
	self.btn_bondBuff:setTouchEnabled(true)
	self.btn_bondBuff:addTouchEventListener(function(arg_39_0, arg_39_1)
		if arg_39_1 ~= ccui.TouchEventType.ended then
			return
		end

		print("羁绊效果弹窗")
		LayerManager:pushInLayer("PopActivityDetail", {
			type = 1,
			key = "bond_detail"
		})
	end)

	local var_38_13 = ccui.ImageView:create("Array/btn_effect_bond.png", var_0_11)
	local var_38_14 = self.btn_bondBuff:getContentSize()

	var_38_13:setPosition(var_38_14.width / 2, var_38_14.height / 2)
	self.btn_bondBuff:addChild(var_38_13)
	self.btn_bondBuff:setVisible(false)

	if true == false then
		var_38_13:setVisible(true)
		var_38_13:stopAllActions()
		var_38_13:runAction((cc.RepeatForever:create(cc.Sequence:create(cc.DelayTime:create(0.2), cc.CallFunc:create(function()
			var_38_13:setScale(1)
			var_38_13:setOpacity(255)
		end), cc.Spawn:create(cc.ScaleTo:create(0.5, 1.3), cc.FadeOut:create(0.5)), cc.DelayTime:create(0.6)))))
	else
		var_38_13:setVisible(false)
		var_38_13:stopAllActions()
		var_38_13:setOpacity(255)
		var_38_13:setScale(1)
	end

	ccui.Helper:seekWidgetByName(var_38_1, "Label_63"):setString(L_FRIEND_INTRODUCE_LAYER.class_lable)
	var_38_10:getVirtualRenderer():setBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA)
	ccui.Helper:seekWidgetByName(var_38_2, "Label_57"):setString(L_FRIEND_INTRODUCE_LAYER.array_tips)
	var_38_2:setCascadeOpacityEnabled(false)
	var_38_3:setString(var_38_0.name)
	var_38_4:setAnchorPoint(cc.p(1, 0.5))
	var_38_4:setPositionX(530)

	if var_38_0.robot then
		var_38_4:setString("")
	else
		var_38_4:setString("编号:" .. var_38_0.playerid)
	end

	if not var_38_0.level then
		var_38_6:setString(" ")
	else
		var_38_6:setString("等级." .. var_38_0.level)
	end

	if not var_38_0.grade then
		var_38_7:setString("")
	else
		var_38_7:setString(var_38_0.grade)

		local var_38_15 = var_38_0.grade

		if var_38_0.grade < 0 then
			var_38_15 = -var_38_15
		end

		if var_38_15 < 1000 then
			var_38_7:setString(string.format("%04d", var_38_15))
		else
			var_38_7:setString(var_38_15)
		end
	end

	if not var_38_0.array.fightpower then
		var_38_10:setString("")
	else
		var_38_10:setString(global_trans_bitmapnumber(var_38_0.array.fightpower))
	end

	self:initPlayerFace(var_38_0.head_sculpture, var_38_9)
	self:initPlayerGrade(var_38_0.class, var_38_5)
	self:initPlayerMedal(var_38_0.medals, var_38_1)
	self:initPlayerArray(var_38_0.array.fight_girls, var_38_2)
	self:createPersonalSignature(var_38_1, var_38_0.signment)
end

function PopFriendIntroduceLayer.createPersonalSignature(arg_41_0, arg_41_1, arg_41_2)
	local var_41_1 = "<p>" .. "<span style=color: rgb(78, 140, 255);>" .. L_FRIEND_INTRODUCE_LAYER.sigment_tips .. "</span>" .. "<span style=color: rgb(105, 140, 204);>" .. ((not arg_41_2 or arg_41_2 == "") and L_FRIEND_INTRODUCE_LAYER.no_signment_tips or arg_41_2) .. "</span></p>"

	if arg_41_1:getChildByName("richTextWord") then
		arg_41_1:getChildByName("richTextWord"):removeFromParent()
	end

	local var_41_2 = require("view.Sprite.RichTextPro"):create()

	var_41_2:setMaxWidth(320)
	var_41_2:setSize(20)
	var_41_2:setLineSpace(0)
	var_41_2:setText(var_41_1, nil, true)
	var_41_2:setName("richTextWord")
	var_41_2:setPosition(cc.p(204, 46))
	arg_41_1:addChild(var_41_2)
end

function PopFriendIntroduceLayer.initPlayerFace(arg_42_0, arg_42_1, arg_42_2)
	if not arg_42_1 or not arg_42_2 then
		return
	end

	if not arg_42_2:getChildByName("avatar_face") then
		local var_42_0 = AvatarSprite:create(tonumber(arg_42_1))

		var_42_0:setPosition(cc.p(-60, -26))
		var_42_0:setName("avatar_face")
		var_42_0:setScale(0.65)
		arg_42_2:addChild(var_42_0)
	else
		arg_42_2:getChildByName("avatar_face"):switchShowAvatar(tonumber(arg_42_1))
	end
end

function PopFriendIntroduceLayer.initPlayerGrade(arg_43_0, arg_43_1, arg_43_2)
	if not arg_43_1 or not arg_43_2 then
		return
	end

	local var_43_0

	if arg_43_1 == 5 then
		var_43_0 = "TopcostLayer/new_doctor.png"
	elseif arg_43_1 == 4 then
		var_43_0 = "TopcostLayer/new_master.png"
	elseif arg_43_1 == 3 then
		var_43_0 = "TopcostLayer/new_Univ.png"
	elseif arg_43_1 == 2 then
		var_43_0 = "TopcostLayer/new_Senior.png"
	elseif arg_43_1 == 1 then
		var_43_0 = "TopcostLayer/new_Junior.png"
	end

	arg_43_2:loadTexture(var_43_0, var_0_11)
end

function PopFriendIntroduceLayer.initPlayerMedal(arg_44_0, arg_44_1, arg_44_2)
	if not arg_44_1 or not next(arg_44_1) or not arg_44_2 then
		return
	end

	local var_44_0 = {}

	for iter_44_0 = 1, 3 do
		local var_44_1 = arg_44_2:getChildByName("medal_" .. iter_44_0)

		if arg_44_1[iter_44_0] and arg_44_1[iter_44_0] ~= 0 then
			table.insert(var_44_0, iter_44_0)
			var_44_1:setVisible(true)

			local var_44_2 = item_data[arg_44_1[iter_44_0]] or item_data[9100011]

			var_44_1:loadTexture((var_44_2.bg or nil) and ("equipment/" .. var_44_2.bg .. ".png" or var_0_14[var_44_2.equip_quality]))
			var_44_1:getChildByName("medalname"):setString(var_44_2.name)
			var_44_1:getChildByName("medalname"):setFontSize(50)
			var_44_1:getChildByName("medalname"):enableOutline(var_0_15[var_44_2.equip_quality], 1)
			var_44_1:getChildByName("medalname"):enableShadow(var_0_15[var_44_2.equip_quality], cc.size(0, 0))
			var_44_1:setScale(0.8)
			var_44_1:getChildByName("medalname"):setPosition(cc.p(var_44_1:getContentSize().width * var_44_1:getScaleX() / 2 + 10, var_44_1:getContentSize().height * var_44_1:getScaleX() / 2 + 6))
			var_44_1:setPositionY(22)
			var_44_1:getChildByName("medalname"):setVisible(var_44_2.only_bg ~= 1)
		else
			var_44_1:setScale(0.5)
			var_44_1:setPositionY(19)
		end
	end
end

function PopFriendIntroduceLayer.initPlayerArray(arg_45_0, arg_45_1, arg_45_2)
	if not arg_45_1 or not next(arg_45_1) or not arg_45_2 then
		return
	end

	for iter_45_0 = 1, FORMATION_SHOW_GIRL_NUM do
		local var_45_0 = iter_45_0
		local var_45_1 = arg_45_1[iter_45_0]

		if arg_45_1[iter_45_0] then
			local var_45_2 = ccui.Helper:seekWidgetByName(arg_45_2, "pos" .. var_45_0)

			ccui.Helper:seekWidgetByName(arg_45_2, "lv_bg_" .. var_45_0):setCascadeOpacityEnabled(false)

			if var_45_1.modelid and var_45_1.modelid ~= -1 and var_45_1.modelid ~= "-1" and var_45_1.modelid ~= "nil" then
				if model_data[var_45_1.modelid] then
					TextureManager:loadImageViewTexture("PopFriendIntroduceLayer", var_45_2, CUTE_ROLE_IMAGE_PATH .. model_data[var_45_1.modelid].cute_role .. ".png")
				end

				if not config._DEBUG then
					var_45_2:setPositionY(140)
				end
			else
				var_45_2:loadTexture("friendsystem/info_array_no.png", var_0_11)

				if not config._DEBUG then
					var_45_2:setPositionY(117)
				end
			end

			local var_45_3 = ccui.Helper:seekWidgetByName(arg_45_2, "Label_level" .. var_45_0)
			local var_45_4 = ccui.Helper:seekWidgetByName(arg_45_2, "lv_bg_" .. var_45_0)
			local var_45_5 = ccui.Helper:seekWidgetByName(arg_45_2, "Image_jieji" .. var_45_0)

			if var_45_1.level ~= nil and var_45_1.level >= 0 then
				local var_45_6 = var_45_1.rank or 0
				local var_45_7 = var_45_5:getChildByName("breakoutIcon")

				if var_45_7 then
					var_45_7:loadTexture("public/rolebg/breakout_" .. var_45_6 .. ".png", var_0_11)
				else
					var_45_7 = ccui.ImageView:create("public/rolebg/breakout_" .. var_45_6 .. ".png", var_0_11)

					var_45_7:setAnchorPoint(cc.p(0.5, 0.5))
					var_45_7:setPosition(cc.p(var_45_5:getContentSize().width / 2, var_45_5:getContentSize().height / 2))
					var_45_7:setName("breakoutIcon")
					var_45_7:setScale(0.6)
					var_45_5:addChild(var_45_7, 10)
				end

				var_45_7:setVisible(var_45_6 >= 0)
				var_45_5:setVisible(var_45_6 >= 0)
				var_45_3:setString("等级." .. var_45_1.level)
				var_45_3:setVisible(true)
				var_45_4:setVisible(true)
			else
				var_45_5:setVisible(false)
				var_45_3:setString("等级...")
			end
		end
	end
end

function PopFriendIntroduceLayer:initCurriculumPanel()
	local var_46_0 = self:getPanelData()

	if not var_46_0 or not next(var_46_0) then
		print("no  data !!!!!!!!!!!")
	end

	local var_46_1 = ccui.Helper:seekWidgetByName(self.panel_2, "img_bg_jifen")
	local var_46_2 = ccui.Helper:seekWidgetByName(self.panel_2, "img_bg_qangwei")
	local var_46_3 = ccui.Helper:seekWidgetByName(self.panel_2, "img_bg_guangka")
	local var_46_4 = ccui.Helper:seekWidgetByName(self.panel_2, "img_bg_xueyuan")
	local var_46_5 = ccui.Helper:seekWidgetByName(var_46_1, "Image_73")
	local var_46_6 = ccui.Helper:seekWidgetByName(var_46_2, "Label_70_5")
	local var_46_7 = ccui.Helper:seekWidgetByName(var_46_3, "Label_70_2")
	local var_46_8 = ccui.Helper:seekWidgetByName(var_46_3, "Label_70_0_0")
	local var_46_9 = ccui.Helper:seekWidgetByName(var_46_4, "Label_70_2")

	var_46_6:getVirtualRenderer():setBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA)
	var_46_7:getVirtualRenderer():setBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA)
	var_46_8:getVirtualRenderer():setBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA)
	var_46_9:getVirtualRenderer():setBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA)
	var_46_6:setScale(0.7)
	var_46_8:setScale(0.7)
	var_46_9:setScale(0.7)

	if not var_46_0.areanrank then
		var_46_6:setString("")
	else
		var_46_6:setString(var_46_0.areanrank)

		if var_46_0.areanrank == -1 then
			var_46_6:setString(L_FRIEND_INTRODUCE_LAYER.no_rank_arean)
		end
	end

	if not var_46_0.mainchapter then
		var_46_7:setString("")
		var_46_8:setString("")
	else
		local var_46_10

		if chapter_data[var_46_0.mainchapter] then
			var_46_10 = chapter_data[var_46_0.mainchapter].name
		end

		if var_46_10 then
			var_46_7:setString(var_46_10)
		end

		local var_46_11

		do
			var_46_7:setString(var_46_0.mainchapter)

			var_46_11 = {}
		end

		for iter_46_0 in var_46_0.mainchapter:gmatch("%d+") do
			table.insert(var_46_11, iter_46_0)
		end

		if var_46_11[1] then
			local var_46_12 = level_manager:getDifficultByMode(tonumber(var_46_11[1]))

			if var_46_12 then
				var_46_8:setString(L_MODE_DIFFICULTY[var_46_12])

				if L_MODE_DIFFICULTY[var_46_12] == "" then
					var_46_7:setScale(0.7)
					var_46_7:setPositionY(50)
				else
					var_46_7:setScale(0.5)
					var_46_7:setPositionY(26)
				end
			else
				var_46_8:setString("")
			end
		else
			var_46_8:setString("")
		end
	end

	if not var_46_0.rolenum then
		var_46_9:setString("")
	else
		var_46_9:setString(var_46_0.rolenum)
	end

	self:initItemsTitle({
		var_46_1,
		var_46_2,
		var_46_3,
		var_46_4
	})
	self:initPlayerDw(var_46_0.arenascore, var_46_5)
end

function PopFriendIntroduceLayer.initItemsTitle(arg_47_0, arg_47_1)
	if not arg_47_1 or not next(arg_47_1) then
		return
	end

	for iter_47_0, iter_47_1 in pairs(arg_47_1) do
		local var_47_0 = ccui.Helper:seekWidgetByName(iter_47_1, "Label_70")
		local var_47_1 = ccui.Helper:seekWidgetByName(iter_47_1, "Label_70_0")

		var_47_0:setString("")
		var_47_1:setString("")
	end
end

function PopFriendIntroduceLayer.initPlayerDw(arg_48_0, arg_48_1, arg_48_2)
	if not arg_48_1 or not arg_48_2 then
		arg_48_2:setVisible(false)

		return
	end

	arg_48_2:setVisible(true)

	local var_48_0 = 5

	for iter_48_0, iter_48_1 in pairs(score_arena_awards_data) do
		if arg_48_1 >= iter_48_1.min and arg_48_1 <= iter_48_1.max then
			var_48_0 = iter_48_0

			break
		end
	end

	arg_48_2:loadTexture("arenascenenew/duanwei" .. "_" .. var_48_0 .. ".png", var_0_11)
end

function PopFriendIntroduceLayer:initBg(arg_49_1)
	local var_49_0 = ccui.Layout:create()

	var_49_0:setTouchEnabled(true)
	var_49_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_49_0:setAnchorPoint(cc.p(0, 0))
	var_49_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_49_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_49_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_49_0:setOpacity(0)
	var_49_0:setCascadeOpacityEnabled(false)
	self:addChild(var_49_0, -1)

	local var_49_1 = ccui.ImageView:create("mainScenebg/blur_mask.png")

	var_49_1:setAnchorPoint(cc.p(0.5, 0.5))
	var_49_1:setPositionX(var_49_0:getContentSize().width / 2)
	var_49_1:setPositionY(var_49_0:getContentSize().height / 2)
	var_49_0:addChild(var_49_1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_50_0)
		self:addChild(arg_50_0, -2)
		arg_50_0:setPositionY(arg_50_0:getPositionY() - GameDisplay.fix_y)
		self:init(arg_49_1)
		var_49_0:setOpacity(102)
		var_49_0:setTouchEnabled(false)
	end)
end

function PopFriendIntroduceLayer:exit()
	self.hideActions.shrinkBoth(self, function()
		LayerManager:removePopLayer(self.__queueindex)
	end)
end
