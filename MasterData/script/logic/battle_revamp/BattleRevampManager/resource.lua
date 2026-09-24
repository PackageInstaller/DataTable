local var_0_0 = {}
local var_0_1 = gamecore.ResourceLoader
local var_0_2 = gamecore.AudioManager

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:createBattleGameObject(arg_2_1)
		self._battle_res = self._battle_res or {}

		table.insert(self._battle_res, arg_2_1)

		return var_0_1:createGameObject(arg_2_1)
	end

	function arg_1_0:loadBattleSprite(arg_3_1)
		self._battle_res = self._battle_res or {}

		table.insert(self._battle_res, arg_3_1)

		return var_0_1:loadSprite(arg_3_1)
	end

	function arg_1_0:loadBattleFont(arg_4_1)
		self._battle_res = self._battle_res or {}

		table.insert(self._battle_res, arg_4_1)

		return var_0_1:loadFont(arg_4_1)
	end

	function arg_1_0:loadBattleSkeletonDataAsset(arg_5_1)
		self._battle_res = self._battle_res or {}

		table.insert(self._battle_res, arg_5_1)

		return var_0_1:loadSkeletonDataAsset(arg_5_1)
	end

	function arg_1_0:loadBattleMaterial(arg_6_1)
		self._battle_res = self._battle_res or {}

		table.insert(self._battle_res, arg_6_1)

		return var_0_1:loadMaterial(arg_6_1)
	end

	function arg_1_0:loadBattleTexture2D(arg_7_1)
		if not self:findPath(arg_7_1) then
			arg_7_1 = "data_extra/ship/spine/1/Ship_girl_1.png"
		end

		self._battle_res = self._battle_res or {}

		table.insert(self._battle_res, arg_7_1)

		return var_0_1:loadTexture2D(arg_7_1)
	end

	function arg_1_0:loadBattleAudioClip(arg_8_1)
		self._battle_res = self._battle_res or {}

		table.insert(self._battle_res, arg_8_1)

		return var_0_1:loadAudioClip(arg_8_1)
	end

	function arg_1_0:playBattleCV(arg_9_1)
		local var_9_0 = var_0_2:playCV(arg_9_1, false, "cv")

		self._battle_res = self._battle_res or {}

		if var_9_0 then
			table.insert(self._battle_res, var_9_0)
		end
	end

	function arg_1_0:playBattleSE(arg_10_1)
		local var_10_0 = var_0_2:playSE(arg_10_1)

		self._battle_res = self._battle_res or {}

		if var_10_0 then
			table.insert(self._battle_res, var_10_0)
		end
	end

	function arg_1_0:playBattleBGM(arg_11_1)
		local var_11_0 = var_0_2:playBackgroundMusic(arg_11_1)

		self._battle_res = self._battle_res or {}

		if var_11_0 then
			table.insert(self._battle_res, var_11_0)
		end
	end

	function arg_1_0.destroyGameObject(arg_12_0, arg_12_1)
		var_0_1:destroyGameObject(arg_12_1)
	end

	function arg_1_0:destroyBattleRes()
		for iter_13_0, iter_13_1 in pairs(self._battle_res or {}) do
			var_0_1:unloadAsset(iter_13_1)
		end

		self._battle_res = {}
	end

	function arg_1_0.findPath(arg_14_0, arg_14_1)
		return var_0_1:findPath(arg_14_1)
	end

	function arg_1_0.reset(arg_15_0)
		arg_15_0._battle_res = {}
	end
end

function var_0_0.extend_obj(arg_16_0)
	arg_16_0._battle_res = {}
end

return var_0_0
