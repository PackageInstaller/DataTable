-- chunkname: @IQIGame\\Util\\LuaUtility_Spine.lua

function LuaUtility.SetSkeletonGraphicAnimationWithGameObject(gameObject, trackIndex, animationName, isLoop)
	LuaCodeInterface.SetSkeletonGraphicAnimationWithGameObject(gameObject, trackIndex, animationName, isLoop)
end

function LuaUtility.AddSkeletonGraphicAnimationWithGameObject(gameObject, trackIndex, animationName, isLoop)
	LuaCodeInterface.AddSkeletonGraphicAnimationWithGameObject(gameObject, trackIndex, animationName, isLoop)
end

function LuaUtility.GetGraphicSpineAnimationDataWithGameObject(gameObject, animationName)
	return LuaCodeInterface.GetGraphicSpineAnimationDataWithGameObject(gameObject, animationName)
end

function LuaUtility.AddGraphicSpineAnimationCompleteEvent(gameObject, func)
	LuaCodeInterface.AddGraphicSpineAnimationCompleteEvent(gameObject, func)
end

function LuaUtility.AddSpineStartEvent(trackEntry, func)
	LuaCodeInterface.AddSpineStartEvent(trackEntry, func)
end
