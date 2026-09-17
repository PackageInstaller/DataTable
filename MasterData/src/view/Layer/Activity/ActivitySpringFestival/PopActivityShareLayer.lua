PopActivityShareLayer = class("PopActivityShareLayer", function()
	return PopBaseLayer:create()
end)

local var_0_0 = config._DEBUG and 0 or 1
local activity_manager = require("controller.activity_manager")
local share_manager = require("controller.share_manager")

require("view.Sprite.ItemSprite")

local file_check_manager = require("controller.filedownloader.file_check_manager")
local activity_share_conf_data = require("data.activity_share_conf_data")
local item_data = require("data.item_data")

function PopActivityShareLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopActivityShareLayer.new()

	var_2_0:initBg(arg_2_1)

	return var_2_0
end

function PopActivityShareLayer:initBg(arg_3_1)
	if arg_3_1 then
		self.activityid = arg_3_1.activityid or nil
	end

	local var_3_0 = ccui.Layout:create()

	var_3_0:setTouchEnabled(true)
	var_3_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_3_0:setAnchorPoint(cc.p(0, 0))
	var_3_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_3_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_3_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_3_0:setOpacity(0)
	var_3_0:setCascadeOpacityEnabled(false)
	self:addChild(var_3_0, -1)

	local var_3_1 = ccui.ImageView:create("mainScenebg/blur_mask.png")

	var_3_1:setAnchorPoint(cc.p(0.5, 0.5))
	var_3_1:setPositionX(var_3_0:getContentSize().width / 2)
	var_3_1:setPositionY(var_3_0:getContentSize().height / 2)
	var_3_0:addChild(var_3_1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_4_0)
		self:addChild(arg_4_0, -2)
		arg_4_0:setPositionY(arg_4_0:getPositionY() - GameDisplay.fix_y)
		self:loadShareDataFromServer(function(arg_5_0, arg_5_1)
			self.data = arg_5_1

			self:init(arg_3_1)
		end)
		var_3_0:setOpacity(102)
		var_3_0:setTouchEnabled(false)
	end)
end

function PopActivityShareLayer:init(arg_6_1)
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "ActivityShare.json" or "ActivityShare.ExportJson")

	self:addChild(self.rootLayer)

	self.rootpanel = ccui.Helper:seekWidgetByName(self.rootLayer, "bg")

	self:initShareAwardListUI()
	self:initExitTouchEvent()

	if self.data and self.data.result == 1 then
		self:reInitShareUI(self.data)
	end

	self.rootLayer:setContentSize(GameDisplay.getScreenSize())
	self.rootLayer:setPositionY(-GameDisplay.fix_y)
	self.rootpanel:setPositionY(self.rootpanel:getPositionY() + GameDisplay.fix_y)
	self.showActions.extendVertical(self)
end

function PopActivityShareLayer:initShareAwardListUI()
	self.awardlist = self.rootpanel:getChildByName("awardlist")
	self.awarditems = {}
	self.awarditems[1] = self.awardlist:getChildByName("awarditem")

	self.awardlist:setVisible(false)

	self.shareinfo = self.rootpanel:getChildByName("info")

	self.shareinfo:setString(activity_share_conf_data[self.activityid].info)
	self.rootpanel:getChildByName("label1"):setVisible(false)
	self.rootpanel:getChildByName("label2"):setVisible(false)
	self.rootpanel:getChildByName("days"):setVisible(false)

	self.btnShare = self.rootpanel:getChildByName("btn_share")

	self.btnShare:getChildByName("award_bg"):setVisible(false)

	if not self.activityid or self.activityid ~= 104 then
		local var_7_0 = cc.Label:createWithTTF("x1", "fonts/name.ttf", 24)

		var_7_0:setAnchorPoint(cc.p(0.5, 0.5))
		var_7_0:setPosition(cc.p(self.btnShare:getChildByName("award_bg"):getContentSize().width / 2 + 48, self.btnShare:getChildByName("award_bg"):getContentSize().height / 2 + 10))
		var_7_0:setName("name_award")
		self.btnShare:getChildByName("award_bg"):addChild(var_7_0)
	else
		self.btnShare:getChildByName("award_bg"):setVisible(false)
	end

	local var_7_1 = self.btnShare:getChildByName("award_bg"):getChildByName("img_drop")

	if file_check_manager:checkFileNeedDownload("activitiesRes/activity" .. self.activityid .. "/share/img_drop.png") then
		var_7_1:loadTexture("activitiesRes/activity" .. self.activityid .. "/share/img_drop.png")
	elseif cc.FileUtils:getInstance():isFileExist("activitiesRes/activity" .. self.activityid .. "/share/img_drop.png") then
		var_7_1:loadTexture("activitiesRes/activity" .. self.activityid .. "/share/img_drop.png")
	end
end

function PopActivityShareLayer:loadShareDataFromServer(arg_8_1)
	print("loadShareDataFromServer: ", self.activityid)
	share_manager:get_activity_share_data(self.activityid, arg_8_1)
end

function PopActivityShareLayer:initExitTouchEvent()
	self.rootLayer:addTouchEventListener(function(arg_10_0, arg_10_1)
		if arg_10_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_10_0:isBright() then
			return
		end

		arg_10_0:setBright(false)
		self.hideActions.shrinkVertical(self, function()
			LayerManager:removePopLayer(self.__queueindex)
		end)
	end)
end

function PopActivityShareLayer:reInitShareUI(arg_12_1)
	if arg_12_1 == nil then
		return
	end

	print("ReInitShareUI: ", dump(arg_12_1))
	self.rootpanel:getChildByName("days"):setVisible(true)

	self.days = arg_12_1.days

	self.rootpanel:getChildByName("days"):setString(arg_12_1.days)
	self.rootpanel:getChildByName("label1"):setVisible(true)
	self.rootpanel:getChildByName("label2"):setVisible(true)
	self.shareinfo:setString(arg_12_1.info)
	self.btnShare:getChildByName("award_bg"):setVisible(arg_12_1.nowdrop)
	self:updateShareAwardList(arg_12_1.totaldrops)
	self:registerShareHandler()
	self.btnShare:addTouchEventListener(function(arg_13_0, arg_13_1)
		if arg_13_1 ~= ccui.TouchEventType.ended then
			return
		end

		if share_manager:can_share() then
			if arg_12_1.url:find(".jpg$") or arg_12_1.url:find(".png$") then
				share_manager:doShare(arg_12_1.title, arg_12_1.url, arg_12_1.content)
			else
				share_manager:doShare(arg_12_1.title, nil, arg_12_1.content, arg_12_1.url)
			end
		else
			self.testhandler()
		end
	end)
end

function PopActivityShareLayer.registerShareHandler(arg_14_0)
	share_manager:registerShareHandler(function(arg_15_0)
		if arg_15_0 == 0 and type(arg_14_0.onShareSuccess) == "function" then
			arg_14_0:onShareSuccess()
		end
	end)

	function arg_14_0.testhandler()
		if type(arg_14_0.onShareSuccess) == "function" then
			arg_14_0:onShareSuccess()
		end
	end
end

function PopActivityShareLayer:onShareSuccess()
	share_manager:activity_share_success(self.activityid, function(arg_18_0)
		if arg_18_0 == 1 then
			self.days = self.days + 1

			self.rootpanel:getChildByName("days"):setString(self.days)
			self.btnShare:getChildByName("award_bg"):setVisible(false)
			self:updateTotalAwardOnShareSuccess()
		end
	end)
	AnalyticManager.sharegame()
end

local var_0_6 = 8
local var_0_7 = 32
local var_0_8 = 132

function PopActivityShareLayer:updateShareAwardList(arg_19_1)
	if arg_19_1 == nil or #arg_19_1 <= 0 then
		return
	end

	self.awardlist:setVisible(true)
	self.awardlist:setInnerContainerSize(cc.size(#arg_19_1 * var_0_8, 200))
	table.sort(arg_19_1, function(arg_20_0, arg_20_1)
		return arg_20_0.id < arg_20_1.id
	end)

	for iter_19_0 = 2, #arg_19_1 do
		local var_19_0 = self.awarditems[1]:clone()

		var_19_0:setPosition(cc.p(var_0_6 + var_0_8 * (iter_19_0 - 1), var_0_7))
		self.awardlist:addChild(var_19_0)

		self.awarditems[iter_19_0] = var_19_0
	end

	for iter_19_1 = 1, #arg_19_1 do
		self.awarditems[iter_19_1]:setVisible(true)
		self:updateShareTotalAward(self.awarditems[iter_19_1], arg_19_1[iter_19_1])
	end
end

function PopActivityShareLayer:updateTotalAwardOnShareSuccess()
	for iter_21_0, iter_21_1 in ipairs(self.awarditems) do
		self:updateShareTotalAward(iter_21_1, iter_21_1.data)
	end
end

local var_0_9 = {
	"Activity_Spring_Festival/Share/bar_on.png",
	"Activity_Spring_Festival/Share/bar_off.png"
}
local var_0_10 = {
	"Activity_Spring_Festival/Share/btn_on.png",
	"Activity_Spring_Festival/Share/btn_off.png"
}
local var_0_11 = {
	"Activity_Spring_Festival/Share/triangle_on.png",
	"Activity_Spring_Festival/Share/triangle_off.png"
}

function PopActivityShareLayer:updateShareTotalAward(arg_22_1, arg_22_2)
	local var_22_0 = arg_22_2.dropid

	arg_22_1:getChildByName("img_itembg"):loadTexture("public/box/" .. item_data[arg_22_2.dropid].equip_quality .. ".png", var_0_0)
	arg_22_1:getChildByName("Label_drop_num"):setString("x" .. arg_22_2.dropNum)
	arg_22_1:getChildByName("img_itembg"):getChildByName("item"):loadTexture("equipment/" .. item_data[arg_22_2.dropid].image_id .. ".png")
	arg_22_1:getChildByName("img_itembg"):getChildByName("item"):setScale(0.5)
	arg_22_1:getChildByName("img_itembg"):setTouchEnabled(true)

	local var_22_1

	if arg_22_2.stat > 0 then
		arg_22_1:getChildByName("img_bar"):loadTexture(var_0_9[1], var_0_0)
		arg_22_1:getChildByName("img_tag"):loadTexture(var_0_11[1], var_0_0)
		arg_22_1:getChildByName("img_btn"):loadTexture(var_0_10[1], var_0_0)
		arg_22_1:getChildByName("img_btn"):getChildByName("info"):setString("已领取")
		arg_22_1:getChildByName("img_mask"):setVisible(true)
		arg_22_1:getChildByName("img_finish"):setVisible(true)

		function var_22_1(arg_23_0, arg_23_1)
			if arg_23_1 ~= ccui.TouchEventType.ended then
				return
			end
		end
	elseif self.days >= arg_22_2.id then
		arg_22_1:getChildByName("img_bar"):loadTexture(var_0_9[1], var_0_0)
		arg_22_1:getChildByName("img_tag"):loadTexture(var_0_11[1], var_0_0)
		arg_22_1:getChildByName("img_btn"):loadTexture(var_0_10[1], var_0_0)
		arg_22_1:getChildByName("img_btn"):getChildByName("info"):setString("可领取")
		arg_22_1:getChildByName("img_mask"):setVisible(false)
		arg_22_1:getChildByName("img_finish"):setVisible(false)

		function var_22_1(arg_24_0, arg_24_1)
			if arg_24_1 ~= ccui.TouchEventType.ended then
				return
			end

			share_manager:get_activity_total_share_award(self.activityid, arg_22_2.id, function(arg_25_0)
				if tolua.isnull(self) then
					return
				end

				if arg_25_0 == 1 then
					arg_22_2.stat = 1

					self:updateShareTotalAward(arg_22_1, arg_22_2)
				end
			end)
		end
	else
		arg_22_1:getChildByName("img_bar"):loadTexture(var_0_9[2], var_0_0)
		arg_22_1:getChildByName("img_tag"):loadTexture(var_0_11[2], var_0_0)
		arg_22_1:getChildByName("img_btn"):loadTexture(var_0_10[2], var_0_0)
		arg_22_1:getChildByName("img_btn"):getChildByName("info"):setString(string.format("累计%d天", arg_22_2.id))
		arg_22_1:getChildByName("img_mask"):setVisible(false)
		arg_22_1:getChildByName("img_finish"):setVisible(false)

		function var_22_1(arg_26_0, arg_26_1)
			if arg_26_1 ~= ccui.TouchEventType.ended then
				return
			end
		end
	end

	arg_22_1:getChildByName("img_btn"):setTouchEnabled(true)
	arg_22_1:getChildByName("img_btn"):addTouchEventListener(var_22_1)
	arg_22_1:addTouchEventListener(var_22_1)
	arg_22_1:getChildByName("img_itembg"):addTouchEventListener(function(arg_27_0, arg_27_1)
		if arg_27_1 ~= ccui.TouchEventType.ended then
			return
		end

		arg_27_0.itemid = var_22_0

		if self.days >= arg_22_2.id then
			share_manager:get_activity_total_share_award(self.activityid, arg_22_2.id, function(arg_28_0)
				if arg_28_0 == 1 then
					arg_22_2.stat = 1

					self:updateShareTotalAward(arg_22_1, arg_22_2)
				end
			end)

			return
		end

		self:showItemDeatil(arg_27_0)
	end)

	arg_22_1.data = arg_22_2
end

function PopActivityShareLayer:showItemDeatil(arg_29_1)
	if item_data[arg_29_1.itemid].bag_item_type == kITEM_HORCRUX then
		local var_29_0 = -1
		local var_29_1 = require("data.horcrux_data")[arg_29_1.itemid].horcruxtype

		for iter_29_0, iter_29_1 in pairs((require("data.photofile_HelpGirl_data"))) do
			if arg_29_1.itemid == iter_29_1.item_id then
				var_29_0 = iter_29_0

				break
			end
		end

		if var_29_0 == -1 then
			print("did not find id")

			return
		end

		LayerManager:pushInLayer("DetailsofHelpGirlLayer", {
			id = var_29_0,
			itemid = arg_29_1.itemid
		})
	elseif item_data[arg_29_1.itemid].bag_item_type == kITEM_HERO then
		LayerManager:pushInLayer("SoulsLayer", {
			showtype = 6,
			defaultDisplayType = "preview",
			layertype = "DropDetailsLayer",
			cursoul = item_data[arg_29_1.itemid].servant
		})
	elseif not self:getChildByName("OTHER_LAYER") then
		local var_29_2 = PopLayer:Item({
			hideGainButton = true,
			itemid = arg_29_1.itemid
		})
	end
end
