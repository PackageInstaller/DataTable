-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/gm/view/msgdebugger/MsgDebuggerConfig.lua

module("logic.extensions.msgdebugger.MsgDebuggerConfig", package.seeall)

local MsgDebuggerConfig = _M

MsgDebuggerConfig.UIROOT = "TOPMOST"
MsgDebuggerConfig.UIPath = "ui/views/gm/msgdebugger/msgdebuggerui.prefab"
MsgDebuggerConfig.ViewPath = "ui/views/gm/msgdebugger/msgdebuggerview.prefab"
MsgDebuggerConfig.ItemPath = "ui/views/gm/msgdebugger/msgdebuggeritem.prefab"
MsgDebuggerConfig.ItemParamPath = "ui/views/gm/msgdebugger/msgdebuggerparamitem.prefab"
MsgDebuggerConfig.ModifyViewPath = "ui/views/gm/msgdebugger/msgdebuggermodifyview.prefab"
MsgDebuggerConfig.BlockAllWhenBlockOccur = true
MsgDebuggerConfig.IgnoreExtCmdList = {
	[10001] = true
}
MsgDebuggerConfig.NeedPrintStackTrace = true
MsgDebuggerConfig.ParamType = {
	nil,
	nil,
	"int64",
	"uint64",
	"int32",
	nil,
	nil,
	"bool",
	"string",
	nil,
	"proto",
	nil,
	"uint32",
	bool = "bool",
	proto = "proto",
	int32 = "int32",
	uint32 = "uint32",
	string = "string",
	int64 = "int64",
	uint64 = "uint64"
}
MsgDebuggerConfig.LabelType = {
	"optional",
	"required",
	"repeated",
	repeated = "repeated",
	optional = "optional",
	required = "required"
}
MsgDebuggerConfig.DefaultValue = {
	bool = {
		"true",
		"false"
	},
	int32 = {
		"0",
		"-1",
		"1",
		"2147483647",
		"-2147483648"
	},
	uint32 = {
		"0",
		"-1",
		"1",
		"4294967295",
		"2147483647",
		"-2147483648"
	},
	int64 = {
		"0",
		"-1",
		"1",
		"9223372036854775807",
		"-9223372036854775808"
	},
	uint64 = {
		"0",
		"-1",
		"1",
		"18446744073709551615",
		"9223372036854775807",
		"-9223372036854775808"
	},
	string = {
		""
	}
}

return MsgDebuggerConfig
