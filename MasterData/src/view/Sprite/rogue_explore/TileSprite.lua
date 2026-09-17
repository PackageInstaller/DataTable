local TileSprite = class("TileSprite", function()
	return cc.Node:create()
end)
local var_0_1 = config._DEBUG and 0 or 1
local explore_manager = require("controller.explore_manager")
local item_manager = require("controller.item_manager")
local l2utils = require("controller.l2utils")
local L2Actor = require("view.Sprite.L2Actor")
local audio_manager = require("controller.audio_manager")
local audio_module = require("controller.audio_module")
local explore_img_data = require("data.explore.explore_img_data")
local model_data = require("data.model_data")

TILE_SIZE = 100

local var_0_10 = 0.24
local var_0_11 = {
	shake = function(arg_2_0, arg_2_1)
		local var_2_0 = {}

		for iter_2_0 = 1, 3 do
			var_2_0[iter_2_0] = cc.Sequence:create(cc.MoveBy:create(0.05 / (iter_2_0 * iter_2_0), cc.p(2 * 10 / iter_2_0, 5 * 10 / iter_2_0)), cc.MoveBy:create(0.05 / (iter_2_0 * iter_2_0), cc.p(-(2 * 10 / iter_2_0), -(5 * 10 / iter_2_0))), cc.MoveBy:create(0.05 / (iter_2_0 * iter_2_0), cc.p(-(2 * 10 / iter_2_0), -(5 * 10 / iter_2_0))), cc.MoveBy:create(0.05 / (iter_2_0 * iter_2_0), cc.p(2 * 10 / iter_2_0, 5 * 10 / iter_2_0)))
		end

		arg_2_1:runAction(cc.Sequence:create(var_2_0[1], var_2_0[2], var_2_0[3]))
	end,
	splash = function(arg_3_0, arg_3_1)
		local var_3_0 = tonumber(arg_3_0) or 0.5
		local var_3_1 = arg_3_1.root.effectLayer

		arg_3_1.root.effectLayer:setOpacity(255)
		var_3_1:setVisible(true)
		var_3_1:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
		var_3_1:setBackGroundColor(cc.c3b(255, 255, 255))
		var_3_1:setBackGroundColorOpacity(255)
		var_3_1:setOpacity(255)
		var_3_1:runAction(cc.Sequence:create(cc.Blink:create(var_3_0, 3), cc.FadeOut:create(0.2), cc.Hide:create()))
	end
}

function TileSprite:createNode(arg_4_1)
	return TileSprite.new()
end

function TileSprite:create(arg_5_1)
	local var_5_0 = TileSprite.new()

	var_5_0:init(arg_5_1)

	return var_5_0
end

function TileSprite:retain()
	cc.Ref.retain(self)

	if self.icon.type == "spine" or self.icon.type == "ani" then
		self.icon:retain()
	end
end

function TileSprite:release()
	cc.Ref.release(self)

	if self.icon.type == "spine" or self.icon.type == "ani" then
		self.icon:release()
	end
end

function TileSprite:init(arg_8_1)
	self.initConfig = arg_8_1
	self.tileInfo = arg_8_1.tileInfo
	self.parent = arg_8_1.parent
	self.tileid = arg_8_1.tileInfo.id
	self.idx = arg_8_1.idx
	self.order = arg_8_1.order
	self.pos = arg_8_1.pos
	self.zOrder = arg_8_1.zOrder
	self.fullImage = arg_8_1.fullImage
	self.size_num = arg_8_1.size_num
	self.controller_idx = self.parent.usedTile[self.idx].controller

	self:setPosition(self.pos)
	self:setName(self.order .. "object")

	self._buffers = {}

	self.parent.iconLayout:addChild(self, self.zOrder)
	self:createIcon()
end

function TileSprite:reset(arg_9_1)
	self.initConfig = arg_9_1
	self.tileInfo = arg_9_1.tileInfo
	self.tileid = arg_9_1.tileInfo.id
	self.size_num = arg_9_1.size_num

	explore_manager:resetObject(self.parent.curRoomOrder, self.idx, self.tileid)

	self.parent.tileobjects[self.idx] = self.parent:createTileObject(arg_9_1.tileInfo, self.idx, self.order, self.pos)

	self:removeIcon()
	self:runAction(cc.RemoveSelf:create())
end

function TileSprite:releaseSelf()
	explore_manager:removeObject(self.parent.curRoomOrder, self.idx)
	self:removeIcon()
	self:runAction(cc.RemoveSelf:create())
end

function TileSprite:isTileActive()
	assert(self.tileInfo.trigger_count, self.tileInfo.id)

	if self.tileInfo.trigger_count > 0 then
		if self.tileInfo.trigger_count > self.parent.usedTile[self.idx].usedcount then
			return true
		else
			return false
		end
	else
		return true
	end
end

function TileSprite:isTileCanPass()
	if self.tileInfo.is_block and self.tileInfo.is_block == 1 then
		return not self:isTileActive()
	else
		return true
	end
end

function TileSprite:isTileShow()
	if not self.tileInfo.icon and not self.tileInfo.ani and not self.tileInfo.model and not self.tileInfo.horcruxid then
		return false
	end

	if self.tileInfo.is_show_icon == 0 then
		return false
	end

	return self:isTileActive()
end

function TileSprite:createIcon()
	self:createLight()

	if not self:isTileShow() then
		return false
	end

	if self.tileInfo.icon then
		self.icon = cc.Sprite:createWithSpriteFrameName("tiles_" .. self.fullImage .. "/" .. self.tileInfo.icon .. ".png")
		self.icon.path = self.tileInfo.icon

		self.icon:setAnchorPoint(cc.p(0, 0))
		self:addChild(self.icon)

		self.icon.size = self.icon:getContentSize()
		self.icon.type = "img"

		if self.tileInfo.is_big_icon and self.tileInfo.is_shadow then
			self.icon:setPositionY(TILE_SIZE / 2)

			self.shadow = ccui.ImageView:create("explore/shadow.png", var_0_1)

			self.shadow:setScale(0.9)
			self.shadow:setPosition(TILE_SIZE / 2, TILE_SIZE / 2 - 10)
			self:addChild(self.shadow)
		end
	elseif self.tileInfo.model then
		local var_14_0 = tostring(self.tileInfo.model)
		local var_14_1 = model_data[var_14_0].spine_model
		local var_14_2 = model_data[var_14_0].clothes_model
		local var_14_3 = (self.tileInfo.model_scale or 1) * var_0_10 * (model_data[var_14_0].modelscale > 1.3 and 1.3 or model_data[var_14_0].modelscale)
		local var_14_4 = cc.size(model_data[var_14_0].modelweight, model_data[var_14_0].modelheight)

		self.icon = L2Actor:create(ROLE_SPINE_PATH .. var_14_1 .. ".json", ROLE_SPINE_PATH .. var_14_1 .. ".atlas", (var_14_2 or nil) and (CLOTHES_SPINE_PATH .. var_14_2 .. ".atlas" or nil))

		self.icon:setScale(var_14_3 * (self.tileInfo.isFlippedX == 1 and -1 or 1), var_14_3)
		self.icon:setContentSize(var_14_4)
		self.icon:playAni(nil, self.tileInfo.act or "idle", true)

		local var_14_5 = 0
		local var_14_6 = 0

		if self.tileInfo.icon_offset then
			var_14_5, var_14_6 = self.tileInfo.icon_offset:match("([^,]+),(.+)")
			var_14_6 = tonumber(var_14_6)
			var_14_5 = tonumber(var_14_5)
		end

		self.icon:setPosition(TILE_SIZE / 2 + var_14_5 * TILE_SIZE, TILE_SIZE / 2 + var_14_6 * TILE_SIZE)

		self.icon.type = "spine"
		self.icon.size = var_14_4
		self.icon.scale = var_14_3
		self.scale = var_14_3

		self:addChild(self.icon)
	elseif self.tileInfo.ani then
		local var_14_7 = self.tileInfo.ani or "black_role"

		self.icon = L2Skeleton:create("spine/explore/" .. var_14_7 .. ".json", "spine/explore/" .. var_14_7 .. ".atlas", nil, true)

		self.icon:refreshSkeleton()
		self.icon:setSpeedScale(0.6)

		self.icon.type = "ani"

		local var_14_8 = self.tileInfo.ani_scale or 1

		self.icon:setScale(var_14_8, var_14_8)
		self.icon:play(self.tileInfo.act or "animation")
		self:addChild(self.icon, 3)
	end

	self.icon:setName("icon")

	self.iconPosTable = {
		self.icon:getPositionX(),
		(self.icon:getPositionY())
	}

	self:createAimTitle()
end

function TileSprite:setScale(arg_15_1, arg_15_2)
	if not self.tileInfo.model then
		return
	end

	self.icon:setScale(arg_15_1, arg_15_2)
end

function TileSprite:createAimTitle()
	if self.parent.aimTypeTbl[self.tileid] and self.parent.aimTypeTbl[self.tileid].flag < self.parent.aimTypeTbl[self.tileid].num then
		local var_16_0

		if self.parent.aimTypeTbl[self.tileid].result_type == "map" then
			var_16_0 = "explore/small_map_aim.png"
		elseif self.parent.aimTypeTbl[self.tileid].result_type == "bridge" then
			var_16_0 = "explore/small_map_branch_aim.png"
		end

		local var_16_1

		if config._DEBUG then
			var_16_1 = cc.Sprite:create(var_16_0) or cc.Sprite:createWithSpriteFrameName(var_16_0)
		end

		var_16_1:setName("icon_title")
		var_16_1:setScale(1.2)
		var_16_1:setAnchorPoint(cc.p(0.5, 1))

		local var_16_2 = 0
		local var_16_3 = 0

		if self.tileInfo.title_offset then
			var_16_2, var_16_3 = self.tileInfo.title_offset:match("([^,]+),(.+)")
			var_16_3 = tonumber(var_16_3)
			var_16_2 = tonumber(var_16_2)
		end

		if self.icon.type == "img" then
			var_16_1:setPosition(self.icon.size.width / 2 + var_16_2, self.icon.size.height + 20 + var_16_3)
		elseif self.icon.type == "spine" then
			var_16_1:setPosition(self.icon.size.width * math.abs(self.icon.scale) / 2 - 20 + var_16_2, self.icon.size.height * math.abs(self.icon.scale) + 30 + var_16_3)
		end

		self.icon:addChild(var_16_1)
		var_16_1:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.MoveBy:create(0.8, cc.p(0, 20)), cc.MoveBy:create(0.8, cc.p(0, -20)))))
	elseif self.tileInfo.title_img then
		local var_16_4

		if config._DEBUG then
			var_16_4 = cc.Sprite:create("explore/" .. self.tileInfo.title_img .. ".png") or cc.Sprite:createWithSpriteFrameName("explore/" .. self.tileInfo.title_img .. ".png")
		end

		var_16_4:setName("icon_title")
		var_16_4:setScale(1.2)
		var_16_4:setAnchorPoint(cc.p(0.5, 1))

		local var_16_5 = 0
		local var_16_6 = 0

		if self.tileInfo.title_offset then
			var_16_5, var_16_6 = self.tileInfo.title_offset:match("([^,]+),(.+)")
			var_16_6 = tonumber(var_16_6)
			var_16_5 = tonumber(var_16_5)
		end

		if self.icon.type == "img" then
			var_16_4:setPosition(self.icon.size.width / 2 + var_16_5, self.icon.size.height + 20 + var_16_6)
		elseif self.icon.type == "spine" then
			var_16_4:setPosition(self.icon.size.width * math.abs(self.icon.scale) / 2 - 20 + var_16_5, self.icon.size.height * math.abs(self.icon.scale) + 30 + var_16_6)
		end

		self.icon:addChild(var_16_4)
		var_16_4:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.MoveBy:create(0.8, cc.p(0, 20)), cc.MoveBy:create(0.8, cc.p(0, -20)))))
	end
end

function TileSprite:createLight()
	if self.tileInfo.light then
		local var_17_0 = self.tileInfo.light_offset_x or 0
		local var_17_1 = self.tileInfo.light_offset_y or 0
		local var_17_2 = self.tileInfo.light_scale or 1
		local var_17_3

		if self.tileInfo.light_opacity then
			var_17_3 = self.tileInfo.light_opacity or 1

			local var_17_4

			if config._DEBUG then
				var_17_4 = cc.Sprite:create("explore/" .. self.tileInfo.light .. ".png") or cc.Sprite:createWithSpriteFrameName("explore/" .. self.tileInfo.light .. ".png")
			end
		end

		self.light = var_17_4

		self.light:setPosition(self.pos.x + self.size_num.width * 100 / 2 + var_17_0, self.pos.y + self.size_num.height * 100 / 2 + var_17_1)
		self.light:setScale(var_17_2)
		self.light:setOpacity(255 * var_17_3)
		self.light:setBlendFunc(GL_SRC_ALPHA, GL_ONE)
		self.parent.iconLayout:addChild(self.light, 99)
	end
end

function TileSprite:removeIcon()
	if self.icon then
		self.icon:removeFromParent()

		self.icon = nil
	end

	if self.shadow then
		self.shadow:removeFromParent()

		self.shadow = nil
	end

	if self.light then
		self.light:removeFromParent()

		self.light = nil
	end
end

function TileSprite:popTalkSp(arg_19_1, arg_19_2, arg_19_3)
	require("view.Sprite.TalkSprite")

	arg_19_1 = arg_19_1 or "Hello World"

	if self:getChildByName("pop_talk") then
		self:getChildByName("pop_talk"):updateString(arg_19_1, arg_19_3, arg_19_2)
	else
		local var_19_0 = TalkSprite:create(arg_19_1, 120, nil, arg_19_3, arg_19_2)

		var_19_0:setName("pop_talk")
		var_19_0:setPositionX(var_19_0:getPositionX() + self.size_num.width * 100 / 2)
		var_19_0:setPositionY(var_19_0:getPositionY() + self.size_num.height * 100 / 2)
		self:addChild(var_19_0, 9)
	end

	if self.parent.roomBound.x_max - self:getPositionX() <= 200 then
		self:getChildByName("pop_talk"):setAnchorPoint(cc.p(0.75, self:getChildByName("pop_talk"):getAnchorPoint().y))
		self:getChildByName("pop_talk"):setArrowPositionX(self:getChildByName("pop_talk"):getContentSize().width / 4 + 125)
	end

	if self.parent.roomBound.y_max - self:getPositionY() <= 200 then
		self:getChildByName("pop_talk"):setAnchorPoint(cc.p(self:getChildByName("pop_talk"):getAnchorPoint().x, 1))
		self:getChildByName("pop_talk"):setPositionY(25)
		self:getChildByName("pop_talk"):getChildByName("arrow"):setScaleY(-1)
		self:getChildByName("pop_talk"):setArrowPositionY(self:getChildByName("pop_talk"):getContentSize().height)
	end
end

function TileSprite:updateState(arg_20_1)
	if not arg_20_1 and self:isTileActive() then
		return
	end

	if self.tileInfo.finished_tile then
		self:reset({
			tileInfo = explore_manager.getCurData("tile", self.parent.curMapType)[self.tileInfo.finished_tile],
			size_num = cc.size(explore_manager:getTileSize(self.tileInfo.finished_tile))
		})
	elseif self.tileInfo.finished_image then
		self:releaseSelf()
		self:finishAddImg()
		explore_manager:update_img_config({
			imgid = self.tileInfo.finished_image,
			order = self.order,
			roomorder = self.parent.curRoomOrder,
			room_img_layer = self.parent.curRoomInfo.imglayer,
			room_size_num = cc.size(self.parent.room_width_num, self.parent.room_height_num)
		})
	else
		self:releaseSelf()
	end
end

function TileSprite:triggerEvent(arg_21_1)
	if self.tileInfo.action_name then
		var_0_11[self.tileInfo.action_name](self.tileInfo.action_param, self.parent)
	end

	self.finishCallback = arg_21_1

	self:checkTriggerPrecondition()
end

function TileSprite:checkTriggerPrecondition()
	local var_22_0

	if self.tileInfo.result1_type then
		local var_22_1 = not self.tileInfo.result2_type and 1 or self.parent.usedTile[self.idx].result and self.parent.usedTile[self.idx].result or 1

		var_22_0 = {
			type = self.tileInfo["result" .. var_22_1 .. "_type"],
			param = self.tileInfo["result" .. var_22_1 .. "_param"],
			des = self.tileInfo["result" .. var_22_1 .. "_des"],
			result_count = var_22_1
		}
	else
		var_22_0 = {}
	end

	if self.tileInfo.trigger_type > 0 then
		if self.tileInfo.trigger_type ~= 1 then
			if self.tileInfo.trigger_type == 4 then
				local var_22_2 = {
					trigger_type = self.tileInfo.trigger_type,
					needid = self.tileInfo.trigger_param1,
					neednum = self.tileInfo.trigger_param2
				}

				var_22_2.needItems = self:readNeedItems()
				var_22_2.ownnum = explore_manager:getItemNumber(self.tileInfo.trigger_param1)
				var_22_2.des = self.tileInfo.trigger_des

				function var_22_2.surecallback()
					self:runTileEvent(var_22_0)
				end

				function var_22_2.cancelcallback()
					self.parent.root.touchLock = false
				end

				if self:checkTriggerEvent() then
					self:runTriggerEvent(function()
						self.parent.root:addChild(self:needKeyPopLayer(var_22_2), 999)
					end)
				else
					self.parent.root:addChild(self:needKeyPopLayer(var_22_2), 999)
				end
			elseif self.tileInfo.trigger_type == 2 then
				LayerManager:pushInLayer("PopDoLayer", {
					labels = {
						titleImage = "title_explore_msg.png",
						title = L_EXPLORE_MSG.Title,
						des = self.tileInfo.trigger_des
					},
					system_figure = self.parent:randomRole(),
					surecallback = function()
						self:runTileEvent(var_22_0)
					end,
					cancelcallback = function()
						self.parent.root.touchLock = false
					end
				})
			elseif self.tileInfo.trigger_type == 3 then
				if explore_manager.curMapConfig.usedTile[self.curRoomOrder][index].usedcount == 0 then
					if self.tileInfo.trigger_param1 then
						global_basic_scene:addChild(self.tileInfo.trigger_param1_talk_type == 2 and TalkLayer:create(self.tileInfo.trigger_param1, nil, 1, "") or ExploreTalkLayer:create({
							classification = self.tileInfo.trigger_param1
						}))
					end

					self:runTileEvent(var_22_0)
				end

				if self.tileInfo.trigger_param2 then
					self.parent.root:addChild(self:npcPopLayer({
						tileInfo = self.tileInfo,
						surecallback = function()
							self:runTileEvent(var_22_0)
						end,
						cancelcallback = function()
							self.parent.root.touchLock = false
						end
					}), 999)
				end
			elseif self.tileInfo.trigger_type == 5 then
				if self.parent.tag.modelid == tostring(self.tileInfo.trigger_param1 or self.tileInfo.trigger_param_str1) then
					global_basic_scene:addChild(ExploreTalkLayer:create({
						classification = self.tileInfo.trigger_param2,
						finishCallback = function()
							self:runTileEvent(var_22_0)
						end
					}), ZORDER_TALKLAYER)
				else
					local var_22_5 = {}

					var_22_5.classification = self.tileInfo.trigger_param3

					function var_22_5.finishCallback()
						self.parent.root.touchLock = false
					end

					global_basic_scene:addChild(ExploreTalkLayer:create(var_22_5), ZORDER_TALKLAYER)
				end
			end
		end
	elseif self.tileInfo.trigger_des then
		if self.tileInfo.trigger_des_type == 2 then
			LayerManager:pushInLayer("PopDoLayer", {
				labels = {
					titleImage = "title_explore_msg.png",
					title = L_EXPLORE_MSG.Title,
					des = self.tileInfo.trigger_des
				},
				system_figure = self.parent:randomRole(),
				surecallback = function()
					self:runTileEvent(var_22_0)
				end,
				cancelcallback = function()
					self.parent.root.touchLock = false
				end
			})
		else
			local function var_22_6()
				self:runTileEvent(var_22_0)
			end

			if self.tileInfo.trigger_des_host == 1 then
				self:popTalkSp(self.tileInfo.trigger_des)
			else
				self.parent:popTalkSp(self.tileInfo.trigger_des)
			end

			var_22_6()
		end
	else
		self:runTileEvent(var_22_0)
	end
end

function TileSprite:trigger_controller()
	local tile_data = require("data.explore.tile_data")

	for iter_35_0, iter_35_1 in pairs(self.controller_idx) do
		if iter_35_1.roomorder == self.parent.curRoomOrder then
			if self.parent.tileobjects[iter_35_1.controller_idx] then
				self.parent.tileobjects[iter_35_1.controller_idx]:updateState(true)
			end
		else
			explore_manager:updateObjectState(iter_35_1.roomorder, iter_35_1.controller_idx)
		end
	end

	local var_35_1 = self.tileInfo.controller_des or L_EXPLORE_CONTROLLER_OPEN

	if var_35_1 ~= "kong" then
		self.parent:popTalkSp(var_35_1)
	end
end

function TileSprite:runTileEvent(arg_36_1, arg_36_2)
	local function var_36_0()
		local var_37_0
		local var_37_1
		local var_37_2

		if arg_36_1 then
			var_37_0 = arg_36_1.type
			var_37_1 = arg_36_1.param
			var_37_2 = arg_36_1.des
		end

		local var_37_5 = {
			room_order = self.parent.curRoomOrder,
			object_idx = self.idx,
			result_type = var_37_0,
			result_param = var_37_1,
			result_des = var_37_2,
			result_count = arg_36_1.result_count
		}

		explore_manager:trigger_event(var_37_5, function(arg_38_0)
			if arg_38_0.result > 0 then
				if not self:checkResultEvent() then
					if self.controller_idx then
						self:trigger_controller()
					end

					self:updateState()

					if self.tileInfo.puzzleids then
						self.parent:checkPuzzle(self.tileid)
					end

					if self.finishCallback then
						self.finishCallback({
							tileInfo = global_deepCopy(self.tileInfo),
							msg = arg_38_0,
							eventconfig = var_37_5
						})
					end

					if self.tileInfo.action_affter_name then
						var_0_11[self.tileInfo.action_affter_name](self.tileInfo.action_affter_param, self.parent)
					end
				else
					local var_38_0 = self.finishCallback
					local var_38_1 = {}

					var_38_1.tileInfo = global_deepCopy(self.tileInfo)
					var_38_1.msg = arg_38_0
					var_38_1.eventconfig = var_37_5

					self:runResultEvent(function()
						if self.controller_idx then
							self:trigger_controller()
						end

						self:updateState()

						if self.tileInfo.puzzleids then
							self.parent:checkPuzzle(self.tileid)
						end

						if var_38_0 then
							var_38_0(var_38_1)
						end

						if self.tileInfo.action_affter_name then
							var_0_11[self.tileInfo.action_affter_name](self.tileInfo.action_affter_param, self.parent)
						end
					end)
				end
			elseif self.finishCallback then
				self.finishCallback({
					tileInfo = self.tileInfo,
					msg = arg_38_0,
					eventconfig = var_37_5
				})
			end
		end)
	end

	if self.tileInfo.trigger_type > 0 then
		if self.tileInfo.trigger_type == 1 or self.tileInfo.trigger_type == 4 then
			var_36_0()
		elseif self:checkTriggerEvent() then
			self:runTriggerEvent(var_36_0)
		else
			var_36_0()
		end
	elseif self:checkTriggerEvent() then
		self:runTriggerEvent(var_36_0)
	else
		var_36_0()
	end
end

function TileSprite:checkTriggerEvent()
	return self.tileInfo.trigger_talk or self.tileInfo.trigger_theater
end

function TileSprite:runTriggerEvent(arg_41_1)
	if self.tileInfo.trigger_talk then
		global_basic_scene:addChild(self.tileInfo.trigger_talk_type == 2 and TalkLayer:create(self.tileInfo.trigger_talk, nil, 1, "", arg_41_1) or ExploreTalkLayer:create({
			classification = self.tileInfo.trigger_talk,
			finishCallback = arg_41_1
		}), ZORDER_TALKLAYER)
	elseif self.tileInfo.trigger_theater then
		local var_41_1 = explore_manager:createDirectory(self.tileInfo.trigger_theater)

		var_41_1:registerExitEvent(arg_41_1)
		var_41_1:startPlay()
	end
end

function TileSprite:checkResultEvent()
	return self.tileInfo.result_talk or self.tileInfo.result_theater
end

function TileSprite:runResultEvent(arg_43_1)
	if self.tileInfo.result_talk then
		global_basic_scene:addChild(self.tileInfo.result_talk_type == 2 and TalkLayer:create(self.tileInfo.result_talk, nil, 1, "", arg_43_1) or ExploreTalkLayer:create({
			classification = self.tileInfo.result_talk,
			finishCallback = arg_43_1
		}), ZORDER_TALKLAYER)
	elseif self.tileInfo.result_theater then
		local var_43_1 = explore_manager:createDirectory(self.tileInfo.result_theater)

		var_43_1:registerExitEvent(arg_43_1)
		var_43_1:startPlay()
	end
end

function TileSprite:showTileResult(arg_44_1, arg_44_2, arg_44_3)
	if self.tileInfo.class == 5 then
		if arg_44_3 then
			arg_44_3()
		end

		return
	end

	local var_44_0 = {
		labels = {
			titleImage = "title_explore_msg.png",
			title = L_EXPLORE_MSG.Title,
			des = arg_44_1
		},
		surecallback = arg_44_3,
		cancelcallback = arg_44_3
	}

	if arg_44_2 == EVENT_TYPE.DEAD then
		var_44_0.labels = {
			titleImage = "title_explore_msg.png",
			title = L_EXPLORE_MSG.Title,
			des = L_EXPLORE_MSG.Dead_Des
		}
	end

	LayerManager:pushInLayer("PopDoLayer", var_44_0)
end

function TileSprite:needKeyPopLayer(arg_45_1)
	local var_45_0 = ccui.Layout:create()

	var_45_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_45_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_45_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_45_0:setBackGroundColorOpacity(145)
	var_45_0:setCascadeOpacityEnabled(false)
	var_45_0:setPositionY(-GameDisplay.fix_y)
	var_45_0:setTouchEnabled(true)
	var_45_0:addTouchEventListener(function(arg_46_0, arg_46_1)
		if arg_46_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_45_1.cancelcallback then
			arg_45_1.cancelcallback()
		end

		var_45_0:runAction(cc.RemoveSelf:create())
	end)

	local var_45_1 = ccui.ImageView:create("public/panelbg/normal_bg_new.png", var_0_1)

	var_45_1:setScale9Enabled(true)
	var_45_1:setCapInsets(cc.rect(20, 20, 30, 30))
	var_45_1:setContentSize(cc.size(600, var_45_1:getContentSize().height))
	var_45_1:setPosition(320, GameDisplay.height / 2)
	var_45_0:addChild(var_45_1)

	local var_45_2 = ccui.ImageView:create(arg_45_1.trigger_type == 4 and "explore/title_use_items.png" or "explore/title_cost_item.png", var_0_1)

	var_45_2:setAnchorPoint(cc.p(0, 0))
	var_45_2:setPosition(0, 454)
	var_45_1:addChild(var_45_2)

	for iter_45_0, iter_45_1 in pairs(arg_45_1.needItems) do
		local var_45_3 = ItemSprite:createNewWithItemId(iter_45_1.needid, 1)

		var_45_3:getChildByName("number"):setString(iter_45_1.ownnum .. "/" .. iter_45_1.neednum)

		if iter_45_1.neednum > iter_45_1.ownnum then
			var_45_3:getChildByName("number"):setColor(cc.c3b(200, 0, 0))
		end

		var_45_3:setScale(0.9)
		var_45_3:setAnchorPoint(cc.p(0.5, 1))
		var_45_3:setPosition(var_45_1:getContentSize().width / 2 + (iter_45_0 - (#arg_45_1.needItems + 1) / 2) * 180, var_45_1:getContentSize().height - 40)
		var_45_1:addChild(var_45_3)
		var_45_3:setTouchEnabled(true)
		var_45_3:setSwallowTouches(true)
		var_45_3:addSpriteTouchEventListener(function(arg_47_0, arg_47_1)
			if arg_47_1 ~= ccui.TouchEventType.ended then
				return
			end

			PopLayer:Item({
				hideGainButton = true,
				itemid = iter_45_1.needid,
				itemnum = explore_manager:getItemNumber(iter_45_1.needid)
			})
		end)
	end

	local var_45_4 = ccui.Layout:create()

	var_45_4:setContentSize(cc.size(500, 150))
	var_45_4:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_45_4:setBackGroundColor(cc.c3b(0, 0, 0))
	var_45_4:setBackGroundColorOpacity(145)
	var_45_4:setCascadeOpacityEnabled(false)
	var_45_4:setAnchorPoint(cc.p(0.5, 0))
	var_45_4:setPosition(var_45_1:getContentSize().width / 2, 10)
	var_45_1:addChild(var_45_4)

	local var_45_5 = cc.Label:createWithTTF(arg_45_1.des or "", FONT_NAME, 26)

	var_45_5:setMaxLineWidth(490)
	var_45_5:setAnchorPoint(cc.p(0.5, 0.5))
	var_45_5:setPosition(var_45_4:getContentSize().width / 2, var_45_4:getContentSize().height / 2)
	var_45_4:addChild(var_45_5)

	local var_45_6 = ccui.Button:create("public/button/public_button_big_y.png", nil, "public/button/public_button_big_y_on.png", var_0_1)

	var_45_6:setScale9Enabled(true)

	local var_45_7 = var_45_6:getContentSize()

	var_45_6:setCapInsets(cc.rect(var_45_7.width / 2 - 10, var_45_7.height / 2 - 10, 10, 10))
	var_45_6:setContentSize(cc.size(450, 80))
	var_45_6:setTitleText(L_BUTTON_TEXT.Comfirm)
	var_45_6:setTitleColor(cc.c3b(0, 0, 0))
	var_45_6:setTitleFontName(FONT_BUTTON)
	var_45_6:setTitleFontSize(30)
	var_45_6:setPosition(var_45_1:getContentSize().width / 2, -100)
	var_45_1:addChild(var_45_6)
	var_45_6:addTouchEventListener(function(arg_48_0, arg_48_1)
		if arg_48_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_45_1.surecallback then
			arg_45_1.surecallback()
		end

		var_45_0:runAction(cc.RemoveSelf:create())
	end)

	return var_45_0
end

function TileSprite:finishAddImg()
	local var_49_0 = cc.Sprite:createWithSpriteFrameName("tiles_" .. self.fullImage .. "/" .. self.tileInfo.finished_image .. ".png")

	var_49_0:setPosition(self.pos)
	var_49_0:setAnchorPoint(cc.p(0, 0))

	if explore_img_data[self.tileInfo.finished_image].is_big_icon then
		self.parent.iconLayout:addChild(var_49_0, self.zOrder)
	else
		self.parent.batchNodeLayout:addChild(var_49_0, self.zOrder)
	end
end

local var_0_12 = setmetatable({}, {
	__index = function(arg_50_0, arg_50_1)
		return TileSprite[arg_50_1]
	end
})

function TileSprite:execute(arg_51_1, arg_51_2, ...)
	var_0_12[arg_51_1](self, arg_51_2, ...)
end

function TileSprite:moveBy_e(arg_52_1, arg_52_2, arg_52_3, arg_52_4)
	local var_52_0 = (math.abs(arg_52_3.x * 100) + math.abs(arg_52_3.y * 100)) / arg_52_2
	local var_52_1 = arg_52_3.x
	local var_52_2 = arg_52_3.y
	local var_52_3 = 0.016666666666666666
	local var_52_4 = 665

	arg_52_4 = arg_52_3.x * 100 == 0 and "y" or arg_52_3.y * 100 == 0 and "x" or arg_52_4 or "y"

	local var_52_5 = cc.RepeatForever:create(cc.Sequence:create(cc.DelayTime:create(0), cc.CallFunc:create(function()
		local var_53_0 = self:getPositionX()
		local var_53_1 = self:getPositionY()
		local var_53_2 = self.parent:transform_index_pos_coordinate(cc.p(var_53_0, var_53_1), "coordinate")
		local var_53_4 = var_53_2.order_y

		local function var_53_5()
			if var_52_1 == var_53_0 then
				return
			end

			var_53_0 = var_53_0 + (var_52_1 - var_53_0) / math.abs(var_52_1 - var_53_0) * (math.abs(var_52_1 - var_53_0) < var_52_3 * var_52_0 and math.abs(var_52_1 - var_53_0) or var_52_3 * var_52_0)

			return true
		end

		local function var_53_6()
			if var_52_2 == var_53_1 then
				return
			end

			var_53_1 = var_53_1 + (var_52_2 - var_53_1) / math.abs(var_52_2 - var_53_1) * (math.abs(var_52_2 - var_53_1) < var_52_3 * var_52_0 and math.abs(var_52_2 - var_53_1) or var_52_3 * var_52_0)

			return true
		end

		if var_53_0 == var_52_1 and var_53_1 == var_52_2 then
			self.pos = cc.p(var_53_0, var_53_1)
			self.zOrder = (self.parent.room_height_num - var_53_4 + 1) * 2
			self.order = var_53_2.index
			self.parent.usedTile[self.idx].order = var_53_2.index

			if arg_52_1 then
				arg_52_1()
			end

			self:stopActionByTag(var_52_0)
		end

		if arg_52_4 == "x" then
			if not var_53_5() then
				var_53_6()
			end
		elseif arg_52_4 == "y" and not var_53_6() then
			var_53_5()
		end

		self:setPosition(var_53_0, var_53_1)
		self:setLocalZOrder((self.parent.room_height_num - var_53_4 + 1) * 2)
	end)))

	var_52_5:setTag(var_52_4)
	self:runAction(var_52_5)
end

function TileSprite:moveTo_e(arg_56_1, arg_56_2, arg_56_3, arg_56_4)
	local var_56_0 = (arg_56_3.x - self.pos.x + (arg_56_3.y - self.pos.y)) / arg_56_2
	local var_56_1 = arg_56_3.x
	local var_56_2 = arg_56_3.y
	local var_56_3 = 0.016666666666666666
	local var_56_4 = 666

	arg_56_4 = arg_56_3.x - self.pos.x == 0 and "y" or arg_56_3.y - self.pos.y == 0 and "x" or arg_56_4 or "y"

	local var_56_5 = cc.RepeatForever:create(cc.Sequence:create(cc.DelayTime:create(0), cc.CallFunc:create(function()
		local var_57_0 = self:getPositionX()
		local var_57_1 = self:getPositionY()
		local var_57_2 = self.parent:transform_index_pos_coordinate(cc.p(var_57_0, var_57_1), "coordinate")
		local var_57_4 = var_57_2.order_y

		local function var_57_5()
			if var_56_1 == var_57_0 then
				return
			end

			var_57_0 = var_57_0 + (var_56_1 - var_57_0) / math.abs(var_56_1 - var_57_0) * (math.abs(var_56_1 - var_57_0) < var_56_3 * var_56_0 and math.abs(var_56_1 - var_57_0) or var_56_3 * var_56_0)

			return true
		end

		local function var_57_6()
			if var_56_2 == var_57_1 then
				return
			end

			var_57_1 = var_57_1 + (var_56_2 - var_57_1) / math.abs(var_56_2 - var_57_1) * (math.abs(var_56_2 - var_57_1) < var_56_3 * var_56_0 and math.abs(var_56_2 - var_57_1) or 0.016666666666666666 * var_56_0)

			return true
		end

		if var_57_0 == var_56_1 and var_57_1 == var_56_2 then
			self.pos = cc.p(var_57_0, var_57_1)
			self.zOrder = (self.parent.room_height_num - var_57_4 + 1) * 2
			self.order = var_57_2.index
			self.parent.usedTile[self.idx].order = var_57_2.index

			if arg_56_1 then
				arg_56_1()
			end

			self:stopActionByTag(var_56_0)
		end

		if arg_56_4 == "x" then
			if not var_57_5() then
				var_57_6()
			end
		elseif arg_56_4 == "y" and not var_57_6() then
			var_57_5()
		end

		self:setPosition(var_57_0, var_57_1)
		self:setLocalZOrder((self.parent.room_height_num - var_57_4 + 1) * 2)
	end)))

	var_56_5:setTag(var_56_4)
	self:runAction(var_56_5)
	self:playAni(nil, "run", true)
end

function TileSprite:moveTo(arg_60_1, arg_60_2, arg_60_3)
	self:runAction(cc.Sequence:create(cc.MoveTo:create(arg_60_2, arg_60_3), cc.CallFunc:create(function()
		if arg_60_1 then
			arg_60_1()
		end
	end)))
end

function TileSprite:moveBy(arg_62_1, arg_62_2, arg_62_3)
	self:runAction(cc.Sequence:create(cc.MoveBy:create(arg_62_2, (cc.p(self.dir * arg_62_3.x, arg_62_3.y))), cc.CallFunc:create(function()
		if arg_62_1 then
			arg_62_1()
		end
	end)))
end

function TileSprite:jumpTo(arg_64_1, arg_64_2, arg_64_3, arg_64_4, arg_64_5)
	self:runAction(cc.Sequence:create(cc.JumpTo:create(arg_64_2, arg_64_3, arg_64_4, arg_64_5), cc.CallFunc:create(function()
		if arg_64_1 then
			arg_64_1()
		end
	end)))
end

function TileSprite:jumpBy(arg_66_1, arg_66_2, arg_66_3, arg_66_4, arg_66_5)
	self:runAction(cc.Sequence:create(cc.JumpBy:create(arg_66_2, cc.p(self.dir * arg_66_3.x, arg_66_3.y), arg_66_4, arg_66_5), cc.CallFunc:create(function()
		if arg_66_1 then
			arg_66_1()
		end
	end)))
end

function TileSprite:playAni(arg_68_1, arg_68_2, arg_68_3)
	self.icon:playAni(arg_68_1, arg_68_2, arg_68_3)
end

function TileSprite:delayTime(arg_69_1, arg_69_2)
	self:runAction(cc.Sequence:create(cc.DelayTime:create(arg_69_2), cc.CallFunc:create(function()
		if arg_69_1 then
			arg_69_1()
		end
	end)))
end

function TileSprite:talk(arg_71_1, arg_71_2, arg_71_3)
	self.icon:talk(arg_71_1, arg_71_2, arg_71_3)
end

function TileSprite:hide(arg_72_1)
	self:runAction(cc.Sequence:create(cc.Hide:create(), cc.CallFunc:create(function()
		if arg_72_1 then
			arg_72_1()
		end
	end)))
end

function TileSprite:show(arg_74_1)
	self:runAction(cc.Sequence:create(cc.Show:create(), cc.CallFunc:create(function()
		if arg_74_1 then
			arg_74_1()
		end
	end)))
end

function TileSprite:loadAudio(arg_76_1, arg_76_2)
	Rapid2D_CAudio.newBuffer(arg_76_1, function(arg_77_0)
		if arg_77_0 then
			self._buffers[arg_76_1] = arg_77_0
		end

		if arg_76_2 then
			arg_76_2()
		end
	end)
end

function TileSprite:playeffectMusic(arg_78_1, arg_78_2, arg_78_3)
	if audio_manager.effect_volume == 0 then
		return
	end

	local var_78_0 = arg_78_2 ~= nil and arg_78_2 or false
	local var_78_1 = (arg_78_3 or 1) * audio_manager.audioVolume[audio_manager.effect_volume] * audio_manager._effectscale

	if (arg_78_3 or 1) * audio_manager.audioVolume[audio_manager.effect_volume] * audio_manager._effectscale > 1 then
		var_78_1 = 1
	end

	if var_78_1 < 0 then
		var_78_1 = 0
	end

	if not arg_78_1:find("^sound") then
		arg_78_1 = "sound/" .. arg_78_1
	end

	arg_78_1 = arg_78_1 .. ".ogg"

	self:loadAudio(arg_78_1, function()
		if not self._buffers[arg_78_1] then
			print(arg_78_1 .. " have not loaded!!!")

			return
		end

		local var_79_0 = audio_module.new(var_78_1)

		if not var_79_0 then
			return
		end

		var_79_0:setVolume(var_78_1)
		var_79_0:play2d(self._buffers[arg_78_1], var_78_0)
	end)
end

function TileSprite:readNeedItems(arg_80_1)
	local var_80_0 = {}
	local var_80_1 = arg_80_1 or 1

	while self.tileInfo["trigger_param" .. var_80_1] do
		table.insert(var_80_0, {
			needid = tonumber(self.tileInfo["trigger_param" .. var_80_1]),
			neednum = tonumber(self.tileInfo["trigger_param" .. var_80_1 + 1]),
			ownnum = explore_manager:getItemNumber(tonumber(self.tileInfo["trigger_param" .. var_80_1]))
		})

		var_80_1 = var_80_1 + 2
	end

	return var_80_0
end

return TileSprite
