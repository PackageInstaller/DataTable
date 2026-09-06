-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/gm/view/gmredpoint/GMRedMoMgr.lua

module("logic.extensions.gm.view.gmredpoint.GMRedMoMgr", package.seeall)

local GMRedMoMgr = class("GMRedMoMgr")

function GMRedMoMgr:ctor()
	self._gmRedMoObjPoolMgr = GMRedMoObjPoolMgr.New()
	self._redIdList = {}
	self._redIdPool = {}
	self._redMoPool = {}
	self._newAddRedIdList = {}
end

function GMRedMoMgr:onEnter()
	self._gmRedMoObjPoolMgr:onEnter()
	self:_update()
	GlobalDispatcher:addListener(GlobalNotify.RedPointUpdate, self._update, self)
end

function GMRedMoMgr:onExit()
	GlobalDispatcher:removeListener(GlobalNotify.RedPointUpdate, self._update, self)
	self._gmRedMoObjPoolMgr:onExit()
end

function GMRedMoMgr:destroy()
	self._gmRedMoObjPoolMgr:destroy()

	self._gmRedMoObjPoolMgr = nil
	self._redIdList = nil
	self._redIdPool = nil
	self._redMoPool = nil
	self._newAddRedIdList = nil
end

function GMRedMoMgr:_update()
	local redIdPool = {}
	local redId = ""

	for _, info in pairs(RedPointModel.instance._infoDic) do
		redIdPool[info.redPointId] = info.redPointId
	end

	for go, redIdList in pairs(RedPointController.instance.redpointPool) do
		for _, redId in ipairs(redIdList) do
			redIdPool[redId] = redId
		end
	end

	for masterRedId, servantRedIdList in pairs(RedPointModel.instance:getMsRedPool()) do
		for _, servantRedId in ipairs(servantRedIdList) do
			redIdPool[servantRedId] = servantRedId
		end

		redIdPool[masterRedId] = masterRedId
	end

	local cycleDataList = RedPointExConfig.instance:getRpeCycleDataList()

	for _, data in pairs(cycleDataList) do
		redId = data.cycleRedId
		redIdPool[redId] = redId
	end

	local onceDataList = RedPointExConfig.instance:getRpeOnceDataList()

	for _, data in pairs(onceDataList) do
		redId = data.onceRedId
		redIdPool[redId] = redId
	end

	for _, redId in ipairs(self._newAddRedIdList) do
		redId = tostring(redId)

		if not string.nilorempty(redId) then
			redIdPool[redId] = redId
		else
			printError("尝试插入一个空的红点")
		end
	end

	table.clear(self._redIdPool)

	for k, v in pairs(redIdPool) do
		redId = tostring(k)
		self._redIdPool[redId] = redId
	end

	table.clear(redIdPool)

	self._redIdList = TableUtil.toList(self._redIdPool)

	self:_clearRedMo()

	for _, redId in pairs(self._redIdPool) do
		self._redMoPool[redId] = self._gmRedMoObjPoolMgr:fetchRedMo(redId)
	end

	GlobalDispatcher:dispatch(GlobalNotify.GMRedMoMgrUpdateFinish)
end

function GMRedMoMgr:_clearRedMo()
	for redId, mo in pairs(self._redMoPool) do
		self._gmRedMoObjPoolMgr:returnRedMo(mo)
	end

	table.clear(self._redMoPool)
end

function GMRedMoMgr:addRedIds(redIdList)
	self._newAddRedIdList = TableUtil.deepcopy(redIdList)

	self:_update()
end

function GMRedMoMgr:getRedIdList()
	return self._redIdList or {}
end

function GMRedMoMgr:getRedIdPool()
	return self._redIdPool or {}
end

function GMRedMoMgr:getRedMo(redId)
	return self._redMoPool[tostring(redId)]
end

return GMRedMoMgr
