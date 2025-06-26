-- chunkname: @IQIGame\\Module\\Login\\HttpRequestParam.lua

CommonData = {
	channelNo = "-1"
}

function CommonData.New()
	local o = Clone(CommonData)

	return o
end

LoginRequestParam = {
	time = 0
}

function LoginRequestParam.New()
	local o = Clone(LoginRequestParam)

	return o
end

LoginRequestData = {
	uName = "",
	pwd = ""
}

function LoginRequestData.New()
	local o = Clone(LoginRequestData)

	return o
end

RegisterData = {
	uName = "",
	name = "",
	email = "",
	idcard = "",
	code = "",
	pwd = ""
}

function RegisterData.New()
	local o = Clone(RegisterData)

	return o
end

NoticeData = {
	types = ""
}

function NoticeData.New()
	local o = Clone(NoticeData)

	return o
end

ServerParamData = {
	type = ""
}

function ServerParamData.New()
	local o = Clone(ServerParamData)

	return o
end

PaySignData = {
	app_id = "",
	product_id = "",
	role_id = "",
	product_name = "",
	third_party_trade_no = "",
	channel_id = "",
	shop_id = "",
	server_name = "",
	user_ip = "",
	role_name = "",
	money = "",
	currency_type = "",
	game_id = "",
	pid = 0,
	product_desc = "",
	areaId = "",
	extension = "",
	uid = "",
	notify_url = "",
	product_position = "",
	role_level = 0,
	sdkName = "",
	server_id = ""
}

function PaySignData.New()
	local o = Clone(PaySignData)

	return o
end

PayData = {
	roleLevel = 0,
	serverId = "",
	extension = "",
	payNotifyUrl = "",
	roleId = "",
	coinName = "",
	roleName = "",
	productName = "",
	productNum = 0,
	productId = "",
	merchantName = "",
	price = 0,
	serverName = "",
	vip = "",
	channel = "",
	productDesc = "",
	userIp = "",
	sign = "",
	orderId = "",
	appID = ""
}

function PayData.New()
	local o = Clone(PayData)

	return o
end

ReportModel = {
	roleProfTitleId = 0,
	roleProfId = 0,
	serverId = "",
	type = 0,
	roleId = "",
	rolePower = 0,
	roleName = "",
	roleProf = "",
	reportType = 0,
	roleScore = 0,
	roleCreateTime = 0,
	roleLevel = "",
	roleLevelUpTime = 0,
	chapter = "",
	serverName = "",
	vip = "",
	gangName = "",
	roleProfTitle = "",
	gangTitleId = 0,
	gangId = 0,
	roleSex = 0,
	gangTitle = "",
	coins = {},
	friends = {},
	ranks = {}
}

function ReportModel.New()
	local o = Clone(ReportModel)

	return o
end
