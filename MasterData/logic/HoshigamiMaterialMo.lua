-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hoshigami/model/HoshigamiMaterialMo.lua

module("logic.extensions.hoshigami.model.HoshigamiMaterialMo", package.seeall)

local HoshigamiMaterialMo = class("HoshigamiMaterialMo")

function HoshigamiMaterialMo:ctor()
	self._defineId = 0
	self._type = 0
	self._id = 0
	self._num = 0
end

function HoshigamiMaterialMo:initData(info)
	self._info = info
	self._type = MatType.Hoshigami
	self._id = info.hoshigamiId
	self._defineId = info.defineId
	self._cfg = HoshigamiConfig.instance:getHoshigamiCfg(info.defineId)
end

function HoshigamiMaterialMo:getMatType()
	return self._type
end

function HoshigamiMaterialMo:getDefineId()
	return self._defineId
end

function HoshigamiMaterialMo:getId()
	return self._id
end

function HoshigamiMaterialMo:getQuality()
	return self._cfg.quality
end

function HoshigamiMaterialMo:getResolveMats()
	local planCfg = HoshigamiConfig.instance:getMainPropPlan(self._cfg.mainPropPlan)
	local cfg = planCfg[self._info.mainPropId]
	local strenCfgs = HoshigamiConfig.instance:getLvStrenCfg(cfg.mainPropId)
	local lvCfg = strenCfgs[self._info.lv]
	local costId = HoshigamiConfig.instance:getUpgradeCostMatId()
	local refund_ratio = HoshigamiConfig.instance:getRefundRatio()

	return {
		[string.format("%s:%s", MatType.Item, costId)] = lvCfg.costItemCount,
		[string.format("%s:%s", MatType.Coin, MatType.Coin_Gold)] = lvCfg.costCoinCount
	}
end

function HoshigamiMaterialMo:getStrenLv()
	return self._info.lv
end

function HoshigamiMaterialMo:getUsePetId()
	return self._info.equippedPetId
end

return HoshigamiMaterialMo
