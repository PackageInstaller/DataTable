-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holystripe/model/HolyStripeSuitMo.lua

module("logic.extensions.holystripe.model.HolyStripeSuitMo", package.seeall)

local HolyStripeSuitMo = class("HolyStripeSuitMo")

function HolyStripeSuitMo:ctor()
	self.groupId = 0
	self.suitId = 0
	self.wearIds = {}
	self.suitName = ""
end

function HolyStripeSuitMo:onReset()
	self.groupId = 0
	self.suitId = 0
	self.wearIds = {}
	self.suitName = ""
end

function HolyStripeSuitMo:initData(info)
	self.groupId = info.groupId
	self.suitId = info.suitId
	self.wearIds = info.wearItemIds
	self.suitName = info.suitName
	self._isDirty = false

	self:checkSuit()
	self:_calcAttr()
end

function HolyStripeSuitMo:checkSuit()
	local realIds = {}

	self._suitList = {}

	local tempSuitList = {}

	for i, v in ipairs(self.wearIds or {}) do
		local mo = HolyStripeModel.instance:getHolyStripeMo(v)

		if mo then
			table.insert(realIds, v)

			local cfg = HolyStripeConfig.instance:getHolyStripeCfg(mo:getDefineId())

			tempSuitList[cfg.suitType] = (tempSuitList[cfg.suitType] or 0) + 1
		elseif v ~= -1 then
			self._isDirty = true
		end
	end

	self.wearIds = realIds

	for type, count in pairs(tempSuitList) do
		local cfg = HolyStripeConfig.instance:getSuitCfgBySuitType(type)

		for i, v in ipairs(cfg) do
			if count >= v.num then
				table.insert(self._suitList, v)
			end
		end

		table.sort(self._suitList, function(cfg1, cfg2)
			return cfg1.num < cfg2.num
		end)
	end
end

function HolyStripeSuitMo:_calcAttr()
	local holyStripes = {}

	self._attrs = {}

	for i, v in ipairs(self.wearIds or {}) do
		local mo = HolyStripeModel.instance:getHolyStripeMo(v)

		if mo then
			table.insert(holyStripes, mo)
		elseif v ~= -1 then
			self._isDirty = true
		end
	end

	local attrList = HolyStripeModel.instance:getAttrListByMo(holyStripes, self._suitList)

	for i, v in ipairs(attrList) do
		self._attrs[v.type] = v.value
	end

	self._attrs[AttrMo.KEY_DIRECT_ZDL] = nil
end

function HolyStripeSuitMo:getAttr()
	return self._attrs
end

function HolyStripeSuitMo:getSuitList()
	return self._suitList
end

function HolyStripeSuitMo:getIsDirty()
	return self._isDirty
end

return HolyStripeSuitMo
