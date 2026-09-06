-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/constdef/NpcFunction.lua

module("logiccommon.common.constdef.NpcFunction", package.seeall)

local NpcFunction = class("NpcFunction")

function NpcFunction:ctor()
	self.taskId = nil
	self.funcCo = nil
end

return NpcFunction
