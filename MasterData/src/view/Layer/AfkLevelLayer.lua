AfkLevelLayer = class("AfkLevelLayer", function()
	return cc.Layer:create()
end)

local var_0_0 = config._DEBUG and 0 or 1
local item_manager = require("controller.item_manager")
local core_manager = require("controller.core_manager")
local level_manager = require("controller.level_manager")
local souls_manager = require("controller.souls_manager")
local activity_manager = require("controller.activity_manager")
local role_false_level_manager = require("controller.role_false_level_manager")
local time_check_manager = require("controller.time_check_manager")
local item_data = require("data.item_data")
local model_data = require("data.model_data")
local servant_data = require("data.servant_data")
local major_factor_data = require("data.major_factor_data")
local playermodel = require("model.playermodel")

function AfkLevelLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = AfkLevelLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function AfkLevelLayer:init(arg_3_1)
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "AfkLevelLayer.json" or "AfkLevelLayer.ExportJson")

	self:addChild(self.rootLayer, 1)
	self:initUI()
	self:registerActivityEventListener()
	role_false_level_manager:get_afklevel_data()
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" then
			activity_manager:releaseEventListenerByName("AfkLevelLayer")
			RoleDefault:getInstance():setIntegerForKey("MaxafkLevel", role_false_level_manager:getCurMaxAfkLevel())
			role_false_level_manager:checkAlert()
		end
	end)
end

function AfkLevelLayer.registerActivityEventListener(arg_5_0)
	activity_manager:registerEventListener("AfkLevelLayer", activity_manager.activityEventId.AFKLEVEL_DATA_UPDATE, function(arg_6_0)
		arg_5_0:updateAfkLevel()
	end)
end

function AfkLevelLayer:initUI()
	self:initBottomList()
	self:initTitle()
	self:initBeforePanel()
	self:initAfterPanel()
	self:initServantPanle()
end

function AfkLevelLayer:initBottomList()
	self.bottomList = self.rootLayer:getChildByName("bottom")

	self.bottomList:setPositionY(self.bottomList:getPositionY() - GameDisplay.fix_y)
	self.bottomList:getChildByName("btn_back"):addTouchEventListener(function(arg_9_0, arg_9_1)
		if arg_9_1 ~= ccui.TouchEventType.ended then
			return
		end

		KeyCodeManager:onKeyReleasedCallFunc()
	end)
end

function AfkLevelLayer:initTitle()
	self.titlePanel = self.rootLayer:getChildByName("title_bg")

	self.titlePanel:setPositionY(self.titlePanel:getPositionY() + GameDisplay.fix_y)

	local function var_10_0(arg_11_0, arg_11_1)
		if arg_11_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopActivityDetail", {
			key = "AfkLevelLayer"
		})
	end

	self.titlePanel:getChildByName("title"):addTouchEventListener(var_10_0)
	self.titlePanel:getChildByName("title_1"):addTouchEventListener(var_10_0)

	local var_10_1 = self.titlePanel:getChildByName("contract_attr_bg")

	self.contractAttrNum = var_10_1:getChildByName("contract_attr_num")

	self.contractAttrNum:setString(souls_manager:get_total_contract_attr())
	var_10_1:setTouchEnabled(true)
	var_10_1:addTouchEventListener(function(arg_12_0, arg_12_1)
		if arg_12_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopContractAttrDetailLayer", {
			unShowbtn = true
		})
	end)
	ccui.Helper:seekWidgetByName(self.rootLayer, "servant_lbl_1"):setString(L_AFKLAYER[1])
	ccui.Helper:seekWidgetByName(self.rootLayer, "servant_lbl_2"):setString(L_AFKLAYER[2])
	ccui.Helper:seekWidgetByName(self.rootLayer, "servant_lbl_3"):setString(L_AFKLAYER[3])
end

function AfkLevelLayer:initBeforePanel()
	self.beforePanel = self.rootLayer:getChildByName("before_panel")

	self.beforePanel:setPositionY(self.beforePanel:getPositionY() + GameDisplay.fix_y)
	self.beforePanel:setVisible(true)

	local var_13_0 = L2Skeleton:create((UI_SPINE_PATH .. "afklevel/skeleton") .. ".json", (UI_SPINE_PATH .. "afklevel/skeleton") .. ".atlas", nil, true)

	var_13_0:refreshSkeleton()
	var_13_0:setPosition(cc.p(320, -38))
	var_13_0:play("animation", true)
	self.beforePanel:addChild(var_13_0, 0)

	local var_13_1 = cc.Label:createWithTTF(L_AFKLEVEL_LAYER.xietiao, FONT_DES, 16)

	var_13_1:setPosition(cc.p(-1, 5))
	var_13_1:setColor(cc.c3b(168, 166, 191))
	var_13_0:addChild(var_13_1)

	self.beforeAfklevelLbl = cc.Label:createWithTTF("", FONT_DES, 34)

	self.beforeAfklevelLbl:setPosition(cc.p(-1, -25))
	self.beforeAfklevelLbl:setColor(cc.c3b(251, 191, 48))
	var_13_0:addChild(self.beforeAfklevelLbl)

	self.beforeSprite = {}

	for iter_13_0 = 1, 5 do
		self.beforeSprite[iter_13_0] = self.beforePanel:getChildByName("sp_" .. iter_13_0)
	end
end

function AfkLevelLayer:initAfterPanel()
	self.afterPanel = self.rootLayer:getChildByName("after_panel")

	self.afterPanel:setPositionY(self.afterPanel:getPositionY() + GameDisplay.fix_y)

	self.afterIcon = {}

	for iter_14_0 = 1, 5 do
		self.afterIcon[iter_14_0] = self.afterPanel:getChildByName("icon_" .. iter_14_0)
	end

	self.afterAfklevelLbl = self.afterPanel:getChildByName("before_afklevel_lbl")
	self.afterLevelBtn = self.afterPanel:getChildByName("after_level_btn")

	self.afterLevelBtn:addTouchEventListener(function(arg_15_0, arg_15_1)
		if arg_15_1 ~= ccui.TouchEventType.ended then
			return
		end

		role_false_level_manager:afklevel_levelup()
	end)

	self.afterCostBg = self.afterPanel:getChildByName("after_num_bg")
end

function AfkLevelLayer:initServantPanle()
	self.cellSpriteNum = 5
	self.servantPanel = self.rootLayer:getChildByName("servant_panel")

	self.servantPanel:setPositionY(self.servantPanel:getPositionY() + GameDisplay.fix_y)

	self.girlSpriteTemp = self.rootLayer:getChildByName("tempSprite")

	local var_16_0 = self.servantPanel:getChildByName("temple_view")

	self.servantView = cc.TableView:create(cc.size(640, var_16_0:getContentSize().height + GameDisplay.fix_y * 2))

	self.servantView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.servantView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.servantView:setAnchorPoint(cc.p(0, 0))
	self.servantView:setPositionY(var_16_0:getPositionY() - GameDisplay.fix_y * 2)
	self.servantView:setDelegate()
	self.servantView:setName("servantView")
	self.servantPanel:addChild(self.servantView)
	self.servantView:registerScriptHandler(function(arg_18_0, arg_18_1)
		return 640, 1050 / self.cellSpriteNum
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.servantView:registerScriptHandler(function(arg_17_0, arg_17_1)
		local var_17_0 = arg_17_0:dequeueCell() or cc.TableViewCell:create()

		self:updateServantViewCell(var_17_0, arg_17_1)

		return var_17_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.servantView:registerScriptHandler(function(arg_19_0, arg_19_1)
		return math.ceil(#self.servantList / self.cellSpriteNum)
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
end

function AfkLevelLayer:updateAfkLevel()
	self.afklevel = role_false_level_manager:getCurAfkLevel()

	if self.afklevel < 300 then
		self:updateBeforePanel()
	else
		self:updateAfterPanel()
	end

	self:updateServantPanle()
end

function AfkLevelLayer:updateBeforePanel()
	self.afterPanel:setVisible(false)
	self.beforePanel:setVisible(true)
	self.beforeAfklevelLbl:setString(self.afklevel)

	local var_21_0 = role_false_level_manager:getBeforeServantList()

	for iter_21_0 = 1, 5 do
		local var_21_1 = self.beforeSprite[iter_21_0]:getChildByName("lv")
		local var_21_2 = self.beforeSprite[iter_21_0]:getChildByName("clip")
		local var_21_3 = self.beforeSprite[iter_21_0]:getChildByName("down")
		local var_21_4 = var_21_2:getChildByName("servant")
		local var_21_5 = var_21_2:getChildByName("servant_add")

		if not var_21_5 then
			var_21_5 = ccui.ImageView:create("AfkLevelLayer/servant_add.png", var_0_0)

			var_21_5:setName("servant_add")
			var_21_2:addChild(var_21_5)
			var_21_5:setAnchorPoint(0.5, 0.5)
			var_21_5:setPosition(var_21_2:getContentSize().width / 2, var_21_2:getContentSize().height / 2)
			var_21_5:setTouchEnabled(true)
		end

		if var_21_0[iter_21_0] then
			local var_21_6 = global_get_servant_skin(var_21_0[iter_21_0].servantid)

			self.beforeSprite[iter_21_0]:loadTexture("AfkLevelLayer/have_up.png", var_0_0)
			var_21_3:loadTexture("AfkLevelLayer/have_down.png", var_0_0)
			var_21_4:loadTexture("roleimage/role/shop_image/" .. model_data[var_21_6].role_image .. ".png")
			var_21_1:setString(var_21_0[iter_21_0].level)
			var_21_1:setVisible(true)
			var_21_4:setScale(0.6)
			var_21_4:setVisible(true)
			var_21_4:setTouchEnabled(true)
			var_21_4:addTouchEventListener(function(arg_22_0, arg_22_1)
				if arg_22_1 ~= ccui.TouchEventType.ended then
					return
				end

				if #var_21_0 < 5 then
					global_ShowBlockWords("没有五个角色")

					return
				end

				LayerManager:pushInLayer("GirlSelectLayer", {
					selectType = SELECT_GIRL_AFK_LEVEL,
					sureCallBack = function(arg_23_0)
						role_false_level_manager:setBeforeServantList(iter_21_0, arg_23_0)
					end
				})
			end)
			var_21_5:setVisible(false)
		else
			self.beforeSprite[iter_21_0]:loadTexture("AfkLevelLayer/nil_up.png", var_0_0)
			var_21_3:loadTexture("AfkLevelLayer/nil_down.png", var_0_0)
			var_21_1:setVisible(false)
			var_21_4:setVisible(false)
			var_21_5:setVisible(true)
			var_21_5:addTouchEventListener(function(arg_24_0, arg_24_1)
				if arg_24_1 ~= ccui.TouchEventType.ended then
					return
				end

				global_ShowBlockWords("没有五个角色")
			end)
		end
	end
end

function AfkLevelLayer:updateAfterPanel()
	self.afterPanel:setVisible(true)
	self.beforePanel:setVisible(false)
	self.afterAfklevelLbl:setString(self.afklevel)

	local var_25_0 = math.floor(self.afklevel % 10 / 2)

	for iter_25_0 = 1, 5 do
		self.afterIcon[iter_25_0]:setVisible(iter_25_0 <= var_25_0)
	end

	local var_25_1 = role_false_level_manager:getCurAfkLevelNeedContractAttr()
	local var_25_2 = self.afterCostBg:getChildByName("tiaojian_num")

	var_25_2:setString(var_25_1)

	if var_25_1 > souls_manager:get_total_contract_attr() then
		var_25_2:setColor(cc.c3b(255, 13, 0))
	else
		var_25_2:setColor(cc.c3b(255, 255, 255))
	end

	local var_25_3 = role_false_level_manager:getCurAfkLevelNeeditem()

	for iter_25_1 = 1, 2 do
		local var_25_4 = self.afterCostBg:getChildByName("xiaohao_icon_" .. iter_25_1)
		local var_25_5 = self.afterCostBg:getChildByName("xiaohao_num_" .. iter_25_1)
		local var_25_6 = cc.c3b(255, 255, 255)

		if var_25_3[iter_25_1] then
			local var_25_7

			if var_25_3[iter_25_1].itemid == "costIntensitemNum" then
				var_25_7 = "equipment/1000004.png"
				var_25_6 = playermodel.strengthpoint > var_25_3[iter_25_1].num and var_25_6 or cc.c3b(255, 13, 0)
			else
				var_25_7 = "equipment/" .. item_data[var_25_3[iter_25_1].itemid].image_id .. ".png"
				var_25_6 = item_manager:isHaveEnoughItem(var_25_3[iter_25_1].itemid, var_25_3[iter_25_1].num) and var_25_6 or cc.c3b(255, 13, 0)
			end

			var_25_4:setScale(0.25)
			var_25_4:setVisible(true)
			var_25_5:setVisible(true)
			var_25_5:setColor(var_25_6)
			var_25_5:setString(var_25_3[iter_25_1].num)
			var_25_4:loadTexture(var_25_7)
		else
			var_25_4:setVisible(false)
			var_25_5:setVisible(false)
		end
	end
end

function AfkLevelLayer:updateServantPanle()
	for iter_26_0 = 1, 3 do
		self.servantPanel:getChildByName("servant_lbl_" .. iter_26_0):setVisible(self.afklevel < 300)
	end

	self.servantList = role_false_level_manager:getAfkLevelServantList()

	local var_26_0 = self.servantPanel:getChildByName("servant_num_bg")

	var_26_0:setPositionY(self.afklevel < 300 and 981 or 965)

	local var_26_1, var_26_2 = role_false_level_manager:getServantNum()

	var_26_0:getChildByName("servant_num"):setString(string.format("%d/%d", var_26_2, var_26_1))

	if not self.servantView.isloaded then
		self.servantView:reloadData()

		self.servantView.isloaded = true
	else
		self:updateShowingCells()
	end
end

function AfkLevelLayer.getAttrIconPath(arg_27_0, arg_27_1)
	local var_27_0 = global_get_all_model_attrs(servant_data[arg_27_1].modelid)
	local var_27_1 = var_27_0.main

	if var_27_0.sub and next(var_27_0.sub) then
		for iter_27_0, iter_27_1 in ipairs(var_27_0.sub) do
			var_27_1 = var_27_1 .. "_" .. iter_27_1
		end
	end

	return var_27_1
end

function AfkLevelLayer:updateServantViewCell(arg_28_1, arg_28_2)
	for iter_28_0 = 1, self.cellSpriteNum do
		local var_28_0 = arg_28_1:getChildByName("sprite_" .. iter_28_0)

		if not var_28_0 then
			var_28_0 = self.girlSpriteTemp:clone()

			var_28_0:setAnchorPoint(cc.p(0, 0.5))
			var_28_0:setPositionX(10 + 125 * (iter_28_0 - 1))
			var_28_0:setPositionY(525 / self.cellSpriteNum)
			var_28_0:setName("sprite_" .. iter_28_0)
			arg_28_1:addChild(var_28_0)
		end

		local var_28_1 = self.cellSpriteNum * arg_28_2 + iter_28_0
		local var_28_2 = self.servantList[self.cellSpriteNum * arg_28_2 + iter_28_0]
		local var_28_3 = var_28_0:getChildByName("lock")
		local var_28_4 = var_28_0:getChildByName("add")
		local var_28_5 = var_28_0:getChildByName("clip")
		local var_28_6 = var_28_0:getChildByName("time_lock")

		self.servantList[self.cellSpriteNum * arg_28_2 + iter_28_0].cd = nil

		if not self.servantList[self.cellSpriteNum * arg_28_2 + iter_28_0] then
			var_28_0:setVisible(false)
		elseif self.servantList[self.cellSpriteNum * arg_28_2 + iter_28_0].cd and self.servantList[self.cellSpriteNum * arg_28_2 + iter_28_0].cd > time_check_manager:getCurTime() then
			var_28_0:setVisible(true)
			var_28_3:setVisible(false)
			var_28_4:setVisible(false)
			var_28_5:setVisible(false)
			var_28_6:setVisible(true)
			var_28_6:getChildByName("time"):setString(L_AFKLEVEL_LAYER.time_lock)
		elseif self.servantList[self.cellSpriteNum * arg_28_2 + iter_28_0].chapter then
			var_28_0:setVisible(true)
			var_28_3:setVisible(true)
			var_28_4:setVisible(false)
			var_28_5:setVisible(false)
			var_28_6:setVisible(false)

			local var_28_7 = level_manager:formatSystemUnlockLevel(self.servantList[self.cellSpriteNum * arg_28_2 + iter_28_0].chapter)

			var_28_3:getChildByName("des"):setString(L_AFKLEVEL_LAYER.lock)
			var_28_3:getChildByName("des_1"):setString(L_AFKLEVEL_LAYER.lock_1)
			var_28_3:getChildByName("level"):setString(var_28_7)
			var_28_3:getChildByName("diamond"):setString(self.servantList[self.cellSpriteNum * arg_28_2 + iter_28_0].diamond .. L_DIAMOND)
		elseif self.servantList[self.cellSpriteNum * arg_28_2 + iter_28_0].diamond then
			var_28_0:setVisible(true)
			var_28_3:setVisible(true)
			var_28_4:setVisible(false)
			var_28_5:setVisible(false)
			var_28_6:setVisible(false)
			var_28_3:getChildByName("des"):setString("")
			var_28_3:getChildByName("level"):setString("")
			var_28_3:getChildByName("des_1"):setString(L_AFKLEVEL_LAYER.lock_2)
			var_28_3:getChildByName("diamond"):setString(self.servantList[self.cellSpriteNum * arg_28_2 + iter_28_0].diamond .. L_DIAMOND)
		elseif self.servantList[self.cellSpriteNum * arg_28_2 + iter_28_0].sid then
			var_28_0:setVisible(true)
			var_28_3:setVisible(false)
			var_28_4:setVisible(false)
			var_28_5:setVisible(true)
			var_28_6:setVisible(false)

			local var_28_8 = global_get_servant_skin(self.servantList[self.cellSpriteNum * arg_28_2 + iter_28_0].sid)
			local var_28_9 = souls_manager:get_servant_cur_roll_rarity(self.servantList[self.cellSpriteNum * arg_28_2 + iter_28_0].sid)
			local var_28_10 = CAREER_ICON[servant_data[self.servantList[self.cellSpriteNum * arg_28_2 + iter_28_0].sid].career .. "_" .. self:getAttrIconPath(self.servantList[self.cellSpriteNum * arg_28_2 + iter_28_0].sid)]

			var_28_5:getChildByName("servant"):setScale(0.6)
			var_28_5:getChildByName("servant"):loadTexture("roleimage/role/shop_image/" .. model_data[var_28_8].role_image .. ".png")
			var_28_5:getChildByName("rarity"):loadTexture("public/rolebg/girlselect_rarity_" .. var_28_9 .. ".png", var_0_0)
			var_28_5:getChildByName("icon"):loadTexture(var_28_10, var_0_0)
			var_28_5:getChildByName("name"):setString(major_factor_data[servant_data[self.servantList[self.cellSpriteNum * arg_28_2 + iter_28_0].sid].major].easy_name)
			var_28_5:getChildByName("level"):setString(self.afklevel)

			local var_28_11 = playermodel.soulOverClock[self.servantList[self.cellSpriteNum * arg_28_2 + iter_28_0].sid] or 0

			if playermodel.soulContract[self.servantList[self.cellSpriteNum * arg_28_2 + iter_28_0].sid] > 0 and var_28_11 == 0 then
				var_28_5:getChildByName("class"):setVisible(true)
				var_28_5:getChildByName("class"):loadTexture("public/rolebg/girlsprite_class_" .. playermodel.soulContract[self.servantList[self.cellSpriteNum * arg_28_2 + iter_28_0].sid] .. ".png", var_0_0)
			elseif var_28_11 > 0 then
				var_28_5:getChildByName("class"):setVisible(true)
				var_28_5:getChildByName("class"):loadTexture("public/rolebg/girlsprite_class_oc.png", var_0_0)
			else
				var_28_5:getChildByName("class"):setVisible(false)
			end
		else
			var_28_0:setVisible(true)
			var_28_3:setVisible(false)
			var_28_4:setVisible(true)
			var_28_5:setVisible(false)
			var_28_6:setVisible(false)
		end

		var_28_0:setSwallowTouches(false)
		var_28_0:addTouchEventListener(function(arg_29_0, arg_29_1)
			if arg_29_1 ~= ccui.TouchEventType.ended then
				return
			end

			if math.abs(arg_29_0:getTouchBeganPosition().y - arg_29_0:getTouchEndPosition().y) > 25 then
				return
			end

			if not var_28_2 then
				return
			elseif var_28_2.cd and var_28_2.cd > time_check_manager:getCurTime() then
				role_false_level_manager:afklevel_clear_cd(var_28_1)
			elseif var_28_2.chapter then
				role_false_level_manager:afklevel_unlock_slot()
			elseif var_28_2.diamond then
				role_false_level_manager:afklevel_unlock_slot()
			elseif var_28_2.sid then
				role_false_level_manager:afklevel_servant_down(var_28_1)
			else
				LayerManager:pushInLayer("GirlSelectLayer", {
					selectType = SELECT_GIRL_AFK_LEVEL,
					sureCallBack = function(arg_30_0)
						role_false_level_manager:afklevel_servant_up(var_28_1, arg_30_0)
					end
				})
			end
		end)
	end
end

function AfkLevelLayer:updateShowingCells()
	local var_31_0, var_31_1 = GetTableViewShowCellIdx(self.servantView, {
		maxcount = math.ceil(#self.servantList / self.cellSpriteNum),
		cellsize = cc.size(640, 1050 / self.cellSpriteNum)
	})

	for iter_31_0 = var_31_0, var_31_1 do
		self.servantView:updateCellAtIndex(iter_31_0)
	end
end
