local var_0_0 = assert
local var_0_1 = string.format
local var_0_2 = table.insert
local var_0_3 = lx.bootstrap_manager
local var_0_4 = UnityEngine.GameObject
local var_0_5 = UnityEngine.Resources
local var_0_6 = UnityEngine.AssetBundle
local var_0_8 = xbask.EditorResourceManager
local var_0_9 = typeof(UnityEngine.GameObject)
local var_0_10 = WaitForEndOfFrame
local var_0_11 = StartCoroutine
local var_0_12 = StopCoroutine
local var_0_13 = Yield
local var_0_14 = string.char(51) .. string.char(102) .. string.char(153) .. string.char(54) .. string.char(105) .. string.char(136) .. string.char(9)

lx.define_class("ResourceManager", function(arg_1_0)
	function arg_1_0:reset()
		for iter_2_0, iter_2_1 in pairs(self._asset_bundle_set) do
			iter_2_1:Unload(true)
		end

		for iter_2_2, iter_2_3 in pairs(self._async_loading_set) do
			var_0_12(iter_2_3.co)
		end

		self._asset_dir_set = {}
		self._asset_dependencies_name_set = {}
		self._root_dir_set = {}
		self._root_dir_readonly = nil
		self._asset_set = {}
		self._asset_bundle_dep_set = {}
		self._asset_bundle_who_dep_me_set = {}
		self._asset_bundle_set = {}
		self._async_loading_set = {}

		self:destroyAllUnusedAssets()
	end

	function arg_1_0:unloadTheAssetBundle(arg_3_1, arg_3_2)
		if type(arg_3_2) ~= "boolean" then
			var_0_0(type(arg_3_2) == "boolean", "'unload_type' expected 'boolean' type")
		end

		local var_3_0 = self:__find_asset_bundle(arg_3_1)

		if not var_3_0 then
			return false
		end

		self:__remove_asset_bundle(arg_3_1)
		var_3_0:Unload(arg_3_2)

		return true
	end

	function arg_1_0:unloadAssetBundle(arg_4_1)
		local var_4_0 = {}

		for iter_4_0, iter_4_1 in pairs(self._asset_bundle_set) do
			local var_4_1, var_4_2 = arg_4_1(iter_4_0)

			if var_4_1 then
				if type(var_4_2) ~= "boolean" then
					var_0_0(type(var_4_2) == "boolean", "'unload_type' expected 'boolean' type")
				end

				var_4_0[iter_4_0] = {
					ab = iter_4_1,
					unload_type = var_4_2
				}
			end
		end

		for iter_4_2, iter_4_3 in pairs(var_4_0) do
			self:__remove_asset_bundle(iter_4_2)
			iter_4_3.ab:Unload(iter_4_3.unload_type)
		end
	end

	function arg_1_0.setAssetPathCheckFunc(arg_5_0, arg_5_1)
		arg_5_0._asset_path_check_func = arg_5_1
	end

	function arg_1_0.setInternalCheckFunc(arg_6_0, arg_6_1)
		arg_6_0._internal_check_func = arg_6_1
	end

	function arg_1_0.setAssetBundleCrcOffsetFunc(arg_7_0, arg_7_1)
		arg_7_0._asset_bundle_crc_offset_func = arg_7_1
	end

	function arg_1_0:isEnableAssetBundle()
		return self._use_asset_bundle
	end

	function arg_1_0:enableAssetBundle()
		self._use_asset_bundle = true

		self:__check_load_all_dependencies()
	end

	function arg_1_0.setInAssetDirPrefix(arg_10_0, arg_10_1)
		arg_10_1 = arg_10_1:gsub("^/", "")
		arg_10_1 = arg_10_1:gsub("/$", "")
		arg_10_1 = arg_10_1 .. "/"
		arg_10_0._in_asset_prefix = arg_10_1
	end

	function arg_1_0:addAssetDir(arg_11_1)
		for iter_11_0, iter_11_1 in pairs(self._asset_dir_set) do
			if iter_11_1 == arg_11_1 then
				return
			end
		end

		local var_11_0 = arg_11_1 .. "/" .. arg_11_1 .. self:__get_asset_bundle_suffix()

		var_0_2(self._asset_dir_set, arg_11_1)
		var_0_2(self._asset_dependencies_name_set, var_11_0)
		self:__check_load_all_dependencies(var_11_0)
	end

	function arg_1_0:getAssetBundleName(arg_12_1)
		return self:__get_asset_bundle_full_name(arg_12_1)
	end

	function arg_1_0:findAssetTheAssetBundleName(arg_13_1)
		return self._asset_set[arg_13_1]
	end

	function arg_1_0:findAssetBundleDepSet(arg_14_1)
		return self._asset_bundle_dep_set[arg_14_1]
	end

	function arg_1_0:findAssetBundleWhoDepMeSet(arg_15_1)
		return self._asset_bundle_who_dep_me_set[arg_15_1]
	end

	function arg_1_0:createGameObject(arg_16_1)
		local var_16_0 = self:__load_asset(arg_16_1)

		if not var_16_0 then
			return nil
		end

		return var_0_4.Instantiate(var_16_0)
	end

	function arg_1_0:createGameObjectAsync(arg_17_1, arg_17_2, arg_17_3)
		local function var_17_0(arg_18_0)
			arg_17_2(var_0_4.Instantiate(arg_18_0))
		end

		local var_17_1 = self:__load_asset(arg_17_1, nil, var_17_0, arg_17_3)

		if var_17_1 then
			var_17_0(var_17_1)
		end
	end

	function arg_1_0:loadAsset(arg_19_1, arg_19_2)
		return self:__load_asset(arg_19_1, arg_19_2, nil, nil)
	end

	function arg_1_0:loadAssetAsync(arg_20_1, arg_20_2, arg_20_3, arg_20_4)
		local var_20_0 = self:__load_asset(arg_20_1, arg_20_2, arg_20_3, arg_20_4)

		if var_20_0 then
			arg_20_3(var_20_0)
		end
	end

	function arg_1_0:preloadAsset(arg_21_1, arg_21_2, arg_21_3)
		if self._asset_path_check_func and not self._asset_path_check_func(arg_21_1) then
			lx.error(var_0_1("path check failed, path:%s", arg_21_1))
		end

		if self._use_asset_bundle then
			arg_21_1 = self:__get_asset_bundle_full_name(arg_21_1)

			self:__load_asset_bundle_async(arg_21_1, arg_21_2, arg_21_3, nil, true)
		else
			var_0_8.LoadAssetAtPath(self._in_asset_prefix .. arg_21_1, var_0_9)

			if arg_21_2 then
				arg_21_2()
			end
		end
	end

	function arg_1_0.destroyGameObject(arg_22_0, arg_22_1)
		var_0_4.Destroy(arg_22_1)
	end

	function arg_1_0.destroyAllUnusedAssets(arg_23_0)
		var_0_5.UnloadUnusedAssets()
	end

	function arg_1_0:getAllNotLoadedAssetBundleSet()
		return self:__check__get_all_not_loaded_asset_bundle_set()
	end

	function arg_1_0:checkLoadAssetBundle(arg_25_1)
		return self:__check__load_asset_bundle(arg_25_1)
	end

	function arg_1_0:__check__get_all_not_loaded_asset_bundle_set()
		local var_26_0 = {}

		for iter_26_0, iter_26_1 in pairs(self._asset_bundle_dep_set) do
			if not self:__find_asset_bundle(iter_26_0) then
				var_26_0[iter_26_0] = iter_26_0
			end
		end

		return var_26_0
	end

	function arg_1_0:__check__load_asset_bundle(arg_27_1)
		local var_27_0 = self:__get_asset_bundle_path(arg_27_1)
		local var_27_1, var_27_2 = self:__get_asset_bundle_crc_offset(var_27_0)

		var_0_6.LoadFromFile(var_27_0, var_27_1, var_27_2):Unload(true)

		return true
	end

	function arg_1_0:__check_load_all_dependencies(arg_28_1)
		if not self._use_asset_bundle or next(self._asset_dependencies_name_set) == nil then
			return
		end

		self:__check_init(arg_28_1)
	end

	function arg_1_0:__check_init(arg_29_1)
		self:__init_root_dir()

		if arg_29_1 then
			self:__init_one(arg_29_1)

			return
		end

		for iter_29_0, iter_29_1 in pairs(self._asset_dependencies_name_set) do
			self:__init_one(iter_29_1)
		end
	end

	function arg_1_0:__init_root_dir()
		local var_30_0 = var_0_3:getWritePath()

		for iter_30_0, iter_30_1 in pairs(self._root_dir_set) do
			if iter_30_1 == var_30_0 then
				return
			end
		end

		var_0_2(self._root_dir_set, var_30_0)

		self._root_dir_readonly = var_0_3:getOSType() == "android" and UnityEngine.Application.streamingAssetsPath .. "/" or var_0_3:getReadonlyPath()
	end

	function arg_1_0:__init_one(arg_31_1)
		self._asset_bundle_who_dep_me_set = self._asset_bundle_who_dep_me_set or {}

		for iter_31_0, iter_31_1 in pairs((lx.json_decode((bit_xor_data_by_mask(self:__read_asset_bundle_manifest(arg_31_1), var_0_14))))) do
			local var_31_0 = {}

			for iter_31_2, iter_31_3 in pairs(iter_31_1.list) do
				var_31_0[iter_31_3] = iter_31_3

				local var_31_1 = self._asset_bundle_who_dep_me_set[iter_31_3]

				if not self._asset_bundle_who_dep_me_set[iter_31_3] then
					var_31_1 = {}
					self._asset_bundle_who_dep_me_set[iter_31_3] = var_31_1
				end

				var_31_1[iter_31_1.name] = iter_31_1.name
			end

			for iter_31_4, iter_31_5 in pairs(iter_31_1.file_list) do
				self._asset_set[iter_31_5] = iter_31_1.name
			end

			self._asset_bundle_dep_set[iter_31_1.name] = var_31_0
		end
	end

	function arg_1_0:__read_asset_bundle_manifest(arg_32_1)
		local var_32_0 = self:__try_get_path_first(arg_32_1)

		if not var_32_0 and var_0_3:getOSType() ~= "android" then
			var_32_0 = self._root_dir_readonly .. arg_32_1
		end

		if var_32_0 then
			local var_32_1 = io.open(var_32_0, "rb")

			if not var_32_1 then
				return nil
			end

			local var_32_2 = var_32_1:read("*a")

			var_32_1:close()

			return var_32_2
		end

		return zipfile.read_the_file(var_0_3:getReadonlyPath(), "assets/" .. arg_32_1)
	end

	function arg_1_0.__get_asset_bundle_suffix(arg_33_0)
		return ".unity3d"
	end

	function arg_1_0:__get_asset_bundle_full_name(arg_34_1)
		return arg_34_1:gsub("/[^/]+$", "") .. self:__get_asset_bundle_suffix()
	end

	function arg_1_0:__try_get_path_first(arg_35_1)
		for iter_35_0, iter_35_1 in pairs(self._root_dir_set) do
			local var_35_0 = io.open(iter_35_1 .. arg_35_1, "rb")

			if var_35_0 then
				var_35_0:close()

				return iter_35_1 .. arg_35_1
			end
		end

		return nil
	end

	function arg_1_0:__get_asset_bundle_path(arg_36_1)
		local var_36_0 = self:__try_get_path_first(arg_36_1)

		if var_36_0 then
			return var_36_0
		end

		if self._root_dir_readonly then
			return self._root_dir_readonly .. arg_36_1
		end

		lx.error(var_0_1("not find AssetBundle, name:[%s]", arg_36_1))
	end

	function arg_1_0:__get_asset_bundle_crc_offset(arg_37_1)
		if self._asset_bundle_crc_offset_func then
			return self._asset_bundle_crc_offset_func(arg_37_1)
		end

		return 0, 0
	end

	function arg_1_0:__load_asset(arg_38_1, arg_38_2, arg_38_3, arg_38_4)
		if self._asset_path_check_func and not self._asset_path_check_func(arg_38_1) then
			lx.error(var_0_1("path check failed, path:%s", arg_38_1))
		end

		arg_38_2 = arg_38_2 or var_0_9

		if self._internal_check_func and self._internal_check_func(arg_38_1) then
			arg_38_1 = arg_38_1:gsub("%.[^.]*$", "")

			return var_0_5.Load(arg_38_1, arg_38_2)
		end

		if self._use_asset_bundle then
			if arg_38_3 then
				self:__load_asset_from_asset_bundle_async(arg_38_1, arg_38_2, arg_38_3, arg_38_4)
			else
				return self:__load_asset_from_asset_bundle(arg_38_1, arg_38_2)
			end
		else
			return var_0_8.LoadAssetAtPath(self._in_asset_prefix .. arg_38_1, arg_38_2)
		end
	end

	function arg_1_0:__load_asset_bundle(arg_39_1)
		local var_39_0 = self:__find_asset_bundle(arg_39_1)

		if var_39_0 then
			return var_39_0
		end

		self:__stop_async_task(arg_39_1)

		local var_39_1 = self:__get_asset_bundle_path(arg_39_1)
		local var_39_2, var_39_3 = self:__get_asset_bundle_crc_offset(var_39_1)
		local var_39_4 = var_0_6.LoadFromFile(var_39_1, var_39_2, var_39_3)

		if self:__find_asset_bundle(arg_39_1) then
			var_0_0(false, "why already in?, name:" .. arg_39_1)
		end

		self:__async_task_loaded(arg_39_1, var_39_4)
		self:__add_asset_bundle(arg_39_1, var_39_4)

		for iter_39_0, iter_39_1 in pairs(self._asset_bundle_dep_set[arg_39_1]) do
			self:__load_asset_bundle(iter_39_0)
		end

		return var_39_4
	end

	function arg_1_0:__load_asset_from_asset_bundle(arg_40_1, arg_40_2)
		local var_40_0 = self:__get_asset_bundle_full_name(arg_40_1)
		local var_40_1 = self:__load_asset_bundle(var_40_0)

		if not var_40_1 then
			lx.error(var_0_1("load Asset from AssetBundle, load AssetBundle failed, " .. "AssetBundle path:[%s], Asset name:[%s]", var_40_0, arg_40_1))
		end

		local var_40_2 = var_40_1:LoadAsset(self._in_asset_prefix .. arg_40_1, arg_40_2)

		if not var_40_2 then
			lx.error(var_0_1("load Asset from AssetBundle, load Asset failed, " .. "AssetBundle path:[%s], Asset name:[%s]", var_40_0, arg_40_1))
		end

		return var_40_2
	end

	function arg_1_0:__load_asset_from_asset_bundle_async(arg_41_1, arg_41_2, arg_41_3, arg_41_4)
		local var_41_0
		local var_41_1 = false
		local var_41_2 = self:__find_async_task(arg_41_1)

		if not var_41_2 then
			var_41_2 = self:__add_async_task(arg_41_1, false, arg_41_2, arg_41_4)
			var_41_0 = var_41_2.progress
			var_41_1 = true
		end

		self:__async_task_add_callback_func(var_41_2, arg_41_3)
		self:__load_asset_bundle_async(self:__get_asset_bundle_full_name(arg_41_1), function()
			if var_41_1 then
				self:__async_task_start(var_41_2)
			end
		end, nil, var_41_0, false, var_41_0)
	end

	function arg_1_0:__load_asset_bundle_async(arg_43_1, arg_43_2, arg_43_3, arg_43_4, arg_43_5, arg_43_6)
		if self:__find_asset_bundle(arg_43_1) then
			if arg_43_2 then
				arg_43_2()
			end

			return false
		end

		local var_43_0 = false
		local var_43_1 = self:__find_async_task(arg_43_1)

		if not var_43_1 then
			var_43_1 = self:__add_async_task(arg_43_1, true, nil, arg_43_3)

			if arg_43_5 then
				arg_43_4 = var_43_1.progress
			end

			if arg_43_6 then
				self:__async_task_add_progress_depend(arg_43_6, arg_43_1)
			end

			var_43_0 = true
		end

		self:__async_task_add_callback_func(var_43_1, arg_43_2)

		if var_43_0 then
			for iter_43_0, iter_43_1 in pairs(self._asset_bundle_dep_set[arg_43_1]) do
				if self:__load_asset_bundle_async(iter_43_0, nil, nil, arg_43_4) then
					self:__async_task_add_depend(var_43_1, iter_43_0)
					self:__async_task_add_progress_depend(arg_43_4, iter_43_0)
				end
			end

			self:__async_task_start(var_43_1)
		end

		return true
	end

	function arg_1_0.__async_task_start(arg_44_0, arg_44_1)
		if arg_44_1.already_start then
			var_0_0(false)

			return
		end

		arg_44_1.co = var_0_11(arg_44_1.is_asset_bundle and function()
			var_0_12((var_0_10()))

			arg_44_1.loading = true

			local var_45_0 = arg_44_0:__get_asset_bundle_path(arg_44_1.name)
			local var_45_1, var_45_2 = arg_44_0:__get_asset_bundle_crc_offset(var_45_0)
			local var_45_3 = var_0_6.LoadFromFileAsync(var_45_0, var_45_1, var_45_2)

			var_0_13(var_45_3)
			arg_44_0:__async_task_loaded(arg_44_1.name, var_45_3.assetBundle)
		end or function()
			local var_46_0 = arg_44_0:__find_asset_bundle((arg_44_0:__get_asset_bundle_full_name(arg_44_1.name))):LoadAssetAsync(arg_44_0._in_asset_prefix .. arg_44_1.name, arg_44_1.asset_type)

			var_0_13(var_46_0)
			arg_44_0:__async_task_loaded(arg_44_1.name, var_46_0.asset)
		end)
		arg_44_1.already_start = true
	end

	function arg_1_0:__add_asset_bundle(arg_47_1, arg_47_2)
		self._asset_bundle_set[arg_47_1] = arg_47_2
	end

	function arg_1_0:__remove_asset_bundle(arg_48_1)
		self._asset_bundle_set[arg_48_1] = nil
	end

	function arg_1_0:__find_asset_bundle(arg_49_1)
		return self._asset_bundle_set[arg_49_1]
	end

	function arg_1_0:__add_async_task(arg_50_1, arg_50_2, arg_50_3, arg_50_4)
		local var_50_0 = {
			loading = false,
			depend_num = 0,
			already_start = false,
			name = arg_50_1,
			is_asset_bundle = arg_50_2,
			asset_type = arg_50_3,
			who_depend_me = {},
			callback_func_set = {},
			progress = {
				total = 0,
				already_num = 0,
				name = arg_50_1,
				who_depend_me = {},
				depend_set = {},
				progress_func = arg_50_4
			}
		}

		self._async_loading_set[arg_50_1] = var_50_0

		return var_50_0
	end

	function arg_1_0:__remove_async_task(arg_51_1)
		self._async_loading_set[arg_51_1] = nil
	end

	function arg_1_0:__find_async_task(arg_52_1)
		return self._async_loading_set[arg_52_1]
	end

	function arg_1_0:__async_task_add_depend(arg_53_1, arg_53_2)
		arg_53_1.depend_num = arg_53_1.depend_num + 1
		self:__find_async_task(arg_53_2).who_depend_me[arg_53_1.name] = arg_53_1.name
	end

	function arg_1_0:__async_task_add_progress_depend(arg_54_1, arg_54_2)
		if arg_54_1 then
			self:__find_async_task(arg_54_2).progress.who_depend_me[arg_54_1.name] = arg_54_1.name

			if arg_54_1.depend_set[arg_54_2] == nil then
				arg_54_1.depend_set[arg_54_2] = false
				arg_54_1.total = arg_54_1.total + 1
			end
		end
	end

	function arg_1_0:__async_task_remove_depend(arg_55_1)
		arg_55_1.depend_num = arg_55_1.depend_num - 1

		if arg_55_1.depend_num < 0 then
			var_0_0(false)
		end

		self:__check_async_task_finish(arg_55_1)
	end

	function arg_1_0.__async_task_progress_remove_depend(arg_56_0, arg_56_1, arg_56_2)
		if arg_56_1.progress.depend_set[arg_56_2] ~= false then
			return
		end

		arg_56_1.progress.depend_set[arg_56_2] = true
		arg_56_1.progress.already_num = arg_56_1.progress.already_num + 1

		if arg_56_1.progress.progress_func then
			arg_56_1.progress.progress_func(arg_56_1.progress.total, arg_56_1.progress.already_num, arg_56_1.name, arg_56_2)
		end
	end

	function arg_1_0.__async_task_add_callback_func(arg_57_0, arg_57_1, arg_57_2)
		if not arg_57_2 then
			return
		end

		var_0_2(arg_57_1.callback_func_set, arg_57_2)
	end

	function arg_1_0:__stop_async_task(arg_58_1)
		local var_58_0 = self:__find_async_task(arg_58_1)

		if not var_58_0 or not var_58_0.co then
			return
		end

		if var_58_0.loading then
			error(var_0_1("now is loading [%s], can't stop.", arg_58_1))
		end

		var_0_12(var_58_0.co)

		var_58_0.co = nil
	end

	function arg_1_0:__async_task_loaded(arg_59_1, arg_59_2)
		local var_59_0 = self:__find_async_task(arg_59_1)

		if not var_59_0 then
			return
		end

		var_59_0.loading = false

		self:__stop_async_task(arg_59_1)

		if var_59_0.is_asset_bundle then
			self:__add_asset_bundle(arg_59_1, arg_59_2)
		else
			var_59_0.game_object = arg_59_2
		end

		for iter_59_0, iter_59_1 in pairs(var_59_0.progress.who_depend_me) do
			self:__async_task_progress_remove_depend(self:__find_async_task(iter_59_0), var_59_0.name)
		end

		for iter_59_2, iter_59_3 in pairs(var_59_0.who_depend_me) do
			self:__async_task_remove_depend((self:__find_async_task(iter_59_2)))
		end

		self:__check_async_task_finish(var_59_0)
	end

	function arg_1_0:__check_async_task_finish(arg_60_1)
		if arg_60_1.depend_num ~= 0 then
			return
		end

		if arg_60_1.is_asset_bundle and not self:__find_asset_bundle(arg_60_1.name) then
			return
		end

		self:__remove_async_task(arg_60_1.name)

		for iter_60_0, iter_60_1 in pairs(arg_60_1.callback_func_set) do
			iter_60_1(arg_60_1.game_object)
		end
	end

	function arg_1_0:destroy_instance()
		self:reset()
	end
end)

return function()
	local var_62_0 = lx.class("ResourceManager")

	var_62_0._asset_path_check_func = nil
	var_62_0._internal_check_func = nil
	var_62_0._asset_bundle_crc_offset_func = nil
	var_62_0._use_asset_bundle = true
	var_62_0._asset_dir_set = {}
	var_62_0._in_asset_prefix = nil
	var_62_0._asset_dependencies_name_set = {}

	if var_0_8.IsEditor() then
		var_62_0._use_asset_bundle = false
	end

	var_62_0._root_dir_set = {}
	var_62_0._root_dir_readonly = nil
	var_62_0._asset_set = {}
	var_62_0._asset_bundle_dep_set = {}
	var_62_0._asset_bundle_who_dep_me_set = {}
	var_62_0._asset_bundle_set = {}
	var_62_0._async_loading_set = {}

	return var_62_0
end
