-- chunkname: @modules/logic/summonuiswitch/define/SummonUISwitchEnum.lua

module("modules.logic.summonuiswitch.define.SummonUISwitchEnum", package.seeall)

local SummonUISwitchEnum = _M

SummonUISwitchEnum.ItemTypeSelected = 1
SummonUISwitchEnum.ItemTypeUnSelected = 2
SummonUISwitchEnum.ItemHeight = 190
SummonUISwitchEnum.ItemUnSelectedScale = 0.78
SummonUISwitchEnum.ItemUnSelectedHeight = SummonUISwitchEnum.ItemHeight * SummonUISwitchEnum.ItemUnSelectedScale
SummonUISwitchEnum.PageWidth = 2592
SummonUISwitchEnum.PageSwitchTime = 2
SummonUISwitchEnum.SaveClickUIPrefKey = "SummonUISwitchEnum_SaveClickUIPrefKey_"

return SummonUISwitchEnum
