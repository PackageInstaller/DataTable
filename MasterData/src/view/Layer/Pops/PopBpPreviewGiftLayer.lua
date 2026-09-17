PopBpPreviewGiftLayer = class("PopBpPreviewGiftLayer", function()
	return PopBaseLayer:create()
end)

require("view.Sprite.ItemSprite")

local L2Actor = require("view.Sprite.L2Actor")
local var_0_1 = config._DEBUG and 0 or 1
local item_data = require("data.item_data")
local model_data = require("data.model_data")
local favorfile_data = require("data.favorfile_data")
local playermodel = require("model.playermodel")
local activity_manager = require("controller.activity_manager")
local var_0_7 = {}

function PopBpPreviewGiftLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopBpPreviewGiftLayer.new()

	var_2_0:initBg(arg_2_1)

	return var_2_0
end

function PopBpPreviewGiftLayer:init(arg_3_1)
	print("open poplayer : PopBpPreviewGiftLayer")

	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "PopBpPreviewGiftLayer.json" or "PopBpPreviewGiftLayer.ExportJson")

	self.rootLayer:setContentSize(GameDisplay:getScreenSize())
	self:addChild(self.rootLayer)

	arg_3_1 = arg_3_1 or {}
	self.activityId = arg_3_1.activityId or 9
	self.imagePath = arg_3_1.imagePath or "ActivityBianhuaBP"

	self:initUI()
	self:registerActivityEventListener()
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" then
			activity_manager:releaseEventListenerByName("PopBpPreviewGiftLayer")
		end
	end)
end

function PopBpPreviewGiftLayer.registerActivityEventListener(arg_5_0)
	activity_manager:registerEventListener("PopBpPreviewGiftLayer", activity_manager.activityEventId.BATTLE_PASS_VIP_UPDATE, function(arg_6_0)
		arg_5_0:initShowLive2d()
	end)
end

function PopBpPreviewGiftLayer:initUI()
	self:initExitTouchEvent()
	self:initShowLive2d()
	self:initOrdGift()
	self:initVipGift()
	self:initSVIPGift()
end

function PopBpPreviewGiftLayer:initShowLive2d()
	self.panelUp = self.rootLayer:getChildByName("panel_bg")

	self.panelUp:setTouchEnabled(true)

	self.banner = self.panelUp:getChildByName("banner")

	self.banner:loadTextures(self.imagePath .. "/pre_banner.png", self.imagePath .. "/pre_banner.png", self.imagePath .. "/pre_banner.png", var_0_1)

	self.btnGoto = self.panelUp:getChildByName("btn_goto")

	self.btnGoto:addTouchEventListener(function(arg_9_0, arg_9_1)
		if arg_9_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer(activity_manager:getBuyVipJumpTo(self.activityId), {
			activityId = self.activityId,
			imagePath = self.imagePath
		})
	end)
	self.btnGoto:setVisible(not activity_manager:isBattlePassSVIP(self.activityId))
end

function PopBpPreviewGiftLayer:initExitTouchEvent()
	self.rootLayer:addTouchEventListener(function(arg_11_0, arg_11_1)
		if arg_11_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_11_0:isBright() then
			return
		end

		arg_11_0:setBright(false)
		self:exit()
	end)

	local var_10_0 = ccui.Layout:create()

	var_10_0:setContentSize(cc.size(640, 100))
	var_10_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_10_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_10_0:setBackGroundColorOpacity(0)
	var_10_0:setTouchEnabled(true)
	var_10_0:addTouchEventListener(function(arg_12_0, arg_12_1)
		if arg_12_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_12_0:isBright() then
			return
		end

		arg_12_0:setBright(false)
		self:exit()
	end)
	self:addChild(var_10_0, 0)
end

function PopBpPreviewGiftLayer:initOrdGift()
	local var_13_0 = self.panelUp:getChildByName("panel_putong"):getChildByName("ordView")

	for iter_13_0, iter_13_1 in pairs((activity_manager:getGiftPreviewList(self.activityId))) do
		local var_13_1 = ItemPurchaseSprite:createPurchaseItem(iter_13_1.dropid, iter_13_1.dropNum)

		var_13_1:setScale(0.7)
		var_13_1:setPosition(cc.p(100, 55))

		local var_13_2 = ccui.Layout:create()

		var_13_2:setContentSize(cc.size(var_13_1:getContentSize().width * 0.7 + 35, var_13_1:getContentSize().height * 0.7))
		var_13_2:addChild(var_13_1)
		var_13_0:pushBackCustomItem(var_13_2)

		local var_13_3 = ccui.Button:create(ITEM_BUTTON_DEFAULT_IMAGE, ITEM_BUTTON_DEFAULT_IMAGE, ITEM_BUTTON_DEFAULT_IMAGE, var_0_1)

		var_13_3:setContentSize(cc.size(var_13_1:getContentSize().width, var_13_1:getContentSize().height))
		var_13_3:setPosition(cc.p(var_13_1:getContentSize().width / 2, var_13_1:getContentSize().height / 2))
		var_13_3:setAnchorPoint(cc.p(0.5, 0.5))
		var_13_3:setName("layout")
		var_13_3:setSwallowTouches(false)
		var_13_1:addChild(var_13_3)
		var_13_3:addTouchEventListener(function(arg_14_0, arg_14_1)
			if arg_14_1 ~= ccui.TouchEventType.ended then
				return
			end

			showItemDetails(iter_13_1.dropid)
		end)
	end
end

function PopBpPreviewGiftLayer:initVipGift()
	local var_15_0 = self.panelUp:getChildByName("panel_sp"):getChildByName("spView")

	for iter_15_0, iter_15_1 in pairs((activity_manager:getSpGiftPreviewList(self.activityId))) do
		local var_15_1 = ItemPurchaseSprite:createPurchaseItem(iter_15_1.dropid, iter_15_1.dropNum)

		var_15_1:setScale(0.7)
		var_15_1:setPosition(cc.p(100, 55))

		local var_15_2 = ccui.Layout:create()

		var_15_2:setContentSize(cc.size(var_15_1:getContentSize().width * 0.7 + 35, var_15_1:getContentSize().height * 0.7))
		var_15_2:addChild(var_15_1)
		var_15_0:pushBackCustomItem(var_15_2)

		local var_15_3 = ccui.Button:create(ITEM_BUTTON_DEFAULT_IMAGE, ITEM_BUTTON_DEFAULT_IMAGE, ITEM_BUTTON_DEFAULT_IMAGE, var_0_1)

		var_15_3:setContentSize(cc.size(var_15_1:getContentSize().width, var_15_1:getContentSize().height))
		var_15_3:setPosition(cc.p(var_15_1:getContentSize().width / 2, var_15_1:getContentSize().height / 2))
		var_15_3:setAnchorPoint(cc.p(0.5, 0.5))
		var_15_3:setName("layout")
		var_15_3:setSwallowTouches(false)
		var_15_1:addChild(var_15_3)
		var_15_3:addTouchEventListener(function(arg_16_0, arg_16_1)
			if arg_16_1 ~= ccui.TouchEventType.ended then
				return
			end

			showItemDetails(iter_15_1.dropid)
		end)
	end
end

function PopBpPreviewGiftLayer:initSVIPGift()
	local var_17_0 = self.panelUp:getChildByName("pre_bg_big")
	local var_17_1 = var_17_0:getChildByName("svipGiftView")

	for iter_17_0, iter_17_1 in pairs((activity_manager:getBuySVIPDrop(self.activityId))) do
		local var_17_2 = ItemPurchaseSprite:createPurchaseItem(iter_17_1.dropid, iter_17_1.dropNum)

		var_17_2:setScale(0.7)
		var_17_2:setPosition(cc.p(80, 60))

		local var_17_3 = ccui.Layout:create()

		var_17_3:setContentSize(cc.size(var_17_2:getContentSize().width * 0.7 + 20, var_17_2:getContentSize().height * 0.7))
		var_17_3:addChild(var_17_2)
		var_17_1:pushBackCustomItem(var_17_3)

		local var_17_4 = ccui.Button:create(ITEM_BUTTON_DEFAULT_IMAGE, ITEM_BUTTON_DEFAULT_IMAGE, ITEM_BUTTON_DEFAULT_IMAGE, var_0_1)

		var_17_4:setContentSize(cc.size(var_17_2:getContentSize().width, var_17_2:getContentSize().height))
		var_17_4:setPosition(cc.p(var_17_2:getContentSize().width / 2, var_17_2:getContentSize().height / 2))
		var_17_4:setAnchorPoint(cc.p(0.5, 0.5))
		var_17_4:setName("layout")
		var_17_4:setSwallowTouches(false)
		var_17_2:addChild(var_17_4)
		var_17_4:addTouchEventListener(function(arg_18_0, arg_18_1)
			if arg_18_1 ~= ccui.TouchEventType.ended then
				return
			end

			showItemDetails(iter_17_1.dropid)
		end)
	end

	local var_17_5 = var_17_0:getChildByName("img_gift")

	var_17_5:loadTexture(self.imagePath .. "/img_gift.png", var_0_1)
	var_17_5:setPosition(cc.p(270, 105))
end

function PopBpPreviewGiftLayer:exit()
	self.rootLayer:runAction(cc.Sequence:create(cc.FadeOut:create(0.2), cc.CallFunc:create(function()
		LayerManager:removePopLayer(self.__queueindex)
	end)))
end

function PopBpPreviewGiftLayer:initBg(arg_21_1)
	local var_21_0 = ccui.Layout:create()

	var_21_0:setTouchEnabled(true)
	var_21_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_21_0:setAnchorPoint(cc.p(0, 0))
	var_21_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_21_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_21_0:setBackGroundColor(cc.c3b(2, 5, 24))
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
		var_21_0:setTouchEnabled(false)
	end)
end

function PopBpPreviewGiftLayer:showSoulGirlPop(arg_23_1, arg_23_2)
	local var_23_0 = activity_manager:getBattlePassLive2d(self.activityId) or "15330"
	local var_23_1 = ccs.GUIReader:getInstance()
	local var_23_2 = var_23_1:widgetFromJsonFile(config._DEBUG and "SoulGirlPop.json" or "SoulGirlPop.ExportJson")
	local var_23_3 = ccui.Helper:seekWidgetByName(var_23_2, "Panel_26")

	var_23_3.setLocalZOrder(var_23_1, 1)
	self:addChild(var_23_2)

	self.showSoulGirlScenePanel = ccui.Helper:seekWidgetByName(var_23_2, "Image_back")

	self.showSoulGirlScenePanel:setPosition(cc.p(320, 568))
	self.showSoulGirlScenePanel:setTouchEnabled(true)
	self.showSoulGirlScenePanel:setLocalZOrder(0)

	local var_23_4 = ccui.Helper:seekWidgetByName(var_23_2, "Button_return")

	if model_data[var_23_0].background and model_data[var_23_0].background == "dark" then
		var_23_4:loadTextures("MarketLayer/return_btn_dark.png", nil, "MarketLayer/return_btn_dark.png", var_0_1)
	else
		var_23_4:loadTextures("MarketLayer/return_btn_bright.png", nil, "MarketLayer/return_btn_bright.png", var_0_1)
	end

	var_23_4:setLocalZOrder(2)

	local function var_23_5(arg_24_0, arg_24_1)
		if arg_24_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.showgirlLayer:resetCurTalkConfig()
		var_23_2:runAction(cc.RemoveSelf:create())

		var_23_2 = nil
	end

	var_23_4:setTouchEnabled(false)
	self.showSoulGirlScenePanel:runAction(cc.Sequence:create(cc.DelayTime:create(0.1), cc.CallFunc:create(function(...)
		var_23_4:setTouchEnabled(true)
		var_23_4:addTouchEventListener(var_23_5)
	end)))

	local var_23_6 = ccui.Helper:seekWidgetByName(var_23_2, "Panel_cute_role")
	local var_23_7 = ccui.Helper:seekWidgetByName(var_23_2, "Image_cute_role")

	var_23_7:loadTexture("roleimage/role1/" .. model_data[var_23_0].cute_role .. ".png")
	var_23_7:setPosition(cc.p(var_23_6:getContentSize().width / 2, var_23_6:getContentSize().height / 2 + 30))
	var_23_7:setScale(0.4)
	var_23_7:setVisible(false)

	local var_23_8 = ccui.Helper:seekWidgetByName(var_23_2, "Panel_up"):setPositionY(568 + GameDisplay.fix_y)
	local var_23_9 = ccui.Helper:seekWidgetByName(var_23_2, "Panel_down"):setPositionY(568 - GameDisplay.fix_y)

	ccui.Helper:seekWidgetByName(var_23_2, "Panel_down"):setLocalZOrder(3)
	ccui.Helper:seekWidgetByName(var_23_2, "Panel_up"):setLocalZOrder(3)

	L2ActorSprite = L2Actor:create(ROLE_SPINE_PATH .. model_data[var_23_0].spine_model .. ".json", ROLE_SPINE_PATH .. model_data[var_23_0].spine_model .. ".atlas", (model_data[var_23_0].clothes_model or nil) and (CLOTHES_SPINE_PATH .. model_data[var_23_0].clothes_model .. ".atlas" or nil))

	L2ActorSprite:setScale(model_data[var_23_0].modelscale / 1.3 * 0.4, model_data[var_23_0].modelscale / 1.3 * 0.4)
	L2ActorSprite:setContentSize(cc.size(100, 200))
	L2ActorSprite:setPosition(cc.p(var_23_6:getContentSize().width / 2, var_23_6:getContentSize().height / 2 - 60))
	var_23_6:addChild(L2ActorSprite, 99)
	L2ActorSprite:playAni(nil, "idle", true)
	var_23_6:addTouchEventListener(function(arg_26_0, arg_26_1)
		if arg_26_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_26_0 = math.random(2, 5)

		local function var_26_1()
			L2ActorSprite:playAni(nil, "idle", true)
		end

		if var_26_0 == 2 then
			L2ActorSprite:playAni(var_26_1, "run", false)
		elseif var_26_0 == 3 then
			L2ActorSprite:playAni(var_26_1, "yule", false)
		elseif var_26_0 == 4 then
			L2ActorSprite:playAni(var_26_1, "chihe", false)
		else
			L2ActorSprite:playAni(var_26_1, "fadai", false)
		end
	end)

	local var_23_10 = ccui.Helper:seekWidgetByName(var_23_2, "Label_name")
	local var_23_11 = ccui.Helper:seekWidgetByName(var_23_2, "Image_cv")

	var_23_11:loadTexture("public/panelbg/cv_bg.png", var_0_1)

	if favorfile_data[3][model_data[var_23_0].photofile_model] then
		var_23_11:setVisible(favorfile_data[3][model_data[var_23_0].photofile_model] ~= L_CV_UNSURE)

		local var_23_12 = cc.Label:createWithTTF("CV/" .. favorfile_data[3][model_data[var_23_0].photofile_model], FONT_DES, 28)

		var_23_12:setPosition(cc.p(var_23_11:getContentSize().width / 2, var_23_11:getContentSize().height / 2 - 3))
		var_23_11:addChild(var_23_12)
	else
		var_23_11:setVisible(false)
	end

	var_23_10:setFontSize(global_change_fontsize_by_length(model_data[var_23_0].name, 40, 4, 6))
	var_23_10:setString(model_data[var_23_0].name)
	var_23_10:setLocalZOrder(9999)

	local var_23_13 = ccui.Helper:seekWidgetByName(var_23_2, "Label_name_bottom")
	local var_23_14 = ccui.Helper:seekWidgetByName(var_23_2, "Label_name_top")

	var_23_13:setString(model_data[var_23_0].main_name)
	var_23_14:setString(model_data[var_23_0].main_name)

	if model_data[var_23_0].background and model_data[var_23_0].background == "bright" then
		var_23_13:setColor(cc.c3b(40, 125, 205))
		var_23_14:setColor(cc.c3b(0, 255, 246))
	end

	local var_23_15 = ccui.Helper:seekWidgetByName(var_23_2, "Image_type")
	local var_23_16

	if model_data[var_23_0].live2d and not model_data[var_23_0].origin then
		var_23_16 = "MarketLayer/skin_type_live2d.png"
	elseif model_data[var_23_0].rolespine then
		var_23_16 = "MarketLayer/skin_type_spine.png"
	else
		var_23_15:setVisible(false)
	end

	var_23_15:loadTextures(var_23_16, nil, var_23_16, var_0_1)

	local var_23_17 = ccui.Helper:seekWidgetByName(var_23_2, "Image_cost_bottom")

	var_23_17:loadTexture("MarketLayer/cost_bottom_bright.png", var_0_1)
	var_23_17:setVisible(false)
	ccui.Helper:seekWidgetByName(var_23_2, "Image_name"):loadTexture("MarketLayer/skin_name_bottom_bright.png", var_0_1)

	local var_23_18 = ccui.Helper:seekWidgetByName(var_23_2, "Button_buy")

	var_23_18:loadTextures("MarketLayer/buy_btn_bright.png", nil, "MarketLayer/buy_btn_bright.png", var_0_1)

	local var_23_19 = ccui.Layout:create()

	var_23_19:setContentSize(cc.Director:getInstance():getVisibleSize())
	var_23_19:setAnchorPoint(cc.p(0.5, 0.5))
	var_23_19:setPosition(cc.p(cc.Director:getInstance():getVisibleSize().width / 2, cc.Director:getInstance():getVisibleSize().height / 2))
	var_23_19:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_23_19:setBackGroundColor(cc.c3b(0, 0, 0))
	var_23_19:setBackGroundColorOpacity(0)
	var_23_3:addChild(var_23_19, 2)

	local var_23_20 = cc.EventListenerTouchOneByOne:create()

	var_23_20:setSwallowTouches(false)
	var_23_20:registerScriptHandler(function(arg_28_0, arg_28_1)
		if arg_23_1.have_bought_num == 1 then
			return true
		end

		if var_0_7[playermodel.playerid][var_23_0] > PREVIEW_SHOWGIRL_MAX_TOUCH_COUNT + 1 and arg_23_1.have_bought_num ~= 1 then
			function arg_23_1.shopcallback()
				if var_23_2 then
					var_23_2:runAction(cc.RemoveSelf:create())
				end

				var_23_2 = nil
			end

			LayerManager:pushInLayer("PopGoodsLayer", arg_23_1)

			return true
		elseif var_0_7[playermodel.playerid][var_23_0] >= PREVIEW_SHOWGIRL_MAX_TOUCH_COUNT then
			var_0_7[playermodel.playerid][var_23_0] = var_0_7[playermodel.playerid][var_23_0] + 1

			global_ShowBlockWords(L_DORMROOM_SEND_GIFT.Interaciton_Used_Up)

			return false
		else
			return true
		end
	end, cc.Handler.EVENT_TOUCH_BEGAN)
	var_23_20:registerScriptHandler(function(arg_30_0, arg_30_1)
		return false
	end, cc.Handler.EVENT_TOUCH_ENDED)
	var_23_19:getEventDispatcher():addEventListenerWithSceneGraphPriority(var_23_20, var_23_19)

	if arg_23_1.have_bought_num == 1 then
		var_23_18:setVisible(false)
		var_23_17:setVisible(false)
	end

	local var_23_21 = ccui.Helper:seekWidgetByName(var_23_2, "Image_costType_new")

	self.showSoulGirlScenePanel:setVisible(true)
	var_23_21:setVisible(false)
	ccui.Helper:seekWidgetByName(var_23_2, "Label_cost_num_new"):setVisible(false)
	ccui.Helper:seekWidgetByName(var_23_2, "Panel_old_cost"):setVisible(false)

	self.showgirlLayer = require("view.Layer.ShowGirlLayer"):create(var_23_0, 3)

	self.showgirlLayer:resetCurTalkConfig()

	if not var_0_7[playermodel.playerid] then
		var_0_7[playermodel.playerid] = {}
		var_0_7[playermodel.playerid][var_23_0] = var_0_7[playermodel.playerid][var_23_0] or 0
	else
		var_0_7[playermodel.playerid][var_23_0] = var_0_7[playermodel.playerid][var_23_0] or 0
	end

	self.showgirlLayer:setTalkEnabled(arg_23_1.have_bought_num > 0 or var_0_7[playermodel.playerid][var_23_0] < PREVIEW_SHOWGIRL_MAX_TOUCH_COUNT)
	self.showgirlLayer:setTouchTalkCallback(function()
		var_0_7[playermodel.playerid][var_23_0] = var_0_7[playermodel.playerid][var_23_0] + 1

		self.showgirlLayer:setTalkEnabled(arg_23_1.have_bought_num > 0 or var_0_7[playermodel.playerid][var_23_0] < PREVIEW_SHOWGIRL_MAX_TOUCH_COUNT)
	end)
	var_23_3:addChild(self.showgirlLayer, 1)

	if model_data[var_23_0].backgroundid then
		var_23_3:addChild(BackGroundLayer:create(model_data[var_23_0].backgroundid, (model_data[var_23_0].is_own_full_screen_background == 1 or nil) and 2), 0)
	end
end
