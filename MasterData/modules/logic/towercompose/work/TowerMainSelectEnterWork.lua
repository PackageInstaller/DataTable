-- chunkname: @modules/logic/towercompose/work/TowerMainSelectEnterWork.lua

module("modules.logic.towercompose.work.TowerMainSelectEnterWork", package.seeall)

local TowerMainSelectEnterWork = class("TowerMainSelectEnterWork", BaseWork)

function TowerMainSelectEnterWork:ctor(mainViewParam)
	self._mainviewParam = mainViewParam
end

function TowerMainSelectEnterWork:onStart(context)
	TowerRpc.instance:sendGetTowerInfoRequest(self._openMainSelectView, self)
end

function TowerMainSelectEnterWork:_openMainSelectView(_, resultCode, _)
	if resultCode ~= 0 then
		return
	end

	if self._mainviewParam then
		local notReset = self._mainviewParam.isNotReset

		TowerComposeRpc.instance:sendTowerComposeGetInfoRequest(not notReset, function(_, _, infoCode)
			if infoCode == 0 then
				TaskRpc.instance:sendGetTaskInfoRequest({
					TaskEnum.TaskType.Tower,
					TaskEnum.TaskType.TowerCompose
				}, function(_, _, taskCode)
					if taskCode == 0 then
						ViewMgr.instance:openView(ViewName.TowerMainSelectView)
						self:onDone(true)
					end
				end, self)
			end
		end, self)
	end
end

function TowerMainSelectEnterWork:clearWork()
	return
end

return TowerMainSelectEnterWork
