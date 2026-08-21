-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/loginpopups/model/LoginPopUpsModel.lua

module("logic.extensions.loginpopups.model.LoginPopUpsModel", package.seeall)

local M = class("LoginPopUpsModel", BaseModel)

function M:ctor()
	return
end

function M:onInit()
	self:onReset()
end

function M:onReset()
	self._itemLst = {}
end

function M:AppendPopItem(code, otherCode, jumpId, otherInfo)
	if not code then
		return
	end

	local cfg = LoginPopUpsConfig.instance:getConfigByKey(ConfigName.LoginPopUps, code)

	if not cfg then
		return
	end

	local hasShow = LoginPopUpUtil.hasShow(code, otherCode)

	if jumpId > 0 and not hasShow then
		local data = {}

		data.code = code
		data.otherCode = otherCode
		data.jumpId = jumpId
		data.sortIndex = cfg.sortIndex
		data.popTyp = cfg.winType
		data.otherInfo = otherInfo

		table.insert(self._itemLst, data)
	end

	table.sort(self._itemLst, function(item1, item2)
		if not item1 or not item2 then
			return false
		end

		local id1 = item1.code
		local id2 = item2.code
		local sortIndex1 = item1.sortIndex
		local sortIndex2 = item2.sortIndex

		if sortIndex1 == sortIndex2 then
			return id2 < id1
		else
			return sortIndex2 < sortIndex1
		end
	end)
end

function M:RemovePopItem(code, otherCode)
	if not code then
		return
	end

	local tmpLst = {}

	for index, value in ipairs(self._itemLst) do
		local otherCodeMatch = false

		if value.otherCode and otherCode and value.otherCode == otherCode then
			otherCodeMatch = true
		elseif value.otherCode == nil and otherCode == nil then
			otherCodeMatch = true
		end

		if value.code == code and otherCodeMatch then
			-- block empty
		else
			table.insert(tmpLst, value)
		end
	end

	self._itemLst = tmpLst
end

function M:getShowData()
	local len = self._itemLst and #self._itemLst or 0

	if len == 0 then
		return false
	end

	local data = table.remove(self._itemLst, len)

	return data
end

function M:getCacheDataLstCount()
	local count = self._itemLst and #self._itemLst or 0

	return count
end

function M:isContain(code)
	if not self._itemLst then
		return false
	end

	for i = 1, #self._itemLst do
		if self._itemLst[i].code == code then
			return true
		end
	end

	return false
end

M.instance = M.New()

return M
