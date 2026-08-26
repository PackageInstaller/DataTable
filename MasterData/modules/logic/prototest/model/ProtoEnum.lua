-- chunkname: @modules/logic/prototest/model/ProtoEnum.lua

module("modules.logic.prototest.model.ProtoEnum", package.seeall)

local ProtoEnum = _M

ProtoEnum.OnClickModifyItem = 1
ProtoEnum.OnClickReqListItem = 2
ProtoEnum.LabelType = {
	"optional",
	"required",
	"repeated",
	repeated = 3,
	optional = 1,
	required = 2
}
ProtoEnum.ParamType = {
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
	bool = 8,
	proto = 11,
	int32 = 5,
	uint32 = 13,
	string = 9,
	int64 = 3,
	uint64 = 4
}
ProtoEnum.DefaultValue = {
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
ProtoEnum.IgnoreCmdList = {
	[19233] = true,
	[24032] = true,
	[-16648] = true
}

return ProtoEnum
