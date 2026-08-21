-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/model/AirWorkShopModel.lua

module("logic.extensions.airworkshop.model.AirWorkShopModel", package.seeall)

local M = class("AirWorkShopModel", BaseModel)

function M:ctor()
	M.super.ctor(self)

	self._lastEditLevelMo = false
end

function M:onInit()
	self:onReset()
end

function M:updateAirInfo(airInfoNO)
	self._airInfo.lv = airInfoNO and airInfoNO.lv or 0
	self._airInfo.exp = airInfoNO and airInfoNO.exp or 0
	self._airInfo.agreement = airInfoNO and airInfoNO.agreement or false
end

function M:getAirInfo()
	return self._airInfo
end

function M:updateAgreement()
	if self._airInfo then
		self._airInfo.agreement = true
	end
end

function M:hasAgreeProtocol()
	return self._airInfo and self._airInfo.agreement
end

function M:onUnlockInfoReply(unlockList)
	if unlockList and #unlockList > 0 then
		for _, UnlockInfoNO in ipairs(unlockList) do
			local typ = UnlockInfoNO.type
			local ids = UnlockInfoNO.id or {}

			if typ > 100 then
				if not self._unlockInfoList[typ] then
					self._unlockInfoList[typ] = {}
				end

				for _, id in ipairs(ids) do
					self._unlockInfoList[typ][id] = true
				end
			end
		end
	end
end

function M:onUnlockInfoPush(typ, ids)
	if typ > 100 then
		if not self._unlockInfoList[typ] then
			self._unlockInfoList[typ] = {}
		end

		for _, id in ipairs(ids or {}) do
			self._unlockInfoList[typ][id] = true
		end
	end
end

function M:getIsUnlockByTypeAndId(type, id)
	return self._unlockInfoList[type] and self._unlockInfoList[type][id] or false
end

function M:getIsSceneOrBuildingUnlockById(type, id)
	local itemDatas = ItemModel.instance:getItemsByItemId(id)

	return itemDatas and #itemDatas > 0
end

function M:saveLastEditLevelMo(lastMo)
	self._lastEditLevelMo = lastMo
end

function M:getLastEditLevelMo()
	return self._lastEditLevelMo
end

function M:clearLastEditLevelMo()
	self._lastEditLevelMo = false
end

function M:onGetAirMapNewsReply(listAirMapNews, typeList)
	for _, _type in ipairs(typeList) do
		self._airMapNewsMoList[_type] = {}
	end

	local len = listAirMapNews and #listAirMapNews or 0

	if len > 0 then
		local typeMap = {}

		for _, AirMapNews in ipairs(listAirMapNews or {}) do
			local _type = AirMapNews.type

			if not typeMap[_type] then
				typeMap[_type] = 1
				self._airMapNewsMoList[_type] = {}
			end

			local mo = AirWorkMapNewsMO.New()

			mo:updateFromServer(AirMapNews)
			table.insert(self._airMapNewsMoList[_type], mo)
		end
	end
end

function M:getAirMapNews(type)
	if self._airMapNewsMoList and self._airMapNewsMoList[type] then
		return self._airMapNewsMoList[type]
	else
		return {}
	end
end

function M:getAllAirMapNewsCount()
	local count = 0

	for _type, list in pairs(self._airMapNewsMoList or {}) do
		for _, mo in pairs(list or {}) do
			if mo:getUnRead() then
				count = count + 1
			end
		end
	end

	return count
end

function M:getAirMapNewsCountByType(type)
	local count = 0
	local list = self:getAirMapNews(type)

	for _, mo in pairs(list or {}) do
		if mo:getUnRead() then
			count = count + 1
		end
	end

	return count
end

function M:onReset()
	self._unlockInfoList = {}
	self._airInfo = {}
	self._airMapNewsMoList = {}
	self._lastEditLevelMo = false
end

M.instance = M.New()

return M
