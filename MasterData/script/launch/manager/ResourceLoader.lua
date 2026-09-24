local var_0_0 = {}
local var_0_3 = typeof(UnityEngine.Texture)
local var_0_4 = typeof(UnityEngine.Texture2D)
local var_0_5 = typeof(UnityEngine.Sprite)
local var_0_6 = typeof(UnityEngine.Material)
local var_0_7 = typeof(UnityEngine.AnimationClip)
local var_0_8 = typeof(UnityEngine.Video.VideoClip)
local var_0_9 = typeof(UnityEngine.AudioClip)
local var_0_10 = typeof(Spine.Unity.SkeletonDataAsset)
local var_0_11 = typeof(UnityEngine.TextAsset)
local var_0_12 = typeof(UnityEngine.Font)
local var_0_13 = typeof(UnityEngine.RuntimeAnimatorController)

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:loadTexture(arg_2_1)
		return self:loadAsset(arg_2_1, var_0_3)
	end

	function arg_1_0:loadTexture2D(arg_3_1)
		return self:loadAsset(arg_3_1, var_0_4)
	end

	function arg_1_0:loadSprite(arg_4_1)
		if not arg_4_1 then
			return
		end

		arg_4_1 = self:convertToJP(arg_4_1)

		local var_4_0, var_4_1 = self:get_hd_sprite(arg_4_1)

		if var_4_0 then
			return self:loadAsset(var_4_1, var_0_5), var_4_1, var_4_0
		end

		local var_4_2 = self:check_and_set_default_sprite((self:get_character_sprite(var_4_1)))

		return self:loadAsset(var_4_2, var_0_5), var_4_2
	end

	function arg_1_0:loadMaterial(arg_5_1)
		return self:loadAsset(arg_5_1, var_0_6)
	end

	function arg_1_0:loadAnimationClip(arg_6_1)
		return self:loadAsset(arg_6_1, var_0_7)
	end

	function arg_1_0:loadAnimatorController(arg_7_1)
		return self:loadAsset(arg_7_1, var_0_13)
	end

	function arg_1_0:loadVideoClip(arg_8_1)
		return self:loadAsset(arg_8_1, var_0_8)
	end

	function arg_1_0:loadAudioClip(arg_9_1)
		return self:loadAsset(arg_9_1, var_0_9)
	end

	function arg_1_0:loadSkeletonDataAsset(arg_10_1)
		return self:loadAsset(arg_10_1, var_0_10)
	end

	function arg_1_0:loadTextAsset(arg_11_1)
		return self:loadAsset(arg_11_1, var_0_11)
	end

	function arg_1_0:loadFont(arg_12_1)
		return self:loadAsset(arg_12_1, var_0_12)
	end

	function arg_1_0:loadRuntimeAnimatorController(arg_13_1)
		return self:loadAsset(arg_13_1, var_0_13)
	end

	function arg_1_0.convertToJP(arg_14_0, arg_14_1, arg_14_2)
		local var_14_0 = app:getSystem():getChannel()

		if var_14_0 ~= gameenum.common_type.channel.android_jp and var_14_0 ~= gameenum.common_type.channel.iOS_jp then
			return arg_14_1
		end

		arg_14_2 = arg_14_2 or "ui"

		return (string.gsub(arg_14_1, string.format("data_cn/%s_cn", arg_14_2), (string.format("data_jp/%s_jp", arg_14_2))))
	end

	function arg_1_0:check_and_set_default_sprite(arg_15_1)
		local var_15_0 = string.sub(arg_15_1, 9, 22)
		local var_15_1 = string.sub(arg_15_1, 7, 20)

		if var_15_0 == "model_normal_l" or var_15_1 == "model_broken_l" or var_15_1 == "model_normal_l" then
			if self:findPath(arg_15_1) then
				return arg_15_1
			else
				return "data/ui/model_normal_l/1/L_NORMAL_1.png"
			end
		elseif var_15_0 == "model_normal_m" or var_15_1 == "model_broken_m" or var_15_1 == "model_normal_m" then
			if self:findPath(arg_15_1) then
				return arg_15_1
			else
				return "data/ui/model_normal_m/1/M_NORMAL_1.png"
			end
		elseif var_15_0 == "model_normal_s" or var_15_1 == "model_broken_s" or var_15_1 == "model_normal_s" then
			if self:findPath(arg_15_1) then
				return arg_15_1
			else
				return "data/ui/model_normal_s/1/S_NORMAL_1.png"
			end
		elseif var_15_0 == "model_normal_x" or var_15_1 == "model_broken_x" or var_15_1 == "model_normal_x" then
			if self:findPath(arg_15_1) then
				return arg_15_1
			else
				return "data/ui/model_normal_xm/1/XM_NORMAL_1.png"
			end
		else
			return arg_15_1
		end
	end

	function arg_1_0:get_hd_sprite(arg_16_1)
		local var_16_0 = false

		if not gameenum.common_type.open_hd_picture then
			return var_16_0, arg_16_1
		end

		if string.sub(arg_16_1, 9, 22) == "model_normal_l" then
			local var_16_1 = lx.UserData:getKeyData("setting_broken")
			local var_16_2 = true

			if var_16_1 ~= "" and var_16_1 ~= " " then
				var_16_2 = lx.json_decode(var_16_1).value
			end

			if var_16_2 ~= "" and var_16_2 ~= " " and type(var_16_2) == "boolean" then
				var_16_2 = var_16_2 or false
			end

			if self:check_open_broken() and var_16_2 then
				local var_16_3 = string.gsub(string.gsub(string.gsub(string.gsub(arg_16_1, "data", "data_hd"), "/ui", ""), "model_normal_l", "model_normal_l_hd2"), "L_NORMAL", "L_NORMAL_HD")

				if self:findPath(var_16_3) then
					arg_16_1 = var_16_3
					var_16_0 = true
				else
					local var_16_4 = string.gsub(var_16_3, "model_normal_l_hd2", "model_normal_l_hd")

					if self:findPath(var_16_4) then
						arg_16_1 = var_16_4
						var_16_0 = true
					end
				end
			else
				local var_16_5 = string.gsub(string.gsub(string.gsub(string.gsub(arg_16_1, "data", "data_hd"), "/ui", ""), "model_normal_l", "model_normal_l_hd"), "L_NORMAL", "L_NORMAL_HD")

				if self:findPath(var_16_5) then
					arg_16_1 = var_16_5
					var_16_0 = true
				end
			end
		else
			local var_16_6 = string.gsub(string.gsub(string.gsub(string.gsub(arg_16_1, "data2", "data_hd"), "/ui", ""), "model_broken_l", "model_broken_l_hd"), "L_BROKEN", "L_BROKEN_HD")

			if self:findPath(var_16_6) then
				arg_16_1 = var_16_6
				var_16_0 = true
			end
		end

		return var_16_0, arg_16_1
	end

	function arg_1_0.check_open_broken(arg_17_0)
		local var_17_0 = app:getSystem():getChannel()

		return (gamecore.SubPatchManager:getIsDownloadPatch("data2") or var_17_0 == gameenum.common_type.channel.android_jp or var_17_0 == gameenum.common_type.channel.iOS_jp) and true
	end

	function arg_1_0:get_character_sprite(arg_18_1)
		local var_18_0 = lx.UserData:getKeyData("setting_broken")
		local var_18_1 = true

		if var_18_0 ~= "" and var_18_0 ~= " " then
			var_18_1 = lx.json_decode(var_18_0).value
		end

		if var_18_1 ~= "" and var_18_1 ~= " " and type(var_18_1) == "boolean" then
			var_18_1 = var_18_1 or false
		end

		if self:check_open_broken() and var_18_1 then
			local var_18_2 = string.sub(arg_18_1, 9, 22)

			if var_18_2 == "model_normal_l" then
				local var_18_3 = string.gsub(string.gsub(arg_18_1, "/ui", ""), "data", "data2")

				if self:findPath(var_18_3) then
					return var_18_3
				end

				return arg_18_1
			elseif var_18_2 == "model_normal_m" then
				local var_18_4 = string.gsub(string.gsub(arg_18_1, "/ui", ""), "data", "data2")

				if self:findPath(var_18_4) then
					return var_18_4
				end

				return arg_18_1
			elseif var_18_2 == "model_normal_s" then
				local var_18_5 = string.gsub(string.gsub(arg_18_1, "/ui", ""), "data", "data2")

				if self:findPath(var_18_5) then
					return var_18_5
				end

				return arg_18_1
			elseif var_18_2 == "model_normal_x" then
				local var_18_6 = string.gsub(string.gsub(arg_18_1, "/ui", ""), "data", "data2")

				if self:findPath(var_18_6) then
					return var_18_6
				end

				return arg_18_1
			end
		end

		return arg_18_1
	end

	function arg_1_0:findPath(arg_19_1)
		local var_19_0 = self:findAssetTheAssetBundleName(arg_19_1)

		if not var_19_0 and app:isPC() then
			local var_19_1 = io.open("./Assets/" .. arg_19_1, "rb")
			local var_19_2 = var_19_1 ~= nil

			if var_19_1 then
				var_19_1:close()
			end

			return var_19_2
		end

		return var_19_0 ~= nil
	end
end

function var_0_0.extend_obj(arg_20_0)
	return
end

return var_0_0
