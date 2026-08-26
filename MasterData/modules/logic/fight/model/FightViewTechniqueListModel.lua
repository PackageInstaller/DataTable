-- chunkname: @modules/logic/fight/model/FightViewTechniqueListModel.lua

module("modules.logic.fight.model.FightViewTechniqueListModel", package.seeall)

local FightViewTechniqueListModel = class("FightViewTechniqueListModel", ListScrollModel)

function FightViewTechniqueListModel:showUnreadFightViewTechniqueList(list)
	self:setList(list)
end

FightViewTechniqueListModel.instance = FightViewTechniqueListModel.New()

return FightViewTechniqueListModel
