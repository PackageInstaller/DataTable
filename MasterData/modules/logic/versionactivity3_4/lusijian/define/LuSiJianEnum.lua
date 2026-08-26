-- chunkname: @modules/logic/versionactivity3_4/lusijian/define/LuSiJianEnum.lua

module("modules.logic.versionactivity3_4.lusijian.define.LuSiJianEnum", package.seeall)

local LuSiJianEnum = _M

LuSiJianEnum.PointType = {
	Disturb = 2,
	Start = 3,
	Normal = 1
}
LuSiJianEnum.PointTypeName = {
	"普通点",
	"干扰点",
	"起点"
}
LuSiJianEnum.StateType = {
	Connect = 2,
	Error = 3,
	Normal = 1
}
LuSiJianEnum.LevelType = {
	Game = 2,
	Story = 1
}
LuSiJianEnum.ConnectRange = 1000
LuSiJianEnum.FaultTolerance = 2

return LuSiJianEnum
