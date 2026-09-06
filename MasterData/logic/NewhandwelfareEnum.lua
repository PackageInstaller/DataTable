-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newhandwelfare/data/NewhandwelfareEnum.lua

module("logic.extensions.newhandwelfare.view.NewhandwelfareEnum", package.seeall)

local NewhandwelfareEnum = {}

NewhandwelfareEnum.BondPrizeType_Collect = "collect"
NewhandwelfareEnum.BondPrizeType_Verify = "verify"
NewhandwelfareEnum.PrivilegeViewSource_Annual = "annual"
NewhandwelfareEnum.PrivilegeViewSource_Regress = "regress"
NewhandwelfareEnum.PrivilegeViewSource_NewHand = "newhand"
NewhandwelfareEnum.BondPrizeTypeList = {
	NewhandwelfareEnum.BondPrizeType_Verify,
	NewhandwelfareEnum.BondPrizeType_Collect
}
NewhandwelfareEnum.BondPrizeTypeNames = {
	[NewhandwelfareEnum.BondPrizeType_Collect] = "收集",
	[NewhandwelfareEnum.BondPrizeType_Verify] = "战力"
}

return NewhandwelfareEnum
