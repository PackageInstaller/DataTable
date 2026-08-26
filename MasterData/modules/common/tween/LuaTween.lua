-- chunkname: @modules/common/tween/LuaTween.lua

module("modules.common.tween.LuaTween", package.seeall)

local LuaTween = _M

function LuaTween.getEaseFunc(easeType)
	local easeFunc = LuaTween.TweenFuncDict[easeType]

	if easeFunc then
		return easeFunc
	end

	return LuaTween.linear
end

function LuaTween.tween(t, b, c, d, easeType)
	local easeFunc = LuaTween.getEaseFunc(easeType)

	return easeFunc(t, b, c, d)
end

function LuaTween.linear(t, b, c, d)
	return c * t / d + b
end

function LuaTween.inSine(t, b, c, d)
	return -c * Mathf.Cos(t / d * (Mathf.PI / 2)) + c + b
end

function LuaTween.outSine(t, b, c, d)
	return c * Mathf.Sin(t / d * (Mathf.PI / 2)) + b
end

function LuaTween.inOutSine(t, b, c, d)
	return -c / 2 * (Mathf.Cos(Mathf.PI * t / d) - 1) + b
end

function LuaTween.inQuad(t, b, c, d)
	t = t / d

	return c * t * t + b
end

function LuaTween.outQuad(t, b, c, d)
	t = t / d

	return -c * t * (t - 2) + b
end

function LuaTween.inOutQuad(t, b, c, d)
	t = t / (d / 2)

	if t < 1 then
		return c / 2 * t * t + b
	end

	t = t - 1

	return -c / 2 * (t * (t - 2) - 1) + b
end

function LuaTween.inCubic(t, b, c, d)
	t = t / d

	return c * t * t * t + b
end

function LuaTween.outCubic(t, b, c, d)
	t = t / d - 1

	return c * (t * t * t + 1) + b
end

function LuaTween.inOutCubic(t, b, c, d)
	t = t / (d / 2)

	if t < 1 then
		return c / 2 * t * t * t + b
	end

	t = t - 2

	return c / 2 * (t * t * t + 2) + b
end

function LuaTween.inQuart(t, b, c, d)
	t = t / d

	return c * t * t * t * t + b
end

function LuaTween.outQuart(t, b, c, d)
	t = t / d - 1

	return -c * (t * t * t * t - 1) + b
end

function LuaTween.inOutQuart(t, b, c, d)
	t = t / (d / 2)

	if t < 1 then
		return c / 2 * t * t * t * t + b
	end

	t = t - 2

	return -c / 2 * (t * t * t * t - 2) + b
end

function LuaTween.inQuint(t, b, c, d)
	t = t / d

	return c * t * t * t * t * t + b
end

function LuaTween.outQuint(t, b, c, d)
	t = t / d - 1

	return c * (t * t * t * t * t + 1) + b
end

function LuaTween.inOutQuint(t, b, c, d)
	t = t / (d / 2)

	if t < 1 then
		return c / 2 * t * t * t * t * t + b
	end

	t = t - 2

	return c / 2 * (t * t * t * t * t + 2) + b
end

function LuaTween.inExpo(t, b, c, d)
	if t == 0 then
		return b
	else
		return c * Mathf.Pow(2, 10 * (t / d - 1)) + b
	end
end

function LuaTween.outExpo(t, b, c, d)
	if t == d then
		return b + c
	else
		return c * (-Mathf.Pow(2, -10 * t / d) + 1) + b
	end
end

function LuaTween.inOutExpo(t, b, c, d)
	if t == 0 then
		return b
	end

	if t == d then
		return b + c
	end

	t = t / (d / 2)

	if t < 1 then
		return c / 2 * Mathf.Pow(2, 10 * (t - 1)) + b
	end

	t = t - 1

	return c / 2 * (-Mathf.Pow(2, -10 * t) + 2) + b
end

function LuaTween.inCirc(t, b, c, d)
	t = t / d

	return -c * (Mathf.Sqrt(1 - t * t) - 1) + b
end

function LuaTween.outCirc(t, b, c, d)
	t = t / d - 1

	return c * Mathf.Sqrt(1 - t * t) + b
end

function LuaTween.inOutCirc(t, b, c, d)
	t = t / (d / 2)

	if t < 1 then
		return -c / 2 * (Mathf.Sqrt(1 - t * t) - 1) + b
	end

	t = t - 2

	return c / 2 * (Mathf.Sqrt(1 - t * t) + 1) + b
end

function LuaTween.inBack(t, b, c, d)
	local s = 1.70158

	t = t / d

	return c * t * t * ((s + 1) * t - s) + b
end

function LuaTween.outBack(t, b, c, d)
	local s = 1.70158

	t = t / d - 1

	return c * (t * t * ((s + 1) * t + s) + 1) + b
end

function LuaTween.inOutBack(t, b, c, d)
	local s = 1.70158

	t = t / (d / 2)
	s = s * 1.525

	if t < 1 then
		return c / 2 * (t * t * ((s + 1) * t - s)) + b
	end

	t = t - 2
	s = s * 1.525

	return c / 2 * (t * t * ((s + 1) * t + s) + 2) + b
end

function LuaTween.inElastic(t, b, c, d)
	if t == 0 then
		return b
	end

	t = t / d

	if t == 1 then
		return b + c
	end

	local p = d * 0.3
	local a = c
	local s = p / 4

	t = t - 1

	return -(a * Mathf.Pow(2, 10 * t) * Mathf.Sin((t * d - s) * (2 * Mathf.PI) / p)) + b
end

function LuaTween.outElastic(t, b, c, d)
	if t == 0 then
		return b
	end

	t = t / d

	if t == 1 then
		return b + c
	end

	local p = d * 0.3
	local a = c
	local s = p / 4

	return a * Mathf.Pow(2, -10 * t) * Mathf.Sin((t * d - s) * (2 * Mathf.PI) / p) + c + b
end

function LuaTween.inOutElastic(t, b, c, d)
	if t == 0 then
		return b
	end

	t = t / (d / 2)

	if t == 2 then
		return b + c
	end

	local p = d * 0.44999999999999996
	local a = c
	local s = p / 4

	if t < 1 then
		t = t - 1

		return -0.5 * (a * Mathf.Pow(2, 10 * t) * Mathf.Sin((t * d - s) * (2 * Mathf.PI) / p)) + b
	end

	t = t - 1

	return a * Mathf.Pow(2, -10 * t) * Mathf.Sin((t * d - s) * (2 * Mathf.PI) / p) * 0.5 + c + b
end

function LuaTween.inBounce(t, b, c, d)
	return c - LuaTween.outBounce(d - t, 0, c, d) + b
end

function LuaTween.outBounce(t, b, c, d)
	t = t / d

	if t < 0.36363636363636365 then
		return c * (7.5625 * t * t) + b
	end

	if t < 0.7272727272727273 then
		t = t - 0.5454545454545454

		return c * (7.5625 * t * t + 0.75) + b
	end

	if t < 0.9090909090909091 then
		t = t - 0.8181818181818182

		return c * (7.5625 * t * t + 0.9375) + b
	end

	t = t - 0.9545454545454546

	return c * (7.5625 * t * t + 0.984375) + b
end

function LuaTween.inOutBounce(t, b, c, d)
	if t < d / 2 then
		return LuaTween.inBounce(t * 2, 0, c, d) * 0.5 + b
	end

	return LuaTween.outBounce(t * 2 - d, 0, c, d) * 0.5 + c * 0.5 + b
end

LuaTween.TweenFuncDict = {
	[EaseType.Linear] = LuaTween.linear,
	[EaseType.InSine] = LuaTween.inSine,
	[EaseType.OutSine] = LuaTween.outSine,
	[EaseType.InOutSine] = LuaTween.inOutSine,
	[EaseType.InQuad] = LuaTween.inQuad,
	[EaseType.OutQuad] = LuaTween.outQuad,
	[EaseType.InOutQuad] = LuaTween.inOutQuad,
	[EaseType.InCubic] = LuaTween.inCubic,
	[EaseType.OutCubic] = LuaTween.outCubic,
	[EaseType.InOutCubic] = LuaTween.inOutCubic,
	[EaseType.InQuart] = LuaTween.inQuart,
	[EaseType.OutQuart] = LuaTween.outQuart,
	[EaseType.InOutQuart] = LuaTween.inOutQuart,
	[EaseType.InQuint] = LuaTween.inQuint,
	[EaseType.OutQuint] = LuaTween.outQuint,
	[EaseType.InOutQuint] = LuaTween.inOutQuint,
	[EaseType.InExpo] = LuaTween.inExpo,
	[EaseType.OutExpo] = LuaTween.outExpo,
	[EaseType.InOutExpo] = LuaTween.inOutExpo,
	[EaseType.InCirc] = LuaTween.inCirc,
	[EaseType.OutCirc] = LuaTween.outCirc,
	[EaseType.InOutCirc] = LuaTween.inOutCirc,
	[EaseType.InBack] = LuaTween.inBack,
	[EaseType.OutBack] = LuaTween.outBack,
	[EaseType.InOutBack] = LuaTween.inOutBack,
	[EaseType.InElastic] = LuaTween.inElastic,
	[EaseType.OutElastic] = LuaTween.outElastic,
	[EaseType.InOutElastic] = LuaTween.inOutElastic,
	[EaseType.InBounce] = LuaTween.inBounce,
	[EaseType.OutBounce] = LuaTween.outBounce,
	[EaseType.InOutBounce] = LuaTween.inOutBounce
}

return LuaTween
