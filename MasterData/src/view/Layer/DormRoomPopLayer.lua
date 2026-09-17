DormRoomPopLayer = class("DormRoomPopLayer", function(...)
	return DormRoomLayer.new()
end)

local weapon_manager = require("controller.weapon_manager")
local item_manager = require("controller.item_manager")
local role_conversation_data = require("data.role_conversation_data")
local conversation_class_data = require("data.conversation_class_data")
local conversation_type_data = require("data.conversation_type_data")
local favorconversation_data = require("data.favorconversation_data")
local model_data = require("data.model_data")
local major_factor_data = require("data.major_factor_data")
local favor_data = require("data.favor_data")
local item_data = require("data.item_data")
local shop_data = require("data.shop_data")
local drop_data = require("data.drop_data")
local drop_manager = require("controller.drop_manager")
local ShowGirlLayer = require("view.Layer.ShowGirlLayer")
local ItemSprite = require("view.Sprite.ItemSprite")
local test_fight_manager = require("controller.test_fight_manager")
local activity_manager = require("controller.activity_manager")
local goodwell_manager = require("controller.goodwell_manager")
local dormitory_manager = require("controller.dormitory_manager")
local audio_manager = require("controller.audio_manager")
local shop_manager = require("controller.shop_manager")
local playermodel = require("model.playermodel")
local var_0_22 = config._DEBUG and 0 or 1
local discount_manager = require("controller.discount_manager")
local servant_data = require("data.servant_data")
local var_0_25 = {}
local var_0_26 = {
	"mainScenebg/dorm.jpg",
	"mainScenebg/dorm_dusk.jpg",
	"mainScenebg/dorm_night.jpg"
}
local var_0_27 = {}
local var_0_28

function DormRoomPopLayer.getInstance()
	return var_0_28
end

function DormRoomPopLayer.create(arg_3_0, arg_3_1)
	local var_3_0 = DormRoomPopLayer.new(arg_3_1)

	var_3_0:initData(function(...)
		var_3_0:init(arg_3_1)
	end)

	return var_3_0
end

function DormRoomPopLayer.initData(arg_5_0, arg_5_1)
	dormitory_manager:init(function(arg_6_0)
		arg_5_0.roomInfos = arg_6_0.infos
		arg_5_0.soul_to_index = arg_6_0.indexs

		if arg_5_1 then
			arg_5_1()
		end
	end)
end

function DormRoomPopLayer:init(arg_7_1)
	var_0_28 = self
	self.soulid = arg_7_1.soulid
	self.servantid = arg_7_1.servantid
	self.isTestFightSelect = arg_7_1.isTestFightSelect
	self.selectType = arg_7_1.selectType
	self.arrayIndex = arg_7_1.arrayIndex

	for iter_7_0, iter_7_1 in pairs(self.roomInfos) do
		if iter_7_1.soulid == self.soulid then
			self.roomindex = iter_7_0
			self.isout = iter_7_1.state == 4
		end
	end

	if self.isout then
		global_ShowBlockWords("外出中")
	end

	if not self.roomindex then
		function self.updateFavorPoolUI(...)
			return
		end

		function self.initAutoGain(...)
			return
		end
	end

	touchLayer = ccui.Layout:create()

	touchLayer:setTouchEnabled(true)
	touchLayer:setContentSize(cc.Director:getInstance():getVisibleSize())
	touchLayer:setAnchorPoint(cc.p(0, 0))
	touchLayer:setPosition(cc.p(0, -GameDisplay.fix_y))
	touchLayer:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	touchLayer:setBackGroundColor(cc.c3b(0, 0, 0))
	touchLayer:setBackGroundColorOpacity(0)
	self:addChild(touchLayer, -1)

	self.modelid = dormitory_manager:getSoulDressModelid(self.soulid) or servant_data[self.servantid].modelid
	self.updateDressCallback = arg_7_1.updateDressCallback
	self.exitCallback = arg_7_1.exitCallback

	local var_7_0 = self.modelid

	self.dialogTable = {}
	self.lineNum = 1
	self.iscanswitch = true
	self.instance = self

	local var_7_1 = ccui.Layout:create()

	var_7_1:setContentSize(cc.size(640, GameDisplay.height))
	var_7_1:setTouchEnabled(false)
	self:addChild(var_7_1, -1)

	self.rootLayer = ccui.Layout:create()

	self.rootLayer:setContentSize(cc.size(640, GameDisplay.height))
	self.rootLayer:setTouchEnabled(false)
	self:addChild(self.rootLayer)

	local var_7_3 = tonumber(os.date("%H"))
	local var_7_4 = var_7_3 > 6 and var_7_3 < 15 and 1 or var_7_3 >= 15 and var_7_3 < 19 and 2 or 3

	self.background = ccui.ImageView:create(var_0_26[var_7_3 > 6 and var_7_3 < 15 and 1 or var_7_3 >= 15 and var_7_3 < 19 and 2 or 3])

	self.background:setPosition(GameDisplay.cx, GameDisplay.height / 2 - GameDisplay.fix_y)
	self.background:setTouchEnabled(false)
	self.rootLayer:addChild(self.background)

	self.effectPanel = ccui.Layout:create()

	self.effectPanel:setContentSize(cc.size(640, 1136))
	self.effectPanel:setTouchEnabled(false)
	self.effectPanel:setOpacity(0)
	self.rootLayer:addChild(self.effectPanel, 999)

	for iter_7_2, iter_7_3 in pairs(playermodel.dormRoomConfig) do
		if iter_7_3.soulid > 0 and not var_0_27[iter_7_3.soulid] then
			var_0_27[iter_7_3.soulid] = {
				AngryTimes = 0,
				TalkTimes = 0
			}
		end
	end

	self:initRoomUI()
	self:initRole()
	self:GirlFirstTalk(var_7_4)
	self:fullScreen()
	self:slideSwitchRoom()
	self:initArrow()
	self:initAutoGain()
	self:registerEvent()

	if arg_7_1.curShowPanel then
		self:switchShowPanelList(arg_7_1.curShowPanel)

		local marry_manager = require("controller.marry_manager")

		if arg_7_1.curShowPanel == "Panel_gift" and not marry_manager:checkIsMarried(self.soulid) and marry_manager:check_marry_flag(self.soulid, 2) then
			LayerManager:pushInLayer("MarryPopLayer", {
				majorid = self.soulid,
				exitCallback = function()
					if DormRoomLayer and DormRoomLayer.getInstance() then
						DormRoomLayer.getInstance():updateDressUI()
						DormRoomLayer.getInstance():updateFavorBar()
					elseif DormRoomPopLayer and DormRoomPopLayer.getInstance() then
						DormRoomPopLayer.getInstance():updateDressUI()
						DormRoomPopLayer.getInstance():updateFavorBar()
					end
				end
			})
		end
	end

	if self.isTestFightSelect then
		self.sendGift:setVisible(false)
	end

	self:registerScriptHandler(function(arg_11_0)
		if arg_11_0 == "exit" then
			var_0_28 = nil

			if self.buttonFavor then
				self.buttonFavor:release()
			end

			if arg_7_1 and arg_7_1.updateDressCallback and var_7_0 ~= self.modelid then
				arg_7_1.updateDressCallback()
			end

			activity_manager:releaseEventListenerByName("DormRoomPopLayer")

			if arg_7_1 and arg_7_1.exitCallback then
				arg_7_1.exitCallback()
			end
		end
	end)

	if not self.roomindex then
		self.favorPoolBar:setVisible(false)
		self.favorPoolLabel:setVisible(false)
		self.favorPoolBnt:setVisible(false)
		ccui.Helper:seekWidgetByName(self.uiPanel, "Button_return"):addTouchEventListener(function(arg_12_0, arg_12_1)
			if arg_12_1 ~= ccui.TouchEventType.ended then
				return
			end

			LayerManager:removePopLayer()
		end)
	end
end

function DormRoomPopLayer:registerEvent()
	activity_manager:registerEventListener("DormRoomPopLayer", activity_manager.activityEventId.CHANGE_TEST_E_FIGHT_ARRAY_SUCCESS, function(arg_14_0)
		LayerManager:removePopLayer(self.__queueindex)
	end)
	activity_manager:registerEventListener("DormRoomPopLayer", activity_manager.activityEventId.CHANGE_TEST_P_FIGHT_ARRAY_SUCCESS, function(arg_15_0)
		LayerManager:removePopLayer(self.__queueindex)
	end)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("ON_SELECT_SKIN", function(arg_16_0)
		self.modelid = arg_16_0.modelid

		if not self.dressPanel:haveDress(self.modelid) then
			self:updateDressUI()
		end

		self.dressPanel:switchDress(self.modelid)
	end), self)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("purchase_success", function(arg_17_0)
		self.dressPanel:switchDress(self.dressPanel.selectOrder)
	end), self)
end

function DormRoomPopLayer.initOther(arg_18_0, arg_18_1)
	return
end

function DormRoomPopLayer.slideSwitchRoom(arg_19_0)
	return
end

function DormRoomPopLayer.initArrow(arg_20_0)
	return
end

function DormRoomPopLayer:updateDressUI()
	self.dressPanel:getChildByName("Button_dress_sure"):setVisible(false)
	self.dressPanel:getChildByName("ScrollView"):removeAllChildren()

	self.dressPanel.selectOrder = nil

	self:initDressList()
end

function DormRoomPopLayer:isSameModel(arg_22_1)
	local var_22_0 = {}

	if self.selectType == SELECT_GIRL_TEST_FIGHT_EMPTY then
		var_22_0 = test_fight_manager:getPvpArray()
	elseif self.selectType == SELECT_GIRL_TEST_FIGHT_PLAYER then
		var_22_0 = test_fight_manager:getPlayerArray()
	end

	var_22_0[self.arrayIndex] = var_22_0[self.arrayIndex] or {}

	return arg_22_1 == var_22_0[self.arrayIndex].modelid
end

function DormRoomPopLayer:initDressList()
	local var_23_0 = 0
	local var_23_1 = -50
	local var_23_2 = self.dressPanel:getChildByName("ScrollView")
	local var_23_3 = dormitory_manager:getSoulDressesFromServant(self.servantid)

	while var_23_3[1] do
		local var_23_4

		if var_23_3[1] == self.modelid then
			table.insert(var_23_3, 1, (table.remove(var_23_3, 1)))

			break
		else
			var_23_4 = 1 + 1
		end
	end

	var_23_2:setInnerContainerSize(cc.size(#var_23_3 * 130 < var_23_2:getContentSize().width and var_23_2:getContentSize().width or #var_23_3 * 130, var_23_2:getContentSize().height))

	for iter_23_0, iter_23_1 in pairs(var_23_3) do
		local var_23_5 = ccui.Button:create("Dormitory/dress_bg.png", "Dormitory/dress_bg.png", "Dormitory/dress_bg.png", var_0_22)

		var_23_5:setAnchorPoint(cc.p(1, 0.5))
		var_23_5:setScale(170 / var_23_5:getContentSize().height)
		var_23_5:setPosition(iter_23_0 * 130, var_23_2:getContentSize().height / 2)

		var_23_5.entityid = model_data[iter_23_1].itemid or -1

		var_23_5:setName(iter_23_1)
		var_23_2:addChild(var_23_5)

		local var_23_6 = ccui.Layout:create()

		var_23_6:setBackGroundImageColor(cc.c3b(255, 0, 0))
		var_23_6:setContentSize(cc.size(188, 244))
		var_23_6:setAnchorPoint(cc.p(0, 1))
		var_23_6:setPosition(cc.p(2, var_23_5:getContentSize().height - 3))
		var_23_6:setClippingEnabled(true)
		var_23_6:setBackGroundColor(cc.c3b(0, 0, 0))
		var_23_6:setName("clipLayer")
		var_23_5:addChild(var_23_6, 2)

		local var_23_7 = ccui.ImageView:create(PANEL_ROLE_IMAGE_PATH .. model_data[iter_23_1].role_image .. ".png")

		var_23_7:setScale(1)
		var_23_7:setAnchorPoint(cc.p(0.5, 0.5))
		var_23_7:setPosition(cc.p(var_23_6:getContentSize().width / 2 + var_23_0, var_23_6:getContentSize().height / 2 + var_23_1))
		var_23_7:setName("photo")
		var_23_6:addChild(var_23_7)
		assert(model_data[iter_23_1].main_name, "去揍策划, 此modelid:" .. iter_23_1 .. "没填main_name")

		local var_23_8 = cc.Label:createWithTTF(model_data[iter_23_1].main_name, FONT_NAME, 30)

		var_23_8:setPosition(cc.p(var_23_5:getContentSize().width / 2, 20))
		var_23_8:setName("nameLable")
		var_23_5:addChild(var_23_8)

		local var_23_9 = ccui.ImageView:create("Dormitory/used_skin.png", var_0_22)

		var_23_9:setPosition(cc.p(var_23_9:getContentSize().width / 2 + 15, var_23_5:getContentSize().height - var_23_9:getContentSize().height / 2 - 4))
		var_23_9:setName("used_skin")
		var_23_9:setVisible(false)
		var_23_9:setScale(math.max(var_23_5:getContentSize().height / 170, 1))
		var_23_5:addChild(var_23_9, 100)
		print("playerModel.servantUsedskin[self.soulid] == dressImg.entityid", playermodel.servantUsedskin[self.servantid], var_23_5.entityid)

		if playermodel.servantUsedskin[self.servantid] == var_23_5.entityid then
			var_23_5:getChildByName("used_skin"):setVisible(true)
		else
			var_23_5:getChildByName("used_skin"):setVisible(false)
		end

		if var_23_5.entityid > 0 and not item_manager:haveItem(var_23_5.entityid) then
			var_23_5:setOpacity(180)

			local var_23_10
			local var_23_12 = false
			local var_23_13

			if dormitory_manager.skinshops.skin[self.soulid] and dormitory_manager.skinshops.skin[self.soulid][iter_23_1] then
				var_23_13 = dormitory_manager.skinshops.skin[self.soulid][iter_23_1]
			elseif dormitory_manager.skinshops.skin_package[self.soulid] and dormitory_manager.skinshops.skin_package[self.soulid][iter_23_1] then
				var_23_13 = dormitory_manager.skinshops.skin_package[self.soulid][iter_23_1]
			end

			if var_23_13 then
				if var_23_13.shopinfo.discount and var_23_13.shopinfo.discount < var_23_13.shopinfo.price or var_23_13.shopinfo.discount2 and var_23_13.shopinfo.discount2 < var_23_13.shopinfo.price2 then
					var_23_10 = "Dormitory/discount_logo.png"
					var_23_12 = true
				else
					var_23_10 = item_data[var_23_5.entityid].is_birth and "Dormitory/logo_bg.png" or shop_data[var_23_13.shopinfo.shopid].is_new and "Dormitory/logo_bg.png" or "Dormitory/logo_bg.png"
				end
			elseif item_data[var_23_5.entityid].is_birth then
				var_23_10 = "Dormitory/logo_bg.png"
			elseif item_data[var_23_5.entityid].targetlayer1 and item_data[var_23_5.entityid].targetlayer1 ~= "-1" then
				var_23_10 = "Dormitory/logo_bg.png"
			end

			if var_23_10 then
				local var_23_14 = ccui.ImageView:create(var_23_10, var_0_22)

				var_23_14:setAnchorPoint(cc.p(0, 1))
				var_23_14:setScale(var_23_5:getContentSize().height / 170)
				var_23_14:setPosition(0, var_23_5:getContentSize().height)
				var_23_5:addChild(var_23_14, 9)

				if var_23_12 == false then
					local var_23_15 = ccui.Text:create(item_data[var_23_5.entityid].logo_str or "", FONT_NAME, 22)

					var_23_15:setPosition(cc.p(30, 18))
					var_23_14:addChild(var_23_15)
				end
			end
		else
			var_23_5:setOpacity(255)
			print("没有推荐信息," .. "modelid======" .. iter_23_1 .. "id======" .. var_23_5.entityid)
		end

		var_23_5:addTouchEventListener(function(arg_24_0, arg_24_1)
			if arg_24_1 ~= ccui.TouchEventType.ended then
				return
			end

			if not self.isCanChangePanel then
				return
			end

			if self.dressPanel.selectOrder == iter_23_1 then
				return
			end

			if self.switchDressIslock then
				return
			end

			self.switchDressIslock = true

			self.dressPanel:switchDress(iter_23_1, function()
				self.switchDressIslock = false
			end)
		end)
	end

	function self.dressPanel.haveDress(arg_26_0, arg_26_1)
		return self.dressPanel:getChildByName("ScrollView"):getChildByName(arg_26_1) ~= nil
	end

	function self.dressPanel:switchDress(arg_27_1, arg_27_2)
		local var_27_0 = self.dressPanel:getChildByName("ScrollView")
		local var_27_1 = var_27_0:getChildByName(arg_27_1)

		self.dressPanel:getChildByName("Button_dress_sure"):setVisible(true)

		if self.isTestFightSelect then
			if self:isSameModel(arg_27_1) then
				self.dressPanel:getChildByName("Button_dress_sure"):loadTextures("public/button/btn_remove.png", "public/button/btn_remove.png", "public/button/btn_remove.png", var_0_22)
			else
				self.dressPanel:getChildByName("Button_dress_sure"):loadTextures("public/button/use_btn.png", "public/button/use_btn.png", "public/button/use_btn.png", var_0_22)
			end
		elseif arg_27_1 == self.modelid then
			self.roleBnt:setTalkEnabled(true)
			self.dressPanel:getChildByName("Button_dress_sure"):loadTextures("public/button/equipped_btn.png", "public/button/equipped_btn.png", "public/button/equipped_btn.png", var_0_22)
		else
			if model_data[arg_27_1].itemid and not item_manager:haveItem(model_data[arg_27_1].itemid) and arg_27_1 ~= servant_data[self.servantid].modelid then
				if dormitory_manager.skinshops.skin[self.soulid] and dormitory_manager.skinshops.skin[self.soulid][arg_27_1] then
					self.dressPanel:getChildByName("Button_dress_sure"):loadTextures("public/button/buy_btn.png", "public/button/buy_btn.png", "public/button/buy_btn.png", var_0_22)
				else
					self.dressPanel:getChildByName("Button_dress_sure"):loadTextures("public/button/buy_btn.png", "public/button/buy_btn.png", "public/button/buy_btn.png", var_0_22)
				end

				self.roleBnt:setTalkEnabled((var_0_25[arg_27_1] or 0) < PREVIEW_SHOWGIRL_MAX_TOUCH_COUNT)
			else
				self.dressPanel:getChildByName("Button_dress_sure"):loadTextures("public/button/change_dress_btn.png", "public/button/change_dress_btn.png", "public/button/change_dress_btn.png", var_0_22)
				self.roleBnt:setTalkEnabled(true)
			end

			AnalyticManager.dorm_click_dress({
				soulid = self.soulid,
				itemid = model_data[arg_27_1].itemid
			})
		end

		if self.selectOrder then
			local var_27_2 = var_27_0:getChildByName(self.selectOrder)

			if var_27_2 and var_27_2.entityid then
				var_27_2:getChildByName("heightLight"):removeFromParent()
			end
		end

		local var_27_5 = ccui.Layout:create()
		local var_27_6 = {}

		for iter_27_0 = 1, 2 do
			if iter_27_0 == 1 then
				if config._DEBUG then
					var_27_6[iter_27_0] = cc.Sprite:create("Dormitory/new_item_bg_on2.png") or cc.Sprite:createWithSpriteFrameName("Dormitory/new_item_bg_on2.png")
				end

				var_27_6[iter_27_0]:setScale(1.1)
				var_27_6[iter_27_0]:setOpacity(0)
				var_27_6[iter_27_0]:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.Spawn:create(cc.FadeIn:create(0.6), cc.ScaleTo:create(0.6, 1)), cc.Spawn:create(cc.FadeOut:create(1), cc.ScaleTo:create(1, 1.1)), cc.Spawn:create(cc.FadeIn:create(1), cc.ScaleTo:create(1, 1)), cc.Spawn:create(cc.FadeOut:create(0.6), cc.ScaleTo:create(0.6, 1.1)))))
			else
				if config._DEBUG then
					var_27_6[iter_27_0] = cc.Sprite:create("Dormitory/new_item_bg_on2.png") or cc.Sprite:createWithSpriteFrameName("Dormitory/new_item_bg_on2.png")
				end

				var_27_6[iter_27_0]:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.Spawn:create(cc.FadeOut:create(0.6), cc.ScaleTo:create(0.6, 1.1)), cc.Spawn:create(cc.FadeIn:create(1), cc.ScaleTo:create(1, 1)), cc.Spawn:create(cc.FadeOut:create(1), cc.ScaleTo:create(1, 1.1)), cc.Spawn:create(cc.FadeIn:create(0.6), cc.ScaleTo:create(0.6, 1)))))
			end

			var_27_6[iter_27_0]:setPosition(var_27_1:getContentSize().width / 2 - 3, var_27_1:getContentSize().height / 2)
			var_27_5:addChild(var_27_6[iter_27_0])
		end

		var_27_5:setName("heightLight")
		var_27_1:addChild(var_27_5)

		if arg_27_1 ~= self.roleBnt._modelid then
			self.roleBnt:update(arg_27_1, arg_27_2)
		elseif arg_27_2 then
			arg_27_2()
		end

		self.selectOrder = arg_27_1
	end
end

function DormRoomPopLayer:updateRoom(arg_28_1)
	self.roomorder = arg_28_1.roomorder

	if arg_28_1.roomindex then
		self.roomindex = arg_28_1.roomindex or DormitoryLayer.getInstance().rooms[self.roomorder].index
	end

	self.soulid = arg_28_1.soulid
	self.isout = arg_28_1.isout
	self.modelid = dormitory_manager:getSoulDressModelid(self.soulid) or servant_data[self.servantid].modelid
	self.dialogTable = {}
	self.lineNum = 1

	local var_28_2 = tonumber(os.date("%H"))
	local var_28_3 = var_28_2 > 6 and var_28_2 < 15 and 1 or var_28_2 >= 15 and var_28_2 < 19 and 2 or 3

	self.background:loadTexture(var_0_26[var_28_2 > 6 and var_28_2 < 15 and 1 or var_28_2 >= 15 and var_28_2 < 19 and 2 or 3])

	for iter_28_0, iter_28_1 in pairs(playermodel.dormRoomConfig) do
		if iter_28_1.soulid > 0 and not var_0_27[iter_28_1.soulid] then
			var_0_27[iter_28_1.soulid] = {
				AngryTimes = 0,
				TalkTimes = 0
			}
		end
	end

	self:updateRoomUI()
	self:updateRole()
	self:GirlFirstTalk(var_28_3)
	self:initAutoGain()
	GuideListener.cleanCurGuides()
	GuideListener.swallowEvent(false)
	GuideListener.lockGuideTrigger(false)
	GuideListener.updateGuides(self)
end

function DormRoomPopLayer:initDressUI()
	self.changeDress = ccui.Helper:seekWidgetByName(self.uiPanel, "Button_dress")

	self.changeDress:setLocalZOrder(9999)
	self.changeDress:addTouchEventListener(function(arg_30_0, arg_30_1)
		if arg_30_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:switchShowPanelList("Panel_dress")
	end)

	self.dressPanel = ccui.Helper:seekWidgetByName(self.uiPanel, "Panel_dress")

	self:initDressList()
	self.dressPanel:setPositionX(640)

	self.dressPanel.postype = "out"

	self.dressPanel:getChildByName("Button_cancel"):loadTextures("public/button/return_btn_bottom.png", "public/button/return_btn.png", "public/button/return_btn.png", var_0_22)
	self.dressPanel:getChildByName("Button_cancel"):addTouchEventListener(function(arg_31_0, arg_31_1)
		if arg_31_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:switchShowPanelList("Panel_dress")
		self.uiPanel:getChildByName("Button_return"):setVisible(true)
	end)
	self.dressPanel:getChildByName("Button_dress_sure"):setVisible(false)
	self.dressPanel:getChildByName("Button_dress_sure"):addTouchEventListener(function(arg_32_0, arg_32_1)
		if arg_32_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.isTestFightSelect then
			self:testFightUseSkin(self.dressPanel.selectOrder)

			return
		end

		if not self.dressPanel.selectOrder then
			return
		end

		if self.dressPanel.selectOrder == self.modelid then
			return
		end

		local var_32_0

		if model_data[self.dressPanel.selectOrder].itemid and self.dressPanel.selectOrder ~= servant_data[self.servantid].modelid then
			var_32_0 = model_data[self.dressPanel.selectOrder].itemid

			if not item_manager:haveItem(model_data[self.dressPanel.selectOrder].itemid) then
				local var_32_1, var_32_2 = (function(arg_33_0, arg_33_1)
					if not dormitory_manager.skinshops then
						return false
					end

					if not dormitory_manager.skinshops.skin then
						return false
					end

					if not dormitory_manager.skinshops.skin[arg_33_0] then
						return false
					end

					for iter_33_0, iter_33_1 in pairs(dormitory_manager.skinshops.skin[arg_33_0]) do
						if item_data[iter_33_1.shopinfo.itemtype].model == arg_33_1 then
							return iter_33_1.shopinfo, iter_33_1.shoptype
						end
					end

					return false
				end)(self.soulid, item_data[model_data[self.dressPanel.selectOrder].itemid].model)
				local var_32_3, var_32_4 = (function(arg_34_0, arg_34_1)
					if not dormitory_manager.skinshops then
						return false
					end

					if not dormitory_manager.skinshops.skin_package then
						return false
					end

					if not dormitory_manager.skinshops.skin_package[arg_34_0] then
						return false
					end

					for iter_34_0, iter_34_1 in pairs(dormitory_manager.skinshops.skin_package[arg_34_0]) do
						if item_data[iter_34_1.shopinfo.itemtype].mode_id then
							for iter_34_2, iter_34_3 in pairs((drop_manager:getEquipDrops(item_data[iter_34_1.shopinfo.itemtype].mode_id))) do
								if item_data[iter_34_3.dropid].model and item_data[iter_34_3.dropid].model == arg_34_1 then
									return iter_34_1.shopinfo, iter_34_1.shoptype
								end
							end
						elseif item_data[iter_34_1.shopinfo.itemtype].model == arg_34_1 then
							return iter_34_1.shopinfo, iter_34_1.shoptype
						end
					end

					return false
				end)(self.soulid, item_data[model_data[self.dressPanel.selectOrder].itemid].model)

				if item_data[model_data[self.dressPanel.selectOrder].itemid].skin_type == "marry" then
					LayerManager:pushInLayer("MarryPopLayer", {
						majorid = self.soulid,
						exitCallback = function()
							if DormRoomLayer and DormRoomLayer.getInstance() then
								DormRoomLayer.getInstance():updateDressUI()
								DormRoomLayer.getInstance():updateFavorBar()
							elseif DormRoomPopLayer and DormRoomPopLayer.getInstance() then
								DormRoomPopLayer.getInstance():updateDressUI()
								DormRoomPopLayer.getInstance():updateFavorBar()
							end
						end
					})
				elseif item_data[model_data[self.dressPanel.selectOrder].itemid].targetlayer1 then
					local var_32_5 = {
						item = model_data[self.dressPanel.selectOrder].itemid,
						methods = {}
					}

					if var_32_1 then
						table.insert(var_32_5.methods, {
							des = L_SKIN_GO_GAIN.shop,
							shopPopFunc = function()
								self:shopPop(var_32_1, var_32_2, "shopitem")
							end
						})
					elseif var_32_3 then
						table.insert(var_32_5.methods, {
							des = L_SKIN_GO_GAIN.shop,
							shopPopFunc = function()
								self:shopPop(var_32_3, var_32_4, "giftitem")
							end
						})
					end

					LayerManager:pushInLayer("PopGoGainLayer", var_32_5)
				elseif var_32_1 then
					self:shopPop(var_32_1, var_32_2, "shopitem")
				elseif var_32_3 then
					self:shopPop(var_32_3, var_32_4, "giftitem")
				else
					global_ShowBlockWords(L_CURRENT_SKIN_UNBLE_TO_BUY)
				end

				return
			end
		else
			var_32_0 = -1
		end

		arg_32_0:setTouchEnabled(false)

		local var_32_6 = playermodel.servantUsedskin[self.servantid] == -1 and servant_data[self.servantid].modelid or item_data[playermodel.servantUsedskin[self.servantid]].model

		dormitory_manager:changeSoulDress(self.soulid, var_32_0, function(arg_38_0, arg_38_1)
			if arg_38_0 == 1 then
				if var_32_0 > 0 then
					self.modelid = item_data[var_32_0].model or servant_data[self.servantid].modelid
				end

				self:updateFavorBar()
				self:updateFavorPoolUI()

				local var_38_1 = self.dressPanel:getChildByName("ScrollView"):getChildByName(self.dressPanel.selectOrder)

				if var_38_1 and var_38_1.entityid then
					var_38_1:getChildByName("heightLight"):removeFromParent()

					if playermodel.servantUsedskin[self.servantid] == var_38_1.entityid then
						var_38_1:getChildByName("used_skin"):setVisible(true)
					else
						var_38_1:getChildByName("used_skin"):setVisible(false)
					end
				end

				local var_38_2 = self.dressPanel:getChildByName("ScrollView"):getChildByName(var_32_6)

				if var_38_2 and var_38_2.entityid then
					if playermodel.servantUsedskin[self.servantid] == var_38_2.entityid then
						var_38_2:getChildByName("used_skin"):setVisible(true)
					else
						var_38_2:getChildByName("used_skin"):setVisible(false)
					end
				end

				self.dressPanel.selectOrder = nil

				self.dressPanel:getChildByName("Button_dress_sure"):setVisible(false)
				self:switchShowPanelList("Panel_dress")

				if not arg_38_1 then
					self.roleBnt:insertTalk(ROLE_CONVERSATION_TYPE.changeDress)
				end
			end

			arg_32_0:setTouchEnabled(true)
		end)
	end)
end

function DormRoomPopLayer:updateCurDress(arg_39_1, arg_39_2)
	if arg_39_2 > 0 then
		self.modelid = item_data[arg_39_2].model or servant_data[self.servantid].modelid
	end

	self:updateFavorBar()
	self:updateFavorPoolUI()

	self.dressPanel.selectOrder = nil

	self.dressPanel:getChildByName("Button_dress_sure"):setVisible(false)
	self:switchShowPanelList("Panel_dress")

	if not isFavorUp then
		self.roleBnt:insertTalk(ROLE_CONVERSATION_TYPE.changeDress)
	end
end

function DormRoomPopLayer:testFightUseSkin(arg_40_1)
	if self:isSameModel(arg_40_1) then
		if self.selectType == SELECT_GIRL_TEST_FIGHT_EMPTY then
			test_fight_manager:changePvpArrayByIndes(self.arrayIndex)
		elseif self.selectType == SELECT_GIRL_TEST_FIGHT_PLAYER then
			test_fight_manager:changePlayerArrayByIndes(self.arrayIndex)
		end

		return
	end

	if self.selectType == SELECT_GIRL_TEST_FIGHT_EMPTY then
		test_fight_manager:changePvpArrayByIndes(self.arrayIndex, self.servantid, arg_40_1)
	elseif self.selectType == SELECT_GIRL_TEST_FIGHT_PLAYER then
		test_fight_manager:changePlayerArrayByIndes(self.arrayIndex, self.servantid, arg_40_1)
	end
end

return DormRoomPopLayer
