-- chunkname: @modules/logic/versionactivity3_3/arcade/model/develop/ArcadeTalentListModel.lua

module("modules.logic.versionactivity3_3.arcade.model.develop.ArcadeTalentListModel", package.seeall)

local ArcadeTalentListModel = class("ArcadeTalentListModel", ListScrollModel)

function ArcadeTalentListModel:setMoList()
	local moList = ArcadeHeroModel.instance:getTalentMoList()

	table.sort(moList, self.sort)
	self:setList(moList)
end

function ArcadeTalentListModel.sort(a, b)
	return a.id < b.id
end

ArcadeTalentListModel.instance = ArcadeTalentListModel.New()

return ArcadeTalentListModel
