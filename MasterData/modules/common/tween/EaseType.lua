-- chunkname: @modules/common/tween/EaseType.lua

module("modules.common.tween.EaseType", package.seeall)

local EaseType = _M

EaseType.Linear = 1
EaseType.InSine = 2
EaseType.OutSine = 3
EaseType.InOutSine = 4
EaseType.InQuad = 5
EaseType.OutQuad = 6
EaseType.InOutQuad = 7
EaseType.InCubic = 8
EaseType.OutCubic = 9
EaseType.InOutCubic = 10
EaseType.InQuart = 11
EaseType.OutQuart = 12
EaseType.InOutQuart = 13
EaseType.InQuint = 14
EaseType.OutQuint = 15
EaseType.InOutQuint = 16
EaseType.InExpo = 17
EaseType.OutExpo = 18
EaseType.InOutExpo = 19
EaseType.InCirc = 20
EaseType.OutCirc = 21
EaseType.InOutCirc = 22
EaseType.InElastic = 23
EaseType.OutElastic = 24
EaseType.InOutElastic = 25
EaseType.InBack = 26
EaseType.OutBack = 27
EaseType.InOutBack = 28
EaseType.InBounce = 29
EaseType.OutBounce = 30
EaseType.InOutBounce = 31
EaseType.Str2TypeDict = {
	linear = EaseType.Linear,
	insine = EaseType.InSine,
	outsine = EaseType.OutSine,
	inoutsine = EaseType.InOutSine,
	inquad = EaseType.InQuad,
	outquad = EaseType.OutQuad,
	inoutquad = EaseType.InOutQuad,
	incubic = EaseType.InCubic,
	outcubic = EaseType.OutCubic,
	inoutcubic = EaseType.InOutCubic,
	inquart = EaseType.InQuart,
	outquart = EaseType.OutQuart,
	inoutquart = EaseType.InOutQuart,
	inquint = EaseType.InQuint,
	outquint = EaseType.OutQuint,
	inoutquint = EaseType.InOutQuint,
	inexpo = EaseType.InExpo,
	outexpo = EaseType.OutExpo,
	inoutexpo = EaseType.InOutExpo,
	incirc = EaseType.InCirc,
	outcirc = EaseType.OutCirc,
	inoutcirc = EaseType.InOutCirc,
	inback = EaseType.InBack,
	outback = EaseType.OutBack,
	inoutback = EaseType.InOutBack,
	inelastic = EaseType.InElastic,
	outelastic = EaseType.OutElastic,
	inoutelastic = EaseType.InOutElastic,
	inbounce = EaseType.InBounce,
	outbounce = EaseType.OutBounce,
	inoutbounce = EaseType.InOutBounce
}

function EaseType.Str2Type(_type)
	if string.nilorempty(_type) then
		return EaseType.Linear
	end

	if type(_type) == "number" then
		return _type
	end

	_type = string.lower(_type)

	local typeEnum = EaseType.Str2TypeDict[_type]

	if typeEnum then
		return typeEnum
	end

	if string.find(_type, "ease") == 1 then
		_type = string.sub(_type, 5)
		typeEnum = EaseType.Str2TypeDict[_type]

		if EaseType.Str2TypeDict[_type] then
			return typeEnum
		end
	end

	return EaseType.Linear
end

return EaseType
