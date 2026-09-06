-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/cmd/UnitCmdBase.lua

module("logicscene.scene.unit.cmd.UnitCmdBase", package.seeall)

local UnitCmdBase = class("UnitCmdBase")
local Time = UnityEngine.Time

function UnitCmdBase:ctor()
	self._time = Time.realtimeSinceStartup
end

function UnitCmdBase:cmdType()
	return
end

function UnitCmdBase:toAction()
	return
end

function UnitCmdBase:runCmd(unit)
	return
end

function UnitCmdBase:elapsed()
	return Time.realtimeSinceStartup - self._time
end

return UnitCmdBase
