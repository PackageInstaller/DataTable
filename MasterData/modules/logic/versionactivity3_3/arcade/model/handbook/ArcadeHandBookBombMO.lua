-- chunkname: @modules/logic/versionactivity3_3/arcade/model/handbook/ArcadeHandBookBombMO.lua

module("modules.logic.versionactivity3_3.arcade.model.handbook.ArcadeHandBookBombMO", package.seeall)

local ArcadeHandBookBombMO = class("ArcadeHandBookBombMO")

function ArcadeHandBookBombMO:ctor(id)
	self.id = id
	self.co = ArcadeConfig.instance:getBombCfg(id)
	self.type = ArcadeEnum.EffectType.Bomb
	self.count = ArcadeConfig.instance:getAttributeInitVal(ArcadeEnum.AttributeConst.BombCount)
end

function ArcadeHandBookBombMO:getName()
	return self.co.name or ""
end

function ArcadeHandBookBombMO:getDesc()
	return ArcadeGameHelper.phraseDesc(self.co.skillDesc or "")
end

function ArcadeHandBookBombMO:getIcon()
	return self.co.icon
end

function ArcadeHandBookBombMO:getCount()
	return self.count
end

return ArcadeHandBookBombMO
