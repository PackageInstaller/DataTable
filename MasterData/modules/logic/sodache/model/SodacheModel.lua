-- chunkname: @modules/logic/sodache/model/SodacheModel.lua

module("modules.logic.sodache.model.SodacheModel", package.seeall)

local SodacheModel = class("SodacheModel", BaseModel)

function SodacheModel:onInit()
	self._outSideMo = nil
	self._inSideMo = nil
	self.toastList = {}
	self.cardToastList = {}
	self.____gmfastrun = false
end

function SodacheModel:reInit()
	self:onInit()
end

function SodacheModel:updateInsideMo(data)
	self._inSideMo = GameUtil.rpcInfoToMo(data, SodacheInsideSceneMo, self._inSideMo)
end

function SodacheModel:updateOutsideMo(data)
	self._outSideMo = GameUtil.rpcInfoToMo(data, SodacheOutsideSceneMo, self._outSideMo)
end

function SodacheModel:getInsideMo()
	return self._inSideMo
end

function SodacheModel:getOutsideMo()
	return self._outSideMo
end

function SodacheModel:updateBag(bagType, data)
	if not self._outSideMo then
		return
	end

	self._outSideMo:updateBag(bagType, data)
end

SodacheModel.instance = SodacheModel.New()

return SodacheModel
