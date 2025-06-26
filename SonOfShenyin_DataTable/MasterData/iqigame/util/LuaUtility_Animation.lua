-- chunkname: @IQIGame\\Util\\LuaUtility_Animation.lua

function LuaUtility.GetAnimationCurveHorizontalValue(animationCurve)
	return LuaCodeInterface.GetAnimationCurveHorizontalValue(animationCurve)
end

function LuaUtility.PlayCriWareMovie(gameObject, endCallBack)
	LuaCodeInterface.PlayCriWareMovie(gameObject, endCallBack)
end

function LuaUtility.StopCriWareMovie(gameObject)
	LuaCodeInterface.StopCriWareMovie(gameObject)
end

function LuaUtility.PauseCriWareMovie(gameObject, onlyPause)
	LuaCodeInterface.PauseCriWareMovie(gameObject, onlyPause)
end

function LuaUtility.SetCriWarEndCallBack(gameObject, endCallBack)
	LuaCodeInterface.SetCriWarEndCallBack(gameObject, endCallBack)
end

function LuaUtility.RePlayAnimation(gameObject)
	local isSucceed = LuaCodeInterface.RePlayAnimation(gameObject)

	if not isSucceed then
		logError(string.format("%s 身上的Animation动画播放失败", gameObject.name))
	end

	return isSucceed
end

function LuaUtility.RePlayAnimationWithName(gameObject, name)
	local isSucceed = LuaCodeInterface.RePlayAnimationWithName(gameObject, name)

	if not isSucceed then
		logError(string.format("%s 身上的Animation动画 %s 播放失败", gameObject.name, name))
	end

	return isSucceed
end

function LuaUtility.GetAnimationLengthWithName(gameObject, name)
	return LuaCodeInterface.GetAnimationLengthWithName(gameObject, name)
end

function LuaUtility.CompleteAnimation(gameObject, name)
	LuaCodeInterface.CompleteAnimation(gameObject, name)
end

function LuaUtility.DoLocalMove(gameObject, endValue, duration, snapping, AnimationCurve)
	return LuaCodeInterface.DoLocalMove(gameObject, endValue, duration, snapping, AnimationCurve)
end

function LuaUtility.DoFadeWithText(gameObject, endValue, duration, AnimationCurve)
	return LuaCodeInterface.DoFadeWithText(gameObject, endValue, duration, AnimationCurve)
end

function LuaUtility.DoFadeWithCanvasGroup(gameObject, endValue, duration, AnimationCurve)
	return LuaCodeInterface.DoFadeWithCanvasGroup(gameObject, endValue, duration, AnimationCurve)
end

function LuaUtility.DoLocalMoveWithRect(rectTransform, endValue, duration, type, func)
	return LuaCodeInterface.DoLocalMoveWithRect(rectTransform, endValue, duration, type, func)
end

function LuaUtility.PlayTweenAnimation(gameObject, id)
	LuaCodeInterface.PlayTweenAnimation(gameObject, id)
end

function LuaUtility.SetRollingNumberValue(gameObject, to, isAnimate)
	LuaCodeInterface.SetRollingNumberValue(gameObject, to, isAnimate)
end

function LuaUtility.PlayAnimation(gameObject, name, onStartEvent, onCompleteEvent)
	LuaCodeInterface.PlayAnimation(gameObject, name, onStartEvent, onCompleteEvent)
end

function LuaUtility.PlayAnimationWithSpeed(gameObject, name, speed, onStartEvent, onCompleteEvent)
	LuaCodeInterface.PlayAnimationWithSpeed(gameObject, name, speed, onStartEvent, onCompleteEvent)
end

function LuaUtility.ReversePlayAnimation(gameObject, name, onStartEvent, onCompleteEvent)
	LuaCodeInterface.ReversePlayAnimation(gameObject, name, onStartEvent, onCompleteEvent)
end

function LuaUtility.AnimationStayInTime(gameObject, name, time)
	LuaCodeInterface.StayInTime(gameObject, name, time)
end

function LuaUtility.ClearAnimationEvent(gameObject, name)
	LuaCodeInterface.ClearAnimationEvent(gameObject, name)
end

function LuaUtility.DoTweenTo_Float(start, to, duration, setterFunction)
	LuaCodeInterface.DoTweenTo_Float(start, to, duration, setterFunction)
end
