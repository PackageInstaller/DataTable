-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/welfare/model/multiple_drop/MultipleDropMo.lua

module("logic.extensions.welfare.model.multiple_drop.MultipleDropMo", package.seeall)

local M = class("MultipleDropMo")

function M:ctor()
	self._cfgid = nil
	self._finishNumber = nil
end

function M:setMultipleMo(motable)
	self._cfgid = motable.cfgid
	self._finishNumber = motable.finishNumber

	local info = MultipleDropConfig.instance:getInfoByCode(self._cfgid)

	if info then
		self._name = info.name
		self._dungeonTypeList = info.dungeonType
		self._count = info.count
		self._jumpId = info.jumpId
		self._iconsLst = info.icons
		self._openCode = info.openCode
		self._timesLanguage = info.timesLanguage
		self._explainLanguage = info.explainLanguage
		self._describe = info.describe
		self._rewardList = info.rewardItemIds
	else
		printError("{excel:H活动集合表.xlsx, sheetName:export_副本掉落up}找不到对应活动配置:" .. self._cfgid)
	end
end

function M:getConfigId()
	return self._cfgid
end

function M:setFinishNumber(num)
	self._finishNumber = num
end

function M:getTypeList()
	return self._dungeonTypeList
end

function M:getLeftNumber()
	return self._count - self._finishNumber > -1 and self._count - self._finishNumber or 0
end

function M:getCount()
	return self._count
end

function M:getName()
	return self._name
end

function M:getJumpId()
	return self._jumpId
end

function M:getIconLst()
	return self._iconsLst
end

function M:getIsOpen()
	if not SystemOpenFacade.instance:isOpen(self._openCode, false) then
		return false
	end

	return true
end

function M:getOpenTis()
	local systemOpenCO = SystemOpenConfig.instance:getSystemOpenCOById(self._openCode)

	return systemOpenCO:getLockTips()
end

function M:getTimes()
	return lang(self._timesLanguage)
end

function M:getExplain()
	return lang(self._explainLanguage)
end

function M:getDescribe()
	return lang(self._describe)
end

function M:getRewardList()
	return self._rewardList
end

return M
