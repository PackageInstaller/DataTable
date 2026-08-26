-- chunkname: @modules/logic/rouge/controller/RougeOutsideController.lua

module("modules.logic.rouge.controller.RougeOutsideController", package.seeall)

local RougeOutsideController = class("RougeOutsideController", BaseController)

function RougeOutsideController:onInit()
	self._model = RougeOutsideModel.instance
end

function RougeOutsideController:addConstEvents()
	OpenController.instance:registerCallback(OpenEvent.GetOpenInfoSuccess, self._onGetOpenInfoSuccess, self)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, self._onDailyRefresh, self)
	RedDotController.instance:registerCallback(RedDotEvent.UpdateRelateDotInfo, self._updateRelateDotInfo, self)
end

function RougeOutsideController:reInit()
	RedDotController.instance:unregisterCallback(RedDotEvent.UpdateRelateDotInfo, self._updateRelateDotInfo, self)
end

function RougeOutsideController:_onGetOpenInfoSuccess()
	local CO = self._model:config()
	local openUnlockId = CO:openUnlockId()

	if OpenModel.instance:isFunctionUnlock(openUnlockId) then
		return
	end

	OpenController.instance:registerCallback(OpenEvent.NewFuncUnlock, self._onNewFuncUnlock, self)
end

function RougeOutsideController:_updateRelateDotInfo(dict)
	if not self:isOpen() or not dict or not dict[RedDotEnum.DotNode.RougeDLCNew] then
		return
	end

	RedDotController.instance:unregisterCallback(RedDotEvent.UpdateRelateDotInfo, self._updateRelateDotInfo, self)
	self:initDLCReddotInfo()
end

function RougeOutsideController:_onDailyRefresh()
	if not self:isOpen() then
		return
	end

	self:sendRpcToGetOutsideInfo()
end

function RougeOutsideController:sendRpcToGetOutsideInfo()
	local season = self._model:season()

	RougeOutsideRpc.instance:sendGetRougeOutSideInfoRequest(season)
end

function RougeOutsideController:checkOutSideStageInfo()
	return
end

function RougeOutsideController:_onNewFuncUnlock(newIds)
	local CO = self._model:config()
	local openUnlockId = CO:openUnlockId()
	local ok = false

	for _, id in ipairs(newIds) do
		if id == openUnlockId then
			ok = true

			break
		end
	end

	if not ok then
		return
	end

	self._model:setIsNewUnlockDifficulty(1, true)
	self:sendRpcToGetOutsideInfo()
	self:initDLCReddotInfo()
end

function RougeOutsideController:isOpen()
	return self._model:isUnlock()
end

function RougeOutsideController:initDLCReddotInfo()
	local reddotInfo_103 = self:_createDLCReddotInfo(RougeDLCEnum.DLCEnum.DLC_103)
	local reddotInfo_entry = self:_createDLCEntryReddotInfo({
		reddotInfo_103
	})
	local reddotInfoList = {
		reddotInfo_103,
		reddotInfo_entry
	}

	RedDotRpc.instance:clientAddRedDotGroupList(reddotInfoList, true)
end

function RougeOutsideController:_createDLCReddotInfo(dlcId)
	if not dlcId or dlcId == 0 then
		return
	end

	local notRead = self:checkIsDLCNotRead(dlcId)
	local reddotVal = notRead and 1 or 0

	return {
		id = RedDotEnum.DotNode.RougeDLCNew,
		uid = dlcId,
		value = reddotVal
	}
end

function RougeOutsideController:checkIsDLCNotRead(dlcId)
	local key = self:_generateNewReadDLCInLocalKey(dlcId)

	return (string.nilorempty(PlayerPrefsHelper.getString(key, "")))
end

function RougeOutsideController:_createDLCEntryReddotInfo(dlcReddotInfos)
	local reddotInfo_entry = {
		uid = 0,
		value = 0,
		id = RedDotEnum.DotNode.RougeDLCNew
	}

	if dlcReddotInfos then
		for _, reddotInfo in ipairs(dlcReddotInfos) do
			if reddotInfo.value and reddotInfo.value > 0 then
				reddotInfo_entry.value = 1

				break
			end
		end
	end

	return reddotInfo_entry
end

function RougeOutsideController:saveNewReadDLCInLocal(dlcId)
	if not dlcId or dlcId == 0 then
		return
	end

	local key = self:_generateNewReadDLCInLocalKey(dlcId)

	PlayerPrefsHelper.setString(key, "true")
end

function RougeOutsideController:_generateNewReadDLCInLocalKey(dlcId)
	return (string.format("%s#%s#%s", PlayerPrefsKey.RougeHasReadDLCId, PlayerModel.instance:getMyUserId(), dlcId))
end

RougeOutsideController.instance = RougeOutsideController.New()

return RougeOutsideController
