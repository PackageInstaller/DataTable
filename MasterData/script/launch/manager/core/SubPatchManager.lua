local var_0_0 = lx
local var_0_1 = assert
local var_0_2 = string.format
local var_0_3 = lx.UserData
local var_0_4 = lx.json_encode
local var_0_5 = lx.json_decode
local var_0_6 = gamecore.Language
local var_0_7 = gamecore.UILoader
local var_0_8 = gameenum.launch_common_type
local var_0_9 = gamecore.ResourceLoader
local var_0_10 = 335544320

lx.define_class("SubPatchManager", function(arg_1_0)
	function arg_1_0.downLoadSubPatch(arg_2_0, arg_2_1)
		var_0_1(arg_2_1 == "data2" or arg_2_1 == "cv_cn" or arg_2_1 == "cv_jp")

		local var_2_0 = var_0_7:createInstance("launch")
		local var_2_1 = var_0_7:createInstance("status")
		local var_2_2 = var_0_7:createInstance("launch_msgbox")
		local var_2_3 = var_0_7:getInstance("home")
		local var_2_4 = var_0_7:getInstance("main_menu")

		if var_2_3 then
			var_2_3:setVisible(false)
		end

		if var_2_4 then
			var_2_4:setVisible(false)
		end

		local var_2_5 = {}

		local function var_2_6()
			local var_3_0 = var_0_7:getInstance("launch") or var_0_7:createInstance("launch")

			var_3_0:setVisible(true)
			var_3_0:show(0.1, nil, true)
			var_2_1:newStatus(var_0_6:getNowLang((arg_2_1 == "data2" or nil) and "downloading_patch"))
			app:downloadSubPacket(var_2_5.func_list, {
				arg_2_1
			})
		end

		var_2_5.func_list = {
			on_check_version_failed = function(arg_4_0)
				var_2_2:showOne(var_0_6:getNowLang("errorofnetwork"), var_2_6, var_0_6:getNowLang("pveservererrortitle"))
			end,
			on_new_app_version = function(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5, arg_5_6)
				return
			end,
			on_ready_to_install_new_app = function(arg_6_0, arg_6_1, arg_6_2)
				return
			end,
			on_new_data_version = function(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
				local var_7_0 = arg_2_0:__make_size_string(arg_7_0)

				if arg_7_2 < arg_7_0 + var_0_10 then
					var_2_2:showOne(var_0_6:getNowLang("not_enough_storage") .. var_7_0, exit_self_process, var_0_6:get("settingquitgame"))
				else
					var_2_2:show(var_0_2(var_0_6:getNowLang("find_new_patch"), var_7_0), function()
						if not app:getSubPacketManager():getSubPacketVersion(arg_2_1) then
							app:getSubPacketManager():updateSubPacketVersion(arg_2_1, "0.0.0.0")
						end

						arg_7_3()

						if gamecore.NetworkManager and gamecore.NetworkManager.reset then
							gamecore.NetworkManager:reset()
						end
					end, exit_self_process)
				end
			end,
			on_update_to_version_begin = function(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
				var_2_0:showVersionInfo()
			end,
			on_update_progress_change = function(arg_10_0, arg_10_1, arg_10_2)
				var_2_1:onProgressChange(arg_10_2, (arg_2_0:__make_size_string(arg_10_0, arg_10_1)))
			end,
			on_update_finish = function()
				arg_2_0:setDownloadPatch(arg_2_1)

				if arg_2_1 == "cv_cn" or arg_2_1 == "cv_jp" then
					arg_2_0:setSelectCV(arg_2_1)
				end

				app:getSystem():updateDataVersion(app:getSystem():getDataVersion())
				gamecore.LaunchManager:reset()

				app._launching = true

				app:restart()
			end
		}

		var_2_6()
	end

	function arg_1_0:downloadDataHD()
		self:__set_data_hd_version()

		local var_12_0 = var_0_7:createInstance("status")
		local var_12_1 = {}
		local var_12_2 = var_0_7:getInstance("launch")
		local var_12_3 = var_0_7:createInstance("home")
		local var_12_4 = var_0_7:createInstance("main_menu")

		local function var_12_5()
			var_12_2 = var_12_2 or var_0_7:createInstance("launch")

			var_12_2:setVisible(true)
			var_12_2:show(0.1, nil, true)
			var_12_0:newStatus(var_0_6:getNowLang("downloading_patch"))
			app:downloadSubPacket(var_12_1.func_list, {
				"data_hd"
			})
		end

		var_12_1.func_list = {
			on_check_version_failed = function(arg_14_0)
				var_0_7:createInstance("launch_msgbox"):showOne(var_0_6:getNowLang("errorofnetwork"), var_12_5, var_0_6:getNowLang("pveservererrortitle"))
			end,
			on_new_app_version = function(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4, arg_15_5, arg_15_6)
				return
			end,
			on_ready_to_install_new_app = function(arg_16_0, arg_16_1, arg_16_2)
				return
			end,
			on_new_data_version = function(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
				local var_17_0 = self:__make_size_string(arg_17_0)
				local var_17_1 = var_0_7:createInstance("launch_msgbox")

				local function var_17_2()
					var_0_7:destroyInstance("launch")
					var_0_7:destroyInstance("status")
				end

				if arg_17_2 < arg_17_0 + var_0_10 then
					var_17_1:showOne(var_0_2(var_0_6:getNowLang("picture_hd_download_desc"), var_17_0), var_17_2, var_0_6:getNowLang("settingquitgame"))
				else
					var_17_1:show(var_0_2(var_0_6:getNowLang("picture_hd_download_desc"), var_17_0), function()
						arg_17_3()

						if gamecore.NetworkManager and gamecore.NetworkManager.reset then
							gamecore.NetworkManager:reset()
						end
					end, var_17_2)
				end
			end,
			on_update_to_version_begin = function(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
				var_0_7:createInstance("launch"):showVersionInfo()
				var_12_3:setVisible(false)
				var_12_4:setVisible(false)
			end,
			on_update_progress_change = function(arg_21_0, arg_21_1, arg_21_2)
				var_12_0:onProgressChange(arg_21_2, (self:__make_size_string(arg_21_0, arg_21_1)))
			end,
			on_update_finish = function()
				self:__update_data_hd_version()
				self:setSelectPictureDefinition("picture_hd")
				app:getSystem():updateDataVersion(app:getSystem():getDataVersion())
				gamecore.LaunchManager:reset()

				app._launching = true

				app:restart()
			end
		}

		var_12_5()
	end

	function arg_1_0:downloadDataHDEnterGame()
		self:__set_data_hd_version()

		local var_23_0 = var_0_7:createInstance("status")
		local var_23_1 = {}
		local var_23_2 = var_0_7:getInstance("launch")

		local function var_23_3()
			var_23_2 = var_23_2 or var_0_7:createInstance("launch")

			var_23_2:setVisible(true)
			var_23_2:show(0.1, nil, true)
			var_23_0:newStatus(var_0_6:getNowLang("downloading_patch"))
			app:downloadSubPacket(var_23_1.func_list, {
				"data_hd"
			})
		end

		var_23_1.func_list = {
			on_check_version_failed = function(arg_25_0)
				var_0_7:createInstance("launch_msgbox"):showOne(var_0_6:getNowLang("errorofnetwork"), var_23_3, var_0_6:getNowLang("pveservererrortitle"))
			end,
			on_new_app_version = function(arg_26_0, arg_26_1, arg_26_2, arg_26_3, arg_26_4, arg_26_5, arg_26_6)
				return
			end,
			on_ready_to_install_new_app = function(arg_27_0, arg_27_1, arg_27_2)
				return
			end,
			on_new_data_version = function(arg_28_0, arg_28_1, arg_28_2, arg_28_3)
				local var_28_0 = self:__make_size_string(arg_28_0)
				local var_28_1 = var_0_7:createInstance("launch_msgbox")

				local function var_28_2()
					var_0_7:destroyInstance("status")
					var_0_7:createInstance("enter_game"):show(false)
				end

				if arg_28_2 < arg_28_0 + var_0_10 then
					var_28_1:showOne(var_0_2(var_0_6:getNowLang("picture_hd_download_desc"), var_28_0), var_28_2, var_0_6:getNowLang("settingquitgame"))
				else
					var_28_1:show(var_0_2(var_0_6:getNowLang("picture_hd_download_desc"), var_28_0), function()
						arg_28_3()

						if gamecore.NetworkManager and gamecore.NetworkManager.reset then
							gamecore.NetworkManager:reset()
						end
					end, var_28_2)
				end
			end,
			on_update_to_version_begin = function(arg_31_0, arg_31_1, arg_31_2, arg_31_3)
				var_0_7:createInstance("launch"):showVersionInfo()
			end,
			on_update_progress_change = function(arg_32_0, arg_32_1, arg_32_2)
				var_23_0:onProgressChange(arg_32_2, (self:__make_size_string(arg_32_0, arg_32_1)))
			end,
			on_update_finish = function()
				self:__update_data_hd_version()
				self:setSelectPictureDefinition("picture_hd")
				app:getSystem():updateDataVersion(app:getSystem():getDataVersion())
				gamecore.LaunchManager:reset()

				app._launching = true

				app:restart()
			end
		}

		var_23_3()
	end

	function arg_1_0.removeDataHDFromSubPacket(arg_34_0)
		app:getSubPacketManager():updateSubPacketVersion("data_hd", nil)
	end

	function arg_1_0:isDataHDNeedUpdate()
		local var_35_0 = app:getNotice()

		if var_35_0.data_hd_version and var_35_0.data_hd_version == self:__get_data_hd_version() then
			return false
		end

		return true
	end

	function arg_1_0:isDataHDNeedUpdateEnterGame()
		local var_36_0 = app:getNotice()
		local var_36_1 = self:__get_data_hd_version()
		local var_36_2 = var_0_3:getKeyData("save_hd_version")

		if var_36_0.data_hd_version and var_36_0.data_hd_version == var_36_1 then
			return false
		elseif not var_36_1 then
			return false
		elseif var_36_0.data_hd_version ~= var_36_1 then
			if var_36_2 then
				if var_36_2 == var_36_1 then
					return false
				elseif var_36_2 == var_36_0.data_hd_version and var_36_2 ~= var_36_1 then
					return true
				end
			else
				return true
			end
		end

		return true
	end

	function arg_1_0.deleteDataHD(arg_37_0)
		var_0_3:setKeyData("save_hd_version", nil)
		directory.rmdir(app:getSystem():getWritePath() .. "data_hd")
		app:getSubPacketManager():updateSubPacketVersion("data_hd", "0.0.0.0")
	end

	function arg_1_0.deleteDataTwo(arg_38_0)
		directory.rmdir(app:getSystem():getWritePath() .. "data2")
		app:getSubPacketManager():updateSubPacketVersion("data2", "0.0.0.0")
	end

	function arg_1_0.deleteDataCv(arg_39_0)
		directory.rmdir(app:getSystem():getWritePath() .. "cv_cn")
		app:getSubPacketManager():updateSubPacketVersion("cv_cn", "0.0.0.0")
	end

	function arg_1_0.deleteDataCvJp(arg_40_0)
		directory.rmdir(app:getSystem():getWritePath() .. "cv_jp")
		app:getSubPacketManager():updateSubPacketVersion("cv_jp", "0.0.0.0")
	end

	function arg_1_0.deleteDataMain(arg_41_0)
		local var_41_0 = var_0_3:getKeyData("save_first_dataversion")

		var_0_3:setKeyData("save_main_data", (app:getSystem():getDataVersion()))
		var_0_3:setKeyData("use_delete_main", "yes")
		var_0_3:setKeyData("save_now_update_to_version", var_41_0)
		var_0_3:setKeyData("save_first_version", var_41_0)
		var_0_3:setKeyData("save_next_version", var_41_0)
		var_0_3:setKeyData("save_click_update", "one")
		directory.rmdir(app:getSystem():getWritePath() .. "data")
		app:getSystem():setDataVersion(var_41_0)

		local var_41_1 = io.open(app:getSystem():getWritePath() .. "check_version.txt", "wb")

		if var_41_1 then
			local var_41_2 = var_41_1:read("*all")

			var_41_1:write(var_41_0)
			var_41_1:close()
		end
	end

	function arg_1_0:addSubData()
		local var_42_0 = app:getSystem():getChannel()

		if var_42_0 == var_0_8.channel.iOS_jp or var_42_0 == var_0_8.channel.android_jp then
			self:setDownloadPatch("data2")
			var_0_9:addAssetDir("data_jp")
		else
			var_0_9:addAssetDir("data_cn")
		end

		if self:getIsDownloadPatch("data2") then
			var_0_9:addAssetDir("data2")
			self:setData2("data2")
		end

		gameenum.common_type:setIsOpenHd()
		var_0_9:addAssetDir("data")
		var_0_9:addAssetDir("data_extra")

		for iter_42_0, iter_42_1 in pairs((app:getSubPacketManager():getSubPacketVersionSet())) do
			if self:getIsDownloadPatch(iter_42_0) then
				var_0_9:addAssetDir(iter_42_0)
			end
		end

		if self:__get_data_hd_version() then
			var_0_9:addAssetDir("data_hd")
		end

		if self:__get_nf_version() then
			var_0_9:addAssetDir("nf")
		end
	end

	function arg_1_0.getIsDownloadPatch(arg_43_0, arg_43_1)
		var_0_1(arg_43_1 == "data2" or arg_43_1 == "cv_cn" or arg_43_1 == "cv_jp" or arg_43_1 == "data_hd" or arg_43_1 == "nf")

		if app:getSystem():getOSType() == "android" then
			local var_43_0 = app:getSystem()
			local var_43_1 = io.open(var_43_0:getWritePath() .. arg_43_1 .. "/" .. arg_43_1 .. ".unity3d")
			local var_43_2 = var_43_0 ~= nil

			if var_43_1 then
				var_43_1:close()
			end

			if not var_43_2 then
				var_0_3:setKeyData(arg_43_1, "")

				return false
			end
		end

		local var_43_3 = var_0_3:getKeyData(arg_43_1)

		if var_43_3 == "" then
			return false
		end

		return var_43_3 == arg_43_1
	end

	function arg_1_0.setDownloadPatch(arg_44_0, arg_44_1)
		var_0_1(arg_44_1 == "data2" or arg_44_1 == "cv_cn" or arg_44_1 == "cv_jp")
		var_0_3:setKeyData(arg_44_1, arg_44_1)
	end

	function arg_1_0.setSelectCV(arg_45_0, arg_45_1)
		var_0_1(arg_45_1 == "cv_cn" or arg_45_1 == "cv_jp")

		local var_45_0

		if arg_45_1 == "cv_cn" then
			var_45_0 = "chinesecv"
		end

		var_0_3:setKeyData("select_cv", (arg_45_1 == "cv_jp" or nil) and "japanesecv")
	end

	function arg_1_0.getSelectCV(arg_46_0)
		local var_46_0 = var_0_3:getKeyData("select_cv")

		if var_46_0 == "" then
			return false
		end

		return var_46_0
	end

	function arg_1_0.setSelectPictureDefinition(arg_47_0, arg_47_1)
		var_0_1(arg_47_1 == "picture_normal" or arg_47_1 == "picture_hd")

		local var_47_0

		if arg_47_1 == "picture_normal" then
			var_47_0 = "picture_normal"
		end

		var_0_3:setKeyData("select_picture_definition", (arg_47_1 == "picture_hd" or nil) and "picture_hd")
	end

	function arg_1_0.getSelectPictureDefinition(arg_48_0)
		local var_48_0 = var_0_3:getKeyData("select_picture_definition")

		if var_48_0 == "" then
			return false
		end

		return var_48_0
	end

	function arg_1_0:setData2(arg_49_1)
		if not self:getIsDownloadPatch(arg_49_1) then
			return
		end

		var_0_8:replace_ship_icon_by_data2(gameenum.common_type)
	end

	function arg_1_0:downloadDataNF()
		self:__set_nf_version()

		local var_50_0 = var_0_7:createInstance("status")
		local var_50_1 = {}
		local var_50_2 = var_0_7:getInstance("launch")
		local var_50_3 = var_0_7:createInstance("home")
		local var_50_4 = var_0_7:createInstance("main_menu")

		local function var_50_5()
			var_50_2 = var_50_2 or var_0_7:createInstance("launch")

			var_50_2:setVisible(true)
			var_50_2:show(0.1, nil, true)
			var_50_0:newStatus(var_0_6:getNowLang("downloading_patch"))
			app:downloadSubPacket(var_50_1.func_list, {
				"nf"
			})
		end

		var_50_1.func_list = {
			on_check_version_failed = function(arg_52_0)
				var_0_7:createInstance("launch_msgbox"):showOne(var_0_6:getNowLang("errorofnetwork"), var_50_5, var_0_6:getNowLang("pveservererrortitle"))
			end,
			on_new_app_version = function(arg_53_0, arg_53_1, arg_53_2, arg_53_3, arg_53_4, arg_53_5, arg_53_6)
				return
			end,
			on_ready_to_install_new_app = function(arg_54_0, arg_54_1, arg_54_2)
				return
			end,
			on_new_data_version = function(arg_55_0, arg_55_1, arg_55_2, arg_55_3)
				local var_55_0 = self:__make_size_string(arg_55_0)
				local var_55_1 = var_0_7:createInstance("launch_msgbox")

				local function var_55_2()
					var_0_7:destroyInstance("launch")
					var_0_7:destroyInstance("status")
				end

				if arg_55_2 < arg_55_0 + var_0_10 then
					var_55_1:showOne(var_0_2(var_0_6:getNowLang("picture_hd_download_desc"), var_55_0), var_55_2, var_0_6:getNowLang("settingquitgame"))
				else
					var_55_1:show(var_0_2(var_0_6:getNowLang("picture_hd_download_desc"), var_55_0), function()
						arg_55_3()

						if gamecore.NetworkManager and gamecore.NetworkManager.reset then
							gamecore.NetworkManager:reset()
						end
					end, var_55_2)
				end
			end,
			on_update_to_version_begin = function(arg_58_0, arg_58_1, arg_58_2, arg_58_3)
				var_0_7:createInstance("launch"):showVersionInfo()
				var_50_3:setVisible(false)
				var_50_4:setVisible(false)
			end,
			on_update_progress_change = function(arg_59_0, arg_59_1, arg_59_2)
				var_50_0:onProgressChange(arg_59_2, (self:__make_size_string(arg_59_0, arg_59_1)))
			end,
			on_update_finish = function()
				self:__update_nf_version()
				app:getSystem():updateDataVersion(app:getSystem():getDataVersion())
				gamecore.LaunchManager:reset()

				app._launching = true

				app:restart()
				gameenum.common_type:setIsCheckNf(true)
				var_0_3:setKeyData("nf_assets", 1)
			end
		}

		var_50_5()
	end

	function arg_1_0.removeDataNFFromSubPacket(arg_61_0)
		app:getSubPacketManager():updateSubPacketVersion("nf", nil)
	end

	function arg_1_0:isDataNFNeedUpdate()
		if var_0_3:getKeyData("nf_assets") == "1" and UnityEngine.Application.platform == UnityEngine.RuntimePlatform.WindowsEditor then
			return false
		end

		local var_62_0 = app:getNotice()

		if var_62_0.nf_version and var_62_0.nf_version == self:__get_nf_version() then
			return false
		end

		return true
	end

	function arg_1_0.deleteDataNF(arg_63_0)
		local var_63_0 = app:getSystem():getWritePath()

		directory.rmdir(var_63_0 .. "nf")
		app:getSubPacketManager():updateSubPacketVersion("nf", nil)
		io.open(var_63_0 .. "nf_version", "wb"):close()
	end

	function arg_1_0:copy_nfdb_to_writepath()
		if UnityEngine.Application.platform == UnityEngine.RuntimePlatform.WindowsEditor then
			return
		end

		local var_64_0 = "data_video/MatrixMasterData.mp4"
		local var_64_1 = app:getSystem():getWritePath() .. "MatrixMasterData.db"

		if self:copy_file(app:getSystem():getWritePath() .. "data_video/MatrixMasterData.mp4", var_64_1) then
			return
		end

		local var_64_2 = self:get_inner_data(var_64_0)

		if not var_64_2 then
			return
		end

		local var_64_3 = io.open(var_64_1, "wb")

		var_64_3:write(var_64_2)
		var_64_3:close()
	end

	function arg_1_0.copy_file(arg_65_0, arg_65_1, arg_65_2)
		local var_65_0 = io.open(arg_65_1, "rb")

		if not var_65_0 then
			return false
		end

		local var_65_1 = var_65_0:read("*a")

		var_65_0:close()

		local var_65_2 = io.open(arg_65_2, "wb")

		var_65_2:write(var_65_1)
		var_65_2:close()

		return true
	end

	function arg_1_0.get_inner_data(arg_66_0, arg_66_1)
		if app:getSystem():getOSType() ~= "android" then
			local var_66_0 = io.open(app:getSystem():getReadonlyPath() .. arg_66_1, "rb")

			if not var_66_0 then
				return nil
			end

			local var_66_1 = var_66_0:read("*a")

			var_66_0:close()

			return var_66_1
		else
			return zipfile.read_the_file(app:getSystem():getReadonlyPath(), "assets/" .. arg_66_1)
		end
	end

	function arg_1_0.__make_size_string(arg_67_0, arg_67_1, arg_67_2)
		local var_67_0
		local var_67_3

		if 1048576 < arg_67_1 then
			var_67_0 = 1048576
			var_67_3 = "%.2fMB"
		else
			var_67_0 = 1024
			var_67_3 = "%.2fKB"
		end

		local var_67_4 = arg_67_1 / var_67_0

		if arg_67_2 == nil then
			return var_0_2(var_67_3, var_67_4)
		end

		if var_67_4 < 0.01 then
			var_67_4 = 0.01
		end

		return var_0_2(var_67_3 .. "/" .. var_67_3, arg_67_2 / var_67_0, var_67_4)
	end

	function arg_1_0:__set_data_hd_version()
		app:getSubPacketManager():updateSubPacketVersion("data_hd", (self:__get_data_hd_version()))
	end

	function arg_1_0.__get_data_hd_version(arg_69_0)
		local var_69_0 = io.open(app:getSystem():getWritePath() .. "data_hd_version", "rb")
		local var_69_1

		if var_69_0 then
			local var_69_2 = var_0_5((var_69_0:read("*all")))

			if var_69_2 then
				var_69_1 = var_69_2.data_hd
			end

			var_69_0:close()
		end

		return var_69_1
	end

	function arg_1_0.__update_data_hd_version(arg_70_0)
		local var_70_0 = app:getSubPacketManager():getSubPacketVersionSet()

		if var_70_0.data_hd then
			var_0_3:setKeyData("save_hd_version", var_70_0.data_hd)

			local var_70_1 = io.open(app:getSystem():getWritePath() .. "data_hd_version", "wb")

			var_70_1:write(var_0_4({
				data_hd = var_70_0.data_hd
			}))
			var_70_1:close()
			app:getSubPacketManager():updateSubPacketVersion("data_hd", nil)
		end
	end

	function arg_1_0:__set_nf_version()
		app:getSubPacketManager():updateSubPacketVersion("nf", (self:__get_nf_version()))
	end

	function arg_1_0.__get_nf_version(arg_72_0)
		local var_72_0 = io.open(app:getSystem():getWritePath() .. "nf_version", "rb")
		local var_72_1

		if var_72_0 then
			var_72_1 = var_0_5((var_72_0:read("*all"))).nf

			var_72_0:close()
		end

		return var_72_1
	end

	function arg_1_0.__update_nf_version(arg_73_0)
		local var_73_0 = app:getSubPacketManager():getSubPacketVersionSet()

		if var_73_0.nf then
			local var_73_1 = io.open(app:getSystem():getWritePath() .. "nf_version", "wb")

			var_73_1:write(var_0_4({
				nf = var_73_0.nf
			}))
			var_73_1:close()
			app:getSubPacketManager():updateSubPacketVersion("nf", nil)
		end
	end
end)

return function()
	return (var_0_0.class("SubPatchManager"))
end
