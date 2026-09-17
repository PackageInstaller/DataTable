local TileSprite = require("view.Sprite.explore.TileSprite")
local NpcfollowTile = class("NpcfollowTile", function(arg_1_0)
	return TileSprite:createNode(arg_1_0)
end)
local explore_manager = require("controller.explore_manager")
local L2Actor = require("view.Sprite.L2Actor")
local item_manager = require("controller.item_manager")
local model_data = require("data.model_data")
local var_0_6 = config._DEBUG and 0 or 1
local var_0_7 = 0.28

function NpcfollowTile:create(arg_2_1)
	local var_2_0 = NpcfollowTile.new(arg_2_1)

	if arg_2_1.is_finished then
		var_2_0:initfinished(arg_2_1)
	else
		var_2_0:init(arg_2_1)
		var_2_0:initother()
	end

	return var_2_0
end

function NpcfollowTile:initfinished(arg_3_1)
	self.initConfig = arg_3_1
	self.tileInfo = arg_3_1.tileInfo
	self.parent = arg_3_1.parent
	self.tileid = arg_3_1.tileInfo.id
	self.idx = arg_3_1.idx
	self.order = arg_3_1.order
	self.pos = arg_3_1.pos
	self.zOrder = arg_3_1.zOrder
	self.fullImage = arg_3_1.fullImage
	self.size_num = arg_3_1.size_num

	self:setName(self.order .. "object")

	self._buffers = {}

	if self.tileInfo.icon then
		self.icon = cc.Sprite:createWithSpriteFrameName("tiles_" .. self.fullImage .. "/" .. self.tileInfo.icon .. ".png")
		self.icon.path = self.tileInfo.icon

		self.icon:setAnchorPoint(cc.p(0, 0))
		self:addChild(self.icon)

		self.icon.size = self.icon:getContentSize()
		self.icon.type = "img"

		if self.tileInfo.is_big_icon and self.tileInfo.is_shadow then
			self.icon:setPositionY(TILE_SIZE / 2)

			self.shadow = ccui.ImageView:create("explore/shadow.png", var_0_6)

			self.shadow:setScale(0.9)
			self.shadow:setPosition(TILE_SIZE / 2, TILE_SIZE / 2 - 10)
			self:addChild(self.shadow)
		end
	elseif self.tileInfo.model then
		local var_3_0 = tostring(self.tileInfo.model)
		local var_3_1 = model_data[var_3_0].spine_model
		local var_3_2 = model_data[var_3_0].clothes_model
		local var_3_3 = (self.tileInfo.model_scale or 1) * var_0_7 * (model_data[var_3_0].modelscale > 1.3 and 1.3 or model_data[var_3_0].modelscale)
		local var_3_4 = cc.size(model_data[var_3_0].modelweight, model_data[var_3_0].modelheight)

		self.icon = L2Actor:create(ROLE_SPINE_PATH .. var_3_1 .. ".json", ROLE_SPINE_PATH .. var_3_1 .. ".atlas", (var_3_2 or nil) and (CLOTHES_SPINE_PATH .. var_3_2 .. ".atlas" or nil))

		self.icon:setScale(var_3_3 * (self.tileInfo.isFlippedX == 1 and -1 or 1), var_3_3)
		self.icon:setContentSize(var_3_4)
		self.icon:playAni(nil, self.tileInfo.act or "idle", true)
		self.icon:setPosition(TILE_SIZE / 2, TILE_SIZE / 2)

		self.icon.type = "spine"

		self:addChild(self.icon)
	elseif self.tileInfo.ani then
		local var_3_5 = self.tileInfo.ani or "black_role"

		self.icon = L2Skeleton:create("spine/explore/" .. var_3_5 .. ".json", "spine/explore/" .. var_3_5 .. ".atlas", nil, true)

		self.icon:refreshSkeleton()
		self.icon:setSpeedScale(0.6)

		self.icon.type = "ani"

		local var_3_6 = self.tileInfo.ani_scale or 1

		self.icon:setScale(var_3_6, var_3_6)
		self.icon:play(self.tileInfo.act or "animation")
		self:addChild(self.icon, 3)
	end

	self.icon:setName("icon")

	self.iconPosTable = {
		self.icon:getPositionX(),
		(self.icon:getPositionY())
	}
end

function NpcfollowTile:initother()
	self:updateNpcPosInfo()
end

function NpcfollowTile:updateState(arg_5_1)
	if not arg_5_1 and self:isTileActive() then
		return
	end

	explore_manager:removeObject(self.parent.curRoomOrder, self.idx)
end

function NpcfollowTile:updateNpcPosInfo(arg_6_1, arg_6_2)
	if arg_6_2 then
		self.parent = arg_6_2
	end

	if arg_6_1 then
		self.order = arg_6_1
	end

	self.curPosIndexNpc = self.order

	local var_6_0 = math.floor((self.curPosIndexNpc - 1) / self.parent.room_width_num) + 1

	self.curPosNpc = cc.p((self.curPosIndexNpc - 1) % self.parent.room_width_num + 1, var_6_0)
	self.curCoordinate = cc.p(((self.curPosIndexNpc - 1) % self.parent.room_width_num + 1 - (self.parent.room_width_num + 1) / 2) * TILE_SIZE + self.parent:getContentSize().width / 2, (var_6_0 - (self.parent.room_height_num + 1) / 2) * TILE_SIZE + self.parent:getContentSize().height / 2)
end

function NpcfollowTile:npcMove(arg_7_1)
	if self.icon:getChildByName("icon_title") then
		self.icon:getChildByName("icon_title"):removeFromParent()
	end

	self.curPosIndexNpc = self.order

	local var_7_0 = 480

	self:stopActionByTag(480)

	local var_7_1 = self.icon

	local function var_7_4()
		if self.index == 1 then
			if self.parent.tag.curPosIndex ~= self.curPosIndexNpc then
				return true
			else
				return false
			end
		elseif self.parent.root.followQueue[self.index - 1].curPosIndexNpc ~= self.curPosIndexNpc or #arg_7_1 <= 2 then
			return true
		else
			return false
		end
	end

	local function var_7_5(arg_9_0, arg_9_1)
		if math.abs(arg_9_0 - arg_9_1) == 1 then
			return "x"
		elseif math.abs(arg_9_0 - arg_9_1) == self.parent.room_width_num then
			return "y"
		else
			print(arg_9_0, arg_9_1, arg_9_0 - arg_9_1)
		end
	end

	local function var_7_6()
		local var_10_0, var_10_1 = self.parent:checkBoundIsLock(direction)

		if var_10_0 then
			self:playAni(nil, "idle", true)

			return
		end

		local var_10_2 = self.curCoordinate.x
		local var_10_3 = self.curCoordinate.y
		local var_10_4
		local var_10_5

		if direction == UP then
			var_10_5 = self.curCoordinate.y
			var_10_4 = var_10_2
		elseif direction == DOWN then
			var_10_5 = self.curCoordinate.y
			var_10_4 = var_10_2
		elseif direction == LEFT then
			var_10_5 = self.curCoordinate.y
			var_10_4 = var_10_2
		elseif direction == RIGHT then
			var_10_5 = self.curCoordinate.y
			var_10_4 = var_10_2
		end

		local var_10_6 = cc.RepeatForever:create(cc.Sequence:create(cc.DelayTime:create(0), cc.CallFunc:create(function()
			var_10_2, var_10_3 = self:getPositionX(), self:getPositionY()

			if direction == UP or direction == DOWN then
				if var_10_3 ~= var_10_5 then
					var_10_3 = var_10_3 + (var_10_5 - var_10_3) / math.abs(var_10_5 - var_10_3) * (math.abs(var_10_5 - var_10_3) < 0.016666666666666666 * var_7_0 and math.abs(var_10_5 - var_10_3) or 0.016666666666666666 * var_7_0)
				else
					self.icon:stopActionByTag(var_7_0)

					return
				end
			elseif direction == LEFT or direction == RIGHT then
				if var_10_2 ~= var_10_4 then
					local var_11_1 = math.abs(var_10_4 - var_10_2) < 0.016666666666666666 * var_7_0 and math.abs(var_10_4 - var_10_2) or 0.016666666666666666 * var_7_0
					local var_11_2 = (var_10_4 - var_10_2) / math.abs(var_10_4 - var_10_2)

					var_10_2 = var_10_2 + var_11_2 * var_11_1

					if var_11_2 ~= self.parent.tag.dir then
						self.icon:setScale(var_11_2 * math.abs(self.icon.scale), math.abs(self.icon.scale))
					end
				else
					self.icon:stopActionByTag(var_7_0)

					return
				end
			end

			self:setPosition(var_10_2, var_10_3)
		end)))

		var_10_6:setTag(var_7_0)
		self:runAction(var_10_6)
		self:playAni(nil, "idle", true)
	end

	if arg_7_1 and next(arg_7_1) == nil and direction then
		var_7_6()

		return
	end

	local var_7_7 = var_7_5(self.curPosIndexNpc, arg_7_1[1])
	local var_7_8 = 1
	local var_7_9 = cc.RepeatForever:create(cc.Sequence:create(cc.DelayTime:create(0), cc.CallFunc:create(function()
		local var_12_0 = arg_7_1[var_7_8]
		local var_12_1 = self.parent:transform_index_pos_coordinate(arg_7_1[var_7_8], "index")
		local var_12_3 = var_12_1.order_y
		local var_12_4 = var_12_1.x
		local var_12_5 = var_12_1.y
		local var_12_6 = self:getPositionX()
		local var_12_7 = self:getPositionY()

		if cc.rectContainsPoint(cc.rect(var_12_1.x - 50, var_12_1.y - 50, 100, 100), cc.p(var_12_6, var_12_7)) and var_12_0 ~= self.curPosIndexNpc then
			self.order = var_12_0

			self:updateNpcPosInfo()
		end

		if var_7_7 and var_7_7 == "x" or not var_7_7 then
			if var_7_8 == #arg_7_1 then
				if var_12_6 == var_12_4 and var_12_7 == var_12_5 then
					if callback then
						callback()
					end

					self:stopActionByTag(var_7_0)

					if direction then
						var_7_6()
					else
						self:playAni(nil, "idle", true)
					end

					return
				elseif var_12_6 ~= var_12_4 then
					local var_12_8 = math.abs(var_12_4 - var_12_6) < 0.016666666666666666 * var_7_0 and math.abs(var_12_4 - var_12_6) or 0.016666666666666666 * var_7_0
					local var_12_9 = (var_12_4 - var_12_6) / math.abs(var_12_4 - var_12_6)

					var_12_6 = var_12_6 + var_12_9 * var_12_8

					if var_12_9 ~= self.icon.dir then
						var_7_1:setScale(var_12_9 * math.abs(var_7_1.scale), math.abs(var_7_1.scale))
					end
				elseif var_12_7 ~= var_12_5 then
					var_12_7 = var_12_7 + (var_12_5 - var_12_7) / math.abs(var_12_5 - var_12_7) * (math.abs(var_12_5 - var_12_7) < 0.016666666666666666 * var_7_0 and math.abs(var_12_5 - var_12_7) or 0.016666666666666666 * var_7_0)
				end
			elseif var_12_6 == var_12_4 and self.curPosIndexNpc == var_12_0 and var_7_4() then
				var_7_8 = var_7_8 + 1
				var_7_7 = var_7_5(self.curPosIndexNpc, arg_7_1[var_7_8])
			elseif var_12_6 ~= var_12_4 then
				local var_12_11 = math.abs(var_12_4 - var_12_6) < 0.016666666666666666 * var_7_0 and math.abs(var_12_4 - var_12_6) or 0.016666666666666666 * var_7_0
				local var_12_12 = (var_12_4 - var_12_6) / math.abs(var_12_4 - var_12_6)

				var_12_6 = var_12_6 + var_12_12 * var_12_11

				if var_12_12 ~= self.icon.dir then
					var_7_1:setScale(var_12_12 * math.abs(var_7_1.scale), math.abs(var_7_1.scale))
				end
			elseif var_12_7 ~= var_12_5 then
				var_12_7 = var_12_7 + (var_12_5 - var_12_7) / math.abs(var_12_5 - var_12_7) * (math.abs(var_12_5 - var_12_7) < 0.016666666666666666 * var_7_0 and math.abs(var_12_5 - var_12_7) or 0.016666666666666666 * var_7_0)
			end
		elseif var_7_7 and var_7_7 == "y" then
			if var_7_8 == #arg_7_1 then
				if var_12_6 == var_12_4 and var_12_7 == var_12_5 then
					if callback then
						callback()
					end

					self:stopActionByTag(var_7_0)

					if direction then
						var_7_6()
					else
						self:playAni(nil, "idle", true)
					end

					return
				elseif var_12_7 ~= var_12_5 then
					var_12_7 = var_12_7 + (var_12_5 - var_12_7) / math.abs(var_12_5 - var_12_7) * (math.abs(var_12_5 - var_12_7) < 0.016666666666666666 * var_7_0 and math.abs(var_12_5 - var_12_7) or 0.016666666666666666 * var_7_0)
				elseif var_12_6 ~= var_12_4 then
					local var_12_15 = math.abs(var_12_4 - var_12_6) < 0.016666666666666666 * var_7_0 and math.abs(var_12_4 - var_12_6) or 0.016666666666666666 * var_7_0
					local var_12_16 = (var_12_4 - var_12_6) / math.abs(var_12_4 - var_12_6)

					var_12_6 = var_12_6 + var_12_16 * var_12_15

					if var_12_16 ~= self.icon.dir then
						var_7_1:setScale(var_12_16 * math.abs(var_7_1.scale), math.abs(var_7_1.scale))
					end
				end
			elseif var_12_7 == var_12_5 and self.curPosIndexNpc == var_12_0 and var_7_4() then
				var_7_8 = var_7_8 + 1
				var_7_7 = var_7_5(self.curPosIndexNpc, arg_7_1[var_7_8])
			elseif var_12_7 ~= var_12_5 then
				var_12_7 = var_12_7 + (var_12_5 - var_12_7) / math.abs(var_12_5 - var_12_7) * (math.abs(var_12_5 - var_12_7) < 0.016666666666666666 * var_7_0 and math.abs(var_12_5 - var_12_7) or 0.016666666666666666 * var_7_0)
			elseif var_12_6 ~= var_12_4 then
				local var_12_18 = math.abs(var_12_4 - var_12_6) < 0.016666666666666666 * var_7_0 and math.abs(var_12_4 - var_12_6) or 0.016666666666666666 * var_7_0
				local var_12_19 = (var_12_4 - var_12_6) / math.abs(var_12_4 - var_12_6)

				var_12_6 = var_12_6 + var_12_19 * var_12_18

				if var_12_19 ~= self.icon.dir then
					var_7_1:setScale(var_12_19 * math.abs(var_7_1.scale), math.abs(var_7_1.scale))
				end
			end
		end

		self:setPosition(var_12_6, var_12_7)
		self:setLocalZOrder((self.parent.room_height_num - var_12_3 + 1) * 2)
	end)))

	var_7_9:setTag(var_7_0)
	self:runAction(var_7_9)
	self:playAni(nil, "run", true)
end

return NpcfollowTile
