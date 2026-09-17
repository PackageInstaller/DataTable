joinCommunityLayer = class("joinCommunityLayer", function()
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
local family_threshold_data = require("data.family_threshold_data")
local family_medal_data = require("data.family_medal_data")
local activity_manager = require("controller.activity_manager")
local playermodel = require("model.playermodel")
local item_manager = require("controller.item_manager")
local var_0_14
local family_other_data = require("data.family_other_data")
local var_0_16 = config._DEBUG and 0 or 1
local var_0_17 = {
	{
		off = "community_system/joinCommunityLayer/one_add_off.png",
		on = "community_system/joinCommunityLayer/one_add_on.png"
	},
	{
		off = "community_system/joinCommunityLayer/one_create_off.png",
		on = "community_system/joinCommunityLayer/one_create_on.png"
	}
}
local var_0_19 = "community_system/joinCommunityLayer/one_input_bg.png"
local var_0_20 = "community_system/joinCommunityLayer/two_change.png"
local var_0_21 = {
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
local var_0_22 = {
	COMMUNITY_JOINCOMMUNITY.tips5,
	COMMUNITY_JOINCOMMUNITY.tips4,
	COMMUNITY_JOINCOMMUNITY.tips6
}
local var_0_23 = {
	on = "community_system/communityMainLayer/setting_left_on.png",
	off = "community_system/communityMainLayer/setting_left_off.png"
}
local var_0_24 = {
	cc.p(46, 262),
	cc.p(46, 221)
}
local var_0_25 = 640
local var_0_26 = 160

function joinCommunityLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = joinCommunityLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function joinCommunityLayer:init(arg_3_1)
	var_0_14 = self
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "joinCommunityLayer.json" or "joinCommunityLayer.ExportJson")

	self:addChild(self.rootLayer)

	self.toplayer = ccui.Helper:seekWidgetByName(self.rootLayer, "top_layer")
	self.midlayer = ccui.Helper:seekWidgetByName(self.rootLayer, "panel_middle")
	self.panel_1 = ccui.Helper:seekWidgetByName(self.midlayer, "addpanel")
	self.panel_2 = ccui.Helper:seekWidgetByName(self.midlayer, "createpanel")
	self.itemstop = ccui.Helper:seekWidgetByName(self.rootLayer, "btnitems")
	self.items = ccui.Helper:seekWidgetByName(self.rootLayer, "items")
	self.search = ccui.Helper:seekWidgetByName(self.panel_1, "search_btn")
	self.flash = ccui.Helper:seekWidgetByName(self.panel_1, "btn_flash")
	self.btn_clear = ccui.Helper:seekWidgetByName(self.panel_1, "btn_close")
	self.tablepanel = ccui.Helper:seekWidgetByName(self.panel_1, "tabviewlayer")
	self.toplistview = ccui.Helper:seekWidgetByName(self.rootLayer, "ListView_45")
	self.input_bg = ccui.Helper:seekWidgetByName(self.panel_1, "Image_10")
	self.searchlayer = ccui.Helper:seekWidgetByName(self.tablepanel, "searchpanel")
	self.searchtable = ccui.Helper:seekWidgetByName(self.searchlayer, "selecttable")
	self.ondataimg = ccui.Helper:seekWidgetByName(self.panel_1, "Image_68")
	self.ondatalable = ccui.Helper:seekWidgetByName(self.ondataimg, "Label_69")
	self.onekeyjoin = ccui.Helper:seekWidgetByName(self.panel_1, "btn_flashjoin")
	self.rank = ccui.Helper:seekWidgetByName(self.toplayer, "btn_rank")
	self.applying = ccui.Helper:seekWidgetByName(self.toplayer, "btn_apply")
	self.filter = ccui.Helper:seekWidgetByName(self.panel_1, "btn_select")
	self.cond_btn_l = ccui.Helper:seekWidgetByName(self.panel_2, "btn_cond_l")
	self.cond_btn_r = ccui.Helper:seekWidgetByName(self.panel_2, "btn_cond_r")
	self.verif_btn_l = ccui.Helper:seekWidgetByName(self.panel_2, "btn_verity_l")
	self.verif_btn_r = ccui.Helper:seekWidgetByName(self.panel_2, "btn_verity_r")
	self.createnamebg = ccui.Helper:seekWidgetByName(self.panel_2, "Panel_41")
	self.createname = ccui.Helper:seekWidgetByName(self.createnamebg, "name")
	self.createmedal = ccui.Helper:seekWidgetByName(self.panel_2, "btn_xunzhang")
	self.changemedal = ccui.Helper:seekWidgetByName(self.panel_2, "btn_tihuan")
	self.conditon_text = ccui.Helper:seekWidgetByName(self.panel_2, "Label_34")
	self.verity_text = ccui.Helper:seekWidgetByName(self.panel_2, "Label_34_0")
	self.create_btn = ccui.Helper:seekWidgetByName(self.panel_2, "btn_create")
	self.createname_btn = ccui.Helper:seekWidgetByName(self.panel_2, "btn_changename")
	self.createinput = ccui.Helper:seekWidgetByName(self.createnamebg, "input")
	self.talkerkung = ccui.Helper:seekWidgetByName(self.toplayer, "notices_bg")

	self.talkerkung:getChildByName("Label_4"):getVirtualRenderer():setMaxLineWidth(294)
	self.talkerkung:getChildByName("Label_4"):getVirtualRenderer():setLineBreakWithoutSpace(true)
	self.talkerkung:setVisible(false)
	self.createname_btn:setEnabled(false)
	self.rank:setVisible(false)
	self.onekeyjoin:setVisible(false)

	self.panels = {
		self.panel_1,
		self.panel_2
	}

	if arg_3_1 then
		self.topindex = arg_3_1.topindex or 1
		self.showbottom = arg_3_1.showbottom or nil
	else
		self.topindex = 1
	end

	self:initBottomList()
	self:fullScreen(self.rootLayer)
	self:initUI()
	self:registerActivityEventListener()
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" then
			activity_manager:releaseEventListenerByName("joinCommunityLayer")

			var_0_14 = nil
		end
	end)
end

function joinCommunityLayer.registerActivityEventListener(arg_5_0)
	activity_manager:registerEventListener("joinCommunityLayer", activity_manager.activityEventId.COMMUNITY_JOIN_COMMNITY, function(arg_6_0)
		if arg_6_0.familyid then
			LayerManager:switchShowLayer("CommunityMainLayer")
		end
	end)
end

function joinCommunityLayer:initUI()
	self:initTopInfoLayer()
	self:initTopBtnLayer()
	self:initSearchPutLayer()
	self:initCreateCommunityLayer()

	if self.showbottom then
		ListButtonLayer.getInstance():hideLayer()
		self.bottomList:setVisible(true)
	end
end

function joinCommunityLayer:initBottomList()
	self.bottomList = BottomBtnList:create(function(arg_9_0, arg_9_1)
		if arg_9_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:switchReturnLayer("CommunityMainLayer")
	end)

	self:addChild(self.bottomList, 100)
	self.bottomList:setVisible(false)
end

function joinCommunityLayer:initCreateCommunityLayer()
	self.conditiondata = {
		{
			id = 0,
			cond = 0,
			type = 0,
			des = COMMUNITY_JOINCOMMUNITY.tips7
		}
	}

	for iter_10_0, iter_10_1 in ipairs(family_threshold_data) do
		table.insert(self.conditiondata, iter_10_1)
	end

	self.confition = 1
	self.verif = 1
	self.medalid = 1

	self.createname:setString("")
	self:initCommunityImage(self.createmedal, self.medalid)

	local function var_10_0(arg_11_0, arg_11_1)
		local var_11_0

		if arg_11_1 ~= ccui.TouchEventType.ended then
			do return end

			var_11_0 = {}
		end

		function var_11_0.callback(arg_12_0)
			self.medalid = arg_12_0

			self:initCommunityImage(self.createmedal, self.medalid)
		end

		var_11_0.medalid = self.medalid

		LayerManager:pushInLayer("PopCommunityMedalChangeLayer", var_11_0)
	end

	self.createmedal:addTouchEventListener(var_10_0)
	self.changemedal:addTouchEventListener(var_10_0)
	self:initCreateBtnImg()
	self:initCreateNameInPutLayer()
	self.cond_btn_l:addTouchEventListener(function(arg_13_0, arg_13_1)
		if arg_13_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.confition <= 1 then
			return
		end

		self.confition = self.confition - 1

		self:initCreateBtnImg()
	end)
	self.cond_btn_r:addTouchEventListener(function(arg_14_0, arg_14_1)
		if arg_14_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.confition >= #self.conditiondata then
			return
		end

		self.confition = self.confition + 1

		self:initCreateBtnImg()
	end)
	self.verif_btn_l:addTouchEventListener(function(arg_15_0, arg_15_1)
		if arg_15_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.verif <= 1 then
			return
		end

		self.verif = self.verif - 1

		self:initCreateBtnImg()
	end)
	self.verif_btn_r:addTouchEventListener(function(arg_16_0, arg_16_1)
		if arg_16_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.verif >= #var_0_21 then
			return
		end

		self.verif = self.verif + 1

		self:initCreateBtnImg()
	end)
	self.create_btn:addTouchEventListener(function(arg_17_0, arg_17_1)
		local var_17_0

		if arg_17_1 ~= ccui.TouchEventType.ended then
			do return end

			var_17_0 = {
				headImage = "community_system/joinCommunityLayer/tips_chuangjian.png",
				layerType = "CommunityMainLayer",
				assgin = 2,
				surecallback = function()
					community_system_manager:create_family(self.editBoxName:getText(), self.medalid, self.conditiondata[self.confition].type, self.conditiondata[self.confition].cond, var_0_21[self.verif].type, function(arg_20_0)
						if arg_20_0.result == 1 then
							global_ShowBlockWords(COMMUNITY_JOINCOMMUNITY.tips8)
							LayerManager:switchShowLayer("CommunityMainLayer")
						elseif arg_20_0.result == 2 then
							global_ShowBlockWords(COMMUNITY_JOINCOMMUNITY.tips9)
						elseif arg_20_0.result == 3 then
							global_ShowBlockWords(COMMUNITY_JOINCOMMUNITY.tips10)
						elseif arg_20_0.result == 11 then
							global_ShowBlockWords(COMMUNITY_JOINCOMMUNITY.tips11)
						elseif arg_20_0.result == 12 then
							global_ShowBlockWords((string.format(COMMUNITY_JOINCOMMUNITY.tips12, community_system_manager:getNextApplyTimeSting())))
						elseif arg_20_0.result == 13 then
							global_ShowBlockWords(COMMUNITY_JOINCOMMUNITY.tips13)
						elseif arg_20_0.result == 14 then
							global_ShowBlockWords(COMMUNITY_JOINCOMMUNITY.tips14)
						end
					end)
				end
			}
		end

		function var_17_0.cancelcallback()
			return
		end

		if not self:isjumpToBuyLayer(family_other_data.family_create_cost.value, family_other_data.family_create_cost.value2) and self:checkTheNameIsValid(self.editBoxName:getText()) then
			global_basic_scene:addChild(ConfirmDialogSprite:create("", COMMUNITY_JOINCOMMUNITY.tips15 .. "\"" .. self.editBoxName:getText() .. "\"" .. "?", var_17_0), 999)
		end
	end)
	self.create_btn:getChildByName("Image_27"):getChildByName("Label_28"):setString("x" .. family_other_data.family_create_cost.value2)
end

function joinCommunityLayer.checkTheNameIsValid(arg_21_0, arg_21_1)
	if arg_21_1 == "" then
		global_ShowBlockWords(COMMUNITY_JOINCOMMUNITY.tips16)

		return false
	end

	if 7 < subStringGetTotalIndex(arg_21_1) then
		global_ShowBlockWords(COMMUNITY_JOINCOMMUNITY.tips17, nil, nil, nil, nil, nil, nil, 20)

		return false
	elseif not global_check_sensitive(arg_21_1) then
		print("违规了!!!!!")
		global_ShowBlockWords(L_WORD_SENSITIVE)

		return false
	else
		return true
	end
end

function joinCommunityLayer:initCreateNameInPutLayer()
	self.editBoxName = cc.EditBox:create(cc.size(380, 38), (config._DEBUG or nil) and (cc.Scale9Sprite:create(var_0_20) or cc.Scale9Sprite:createWithSpriteFrameName(var_0_20)))

	self.editBoxName:setPosition(cc.p(self.createinput:getContentSize().width / 2, self.createinput:getContentSize().height / 2))
	self.editBoxName:setPlaceHolder(COMMUNITY_JOINCOMMUNITY.tips18)
	self.editBoxName:setPlaceholderFontColor(cc.c3b(167, 194, 243))
	self.editBoxName:setInputMode(cc.EDITBOX_INPUT_MODE_ANY)
	self.editBoxName:setReturnType(cc.KEYBOARD_RETURNTYPE_DONE)
	self.editBoxName:setOpacity(0)
	self.editBoxName:setFont(FONT_NAME, 24)
	self.editBoxName:setFontColor(cc.c3b(102, 153, 249))
	self.editBoxName:setMaxLength(360)
	self.createinput:addChild(self.editBoxName)
	self.editBoxName:registerScriptEditBoxHandler(function(arg_23_0, arg_23_1)
		if arg_23_0 == "began" then
			arg_23_1:setText("")
		elseif arg_23_0 == "ended" then
			if not global_check_sensitive(arg_23_1:getText()) then
				global_ShowBlockWords(L_WORD_SENSITIVE)
				arg_23_1:setText("")
			end
		elseif arg_23_0 == "return" then
			-- block empty
		elseif arg_23_0 == "changed" then
			-- block empty
		end
	end)
end

function joinCommunityLayer:updateCreateNameText()
	self.createname:setString(self.editBoxName:getText())
end

function joinCommunityLayer:initCreateBtnImg()
	self.conditon_text:setString(self.conditiondata[self.confition].des)
	self.verity_text:setString(var_0_21[self.verif].context)

	if self.confition == 1 then
		self.cond_btn_l:loadTextures(var_0_23.off, nil, var_0_23.off, var_0_16)
		self.cond_btn_r:loadTextures(var_0_23.on, nil, var_0_23.on, var_0_16)
	elseif self.confition == #self.conditiondata then
		self.cond_btn_l:loadTextures(var_0_23.on, nil, var_0_23.on, var_0_16)
		self.cond_btn_r:loadTextures(var_0_23.off, nil, var_0_23.off, var_0_16)
	else
		self.cond_btn_l:loadTextures(var_0_23.on, nil, var_0_23.on, var_0_16)
		self.cond_btn_r:loadTextures(var_0_23.on, nil, var_0_23.on, var_0_16)
	end

	if self.verif == 1 then
		self.verif_btn_l:loadTextures(var_0_23.off, nil, var_0_23.off, var_0_16)
		self.verif_btn_r:loadTextures(var_0_23.on, nil, var_0_23.on, var_0_16)
	elseif self.verif == #var_0_21 then
		self.verif_btn_l:loadTextures(var_0_23.on, nil, var_0_23.on, var_0_16)
		self.verif_btn_r:loadTextures(var_0_23.off, nil, var_0_23.off, var_0_16)
	else
		self.verif_btn_l:loadTextures(var_0_23.on, nil, var_0_23.on, var_0_16)
		self.verif_btn_r:loadTextures(var_0_23.on, nil, var_0_23.on, var_0_16)
	end
end

function joinCommunityLayer:initSearchPutLayer()
	self.editBox = cc.EditBox:create(cc.size(509, 45), (config._DEBUG or nil) and (cc.Scale9Sprite:create(var_0_19) or cc.Scale9Sprite:createWithSpriteFrameName(var_0_19)))

	self.editBox:setPosition(cc.p(self.input_bg:getContentSize().width / 2, self.input_bg:getContentSize().height / 2))
	self.editBox:setPlaceHolder(COMMUNITY_JOINCOMMUNITY.tips19)
	self.editBox:setPlaceholderFontColor(cc.c3b(58, 91, 160))
	self.editBox:setInputMode(cc.EDITBOX_INPUT_MODE_ANY)
	self.editBox:setReturnType(cc.KEYBOARD_RETURNTYPE_DONE)
	self.editBox:setFont(FONT_NAME, 20)
	self.editBox:setMaxLength(460)
	self.input_bg:addChild(self.editBox)
	self:showClearBtn(false)
	self.editBox:registerScriptEditBoxHandler(function(arg_27_0, arg_27_1)
		if arg_27_0 == "began" then
			arg_27_1:setText("")
		elseif arg_27_0 == "ended" then
			if not global_is_words_pass_against(arg_27_1:getText()) then
				arg_27_1:setText("")
			end
		elseif arg_27_0 == "return" then
			-- block empty
		elseif arg_27_0 == "changed" then
			self:showClearBtn(true)
		end
	end)
	self.btn_clear:addTouchEventListener(function(arg_28_0, arg_28_1)
		if arg_28_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:showClearBtn(false)
		self:hideOropenRecomend(true)
		self.ondataimg:setVisible(false)
	end)
end

function joinCommunityLayer:showClearBtn(arg_29_1)
	self.btn_clear:setVisible(arg_29_1)

	if not arg_29_1 then
		self:resetInPutText()
	end
end

function joinCommunityLayer:resetInPutText()
	self.editBox:setText("")
end

function joinCommunityLayer:initTopInfoLayer()
	self.applying:addTouchEventListener(function(arg_32_0, arg_32_1)
		if arg_32_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopCommunityPlayerApplyLayer")
	end)
	self.filter:addTouchEventListener(function(arg_33_0, arg_33_1)
		local var_33_0

		if arg_33_1 ~= ccui.TouchEventType.ended then
			do return end

			var_33_0 = {
				filtertype = 1
			}
		end

		function var_33_0.callback()
			if var_0_14 then
				if not self.searchlayer:isVisible() then
					if self.recomenddata and self.tableview1 then
						self.recomenddata = community_system_manager:filterComminityParmData(community_system_manager:getRecommendList())

						self.tableview1:reloadData()

						if #self.recomenddata == 0 then
							self.ondataimg:setVisible(true)
							self.ondatalable:setString(var_0_22[3])
						else
							self.ondataimg:setVisible(false)
						end
					end
				elseif self.searchdata and self.tableviewsearch then
					self.searchdata = community_system_manager:filterComminityParmData(community_system_manager:getSearchList())

					self.tableviewsearch:reloadData()

					if #self.searchdata == 0 then
						self.ondataimg:setVisible(true)
						self.ondatalable:setString(var_0_22[3])
					else
						self.ondataimg:setVisible(false)
					end
				end
			end
		end

		LayerManager:pushInLayer("PopCommunityFilterLayer", var_33_0)
	end)
	self:initTalkerLayer()
end

function joinCommunityLayer:initTalkerLayer()
	self.id = 1
	self.talkdata = community_system_manager:getTalklayerDataByType(1)

	if self.talkdata and next(self.talkdata) then
		self.talkerkung:setVisible(true)
		self:runAction(cc.RepeatForever:create((cc.Sequence:create(cc.CallFunc:create(function()
			if var_0_14 then
				if self.id > #self.talkdata then
					self.id = 1
				end

				self.talkerkung:getChildByName("Label_4"):setString(self.talkdata[self.id].des)

				self.id = self.id + 1
			end
		end), cc.DelayTime:create(10)))))
	else
		self.talkerkung:setVisible(false)
	end
end

function joinCommunityLayer:initTopBtnLayer()
	self.toplistview:removeAllChildren()
	self.toplistview:setItemsMargin(2)

	self.top_btn = {}

	for iter_37_0, iter_37_1 in ipairs(var_0_17) do
		local var_37_0 = self.itemstop:clone()

		table.insert(self.top_btn, var_37_0)
		self.toplistview:pushBackCustomItem(var_37_0)
	end

	for iter_37_2, iter_37_3 in pairs(self.top_btn) do
		iter_37_3:getChildByName("Button_47"):addTouchEventListener(function(arg_38_0, arg_38_1)
			if arg_38_1 ~= ccui.TouchEventType.ended then
				return
			end

			if self.topindex == iter_37_2 then
				return
			end

			self.topindex = iter_37_2

			self:updateTopBtn()
		end)
	end

	if self.showbottom then
		self.top_btn[2]:setVisible(false)
	else
		self.top_btn[2]:setVisible(true)
	end

	community_system_manager:get_family_player_applications(function()
		if var_0_14 then
			self:updateTopBtn()
			self:listenerTopBtn()
		end
	end)
end

function joinCommunityLayer:listenerTopBtn()
	self.search:addTouchEventListener(function(arg_41_0, arg_41_1)
		if arg_41_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_41_0 = self.editBox:getText()

		if self:CheckUidValidity(var_41_0) then
			community_system_manager:resetSearchListParam()
			community_system_manager:search_family(self:checkIsSearchCommunityId(var_41_0), 1, function(arg_42_0, arg_42_1)
				if var_0_14 then
					if arg_42_0 == 1 then
						self.searchdata = community_system_manager:filterComminityParmData(arg_42_1)

						self:updateSearchLayer()
						self:hideOropenRecomend(false)
						self:showClearBtn(true)
					else
						self:resetInPutText()
						global_ShowBlockWords(COMMUNITY_JOINCOMMUNITY.tips20)
					end
				end
			end)
		end
	end)
	self.flash:addTouchEventListener(function(arg_43_0, arg_43_1)
		if arg_43_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:showClearBtn(false)
		self:updateSelectLayer()
	end)
end

function joinCommunityLayer.checkIsSearchCommunityId(arg_44_0, arg_44_1)
	if tonumber(arg_44_1) then
		local var_44_0 = 0

		for iter_44_0 in arg_44_1:gmatch("%d") do
			var_44_0 = var_44_0 + 1
		end

		if var_44_0 - 5 >= 0 then
			return arg_44_1
		else
			local var_44_1 = arg_44_1

			for iter_44_1 = 1, -1 * (var_44_0 - 5) do
				var_44_1 = "0" .. var_44_1
			end

			return var_44_1
		end
	else
		return arg_44_1
	end
end

function joinCommunityLayer.CheckUidValidity(arg_45_0, arg_45_1)
	if not arg_45_1 or arg_45_1 == "" then
		global_ShowBlockWords(COMMUNITY_JOINCOMMUNITY.tips21)

		return false
	end

	return true
end

function joinCommunityLayer:updateTopBtn()
	for iter_46_0, iter_46_1 in pairs(self.top_btn) do
		if self.topindex == iter_46_0 then
			iter_46_1:getChildByName("Button_47"):loadTextures(var_0_17[iter_46_0].on, var_0_17[iter_46_0].on, var_0_17[iter_46_0].on, var_0_16)
			self.panels[iter_46_0]:setVisible(true)
			self:updateSelectLayer()
		else
			iter_46_1:getChildByName("Button_47"):loadTextures(var_0_17[iter_46_0].off, var_0_17[iter_46_0].off, var_0_17[iter_46_0].off, var_0_16)
			self.panels[iter_46_0]:setVisible(false)
		end
	end
end

function joinCommunityLayer:updateSelectLayer()
	if self.topindex == 1 then
		community_system_manager:get_family_recommend_list(function(arg_48_0)
			if var_0_14 then
				if arg_48_0.result == 1 then
					self.recomenddata = community_system_manager:filterComminityParmData(arg_48_0.list)

					self:updateAddLayer()
					self:hideOropenRecomend(true)
				elseif arg_48_0.result == 9999 then
					global_ShowBlockWords("社团系统已关闭~")
					LayerManager:switchShowLayer("MainLayer")
				end
			end
		end)
	end
end

function joinCommunityLayer:hideOropenRecomend(arg_49_1)
	if self.tableview1 then
		self.tableview1:setVisible(arg_49_1)
	end

	self.searchlayer:setVisible(not arg_49_1)
end

function joinCommunityLayer.createTableView(arg_50_0, arg_50_1, arg_50_2)
	local var_50_0 = cc.TableView:create(arg_50_1)

	;(nil):setName(arg_50_2)
	var_50_0:setDelegate()
	var_50_0:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	var_50_0:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)

	return var_50_0
end

function joinCommunityLayer:createRecommendNode()
	return (self.items:clone())
end

function joinCommunityLayer:updateAddLayer()
	if self.tablepanel:getChildByName("mytablepanel") then
		self.tablepanel:getChildByName("mytablepanel"):removeFromParent()
	end

	if not self.recomenddata or not next(self.recomenddata) then
		self.ondataimg:setVisible(true)
		self.ondatalable:setString(var_0_22[2])

		return
	end

	self.ondataimg:setVisible(false)

	self.tableview1 = self:createTableView(cc.size(self.tablepanel:getContentSize().width, self.tablepanel:getContentSize().height), "mytablepanel")

	self.tablepanel:addChild(self.tableview1, 1)
	self.tableview1:setPosition(cc.p(0, 0))

	self.roleTableViewhight = self.tablepanel:getContentSize().height

	self:initTableViewRecommend()
end

function joinCommunityLayer:updateSearchLayer()
	if self.searchtable:getChildByName("searchtablepanel") then
		self.searchtable:getChildByName("searchtablepanel"):removeFromParent()
	end

	if not self.searchdata or not next(self.searchdata) then
		self.ondataimg:setVisible(true)
		self.ondatalable:setString(var_0_22[1])

		return
	end

	self.ondataimg:setVisible(false)

	self.tableviewsearch = self:createTableView(cc.size(self.searchtable:getContentSize().width, self.searchtable:getContentSize().height), "searchtablepanel")

	self.searchtable:addChild(self.tableviewsearch, 1)
	self.tableviewsearch:setPosition(cc.p(0, 0))

	self.tableViewhight = self.searchtable:getContentSize().height

	self:initTableViewSearch()
end

function joinCommunityLayer:initTableViewSearch()
	self.tableviewsearch:registerScriptHandler(function(arg_56_0, arg_56_1)
		return var_0_25, var_0_26
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.tableviewsearch:registerScriptHandler(function(arg_55_0, arg_55_1)
		local var_55_0 = arg_55_0:dequeueCell()

		if not var_55_0 then
			var_55_0 = cc.TableViewCell:create()

			local var_55_1 = self:createRecommendNode()

			var_55_1:setName("node")
			var_55_1:setPosition(cc.p(5, -5))
			self:updateRecommendNode(var_55_1, self.searchdata[arg_55_1 + 1])

			if arg_55_1 <= math.floor(self.tableViewhight / var_0_26) then
				var_55_1:setOpacity(0)
				var_55_1:runAction(cc.Sequence:create(cc.DelayTime:create(0.1 * arg_55_1), cc.FadeIn:create(0.1)))
			else
				var_55_1:setOpacity(255)
			end

			var_55_0:addChild(var_55_1)
		else
			local var_55_2 = var_55_0:getChildByName("node")

			var_55_2:setOpacity(255)
			self:updateRecommendNode(var_55_2, self.searchdata[arg_55_1 + 1])
		end

		return var_55_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.tableviewsearch:registerScriptHandler(function(arg_57_0, arg_57_1)
		return #self.searchdata
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.tableviewsearch:reloadData()
end

function joinCommunityLayer:initTableViewRecommend()
	self.tableview1:registerScriptHandler(function(arg_60_0, arg_60_1)
		return var_0_25, var_0_26
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.tableview1:registerScriptHandler(function(arg_59_0, arg_59_1)
		local var_59_0 = arg_59_0:dequeueCell()

		if not var_59_0 then
			var_59_0 = cc.TableViewCell:create()

			local var_59_1 = self:createRecommendNode()

			var_59_1:setName("node")
			var_59_1:setPosition(cc.p(5, -5))
			self:updateRecommendNode(var_59_1, self.recomenddata[arg_59_1 + 1])

			if arg_59_1 <= math.floor(self.roleTableViewhight / var_0_26) then
				var_59_1:setOpacity(0)
				var_59_1:runAction(cc.Sequence:create(cc.DelayTime:create(0.1 * arg_59_1), cc.FadeIn:create(0.1)))
			else
				var_59_1:setOpacity(255)
			end

			var_59_0:addChild(var_59_1)
		else
			local var_59_2 = var_59_0:getChildByName("node")

			var_59_2:setOpacity(255)
			self:updateRecommendNode(var_59_2, self.recomenddata[arg_59_1 + 1])
		end

		return var_59_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.tableview1:registerScriptHandler(function(arg_61_0, arg_61_1)
		return #self.recomenddata
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.tableview1:reloadData()
end

function joinCommunityLayer:updateRecommendNode(arg_62_1, arg_62_2)
	local var_62_0 = ccui.Helper:seekWidgetByName(ccui.Helper:seekWidgetByName(arg_62_1, "member_label"), "name")
	local var_62_1 = ccui.Helper:seekWidgetByName(ccui.Helper:seekWidgetByName(arg_62_1, "active_label"), "name")
	local var_62_2 = ccui.Helper:seekWidgetByName(ccui.Helper:seekWidgetByName(arg_62_1, "textlayer"), "Label_41")

	ccui.Helper:seekWidgetByName(arg_62_1, "name_lable"):setString(arg_62_2.familyname)
	ccui.Helper:seekWidgetByName(ccui.Helper:seekWidgetByName(arg_62_1, "lv_label"), "name"):setString(arg_62_2.level)
	var_62_0:setString(arg_62_2.member)

	if arg_62_2.max_member then
		var_62_0:setString("" .. arg_62_2.member .. "/" .. arg_62_2.max_member)
	end

	if arg_62_2.active then
		var_62_1:setString(global_trans_number(arg_62_2.active))
	else
		var_62_1:setString("")
	end

	var_62_2:getVirtualRenderer():setMaxLineWidth(480)
	var_62_2:setString(arg_62_2.slogan)
	self:updateCommunityLable(arg_62_1, community_system_manager:deCodeTagsData(arg_62_2.tags))
	self:updateApplyStatus(arg_62_1, arg_62_2.audit_type, arg_62_2.familyid)
	self:updateImage(arg_62_1, arg_62_2.flag, arg_62_2)
end

function joinCommunityLayer.updateCommunityLable(arg_63_0, arg_63_1, arg_63_2)
	for iter_63_0 = 1, 3 do
		if arg_63_2 and arg_63_2[iter_63_0] and arg_63_1:getChildByName("label_" .. iter_63_0) and family_tag_data[arg_63_2[iter_63_0]] then
			arg_63_1:getChildByName("label_" .. iter_63_0):setVisible(true)
			arg_63_1:getChildByName("label_" .. iter_63_0):getChildByName("name"):setString(family_tag_data[arg_63_2[iter_63_0]].des)
		else
			arg_63_1:getChildByName("label_" .. iter_63_0):setVisible(false)
		end
	end
end

function joinCommunityLayer.updateApplyStatus(arg_64_0, arg_64_1, arg_64_2, arg_64_3)
	if not arg_64_1 then
		return
	end

	local var_64_0 = community_system_manager:getCommunityStatus(arg_64_3)

	if var_64_0 == 0 then
		arg_64_1:getChildByName("cancel"):setVisible(false)
		arg_64_1:getChildByName("free"):setVisible(false)
		arg_64_1:getChildByName("applying"):setVisible(true)
	elseif var_64_0 == 1 then
		arg_64_1:getChildByName("cancel"):setVisible(true)
		arg_64_1:getChildByName("free"):setVisible(false)
		arg_64_1:getChildByName("applying"):setVisible(false)
	elseif arg_64_2 == 0 then
		arg_64_1:getChildByName("applying"):setVisible(false)
		arg_64_1:getChildByName("free"):setVisible(true)
		arg_64_1:getChildByName("cancel"):setVisible(false)
	else
		arg_64_1:getChildByName("applying"):setVisible(false)
		arg_64_1:getChildByName("free"):setVisible(false)
		arg_64_1:getChildByName("cancel"):setVisible(false)
	end
end

function joinCommunityLayer:updateImage(arg_65_1, arg_65_2, arg_65_3)
	if not arg_65_1 or not arg_65_2 then
		return
	end

	self:initCommunityImage(arg_65_1:getChildByName("medal_btn"), arg_65_2)
	arg_65_1:getChildByName("Button_24"):setSwallowTouches(false)
	arg_65_1:getChildByName("Button_24"):addTouchEventListener(function(arg_66_0, arg_66_1)
		if arg_66_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_66_0

		if math.abs(arg_66_0:getTouchBeganPosition().y - arg_66_0:getTouchEndPosition().y) > 50 then
			do return end

			var_66_0 = {}
		end

		function var_66_0.callback()
			if not self.searchlayer:isVisible() then
				self:updateTableViewPanel(self.tableview1, self.recomenddata)
			else
				self:updateTableViewPanel(self.tableviewsearch, self.searchdata)
			end
		end

		var_66_0.data = arg_65_3

		LayerManager:pushInLayer("PopCommunityIntroduceLayer", var_66_0)
	end)
end

function joinCommunityLayer.initCommunityImage(arg_68_0, arg_68_1, arg_68_2)
	if not arg_68_2 or not arg_68_1 then
		return
	end

	local var_68_0 = "equipment/family/communitymedal1.png"

	if family_medal_data[arg_68_2] then
		var_68_0 = "equipment/family/" .. family_medal_data[arg_68_2].image_id .. ".png"
	end

	arg_68_1:loadTextures(var_68_0, nil, var_68_0)
end

function joinCommunityLayer.updateTableViewPanel(arg_69_0, arg_69_1, arg_69_2)
	if not arg_69_1 or not arg_69_2 then
		return
	end

	local var_69_0, var_69_1 = GetTableViewShowCellIdx(arg_69_1, {
		cellsize = cc.size(var_0_25, var_0_26),
		maxcount = #arg_69_2
	})

	for iter_69_0 = var_69_0, var_69_1 do
		arg_69_1:updateCellAtIndex(iter_69_0)
	end
end

function joinCommunityLayer:fullScreen(arg_70_1)
	local var_70_0 = GameDisplay.getScreenSize()

	arg_70_1:setContentSize(var_70_0)
	arg_70_1:setPositionY(arg_70_1:getPositionY() - GameDisplay.fix_y)
	self.toplayer:setPositionY(var_70_0.height - self.toplayer:getContentSize().height / 2)
	self.midlayer:setPositionY(self.toplayer:getPositionY() - 113)
	self.tablepanel:setContentSize(cc.size(640, 610 + 2 * GameDisplay.fix_y))
	self.tablepanel:setPositionY(self.tablepanel:getPositionY() - 2 * GameDisplay.fix_y)
	self.panel_2:setPositionY(self.panel_2:getPositionY() - GameDisplay.fix_y)
	self.searchlayer:setContentSize(cc.size(640, 610 + 2 * GameDisplay.fix_y))
	self.searchtable:setContentSize(cc.size(640, 610 + 2 * GameDisplay.fix_y))

	if self.bottomList then
		self.bottomList:setPositionY(self.bottomList:getPositionY() - GameDisplay.fix_y)
	end
end

function joinCommunityLayer.isjumpToBuyLayer(arg_71_0, arg_71_1, arg_71_2)
	local var_71_0 = {
		[SHOP_CURRENCY_GOLD] = function()
			return playermodel.gold
		end,
		[SHOP_CURRENCY_DIAMOND] = function()
			return playermodel.diamond
		end,
		[SHOP_CURRENCY_HORNOR] = function()
			return playermodel.honor
		end,
		[SHOP_CURRENCY_EXPLORECOIN] = function()
			return playermodel.explorecoin
		end,
		[SHOP_CURRENCY_RMB] = function()
			return 0
		end
	}

	setmetatable(var_71_0, {
		__index = function(arg_77_0, arg_77_1)
			return function()
				return item_manager:getItemNumber(arg_77_1)
			end
		end
	})

	local var_71_1 = {
		[SHOP_CURRENCY_GOLD] = function()
			LayerManager:pushInLayer("PopGoLayer", {
				targetlayer = "HandOfMidasLayer",
				labels = L_POPLAYER_SHOP_LABELS.SHOP_CURRENCY_GOLD
			})
		end,
		[SHOP_CURRENCY_DIAMOND] = function()
			LayerManager:pushInLayer("PopGoBuyDiamond", {
				is_need_pop_layer = 1
			})
		end,
		[SHOP_CURRENCY_HORNOR] = function()
			LayerManager:pushInLayer("PopGoLayer", {
				targetlayer = "ArenaLayer",
				labels = L_POPLAYER_SHOP_LABELS.SHOP_CURRENCY_HORNOR
			})
		end,
		[SHOP_CURRENCY_EXPLORECOIN] = function()
			LayerManager:pushInLayer("PopGoLayer", {
				targetlayer = "ExploreMapLayer",
				labels = L_POPLAYER_SHOP_LABELS.SHOP_CURRENCY_EXPLORECOIN
			})
		end
	}

	setmetatable(var_71_1, {
		__index = function(arg_83_0, arg_83_1)
			return function()
				global_ShowBlockWords(string.format(L_COMMON_WARNING.Used_Up, item_data[arg_83_1].name))
				audioManager:playeffectMusicTest("sound/invalid")
			end
		end
	})

	if var_71_0[arg_71_1] and arg_71_2 <= var_71_0[arg_71_1]() then
		return false
	else
		if var_71_1[arg_71_1] then
			var_71_1[arg_71_1]()
		end

		return true
	end
end
