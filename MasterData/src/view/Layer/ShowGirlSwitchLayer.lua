ShowGirlSwitchLayer = class("ShowGirlSwitchLayer", function()
	return cc.Layer:create()
end)

local var_0_0 = config._DEBUG and 0 or 1
local discount_manager = require("controller.discount_manager")
local shop_manager = require("controller.shop_manager")
local playermodel = require("model.playermodel")
local item_manager = require("controller.item_manager")
local weapon_data = require("data.weapon_data")
local model_data = require("data.model_data")
local major_factor_data = require("data.major_factor_data")
local npc_data = require("data.npc_data")
local item_data = require("data.item_data")
local servant_data = require("data.servant_data")
local audio_manager = require("controller.audio_manager")
local drop_manager = require("controller.drop_manager")
local var_0_13 = require("controller.item_manager")
local ShowGirlLayer = require("view.Layer.ShowGirlLayer")

require("view.Layer.BackGroundLayer")

local var_0_15
local var_0_16 = 1
local var_0_17 = 2
local var_0_18 = {
	MAIN_SCENE = 1,
	PHOTO = 2
}

function ShowGirlSwitchLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = ShowGirlSwitchLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function ShowGirlSwitchLayer:init(arg_3_1)
	var_0_15 = self
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "ShowGirlSwitchLayer.json" or "ShowGirlSwitchLayer.ExportJson")

	self:addChild(self.rootLayer)
	self.rootLayer:setBackGroundImage(UIBG)

	self.curDisplayMode = var_0_17
	self.selectRole = arg_3_1.selectRole
	self.entryType = arg_3_1.entryType or var_0_18.MAIN_SCENE
	self.curModel = arg_3_1.selectModelid
	self.changeShowGirlCallBack = arg_3_1.changeShowGirlCallBack
	self.returnCallback = arg_3_1.returnCallback
	self.clickLock = false
	self.timer = cc.Node:create()

	self:addChild(self.timer)
	self:getShopSkinData()
	self:initShowGirlData()
	self:initDefaultRoleIndex()

	self.roleName = ccui.Helper:seekWidgetByName(self.rootLayer, "Label_roleName")

	self.roleName:setString(model_data[self.showRoleList[self.roleIndex].modelid].main_name)
	self.roleName:enableOutline(cc.c4b(0, 0, 0, 255), 1)
	self.roleName:setPositionY(90 - GameDisplay.fix_y)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_nameBg"):setPositionY(60 - GameDisplay.fix_y)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Button_before"):addTouchEventListener(function(arg_4_0, arg_4_1)
		if arg_4_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.clickLock then
			return
		end

		self.clickLock = true

		self.timer:stopAllActions()
		self.timer:runAction(cc.Sequence:create(cc.DelayTime:create(0.5), cc.CallFunc:create(function(...)
			self.clickLock = false
		end)))

		if #self.showRoleList == 1 then
			global_ShowBlockWords(L_SHOWGIRL_SKIN_LACK)
			audio_manager:playeffectMusicTest("sound/invalid")

			return
		end

		self.roleIndex = self.roleIndex - 1

		if self.roleIndex == 0 then
			self.roleIndex = #self.showRoleList
		end

		self:updateShowGirl()
		arg_4_0:setPositionX(50)
		arg_4_0:stopAllActions()
		arg_4_0:runAction((self:getBtnTouchActionObj(-1, function()
			arg_4_0:stopAllActions()
			arg_4_0:setPositionX(50)
			arg_4_0:runAction(self:getBtnActionObj(-1))
		end)))
	end)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Button_before"):runAction(self:getBtnActionObj(-1))
	ccui.Helper:seekWidgetByName(self.rootLayer, "Button_last"):addTouchEventListener(function(arg_7_0, arg_7_1)
		if arg_7_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.clickLock then
			return
		end

		self.clickLock = true

		self.timer:stopAllActions()
		self.timer:runAction(cc.Sequence:create(cc.DelayTime:create(0.5), cc.CallFunc:create(function(...)
			self.clickLock = false
		end)))

		if #self.showRoleList == 1 then
			global_ShowBlockWords(L_SHOWGIRL_SKIN_LACK)
			audio_manager:playeffectMusicTest("sound/invalid")

			return
		end

		self.roleIndex = self.roleIndex + 1
		self.roleIndex = self.roleIndex % #self.showRoleList

		if self.roleIndex == 0 then
			self.roleIndex = #self.showRoleList
		end

		self:updateShowGirl()
		arg_7_0:setPositionX(590)
		arg_7_0:stopAllActions()
		arg_7_0:runAction((self:getBtnTouchActionObj(1, function()
			arg_7_0:stopAllActions()
			arg_7_0:setPositionX(590)
			arg_7_0:runAction(self:getBtnActionObj(1))
		end)))
	end)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Button_last"):runAction(self:getBtnActionObj(1))

	self.listener = cc.EventListenerTouchOneByOne:create()

	self.listener:setSwallowTouches(false)
	self.listener:registerScriptHandler(function(arg_10_0, arg_10_1)
		return true
	end, cc.Handler.EVENT_TOUCH_BEGAN)
	self.listener:registerScriptHandler(function(arg_11_0, arg_11_1)
		local var_11_0 = arg_11_0:getStartLocation()
		local var_11_1 = arg_11_0:getLocation()

		if self.curDisplayMode == var_0_17 then
			if math.abs(var_11_0.x - var_11_1.x) < 200 then
				return
			end

			if var_11_0.x - var_11_1.x < 0 then
				self.roleIndex = self.roleIndex + 1
				dir = 1
			else
				self.roleIndex = self.roleIndex - 1
				dir = -1
			end

			self.roleIndex = self.roleIndex % #self.showRoleList

			if self.roleIndex == 0 then
				self.roleIndex = #self.showRoleList
			end

			self:updateShowGirl()
		else
			self.curDisplayMode = var_0_17

			self:switchShowMode()
		end
	end, cc.Handler.EVENT_TOUCH_ENDED)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(self.listener, ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_touchPanel"))
	self:initBottomList()
	self:updateShowGirl()
	self:switchShowMode()
	self:registerScriptHandler(function(arg_12_0)
		if arg_12_0 == "exit" then
			self.showgirlLayer:resetCurTalkConfig(self.modelid)

			var_0_15 = nil

			TextureManager:removeSpineTexturesWithOutCollect()
		end
	end)
end

function ShowGirlSwitchLayer:initDefaultRoleIndex()
	self.roleIndex = 1

	for iter_13_0, iter_13_1 in pairs(self.showRoleList) do
		if iter_13_1.unlock == 1 then
			roleIndex = iter_13_0
		end
	end
end

function ShowGirlSwitchLayer:switchShowMode()
	ccui.Helper:seekWidgetByName(self.rootLayer, "Button_before"):setVisible(self.curDisplayMode == var_0_17 and #self.showRoleList > 1)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Button_last"):setVisible(self.curDisplayMode == var_0_17 and #self.showRoleList > 1)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_nameBg"):setVisible(self.curDisplayMode == var_0_17)
	self.bottomList:setVisible(self.curDisplayMode == var_0_17)
	self.listener:setSwallowTouches(self.curDisplayMode == var_0_16)
end

function ShowGirlSwitchLayer:updateShowGirl()
	self:updateBottomList()

	self.modelid = self.showRoleList[self.roleIndex].modelid

	self.roleName:setString((model_data[self.modelid].main_name == "焕丽凤翎" or nil) and "焕丽凤  翎")

	if not model_data[self.modelid].background then
		-- block empty
	end

	if global_canshow_live2d(self.modelid) then
		self.displayedLive2d = true
	end

	local var_15_2 = 1

	if model_data[self.modelid].is_own_full_screen_background == 1 then
		var_15_2 = 2
	end

	local var_15_3 = model_data[self.modelid].backgroundid or 6300001

	if self.backGroundLayer ~= nil then
		self.backGroundLayer:update(var_15_3, var_15_2)
	else
		self.backGroundLayer = BackGroundLayer:create(var_15_3, var_15_2)

		ccui.Helper:seekWidgetByName(self.rootLayer, "Image_backGround"):getParent():addChild(self.backGroundLayer)
	end

	if not self.showgirlLayer then
		self.showgirlLayer = ShowGirlLayer:create(self.modelid, 3)

		ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_swtichShowGirl"):addChild(self.showgirlLayer, 1)
		self.showgirlLayer:resetCurTalkConfig(self.modelid)
	else
		self.showgirlLayer:update(self.modelid)
	end

	self.showgirlLayer:setTalkEnabled(false)
end

local function var_0_19(arg_16_0, arg_16_1)
	if var_0_13:haveItem(arg_16_0) then
		return true
	end

	if require("controller.antihexie_assets_manager"):isAntiHexieNow() then
		return true
	end

	if arg_16_1 == 1 then
		return false
	end

	return true
end

function ShowGirlSwitchLayer:initShowGirlData()
	self.showRoleList = {}

	local var_17_0

	if major_factor_data[self.selectRole] then
		for iter_17_0, iter_17_1 in pairs(servant_data) do
			if iter_17_1.major == self.selectRole and iter_17_1.classtype == 1 then
				table.insert(self.showRoleList, {
					itemid = iter_17_1.itemid,
					modelid = iter_17_1.modelid,
					unlock = playermodel.haveServant[iter_17_1.id] and 1 or 0
				})

				var_17_0 = iter_17_1.id
			end
		end

		local var_17_1 = 1

		while major_factor_data[self.selectRole]["item" .. var_17_1] do
			local var_17_2 = major_factor_data[self.selectRole]["item" .. var_17_1]

			if var_0_19(major_factor_data[self.selectRole]["item" .. var_17_1], major_factor_data[self.selectRole]["item" .. var_17_1 .. "_hide"]) then
				table.insert(self.showRoleList, {
					itemid = var_17_2,
					modelid = item_data[var_17_2].model,
					unlock = var_0_13:getItemNumber(var_17_2) > 0 and 1 or 0
				})
			end

			var_17_1 = var_17_1 + 1
		end

		if major_factor_data[self.selectRole].item_oc then
			local var_17_3 = major_factor_data[self.selectRole].item_oc
			local var_17_4 = {
				itemid = major_factor_data[self.selectRole].item_oc,
				modelid = item_data[major_factor_data[self.selectRole].item_oc].model,
				unlock = var_0_13:getItemNumber(major_factor_data[self.selectRole].item_oc) > 0 and 1 or 0
			}

			if var_17_4.modelid and global_get_model_attr(servant_data[item_data[var_17_3].servant].modelid) ~= "umaru" and not playermodel:isServantOverclockLockByTime(item_data[var_17_3].servant) then
				table.insert(self.showRoleList, var_17_4)
			end
		end

		if var_17_0 and global_get_model_attr(servant_data[var_17_0].modelid) ~= "umaru" then
			table.insert(self.showRoleList, {
				itemid = -1,
				unlock = 1,
				modelid = major_factor_data[self.selectRole].model
			})
		end
	else
		local var_17_5 = 1

		while npc_data[self.selectRole]["item" .. var_17_5] do
			if not npc_data[self.selectRole]["item" .. var_17_5 .. "_hide"] then
				table.insert(self.showRoleList, {
					itemid = npc_data[self.selectRole]["item" .. var_17_5],
					modelid = item_data[npc_data[self.selectRole]["item" .. var_17_5]].model,
					unlock = var_0_13:getItemNumber(npc_data[self.selectRole]["item" .. var_17_5]) > 0 and 1 or 0
				})
			end

			var_17_5 = var_17_5 + 1
		end

		table.insert(self.showRoleList, {
			itemid = -1,
			unlock = 1,
			modelid = npc_data[self.selectRole].model
		})
	end

	local var_17_6

	for iter_17_2, iter_17_3 in pairs(self.showRoleList) do
		if modelid == playermodel.showgirl then
			var_17_6 = iter_17_2
		end
	end

	if var_17_6 then
		table.remove(self.showRoleList, var_17_6)
		table.insert(self.showRoleList, {
			itemid = -1,
			unlock = 1,
			modelid = playermodel.showgirl
		})
	end

	local var_17_7 = 1

	while self.showRoleList[var_17_7] do
		if self.showRoleList[var_17_7].itemid ~= -1 and global_is_hide_skin_by_itemid(self.showRoleList[var_17_7].itemid) then
			table.remove(self.showRoleList, var_17_7)
		else
			var_17_7 = var_17_7 + 1
		end
	end

	if self.curModel then
		local var_17_8 = 1

		while self.showRoleList[var_17_8] do
			if self.showRoleList[var_17_8].modelid == self.curModel then
				table.remove(self.showRoleList, var_17_8)
			else
				var_17_8 = var_17_8 + 1
			end
		end

		table.insert(self.showRoleList, 1, {
			itemid = -1,
			unlock = 1,
			modelid = self.curModel
		})
	end
end

function ShowGirlSwitchLayer.getChangeDisplayModeHandle(arg_18_0)
	return function(arg_19_0, arg_19_1)
		if arg_19_1 ~= ccui.TouchEventType.ended then
			return
		end

		arg_18_0.curDisplayMode = arg_18_0.curDisplayMode == var_0_16 and var_0_17 or var_0_16

		arg_18_0:switchShowMode()
	end
end

function ShowGirlSwitchLayer:initBottomList()
	({
		[var_0_18.MAIN_SCENE] = function()
			self.bottomList = BottomBtnList:create(self:getExitHandel(), {
				{
					name = "sureBtn",
					word = L_BUTTON_TEXT.Switch,
					handler = self:getSureCallbackHandle()
				}
			})

			self.bottomList:setPositionY(-GameDisplay.fix_y)
			self.rootLayer:addChild(self.bottomList, 10)
		end
	})[self.entryType]()
end

function ShowGirlSwitchLayer:updateBottomList()
	({
		[var_0_18.MAIN_SCENE] = function()
			print("<<<<<<<<<<<<<<<<<<<<", self.showRoleList[self.roleIndex].unlock)

			if self.showRoleList[self.roleIndex].unlock == 1 then
				self.bottomList:getChildByName("sureBtn"):getChildByName("word"):setString(L_SHOWGIRL_BOTTOM_LIST[1])
				self.bottomList:getChildByName("sureBtn"):loadTextures("public/button/public_button_normal_y.png", "", "public/button/public_button_normal_y.png", var_0_0)
			elseif self.modelid == playermodel.showgirl then
				self.bottomList:getChildByName("sureBtn"):getChildByName("word"):setString(L_SHOWGIRL_BOTTOM_LIST[1])
				self.bottomList:getChildByName("sureBtn"):loadTextures("public/button/public_button_off.png", "", "public/button/public_button_off.png", var_0_0)
			else
				self.bottomList:getChildByName("sureBtn"):getChildByName("word"):setString(L_SHOWGIRL_BOTTOM_LIST[2])
				self.bottomList:getChildByName("sureBtn"):loadTextures("public/button/public_button_off.png", "", "public/button/public_button_off.png", var_0_0)
			end
		end
	})[self.entryType]()
end

function ShowGirlSwitchLayer.getShopSkinData(arg_24_0)
	arg_24_0.skinshops = {}

	shop_manager:get_shop_clothes_data(function(arg_25_0)
		arg_24_0.skinshops = arg_25_0
	end)
end

function ShowGirlSwitchLayer.getSureCallbackHandle(arg_26_0)
	return function(arg_27_0, arg_27_1)
		if arg_27_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_26_0.showRoleList[arg_26_0.roleIndex].unlock == 0 then
			local var_27_0 = arg_26_0.showRoleList[arg_26_0.roleIndex].itemid
			local var_27_1
			local var_27_2

			if item_data[arg_26_0.showRoleList[arg_26_0.roleIndex].itemid].bag_item_type == kITEM_HERO then
				var_27_1 = servant_data[item_data[var_27_0].servant].modelid
				var_27_2 = servant_data[item_data[var_27_0].servant].major
			else
				var_27_1 = item_data[var_27_0].model
				var_27_2 = model_data[item_data[var_27_0].model].major
			end

			local function var_27_3(arg_28_0, arg_28_1)
				if not arg_26_0.skinshops then
					return false
				end

				if not arg_26_0.skinshops.skin then
					return false
				end

				if not arg_26_0.skinshops.skin[arg_28_0] then
					return false
				end

				for iter_28_0, iter_28_1 in pairs(arg_26_0.skinshops.skin[arg_28_0]) do
					if item_data[iter_28_1.shopinfo.itemtype].model == arg_28_1 then
						return iter_28_1.shopinfo, iter_28_1.shoptype
					end
				end

				return false
			end

			print(item_data[var_27_0].targetlayer1)

			local var_27_4, var_27_5 = var_27_3(var_27_2, var_27_1)
			local var_27_6, var_27_7 = (function(arg_29_0, arg_29_1)
				if not arg_26_0.skinshops then
					return false
				end

				if not arg_26_0.skinshops.skin_package then
					return false
				end

				if not arg_26_0.skinshops.skin_package[arg_29_0] then
					return false
				end

				for iter_29_0, iter_29_1 in pairs(arg_26_0.skinshops.skin_package[arg_29_0]) do
					if item_data[iter_29_1.shopinfo.itemtype].mode_id then
						for iter_29_2, iter_29_3 in pairs((drop_manager:getEquipDrops(item_data[iter_29_1.shopinfo.itemtype].mode_id))) do
							if item_data[iter_29_3.dropid].model and item_data[iter_29_3.dropid].model == arg_29_1 then
								return iter_29_1.shopinfo, iter_29_1.shoptype
							end
						end
					elseif item_data[iter_29_1.shopinfo.itemtype].model == arg_29_1 then
						return iter_29_1.shopinfo, iter_29_1.shoptype
					end
				end

				return false
			end)(var_27_2, var_27_1)

			if var_27_0 == major_factor_data[var_27_2] and major_factor_data[var_27_2].item_oc then
				local var_27_8 = {}

				var_27_8.curSoul = item_data[var_27_0].servant or 23120

				function var_27_8.cancelcallback()
					if var_0_13:getItemNumber(var_27_0) > 0 then
						arg_26_0:updateData()
						arg_26_0:updateBottomList()
					end
				end

				LayerManager:pushInLayer("PopServantUpgradeLayer", var_27_8)
			elseif item_data[var_27_0].bag_item_type == kITEM_HERO then
				LayerManager:pushInLayer("PopGoGainLayer", {
					item = var_27_0
				})
			elseif item_data[var_27_0].targetlayer1 then
				local var_27_9 = {
					item = var_27_0,
					methods = {}
				}

				if var_27_4 then
					table.insert(var_27_9.methods, {
						des = L_SKIN_GO_GAIN.shop,
						shopPopFunc = function()
							arg_26_0:shopPop(var_27_4, var_27_5, "shopitem")
						end
					})
				elseif var_27_6 then
					table.insert(var_27_9.methods, {
						des = L_SKIN_GO_GAIN.shop,
						shopPopFunc = function()
							arg_26_0:shopPop(var_27_6, var_27_7, "giftitem")
						end
					})
				end

				LayerManager:pushInLayer("PopGoGainLayer", var_27_9)
			elseif var_27_4 then
				arg_26_0:shopPop(var_27_4, var_27_5, "shopitem")
			elseif var_27_6 then
				arg_26_0:shopPop(var_27_6, var_27_7, "giftitem")
			else
				LayerManager:pushInLayer("PopGoGainLayer", {
					item = var_27_0
				})
			end

			return
		end

		if arg_26_0.modelid == playermodel.showgirl then
			global_ShowBlockWords(L_SHOWGIRL_CANT_CHANGE)

			return
		end

		if not arg_27_0:isBright() then
			return
		end

		arg_27_0:setBright(false)

		local var_27_10 = arg_26_0.showRoleList[arg_26_0.roleIndex].modelid

		playermodel:setShowGirl(arg_26_0.showRoleList[arg_26_0.roleIndex].modelid, function(arg_33_0)
			if arg_33_0 == 0 then
				global_ShowBlockWords(L_SHOWGIRL_SWITCH_WARNING[0], RISE_WORDS_FAIL)
				audio_manager:playeffectMusicTest("sound/invalid")
			elseif arg_33_0 == 1 then
				LayerManager:removePopLayer()

				if arg_26_0.changeShowGirlCallBack then
					arg_26_0.changeShowGirlCallBack()
				end

				LayerManager:switchShowLayer("MainLayer")

				local var_33_0

				if RoleDefault:getInstance():getStringForKey("MainLayerShowGirl") ~= "" then
					var_33_0 = json.decode(RoleDefault:getInstance():getStringForKey("MainLayerShowGirl")) or {}

					if major_factor_data[arg_26_0.selectRole] then
						var_33_0["m" .. arg_26_0.selectRole] = var_27_10
					end
				end

				RoleDefault:getInstance():setStringForKey("MainLayerShowGirl", (json.encode(var_33_0)))
			elseif arg_33_0 == 2 then
				global_ShowBlockWords(L_SHOWGIRL_SWITCH_WARNING[2], RISE_WORDS_FAIL)
				audio_manager:playeffectMusicTest("sound/invalid")
				arg_27_0:setBright(true)
			elseif arg_33_0 == 3 then
				global_ShowBlockWords(L_SHOWGIRL_SWITCH_WARNING[3], RISE_WORDS_FAIL)
				audio_manager:playeffectMusicTest("sound/invalid")
				arg_27_0:setBright(true)
			else
				arg_27_0:setBright(true)
			end
		end)
	end
end

function ShowGirlSwitchLayer:updateData()
	self.showRoleList[self.roleIndex].unlock = 1
end

function ShowGirlSwitchLayer.shopPop(arg_35_0, arg_35_1, arg_35_2, arg_35_3)
	local var_35_1 = {
		function()
			return playermodel.gold
		end,
		[0] = function()
			return playermodel.diamond
		end,
		function()
			return playermodel.honor
		end,
		function()
			return playermodel.explorecoin
		end,
		[100] = function()
			return 0
		end
	}

	setmetatable(var_35_1, {
		__index = function(arg_41_0, arg_41_1)
			return function()
				return var_0_13:getItemNumber(arg_41_1)
			end
		end
	})

	local var_35_2 = {
		"public/currency/UI_battleEnd_gold.png",
		[0] = "public/currency/UI_battleEnd_diamond.png",
		"public/currency/arenascene_dot_1.png",
		"public/currency/explorecoin.png",
		[1500001] = "public/currency/1500001_1.png",
		[100] = "public/currency/rmb_white.png"
	}

	setmetatable(var_35_2, {
		__index = function(arg_43_0, arg_43_1)
			return "public/currency/" .. item_data[arg_43_1].image_id .. ".png"
		end
	})

	local var_35_3 = {
		function()
			LayerManager:pushInLayer("PopGoLayer", {
				targetlayer = "HandOfMidasLayer",
				labels = L_POPLAYER_SHOP_LABELS.SHOP_CURRENCY_GOLD
			})
		end,
		[0] = function()
			LayerManager:pushInLayer("PopGoBuyDiamond", {
				is_need_pop_layer = 1
			})
		end,
		function()
			LayerManager:pushInLayer("PopGoLayer", {
				targetlayer = "ArenaLayer",
				labels = L_POPLAYER_SHOP_LABELS.SHOP_CURRENCY_HORNOR
			})
		end,
		function()
			LayerManager:pushInLayer("PopGoLayer", {
				targetlayer = "ExploreMapLayer",
				labels = L_POPLAYER_SHOP_LABELS.SHOP_CURRENCY_EXPLORECOIN
			})
		end
	}

	setmetatable(var_35_3, {
		__index = function(arg_48_0, arg_48_1)
			return function()
				global_ShowBlockWords(string.format(L_COMMON_WARNING.Used_Up, item_data[arg_48_1].name))
				audio_manager:playeffectMusicTest("sound/invalid")
			end
		end
	})

	local var_35_4 = {}

	local function var_35_5(arg_50_0)
		local var_50_0 = var_35_4

		if arg_50_0.result == 1 then
			if not arg_50_0.selectCoupon then
				shop_manager:shop_buy(var_35_4.shoptype, var_35_4.shopitem.shopid, function(arg_51_0)
					if arg_51_0 == 1 then
						arg_35_1.have_bought = arg_35_1.have_bought + var_50_0.curbuyTime
						arg_35_1.sell_out = arg_35_1.buy_limit and arg_35_1.buy_limit <= arg_35_1.have_bought

						if item_data[var_50_0.itemid].bag_item_type == kITEM_SKIN then
							require("view.Layer.GetRoleAnimationLayer")
							cc.Director:getInstance():getRunningScene():addChild(GetRoleAnimationLayer:create(var_50_0.itemid), 1000)
						end

						if var_50_0.callback then
							var_50_0.callback()
						end

						arg_35_0:updateData()
						arg_35_0:updateBottomList()
					elseif arg_51_0 == 2 then
						global_ShowBlockWords(L_MARKET_MSG.Sold_Out)
						audio_manager:playeffectMusicTest("sound/invalid")
					elseif arg_51_0 == 3 then
						var_35_3[var_50_0.shopitem.currency]()
					end
				end, var_35_4.curbuyTime, function()
					LayerManager:removePopLayer()
				end)
			else
				shop_manager:shop_buy_with_ticket(var_35_4.shoptype, var_35_4.shopitem.shopid, function(arg_53_0)
					if arg_53_0 == 1 then
						arg_35_1.have_bought = arg_35_1.have_bought + var_50_0.curbuyTime
						arg_35_1.sell_out = arg_35_1.buy_limit and arg_35_1.buy_limit <= arg_35_1.have_bought

						if item_data[var_50_0.itemid].bag_item_type == kITEM_SKIN then
							require("view.Layer.GetRoleAnimationLayer")
							cc.Director:getInstance():getRunningScene():addChild(GetRoleAnimationLayer:create(var_50_0.itemid), 1000)
						end

						if var_50_0.callback then
							var_50_0.callback()
						end

						arg_35_0:updateData()
						arg_35_0:updateBottomList()
					elseif arg_53_0 == 2 then
						global_ShowBlockWords(L_MARKET_MSG.Sold_Out)
						audio_manager:playeffectMusicTest("sound/invalid")
					elseif arg_53_0 == 3 then
						var_35_3[var_50_0.shopitem.currency]()
					end
				end, var_35_4.curbuyTime, function()
					LayerManager:removePopLayer()
				end, arg_50_0.selectCoupon, 1)
			end
		end
	end

	local function var_35_6(arg_55_0)
		if not arg_55_0.currency2 or discount_manager:getLastPriceByItem(arg_55_0.itemid, arg_55_0.currency2, arg_55_0.discount2) < arg_55_0.discount2 then
			return true
		end

		return false
	end

	local function var_35_7(arg_62_0)
		local var_62_0 = {}

		if arg_62_0.currency2 then
			var_62_0.currency2 = arg_62_0.currency2
			var_62_0.costIcon2 = var_35_2[arg_62_0.currency2]
			var_62_0.cost2 = arg_62_0.discount2 or arg_62_0.price2
			var_62_0.cost_old2 = arg_62_0.price2
			var_62_0.discount2 = arg_62_0.discount2
		end

		var_62_0.name = item_data[arg_62_0.itemtype].name
		var_62_0.itemid = arg_62_0.itemtype
		var_62_0.shopid = arg_62_0.shopid
		var_62_0.costIcon = var_35_2[arg_62_0.currency]
		var_62_0.currency = arg_62_0.currency
		var_62_0.isnewitem = arg_62_0.isnewitem
		var_62_0.discountfinish = arg_62_0.discountfinish
		var_62_0.cost = arg_62_0.discount or arg_62_0.price
		var_62_0.quality = item_data[arg_62_0.itemtype].equip_quality or 1
		var_62_0.cost_old = arg_62_0.price
		var_62_0.bag_item_type = item_data[arg_62_0.itemtype].bag_item_type
		var_62_0.item_attr = arg_62_0.item_attr
		var_62_0.finish_time = arg_62_0.finish_time
		var_62_0.discount = arg_62_0.discount
		var_62_0.buy_limit = arg_62_0.buy_limit or 1000000
		var_62_0.have_bought = arg_62_0.have_bought or 0
		var_62_0.sell_out = arg_62_0.buy_limit and arg_62_0.buy_limit <= arg_62_0.have_bought
		var_62_0.tag = arg_62_0.tag or 0
		var_62_0.pos = arg_62_0.pos
		var_62_0.purchaseid = arg_62_0.productid

		return var_62_0
	end

	if arg_35_1.currency == 100 then
		(function(arg_58_0)
			local var_58_0 = {
				itemid = arg_58_0.itemid,
				item_attr = arg_58_0.item_attr
			}
			local var_58_1 = {
				costtype = arg_58_0.costIcon
			}

			var_58_1.costnum = arg_58_0.discount or arg_58_0.cost
			var_58_0.slidecost = var_58_1

			function var_58_0:ShopSliderCallback(arg_59_1, arg_59_2)
				if arg_59_1 ~= ccui.TouchEventType.ended then
					return
				end

				if arg_58_0.have_bought >= arg_58_0.buy_limit then
					global_ShowBlockWords(L_MARKET_MSG.Sold_Out)
					audio_manager:playeffectMusicTest("sound/invalid")

					return
				end

				self:setTouchEnabled(false)
				shop_manager:shop_purchase(arg_58_0.shopid, arg_58_0.purchaseid, function(arg_60_0)
					if arg_60_0 == 1 then
						arg_35_1.have_bought = arg_35_1.have_bought + curbuyTime
						arg_35_1.sell_out = arg_35_1.buy_limit and arg_35_1.buy_limit <= arg_35_1.have_bought

						LayerManager:removePopLayer(arg_35_0.__queueindex)

						if item_data[var_58_0.itemid].bag_item_type == kITEM_SKIN then
							require("view.Layer.GetRoleAnimationLayer")
							cc.Director:getInstance():getRunningScene():addChild(GetRoleAnimationLayer:create(var_58_0.itemid), 1000)
						end

						if arg_35_2 == 6 then
							for iter_60_0, iter_60_1 in pairs({
								{
									entityid = var_58_0.itemid
								}
							}) do
								net:rpc("use_gift_bag", {
									num = 1,
									entityid = iter_60_1.entityid
								}, function(arg_61_0)
									if arg_61_0.result == 1 then
										global_gain(arg_61_0)
										var_0_13:deleteItem(iter_60_1.entityid, 1)
									else
										global_ShowBlockWords(L_MARKET_MSG.Gift_Bag_Lack)
									end
								end)
							end
						else
							LayerManager:pushInLayer("PopPurchaseResultLayer", {
								items = {
									{
										dropNum = 1,
										dropid = var_58_0.itemid,
										entityid = var_58_0.itemid
									}
								}
							})
						end

						arg_35_0:updateData()
						arg_35_0:updateBottomList()
					elseif arg_60_0 == 2 then
						global_ShowBlockWords(L_MARKET_MSG.Goods_Sended)
						audio_manager:playeffectMusicTest("sound/invalid")
					end

					if arg_59_2 then
						arg_59_2(arg_60_0)
					end
				end)
			end

			if arg_35_2 == 4 or arg_35_2 == 6 then
				arg_35_0:showBuyPop(var_58_0, nil, arg_35_3)
			else
				print("暂时没给非服装商城做人民币支付")
			end

			arg_58_0.isnewitem = false
		end)(var_35_7(arg_35_1))
	else
		(function(arg_56_0)
			local var_56_0 = {
				itemid = arg_56_0.itemid,
				item_attr = arg_56_0.item_attr
			}

			var_56_0.limitNum = arg_56_0.buy_limit and (arg_56_0.buy_limit - arg_56_0.have_bought >= SHOP_NORMAL_BUY_LIMIT_NUM and SHOP_NORMAL_BUY_LIMIT_NUM or arg_56_0.buy_limit - arg_56_0.have_bought) or SHOP_NORMAL_BUY_LIMIT_NUM

			local var_56_1

			if var_35_6(arg_56_0) then
				var_56_1 = math.floor(var_35_1[arg_56_0.currency]() / arg_56_0.cost)
				var_56_0.currency = arg_56_0.currency
			else
				var_56_1 = math.floor(var_35_1[arg_56_0.currency2]() / arg_56_0.cost2)
				var_56_0.currency = arg_56_0.currency2
			end

			if var_56_1 > var_56_0.limitNum then
				var_56_0.limitNum = var_56_0.limitNum or var_56_1
			end

			local var_56_2 = arg_35_0:getResidueTime(arg_56_0.finish_time)

			if var_56_2 ~= "-1" then
				var_56_0.limit_time = L_MARKET_MSG.Rest_Time .. var_56_2
			end

			var_56_0.slidecost = {}

			if var_35_6(arg_56_0) then
				var_56_0.slidecost.costtype = arg_56_0.costIcon
				var_56_0.slidecost.costnum = arg_56_0.discount or arg_56_0.cost
				var_56_0.slidecost.nowHave = var_35_1[arg_56_0.currency]()
				var_56_0.slidecost.cost_old = arg_56_0.cost_old or var_56_0.slidecost.costnum
			else
				var_56_0.slidecost.costtype = arg_56_0.costIcon2
				var_56_0.slidecost.costnum = arg_56_0.discount2 or arg_56_0.cost2
				var_56_0.slidecost.nowHave = var_35_1[arg_56_0.currency2]()
				var_56_0.slidecost.cost_old = arg_56_0.cost_old2 or var_56_0.slidecost.costnum
			end

			function var_56_0:ShopSliderCallback(arg_57_1, arg_57_2, arg_57_3)
				if arg_57_1 ~= ccui.TouchEventType.ended then
					return
				end

				if not self:isBright() then
					return
				end

				local var_57_0 = self.nowNum or 1

				var_35_4 = {
					curbuyTime = var_57_0,
					shoptype = arg_35_2,
					itemid = var_56_0.itemid,
					callback = arg_57_2,
					shopitem = arg_56_0
				}

				if var_35_6(arg_56_0) and arg_56_0.cost > var_35_1[arg_56_0.currency]() then
					LayerManager:removePopLayer()
					var_35_3[arg_56_0.currency]()

					return
				end

				self:setTouchEnabled(false)
				var_35_5({
					result = 1,
					selectCoupon = arg_57_3
				})
			end

			var_56_0.hideGainButton = true

			if arg_56_0.have_bought and arg_56_0.buy_limit then
				var_56_0.limit_buy_num = arg_56_0.buy_limit - arg_56_0.have_bought
				var_56_0.have_bought_num = arg_56_0.have_bought
			end

			arg_35_0:showBuyPop(var_56_0, arg_35_2, arg_35_3)

			arg_56_0.isnewitem = false
		end)(var_35_7(arg_35_1))
	end
end

function ShowGirlSwitchLayer.getResidueTime(arg_63_0, arg_63_1)
	if not arg_63_1 then
		return "-1"
	end

	local var_63_5 = global_get_time_by_date(arg_63_1) - playermodel.onlineTime
	local var_63_6 = math.floor(var_63_5 / 24 / 3600)
	local var_63_7 = math.floor((var_63_5 - var_63_6 * 24 * 3600) / 3600)
	local var_63_8 = math.floor((var_63_5 - var_63_6 * 24 * 3600 - var_63_7 * 3600) / 60)

	return var_63_6 ~= 0 and string.format(L_TIME_TEXT[1], var_63_6, var_63_7) or var_63_7 ~= 0 and string.format(L_TIME_TEXT[2], var_63_7, var_63_8) or string.format(L_TIME_TEXT[3], var_63_8)
end

function ShowGirlSwitchLayer.showBuyPop(arg_64_0, arg_64_1, arg_64_2, arg_64_3)
	arg_64_1.couponList = discount_manager:getCanUseCoupin(arg_64_1.itemid, arg_64_1.currency, arg_64_1.costnum or arg_64_1.slidecost.costnum, arg_64_2)

	if not arg_64_2 then
		LayerManager:pushInLayer("PopGoodsLayer", arg_64_1)
	elseif arg_64_3 == "shopitem" then
		LayerManager:pushInLayer("PopGoodsLayer", arg_64_1)
	elseif arg_64_3 == "giftitem" then
		if arg_64_1.couponList and next(arg_64_1.couponList) then
			LayerManager:pushInLayer("PopGoodsLayer", arg_64_1)
		else
			LayerManager:pushInLayer("PopSkinPackage", arg_64_1)
		end
	else
		LayerManager:pushInLayer("PopGoodsLayer", arg_64_1)
	end
end

function ShowGirlSwitchLayer.getExitHandel(arg_65_0)
	return function(arg_66_0, arg_66_1)
		if arg_66_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:removePopLayer()

		if arg_65_0.returnCallback then
			arg_65_0.returnCallback(arg_65_0.displayedLive2d)
		end

		girlselectlayerInstance = nil
	end
end

function ShowGirlSwitchLayer.getBtnActionObj(arg_67_0, arg_67_1)
	return (cc.RepeatForever:create(cc.Sequence:create(cc.MoveBy:create(0.2, cc.p(16 * arg_67_1, 0)), cc.MoveBy:create(0.3, cc.p(-24 * arg_67_1, 0)), cc.MoveBy:create(0.1, cc.p(8 * arg_67_1, 0)), cc.DelayTime:create(0.8))))
end

function ShowGirlSwitchLayer.getBtnTouchActionObj(arg_68_0, arg_68_1, arg_68_2)
	return (cc.Sequence:create(cc.MoveBy:create(0.2, cc.p(32 * arg_68_1, 0)), cc.MoveBy:create(0.3, cc.p(-48 * arg_68_1, 0)), cc.MoveBy:create(0.1, cc.p(16 * arg_68_1, 0)), cc.CallFunc:create(arg_68_2)))
end

function ShowGirlSwitchLayer:exit()
	LayerManager:removePopLayer()

	if self.returnCallback then
		self.returnCallback(self.displayedLive2d)
	end

	girlselectlayerInstance = nil
end
