-- chunkname: @/tmp/or_script/lua_compile/dm/gameupdate/GameExtPackUpdaterManager.lua

local updaters = {}
local tickEntry
local netState = -1

GameExtPackUpdaterManager = {}

function GameExtPackUpdaterManager.getUpdater()
	local extUpdater = GameExtPackUpdater:new()
	local oldrun = extUpdater.run

	function extUpdater.run(...)
		oldrun(...)
		table.insert(updaters, extUpdater)
		GameExtPackUpdaterManager.check()
	end

	return extUpdater
end

function GameExtPackUpdaterManager.getTotalReceivedSize()
	local totalBytesReceived = 0

	for i = #updaters, 1, -1 do
		totalBytesReceived = totalBytesReceived + updaters[i]:getTotalReceivedSize()
	end

	return totalBytesReceived
end

function GameExtPackUpdaterManager.getTotalExpectedSize()
	local totalBytesExpected = 0

	for i = #updaters, 1, -1 do
		totalBytesExpected = totalBytesExpected + updaters[i]:getTotalExpectedSize()
	end

	return totalBytesExpected
end

function GameExtPackUpdaterManager.check()
	local needCheck = false

	for i = #updaters, 1, -1 do
		if not updaters[i]:isAllDownloadFinish() then
			needCheck = true
		else
			table.remove(updaters, i)
		end
	end

	if needCheck then
		if tickEntry == nil then
			print("开启下载网络监测")

			tickEntry = cc.Director:getInstance():getScheduler():scheduleScriptFunc(function(dt)
				for i = #updaters, 1, -1 do
					if updaters[i]:isAllDownloadFinish() then
						table.remove(updaters, i)
					end
				end

				local curNetState = 1

				if app.getDevice and app.getDevice() then
					curNetState = app.getDevice():getNetworkStatus()
				end

				if netState ~= curNetState then
					if curNetState == 2 or curNetState == 0 then
						for i = #updaters, 1, -1 do
							local updater = updaters[i]

							if not updater:isAllDownloadFinish() and (not updater:ignoreNetState() or curNetState == 0) and not updater:isPause() then
								updater:autoPauseTask()
								updater:onAutoPause()
								print("网络变为4G自动暂停下载任务")
							end
						end
					elseif curNetState == 1 then
						for i = #updaters, 1, -1 do
							local updater = updaters[i]

							if not updater:isAllDownloadFinish() and updater:isAutoPause() then
								updater:resumeTask()
								updater:onAutoResume()
								print("网络变为wifi自动恢复下载任务")
							end
						end
					end

					netState = curNetState
				end

				if #updaters == 0 then
					print("停止下载网络监测")
					cc.Director:getInstance():getScheduler():unscheduleScriptEntry(tickEntry)

					tickEntry = nil
				end
			end, 1, false)
		end
	elseif tickEntry then
		print("停止下载网络监测")
		cc.Director:getInstance():getScheduler():unscheduleScriptEntry(tickEntry)

		tickEntry = nil
	end
end
