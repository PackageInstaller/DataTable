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

LoginRequestData = {}

function LoginRequestData.New()
	local o = Clone(LoginRequestData)

	return o
end

RegisterData = {}

function RegisterData.New()
	local o = Clone(RegisterData)

	return o
end

CreateRechargeOrderData = {}

function CreateRechargeOrderData.New()
	local o = Clone(CreateRechargeOrderData)

	return o
end
