-- chunkname: @modules/logic/gm/model/GMAudioBankViewModel.lua

module("modules.logic.gm.model.GMAudioBankViewModel", package.seeall)

local GMAudioBankViewModel = class("GMAudioBankViewModel", ListScrollModel)

function GMAudioBankViewModel:ctor()
	GMAudioBankViewModel.super.ctor(self)
end

function GMAudioBankViewModel:reInit()
	return
end

GMAudioBankViewModel.instance = GMAudioBankViewModel.New()

return GMAudioBankViewModel
