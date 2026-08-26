-- chunkname: @modules/logic/versionactivity3_3/arcade/model/handbook/ArcadeHandBookMO.lua

module("modules.logic.versionactivity3_3.arcade.model.handbook.ArcadeHandBookMO", package.seeall)

local ArcadeHandBookMO = class("ArcadeHandBookMO")

function ArcadeHandBookMO:ctor(id, type, co)
	self.co = co
	self.id = id
	self.type = type
	self._isLock = true

	self:initAttribute()
	self:initEffect()
	self:_setSize()
end

function ArcadeHandBookMO:_setSize()
	local minSize = ArcadeEnum.HandBookItemParams.MinSize

	self._sizeX, self._sizeY = string.match(self:getIcon(), "(%d+)x(%d+)")
	self._sizeX = self._sizeX and tonumber(self._sizeX) * minSize or minSize
	self._sizeY = self._sizeY and tonumber(self._sizeY) * minSize or minSize
end

function ArcadeHandBookMO:setLock(lock)
	self._isLock = lock
end

function ArcadeHandBookMO:isLock()
	return self._isLock
end

function ArcadeHandBookMO:initAttribute()
	self._attributeList = {}
end

function ArcadeHandBookMO:initEffect()
	self._effectList = {}
end

function ArcadeHandBookMO:getId()
	return self.id
end

function ArcadeHandBookMO:getType()
	return self.type
end

function ArcadeHandBookMO:getConfig()
	return self.co
end

function ArcadeHandBookMO:getIcon()
	return self.co.icon
end

function ArcadeHandBookMO:getBigIcon()
	return self.co.icon
end

function ArcadeHandBookMO:getName()
	return self.co.name
end

function ArcadeHandBookMO:getDesc()
	return self.co.desc or ""
end

function ArcadeHandBookMO:getDescList()
	return {
		self:getDesc()
	}
end

function ArcadeHandBookMO:getAttribute()
	return self._attributeList
end

function ArcadeHandBookMO:getEffect()
	return self._effectList
end

function ArcadeHandBookMO:getEleId()
	return self.co.id
end

function ArcadeHandBookMO:setCount(count)
	self._count = count
end

function ArcadeHandBookMO:getCount()
	return self._count or 1
end

function ArcadeHandBookMO:setNew(isNew)
	self._isNew = isNew
end

function ArcadeHandBookMO:saveNew(isNew)
	local prefsKey, key = self:getReddotKey()

	ArcadeOutSizeModel.instance:setPlayerPrefsValue(prefsKey, key, isNew and 0 or 1, true)
end

function ArcadeHandBookMO:isNew()
	return self._isNew
end

function ArcadeHandBookMO:getReddotKey()
	self._reddotKey = self._reddotKey or string.format("%s_%s", self:getType(), self:getId())

	return ArcadeEnum.PlayerPrefsKey.HankBookNew, self._reddotKey
end

function ArcadeHandBookMO:setAnchorX(x)
	self._anchorX = x
end

function ArcadeHandBookMO:setAnchorY(y)
	self._anchorY = y
end

function ArcadeHandBookMO:getAnchor()
	return self._anchorX or 0, self._anchorY or 0
end

function ArcadeHandBookMO:getIconSize()
	return self._sizeX or 1, self._sizeY or 1
end

function ArcadeHandBookMO:isSpecialIconSize()
	return false
end

function ArcadeHandBookMO:setRowInfo(count, index)
	self._rowCount = count
	self._rowIndex = index
end

function ArcadeHandBookMO:getRowInfo()
	return self._rowCount, self._rowIndex
end

function ArcadeHandBookMO:getBigIconTrans()
	local anchorX, anchorY = 0, 0
	local scaleX, scaleY = 1, 1

	return anchorX, anchorY, scaleX, scaleY
end

function ArcadeHandBookMO:getLockTip()
	return luaLang("p_v3a3_eliminate_handbook_lock")
end

return ArcadeHandBookMO
