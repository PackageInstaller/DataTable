-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/orimatgame/model/buff/OriMatGameAddBulletCountBuff.lua

module("logic.extensions.orimatgame.model.buff.OriMatGameAddBulletCountBuff", package.seeall)

local OriMatGameAddBulletCountBuff = class("OriMatGameAddBulletCountBuff", OriMatGameBuffBase)

function OriMatGameAddBulletCountBuff:initComplete()
	OriMatGameAddBulletCountBuff.super.initComplete(self)

	self._addDir = self._tiggerParam[self:gPId()]
	self._addCount = checknumber(self._tiggerParam[self:gPId()])
	self._addBulletId = checknumber(self._tiggerParam[self:gPId()])
end

function OriMatGameAddBulletCountBuff:onAdd(target)
	OriMatGameAddBulletCountBuff.super.onAdd(self, target)
	GameUtil.callBack(self._unit.addBulletCount, self._unit, self._addDir, self._addCount, self._addBulletId)
end

function OriMatGameAddBulletCountBuff:onRemove(unit)
	OriMatGameAddBulletCountBuff.super.onRemove(self, unit)
	GameUtil.callBack(self._unit.reduceBulletCount, self._unit, self._addDir, self._addCount, self._addBulletId)
end

return OriMatGameAddBulletCountBuff
