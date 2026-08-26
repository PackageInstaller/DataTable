-- chunkname: @modules/logic/survival/model/map/SurvivalBagItemListModel.lua

module("modules.logic.survival.model.map.SurvivalBagItemListModel", package.seeall)

local SurvivalBagItemListModel = class("SurvivalBagItemListModel", ListScrollModel)

SurvivalBagItemListModel.instance = SurvivalBagItemListModel.New()

return SurvivalBagItemListModel
