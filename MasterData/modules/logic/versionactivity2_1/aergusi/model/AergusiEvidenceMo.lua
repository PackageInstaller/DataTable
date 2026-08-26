-- chunkname: @modules/logic/versionactivity2_1/aergusi/model/AergusiEvidenceMo.lua

module("modules.logic.versionactivity2_1.aergusi.model.AergusiEvidenceMo", package.seeall)

local AergusiEvidenceMo = class("AergusiEvidenceMo")

function AergusiEvidenceMo:ctor()
	self.clueInfos = {}
	self.hp = 0
	self.tipCount = 0
	self.success = false
end

function AergusiEvidenceMo:init(info)
	self.clueInfos = self:_buildClues(info.cluesInfo)
	self.hp = info.hp
	self.tipCount = info.tipCount
	self.success = info.success
end

function AergusiEvidenceMo:update(info)
	self:init(info)
end

function AergusiEvidenceMo:_buildClues(clueInfos)
	local infos = {}

	for _, v in ipairs(clueInfos) do
		local info = AergusiClueMo.New()

		info:init(v)
		table.insert(infos, info)
	end

	return infos
end

return AergusiEvidenceMo
