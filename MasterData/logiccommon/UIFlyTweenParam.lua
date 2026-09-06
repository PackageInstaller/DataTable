-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/tweens/UIFlyTweenParam.lua

module("logiccommon.common.tweens.UIFlyTweenParam", package.seeall)

local UIFlyTweenParam = class("UIFlyTweenParam")

function UIFlyTweenParam:ctor()
	self:reset()
end

function UIFlyTweenParam:reset()
	self.targetGo = nil
	self.endPosition = nil
	self.endScale = nil
	self.onCompleteCallback = nil
	self.duration = nil
	self.isKeepFinalResult = nil
end

return UIFlyTweenParam
