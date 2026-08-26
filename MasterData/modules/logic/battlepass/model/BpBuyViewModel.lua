-- chunkname: @modules/logic/battlepass/model/BpBuyViewModel.lua

module("modules.logic.battlepass.model.BpBuyViewModel", package.seeall)

local BpBuyViewModel = class("BpBuyViewModel", ListScrollModel)

BpBuyViewModel.instance = BpBuyViewModel.New()

return BpBuyViewModel
