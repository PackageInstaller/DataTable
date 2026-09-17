ActivityGroupFightLayer = class("ActivityGroupFightLayer", function()
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
local activity_manager = require("controller.activity_manager")
local level_manager = require("controller.level_manager")
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
local var_0_21 = {
	"adventurenewtowerlayer/changdi_1.png",
	"adventurenewtowerlayer/changdi_2.png",
	"adventurenewtowerlayer/changdi_3.png",
	"adventurenewtowerlayer/bai.png",
	"adventurenewtowerlayer/changdi_4.png"
}
local var_0_22 = {
	"adventurenewtowerlayer/namedi_1.png",
	"adventurenewtowerlayer/namedi_2.png",
	"adventurenewtowerlayer/bigboss_namedi.png"
}
local var_0_23 = {
	"adventurenewtowerlayer/bossinfo_1.png",
	"adventurenewtowerlayer/bossinfo_2.png",
	"adventurenewtowerlayer/bossinfo_3.png"
}
local var_0_24 = "adventurenewtowerlayer/getawrad.png"
local var_0_25 = {
	"adventurenewtowerlayer/bigboss_di.png",
	"adventurenewtowerlayer/bigboss_di1.png",
	"adventurenewtowerlayer/bigboss_tou3.png",
	"adventurenewtowerlayer/bigboss_tou4.png"
}
local var_0_26 = {
	"adventurenewtowerlayer/frame1.png",
	"adventurenewtowerlayer/frame2.png",
	"adventurenewtowerlayer/frame3.png"
}
local var_0_27 = 630
local var_0_28 = 192

function ActivityGroupFightLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = ActivityGroupFightLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function ActivityGroupFightLayer:init(arg_3_1)
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "AdventureNewTowerLayer.json" or "AdventureNewTowerLayer.ExportJson")

	self:addChild(self.rootLayer)

	self.activityId = arg_3_1.activityId
	self.num = 0

	self:initUI()
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" then
			activity_manager:releaseEventListenerByName("ActivityGroupFightLayer")
		end
	end)
end

function ActivityGroupFightLayer:initUI()
	self.bg = ccui.Helper:seekWidgetByName(self.rootLayer, "bg")

	self.bg:loadTexture("mainScenebg/roledatabg.jpg")
	self.bg:setPosition(cc.p(320, GameDisplay.getScreenSize().height / 2))

	self.backdi = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_bottom")

	self.backdi:setPosition(cc.p(320, 31))
	self.backdi:setZOrder(10000)

	self.back = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_23")

	self.back:addTouchEventListener(function(arg_6_0, arg_6_1)
		if arg_6_1 ~= ccui.TouchEventType.ended then
			return
		end

		KeyCodeManager:onKeyReleasedCallFunc()
	end)

	local var_5_0 = ccui.ImageView:create("adventurenewtowerlayer/top.png", var_0_3)

	var_5_0:setAnchorPoint(cc.p(0.5, 1))
	var_5_0:setPosition(320, GameDisplay.height)
	var_5_0:setTouchEnabled(true)
	self.rootLayer:addChild(var_5_0, 100)

	local var_5_1 = ccui.ImageView:create("adventurenewtowerlayer/title.png", var_0_3)

	var_5_1:setAnchorPoint(cc.p(0, 0.5))
	var_5_1:setPosition(10, var_5_0:getContentSize().height / 2)
	var_5_0:addChild(var_5_1)

	local var_5_2 = ccui.ImageView:create("adventurenewtowerlayer/detail.png", var_0_3)

	var_5_2:setAnchorPoint(cc.p(0, 0.5))
	var_5_2:setPosition(145, var_5_0:getContentSize().height / 2)
	var_5_0:addChild(var_5_2)
	var_5_1:setTouchEnabled(true)
	var_5_1:addTouchEventListener(function(arg_7_0, arg_7_1)
		if arg_7_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopActivityDetail", {
			key = "ActivityGrouptower_" .. self.activityId
		})
	end)
	var_5_2:setTouchEnabled(true)
	var_5_2:addTouchEventListener(function(arg_8_0, arg_8_1)
		if arg_8_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopActivityDetail", {
			key = "ActivityGrouptower_" .. self.activityId
		})
	end)

	local var_5_3 = ccui.Helper:seekWidgetByName(self.rootLayer, "auto_fight_bg")
	local var_5_4 = ccui.Helper:seekWidgetByName(self.rootLayer, "auto_fight_choose")

	self.autoFight = RoleDefault:getInstance():getBoolForKey("GroupTowerAutoFight")

	var_5_4:setVisible(self.autoFight)
	var_5_3:setTouchEnabled(true)
	var_5_3:addTouchEventListener(function(arg_9_0, arg_9_1)
		if arg_9_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.autoFight = not self.autoFight

		var_5_4:setVisible(self.autoFight)
		RoleDefault:getInstance():setBoolForKey("GroupTowerAutoFight", self.autoFight)
	end)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("set_group_autofight_false", function(arg_10_0)
		self.autoFight = false

		var_5_4:setVisible(self.autoFight)
	end), self)
	self.rootLayer:setContentSize((GameDisplay.getScreenSize()))
	self.rootLayer:setPositionY(self.rootLayer:getPositionY() - GameDisplay.fix_y)

	self.modetype = ACTIVITY_ID_TO_MODETYPE_FUNC.group_tower(self.activityId)
	self.mode = self.modetype * 10 + 1

	activity_manager:getGroupmode(self.mode)
	self:getListData(self.modetype)
end

function ActivityGroupFightLayer:getListData(arg_11_1)
	self.res_element = levelmode_data[self.mode].ele_type_show or levelmode_data[self.mode].ele_type
	self.numchapter = levelmode_data[self.mode].totalchapter
	self.curlevel = playermodel.levelmode[self.mode].status
	self.maxLevel = playermodel.levelmode[self.mode].status
	self.data = self:getData()

	self:initTableView()
end

function ActivityGroupFightLayer:getData()
	local var_12_0 = {}

	self.isGroupList = {}

	for iter_12_0 = 1, level_manager:getModeTotalChapter(self.mode) do
		local var_12_1 = monster_manager.getLevelBoss(self.mode, iter_12_0 .. "-1")
		local var_12_2 = {
			bossmode = var_12_1.majorlist.modelid,
			layer = iter_12_0,
			item = self:getDropData((level_manager:getLevelDropID(self.mode, iter_12_0 .. "-1"))),
			isbigboss = var_12_1.isFinal,
			isGroup = var_12_1.isGroup
		}
		local var_12_3 = horcrux_manager:getMonsterHorcruxAssistConfig(var_12_1.majorlist)

		var_12_2.horcruxAffix = {}

		if var_12_3 then
			for iter_12_1, iter_12_2 in ipairs(var_12_3.skills) do
				var_12_2.horcruxAffix[iter_12_1] = {
					id = iter_12_2,
					name = total_skill_data[iter_12_2].name,
					des = string.format("%s。", total_skill_data[iter_12_2].description),
					icon = total_skill_data[iter_12_2].icon
				}
			end
		end

		var_12_2.status = iter_12_0 == self.curlevel and 2 or iter_12_0 > self.curlevel and 1 or 3
		var_12_0[iter_12_0] = var_12_2
	end

	self.num = self.curlevel

	return var_12_0
end

function ActivityGroupFightLayer:createNode()
	local var_13_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "items"):clone()

	var_13_0:setTouchEnabled(false)

	local var_13_1 = ccui.ImageView:create("public/career_icon/restrain_tip_1.png", var_0_3)

	var_13_1:setName("restrainTip")
	var_13_1:setPosition(cc.p(118, 158))
	var_13_0:addChild(var_13_1)

	local var_13_2 = ccui.Layout:create()

	var_13_2:setContentSize(var_13_0:getContentSize())
	var_13_2:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_13_2:setAnchorPoint(0, 0)
	var_13_2:setPosition(cc.p(0, 0))
	var_13_2:setBackGroundColor(cc.c3b(0, 0, 0))
	var_13_2:setCascadeOpacityEnabled(false)
	var_13_2:setBackGroundColorOpacity(190)
	var_13_2:setName("usedServant")
	var_13_2:setVisible(false)
	var_13_0:addChild(var_13_2, 100)

	local var_13_3 = ccui.ImageView:create("adventurenewtowerlayer/groupTip.png", var_0_3)

	var_13_3:setName("groupTip")
	var_13_3:setPosition(cc.p(48, 148))
	var_13_0:addChild(var_13_3, 100)

	for iter_13_0 = 1, 5 do
		local var_13_4 = ccui.ImageView:create("public/box/material_red.png", var_0_3)

		var_13_4:setPosition(cc.p(-50 + 120 * iter_13_0, 75))
		var_13_4:setName("servantBg" .. iter_13_0)
		var_13_2:addChild(var_13_4)

		local var_13_5 = ccui.ImageView:create("public/box/material_red.png", var_0_3)

		var_13_5:setPosition(cc.p(var_13_4:getContentSize().width / 2, var_13_4:getContentSize().height / 2))
		var_13_5:setName("servantIcon" .. iter_13_0)
		var_13_5:setScale(0.5)
		var_13_4:addChild(var_13_5)
	end

	return var_13_0
end

function ActivityGroupFightLayer:updateNode(arg_14_1, arg_14_2)
	local var_14_0 = ccui.Helper:seekWidgetByName(arg_14_1, "ani_1")
	local var_14_1 = ccui.Helper:seekWidgetByName(arg_14_1, "ani_2")
	local var_14_2 = ccui.Helper:seekWidgetByName(arg_14_1, "bossface")
	local var_14_3 = ccui.Helper:seekWidgetByName(arg_14_1, "name_di")
	local var_14_4 = ccui.Helper:seekWidgetByName(arg_14_1, "detail_btn")
	local var_14_5 = ccui.Helper:seekWidgetByName(arg_14_1, "ceshu")
	local var_14_6 = ccui.Helper:seekWidgetByName(arg_14_1, "change_btn")
	local var_14_7 = ccui.Helper:seekWidgetByName(arg_14_1, "usedServant")
	local var_14_8 = ccui.Helper:seekWidgetByName(arg_14_1, "groupTip")

	if arg_14_2.array and next(arg_14_2.array) then
		var_14_7:setVisible(true)

		for iter_14_0 = 1, 5 do
			local var_14_9 = ccui.Helper:seekWidgetByName(arg_14_1, "servantBg" .. iter_14_0)

			if arg_14_2.array[iter_14_0] then
				var_14_9:setVisible(true)
				ccui.Helper:seekWidgetByName(arg_14_1, "servantIcon" .. iter_14_0):loadTexture(ROLE_HEAD_IMAGE_PATH .. model_data[global_get_servant_skin(arg_14_2.array[iter_14_0])].head_image .. ".png")
			else
				var_14_9:setVisible(false)
			end
		end
	else
		var_14_7:setVisible(false)
	end

	var_14_5:setString("")
	var_14_4:setPositionY(115)
	var_14_4:setPositionX(307)

	if not arg_14_2.isbigboss then
		var_14_0:loadTexture("adventurenewtowerlayer/tou_1.png", var_0_3)
		var_14_1:loadTexture("adventurenewtowerlayer/tou_2.png", var_0_3)
	else
		var_14_0:loadTexture("adventurenewtowerlayer/bigboss_tou3.png", var_0_3)
		var_14_1:loadTexture("adventurenewtowerlayer/bigboss_tou4.png", var_0_3)
	end

	self:updataImage(arg_14_1, arg_14_2)
	var_14_4:setSwallowTouches(false)

	local var_14_10

	if arg_14_2.status == 1 then
		if arg_14_1:getChildByName("sucess") then
			arg_14_1:getChildByName("sucess"):removeFromParent()
		end

		if arg_14_1:getChildByName("bosssucess") then
			arg_14_1:getChildByName("bosssucess"):removeFromParent()
		end

		if not arg_14_2.isbigboss then
			arg_14_1:setBackGroundImage(var_0_21[2], var_0_3)
			var_14_4:loadTextures(var_0_23[2], nil, var_0_23[2], var_0_3)
			var_14_3:loadTexture(var_0_22[2], var_0_3)

			var_14_10 = "<p>" .. string.format(L_ADVENTURE_TOWER_FLOOR_NOT_BOSS, arg_14_2.layer)
		else
			arg_14_1:setBackGroundImage(var_0_25[2], var_0_3)
			var_14_4:loadTextures(var_0_23[3], nil, var_0_23[3], var_0_3)
			var_14_3:loadTexture(var_0_22[3], var_0_3)

			var_14_10 = "<p>" .. string.format(L_ADVENTURE_TOWER_FLOOR_BOSS, arg_14_2.layer)
		end

		var_14_3:setVisible(true)
		var_14_0:setVisible(false)
		var_14_1:setVisible(false)
		var_14_6:setVisible(false)
	elseif arg_14_2.status == 2 then
		if arg_14_1:getChildByName("bosssucess") then
			arg_14_1:getChildByName("bosssucess"):removeFromParent()
		end

		if not arg_14_2.isbigboss then
			arg_14_1:setBackGroundImage(var_0_21[1], var_0_3)
			var_14_4:loadTextures(var_0_23[1], nil, var_0_23[1], var_0_3)
			var_14_3:loadTexture(var_0_22[1], var_0_3)

			var_14_10 = "<p>" .. string.format(L_ADVENTURE_TOWER_FLOOR_NOW, arg_14_2.layer)
		else
			arg_14_1:setBackGroundImage(var_0_25[1], var_0_3)
			var_14_4:loadTextures(var_0_23[3], nil, var_0_23[3], var_0_3)
			var_14_3:loadTexture(var_0_22[3], var_0_3)

			var_14_10 = "<p>" .. string.format(L_ADVENTURE_TOWER_FLOOR_BOSS, arg_14_2.layer)
		end

		var_14_3:setVisible(true)
		var_14_0:setVisible(true)
		var_14_1:setVisible(true)
		var_14_6:setVisible(true)
		self:playain(arg_14_1)

		if var_14_5:getChildByName("richTextWord") then
			var_14_5:getChildByName("richTextWord"):removeFromParent()
		end

		local var_14_11 = require("view.Sprite.RichTextPro"):create()

		var_14_11:setMaxWidth(550)
		var_14_11:setSize(27)
		var_14_11:setLineSpace(0)
		var_14_11:setText(var_14_10, nil, true)
		var_14_11:setName("richTextWord")
		var_14_11:setPosition(cc.p((arg_14_2.layer >= 100 or nil) and -15, 40))
		var_14_5:addChild(var_14_11)
	elseif arg_14_2.status == 3 then
		if arg_14_1:getChildByName("sucess") then
			arg_14_1:getChildByName("sucess"):removeFromParent()
		end

		if arg_14_1:getChildByName("bosssucess") then
			arg_14_1:getChildByName("bosssucess"):removeFromParent()
		end

		local var_14_13 = ccui.ImageView:create("adventurenewtowerlayer/yitiaozhan.png", var_0_3)

		var_14_13:setScale(1)
		var_14_13:setAnchorPoint(cc.p(0.5, 0.5))
		var_14_13:setName("bosssucess")
		var_14_13:setPosition(cc.p(arg_14_1:getContentSize().width / 2 + 240, arg_14_1:getContentSize().height / 2 - 13))
		arg_14_1:addChild(var_14_13, 10000)

		if not arg_14_2.isbigboss then
			arg_14_1:setBackGroundImage(var_0_21[3], var_0_3)

			if arg_14_1:getChildByName("bosssucess") then
				arg_14_1:getChildByName("bosssucess"):removeFromParent()
			end

			var_14_3:loadTexture(var_0_22[2], var_0_3)

			var_14_10 = "<p>" .. string.format(L_ADVENTURE_TOWER_FLOOR_BOSS_SUCCESS, arg_14_2.layer)
		else
			arg_14_1:setBackGroundImage(var_0_25[1], var_0_3)
			var_14_3:loadTexture(var_0_22[3], var_0_3)

			var_14_10 = "<p>" .. string.format(L_ADVENTURE_TOWER_FLOOR_BOSS, arg_14_2.layer)
		end

		var_14_4:loadTextures(var_0_23[2], nil, var_0_23[2], var_0_3)
		var_14_0:setVisible(false)
		var_14_1:setVisible(false)
		var_14_6:setVisible(false)

		if var_14_5:getChildByName("richTextWord") then
			var_14_5:getChildByName("richTextWord"):removeFromParent()
		end

		local var_14_14 = require("view.Sprite.RichTextPro"):create()

		var_14_14:setMaxWidth(550)
		var_14_14:setSize(25)
		var_14_14:setLineSpace(0)
		var_14_14:setText(var_14_10, nil, true)
		var_14_14:setName("richTextWord")
		var_14_14:setPosition(cc.p((arg_14_2.layer >= 100 or nil) and -15, 40))
		var_14_5:addChild(var_14_14)
	end

	if var_14_10 then
		if var_14_5:getChildByName("richTextWord") then
			var_14_5:getChildByName("richTextWord"):removeFromParent()
		end

		local var_14_16 = require("view.Sprite.RichTextPro"):create()

		var_14_16:setMaxWidth(550)
		var_14_16:setSize(27)
		var_14_16:setLineSpace(0)
		var_14_16:setText(var_14_10, nil, true)
		var_14_16:setName("richTextWord")
		var_14_16:setPosition(cc.p((arg_14_2.layer >= 100 or nil) and -15, 40))
		var_14_5:addChild(var_14_16)
	end

	var_14_2:loadTextures("role1/" .. model_data[arg_14_2.bossmode].cute_role .. ".png", nil, "role1/" .. model_data[arg_14_2.bossmode].cute_role .. ".png")
	var_14_2:setScale(0.35)
	var_14_2:setTouchEnabled(true)
	var_14_2:setSwallowTouches(false)
	var_14_3:getChildByName("bossname"):setFontSize(20)
	var_14_3:getChildByName("bossname"):setString(model_data[arg_14_2.bossmode].name)
	var_14_2:setPositionY(110)
	var_14_6:addTouchEventListener(function(arg_15_0, arg_15_1)
		if arg_15_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_14_2.status == 3 then
			return
		end

		self:dealChangeBtn(self.mode, arg_14_2.layer, callback)
	end)
	var_14_2:addTouchEventListener(function(arg_16_0, arg_16_1)
		if arg_16_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_14_2.status == 3 then
			return
		end

		self:showBossInfo(self.mode, arg_14_2.layer, callback)
	end)

	local var_14_18 = arg_14_1:getChildByName("restrainTip")

	if self.res_element then
		var_14_18:setVisible(true)
		var_14_18:loadTexture("public/career_icon/restrain_tip_" .. ATTR_INDEX[self.res_element] .. ".png", var_0_3)
	else
		var_14_18:setVisible(false)
	end

	if arg_14_2.isGroup then
		var_14_8:setVisible(true)
	else
		var_14_8:setVisible(false)
	end
end

function ActivityGroupFightLayer.playain(arg_17_0, arg_17_1)
	arg_17_1:getChildByName("ani_1"):runAction(cc.RepeatForever:create(cc.RotateBy:create(6, -360)))
	arg_17_1:getChildByName("ani_2"):runAction(cc.RepeatForever:create(cc.RotateBy:create(6, 360)))
end

function ActivityGroupFightLayer.updataImage(arg_18_0, arg_18_1, arg_18_2)
	local var_18_1 = {}

	if arg_18_2.item.items and #arg_18_2.item.items > 0 then
		for iter_18_0, iter_18_1 in ipairs(arg_18_2.item.items) do
			if iter_18_1.num and iter_18_1.num > 0 then
				table.insert(var_18_1, iter_18_1)
			end
		end
	end

	if arg_18_2.item.gold and arg_18_2.item.gold > 0 then
		table.insert(var_18_1, {
			itemid = "gold",
			num = arg_18_2.item.gold
		})
	end

	if arg_18_2.item.diamond and arg_18_2.item.diamond > 0 then
		table.insert(var_18_1, {
			itemid = "diamond",
			num = arg_18_2.item.diamond
		})
	end

	local var_18_2 = #var_18_1

	if #var_18_1 <= 0 then
		return
	end

	local var_18_4 = var_18_2 == 1 and 1 or var_18_2 == 2 and 2 or 3
	local var_18_5 = 1

	while arg_18_1:getChildByName("award" .. var_18_5) do
		arg_18_1:getChildByName("award" .. var_18_5):removeFromParent()

		if arg_18_1:getChildByName("zhezhao" .. var_18_5) then
			arg_18_1:getChildByName("zhezhao" .. var_18_5):removeFromParent()
		end

		var_18_5 = var_18_5 + 1
	end

	for iter_18_2 = 1, var_18_4 do
		local var_18_7 = type(var_18_1[iter_18_2].itemid) == "string" and ccui.Button:create("public/box/" .. "1" .. ".png", "public/box/" .. "1" .. ".png", nil, var_0_3) or ccui.Button:create("public/box/" .. var_0_16[var_18_1[iter_18_2].itemid].equip_quality .. ".png", "public/box/" .. var_0_16[var_18_1[iter_18_2].itemid].equip_quality .. ".png", nil, var_0_3)

		var_18_7:setAnchorPoint(cc.p(0.5, 0.5))
		var_18_7:setPosition(cc.p(0, 0))
		var_18_7:setTouchEnabled(true)
		var_18_7:setSwallowTouches(false)
		var_18_7:setPosition(cc.p(266 + (iter_18_2 - 1) * 90, 60))
		var_18_7:setName("award" .. iter_18_2)
		arg_18_1:addChild(var_18_7, 1)

		local var_18_8
		local var_18_9

		if var_18_1[iter_18_2].itemid == "gold" and var_18_1[iter_18_2].num > 0 then
			var_18_8 = "equipment/1000001.png"
		elseif var_18_1[iter_18_2].itemid == "diamond" and var_18_1[iter_18_2].num > 0 then
			var_18_8 = "equipment/1000000.png"
		elseif var_0_16[var_18_1[iter_18_2].itemid].image_id then
			var_18_8 = "equipment/" .. var_0_16[var_18_1[iter_18_2].itemid].image_id .. ".png"
		else
			var_18_9 = var_0_16[var_18_1[iter_18_2].itemid].bag_item_type == kITEM_MEDAL and ItemSprite:create_medal_icon(var_18_1[iter_18_2].itemid) or component_manager:create_component_icon(var_18_1[iter_18_2].itemid, nil, nil)
		end

		var_18_9 = var_18_9 or ccui.ImageView:create(var_18_8)

		var_18_9:setPosition(cc.p(var_18_7:getContentSize().width / 2, var_18_7:getContentSize().height / 2))
		var_18_7:addChild(var_18_9)
		var_18_9:setScale(66 / math.min(var_18_9:getContentSize().width, var_18_9:getContentSize().height))

		if arg_18_2.status == 3 then
			local var_18_10 = ccui.ImageView:create(var_0_24, var_0_3)

			var_18_10:setPosition(cc.p(var_18_7:getContentSize().width / 2, var_18_7:getContentSize().height / 2 + 15))
			var_18_10:setTouchEnabled(false)
			var_18_10:setScale9Enabled(true)
			var_18_10:setCapInsets(cc.rect(0, 0, 40, 40))
			var_18_10:setContentSize(cc.size(85, 90))
			var_18_10:setName("zhezhao" .. iter_18_2)
			arg_18_1:addChild(var_18_10, 2)
		end

		local var_18_11 = cc.Label:createWithTTF("", FONT_DES, 16)

		var_18_11:setMaxLineWidth(190)
		var_18_11:setAnchorPoint(cc.p(0.5, 0.5))
		var_18_11:setString("x" .. var_18_1[iter_18_2].num)
		var_18_11:setPosition(cc.p(var_18_7:getContentSize().width / 2, var_18_7:getContentSize().height / 2 - 36))
		var_18_7:addChild(var_18_11)

		var_18_7.itemtype = "gold"

		if var_18_1[iter_18_2].itemid ~= "gold" and var_18_1[iter_18_2].itemid ~= "diamond" then
			var_18_7.itemtype = "item"
		end

		var_18_7:addTouchEventListener(function(arg_19_0, arg_19_1)
			if arg_19_1 ~= ccui.TouchEventType.ended then
				return
			end

			if arg_18_2.status == 3 then
				return
			end

			arg_18_0:showDetailsofItems(var_18_1[iter_18_2].itemid, var_18_7.itemtype)
		end)
	end

	if var_18_4 == 1 and arg_18_1:getChildByName("award" .. 1) then
		arg_18_1:getChildByName("award" .. 1):setPositionX(316)

		if arg_18_1:getChildByName("zhezhao" .. 1) then
			arg_18_1:getChildByName("zhezhao" .. 1):setPositionX(316)
		end
	end

	local var_18_12 = {
		266,
		356,
		445
	}

	if var_18_4 == 3 then
		for iter_18_3 = 1, 3 do
			if arg_18_1:getChildByName("award" .. iter_18_3) then
				arg_18_1:getChildByName("award" .. iter_18_3):setPositionX(var_18_12[iter_18_3] - 40)
			end

			if arg_18_1:getChildByName("zhezhao" .. iter_18_3) then
				arg_18_1:getChildByName("zhezhao" .. iter_18_3):setPositionX(var_18_12[iter_18_3] - 40)
			end
		end
	end

	local var_18_13 = {
		266,
		356
	}

	if var_18_4 == 2 then
		for iter_18_4 = 1, 2 do
			if arg_18_1:getChildByName("zhezhao" .. iter_18_4) then
				arg_18_1:getChildByName("zhezhao" .. iter_18_4):setPositionX(var_18_13[iter_18_4])
			end
		end
	end

	local var_18_14 = arg_18_2.horcruxAffix
	local var_18_16 = 1

	while arg_18_1:getChildByName("btnpanel_" .. var_18_16) do
		arg_18_1:getChildByName("btnpanel_" .. var_18_16):removeFromParent()

		var_18_16 = var_18_16 + 1
	end

	local var_18_17

	if arg_18_2.isbigboss then
		var_18_17 = var_0_26[3]
	elseif arg_18_2.status == 1 or arg_18_2.status == 3 then
		var_18_17 = var_0_26[2]
	elseif arg_18_2.status == 2 then
		var_18_17 = var_0_26[1]
	end

	for iter_18_5 = 1, 2 do
		if var_18_14[iter_18_5] then
			local var_18_18 = ccui.Layout:create()

			var_18_18:setContentSize(cc.size(140, 36))
			var_18_18:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
			var_18_18:setAnchorPoint(0.5, 0.5)
			var_18_18:setBackGroundColor(cc.c3b(0, 0, 0))
			var_18_18:setTouchEnabled(false)
			var_18_18:setName("btnpanel_" .. iter_18_5)
			var_18_18:setPosition(cc.p(arg_18_1:getContentSize().width / 2 - 50 + (iter_18_5 - 1) * 130, arg_18_1:getContentSize().height / 2 + 60))
			arg_18_1:addChild(var_18_18, 10)

			local var_18_19 = ccui.ImageView:create(var_18_17, var_0_3)

			var_18_19:setPosition(cc.p(var_18_18:getContentSize().width / 2 - 50, var_18_18:getContentSize().height / 2 - 3))
			var_18_18:addChild(var_18_19)
			var_18_19:setTouchEnabled(false)

			local var_18_20 = ccui.Button:create("skill_new/skill/" .. var_18_14[iter_18_5].icon .. ".png", "skill_new/skill/" .. var_18_14[iter_18_5].icon .. ".png", nil, var_0_3)

			var_18_20:setName("btnSkill_" .. iter_18_5)
			var_18_20:setPosition(cc.p(var_18_19:getContentSize().width / 2, var_18_19:getContentSize().height / 2))
			var_18_20:setScale((math.min(37 / var_18_20:getContentSize().width, 37 / var_18_20:getContentSize().height)))
			var_18_19:addChild(var_18_20)
			var_18_20:setTouchEnabled(true)
			var_18_20:setSwallowTouches(false)
			var_18_20:addTouchEventListener(function(arg_20_0, arg_20_1)
				if arg_20_1 ~= ccui.TouchEventType.ended then
					return
				end

				if arg_18_2.status == 3 then
					return
				end

				arg_18_0:showAwardInfo(arg_18_1, var_18_14[iter_18_5].name, var_18_14[iter_18_5].des, iter_18_5)
			end)

			local var_18_21 = cc.Label:createWithTTF("1", FONT_DES, 20)

			var_18_21:setMaxLineWidth(190)
			var_18_21:setAnchorPoint(cc.p(0, 0.5))
			var_18_21:setString(var_18_14[iter_18_5].name)
			var_18_21:setPosition(cc.p(var_18_19:getPositionX() + 27, var_18_19:getPositionY()))
			var_18_18:addChild(var_18_21)
		end
	end
end

function ActivityGroupFightLayer:showAwardInfo(arg_21_1, arg_21_2, arg_21_3, arg_21_4)
	for iter_21_0 = 1, 2 do
		if iter_21_0 ~= arg_21_4 and arg_21_1:getChildByName("btnpanel_" .. iter_21_0) then
			arg_21_1:getChildByName("btnpanel_" .. iter_21_0):setZOrder(20)

			if arg_21_1:getChildByName("btnpanel_" .. iter_21_0):getChildByName("showskill") then
				arg_21_1:getChildByName("btnpanel_" .. iter_21_0):getChildByName("showskill"):removeFromParent()
			end
		end
	end

	local var_21_0 = arg_21_1:getChildByName("btnpanel_" .. arg_21_4)

	var_21_0:setZOrder(21)

	if var_21_0:getChildByName("showskill") then
		var_21_0:getChildByName("showskill"):removeFromParent()

		return
	end

	local var_21_1 = ccui.Layout:create()

	var_21_1:setContentSize(cc.size(260, 120))
	var_21_1:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_21_1:setAnchorPoint(0, 1)
	var_21_1:setPosition(cc.p(var_21_0:getPositionX() / 2 - arg_21_4 * 70, var_21_0:getPositionY() / 2 - 36))
	var_21_1:setBackGroundColor(cc.c3b(0, 0, 0))
	var_21_1:setCascadeOpacityEnabled(false)
	var_21_1:setBackGroundColorOpacity(190)
	var_21_1:setName("showskill")
	var_21_1:setTouchEnabled(true)
	var_21_1:setScale(0)
	var_21_0:addChild(var_21_1, 100)

	local var_21_2 = cc.Label:createWithTTF("1", FONT_DES, 22)

	var_21_2:setMaxLineWidth(190)
	var_21_2:setAnchorPoint(cc.p(0.5, 0.5))
	var_21_2:setColor(cc.c3b(253, 211, 81))
	var_21_2:setPosition(cc.p(var_21_1:getContentSize().width / 2, var_21_1:getContentSize().height - 12))
	var_21_2:setName("Label1")
	var_21_2:setString(arg_21_2)
	var_21_1:addChild(var_21_2)

	local var_21_3 = cc.Label:createWithTTF("1", FONT_DES, 20)

	var_21_3:setMaxLineWidth(250)
	var_21_3:setAnchorPoint(cc.p(0, 1))
	var_21_3:setColor(cc.c3b(234, 232, 226))
	var_21_3:setPosition(cc.p(0, var_21_2:getPositionY() - var_21_2:getContentSize().height))
	var_21_3:setName("Label2")
	var_21_3:setString(arg_21_3)
	var_21_1:addChild(var_21_3)

	local var_21_4 = cc.EventListenerTouchOneByOne:create()

	var_21_4:setSwallowTouches(false)
	var_21_4:registerScriptHandler(function(arg_22_0, arg_22_1)
		return true
	end, cc.Handler.EVENT_TOUCH_BEGAN)
	var_21_4:registerScriptHandler(function(arg_23_0, arg_23_1)
		if var_21_0:getChildByName("showskill") then
			var_21_0:getChildByName("showskill"):removeFromParent()
		end
	end, cc.Handler.EVENT_TOUCH_ENDED)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(var_21_4, var_21_1)
	var_21_1:runAction((cc.ScaleTo:create(0.2, 1)))
end

function ActivityGroupFightLayer:initTableView()
	if self.roleTableView then
		self.roleTableView:reloadData()

		return
	end

	local var_24_0 = GameDisplay.getUiScreenSize().height - 63

	self.roleTableView = cc.TableView:create(cc.size(640, var_24_0))

	self.roleTableView:setPosition(cc.p(0, self.backdi:getPositionY() + self.backdi:getContentSize().height / 2 - 60))
	self.roleTableView:setDelegate()
	self.roleTableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.rootLayer:addChild(self.roleTableView)
	self.roleTableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_BOTTOMUP)

	self.roleTableViewhight = var_24_0

	self.roleTableView:registerScriptHandler(function(arg_26_0, arg_26_1)
		return var_0_27, var_0_28
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.roleTableView:registerScriptHandler(function(arg_25_0, arg_25_1)
		local var_25_0 = arg_25_0:dequeueCell()

		if not var_25_0 then
			var_25_0 = cc.TableViewCell:create()

			local var_25_1 = self:createNode()

			var_25_1:setName("node")
			var_25_1:setPosition(cc.p(5, 5))
			self:updateNode(var_25_1, self.data[arg_25_1 + 1])
			var_25_0:addChild(var_25_1)
		else
			self:updateNode(var_25_0:getChildByName("node"), self.data[arg_25_1 + 1])
		end

		return var_25_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.roleTableView:registerScriptHandler(function(arg_27_0, arg_27_1)
		return #self.data
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.roleTableView:reloadData()

	if self.num < 6 then
		self.roleTableView:setContentOffset(cc.p(0, 0))
	elseif self.num >= #self.data - 1 then
		self.roleTableView:setContentOffset(cc.p(0, GameDisplay.getUiScreenSize().height - 63 - #self.data * var_0_28))
	else
		self.roleTableView:setContentOffset(cc.p(0, GameDisplay.getUiScreenSize().height - 63 - (self.num + 2) * var_0_28))
	end
end

function ActivityGroupFightLayer.showBossInfo(arg_28_0, arg_28_1, arg_28_2, arg_28_3)
	local var_28_0 = {
		fight_type = "GroupFightLayer",
		level = 1,
		mode = arg_28_1,
		chapter = arg_28_2,
		callback = arg_28_3
	}

	var_28_0.initindex = RoleDefault:getInstance():getIntegerForKey("adventurearray", 1)

	LayerManager:pushInLayer("LevelDetailGroupLayer", var_28_0)
end

function ActivityGroupFightLayer.showDetailsofItems(arg_29_0, arg_29_1, arg_29_2)
	if arg_29_2 == "item" then
		if var_0_16[arg_29_1].bag_item_type == kITEM_HORCRUX then
			local var_29_1 = -1
			local horcrux_data = require("data.horcrux_data")

			for iter_29_0, iter_29_1 in pairs((require("data.photofile_HelpGirl_data"))) do
				if iter_29_1.model_id == horcrux_data[arg_29_1].model then
					var_29_1 = iter_29_0

					break
				end
			end

			if var_29_1 == -1 then
				print("did not find id")

				return
			end

			LayerManager:pushInLayer("DetailsofHelpGirlLayer", {
				id = var_29_1,
				itemid = arg_29_1
			})
		elseif var_0_16[arg_29_1].bag_item_type == kITEM_HERO then
			LayerManager:pushInLayer("SoulsLayer", {
				showtype = 6,
				layertype = "DropDetailsLayer",
				cursoul = var_0_16[arg_29_1].servant
			})
		else
			showItemDetails(arg_29_1)
		end
	end
end

function ActivityGroupFightLayer.dealChangeBtn(arg_30_0, arg_30_1, arg_30_2, arg_30_3)
	local var_30_0 = arg_30_1
	local var_30_1 = arg_30_2
	local var_30_2, var_30_3 = level_manager:isModeValid(arg_30_1)

	if not var_30_2 then
		audio_manager:playeffectMusicTest("sound/invalid")
		global_ShowBlockWords(level_manager:getModeUnlockMsg(arg_30_1, var_30_3))

		return
	end

	local function var_30_4(arg_31_0)
		if arg_31_0 == 1 then
			LayerManager:switchShowLayer("FightLayer", {
				is_hide_topcost = true,
				is_hide_listbutton = true
			})
			FightManager.refreshFightToType(FIGHTTYPE_GROUPFIGHT)
		else
			if arg_31_0 == 2 then
				audio_manager:playeffectMusicTest("sound/invalid")
				global_ShowBlockWords(L_ADVENTURE_WARNING[2])
			elseif arg_31_0 == 3 then
				audio_manager:playeffectMusicTest("sound/invalid")
				global_ShowBlockWords(L_ADVENTURE_WARNING[3])
			elseif arg_31_0 == 4 then
				audio_manager:playeffectMusicTest("sound/invalid")
				global_ShowBlockWords(L_ADVENTURE_WARNING[4])
			elseif arg_31_0 == 5 then
				audio_manager:playeffectMusicTest("sound/invalid")
				global_ShowBlockWords(L_ADVENTURE_WARNING[5])
			elseif arg_31_0 == 6 then
				audio_manager:playeffectMusicTest("sound/invalid")

				if chapter_data["" .. var_30_0 .. "-" .. var_30_1] and chapter_data["" .. var_30_0 .. "-" .. var_30_1].boss_combat then
					global_ShowBlockWords(L_ADVENTURE_WARNING[6] .. chapter_data["" .. var_30_0 .. "-" .. var_30_1].boss_combat .. L_ADVENTURE_WARNING[7])
				end
			end

			GuideListener.showAllGuidesWithFullScreen(true)
		end
	end

	local function var_30_5(arg_32_0)
		GuideListener.showAllGuidesWithFullScreen(false)
		RoleDefault:getInstance():setIntegerForKey("adventurearray", arg_32_0)
		RoleDefault:getInstance():setIntegerForKey("lastadventurearray", arg_32_0)
		RoleDefault:getInstance():setIntegerForKey("AdventureEnterIndex", arg_30_0.modetype)
		activity_manager:startGroupTower(var_30_0, var_30_1, var_30_4, arg_32_0)
	end

	LayerManager:pushInLayer("LevelDetailGroupLayer", {
		fight_type = "GroupFightLayer",
		level = 1,
		mode = arg_30_1,
		chapter = arg_30_2,
		callback = arg_30_3,
		adventuresurecallback = function()
			local var_33_0 = {
				level = 1,
				mode = var_30_0
			}

			var_33_0.defaultIndex = RoleDefault:getInstance():getIntegerForKey("adventurearray", 1)
			var_33_0.configcallback = var_30_5
			var_33_0.exitcallback = arg_30_3
			var_33_0.chapter = var_30_1

			var_0_14:pushFormationLayer("FormationGroupFightLayer", var_33_0)
		end,
		initindex = RoleDefault:getInstance():getIntegerForKey("adventurearray", 1)
	})
end

function ActivityGroupFightLayer.getDropData(arg_34_0, arg_34_1)
	local var_34_0 = {
		gold = 0,
		diamond = 0,
		items = {}
	}
	local var_34_1 = drop_data[arg_34_1] or {}

	if var_34_1.gold then
		var_34_0.gold = var_34_0.gold + var_34_1.gold
	end

	if var_34_1.diamond then
		var_34_0.diamond = var_34_0.diamond + var_34_1.diamond
	end

	local var_34_2 = 1

	if var_34_1["drop_id" .. 1] then
		local var_34_3 = 1

		while var_34_1["drop_id" .. var_34_3] do
			var_34_0.items[var_34_2] = {
				itemid = var_34_1["drop_id" .. var_34_3],
				num = var_34_1["drop_num" .. var_34_3]
			}
			var_34_3 = var_34_3 + 1
			var_34_2 = var_34_2 + 1
		end
	end

	if var_34_1["dropmodel_id" .. 1] then
		local var_34_4 = 1

		while var_34_1["dropmodel_id" .. var_34_4] do
			if drop_data[var_34_1["dropmodel_id" .. var_34_4]].gold then
				var_34_0.gold = var_34_0.gold + drop_data[var_34_1["dropmodel_id" .. var_34_4]].gold
			end

			if drop_data[var_34_1["dropmodel_id" .. var_34_4]].diamond then
				var_34_0.diamond = var_34_0.diamond + drop_data[var_34_1["dropmodel_id" .. var_34_4]].diamond
			end

			if drop_data[var_34_1["dropmodel_id" .. var_34_4]]["drop_id" .. 1] then
				local var_34_5 = 1

				while drop_data[var_34_1["dropmodel_id" .. var_34_4]]["drop_id" .. var_34_5] do
					var_34_0.items[var_34_2] = {
						itemid = drop_data[var_34_1["dropmodel_id" .. var_34_4]]["drop_id" .. var_34_5],
						num = drop_data[var_34_1["dropmodel_id" .. var_34_4]]["drop_num" .. var_34_5]
					}
					var_34_5 = var_34_5 + 1
					var_34_2 = var_34_2 + 1
				end
			end

			if drop_data[var_34_1["dropmodel_id" .. var_34_4]]["rd_drop_id" .. 1] then
				local var_34_6 = 1

				while drop_data[var_34_1["dropmodel_id" .. var_34_4]]["rd_drop_id" .. var_34_6] do
					var_34_0.items[var_34_2] = {
						itemid = drop_data[var_34_1["dropmodel_id" .. var_34_4]]["rd_drop_id" .. var_34_6],
						num = drop_data[var_34_1["dropmodel_id" .. var_34_4]]["rd_drop_num" .. var_34_6]
					}
					var_34_6 = var_34_6 + 1
					var_34_2 = var_34_2 + 1
				end
			end

			var_34_4 = var_34_4 + 1
		end
	end

	if var_34_1["rd_drop_id" .. 1] then
		local var_34_7 = 1

		while var_34_1["rd_drop_id" .. var_34_7] do
			var_34_0.items[var_34_2] = {
				itemid = var_34_1["rd_drop_id" .. var_34_7],
				num = var_34_1["rd_drop_num" .. var_34_7]
			}
			var_34_7 = var_34_7 + 1
			var_34_2 = var_34_2 + 1
		end
	end

	if var_34_1["rd_dropmodel_id" .. 1] then
		local var_34_8 = 1

		while var_34_1["rd_dropmodel_id" .. var_34_8] do
			if drop_data[var_34_1["rd_dropmodel_id" .. var_34_8]].gold then
				var_34_0.gold = var_34_0.gold + drop_data[var_34_1["rd_dropmodel_id" .. var_34_8]].gold
			end

			if drop_data[var_34_1["rd_dropmodel_id" .. var_34_8]].diamond then
				var_34_0.diamond = var_34_0.diamond + drop_data[var_34_1["rd_dropmodel_id" .. var_34_8]].diamond
			end

			if drop_data[var_34_1["rd_dropmodel_id" .. var_34_8]]["drop_id" .. 1] then
				local var_34_9 = 1

				while drop_data[var_34_1["rd_dropmodel_id" .. var_34_8]]["drop_id" .. var_34_9] do
					var_34_0.items[var_34_2] = {
						itemid = drop_data[var_34_1["rd_dropmodel_id" .. var_34_8]]["drop_id" .. var_34_9],
						num = drop_data[var_34_1["rd_dropmodel_id" .. var_34_8]]["drop_num" .. var_34_9]
					}
					var_34_9 = var_34_9 + 1
					var_34_2 = var_34_2 + 1
				end
			end

			if drop_data[var_34_1["rd_dropmodel_id" .. var_34_8]]["rd_drop_id" .. 1] then
				local var_34_10 = 1

				while drop_data[var_34_1["rd_dropmodel_id" .. var_34_8]]["rd_drop_id" .. var_34_10] do
					var_34_0.items[var_34_2] = {
						itemid = drop_data[var_34_1["rd_dropmodel_id" .. var_34_8]]["rd_drop_id" .. var_34_10],
						num = drop_data[var_34_1["rd_dropmodel_id" .. var_34_8]]["rd_drop_num" .. var_34_10]
					}
					var_34_10 = var_34_10 + 1
					var_34_2 = var_34_2 + 1
				end
			end

			var_34_8 = var_34_8 + 1
		end
	end

	return var_34_0
end
