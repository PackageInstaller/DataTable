PopSwimTeamInfoLayer = class("PopSwimTeamInfoLayer", function()
	return PopBaseLayer:create()
end)

local var_0_0 = 340
local var_0_1 = config._DEBUG and 0 or 1
local model_data = require("data.model_data")
local school_swim_manager = require("controller.school_swim_manager")

function PopSwimTeamInfoLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopSwimTeamInfoLayer.new()

	var_2_0:initBg(arg_2_1)

	return var_2_0
end

function PopSwimTeamInfoLayer:init(arg_3_1)
	print("open poplayer : PopSwimTeamInfoLayer")

	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "PopSwimTeamInfoLayer.json" or "PopSwimTeamInfoLayer.ExportJson")

	self:addChild(self.rootLayer)
	self:initUI()
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" then
			-- block empty
		end
	end)
end

function PopSwimTeamInfoLayer:initUI()
	self:addTouchEventMask()
	self:initExitTouchEvent()
	self:initLables()
	self:initTeamView()
end

function PopSwimTeamInfoLayer:addTouchEventMask()
	local var_6_0 = ccui.Layout:create()

	var_6_0:setContentSize(cc.size(640, 200))
	var_6_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_6_0:setPosition(cc.p(0, 0))
	var_6_0:setBackGroundColorOpacity(0)
	var_6_0:setTouchEnabled(true)
	var_6_0:addTouchEventListener(function(arg_7_0, arg_7_1)
		if arg_7_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_7_0:isBright() then
			return
		end

		arg_7_0:setBright(false)
		self:exit()
	end)
	self.rootLayer:addChild(var_6_0, 50)
end

function PopSwimTeamInfoLayer:initExitTouchEvent()
	self.rootLayer:setTouchEnabled(true)
	self.rootLayer:addTouchEventListener(function(arg_9_0, arg_9_1)
		if arg_9_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_9_0:isBright() then
			return
		end

		arg_9_0:setBright(false)
		self:exit()
	end)
end

function PopSwimTeamInfoLayer:initLables()
	self.teamPanel = self.rootLayer:getChildByName("panel_up")

	self.teamPanel:setTouchEnabled(true)
	self.teamPanel:getChildByName("lbl_name_1"):setString(L_SWIM_TEAM_INFO)
	self.teamPanel:getChildByName("lbl_name_2"):setString(L_SWIM_TEAM_INFO)

	local var_10_0 = self.rootLayer:getChildByName("panel_btn"):getChildByName("btn_shop")

	var_10_0:getChildByName("go_to_shop"):setString(L_SWIM_GOTO_SHOP)
	var_10_0:setVisible(false)
	self.rootLayer:getChildByName("panel_btn"):setLocalZOrder(9999)
	var_10_0:addTouchEventListener(function(arg_11_0, arg_11_1)
		if arg_11_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopSkinAccessLayer", {
			activityId = 500
		})
	end)
end

function PopSwimTeamInfoLayer:initTeamView()
	self.teamList = school_swim_manager:getTeamListSortById()

	if not self.teamList or not next(self.teamList) then
		return
	end

	if self.teamView then
		self:updateShowingCells()

		return
	end

	self.teamView = cc.TableView:create(cc.size(640, 750))

	self.teamView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.teamView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.teamView:setAnchorPoint(cc.p(0, 0))
	self.teamView:setPosition(-12, 53)
	self.teamView:setDelegate()
	self.teamPanel:addChild(self.teamView, 3)
	self.teamView:registerScriptHandler(function(arg_14_0, arg_14_1)
		return 640, var_0_0
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.teamView:registerScriptHandler(function(arg_13_0, arg_13_1)
		local var_13_0 = arg_13_0:dequeueCell()

		if not var_13_0 then
			var_13_0 = cc.TableViewCell:create()

			local var_13_2 = self:createTeamSprite(self.teamList[arg_13_1 + 1])

			var_13_2:setAnchorPoint(cc.p(0.5, 0.5))
			var_13_2:setPosition(cc.p(320, var_0_0 / 2))
			var_13_0:addChild(var_13_2)
			var_13_0:setLocalZOrder(999 - 10 * arg_13_1)
		else
			self:updateTeamSprite(var_13_0:getChildByTag(100), self.teamList[arg_13_1 + 1])
			var_13_0:setLocalZOrder(999 - 10 * arg_13_1)
		end

		return var_13_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.teamView:registerScriptHandler(function(arg_15_0, arg_15_1)
		return #self.teamList
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.teamView:reloadData()
end

function PopSwimTeamInfoLayer.createTeamSprite(arg_16_0, arg_16_1)
	local var_16_0 = ccui.ImageView:create("SwimMainLayer/team_bg.png", var_0_1)

	var_16_0:setTag(100)

	local var_16_1 = school_swim_manager:getModelByTeamId(arg_16_1.id)

	school_swim_manager:getModelByTeamId(arg_16_1.id)

	for iter_16_0 = 1, #var_16_1 do
		local var_16_2 = ccui.ImageView:create("SwimMainLayer/model_bg_1.png", var_0_1)

		var_16_2:setPosition(cc.p(136 * iter_16_0 - 64, 125))
		var_16_2:setName("model_bg" .. iter_16_0)
		var_16_0:addChild(var_16_2)

		local var_16_3 = ccui.ImageView:create("SwimMainLayer/model_bg_2.png", var_0_1)

		var_16_3:setPosition(cc.p(136 * iter_16_0 - 64, 125))
		var_16_3:setName("model_fg" .. iter_16_0)
		var_16_0:addChild(var_16_3)

		local var_16_4 = ccui.Layout:create()

		var_16_4:setClippingEnabled(true)
		var_16_4:setContentSize(var_16_3:getContentSize().width - 8, var_16_3:getContentSize().height - 8)
		var_16_4:setPosition(cc.p(4, 4))
		var_16_4:setTouchEnabled(false)
		var_16_4:setCascadeOpacityEnabled(true)
		var_16_4:setName("clip")
		var_16_2:addChild(var_16_4)

		local var_16_5 = ccui.ImageView:create("role/fight/" .. model_data[var_16_1[iter_16_0]].role_image .. ".png")

		var_16_5:setPosition((var_16_3:getContentSize().width - 8) / 2, (var_16_3:getContentSize().height - 8) / 2)
		var_16_5:setName("model_img" .. iter_16_0)
		var_16_4:addChild(var_16_5)

		local var_16_6 = cc.Label:createWithTTF(model_data[var_16_1[iter_16_0]].main_name, FONT_TITLE, 20)

		var_16_6:setName("model_name")
		var_16_6:setPosition(cc.p(63, 12))
		var_16_3:addChild(var_16_6, 50)

		local var_16_7 = ccui.Button:create(ITEM_BUTTON_DEFAULT_IMAGE, ITEM_BUTTON_DEFAULT_IMAGE, ITEM_BUTTON_DEFAULT_IMAGE, var_0_1)

		var_16_7:setContentSize(var_16_3:getContentSize().width - 8, var_16_3:getContentSize().height - 8)
		var_16_7:setPosition(cc.p(var_16_3:getContentSize().width / 2, var_16_3:getContentSize().height / 2))
		var_16_7:setAnchorPoint(cc.p(0.5, 0.5))
		var_16_7:setName("btn_layout")
		var_16_7:setSwallowTouches(false)
		var_16_3:addChild(var_16_7)
		var_16_7:addTouchEventListener(function(arg_17_0, arg_17_1)
			if arg_17_1 ~= ccui.TouchEventType.ended then
				return
			end

			local var_17_0 = arg_17_0:getTouchBeganPosition()

			if math.abs(var_17_0.y - arg_17_0:getTouchEndPosition().y) > 30 then
				return
			end

			if var_17_0.x - var_16_3:getPositionX() > 114 then
				return
			end

			LayerManager:pushInLayer("PopShowGilrPreviewLayer", {
				showGain = true,
				modelid = var_16_1[iter_16_0]
			})
		end)
	end

	local var_16_8 = ccui.ImageView:create("SwimMainLayer/line_1.png", var_0_1)

	var_16_8:setPosition(cc.p(16, 293))
	var_16_0:addChild(var_16_8)

	local var_16_9 = cc.Label:createWithTTF(string.format(L_SWIM_TEAM_NAMES[arg_16_1.id], arg_16_1.name), FONT_TITLE, 22)

	var_16_9:setAnchorPoint(cc.p(0, 0.5))
	var_16_9:setPosition(cc.p(25, 291))
	var_16_9:setName("lbl_team_name")
	var_16_0:addChild(var_16_9)

	local var_16_10 = cc.Label:createWithTTF(string.format(L_SWIM_BUFF_DES, arg_16_1.buffName, arg_16_1.buffDes), FONT_TITLE, 19)

	var_16_10:setAnchorPoint(cc.p(0, 1))
	var_16_10:setPosition(cc.p(25, 274))
	var_16_10:setName("lbl_buff")
	var_16_10:setColor(cc.c3b(106, 191, 251))
	var_16_10:setMaxLineWidth(520)
	var_16_0:addChild(var_16_10)

	return var_16_0
end

function PopSwimTeamInfoLayer.updateTeamSprite(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = school_swim_manager:getModelByTeamId(arg_18_2.id)

	for iter_18_0 = 1, #var_18_0 do
		local var_18_1 = arg_18_1:getChildByName("model_fg" .. iter_18_0)

		var_18_1:getChildByName("model_name"):setString(model_data[var_18_0[iter_18_0]].main_name)
		arg_18_1:getChildByName("model_bg" .. iter_18_0):getChildByName("clip"):getChildByName("model_img" .. iter_18_0):loadTexture("role/fight/" .. model_data[var_18_0[iter_18_0]].role_image .. ".png")
		var_18_1:getChildByName("btn_layout"):addTouchEventListener(function(arg_19_0, arg_19_1)
			if arg_19_1 ~= ccui.TouchEventType.ended then
				return
			end

			if math.abs(arg_19_0:getTouchBeganPosition().y - arg_19_0:getTouchEndPosition().y) > 30 then
				return
			end

			LayerManager:pushInLayer("PopShowGilrPreviewLayer", {
				modelid = var_18_0[iter_18_0]
			})
		end)
	end

	arg_18_1:getChildByName("lbl_team_name"):setString(string.format(L_SWIM_TEAM_NAMES[arg_18_2.id], arg_18_2.name))
	arg_18_1:getChildByName("lbl_buff"):setString(string.format(L_SWIM_BUFF_DES, arg_18_2.buffName, arg_18_2.buffDes))
end

function PopSwimTeamInfoLayer:exit()
	self.rootLayer:runAction(cc.Sequence:create(cc.FadeOut:create(0.2), cc.CallFunc:create(function()
		LayerManager:removePopLayer(self.__queueindex)
	end)))
end

function PopSwimTeamInfoLayer:initBg(arg_22_1)
	local var_22_0 = ccui.Layout:create()

	var_22_0:setTouchEnabled(true)
	var_22_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_22_0:setAnchorPoint(cc.p(0, 0))
	var_22_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_22_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	var_22_0:setOpacity(0)
	self:addChild(var_22_0, -1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_23_0)
		self:addChild(arg_23_0, -2)
		arg_23_0:setPositionY(arg_23_0:getPositionY() - GameDisplay.fix_y)

		local var_23_0 = ccui.ImageView:create("mainScenebg/blur_mask.png")

		var_23_0:setAnchorPoint(cc.p(0, 0))
		var_23_0:setPositionY(-GameDisplay.fix_y)
		self:addChild(var_23_0, -1)
		self:init(arg_22_1)
		var_22_0:setOpacity(102)
		var_22_0:setTouchEnabled(false)
	end)
end
