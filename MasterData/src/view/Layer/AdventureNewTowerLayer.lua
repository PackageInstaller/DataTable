AdventureNewTowerLayer = class("AdventureNewTowerLayer", function()
	return cc.Layer:create()
end)

local net_dispatcher = require("network.net_dispatcher")
local network = require("network.network")
local var_0_3 = config._DEBUG and 0 or 1
local playermodel = require("model.playermodel")
local item_data = require("data.item_data")
local total_skill_data = require("data.total_skill_data")

require("view.Sprite.BottomBtnList")
require("view.Sprite.TitleSprite")
require("view.Layer.BattleArrayLayerNew")

local TempWidget = require("view.Sprite.TempWidget")
local level_manager = require("controller.level_manager")
local array_manager = require("controller.array_manager")
local audio_manager = require("controller.audio_manager")
local monster_manager = require("controller.monster_manager")
local component_manager = require("controller.component_manager")
local horcrux_manager = require("controller.horcrux_manager")
local var_0_14 = require("controller.formation.formation_manager"):getInstance()
local levelmode_data = require("data.levelmode_data")
local var_0_16 = require("data.item_data")
local model_data = require("data.model_data")
local BonusPreview_data = require("data/BonusPreview_data")
local chapter_data = require("data.chapter_data")
local drop_data = require("data.drop_data")
local var_0_23 = {
	"adventurenewtowerlayer/changdi_1.png",
	"adventurenewtowerlayer/changdi_2.png",
	"adventurenewtowerlayer/changdi_3.png",
	"adventurenewtowerlayer/bai.png",
	"adventurenewtowerlayer/changdi_4.png"
}
local var_0_24 = {
	"adventurenewtowerlayer/namedi_1.png",
	"adventurenewtowerlayer/namedi_2.png",
	"adventurenewtowerlayer/bigboss_namedi.png"
}
local var_0_25 = {
	"adventurenewtowerlayer/bossinfo_1.png",
	"adventurenewtowerlayer/bossinfo_2.png",
	"adventurenewtowerlayer/bossinfo_3.png"
}
local var_0_27 = "adventurenewtowerlayer/getawrad.png"
local var_0_28 = {
	"adventurenewtowerlayer/bigboss_di.png",
	"adventurenewtowerlayer/bigboss_di1.png",
	"adventurenewtowerlayer/bigboss_tou3.png",
	"adventurenewtowerlayer/bigboss_tou4.png"
}
local var_0_29 = {
	"adventurenewtowerlayer/frame1.png",
	"adventurenewtowerlayer/frame2.png",
	"adventurenewtowerlayer/frame3.png"
}
local var_0_30 = 630
local var_0_31 = 192

function AdventureNewTowerLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = AdventureNewTowerLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function AdventureNewTowerLayer:getExitParam()
	return cloneconf(self.msg)
end

function AdventureNewTowerLayer.init(arg_4_0, arg_4_1)
	require("controller.formation.formation_mode_manager"):getInstance():requestInfo(arg_4_1.chaptermode, RoleDefault:getInstance():getIntegerForKey("adventurearray", playermodel.curArray), function(arg_5_0)
		local var_5_0

		if TopcostLayer and TopcostLayer.getInstance() then
			TopcostLayer.getInstance():hideTopcostLayer()

			var_5_0 = arg_4_0
		end

		var_5_0.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "AdventureNewTowerLayer.json" or "AdventureNewTowerLayer.ExportJson")

		arg_4_0:addChild(arg_4_0.rootLayer)

		arg_4_0.bg = ccui.Helper:seekWidgetByName(arg_4_0.rootLayer, "bg")

		arg_4_0.bg:loadTexture("mainScenebg/roledatabg.jpg")
		arg_4_0.bg:setPosition(cc.p(320, GameDisplay.getScreenSize().height / 2))

		arg_4_0.backdi = ccui.Helper:seekWidgetByName(arg_4_0.rootLayer, "Image_bottom")

		arg_4_0.backdi:setPosition(cc.p(320, 31))
		arg_4_0.backdi:setZOrder(10000)

		arg_4_0.back = ccui.Helper:seekWidgetByName(arg_4_0.rootLayer, "Button_23")

		local var_5_1 = GameDisplay.getUiScreenSize().height - 63

		arg_4_0.roleTableView = cc.TableView:create(cc.size(640, var_5_1))

		arg_4_0.roleTableView:setPosition(cc.p(0, arg_4_0.backdi:getPositionY() + arg_4_0.backdi:getContentSize().height / 2))
		arg_4_0.roleTableView:setDelegate()
		arg_4_0.roleTableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
		arg_4_0.rootLayer:addChild(arg_4_0.roleTableView)
		arg_4_0.roleTableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
		arg_4_0.rootLayer:setName("self.roleTableView")

		arg_4_0.roleTableViewhight = var_5_1
		arg_4_0.num = 0
		arg_4_0.modetype = nil
		arg_4_0.sucessflag = nil
		arg_4_0.msg = arg_4_1

		if type(arg_4_1) == "table" then
			arg_4_0.modetype = arg_4_1.layer
			arg_4_0.sucessflag = arg_4_1.scessflag
			arg_4_0.chaptermode = arg_4_1.chaptermode
		elseif type(arg_4_1) == "number" then
			arg_4_0.modetype = arg_4_1
		end

		arg_4_0:fullScreen(arg_4_0.rootLayer)
		arg_4_0:getListData(arg_4_0.modetype)
		arg_4_0:registerScriptHandler(function(arg_6_0)
			if arg_6_0 == "exit" then
				RoleDefault:getInstance():setIntegerForKey(arg_4_0.mode .. "red", 1)
			end
		end)
		arg_4_0.back:addTouchEventListener(function(arg_7_0, arg_7_1)
			if arg_7_1 ~= ccui.TouchEventType.ended then
				return
			end

			KeyCodeManager:onKeyReleasedCallFunc()
		end)

		arg_4_0.autoFight = RoleDefault:getInstance():getBoolForKey("AdventureTowerAutoFight", false)

		local var_5_2 = ccui.Helper:seekWidgetByName(arg_4_0.rootLayer, "auto_fight_bg")
		local var_5_3 = ccui.Helper:seekWidgetByName(arg_4_0.rootLayer, "auto_fight_choose")

		var_5_3:setVisible(arg_4_0.autoFight)
		var_5_2:setTouchEnabled(true)
		var_5_2:addTouchEventListener(function(arg_8_0, arg_8_1)
			if arg_8_1 ~= ccui.TouchEventType.ended then
				return
			end

			arg_4_0.autoFight = not arg_4_0.autoFight

			var_5_3:setVisible(arg_4_0.autoFight)
			RoleDefault:getInstance():setBoolForKey("AdventureTowerAutoFight", arg_4_0.autoFight)
		end)

		local var_5_4 = TempWidget:CreateTempBtn("adventurenewtowerlayer/btn_reward_preview.png", var_5_2:getParent())

		var_5_4:align(cc.p(1, 0.5), var_5_2:getPositionX() - var_5_2:getContentSize().width / 2 - 10, var_5_2:getPositionY())
		var_5_4:setScale(1.2)
		var_5_4:setVisible(arg_4_0.chaptermode and true or false)
		var_5_4:_addEvent(function()
			local var_9_0 = {}

			for iter_9_0, iter_9_1 in pairs(BonusPreview_data) do
				if tonumber(iter_9_1.name) == arg_4_0.chaptermode then
					if iter_9_1.diamond then
						var_9_0[#var_9_0 + 1] = {
							id = "diamond",
							count = iter_9_1.diamond
						}
					end

					local var_9_1 = 1

					while iter_9_1["itemid" .. var_9_1] do
						local var_9_2 = {
							id = iter_9_1["itemid" .. var_9_1]
						}

						var_9_2.count = iter_9_1["item_num" .. var_9_1] or 1
						var_9_0[#var_9_0 + 1] = var_9_2
						var_9_1 = var_9_1 + 1
					end

					break
				end
			end

			LayerManager:pushInLayer("RewardPreviewLayer", var_9_0)
		end)

		local var_5_5 = arg_4_0:getEventDispatcher()

		var_5_5:addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("adv_tower_auto_fight", function(arg_10_0)
			arg_4_0.autoFight = false

			var_5_3:setVisible(arg_4_0.autoFight)
		end), arg_4_0)
		arg_4_0:checkAutoFight(arg_4_1)
		var_5_5:addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("update_tablecell", function(arg_11_0)
			arg_4_0:getListData(arg_4_0.modetype)
			global_ShowBlockWords(L_ADVENTURE_WARNING[8])
		end), arg_4_0)
	end)
end

function AdventureNewTowerLayer:getAutoFightData()
	if not self.data then
		return
	end

	for iter_12_0, iter_12_1 in ipairs(self.data) do
		if iter_12_1.status == 2 then
			return iter_12_1
		end
	end
end

function AdventureNewTowerLayer:checkAutoFight(arg_13_1)
	if not arg_13_1.needAutoFight then
		return
	end

	if not self.autoFight then
		return
	end

	local function var_13_0()
		if tolua.isnull(ref) then
			return
		end

		ref:setBright(true)
	end

	local var_13_1 = self:getAutoFightData()

	if not var_13_1 then
		return
	end

	global_count_down_layer(4, function()
		self:dealChangeBtn(self.mode, var_13_1.layer, var_13_0)
	end, function()
		cc.Director:getInstance():getEventDispatcher():dispatchEvent((cc.EventCustom:new("adv_tower_auto_fight")))
		RoleDefault:getInstance():setBoolForKey("AdventureTowerAutoFight", false)
	end)
end

function AdventureNewTowerLayer:createNode()
	local var_17_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "items"):clone()

	var_17_0:setTouchEnabled(false)

	local var_17_1 = ccui.ImageView:create("public/career_icon/restrain_tip_1.png", var_0_3)

	var_17_1:setName("restrainTip")
	var_17_1:setPosition(cc.p(118, 158))
	var_17_0:addChild(var_17_1)

	return var_17_0
end

function AdventureNewTowerLayer:updateNode(arg_18_1, arg_18_2)
	local var_18_0 = ccui.Helper:seekWidgetByName(arg_18_1, "ani_1")
	local var_18_1 = ccui.Helper:seekWidgetByName(arg_18_1, "ani_2")
	local var_18_2 = ccui.Helper:seekWidgetByName(arg_18_1, "bossface")
	local var_18_3 = ccui.Helper:seekWidgetByName(arg_18_1, "name_di")
	local var_18_4 = ccui.Helper:seekWidgetByName(arg_18_1, "detail_btn")
	local var_18_5 = ccui.Helper:seekWidgetByName(arg_18_1, "ceshu")
	local var_18_6 = ccui.Helper:seekWidgetByName(arg_18_1, "change_btn")

	var_18_5:setString("")
	var_18_4:setPositionY(115)
	var_18_4:setPositionX(307)

	if not arg_18_2.isbigboss then
		var_18_0:loadTexture("adventurenewtowerlayer/tou_1.png", var_0_3)
		var_18_1:loadTexture("adventurenewtowerlayer/tou_2.png", var_0_3)
	else
		var_18_0:loadTexture("adventurenewtowerlayer/bigboss_tou3.png", var_0_3)
		var_18_1:loadTexture("adventurenewtowerlayer/bigboss_tou4.png", var_0_3)
	end

	self:updataImage(arg_18_1, arg_18_2)
	var_18_4:setSwallowTouches(false)

	local var_18_7

	if arg_18_2.status == 1 then
		if arg_18_1:getChildByName("sucess") then
			arg_18_1:getChildByName("sucess"):removeFromParent()
		end

		if arg_18_1:getChildByName("bosssucess") then
			arg_18_1:getChildByName("bosssucess"):removeFromParent()
		end

		if not arg_18_2.isbigboss then
			arg_18_1:setBackGroundImage(var_0_23[2], var_0_3)
			var_18_4:loadTextures(var_0_25[2], nil, var_0_25[2], var_0_3)
			var_18_3:loadTexture(var_0_24[2], var_0_3)

			var_18_7 = "<p>" .. string.format(L_ADVENTURE_TOWER_FLOOR_NOT_BOSS, arg_18_2.layer)
		else
			arg_18_1:setBackGroundImage(var_0_28[2], var_0_3)
			var_18_4:loadTextures(var_0_25[3], nil, var_0_25[3], var_0_3)
			var_18_3:loadTexture(var_0_24[3], var_0_3)

			var_18_7 = "<p>" .. string.format(L_ADVENTURE_TOWER_FLOOR_BOSS, arg_18_2.layer)
		end

		var_18_3:setVisible(true)
		var_18_0:setVisible(false)
		var_18_1:setVisible(false)
		var_18_6:setVisible(false)
	elseif arg_18_2.status == 2 then
		if arg_18_1:getChildByName("bosssucess") then
			arg_18_1:getChildByName("bosssucess"):removeFromParent()
		end

		local function var_18_8(arg_19_0)
			if not arg_18_2.isbigboss then
				arg_19_0:setBackGroundImage(var_0_23[1], var_0_3)
				var_18_4:loadTextures(var_0_25[1], nil, var_0_25[1], var_0_3)
				var_18_3:loadTexture(var_0_24[1], var_0_3)

				var_18_7 = "<p>" .. string.format(L_ADVENTURE_TOWER_FLOOR_NOW, arg_18_2.layer)
			else
				arg_19_0:setBackGroundImage(var_0_28[1], var_0_3)
				var_18_4:loadTextures(var_0_25[3], nil, var_0_25[3], var_0_3)
				var_18_3:loadTexture(var_0_24[3], var_0_3)

				var_18_7 = "<p>" .. string.format(L_ADVENTURE_TOWER_FLOOR_BOSS, arg_18_2.layer)
			end

			var_18_3:setVisible(true)
			var_18_0:setVisible(true)
			var_18_1:setVisible(true)
			var_18_6:setVisible(true)
			self:playain(arg_19_0)

			if var_18_5:getChildByName("richTextWord") then
				var_18_5:getChildByName("richTextWord"):removeFromParent()
			end

			local var_19_0 = require("view.Sprite.RichTextPro"):create()

			var_19_0:setMaxWidth(550)
			var_19_0:setSize(27)
			var_19_0:setLineSpace(0)
			var_19_0:setText(var_18_7, nil, true)
			var_19_0:setName("richTextWord")
			var_19_0:setPosition(cc.p((arg_18_2.layer >= 100 or nil) and -15, 40))
			var_18_5:addChild(var_19_0)
		end

		if self.sucessflag and self.sucessflag == 1 then
			if not arg_18_2.isbigboss then
				arg_18_1:setBackGroundImage(var_0_23[2], var_0_3)
				var_18_4:loadTextures(var_0_25[2], nil, var_0_25[2], var_0_3)
				var_18_3:loadTexture(var_0_24[2], var_0_3)

				var_18_7 = "<p>" .. string.format(L_ADVENTURE_TOWER_FLOOR_NOT_BOSS, arg_18_2.layer)
			else
				arg_18_1:setBackGroundImage(var_0_28[2], var_0_3)
				var_18_4:loadTextures(var_0_25[3], nil, var_0_25[3], var_0_3)
				var_18_3:loadTexture(var_0_24[3], var_0_3)

				var_18_7 = "<p>" .. string.format(L_ADVENTURE_TOWER_FLOOR_BOSS, arg_18_2.layer)
			end

			var_18_3:setVisible(true)
			var_18_0:setVisible(false)
			var_18_1:setVisible(false)
			var_18_6:setVisible(false)
		elseif self.sucessflag and self.sucessflag == 2 then
			self:playani2(arg_18_1, var_18_8)
		elseif var_18_8 then
			var_18_8(arg_18_1)
		end
	elseif arg_18_2.status == 3 then
		if arg_18_1:getChildByName("sucess") then
			arg_18_1:getChildByName("sucess"):removeFromParent()
		end

		local function var_18_9(arg_20_0)
			if arg_20_0:getChildByName("bosssucess") then
				arg_20_0:getChildByName("bosssucess"):removeFromParent()
			end

			local var_20_0 = ccui.ImageView:create("adventurenewtowerlayer/yitiaozhan.png", var_0_3)

			var_20_0:setScale(1)
			var_20_0:setAnchorPoint(cc.p(0.5, 0.5))
			var_20_0:setName("bosssucess")
			var_20_0:setPosition(cc.p(arg_20_0:getContentSize().width / 2 + 240, arg_20_0:getContentSize().height / 2 - 13))
			arg_20_0:addChild(var_20_0, 10000)

			if not arg_18_2.isbigboss then
				arg_20_0:setBackGroundImage(var_0_23[3], var_0_3)

				if arg_20_0:getChildByName("bosssucess") then
					arg_20_0:getChildByName("bosssucess"):removeFromParent()
				end

				var_18_3:loadTexture(var_0_24[2], var_0_3)

				var_18_7 = "<p>" .. string.format(L_ADVENTURE_TOWER_FLOOR_BOSS_SUCCESS, arg_18_2.layer)
			else
				arg_20_0:setBackGroundImage(var_0_28[1], var_0_3)
				var_18_3:loadTexture(var_0_24[3], var_0_3)

				var_18_7 = "<p>" .. string.format(L_ADVENTURE_TOWER_FLOOR_BOSS, arg_18_2.layer)
			end

			var_18_4:loadTextures(var_0_25[2], nil, var_0_25[2], var_0_3)
			var_18_0:setVisible(false)
			var_18_1:setVisible(false)
			var_18_6:setVisible(false)

			if var_18_5:getChildByName("richTextWord") then
				var_18_5:getChildByName("richTextWord"):removeFromParent()
			end

			local var_20_1 = require("view.Sprite.RichTextPro"):create()

			var_20_1:setMaxWidth(550)
			var_20_1:setSize(25)
			var_20_1:setLineSpace(0)
			var_20_1:setText(var_18_7, nil, true)
			var_20_1:setName("richTextWord")
			var_20_1:setPosition(cc.p((arg_18_2.layer >= 100 or nil) and -15, 40))
			var_18_5:addChild(var_20_1)
		end

		if self.sucessflag and self.sucessflag == 1 and arg_18_2.layer == self.curlevel - 1 then
			if not arg_18_2.isbigboss then
				arg_18_1:setBackGroundImage(var_0_23[5], var_0_3)
			else
				arg_18_1:setBackGroundImage(var_0_28[1], var_0_3)
			end

			var_18_6:setVisible(false)
			self:playani3(arg_18_1, var_18_9)
		else
			var_18_9(arg_18_1)
		end
	end

	if var_18_7 then
		if var_18_5:getChildByName("richTextWord") then
			var_18_5:getChildByName("richTextWord"):removeFromParent()
		end

		local var_18_10 = require("view.Sprite.RichTextPro"):create()

		var_18_10:setMaxWidth(550)
		var_18_10:setSize(27)
		var_18_10:setLineSpace(0)
		var_18_10:setText(var_18_7, nil, true)
		var_18_10:setName("richTextWord")
		var_18_10:setPosition(cc.p((arg_18_2.layer >= 100 or nil) and -15, 40))
		var_18_5:addChild(var_18_10)
	end

	var_18_2:loadTextures("role1/" .. model_data[arg_18_2.bossmode].cute_role .. ".png", nil, "role1/" .. model_data[arg_18_2.bossmode].cute_role .. ".png")
	var_18_2:setScale(0.35)
	var_18_2:setTouchEnabled(true)
	var_18_2:setSwallowTouches(false)
	var_18_3:getChildByName("bossname"):setFontSize(20)
	var_18_3:getChildByName("bossname"):setString(model_data[arg_18_2.bossmode].name)
	var_18_2:setPositionY(110)
	var_18_6:addTouchEventListener(function(arg_21_0, arg_21_1)
		if arg_21_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_21_0 = "501-" .. arg_18_2.layer

		if chapter_data["501-" .. arg_18_2.layer] and chapter_data[var_21_0].boss_combat and playermodel.grade < chapter_data[var_21_0].boss_combat then
			global_ShowBlockWords(L_ADVENTURE_WARNING[6] .. chapter_data[var_21_0].boss_combat .. L_ADVENTURE_WARNING[7])

			return
		end

		if not arg_21_0:isBright() then
			return
		end

		arg_21_0:setBright(false)
		self:dealChangeBtn(self.mode, arg_18_2.layer, function()
			if tolua.isnull(arg_21_0) then
				return
			end

			arg_21_0:setBright(true)
		end)
	end)
	var_18_4:setTouchEnabled(false)
	var_18_4:addTouchEventListener(function(arg_23_0, arg_23_1)
		if arg_23_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_23_0:isBright() then
			return
		end

		arg_23_0:setBright(false)
		self:showBossInfo(self.mode, arg_18_2.layer, function()
			arg_23_0:setBright(true)
		end)
	end)
	var_18_2:addTouchEventListener(function(arg_25_0, arg_25_1)
		if arg_25_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_25_0:isBright() then
			return
		end

		arg_25_0:setBright(false)
		self:showBossInfo(self.mode, arg_18_2.layer, function()
			if tolua.isnull(arg_25_0) then
				return
			end

			arg_25_0:setBright(true)
		end)
	end)

	local var_18_12 = arg_18_1:getChildByName("restrainTip")

	if self.res_element then
		var_18_12:setVisible(true)
		var_18_12:loadTexture("public/career_icon/restrain_tip_" .. ATTR_INDEX[self.res_element] .. ".png", var_0_3)
	else
		var_18_12:setVisible(false)
	end
end

function AdventureNewTowerLayer.playani3(arg_27_0, arg_27_1, arg_27_2)
	local var_27_0 = arg_27_1

	if arg_27_1:getChildByName("sucess") then
		arg_27_1:getChildByName("sucess"):removeFromParent()
	end

	local var_27_1 = ccui.ImageView:create("adventurenewtowerlayer/yitiaozhan.png", var_0_3)

	var_27_1:setScale(3)
	var_27_1:setAnchorPoint(cc.p(0.5, 0.5))
	var_27_1:setName("sucess")
	var_27_1:setPosition(cc.p(arg_27_1:getContentSize().width / 2 + 240, arg_27_1:getContentSize().height / 2 - 13))
	arg_27_1:addChild(var_27_1, 10000)
	var_27_1:runAction(cc.Sequence:create(cc.ScaleTo:create(0.5, 1), cc.CallFunc:create(function()
		if arg_27_2 then
			arg_27_2(var_27_0)

			arg_27_0.sucessflag = 2

			print("!!!!!!!!!!")
		end
	end), cc.CallFunc:create(function()
		if arg_27_0.isscoll then
			arg_27_0.data = arg_27_0.newdata

			arg_27_0.roleTableView:reloadData()
			arg_27_0.roleTableView:scrollToPercent(50, nil, false)
			arg_27_0.roleTableView:scrollToPercent(0, 1, true)
		else
			arg_27_0.roleTableView:reloadData()
		end
	end)))
end

function AdventureNewTowerLayer.playani2(arg_30_0, arg_30_1, arg_30_2)
	local var_30_0 = arg_30_1

	arg_30_1:runAction(cc.Sequence:create(cc.CallFunc:create(function()
		local var_31_0 = ccui.ImageView:create(var_0_23[4], var_0_3)

		var_31_0:setName("baisezhe")
		var_31_0:setPosition(var_30_0:getContentSize().width / 2 + 2, var_30_0:getContentSize().height / 2)
		var_30_0:addChild(var_31_0, 1000000)
		var_31_0:runAction(cc.Sequence:create(cc.FadeTo:create(0.3, 102), cc.FadeTo:create(0.3, 255), cc.CallFunc:create(function()
			if arg_30_2 then
				arg_30_2(var_30_0)
			end
		end), cc.FadeTo:create(0.3, 0)))
	end), cc.DelayTime:create(1), cc.CallFunc:create(function()
		if var_30_0:getChildByName("baisezhe") then
			var_30_0:getChildByName("baisezhe"):removeFromParent()
		end

		arg_30_0.sucessflag = nil

		arg_30_0.roleTableView:setTouchEnabled(true)
	end)))
end

function AdventureNewTowerLayer.playain(arg_34_0, arg_34_1)
	arg_34_1:getChildByName("ani_1"):runAction(cc.RepeatForever:create(cc.RotateBy:create(6, -360)))
	arg_34_1:getChildByName("ani_2"):runAction(cc.RepeatForever:create(cc.RotateBy:create(6, 360)))
end

function AdventureNewTowerLayer:updataImage(arg_35_1, arg_35_2)
	local var_35_0 = arg_35_2.horcruxAffix
	local var_35_1 = #arg_35_2.horcruxAffix

	while arg_35_1:getChildByName("btnpanel_" .. 1) do
		arg_35_1:getChildByName("btnpanel_" .. 1):removeFromParent()
	end

	local var_35_3

	if arg_35_2.isbigboss then
		var_35_3 = var_0_29[3]
	elseif arg_35_2.status == 1 or arg_35_2.status == 3 then
		var_35_3 = var_0_29[2]
	elseif arg_35_2.status == 2 then
		var_35_3 = var_0_29[1]
	end

	for iter_35_0 = 1, var_35_1 do
		local var_35_4 = ccui.Layout:create()

		var_35_4:setContentSize(cc.size(140, 36))
		var_35_4:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
		var_35_4:setAnchorPoint(0.5, 0.5)
		var_35_4:setBackGroundColor(cc.c3b(0, 0, 0))
		var_35_4:setTouchEnabled(false)
		var_35_4:setName("btnpanel_" .. iter_35_0)
		var_35_4:setPosition(cc.p(arg_35_1:getContentSize().width / 2 - 50 + (iter_35_0 - 1) * 130, arg_35_1:getContentSize().height / 2 + 60))
		arg_35_1:addChild(var_35_4, 10)

		local var_35_5 = ccui.ImageView:create(var_35_3, var_0_3)

		var_35_5:setPosition(cc.p(var_35_4:getContentSize().width / 2 - 50, var_35_4:getContentSize().height / 2 - 3))
		var_35_4:addChild(var_35_5)
		var_35_5:setTouchEnabled(false)

		local var_35_6 = ccui.Button:create("skill_new/skill/" .. arg_35_2.horcruxAffix[iter_35_0].icon .. ".png", "skill_new/skill/" .. arg_35_2.horcruxAffix[iter_35_0].icon .. ".png", nil, var_0_3)

		var_35_6:setName("btnSkill_" .. iter_35_0)
		var_35_6:setPosition(cc.p(var_35_5:getContentSize().width / 2, var_35_5:getContentSize().height / 2))
		var_35_6:setScale((math.min(37 / var_35_6:getContentSize().width, 37 / var_35_6:getContentSize().height)))
		var_35_5:addChild(var_35_6)
		var_35_6:setTouchEnabled(true)
		var_35_6:setSwallowTouches(false)

		local var_35_7 = cc.Label:createWithTTF("1", FONT_DES, 20)

		var_35_7:setMaxLineWidth(190)
		var_35_7:setAnchorPoint(cc.p(0, 0.5))
		var_35_7:setString(arg_35_2.horcruxAffix[iter_35_0].name)
		var_35_7:setPosition(cc.p(var_35_5:getPositionX() + 27, var_35_5:getPositionY()))
		var_35_4:addChild(var_35_7)
		var_35_6:addTouchEventListener(function(arg_36_0, arg_36_1)
			if arg_36_1 ~= ccui.TouchEventType.ended then
				return
			end

			self:showAwardInfo(arg_35_1, var_35_0[iter_35_0].name, var_35_0[iter_35_0].des, iter_35_0)
		end)
	end

	local var_35_8 = arg_35_2.firstPassDrop.items
	local var_35_9 = arg_35_2.status
	local var_35_10 = {}

	if arg_35_2.item.items and #arg_35_2.item.items > 0 then
		for iter_35_1, iter_35_2 in ipairs(arg_35_2.item.items) do
			if iter_35_2.num and iter_35_2.num > 0 then
				table.insert(var_35_10, iter_35_2)
			end
		end
	end

	if arg_35_2.item.gold and arg_35_2.item.gold > 0 then
		table.insert(var_35_10, {
			itemid = "gold",
			num = arg_35_2.item.gold
		})
	end

	if arg_35_2.item.diamond and arg_35_2.item.diamond > 0 then
		table.insert(var_35_10, {
			itemid = "diamond",
			num = arg_35_2.item.diamond
		})
	end

	local var_35_11 = #var_35_10 + #var_35_8

	if #var_35_10 + #var_35_8 <= 0 then
		return
	end

	local var_35_13 = var_35_11 == 1 and 1 or var_35_11 == 2 and 2 or 3
	local var_35_14 = 1

	while arg_35_1:getChildByName("award" .. var_35_14) do
		arg_35_1:getChildByName("award" .. var_35_14):removeFromParent()

		if arg_35_1:getChildByName("zhezhao" .. var_35_14) then
			arg_35_1:getChildByName("zhezhao" .. var_35_14):removeFromParent()
		end

		var_35_14 = var_35_14 + 1
	end

	for iter_35_3 = 1, var_35_13 do
		if iter_35_3 <= #var_35_10 then
			self:createDropItem(arg_35_1, var_35_10[iter_35_3], var_35_9, iter_35_3, false)
		else
			self:createDropItem(arg_35_1, var_35_8[iter_35_3 - #var_35_10], arg_35_2.firstPassDrop.status, iter_35_3, true)
		end
	end

	if var_35_13 == 1 and arg_35_1:getChildByName("award" .. 1) then
		arg_35_1:getChildByName("award" .. 1):setPositionX(316)

		if arg_35_1:getChildByName("zhezhao" .. 1) then
			arg_35_1:getChildByName("zhezhao" .. 1):setPositionX(316)
		end
	end

	local var_35_15 = {
		266,
		356,
		445
	}

	if var_35_13 == 3 then
		for iter_35_4 = 1, 3 do
			if arg_35_1:getChildByName("award" .. iter_35_4) then
				arg_35_1:getChildByName("award" .. iter_35_4):setPositionX(var_35_15[iter_35_4] - 40)
			end

			if arg_35_1:getChildByName("zhezhao" .. iter_35_4) then
				arg_35_1:getChildByName("zhezhao" .. iter_35_4):setPositionX(var_35_15[iter_35_4] - 40)
			end
		end
	end

	local var_35_16 = {
		266,
		356
	}

	if var_35_13 == 2 then
		for iter_35_5 = 1, 2 do
			if arg_35_1:getChildByName("zhezhao" .. iter_35_5) then
				arg_35_1:getChildByName("zhezhao" .. iter_35_5):setPositionX(var_35_16[iter_35_5])
			end
		end
	end
end

function AdventureNewTowerLayer.createDropItem(arg_37_0, arg_37_1, arg_37_2, arg_37_3, arg_37_4, arg_37_5)
	local var_37_1 = type(arg_37_2.itemid) == "string" and ccui.Button:create("public/box/" .. "1" .. ".png", "public/box/" .. "1" .. ".png", nil, var_0_3) or ccui.Button:create("public/box/" .. var_0_16[arg_37_2.itemid].equip_quality .. ".png", "public/box/" .. var_0_16[arg_37_2.itemid].equip_quality .. ".png", nil, var_0_3)

	var_37_1:setAnchorPoint(cc.p(0.5, 0.5))
	var_37_1:setPosition(cc.p(0, 0))
	var_37_1:setTouchEnabled(true)
	var_37_1:setSwallowTouches(false)
	var_37_1:setPosition(cc.p(266 + (arg_37_4 - 1) * 90, 60))
	var_37_1:setName("award" .. arg_37_4)
	arg_37_1:addChild(var_37_1, 1)

	local var_37_2
	local var_37_3

	if arg_37_2.itemid == "gold" and arg_37_2.num > 0 then
		var_37_2 = "equipment/1000001.png"
	elseif arg_37_2.itemid == "diamond" and arg_37_2.num > 0 then
		var_37_2 = "equipment/1000000.png"
	elseif var_0_16[arg_37_2.itemid].image_id then
		var_37_2 = "equipment/" .. var_0_16[arg_37_2.itemid].image_id .. ".png"
	else
		var_37_3 = var_0_16[arg_37_2.itemid].bag_item_type == kITEM_MEDAL and ItemSprite:create_medal_icon(arg_37_2.itemid) or component_manager:create_component_icon(arg_37_2.itemid, nil, nil)
	end

	var_37_3 = var_37_3 or ccui.ImageView:create(var_37_2)

	var_37_3:setPosition(cc.p(var_37_1:getContentSize().width / 2, var_37_1:getContentSize().height / 2))
	var_37_1:addChild(var_37_3)
	var_37_3:setScale(66 / math.min(var_37_3:getContentSize().width, var_37_3:getContentSize().height))

	if arg_37_3 == 3 then
		local var_37_4 = ccui.ImageView:create(var_0_27, var_0_3)

		var_37_4:setPosition(cc.p(var_37_1:getContentSize().width / 2, var_37_1:getContentSize().height / 2 + 15))
		var_37_4:setTouchEnabled(false)
		var_37_4:setScale9Enabled(true)
		var_37_4:setCapInsets(cc.rect(0, 0, 40, 40))
		var_37_4:setContentSize(cc.size(85, 90))
		var_37_4:setName("zhezhao" .. arg_37_4)
		arg_37_1:addChild(var_37_4, 2)
	end

	if arg_37_5 then
		local var_37_5 = ccui.ImageView:create("public/panelbg/act_add.png", var_0_3)

		var_37_5:setPosition(cc.p(var_37_3:getContentSize().width / 2 - 30, var_37_3:getContentSize().height + 5))
		var_37_5:setName("aaa" .. arg_37_4)
		var_37_5:setScale(0.8)
		var_37_3:addChild(var_37_5, 99)
	end

	local var_37_6 = cc.Label:createWithTTF("", FONT_DES, 16)

	var_37_6:setMaxLineWidth(190)
	var_37_6:setAnchorPoint(cc.p(0.5, 0.5))
	var_37_6:setString("x" .. arg_37_2.num)
	var_37_6:setPosition(cc.p(var_37_1:getContentSize().width / 2, var_37_1:getContentSize().height / 2 - 36))
	var_37_1:addChild(var_37_6)

	var_37_1.itemtype = "gold"

	if arg_37_2.itemid ~= "gold" and arg_37_2.itemid ~= "diamond" then
		var_37_1.itemtype = "item"
	end

	var_37_1:addTouchEventListener(function(arg_38_0, arg_38_1)
		if arg_38_1 ~= ccui.TouchEventType.ended then
			return
		end

		arg_37_0:showDetailsofItems(arg_37_2.itemid, var_37_1.itemtype)
	end)
end

function AdventureNewTowerLayer:showAwardInfo(arg_39_1, arg_39_2, arg_39_3, arg_39_4)
	for iter_39_0 = 1, 2 do
		if iter_39_0 ~= arg_39_4 and arg_39_1:getChildByName("btnpanel_" .. iter_39_0) then
			arg_39_1:getChildByName("btnpanel_" .. iter_39_0):setZOrder(20)

			if arg_39_1:getChildByName("btnpanel_" .. iter_39_0):getChildByName("showskill") then
				arg_39_1:getChildByName("btnpanel_" .. iter_39_0):getChildByName("showskill"):removeFromParent()
			end
		end
	end

	local var_39_0 = arg_39_1:getChildByName("btnpanel_" .. arg_39_4)

	var_39_0:setZOrder(21)

	if var_39_0:getChildByName("showskill") then
		var_39_0:getChildByName("showskill"):removeFromParent()

		return
	end

	local var_39_1 = ccui.Layout:create()

	var_39_1:setContentSize(cc.size(260, 120))
	var_39_1:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_39_1:setAnchorPoint(0, 1)
	var_39_1:setPosition(cc.p(var_39_0:getPositionX() / 2 - arg_39_4 * 70, var_39_0:getPositionY() / 2 - 36))
	var_39_1:setBackGroundColor(cc.c3b(0, 0, 0))
	var_39_1:setCascadeOpacityEnabled(false)
	var_39_1:setBackGroundColorOpacity(190)
	var_39_1:setName("showskill")
	var_39_1:setTouchEnabled(true)
	var_39_1:setScale(0)
	var_39_0:addChild(var_39_1, 100)

	local var_39_2 = cc.Label:createWithTTF("1", FONT_DES, 22)

	var_39_2:setMaxLineWidth(190)
	var_39_2:setAnchorPoint(cc.p(0.5, 0.5))
	var_39_2:setColor(cc.c3b(253, 211, 81))
	var_39_2:setPosition(cc.p(var_39_1:getContentSize().width / 2, var_39_1:getContentSize().height - 12))
	var_39_2:setName("Label1")
	var_39_2:setString(arg_39_2)
	var_39_1:addChild(var_39_2)

	local var_39_3 = cc.Label:createWithTTF("1", FONT_DES, 20)

	var_39_3:setMaxLineWidth(250)
	var_39_3:setAnchorPoint(cc.p(0, 1))
	var_39_3:setColor(cc.c3b(234, 232, 226))
	var_39_3:setPosition(cc.p(0, var_39_2:getPositionY() - var_39_2:getContentSize().height))
	var_39_3:setName("Label2")
	var_39_3:setString(arg_39_3)
	var_39_1:addChild(var_39_3)

	local var_39_4 = cc.EventListenerTouchOneByOne:create()

	var_39_4:setSwallowTouches(false)
	var_39_4:registerScriptHandler(function(arg_40_0, arg_40_1)
		return true
	end, cc.Handler.EVENT_TOUCH_BEGAN)
	var_39_4:registerScriptHandler(function(arg_41_0, arg_41_1)
		if var_39_0:getChildByName("showskill") then
			var_39_0:getChildByName("showskill"):removeFromParent()
		end
	end, cc.Handler.EVENT_TOUCH_ENDED)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(var_39_4, var_39_1)
	var_39_1:runAction((cc.ScaleTo:create(0.2, 1)))
end

function AdventureNewTowerLayer:initTableView()
	self.roleTableView:registerScriptHandler(function(arg_44_0, arg_44_1)
		return var_0_30, var_0_31
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.roleTableView:registerScriptHandler(function(arg_43_0, arg_43_1)
		local var_43_0 = arg_43_0:dequeueCell()

		if not var_43_0 then
			var_43_0 = cc.TableViewCell:create()

			var_43_0:setName("cell_" .. arg_43_1)

			local var_43_1 = self:createNode()

			var_43_1:setName("node")
			var_43_1:setPosition(cc.p(5, 5))
			self:updateNode(var_43_1, self.data[arg_43_1 + 1])

			if not self.sucessflag then
				if arg_43_1 <= math.floor(self.roleTableViewhight / var_0_31) then
					var_43_1:setOpacity(0)
					var_43_1:runAction(cc.Sequence:create(cc.DelayTime:create(0.05 * arg_43_1), cc.FadeIn:create(0.1)))
				else
					var_43_1:setOpacity(255)
				end
			end

			var_43_0:addChild(var_43_1)
		else
			local var_43_2 = var_43_0:getChildByName("node")

			var_43_2:setTag(arg_43_1)

			if not self.sucessflag then
				var_43_2:setOpacity(255)
			end

			self:updateNode(var_43_2, self.data[arg_43_1 + 1])
		end

		return var_43_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.roleTableView:registerScriptHandler(function(arg_45_0, arg_45_1)
		return #self.data
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.roleTableView:reloadData()

	if self.num < 6 then
		self.roleTableView:setContentOffset(cc.p(0, 0))
	elseif self.num >= #self.data - 1 then
		self.roleTableView:setContentOffset(cc.p(0, GameDisplay.getUiScreenSize().height - 63 - #self.data * var_0_31))
	else
		self.roleTableView:setContentOffset(cc.p(0, GameDisplay.getUiScreenSize().height - 63 - (self.num + 2) * var_0_31))
	end
end

function AdventureNewTowerLayer:getListData(arg_46_1)
	local var_46_1

	for iter_46_0, iter_46_1 in pairs(levelmode_data) do
		if iter_46_1.modetype == arg_46_1 then
			var_46_1 = iter_46_1
		end
	end

	if self.chaptermode then
		for iter_46_2, iter_46_3 in pairs(levelmode_data) do
			if iter_46_3.mode == self.chaptermode then
				var_46_1 = iter_46_3
			end
		end
	end

	if not var_46_1 then
		return
	end

	self.leveldata = var_46_1
	self.mode = var_46_1.mode
	self.numchapter = var_46_1.totalchapter
	self.ele_type = var_46_1.ele_type or var_46_1.element_type
	self.res_element = var_46_1.ele_type_show or self.ele_type
	self.curlevel = playermodel.levelmode[self.mode].status

	local var_46_2 = self:dealEndData2(global_deepCopy((self:getData(self.mode))))

	if self.sucessflag and self.sucessflag == 1 and self.beatbigboss then
		local var_46_3 = {}

		for iter_46_4 = #var_46_2 - (self.curlevel - 1) + 1, #var_46_2 do
			table.insert(var_46_3, var_46_2[iter_46_4])
		end

		self.newdata = var_46_2
		self.data = var_46_3

		self:initTableView()

		self.isscoll = true
	else
		self.data = var_46_2

		self:initTableView()
	end
end

function AdventureNewTowerLayer:getScollPercetn()
	return (self.tableviewcontensize / var_0_31 + (self.data[1].layer - self.curlevel + 1)) / #self.data * 100
end

function AdventureNewTowerLayer:getData(arg_48_1)
	if not arg_48_1 then
		return
	end

	local var_48_0 = {}

	for iter_48_0 = 1, level_manager:getModeTotalChapter(arg_48_1) do
		local var_48_1 = monster_manager.getLevelBoss(arg_48_1, iter_48_0 .. "-1")
		local var_48_2 = {
			bossmode = var_48_1.majorlist.modelid,
			layer = iter_48_0,
			item = self:getDropData((level_manager:getLevelDropID(arg_48_1, iter_48_0 .. "-1"))),
			isbigboss = var_48_1.isFinal
		}
		local var_48_3 = horcrux_manager:getMonsterHorcruxAssistConfig(var_48_1.majorlist)

		var_48_2.horcruxAffix = {}

		if var_48_3 then
			for iter_48_1, iter_48_2 in ipairs(var_48_3.skills) do
				var_48_2.horcruxAffix[iter_48_1] = {
					id = iter_48_2,
					name = total_skill_data[iter_48_2].name,
					des = string.format("%s。", total_skill_data[iter_48_2].description),
					icon = total_skill_data[iter_48_2].icon
				}
			end
		end

		var_48_0[iter_48_0] = var_48_2
		var_48_2.firstPassDrop = {
			items = {}
		}

		local var_48_4 = level_manager:getLevelFirstPassDrop(arg_48_1, iter_48_0 .. "-1")

		if var_48_4 then
			var_48_2.firstPassDrop = self:getDropData(var_48_4)
			var_48_2.firstPassDrop.status = level_manager:isPassedTower(arg_48_1, iter_48_0) and 3
		end
	end

	return var_48_0
end

function AdventureNewTowerLayer:dealEndData2(arg_49_1)
	local var_49_0 = {}
	local var_49_1 = {}
	local var_49_2 = {}
	local var_49_3 = {}
	local var_49_5 = #arg_49_1

	self.beatbigboss = not not (arg_49_1[self.curlevel - 1] and arg_49_1[self.curlevel - 1].isbigboss)

	if var_49_5 and arg_49_1[self.curlevel] then
		for iter_49_0 = 1, var_49_5 - self.curlevel do
			if arg_49_1[var_49_5 - iter_49_0 + 1] then
				arg_49_1[var_49_5 - iter_49_0 + 1].status = 1

				table.insert(var_49_0, arg_49_1[var_49_5 - iter_49_0 + 1])
			end
		end

		arg_49_1[self.curlevel].status = 2
		var_49_2 = arg_49_1[self.curlevel]

		for iter_49_1 = 1, self.curlevel - 1 do
			arg_49_1[self.curlevel - iter_49_1].status = 3

			table.insert(var_49_1, arg_49_1[self.curlevel - iter_49_1])
		end
	else
		for iter_49_2 = 1, #arg_49_1 do
			arg_49_1[#arg_49_1 - iter_49_2 + 1].status = 3

			table.insert(var_49_1, arg_49_1[#arg_49_1 - iter_49_2 + 1])
		end

		self.beatbigboss = false
	end

	if next(var_49_0) then
		var_49_3 = var_49_0
	end

	if next(var_49_2) then
		table.insert(var_49_3, var_49_2)
	end

	if next(var_49_1) then
		for iter_49_3, iter_49_4 in ipairs(var_49_1) do
			table.insert(var_49_3, iter_49_4)
		end
	end

	self.beatbigboss = not not (arg_49_1[self.curlevel - 1] and arg_49_1[self.curlevel - 1].isbigboss)
	self.num = #var_49_1

	return var_49_3
end

function AdventureNewTowerLayer:dealEndData(arg_50_1)
	local var_50_0 = {}
	local var_50_1 = {}
	local var_50_2 = {}
	local var_50_3 = 0

	if arg_50_1[self.curlevel + 3] then
		var_50_3 = 3
	elseif arg_50_1[self.curlevel + 2] then
		var_50_3 = 2
	elseif arg_50_1[self.curlevel + 1] then
		var_50_3 = 1
	end

	for iter_50_0 = 1, var_50_3 do
		arg_50_1[self.curlevel + var_50_3 - iter_50_0 + 1].status = 1

		table.insert(var_50_0, arg_50_1[self.curlevel + var_50_3 - iter_50_0 + 1])
	end

	if var_50_3 > 0 then
		var_50_2 = var_50_0
	end

	if self.curlevel <= self.numchapter then
		arg_50_1[self.curlevel].status = 2

		table.insert(var_50_2, arg_50_1[self.curlevel])
	end

	for iter_50_1 = 1, self.curlevel - 1 do
		arg_50_1[self.curlevel - iter_50_1].status = 3

		table.insert(var_50_1, arg_50_1[self.curlevel - iter_50_1])
	end

	if #var_50_1 > 0 then
		for iter_50_2, iter_50_3 in ipairs(var_50_1) do
			table.insert(var_50_2, iter_50_3)
		end
	end

	local var_50_4 = #var_50_2

	if #var_50_2 < 7 then
		for iter_50_4 = 1, 7 - #var_50_2 do
			table.insert(var_50_2, {
				istempdata = true,
				layer = var_50_4 + iter_50_4
			})
		end
	end

	return var_50_2
end

function AdventureNewTowerLayer.showBossInfo(arg_51_0, arg_51_1, arg_51_2, arg_51_3)
	local var_51_0 = {
		fight_type = "ADVENTURE",
		level = 1,
		mode = arg_51_1,
		chapter = arg_51_2,
		callback = arg_51_3
	}

	var_51_0.initindex = RoleDefault:getInstance():getIntegerForKey("adventurearray", 1)

	LayerManager:pushInLayer("LevelDetailLayer", var_51_0)
end

function AdventureNewTowerLayer:showDetailsofItems(arg_52_1, arg_52_2)
	local function var_52_1()
		return
	end

	if arg_52_2 == "item" then
		if var_0_16[arg_52_1].bag_item_type == kITEM_HORCRUX then
			local var_52_2 = -1
			local horcrux_data = require("data.horcrux_data")

			for iter_52_0, iter_52_1 in pairs((require("data.photofile_HelpGirl_data"))) do
				if iter_52_1.model_id == horcrux_data[arg_52_1].model then
					var_52_2 = iter_52_0

					break
				end
			end

			if var_52_2 == -1 then
				print("did not find id")

				return
			end

			LayerManager:pushInLayer("DetailsofHelpGirlLayer", {
				id = var_52_2,
				itemid = arg_52_1,
				callback = var_52_1
			})
		elseif var_0_16[arg_52_1].bag_item_type == kITEM_HERO then
			LayerManager:pushInLayer("SoulsLayer", {
				showtype = 6,
				layertype = "DropDetailsLayer",
				cursoul = var_0_16[arg_52_1].servant,
				exitCallback = var_52_1
			})
		elseif not self:getChildByName("OTHER_LAYER") then
			local var_52_4 = PopLayer:Item({
				hideGainButton = true,
				itemid = arg_52_1
			})
		end
	elseif arg_52_2 == "gold" then
		-- block empty
	elseif arg_52_2 == "diamond" then
		-- block empty
	end
end

function AdventureNewTowerLayer.dealChangeBtn(arg_54_0, arg_54_1, arg_54_2, arg_54_3)
	local var_54_0 = arg_54_1
	local var_54_1 = arg_54_2
	local var_54_2, var_54_3 = level_manager:isModeValid(arg_54_1)

	if not var_54_2 then
		audio_manager:playeffectMusicTest("sound/invalid")
		global_ShowBlockWords(level_manager:getModeUnlockMsg(arg_54_1, var_54_3))

		return
	end

	local function var_54_4(arg_55_0)
		if arg_55_0 == 1 then
			AnalyticManager.click_bosstower()
			LayerManager:switchShowLayer("FightLayer", {
				is_hide_topcost = true,
				is_hide_listbutton = true
			})
			FightManager.refreshFightToType(FIGHTTYPE_ADVENTURE_TOWER)
		else
			if arg_55_0 == 2 then
				audio_manager:playeffectMusicTest("sound/invalid")
				global_ShowBlockWords(L_ADVENTURE_WARNING[2])
			elseif arg_55_0 == 3 then
				audio_manager:playeffectMusicTest("sound/invalid")
				global_ShowBlockWords(L_ADVENTURE_WARNING[3])
			elseif arg_55_0 == 4 then
				audio_manager:playeffectMusicTest("sound/invalid")
				global_ShowBlockWords(L_ADVENTURE_WARNING[4])
			elseif arg_55_0 == 5 then
				audio_manager:playeffectMusicTest("sound/invalid")
				global_ShowBlockWords(L_ADVENTURE_WARNING[5])
			elseif arg_55_0 == 6 then
				audio_manager:playeffectMusicTest("sound/invalid")

				if chapter_data["" .. var_54_0 .. "-" .. var_54_1] and chapter_data["" .. var_54_0 .. "-" .. var_54_1].boss_combat then
					global_ShowBlockWords(L_ADVENTURE_WARNING[6] .. chapter_data["" .. var_54_0 .. "-" .. var_54_1].boss_combat .. L_ADVENTURE_WARNING[7])
				end
			elseif arg_55_0 == 8 then
				audio_manager:playeffectMusicTest("sound/invalid")
				global_ShowBlockWords(L_ADVENTURE_WARNING[8])
			end

			GuideListener.showAllGuidesWithFullScreen(true)
		end
	end

	local function var_54_5(arg_56_0)
		GuideListener.showAllGuidesWithFullScreen(false)
		RoleDefault:getInstance():setIntegerForKey("adventurearray", arg_56_0)
		RoleDefault:getInstance():setIntegerForKey("lastadventurearray", arg_56_0)
		level_manager:switchToAdventureMode(var_54_0, var_54_1, var_54_4, arg_56_0)
	end

	local var_54_6 = RoleDefault:getInstance():getIntegerForKey("adventurearray", 1)

	;(function()
		local var_57_0 = {
			mode = var_54_0
		}

		var_57_0.defaultIndex = RoleDefault:getInstance():getIntegerForKey("adventurearray", 1)
		var_57_0.configcallback = var_54_5
		var_57_0.exitcallback = arg_54_3

		var_0_14:pushFormationLayer("FormationElementsLayer", var_57_0)
	end)()
end

function AdventureNewTowerLayer.getDropData(arg_58_0, arg_58_1)
	local var_58_0 = {
		gold = 0,
		diamond = 0,
		items = {}
	}
	local var_58_1 = drop_data[arg_58_1] or {}

	if var_58_1.gold then
		var_58_0.gold = var_58_0.gold + var_58_1.gold
	end

	if var_58_1.diamond then
		var_58_0.diamond = var_58_0.diamond + var_58_1.diamond
	end

	local var_58_2 = 1

	if var_58_1["drop_id" .. 1] then
		local var_58_3 = 1

		while var_58_1["drop_id" .. var_58_3] do
			var_58_0.items[var_58_2] = {
				itemid = var_58_1["drop_id" .. var_58_3],
				num = var_58_1["drop_num" .. var_58_3]
			}
			var_58_3 = var_58_3 + 1
			var_58_2 = var_58_2 + 1
		end
	end

	if var_58_1["dropmodel_id" .. 1] then
		local var_58_4 = 1

		while var_58_1["dropmodel_id" .. var_58_4] do
			if drop_data[var_58_1["dropmodel_id" .. var_58_4]].gold then
				var_58_0.gold = var_58_0.gold + drop_data[var_58_1["dropmodel_id" .. var_58_4]].gold
			end

			if drop_data[var_58_1["dropmodel_id" .. var_58_4]].diamond then
				var_58_0.diamond = var_58_0.diamond + drop_data[var_58_1["dropmodel_id" .. var_58_4]].diamond
			end

			if drop_data[var_58_1["dropmodel_id" .. var_58_4]]["drop_id" .. 1] then
				local var_58_5 = 1

				while drop_data[var_58_1["dropmodel_id" .. var_58_4]]["drop_id" .. var_58_5] do
					var_58_0.items[var_58_2] = {
						itemid = drop_data[var_58_1["dropmodel_id" .. var_58_4]]["drop_id" .. var_58_5],
						num = drop_data[var_58_1["dropmodel_id" .. var_58_4]]["drop_num" .. var_58_5]
					}
					var_58_5 = var_58_5 + 1
					var_58_2 = var_58_2 + 1
				end
			end

			if drop_data[var_58_1["dropmodel_id" .. var_58_4]]["rd_drop_id" .. 1] then
				local var_58_6 = 1

				while drop_data[var_58_1["dropmodel_id" .. var_58_4]]["rd_drop_id" .. var_58_6] do
					var_58_0.items[var_58_2] = {
						itemid = drop_data[var_58_1["dropmodel_id" .. var_58_4]]["rd_drop_id" .. var_58_6],
						num = drop_data[var_58_1["dropmodel_id" .. var_58_4]]["rd_drop_num" .. var_58_6]
					}
					var_58_6 = var_58_6 + 1
					var_58_2 = var_58_2 + 1
				end
			end

			var_58_4 = var_58_4 + 1
		end
	end

	if var_58_1["rd_drop_id" .. 1] then
		local var_58_7 = 1

		while var_58_1["rd_drop_id" .. var_58_7] do
			var_58_0.items[var_58_2] = {
				itemid = var_58_1["rd_drop_id" .. var_58_7],
				num = var_58_1["rd_drop_num" .. var_58_7]
			}
			var_58_7 = var_58_7 + 1
			var_58_2 = var_58_2 + 1
		end
	end

	if var_58_1["rd_dropmodel_id" .. 1] then
		local var_58_8 = 1

		while var_58_1["rd_dropmodel_id" .. var_58_8] do
			if drop_data[var_58_1["rd_dropmodel_id" .. var_58_8]].gold then
				var_58_0.gold = var_58_0.gold + drop_data[var_58_1["rd_dropmodel_id" .. var_58_8]].gold
			end

			if drop_data[var_58_1["rd_dropmodel_id" .. var_58_8]].diamond then
				var_58_0.diamond = var_58_0.diamond + drop_data[var_58_1["rd_dropmodel_id" .. var_58_8]].diamond
			end

			if drop_data[var_58_1["rd_dropmodel_id" .. var_58_8]]["drop_id" .. 1] then
				local var_58_9 = 1

				while drop_data[var_58_1["rd_dropmodel_id" .. var_58_8]]["drop_id" .. var_58_9] do
					var_58_0.items[var_58_2] = {
						itemid = drop_data[var_58_1["rd_dropmodel_id" .. var_58_8]]["drop_id" .. var_58_9],
						num = drop_data[var_58_1["rd_dropmodel_id" .. var_58_8]]["drop_num" .. var_58_9]
					}
					var_58_9 = var_58_9 + 1
					var_58_2 = var_58_2 + 1
				end
			end

			if drop_data[var_58_1["rd_dropmodel_id" .. var_58_8]]["rd_drop_id" .. 1] then
				local var_58_10 = 1

				while drop_data[var_58_1["rd_dropmodel_id" .. var_58_8]]["rd_drop_id" .. var_58_10] do
					var_58_0.items[var_58_2] = {
						itemid = drop_data[var_58_1["rd_dropmodel_id" .. var_58_8]]["rd_drop_id" .. var_58_10],
						num = drop_data[var_58_1["rd_dropmodel_id" .. var_58_8]]["rd_drop_num" .. var_58_10]
					}
					var_58_10 = var_58_10 + 1
					var_58_2 = var_58_2 + 1
				end
			end

			var_58_8 = var_58_8 + 1
		end
	end

	return var_58_0
end

function AdventureNewTowerLayer.fullScreen(arg_59_0, arg_59_1)
	arg_59_1:setContentSize((GameDisplay.getScreenSize()))
	arg_59_1:setPositionY(arg_59_1:getPositionY() - GameDisplay.fix_y)
end
