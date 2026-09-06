-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/avatar/animator/AnimatorParams.lua

module("logiccommon.common.avatar.animator.AnimatorParams", package.seeall)

local AnimatorParams = class("AnimatorParams")

function AnimatorParams:ctor()
	self.type = nil
	self.id = nil
	self.value = nil
end

return AnimatorParams
