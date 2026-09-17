flyChessPlayer = class("flyChessPlayer", function()
	return cc.Node:create()
end)

local activity_manager = require("controller.activity_manager")
local var_0_2 = 0.2

function flyChessPlayer.create(arg_2_0, arg_2_1)
	local var_2_0 = flyChessPlayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function flyChessPlayer:init(arg_3_1)
	self.activityId = arg_3_1.activityId
	self.ismoving = false

	local var_3_0 = activity_manager:getFlychessConf(self.activityId).playerModelId or 21921
	local var_3_1 = L2Skeleton:create("spine/test/" .. var_3_0 .. ".json", "spine/test/" .. var_3_0 .. ".atlas")

	var_3_1:refreshSkeleton()
	var_3_1:play("idle", true)
	var_3_1:setVisible(true)
	var_3_1:registerListener(SP_ANIMATION_COMPLETE, function(arg_4_0)
		return
	end)
	self:addChild(var_3_1)

	self._playerSpine = var_3_1

	self:setScale(0.3)

	function var_3_1._updateDir(arg_5_0, arg_5_1)
		if arg_5_0 < arg_5_1 then
			var_3_1:setScaleX(1)
		elseif arg_5_1 < arg_5_0 then
			var_3_1:setScaleX(-1)
		end
	end
end

function flyChessPlayer.playAni(arg_6_0, arg_6_1, arg_6_2)
	return
end

function flyChessPlayer.attachMap(arg_7_0, arg_7_1)
	arg_7_0.map = arg_7_1
end

function flyChessPlayer:setMapPos(arg_8_1)
	self:setPosition(self.map.map_grids[arg_8_1]:getPosition())

	self.pos = arg_8_1
end

function flyChessPlayer:forward(arg_9_1)
	if arg_9_1.pos == self.pos then
		return
	end

	self.path_index = 1
	self.path = {}
	self.curpos = self.pos

	self._playerSpine:play("run", true)

	self.ismoving = true

	local function var_9_2()
		self._playerSpine._updateDir(self:getPositionX(), self.map.map_grids[self.curpos == self.map.grids_num and 1 or self.curpos + 1]:getPositionX())

		if var_10_0 ~= arg_9_1.pos then
			self:runAction(cc.Sequence:create(cc.MoveTo:create(var_0_2, cc.p(self.map.map_grids[var_10_0]:getPositionX(), self.map.map_grids[var_10_0]:getPositionY())), cc.CallFunc:create(function()
				self.curpos = var_10_0

				var_9_2()
			end)))
		else
			self:runAction(cc.Sequence:create(cc.MoveTo:create(var_0_2, cc.p(self.map.map_grids[var_10_0]:getPositionX(), self.map.map_grids[var_10_0]:getPositionY())), cc.CallFunc:create(function()
				self._playerSpine:play("idle", true)
				self._playerSpine._updateDir(self:getPositionX(), self.map.map_grids[var_10_0]:getPositionX())

				self.pos = arg_9_1.pos
				self.ismoving = false

				if arg_9_1.cb then
					arg_9_1:cb()
				end

				if arg_9_1.popmsg then
					LayerManager:pushInLayer("PopPurchaseResultLayer", arg_9_1.popmsg)
				end

				activity_manager:fireEvent(activity_manager.activityEventId.ACTIVITY_FLYCHESS_DATA_UPDATE, arg_9_1)
			end)))
		end
	end

	;(nil)()
end

function flyChessPlayer:update(arg_13_1)
	if not self.ismoving then
		return
	end

	self:updateForward(arg_13_1)
end

function flyChessPlayer:updateForward(arg_14_1)
	if self.path_index > #self.path then
		self.ismoving = false
		self.elapse = 0

		return
	end

	self.elapse = self.elapse + arg_14_1

	self:setPositionX(self:getPositionX() + self.path[index])

	if self.elapse > var_0_2 then
		-- block empty
	end

	self.path_index = self.path_index + 1
end
