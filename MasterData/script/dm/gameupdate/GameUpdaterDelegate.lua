-- chunkname: @/tmp/or_script/lua_compile/dm/gameupdate/GameUpdaterDelegate.lua

require("dm.gameupdate.GameUpdaterConfig")

kVMSState = {
	kVmsEnded = 2,
	kVmsStart = 1
}
GameUpdaterDelegate = GameUpdaterDelegate or {}

function GameUpdaterDelegate:new()
	local result = setmetatable({}, {
		__index = GameUpdaterDelegate
	})

	result:initialize()

	return result
end

function GameUpdaterDelegate:initialize()
	self._callBack = nil
end

function GameUpdaterDelegate:setCallback(callback)
	self._callBack = callback
end

function GameUpdaterDelegate:vmsRequestError(status, statusText, response)
	GameUpdaterDebuger:print("************************")
	GameUpdaterDebuger:print("vmsRequestError")

	if status and statusText then
		GameUpdaterDebuger:print("vmsRequestError.status:%d", status)
		GameUpdaterDebuger:print("vmsRequestError.statusText:%d:%s", statusText)
	else
		GameUpdaterDebuger:print("vmsRequestError.status or vmsRequestError.statusText is nil")
	end

	GameUpdaterDebuger:print(">>>>>>>>>>>>>>>>>>>>>>>>")

	local data = {
		type = "vmsRequestError",
		data = {
			status = status,
			statusText = statusText
		}
	}

	if self._callBack then
		self._callBack(data)
	end
end

function GameUpdaterDelegate:vmsReuqestState(state)
	GameUpdaterDebuger:print("************************")
	GameUpdaterDebuger:print("vms state: %d", state)
	GameUpdaterDebuger:print(">>>>>>>>>>>>>>>>>>>>>>>>")

	local data = {
		type = "vmsState",
		state = state
	}

	if self._callBack then
		self._callBack(data)
	end
end

function GameUpdaterDelegate:onTaskProgress(task, bytesReceived, totalBytesReceived, totalBytesExpected)
	GameUpdaterDebuger:print("************************")
	GameUpdaterDebuger:print("progress")
	GameUpdaterDebuger:print("task.identifier:%s", task.identifier)
	GameUpdaterDebuger:print("task.requestURL:%s", task.requestURL)
	GameUpdaterDebuger:print("task.storagePath:%s", task.storagePath)
	GameUpdaterDebuger:print("bytesReceived:%d", bytesReceived)
	GameUpdaterDebuger:print("totalBytesReceived:%d", totalBytesReceived)
	GameUpdaterDebuger:print("totalBytesExpected:%d", totalBytesExpected)
	GameUpdaterDebuger:print(">>>>>>>>>>>>>>>>>>>>>>>>")

	local data = {
		type = "downloading",
		data = {
			task = task,
			bytesReceived = bytesReceived,
			totalBytesReceived = totalBytesReceived,
			totalBytesExpected = totalBytesExpected
		}
	}

	if self._callBack then
		self._callBack(data)
	end
end

function GameUpdaterDelegate:onFileTaskSuccess(task)
	GameUpdaterDebuger:print("************************")
	GameUpdaterDebuger:print("success")
	GameUpdaterDebuger:print("task.identifier:%s", task.identifier)
	GameUpdaterDebuger:print("task.requestURL:%s", task.requestURL)
	GameUpdaterDebuger:print("task.storagePath:%s", task.storagePath)
	GameUpdaterDebuger:print(">>>>>>>>>>>>>>>>>>>>>>>>")

	local data = {
		type = "downloadFinish",
		data = {
			task = task
		}
	}

	if self._callBack then
		self._callBack(data)
	end
end

function GameUpdaterDelegate:onFileTaskStart(task)
	GameUpdaterDebuger:print("************************")
	GameUpdaterDebuger:print("download pack start")
	GameUpdaterDebuger:print("task.identifier:%s", task.identifier)
	GameUpdaterDebuger:print("task.requestURL:%s", task.requestURL)
	GameUpdaterDebuger:print("task.storagePath:%s", task.storagePath)
	GameUpdaterDebuger:print(">>>>>>>>>>>>>>>>>>>>>>>>")

	local data = {
		type = "downloadStart",
		data = {
			task = task
		}
	}

	if self._callBack then
		self._callBack(data)
	end
end

function GameUpdaterDelegate:onTaskError(task, errorCode, errorCodeInternal, errorStr)
	GameUpdaterDebuger:print("************************")
	GameUpdaterDebuger:print("error")
	GameUpdaterDebuger:print("task.identifier:%s", task.identifier)
	GameUpdaterDebuger:print("task.requestURL:%s", task.requestURL)
	GameUpdaterDebuger:print("task.storagePath:%s", task.storagePath)
	GameUpdaterDebuger:print("errorCode:%d", errorCode)
	GameUpdaterDebuger:print("errorCodeInternal:%d", errorCodeInternal)
	GameUpdaterDebuger:print("errorStr:%s", errorStr)
	GameUpdaterDebuger:print(">>>>>>>>>>>>>>>>>>>>>>>>")

	local data = {
		type = "downloadError",
		data = {
			task = task,
			errorCode = errorCode,
			errorCodeInternal = errorCodeInternal,
			errorStr = errorStr
		}
	}

	if self._callBack then
		self._callBack(data)
	end
end

function GameUpdaterDelegate:onInstallPackage(event, details)
	GameUpdaterDebuger:print("************************")
	GameUpdaterDebuger:print("installing package, event:%s, details:%s", event, details)
	GameUpdaterDebuger:print(">>>>>>>>>>>>>>>>>>>>>>>>")

	local data = {
		type = "installPackage",
		data = {
			event = event,
			details = details
		}
	}

	if self._callBack then
		self._callBack(data)
	end
end

function GameUpdaterDelegate:onUpdateFinish()
	GameUpdaterDebuger:print("************************")
	GameUpdaterDebuger:print("update finish")
	GameUpdaterDebuger:print(">>>>>>>>>>>>>>>>>>>>>>>>")

	local data = {
		type = "updateFinish"
	}

	if self._callBack then
		self._callBack(data)
	end
end

function GameUpdaterDelegate:onNoUpdate(details)
	GameUpdaterDebuger:print("************************")
	GameUpdaterDebuger:print("don't need update")
	GameUpdaterDebuger:print(">>>>>>>>>>>>>>>>>>>>>>>>")

	local data = {
		type = "noUpdate",
		data = details
	}

	if self._callBack then
		self._callBack(data)
	end
end

function GameUpdaterDelegate:onUpdate()
	GameUpdaterDebuger:print("************************")
	GameUpdaterDebuger:print("need update")
	GameUpdaterDebuger:print(">>>>>>>>>>>>>>>>>>>>>>>>")

	local data = {
		type = "update"
	}

	if self._callBack then
		self._callBack(data)
	end
end

function GameUpdaterDelegate:onForceUpdate()
	GameUpdaterDebuger:print("************************")
	GameUpdaterDebuger:print("need force update")
	GameUpdaterDebuger:print(">>>>>>>>>>>>>>>>>>>>>>>>")

	local data = {
		type = "forceupdate"
	}

	if self._callBack then
		self._callBack(data)
	end
end

function GameUpdaterDelegate:onMaintain(notice)
	GameUpdaterDebuger:print("************************")
	GameUpdaterDebuger:print("need maintain")
	GameUpdaterDebuger:print(">>>>>>>>>>>>>>>>>>>>>>>>")

	local data = {
		type = "maintain",
		notice = notice
	}

	if self._callBack then
		self._callBack(data)
	end
end

function GameUpdaterDelegate:onEnsureUpdate(size, totalBytesReceived, vmsData)
	GameUpdaterDebuger:print("************************")
	GameUpdaterDebuger:print("ensure update")
	GameUpdaterDebuger:print(">>>>>>>>>>>>>>>>>>>>>>>>")

	local data = {
		type = "ensureUpdate",
		size = size,
		totalBytesReceived = totalBytesReceived,
		vmsData = vmsData
	}

	if self._callBack then
		self._callBack(data)
	end
end

function GameUpdaterDelegate:onUpdateError()
	GameUpdaterDebuger:print("************************")
	GameUpdaterDebuger:print("update data error")
	GameUpdaterDebuger:print(">>>>>>>>>>>>>>>>>>>>>>>>")

	local data = {
		type = "updateError"
	}

	if self._callBack then
		self._callBack(data)
	end
end

function GameUpdaterDelegate:onDownloadError()
	GameUpdaterDebuger:print("************************")
	GameUpdaterDebuger:print("download package error")
	GameUpdaterDebuger:print(">>>>>>>>>>>>>>>>>>>>>>>>")

	local data = {
		type = "downloadError"
	}

	if self._callBack then
		self._callBack(data)
	end
end
