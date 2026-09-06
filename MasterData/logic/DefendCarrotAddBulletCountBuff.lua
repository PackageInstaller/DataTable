-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/defendcarrot/model/buff/DefendCarrotAddBulletCountBuff.lua

module("logic.extensions.defendcarrot.model.buff.DefendCarrotAddBulletCountBuff", package.seeall)

local DefendCarrotAddBulletCountBuff = class("DefendCarrotAddBulletCountBuff", DefendCarrotBuffBase)

function DefendCarrotAddBulletCountBuff:initComplete()
	DefendCarrotAddBulletCountBuff.super.initComplete(self)

	self._addDir = self._tiggerParam[self:gPId()]
	self._addCount = checknumber(self._tiggerParam[self:gPId()])
	self._addBulletId = checknumber(self._tiggerParam[self:gPId()])
end

function DefendCarrotAddBulletCountBuff:onAdd(target)
	DefendCarrotAddBulletCountBuff.super.onAdd(self, target)
	GameUtil.callBack(self._unit.addBulletCount, self._unit, self._addDir, self._addCount, self._addBulletId)
end

function DefendCarrotAddBulletCountBuff:onRemove(unit)
	DefendCarrotAddBulletCountBuff.super.onRemove(self, unit)
	GameUtil.callBack(self._unit.reduceBulletCount, self._unit, self._addDir, self._addCount, self._addBulletId)
end

return DefendCarrotAddBulletCountBuff
