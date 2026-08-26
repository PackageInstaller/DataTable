-- chunkname: @modules/logic/versionactivity/model/VersionActivityLeiMiTeBeiTaskModel.lua

module("modules.logic.versionactivity.model.VersionActivityLeiMiTeBeiTaskModel", package.seeall)

local VersionActivityLeiMiTeBeiTaskModel = class("VersionActivityLeiMiTeBeiTaskModel", BaseModel)

function VersionActivityLeiMiTeBeiTaskModel:onInit()
	self.infosDic = {}
end

function VersionActivityLeiMiTeBeiTaskModel:reInit()
	self:onInit()
end

VersionActivityLeiMiTeBeiTaskModel.instance = VersionActivityLeiMiTeBeiTaskModel.New()

return VersionActivityLeiMiTeBeiTaskModel
