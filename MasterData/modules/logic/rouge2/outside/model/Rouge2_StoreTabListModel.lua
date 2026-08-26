-- chunkname: @modules/logic/rouge2/outside/model/Rouge2_StoreTabListModel.lua

module("modules.logic.rouge2.outside.model.Rouge2_StoreTabListModel", package.seeall)

local Rouge2_StoreGoodsListModel = class("Rouge2_StoreTabListModel", ListScrollModel)

Rouge2_StoreTabListModel.instance = Rouge2_StoreTabListModel.New()

return Rouge2_StoreTabListModel
