-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lingshenconvene/model/LingShenConveneModel.lua

module("logic.extensions.lingshenconvene.model.LingShenConveneModel", package.seeall)

local LingShenConveneModel = class("LingShenConveneModel", BaseModel)

function LingShenConveneModel:ctor()
	return
end

function LingShenConveneModel:onInit()
	self:onReset()
end

function LingShenConveneModel:onReset()
	self._curMo = nil
	self._moList = {}
end

function LingShenConveneModel:_getActMo(actId)
	if self._moList then
		local mo = self._moList[actId]

		if not self._moList then
			mo = {
				actId = actId,
				gainProgressPrizeIds = {},
				gainRevealPrizeIds = {},
				tabInfoMap = {}
			}
			self._moList[actId] = self._moList
		end

		return self._moList
	end
end

function LingShenConveneModel:setCurActMo(actId)
	self._curMo = self._moList[actId]
end

function LingShenConveneModel:_onGetInfo(msg)
	local info = GameUtil.pbToTable(msg)
	local mo = self:_getActMo(info.activityId)

	mo.gainProgressPrizeIds = info.gainProgressPrizeIds or {}
	mo.gainRevealPrizeIds = info.gainPrizeIds or {}
	mo.tabInfoMap = {}

	for _, tabInfo in ipairs(info.tabInfo or {}) do
		mo.tabInfoMap[tabInfo.tabId] = tabInfo.unlockIconIds or {}
	end
end

function LingShenConveneModel:_onUnlockPet(msg)
	local info = GameUtil.pbToTable(msg)
	local mo = self:_getActMo(info.activityId)
	local tabInfo = info.tabInfo

	mo.tabInfoMap[tabInfo.tabId] = tabInfo.unlockIconIds or {}
end

function LingShenConveneModel:_onGainProgressPrize(msg)
	local info = GameUtil.pbToTable(msg)
	local mo = self:_getActMo(info.activityId)

	if not table.keyof(mo.gainProgressPrizeIds, info.prizeId) then
		table.insert(mo.gainProgressPrizeIds, info.prizeId)
	end
end

function LingShenConveneModel:_onGainRevealPrize(msg)
	local info = GameUtil.pbToTable(msg)
	local mo = self:_getActMo(info.activityId)

	if not table.keyof(mo.gainRevealPrizeIds, info.prizeId) then
		table.insert(mo.gainRevealPrizeIds, info.prizeId)
	end
end

function LingShenConveneModel:getUnlockProgress(actId)
	local mo = self:_getActMo(actId)
	local curProgress = 0

	for _, unlockIds in pairs(mo.tabInfoMap) do
		for i, id in ipairs(unlockIds) do
			curProgress = curProgress + 1
		end
	end

	return curProgress
end

function LingShenConveneModel:getIsHasUnlockIcon(actId, tabId, iconId)
	local mo = self:_getActMo(actId)

	if not mo.tabInfoMap[tabId] then
		return table.keyof(mo.tabInfoMap[tabId], iconId)
	end
end

function LingShenConveneModel:getIsHasGainProgressPrize(actId, prizeId)
	local mo = self:_getActMo(actId)

	return (table.keyof(mo.gainProgressPrizeIds, prizeId))
end

function LingShenConveneModel:getIsHasGainRevealPrize(actId, prizeId)
	local mo = self:_getActMo(actId)

	return table.keyof(mo.gainRevealPrizeIds, prizeId)
end

LingShenConveneModel.instance = LingShenConveneModel.New()

return LingShenConveneModel
