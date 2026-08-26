-- chunkname: @modules/logic/versionactivity3_9/hedone/model/entity/modifier/HedoneBaseModifier.lua

module("modules.logic.versionactivity3_9.hedone.model.entity.modifier.HedoneBaseModifier", package.seeall)

local HedoneBaseModifier = class("HedoneBaseModifier")

function HedoneBaseModifier:ctor(buffUid, buffId, index, attrId, attrSubId, modValue)
	self._belongBuffUid = buffUid
	self._belongBuffId = buffId
	self._index = index
	self._uid = string.format("%s#%s", tostring(buffUid), tostring(index))

	local attrCfg = HedoneConfig.instance:getHedoneAttributeCfg(attrId, true)

	if not attrCfg then
		logError(string.format("HedoneBaseModifier:ctor error, attrCfg is nil, attrId:%s", attrId))

		return
	end

	self._modAttrId = attrId
	self._modAttrSubId = attrSubId
	self._modVal = modValue
end

function HedoneBaseModifier:getModUid()
	return self._uid
end

function HedoneBaseModifier:getBelongBuffUid()
	return self._belongBuffUid
end

function HedoneBaseModifier:getBelongBuffId()
	return self._belongBuffId
end

function HedoneBaseModifier:getIsCanModify(attrId, attrSubId, needLog)
	local errMsg
	local isCanModify = false

	if not self._modAttrId or self._modAttrId ~= attrId then
		errMsg = string.format("HedoneBaseModifier:getIsCanModify modAttrId mismatch, modAttrId:%s, attrId:%s", self._modAttrId, attrId)
	elseif not self._modAttrSubId or self._modAttrSubId == attrSubId then
		isCanModify = true
	else
		errMsg = string.format("HedoneBaseModifier:getIsCanModify modAttrSubId mismatch, modAttrSubId:%s, attrSubId:%s", self._modAttrSubId, attrSubId)
	end

	if not string.nilorempty(errMsg) and needLog then
		logError(errMsg)
	end

	return isCanModify
end

function HedoneBaseModifier:getModifyAttr()
	return self._modAttrId, self._modAttrSubId
end

function HedoneBaseModifier:modify(attrValue)
	if not attrValue or not self._modVal then
		return
	end

	return self:onModify(attrValue)
end

function HedoneBaseModifier:onModify(attrValue)
	logError("HedoneBaseModifier:onModify error, need override it")
end

function HedoneBaseModifier:getModAffectType()
	return
end

return HedoneBaseModifier
