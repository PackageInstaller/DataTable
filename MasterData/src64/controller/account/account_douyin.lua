local var_0_0 = {}
local network = require("network.network")
local crypt = require("crypt")

var_0_0.accountInfo = {
	platform = "Douyin",
	channel = "douyin"
}
var_0_0.playerInfo = {}
var_0_0.serverInfo = {}
var_0_0.loginRequestingHandler = nil
var_0_0.switchAccountRequestingHandler = nil
var_0_0.playerFirstLogin = false

local function var_0_3(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	print("Global Login Callback: ", arg_1_0, arg_1_1, arg_1_2, arg_1_3)

	if arg_1_0 == 0 then
		if var_0_0.loginRequestingHandler then
			var_0_0.loginRequestingHandler(1, "", arg_1_1)
		end
	elseif var_0_0.loginRequestingHandler then
		var_0_0.loginRequestingHandler(2)
	end
end

local function var_0_4(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	var_0_0.accountInfo.uid = nil
	var_0_0.accountInfo.token = arg_2_1

	global_logout("feiyuswitchaccount")
end

local function var_0_5(arg_3_0)
	require("controller.l2utils"):performWithDelay(function()
		var_0_0.accountInfo.uid = nil

		global_logout("feiyulogoutaccount")
	end, 1)
end

function var_0_0.init(arg_5_0)
	DouyinManager:registerLoginHandler(var_0_3)
	DouyinManager:registerSwitchAccountHandler(var_0_4)
	DouyinManager:registerLogoutHandler(var_0_5)
end

function var_0_0:getPlatform()
	return self.accountInfo.platform
end

function var_0_0:getToken()
	return self.accountInfo.token
end

local function var_0_6(arg_8_0)
	return cc.Crypto:MD5(string.format("channel=%s&clientbranch=%s&clientbranch=%s&platform=%s&time=%s", arg_8_0.channel or "", arg_8_0.clientbranch or "", arg_8_0.clientversion, arg_8_0.platform, arg_8_0.time or ""), false, true)
end

local function var_0_7()
	local var_9_0 = {
		platform = DeviceManager.platform,
		channel = var_0_0:getChannel(),
		clientversion = config.version,
		clientbranch = config.clientbranch,
		time = tostring(os.time())
	}

	if cc.Native.getVersionCode then
		var_9_0.versioncode = cc.Native:getVersionCode()
	end

	var_9_0.sign = var_0_6(var_9_0)

	return json.encode(var_9_0)
end

local function var_0_8(arg_10_0, arg_10_1)
	local var_10_0 = DeviceManager.createHTTPRequest(function(arg_11_0)
		local var_11_0 = arg_11_0.request

		if arg_11_0.name ~= "completed" then
			return
		end

		if var_11_0:getResponseStatusCode() ~= 200 then
			if arg_10_1 then
				arg_10_1(0)
			end

			return
		end

		if arg_10_1 then
			arg_10_1(1, json.decode((var_11_0:getResponseString())))
		end
	end, arg_10_0, "POST")

	var_10_0:setTimeout(35)
	var_10_0:setPOSTData((var_0_7()))
	var_10_0:start()
end

function var_0_0:verifyChannelPlayerid(arg_12_1, arg_12_2, arg_12_3)
	var_0_8(string.format("%s?method=verify_v3&uid=%s&platform=%s&channel=%s&token=%s", config.loginurl, arg_12_1, self.accountInfo.platform, self.accountInfo.channel, arg_12_2), function(arg_13_0, arg_13_1)
		if arg_13_0 == 0 then
			if arg_12_3 then
				arg_12_3(0)
			end
		else
			local var_13_0 = arg_13_1.errcode

			if arg_13_1.errcode == -1 then
				if arg_12_3 then
					arg_12_3(0)
				end
			elseif var_13_0 == -2 then
				if not network:isConnected() then
					self:setServerInfo({
						id = arg_13_1.serverid,
						name = arg_13_1.servername,
						tag = arg_13_1.servertag
					})
				end

				if arg_12_3 then
					arg_12_3(2, string.urldecode(arg_13_1.msg))
				end
			elseif var_13_0 == -3 then
				local var_13_1 = cc.EventCustom:new("NEED_CLIENT_V3")

				var_13_1.downloadurl = string.urldecode(arg_13_1.downloadurl)

				cc.Director:getInstance():getEventDispatcher():dispatchEvent(var_13_1)

				if arg_12_3 then
					arg_12_3(0)
				end
			else
				self.accountInfo.uid = arg_13_1.uid
				self.accountInfo.unionid = arg_13_1.uid

				if arg_13_1.needharmony == 1 then
					global_open_harmony_world()
				end

				if network:isConnected() then
					if arg_13_1.serverid == self:getServerID() then
						if arg_12_3 then
							arg_12_3(1)
						end
					else
						self:setServerInfo({
							id = arg_13_1.serverid,
							name = arg_13_1.servername,
							tag = arg_13_1.servertag
						})
						network:closeOnLogout()

						if not network:connect(arg_13_1.ip, arg_13_1.port, arg_12_3) and arg_12_3 then
							arg_12_3(0)
						end
					end
				else
					self:setServerInfo({
						id = arg_13_1.serverid,
						name = arg_13_1.servername,
						tag = arg_13_1.servertag
					})

					if not network:connect(arg_13_1.ip, arg_13_1.port, arg_12_3) and arg_12_3 then
						arg_12_3(0)
					end
				end

				if umeng_setAlias then
					print("############################")
					print("SetAlias: ", arg_12_1)
					print("############################")
					umeng_setAlias(arg_12_1, "douyin", "PUSH_ALIAS_CALLBACK")
				end
			end
		end
	end)
end

function var_0_0:getPlayerData(arg_14_1, arg_14_2)
	network:rpc("get_user_account_data", {
		token = "",
		uid = arg_14_1,
		userchannel = self.accountInfo.channel,
		platform = DeviceManager.platform,
		channelid = self:getChannel(),
		device = DeviceManager.getDeviceID(),
		sdkver = config.version
	}, function(arg_15_0)
		print("getPlayerDataResult: ", dump(arg_15_0))

		if arg_15_0.result == 1 or arg_15_0.result == 3 then
			self.accountInfo.uid = arg_14_1
			self.accountInfo.userinfo = arg_15_0.userinfo

			if arg_15_0.new then
				self.playerFirstLogin = true
			end

			if arg_14_2 then
				arg_14_2(arg_15_0.result)
			end
		elseif arg_14_2 then
			arg_14_2(2)
		end
	end)
end

function var_0_0:setServerInfo(arg_16_1)
	self.serverInfo.id = arg_16_1.id
	self.serverInfo.name = arg_16_1.name
	self.serverInfo.tag = arg_16_1.tag
end

function var_0_0:getServerInfo()
	return self.serverInfo
end

function var_0_0:getServerID()
	return self.serverInfo.id
end

function var_0_0:getServerList(arg_19_1)
	var_0_8(string.format("%s?method=getlist&uid=%s", config.loginurl, self.accountInfo.uid), function(arg_20_0, arg_20_1)
		if arg_20_0 == 0 then
			if arg_19_1 then
				arg_19_1(0)
			end
		elseif arg_19_1 then
			arg_19_1(1, arg_20_1.all, arg_20_1.close)
		end
	end)
end

function var_0_0:selectServer(arg_21_1, arg_21_2)
	var_0_8(string.format("%s?method=select_server&uid=%s&serverid=%d", config.loginurl, self.accountInfo.uid, arg_21_1), function(arg_22_0, arg_22_1)
		if arg_22_0 == 0 then
			if arg_21_2 then
				arg_21_2(-1)
			end
		elseif arg_22_1.errorcode == -2 then
			if arg_21_2 then
				arg_21_2(2, string.urldecode(arg_22_1.msg))
			end
		else
			self:setServerInfo({
				id = arg_22_1.serverid,
				name = arg_22_1.servername,
				tag = arg_22_1.servertag
			})
			network:closeOnLogout()

			if not network:connect(arg_22_1.ip, arg_22_1.port, arg_21_2) and arg_21_2 then
				arg_21_2(0)
			end
		end
	end)
end

function var_0_0.playerLogin(arg_23_0, arg_23_1)
	arg_23_0.loginRequestingHandler = arg_23_1

	DouyinManager.login()
end

function var_0_0.switchaccount(arg_24_0, arg_24_1)
	arg_24_0.switchAccountRequestingHandler = arg_24_1

	DouyinManager.switchAccount()
end

function var_0_0.usercenterwithinfo(arg_25_0)
	return
end

local var_0_9

function var_0_0.getChannel(arg_26_0)
	var_0_9 = var_0_9 or DeviceManager.getChannelID()

	return var_0_9
end

function var_0_0:getPlayerShowInfo()
	return "ID", self.accountInfo.playerid
end

function var_0_0:login(arg_28_1, arg_28_2)
	assert(self.accountInfo.uid and self.accountInfo.channel)
	network:rpc("player_login", {
		ntguard = 0,
		token = string.format("%s@%s", crypt.base64encode(self.accountInfo.uid), crypt.base64encode(self.accountInfo.channel)),
		pos = arg_28_1,
		device = DeviceManager.getDeviceID(),
		platform = DeviceManager.platform,
		sdkver = config.version,
		channelid = self:getChannel(),
		packageversion = DeviceManager.getPackageAssetsVersion()
	}, function(arg_29_0)
		if arg_29_0.result == 1 then
			network:set_login_info(2, arg_29_0.playerid)
			network:connect_check_schedule()
			TrackingManager.login(arg_29_0.playerid)
			buglySetUserId(tostring(arg_29_0.playerid))
			self:onPlayerLogin(arg_29_0.playerid)

			self.accountInfo.userinfo.defaultid = arg_28_1

			if arg_28_2 then
				arg_28_2(1, arg_29_0.playerid)
			end
		elseif arg_29_0.result == 2 then
			if arg_28_2 then
				arg_28_2(2)
			end
		elseif arg_28_2 then
			arg_28_2(arg_29_0.result, arg_29_0.errmsg)
		end
	end)
end

function var_0_0:addAndLogin(arg_30_1, arg_30_2, arg_30_3)
	assert(self.accountInfo.uid and self.accountInfo.channel and arg_30_1)

	local var_30_0 = {
		uid = self.accountInfo.uid,
		channel = self.accountInfo.channel,
		pos = arg_30_1,
		name = arg_30_2,
		device = DeviceManager.getDeviceID(),
		platform = DeviceManager.platform,
		sdkver = config.version
	}

	var_30_0.ntguard = 0
	var_30_0.channelid = self:getChannel()
	var_30_0.packageversion = DeviceManager.getPackageAssetsVersion()

	network:rpc("user_add_player", var_30_0, function(arg_31_0)
		if arg_31_0.result == 1 then
			network:set_login_info(2, arg_31_0.playerid)
			network:connect_check_schedule()
			TrackingManager.login(arg_31_0.playerid)
			buglySetUserId(tostring(arg_31_0.playerid))

			self.accountInfo.userinfo.defaultid = arg_30_1
			self.accountInfo.userinfo["playerid" .. arg_30_1] = arg_31_0.playerid
			self.playerFirstLogin = true

			if arg_30_3 then
				arg_30_3(1, arg_31_0.playerid)
			end
		elseif arg_30_3 then
			arg_30_3(arg_31_0.result, arg_31_0.errmsg)
		end
	end)
end

function var_0_0:getUserPlayerInfo(arg_32_1, arg_32_2)
	local var_32_0 = self.accountInfo.userinfo

	assert(arg_32_1 > 0 and arg_32_1 < 13, arg_32_1)

	local var_32_1 = var_32_0["playerid" .. arg_32_1]

	assert(var_32_0["playerid" .. arg_32_1])

	if self.playerInfo[var_32_0["playerid" .. arg_32_1]] then
		if arg_32_2 then
			arg_32_2(1, self.playerInfo[var_32_0["playerid" .. arg_32_1]])
		end
	else
		network:rpc("get_user_player_info", {
			playerid = var_32_0["playerid" .. arg_32_1]
		}, function(arg_33_0)
			if arg_33_0.result == 1 then
				self.playerInfo[var_32_1] = arg_33_0.playerinfo

				if arg_32_2 then
					arg_32_2(arg_33_0.result, arg_33_0.playerinfo)
				end
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

function var_0_0:getUserPlayeridByPos(arg_36_1)
	if self.accountInfo.userinfo["playerid" .. arg_36_1] and self.accountInfo.userinfo["playerid" .. arg_36_1] ~= 0 then
		return self.accountInfo.userinfo["playerid" .. arg_36_1]
	else
		return nil
	end
end

function var_0_0:isUserPlayerInfoCached(arg_37_1)
	return self.playerInfo[arg_37_1] ~= nil
end

function var_0_0:getUserPlayerInfoByPlayerid(arg_38_1)
	return self.playerInfo[arg_38_1]
end

local var_0_10 = {
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

function var_0_0:canCreateNewPlayer(arg_39_1)
	if var_0_10[arg_39_1] <= 0 then
		return true
	end

	local var_39_0 = self.accountInfo.userinfo.playerid1

	if self.playerInfo[self.accountInfo.userinfo.playerid1] then
		return self.playerInfo[var_39_0].grade >= var_0_10[arg_39_1]
	else
		network:rpc("get_user_player_info", {
			playerid = var_39_0
		}, function(arg_40_0)
			if arg_40_0.result == 1 then
				self.playerInfo[var_39_0] = arg_40_0.playerinfo
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

function var_0_0:getUnionID()
	return self.accountInfo.unionid
end

function var_0_0:activate_user(arg_44_1, arg_44_2)
	if string.len(arg_44_1) == 0 then
		if arg_44_2 then
			arg_44_2(0)
		end

		return
	end

	network:rpc("activate_uid", {
		uid = self:getUserID(),
		key = arg_44_1
	}, function(arg_45_0)
		if arg_44_2 then
			arg_44_2(arg_45_0.result)
		end
	end)
end

function var_0_0:isPlayerFirstLogin()
	return self.playerFirstLogin
end

function var_0_0:collectPlayerInfoOnLogin(arg_47_1)
	local var_47_0 = self.playerInfo[arg_47_1] or {}
	local var_47_1 = (function(arg_48_0)
		local var_48_0, var_48_1, var_48_2 = arg_48_0:match("(%d+)-(%d+)-(%d+)")

		return var_48_0 .. "-" .. var_48_1
	end)(var_47_0.level or "1-1-1")
	local var_47_2 = 0

	for iter_47_0 = 1, 4 do
		if self.accountInfo.userinfo["playerid" .. iter_47_0] and self.accountInfo.userinfo["playerid" .. iter_47_0] > 0 then
			var_47_2 = var_47_2 + 1
		end
	end

	return {
		city = var_47_1,
		grade = var_47_0.grade,
		class = var_47_0.class,
		rolenum = var_47_0.rolenum,
		playernum = var_47_2
	}
end

function var_0_0.onFeiyuAccountLogin(arg_49_0)
	return
end

function var_0_0.onPlayerCreate(arg_50_0)
	return
end

function var_0_0.onPlayerLogin(arg_51_0, arg_51_1)
	return
end

function var_0_0.onPlayerUpdate(arg_52_0)
	return
end

function var_0_0.onEnterGame(arg_53_0)
	return
end

function var_0_0.createrole(arg_54_0, arg_54_1)
	return
end

function var_0_0.collectInfo(arg_55_0, arg_55_1)
	return
end

function var_0_0.isIntegrateNT(arg_56_0)
	return false
end

function var_0_0.getAntiAddictionInfo(arg_57_0)
	return nil
end

function var_0_0.antiAddiction(arg_58_0, arg_58_1)
	return
end

function var_0_0.antiAddictTimeout(arg_59_0)
	return
end

function var_0_0:getAccountPlayerCount()
	local var_60_0 = 6

	for iter_60_0 = 7, 12 do
		if self.accountInfo.userinfo["playerid" .. iter_60_0] and self.accountInfo.userinfo["playerid" .. iter_60_0] > 0 then
			var_60_0 = var_60_0 + 1
		end
	end

	return var_60_0
end

function var_0_0:getAccountPlayerRealCount()
	local var_61_0 = 0

	for iter_61_0 = 1, 12 do
		if self.accountInfo.userinfo["playerid" .. iter_61_0] and self.accountInfo.userinfo["playerid" .. iter_61_0] > 0 then
			var_61_0 = var_61_0 + 1
		end
	end

	return var_61_0
end

return var_0_0
