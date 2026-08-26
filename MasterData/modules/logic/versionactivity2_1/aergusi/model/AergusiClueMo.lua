-- chunkname: @modules/logic/versionactivity2_1/aergusi/model/AergusiClueMo.lua

module("modules.logic.versionactivity2_1.aergusi.model.AergusiClueMo", package.seeall)

local AergusiClueMo = class("AergusiClueMo")

function AergusiClueMo:ctor()
	self.clueId = 0
	self.status = 0
end

function AergusiClueMo:init(info)
	self.clueId = info.clueId
	self.status = info.status
end

return AergusiClueMo
