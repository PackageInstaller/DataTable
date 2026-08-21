-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/model/MonumentModel.lua

module("logic.extensions.playerinfo.model.MonumentModel", package.seeall)

local M = class("MonumentModel", BaseModel)

function M:ctor()
	self._monumentMoList = {}
	self._monumentListModel = BaseListModel.New()
end

function M:onInit()
	local allMonumentCfgs = MonumentConfig.instance:getAllMonumentCfgs()

	for _, cfg in ipairs(allMonumentCfgs) do
		table.insert(self._monumentMoList, MonumentMO.New(cfg))
	end
end

function M:onReset()
	table.clear(self._monumentMoList)
	self._monumentListModel:clear()
	self:onInit()
end

function M:getLabelName(id)
	local name = ""

	if id == 0 then
		name = lang("tip_common_all")
	else
		local monumentLabelMo = MonumentModel.instance:getMonumentLabelMoById(id)

		if monumentLabelMo then
			name = monumentLabelMo:getName()
		end
	end

	return name
end

function M:updateMonumentListModel(ids)
	local temp = {}

	for _, id in ipairs(ids or {}) do
		local mo = self:getMonumentMoById(id)
		local no = mo:getNo()

		if not temp[no] then
			temp[no] = mo
		end

		local maxLevel = self:getMaxLevel(no)

		if mo:getIsFinish() and temp[no]:getLv() < mo:getLv() then
			temp[no] = mo
		end
	end

	local moList = {}

	for _, mo in pairs(temp) do
		if not mo:getIsFinish() and mo:isNotGetNoShow() then
			print("====not get no show cup id: " .. mo:getId())
		else
			table.insert(moList, mo)
		end
	end

	table.sort(moList, function(mo1, mo2)
		return mo1:getNo() < mo2:getNo()
	end)
	self._monumentListModel:setMoList(moList)
end

function M:getMonumentListModel()
	return self._monumentListModel
end

function M:getFinishedMonuments()
	local res = {}

	for _, monumentMo in ipairs(self._monumentMoList) do
		if monumentMo:getIsFinish() then
			table.insert(res, monumentMo)
		end
	end

	return res
end

function M:getFinishedMaxLvMonuments()
	local res = {}
	local flag = {}

	for _, monumentMo in ipairs(self._monumentMoList) do
		if monumentMo:getIsFinish() then
			local no = monumentMo:getNo()

			if not flag[no] or flag[no]:getLv() < monumentMo:getLv() then
				flag[no] = monumentMo
			end
		end
	end

	for _, v in pairs(flag) do
		table.insert(res, v)
	end

	return res
end

function M:getMonumentMoById(id)
	for _, monumentMo in ipairs(self._monumentMoList) do
		if monumentMo:getId() == id then
			return monumentMo
		end
	end

	printError("Can't find MonumentMO for id = " .. tostring(id))
end

function M:getAllMonumentIds()
	local allMonumentCfgs = MonumentConfig.instance:getAllMonumentCfgs()
	local res = {}

	for _, cfg in ipairs(allMonumentCfgs) do
		table.insert(res, cfg.id)
	end

	return res
end

function M:getUpgradeMonumentMo(no, level)
	for _, monumentMo in ipairs(self._monumentMoList) do
		if monumentMo:getNo() == no and monumentMo:getLv() == level then
			return monumentMo
		end
	end

	printError("Can't find MonumentMO for no, level = " .. tostring(no) .. " " .. tostring(level))
end

function M:refreshMonumentMoByAgent(datas)
	for _, CupNO in ipairs(datas) do
		local monumentMo = self:getMonumentMoById(CupNO.id)

		if monumentMo then
			monumentMo:setFinishCnt(CupNO.count)
			monumentMo:setIsFinish(CupNO.finish)
			monumentMo:setObtTime(CupNO.time)
			monumentMo:setRate(CupNO.rate)
		end
	end
end

function M:getIsSingleLevel(no)
	local monumentCfgs = MonumentConfig.instance:getMonumentCfgsByNo(no)

	return #monumentCfgs > 1
end

function M:getCurLevel(no)
	local monumentCfgs = MonumentConfig.instance:getMonumentCfgsByNo(no)
	local curLevel = 0

	for _, cfg in ipairs(monumentCfgs) do
		local mo = self:getMonumentMoById(cfg.id)

		if mo:getIsFinish() then
			curLevel = mo:getLv()
		end
	end

	return curLevel
end

function M:getMaxLevel(no)
	local monumentCfgs = MonumentConfig.instance:getMonumentCfgsByNo(no)

	return monumentCfgs[#monumentCfgs].lv
end

local FinishStatus = {
	Done = 1,
	Other = 2
}

local function _genFinishStatus(mo)
	if mo:getIsFinish() then
		return FinishStatus.Done
	else
		return FinishStatus.Other
	end
end

local UpgradeStatus = {
	Unable = 2,
	Able = 1
}

local function _genUpgradeStatus(mo)
	if mo:getLv() < self:getMaxLevel(mo:getNo()) then
		return UpgradeStatus.Able
	else
		return UpgradeStatus.Unable
	end
end

function M:_sortMonumentListModel()
	local moList = self._monumentListModel:getMoList()

	table.sort(moList, function(mo1, mo2)
		if _genSortIndex(mo1) ~= _genSortIndex(mo2) then
			return _genSortIndex(mo1) < _genSortIndex(mo2)
		elseif mo1:getLv() ~= mo2:getLv() then
			return mo1:getLv() > mo2:getLv()
		elseif mo1:getPriority() ~= mo2:getPriority() then
			return mo1:getPriority() < mo2:getPriority()
		elseif mo1:_genUpgradeStatus() ~= mo2:_genUpgradeStatus() then
			return mo1:_genUpgradeStatus() < mo2:_genUpgradeStatus()
		else
			return mo1:getId() < mo2:getId()
		end
	end)
end

function M:setNewCups(newCups)
	self._newCups = newCups
end

function M:getNewCups()
	if self._newCups and #self._newCups > 0 then
		return self._newCups
	else
		return false
	end
end

function M:setUpgradeCups(upgradeCups)
	self._upgradeCups = upgradeCups
end

function M:getUpgradeCups()
	if self._upgradeCups and #self._upgradeCups > 0 then
		return self._upgradeCups
	else
		return false
	end
end

function M:getMaxTime()
	local maxTime = 0.5

	if self._newCups and #self._newCups > 0 then
		maxTime = maxTime + 2
	end

	if self._upgradeCups and #self._upgradeCups > 0 then
		maxTime = maxTime + 2
	end

	return maxTime
end

M.instance = M.New()

return M
