TowerDefenceSelectLayer = class("TowerDefenceSelectLayer", function()
	return cc.Layer:create()
end)

local level_manager = require("controller.level_manager")
local tower_defence_manager = require("controller.tower_defence_manager")
local core_manager = require("controller.core_manager")
local role_false_level_manager = require("controller.role_false_level_manager")
local playermodel = require("model.playermodel")
local model_data = require("data.model_data")
local servant_data = require("data.servant_data")
local chapter_data = require("data.chapter_data")
local spinecache_manager = require("controller.spinecache_manager")
local TowerBaseBarSprite = require("view.Sprite.TowerBaseBarSprite")
local TempWidget = require("view.Sprite.TempWidget")
local var_0_11 = 185
local var_0_12 = GameDisplay.height * (ORIGIN_FIGHT_HEIGHT + 185) / GameDisplay.origin_design_y - GameDisplay.fix_y
local var_0_13 = 640
local var_0_14 = 800
local var_0_15 = -420
local var_0_16 = -(GameDisplay.height * (ORIGIN_FIGHT_HEIGHT + 185) / GameDisplay.origin_design_y - GameDisplay.fix_y) - GameDisplay.fix_y
local var_0_17 = 110
local var_0_19 = 600
local var_0_20 = 230
local var_0_21 = 0.24
local var_0_22 = 10
local var_0_23 = {
	{
		x = 4,
		y = 4
	},
	{
		x = 28,
		y = 100
	},
	{
		x = 124,
		y = 100
	},
	{
		x = 100,
		y = 4
	}
}
local var_0_25 = config._DEBUG and 0 or 1
local var_0_26

function TowerDefenceSelectLayer:createLoadIngAni(arg_2_1)
	local var_2_0 = ccui.Layout:create()

	var_2_0:setContentSize(cc.size(640, GameDisplay.height))
	var_2_0:setTouchEnabled(true)
	var_2_0:setPositionY(var_0_16)
	self:addChild(var_2_0, 999)
	ccs.ArmatureDataManager:getInstance():addArmatureFileInfo("effect/fight_loading.ExportJson")

	local var_2_1 = ccs.Armature:create("fight_loading")

	var_2_1:setPosition(320, GameDisplay.height / 2)
	var_2_0:addChild(var_2_1)
	var_2_1:getAnimation():play("Animation1")
	var_2_1:getAnimation():setFrameEventCallFunc(function(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
		if arg_3_1 == "end" then
			if arg_2_1 then
				arg_2_1()
			end

			var_2_0:runAction(cc.RemoveSelf:create())
		end
	end)
end

function TowerDefenceSelectLayer.create(arg_4_0, arg_4_1)
	local var_4_0 = TowerDefenceSelectLayer.new()

	var_4_0:setPosition(cc.p(0, var_0_12))
	var_4_0:initBg(arg_4_1)
	TextureManager:removeUnusedSpineTextures()
	var_4_0:init(arg_4_1)

	return var_4_0
end

function TowerDefenceSelectLayer:init(arg_5_1)
	self.mode = arg_5_1.mode
	self.chapter = arg_5_1.chapter
	self.sureCallback = arg_5_1.sureCallback

	self:initData()
	self:initUI()
	self:batchCreatePlayer()
	self:registerScriptHandler(function(arg_6_0)
		if arg_6_0 == "exit" then
			var_0_26 = nil
		elseif arg_6_0 == "enter" then
			var_0_26 = self
		end
	end)
end

function TowerDefenceSelectLayer:initData()
	(function()
		var_0_22 = chapter_data[self.mode .. "-" .. self.chapter].select_max_role or 10
		self.selectedList = {}
		self.skeletonList = {}
		self.skeletonDataList = {}
		self.spinePosIdx = {}

		for iter_8_0 in RoleDefault:getInstance():getStringForKey("TowerDefenceLastRoles", ""):gmatch("([^,]+)") do
			self.selectedList[tonumber(iter_8_0)] = true
			self.isNeedBatchCreatePlayer = true
		end
	end)()
	;(function()
		self.headConf = {}

		local function var_9_0(arg_10_0)
			local var_10_0 = {}
			local var_10_1 = model_data[arg_10_0.majorlist.modelid]
			local var_10_2 = global_get_model_attr(arg_10_0.majorlist.modelid)

			if var_10_2 then
				var_10_0.careericon = model_data[arg_10_0.majorlist.modelid].career .. "_" .. var_10_2 or "class_" .. model_data[arg_10_0.majorlist.modelid].career .. "_black"
			end

			var_10_0.headimg = var_10_1.head_image
			var_10_0.lv = arg_10_0.majorlist.level
			var_10_0.name = var_10_1.name
			var_10_0.charactertype = arg_10_0.charactertype
			var_10_0.hpcount = arg_10_0.majorlist.hpcount or 1
			var_10_0.singlehp = arg_10_0.majorlist.hp

			return var_10_0
		end

		self.headConf.player = var_9_0(tower_defence_manager:getPlayerBaseConf(self.mode, self.chapter)[1])
		self.headConf.enemy = var_9_0(tower_defence_manager:getEnemyBaseConf(self.mode, self.chapter)[1])
	end)()
	;(function()
		self.allRoleDatas = {}

		for iter_11_0, iter_11_1 in pairs(servant_data) do
			if playermodel.haveServant[iter_11_1.id] then
				table.insert(self.allRoleDatas, iter_11_1.id)
			end
		end
	end)()
	;(function()
		self.attrList = {}
		self.special_attrs = {}

		local var_12_0 = {
			wind = 8,
			water = 6,
			fire = 7,
			devil = 2,
			light = 5,
			dark = 4,
			imaginary = 3
		}

		for iter_12_0, iter_12_1 in pairs(ATTR_ID) do
			if var_12_0[iter_12_1] then
				table.insert(self.attrList, iter_12_1)
			else
				self.special_attrs[iter_12_1] = true
			end
		end

		table.sort(self.attrList, function(arg_13_0, arg_13_1)
			return (var_12_0[arg_13_1] or 0) < (var_12_0[arg_13_0] or 0)
		end)
		table.insert(self.attrList, 1, "all")
		table.insert(self.attrList, "special")

		self.curSelectType = "all"
	end)()
	;(function()
		self.enemyList, self.enemyBossList = tower_defence_manager:getAllLevelEnemys(self.mode, self.chapter)

		table.sort(self.enemyList, function(arg_15_0, arg_15_1)
			return model_data[arg_15_0].modelweight < model_data[arg_15_1].modelweight
		end)
	end)()
	self:updateRoleListData()
end

function TowerDefenceSelectLayer:updateRoleListData()
	self.curRoleList = {}

	for iter_16_0, iter_16_1 in pairs(self.allRoleDatas) do
		local var_16_0 = global_get_model_attr((global_get_servant_skin(iter_16_1, -1)))

		if self.curSelectType == "all" or self.curSelectType == var_16_0 or self.curSelectType == "special" and self.special_attrs[var_16_0] then
			table.insert(self.curRoleList, iter_16_1)
		end
	end

	if next(self.curRoleList) ~= nil then
		tower_defence_manager:sortRoleListTbl(self.curRoleList)
	end
end

function TowerDefenceSelectLayer:initBg(arg_17_1)
	self.bgPanel = ccui.Layout:create()

	self.bgPanel:setAnchorPoint(cc.p(0, 0))
	self.bgPanel:setPosition(cc.p(0, 5))
	self.bgPanel:setContentSize(cc.size(var_0_13, var_0_14))
	self:addChild(self.bgPanel)

	self.map = ccui.Layout:create()

	self.map:setContentSize(cc.size(var_0_13, var_0_14))
	self.map:setAnchorPoint(cc.p(0.5, 0))
	self.map:setPosition(cc.p(var_0_13 / 2, 0))
	self.bgPanel:addChild(self.map)

	local var_17_0 = ccui.ImageView:create("TowerDefenceListPanel/select_mark_bg.png", var_0_25)

	var_17_0:setAnchorPoint(cc.p(0.5, 0))
	var_17_0:setPosition(320, var_0_16)
	self:addChild(var_17_0)

	self.background = {}

	local var_17_1 = level_manager.getCurLevelData(arg_17_1.mode, arg_17_1.chapter .. "-1")

	for iter_17_0 = 1, 3 do
		self.background[iter_17_0] = cc.Sprite:create(FIGHT_BG_PATH .. var_17_1["sceneConfigure" .. iter_17_0] .. ".png")

		self.background[iter_17_0]:setAnchorPoint(cc.p(0, 0))
		self.background[iter_17_0]:setPosition(cc.p(-100, var_0_15))
		self.map:addChild(self.background[iter_17_0], -iter_17_0)
	end
end

function TowerDefenceSelectLayer:initUI()
	self:initHead()
	self:initBaseUI()
	self:initBattleFieldStatusInfoPanel()
	self:initList()
	self:initBottom()
	self:initEnemySpine()
end

function TowerDefenceSelectLayer:initHead()
	local var_19_0 = cc.Node:create()
	local var_19_1 = GameDisplay.height - (GameDisplay.height * (ORIGIN_FIGHT_HEIGHT + var_0_11) / GameDisplay.origin_design_y - GameDisplay.fix_y) - GameDisplay.fix_y - 80

	var_19_0:setPosition(cc.p(0, GameDisplay.height - (GameDisplay.height * (ORIGIN_FIGHT_HEIGHT + var_0_11) / GameDisplay.origin_design_y - GameDisplay.fix_y) - GameDisplay.fix_y - 80 + 300))
	self.bgPanel:addChild(var_19_0)

	local var_19_2

	if config._DEBUG then
		var_19_2 = cc.Sprite:create("FightLayer/boss_blood_frame.png") or cc.Sprite:createWithSpriteFrameName("FightLayer/boss_blood_frame.png")
	end

	var_19_2:setAnchorPoint(cc.p(0.5, 1))
	var_19_2:setPosition(320, 80)
	var_19_0:addChild(var_19_2, -1)

	for iter_19_0, iter_19_1 in pairs(self.headConf) do
		local var_19_3 = TowerBaseBarSprite:createHpBar(iter_19_1.singlehp, iter_19_1.singlehp, iter_19_1.hpcount, 1, iter_19_1)

		var_19_3:setName("hpbar")
		var_19_3:setPositionX(iter_19_0 == "player" and 0 or 640)
		var_19_0:addChild(var_19_3, 1)
	end

	var_19_0:runAction(cc.EaseExponentialIn:create(cc.MoveTo:create(0.4, cc.p(0, var_19_1))))
end

function TowerDefenceSelectLayer:initBaseUI()
	self.listBg = ccui.ImageView:create("TowerDefenceListPanel/panelbg.png", var_0_25)

	self.listBg:setAnchorPoint(cc.p(0.5, 0))
	self.listBg:setPosition(320, var_0_16 + 10 - 450 - 30)
	self.listBg:setName("listBg")
	self:addChild(self.listBg)
	self.listBg:runAction(cc.EaseExponentialIn:create(cc.MoveTo:create(0.4, cc.p(320, var_0_16 + 10))))

	local var_20_0 = ccui.ImageView:create("TowerDefenceListPanel/arrow.png", var_0_25)

	var_20_0:setScaleX(-1)
	var_20_0:setAnchorPoint(cc.p(1, 0.5))
	var_20_0:setPosition(-4, 166)
	self.listBg:addChild(var_20_0)

	local var_20_1 = ccui.ImageView:create("TowerDefenceListPanel/arrow.png", var_0_25)

	var_20_1:setAnchorPoint(cc.p(1, 0.5))
	var_20_1:setPosition(644, 166)
	self.listBg:addChild(var_20_1)

	self.limitLabel = cc.Label:createWithTTF("可上阵:10/10", FONT_NAME, 24)

	self.limitLabel:setPosition(555, 310)
	self.limitLabel:setRotation(-2)
	self.listBg:addChild(self.limitLabel)
	self:updatelimitLabel()

	local var_20_2 = cc.Label:createWithTTF(L_TOWER_DEFENCE_SELECT_DES, FONT_W5, 24)

	var_20_2:setAnchorPoint(0.5, 0.5)
	var_20_2:setPosition(320, 310 - 10)
	self.listBg:addChild(var_20_2)

	local var_20_3 = cc.Label:createWithTTF("00:00", FONT_NAME, 24)

	var_20_3:setPosition(60, 310)
	var_20_3:setRotation(2)
	self.listBg:addChild(var_20_3)

	self.debutEffect = L2Skeleton:create("spine/tower_defence/chuchang.json", "spine/tower_defence/chuchang.atlas", nil, true)

	self.debutEffect:refreshSkeleton()
	self.debutEffect:setVisible(false)
	self.map:addChild(self.debutEffect, 99)

	self.sureBtn = ccui.Button:create("TowerDefenceListPanel/select_sure_btn.png", nil, "TowerDefenceListPanel/select_sure_btn.png", var_0_25)

	self.sureBtn:setAnchorPoint(cc.p(1, 0))
	self.sureBtn:setPosition(640, 350)
	self.sureBtn:setName("sureSelectBtn")
	self.listBg:addChild(self.sureBtn)

	local var_20_4 = TempWidget:CreateTempBtn("TowerDefenceListPanel/back_btn.png")

	var_20_4:align(cc.p(1, 0), self.sureBtn:getPositionX(), self.sureBtn:getPositionY() + self.sureBtn:getContentSize().height + 20)
	var_20_4:_addEvent(function()
		KeyCodeManager:onKeyReleasedCallFunc()
	end)
	self.listBg:addChild(var_20_4)
	self.sureBtn:addTouchEventListener(function(arg_22_0, arg_22_1)
		if arg_22_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:sureEventFunc()
	end)
end

function TowerDefenceSelectLayer:updatelimitLabel()
	self.limitLabel:setString(TOWER_ROLE_LIMIT .. table.nums(self.selectedList) .. "/" .. var_0_22)
	self.limitLabel:setColor(table.nums(self.selectedList) >= var_0_22 and cc.c3b(255, 85, 85) or cc.c3b(255, 255, 255))
end

function TowerDefenceSelectLayer:initBattleFieldStatusInfoPanel()
	local var_24_0 = "FightLayer/battlefield_status_bg.png"

	self.battlefieldStatusInfo = cc.Node:create()

	self.battlefieldStatusInfo:setPosition(cc.p(0, 360))

	self.battlefieldStatusInfo.curchapter = self.mode .. "-" .. self.chapter

	self.listBg:addChild(self.battlefieldStatusInfo, 99)

	local function var_24_1(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
		local var_25_0 = arg_25_0:getChildByName("bg")

		var_25_0:stopAllActions()

		arg_25_1 = arg_25_1 or 0
		arg_25_2 = arg_25_2 or 999

		local var_25_1 = var_25_0:getChildren()

		for iter_25_0 = 1, #var_25_1 do
			var_25_1[iter_25_0]:setVisible(true)
		end

		var_25_0:runAction(cc.Sequence:create(cc.DelayTime:create(arg_25_1), cc.MoveTo:create(0.1, cc.p(0, var_25_0:getPositionY())), cc.DelayTime:create(arg_25_2), cc.MoveTo:create(0.1, cc.p(-var_25_0:getContentSize().width + 40, 0)), cc.CallFunc:create(function()
			arg_25_3:setRotation(180)

			local var_26_0 = var_25_0:getChildren()

			for iter_26_0 = 1, #var_26_0 do
				if var_26_0[iter_26_0]:getName() ~= "bntShowInfo" then
					var_26_0[iter_26_0]:setVisible(false)
				end
			end
		end)))
	end

	local function var_24_2(arg_27_0, arg_27_1)
		local var_27_0 = arg_27_0:getChildByName("bg")

		var_27_0:stopAllActions()

		arg_27_1 = arg_27_1 or 0

		var_27_0:runAction(cc.Sequence:create(cc.DelayTime:create(arg_27_1), cc.MoveTo:create(0.1, cc.p(-var_27_0:getContentSize().width + 40, var_27_0:getPositionY())), cc.CallFunc:create(function()
			local var_28_0 = var_27_0:getChildren()

			for iter_28_0 = 1, #var_28_0 do
				if var_28_0[iter_28_0]:getName() ~= "bntShowInfo" then
					var_28_0[iter_28_0]:setVisible(false)
				end
			end
		end)))
	end

	local var_24_3 = {}

	for iter_24_0, iter_24_1 in ipairs((level_manager:getChapterBattleFieldInfo(self.mode .. "-" .. self.chapter))) do
		table.insert(var_24_3, {
			icon = "FightLayer/map_icon.png",
			des = iter_24_1
		})
	end

	if #var_24_3 == 0 then
		return
	end

	local var_24_5 = 0
	local var_24_6 = 0.5
	local var_24_7 = 3
	local var_24_8 = ccui.Button:create("FightLayer/btn_show_info.png", nil, "FightLayer/btn_show_info.png", var_0_25)

	var_24_8:setName("bntShowInfo")
	var_24_8:setSwallowTouches(false)

	local var_24_10 = (function(arg_29_0)
		local var_29_0 = cc.Node:create()
		local var_29_1 = ccui.ImageView:create(var_24_0, var_0_25)

		var_29_1:setScale9Enabled(true)
		var_29_1:setScaleX(-1)
		var_29_1:setAnchorPoint(cc.p(1, 0.5))
		var_29_1:setName("bg")
		var_29_1:setPosition(cc.p(-var_29_1:getContentSize().width, 0))
		var_29_1:setTouchEnabled(true)

		local var_29_2 = 0
		local var_29_3 = {}
		local var_29_4 = {}
		local var_29_5 = 0.3

		for iter_29_0 = 1, #arg_29_0 do
			local var_29_6 = cc.Label:createWithTTF(arg_29_0[iter_29_0].des, FONT_DES, 20)

			var_29_6:setScaleX(-1)
			var_29_6:setAnchorPoint(cc.p(0, 0.5))
			var_29_6:setColor(cc.c3b(212, 226, 242))
			var_29_6:setName("label")
			var_29_6:setAnchorPoint(cc.p(0, 0.5))

			var_29_3[#var_29_3 + 1] = var_29_6

			var_29_1:addChild(var_29_6, 99)

			local var_29_7 = ccui.ImageView:create(arg_29_0[iter_29_0].icon, var_0_25)

			var_29_7:setScale(var_29_5)
			var_29_7:setAnchorPoint(cc.p(1, 0.5))
			var_29_7:setName("icon")

			var_29_4[#var_29_4 + 1] = var_29_7

			var_29_1:addChild(var_29_7, 99)

			if var_29_2 < var_29_6:getContentSize().width + var_29_7:getContentSize().width * var_29_5 then
				var_29_2 = var_29_6:getContentSize().width + var_29_7:getContentSize().width * var_29_5
			end
		end

		local var_29_8 = var_29_3[1]:getContentSize().height

		print(":::::::::::::::::::21", var_29_8)

		local var_29_9 = var_29_2

		if var_29_9 > 320 then
			var_29_1:setContentSize(cc.size(var_29_9 + 50, #arg_29_0 < 3 and 67 or 104 + (#arg_29_0 - 2) * 20))
		else
			var_29_1:setContentSize(cc.size(340, #arg_29_0 < 3 and 67 or 104 + (#arg_29_0 - 2) * 20))
		end

		if #var_29_3 == 1 then
			var_29_4[1]:setPosition(cc.p(var_29_1:getContentSize().width - 5, var_29_1:getContentSize().height / 2))
			var_29_3[1]:setPosition(cc.p(var_29_1:getContentSize().width - 10 - var_29_4[1]:getContentSize().width * var_29_5, var_29_1:getContentSize().height / 2))
		elseif #var_29_3 % 2 == 1 then
			for iter_29_1 = 1, #var_29_3 do
				var_29_4[iter_29_1]:setPosition(cc.p(var_29_1:getContentSize().width - 5, var_29_1:getContentSize().height / 2 + var_29_8 - (iter_29_1 - math.floor(#var_29_3 / 2)) * (var_29_8 + 3)))
				var_29_3[iter_29_1]:setPosition(cc.p(var_29_1:getContentSize().width - 10 - var_29_4[iter_29_1]:getContentSize().width * var_29_5, var_29_1:getContentSize().height / 2 + var_29_8 - (iter_29_1 - math.floor(#var_29_3 / 2)) * (var_29_8 + 3)))
			end
		elseif #var_29_3 % 2 == 0 then
			for iter_29_2 = 1, #var_29_3 do
				var_29_4[iter_29_2]:setPosition(cc.p(var_29_1:getContentSize().width - 5, var_29_1:getContentSize().height / 2 + var_29_8 / 2 - (iter_29_2 - #var_29_3 / 2) * (var_29_8 + 3)))
				var_29_3[iter_29_2]:setPosition(cc.p(var_29_1:getContentSize().width - 10 - var_29_4[iter_29_2]:getContentSize().width * var_29_5, var_29_1:getContentSize().height / 2 + var_29_8 / 2 - (iter_29_2 - #var_29_3 / 2) * (var_29_8 + 3)))
			end
		end

		var_29_0.show = var_24_1
		var_29_0.hide = var_24_2

		var_29_0:addChild(var_29_1)

		return var_29_0
	end)(var_24_3)
	local var_24_11 = var_24_10:getChildByName("bg")

	var_24_10:setPosition(cc.p(0, var_24_5 + (var_24_11:getContentSize().height > 90 and var_24_11:getContentSize().height - 90 or 0)))
	self.battlefieldStatusInfo:addChild(var_24_10)
	var_24_8:setPosition(18, var_24_11:getContentSize().height / 2)
	var_24_10:show(var_24_6, var_24_7, var_24_8)
	var_24_11:addChild(var_24_8, 99)
	var_24_10:show(0, nil, var_24_8)
	var_24_8:setRotation(0)
	var_24_11:addTouchEventListener(function(arg_30_0, arg_30_1)
		if arg_30_1 ~= ccui.TouchEventType.ended then
			return
		end

		if var_24_8:getRotation() == 180 then
			var_24_10:show(0, nil, var_24_8)
			var_24_8:setRotation(0)
		else
			var_24_10:hide(0)
			var_24_8:setRotation(180)
		end
	end)
end

function TowerDefenceSelectLayer:initList()
	self.scrollView = ccui.ScrollView:create()

	self.scrollView:setContentSize(cc.size(var_0_19, var_0_20))
	self.scrollView:setBounceEnabled(true)
	self.scrollView:setDirection(ccui.ScrollViewDir.horizontal)
	self.scrollView:setPosition(20, 50)
	self.listBg:addChild(self.scrollView)
	self:updateList()
end

function TowerDefenceSelectLayer:updateList()
	self.scrollView:removeAllChildren()
	self.scrollView:setInnerContainerSize(cc.size(math.ceil(#self.curRoleList / 2) * var_0_17 + 20, var_0_20))

	for iter_32_0, iter_32_1 in ipairs(self.curRoleList) do
		local var_32_0 = self:createSp(iter_32_0)

		self:updateSp(var_32_0)
		var_32_0:setPosition((math.ceil(iter_32_0 / 2) - 1) * var_0_17, iter_32_0 % 2 == 0 and 10 or var_32_0:getContentSize().height + 20)
		var_32_0:setName("sp" .. iter_32_0)
		var_32_0:setTag(var_32_0.servantid)
		self.scrollView:addChild(var_32_0)
	end
end

function TowerDefenceSelectLayer:initBottom()
	local var_33_0 = ccui.ImageView:create("TowerDefenceListPanel/tips.png", var_0_25)

	var_33_0:setAnchorPoint(cc.p(0, 0))
	var_33_0:setPosition(0, -10)
	self.listBg:addChild(var_33_0)

	self.attrView = ccui.ScrollView:create()

	self.attrView:setContentSize(cc.size(640, 60))
	self.attrView:setInnerContainerSize(cc.size(75 * #self.attrList, 60))
	self.attrView:setDirection(ccui.ScrollViewDir.horizontal)
	self.attrView:setPosition(var_33_0:getContentSize().width, -10)
	self.listBg:addChild(self.attrView)

	for iter_33_0, iter_33_1 in ipairs(self.attrList) do
		local var_33_1

		if iter_33_1 == self.curSelectType then
			var_33_1 = "TowerDefenceListPanel/" .. iter_33_1 .. "_on.png" or "TowerDefenceListPanel/" .. iter_33_1 .. "_off.png"
		end

		local var_33_2 = ccui.Button:create(var_33_1, nil, var_33_1, var_0_25)

		var_33_2:setAnchorPoint(cc.p(0, 0))
		var_33_2:setPosition((iter_33_0 - 1) * var_33_2:getContentSize().width, 0)
		var_33_2:setName(iter_33_1)
		self.attrView:addChild(var_33_2)
		var_33_2:addTouchEventListener(function(arg_34_0, arg_34_1)
			if arg_34_1 ~= ccui.TouchEventType.ended then
				return
			end

			self:switchSelect(iter_33_1)
		end)
	end
end

function TowerDefenceSelectLayer:createSp(arg_35_1)
	local var_35_0 = self.curRoleList[arg_35_1]
	local var_35_1 = TempWidget:CreateTempBtn("TowerDefenceListPanel/role_bg2.png")

	var_35_1:loadTexturePressed("TowerDefenceListPanel/role_bg2.png")
	var_35_1:loadTextureDisabled("TowerDefenceListPanel/role_bg2.png")
	var_35_1:setAnchorPoint(0, 0)
	var_35_1:setSwallowTouches(false)

	local var_35_2 = ccui.ImageView:create(ROLE_PORTRAIT_PATH .. model_data[servant_data[self.curRoleList[arg_35_1]].modelid].portrait_image .. ".png")

	var_35_2:setScale(0.9)
	var_35_2:setPosition(var_35_1:getContentSize().width / 2, var_35_1:getContentSize().height / 2)
	var_35_1:addChild(var_35_2, 1)

	local var_35_3 = ccui.ImageView:create("TowerDefenceListPanel/cost_bg.png", var_0_25)

	var_35_3:setAnchorPoint(cc.p(0, 0))
	var_35_3:setPosition(5, 0)
	var_35_1:addChild(var_35_3, 3)

	local var_35_4 = cc.Label:createWithTTF("", FONT_W5, 26)

	var_35_4:setAnchorPoint(cc.p(1, 0))
	var_35_4:setColor(cc.c3b(250, 255, 170))
	var_35_4:setPosition(var_35_3:getContentSize().width - 5, -2)
	var_35_3:addChild(var_35_4)

	local var_35_5 = cc.Label:createWithTTF("", FONT_NAME, 16)

	var_35_5:setAnchorPoint(cc.p(0, 0))
	var_35_5:setPosition(0, 0)
	var_35_3:addChild(var_35_5)
	var_35_4:setVisible(false)

	local var_35_6 = ccui.ImageView:create("TowerDefenceListPanel/selected_frame.png", var_0_25)

	var_35_6:setPosition(var_35_1:getContentSize().width / 2, var_35_1:getContentSize().height / 2)
	var_35_1:addChild(var_35_6, 5)
	var_35_1:_addSuperEvent(function(arg_36_0, arg_36_1, arg_36_2)
		if arg_36_0 == TempWidget.Click then
			local var_36_0 = arg_36_1:getTouchBeganPosition()

			if not isContainPosOfConvexPolygon(var_0_23, (arg_36_1:convertToNodeSpace((arg_36_1:getTouchEndPosition())))) then
				return
			end

			self:roleSpEventFunc(var_35_0)
		elseif arg_36_0 == TempWidget.Press then
			LayerManager:pushInLayer("EquipLayer", {
				showtype = SHOW_TYPE_DROP_PREVIEW,
				cursoul = var_35_0,
				exitCallback = function(...)
					if var_0_26 then
						self:updateList()
					end
				end
			})
		end
	end)

	var_35_1.id = arg_35_1
	var_35_1.servantid = self.curRoleList[arg_35_1]
	var_35_1.costBg = var_35_3
	var_35_1.costNum = var_35_4
	var_35_1.roleLv = var_35_5
	var_35_1.selectedLogo = var_35_6

	return var_35_1
end

function TowerDefenceSelectLayer:updateSp(arg_38_1)
	local var_38_0 = not not self.selectedList[arg_38_1.servantid]

	arg_38_1:loadTextures("TowerDefenceListPanel/" .. ((self.selectedList[arg_38_1.servantid] and true or false) and "role_bg2.png" or "role_bg1.png"), "TowerDefenceListPanel/" .. ((self.selectedList[arg_38_1.servantid] and true or false) and "role_bg2.png" or "role_bg1.png"), "TowerDefenceListPanel/" .. ((self.selectedList[arg_38_1.servantid] and true or false) and "role_bg2.png" or "role_bg1.png"), var_0_25)
	arg_38_1.selectedLogo:setVisible(var_38_0)
	arg_38_1.costNum:setString(tower_defence_manager:get_servant_cost(arg_38_1.servantid))
	arg_38_1.roleLv:setString("等级" .. core_manager:getCoreLv(arg_38_1.servantid))
	arg_38_1.roleLv:setOpacity(255)
	arg_38_1.roleLv:stopAllActions()
	arg_38_1.roleLv:setColor(cc.c3b(255, 255, 255))

	if role_false_level_manager:isRoleFalseLevelMember(arg_38_1.servantid, FIGHTTYPE_TOWER, self.mode) then
		local var_38_1, var_38_2, var_38_3, var_38_4 = role_false_level_manager:getRoleFalseAttrInfoByAllRole(arg_38_1.servantid, FIGHTTYPE_TOWER, self.mode)

		arg_38_1.roleLv:setString("等级" .. var_38_2)

		if var_38_1 == core_manager:getServantCoreRank(arg_38_1.servantid) and playermodel.cores[arg_38_1.servantid].level == var_38_2 then
			-- block empty
		else
			arg_38_1.roleLv:setColor(cc.c3b(206, 255, 167))

			local var_38_5 = true

			arg_38_1.roleLv:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.FadeOut:create(2), cc.CallFunc:create(function(...)
				if var_38_5 then
					arg_38_1.roleLv:setString("等级提升中")
				else
					arg_38_1.roleLv:setString("等级" .. var_38_2 + var_38_4)
				end

				var_38_5 = not var_38_5
			end), cc.FadeIn:create(2))))
		end
	end
end

function TowerDefenceSelectLayer:roleSpEventFunc(arg_40_1)
	if self.roleSpTouchLock then
		return
	end

	if self.selectedList[arg_40_1] then
		self.selectedList[arg_40_1] = nil

		self:removeRoleSpine(arg_40_1)
	elseif table.nums(self.selectedList) < var_0_22 then
		self.selectedList[arg_40_1] = true

		self:addRoleSpine(arg_40_1)
	else
		global_ShowBlockWords("可上阵已满")
	end

	self:updatelimitLabel()

	local var_40_0 = self.scrollView:getChildByTag(arg_40_1)

	if var_40_0 then
		self:updateSp(var_40_0)
	end
end

function TowerDefenceSelectLayer:switchSelect(arg_41_1)
	if self.roleSpTouchLock then
		return
	end

	if self.curSelectType == arg_41_1 then
		return
	end

	self.curSelectType = arg_41_1

	for iter_41_0, iter_41_1 in pairs(self.attrView:getChildren()) do
		local var_41_0 = iter_41_1:getName()

		if var_41_0 == self.curSelectType then
			iter_41_1:loadTextures("TowerDefenceListPanel/" .. var_41_0 .. "_on.png", nil, "TowerDefenceListPanel/" .. var_41_0 .. "_on.png", var_0_25)
		else
			iter_41_1:loadTextures("TowerDefenceListPanel/" .. var_41_0 .. "_off.png", nil, "TowerDefenceListPanel/" .. var_41_0 .. "_off.png", var_0_25)
		end
	end

	self:updateRoleListData()
	self:updateList()
end

function TowerDefenceSelectLayer:sureEventFunc()
	if self.roleSpTouchLock then
		return
	end

	if next(self.selectedList) == nil then
		return global_ShowBlockWords(L_TOWER_DEFENCE_SELECT_ERROR)
	end

	if table.nums(self.selectedList) > var_0_22 then
		global_ShowBlockWords(L_TOWER_DEFENCE_SELECT_ERROR2)

		return
	end

	local var_42_0 = {}

	for iter_42_0, iter_42_1 in pairs(self.selectedList) do
		table.insert(var_42_0, iter_42_0)
	end

	self:saveRoleList(var_42_0)

	if self.sureCallback then
		self.sureCallback(var_42_0)
	end
end

function TowerDefenceSelectLayer:initEnemySpine()
	local var_43_0 = {
		[4] = cc.p(560, -50 + 80 * 3),
		[8] = cc.p(560 - 100, -50 + 80 * 3),
		[3] = cc.p(560, -50 + 80 * 2),
		[6] = cc.p(560 - 100, -50 + 80 * 2),
		[2] = cc.p(560, -50 + 80),
		[5] = cc.p(560 - 100, -50 + 80),
		cc.p(560, -50),
		[7] = cc.p(560 - 100, -50)
	}
	local var_43_1 = {
		4,
		3,
		2,
		1,
		3,
		2,
		1,
		2,
		1,
		1
	}

	self.enemySkeletons = {}

	local var_43_2 = {}

	local function var_43_3(arg_44_0)
		if self.enemyBossList[arg_44_0] then
			for iter_44_0, iter_44_1 in ipairs({
				4,
				8,
				3,
				2.1
			}) do
				if not var_43_2[iter_44_0] then
					return iter_44_0
				end
			end
		end

		for iter_44_2 = 1, 10 do
			if not var_43_2[iter_44_2] then
				return iter_44_2
			end
		end
	end

	for iter_43_0, iter_43_1 in ipairs(self.enemyList) do
		if iter_43_0 <= #var_43_0 then
			self:runAction(cc.Sequence:create(cc.DelayTime:create((iter_43_0 - 1) * 0.01), cc.CallFunc:create(function()
				local var_45_0 = var_43_3(iter_43_1)
				local var_45_2 = L2Skeleton:create(ROLE_SPINE_PATH .. model_data[iter_43_1].spine_model .. ".json", ROLE_SPINE_PATH .. model_data[iter_43_1].spine_model .. ".atlas", (model_data[iter_43_1].clothes_model or nil) and (CLOTHES_SPINE_PATH .. model_data[iter_43_1].clothes_model .. ".atlas" or nil))

				var_45_2._modelid = iter_43_1

				self:addSkeletonDownloadInterface(var_45_2)
				var_45_2:showLoadingAni(true)
				var_45_2:refreshSkeleton()

				local var_45_3 = model_data[iter_43_1].modelscale or 1

				var_45_2:setScale(var_0_21 * -1 * var_45_3 * (model_data[iter_43_1].modelflip or 1) * 0.8, var_0_21 * var_45_3 * 0.8)
				var_45_2:play("idle")
				var_45_2:setRotation(math.random(-120, 120))
				var_45_2:setPosition(var_43_0[var_45_0].x + math.random(-10, 10), 1000)
				self.map:addChild(var_45_2, var_43_1[var_45_0])

				var_43_2[var_45_0] = true
				self.enemySkeletons[var_45_0] = var_45_2

				var_45_2:runAction(cc.Sequence:create(cc.DelayTime:create(iter_43_0 * math.random(1, 5) * 0.04), cc.EaseExponentialIn:create(cc.MoveTo:create(0.8, cc.p(var_45_2:getPositionX(), var_43_0[var_45_0].y))), cc.Spawn:create(cc.JumpTo:create(0.5, var_43_0[var_45_0], math.random(2, 4) * 10, 2), cc.RotateTo:create(0.5, 0))))
			end)))
		end
	end
end

function TowerDefenceSelectLayer:getAddRolePosIndex(arg_46_1)
	if model_data[arg_46_1].career == "tank" or model_data[arg_46_1].career == "fighter" then
		-- block empty
	elseif model_data[arg_46_1].career == "shotter" or model_data[arg_46_1].career == "assassin" then
		for iter_46_0 = 7, 1, -1 do
			if not self.skeletonList[iter_46_0] then
				return iter_46_0
			end
		end
	elseif model_data[arg_46_1].career == "support" or model_data[arg_46_1].career == "witcher" then
		for iter_46_1 = 1, 10 do
			if not self.skeletonList[iter_46_1] then
				return iter_46_1
			end
		end
	end

	for iter_46_2 = 10, 1, -1 do
		if not self.skeletonList[iter_46_2] then
			return iter_46_2
		end
	end
end

function TowerDefenceSelectLayer:addRoleSpine(arg_47_1)
	local var_47_0 = {
		[4] = cc.p(80 + 100, 240),
		cc.p(80, 240 - 60),
		[8] = cc.p(80 + 100 * 2, 240 - 60),
		[5] = cc.p(80 + 100, 240 - 60 * 2),
		cc.p(80, 240 - 60 * 3),
		[9] = cc.p(80 + 100 * 2, 240 - 60 * 3),
		[6] = cc.p(80 + 100, 240 - 60 * 4),
		cc.p(80, 240 - 60 * 5),
		[10] = cc.p(80 + 100 * 2, 240 - 60 * 5),
		[7] = cc.p(80 + 100, 240 - 60 * 6)
	}
	local var_47_1 = {
		6,
		4,
		2,
		7,
		5,
		3,
		1,
		6,
		4,
		2
	}
	local var_47_2 = global_get_servant_skin(arg_47_1)
	local var_47_3 = self:getAddRolePosIndex(var_47_2)
	local var_47_5 = model_data[var_47_2].modelweight
	local var_47_6 = model_data[var_47_2].modelheight
	local var_47_7 = L2Skeleton:create(ROLE_SPINE_PATH .. model_data[var_47_2].spine_model .. ".json", ROLE_SPINE_PATH .. model_data[var_47_2].spine_model .. ".atlas", (model_data[var_47_2].clothes_model or nil) and (CLOTHES_SPINE_PATH .. model_data[var_47_2].clothes_model .. ".atlas" or nil))

	var_47_7._modelid = var_47_2

	self:addSkeletonDownloadInterface(var_47_7)
	var_47_7:showLoadingAni(true)
	var_47_7:refreshSkeleton()

	local var_47_8 = model_data[var_47_2].modelscale or 1

	var_47_7:setScale(var_0_21 * var_47_8 * (model_data[var_47_2].modelflip or 1), var_0_21 * var_47_8)
	var_47_7:play("win", false)
	var_47_7:addAnimation("idle")
	var_47_7:setPosition(var_47_0[var_47_3])
	self.map:addChild(var_47_7, var_47_1[var_47_3])
	self.debutEffect:setVisible(true)
	self.debutEffect:setPosition(var_47_0[var_47_3].x, var_47_0[var_47_3].y + 40)
	self.debutEffect:play("chuchang", false)
	self.debutEffect:setLocalZOrder(var_47_1[var_47_3])
	GlobalPlayRoleSound(var_47_2, ROLE_SOUND_TYPE.fight)

	local var_47_9 = ccui.Layout:create()

	var_47_9:setTouchEnabled(true)
	var_47_9:setAnchorPoint(cc.p(0.5, 0))
	var_47_9:setPosition(0, 0)
	var_47_9:setContentSize(cc.size(var_47_5, var_47_6))
	var_47_7:addChild(var_47_9)
	var_47_9:addTouchEventListener(function(arg_48_0, arg_48_1)
		if arg_48_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.roleSpTouchLock then
			return
		end

		if arg_48_0.isLock then
			return
		end

		arg_48_0.isLock = true

		self:runAction(cc.CallFunc:create(function()
			self:roleSpEventFunc(arg_47_1)
		end))
	end)

	self.skeletonList[var_47_3] = var_47_7
	self.spinePosIdx[arg_47_1] = var_47_3
end

function TowerDefenceSelectLayer:removeRoleSpine(arg_50_1)
	self.skeletonList[self.spinePosIdx[arg_50_1]]:removeFromParent()

	self.skeletonList[self.spinePosIdx[arg_50_1]] = nil
	self.skeletonDataList[self.spinePosIdx[arg_50_1]] = nil
	self.spinePosIdx[arg_50_1] = nil
end

function TowerDefenceSelectLayer.saveRoleList(arg_51_0, arg_51_1)
	local var_51_0 = ""

	for iter_51_0, iter_51_1 in pairs(arg_51_1) do
		var_51_0 = var_51_0 .. iter_51_1 .. ","
	end

	RoleDefault:getInstance():setStringForKey("TowerDefenceLastRoles", var_51_0)
end

function TowerDefenceSelectLayer:batchCreatePlayer()
	if not self.isNeedBatchCreatePlayer then
		return
	end

	self.roleSpTouchLock = true

	local var_52_0 = {
		[4] = cc.p(80 + 100, 240),
		cc.p(80, 240 - 60),
		[8] = cc.p(80 + 100 * 2, 240 - 60),
		[5] = cc.p(80 + 100, 240 - 60 * 2),
		cc.p(80, 240 - 60 * 3),
		[9] = cc.p(80 + 100 * 2, 240 - 60 * 3),
		[6] = cc.p(80 + 100, 240 - 60 * 4),
		cc.p(80, 240 - 60 * 5),
		[10] = cc.p(80 + 100 * 2, 240 - 60 * 5),
		[7] = cc.p(80 + 100, 240 - 60 * 6)
	}
	local var_52_1 = {
		6,
		4,
		2,
		7,
		5,
		3,
		1,
		6,
		4,
		2
	}
	local var_52_2 = 1

	for iter_52_0, iter_52_1 in pairs(self.selectedList) do
		self:runAction(cc.Sequence:create(cc.DelayTime:create((1 - 1) * 0.1), cc.CallFunc:create(function()
			local var_53_0 = global_get_servant_skin(iter_52_0)
			local var_53_1 = self:getAddRolePosIndex(var_53_0)
			local var_53_3 = model_data[var_53_0].modelweight
			local var_53_4 = model_data[var_53_0].modelheight
			local var_53_5 = L2Skeleton:create(ROLE_SPINE_PATH .. model_data[var_53_0].spine_model .. ".json", ROLE_SPINE_PATH .. model_data[var_53_0].spine_model .. ".atlas", (model_data[var_53_0].clothes_model or nil) and (CLOTHES_SPINE_PATH .. model_data[var_53_0].clothes_model .. ".atlas" or nil))

			var_53_5._modelid = var_53_0

			self:addSkeletonDownloadInterface(var_53_5)
			var_53_5:showLoadingAni(true)
			var_53_5:refreshSkeleton()

			local var_53_6 = model_data[var_53_0].modelscale or 1

			var_53_5:setScale(var_0_21 * var_53_6 * (model_data[var_53_0].modelflip or 1), var_0_21 * var_53_6)
			var_53_5:play("idle")
			var_53_5:setRotation(math.random(-120, 120))
			var_53_5:setPosition(var_52_0[var_53_1].x + math.random(-14, 14), 1000)
			self.map:addChild(var_53_5, var_52_1[var_53_1])

			local var_53_7 = ccui.Layout:create()

			var_53_7:setTouchEnabled(true)
			var_53_7:setAnchorPoint(cc.p(0.5, 0))
			var_53_7:setPosition(0, 0)
			var_53_7:setContentSize(cc.size(var_53_3, var_53_4))
			var_53_5:addChild(var_53_7)
			var_53_7:addTouchEventListener(function(arg_54_0, arg_54_1)
				if arg_54_1 ~= ccui.TouchEventType.ended then
					return
				end

				if self.roleSpTouchLock then
					return
				end

				if arg_54_0.isLock then
					return
				end

				arg_54_0.isLock = true

				self:runAction(cc.CallFunc:create(function()
					self:roleSpEventFunc(iter_52_0)
				end))
			end)

			self.skeletonList[var_53_1] = var_53_5
			self.spinePosIdx[iter_52_0] = var_53_1

			local var_53_8 = var_52_2 == table.nums(self.selectedList)

			var_53_5:runAction(cc.Sequence:create(cc.DelayTime:create(var_52_2 * math.random(1, 4) * 0.02), cc.EaseExponentialIn:create(cc.MoveTo:create(0.6, cc.p(var_53_5:getPositionX(), var_52_0[var_53_1].y))), cc.Spawn:create(cc.JumpTo:create(0.2, var_52_0[var_53_1], math.random(2, 4) * 8, math.random(1, 2)), cc.RotateTo:create(0.2, 0)), cc.CallFunc:create(function()
				if var_53_8 then
					self.roleSpTouchLock = false
				end
			end)))

			var_52_2 = var_52_2 + 1
		end)))
	end
end

local var_0_27 = "default/default.json"
local var_0_28 = "default/default.atlas"

function TowerDefenceSelectLayer.addSkeletonDownloadInterface(arg_57_0, arg_57_1)
	local file_check_manager = require("controller.filedownloader.file_check_manager")

	function arg_57_1:checkResource(arg_58_1)
		self._downloadinglist = {}
		self._downloadimg = arg_58_1

		if not arg_58_1 then
			self:onDownloadComplete(arg_58_1)

			return
		end

		local var_58_0 = file_check_manager:checkBattleSpineByModel(self._modelid)

		if #var_58_0 > 0 then
			self:onDownloadComplete({
				json = var_0_27,
				atlas = var_0_28
			})
			self:onDownloadProcessing()
			self:startDownload(var_58_0)
		else
			self:onDownloadComplete(arg_58_1)
		end
	end
end
