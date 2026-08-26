-- chunkname: @modules/logic/pay/define/PayEnum.lua

module("modules.logic.pay.define.PayEnum", package.seeall)

local PayEnum = _M

PayEnum.PayResultCode = {
	PayCancel = 901,
	PayOrderCancel = 904,
	PayError = 903,
	PayInfoFail = 902,
	PayFinish = 200,
	PayChannelFail = 905
}
PayEnum.CurrencyCode = {
	DKK = "DKK",
	CNY = "CNY",
	GBP = "GBP",
	RUB = "RUB",
	HKD = "HKD",
	ILS = "ILS",
	AUD = "AUD",
	SEK = "SEK",
	BGN = "BGN",
	HUF = "HUF",
	TZS = "TZS",
	COP = "COP",
	NZD = "NZD",
	THB = "THB",
	TRY = "TRY",
	NOK = "NOK",
	KZT = "KZT",
	EGP = "EGP",
	BRL = "BRL",
	VND = "VND",
	MXN = "MXN",
	PKR = "PKR",
	CZK = "CZK",
	CLP = "CLP",
	KRW = "KRW",
	NGN = "NGN",
	TWD = "TWD",
	MYR = "MYR",
	JPY = "JPY",
	ZAR = "ZAR",
	CHF = "CHF",
	RON = "RON",
	SAR = "SAR",
	AED = "AED",
	QAR = "QAR",
	USD = "USD",
	INR = "INR",
	PHP = "PHP",
	SGD = "SGD",
	IDR = "IDR",
	EUR = "EUR",
	PEN = "PEN",
	CAD = "CAD",
	PLN = "PLN"
}
PayEnum.CurrencySymbol = {
	[PayEnum.CurrencyCode.USD] = "US$",
	[PayEnum.CurrencyCode.KRW] = "₩",
	[PayEnum.CurrencyCode.JPY] = "¥",
	[PayEnum.CurrencyCode.EUR] = "€",
	[PayEnum.CurrencyCode.CNY] = "¥"
}
PayEnum.NoDecimalsCurrency = {
	[PayEnum.CurrencyCode.JPY] = true,
	[PayEnum.CurrencyCode.HKD] = true,
	[PayEnum.CurrencyCode.TWD] = true,
	[PayEnum.CurrencyCode.KRW] = true,
	[PayEnum.CurrencyCode.CNY] = true
}

return PayEnum
