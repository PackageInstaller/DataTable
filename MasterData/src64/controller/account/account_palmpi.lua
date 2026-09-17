local var_0_0 = {}
local network = require("network.network")
local crypt = require("crypt")
local package_loader = require("controller.package_loader")

var_0_0.accountInfo = {
	channel = "palmpiuser"
}
var_0_0.playerInfo = {}
var_0_0.serverInfo = {}
var_0_0.playerFirstLogin = false
var_0_0.playerNeedRealName = false
var_0_0.isAdult = true

local function var_0_4(arg_1_0)
	local var_1_0 = cc.UserDefault:getInstance():getStringForKey(arg_1_0, "")

	return string.len(var_1_0) > 0 and var_1_0 or nil
end

local function var_0_5(arg_2_0, arg_2_1)
	arg_2_1 = arg_2_1 or ""

	return cc.UserDefault:getInstance():setStringForKey(arg_2_0, arg_2_1)
end

function var_0_0.init(arg_3_0)
	var_0_0.accountInfo.userid = var_0_4("userid")
	var_0_0.accountInfo.password = var_0_4("password")
	var_0_0.accountInfo.phone = var_0_4("phone")
	var_0_0.accountInfo.email = var_0_4("email")
	var_0_0.accountInfo.uid = var_0_4("uid")
end

function var_0_0.getPlatform(arg_4_0)
	return "palmpi"
end

local function var_0_6(arg_5_0)
	return cc.Crypto:MD5(string.format("channel=%s&clientbranch=%s&clientbranch=%s&platform=%s&time=%s", arg_5_0.channel or "", arg_5_0.clientbranch or "", arg_5_0.clientversion, arg_5_0.platform, arg_5_0.time or ""), false, true)
end

local function var_0_7()
	local var_6_0 = {
		platform = DeviceManager.platform,
		channel = var_0_0:getChannel(),
		clientversion = config.version,
		clientbranch = config.clientbranch,
		time = tostring(os.time())
	}

	if cc.Native.getVersionCode then
		var_6_0.versioncode = cc.Native:getVersionCode()
	end

	var_6_0.sign = var_0_6(var_6_0)

	return json.encode(var_6_0)
end

local function var_0_8(arg_7_0, arg_7_1)
	local var_7_0 = DeviceManager.createHTTPRequest(function(arg_8_0)
		local var_8_0 = arg_8_0.request

		if arg_8_0.name ~= "completed" then
			return
		end

		if var_8_0:getResponseStatusCode() ~= 200 then
			if arg_7_1 then
				arg_7_1(0)
			end

			return
		end

		local var_8_1 = var_8_0:getResponseString()

		print(var_8_1)

		if arg_7_1 then
			arg_7_1(1, json.decode(var_8_1))
		end
	end, arg_7_0, "POST")

	var_7_0:setTimeout(35)
	var_7_0:setPOSTData((var_0_7()))
	var_7_0:start()
end

function var_0_0.verifyChannelPlayerid(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	var_0_8(string.format("%s?method=verify&uid=%s&platform=%s&channel=palmpiuser&token=%s", config.loginurl, arg_9_1, DeviceManager.platform, arg_9_2), function(arg_10_0, arg_10_1)
		if arg_10_0 == 0 then
			if arg_9_3 then
				arg_9_3(0)
			end
		else
			local var_10_0 = arg_10_1.errcode

			if arg_10_1.errcode == -1 then
				if arg_9_3 then
					arg_9_3(-1)
				end
			elseif var_10_0 == -2 then
				if arg_10_1.serverid ~= arg_9_0:getServerID() then
					package_loader.switch_server_data_package(arg_10_1.serverid)
				end

				arg_9_0:setServerInfo({
					id = arg_10_1.serverid,
					name = arg_10_1.servername,
					tag = arg_10_1.servertag
				})

				if arg_9_3 then
					arg_9_3(2, string.urldecode(arg_10_1.msg))
				end
			else
				if arg_10_1.needharmony == 1 then
					global_open_harmony_world()
				end

				if arg_10_1.serverid ~= arg_9_0:getServerID() then
					package_loader.switch_server_data_package(arg_10_1.serverid)
				end

				arg_9_0:setServerInfo({
					id = arg_10_1.serverid,
					name = arg_10_1.servername,
					tag = arg_10_1.servertag
				})

				if not network:connect(arg_10_1.ip, arg_10_1.port, arg_9_3) and arg_9_3 then
					arg_9_3(0)
				end
			end
		end
	end)
end

function var_0_0:getAccountInfo(arg_11_1)
	if (self.accountInfo.userid or self.accountInfo.phone) and self.accountInfo.password then
		if arg_11_1 then
			arg_11_1(1, self.accountInfo)
		end
	elseif self.accountInfo.uid then
		if arg_11_1 then
			arg_11_1(2, self.accountInfo)
		end
	elseif arg_11_1 then
		arg_11_1(3)
	end
end

function var_0_0:getPlayerShowInfo()
	if (self.accountInfo.userid or self.accountInfo.phone) and self.accountInfo.password then
		if self.accountInfo.phone then
			return "ID", self.accountInfo.phone
		else
			return "ID", self.accountInfo.userid
		end
	else
		return L_VISITOR, self.accountInfo.uid
	end
end

function var_0_0.getChannel(arg_13_0)
	return DeviceManager.getChannelID()
end

function var_0_0:setServerInfo(arg_14_1)
	self.serverInfo.id = arg_14_1.id
	self.serverInfo.name = arg_14_1.name
	self.serverInfo.tag = arg_14_1.tag
end

function var_0_0:getServerInfo()
	return self.serverInfo
end

function var_0_0:getServerID()
	return self.serverInfo.id
end

function var_0_0:getServerList(arg_17_1)
	var_0_8(string.format("%s?method=getlist&uid=%s", config.loginurl, self.accountInfo.uid), function(arg_18_0, arg_18_1)
		if arg_18_0 == 0 then
			if arg_17_1 then
				arg_17_1(0)
			end
		elseif arg_17_1 then
			arg_17_1(1, arg_18_1.all, arg_18_1.close)
		end
	end)
end

function var_0_0:selectServer(arg_19_1, arg_19_2)
	var_0_8(string.format("%s?method=select_server&uid=%s&serverid=%d", config.loginurl, self.accountInfo.uid, arg_19_1), function(arg_20_0, arg_20_1)
		if arg_20_0 == 0 then
			if arg_19_2 then
				arg_19_2(-1)
			end
		elseif arg_20_1.errorcode == -2 then
			if arg_19_2 then
				arg_19_2(2, string.urldecode(arg_20_1.msg))
			end
		else
			self:setServerInfo({
				id = arg_20_1.serverid,
				name = arg_20_1.servername,
				tag = arg_20_1.servertag
			})
			package_loader.switch_server_data_package(arg_20_1.serverid)
			network:closeOnLogout()

			if not network:connect(arg_20_1.ip, arg_20_1.port, arg_19_2) and arg_19_2 then
				arg_19_2(0)
			end
		end
	end)
end

function var_0_0:playerLogin(arg_21_1, arg_21_2, arg_21_3)
	if self.accountInfo.uid then
		if arg_21_1 then
			arg_21_1(1, self.accountInfo.uid)
		end
	else
		var_0_8(string.format("%s?method=createuid", config.loginurl), function(arg_22_0, arg_22_1)
			if arg_22_0 == 0 then
				if arg_21_1 then
					arg_21_1(0)
				end
			else
				self.accountInfo.uid = arg_22_1.uid

				var_0_5("uid", arg_22_1.uid)

				self.playerFirstLogin = true

				if arg_21_1 then
					arg_21_1(1, arg_22_1.uid)
				end
			end
		end)
	end
end

var_0_0.switchaccount = var_0_0.playerLogin

function var_0_0:getPlayerData(arg_23_1, arg_23_2)
	self:loginPalmpiGuest(arg_23_2)
end

function var_0_0:login(arg_24_1, arg_24_2)
	assert(self.accountInfo.uid and self.accountInfo.channel)
	network:rpc("player_login", {
		token = string.format("%s@%s", crypt.base64encode(self.accountInfo.uid), crypt.base64encode(self.accountInfo.channel)),
		pos = arg_24_1
	}, function(arg_25_0)
		if arg_25_0.result == 1 then
			network:set_login_info(2, arg_25_0.playerid)
			network:connect_check_schedule()

			self.accountInfo.userinfo.defaultid = arg_24_1

			if arg_24_2 then
				arg_24_2(1, arg_25_0.playerid)
			end
		elseif arg_25_0.result == 2 then
			if arg_24_2 then
				arg_24_2(2)
			end
		elseif arg_24_2 then
			arg_24_2(arg_25_0.result, arg_25_0.errmsg)
		end
	end)
end

function var_0_0:addAndLogin(arg_26_1, arg_26_2, arg_26_3)
	assert(self.accountInfo.uid and self.accountInfo.channel and arg_26_1)
	network:rpc("user_add_player", {
		uid = self.accountInfo.uid,
		channel = self.accountInfo.channel,
		pos = arg_26_1,
		name = arg_26_2
	}, function(arg_27_0)
		if arg_27_0.result == 1 then
			network:set_login_info(2, arg_27_0.playerid)
			network:connect_check_schedule()

			self.accountInfo.userinfo.defaultid = arg_26_1
			self.accountInfo.userinfo["playerid" .. arg_26_1] = arg_27_0.playerid

			if arg_26_3 then
				arg_26_3(1, arg_27_0.playerid)
			end
		else
			if arg_27_0.playerid then
				self.accountInfo.userinfo["playerid" .. arg_26_1] = arg_27_0.playerid
				self.playerInfo[arg_27_0.playerid] = {
					head = 9202101,
					class = 1,
					showgirl = "2100",
					grade = 1,
					rolenum = 1,
					level = "1-1-1",
					name = arg_26_2
				}
			end

			if arg_26_3 then
				arg_26_3(arg_27_0.result, arg_27_0.errmsg)
			end
		end
	end)
end

function var_0_0:getUserPlayerInfo(arg_28_1, arg_28_2)
	local var_28_0 = self.accountInfo.userinfo

	assert(arg_28_1 > 0 and arg_28_1 < 13, arg_28_1)

	local var_28_1 = var_28_0["playerid" .. arg_28_1]

	assert(var_28_0["playerid" .. arg_28_1])

	if self.playerInfo[var_28_0["playerid" .. arg_28_1]] then
		if arg_28_2 then
			arg_28_2(1, self.playerInfo[var_28_0["playerid" .. arg_28_1]])
		end
	else
		network:rpc("get_user_player_info", {
			playerid = var_28_0["playerid" .. arg_28_1]
		}, function(arg_29_0)
			if arg_29_0.result == 1 then
				self.playerInfo[var_28_1] = arg_29_0.playerinfo

				if arg_28_2 then
					arg_28_2(arg_29_0.result, arg_29_0.playerinfo)
				end
			elseif arg_28_2 then
				arg_28_2(arg_29_0.result)
			end
		end)
	end
end

function var_0_0:getUserPlayerid()
	if not self.accountInfo.userinfo then
		return nil
	end

	return self.accountInfo.userinfo["playerid" .. self.accountInfo.userinfo.defaultid]
end

function var_0_0:getUserPlayerIndex()
	return self.accountInfo.userinfo.defaultid
end

function var_0_0:getUserPlayeridByPos(arg_32_1)
	if self.accountInfo.userinfo["playerid" .. arg_32_1] and self.accountInfo.userinfo["playerid" .. arg_32_1] ~= 0 then
		return self.accountInfo.userinfo["playerid" .. arg_32_1]
	else
		return nil
	end
end

function var_0_0:isUserPlayerInfoCached(arg_33_1)
	return self.playerInfo[arg_33_1] ~= nil
end

function var_0_0:getUserPlayerInfoByPlayerid(arg_34_1)
	return self.playerInfo[arg_34_1]
end

local var_0_9 = {
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0
}

function var_0_0:canCreateNewPlayer(arg_35_1)
	if var_0_9[arg_35_1] <= 0 then
		return true
	end

	local var_35_0 = self.accountInfo.userinfo.playerid1

	if self.playerInfo[self.accountInfo.userinfo.playerid1] then
		return self.playerInfo[var_35_0].grade >= var_0_9[arg_35_1]
	else
		network:rpc("get_user_player_info", {
			playerid = var_35_0
		}, function(arg_36_0)
			if arg_36_0.result == 1 then
				self.playerInfo[var_35_0] = arg_36_0.playerinfo
			end
		end)

		return false
	end
end

function var_0_0:updatePlayerInfoOnLogOut()
	local playermodel = require("model.playermodel")

	self.playerInfo[playermodel.playerid] = {
		name = playermodel.nickname,
		class = playermodel.class,
		grade = playermodel.grade,
		level = playermodel.curMode .. "-" .. playermodel.curLevel,
		head = playermodel.head_sculpture,
		showgirl = playermodel.showgirl,
		rolenum = playermodel:getOwnedServantNum()
	}
end

function var_0_0:getUserID()
	return self.accountInfo.uid
end

function var_0_0:activate_user(arg_39_1, arg_39_2)
	if string.len(arg_39_1) == 0 then
		if arg_39_2 then
			arg_39_2(0)
		end

		return
	end

	network:rpc("activate_uid", {
		uid = self:getUserID(),
		key = arg_39_1
	}, function(arg_40_0)
		if arg_39_2 then
			arg_39_2(arg_40_0.result)
		end
	end)
end

function var_0_0:isPlayerFirstLogin()
	return self.playerFirstLogin
end

function var_0_0:collectPlayerInfoOnLogin(arg_42_1)
	local var_42_0 = self.playerInfo[arg_42_1] or {}
	local var_42_1 = (function(arg_43_0)
		local var_43_0, var_43_1, var_43_2 = arg_43_0:match("(%d+)-(%d+)-(%d+)")

		return var_43_0 .. "-" .. var_43_1
	end)(var_42_0.level or "1-1-1")
	local var_42_2 = 0

	for iter_42_0 = 1, 4 do
		if self.accountInfo.userinfo["playerid" .. iter_42_0] and self.accountInfo.userinfo["playerid" .. iter_42_0] > 0 then
			var_42_2 = var_42_2 + 1
		end
	end

	return {
		city = var_42_1,
		grade = var_42_0.grade,
		class = var_42_0.class,
		rolenum = var_42_0.rolenum,
		playernum = var_42_2
	}
end

function var_0_0.registerPalmpiGuest(arg_44_0, arg_44_1)
	network:rpc("register_palmpi_guest", {
		needactivate = config.needactivate
	}, function(arg_45_0)
		if arg_45_0.result == 1 or arg_45_0.result == 3 then
			arg_44_0.accountInfo.uid = arg_45_0.uid
			arg_44_0.accountInfo.userinfo = arg_45_0.userinfo

			var_0_5("uid", arg_45_0.uid)

			arg_44_0.playerFirstLogin = true

			if arg_44_1 then
				arg_44_1(arg_45_0.result)
			end
		elseif arg_44_1 then
			arg_44_1(-1)
		end
	end)
end

function var_0_0:registerPalmpiAccount(arg_46_1, arg_46_2, arg_46_3)
	assert(arg_46_1 and string.len(arg_46_1) > 0)
	assert(arg_46_2 and string.len(arg_46_2) > 0)

	arg_46_2 = cc.Crypto:MD5(arg_46_2, false, false)

	network:rpc("register_palmpi_account", {
		token = string.format("%s@%s:%s", crypt.base64encode(arg_46_1), crypt.base64encode(arg_46_2), crypt.base64encode((self.accountInfo.userid or self.accountInfo.phone) and self.accountInfo.password and "-1" or self.accountInfo.uid or "-1")),
		needactivate = config.needactivate
	}, function(arg_47_0)
		if arg_47_0.result == 1 or arg_47_0.result == 3 then
			self.accountInfo.userid = arg_46_1

			var_0_5("userid", arg_46_1)

			self.accountInfo.password = arg_46_2

			var_0_5("password", arg_46_2)

			self.accountInfo.uid = arg_47_0.uid

			var_0_5("uid", "")

			self.accountInfo.userinfo = arg_47_0.userinfo

			if arg_46_3 then
				arg_46_3(arg_47_0.result)
			end
		elseif arg_46_3 then
			arg_46_3(arg_47_0.result)
		end
	end)
end

function var_0_0:loginPalmpiGuest(arg_48_1)
	assert(self.accountInfo.uid)
	network:rpc("get_user_account_data", {
		token = "",
		uid = self.accountInfo.uid,
		userchannel = self.accountInfo.channel,
		platform = DeviceManager.platform,
		channelid = self:getChannel(),
		device = DeviceManager.getDeviceID(),
		sdkver = config.version
	}, function(arg_49_0)
		self.accountInfo.userinfo = arg_49_0.userinfo

		if arg_48_1 then
			arg_48_1(arg_49_0.result)
		end
	end)
end

function var_0_0:loginPalmpiAccount(arg_50_1, arg_50_2, arg_50_3)
	arg_50_1 = arg_50_1 or self.accountInfo.userid
	arg_50_2 = arg_50_2 and cc.Crypto:MD5(arg_50_2, false, false) or self.accountInfo.password

	assert(arg_50_1 and arg_50_2)
	network:rpc("login_palmpi_account", {
		token = string.format("%s@%s", crypt.base64encode(arg_50_1), crypt.base64encode(arg_50_2)),
		needactivate = config.needactivate
	}, function(arg_51_0)
		if arg_51_0.result == 1 or arg_51_0.result == 3 then
			self.accountInfo.userid = arg_51_0.userid

			var_0_5("userid", arg_51_0.userid)

			self.accountInfo.password = arg_50_2

			var_0_5("password", arg_50_2)

			self.accountInfo.phone = arg_51_0.phone

			var_0_5("phone", arg_51_0.phone)

			self.accountInfo.uid = arg_51_0.uid

			var_0_5("uid", "")

			self.accountInfo.userinfo = arg_51_0.userinfo

			if arg_50_3 then
				arg_50_3(arg_51_0.result)
			end
		elseif arg_50_3 then
			arg_50_3(arg_51_0.result)
		end
	end)
end

function var_0_0:tryToLoginPalmpiGuest(arg_52_1)
	if self.accountInfo.uid then
		self:loginPalmpiGuest(arg_52_1)
	else
		self:registerPalmpiGuest(arg_52_1)
	end
end

function var_0_0:getPalmpiAccount()
	return self.accountInfo.userid or self.accountInfo.uid or ""
end

function var_0_0:getPalmpiUserID()
	return self.accountInfo.userid or ""
end

function var_0_0:getPalmpiPassword()
	return self.accountInfo.password or ""
end

function var_0_0.accountBind(arg_56_0, arg_56_1, arg_56_2)
	if var_0_0.accountInfo.registerstatus == 0 then
		global_ShowBlockWords(L_ACCOUNTMGR_BIND_RETURN[3])

		if arg_56_2 then
			arg_56_2(3)
		end

		return
	end

	if not var_0_0.accountInfo.playername or string.len(var_0_0.accountInfo.playername) == 0 then
		global_ShowBlockWords(L_ACCOUNTMGR_BIND_RETURN[2])

		if arg_56_2 then
			arg_56_2(2)
		end

		return
	end

	if not var_0_0.accountInfo.userid or checkint(crypt.base64decode(var_0_0.accountInfo.userid)) < 0 then
		global_ShowBlockWords(L_ACCOUNTMGR_BIND_RETURN[6])

		if arg_56_2 then
			arg_56_2(6)
		end

		return
	end

	local var_56_0 = arg_56_1.phone

	network:rpc("verify_smscode", {
		verifytype = 1,
		phone = arg_56_1.phone,
		verifycode = arg_56_1.verifycode,
		token = string.format("%s@%s", var_0_0.accountInfo.playername, var_0_0.accountInfo.password)
	}, function(arg_57_0)
		if arg_57_0.result == 1 then
			global_ShowBlockWords(L_ACCOUNTMGR_BIND_RETURN[1] .. var_56_0)

			if arg_56_2 then
				arg_56_2(1, var_0_0.accountInfo)
			end
		elseif arg_57_0.result == 2 then
			global_ShowBlockWords(L_ACCOUNTMGR_BIND_RETURN[2])

			if arg_56_2 then
				arg_56_2(2)
			end
		elseif arg_57_0.result == 4 then
			global_ShowBlockWords(L_ACCOUNTMGR_BIND_RETURN[4])

			if arg_56_2 then
				arg_56_2(4)
			end
		elseif arg_57_0.result == 5 then
			global_ShowBlockWords(L_ACCOUNTMGR_BIND_RETURN[5])

			if arg_56_2 then
				arg_56_2(5)
			end
		elseif arg_56_2 then
			arg_56_2(0)
		end
	end)
end

function var_0_0.getVerifyCode(arg_58_0, arg_58_1, arg_58_2, arg_58_3)
	if not arg_58_1 then
		if arg_58_3 then
			arg_58_3(2)
		end

		return
	end

	if string.len(arg_58_1) ~= 11 then
		if arg_58_3 then
			arg_58_3(2)
		end

		return
	end

	if not string.find(arg_58_1, "^1([3|4|5|6|7|8|9])([0-9])(%d+)$") then
		if arg_58_3 then
			arg_58_3(2)
		end

		return
	end

	if arg_58_2 == 1 or arg_58_2 == 3 then
		cc.Smssdk.getCode(0, arg_58_1, "86")

		if arg_58_3 then
			arg_58_3(1)
		end
	elseif arg_58_2 == 2 then
		network:rpc("check_phone_number", {
			phone = arg_58_1
		}, function(arg_59_0)
			if arg_59_0.result == 1 then
				cc.Smssdk.getCode(0, arg_58_1, "86")

				if arg_58_3 then
					arg_58_3(1)
				end
			elseif arg_59_0.result == 2 then
				global_riseWord(L_ACCOUNTMGR_PHONE_RETURN[2])

				if arg_58_3 then
					arg_58_3(2)
				end
			elseif arg_59_0.result == 3 then
				global_riseWord(L_ACCOUNTMGR_PHONE_RETURN[3])

				if arg_58_3 then
					arg_58_3(3)
				end
			elseif arg_58_3 then
				arg_58_3(0)
			end
		end)
	end
end

function var_0_0.findbackPassword(arg_60_0, arg_60_1, arg_60_2)
	local var_60_0 = arg_60_1.phone

	network:rpc("verify_smscode", {
		verifytype = 2,
		phone = arg_60_1.phone,
		verifycode = arg_60_1.verifycode,
		password = arg_60_1.password
	}, function(arg_61_0)
		if arg_61_0.result == 1 then
			local var_61_0, var_61_1, var_61_2 = arg_61_0.token:match("([^@]+)@([^:]+):(.+)")

			var_0_0.accountInfo.playername = var_61_0

			save_to_record("playername", var_61_0)

			var_0_0.accountInfo.password = var_61_1

			save_to_record("password", var_61_1)

			var_0_0.accountInfo.userid = var_61_2

			save_to_record("userid", crypt.base64encode("-1"))

			var_0_0.accountInfo.registerstatus = 1

			save_to_record("registerstatus", crypt.base64encode("1"))

			var_0_0.accountInfo.phone = crypt.base64encode(var_60_0)

			save_to_record("phone", var_0_0.accountInfo.phone)

			var_0_0.currenttype = LOGINTYPE_PLAYER

			global_ShowBlockWords(L_ACCOUNTMGR_PASSWD_RETURN[1])

			if arg_60_2 then
				arg_60_2(1, var_0_0.accountInfo)
			end
		elseif arg_61_0.result == 2 then
			global_ShowBlockWords(L_ACCOUNTMGR_PASSWD_RETURN[2])

			if arg_60_2 then
				arg_60_2(2)
			end
		else
			global_ShowBlockWords(L_ACCOUNTMGR_PASSWD_RETURN[0])

			if arg_60_2 then
				arg_60_2(0)
			end
		end
	end)
end

function var_0_0:getAntiAddictionInfo()
	return {
		countdown = 5470,
		needantiaddiction = not self.isAdult
	}
end

function var_0_0:checkAntiAddiction(arg_63_1)
	if self.isAdult then
		if arg_63_1 then
			arg_63_1()
		end

		return
	end

	if arg_63_1 then
		self:checkAntiAddictionWithCallback(arg_63_1)
	else
		self:checkAntiAddictionFromServer()
	end
end

function var_0_0:checkAntiAddictionWithCallback(arg_64_1)
	network:rpc("check_antiaddiction", {
		needantiaddiction = not self.isAdult
	}, function(arg_65_0)
		if arg_65_0.result == 1 then
			cc.Director:getInstance():getEventDispatcher():dispatchEvent((cc.EventCustom:new("NEEDANTIADDICTION")))
		else
			arg_64_1()
		end
	end)
end

function var_0_0:checkAntiAddictionFromServer()
	local var_66_0 = not self.isAdult

	network:rpc("check_antiaddiction", {
		needantiaddiction = not self.isAdult
	}, function(arg_67_0)
		if arg_67_0.result == 1 then
			cc.Director:getInstance():getEventDispatcher():dispatchEvent((cc.EventCustom:new("NEEDANTIADDICTION")))
		elseif var_66_0 then
			self:startCheckAntiAddictionScheduler()
		else
			self:stopCheckAntiAddictionScheduler()
		end
	end)
end

var_0_0._antiaddictionScheduler = nil

function var_0_0:startCheckAntiAddictionScheduler()
	if self._antiaddictionScheduler then
		return
	end

	self._antiaddictionScheduler = cc.Director:getInstance():getScheduler():scheduleScriptFunc(function()
		self:checkAntiAddictionFromServer()
	end, 10, false)
end

function var_0_0:stopCheckAntiAddictionScheduler()
	if not self._antiaddictionScheduler then
		return
	end

	cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self._antiaddictionScheduler)
end

function var_0_0.antiAddiction(arg_71_0)
	return
end

function var_0_0.antiAddictTimeout(arg_72_0)
	return
end

function var_0_0:getAccountPlayerCount()
	local var_73_0 = 6

	for iter_73_0 = 7, 12 do
		if self.accountInfo.userinfo["playerid" .. iter_73_0] and self.accountInfo.userinfo["playerid" .. iter_73_0] > 0 then
			var_73_0 = var_73_0 + 1
		end
	end

	return var_73_0
end

function var_0_0:getAccountPlayerRealCount()
	local var_74_0 = 0

	for iter_74_0 = 1, 12 do
		if self.accountInfo.userinfo["playerid" .. iter_74_0] and self.accountInfo.userinfo["playerid" .. iter_74_0] > 0 then
			var_74_0 = var_74_0 + 1
		end
	end

	return var_74_0
end

return var_0_0
