SoulsLayer = class("SoulsLayer", function()
	return cc.Layer:create()
end)

require("view.Sprite.ItemsPanel")
require("data.constants")
require("controller.goto_system_manager")

local playermodel = require("model.playermodel")
local ShowGirlLayer = require("view.Layer.ShowGirlLayer")

require("view.Layer.BackGroundLayer")

local model_manager = require("controller.model_manager")
local item_manager = require("controller.item_manager")
local component_manager = require("controller.component_manager")
local array_manager = require("controller.array_manager")
local armature_manager = require("controller.armature_manager")
local audio_manager = require("controller.audio_manager")
local weapon_manager = require("controller.weapon_manager")
local core_manager = require("controller.core_manager")
local fight_capacity_manager = require("controller.fight_capacity_manager")
local alert_manager = require("controller.alert_manager")
local autopop_manager = require("controller.autopop_manager")
local level_manager = require("controller.level_manager")
local patrol_manager = require("controller.patrol_manager")
local arenatft_manager = require("controller.arenatft_manager")
local time_check_manager = require("controller.time_check_manager")
local hexie_manager = require("controller.hexie_manager")
local help_battle_formation_manager = require("controller/help_battle/help_battle_formation_manager")
local var_0_19 = help_battle_formation_manager:getInstance()
local var_0_20 = require("controller/layer_notification_manager").getInstance(help_battle_formation_manager)
local horcrux_devour_select_manager = require("controller/horcrux_devour/horcrux_devour_select_manager")
local var_0_22 = horcrux_devour_select_manager:getInstance()
local var_0_23 = require("controller/horcrux_devour/horcrux_devour_manager").getInstance(horcrux_devour_select_manager)
local network = require("network.network")
local major_factor_data = require("data.major_factor_data")
local model_data = require("data.model_data")
local total_skill_data = require("data.total_skill_data")
local component_effect_data = require("data.component_effect_data")
local item_data = require("data.item_data")
local role_conversation_data = require("data.role_conversation_data")
local conversation_class_data = require("data.conversation_class_data")
local var_0_32 = require("data.item_data")
local var_0_33 = require("data.total_skill_data")
local weapon_revolution_data = require("data.weapon_revolution_data")
local core_data = require("data.core_data")
local servant_data = require("data.servant_data")
local favorfile_data = require("data.favorfile_data")
local role_switch_data = require("data.role_switch_data")
local marry_manager = require("controller.marry_manager")
local souls_manager = require("controller.souls_manager")
local TempWidget = require("view.Sprite.TempWidget")
local Utility = require("common.Utility")
local var_0_43 = config._DEBUG and 0 or 1
local var_0_44 = {
	DEX = "public/career_icon/dex.png",
	ASS = "public/career_icon/ass.png",
	FIG = "public/career_icon/fig.png",
	STR = "public/career_icon/str.png",
	INT = "public/career_icon/int.png",
	SUP = "public/career_icon/sup.png"
}
local var_0_45 = {
	Oc = 2,
	Upgrade = 1,
	Jump = 1
}
local var_0_46 = {
	"damage",
	"hp",
	"attackspeed",
	"range"
}
local var_0_47 = L_SOULS_LEFTUP_ATTR_PANEL_STR
local var_0_48 = 0
local var_0_49 = 1
local var_0_50 = 0.2
local var_0_51 = 0.2
local var_0_52 = {
	{
		x = 43,
		y = 0
	},
	{
		x = 0,
		y = 45
	},
	{
		x = 43,
		y = 90
	},
	{
		x = 87,
		y = 45
	}
}
local var_0_53 = {
	{
		x = 12,
		y = 86
	},
	{
		x = 90,
		y = 170
	},
	{
		x = 172,
		y = 170
	},
	{
		x = 172,
		y = 0
	},
	{
		x = 0,
		y = 10
	}
}
local var_0_54
local var_0_55 = cc.p(426, 175)

global_last_select_servant = nil

local function var_0_56(arg_2_0)
	return ({
		[2266201] = 0.52,
		[2216301] = 0.54,
		[2211201] = 0.52,
		[2246001] = 0.46,
		[2209201] = 0.5,
		[2241201] = 0.58,
		[2215051] = 0.5,
		[2265201] = 0.38,
		[2228201] = 0.54,
		[2225201] = 0.52,
		[2295201] = 0.4,
		[2208201] = 0.6,
		[2223201] = 0.5,
		[2210201] = 0.5,
		[2253001] = 0.44,
		[2206201] = 0.5,
		[2214301] = 0.62,
		[2281201] = 0.38,
		[2227201] = 0.44,
		[2207201] = 0.5,
		[22028201] = 0.44,
		[2268201] = 0.45,
		[2255201] = 0.44,
		[2226201] = 0.42,
		[2210051] = 0.56,
		[2284201] = 0.38,
		[2222201] = 0.45,
		[2211041] = 0.5,
		[2238001] = 0.52,
		[2262201] = 0.42,
		[2275201] = 0.38,
		[2233201] = 0.56,
		[2240201] = 0.5,
		[2205201] = 0.5,
		[2212041] = 0.53,
		[2229201] = 0.34,
		[2261201] = 0.48,
		[2246201] = 0.5,
		[2254001] = 0.52,
		[2239201] = 0.44,
		[2291201] = 0.5,
		[22016201] = 0.55,
		[2214031] = 0.52,
		[2221201] = 0.54,
		[22020201] = 0.5,
		[22025201] = 0.45,
		[2203201] = 0.53,
		[2248001] = 0.3,
		[2272201] = 0.38,
		[2204201] = 0.5,
		[2234001] = 0.54,
		[2219201] = 0.52,
		[2251001] = 0.42,
		[2201201] = 0.52,
		[2215111] = 0.56,
		[2220201] = 0.52,
		[22010201] = 0.41,
		[2287201] = 0.3,
		[22019201] = 0.6,
		[22018201] = 0.55,
		[2208021] = 0.58,
		[2290201] = 0.42,
		[2218201] = 0.52,
		[22017201] = 0.53,
		[2237201] = 0.62,
		[2229101] = 0.34,
		[2215201] = 0.64,
		[2267201] = 0.4,
		[2232201] = 0.58,
		[2260001] = 0.5,
		[2206021] = 0.48,
		[2261611] = 0.48,
		[2216201] = 0.52,
		[2200051] = 0.52,
		[2231201] = 0.5,
		[2201041] = 0.5,
		[2276001] = 0.46,
		[2213201] = 0.58,
		[2203031] = 0.56,
		[2202901] = 0.84,
		[2205021] = 0.5,
		[2285201] = 0.64,
		[2263201] = 0.4,
		[2280201] = 0.38,
		[2202021] = 0.5,
		[2208101] = 0.6,
		[2212201] = 0.61
	})[arg_2_0] or 0.5
end

function SoulsLayer.create(arg_3_0, arg_3_1)
	local var_3_0 = SoulsLayer.new()

	var_3_0:init(arg_3_1)

	return var_3_0
end

function SoulsLayer.getInstance()
	return var_0_54
end

function SoulsLayer:init(arg_6_1)
	var_0_54 = self
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "Souls.json" or "Souls.ExportJson")

	self:addChild(self.rootLayer)

	self.isEquipLayerShowAll = false
	self.soulidList = {}
	self.curFightArray = {}

	for iter_6_0, iter_6_1 in pairs(servant_data) do
		if iter_6_1.classtype ~= 1 or iter_6_1.linkage and not playermodel.haveServant[iter_6_1.id] then
			-- block empty
		elseif not playermodel:isServantLockByTime(iter_6_1.id) and hexie_manager:canShowServant(iter_6_1.id) then
			self.soulidList[#self.soulidList + 1] = iter_6_1.id
		elseif arg_6_1 and arg_6_1.cursoul == iter_6_1.id then
			self.soulidList[#self.soulidList + 1] = iter_6_1.id
		end
	end

	self:initSoulTableViewData()

	self.componentRedPointList = {}

	if LayerManager:getUIElement("TopcostLayer") then
		self.topCostDisplayState = LayerManager:getUIElement("TopcostLayer"):getTopcostLayerState()
	end

	if arg_6_1.showtype ~= SHOW_TYPE_FIGHTLAYER then
		global_last_select_servant = self.curSoul
	end

	self.curSoul = global_last_select_servant or arg_6_1.cursoul or self.soulidList[1]
	self.showtype = arg_6_1.showtype
	self.bottomBtnState = arg_6_1.bottomBtnState or var_0_48
	self.exitUpdateCallback = arg_6_1.exitUpdateCallback
	self.showButtonList = arg_6_1.showButtonList
	self.exitCallback = arg_6_1.exitCallback
	self.defaultDisplayType = arg_6_1.defaultDisplayType
	self.bottomBtnState = var_0_48

	self:updateNewServantAlert(self.curSoul)

	self.previewReturnCallback = arg_6_1.previewReturnCallback
	self.talkType = (self.showtype == SHOW_TYPE_FIGHT or self.showtype == SHOW_TYPE_FIGHTLAYER) and ROLE_SOUND_TYPE.fight or ROLE_SOUND_TYPE.home
	self.infoPanel = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_infoLayer")

	self.infoPanel:setVisible(false)
	self:initDisplayValue(self.infoPanel)
	self.infoPanel:setVisible(true)
	self.infoPanel:setPositionX(0)
	self:showInfoPanel()
	self:createMoveLayer()
	self:registerScriptHandler(function(arg_7_0)
		if arg_7_0 == "exit" then
			if self.exitCallback then
				self.exitCallback()
			end

			var_0_54 = nil

			TextureManager:unregisterTexture("EquipLayer")
			self:resetTopCostListButton()

			if BattleArrayLayerNew and BattleArrayLayerNew.getInstance() then
				BattleArrayLayerNew.getInstance():updateAllCell()
				BattleArrayLayerNew.getInstance():updateUI()
			end

			require("controller.formation.formation_manager"):getInstance():updateLayer()
			cc.Director:getInstance():getEventDispatcher():dispatchEvent((cc.EventCustom:new("substitutionArrayLayerEvent")))

			if GirlSelectLayer and GirlSelectLayer.getInstance() then
				GirlSelectLayer.getInstance():updateShowingCells()
			end

			if self.previewReturnCallback then
				self.previewReturnCallback()
			end

			self:openAllNewServant()

			if self.Scheduler then
				cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.Scheduler)

				self.Scheduler = nil
			end

			if global_basic_scene:getChildByName("descriptionLayout") then
				global_basic_scene:getChildByName("descriptionLayout"):removeFromParent()
			end

			var_0_20:removeLayerNotification(self)
		elseif arg_7_0 == "enter" then
			var_0_20:registerLayerNotification("HorcruxDevourSucceeded", {
				layer = self,
				callBack = function()
					self:updateDevourLayout()
				end
			})
			var_0_20:registerLayerNotification("HorcruxDevourConfirmNewSkillSucceeded", {
				layer = self,
				callBack = function()
					self:updateDevourLayout()
				end
			})
			var_0_20:registerLayerNotification("StrengthenCoreSuccess", {
				layer = self,
				callBack = function()
					self:updateDevourLayout()
				end
			})
			var_0_20:registerLayerNotification("DisassembleHorcruxSuccess", {
				layer = self,
				callBack = function()
					self:updateDevourLayout()
				end
			})
		end
	end)
	self:createDescriptionLayer()
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("on_buy_shop", function(arg_12_0)
		self:onBuyShop()
	end), self)
end

function SoulsLayer.findKeyofValue(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0

	if arg_13_1 then
		for iter_13_0, iter_13_1 in pairs(arg_13_1) do
			if iter_13_1 == arg_13_2 then
				var_13_0 = iter_13_0

				return iter_13_0
			end
		end
	end

	return var_13_0
end

function SoulsLayer:initSoulTableViewData()
	local var_14_4 = {
		{
			weight = 2,
			func = function(arg_20_0, arg_20_1)
				return arg_20_0 < arg_20_1
			end
		},
		{
			weight = 3,
			func = function(arg_16_0, arg_16_1)
				return servant_data[arg_16_0].major > servant_data[arg_16_1].major
			end
		},
		{
			weight = 5,
			func = function(arg_24_0, arg_24_1)
				local var_24_0 = playermodel.soulOverClock[arg_24_0] > 0 and 6 or playermodel.soulContract[arg_24_0] or 0
				local var_24_1 = playermodel.soulOverClock[arg_24_1] > 0 and 6 or playermodel.soulContract[arg_24_1] or 0

				if var_24_0 == var_24_1 then
					return "=="
				else
					return var_24_1 < var_24_0
				end
			end
		},
		{
			weight = 11000,
			func = function(arg_23_0, arg_23_1)
				local var_23_0 = playermodel.newservants[arg_23_0] and 1 or 0
				local var_23_1 = playermodel.newservants[arg_23_1] and 1 or 0

				if (playermodel.newservants[arg_23_0] and 1 or 0) == (playermodel.newservants[arg_23_1] and 1 or 0) then
					return "=="
				else
					return var_23_1 < var_23_0
				end
			end
		},
		{
			weight = 12000,
			func = function(arg_19_0, arg_19_1)
				local var_19_0 = playermodel.haveServant[arg_19_0] and 1 or 0
				local var_19_1 = playermodel.haveServant[arg_19_1] and 1 or 0

				if (playermodel.haveServant[arg_19_0] and 1 or 0) == (playermodel.haveServant[arg_19_1] and 1 or 0) then
					return "=="
				else
					return var_19_1 < var_19_0
				end
			end
		},
		{
			weight = 4,
			func = function(arg_26_0, arg_26_1)
				local var_26_0 = playermodel.servant_unlock_time and playermodel.servant_unlock_time[arg_26_0]
				local var_26_1 = playermodel.servant_unlock_time and playermodel.servant_unlock_time[arg_26_1]

				if var_26_0 == var_26_1 then
					return "=="
				else
					return var_26_1 < var_26_0
				end
			end
		},
		{
			weight = 6,
			func = function(arg_15_0, arg_15_1)
				local var_15_0 = core_manager:getCoreLv(arg_15_0)
				local var_15_1 = core_manager:getCoreLv(arg_15_1)

				if var_15_0 == var_15_1 then
					return "=="
				else
					return var_15_1 < var_15_0
				end
			end
		},
		{
			weight = 7,
			func = function(arg_18_0, arg_18_1)
				local var_18_0 = servant_data[arg_18_0].roll_rarity or 1
				local var_18_1 = servant_data[arg_18_1].roll_rarity or 1

				if var_18_0 == var_18_1 then
					return "=="
				end

				return var_18_1 < var_18_0
			end
		}
	}

	table.sort(var_14_4, function(arg_27_0, arg_27_1)
		return arg_27_0.weight > arg_27_1.weight
	end)
	table.sort(self.soulidList, function(arg_28_0, arg_28_1)
		for iter_28_0 = 1, #var_14_4 do
			if var_14_4[iter_28_0].func(arg_28_0, arg_28_1) ~= "==" then
				return var_14_4[iter_28_0].func(arg_28_0, arg_28_1)
			end
		end
	end)
end

function SoulsLayer.loadUIPanel(arg_29_0, arg_29_1)
	return (ccs.GUIReader:getInstance():widgetFromJsonFile((config._DEBUG or nil) and (arg_29_1 .. ".json" or arg_29_1 .. ".ExportJson")))
end

function SoulsLayer:initUILoadQueue()
	self.UILoadQueue = {}
	self.UILoadQueue.queueLen = 0

	function self.UILoadQueue.isEmpty()
		return self.UILoadQueue.queueLen == 0
	end

	self.UILoadQueue.head = 0
	self.UILoadQueue.last = 1

	function self.UILoadQueue.pushBack(arg_32_0)
		self.UILoadQueue.queueLen = self.UILoadQueue.queueLen + 1
		self.UILoadQueue.head = self.UILoadQueue.head + 1
		self.UILoadQueue[self.UILoadQueue.head] = arg_32_0
	end

	function self.UILoadQueue.pop()
		self.UILoadQueue[self.UILoadQueue.last]()

		self.UILoadQueue.last = self.UILoadQueue.last + 1
		self.UILoadQueue.queueLen = self.UILoadQueue.queueLen - 1
	end

	self.Scheduler = nil
	self.UILoadQueue.topHead = 0
	self.UILoadQueue.topLast = 1
	self.TopUILoadQueue = {}

	function self.UILoadQueue.pushBackTopQueue(arg_34_0)
		self.UILoadQueue.topHead = self.UILoadQueue.topHead + 1
		self.TopUILoadQueue[self.UILoadQueue.topHead] = arg_34_0
	end

	function self.UILoadQueue.popTopQueue()
		self.TopUILoadQueue[self.UILoadQueue.topLast]()

		self.UILoadQueue.topLast = self.UILoadQueue.topLast + 1
	end

	local function var_30_0()
		if self.UILoadQueue.topLast <= self.UILoadQueue.topHead then
			self.UILoadQueue.popTopQueue()
		elseif self.UILoadQueue.last <= self.UILoadQueue.head then
			self.UILoadQueue.pop()
		else
			self.UILoadQueue = {}

			cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.Scheduler)

			self.Scheduler = nil
		end
	end

	function self.UILoadQueue.beginLoadUI()
		self.Scheduler = cc.Director:getInstance():getScheduler():scheduleScriptFunc(var_30_0, 0, false)
	end
end

function SoulsLayer:updatePreview1Panel()
	local var_38_0 = split(model_data[servant_data[self.curSoul].modelid].characteristic, "#")
	local var_38_1 = 239

	for iter_38_0 = 1, 3 do
		ccui.Helper:seekWidgetByName(self.preview1Panel, "Label_introduction" .. iter_38_0):setTextAreaSize(cc.size(400, 0))

		if var_38_0[iter_38_0] then
			ccui.Helper:seekWidgetByName(self.preview1Panel, "Label_introduction" .. iter_38_0):setVisible(true)
			ccui.Helper:seekWidgetByName(self.preview1Panel, "Label_introduction" .. iter_38_0):setString(var_38_0[iter_38_0])
			ccui.Helper:seekWidgetByName(self.preview1Panel, "Label_introduction" .. iter_38_0):setPositionY(var_38_1)
		else
			ccui.Helper:seekWidgetByName(self.preview1Panel, "Label_introduction" .. iter_38_0):setVisible(false)
		end

		var_38_1 = var_38_1 - ccui.Helper:seekWidgetByName(self.preview1Panel, "Label_introduction" .. iter_38_0):getContentSize().height
	end

	local var_38_2 = split(model_data[servant_data[self.curSoul].modelid].Recommended_attribute, "#")
	local var_38_3 = 143

	for iter_38_1 = 1, 3 do
		ccui.Helper:seekWidgetByName(self.preview1Panel, "Label_Recommend" .. iter_38_1):setTextAreaSize(cc.size(400, 0))

		if var_38_2[iter_38_1] then
			ccui.Helper:seekWidgetByName(self.preview1Panel, "Label_Recommend" .. iter_38_1):setVisible(true)
			ccui.Helper:seekWidgetByName(self.preview1Panel, "Label_Recommend" .. iter_38_1):setString(var_38_2[iter_38_1])
			ccui.Helper:seekWidgetByName(self.preview1Panel, "Label_Recommend" .. iter_38_1):setPositionY(var_38_3)
		else
			ccui.Helper:seekWidgetByName(self.preview1Panel, "Label_Recommend" .. iter_38_1):setVisible(false)
		end

		var_38_3 = var_38_3 - ccui.Helper:seekWidgetByName(self.preview1Panel, "Label_Recommend" .. iter_38_1):getContentSize().height
	end

	for iter_38_2, iter_38_3 in pairs({
		"Outreak",
		"Survival",
		"Control",
		"Dexterity",
		"Support"
	}) do
		ccui.Helper:seekWidgetByName(self.preview1Panel, "Image_bar" .. iter_38_3):getChildByName("ProgressBar_bar"):setPercent(model_data[servant_data[self.curSoul].modelid][iter_38_3] * 10)
	end
end

function SoulsLayer:initPreviewPanel()
	if self.previewPanel then
		return
	end

	self.previewPanel = self:loadUIPanel("Souls_preview_down")

	ccui.Helper:seekWidgetByName(self.infoPanel, "Panel_weaponview"):addChild(self.previewPanel)

	self.preview1Panel = ccui.Helper:seekWidgetByName(self.previewPanel, "Panel_preview1")
	self.preview3Panel = ccui.Helper:seekWidgetByName(self.previewPanel, "Panel_preview3")

	ccui.Helper:seekWidgetByName(self.previewPanel, "Button_previewServant"):addTouchEventListener(function(arg_40_0, arg_40_1)
		if arg_40_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.previewType = 1

		self:updatePreviewDownPanel()
	end)
	ccui.Helper:seekWidgetByName(self.previewPanel, "Button_previewWeapon"):addTouchEventListener(function(arg_41_0, arg_41_1)
		if arg_41_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.previewType = 3

		self:updatePreviewDownPanel()
	end)

	self.previewWeaponLevel = "max"

	ccui.Helper:seekWidgetByName(self.preview3Panel, "Button_weaponLevelOrgin"):addTouchEventListener(function(arg_42_0, arg_42_1)
		if arg_42_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.previewWeaponLevel = "orgin"

		self:updatePreviewDownPanel()
	end)
	ccui.Helper:seekWidgetByName(self.preview3Panel, "Button_weaponMaxLevel"):addTouchEventListener(function(arg_43_0, arg_43_1)
		if arg_43_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.previewWeaponLevel = "max"

		self:updatePreviewDownPanel()
	end)
	ccui.Helper:seekWidgetByName(self.preview3Panel, "Label_mainAttrDes"):setString(L_WEAPON_MAIN_ATTR)
	ccui.Helper:seekWidgetByName(self.preview3Panel, "Label_subAttrDes"):setString(L_WEAPON_SUB_ATTR)
	ccui.Helper:seekWidgetByName(self.preview1Panel, "Image_barOutreak"):getChildByName("Label_des"):setString(L_EQUIPLAYER_OUTREAK)
	ccui.Helper:seekWidgetByName(self.preview1Panel, "Image_barSurvival"):getChildByName("Label_des"):setString(L_EQUIPLAYER_SURVIVAL)
	ccui.Helper:seekWidgetByName(self.preview1Panel, "Image_barControl"):getChildByName("Label_des"):setString(L_EQUIPLAYER_CONTROL)
	ccui.Helper:seekWidgetByName(self.preview1Panel, "Image_barDexterity"):getChildByName("Label_des"):setString(L_EQUIPLAYER_DEXTERITY)
	ccui.Helper:seekWidgetByName(self.preview1Panel, "Image_barSupport"):getChildByName("Label_des"):setString(L_EQUIPLAYER_SUPPORT)
	ccui.Helper:seekWidgetByName(self.preview1Panel, "Label_31"):setString(L_EQUIPLAYER_CHARACTER)
	ccui.Helper:seekWidgetByName(self.preview1Panel, "Label_32"):setString(L_EQUIPLAYER_RECOMMEND)
	self:initBtnGet()
end

function SoulsLayer:updatePreview3Panel()
	local var_44_9000
	local var_44_0 = servant_data[self.curSoul].recommend_weapon2
	local var_44_1 = 0

	for iter_44_0, iter_44_1 in pairs(WEAPON_SERVANT_LIMIT) do
		var_44_1 = math.max(var_44_1, iter_44_1.limit)
	end

	if self.previewWeaponLevel == "orgin" then
		var_44_1 = 0
	end

	local var_44_2 = {
		itemid = var_44_0,
		weapon_attr = {
			nowStars = item_data[var_44_0].max_star,
			level = var_44_1
		}
	}

	if self.previewWeaponLevel == "orgin" then
		var_44_2 = {
			itemid = var_44_0,
			weapon_attr = {
				nowStars = 0,
				level = var_44_1
			}
		}
	end

	for iter_44_2 = 1, 5 do
		ccui.Helper:seekWidgetByName(self.preview3Panel, "Panel_start"):getChildByName("Image_" .. iter_44_2):setVisible(false)

		if iter_44_2 + 5 <= var_44_2.weapon_attr.nowStars then
			ccui.Helper:seekWidgetByName(self.preview3Panel, "Panel_start"):getChildByName("Image_" .. iter_44_2):setScale(0.4)
			ccui.Helper:seekWidgetByName(self.preview3Panel, "Panel_start"):getChildByName("Image_" .. iter_44_2):setVisible(true)
			ccui.Helper:seekWidgetByName(self.preview3Panel, "Panel_start"):getChildByName("Image_" .. iter_44_2):loadTexture("public/currency/pink_star.png", var_0_43)
		elseif var_44_2.weapon_attr.nowStars <= 5 and iter_44_2 <= var_44_2.weapon_attr.nowStars then
			ccui.Helper:seekWidgetByName(self.preview3Panel, "Panel_start"):getChildByName("Image_" .. iter_44_2):setScale(1)
			ccui.Helper:seekWidgetByName(self.preview3Panel, "Panel_start"):getChildByName("Image_" .. iter_44_2):setVisible(true)
			ccui.Helper:seekWidgetByName(self.preview3Panel, "Panel_start"):getChildByName("Image_" .. iter_44_2):loadTexture("EquipLayer/weapon_star.png", var_0_43)
		end
	end

	ccui.Helper:seekWidgetByName(self.preview3Panel, "Image_weaponIcon"):loadTexture("weaponIcon/" .. item_data[servant_data[self.curSoul].recommend_weapon2].image_id .. ".png")
	ccui.Helper:seekWidgetByName(self.preview3Panel, "Image_weaponIcon"):setScale(var_0_56(item_data[var_44_0].image_id * 1.3))
	ccui.Helper:seekWidgetByName(self.preview3Panel, "Image_197"):addTouchEventListener(function(arg_45_0, arg_45_1)
		if arg_45_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopItemLayer", {
			itemid = var_44_0,
			item_attr = {
				nowStars = var_44_2.weapon_attr.nowStars,
				level = var_44_2.weapon_attr.level
			},
			goto_back_system_id = self:getCurSystemId()
		})
	end)
	ccui.Helper:seekWidgetByName(self.preview3Panel, "Label_weaponName"):setString(item_data[var_44_0].name)

	if self.previewWeaponLevel == "max" then
		ccui.Helper:seekWidgetByName(self.preview3Panel, "Button_weaponMaxLevel"):loadTextures("EquipLayer/weapon_max_level_on.png", nil, "EquipLayer/weapon_max_level_on.png", var_0_43)
		ccui.Helper:seekWidgetByName(self.preview3Panel, "Button_weaponLevelOrgin"):loadTextures("EquipLayer/weapon_level_orgin_off.png", nil, "EquipLayer/weapon_level_orgin_off.png", var_0_43)
	else
		ccui.Helper:seekWidgetByName(self.preview3Panel, "Button_weaponMaxLevel"):loadTextures("EquipLayer/weapon_max_level_off.png", nil, "EquipLayer/weapon_max_level_off.png", var_0_43)
		ccui.Helper:seekWidgetByName(self.preview3Panel, "Button_weaponLevelOrgin"):loadTextures("EquipLayer/weapon_level_orgin_on.png", nil, "EquipLayer/weapon_level_orgin_on.png", var_0_43)
	end

	local var_44_3 = weapon_manager:getWeaponAddMainAttr(var_44_0, var_44_1)

	table.insert(var_44_3, {
		{
			attrtype = item_data[var_44_0].main_attr,
			value = item_data[var_44_0].value
		}
	})

	local var_44_4 = weapon_manager:getWeaponAddSubAttr(var_44_0, item_data[var_44_0].max_star)

	if self.previewWeaponLevel == "orgin" then
		var_44_4 = weapon_manager:getWeaponAddSubAttr(var_44_0, 0)
	end

	local var_44_5 = {}

	for iter_44_3, iter_44_4 in pairs(var_44_3) do
		for iter_44_5, iter_44_6 in pairs(iter_44_4) do
			var_44_5[iter_44_6.attrtype] = var_44_5[iter_44_6.attrtype] or 0
			var_44_5[iter_44_6.attrtype] = var_44_5[iter_44_6.attrtype] + iter_44_6.value
		end
	end

	local var_44_6 = ""

	for iter_44_7, iter_44_8 in pairs(var_44_5) do
		var_44_6 = var_44_6 .. FIGHT_ATTR_INFO[iter_44_7] .. " + " .. FIGHT_ATTR_FORMAT[iter_44_7](iter_44_8 * var_44_6) .. "\n"
	end

	local var_44_9 = ""

	for iter_44_9, iter_44_10 in pairs(var_44_4) do
		var_44_9 = var_44_9 .. FIGHT_ATTR_INFO[iter_44_10.attrtype] .. " + " .. FIGHT_ATTR_FORMAT[iter_44_10.attrtype](iter_44_10.value) .. "\n"
	end

	ccui.Helper:seekWidgetByName(self.preview3Panel, "Label_mainDes"):setString(var_44_6)
	ccui.Helper:seekWidgetByName(self.preview3Panel, "Label_subDes"):setString(var_44_9)

	local var_44_10 = ccui.Helper:seekWidgetByName(self.preview3Panel, "Label_mainAttrDes")

	ccui.Helper:seekWidgetByName(self.preview3Panel, "Label_mainDes").setPositionY(ccui.Helper:seekWidgetByName(self.preview3Panel, "Label_mainDes").getContentSize(var_44_10).height, var_44_10:getPositionY() - var_44_9000)

	local var_44_11 = var_44_10:getPositionY() - var_44_9000 - ccui.Helper:seekWidgetByName(self.preview3Panel, "Label_subAttrDes"):getContentSize().height - 5

	ccui.Helper:seekWidgetByName(self.preview3Panel, "Label_subAttrDes"):setPositionY(var_44_11)
	ccui.Helper:seekWidgetByName(self.preview3Panel, "Label_subDes"):setPositionY(var_44_11 - ccui.Helper:seekWidgetByName(self.preview3Panel, "Label_subDes"):getContentSize().height)
end

function SoulsLayer:sortLoadUI()
	if self.displayType == "attr" then
		(function()
			self.attrDownPanel = self:loadUIPanel("Souls_attr_down")

			self.infoPanel:getChildByName("Panel_equip"):addChild(self.attrDownPanel)
			self:initWeaponPanel()
			self:initcomponentPanel()
			self:updateContract()
			self:updateLevelPanel()
		end)()
		self.UILoadQueue.pushBack(function()
			self:initPreviewPanel()
		end)
	else
		local var_46_0

		if self.previewType then
			function var_46_0()
				self:initPreviewPanel()
				self:updatePreviewDownPanel()
			end
		end

		local function var_46_3()
			self.attrDownPanel = self:loadUIPanel("Souls_attr_down")

			self.infoPanel:getChildByName("Panel_equip"):addChild(self.attrDownPanel)
		end

		self.UILoadQueue.pushBack(var_46_0)
		self.UILoadQueue.pushBack(var_46_3)
		self.UILoadQueue.pushBack(function()
			self:initWeaponPanel()
			self:updateContract()
			self:updateLevelPanel()
		end)
		self.UILoadQueue.pushBack(function()
			self:initcomponentPanel()
		end)
	end

	self.UILoadQueue.beginLoadUI()
end

function SoulsLayer:updatePreviewDownPanel()
	if not self.previewPanel then
		return
	end

	if self.previewType == 1 then
		ccui.Helper:seekWidgetByName(self.previewPanel, "Button_previewServant"):loadTextures("EquipLayer/servant_preview_on.png", nil, "EquipLayer/servant_preview_on.png", var_0_43)
		ccui.Helper:seekWidgetByName(self.previewPanel, "Button_previewWeapon"):loadTextures("EquipLayer/weapon_preview_off.png", nil, "EquipLayer/weapon_preview_off.png", var_0_43)

		if self.preview1Panel then
			self.preview1Panel:setVisible(true)
			self:updatePreview1Panel()
		end

		if self.preview3Panel then
			self.preview3Panel:setVisible(false)
		end
	end

	if self.previewType == 3 then
		ccui.Helper:seekWidgetByName(self.previewPanel, "Button_previewServant"):loadTextures("EquipLayer/servant_preview_off.png", nil, "EquipLayer/servant_preview_off.png", var_0_43)
		ccui.Helper:seekWidgetByName(self.previewPanel, "Button_previewWeapon"):loadTextures("EquipLayer/weapon_preview_on.png", nil, "EquipLayer/weapon_preview_on.png", var_0_43)

		if self.preview3Panel then
			self.preview3Panel:setVisible(true)
			self:updatePreview3Panel()
		end

		if self.preview1Panel then
			self.preview1Panel:setVisible(false)
		end
	end
end

function SoulsLayer:initWeaponPanel()
	if not self.attrDownPanel then
		return
	end

	self.weaponPanel = ccui.Helper:seekWidgetByName(self.attrDownPanel, "Panel_weapon")

	if self.displayType == "attr" then
		self.weaponPanel:setPositionX(800)
		self.weaponPanel:runAction(cc.MoveTo:create(var_0_50, cc.p(460, self.weaponPanel:getPositionY())))
	end

	local var_54_0 = ccui.Helper:seekWidgetByName(self.attrDownPanel, "Panel_star")
	local var_54_1 = ccui.Helper:seekWidgetByName(self.attrDownPanel, "Image_weaponImage")

	function var_54_0.update(arg_55_0)
		for iter_55_0 = 1, 5 do
			var_54_0:getChildByName("Image_start_" .. iter_55_0):loadTexture("EquipLayer/weapon_star_off.png", var_0_43)

			if arg_55_0 >= iter_55_0 + 5 then
				var_54_0:getChildByName("Image_start_" .. iter_55_0):setScale(0.4)
				var_54_0:getChildByName("Image_start_" .. iter_55_0):setVisible(true)
				var_54_0:getChildByName("Image_start_" .. iter_55_0):loadTexture("public/currency/pink_star.png", var_0_43)
			elseif arg_55_0 <= 5 and iter_55_0 <= arg_55_0 then
				var_54_0:getChildByName("Image_start_" .. iter_55_0):setScale(1)
				var_54_0:getChildByName("Image_start_" .. iter_55_0):setVisible(true)
				var_54_0:getChildByName("Image_start_" .. iter_55_0):loadTexture("EquipLayer/weapon_star.png", var_0_43)
			end
		end
	end

	local function var_54_2(arg_56_0, arg_56_1)
		if playermodel.weaponId[self.curSoul] then
			local var_56_0

			if arenatft_manager:getLayerBtnLock() then
				global_ShowBlockWords(L_TVT_FIGHT_BTN_LOCK)

				do return end

				var_56_0 = {
					entityid = playermodel.weaponId[self.curSoul],
					goto_back_system_id = self:getCurSystemId()
				}
			end

			function var_56_0.exitCallback()
				self:updateEquipLayerCallback()
				self:updateGirlDate()
				self:updateStatusPanel()
				self:updateWeaponPanel()
				self:resetTopCostListButton()
			end

			LayerManager:pushInLayer("PopWeaponUpLevelList", var_56_0)
		end
	end

	local function var_54_3(arg_58_0, arg_58_1)
		require("controller.shop_manager"):pushBuyWeaponPop(self.curSoul)
	end

	ccui.Helper:seekWidgetByName(self.attrDownPanel, "Image_weaponFrameBg"):addTouchEventListener(function(arg_59_0, arg_59_1)
		if arg_59_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not isContainPosOfConvexPolygon(var_0_53, (arg_59_0:convertToNodeSpace((arg_59_0:getTouchEndPosition())))) then
			return
		end

		if var_54_1.usedWeapon then
			var_54_2(var_54_1, arg_59_1)
		elseif var_54_1.canUseWeapon then
			GuideListener.lockGuideTrigger(true)
			GuideListener.cleanCurGuides()
			self:useWeapon()
		else
			var_54_3(var_54_1, arg_59_1)
		end
	end)
	self:updateWeaponPanel()
end

function SoulsLayer:useWeapon(...)
	local function var_60_0(arg_61_0)
		audio_manager:playeffectMusic("weapon_starup")

		local var_61_0 = ccui.Layout:create()

		var_61_0:setTouchEnabled(true)
		var_61_0:setContentSize(cc.Director:getInstance():getVisibleSize())
		var_61_0:setAnchorPoint(cc.p(0.5, 0.5))
		var_61_0:setPosition(cc.p(cc.Director:getInstance():getVisibleSize().width / 2, cc.Director:getInstance():getVisibleSize().height / 2))
		var_61_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
		var_61_0:setBackGroundColor(cc.c3b(0, 0, 0))
		var_61_0:setBackGroundColorOpacity(220)
		var_61_0:addTouchEventListener(function(arg_62_0, arg_62_1)
			if arg_62_1 ~= ccui.TouchEventType.ended then
				return
			end

			if arg_61_0 then
				arg_61_0()
			end

			var_61_0:runAction(cc.RemoveSelf:create())
		end)
		global_basic_scene:addChild(var_61_0, 999)

		local var_61_1 = playermodel.items[playermodel.weaponId[self.curSoul]]
		local var_61_2 = L2Skeleton:create("spine/ui/weapon_up_quality/weapon_up.json", "spine/ui/weapon_up_quality/weapon_up.atlas")

		var_61_2:refreshSkeleton()
		var_61_2:setSlotTexture("wuqi", "diergewuqi", "weaponIcon/" .. item_data[playermodel.items[playermodel.weaponId[self.curSoul]].itemid].image_id .. ".png")
		var_61_2:setSlotTexture("wuqi", "wuqishengjiewuqi", "weaponIcon/weapon_blue_shadow/" .. item_data[playermodel.items[playermodel.weaponId[self.curSoul]].itemid].image_id .. ".png")
		var_61_2:setSlotTexture("wuqikuang", "wuqishengjiewuqikuang", "weaponIcon/weapon_bg_red.png")
		var_61_2.skeletonAnimation:setPosition(cc.p(320, GameDisplay.height / 2 + 60))
		var_61_2:play("weapon_up", false)
		var_61_0:addChild(var_61_2, 10000)

		local function var_61_3()
			local var_63_0 = {}

			for iter_63_0 = 1, item_data[var_61_1.itemid].max_star do
				local var_63_1 = ccui.ImageView:create("public/currency/weapon_star_empty.png", var_0_43)

				var_63_1:setPosition(cc.p(320 + (iter_63_0 - (item_data[var_61_1.itemid].max_star + 1) / 2) * (var_63_1:getContentSize().width - 10), 545 + GameDisplay.fix_y))
				table.insert(var_63_0, var_63_1)
				var_63_1:setVisible(false)
				var_61_0:addChild(var_63_1, 100000)
			end

			for iter_63_1, iter_63_2 in pairs(var_63_0) do
				var_63_0[iter_63_1]:setScale(8)
				var_63_0[iter_63_1]:runAction(cc.Sequence:create(cc.DelayTime:create(iter_63_1 / 30), cc.CallFunc:create(function()
					var_63_0[iter_63_1]:setVisible(true)
				end), cc.Spawn:create(cc.RotateBy:create(0.55, 72), cc.Sequence:create(cc.ScaleTo:create(0.15, 1, 1), cc.ScaleTo:create(0.25, 2, 2), cc.ScaleTo:create(0.15, 1, 1)))))
			end
		end

		local var_61_4 = false

		var_61_0:runAction(cc.Sequence:create(cc.DelayTime:create(1), cc.CallFunc:create(function()
			var_61_3()
			var_61_2:play("weapon_up_stay", true)

			var_61_4 = true
		end), cc.DelayTime:create(2), cc.RemoveSelf:create(), cc.CallFunc:create(function()
			if arg_61_0 then
				arg_61_0()
			end
		end)))
	end

	local var_60_1

	for iter_60_0, iter_60_1 in pairs(playermodel.items) do
		if iter_60_1.itemtype == kITEM_WEAPON and item_data[iter_60_1.itemid].servant == self.curSoul then
			var_60_1 = iter_60_0
		end
	end

	fight_capacity_manager:saveSoulAttr(self.curSoul, self.roleInfos[self.curSoul].model)
	weapon_manager:replaceRoleWeapon(self.curSoul, var_60_1, function(arg_67_0)
		if arg_67_0 == 1 then
			var_60_0(function()
				self:updateEquipLayerCallback()
				fight_capacity_manager:displaySoulAttrChangeValue(nil, nil, self.roleInfos[self.curSoul].model, nil, function(...)
					self:updateGuide()
				end)
			end)
		end
	end)
end

function SoulsLayer:getCurSystemId()
	return self.showtype == 5 and 301 or 300
end

function SoulsLayer:updateWeaponPanel()
	if not self.attrDownPanel then
		return
	end

	local var_71_0 = ccui.Helper:seekWidgetByName(self.attrDownPanel, "Image_weaponImage")
	local var_71_1 = ccui.Helper:seekWidgetByName(self.attrDownPanel, "Label_weaponlevel")
	local var_71_2 = ccui.Helper:seekWidgetByName(self.attrDownPanel, "Image_weaponLevelBg")
	local var_71_3 = ccui.Helper:seekWidgetByName(self.attrDownPanel, "Panel_star")
	local var_71_4 = ccui.Helper:seekWidgetByName(self.attrDownPanel, "Image_redPointWeapon")
	local var_71_5 = ccui.Helper:seekWidgetByName(self.attrDownPanel, "Image_blueWeapon")
	local var_71_6 = playermodel.weaponId[self.curSoul]
	local var_71_7 = playermodel.items[playermodel.weaponId[self.curSoul]]

	if playermodel.items[playermodel.weaponId[self.curSoul]] then
		var_71_0.weaponId = var_71_6
		var_71_0.usedWeapon = true

		var_71_0:loadTexture("weaponIcon/" .. item_data[var_71_7.itemid].image_id .. ".png")
		var_71_1:setVisible(true)
		var_71_1:setString("等级." .. var_71_7.weapon_attr.level)
		var_71_2:setVisible(true)
		var_71_0:setOpacity(255)
		var_71_3:setVisible(true)
		var_71_3.update(playermodel.items[var_71_6].weapon_attr.nowStars)
		var_71_5:setVisible(false)
		var_71_0:setScale(var_0_56(item_data[var_71_7.itemid].image_id) * 0.9)
	else
		local var_71_9 = servant_data[self.curSoul].recommend_weapon2

		var_71_0.weaponId = servant_data[self.curSoul].recommend_weapon2
		var_71_0.usedWeapon = false

		var_71_1:setVisible(false)
		var_71_3:setVisible(false)
		var_71_2:setVisible(false)
		var_71_0:setOpacity(0)

		var_71_0.weaponId = var_71_9

		var_71_5:setVisible(true)
		var_71_5:loadTexture("weaponIcon/weapon_blue_shadow/" .. item_data[servant_data[self.curSoul].recommend_weapon2].image_id .. ".png")
	end

	var_71_4:setVisible(false)
	var_71_4:setVisible(weapon_manager:checkIsCanUpgrade(var_71_6))
	ccui.Helper:seekWidgetByName(self.attrDownPanel, "Image_weaponLockIcon"):setVisible(false)

	var_71_0.canUseWeapon = false

	if weapon_manager:checkIsCanReplaceBetter(self.curSoul) then
		ccui.Helper:seekWidgetByName(self.attrDownPanel, "Image_weaponLockIcon"):loadTexture("EquipLayer/weapon_unlocked.png", var_0_43)
		ccui.Helper:seekWidgetByName(self.attrDownPanel, "Image_weaponLockIcon"):setVisible(true)
		var_71_0:loadTexture("weaponIcon/" .. item_data[servant_data[self.curSoul].recommend_weapon2].image_id .. ".png")
		var_71_0:setScale(0.5)
		var_71_5:setScale(1)
		var_71_0:stopAllActions()
		var_71_5:stopAllActions()
		var_71_0:setOpacity(128)

		var_71_0.canUseWeapon = true

		var_71_5:setVisible(true)
		var_71_0:setScale(var_0_56(item_data[servant_data[self.curSoul].recommend_weapon2].image_id))
	elseif not var_71_7 then
		ccui.Helper:seekWidgetByName(self.attrDownPanel, "Image_weaponLockIcon"):loadTexture("EquipLayer/goto_gain_weapon.png", var_0_43)
		ccui.Helper:seekWidgetByName(self.attrDownPanel, "Image_weaponLockIcon"):setVisible(true)
	end

	var_71_0:setVisible(true)
end

function SoulsLayer.isShowWeaponRedPoint(arg_72_0, arg_72_1)
	if weapon_manager:checkIsCanReplaceBetter(arg_72_1) then
		return true
	end

	if (function(arg_73_0)
		if playermodel.weaponId[arg_73_0] then
			return weapon_manager:checkIsCanUpgrade(playermodel.weaponId[arg_73_0]) or weapon_manager:isTipsUpWeaponQuality(playermodel.weaponId[arg_73_0])
		end

		return false
	end)(arg_72_1) then
		return true
	elseif weapon_manager:isTipsStrengWeapon(arg_72_1) then
		return false
	end

	return false
end

function SoulsLayer:isShowComponentRedPoint(arg_74_1, arg_74_2)
	if arg_74_2 then
		if not self:getComponentRedPoint(arg_74_1, arg_74_2) then
			if playermodel.component[arg_74_1] and playermodel.component[arg_74_1][arg_74_2] and component_manager:isTipsStrengComponent(playermodel.component[arg_74_1][arg_74_2].id, arg_74_1) then
				return 2
			end
		end

		return self:getComponentRedPoint(arg_74_1, arg_74_2)
	else
		self.componentRedPointList[arg_74_1] = self.componentRedPointList[arg_74_1] or {}

		for iter_74_0 = 1, 3 do
			self.componentRedPointList[arg_74_1][iter_74_0] = self:getComponentRedPoint(arg_74_1, iter_74_0)
		end

		for iter_74_1, iter_74_2 in pairs(self.componentRedPointList[arg_74_1]) do
			if iter_74_2 then
				return true
			end
		end

		if playermodel.component[arg_74_1] and playermodel.component[arg_74_1][arg_74_2] and component_manager:isTipsStrengComponent(playermodel.component[arg_74_1][arg_74_2].id, arg_74_1) then
			return 2
		end

		return false
	end
end

function SoulsLayer:getComponentRedPoint(arg_75_1, arg_75_2)
	self.componentRedPointList[arg_75_1] = self.componentRedPointList[arg_75_1] or {}

	if self.componentRedPointList[arg_75_1][arg_75_2] ~= nil then
		return self.componentRedPointList[arg_75_1][arg_75_2]
	else
		self.componentRedPointList[arg_75_1][arg_75_2] = component_manager:checkIsCanReplaceBetter(arg_75_1, arg_75_2)

		return self.componentRedPointList[arg_75_1][arg_75_2]
	end
end

function SoulsLayer:resetAllComponentRedPoint(arg_76_1)
	if arg_76_1 then
		for iter_76_0, iter_76_1 in pairs(self.componentRedPointList) do
			if self.componentRedPointList[iter_76_0][arg_76_1] ~= nil then
				self.componentRedPointList[iter_76_0][arg_76_1] = nil
			end
		end
	else
		self.componentRedPointList = {}
	end
end

function SoulsLayer:componentTouchEvent(arg_77_1)
	local var_77_0 = component_manager:getSoulComponentConditions(self.curSoul)

	var_77_0.pos = {
		arg_77_1
	}
	var_77_0.servantid = self.curSoul

	local var_77_1

	if playermodel.component[self.curSoul] and playermodel.component[self.curSoul][arg_77_1] then
		var_77_1 = {
			playermodel.component[self.curSoul][arg_77_1].id
		}
	end

	local function var_77_4(arg_80_0)
		local function var_80_0(...)
			local function var_81_0(arg_82_0)
				if arg_82_0 == 1 then
					LayerManager:removePopLayer()

					if self.roleInfos[self.curSoul] then
						audio_manager:playeffectMusicTest("sound/equip")

						local var_82_0, var_82_1 = component_manager:getSoulComponentlist(self.curSoul)

						self.roleInfos[self.curSoul].model:updateComponentAttr(var_82_0)

						self.roleInfos[self.curSoul].effects = var_82_1

						self:updateGirlDate()
						self:resetAllComponentRedPoint()
						self:updateStatusPanel()
						self:updateComponentPanel()
						self:resetTopCostListButton()
					end
				end

				if arg_82_0 == 4 then
					global_ShowBlockWords(L_SOULS_COMPONENT_TOUCH_WARNING[1])
					audio_manager:playeffectMusicTest("sound/invalid")
				end

				if arg_80_0 then
					arg_80_0()
				end
			end

			;(function(arg_83_0, arg_83_1)
				if arg_83_1 then
					arg_83_1()
				end
			end)((playermodel.component[self.curSoul] and playermodel.component[self.curSoul][arg_77_1]).id, function()
				component_manager:detachComponent(self.curSoul, arg_77_1, var_81_0)
			end)
		end

		if playermodel.reinforce_component[self.curSoul] == 0 then
			var_80_0()
		else
			local var_80_1 = {
				layerType = "HorcruxInfoLayerNew",
				surecallback = var_80_0
			}

			function var_80_1.cancelCallback(arg_85_0, arg_85_1)
				if arg_80_0 then
					arg_80_0()
				end
			end

			require("view.Sprite.ConfirmDialogSprite")
			global_basic_scene:addChild(ConfirmDialogSprite:create("卸下芯片", "卸下已聚合芯片将会使聚合效果消失，是否更换", var_80_1), 1011111)
		end
	end

	local var_77_5 = {
		used = var_77_4,
		unused = function(arg_86_0, arg_86_1)
			local function var_86_0(...)
				fight_capacity_manager:saveSoulAttr(self.curSoul, self.roleInfos[self.curSoul].model)

				local function var_87_0(arg_88_0)
					if arg_88_0 == 1 then
						audio_manager:playeffectMusicTest("sound/equip")
						LayerManager:removePopLayer()

						if self.roleInfos[self.curSoul] then
							local var_88_0, var_88_1 = component_manager:getSoulComponentlist(self.curSoul)

							self.roleInfos[self.curSoul].model:updateComponentAttr(var_88_0)

							self.roleInfos[self.curSoul].effects = var_88_1

							self:updateGirlDate()
							self:resetAllComponentRedPoint()
							self:updateStatusPanel()
							self:updateComponentPanel()
							self:resetTopCostListButton()

							if next(self.roleInfos[self.curSoul].effects) ~= nil then
								local var_88_2 = ""

								for iter_88_0, iter_88_1 in pairs(self.roleInfos[self.curSoul].effects) do
									var_88_2 = component_effect_data[iter_88_1].intro .. "\n"
								end

								if var_88_2 ~= nil then
									local var_88_3 = string.find(var_88_2, "：", 1)
									local var_88_4 = "" .. string.sub(var_88_2, 1, var_88_3 - 1) .. string.sub(var_88_2, var_88_3 + 3, string.len(var_88_2))
								end

								self:showComponentEffect(true)
							end

							popmsg = {
								showType = "component"
							}
							popmsg.componentType = next(self.roleInfos[self.curSoul].effects) ~= nil and 4 or var_0_32[playermodel.items[playermodel.component[self.curSoul][arg_77_1].id].itemid].equip_condition == "soul_" .. self.curSoul and 3 or var_0_32[playermodel.items[playermodel.component[self.curSoul][arg_77_1].id].itemid].equip_condition == self.roleInfos[self.curSoul].model:getAttribute("career") and 2 or 1

							self:createPopTalk(popmsg)
						end
					elseif arg_88_0 == 4 then
						global_ShowBlockWords(L_SOULS_COMPONENT_TOUCH_WARNING[2])
						audio_manager:playeffectMusicTest("sound/invalid")
					end

					if arg_86_1 then
						arg_86_1(arg_88_0)
					end
				end

				;(function(arg_89_0, arg_89_1)
					if arg_89_1 then
						arg_89_1()
					end
				end)(arg_86_0, function()
					component_manager:setComponent(self.curSoul, arg_77_1, arg_86_0, var_87_0)
				end)
			end

			if playermodel.reinforce_component[self.curSoul] == 0 then
				var_86_0()
			else
				local function var_86_1(arg_91_0, arg_91_1)
					if arg_86_1 then
						arg_86_1()
					end
				end

				require("view.Sprite.ConfirmDialogSprite")
				global_basic_scene:addChild(ConfirmDialogSprite:create("更换芯片", "更换已聚合芯片将会使聚合效果消失，是否更换", {
					layerType = "HorcruxInfoLayerNew",
					surecallback = var_86_0,
					cancelCallback = var_86_1
				}, nil, nil, var_86_1), 1011111)
			end
		end,
		extra = function(arg_78_0, arg_78_1)
			component_manager:strengthenComponent(arg_78_0, function(arg_79_0)
				if not var_0_54 then
					return
				end

				if arg_79_0 == 1 then
					if self.roleInfos[self.curSoul] then
						self.roleInfos[self.curSoul].model:updateComponentAttr((component_manager:getSoulComponentlist(self.curSoul)))
						self:updateGirlDate()
						self:updateStatusPanel()
						self:updateLevelPanel()
					end

					if releasecallback then
						releasecallback()
					end

					if arg_78_1 then
						arg_78_1(true)
					end
				elseif arg_79_0 == 2 then
					global_ShowBlockWords(L_COMPONENT_TEXT.Warning[2])
					audio_manager:playeffectMusicTest("sound/invalid")

					if arg_78_1 then
						arg_78_1(false)
					end
				elseif arg_79_0 == 3 then
					global_ShowBlockWords(L_COMPONENT_TEXT.Warning[3])
					audio_manager:playeffectMusicTest("sound/invalid")

					if arg_78_1 then
						arg_78_1(false)
					end
				elseif arg_79_0 == 4 then
					global_ShowBlockWords(L_COMPONENT_TEXT.Warning[4])
					audio_manager:playeffectMusicTest("sound/invalid")
					LayerManager:removePopLayer()
					LayerManager:pushInLayer("PopGoGainLayer", {
						item = "gold",
						goto_back_system_id = self:getCurSystemId()
					})

					if arg_78_1 then
						arg_78_1(false)
					end
				else
					audio_manager:playeffectMusicTest("sound/invalid")

					if arg_78_1 then
						arg_78_1(false)
					end
				end
			end)
		end,
		returnCallBack = function()
			self:updateGirlDate()
			self:resetAllComponentRedPoint()
			self:updateComponentPanel()
		end,
		cancelcallback = function()
			self:resetTopCostListButton()
		end
	}

	local function var_77_6()
		local var_94_0 = {
			itemtype = kITEM_COMPONENT,
			itemConditions = var_77_0,
			usedItem = var_77_1,
			callbacklist = var_77_5,
			paneltype = ITEMPANEL_TYPE_ROLE_COMPONENT,
			goto_back_system_id = self:getCurSystemId()
		}

		if var_77_1 then
			local var_94_1

			for iter_94_0 = 1, 3 do
				if playermodel.component[self.curSoul] and playermodel.component[self.curSoul][iter_94_0] then
					if not var_94_1 then
						var_94_1 = playermodel.items[playermodel.component[self.curSoul][iter_94_0].id].component_attr.effect
					elseif var_94_1 ~= playermodel.items[playermodel.component[self.curSoul][iter_94_0].id].component_attr.effect then
						var_94_1 = nil

						break
					end
				else
					var_94_1 = nil

					break
				end
			end

			var_94_0.componentScore = component_manager:getScore(var_77_1[1])
			var_94_0.effectid = var_94_1
		else
			var_94_0.componentScore = 0
		end

		LayerManager:pushInLayer("ItemsPanel", var_94_0)
	end

	if var_77_1 then
		local function var_77_7(arg_95_0, arg_95_1, arg_95_2)
			arg_95_0:setBright(false)

			if arg_95_1 ~= ccui.TouchEventType.ended then
				return
			end

			local var_95_0 = playermodel.component[self.curSoul][arg_77_1].id

			component_manager:strengthenComponent(playermodel.component[self.curSoul][arg_77_1].id, function(arg_96_0)
				arg_95_0:setBright(true)

				if arg_96_0 == 1 then
					if releasecallback then
						releasecallback()
					end

					local var_96_0 = component_manager:getStrengthenInfo(var_95_0, true)
					local var_96_2 = {
						L_COMPONENT_TEXT.prefix_str[1] .. "\n" .. var_96_0[1].name .. " + " .. FIGHT_ATTR_FORMAT(var_96_0[1].key, var_96_0[1].value)
					}

					for iter_96_0, iter_96_1 in pairs(var_96_0[3]) do
						var_96_2[iter_96_0 + 1] = iter_96_0 == 1 and L_COMPONENT_TEXT.prefix_str[2] .. "\n" .. FIGHT_ATTR_INFO[iter_96_1.key] .. " + " .. FIGHT_ATTR_FORMAT(iter_96_1.key, iter_96_1.value) or FIGHT_ATTR_INFO[iter_96_1.key] .. " + " .. FIGHT_ATTR_FORMAT(iter_96_1.key, iter_96_1.value)
					end

					local var_96_3 = component_manager:getStrengthenInfo(var_95_0, true, self.servantid)
					local var_96_4 = {}
					local var_96_5 = {}

					if var_96_0[1].value ~= var_96_3[1].value then
						local var_96_6 = 2

						for iter_96_2, iter_96_3 in pairs(var_96_3[3]) do
							var_96_4[#var_96_4 + 1] = {}
							var_96_4[#var_96_4].key = FIGHT_ATTR_INFO[iter_96_3.key]
							var_96_4[#var_96_4].value = " + " .. FIGHT_ATTR_FORMAT(iter_96_3.key, iter_96_3.value)
							var_96_6 = var_96_6 + 1
						end

						var_96_5[1] = L_COMPONENT_TEXT.prefix_str[5] .. "\n" .. var_96_3[1].name .. " + " .. FIGHT_ATTR_FORMAT(var_96_3[1].key, var_96_3[1].value)

						for iter_96_4, iter_96_5 in pairs(var_96_4) do
							var_96_5[iter_96_4 + 1] = iter_96_4 == 1 and L_COMPONENT_TEXT.prefix_str[6] .. "\n" .. iter_96_5.key .. iter_96_5.value or iter_96_5.key .. iter_96_5.value
						end
					end

					self:updateGirlDate()
					self:resetAllComponentRedPoint()
					self:updateStatusPanel()
					self:updateComponentPanel()

					if arg_95_2 then
						arg_95_2(nil, var_96_2, var_96_5)
					end
				elseif arg_96_0 == 2 then
					global_ShowBlockWords(L_COMPONENT_TEXT.Warning[2])
					audio_manager:playeffectMusicTest("sound/invalid")
				elseif arg_96_0 == 3 then
					global_ShowBlockWords(L_COMPONENT_TEXT.Warning[3])
					audio_manager:playeffectMusicTest("sound/invalid")
				elseif arg_96_0 == 4 then
					global_ShowBlockWords(L_COMPONENT_TEXT.Warning[4])
					audio_manager:playeffectMusicTest("sound/invalid")
					LayerManager:removePopLayer()
					LayerManager:pushInLayer("PopGoGainLayer", {
						item = "gold",
						goto_back_system_id = self:getCurSystemId()
					})
				end
			end)
		end

		local var_77_8 = var_77_1[1]
		local var_77_9 = component_manager:getStrengthenStatus(var_77_1[1])
		local var_77_10 = component_manager:canAdjustComponent(var_77_1[1])
		local var_77_11 = component_manager:hadAdjustComponent(var_77_1[1])
		local var_77_12 = component_manager:initComponentIntro(var_77_1[1], true)

		local function var_77_13(arg_99_0, arg_99_1)
			if arg_99_1 ~= ccui.TouchEventType.ended then
				return
			end

			var_77_6()
		end

		local var_77_14 = {
			itemid = playermodel.items[var_77_1[1]].itemid,
			entityid = var_77_1[1],
			servantid = self.curSoul
		}
		local var_77_15 = {}
		local var_77_16 = {}

		if playermodel.items[var_77_1[1]].component_attr.lock then
			var_77_16.label = L_UNLOCK or L_LOCK
		end

		function var_77_16.surecallback(arg_97_0, arg_97_1, arg_97_2)
			if arg_97_1 ~= ccui.TouchEventType.ended then
				return
			end

			network:rpc("lock_item", {
				locktype = playermodel.items[var_77_8].component_attr.lock and 1 or 2,
				entityid = var_77_8
			}, function(arg_98_0)
				if arg_98_0.result == 1 then
					playermodel.items[var_77_8].component_attr.lock = arg_98_0.lock

					if playermodel.items[var_77_8].component_attr.lock then
						if arg_97_2 then
							arg_97_2(1)
						end
					elseif arg_97_2 then
						arg_97_2(0)
					end
				else
					l2Log("lock fail")
				end
			end)
		end

		var_77_15[1] = var_77_16

		local var_77_17 = {}
		local var_77_18

		if var_77_9 then
			var_77_18 = L_COMPONENT_TEXT.Button_Label[3]

			if not L_COMPONENT_TEXT.Button_Label[3] then
				if var_77_10 then
					var_77_18 = L_COMPONENT_TEXT.Button_Label[8]

					if not L_COMPONENT_TEXT.Button_Label[8] then
						if var_77_11 then
							var_77_18 = L_COMPONENT_TEXT.Button_Label[9] or L_COMPONENT_TEXT.Button_Label[4]
						end
					end
				end
			end
		end

		var_77_17.label = var_77_18
		var_77_17.surecallback = var_77_7
		var_77_17.surecallback2 = strengthenCallback
		var_77_15[2] = var_77_17
		var_77_15[3] = {
			label = L_BUTTON_TEXT.Switch,
			surecallback = var_77_13
		}
		var_77_15[4] = {
			label = L_BUTTON_TEXT.Item_Panel_Btn.Unload,
			surecallback = function()
				var_77_4()
			end
		}
		var_77_14.button = var_77_15
		var_77_14.nextgrade = component_manager:getUpGradeData(var_77_8)

		function var_77_14.exitCallback(...)
			self:updateEquipLayerCallback()
			self:updateGirlDate()
			self:updateStatusPanel()
			self:updateWeaponPanel()
			self:resetTopCostListButton()
			self:updateComponentPanel()
		end

		var_77_14.goto_back_system_id = self:getCurSystemId()

		LayerManager:pushInLayer("PopComponentInfos", var_77_14)

		return
	else
		var_77_6()
	end
end

local function var_0_58(arg_102_0)
	return component_effect_data[arg_102_0].image_id
end

function SoulsLayer:initcomponentPanel()
	if not self.attrDownPanel then
		return
	end

	self.componentPanel = self.attrDownPanel:getChildByName("Panel_component")

	self.componentPanel:setTouchEnabled(false)

	if not self.componentPanel:getChildByName("equipComponent") then
		local var_103_0 = ccui.Button:create("EquipLayer/btn_equip_onekey.png", nil, "EquipLayer/btn_equip_onekey.png", var_0_43)

		self.componentPanel:addChild(var_103_0)
		var_103_0:setName("equipComponent")
		var_103_0:setPosition(-160, 170)
		var_103_0:addTouchEventListener(function(arg_104_0, arg_104_1)
			if arg_104_1 ~= ccui.TouchEventType.ended then
				return
			end

			if not arg_104_0:isBright() then
				return
			end

			arg_104_0:setBright(false)
			self:equip_component_onekey(arg_104_0)
		end)
	end

	if self.displayType == "attr" then
		self.componentPanel:setPositionX(800)
		self.componentPanel:runAction(cc.MoveTo:create(var_0_50, cc.p(640, self.componentPanel:getPositionY())))
	end

	local function var_103_4(arg_108_0)
		if playermodel.component[self.curSoul] and playermodel.component[self.curSoul][arg_108_0.pos] then
			arg_108_0:getChildByName("Image_componentUseBg"):loadTexture("EquipLayer/component_used.png", var_0_43)
			arg_108_0:getChildByName("Image_componentUseBg"):setVisible(true)
			arg_108_0:getChildByName("Image_componentUseBg"):loadTexture("EquipLayer/component_used_" .. item_data[playermodel.items[playermodel.component[self.curSoul][arg_108_0.pos].id].itemid].equip_quality .. ".png", var_0_43)

			if arg_108_0:getChildByName("Image_componentUseBg"):getChildByName("componentSp") then
				arg_108_0:getChildByName("Image_componentUseBg"):getChildByName("componentSp"):removeFromParent()
			end

			local var_108_0 = component_manager:create_component_icon(playermodel.component[self.curSoul][arg_108_0.pos].id, 1)

			var_108_0:setPositionX(arg_108_0:getChildByName("Image_componentUseBg"):getContentSize().width / 2)
			var_108_0:setPositionY(arg_108_0:getChildByName("Image_componentUseBg"):getContentSize().height / 2)
			var_108_0:setName("componentSp")
			arg_108_0:getChildByName("Image_componentUseBg"):addChild(var_108_0)
			arg_108_0:getChildByName("Label_component_extra"):setString("+" .. component_manager:getComponentAttrsInfo(playermodel.component[self.curSoul][arg_108_0.pos].id, self.curSoul).extra)
		else
			arg_108_0:getChildByName("Image_componentUseBg"):setVisible(false)
			arg_108_0:getChildByName("Label_component_extra"):setString("")
		end

		if self:isShowComponentRedPoint(self.curSoul, arg_108_0.pos) == true then
			arg_108_0:getChildByName("Image_redPoint"):setVisible(true)
			arg_108_0:getChildByName("Image_redPoint"):loadTexture("public/reddot/reddot2.png", var_0_43)
		elseif self:isShowComponentRedPoint(self.curSoul, arg_108_0.pos) == 2 then
			arg_108_0:getChildByName("Image_redPoint"):loadTexture("public/reddot/up.png", var_0_43)
			arg_108_0:getChildByName("Image_redPoint"):setVisible(true)
		else
			arg_108_0:getChildByName("Image_redPoint"):setVisible(false)
		end
	end

	local function var_103_5(arg_109_0, arg_109_1)
		if arg_109_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not isContainPosOfConvexPolygon(var_0_52, (arg_109_0:convertToNodeSpace((arg_109_0:getTouchEndPosition())))) then
			return
		end

		if not level_manager:isPlayerPassLevel(UNLOCK_EQUIPLAYER_COMPONENT) then
			global_ShowBlockWords(string.format(L_AREAN_UNLOCK, level_manager:formatSystemUnlockLevel(UNLOCK_EQUIPLAYER_COMPONENT)))

			return
		end

		self:componentTouchEvent(arg_109_0.pos)
	end

	ccui.Helper:seekWidgetByName(self.rootLayer, "Button_introduce"):addTouchEventListener(function(arg_110_0, arg_110_1)
		local var_110_0

		if arg_110_1 ~= ccui.TouchEventType.ended then
			do return end

			var_110_0 = {}
		end

		var_110_0.tips = {
			"mainScenebg/guide/18.jpg",
			"mainScenebg/guide/19.jpg",
			"mainScenebg/guide/20.jpg",
			"mainScenebg/guide/21.jpg"
		}

		LayerManager:pushInLayer("TipsLayer", var_110_0)
	end)

	local function var_103_6(arg_111_0, arg_111_1)
		local var_111_0 = ccui.Helper:seekWidgetByName(self.attrDownPanel, "Button_component" .. arg_111_0)

		var_111_0.pos = arg_111_0

		if playermodel.component[self.curSoul] and playermodel.component[self.curSoul][arg_111_0] and next(playermodel.component[self.curSoul][arg_111_0]) ~= nil then
			var_111_0.entityid = playermodel.component[self.curSoul][arg_111_0].id
			var_111_0.itemid = playermodel.items[var_111_0.entityid].itemid
		else
			var_111_0.entityid = -1
		end

		var_111_0.update = var_103_4

		var_111_0:update()
		var_111_0:setVisible(true)
		var_111_0:setSwallowTouches(false)
		var_111_0:addTouchEventListener(var_103_5)
	end

	for iter_103_0 = 1, 3 do
		var_103_6(iter_103_0, initFinCallback)
	end

	local function var_103_7(arg_112_0, arg_112_1)
		if arg_112_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_112_0, var_112_1 = component_manager:getServantComponentlist(self.curSoul)
		local var_112_2 = true

		if playermodel.component[self.curSoul] then
			for iter_112_0, iter_112_1 in pairs(playermodel.component[self.curSoul]) do
				if item_data[playermodel.items[iter_112_1.id].itemid].equip_quality < 5 then
					var_112_2 = false
				end
			end
		end

		if var_112_2 and var_112_1 and var_112_1[1] then
			LayerManager:pushInLayer("PopComponentReinforceLayer", {
				servantid = self.curSoul,
				callback = function(...)
					self:updateComponentPanel()
				end
			})
		else
			self:showComponentEffect(true)
		end
	end

	ccui.Helper:seekWidgetByName(self.attrDownPanel, "Panel_effectTouchLayer"):addTouchEventListener(var_103_7)
	ccui.Helper:seekWidgetByName(self.attrDownPanel, "Panel_effectTouchLayer_0"):addTouchEventListener(var_103_7)

	local var_103_8 = ccui.Helper:seekWidgetByName(self.attrDownPanel, "Panel_componentEffect")

	function var_103_8.update()
		local var_114_0 = false

		if self.roleInfos[self.curSoul] then
			if next(self.roleInfos[self.curSoul].effects) ~= nil then
				local var_114_1 = ""

				for iter_114_0, iter_114_1 in pairs(self.roleInfos[self.curSoul].effects) do
					var_114_1 = component_effect_data[iter_114_1].intro .. "\n"
				end

				if var_114_1 ~= nil then
					effectid = playermodel.items[playermodel.component[self.curSoul][1].id].component_attr.effect
					var_114_0 = true
				end
			end
		end

		ccui.Helper:seekWidgetByName(self.rootLayer, "Button_introduce"):setVisible(true)

		for iter_114_2 = 1, 3 do
			local var_114_2 = var_103_8:getChildByName("Image_28"):getChildByName("Image_component" .. iter_114_2)

			print(var_114_2, iter_114_2)

			if playermodel.component[self.curSoul] and playermodel.component[self.curSoul][iter_114_2] then
				local var_114_3 = playermodel.component[self.curSoul][iter_114_2].id
				local var_114_4 = playermodel.items[playermodel.component[self.curSoul][iter_114_2].id].itemid
				local var_114_5 = playermodel.items[playermodel.component[self.curSoul][iter_114_2].id].component_attr.effect

				if var_0_32[playermodel.items[playermodel.component[self.curSoul][iter_114_2].id].itemid].main_attr then
					var_114_2:loadTexture("equipment/component/shine_component/component" .. var_0_58(var_114_5) .. "_" .. var_0_32[playermodel.items[playermodel.component[self.curSoul][iter_114_2].id].itemid].main_attr .. "_" .. iter_114_2 .. ".png")
				else
					var_114_2:loadTexture("equipment/component/shine_component/component" .. var_0_58(var_114_5) .. "_" .. playermodel.items[var_114_3].component_attr.attr1 .. "_" .. iter_114_2 .. ".png")
				end

				var_103_8:getChildByName("Label_effectName"):setString(glabal_trans_text_horizontal_to_vertical(component_effect_data[var_114_5].name))
				var_114_2:setVisible(true)

				var_114_2.entityid = var_114_3
				var_114_2.itemid = var_114_4

				ccui.Helper:seekWidgetByName(self.rootLayer, "Button_introduce"):setVisible(false)
			else
				var_114_2:setVisible(false)

				var_114_2.entityid = -1
			end
		end

		if playermodel.reinforce_component[self.curSoul] ~= 0 then
			var_103_8:getChildByName("Label_effectName"):setString(glabal_trans_text_horizontal_to_vertical(component_effect_data[effectid].name .. "+"))
		end

		if var_103_8:getChildByName("reddot") then
			var_103_8:getChildByName("reddot"):setVisible(false)
		end

		if var_114_0 then
			var_103_8:getChildByName("Label_effectName"):setVisible(true)
			var_103_8:setVisible(true)
			var_103_8:setOpacity(255)

			local var_114_9 = var_103_8:getChildByName("Image_28"):getContentSize().height / 2

			var_103_8:getChildByName("Image_28"):getChildByName("Image_component1"):setAnchorPoint(cc.p(0.5, 0.5))
			var_103_8:getChildByName("Image_28"):getChildByName("Image_component2"):setAnchorPoint(cc.p(0.5, 0.5))
			var_103_8:getChildByName("Image_28"):getChildByName("Image_component3"):setAnchorPoint(cc.p(0.5, 0.5))

			if config._DEBUG then
				var_103_8:getChildByName("Image_28"):getChildByName("Image_component1"):setPositionY(var_114_9)
				var_103_8:getChildByName("Image_28"):getChildByName("Image_component2"):setPositionY(var_114_9)
				var_103_8:getChildByName("Image_28"):getChildByName("Image_component3"):setPositionY(var_114_9)
			else
				var_103_8:getChildByName("Image_28"):getChildByName("Image_component1"):setPositionY(var_114_9 - 12)
				var_103_8:getChildByName("Image_28"):getChildByName("Image_component2"):setPositionY(var_114_9)
				var_103_8:getChildByName("Image_28"):getChildByName("Image_component3"):setPositionY(var_114_9 + 12)
			end

			if not var_103_8:getChildByName("reddot") then
				local var_114_10 = ccui.ImageView:create("public/reddot/reddot2.png", var_0_43)

				var_114_10:setName("reddot")
				var_114_10:setPosition(cc.p(70, 70))
				var_114_10:setVisible(false)
				var_103_8:addChild(var_114_10, 11111)
			end

			local var_114_11 = true

			if playermodel.component[self.curSoul] then
				for iter_114_3, iter_114_4 in pairs(playermodel.component[self.curSoul]) do
					if item_data[playermodel.items[iter_114_4.id].itemid].equip_quality < 5 then
						var_114_11 = false
					end
				end
			end

			if var_114_11 and playermodel.reinforce_component[self.curSoul] == 0 then
				var_103_8:getChildByName("reddot"):setVisible(true)
			end
		else
			var_103_8:getChildByName("Label_effectName"):setVisible(false)

			local var_114_12 = var_103_8:getChildByName("Image_28"):getContentSize().height / 2

			if config._DEBUG then
				var_103_8:getChildByName("Image_28"):getChildByName("Image_component1"):setPositionY(var_114_12 + 12)
				var_103_8:getChildByName("Image_28"):getChildByName("Image_component2"):setPositionY(var_114_12)
				var_103_8:getChildByName("Image_28"):getChildByName("Image_component3"):setPositionY(var_114_12 - 12)
			else
				var_103_8:getChildByName("Image_28"):getChildByName("Image_component1"):setPositionY(var_114_12)
				var_103_8:getChildByName("Image_28"):getChildByName("Image_component2"):setPositionY(var_114_12)
				var_103_8:getChildByName("Image_28"):getChildByName("Image_component3"):setPositionY(var_114_12)
			end
		end

		var_103_8:setTouchEnabled(true)
	end

	var_103_8.update()
end

function SoulsLayer:showComponentEffect(arg_116_1)
	if next(self.roleInfos[self.curSoul].effects) ~= nil then
		local var_116_0 = playermodel.items[playermodel.component[self.curSoul][1].id].component_attr.effect

		if arg_116_1 or self.effectid ~= var_116_0 then
			local var_116_2 = ""

			for iter_116_0, iter_116_1 in pairs(self.roleInfos[self.curSoul].effects) do
				var_116_2 = component_effect_data[iter_116_1].intro .. "\n"
			end

			if var_116_2 ~= nil then
				if playermodel.reinforce_component[self.curSoul] ~= 0 then
					var_116_2 = component_effect_data[playermodel.reinforce_component[self.curSoul]].intro_up or "没填intro_up"
				end

				local var_116_3 = string.find(var_116_2, "：", 1)
				local var_116_4 = {
					suit = {},
					labels = {
						title = string.sub(var_116_2, 1, var_116_3 - 1),
						effect = string.sub(var_116_2, var_116_3 + 3, string.len(var_116_2))
					}
				}

				for iter_116_2 = 1, 3 do
					var_116_4.suit[iter_116_2] = var_0_32[playermodel.items[playermodel.component[self.curSoul][iter_116_2].id].itemid].main_attr and "equipment/component/shine_component/component" .. var_0_58(var_116_0) .. "_" .. var_0_32[playermodel.items[playermodel.component[self.curSoul][iter_116_2].id].itemid].main_attr .. "_" .. iter_116_2 .. ".png" or "equipment/component/shine_component/component" .. var_0_58(var_116_0) .. "_" .. playermodel.items[playermodel.component[self.curSoul][iter_116_2].id].component_attr.attr1 .. "_" .. iter_116_2 .. ".png"
				end

				self.rootLayer:runAction(cc.Sequence:create(cc.DelayTime:create((arg_116_1 or nil) and 0), cc.CallFunc:create(function()
					self:animationComponentSuit(var_116_4)
				end)))
			end
		end

		self.effectid = var_116_0
	else
		self.effectid = nil

		if arg_116_1 then
			global_ShowBlockWords(L_COMPONENT_TEXT.No_Suit_Effect)
			audio_manager:playeffectMusicTest("sound/invalid")
		end
	end
end

function SoulsLayer:updateComponentPanel()
	if not self.attrDownPanel then
		return
	end

	if ccui.Helper:seekWidgetByName(self.attrDownPanel, "Button_component1") then
		ccui.Helper:seekWidgetByName(self.attrDownPanel, "Button_component1"):update()
	else
		print("componentNode1 init not fin")
	end

	if ccui.Helper:seekWidgetByName(self.attrDownPanel, "Button_component2") then
		ccui.Helper:seekWidgetByName(self.attrDownPanel, "Button_component2"):update()
	else
		print("componentNode2 init not fin")
	end

	if ccui.Helper:seekWidgetByName(self.attrDownPanel, "Button_component3") then
		ccui.Helper:seekWidgetByName(self.attrDownPanel, "Button_component3"):update()
	else
		print("componentNode3 init not fin")
	end

	if ccui.Helper:seekWidgetByName(self.attrDownPanel, "Panel_componentEffect") then
		ccui.Helper:seekWidgetByName(self.attrDownPanel, "Panel_componentEffect").update()
	else
		print("componentEffectPanel init not fin")
	end
end

function SoulsLayer:showServantBreakLimit(arg_119_1, arg_119_2)
	local function var_119_0()
		if LayerManager:getUIElement("TopcostLayer") then
			LayerManager:getUIElement("TopcostLayer"):showTopcostLayer()
		end
	end

	local function var_119_1()
		self:updateShowgirlLayer()
	end

	local var_119_2 = playermodel.soulContract[self.curSoul]
	local var_119_3 = model_data[servant_data[self.curSoul].modelid].damageFactor
	local var_119_4 = model_data[servant_data[self.curSoul].modelid].hpFactor
	local var_119_5 = model_data[servant_data[self.curSoul].modelid].damageFactor + (servant_data[self.curSoul]["damageFactorPlus" .. playermodel.soulContract[self.curSoul]] or 0)
	local var_119_6 = model_data[servant_data[self.curSoul].modelid].hpFactor + (servant_data[self.curSoul]["hpFactorPlus" .. var_119_2] or 0)

	if var_119_2 < 5 then
		var_119_3 = var_119_3 + (servant_data[self.curSoul]["damageFactorPlus" .. var_119_2 + 1] or 0)
		var_119_4 = var_119_4 + (servant_data[self.curSoul]["hpFactorPlus" .. var_119_2 + 1] or 0)
	end

	local var_119_10
	local var_119_9
	local var_119_8

	do
		var_119_4 = L_SOULS_BREAK_LIMIT.Level_Max
		var_119_3 = L_SOULS_BREAK_LIMIT.Level_Max
		var_119_8 = {
			showIntro = true
		}
		var_119_9 = {
			{
				newvalue = {
					var_119_5,
					var_119_3
				},
				name = L_SOULS_BREAK_LIMIT.Aptitude[2] .. "："
			}
		}
		var_119_10 = {}
	end

	var_119_10.newvalue = {
		var_119_6,
		var_119_4
	}
	var_119_10.name = L_SOULS_BREAK_LIMIT.Aptitude[1] .. "："
	var_119_9[2] = var_119_10
	var_119_8.labels = var_119_9

	function var_119_8.cancelcallback()
		var_119_0()
	end

	var_119_8.materials = {}
	var_119_8.goto_back_system_id = self:getCurSystemId()

	local var_119_11 = core_manager:getUpgradeCostRoleCardNum(self.curSoul, var_119_2 + 1) or 0

	if var_119_11 > 0 then
		var_119_8.materials[#var_119_8.materials + 1] = {}
		var_119_8.materials[#var_119_8.materials].ownnum = playermodel.servantNum[self.curSoul]
		var_119_8.materials[#var_119_8.materials].neednum = var_119_11
		var_119_8.materials[#var_119_8.materials].id = servant_data[self.curSoul].itemid
	end

	local var_119_12 = core_manager:getUpgradeCostMaterial(self.curSoul, var_119_2 + 1)

	if var_119_12 then
		var_119_8.materials[#var_119_8.materials + 1] = {}
		var_119_8.materials[#var_119_8.materials].ownnum = item_manager:getItemNumber(var_119_12)
		var_119_8.materials[#var_119_8.materials].neednum = core_manager:getUpgradeCostMaterialNum(self.curSoul, var_119_2 + 1)
		var_119_8.materials[#var_119_8.materials].id = var_119_12
	end

	var_119_8.bntstr = L_BUTTON_TEXT.Up_Grade
	var_119_8.curSoul = self.curSoul

	function var_119_8.surecallback(arg_123_0)
		self:updateGirlDate()
		self:updateStatusPanel()
		self:updateContract()
		self:updateOperationAreaPanel()
		self:updateNamePanel()
		var_119_1()
	end

	var_119_8.title = L_SERVANT_BREAKLIMIT.title
	var_119_8.imageTitle = "public/panelbg/title_girl_up_grade.png"
	var_119_8.soulContract = var_119_2
	var_119_8.isBreakLimit = core_manager:isBreakLimit(self.curSoul)
	var_119_8.showtype = arg_119_1

	;(function()
		if LayerManager:getUIElement("TopcostLayer") then
			LayerManager:getUIElement("TopcostLayer"):hideTopcostLayer()
		end

		if arg_119_2 then
			LayerManager:pushInLayer("ShowRoleOverClockLayer", var_119_8)
		else
			LayerManager:pushInLayer("PopServantUpgradeLayer", var_119_8)
		end
	end)()
end

function SoulsLayer:resetTopCostListButton()
	if LayerManager:getUIElement("TopcostLayer") then
		if self.topCostDisplayState ~= LayerManager:getUIElement("TopcostLayer"):getTopcostLayerState() and self.topCostDisplayState then
			if self.topCostDisplayState == 0 then
				LayerManager:getUIElement("TopcostLayer"):hideTopcostLayer()
			else
				LayerManager:getUIElement("TopcostLayer"):showTopcostLayer()
			end
		end
	end
end

function SoulsLayer:getGirlData(arg_126_1)
	local var_126_0 = model_manager.new()

	if self.soulUnLock == false then
		-- block empty
	elseif playermodel.weaponId[self.curSoul] then
		-- block empty
	end

	var_126_0:initPlayerAttribute(arg_126_1)

	local var_126_3, var_126_4 = component_manager:getSoulComponentlist(arg_126_1)

	var_126_0:updateComponentAttr(var_126_3)

	return {
		model = var_126_0,
		effects = var_126_4
	}
end

function SoulsLayer:updateGirlDate()
	self.roleInfos = {}
	self.roleInfos[self.curSoul] = self:getGirlData(self.curSoul)

	if playermodel.haveServant[self.curSoul] and playermodel.weaponId[self.curSoul] then
		self.weaponOthers = weapon_manager:getWeaponConfig(playermodel.items[playermodel.weaponId[self.curSoul]])

		self.roleInfos[self.curSoul].model:updateWeaponAttr(self.weaponOthers)
	end
end

function SoulsLayer.getBreakOutHandel(arg_128_0)
	return function(arg_129_0, arg_129_1)
		if arg_129_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_129_0 = arg_128_0.curSoul
		local var_129_1 = core_data[playermodel.cores[arg_128_0.curSoul].coreid].upgrade

		if not core_data[core_data[playermodel.cores[arg_128_0.curSoul].coreid].upgrade] then
			var_129_1 = playermodel.cores[arg_128_0.curSoul].coreid
		end

		local var_129_2 = core_data[playermodel.cores[arg_128_0.curSoul].coreid].original_intensify_level + core_manager:getCoreCurRankTotalLv((core_manager:getServantCoreRank(arg_128_0.curSoul)))
		local var_129_3 = core_manager:getStrengthenValue(var_129_0, playermodel.cores[arg_128_0.curSoul].coreid, var_129_2)
		local var_129_5 = core_manager:getStrengthenValue(var_129_0, var_129_1, var_129_2)
		local var_129_6 = "+" .. model_data[servant_data[var_129_0].modelid].hpFactor * var_129_5 - model_data[servant_data[var_129_0].modelid].hpFactor * var_129_3
		local var_129_7 = "+" .. model_data[servant_data[var_129_0].modelid].damageFactor * var_129_5 - model_data[servant_data[var_129_0].modelid].damageFactor * var_129_3
		local var_129_8 = "+" .. var_129_5 - var_129_3

		if core_manager:getServantCoreRank(var_129_0) >= #CLASS_TYPE_ID or core_manager:isCoreMax(var_129_0) then
			local var_129_10 = {
				showIntro = true,
				goto_back_system_id = arg_128_0:getCurSystemId(),
				servantid = var_129_0
			}

			LayerManager:pushInLayer("PopServantBreakout", {
				up_type = 2,
				servantid = var_129_0
			})
		else
			local var_129_11 = core_manager:getCoreTotalLv(core_data[playermodel.cores[arg_128_0.curSoul].coreid].rank)
			local var_129_12 = core_data[playermodel.cores[var_129_0].coreid].rank
			local var_129_13 = {
				showIntro = true
			}
			local var_129_14 = {}
			local var_129_15 = {
				newvalue = var_129_11
			}

			if var_129_11 ~= "" then
				var_129_15.name = L_BREAKOUT_HANDEL.Name[1] or L_BREAKOUT_HANDEL.Name[5]
			end

			var_129_14[1] = var_129_15

			local var_129_16 = {
				newvalue = var_129_11 ~= "" and var_129_8 or ""
			}

			if var_129_11 ~= "" then
				var_129_16.name = L_BREAKOUT_HANDEL.Name[2] or ""
			end

			var_129_14[2] = var_129_16

			local var_129_17 = {
				newvalue = var_129_11 ~= "" and var_129_7 or ""
			}

			if var_129_11 ~= "" then
				var_129_17.name = L_BREAKOUT_HANDEL.Name[3] or ""
			end

			var_129_14[3] = var_129_17

			local var_129_18 = {
				newvalue = var_129_11 ~= "" and var_129_6 or ""
			}

			if var_129_11 ~= "" then
				var_129_18.name = L_BREAKOUT_HANDEL.Name[4] or ""
			end

			var_129_14[4] = var_129_18
			var_129_13.labels = var_129_14
			var_129_13.materials = {}
			var_129_13.gold_cost = core_manager:getBreakOutCostGold(var_129_0, core_data[playermodel.cores[var_129_0].coreid].rank + 1)
			var_129_13.goto_back_system_id = arg_128_0:getCurSystemId()
			var_129_13.servantid = var_129_0
			var_129_13.up_type = var_129_12 >= SERVANT_CORE_BREAK_MAX and 2 or 1

			local var_129_19 = true
			local var_129_20 = core_manager:getBreakOutCostMaterial(var_129_0, var_129_12 + 1)

			for iter_129_0, iter_129_1 in pairs(var_129_20) do
				local var_129_21 = item_manager:getItemNumber(iter_129_1.itemid)

				var_129_13.materials[#var_129_13.materials + 1] = {}
				var_129_13.materials[#var_129_13.materials].ownnum = var_129_21
				var_129_13.materials[#var_129_13.materials].neednum = iter_129_1.num
				var_129_13.materials[#var_129_13.materials].id = iter_129_1.itemid

				if var_129_21 < iter_129_1.num then
					var_129_19 = false
				end
			end

			function var_129_13.surecallback(arg_130_0)
				local var_130_0 = {}

				for iter_130_0 = 1, #var_129_13.materials do
					var_130_0[iter_130_0] = var_129_13.materials[iter_130_0].id
				end

				var_129_19 = true

				for iter_130_1, iter_130_2 in pairs(var_129_20) do
					if iter_130_2.num > item_manager:getItemNumber(iter_130_2.itemid) then
						var_129_19 = false

						break
					end
				end

				if var_129_19 then
					local var_130_1 = core_data[playermodel.cores[var_129_0].coreid].rank

					core_manager:upgradeCoreToServer(var_129_0, function(arg_131_0, arg_131_1)
						if arg_131_0 == 1 then
							({})[1] = L_SOULS_CENTRE_LV .. "  " .. var_130_1 .. " → " .. core_data[playermodel.cores[var_129_0].coreid].rank

							local var_131_0 = {
								cc.c3b(255, 150, 0)
							}

							audio_manager:playeffectMusicTest("sound/jinjie")
							arg_128_0:breakAnimation(var_129_0, var_130_0, var_129_12 >= 3 and 2 or 1)
							arg_128_0:updateGirlDate()
							arg_128_0:updateLevelPanel()
							arg_128_0:updateStatusPanel()
						elseif arg_131_0 == 4 then
							LayerManager:removePopLayer()
							LayerManager:pushInLayer("PopGoLayer", {
								targetlayer = "TopPlotListLayer",
								goto_back_system_id = 201,
								labels = L_BREAKOUT_HANDEL.Button_Msg
							})
						else
							if arg_131_1 then
								global_ShowBlockWords(arg_131_1)
							end

							audio_manager:playeffectMusicTest("sound/invalid")
						end

						if arg_130_0 then
							arg_130_0(arg_131_0)
						end
					end)
				else
					global_ShowBlockWords(L_COMMON_WARNING.Material_Lack)
					audio_manager:playeffectMusicTest("sound/invalid")
				end
			end

			function var_129_13.cancelcallback()
				arg_128_0:updateEquipLayerCallback()
			end

			LayerManager:pushInLayer("PopServantBreakout", var_129_13)
		end
	end
end

local function var_0_59(arg_133_0, arg_133_1)
	local var_133_0 = ccui.ImageView:create("public/panelbg/servant_break_out_bg.png", var_0_43)
	local var_133_1 = ccui.ImageView:create("public/panelbg/servant_break_lvl_bg.png", var_0_43)

	var_133_1:setPosition(cc.p(320, 228))
	var_133_0:addChild(var_133_1)

	local var_133_2 = ccui.ImageView:create("public/panelbg/servant_break_skl_bg.png", var_0_43)

	var_133_2:setAnchorPoint(cc.p(0, 0))
	var_133_2:setPosition(cc.p(8, 12))
	var_133_0:addChild(var_133_2)

	local var_133_3 = cc.Label:createWithTTF(L_SHOW_ROLE_INFO_1[1], FONT_NAME, 20)

	var_133_3:setPosition(cc.p(106, 69))
	var_133_1:addChild(var_133_3)

	local var_133_4 = cc.Label:createWithTTF(L_SHOW_ROLE_INFO_1[2], FONT_NAME, 20)

	var_133_4:setPosition(cc.p(106, 19))
	var_133_1:addChild(var_133_4)

	local var_133_5 = core_manager:getCoreLv(arg_133_0)

	print()

	local var_133_6 = core_manager:getStrengthenValue(arg_133_0, playermodel.cores[arg_133_0].coreid, var_133_5)
	local var_133_7 = cc.Label:createWithTTF(model_data[servant_data[arg_133_0].modelid].hpFactor * var_133_6, FONT_NAME, 20)

	var_133_7:setPosition(cc.p(205, 69))
	var_133_1:addChild(var_133_7)

	local var_133_8 = cc.Label:createWithTTF(model_data[servant_data[arg_133_0].modelid].damageFactor * var_133_6, FONT_NAME, 20)

	var_133_8:setPosition(cc.p(205, 19))
	var_133_1:addChild(var_133_8)

	local var_133_10 = core_manager:getStrengthenValue(arg_133_0, (not core_data[core_data[playermodel.cores[arg_133_0].coreid].upgrade] or nil) and playermodel.cores[arg_133_0].coreid, var_133_5)
	local var_133_11 = cc.Label:createWithTTF(model_data[servant_data[arg_133_0].modelid].hpFactor * var_133_10, FONT_NAME, 20)

	var_133_11:setPosition(cc.p(445, 69))
	var_133_11:setColor(cc.c3b(255, 201, 13))
	var_133_1:addChild(var_133_11)

	local var_133_12 = cc.Label:createWithTTF(model_data[servant_data[arg_133_0].modelid].damageFactor * var_133_10, FONT_NAME, 20)

	var_133_12:setPosition(cc.p(445, 19))
	var_133_12:setColor(cc.c3b(255, 201, 13))
	var_133_1:addChild(var_133_12)

	local var_133_13 = cc.Label:createWithTTF("+" .. model_data[servant_data[arg_133_0].modelid].hpFactor * var_133_10 - model_data[servant_data[arg_133_0].modelid].hpFactor * var_133_6, FONT_NAME, 15)

	var_133_13:setPosition(cc.p(325, 75))
	var_133_13:setColor(cc.c3b(255, 201, 13))
	var_133_1:addChild(var_133_13)

	local var_133_14 = cc.Label:createWithTTF("+" .. model_data[servant_data[arg_133_0].modelid].damageFactor * var_133_10 - model_data[servant_data[arg_133_0].modelid].damageFactor * var_133_6, FONT_NAME, 15)

	var_133_14:setPosition(cc.p(325, 25))
	var_133_14:setColor(cc.c3b(255, 201, 13))
	var_133_1:addChild(var_133_14)

	local var_133_15 = core_manager:getServantCoreRank(arg_133_0) + 1

	if arg_133_1 == 1 and model_data[servant_data[arg_133_0].modelid]["ex_" .. var_133_15] then
		local var_133_16 = ccui.ImageView:create("skill_new/skill/ex" .. var_133_15 .. ".png", var_0_43)

		var_133_16:setPosition(cc.p(70, 46))
		var_133_16:setScale(0.8)
		var_133_2:addChild(var_133_16)

		local var_133_18 = ccui.ImageView:create((var_133_15 == 1 or nil) and "public/button/get_skill.png", var_0_43)

		var_133_18:setPosition(cc.p(10, 108))
		var_133_18:setScale(1.25)
		var_133_16:addChild(var_133_18)

		local var_133_19 = cc.Label:createWithTTF(total_skill_data[model_data[servant_data[arg_133_0].modelid]["ex_" .. var_133_15]].name, FONT_DES, 20)

		var_133_19:setAnchorPoint(cc.p(0, 0.5))
		var_133_19:setColor(cc.c3b(255, 201, 13))
		var_133_19:setPosition(cc.p(125, 88))
		var_133_2:addChild(var_133_19)

		local var_133_20 = RichTextPro:create()

		var_133_20:setMaxWidth(350)
		var_133_20:setSize(20)
		var_133_20:setLineSpace(0)
		var_133_20:setText((transSkillDesToRichText(total_skill_data[model_data[servant_data[arg_133_0].modelid]["ex_" .. var_133_15]].description)))
		var_133_20:setName("richText")
		var_133_20:setPosition(cc.p(125, 67))
		var_133_2:addChild(var_133_20)
	else
		var_133_2:setVisible(false)
		var_133_1:setPositionY(var_133_1:getPositionY() - 120)
	end

	return var_133_0
end

function SoulsLayer.breakAnimation(arg_134_0, arg_134_1, arg_134_2, arg_134_3)
	local var_134_0 = ccui.Layout:create()

	var_134_0:setTouchEnabled(true)
	var_134_0:setContentSize(cc.Director:getInstance():getVisibleSize())
	var_134_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_134_0:setPosition(cc.p(cc.Director:getInstance():getVisibleSize().width / 2, cc.Director:getInstance():getVisibleSize().height / 2))
	var_134_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_134_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_134_0:setBackGroundColorOpacity(180)
	global_basic_scene:addChild(var_134_0, 999)

	local var_134_1 = ccui.ImageView:create("roleimage/role1/" .. model_data[global_get_servant_skin(arg_134_1)].cute_role .. ".png")

	var_134_1:setPosition(cc.p(var_134_0:getContentSize().width / 2 + 15, var_134_0:getContentSize().height / 2 + 50))
	var_134_0:addChild(var_134_1, 100)
	var_134_1:setScale(0.7)

	local var_134_2 = false

	var_134_0:runAction(cc.Sequence:create(cc.CallFunc:create(function()
		var_134_2 = true
	end), cc.CallFunc:create(function()
		local var_138_0 = L2Skeleton:create("spine/ui/upgrade/up.json", "spine/ui/upgrade/up.atlas")

		var_138_0:refreshSkeleton()
		var_138_0.skeletonAnimation:setPositionX(var_134_0:getContentSize().width / 2 + 20)
		var_138_0.skeletonAnimation:setPositionY(var_134_0:getContentSize().height / 2)
		var_138_0:setName("upSpine")
		var_138_0:setScale(2)
		var_138_0:play("tupo", false)
		var_134_0:addChild(var_138_0, 150)

		local var_138_1 = L2Skeleton:create("spine/ui/upgrade/down.json", "spine/ui/upgrade/down.atlas")

		var_138_1:refreshSkeleton()
		var_138_1.skeletonAnimation:setPositionX(var_134_0:getContentSize().width / 2 + 20)
		var_138_1.skeletonAnimation:setPositionY(var_134_0:getContentSize().height / 2 - 80)
		var_138_1:setName("downSpine")
		var_138_1:setScale(1.5)
		var_138_1:play("tupo", false)
		var_134_0:addChild(var_138_1, 50)
	end), cc.DelayTime:create(2.3), cc.CallFunc:create(function()
		local var_135_0 = ccui.ImageView:create("EquipLayer/weapon_light.png", var_0_43)

		var_135_0:setPosition(cc.p(var_134_0:getContentSize().width / 2, var_134_0:getContentSize().height / 2))
		var_135_0:setScale(0.1)
		var_134_0:addChild(var_135_0, 999)
		var_135_0:runAction(cc.Sequence:create(cc.ScaleTo:create(0.3, 100), cc.RemoveSelf:create()))
		var_134_1:setVisible(false)
	end), cc.DelayTime:create(0.3), cc.CallFunc:create(function()
		local var_136_0 = var_134_0:getChildByName("upSpine")
		local var_136_1 = var_134_0:getChildByName("downSpine")

		if var_136_0 then
			var_136_0:setVisible(false)
		end

		if var_136_1 then
			var_136_1:setVisible(false)
		end

		local var_136_2 = ccui.ImageView:create("AchievementPop/achievement_bg.png", var_0_43)

		var_136_2:setPosition(cc.p(var_134_0:getContentSize().width / 2, var_134_0:getContentSize().height / 2 + 100))
		var_136_2:setScale(0, 1)
		var_136_2:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1, 1), cc.CallFunc:create(function()
			local var_137_0 = cc.Label:createWithTTF((arg_134_3 == 1 or nil) and (L_BREAKOUT_HANDEL.Success or L_BREAKOUT_HANDEL.advance_success), FONT_NAME, 30)

			var_137_0:setColor(cc.c3b(0, 0, 0))
			var_137_0:setPosition(cc.p(var_136_2:getContentSize().width / 2, var_136_2:getContentSize().height / 2))
			var_136_2:addChild(var_137_0, 999)

			local var_137_1 = var_0_59(arg_134_1, arg_134_3)

			var_137_1:setPosition(cc.p(var_134_0:getContentSize().width / 2, var_134_0:getContentSize().height / 2 + (arg_134_3 ~= 1 and -40 or -120)))
			var_134_0:addChild(var_137_1)
		end)))
		var_134_0:addChild(var_136_2, 999)
	end), cc.DelayTime:create(10), cc.RemoveSelf:create()))
	var_134_0:addTouchEventListener(function(arg_140_0, arg_140_1)
		if arg_140_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not var_134_2 then
			return
		end

		var_134_0:runAction(cc.RemoveSelf:create())
		arg_134_0:getBreakOutHandel()(arg_134_0.levelPanel:getChildByName("Button_breakOut"), ccui.TouchEventType.ended)
	end)
end

function SoulsLayer:showInfoPanel(arg_141_1)
	self:initUILoadQueue()
	self.infoPanel:setVisible(true)

	if self.switchModeFin == nil then
		self.switchModeFin = true
	end

	self.soulUnLock = nil
	self.displayType = "attr"

	if playermodel.haveServant[self.curSoul] then
		if self.defaultDisplayType then
			self.displayType = self.defaultDisplayType
		end

		self.soulUnLock = true
	else
		self.soulUnLock = false
		self.displayType = "preview"
	end

	if self.showtype == SHOW_TYPE_TWISTEGG_PREVIEW then
		self.displayType = "preview"
	end

	self:updateGuide()

	self.previewType = 1

	self:updateGirlDate()
	self:updateNamePanel()
	self:setInitUiPos()
	self:initOperationAreaPanel()
	self:initStatusPanel()
	self:initDevourLayout()
	self:updateStatusPanel()

	self.moveEndFlag = true

	self:runAction(cc.Sequence:create(cc.DelayTime:create(), cc.CallFunc:create(function(...)
		self:updateShowgirlLayer()
	end)))

	self.bottomPanel = ccui.Helper:seekWidgetByName(self.infoPanel, "Panel_bottom")

	self.bottomPanel:getChildByName("Button_cancel"):addTouchEventListener(function(arg_143_0, arg_143_1)
		if arg_143_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.showtype == SHOW_TYPE_DROP_PREVIEW or self.showtype == SHOW_TYPE_TWISTEGG_PREVIEW then
			self.infoPanel:setVisible(false)

			if self.exitCallback then
				self.exitCallback()
			end

			if self.exitUpdateCallback then
				self.exitUpdateCallback()
			end

			if self:getParent():getName() ~= "SignLayer" then
				if self:getParent():getName() == "ActivitySignLayer" then
					self:runAction(cc.RemoveSelf:create())

					goto label_143_0
				end
			end

			LayerManager:removePopLayer()
		elseif self.showtype == SHOW_TYPE_FIGHTLAYER then
			if self.exitCallback then
				self.exitCallback()
			end

			if self.exitUpdateCallback then
				self.exitUpdateCallback()
			end

			KeyCodeManager:onKeyReleasedCallFunc()
		else
			self.infoPanel:setVisible(false)

			if self.exitCallback then
				self.exitCallback()
			end

			if self.exitUpdateCallback then
				self.exitUpdateCallback()
			end

			KeyCodeManager:onKeyReleasedCallFunc()
		end

		::label_143_0::

		var_0_54 = nil
	end)

	if self.bottomBtnState == var_0_49 then
		self.infoPanel:getChildByName("Panel_bottom"):setVisible(false)
	end

	self:sortLoadUI(self.displayType)
end

function SoulsLayer:createPopTalk(arg_144_1)
	local var_144_0

	if arg_144_1.showType == "component" then
		local var_144_1 = GenerateRoleConversationClass(global_get_servant_skin(self.curSoul) or major_factor_data[servant_data[self.curSoul].major].model, ROLE_CONVERSATION_TYPE.component)

		if var_144_1 and role_conversation_data[var_144_1 * 100 + 1].dec then
			var_144_0 = role_conversation_data[var_144_1 * 100 + 1].dec
		end
	elseif arg_144_1.showType == "dress" then
		var_144_0 = item_data[arg_144_1.dressid].gift_feedback
	end

	local var_144_2 = cc.Label:createWithTTF("", "fonts/new1.ttf", 20)

	var_144_2:setMaxLineWidth(357)
	var_144_2:setString(var_144_0)
	var_144_2:setAnchorPoint(cc.p(0.5, 0.5))
	var_144_2:setColor(cc.c3b(219, 228, 255))

	local var_144_3 = var_144_2:getContentSize().width
	local var_144_4 = var_144_2:getContentSize().height

	if not self.talk then
		self.talk = ccui.Button:create("mainScenebg/word_bg.png", "mainScenebg/word_bg.png", "mainScenebg/word_bg.png")

		self.talk:setFlippedX(true)
		self.talk:setScale9Enabled(true)
		self.talk:setCapInsets(cc.rect(65, 20, 30, 10))
		self.talk:setContentSize(cc.size(var_144_3 + 40, var_144_4 + 37))
		self.talk:setAnchorPoint(cc.p(0.5, 0.5))
		var_144_2:setPosition(cc.p(self.talk:getContentSize().width / 2, self.talk:getContentSize().height / 2 - 8))
		var_144_2:setName("label_talk")
		self:addChild(self.talk, 999)
		self.talk:addChild(var_144_2, 3)
		self.talk:setName("talkLabel")
	else
		self.talk:getChildByName("label_talk"):removeFromParent()
		var_144_2:setName("label_talk")
		self.talk:addChild(var_144_2, 3)
		self.talk:setContentSize(cc.size(var_144_3 + 40, var_144_4 + 37))
		var_144_2:setPosition(cc.p(self.talk:getContentSize().width / 2, self.talk:getContentSize().height / 2 - 8))
		self.talk:setVisible(true)
	end

	self.talk:setPosition(cc.p(320, 658))
	self.talk:runAction(cc.Sequence:create(cc.DelayTime:create(3), cc.Hide:create()))
end

function SoulsLayer.animationComponentSuit(arg_145_0, arg_145_1)
	local var_145_0 = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "ComponentSuit.json" or "ComponentSuit.ExportJson")

	var_145_0:setPositionY(GameDisplay.fix_y)
	var_145_0:setContentSize(cc.size(640, GameDisplay.height))
	global_basic_scene:addChild(var_145_0, 999)
	LayerManager:createFullScreenMask(var_145_0, 180, function(arg_146_0, arg_146_1)
		if arg_146_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_145_0:runAction(cc.RemoveSelf:create())
	end)

	local var_145_1 = ccui.Helper:seekWidgetByName(var_145_0, "image_bg")
	local var_145_2 = ccui.Helper:seekWidgetByName(var_145_0, "image_component1")
	local var_145_3 = ccui.Helper:seekWidgetByName(var_145_0, "image_component3")

	var_145_2:loadTexture(arg_145_1.suit[1])
	ccui.Helper:seekWidgetByName(var_145_0, "image_component2"):loadTexture(arg_145_1.suit[2])
	var_145_3:loadTexture(arg_145_1.suit[3])
	ccui.Helper:seekWidgetByName(var_145_0, "label_title"):setString(arg_145_1.labels.title)
	ccui.Helper:seekWidgetByName(var_145_0, "label_effect"):setString(arg_145_1.labels.effect)
	var_145_1:setPosition(cc.p(320, 568))
	var_145_1:setOpacity(0)
	var_145_1:setScale(1, 0.001)
	audio_manager:playeffectMusicTest("sound/equip_suit")
	var_145_1:runAction((cc.Sequence:create(cc.Blink:create(0.15, 1), cc.Spawn:create(cc.FadeIn:create(0.1), cc.ScaleTo:create(0.1, 1, 1)), cc.CallFunc:create(function()
		var_145_2:runAction(cc.MoveBy:create(0.5, cc.p(0, -20)))
		var_145_3:runAction(cc.MoveBy:create(0.5, cc.p(0, 20)))
	end), cc.DelayTime:create(3.5), cc.Spawn:create(cc.Sequence:create(cc.FadeTo:create(0.1, 20), cc.Blink:create(0.15, 1)), cc.ScaleTo:create(0.1, 1, 0.001)), cc.CallFunc:create(function()
		var_145_0:runAction(cc.RemoveSelf:create())
	end))))
end

function SoulsLayer.servantIsPatrolComplete(arg_149_0, arg_149_1)
	local var_149_0 = patrol_manager:getPatrolInfoByServantid()

	return var_149_0 and var_149_0.time <= 0 or false
end

function SoulsLayer.updateNewServantAlert(arg_150_0, arg_150_1)
	playermodel:playerOpenNewServant(arg_150_1)
	alert_manager:check_new_servant(false)
end

function SoulsLayer.openAllNewServant(arg_151_0)
	return
end

function SoulsLayer:getShowStat()
	if self.displayType == "attr" then
		return 1
	else
		return 2
	end
end

function SoulsLayer.updateGuide(arg_153_0)
	GuideListener.cleanCurGuides()
	GuideListener.swallowEvent(false)
	GuideListener.lockGuideTrigger(false)
	GuideListener.updateGuides(arg_153_0)
end

function SoulsLayer:initDisplayValue(arg_154_1)
	self.displayPos = global_get_node_display_posy(arg_154_1, {
		Panel_operationArea = {
			posY = 680,
			focusName = "Panel_operationArea",
			reference = TRANSFORM_REFERENCE.DOWN,
			unit = TRANSFORM_UNIT.PX
		},
		Panel_equip = {
			posY = 0,
			focusName = "Panel_equip",
			reference = TRANSFORM_REFERENCE.DOWN,
			unit = TRANSFORM_UNIT.PX
		},
		Panel_weaponview = {
			posY = 0,
			focusName = "Panel_weaponview",
			reference = TRANSFORM_REFERENCE.DOWN,
			unit = TRANSFORM_UNIT.PX
		},
		Panel_bottom = {
			posY = 0,
			focusName = "Panel_bottom",
			reference = TRANSFORM_REFERENCE.DOWN,
			unit = TRANSFORM_UNIT.PX
		},
		Panel_status = {
			posY = 50,
			focusName = "Panel_status",
			reference = TRANSFORM_REFERENCE.DOWN,
			unit = TRANSFORM_UNIT.PX
		},
		Panel_name = {
			posY = 197,
			focusName = "Panel_name",
			reference = TRANSFORM_REFERENCE.UP,
			unit = TRANSFORM_UNIT.PX
		}
	})

	for iter_154_0, iter_154_1 in pairs(self.displayPos) do
		local var_154_0 = ccui.Helper:seekWidgetByName(arg_154_1, iter_154_0)

		if var_154_0 then
			var_154_0:setPositionY(iter_154_1)
		end
	end
end

function SoulsLayer:createMoveLayer(...)
	self.moveTouchLayer = ccui.Layout:create()

	self.moveTouchLayer:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	self.moveTouchLayer:setPositionY(-GameDisplay.fix_y)
	self.moveTouchLayer:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	self.rootLayer:addChild(self.moveTouchLayer, 9999)

	local var_155_0 = cc.EventListenerTouchOneByOne:create()

	var_155_0:registerScriptHandler(function(arg_156_0, arg_156_1)
		var_155_0:setSwallowTouches(false)

		return true
	end, cc.Handler.EVENT_TOUCH_BEGAN)
	var_155_0:registerScriptHandler(function(arg_157_0, arg_157_1)
		local var_157_0 = self.moveTouchLayer:convertToNodeSpace(arg_157_0:getStartLocation())
		local var_157_1 = self.moveTouchLayer:convertToNodeSpace(arg_157_0:getLocation())

		if self.isEquipLayerShowAll then
			return
		end

		if math.abs(var_157_0.x - var_157_1.x) > 280 then
			var_155_0:setSwallowTouches(true)

			local var_157_2

			for iter_157_0, iter_157_1 in pairs(self.soulidList) do
				if iter_157_1 == self.curSoul then
					var_157_2 = iter_157_0
				end
			end

			self.curSoul = var_157_0.x > var_157_1.x and (var_157_2 == #self.soulidList and self.soulidList[1] or self.soulidList[var_157_2 + 1]) or var_157_2 == 1 and self.soulidList[#self.soulidList] or self.soulidList[var_157_2 - 1]
			global_last_select_servant = self.curSoul

			if self.isEquipLayerShowAll then
				return
			end

			self:updateNewServantAlert(self.curSoul)
			self:onChangeRole()
		else
			var_155_0:setSwallowTouches(false)
		end
	end, cc.Handler.EVENT_TOUCH_ENDED)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(var_155_0, self.moveTouchLayer)
end

function SoulsLayer:updateShowgirlLayer()
	local var_158_0 = global_get_servant_skin(self.curSoul)

	;(function()
		local var_159_0 = 1

		if model_data[var_158_0].is_own_full_screen_background == 1 then
			var_159_0 = 2
		end

		local var_159_1 = model_data[var_158_0].backgroundid_main or 6300034

		if self.backGroundLayer ~= nil then
			self.backGroundLayer:update(var_159_1, var_159_0)
		else
			self.backGroundLayer = BackGroundLayer:create(var_159_1, var_159_0)

			self:addChild(self.backGroundLayer, -10)
		end
	end)()

	if not self.showgirlLayer then
		self.showgirlLayer = ShowGirlLayer:create(var_158_0, 5)

		self.showgirlLayer:setPositionY(math.min(GameDisplay.fix_y - 208, 0))
		self.rootLayer:addChild(self.showgirlLayer)

		self.showgirlLayerMask = ccui.ImageView:create("EquipLayer/showgirlLayerMask.png", var_0_43)

		self.showgirlLayerMask:setScale9Enabled(true)
		self.showgirlLayerMask:setCapInsets(cc.rect(315, 563, 10, 10))
		self.showgirlLayerMask:setContentSize(GameDisplay.size)
		self.showgirlLayerMask:setPositionY(GameDisplay.size.height / 2 - GameDisplay.fix_y)
		self.showgirlLayerMask:setPositionX(320)
		self.rootLayer:addChild(self.showgirlLayerMask)
	end

	self.showgirlLayer:update(var_158_0, nil)
end

function SoulsLayer:initBtnGet()
	if self.previewPanel:getChildByName("btn_file") then
		self.previewPanel:getChildByName("btn_file"):removeFromParent()
	end

	local var_160_0 = ccui.Button:create("EquipLayer/btn_file.png", "EquipLayer/btn_file.png", "EquipLayer/btn_file.png", var_0_43)

	var_160_0:setName("btn_file")
	var_160_0:setPosition(cc.p(595, 480))
	var_160_0:addTouchEventListener(function(arg_161_0, arg_161_1)
		local var_161_0

		if arg_161_1 ~= ccui.TouchEventType.ended then
			do return end

			var_161_0 = {
				PhotoFileLayer = 1,
				id = model_data[servant_data[self.curSoul].modelid].photofile_model
			}
		end

		var_161_0.modelid = servant_data[self.curSoul].modelid
		var_161_0.contentType = {
			contentType = "file_player"
		}

		LayerManager:pushInLayer("PhotoFileRoleFileLayer", var_161_0)
	end)
	self.previewPanel:addChild(var_160_0)

	self.btn_file = var_160_0
	self.btnGet = ccui.Button:create("EquipLayer/btn_get.png", nil, "EquipLayer/btn_get.png", var_0_43)

	self.btnGet:setPosition(self.btn_file:getPositionX(), self.btn_file:getPositionY() + self.btnGet:getContentSize().height)
	self.previewPanel:addChild(self.btnGet)
	self.btnGet:setVisible(not playermodel.haveServant[self.curSoul])
	Utility:addClickEventListener(self.btnGet, function()
		for iter_162_0, iter_162_1 in ipairs((Utility:parseDataByElement(item_data[servant_data[self.curSoul].itemid], {
			{
				index = "targetlayer",
				name = "roleJump"
			},
			{
				index = "targetlayer_starttime",
				name = "startTime",
				hyphen = "_"
			},
			{
				index = "targetlayer_finishtime",
				name = "endTime",
				hyphen = "_"
			}
		}))) do
			if tonumber(iter_162_1.roleJump) and Utility:isTimeRangeValid(iter_162_1.startTime, iter_162_1.endTime) or tonumber(iter_162_1.roleJump) and not iter_162_1.startTime and not iter_162_1.endTime then
				Utility:executeLayerJump({
					systemid = tonumber(iter_162_1.roleJump)
				})

				return
			end
		end

		global_ShowBlockWords("暂时没有获取该角色的途径")
	end)

	self.btnDormRoom = ccui.Button:create("EquipLayer/btn_dormroom.png", nil, "EquipLayer/btn_dormroom.png", var_0_43)

	self.btnDormRoom:setPosition(self.btnGet:getPositionX(), self.btnGet:getPositionY() + 180)
	self.previewPanel:addChild(self.btnDormRoom)
	self.btnDormRoom:setVisible(self.showtype == SHOW_TYPE_TWISTEGG_PREVIEW or not playermodel.haveServant[self.curSoul])
	self.btnDormRoom:addTouchEventListener(function(arg_163_0, arg_163_1)
		if arg_163_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("DormRoomPopLayer", {
			curShowPanel = "Panel_dress",
			soulid = servant_data[self.curSoul].major,
			servantid = self.curSoul,
			exitCallback = function(...)
				if not var_0_54 then
					return
				end

				self:updateShowgirlLayer()
				self:updateOperationAreaPanel()
			end
		})
	end)
end

function SoulsLayer:onChangeRole(...)
	self:updateGirlDate()
	self:updateNamePanel()

	self.effectid = next(self.roleInfos[self.curSoul].effects) ~= nil and playermodel.component[self.curSoul][1].id or nil

	local var_165_0 = self.displayType

	if not self.btnGet then
		self:initBtnGet()
	end

	if playermodel.haveServant[self.curSoul] then
		self.soulUnLock = true
		self.displayType = "attr"

		self.btnGet:setVisible(false)
		self.btnDormRoom:setVisible(false)
	else
		self.soulUnLock = false
		self.displayType = "preview"

		self.btnGet:setVisible(true)
		self.btnDormRoom:setVisible(true)
	end

	self:updateGuide()

	if self.soulUnLock == true then
		if var_165_0 ~= self.displayType then
			self:changeShowType("attr")
		else
			self:changeShowType()
		end
	elseif var_165_0 ~= self.displayType then
		self:changeShowType("preview")
	else
		self:changeShowType()
	end

	self:runAction(cc.Sequence:create(cc.DelayTime:create(var_0_50 / 2), cc.CallFunc:create(function()
		self:updateStatusPanel()
		self:updateOperationAreaPanel()
		self:updatePreviewDownPanel()
		self:updateWeaponPanel()
		self:updateComponentPanel()
		self:updateContract()
		self:updateLevelPanel()
		self:updateShowgirlLayer()
		self:updateDevourLayout()
	end)))
end

function SoulsLayer:updateNamePanel(...)
	if not self.namePanel then
		self.namePanel = ccui.Helper:seekWidgetByName(self.infoPanel, "Panel_name")

		self.namePanel:setTouchEnabled(true)
		self.namePanel:addTouchEventListener(function(arg_168_0, arg_168_1)
			if arg_168_1 ~= ccui.TouchEventType.ended then
				return
			end

			if self.switchModeFin == false then
				return
			end

			if self.bottomBtnState == var_0_48 then
				self.infoPanel:getChildByName("Panel_bottom"):setVisible(true)
			end

			self.statusPanel:getChildByName("Button_skillBtn"):setBright(true)

			self.switchModeFin = false

			arg_168_0:runAction(cc.Sequence:create(cc.DelayTime:create(var_0_50), cc.CallFunc:create(function()
				self.switchModeFin = true
			end)))

			if playermodel.haveServant[self.curSoul] then
				self.displayType = self.displayType ~= "preview" and "preview" or "attr"

				self:updateGuide()
				self:changeShowType(self.displayType)
			end

			self:updateOperationAreaPanel()
		end)

		self.nameFont = cc.Label:createWithTTF("", FONT_NAME, 54)

		self.nameFont:setPositionX((self.namePanel:getChildByName("Label_soulName"):getPositionX()))
		self.nameFont:setPositionY(self.namePanel:getChildByName("Label_soulName"):getPositionY() + 3)
		self.nameFont:setAnchorPoint(cc.p(0, 0.5))
		self.nameFont:setName("fightCapacityFont")
		self.namePanel:addChild(self.nameFont)
		self.namePanel:getChildByName("Image_career"):addTouchEventListener(function(arg_170_0, arg_170_1)
			local var_170_0

			if arg_170_1 ~= ccui.TouchEventType.ended then
				do return end

				var_170_0 = {}
			end

			var_170_0.tips = {
				"mainScenebg/guide/16.jpg",
				"mainScenebg/guide/23.jpg",
				"mainScenebg/guide/24.jpg",
				"mainScenebg/guide/25.jpg",
				"mainScenebg/guide/26.jpg",
				"mainScenebg/guide/27.jpg",
				"mainScenebg/guide/28.jpg",
				"mainScenebg/guide/29.jpg"
			}

			LayerManager:pushInLayer("TipsLayer", var_170_0)
		end)
	end

	local var_167_0 = souls_manager:get_servant_cur_roll_rarity(self.curSoul)
	local var_167_1 = global_get_all_model_attrs(servant_data[self.curSoul].modelid)
	local var_167_2 = var_167_1.main

	if var_167_1.sub and next(var_167_1.sub) then
		for iter_167_0, iter_167_1 in ipairs(var_167_1.sub) do
			var_167_2 = var_167_2 .. "_" .. iter_167_1
		end
	end

	self.namePanel:getChildByName("Label_soulName"):setString("")
	self.nameFont:setString(major_factor_data[servant_data[self.curSoul].major].easy_name)
	self.namePanel:getChildByName("Image_rarity"):loadTexture(RARITY_LONG_LONG_ICON[var_167_0], var_0_43)
	self.namePanel:getChildByName("Image_career"):loadTexture(CAREER_ICON[servant_data[self.curSoul].career .. "_" .. var_167_2], var_0_43)
	self.namePanel:getChildByName("Image_name_bg"):getChildByName("career"):loadTexture(var_0_44[SERVANT_CAREE_TBL[model_data[servant_data[self.curSoul].modelid].career]], var_0_43)
	self.namePanel:getChildByName("Label_servantName"):setString(string.match(servant_data[self.curSoul].name, "【(.+)】"))
	self.namePanel:getChildByName("Label_majorEnglishName"):setString(favorfile_data[23][model_data[servant_data[self.curSoul].modelid].photofile_model] or "")
end

function SoulsLayer:initStatusPanel(...)
	self.statusPanel = ccui.Helper:seekWidgetByName(self.infoPanel, "Panel_status")

	self.statusPanel:setPositionX(0)
	self.statusPanel:runAction(cc.MoveTo:create(var_0_50, cc.p(0, self.statusPanel:getPositionY())))

	if self.displayType == "attr" then
		self.statusPanel:setPositionX(-400)
		self.statusPanel:runAction(cc.MoveTo:create(0.2, cc.p(0, self.statusPanel:getPositionY())))
	end

	self.statusPanel:getChildByName("Button_skillBtn"):addTouchEventListener(function(arg_172_0, arg_172_1)
		if arg_172_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.moveEndFlag == false then
			return
		end

		if not arg_172_0:isBright() then
			fun(arg_172_0, arg_172_1)

			return
		end

		LayerManager:pushInLayer("PopskillDetailLayer", {
			servantid = self.curSoul
		})
	end)
	ccui.Helper:seekWidgetByName(self.statusPanel, "Button_fightCapacity"):addTouchEventListener(function(arg_173_0, arg_173_1)
		if arg_173_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopEquipAttrLayer", {
			servantid = self.curSoul
		})
	end)
end

function SoulsLayer:initDevourLayout()
	self.statusPanel = ccui.Helper:seekWidgetByName(self.infoPanel, "Panel_status")

	ccui.Helper:seekWidgetByName(self.statusPanel, "Button_devour"):addTouchEventListener(function(arg_175_0, arg_175_1)
		if arg_175_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not level_manager:isPlayerPassLevel(UNLOCK_HORCRUX) then
			global_ShowBlockWords(string.format(L_LAYER_UNLOCKED, (level_manager:formatSystemUnlockLevel(UNLOCK_HORCRUX))))

			return
		end

		if playermodel.haveServant[self.curSoul] then
			LayerManager:pushInLayer("HorcruxDevourLayer", {
				servantId = self.curSoul
			})
		end
	end)
	ccui.Helper:seekWidgetByName(self.statusPanel, "Button_devour"):getChildByName("Image_36_0"):getChildByName("Label_65"):setString(L_HORCRUX_DEVOUR[1])
	self:updateDevourLayout()
end

function SoulsLayer:updateStatusPanel(...)
	local var_176_0 = var_0_23:getAttrBonus(self.curSoul)

	for iter_176_0 = 1, 5 do
		if iter_176_0 == 1 then
			ccui.Helper:seekWidgetByName(self.statusPanel, "Label_name_" .. iter_176_0):setString(var_0_47[iter_176_0])
			ccui.Helper:seekWidgetByName(self.statusPanel, "Label_value_" .. iter_176_0):setString(fight_capacity_manager:getSoulFightCapacity(self.curSoul, "number"))
		else
			local var_176_1 = self.roleInfos[self.curSoul].model:getAttribute(var_0_46[iter_176_0 - 1])

			if iter_176_0 == 2 or iter_176_0 == 3 then
				var_176_1 = var_176_1 + var_176_0[var_0_46[iter_176_0 - 1]]
			end

			if var_176_1 > 1000 then
				var_176_1 = global_trans_number(var_176_1)
			end

			ccui.Helper:seekWidgetByName(self.statusPanel, "Label_name_" .. iter_176_0):setString(var_0_47[iter_176_0])
			ccui.Helper:seekWidgetByName(self.statusPanel, "Label_value_" .. iter_176_0):setString(var_176_1)
			ccui.Helper:seekWidgetByName(self.statusPanel, "Label_name_" .. iter_176_0 .. "_shadow"):setString(var_0_47[iter_176_0])
			ccui.Helper:seekWidgetByName(self.statusPanel, "Label_value_" .. iter_176_0 .. "_shadow"):setString(var_176_1)
		end
	end

	local var_176_2 = 76

	ccui.Helper:seekWidgetByName(self.statusPanel, "Panel_skill_1"):getChildByName("Image_skillIcon"):loadTexture("skill_new/skill/" .. total_skill_data[model_data[servant_data[self.curSoul].modelid].XP].icon .. ".png", var_0_43)
	ccui.Helper:seekWidgetByName(self.statusPanel, "Panel_skill_1"):getChildByName("Image_skillIcon"):setScale(0.54)
	ccui.Helper:seekWidgetByName(self.statusPanel, "Panel_skill_1"):getChildByName("Label_skillName"):setString(total_skill_data[model_data[servant_data[self.curSoul].modelid].XP].name)

	local var_176_3 = model_data[servant_data[self.curSoul].modelid]["skill1_" .. playermodel.skill1Level[self.curSoul]] or 206201

	ccui.Helper:seekWidgetByName(self.statusPanel, "Panel_skill_2"):getChildByName("Image_skillIcon"):loadTexture("skill_new/skill/" .. total_skill_data[var_176_3].icon .. ".png", var_0_43)
	ccui.Helper:seekWidgetByName(self.statusPanel, "Panel_skill_2"):getChildByName("Image_skillIcon"):setScale(0.54)
	ccui.Helper:seekWidgetByName(self.statusPanel, "Panel_skill_2"):getChildByName("Label_skillName"):setString(total_skill_data[var_176_3].name)
	ccui.Helper:seekWidgetByName(self.statusPanel, "Panel_skill_3"):getChildByName("Image_skillIcon"):loadTexture("skill_new/skill/" .. total_skill_data[model_data[servant_data[self.curSoul].modelid].passive].icon .. ".png", var_0_43)
	ccui.Helper:seekWidgetByName(self.statusPanel, "Panel_skill_3"):getChildByName("Image_skillIcon"):setScale(0.54)
	ccui.Helper:seekWidgetByName(self.statusPanel, "Panel_skill_3"):getChildByName("Label_skillName"):setString(total_skill_data[model_data[servant_data[self.curSoul].modelid].passive].name)
	ccui.Helper:seekWidgetByName(self.statusPanel, "Panel_skill_4"):getChildByName("Image_skillIcon"):loadTexture("skill_new/skill/" .. total_skill_data[model_data[servant_data[self.curSoul].modelid].sp].icon .. ".png", var_0_43)
	ccui.Helper:seekWidgetByName(self.statusPanel, "Panel_skill_4"):getChildByName("Image_skillIcon"):setScale(0.54)
	ccui.Helper:seekWidgetByName(self.statusPanel, "Panel_skill_4"):getChildByName("Label_skillName"):setString(total_skill_data[model_data[servant_data[self.curSoul].modelid].sp].name)

	local var_176_4 = ccui.Helper:seekWidgetByName(self.statusPanel, "Panel_skill_1"):getChildByName("Label_skillName"):getContentSize().width
	local var_176_5 = ccui.Helper:seekWidgetByName(self.statusPanel, "Panel_skill_1"):getChildByName("Label_skillName").setScaleX

	ccui.Helper:seekWidgetByName(self.statusPanel, "Panel_skill_1"):getChildByName("Label_skillName"):setScaleX((var_176_2 < var_176_4 or nil) and (var_176_2 / var_176_4 or 1))

	local var_176_6 = ccui.Helper:seekWidgetByName(self.statusPanel, "Panel_skill_2"):getChildByName("Label_skillName"):getContentSize().width
	local var_176_7 = ccui.Helper:seekWidgetByName(self.statusPanel, "Panel_skill_2"):getChildByName("Label_skillName").setScaleX

	ccui.Helper:seekWidgetByName(self.statusPanel, "Panel_skill_2"):getChildByName("Label_skillName"):setScaleX((var_176_2 < var_176_6 or nil) and (var_176_2 / var_176_6 or 1))

	local var_176_8 = ccui.Helper:seekWidgetByName(self.statusPanel, "Panel_skill_3"):getChildByName("Label_skillName"):getContentSize().width
	local var_176_9 = ccui.Helper:seekWidgetByName(self.statusPanel, "Panel_skill_3"):getChildByName("Label_skillName").setScaleX

	ccui.Helper:seekWidgetByName(self.statusPanel, "Panel_skill_3"):getChildByName("Label_skillName"):setScaleX((var_176_2 < var_176_8 or nil) and (var_176_2 / var_176_8 or 1))

	local var_176_10 = ccui.Helper:seekWidgetByName(self.statusPanel, "Panel_skill_4"):getChildByName("Label_skillName"):getContentSize().width
	local var_176_11 = ccui.Helper:seekWidgetByName(self.statusPanel, "Panel_skill_4"):getChildByName("Label_skillName").setScaleX

	ccui.Helper:seekWidgetByName(self.statusPanel, "Panel_skill_4"):getChildByName("Label_skillName"):setScaleX((var_176_2 < var_176_10 or nil) and (var_176_2 / var_176_10 or 1))
end

function SoulsLayer:updateLevelPanel(...)
	if not self.levelPanel then
		self.levelPanel = ccui.Helper:seekWidgetByName(self.attrDownPanel, "Panel_level")

		self.levelPanel:getChildByName("Button_breakLimitBtn"):addTouchEventListener(function(arg_178_0, arg_178_1)
			local var_178_0

			if arg_178_1 ~= ccui.TouchEventType.ended then
				do return end

				var_178_0 = {}
			end

			function var_178_0.levelUpCallback()
				self:updateGirlDate()
				self:updateStatusPanel()
				self:updateLevelPanel()
			end

			function var_178_0.resetCallback()
				self:updateGirlDate()
				self:updateStatusPanel()
				self:updateLevelPanel()
			end

			var_178_0.servantid = self.curSoul
			var_178_0.goto_back_system_id = self:getCurSystemId()

			function var_178_0.exitCallback()
				self:updateEquipLayerCallback()
			end

			LayerManager:pushInLayer("SoulStrengthLayer", var_178_0)
		end)
		self.levelPanel:getChildByName("Button_breakOut"):addTouchEventListener(self:getBreakOutHandel())
		self.levelPanel:getChildByName("Button_breakLimitBtn"):getChildByName("Image_53"):setVisible(core_manager:getCoreLv(self.curSoul) < 400)
		ccui.Helper:seekWidgetByName(self.levelPanel, "Image_breakoutIcon"):addTouchEventListener(function(arg_182_0, arg_182_1)
			if arg_182_1 ~= ccui.TouchEventType.ended then
				return
			end

			local var_182_0 = servant_data[self.curSoul].modelid
			local var_182_1 = model_data[var_182_0]["ex_" .. ((core_manager:getServantCoreRank(self.curSoul) > SERVANT_CORE_BREAK_MAX or nil) and (SERVANT_CORE_BREAK_MAX or core_manager:getServantCoreRank(self.curSoul)))]

			if not model_data[var_182_0]["ex_" .. ((core_manager:getServantCoreRank(self.curSoul) > SERVANT_CORE_BREAK_MAX or nil) and (SERVANT_CORE_BREAK_MAX or core_manager:getServantCoreRank(self.curSoul)))] then
				var_182_1 = model_data[var_182_0].ex_1
			end

			if not var_182_1 then
				return
			end

			local var_182_2 = ccui.Layout:create()

			var_182_2:setTouchEnabled(true)
			var_182_2:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
			var_182_2:setAnchorPoint(cc.p(0.5, 0.5))
			var_182_2:setPosition(cc.p(GameDisplay.width / 2, GameDisplay.height / 2))
			var_182_2:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
			var_182_2:setBackGroundColor(cc.c3b(0, 0, 0))
			var_182_2:setBackGroundColorOpacity(180)
			var_182_2:addTouchEventListener(function(arg_183_0, arg_183_1)
				if arg_183_1 ~= ccui.TouchEventType.ended then
					return
				end

				var_182_2:runAction(cc.RemoveSelf:create())
			end)
			;(function()
				local var_184_0 = ccui.ImageView:create("EquipLayer/skill_des_bg.png", var_0_43)

				var_184_0:setPosition(cc.p(320, 672))
				var_184_0:setAnchorPoint(cc.p(0.5, 0.5))
				var_182_2:addChild(var_184_0)

				local var_184_1 = ccui.Layout:create()

				var_184_1:setContentSize(cc.size(500, 124))
				var_184_1:setAnchorPoint(cc.p(0, 0))
				var_184_1:setPosition(cc.p(70, 600))
				var_184_1:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
				var_184_1:setBackGroundColor(cc.c3b(0, 0, 0))
				var_184_1:setBackGroundColorOpacity(0)
				var_182_2:addChild(var_184_1, 2)

				local var_184_2 = ccui.ImageView:create("EquipLayer/normal_skill_frame.png", var_0_43)

				var_184_2:setPosition(cc.p(58, 63))
				var_184_2:setAnchorPoint(cc.p(0.5, 0.5))
				var_184_1:addChild(var_184_2)

				local var_184_3 = ccui.ImageView:create("skill_new/skill/ex" .. core_manager:getServantCoreRank(self.servantid) .. ".png", var_0_43)

				var_184_3:setScale(0.88)
				var_184_3:setPosition(cc.p(58, 63))
				var_184_1:addChild(var_184_3)

				local var_184_4 = cc.Label:createWithTTF(total_skill_data[var_182_1].name, FONT_DES, 24)

				var_184_4:setAnchorPoint(cc.p(0, 0.5))
				var_184_4:setPosition(cc.p(121, 96))
				var_184_1:addChild(var_184_4)

				if total_skill_data[var_182_1].cd then
					local var_184_5 = {
						nil,
						nil,
						nil,
						"超快",
						"快",
						"標準"
					}
					local var_184_6 = cc.Label:createWithTTF(L_SKILL_CD .. ":" .. (var_184_5[var_0_33[var_182_1].cd] or var_184_5[6]), FONT_DES, 20)

					var_184_6:setAnchorPoint(cc.p(1, 0.5))
					var_184_6:setPosition(cc.p(473, 96))
					var_184_1:addChild(var_184_6)
				end

				local var_184_7 = transSkillDesToRichText(total_skill_data[var_182_1].description)
				local var_184_8 = RichTextPro:create()

				var_184_8:setMaxWidth(380)
				var_184_8:setSize(20)
				var_184_8:setColor(cc.c3b(220, 251, 241))
				var_184_8:setLineSpace(0)
				var_184_8:setText(var_184_7)
				var_184_8:setName("richText")
				var_184_8:setPosition(cc.p(120, 86))
				var_184_1:addChild(var_184_8)
			end)()
			global_basic_scene:addChild(var_182_2, 10000)
		end)

		if self.displayType == "attr" then
			self.levelPanel:setPositionX(-400)
			self.levelPanel:runAction(cc.MoveTo:create(0.2, cc.p(0, self.levelPanel:getPositionY())))
		end
	end

	self.levelPanel:getChildByName("Button_breakLimitBtn"):getChildByName("Label_level"):setString(core_manager:getCoreLv(self.curSoul))

	local var_177_0 = core_manager:getServantCoreRank(self.curSoul)

	ccui.Helper:seekWidgetByName(self.levelPanel, "Image_breakoutIcon"):loadTexture("public/rolebg/breakout_" .. var_177_0 .. ".png", var_0_43)

	if var_177_0 >= SERVANT_CORE_BREAK_MAX then
		ccui.Helper:seekWidgetByName(self.levelPanel, "Button_breakOut"):loadTextures("EquipLayer/btn_coreadvance.png", nil, "EquipLayer/btn_coreadvance.png", var_0_43)
	else
		ccui.Helper:seekWidgetByName(self.levelPanel, "Button_breakOut"):loadTextures("EquipLayer/btn_breakout.png", nil, "EquipLayer/btn_breakout.png", var_0_43)
	end

	ccui.Helper:seekWidgetByName(self.levelPanel, "Button_breakOut"):getChildByName("Image_redDot"):setVisible((core_manager:isTipsBreakOut(self.curSoul)))
end

function SoulsLayer:updateContract(...)
	if not self.contractPanel then
		self.contractPanel = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_contract")

		ccui.Helper:seekWidgetByName(self.rootLayer, "Button_contract"):addTouchEventListener(function(arg_186_0, arg_186_1)
			if arg_186_1 ~= ccui.TouchEventType.ended then
				return
			end

			if not playermodel.haveServant[self.curSoul] then
				return
			end

			self:showServantBreakLimit()
			AnalyticManager.clickBtnContract()
		end)
	end

	ccui.Helper:seekWidgetByName(self.rootLayer, "Button_contract"):getChildByName("Image_redPoint"):setVisible(core_manager:isBreakLimit(self.curSoul))

	local var_185_0 = global_get_servant_skin(self.curSoul)
	local var_185_1 = core_manager:oc_pre_resonance_level(self.curSoul)
	local var_185_3 = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_contract")

	if souls_manager:check_is_can_avance_with_material(self.curSoul) then
		ccui.Helper:seekWidgetByName(self.rootLayer, "Button_contract"):loadTextures("EquipLayer/btn_avance.png", "EquipLayer/btn_avance.png", "EquipLayer/btn_avance.png", var_0_43)
	elseif souls_manager:check_is_can_OC_with_material(self.curSoul) then
		ccui.Helper:seekWidgetByName(self.rootLayer, "Button_contract"):loadTextures("EquipLayer/btn_overclock.png", "EquipLayer/btn_overclock.png", "EquipLayer/btn_overclock.png", var_0_43)
	else
		local var_185_4 = playermodel.soulOverClock[self.curSoul] or 0

		if playermodel.soulContract[self.curSoul] < 1 then
			ccui.Helper:seekWidgetByName(self.rootLayer, "Button_contract"):loadTextures("EquipLayer/btn_upclass.png", "EquipLayer/btn_upclass.png", "EquipLayer/btn_upclass.png", var_0_43)
		else
			ccui.Helper:seekWidgetByName(self.rootLayer, "Button_contract"):loadTextures("EquipLayer/btn_upclass_" .. playermodel.soulContract[self.curSoul] .. ".png", "EquipLayer/btn_upclass_" .. playermodel.soulContract[self.curSoul] .. ".png", "EquipLayer/btn_upclass_" .. playermodel.soulContract[self.curSoul] .. ".png", var_0_43)
		end

		if var_185_4 > 0 then
			ccui.Helper:seekWidgetByName(self.rootLayer, "Button_contract"):loadTextures("EquipLayer/btn_upclass_oc.png", "EquipLayer/btn_upclass_oc.png", "EquipLayer/btn_upclass_oc.png", var_0_43)
		end
	end

	self:updateUpgradePanel()
end

function SoulsLayer:changeShowType(arg_187_1)
	self.levelPanel:setVisible(true)
	self.componentPanel:setVisible(true)
	self.weaponPanel:setVisible(true)

	if arg_187_1 == "preview" then
		self.infoPanel:getChildByName("Panel_equip"):runAction(cc.MoveTo:create(var_0_50 * 1.1, cc.p(-704, (self.infoPanel:getChildByName("Panel_equip"):getPositionY()))))
		self.infoPanel:getChildByName("Panel_weaponview"):setPositionX(640)
		self:updatePreviewDownPanel()
		self.infoPanel:getChildByName("Panel_weaponview"):setPositionY(self.displayPos.Panel_weaponview)
		self.infoPanel:getChildByName("Panel_weaponview"):runAction(cc.MoveTo:create(var_0_50, cc.p(0, (self.infoPanel:getChildByName("Panel_weaponview"):getPositionY()))))
		self.statusPanel:runAction(cc.Sequence:create(cc.MoveTo:create(var_0_50 / 2, cc.p(-400, self.statusPanel:getPositionY())), cc.MoveTo:create(var_0_50 / 2, cc.p(0, self.statusPanel:getPositionY()))))
	elseif arg_187_1 == "attr" then
		self.infoPanel:getChildByName("Panel_weaponview"):runAction(cc.MoveTo:create(var_0_50, cc.p(-640, (self.infoPanel:getChildByName("Panel_weaponview"):getPositionY()))))
		self.infoPanel:getChildByName("Panel_equip"):setPositionX(640)
		self.infoPanel:getChildByName("Panel_equip"):runAction(cc.MoveTo:create(var_0_50, cc.p(0, (self.infoPanel:getChildByName("Panel_equip"):getPositionY()))))
		self.statusPanel:setPositionX(640)
		self.statusPanel:runAction(cc.MoveTo:create(var_0_50, cc.p(0, self.statusPanel:getPositionY())))
		self.operationAreaPanel:setPositionX(800)
		self.operationAreaPanel:runAction(cc.MoveTo:create(var_0_50, cc.p(640, self.operationAreaPanel:getPositionY())))
	else
		self.statusPanel:runAction(cc.Sequence:create(cc.MoveTo:create(var_0_50 / 2, cc.p(-400, self.statusPanel:getPositionY())), cc.MoveTo:create(var_0_50 / 2, cc.p(0, self.statusPanel:getPositionY()))))
		self.operationAreaPanel:runAction(cc.Sequence:create(cc.MoveTo:create(var_0_50 / 2, cc.p(800, self.operationAreaPanel:getPositionY())), cc.MoveTo:create(var_0_50 / 2, cc.p(640, self.operationAreaPanel:getPositionY()))))
		self.namePanel:runAction(cc.Sequence:create(cc.MoveTo:create(var_0_50 / 2, cc.p(-400, self.namePanel:getPositionY())), cc.MoveTo:create(var_0_50 / 2, cc.p(0, self.namePanel:getPositionY()))))

		if self.displayType == "preview" then
			self.levelPanel:setVisible(false)
			self.componentPanel:setVisible(false)
			self.weaponPanel:setVisible(false)
		end

		self.levelPanel:runAction(cc.Sequence:create(cc.MoveTo:create(var_0_50 / 2, cc.p(-400, self.levelPanel:getPositionY())), cc.MoveTo:create(var_0_50 / 2, cc.p(0, self.levelPanel:getPositionY()))))
		self.componentPanel:runAction(cc.Sequence:create(cc.MoveTo:create(var_0_50 / 2, cc.p(800, self.componentPanel:getPositionY())), cc.MoveTo:create(var_0_50 / 2, cc.p(640, self.componentPanel:getPositionY()))))
		self.weaponPanel:runAction(cc.Sequence:create(cc.MoveTo:create(var_0_50 / 2, cc.p(800, self.weaponPanel:getPositionY())), cc.MoveTo:create(var_0_50 / 2, cc.p(460, self.weaponPanel:getPositionY()))))
	end
end

function SoulsLayer:initOperationAreaPanel(...)
	self.operationAreaPanel = ccui.Helper:seekWidgetByName(self.infoPanel, "Panel_operationArea")

	self.operationAreaPanel:setPositionX(800)
	self.operationAreaPanel:runAction(cc.MoveTo:create(var_0_50, cc.p(640, self.operationAreaPanel:getPositionY())))
	self.operationAreaPanel:getChildByName("Button_gotoDorm"):getChildByName("Button_changeSkin"):addTouchEventListener(function(arg_189_0, arg_189_1)
		if arg_189_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arenatft_manager:getLayerBtnLock() then
			global_ShowBlockWords(L_TVT_FIGHT_BTN_LOCK)

			return
		end

		LayerManager:pushInLayer("DormRoomPopLayer", {
			curShowPanel = "Panel_dress",
			soulid = servant_data[self.curSoul].major,
			servantid = self.curSoul,
			exitCallback = function(...)
				if not var_0_54 then
					return
				end

				self:updateShowgirlLayer()
				self:updateOperationAreaPanel()
			end
		})
	end)
	self.operationAreaPanel:getChildByName("Button_gotoDorm"):getChildByName("Button_marry"):addTouchEventListener(function(arg_191_0, arg_191_1)
		if arg_191_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arenatft_manager:getLayerBtnLock() then
			global_ShowBlockWords(L_TVT_FIGHT_BTN_LOCK)

			return
		end

		LayerManager:pushInLayer("DormRoomPopLayer", {
			curShowPanel = "Panel_gift",
			soulid = servant_data[self.curSoul].major,
			servantid = self.curSoul,
			exitCallback = function(...)
				if not var_0_54 then
					return
				end

				self:updateShowgirlLayer()
				self:updateOperationAreaPanel()
			end
		})
	end)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Button_info"):addTouchEventListener(function(arg_193_0, arg_193_1)
		if arg_193_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.soulUnLock == false then
			return
		end

		if self.switchModeFin == false then
			return
		end

		if self.displayType ~= "attr" then
			return
		end

		if not arg_193_0:isBright() then
			return
		end

		arg_193_0:setBright(false)

		self.switchModeFin = false

		arg_193_0:runAction(cc.Sequence:create(cc.DelayTime:create(var_0_50 + var_0_51), cc.CallFunc:create(function()
			self.switchModeFin = true

			arg_193_0:setBright(true)
		end)))
		self:hideView()
	end)

	self.isUseOcSkin = playermodel.servantUsedskin[self.curSoul] == major_factor_data[servant_data[self.curSoul].major].item_oc

	self.operationAreaPanel:getChildByName("Button_useOCSkin"):getChildByName("Label_OCSkinOff"):setString("常\n态")
	self.operationAreaPanel:getChildByName("Button_useOCSkin"):getChildByName("Label_OCSkinOn"):setString("超\n频")
	self.operationAreaPanel:getChildByName("Button_useOCSkin"):addTouchEventListener(function(arg_195_0, arg_195_1)
		if arg_195_1 ~= ccui.TouchEventType.ended then
			return
		end

		if item_manager:getItemNumber(major_factor_data[servant_data[self.curSoul].major].item_oc) > 0 then
			if self.isUseOcSkin then
				playermodel:setServantUsedmodel(self.curSoul, playermodel.dress[servant_data[self.curSoul].major], function(...)
					self.isUseOcSkin = false

					self:updateOperationAreaPanel()
					self:updateShowgirlLayer()
				end)
			else
				playermodel:setServantUsedmodel(self.curSoul, major_factor_data[servant_data[self.curSoul].major].item_oc, function()
					self.isUseOcSkin = true

					self:updateOperationAreaPanel()
					self:updateShowgirlLayer()
				end)
			end
		else
			self:showServantBreakLimit(nil, true)
		end
	end)
	self:updateOperationAreaPanel()
end

function SoulsLayer:updateOperationAreaPanel(...)
	self.operationAreaPanel:setVisible(self.displayType == "attr")

	if servant_data[self.curSoul].oc_isopen1 then
		self.operationAreaPanel:getChildByName("Button_useOCSkin"):setVisible(true)

		if role_switch_data[self.curSoul] and role_switch_data[self.curSoul].overclock_starttime and time_check_manager:getCurTime() < os.time(parse_time(role_switch_data[self.curSoul].overclock_starttime)) then
			self.operationAreaPanel:getChildByName("Button_useOCSkin"):setVisible(false)
		end

		if servant_data[self.curSoul].linkage then
			self.operationAreaPanel:getChildByName("Button_useOCSkin"):setVisible(false)
		end
	else
		self.operationAreaPanel:getChildByName("Button_useOCSkin"):setVisible(false)
	end

	self.isUseOcSkin = playermodel.servantUsedskin[self.curSoul] == major_factor_data[servant_data[self.curSoul].major].item_oc

	if self.isUseOcSkin then
		self.operationAreaPanel:getChildByName("Button_useOCSkin"):getChildByName("Image_OCSkinOff"):setVisible(false)
		self.operationAreaPanel:getChildByName("Button_useOCSkin"):getChildByName("Image_OCSkinOn"):setVisible(true)
	else
		self.operationAreaPanel:getChildByName("Button_useOCSkin"):getChildByName("Image_OCSkinOff"):setVisible(true)
		self.operationAreaPanel:getChildByName("Button_useOCSkin"):getChildByName("Image_OCSkinOn"):setVisible(false)
	end

	if not marry_manager:checkIsMarried(servant_data[self.curSoul].major) and marry_manager:check_marry_flag(servant_data[self.curSoul].major, 2) then
		self.operationAreaPanel:getChildByName("Button_gotoDorm"):getChildByName("Button_marry"):loadTextures("EquipLayer/goto_marry.png", nil, "EquipLayer/goto_marry.png", var_0_43)
	else
		self.operationAreaPanel:getChildByName("Button_gotoDorm"):getChildByName("Button_marry"):loadTextures("EquipLayer/goto_send_gift.png", nil, "EquipLayer/goto_send_gift.png", var_0_43)
	end
end

function SoulsLayer:hideView(...)
	self.statusPanel:runAction(cc.MoveTo:create(var_0_50, cc.p(-400, self.statusPanel:getPositionY())))
	self.namePanel:runAction(cc.MoveTo:create(var_0_50, cc.p(-400, self.namePanel:getPositionY())))
	self.levelPanel:runAction(cc.MoveTo:create(var_0_50, cc.p(-400, self.levelPanel:getPositionY())))
	self.componentPanel:runAction(cc.MoveTo:create(var_0_50, cc.p(800, self.componentPanel:getPositionY())))
	self.weaponPanel:runAction(cc.MoveTo:create(var_0_50, cc.p(800, self.weaponPanel:getPositionY())))
	self.operationAreaPanel:runAction(cc.MoveTo:create(var_0_50, cc.p(800, self.operationAreaPanel:getPositionY())))
	self.infoPanel:getChildByName("Panel_equip"):setVisible(false)

	if LayerManager:getUIElement("TopcostLayer") then
		LayerManager:getUIElement("TopcostLayer"):hideTopcostLayer()
	end

	self.infoPanel:getChildByName("Panel_bottom"):setVisible(false)
	self.showgirlLayerMask:setVisible(false)

	self.isEquipLayerShowAll = true

	self:updateShowgirlLayer()
	LayerManager:pushInLayer("SoulServantInfo", {
		servantid = self.curSoul,
		callback = function()
			self:showView()

			self.isEquipLayerShowAll = false

			self:updateShowgirlLayer()
			self.infoPanel:getChildByName("Panel_bottom"):setVisible(true)
		end
	})
end

function SoulsLayer:showView(...)
	self.statusPanel:runAction(cc.MoveTo:create(var_0_50, cc.p(0, self.statusPanel:getPositionY())))
	self.namePanel:runAction(cc.MoveTo:create(var_0_50, cc.p(0, self.namePanel:getPositionY())))
	self.levelPanel:runAction(cc.MoveTo:create(var_0_50, cc.p(0, self.levelPanel:getPositionY())))
	self.componentPanel:runAction(cc.MoveTo:create(var_0_50, cc.p(640, self.componentPanel:getPositionY())))
	self.weaponPanel:runAction(cc.MoveTo:create(var_0_50, cc.p(460, self.weaponPanel:getPositionY())))
	self.operationAreaPanel:runAction(cc.MoveTo:create(var_0_50, cc.p(640, self.operationAreaPanel:getPositionY())))
	self.infoPanel:getChildByName("Panel_equip"):setVisible(true)

	if LayerManager:getUIElement("TopcostLayer") then
		LayerManager:getUIElement("TopcostLayer"):showTopcostLayer()
	end

	self.showgirlLayerMask:setVisible(true)
	self:updateShowgirlLayer()
end

function SoulsLayer:setInitUiPos(...)
	if self.displayType == "attr" then
		self.infoPanel:getChildByName("Panel_equip"):setPositionX(0)
		self.infoPanel:getChildByName("Panel_weaponview"):setPositionX(640)
	else
		self.infoPanel:getChildByName("Panel_equip"):setPositionX(640)
		self.infoPanel:getChildByName("Panel_weaponview"):setPositionX(640)
		self.infoPanel:getChildByName("Panel_weaponview"):runAction(cc.MoveTo:create(var_0_50, cc.p(0, (self.infoPanel:getChildByName("Panel_weaponview"):getPositionY()))))
	end
end

function SoulsLayer:updateEquipLayerCallback(...)
	if not self.roleInfos[self.curSoul] then
		return
	end

	self:updateGirlDate()

	if self.roleInfos[self.curSoul].fighting then
		FightManager.registerPlayerChangeWeapon()
	end

	self:resetTopCostListButton()
	self:updateStatusPanel()
	self:updateOperationAreaPanel()
	self:updateWeaponPanel()
	self:updateContract()
	self:updateLevelPanel()
end

function SoulsLayer:createDescriptionLayer()
	local var_205_9000
	local l2utils = require("controller.l2utils")
	local var_205_1 = 999

	local function var_205_2()
		local var_206_0 = global_basic_scene:getChildByName("descriptionLayout")
		local var_206_1 = var_206_0:getChildByName("descriptionBg")

		if var_206_1:getActionByTag(var_205_1) then
			return
		end

		local var_206_2 = cc.Spawn:create(cc.EaseBackIn:create(cc.MoveBy:create(0.5, cc.p(0, -70))), cc.Sequence:create(cc.FadeOut:create(0.5), cc.CallFunc:create(function()
			var_206_0:hide()
		end)))

		var_206_2:setTag(var_205_1)
		var_206_1:setOpacity(255)
		var_206_1:align(cc.p(0.5, 0.5), var_206_0:size().w / 2, var_206_0:size().h / 2)
		var_206_1:runAction(var_206_2)
	end

	local var_205_3 = TempWidget:CreateTempBtn("public/button/interrogation_btn.png", var_205_9000)
	local var_205_6 = cc.p(self.operationAreaPanel:getChildByName("Button_useOCSkin").getPosition((self.operationAreaPanel:getChildByName("Button_useOCSkin"):getParent())))

	var_205_6.y = var_205_6.y + self.operationAreaPanel:getChildByName("Button_useOCSkin"):getContentSize().height

	var_205_3:move(var_205_6)
	var_205_3:_addEvent(function()
		l2utils:captureScreenGaussBlur(function(arg_209_0)
			local var_209_0 = global_basic_scene:getChildByName("descriptionLayout")

			if not var_209_0 then
				var_209_0 = TempWidget:CreateTempLayout(global_basic_scene)

				var_209_0:addChild(arg_209_0)
				var_209_0:setName("descriptionLayout")
				var_209_0:setContentSize(GameDisplay.size)
				var_209_0:move(0, 0)
				var_209_0:_addEvent(var_205_2)

				local var_209_1 = TempWidget:CreateTempImg("EquipLayer/role_ description_bg.png", var_209_0)

				var_209_1:setName("descriptionBg")
				var_209_1:align(cc.p(0.5, 0.5), var_209_0:size().w / 2, var_209_0:size().h / 2 - 70)

				local var_209_2 = TempWidget:CreateTempBtn("public/button/role_ description_close_btn.png", var_209_1)

				var_209_2:align(cc.p(0.5, 0.5), var_209_1:size().w - 25, var_209_1:size().h - 10)
				var_209_2:_addEvent(var_205_2)
			end

			var_209_0:show()

			local var_209_3 = var_209_0:getChildByName("descriptionBg")

			var_209_3:stopAllActions()
			var_209_3:align(cc.p(0.5, 0.5), var_209_0:size().w / 2, var_209_0:size().h / 2 - 70)
			var_209_3:setOpacity(0)

			local var_209_4 = cc.Spawn:create(cc.EaseBackOut:create(cc.MoveBy:create(0.5, cc.p(0, 70))), cc.FadeIn:create(0.5))

			var_209_4:setTag(var_205_1)
			var_209_3:runAction(var_209_4)
		end)
	end)
end

function SoulsLayer:updateUpgradeInfo()
	self.upgradeInfo = {}

	local var_210_0 = {
		SR = 2,
		MR = 4,
		UR = 3,
		R = 1,
		SP = 5
	}
	local var_210_2 = 4
	local var_210_3 = math.max(playermodel.soulContract[self.curSoul] or 0, 0)
	local var_210_4 = playermodel.soulOverClock[self.curSoul] or 0
	local var_210_5 = playermodel.addRollRarity[self.curSoul] or 0
	local var_210_6 = souls_manager:get_servant_initial_roll_rarity(self.curSoul)

	self.upgradeInfo.isHaveMaxUpgrade = var_210_3 == 5
	self.upgradeInfo.isContentUpgrade = core_manager:isBreakLimit(self.curSoul)
	self.upgradeInfo.soulContract = var_210_3
	self.upgradeInfo.contractAttr = souls_manager:get_contract_attr(self.curSoul)
	self.upgradeInfo.isCanOc = false
	self.upgradeInfo.isUnLockOc = false
	self.upgradeInfo.isContentOc = false
	self.upgradeInfo.isHavedOc = false
	self.upgradeInfo.isCanJump = false
	self.upgradeInfo.isUnLockJump = false
	self.upgradeInfo.isContentJump = false
	self.upgradeInfo.isHavedJump = false

	if var_210_6 == var_210_0.SR then
		self.upgradeInfo.isCanOc = false
		self.upgradeInfo.isCanJump = true
		self.upgradeInfo.isUnLockOc = false
		self.upgradeInfo.isUnLockJump = self.upgradeInfo.isHaveMaxUpgrade == true
	elseif var_210_6 == var_210_0.UR then
		self.upgradeInfo.isCanOc = not playermodel:isServantOverclockLockByTime(self.curSoul) and servant_data[self.curSoul].oc_isopen1 == 1
		self.upgradeInfo.isCanJump = true
		self.upgradeInfo.isUnLockOc = self.upgradeInfo.isCanOc == true and (self.upgradeInfo.isHaveMaxUpgrade == true and var_210_5 <= 0 or var_210_5 > 0)
		self.upgradeInfo.isUnLockJump = self.upgradeInfo.isHaveMaxUpgrade == true and var_210_5 <= 0
	elseif var_210_6 == var_210_0.MR or var_210_6 == var_210_0.SP then
		self.upgradeInfo.isCanOc = not playermodel:isServantOverclockLockByTime(self.curSoul) and servant_data[self.curSoul].oc_isopen1 == 1
		self.upgradeInfo.isCanJump = false
		self.upgradeInfo.isUnLockOc = self.upgradeInfo.isCanOc == true and self.upgradeInfo.isHaveMaxUpgrade == true
		self.upgradeInfo.isUnLockJump = false
	end

	if self.upgradeInfo.isUnLockOc == true and souls_manager:check_is_can_OC_with_material(self.curSoul) then
		self.upgradeInfo.isContentOc = true
	end

	if self.upgradeInfo.isUnLockJump == true and souls_manager:check_is_can_avance_with_material(self.curSoul) then
		self.upgradeInfo.isContentJump = true
	end

	if var_210_4 > 0 then
		self.upgradeInfo.isHavedOc = true
	end

	if var_210_6 < var_210_2 and var_210_6 + var_210_5 == var_210_2 then
		self.upgradeInfo.isHavedJump = true
	end

	if self.upgradeInfo.isHaveMaxUpgrade == false and var_210_5 <= 0 then
		self.upgradeInfo.operatePath = "EquipLayer/min_btn_upgrade" .. var_210_3 .. ".png"
		self.upgradeInfo.operateMinPath = nil
		self.upgradeInfo.operateType = var_0_45.Upgrade
		self.upgradeInfo.operateRedDot = self.upgradeInfo.isContentUpgrade
	elseif self.upgradeInfo.isHaveMaxUpgrade == false and var_210_5 > 0 then
		if self.upgradeInfo.isUnLockOc and self.upgradeInfo.isHavedOc == false then
			self.upgradeInfo.operatePath = "EquipLayer/min_btn_upgrade" .. var_210_3 .. ".png"
			self.upgradeInfo.operateMinPath = "EquipLayer/min_btn_oc.png"
			self.upgradeInfo.operateType = var_0_45.Upgrade
			self.upgradeInfo.operateMinType = var_0_45.Oc
			self.upgradeInfo.operateRedDot = self.upgradeInfo.isContentUpgrade
			self.upgradeInfo.operateMinRedDot = self.upgradeInfo.isContentOc
		else
			self.upgradeInfo.operatePath = "EquipLayer/min_btn_upgrade" .. var_210_3 .. ".png"
			self.upgradeInfo.operateMinPath = nil
			self.upgradeInfo.operateType = var_0_45.Upgrade
			self.upgradeInfo.operateRedDot = self.upgradeInfo.isContentUpgrade
		end
	elseif self.upgradeInfo.isHaveMaxUpgrade == true then
		if self.upgradeInfo.isUnLockOc == false and self.upgradeInfo.isUnLockJump == false then
			self.upgradeInfo.operatePath = "EquipLayer/btn_upgrade_haved.png"
			self.upgradeInfo.operateMinPath = nil
			self.upgradeInfo.operateType = var_0_45.Upgrade
		elseif self.upgradeInfo.isUnLockOc == true and self.upgradeInfo.isUnLockJump == false and self.upgradeInfo.isHavedOc == false then
			self.upgradeInfo.operatePath = "EquipLayer/btn_oc0.png"
			self.upgradeInfo.operateMinPath = nil
			self.upgradeInfo.operateType = var_0_45.Oc
			self.upgradeInfo.operateRedDot = self.upgradeInfo.isContentOc
		elseif self.upgradeInfo.isUnLockOc == true and self.upgradeInfo.isUnLockJump == false and self.upgradeInfo.isHavedOc == true then
			self.upgradeInfo.operatePath = "EquipLayer/btn_oc_haved.png"
			self.upgradeInfo.operateMinPath = nil
			self.upgradeInfo.operateType = var_0_45.Oc
		elseif self.upgradeInfo.isUnLockOc == false and self.upgradeInfo.isUnLockJump == true and self.upgradeInfo.isHavedJump == false then
			self.upgradeInfo.operatePath = "EquipLayer/btn_jump.png"
			self.upgradeInfo.operateMinPath = nil
			self.upgradeInfo.operateType = var_0_45.Jump
			self.upgradeInfo.operateRedDot = self.upgradeInfo.isContentJump
		elseif self.upgradeInfo.isUnLockOc == false and self.upgradeInfo.isUnLockJump == true and self.upgradeInfo.isHavedJump == true then
			self.upgradeInfo.operatePath = "EquipLayer/btn_upgrade_haved.png"
			self.upgradeInfo.operateMinPath = nil
			self.upgradeInfo.operateType = var_0_45.Upgrade
		elseif self.upgradeInfo.isUnLockOc == true and self.upgradeInfo.isUnLockJump == true and self.upgradeInfo.isHavedOc == false and self.upgradeInfo.isHavedJump == false then
			self.upgradeInfo.operatePath = "EquipLayer/btn_oc1.png"
			self.upgradeInfo.operateMinPath = "EquipLayer/min_btn_jump.png"
			self.upgradeInfo.operateType = var_0_45.Oc
			self.upgradeInfo.operateMinType = var_0_45.Jump
			self.upgradeInfo.operateRedDot = self.upgradeInfo.isContentOc
			self.upgradeInfo.operateMinRedDot = self.upgradeInfo.isContentJump
		elseif self.upgradeInfo.isUnLockOc == true and self.upgradeInfo.isUnLockJump == true and self.upgradeInfo.isHavedOc == true and self.upgradeInfo.isHavedJump == false then
			self.upgradeInfo.operatePath = "EquipLayer/btn_jump.png"
			self.upgradeInfo.operateMinPath = nil
			self.upgradeInfo.operateType = var_0_45.Jump
			self.upgradeInfo.operateRedDot = self.upgradeInfo.isContentJump
		elseif self.upgradeInfo.isUnLockOc == true and self.upgradeInfo.isUnLockJump == true and self.upgradeInfo.isHavedOc == false and self.upgradeInfo.isHavedJump == true then
			self.upgradeInfo.operatePath = "EquipLayer/btn_oc0.png"
			self.upgradeInfo.operateMinPath = nil
			self.upgradeInfo.operateType = var_0_45.Oc
			self.upgradeInfo.operateRedDot = self.upgradeInfo.isContentOc
		elseif self.upgradeInfo.isUnLockOc == true and self.upgradeInfo.isUnLockJump == true and self.upgradeInfo.isHavedOc == true and self.upgradeInfo.isHavedJump == true then
			self.upgradeInfo.operatePath = "EquipLayer/btn_oc_haved.png"
			self.upgradeInfo.operateMinPath = nil
			self.upgradeInfo.operateType = var_0_45.Oc
		end
	end
end

function SoulsLayer:updateUpgradePanel()
	self:updateUpgradeInfo()

	local var_211_0 = ccui.Helper:seekWidgetByName(self.attrDownPanel, "Panel_level")
	local var_211_1 = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_contract")
	local var_211_2 = 0
	local var_211_3 = self.upgradeInfo.operatePath

	if self.upgradeInfo.operatePath then
		var_211_2 = var_211_2 + 1
	end

	ccui.Helper:seekWidgetByName(var_211_0, "Label_contract"):setString(self.upgradeInfo.soulContract)
	ccui.Helper:seekWidgetByName(var_211_0, "Label_contractPoint"):setString("+" .. self.upgradeInfo.contractAttr)
	var_211_1:loadTextures(var_211_3, var_211_3, var_211_3, var_0_43)
	ccui.Helper:seekWidgetByName(var_211_0, "Button_contractPoint"):addTouchEventListener(function(arg_212_0, arg_212_1)
		if arg_212_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopContractAttrDetailLayer")
	end)
	var_211_1:setVisible(var_211_3 ~= nil)
	var_211_1:addTouchEventListener(function(arg_213_0, arg_213_1)
		if arg_213_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.upgradeInfo.operateType == var_0_45.Upgrade then
			-- block empty
		elseif self.upgradeInfo.operateType == var_0_45.Oc then
			-- block empty
		elseif self.upgradeInfo.operateType == var_0_45.Jump then
			-- block empty
		end

		if not playermodel.haveServant[self.curSoul] then
			return
		end

		self:showServantBreakLimit(self.upgradeInfo.operateType)
		AnalyticManager.clickBtnContract()
	end)

	local var_211_4 = var_211_1:getChildByName("Image_redPoint")

	var_211_4:setVisible(self.upgradeInfo.operateRedDot == true)
	var_211_4:setPosition(cc.p(var_211_1:getContentSize().width - 10, var_211_1:getContentSize().height - 10))

	local var_211_5 = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_contract")
	local var_211_6 = var_211_5:getChildByName("min_btn_operate")

	if var_211_6 == nil then
		var_211_6 = ccui.Button:create()

		var_211_6:setTouchEnabled(true)
		var_211_6:setName("min_btn_operate")
		var_211_5:addChild(var_211_6)
	end

	local var_211_7 = self.upgradeInfo.operateMinPath

	if self.upgradeInfo.operateMinPath then
		var_211_2 = var_211_2 + 1
	end

	var_211_6:loadTextures(var_211_7, var_211_7, var_211_7, var_0_43)
	var_211_6:addTouchEventListener(function(arg_214_0, arg_214_1)
		if arg_214_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.upgradeInfo.operateType == var_0_45.Upgrade then
			-- block empty
		elseif self.upgradeInfo.operateType == var_0_45.Oc then
			-- block empty
		elseif self.upgradeInfo.operateType == var_0_45.Jump then
			-- block empty
		end

		if not playermodel.haveServant[self.curSoul] then
			return
		end

		self:showServantBreakLimit(self.upgradeInfo.operateMinType)
		AnalyticManager.clickBtnContract()
	end)
	var_211_6:setVisible(var_211_7 ~= nil)

	if self.upgradeInfo.operateMinRedDot == true then
		global_add_alert_tag(var_211_6, cc.p(var_211_6:getContentSize().width, var_211_6:getContentSize().height))
	else
		global_remove_alert_tag(var_211_6)
	end

	local var_211_8 = {
		{
			cc.p(340, 23),
			cc.p(340, 23)
		},
		{
			cc.p(300, 23),
			cc.p(480, 23)
		}
	}

	var_211_1:setPosition(var_211_8[var_211_2][1])
	var_211_6:setPosition(var_211_8[var_211_2][2])
end

function SoulsLayer:updateDevourLayout()
	local var_215_0 = ccui.Helper:seekWidgetByName(self.statusPanel, "Button_devour")

	var_215_0:getChildByName("Image_36_0"):getChildByName("Label_65"):setString(L_HORCRUX_DEVOUR[1])

	local var_215_1 = not level_manager:isPlayerPassLevel(UNLOCK_HORCRUX)

	for iter_215_0 = 1, HORCRUX_DEVOUR_MAX do
		local var_215_2 = var_215_0:getChildByName("Panel_devour_" .. iter_215_0)
		local var_215_3 = var_215_0:getChildByName("Label_horcruxName" .. iter_215_0)
		local var_215_4 = var_215_2:getChildByName("Image_horcruxIcon")
		local var_215_5 = var_215_2:getChildByName("Image_59")
		local var_215_6 = var_215_5:getChildByName("null_img")

		if not var_215_6 then
			local var_215_7 = TempWidget:CreateTempImg("EquipLayer/null_img.png", var_215_5)

			var_215_7:setScale(0.95)
			var_215_7:align(cc.p(0.5, 0.5), var_215_5:getContentSize().width / 2, var_215_5:getContentSize().height / 2)
			var_215_7:setName("null_img")

			var_215_6 = var_215_7
		end

		var_215_6:setVisible(false)

		local var_215_8 = var_215_5:getChildByName("lock_img")

		if not var_215_8 then
			local var_215_9 = TempWidget:CreateTempImg("EquipLayer/lock_img.png", var_215_5)

			var_215_9:setScale(0.95)
			var_215_9:align(cc.p(0.5, 0.5), var_215_5:getContentSize().width / 2, var_215_5:getContentSize().height / 2)
			var_215_9:setName("lock_img")

			var_215_8 = var_215_9
		end

		var_215_8:hide()

		local var_215_10 = var_215_4:getChildByName("repeatImg")

		if not var_215_10 then
			local var_215_11 = TempWidget:CreateTempImg("EquipLayer/repeat.png", var_215_4)

			var_215_11:center()
			var_215_11:setScale(1.4)
			var_215_11:setName("repeatImg")

			var_215_10 = var_215_11
		end

		var_215_10:hide()

		local var_215_12 = var_215_0:getChildByName("redDot_" .. iter_215_0)

		if not var_215_12 then
			local var_215_13 = TempWidget:CreateTempImg("public/reddot/reddot2.png", var_215_0)

			var_215_13:setPosition(var_215_2:getContentSize().width + var_215_2:getPositionX(), var_215_2:getContentSize().height + var_215_2:getPositionY())
			var_215_13:setName("redDot_" .. iter_215_0)
			var_215_13:setScale(0.8, 0.8)

			var_215_12 = var_215_13
		end

		var_215_12:hide()

		if self:isHorcruxHaveAlert(iter_215_0) then
			var_215_12:setVisible(true)
		end

		var_215_4:setScale(0.33)
		var_215_3:setVisible(false)
		var_215_4:setVisible(false)

		local var_215_14 = var_0_22:getLayerSkillInfo(self.curSoul, iter_215_0)
		local var_215_15 = var_0_23:isUnlock(self.curSoul, iter_215_0)

		var_215_8:setVisible(not var_215_15)

		if not var_215_15 then
			var_215_12:setVisible(false)
		end

		if var_215_1 then
			var_215_8:setVisible(true)
			var_215_12:setVisible(false)
		end

		if var_215_14 then
			var_215_12:setVisible(false)
			var_215_3:setVisible(true)
			var_215_4:setVisible(true)
			var_215_3:setString(var_215_14.horcruxName)
			var_215_4:loadTexture(var_215_14.horcruxPath)

			if var_215_14.disable then
				var_215_10:center()
				var_215_10:show()

				if var_215_15 then
					var_215_10:loadTexture("EquipLayer/repeat.png", var_0_43)
				else
					var_215_10:loadTexture("EquipLayer/hide.png", var_0_43)
				end
			end
		else
			var_215_6:setVisible(true)
		end
	end
end

function SoulsLayer:onBuyShop()
	print("on_buy_shop")

	if weapon_manager:checkIsCanReplaceBetter(self.curSoul) then
		self:useWeapon()
	end
end

function SoulsLayer:isHorcruxHaveAlert(arg_217_1)
	local var_217_0 = false

	for iter_217_0 = 1, 3 do
		if #var_0_22:getOutSideHorcruxs(self.curSoul, {
			attrFilter = iter_217_0 == 1,
			index = iter_217_0,
			selectIndex = arg_217_1
		}) >= 1 then
			var_217_0 = true
		else
			var_217_0 = false

			break
		end
	end

	return var_217_0
end

function SoulsLayer:equip_component_onekey(arg_218_1)
	component_manager:equipComponentOnekey(self.curSoul, function(arg_219_0)
		if arg_219_0.no_component then
			arg_218_1:setBright(true)
			global_ShowBlockWords(L_EQUIP_COMPONENT_ONEKEY_NOCOMPONENT)

			return
		end

		if arg_219_0.result == 1 then
			if self.roleInfos[self.curSoul] then
				audio_manager:playeffectMusicTest("sound/equip")

				local var_219_0, var_219_1 = component_manager:getSoulComponentlist(self.curSoul)

				self.roleInfos[self.curSoul].model:updateComponentAttr(var_219_0)

				self.roleInfos[self.curSoul].effects = var_219_1

				self:updateGirlDate()
				self:resetAllComponentRedPoint()
				self:updateStatusPanel()
				self:updateComponentPanel()
				self:resetTopCostListButton()

				if arg_219_0.bChangeParts then
					global_ShowBlockWords(L_EQUIP_COMPONENT_ONEKEY_SUCCESS)
				else
					global_ShowBlockWords(L_EQUIP_COMPONENT_ONEKEY_EQUIPED)
				end
			end
		else
			global_ShowBlockWords(L_EQUIP_COMPONENT_ONEKEY_FAIL)
		end

		arg_218_1:setBright(true)
	end)
end
