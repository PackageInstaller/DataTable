-- chunkname: @modules/logic/fightuiswitch/rpc/FightUISwitchRpc.lua

module("modules.logic.fightuiswitch.rpc.FightUISwitchRpc", package.seeall)

local FightUISwitchRpc = class("FightUISwitchRpc", BaseRpc)

FightUISwitchRpc.instance = FightUISwitchRpc.New()

return FightUISwitchRpc
