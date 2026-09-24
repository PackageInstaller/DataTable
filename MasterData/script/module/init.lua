local var_0_0 = {}

local function var_0_1(arg_1_0, arg_1_1)
	for iter_1_0, iter_1_1 in pairs({}) do
		gamecore.register_enum(iter_1_1.name, arg_1_1(arg_1_0 .. "." .. iter_1_1.path))
	end

	for iter_1_2, iter_1_3 in pairs({}) do
		gamecore.register_class_extend(iter_1_3.name, arg_1_0 .. "." .. iter_1_3.path)
	end

	for iter_1_4, iter_1_5 in pairs({
		{
			path = "util.reusable_cell",
			name = "reusable_cell"
		}
	}) do
		gamecore.register_class_module(iter_1_5.name, arg_1_0 .. "." .. iter_1_5.path)
	end

	for iter_1_6, iter_1_7 in pairs({
		{
			path = "protocol.opcode",
			name = "opcode"
		},
		{
			path = "protocol.opcode_role_client",
			name = "opcode_role_client"
		},
		{
			path = "protocol.opcode_battle_client",
			name = "opcode_battle_client"
		},
		{
			path = "protocol.opcode_request_response",
			name = "opcode_request_response"
		},
		{
			path = "protocol.protobuf",
			name = "_protobuf"
		},
		{
			path = "util.toggle_group",
			name = "toggle_group"
		}
	}) do
		gamecore.register_class_module(iter_1_7.name, arg_1_0 .. "." .. iter_1_7.path)
	end

	for iter_1_8, iter_1_9 in pairs({
		{
			path = "platform.manager.AccountPlatform",
			name = "AccountPlatform"
		},
		{
			path = "prompt.prompt",
			name = "prompt"
		},
		{
			path = "network.NetworkManager",
			name = "NetworkManager"
		},
		{
			path = "profile.profile",
			name = "profile"
		},
		{
			path = "pay.manager.PayManager",
			name = "PayManager"
		}
	}) do
		gamecore.register_instance(iter_1_9.name, arg_1_0 .. "." .. iter_1_9.path)
	end
end

local function var_0_2(arg_2_0, arg_2_1)
	gamecore.UILoader:setPath(arg_2_0 .. ".prompt.ui.", "data/prefab/module/prompt/")
	gamecore.UILoader:initAll({
		"prompt"
	}, gamecore.register_class_module, false, {
		prompt = "data/prefab/module/prompt/"
	}, nil, {
		prompt = gameenum.common_type.ui_layer.cover
	})
	gamecore.UILoader:setPath(arg_2_0 .. ".profile.ui.", "data/prefab/module/profile/")
	gamecore.UILoader:initAll({
		"profile"
	}, gamecore.register_class_module, false, {
		profile = "data/prefab/module/profile/"
	}, nil, {
		profile = gameenum.common_type.ui_layer.cover
	})
end

local function var_0_3()
	local var_3_0, var_3_1 = lx.jsonfile_decode("config/protocol/protocols.json")

	if not var_3_0 then
		log.errorlog("load protocols.json failed.")

		return
	end

	for iter_3_0, iter_3_1 in pairs(var_3_0) do
		if iter_3_1.data then
			var_3_0[iter_3_0] = lx.base64_decode(iter_3_1.data)
		end
	end

	for iter_3_2, iter_3_3 in pairs(var_3_0) do
		gamecore.protobuf.register(iter_3_3)
	end

	gamecore.protocol:setOpcodeRoot(gamecore.opcode)
	gamecore.protocol:setVersion(gamecore.opcode_request_response.get_version())
	gamecore.protocol:registerProtocolModule(gamecore.protobuf, gamecore.opcode)
	gamecore.protocol:registerProtocolModule(gamecore.protobuf, gamecore.opcode_role_client)
	gamecore.protocol:registerProtocolModule(gamecore.protobuf, gamecore.opcode_battle_client)
end

function var_0_0.link(arg_4_0, arg_4_1)
	var_0_1(arg_4_0, arg_4_1)
end

function var_0_0.init(arg_5_0, arg_5_1)
	var_0_2(arg_5_0, arg_5_1)
	var_0_3()
	gamecore.AccountPlatform:init()

	if app:isPC() then
		if log.protocol_log == nil then
			local var_5_0 = filelog.create()

			var_5_0:set_directory_log(app:getSystem():getWritePath() .. "log/protocol")

			function log.protocol_log(arg_6_0)
				var_5_0:write_log(arg_6_0)
			end
		end

		gamecore.NetworkManager:setLogFunc(log.protocol_log)
		gamecore.NetworkManager:enableLog(app:isPC())
	end

	return true
end

return var_0_0
