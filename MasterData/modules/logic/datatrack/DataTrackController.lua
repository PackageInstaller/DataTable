-- chunkname: @modules/logic/datatrack/DataTrackController.lua

module("modules.logic.datatrack.DataTrackController", package.seeall)

local DataTrackController = class("DataTrackController", BaseController)

function DataTrackController:onInit()
	SDKDataTrackExt.activateExtend()
end

DataTrackController.instance = DataTrackController.New()

return DataTrackController
