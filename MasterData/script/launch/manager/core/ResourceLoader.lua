local var_0_0 = lx
local var_0_1 = lx.ResourceManager
local var_0_2 = lx.ResourceManagerRef

lx.define_class("ResourceLoader", function(arg_1_0)
	function arg_1_0.reset(arg_2_0)
		var_0_2:reset()
		var_0_1:reset()
	end

	function arg_1_0.checkInit(arg_3_0)
		var_0_2:checkInit()

		if app:isPC() then
			var_0_2:enableCache(true)
			var_0_2:setResourceConfig(60, 128)
		else
			var_0_2:enableCache(false)
			var_0_2:setResourceConfig(60, 128)
		end
	end

	function arg_1_0.setProfileLogFunc(arg_4_0, arg_4_1)
		var_0_2:setProfileLogFunc(arg_4_1)
	end

	function arg_1_0.enableProfile(arg_5_0, arg_5_1)
		var_0_2:enableProfile(arg_5_1)
	end

	function arg_1_0.setAssetPathCheckFunc(arg_6_0, arg_6_1)
		var_0_1:setAssetPathCheckFunc(arg_6_1)
	end

	function arg_1_0.setInternalCheckFunc(arg_7_0, arg_7_1)
		var_0_1:setInternalCheckFunc(arg_7_1)
	end

	function arg_1_0.setInAssetDirPrefix(arg_8_0, arg_8_1)
		var_0_1:setInAssetDirPrefix(arg_8_1)
	end

	function arg_1_0.addAssetDir(arg_9_0, arg_9_1)
		var_0_1:addAssetDir(arg_9_1)
	end

	function arg_1_0.setAssetBundleCrcOffsetFunc(arg_10_0, arg_10_1)
		var_0_1:setAssetBundleCrcOffsetFunc(arg_10_1)
	end

	function arg_1_0.isEnableAssetBundle(arg_11_0)
		return var_0_1:isEnableAssetBundle()
	end

	function arg_1_0.enableAssetBundle(arg_12_0)
		var_0_1:enableAssetBundle()
	end

	function arg_1_0.createGameObject(arg_13_0, arg_13_1)
		return var_0_2:createGameObject(arg_13_1)
	end

	function arg_1_0.createGameObjectAsync(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
		var_0_2:createGameObjectAsync(arg_14_1, arg_14_2, arg_14_3)
	end

	function arg_1_0.destroyGameObject(arg_15_0, arg_15_1)
		var_0_1:destroyGameObject(arg_15_1)
	end

	function arg_1_0.loadAsset(arg_16_0, arg_16_1, arg_16_2)
		return var_0_2:loadAsset(arg_16_1, arg_16_2)
	end

	function arg_1_0.loadAssetAsync(arg_17_0, arg_17_1, arg_17_2, arg_17_3, arg_17_4)
		var_0_2:loadAssetAsync(arg_17_1, arg_17_2, arg_17_3, arg_17_4)
	end

	function arg_1_0:preloadAsset(arg_18_1, arg_18_2, arg_18_3)
		if self:findPath(arg_18_1) then
			arg_18_2 = arg_18_2 or function()
				return
			end

			var_0_2:preloadAsset(arg_18_1, arg_18_2, arg_18_3)
		end
	end

	function arg_1_0.clearPreload(arg_20_0)
		var_0_2:clearPreload()
	end

	function arg_1_0.unloadAsset(arg_21_0, arg_21_1)
		var_0_2:unloadAsset(arg_21_1)
	end

	function arg_1_0.destroyAllUnusedAssets(arg_22_0)
		var_0_1:destroyAllUnusedAssets()
	end

	function arg_1_0.findAssetTheAssetBundleName(arg_23_0, arg_23_1)
		return var_0_1:findAssetTheAssetBundleName(arg_23_1)
	end

	function arg_1_0.getProfilerInfo(arg_24_0)
		return var_0_0.format_to_json(var_0_2:getProfilerInfo(), {})
	end

	gamecore.extend_method(arg_1_0)
end)

return function()
	local var_25_0 = var_0_0.class("ResourceLoader")

	gamecore.extend_obj(var_25_0)

	return var_25_0
end
