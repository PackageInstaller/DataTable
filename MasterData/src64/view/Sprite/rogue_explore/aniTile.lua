local TileSprite = require("view.Sprite.explore.TileSprite")
local aniTile = class("aniTile", function(arg_1_0)
	return TileSprite:createNode(arg_1_0)
end)
local explore_manager = require("controller.explore_manager")
local L2Actor = require("view.Sprite.L2Actor")
local item_manager = require("controller.item_manager")
local explore_img_data = require("data.explore.explore_img_data")
local model_data = require("data.model_data")
local tile_data = require("data.explore.tile_data")
local servant_data = require("data.servant_data")
local npc_fightconfig_data = require("data.npc_fightconfig_data")
local item_data = require("data.item_data")
local audio_manager = require("controller.audio_manager")
local audio_module = require("controller.audio_module")
local var_0_15 = {
	shake = function(arg_2_0, arg_2_1, arg_2_2)
		local var_2_0 = {}

		for iter_2_0 = 1, 3 do
			var_2_0[iter_2_0] = cc.Sequence:create(cc.MoveBy:create(0.05 / (iter_2_0 * iter_2_0), cc.p(arg_2_0 * 10 / iter_2_0, arg_2_1 * 10 / iter_2_0)), cc.MoveBy:create(0.05 / (iter_2_0 * iter_2_0), cc.p(-(arg_2_0 * 10 / iter_2_0), -(arg_2_1 * 10 / iter_2_0))), cc.MoveBy:create(0.05 / (iter_2_0 * iter_2_0), cc.p(-(arg_2_0 * 10 / iter_2_0), -(arg_2_1 * 10 / iter_2_0))), cc.MoveBy:create(0.05 / (iter_2_0 * iter_2_0), cc.p(arg_2_0 * 10 / iter_2_0, arg_2_1 * 10 / iter_2_0)))
		end

		arg_2_2:runAction(cc.Sequence:create(var_2_0[1], var_2_0[2], var_2_0[3]))
	end
}

function aniTile:create(arg_3_1)
	local var_3_0 = aniTile.new(arg_3_1)

	var_3_0:init(arg_3_1)

	return var_3_0
end

function aniTile:initother()
	self._buffers = {}
	explore_manager.curMapConfig.finishedAni[self.parent.curRoomOrder] = explore_manager.curMapConfig.finishedAni[self.parent.curRoomOrder] or {}
	explore_manager.curMapConfig.finishedAni[self.parent.curRoomOrder][self.idx] = explore_manager.curMapConfig.finishedAni[self.parent.curRoomOrder][self.idx] or 0
end

function aniTile:createIcon()
	self:initother()
	self:createLight()

	if not self:isTileShow() then
		return false
	end

	if self.tileInfo.ani then
		local var_5_0 = explore_manager.curMapConfig.finishedAni[self.parent.curRoomOrder][self.idx] == 0 and (self.tileInfo.ani or "black_role") or self.tileInfo.ani1 or "black_role"

		self.icon = L2Skeleton:create("spine/explore/" .. var_5_0 .. ".json", "spine/explore/" .. var_5_0 .. ".atlas")

		self.icon:refreshSkeleton()
		self.icon:setSpeedScale(0.6)

		self.icon.type = "ani"

		local var_5_1 = self.tileInfo.ani_scale or 1

		self.icon:setScale(var_5_1, var_5_1)

		self.act = self.tileInfo.act or "animation"

		self:addChild(self.icon, 3)
	end

	self.icon:setName("icon")
	self:createAimTitle()
	self:updateAni()
end

function aniTile:updateAni()
	if explore_manager.curMapConfig.finishedAni[self.parent.curRoomOrder][self.idx] == 0 then
		if self.tileInfo.action_name then
			var_0_15[self.tileInfo.action_name](2, 5, self.parent)
		end

		if self.tileInfo.action_music then
			self:playeffectMusic("sound/" .. self.tileInfo.action_music)
		end

		self.icon:play(self.act, false)
		self.icon:registerListener(SP_ANIMATION_COMPLETE, function(arg_7_0)
			local var_7_0 = self.tileInfo.ani1 or "black_role"

			self.icon = L2Skeleton:create("spine/explore/" .. var_7_0 .. ".json", "spine/explore/" .. var_7_0 .. ".atlas")

			self.icon:refreshSkeleton()
			self.icon:setSpeedScale(0.6)

			self.icon.type = "ani"

			local var_7_1 = self.tileInfo.ani_scale or 1

			self.icon:setScale(var_7_1, var_7_1)
			self.icon:play(self.act, true)

			explore_manager.curMapConfig.finishedAni[self.parent.curRoomOrder][self.idx] = explore_manager.curMapConfig.finishedAni[self.parent.curRoomOrder][self.idx] + 1
		end)
	elseif explore_manager.curMapConfig.finishedAni[self.parent.curRoomOrder][self.idx] == 1 then
		self.icon:play(self.act, true)
	end
end

function aniTile:loadAudio(arg_8_1, arg_8_2)
	Rapid2D_CAudio.newBuffer(arg_8_1, function(arg_9_0)
		if arg_9_0 then
			self._buffers[arg_8_1] = arg_9_0
		end

		if arg_8_2 then
			arg_8_2()
		end
	end)
end

function aniTile:playeffectMusic(arg_10_1, arg_10_2, arg_10_3)
	if audio_manager.effect_volume == 0 then
		return
	end

	local var_10_0 = arg_10_2 ~= nil and arg_10_2 or false
	local var_10_1 = (arg_10_3 or 1) * audio_manager.audioVolume[audio_manager.effect_volume] * audio_manager._effectscale

	if (arg_10_3 or 1) * audio_manager.audioVolume[audio_manager.effect_volume] * audio_manager._effectscale > 1 then
		var_10_1 = 1
	end

	if var_10_1 < 0 then
		var_10_1 = 0
	end

	if not arg_10_1:find("^sound") then
		arg_10_1 = "sound/" .. arg_10_1
	end

	arg_10_1 = arg_10_1 .. ".ogg"

	self:loadAudio(arg_10_1, function()
		if not self._buffers[arg_10_1] then
			print(arg_10_1 .. " have not loaded!!!")

			return
		end

		local var_11_0 = audio_module.new(var_10_1)

		if not var_11_0 then
			return
		end

		var_11_0:setVolume(var_10_1)
		var_11_0:play2d(self._buffers[arg_10_1], var_10_0)
	end)
end

return aniTile
