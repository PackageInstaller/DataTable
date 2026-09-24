local var_0_0 = assert
local var_0_1 = table.insert
local var_0_2 = table.remove
local var_0_3 = string.format
local var_0_4 = UnityEngine.GameObject
local var_0_5 = typeof(UnityEngine.GameObject)
local var_0_6 = get_millisecond
local var_0_7 = lx.Time
local var_0_8 = lx.ResourceManager
local var_0_9 = System.GC.GetTotalMemory

lx.define_class("ResourceManagerRef", function(arg_1_0)
	function arg_1_0:reset()
		self._cache_set = {}
		self._delay_time = 0
		self._lru_capacity = 0
		self._lru_num = 0
		self._lru_pool = {}
		self._preload_file_set = {}
		self._asset_bundle_set = {}

		self:__profile_end((self:__profile_begin("reset")))
	end

	function arg_1_0:checkInit()
		if self._lru_pool == nil then
			self._delay_time = 0
			self._lru_capacity = 0
			self._lru_num = 0
			self._lru_pool = {}
		end
	end

	function arg_1_0.setProfileLogFunc(arg_4_0, arg_4_1)
		arg_4_0._profile_log_func = arg_4_1
	end

	function arg_1_0.enableProfile(arg_5_0, arg_5_1)
		arg_5_0._enable_profile = arg_5_1
	end

	function arg_1_0.setResourceConfig(arg_6_0, arg_6_1, arg_6_2)
		arg_6_1 = arg_6_1 or 0
		arg_6_2 = arg_6_2 or 0
		arg_6_0._delay_time = arg_6_1
		arg_6_0._lru_capacity = arg_6_2
	end

	function arg_1_0:getProfilerInfo()
		return self._asset_bundle_set
	end

	function arg_1_0:enableCache(arg_8_1)
		if self._enable_cache and not arg_8_1 then
			self._cache_set = {}
		end

		if not self._enable_cache and arg_8_1 then
			self._cache_set = {}
		end

		self._enable_cache = arg_8_1
	end

	function arg_1_0:createGameObject(arg_9_1)
		local var_9_0
		local var_9_1 = self:__find_from_cache(arg_9_1, var_0_5)

		if not var_9_1 then
			var_9_0 = var_0_8:loadAsset(arg_9_1, var_0_5)
		end

		var_9_0 = var_9_1 or var_9_0

		local var_9_2

		if var_9_0 then
			var_9_2 = var_0_4.Instantiate(var_9_0)

			self:__profile_end((self:__profile_begin(var_0_3("createGameObject [%s]", arg_9_1))))
			self:__retain_asset(arg_9_1)

			if not var_9_1 then
				self:__add_to_cache(arg_9_1, var_0_5, var_9_0)
			end
		end

		return var_9_2
	end

	function arg_1_0:createGameObjectAsync(arg_10_1, arg_10_2, arg_10_3)
		local var_10_0 = self:__profile_begin(var_0_3("createGameObjectAsync [%s]", arg_10_1))
		local var_10_1 = var_0_5
		local var_10_2 = self:__find_from_cache(arg_10_1, var_0_5)

		local function var_10_3(arg_11_0)
			local var_11_0

			if arg_11_0 then
				var_11_0 = var_0_4.Instantiate(arg_11_0)

				self:__profile_end(var_10_0)
				self:__retain_asset(arg_10_1)

				if not self:__find_from_cache(arg_10_1, var_10_1) then
					self:__add_to_cache(arg_10_1, var_10_1, arg_11_0)
				end
			end

			arg_10_2(var_11_0)
		end

		if var_10_2 then
			var_10_3(var_10_2)
		else
			var_0_8:loadAssetAsync(arg_10_1, var_0_5, var_10_3, arg_10_3)
		end
	end

	function arg_1_0:loadAsset(arg_12_1, arg_12_2)
		local var_12_0
		local var_12_1 = self:__find_from_cache(arg_12_1, arg_12_2)

		if not var_12_1 then
			var_12_0 = var_0_8:loadAsset(arg_12_1, arg_12_2)
		end

		var_12_0 = var_12_1 or var_12_0

		if var_12_0 then
			self:__profile_end((self:__profile_begin(var_0_3("loadAsset [%s](%s)", arg_12_1, tostring(arg_12_2)))))
			self:__retain_asset(arg_12_1)

			if not var_12_1 then
				self:__add_to_cache(arg_12_1, arg_12_2, var_12_0)
			end
		end

		return var_12_0
	end

	function arg_1_0:loadAssetAsync(arg_13_1, arg_13_2, arg_13_3, arg_13_4)
		local var_13_0 = self:__profile_begin(var_0_3("loadAssetAsync [%s](%s)", arg_13_1, tostring(arg_13_2)))
		local var_13_1 = self:__find_from_cache(arg_13_1, arg_13_2)

		local function var_13_2(arg_14_0)
			if arg_14_0 then
				self:__profile_end(var_13_0)
				self:__retain_asset(arg_13_1)

				if not self:__find_from_cache(arg_13_1, arg_13_2) then
					self:__add_to_cache(arg_13_1, arg_13_2, arg_14_0)
				end
			end

			arg_13_3(arg_14_0)
		end

		if var_13_1 then
			var_13_2(var_13_1)
		else
			var_0_8:loadAssetAsync(arg_13_1, arg_13_2, var_13_2, arg_13_4)
		end
	end

	function arg_1_0:preloadAsset(arg_15_1, arg_15_2, arg_15_3)
		local var_15_0 = self:__profile_begin(var_0_3("preloadAsset [%s]", arg_15_1))
		local var_15_1 = "preloadAsset"

		local function var_15_2()
			self:__profile_end(var_15_0)
			self:__retain_asset(arg_15_1)
			self:__preload_asset(arg_15_1)

			if not self:__find_from_cache(arg_15_1, var_15_1) then
				self:__add_to_cache(arg_15_1, var_15_1, "")
			end

			arg_15_2()
		end

		if self:__find_from_cache(arg_15_1, "preloadAsset") then
			var_15_2()
		else
			var_0_8:preloadAsset(arg_15_1, var_15_2, arg_15_3)
		end
	end

	function arg_1_0:unloadAsset(arg_17_1)
		self:__profile_end((self:__profile_begin(var_0_3("unloadAsset [%s]", arg_17_1), true, true)))
		self:__try_release_asset(arg_17_1)
	end

	function arg_1_0:clearPreload()
		for iter_18_0, iter_18_1 in pairs(self._preload_file_set) do
			for iter_18_2 = 1, iter_18_1 do
				self:__try_release_asset(iter_18_0)
			end
		end

		self._preload_file_set = {}
	end

	function arg_1_0:__profile_begin(arg_19_1, arg_19_2, arg_19_3)
		if not self._enable_profile then
			return nil
		end

		local var_19_0 = 0

		if not arg_19_2 then
			var_19_0 = var_0_6()
		end

		local var_19_1 = 0
		local var_19_2 = 0

		if not arg_19_3 then
			var_19_1 = processinfo_get().memory.current
			var_19_2 = math.floor(tonumber(tostring(var_0_9(false))) / 1024)
		end

		return {
			profile_begin_time = var_19_0,
			profile_str = arg_19_1,
			memory = var_19_1,
			cs_memory = var_19_2
		}
	end

	function arg_1_0:__profile_end(arg_20_1)
		if not self._enable_profile then
			return
		end

		local var_20_0
		local var_20_1
		local var_20_2
		local var_20_3 = "[ResourceManagerRef] %s elapsed [%s] ms"

		if arg_20_1.profile_begin_time == 0 then
			var_20_3 = "[ResourceManagerRef] %s"
		else
			var_20_0 = var_0_6() - arg_20_1.profile_begin_time

			if arg_20_1.memory ~= 0 then
				var_20_1 = processinfo_get().memory.current - arg_20_1.memory
				var_20_2 = math.floor(tonumber(tostring(var_0_9(false))) / 1024) - arg_20_1.cs_memory
				var_20_3 = var_20_3 .. ", memory(%s)KB, cs memory(%s)KB"
			end
		end

		self._profile_log_func(var_0_3(var_20_3, arg_20_1.profile_str, var_20_0, var_20_1, var_20_2))
	end

	function arg_1_0:__find_from_cache(arg_21_1, arg_21_2)
		if not self._enable_cache then
			return nil
		end

		local var_21_0 = self._cache_set[arg_21_1]

		if not self._cache_set[arg_21_1] then
			return nil
		end

		return var_21_0[arg_21_2]
	end

	function arg_1_0:__add_to_cache(arg_22_1, arg_22_2, arg_22_3)
		if not self._enable_cache then
			return
		end

		self:__profile_end((self:__profile_begin(var_0_3("add_to_cache [%s](%s)", arg_22_1, tostring(arg_22_2)), true, true)))

		local var_22_0 = self._cache_set[arg_22_1]

		if not self._cache_set[arg_22_1] then
			var_22_0 = {}
			self._cache_set[arg_22_1] = var_22_0
		end

		if var_22_0[arg_22_2] then
			var_0_0(not var_22_0[arg_22_2], var_0_3("why already in cache, [%s]", arg_22_1))
		end

		var_22_0[arg_22_2] = arg_22_3
	end

	function arg_1_0:__remove_from_cache(arg_23_1)
		if not self._enable_cache then
			return
		end

		self:__profile_end((self:__profile_begin(var_0_3("remove_from_cache [%s]", arg_23_1), true, true)))

		if not self._cache_set[arg_23_1] then
			var_0_0(self._cache_set[arg_23_1], var_0_3("why not in cache? [%s]", arg_23_1))
		end

		self._cache_set[arg_23_1] = nil
	end

	function arg_1_0:__retain_asset(arg_24_1)
		local var_24_0 = var_0_8:getAssetBundleName(arg_24_1)
		local var_24_1 = self._asset_bundle_set[var_24_0]

		if not self._asset_bundle_set[var_24_0] then
			var_24_1 = {}
			self._asset_bundle_set[var_24_0] = var_24_1

			self:__check_retain_asset_bundle(var_24_0)
		end

		local var_24_2 = var_24_1[arg_24_1]

		var_24_2 = var_24_1[arg_24_1] and var_24_2 + 1 or 1
		var_24_1[arg_24_1] = var_24_2

		self:__check_lru()
	end

	function arg_1_0:__check_retain_asset_bundle(arg_25_1)
		self:__profile_end((self:__profile_begin(var_0_3("add_asset_bundle [%s]", arg_25_1), true, true)))

		local var_25_0 = var_0_8:findAssetBundleDepSet(arg_25_1)

		if not var_25_0 then
			return
		end

		for iter_25_0, iter_25_1 in pairs(var_25_0) do
			self._asset_bundle_set[iter_25_0] = self._asset_bundle_set[iter_25_0] or {}

			self:__check_retain_asset_bundle(iter_25_0)
		end
	end

	function arg_1_0:__release_asset(arg_26_1)
		self:__profile_end((self:__profile_begin(var_0_3("release_asset [%s]", arg_26_1), true, true)))

		local var_26_0 = var_0_8:getAssetBundleName(arg_26_1)

		if not self._asset_bundle_set[var_26_0] then
			var_0_0(self._asset_bundle_set[var_26_0], var_0_3("why not find ab:[%s]", var_26_0))
		end

		local var_26_1 = self._asset_bundle_set[var_26_0][arg_26_1]

		if not self._asset_bundle_set[var_26_0][arg_26_1] then
			var_0_0(var_26_1, var_0_3("why not find file:[%s]", arg_26_1))
		end

		local var_26_2 = var_26_1 - 1

		if var_26_1 - 1 <= 0 then
			self._asset_bundle_set[var_26_0][arg_26_1] = nil

			self:__remove_from_cache(arg_26_1)
			self:__check_release_asset_bundle(var_26_0)
		else
			self._asset_bundle_set[var_26_0][arg_26_1] = var_26_2
		end
	end

	function arg_1_0:__check_release_asset_bundle(arg_27_1)
		if not self._asset_bundle_set[arg_27_1] or next(self._asset_bundle_set[arg_27_1]) then
			return
		end

		local var_27_0 = var_0_8:findAssetBundleWhoDepMeSet(arg_27_1)

		if var_27_0 then
			for iter_27_0, iter_27_1 in pairs(var_27_0) do
				if self._asset_bundle_set[iter_27_0] then
					return
				end
			end
		end

		local var_27_1 = self:__profile_begin(var_0_3("remove_asset_bundle [%s]", arg_27_1))

		self._asset_bundle_set[arg_27_1] = nil

		var_0_8:unloadTheAssetBundle(arg_27_1, true)
		self:__profile_end(var_27_1)

		local var_27_2 = var_0_8:findAssetBundleDepSet(arg_27_1)

		if var_27_2 then
			for iter_27_2, iter_27_3 in pairs(var_27_2) do
				self:__check_release_asset_bundle(iter_27_2)
			end
		end
	end

	function arg_1_0:__try_release_asset(arg_28_1)
		self._lru_num = self._lru_num + 1

		var_0_1(self._lru_pool, {
			name = arg_28_1,
			expire_time = var_0_7:getUtcTime() + self._delay_time
		})
		self:__check_lru()
	end

	function arg_1_0:__check_lru()
		local var_29_0 = var_0_7:getUtcTime()

		while true do
			if not self._lru_pool[1] then
				break
			end

			if self._lru_num < self._lru_capacity and var_29_0 < self._lru_pool[1].expire_time then
				break
			end

			self._lru_num = self._lru_num - 1

			var_0_2(self._lru_pool, 1)
			self:__release_asset(self._lru_pool[1].name)
		end
	end

	function arg_1_0:__preload_asset(arg_30_1)
		local var_30_0 = self._preload_file_set[arg_30_1]

		var_30_0 = self._preload_file_set[arg_30_1] and var_30_0 + 1 or 1
		self._preload_file_set[arg_30_1] = var_30_0
	end
end)

return function()
	local var_31_0 = lx.class("ResourceManagerRef")

	var_31_0._profile_log_func = nil
	var_31_0._enable_profile = false
	var_31_0._enable_cache = false
	var_31_0._cache_set = {}
	var_31_0._delay_time = 0
	var_31_0._lru_capacity = 0
	var_31_0._lru_num = 0
	var_31_0._lru_pool = {}
	var_31_0._preload_file_set = {}
	var_31_0._asset_bundle_set = {}

	return var_31_0
end
