-- chunkname: @modules/logic/gm/model/GMResetCardsModel.lua

module("modules.logic.gm.model.GMResetCardsModel", package.seeall)

local GMResetCardsModel = class("GMResetCardsModel", BaseModel)

function GMResetCardsModel:ctor()
	GMResetCardsModel.super.ctor(self)

	self._model1 = ListScrollModel.New()
	self._model2 = ListScrollModel.New()
end

function GMResetCardsModel:onInit()
	self._model1:onInit()
	self._model2:onInit()
end

function GMResetCardsModel:reInit()
	self._model1:reInit()
	self._model2:reInit()
end

function GMResetCardsModel:clear()
	self._model1:clear()
	self._model2:clear()
end

function GMResetCardsModel:getModel1()
	return self._model1
end

function GMResetCardsModel:getModel2()
	return self._model2
end

GMResetCardsModel.instance = GMResetCardsModel.New()

return GMResetCardsModel
