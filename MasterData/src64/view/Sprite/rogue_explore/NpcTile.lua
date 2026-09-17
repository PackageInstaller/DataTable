local TileSprite = require("view.Sprite.explore.TileSprite")
local NpcTile = class("NpcTile", function(arg_1_0)
	return TileSprite:createNode(arg_1_0)
end)
local explore_manager = require("controller.explore_manager")
local L2Actor = require("view.Sprite.L2Actor")
local item_manager = require("controller.item_manager")
local model_data = require("data.model_data")
local var_0_6 = config._DEBUG and 0 or 1

function NpcTile:create(arg_2_1)
	local var_2_0 = NpcTile.new(arg_2_1)

	var_2_0:init(arg_2_1)
	var_2_0:initother()

	return var_2_0
end

function NpcTile:initother()
	self.first_trigger = not self.parent.usedTile[self.idx].is_triggered
end

function NpcTile:checkTriggerPrecondition()
	local var_4_0

	if self.tileInfo.result1_type then
		local var_4_1 = not self.tileInfo.result2_type and 1 or self.parent.usedTile[self.idx].result and self.parent.usedTile[self.idx].result or 1

		var_4_0 = {
			type = self.tileInfo["result" .. var_4_1 .. "_type"],
			param = self.tileInfo["result" .. var_4_1 .. "_param"],
			des = self.tileInfo["result" .. var_4_1 .. "_des"],
			result_count = var_4_1
		}
	else
		var_4_0 = {}
	end

	if self.tileInfo.trigger_param2 then
		self.parent.root:addChild(self:npcPopLayer({
			tileInfo = self.tileInfo,
			surecallback = function()
				self:runTileEvent(var_4_0)
			end,
			cancelcallback = function()
				self.parent.root.touchLock = false
			end
		}), 999)
	end

	if self.first_trigger then
		if self.tileInfo.trigger_param1 then
			local function var_4_3()
				if self.npcPop then
					self.npcPop:setVisible(true)
				end

				self.first_trigger = false
				self.parent.usedTile[self.idx].is_triggered = true
			end

			global_basic_scene:addChild(self.tileInfo.trigger_param1_talk_type == 2 and TalkLayer:create(self.tileInfo.trigger_param1, nil, 1, "", var_4_3) or ExploreTalkLayer:create({
				classification = self.tileInfo.trigger_param1,
				finishCallback = var_4_3
			}))
		end
	elseif self.npcPop then
		self.npcPop:setVisible(true)
	end
end

function NpcTile:runTileEvent(arg_8_1)
	local var_8_0
	local var_8_1
	local var_8_3

	if arg_8_1 then
		var_8_0 = arg_8_1.type
		var_8_1 = arg_8_1.param
		var_8_3 = arg_8_1.result_count
	end

	local var_8_5 = {
		room_order = self.parent.curRoomOrder,
		object_idx = self.idx,
		result_type = var_8_0,
		result_param = var_8_1,
		result_count = var_8_3
	}

	explore_manager:trigger_event(var_8_5, function(arg_9_0)
		if arg_9_0.result > 0 then
			self:updateState()

			if self.finishCallback then
				self.finishCallback({
					tileInfo = self.tileInfo,
					msg = arg_9_0,
					eventconfig = var_8_5
				})
			end
		elseif self.finishCallback then
			self.finishCallback({
				tileInfo = self.tileInfo,
				msg = arg_9_0,
				eventconfig = var_8_5
			})
		end
	end)
end

function NpcTile:showTileResult()
	return
end

function NpcTile:npcPopLayer(arg_11_1)
	local var_11_0 = ccui.Layout:create()

	var_11_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_11_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_11_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_11_0:setBackGroundColorOpacity(145)
	var_11_0:setCascadeOpacityEnabled(false)
	var_11_0:setTouchEnabled(true)
	var_11_0:setVisible(false)
	var_11_0:setPositionY(-GameDisplay.fix_y)

	self.npcPop = var_11_0

	var_11_0:addTouchEventListener(function(arg_12_0, arg_12_1)
		if arg_12_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_11_1.cancelcallback then
			arg_11_1.cancelcallback()
		end

		var_11_0:runAction(cc.RemoveSelf:create())

		self.npcPop = nil
	end)

	local var_11_1 = ccui.ImageView:create("public/panelbg/normal_bg_new.png", var_0_6)

	var_11_1:setTouchEnabled(true)
	var_11_1:setScale9Enabled(true)
	var_11_1:setCapInsets(cc.rect(20, 20, 30, 30))
	var_11_1:setContentSize(cc.size(600, var_11_1:getContentSize().height))
	var_11_1:setPosition(320, GameDisplay.height / 2)
	var_11_0:addChild(var_11_1)

	local var_11_2 = ccui.ImageView:create("explore/title_task.png", var_0_6)

	var_11_2:setAnchorPoint(cc.p(0, 0))
	var_11_2:setPosition(0, 454)
	var_11_1:addChild(var_11_2)

	if arg_11_1.tileInfo.trigger_param1 then
		local var_11_3 = ccui.Button:create("explore/npc_talk_bnt.png", nil, "explore/npc_talk_bnt.png", var_0_6)

		var_11_3:setAnchorPoint(cc.p(0.5, 0.5))
		var_11_3:setPosition(var_11_1:getContentSize().width - 50, 165)
		var_11_1:addChild(var_11_3, 9)
		var_11_3:addTouchEventListener(function(arg_13_0, arg_13_1)
			if arg_13_1 ~= ccui.TouchEventType.ended then
				return
			end

			var_11_0:setVisible(false)

			local function var_13_1()
				var_11_0:setVisible(true)
			end

			global_basic_scene:addChild(self.tileInfo.trigger_param1_talk_type == 2 and TalkLayer:create(arg_11_1.tileInfo.trigger_param1, nil, 1, "", var_13_1) or ExploreTalkLayer:create({
				classification = arg_11_1.tileInfo.trigger_param1,
				finishCallback = var_13_1
			}), 999)
		end)
	end

	local var_11_4 = self:readNeedItems(2)

	for iter_11_0, iter_11_1 in ipairs(var_11_4) do
		local var_11_5 = ItemSprite:createNewWithItemId(iter_11_1.needid, 1)

		var_11_5:getChildByName("number"):setString(iter_11_1.ownnum .. "/" .. iter_11_1.neednum)

		if iter_11_1.neednum > iter_11_1.ownnum then
			var_11_5:getChildByName("number"):setColor(cc.c3b(200, 0, 0))
		end

		var_11_5:setScale(0.9)
		var_11_5:setAnchorPoint(cc.p(0.5, 1))
		var_11_5:setPosition(var_11_1:getContentSize().width / 2 + (iter_11_0 - (#var_11_4 + 1) / 2) * 180, var_11_1:getContentSize().height - 30)
		var_11_1:addChild(var_11_5)
		var_11_5:setTouchEnabled(true)
		var_11_5:setSwallowTouches(true)
		var_11_5:addSpriteTouchEventListener(function(arg_15_0, arg_15_1)
			if arg_15_1 ~= ccui.TouchEventType.ended then
				return
			end

			PopLayer:Item({
				hideGainButton = true,
				itemid = iter_11_1.needid,
				itemnum = explore_manager:getItemNumber(iter_11_1.needid)
			})
		end)
	end

	local var_11_6 = ccui.Layout:create()

	var_11_6:setContentSize(cc.size(500, 150))
	var_11_6:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_11_6:setBackGroundColor(cc.c3b(23, 22, 47))
	var_11_6:setBackGroundColorOpacity(120)
	var_11_6:setCascadeOpacityEnabled(false)
	var_11_6:setAnchorPoint(cc.p(0.5, 0))
	var_11_6:setPosition(var_11_1:getContentSize().width / 2, 20)
	var_11_1:addChild(var_11_6)

	local var_11_7 = cc.Label:createWithTTF(arg_11_1.tileInfo.trigger_des, FONT_NAME, 26)

	var_11_7:setMaxLineWidth(490)
	var_11_7:setAnchorPoint(cc.p(0.5, 0.5))
	var_11_7:setPosition(var_11_6:getContentSize().width / 2, var_11_6:getContentSize().height / 2)
	var_11_6:addChild(var_11_7)

	local var_11_8 = ccui.Button:create("public/button/public_button_big_y.png", nil, "public/button/public_button_big_y_on.png", var_0_6)

	var_11_8:setScale9Enabled(true)

	local var_11_9 = var_11_8:getContentSize()

	var_11_8:setCapInsets(cc.rect(var_11_9.width / 2 - 10, var_11_9.height / 2 - 10, 10, 10))
	var_11_8:setContentSize(cc.size(450, 80))
	var_11_8:setTitleText(L_BUTTON_TEXT.Item_Panel_Btn.Sure)
	var_11_8:setTitleColor(cc.c3b(0, 0, 0))
	var_11_8:setTitleFontName(FONT_BUTTON)
	var_11_8:setTitleFontSize(30)
	var_11_8:setPosition(var_11_1:getContentSize().width / 2, -100)
	var_11_1:addChild(var_11_8)
	var_11_8:addTouchEventListener(function(arg_16_0, arg_16_1)
		if arg_16_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_11_1.surecallback then
			arg_11_1.surecallback()
		end

		var_11_0:runAction(cc.RemoveSelf:create())

		self.npcPop = nil
	end)

	return var_11_0
end

return NpcTile
