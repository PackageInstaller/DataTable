-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/groupregress/data/GroupRegressEnum.lua

module("logic.extensions.groupregress.data.GroupRegressEnum", package.seeall)

local GroupRegressEnum = {}

GroupRegressEnum.PlayerType = {
	Regress = "REGRESS_PLAYER",
	New = "NEW_PLAYER",
	Active = "ACTIVE_PLAYER"
}
GroupRegressEnum.TeamType = {
	InviteOwner = 1,
	BindOwner = 2
}

return GroupRegressEnum
