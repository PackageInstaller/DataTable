-- chunkname: @IQIGame\\Net\\NetHomeResponse.lua

function net_home.enterRootResult(code, room)
	HomeModule.OnEnterRootResult(room)
end

function net_home.upgradeHomeResult(code, homePOD)
	HomeModule.OnUpgradeHomeResult(homePOD)
end

function net_home.refreshDispTaskResult(code)
	HomeModule.OnRefreshDispTaskResult()
end

function net_home.executeDispTaskResult(code)
	HomeModule.OnExecuteDispTaskResult()
end

function net_home.submitDispTaskResult(code, shows)
	HomeModule.SubmitDispTaskResult(shows)
end

function net_home.changeRoomSkinResult(code)
	return
end

function net_home.notifyHome(home)
	HomeModule.OnNotifyHome(home)
end

function net_home.notifyRoom(homeRoom)
	HomeModule.OnNotifyRoom(homeRoom)
end

function net_home.notifyUpdateTask(tasks)
	HomeModule.OnNotifyUpdateTask(tasks)
end

function net_home.notifyRemoveTask(tasks)
	HomeModule.OnNotifyRemoveTask(tasks)
end
