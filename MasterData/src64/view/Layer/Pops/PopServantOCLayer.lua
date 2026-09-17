PopServantOCLayer = class("PopServantOCLayer", function()
	return PopBaseLayer:create()
end)

local var_0_0 = config._DEBUG and 0 or 1
local playermodel = require("model.playermodel")
local audio_manager = require("controller.audio_manager")
local autopop_manager = require("controller.autopop_manager")
local armature_manager = require("controller.armature_manager")
local core_manager = require("controller.core_manager")
local item_manager = require("controller.item_manager")
local model_data = require("data.model_data")
local servant_data = require("data.servant_data")
local item_data = require("data.item_data")
local total_skill_data = require("data.total_skill_data")
local var_0_12

function PopServantOCLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopServantOCLayer.new()

	var_2_0:initBg(arg_2_1)

	return var_2_0
end

function PopServantOCLayer:init(arg_3_1)
	var_0_12 = self
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "PopServantOCLayer.json" or "PopServantOCLayer.ExportJson")

	self:addChild(self.rootLayer, 2)

	self.surebutton = ccui.Helper:seekWidgetByName(self.rootLayer, "button_sure")
	self.panel = ccui.Helper:seekWidgetByName(self.rootLayer, "panel_upgrade")
	self.materialbg = {}

	self:createFullScreenMask(function(arg_4_0, arg_4_1)
		if arg_4_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.hideActions.shrinkVertical(self, function()
			LayerManager:removePopLayer(self.__queueindex)
		end)
	end, 0)
	self:initData(arg_3_1)

	local function var_3_0()
		self.panel:setTouchEnabled(false)
		global_window_close_action(self.rootpanel, function()
			if arg_3_1.cancelcallback then
				arg_3_1.cancelcallback()
			end

			LayerManager:removePopLayer(self.__queueindex)
		end)
	end

	self.panel:addTouchEventListener(var_3_0)

	self.rootpanel = ccui.Helper:seekWidgetByName(self.rootLayer, "material_bg")

	self.rootpanel:setAnchorPoint(cc.p(0.5, 0.5))
	self.rootpanel:setTouchEnabled(false)
	self.rootpanel:setPositionX(self.rootLayer:getContentSize().width / 2)
	self.rootpanel:setPositionY(self.rootLayer:getContentSize().height / 2 + 100)
	self.surebutton:getChildByName("Label_21"):setString(arg_3_1.bntstr)
	self:setMaterial(arg_3_1, var_3_0)
	self:fullScreen(self.rootLayer)
	self:registerScriptHandler(function(arg_8_0)
		if arg_8_0 == "exit" then
			var_0_12 = nil
		end
	end)
end

function PopServantOCLayer:initData(arg_9_1)
	self.servant = arg_9_1.curSoul
	self.studentCard = servant_data[self.servant].studentCard
	self.studentCardRate = servant_data[self.servant].studentCardRate
	self.rarityCard = core_manager:getServantRarityCard(self.servant)
	self.rarityCardRate = core_manager:getServantRarityCardRate(self.servant)
	self.eleCard = core_manager:getServantElementCard(self.servant)
	self.eleCardRate = core_manager:getServantElementCardRate(self.servant)
end

function PopServantOCLayer:setMaterial(arg_10_1, arg_10_2)
	local var_10_1 = true
	local var_10_2 = 1
	local var_10_3 = {
		{
			x = 225,
			y = 153
		},
		{
			x = 415,
			y = 153
		}
	}

	if arg_10_1.materials then
		for iter_10_0, iter_10_1 in ipairs(arg_10_1.materials) do
			self.materialbg[iter_10_0] = ccui.Helper:seekWidgetByName(self.rootLayer, "equip_" .. var_10_2)

			local var_10_4 = iter_10_1.entityid and iter_10_1.entityid > 0 and ItemSprite:createBigWithEntityId(iter_10_1.entityid) or ItemSprite:createNewWithItemId(iter_10_1.id, iter_10_1.ownnum, nil, nil, nil, nil, iter_10_1.neednum)

			var_10_4:setPosition(cc.p(var_10_3[iter_10_0].x, var_10_3[iter_10_0].y))
			self.rootpanel:addChild(var_10_4, 5)

			if not self:checkIsMaterialEnough(iter_10_1.ownnum, iter_10_1.neednum, iter_10_1.id) then
				var_10_1 = false

				var_10_4:setLocalZOrder(5)
				var_10_4:getChildByName("layout"):getChildByName("icon"):setOpacity(180)
				var_10_4:setOpacity(180)
				var_10_4:setCascadeOpacityEnabled(false)
				var_10_4:getChildByName("number"):setColor(cc.c3b(214, 77, 82))
			else
				var_10_4:getChildByName("number"):setColor(cc.c3b(121, 178, 28))
			end

			if var_10_1 then
				self.materialbg[iter_10_0]:addTouchEventListener(function(arg_11_0, arg_11_1)
					local var_11_0

					if arg_11_1 ~= ccui.TouchEventType.ended then
						do return end

						var_11_0 = {
							itemid = iter_10_1.id,
							goto_back_system_id = arg_10_1.goto_back_system_id
						}
					end

					var_11_0.layer = cc.Layer:create()

					function var_11_0.removeParentCallback()
						arg_10_2()
					end

					if iter_10_1.entityid and iter_10_1.entityid > 0 then
						var_11_0.entityid = iter_10_1.entityid
					end

					LayerManager:removePopLayer(self.__queueindex)
					LayerManager:pushInLayer("PopItemLayer", var_11_0)
				end)
			else
				self.materialbg[iter_10_0]:addTouchEventListener(function(arg_13_0, arg_13_1)
					if arg_13_1 ~= ccui.TouchEventType.ended then
						return
					end

					local var_13_0 = cc.Layer:create()

					LayerManager:removePopLayer(self.__queueindex)

					if arg_10_1.removeCallback then
						arg_10_1.removeCallback()
					end

					LayerManager:pushInLayer("PopGoGainLayer", {
						item = iter_10_1.id,
						surecallback = function()
							if arg_10_1.cancelcallback then
								arg_10_1.cancelcallback()
							end
						end,
						goto_back_system_id = arg_10_1.goto_back_system_id
					})
				end)
			end

			var_10_2 = var_10_2 + 1
		end
	end

	if var_10_1 then
		self.surebutton:addTouchEventListener(function(arg_15_0, arg_15_1)
			if arg_15_1 ~= ccui.TouchEventType.ended then
				return
			end

			if not arg_15_0:isBright() then
				return
			end

			arg_15_0:setBright(false)

			local function var_15_0()
				self.panel:setVisible(false)
				self:StartUpgrade(arg_10_1, arg_10_2)
			end

			if self.extraMaterial and next(self.extraMaterial) then
				LayerManager:pushInLayer("PopDoLayer", {
					surecallback = var_15_0,
					cancelcallback = function()
						arg_15_0:setBright(true)
					end,
					labels = {
						title = L_ACTIVITY_SIGN_REMEDY_DIALOG.Title,
						des = self:getMaterialString()
					}
				})
			else
				var_15_0()
			end
		end)
	else
		self.surebutton:loadTextures("public/button/public_button_gray_long.png", "public/button/public_button_gray_long.png", "public/button/public_button_gray_long.png", var_0_0)

		local var_10_5 = self.surebutton:getChildByName("Label_21")

		var_10_5:setFontSize(34)
		var_10_5:setPosition(cc.p(self.surebutton:getContentSize().width / 2, self.surebutton:getContentSize().height / 2 - 3))
		self.surebutton:getChildByName("Label_21"):setPositionY(self.surebutton:getContentSize().height / 2 - 3)
		self.surebutton:addTouchEventListener(function(arg_18_0, arg_18_1)
			if arg_18_1 ~= ccui.TouchEventType.ended then
				return
			end

			global_ShowBlockWords(L_CONDITON_NO_ENOUGH)
			audio_manager:playeffectMusicTest("sound/invalid")
		end)
	end

	self:drawExtraMaterial(arg_10_1)
end

function PopServantOCLayer:drawExtraMaterial(arg_19_1)
	print("extraMaterial ======= ", dump(self.extraMaterial))

	local var_19_0 = self.rootpanel:getContentSize().height - 150

	for iter_19_0, iter_19_1 in ipairs(self.extraMaterial) do
		if iter_19_1.id then
			local var_19_1 = ccui.ImageView:create("PopServantUpgradeLayer/extra_bg.png", var_0_0)

			var_19_1:setAnchorPoint(cc.p(1, 0.5))
			var_19_1:setPositionX(self.rootpanel:getContentSize().width)
			var_19_1:setPositionY(var_19_0)
			self.rootpanel:addChild(var_19_1, 1)
			var_19_1:setTouchEnabled(true)

			local var_19_2 = ItemSprite:createNewWithItemId(iter_19_1.id, iter_19_1.totalNum, "withoutBox")

			var_19_2:setScale(0.4)
			var_19_2:setPosition(cc.p(30, var_19_1:getContentSize().height / 2 - 10))
			var_19_1:addChild(var_19_2)

			local var_19_3 = cc.Label:createWithTTF(string.format("%d", iter_19_1.totalNum), FONT_NAME, 24)

			var_19_3:setAnchorPoint(cc.p(0.5, 0.5))
			var_19_3:setPosition(cc.p(100, var_19_1:getContentSize().height / 2))
			var_19_1:addChild(var_19_3)
			var_19_1:addTouchEventListener(function(arg_20_0, arg_20_1)
				local var_20_0

				if arg_20_1 ~= ccui.TouchEventType.ended then
					do return end

					var_20_0 = {
						itemid = iter_19_1.id,
						goto_back_system_id = arg_19_1.goto_back_system_id
					}
				end

				var_20_0.layer = cc.Layer:create()

				function var_20_0.removeParentCallback()
					cb_ExitNotice()
				end

				if iter_19_1.entityid and iter_19_1.entityid > 0 then
					var_20_0.entityid = iter_19_1.entityid
				end

				LayerManager:pushInLayer("PopItemLayer", var_20_0)
			end)

			var_19_0 = var_19_0 - 70
		end
	end

	local var_19_4 = cc.Label:createWithTTF(L_REPLACE_MATERIAL, FONT_NAME, 18)

	var_19_4:setAnchorPoint(cc.p(1, 0.5))
	var_19_4:setPosition(cc.p(self.rootpanel:getContentSize().width, self.rootpanel:getContentSize().height - 100))
	var_19_4:setColor(cc.c3b(185, 189, 209))
	self.rootpanel:addChild(var_19_4, 2)

	local var_19_5 = ccui.ImageView:create("PopServantUpgradeLayer/tips.png", var_0_0)

	var_19_5:setAnchorPoint(cc.p(1, 0.5))
	var_19_5:setPositionX(self.rootpanel:getContentSize().width - var_19_4:getContentSize().width)
	var_19_5:setPositionY(var_19_4:getPositionY())
	self.rootpanel:addChild(var_19_5, 1)
end

function PopServantOCLayer.StartUpgrade(arg_22_0, arg_22_1, arg_22_2)
	autopop_manager:pauseAchievementPop()
	playermodel:servantOverclock(arg_22_1.curSoul, function(arg_23_0, arg_23_1)
		if not var_0_12 then
			return
		end

		if arg_23_0 == 1 then
			if arg_22_1.surecallback then
				arg_22_1.surecallback()
			end

			arg_22_0:showUpGradeAni(arg_22_1, arg_22_2, (arg_23_1 and next(arg_23_1) or nil) and arg_23_1, {
				{
					L_SOULS_BREAK_LIMIT.Aptitude[1],
					L_SOULS_BREAK_LIMIT.Aptitude[2]
				},
				{
					arg_22_1.labels[2].newvalue,
					arg_22_1.labels[1].newvalue
				},
				{
					{
						g = 255,
						b = 255,
						r = 255
					},
					{
						g = 107,
						b = 225,
						r = 236
					}
				}
			})
		elseif arg_23_0 == 2 then
			autopop_manager:resumeAchievementPop()
			global_ShowBlockWords(L_OC_LIMIT[2])
			audio_manager:playeffectMusicTest("sound/invalid")
		elseif arg_23_0 == 3 then
			autopop_manager:resumeAchievementPop()
			global_ShowBlockWords(L_OC_LIMIT[3])
			audio_manager:playeffectMusicTest("sound/invalid")
		elseif arg_23_0 == 4 then
			autopop_manager:resumeAchievementPop()
			global_ShowBlockWords(L_OC_LIMIT[4])
			audio_manager:playeffectMusicTest("sound/invalid")
		elseif arg_23_0 == 5 then
			autopop_manager:resumeAchievementPop()
			global_ShowBlockWords(L_OC_LIMIT[5])
			audio_manager:playeffectMusicTest("sound/invalid")
		end
	end)
end

function PopServantOCLayer.showUpGradeAni(arg_24_0, arg_24_1, arg_24_2, arg_24_3, arg_24_4)
	audio_manager:playeffectMusicTest("sound/upgrade_rank")

	local var_24_0 = ccui.Layout:create()

	var_24_0:setTouchEnabled(true)
	var_24_0:setContentSize(cc.Director:getInstance():getVisibleSize())
	var_24_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_24_0:setPosition(cc.p(cc.Director:getInstance():getVisibleSize().width / 2, cc.Director:getInstance():getVisibleSize().height / 2))
	var_24_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_24_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_24_0:setBackGroundColorOpacity(0)
	global_basic_scene:addChild(var_24_0, 999)

	local var_24_1 = L2Skeleton:create("spine/ui/chaopin.json", "spine/ui/chaopin.atlas")

	var_24_1:refreshSkeleton()
	var_24_1:setPosition(cc.p(320, 500))
	var_24_1:setVisible(true)
	var_24_1:play("animation", false)
	var_24_1:registerListener(SP_ANIMATION_COMPLETE, function(arg_25_0)
		var_24_1:runAction(cc.RemoveSelf:create())
	end)
	var_24_0:addChild(var_24_1)

	local var_24_2 = false

	var_24_0:runAction(cc.Sequence:create(cc.DelayTime:create(2), cc.CallFunc:create(function()
		var_24_2 = true
	end), cc.CallFunc:create(function()
		local var_26_0 = {}
		local var_26_1 = {}
		local var_26_2 = {}

		while #arg_24_4[1] > 0 do
			var_26_0[#var_26_0 + 1] = arg_24_4[1][#arg_24_4[1]]
			var_26_2[#var_26_2 + 1] = arg_24_4[2][#arg_24_4[1]]
			var_26_1[#var_26_1 + 1] = arg_24_4[3][#arg_24_4[1]]
		end

		local var_26_4 = 0
		local var_26_5 = ccui.ImageView:create("PopServantUpgradeLayer/oc_success_bg.png", var_0_0)

		var_26_5:setAnchorPoint(cc.p(0.5, 0.5))
		var_26_5:setPositionX(320)
		var_26_5:setPositionY(660)
		var_26_5:setOpacity(0)
		var_26_5:runAction(cc.Sequence:create(cc.DelayTime:create(var_26_4 * 0.2), cc.FadeIn:create(0.3)))
		var_24_0:addChild(var_26_5, 2)

		local var_26_6 = ccui.ImageView:create("PopServantUpgradeLayer/oc_upgrade1.png", var_0_0)

		var_26_6:setAnchorPoint(cc.p(0.5, 0.5))
		var_26_6:setPositionX(320)
		var_26_6:setPositionY(250)
		var_26_6:setOpacity(0)
		var_26_6:runAction(cc.Sequence:create(cc.DelayTime:create((var_26_4 + 1) * 0.2), cc.FadeIn:create(0.3)))
		var_26_5:addChild(var_26_6, 2)

		local var_26_7 = 250 - var_26_6:getContentSize().height / 2 - 30
		local var_26_8 = 80

		for iter_26_0, iter_26_1 in pairs(var_26_0) do
			local var_26_9 = ccui.Text:create(iter_26_1 .. ":", FONT_DES, 18)

			var_26_9:setAnchorPoint(cc.p(0, 0.5))
			var_26_9:setColor(var_26_1[2])
			var_26_9:setPositionX(var_26_8)
			var_26_9:setPositionY(var_26_7)
			var_26_9:setOpacity(0)
			var_26_9:runAction(cc.Sequence:create(cc.DelayTime:create((var_26_4 + 1 + 1) * 0.2), cc.Spawn:create(cc.FadeIn:create(0.3))))
			var_26_5:addChild(var_26_9, 2)

			var_26_8 = var_26_8 + var_26_9:getContentSize().width + 5

			local var_26_10 = ccui.Text:create(var_26_2[iter_26_0][1], FONT_DES, 18)

			var_26_10:setAnchorPoint(cc.p(0, 0.5))
			var_26_10:setColor(var_26_1[2])
			var_26_10:setPositionX(var_26_8)
			var_26_10:setPositionY(var_26_7)
			var_26_10:setOpacity(0)
			var_26_10:runAction(cc.Sequence:create(cc.DelayTime:create((var_26_4 + 1 + 1) * 0.2), cc.FadeIn:create(0.3)))
			var_26_5:addChild(var_26_10, 2)

			var_26_8 = var_26_8 + var_26_10:getContentSize().width + 5

			local var_26_11 = ccui.ImageView:create("public/panelbg/strengen_arrow2.png", var_0_0)

			var_26_11:setAnchorPoint(cc.p(0, 0.5))
			var_26_11:setPositionX(var_26_8)
			var_26_11:setPositionY(var_26_7)
			var_26_11:setOpacity(0)
			var_26_11:runAction(cc.Sequence:create(cc.DelayTime:create((var_26_4 + 1 + 1) * 0.2), cc.FadeIn:create(0.3)))
			var_26_5:addChild(var_26_11, 2)

			var_26_8 = var_26_8 + var_26_11:getContentSize().width + 5

			local var_26_12 = ccui.Text:create(var_26_2[iter_26_0][2], FONT_DES, 18)

			var_26_12:setAnchorPoint(cc.p(0, 0.5))
			var_26_12:setColor(var_26_1[1])
			var_26_12:setPositionX(var_26_8)
			var_26_12:setPositionY(var_26_7)
			var_26_12:setOpacity(0)
			var_26_12:runAction(cc.Sequence:create(cc.DelayTime:create((var_26_4 + 1 + 1) * 0.2), cc.FadeIn:create(0.3)))
			var_26_5:addChild(var_26_12, 2)

			var_26_8 = var_26_8 + var_26_12:getContentSize().width + 50
		end

		local var_26_13 = ccui.ImageView:create("PopServantUpgradeLayer/skill_bg.png", var_0_0)

		var_26_13:setAnchorPoint(cc.p(0.5, 0.5))
		var_26_13:setScale(2)
		var_26_13:setPositionX(320)
		var_26_13:setPositionY(var_26_7 - 25 - 65)
		var_26_13:setOpacity(0)
		var_26_13:runAction(cc.Sequence:create(cc.DelayTime:create((var_26_4 + 1 + 1 + 1) * 0.2), cc.FadeIn:create(0.3)))
		var_26_5:addChild(var_26_13, 2)

		arg_24_1.skillpath = arg_24_1.skillpath or "skill_new/skill/" .. total_skill_data[model_data[servant_data[arg_24_1.curSoul].modelid].over_clocking_skill].icon .. ".png"

		local var_26_14 = ccui.ImageView:create(arg_24_1.skillpath, var_0_0)

		var_26_14:setAnchorPoint(cc.p(0.5, 0.5))
		var_26_14:setPositionX(320)
		var_26_14:setPositionY(var_26_7 - 25 - 65)
		var_26_14:setOpacity(0)
		var_26_14:runAction(cc.Sequence:create(cc.DelayTime:create((var_26_4 + 1 + 1 + 1) * 0.2), cc.FadeIn:create(0.3)))
		var_26_5:addChild(var_26_14, 1)

		arg_24_1.skillName = arg_24_1.skillName or total_skill_data[model_data[servant_data[arg_24_1.curSoul].modelid].over_clocking_skill].name

		local var_26_15 = ccui.Text:create(L_GET_NEW_SKILL .. arg_24_1.skillName, FONT_DES, 24)

		var_26_15:setAnchorPoint(cc.p(0.5, 0.5))
		var_26_15:setPositionX(320)
		var_26_15:setPositionY(var_26_7 - 25 - 65 - var_26_14:getContentSize().height / 2 - 30)
		var_26_15:setOpacity(0)
		var_26_15:runAction(cc.Sequence:create(cc.DelayTime:create((var_26_4 + 1 + 1 + 1 + 1) * 0.2), cc.FadeIn:create(0.3)))
		var_26_5:addChild(var_26_15, 2)
	end), cc.DelayTime:create(10), cc.CallFunc:create(function()
		if arg_24_3 and next(arg_24_3) then
			global_gain({
				items = arg_24_3
			})

			for iter_28_0, iter_28_1 in pairs(arg_24_3) do
				if item_data[iter_28_1.itemid].bag_item_type == kITEM_HERO or item_data[iter_28_1.itemid].bag_item_type == kITEM_SKIN then
					require("view.Layer.GetRoleAnimationLayer")

					local var_28_0 = GetRoleAnimationLayer:create(iter_28_1.itemid, autopop_manager:resumeAchievementPop())

					if not var_28_0:getParent() then
						global_basic_scene:addChild(var_28_0, 99)
					end
				end
			end
		end

		arg_24_2()
	end), cc.RemoveSelf:create()))
	var_24_0:addTouchEventListener(function(arg_29_0, arg_29_1)
		if arg_29_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not var_24_2 then
			return
		end

		if arg_24_3 and next(arg_24_3) then
			global_gain({
				items = arg_24_3
			})

			for iter_29_0, iter_29_1 in pairs(arg_24_3) do
				if item_data[iter_29_1.itemid].bag_item_type == kITEM_HERO or item_data[iter_29_1.itemid].bag_item_type == kITEM_SKIN then
					require("view.Layer.GetRoleAnimationLayer")

					local var_29_0 = GetRoleAnimationLayer:create(iter_29_1.itemid, autopop_manager:resumeAchievementPop())

					if not var_29_0:getParent() then
						global_basic_scene:addChild(var_29_0, 99)
					end
				end
			end
		end

		arg_24_2()
		var_24_0:runAction(cc.RemoveSelf:create())
	end)
end

function PopServantOCLayer.ActionofAccess(arg_30_0, arg_30_1)
	arg_30_1:setOpacity(0)
	arg_30_1:setScale(1, 0.001)
	arg_30_1:runAction((cc.Sequence:create(cc.Blink:create(0.15, 1), cc.Spawn:create(cc.FadeIn:create(0.1), cc.ScaleTo:create(0.1, 1, 1)))))
end

function PopServantOCLayer:checkIsMaterialEnough(arg_31_1, arg_31_2, arg_31_3)
	if item_data[arg_31_3].bag_item_type ~= kITEM_HERO then
		return arg_31_2 <= arg_31_1
	end

	self.extraMaterial = self.extraMaterial or {}

	if arg_31_2 <= arg_31_1 then
		return true
	else
		local var_31_0 = arg_31_2 - arg_31_1
		local var_31_1 = self.studentCard and item_manager:getItemNumber(self.studentCard)
		local var_31_2 = self.rarityCard and item_manager:getItemNumber(self.rarityCard)
		local var_31_3 = self.eleCard and item_manager:getItemNumber(self.eleCard)

		table.insert(self.extraMaterial, {
			id = self.studentCard,
			totalNum = var_31_1,
			rate = self.studentCardRate
		})
		table.insert(self.extraMaterial, {
			id = self.eleCard,
			totalNum = var_31_3,
			rate = self.eleCardRate
		})
		table.insert(self.extraMaterial, {
			id = self.rarityCard,
			totalNum = var_31_2,
			rate = self.rarityCardRate
		})

		local var_31_4 = var_31_0

		for iter_31_0, iter_31_1 in ipairs(self.extraMaterial) do
			if iter_31_1.id then
				iter_31_1.needNum, var_31_4 = var_31_4 > math.floor(iter_31_1.totalNum / iter_31_1.rate) and math.floor(iter_31_1.totalNum / iter_31_1.rate) * iter_31_1.rate or var_31_4 * iter_31_1.rate, var_31_4 - math.floor(iter_31_1.totalNum / iter_31_1.rate)
			end
		end

		if var_31_4 <= 0 then
			return true
		else
			return false
		end
	end
end

function PopServantOCLayer:getMaterialString()
	local var_32_0 = "确定额外消耗"

	for iter_32_0, iter_32_1 in ipairs(self.extraMaterial) do
		if iter_32_1.needNum > 0 then
			if 0 >= 1 then
				var_32_0 = var_32_0 .. "，"
			end

			var_32_0 = var_32_0 .. string.format("%d个%s", iter_32_1.needNum, item_data[iter_32_1.id].name)
		end
	end

	return var_32_0
end

function PopServantOCLayer.fullScreen(arg_33_0, arg_33_1)
	arg_33_1:setContentSize((GameDisplay.getScreenSize()))
	arg_33_1:setPositionY(arg_33_1:getPositionY() - GameDisplay.fix_y)
end

function PopServantOCLayer:initBg(arg_34_1)
	local var_34_0 = ccui.Layout:create()

	var_34_0:setTouchEnabled(true)
	var_34_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_34_0:setAnchorPoint(cc.p(0, 0))
	var_34_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_34_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_34_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_34_0:setOpacity(0)
	self:addChild(var_34_0, -1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_35_0)
		self:addChild(arg_35_0, -2)
		arg_35_0:setPositionY(arg_35_0:getPositionY() - GameDisplay.fix_y)
		self:init(arg_34_1, initInfo)
		var_34_0:setOpacity(102)
		var_34_0:setTouchEnabled(false)
	end)
end
