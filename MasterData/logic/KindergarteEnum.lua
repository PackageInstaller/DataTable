-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kindergarten/data/KindergarteEnum.lua

module("logic.extensions.gm.view.KindergarteEnum", package.seeall)

local KindergarteEnum = {}

KindergarteEnum.StuType_Normal = 1
KindergarteEnum.StuType_Super = 2
KindergarteEnum.StuTypeNames = {
	[KindergarteEnum.StuType_Normal] = "普通学生",
	[KindergarteEnum.StuType_Super] = "天才学生"
}

return KindergarteEnum
