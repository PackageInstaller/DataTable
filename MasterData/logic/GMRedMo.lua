-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/gm/view/gmredpoint/GMRedMo.lua

module("logic.extensions.gm.view.gmredpoint.GMRedMo", package.seeall)

local GMRedMo = class("GMRedMo")

function GMRedMo:ctor()
	return
end

function GMRedMo:reset()
	return
end

function GMRedMo:update(redId)
	self._redId = tostring(redId)

	self:_updateGoList()
	self:_updateMasterServant()

	self._redInfo = RedPointModel.instance:getRedPoingInfo(self._redId)

	self:_updateMo(self._redId)
end

function GMRedMo:_updateMo(redId)
	local mo = {}

	mo._isReg = self._redInfo ~= nil
	mo._isLight = RedPointModel.instance:isActive(redId)
	mo._isAttrActivated = RedPointModel.instance:isAttrActivated(redId)
	mo._isInTime = RedPointModel.instance:isInTime(redId)
	mo._isFuncOpenByServer = RedPointModel.instance:isFuncOpenByServer(redId)
	mo._isFuncOpenByClient = RedPointModel.instance:isFuncOpenByClient(redId)
	mo._isHaveRedGos = #self:getGoList() > 0
	mo._isMasterRed = #self:getServantRedIdList() > 0
	mo._isServantRed = #self:getMasterRedIdList() > 0
	mo._isCycleRed = RedPointExConfig.instance:isCycleRed(redId)
	mo._isOnceRed = RedPointExConfig.instance:isOnceRed(redId)
	self._mo = mo
end

function GMRedMo:getRedId()
	return self._redId
end

function GMRedMo:getRedInfo()
	return self._redInfo
end

function GMRedMo:getGoList()
	return self._goList or {}
end

function GMRedMo:_updateGoList()
	local goList = {}
	local myRedId = self:getRedId()

	for go, redIdList in pairs(RedPointController.instance.redpointPool) do
		for _, redId in ipairs(redIdList) do
			redId = tostring(redId)

			if myRedId == redId then
				if go and goutil.isNil(go) then
					local path = RedPointController.instance.redGoPaths[go]

					printError(string.format("错误,红点gameObject池存在已经销毁的gameObject, redId:%s, path:%s", redId, path))
				else
					table.insert(goList, go)
				end
			end
		end
	end

	self._goList = goList
end

function GMRedMo:getMasterRedIdList()
	return self._masterRedIdList or {}
end

function GMRedMo:getServantRedIdList()
	return self._servantRedIdList or {}
end

function GMRedMo:_updateMasterServant()
	local masterRedPool = {}
	local servantRedPool = RedPointModel.instance:getMsRedPool()

	for masterRedId, servantRedIdList in pairs(servantRedPool) do
		for _, servantRedId in ipairs(servantRedIdList) do
			if masterRedPool[servantRedId] == nil then
				masterRedPool[servantRedId] = {}
			end

			table.insert(masterRedPool[servantRedId], masterRedId)
		end
	end

	self._servantRedIdList = servantRedPool[self:getRedId()]
	self._masterRedIdList = masterRedPool[self:getRedId()]
end

function GMRedMo:_getMo()
	return self._mo
end

function GMRedMo:isReg()
	return self._mo._isReg
end

function GMRedMo:isLight()
	return self._mo._isLight
end

function GMRedMo:isAttrActivated()
	return self._mo._isAttrActivated
end

function GMRedMo:isInTime()
	return self._mo._isInTime
end

function GMRedMo:isFuncOpenByServer()
	return self._mo._isFuncOpenByServer
end

function GMRedMo:isFuncOpenByClient()
	return self._mo._isFuncOpenByClient
end

function GMRedMo:isHaveRedGos()
	return self._mo._isHaveRedGos
end

function GMRedMo:isMasterRed()
	return self._mo._isMasterRed
end

function GMRedMo:isServantRed()
	return self._mo._isServantRed
end

function GMRedMo:isCycleRed()
	return self._mo._isCycleRed
end

function GMRedMo:isOnceRed()
	return self._mo._isOnceRed
end

return GMRedMo
