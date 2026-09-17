PopCommunitySettingLayer = class("PopCommunitySettingLayer", function()
	return PopBaseLayer:create()
end)

require("view.Sprite.ItemSprite")
require("view.Layer.PopLayer")
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
local var_0_12 = {
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
local var_0_14 = COMMUNITY_COMMUNITYSETTINGLAYER.tips1
local var_0_15 = {
	on = "community_system/communityMainLayer/setting_label_select.png",
	off = "community_system/communityMainLayer/setting_label_di.png"
}
local var_0_16 = {
	on = "community_system/communityMainLayer/setting_left_on.png",
	off = "community_system/communityMainLayer/setting_left_off.png"
}
local var_0_17 = 386
local var_0_18 = 40
local var_0_19 = {
	cc.p(0, 0),
	cc.p(96, 0),
	cc.p(192, 0),
	(cc.p(288, 0))
}
local var_0_20 = "community_system/communityMainLayer/setting_noticebg.png"

function PopCommunitySettingLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopCommunitySettingLayer.new()

	var_2_0:initBg(arg_2_1)

	return var_2_0
end

function PopCommunitySettingLayer:init(arg_3_1)
	var_0_10 = self
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "PopCommunitySettingLayer.json" or "PopCommunitySettingLayer.ExportJson")

	self.rootLayer:setBackGroundColorOpacity(0)
	self.rootLayer:setContentSize(GameDisplay.getScreenSize())
	self.rootLayer:setPosition(cc.p(0, -GameDisplay.fix_y))
	self:addChild(self.rootLayer, 2)

	self.rootpanel = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_1")
	self.btn_sure = ccui.Helper:seekWidgetByName(self.rootpanel, "Button_3")
	self.items = ccui.Helper:seekWidgetByName(self.rootLayer, "items")
	self.medallayer = ccui.Helper:seekWidgetByName(self.rootpanel, "img_xz")
	self.noticelayer = ccui.Helper:seekWidgetByName(self.rootpanel, "img_xy")
	self.labellayer = ccui.Helper:seekWidgetByName(self.rootpanel, "img_bq")
	self.conditionlayer = ccui.Helper:seekWidgetByName(self.rootpanel, "img_jr")
	self.verificationlayer = ccui.Helper:seekWidgetByName(self.rootpanel, "img_yz")
	self.cond_btn_l = ccui.Helper:seekWidgetByName(self.conditionlayer, "btn_left")
	self.cond_btn_r = ccui.Helper:seekWidgetByName(self.conditionlayer, "btn_right")
	self.condlabel = ccui.Helper:seekWidgetByName(self.conditionlayer, "Label_47")
	self.verif_btn_l = ccui.Helper:seekWidgetByName(self.verificationlayer, "btn_left")
	self.verif_btn_r = ccui.Helper:seekWidgetByName(self.verificationlayer, "btn_right")
	self.veriflabel = ccui.Helper:seekWidgetByName(self.verificationlayer, "Label_48")

	self.rootpanel:setCascadeOpacityEnabled(false)
	self.rootpanel:setPositionY(GameDisplay.getScreenSize().height / 2)
	self:createFullScreenMask(function(arg_4_0, arg_4_1)
		if arg_4_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.hideActions.shrinkVertical(self, function()
			LayerManager:removePopLayer(self.__queueindex)
		end)
	end, 0)

	if arg_3_1 then
		self.initfamilyid = arg_3_1.data.familyid or nil
	end

	if arg_3_1 then
		self.initmedalid = arg_3_1.data.flag or nil
	end

	if arg_3_1 then
		self.initdeclaration = arg_3_1.data.slogan or ""
	end

	if arg_3_1 then
		self.initlables = arg_3_1.data.tags or 0
	end

	if arg_3_1 then
		self.initthresholdtype = arg_3_1.data.threshold_type or 0
	end

	if arg_3_1 then
		self.initthresholdvalue = arg_3_1.data.threshold_value or 1
	end

	if arg_3_1 then
		self.initverity = arg_3_1.data.audit_type or 0
	end

	if arg_3_1 then
		self.familyid = arg_3_1.data.familyid or nil
	end

	if arg_3_1 then
		self.medalid = arg_3_1.data.flag or nil
	end

	if arg_3_1 then
		self.declaration = arg_3_1.data.slogan or ""
	end

	if arg_3_1 then
		self.lables = arg_3_1.data.tags or 0
	end

	if arg_3_1 then
		self.thresholdtype = arg_3_1.data.threshold_type or 0
	end

	if arg_3_1 then
		self.audittype = arg_3_1.data.audit_type or 0
	end

	if arg_3_1 then
		self.verity = arg_3_1.data.audit_type + 1 or 1
	end

	if arg_3_1 then
		self.callback = arg_3_1.callback or nil
	end

	if self.thresholdtype and self.thresholdtype == 0 then
		self.confition = 1
	elseif self.thresholdtype and self.thresholdtype == 1 then
		self.confition = arg_3_1.data.threshold_value + 1
	end

	self:initUI()
	global_window_open_action(self.rootpanel)
	self:registerScriptHandler(function(arg_6_0)
		if arg_6_0 == "exit" then
			var_0_10 = nil
		end
	end)
end

function PopCommunitySettingLayer:initUI()
	self:initMedalLayer()
	self:initDeclarationLayer()
	self:initLableLayer()
	self:initConditionLayer()
	self:initVerificationlayer()
	self:initSureBtn()
end

function PopCommunitySettingLayer:initSureBtn()
	self.btn_sure:getChildByName("Label_4"):setString(COMMUNITY_COMMUNITYMEMBERLAYER.tips17)
	self.btn_sure:addTouchEventListener(function(arg_9_0, arg_9_1)
		if arg_9_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self:checkIsVialid() then
			local function var_9_0(arg_10_0)
				if arg_10_0.result == 1 then
					if var_0_10 then
						global_ShowBlockWords(COMMUNITY_COMMUNITYSETTINGLAYER.tips2)

						self.declaration = self.editBox:getText()

						self:exit()
					end
				elseif arg_10_0.result == 2 then
					global_ShowBlockWords(COMMUNITY_JOINCOMMUNITY.tips10)
				elseif arg_10_0.result == 3 then
					global_ShowBlockWords(COMMUNITY_COMMUNITYSETTINGLAYER.nameig)
				elseif arg_10_0.result == 4 then
					global_ShowBlockWords(COMMUNITY_COMMUNITYSETTINGLAYER.tips3)
				elseif arg_10_0.result == 5 then
					global_ShowBlockWords(COMMUNITY_COMMUNITYSETTINGLAYER.tips4)
				elseif arg_10_0.result == 11 then
					global_ShowBlockWords(COMMUNITY_COMMUNITYSETTINGLAYER.tips5)
				elseif arg_10_0.result == 12 then
					global_ShowBlockWords(COMMUNITY_COMMUNITYMEMBERLAYER.tips15)
				elseif arg_10_0.result == 13 then
					global_ShowBlockWords(L_BUY_BATTLEPASS_LEVEL[1])
				elseif arg_10_0.result == 14 then
					global_ShowBlockWords(COMMUNITY_JOINCOMMUNITY.tips14)
				end
			end

			local var_9_1 = {}

			if self.initmedalid ~= self.medalid then
				var_9_1.flag = self.medalid or nil
			end

			var_9_1.tags = self.initlables ~= community_system_manager:enCodeTagsData(self.selecttbl) and community_system_manager:enCodeTagsData(self.selecttbl) or nil
			var_9_1.slogan = self.editBox:getText() ~= "" and self.editBox:getText() ~= self.initdeclaration and self.editBox:getText() or nil
			var_9_1.threshold_type = self.conditiondata[self.confition].type

			if self.conditiondata[self.confition].type ~= 0 then
				var_9_1.threshold_value = self.conditiondata[self.confition].cond or nil
			end

			if self.initverity ~= var_0_12[self.verity].type then
				var_9_1.audit_type = var_0_12[self.verity].type or nil
			end

			if next(var_9_1) then
				if self:checkIsRight(self.editBox:getText()) then
					community_system_manager:update_family_setting(self.familyid, var_9_1, var_9_0)
				end
			else
				global_ShowBlockWords(COMMUNITY_COMMUNITYSETTINGLAYER.tips6)
			end
		end
	end)
end

function PopCommunitySettingLayer.checkIsRight(arg_11_0, arg_11_1)
	if not arg_11_1 then
		return true
	end

	if utfstrlen(arg_11_1) > 30 then
		global_ShowBlockWords(COMMUNITY_COMMUNITYSETTINGLAYER.tips7)

		return false
	elseif not global_check_sensitive(arg_11_1) then
		global_ShowBlockWords(L_WORD_SENSITIVE)

		return false
	else
		return true
	end

	return true
end

function PopCommunitySettingLayer:initMedalLayer()
	self.medalimg = ccui.Helper:seekWidgetByName(self.medallayer, "medal")
	self.replacebtn = ccui.Helper:seekWidgetByName(self.medalimg, "Button_18")

	self:initCommunityImage(self.medalimg, self.medalid)
	self.replacebtn:addTouchEventListener(function(arg_13_0, arg_13_1)
		local var_13_0

		if arg_13_1 ~= ccui.TouchEventType.ended then
			do return end

			var_13_0 = {}
		end

		function var_13_0.callback(arg_14_0)
			self.medalid = arg_14_0

			self:initCommunityImage(self.medalimg, self.medalid)
		end

		var_13_0.medalid = self.medalid

		LayerManager:pushInLayer("PopCommunityMedalChangeLayer", var_13_0)
	end)
end

function PopCommunitySettingLayer.initCommunityImage(arg_15_0, arg_15_1, arg_15_2)
	if not arg_15_2 or not arg_15_1 then
		return
	end

	local var_15_0 = "equipment/family/communitymedal1.png"

	if family_medal_data[arg_15_2] then
		var_15_0 = "equipment/family/" .. family_medal_data[arg_15_2].image_id .. ".png"
	end

	arg_15_1:loadTextures(var_15_0, nil, var_15_0)
end

function PopCommunitySettingLayer:initDeclarationLayer()
	self.declarationbg = ccui.Helper:seekWidgetByName(self.noticelayer, "Image_25")
	self.declable = ccui.Helper:seekWidgetByName(self.declarationbg, "Label_26")

	self.declable:getVirtualRenderer():setMaxLineWidth(230)
	self.declable:setString("")

	self.editBox = cc.EditBox:create(cc.size(386, 96), (config._DEBUG or nil) and (cc.Scale9Sprite:create(var_0_20) or cc.Scale9Sprite:createWithSpriteFrameName(var_0_20)))

	self.editBox:setPosition(cc.p(self.declarationbg:getContentSize().width / 2, self.declarationbg:getContentSize().height / 2))

	if self.initdeclaration ~= "" then
		self.editBox:setText(self.initdeclaration)
	else
		self.editBox:setPlaceHolder(var_0_14)
		self.editBox:setText(var_0_14)
	end

	self.editBox:setInputMode(cc.EDITBOX_INPUT_MODE_ANY)
	self.editBox:setReturnType(cc.KEYBOARD_RETURNTYPE_DONE)
	self.editBox:setFont(FONT_NAME, 22)
	self.editBox:setMaxLength(360)
	self.declarationbg:addChild(self.editBox)
	self.editBox:registerScriptEditBoxHandler(function(arg_17_0, arg_17_1)
		if arg_17_0 == "began" then
			arg_17_1:setText("")
		elseif arg_17_0 == "ended" then
			if not global_check_sensitive(arg_17_1:getText()) then
				global_ShowBlockWords(L_WORD_SENSITIVE)
				arg_17_1:setText("")
			end

			self:updateDeclarationLayer()
		elseif arg_17_0 == "return" then
			-- block empty
		elseif arg_17_0 == "changed" then
			-- block empty
		end
	end)
end

function PopCommunitySettingLayer:initConditionLayer()
	self.conditiondata = {
		{
			id = 0,
			cond = 0,
			type = 0,
			des = COMMUNITY_JOINCOMMUNITY.tips7
		}
	}

	for iter_18_0, iter_18_1 in ipairs(family_threshold_data) do
		table.insert(self.conditiondata, iter_18_1)
	end

	self.cond_btn_l:addTouchEventListener(function(arg_19_0, arg_19_1)
		if arg_19_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.confition <= 1 then
			return
		end

		self.confition = self.confition - 1

		self:initCreateBtnImg()
	end)
	self.cond_btn_r:addTouchEventListener(function(arg_20_0, arg_20_1)
		if arg_20_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.confition >= #self.conditiondata then
			return
		end

		self.confition = self.confition + 1

		self:initCreateBtnImg(arg_20_0)
	end)
	self:initCreateBtnImg()
end

function PopCommunitySettingLayer:initVerificationlayer()
	self.verif_btn_l:addTouchEventListener(function(arg_22_0, arg_22_1)
		if arg_22_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.verity <= 1 then
			return
		end

		self.verity = self.verity - 1

		self:initCreateBtnImg()
	end)
	self.verif_btn_r:addTouchEventListener(function(arg_23_0, arg_23_1)
		if arg_23_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.verity >= #var_0_12 then
			return
		end

		self.verity = self.verity + 1

		self:initCreateBtnImg(arg_23_0)
	end)
	self:initCreateBtnImg()
end

function PopCommunitySettingLayer:initCreateBtnImg()
	self.condlabel:setString(self.conditiondata[self.confition].des)
	self.veriflabel:setString(var_0_12[self.verity].context)

	if self.confition == 1 then
		self.cond_btn_l:loadTextures(var_0_16.off, nil, var_0_16.off, var_0_11)
		self.cond_btn_r:loadTextures(var_0_16.on, nil, var_0_16.on, var_0_11)
	elseif self.confition == #self.conditiondata then
		self.cond_btn_l:loadTextures(var_0_16.on, nil, var_0_16.on, var_0_11)
		self.cond_btn_r:loadTextures(var_0_16.off, nil, var_0_16.off, var_0_11)
	else
		self.cond_btn_l:loadTextures(var_0_16.on, nil, var_0_16.on, var_0_11)
		self.cond_btn_r:loadTextures(var_0_16.on, nil, var_0_16.on, var_0_11)
	end

	if self.verity == 1 then
		self.verif_btn_l:loadTextures(var_0_16.off, nil, var_0_16.off, var_0_11)
		self.verif_btn_r:loadTextures(var_0_16.on, nil, var_0_16.on, var_0_11)
	elseif self.verity == #var_0_12 then
		self.verif_btn_l:loadTextures(var_0_16.on, nil, var_0_16.on, var_0_11)
		self.verif_btn_r:loadTextures(var_0_16.off, nil, var_0_16.off, var_0_11)
	else
		self.verif_btn_l:loadTextures(var_0_16.on, nil, var_0_16.on, var_0_11)
		self.verif_btn_r:loadTextures(var_0_16.on, nil, var_0_16.on, var_0_11)
	end
end

function PopCommunitySettingLayer.createTableView(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0 = cc.TableView:create(arg_25_1)

	;(nil):setName(arg_25_2)
	var_25_0:setDelegate()
	var_25_0:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	var_25_0:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)

	return var_25_0
end

function PopCommunitySettingLayer:initLableLayer()
	self.tablelayer = ccui.Helper:seekWidgetByName(self.labellayer, "tablelayer")
	self.lablenum = ccui.Helper:seekWidgetByName(self.labellayer, "Label_53")
	self.selecttbl = global_deepCopy(community_system_manager:deCodeTagsData(self.lables))
	self.labledata = family_tag_data

	if not self.labledata then
		return
	end

	self.tableview1 = self:createTableView(cc.size(self.tablelayer:getContentSize().width, self.tablelayer:getContentSize().height), "communitytableview")

	self.tablelayer:addChild(self.tableview1, 1)
	self.tableview1:setPosition(cc.p(0, 0))

	self.roleTableViewhight = self.tablelayer:getContentSize().height

	self:initLableTableView()
end

function PopCommunitySettingLayer:createLableNode()
	return (self.items:clone())
end

function PopCommunitySettingLayer.updateLableNode(arg_28_0, arg_28_1, arg_28_2, arg_28_3, arg_28_4)
	return
end

function PopCommunitySettingLayer:checkIsLableSelect(arg_29_1)
	local var_29_0 = false

	for iter_29_0, iter_29_1 in pairs(self.selecttbl) do
		if arg_29_1 == iter_29_1 then
			var_29_0 = true

			break
		end
	end

	return var_29_0
end

function PopCommunitySettingLayer:updateLablesData(arg_30_1)
	if not arg_30_1 then
		return
	end

	local var_30_0 = {}

	for iter_30_0, iter_30_1 in ipairs(self.selecttbl) do
		if iter_30_1 ~= arg_30_1 then
			table.insert(var_30_0, iter_30_1)
		end
	end

	self.selecttbl = var_30_0
end

function PopCommunitySettingLayer:updateMedalTableViewPanel()
	if not self.tableview1 or not self.labledata then
		return
	end

	local var_31_0, var_31_1 = GetTableViewShowCellIdx(self.tableview1, {
		cellsize = cc.size(var_0_17, var_0_18),
		maxcount = self:getCurDataListLen()
	})

	for iter_31_0 = var_31_0, var_31_1 do
		self.tableview1:updateCellAtIndex(iter_31_0)
	end
end

function PopCommunitySettingLayer:getCurDataListLen()
	local var_32_0 = math.ceil(#self.labledata / 4)

	if var_32_0 < 3 then
		var_32_0 = 3
	end

	return var_32_0
end

function PopCommunitySettingLayer:initLableTableView()
	self.tableview1:registerScriptHandler(function(arg_36_0, arg_36_1)
		return var_0_17, var_0_18
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.tableview1:registerScriptHandler(function(arg_34_0, arg_34_1)
		local var_34_0 = arg_34_0:dequeueCell()

		if not var_34_0 then
			var_34_0 = cc.TableViewCell:create()

			var_34_0:setName("cell_node_" .. arg_34_1)

			local var_34_1 = 4

			for iter_34_0 = 1, 4 do
				local var_34_2 = self:createLableNode()

				var_34_2:setName("sp_" .. iter_34_0)
				var_34_2:setPosition(var_0_19[iter_34_0])

				var_34_2:getChildByName("Button_50").selectindex = var_34_1 * arg_34_1 + iter_34_0

				var_34_2:getChildByName("Button_50"):setSwallowTouches(false)
				var_34_2:getChildByName("Button_50"):getChildByName("Label_52"):setString("")
				var_34_2:getChildByName("Button_50"):addTouchEventListener(function(arg_35_0, arg_35_1)
					if arg_35_1 ~= ccui.TouchEventType.ended then
						return
					end

					if #self.selecttbl < 3 then
						if self:checkIsLableSelect(arg_35_0.selectindex) then
							self:updateLablesData(arg_35_0.selectindex)
						else
							table.insert(self.selecttbl, arg_35_0.selectindex)
						end
					elseif self:checkIsLableSelect(arg_35_0.selectindex) then
						self:updateLablesData(arg_35_0.selectindex)
					else
						global_ShowBlockWords(COMMUNITY_COMMUNITYSETTINGLAYER.tips8)
					end

					self:updateMedalTableViewPanel()
				end)

				if self.labledata[var_34_1 * arg_34_1 + iter_34_0] then
					local var_34_3 = self.labledata[var_34_1 * arg_34_1 + iter_34_0].des or nil

					if var_34_3 then
						var_34_2:getChildByName("Button_50"):getChildByName("Label_52"):setString(var_34_3)
						var_34_2:setVisible(true)

						var_34_2:getChildByName("Button_50").selectindex = var_34_1 * arg_34_1 + iter_34_0
						var_34_2.index = var_34_1 * arg_34_1 + iter_34_0

						goto label_34_0
					end
				end

				var_34_2:setVisible(false)

				::label_34_0::

				var_34_0:addChild(var_34_2)

				if self:checkIsLableSelect(var_34_1 * arg_34_1 + iter_34_0) then
					var_34_2:getChildByName("Button_50"):loadTextures(var_0_15.on, nil, var_0_15.on, var_0_11)
				else
					var_34_2:getChildByName("Button_50"):loadTextures(var_0_15.off, nil, var_0_15.off, var_0_11)
				end
			end

			self:updateLableLayer()
		else
			local var_34_4 = 4

			for iter_34_1 = 1, 4 do
				local var_34_5 = var_34_0:getChildByName("sp_" .. iter_34_1)

				if self.labledata[var_34_4 * arg_34_1 + iter_34_1] then
					local var_34_6 = self.labledata[var_34_4 * arg_34_1 + iter_34_1].des or nil

					if var_34_6 then
						var_34_5:getChildByName("Button_50"):getChildByName("Label_52"):setString(var_34_6)
						var_34_5:setVisible(true)

						var_34_5:getChildByName("Button_50").selectindex = var_34_4 * arg_34_1 + iter_34_1
						var_34_5.index = var_34_4 * arg_34_1 + iter_34_1

						goto label_34_1
					end
				end

				var_34_5:setVisible(false)

				::label_34_1::

				if self:checkIsLableSelect(var_34_4 * arg_34_1 + iter_34_1) then
					var_34_5:getChildByName("Button_50"):loadTextures(var_0_15.on, nil, var_0_15.on, var_0_11)
				else
					var_34_5:getChildByName("Button_50"):loadTextures(var_0_15.off, nil, var_0_15.off, var_0_11)
				end
			end

			self:updateLableLayer()
		end

		return var_34_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.tableview1:registerScriptHandler(function(arg_37_0, arg_37_1)
		return self:getCurDataListLen()
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.tableview1:reloadData()
end

function PopCommunitySettingLayer:updateDeclarationLayer()
	self.declable:setString(self.editBox:getText())
end

function PopCommunitySettingLayer:updateLableLayer()
	self.lablenum:setString(#self.selecttbl .. "/" .. 3)
end

function PopCommunitySettingLayer.checkIsVialid(arg_40_0)
	return true
end

function PopCommunitySettingLayer:initBg(arg_41_1)
	local var_41_0 = ccui.Layout:create()

	var_41_0:setTouchEnabled(true)
	var_41_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_41_0:setAnchorPoint(cc.p(0, 0))
	var_41_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_41_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_41_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_41_0:setOpacity(0)
	var_41_0:setCascadeOpacityEnabled(false)
	self:addChild(var_41_0, -1)

	local var_41_1 = ccui.ImageView:create("mainScenebg/blur_mask.png")

	var_41_1:setAnchorPoint(cc.p(0.5, 0.5))
	var_41_1:setPositionX(var_41_0:getContentSize().width / 2)
	var_41_1:setPositionY(var_41_0:getContentSize().height / 2)
	var_41_0:addChild(var_41_1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_42_0)
		self:addChild(arg_42_0, -2)
		arg_42_0:setPositionY(arg_42_0:getPositionY() - GameDisplay.fix_y)
		self:init(arg_41_1)
		var_41_0:setOpacity(102)
		var_41_0:setTouchEnabled(false)
	end)
end

function PopCommunitySettingLayer:exit()
	self.hideActions.shrinkVertical(self, function()
		if self.callback then
			self.callback(self.medalid, self.declaration, self.conditiondata[self.confition].type, self.conditiondata[self.confition].cond, var_0_12[self.verity].type)
		end

		LayerManager:removePopLayer(self.__queueindex)
	end)
end
