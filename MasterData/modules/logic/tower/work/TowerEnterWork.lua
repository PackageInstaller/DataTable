-- chunkname: @modules/logic/tower/work/TowerEnterWork.lua

module("modules.logic.tower.work.TowerEnterWork", package.seeall)

local TowerEnterWork = class("TowerEnterWork", BaseWork)

function TowerEnterWork:ctor(mainViewParam, viewName)
	self._mainviewParam = mainViewParam
	self._viewName = viewName
end

function TowerEnterWork:onStart(context)
	TowerRpc.instance:sendGetTowerInfoRequest(self._openMainView, self)
end

function TowerEnterWork:_openMainView(_, resultCode, _)
	if resultCode ~= 0 then
		return
	end

	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Tower,
		TaskEnum.TaskType.TowerPermanentDeep,
		TaskEnum.TaskType.TowerCompose
	}, function(_, taskCode, _)
		if taskCode == 0 then
			StoreRpc.instance:sendGetStoreInfosRequest(StoreEnum.TowerStore, function(_, _, storeCode)
				if storeCode == 0 then
					local isDeepLayerUnlock = TowerPermanentDeepModel.instance:checkDeepLayerUnlock()

					if isDeepLayerUnlock then
						TowerDeepRpc.instance:sendTowerDeepGetInfoRequest(function(_, towerDeepCode, _)
							if towerDeepCode == 0 then
								ViewMgr.instance:openView(self._viewName, self._mainviewParam)
								self:onDone(true)
							end
						end)
					else
						ViewMgr.instance:openView(self._viewName, self._mainviewParam)
						self:onDone(true)
					end
				end
			end, self)
		end
	end)
end

function TowerEnterWork:clearWork()
	return
end

return TowerEnterWork
