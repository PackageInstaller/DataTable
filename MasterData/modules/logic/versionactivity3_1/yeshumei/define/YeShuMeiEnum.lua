-- chunkname: @modules/logic/versionactivity3_1/yeshumei/define/YeShuMeiEnum.lua

module("modules.logic.versionactivity3_1.yeshumei.define.YeShuMeiEnum", package.seeall)

local YeShuMeiEnum = _M

YeShuMeiEnum.PointType = {
	Disturb = 2,
	Start = 3,
	Normal = 1
}
YeShuMeiEnum.PointTypeName = {
	"普通点",
	"干扰点",
	"起点"
}
YeShuMeiEnum.StateType = {
	Connect = 2,
	Error = 3,
	Normal = 1
}
YeShuMeiEnum.LevelType = {
	Game = 2,
	Story = 1
}
YeShuMeiEnum.BeForePlayGame = 1000
YeShuMeiEnum.AfterPlayGame = 1001
YeShuMeiEnum.ReViewTime = 1002
YeShuMeiEnum.ConnectRange = 1003
YeShuMeiEnum.CreateLineLength = 60

return YeShuMeiEnum
