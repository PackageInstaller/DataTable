-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/gm/view/GmEnum.lua

module("logic.extensions.gm.view.GmEnum", package.seeall)

local GmEnum = {}

GmEnum.ItemScrType_Command = "ItemScrType_Command"
GmEnum.ItemScrType_Prop = "ItemScrType_Prop"
GmEnum.ItemScrType_Search = "ItemScrType_Search"
GmEnum.ItemScrTypeList = {
	GmEnum.ItemScrType_Search,
	GmEnum.ItemScrType_Command,
	GmEnum.ItemScrType_Prop
}
GmEnum.MaxSearchDataLimit = 10

return GmEnum
