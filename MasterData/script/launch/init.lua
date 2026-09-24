local var_0_0 = {}
local var_0_1 = lx.json_decode
local var_0_2 = lx.UserData

local function var_0_3(arg_1_0, arg_1_1)
	for iter_1_0, iter_1_1 in pairs({
		{
			path = "enum.config_data",
			name = "config_data"
		},
		{
			path = "enum.error_code",
			name = "error_code"
		},
		{
			path = "enum.error_type",
			name = "error_type"
		},
		{
			path = "enum.common_type",
			name = "common_type"
		},
		{
			path = "enum.language_table",
			name = "language_table"
		},
		{
			path = "enum.sensitive_words",
			name = "sensitive_words"
		},
		{
			path = "enum.data_version",
			name = "data_version"
		},
		{
			path = "enum.replace_connect",
			name = "replace_connect"
		},
		{
			path = "manager.core.enum.launch_common_type",
			name = "launch_common_type"
		}
	}) do
		gamecore.register_enum(iter_1_1.name, arg_1_1(arg_1_0 .. "." .. iter_1_1.path))
	end

	for iter_1_2, iter_1_3 in pairs({}) do
		gamecore.register_class_extend(iter_1_3.name, arg_1_0 .. "." .. iter_1_3.path)
	end

	for iter_1_4, iter_1_5 in pairs({
		{
			path = "util_func.util_func",
			name = "util_func"
		}
	}) do
		gamecore.register_class_module(iter_1_5.name, arg_1_0 .. "." .. iter_1_5.path)
	end

	for iter_1_6, iter_1_7 in pairs({
		{
			path = "manager.play_spine_anim",
			name = "play_spine_anim"
		}
	}) do
		gamecore.register_class_module(iter_1_7.name, arg_1_0 .. "." .. iter_1_7.path)
	end

	for iter_1_8, iter_1_9 in pairs({
		{
			path = "manager.SceneManager",
			name = "SceneManager"
		},
		{
			path = "manager.AudioManager",
			name = "AudioManager"
		},
		{
			path = "manager.PreloadManager",
			name = "PreloadManager"
		},
		{
			path = "manager.UserDataManager",
			name = "UserDataManager"
		},
		{
			path = "manager.click_spine_mgr",
			name = "click_spine_mgr"
		},
		{
			path = "manager.emotion_spine_mgr",
			name = "emotion_spine_mgr"
		},
		{
			path = "manager.core.LaunchManager",
			name = "LaunchManager"
		},
		{
			path = "manager.core.SubPatchManager",
			name = "SubPatchManager"
		},
		{
			path = "manager.core.FullPatchManager",
			name = "FullPatchManager"
		},
		{
			path = "manager.core.AccountServiceManager",
			name = "AccountServiceManager"
		},
		{
			path = "manager.core.EncryptOffset",
			name = "EncryptOffset"
		},
		{
			path = "manager.core.AuditServerManager",
			name = "AuditServerManager"
		},
		{
			path = "manager.core.ErrorReport",
			name = "ErrorReport"
		},
		{
			path = "manager.NotificationMgr",
			name = "NotificationMgr"
		}
	}) do
		gamecore.register_instance(iter_1_9.name, arg_1_0 .. "." .. iter_1_9.path)
	end
end

function var_0_0.first(arg_2_0, arg_2_1)
	for iter_2_0, iter_2_1 in pairs({
		{
			path = "config_loader.config_loader",
			name = "config_loader"
		}
	}) do
		gamecore.register_class_module(iter_2_1.name, arg_2_0 .. "." .. iter_2_1.path)
	end

	for iter_2_2, iter_2_3 in pairs({
		{
			path = "manager.ResourceLoader",
			name = "ResourceLoader"
		}
	}) do
		gamecore.register_class_extend(iter_2_3.name, arg_2_0 .. "." .. iter_2_3.path)
	end

	for iter_2_4, iter_2_5 in pairs({
		{
			path = "manager.Language",
			name = "Language"
		},
		{
			path = "manager.UILoader",
			name = "UILoader"
		},
		{
			path = "manager.core.ResourceLoader",
			name = "ResourceLoader"
		}
	}) do
		gamecore.register_instance(iter_2_5.name, arg_2_0 .. "." .. iter_2_5.path)
	end

	return true
end

function var_0_0.init(arg_3_0, arg_3_1)
	var_0_3(arg_3_0, arg_3_1)

	if app:isPC() then
		if log.profile_log == nil then
			local var_3_0 = filelog.create()

			var_3_0:set_directory_log(app:getSystem():getWritePath() .. "log/profile_log")

			function log.profile_log(arg_4_0)
				var_3_0:write_log(arg_4_0)
			end
		end

		gamecore.UILoader:setProfileLogFunc(log.profile_log)
		gamecore.UILoader:enableProfile(true)
		gamecore.ResourceLoader:setProfileLogFunc(log.profile_log)
		gamecore.ResourceLoader:enableProfile(true)
	end

	gamecore.UILoader:checkInit()
	gamecore.ResourceLoader:checkInit()
	gamecore.ResourceLoader:setAssetPathCheckFunc(function(arg_5_0)
		if arg_5_0:find("%.[^%.]+$") then
			return true
		end

		return false
	end)
	gamecore.ResourceLoader:setInternalCheckFunc(function(arg_6_0)
		return arg_6_0:find("^internal/")
	end)
	gamecore.UILoader:setPath(arg_3_0 .. ".manager.core.ui.", "internal/ui/prefab/")
	gamecore.UILoader:initAll({
		"install",
		"install_msgbox",
		"useragreement_msgbox",
		"login_prompt"
	}, gamecore.register_class_module, false, {
		login_prompt = "internal/ui/prefab/install/",
		install = "internal/ui/prefab/install/",
		useragreement_msgbox = "internal/ui/prefab/install/",
		install_msgbox = "internal/ui/prefab/install/"
	}, {}, {
		login_prompt = gameenum.common_type.ui_layer.top
	})

	local var_3_1 = {
		"logo",
		"logo_channel",
		"launch",
		"status",
		"launch_msgbox"
	}

	gamecore.UILoader:setStateUISet("launch", var_3_1)
	gamecore.UILoader:setPath(arg_3_0 .. ".manager.core.ui.", "internal/ui/prefab/")
	gamecore.UILoader:initAll(var_3_1, gamecore.register_class_module, true, {
		logo = "internal/ui/prefab/launch/",
		status = "internal/ui/prefab/launch/",
		launch = "internal/ui/prefab/launch/",
		launch_msgbox = "internal/ui/prefab/launch/",
		logo_channel = "internal/ui/prefab/launch/"
	}, nil, {
		launch_msgbox = gameenum.common_type.ui_layer.top
	})

	local var_3_2 = {
		"cover"
	}

	gamecore.UILoader:setStateUISet("cover", var_3_2)
	gamecore.UILoader:setPath(arg_3_0 .. ".manager.core.ui.", "internal/ui/prefab/")
	gamecore.UILoader:initAll(var_3_2, gamecore.register_class_module, false, {
		cover = "internal/ui/prefab/install/"
	}, nil, {
		cover = gameenum.common_type.ui_layer.cover
	})

	local var_3_3 = app:getSystem():getChannel()
	local var_3_4 = {
		"login"
	}
	local var_3_5 = {}

	gamecore.UILoader:setPath(arg_3_0 .. ".manager.core.ui.", "internal/ui/prefab")
	gamecore.UILoader:initAll(var_3_4, gamecore.register_class_module, true, {
		login = "internal/ui/prefab/login/cn/"
	}, var_3_5)
	gamecore.UILoader:initUIExtend(arg_3_0 .. ".manager.core.ui.event.", var_3_4, var_3_5, gamecore.register_class_extend)

	if var_3_3 == gameenum.common_type.channel.android_jp or var_3_3 == gameenum.common_type.channel.iOS_jp then
		local var_3_6 = {
			"login"
		}
		local var_3_7 = {}

		gamecore.UILoader:setPath(arg_3_0 .. ".manager.core.ui.", "internal/ui/prefab/")
		gamecore.UILoader:initAll(var_3_6, gamecore.register_class_module, true, {
			login = "internal/ui/prefab/login/jp/"
		}, var_3_7)
		gamecore.UILoader:initUIExtend(arg_3_0 .. ".manager.core.ui.event.", var_3_6, var_3_7, gamecore.register_class_extend)
	end

	return true
end

function var_0_0.finish()
	gamecore.Language:loadLanguage()
	gamecore.AudioManager:init_volume()

	local var_7_1 = var_0_2:getKeyData("setting_framerate")

	if var_7_1 ~= "" then
		UnityEngine.Application.targetFrameRate = var_0_1(var_7_1).value
	end

	if var_0_2:getKeyData("setting_live2d") == "" then
		var_0_2:getKeyData("setting_live2d", lx.json_encode({
			value = true
		}))
	end

	if var_0_2:getKeyData("setting_spine") == "" then
		var_0_2:getKeyData("setting_spine", lx.json_encode({
			value = true
		}))
	end

	gamecore.LaunchManager:start(function()
		gamecore.ResourceLoader:setInAssetDirPrefix("Assets")
		gamecore.ResourceLoader:setAssetBundleCrcOffsetFunc(function(arg_9_0)
			return 0, gamecore.EncryptOffset:getOffset(arg_9_0)
		end)

		if not app:isPC() then
			gamecore.ResourceLoader:enableAssetBundle()
		end

		gamecore.UILoader:checkInit()
	end)

	return true
end

return var_0_0
