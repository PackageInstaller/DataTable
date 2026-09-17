local var_0_0 = {}

var_0_0.co_check = nil
var_0_0.downloadInfo = {}

function var_0_0.resetInfo(arg_1_0)
	arg_1_0.co_check = nil
	arg_1_0.downloadInfo = {}
end

local function var_0_1(arg_2_0)
	return arg_2_0:find("roleimage/") or arg_2_0:find("live2d/") or arg_2_0:find("sound/") or arg_2_0:find("spine/") or arg_2_0:find("equipment/")
end

function var_0_0:checkResource()
	self:resetInfo()

	self.co_check = coroutine.create(function()
		local file_check_manager = require("controller.filedownloader.file_check_manager")
		local var_4_1 = {}
		local var_4_2 = 0
		local var_4_3 = 0

		for iter_4_0, iter_4_1 in pairs((file_check_manager:getAllFileList())) do
			if var_0_1(iter_4_1.file) and not iter_4_1.file:find(" ") and file_check_manager:checkFileNeedDownload(iter_4_1.file) then
				table.insert(var_4_1, file_check_manager:getFileDownloadInfo(iter_4_1.file))

				var_4_2 = var_4_2 + iter_4_1.size
			end

			var_4_3 = var_4_3 + 1

			if var_4_3 >= 5000 then
				var_4_3 = 0

				coroutine.yield(iter_4_0)
			end
		end

		self.downloadInfo.totalsize = var_4_2
		self.downloadInfo.totallist = var_4_1

		return "end"
	end)

	self:startCheck()
end

function var_0_0.startCheck(arg_5_0)
	local var_5_0

	var_5_0 = cc.Director:getInstance():getScheduler():scheduleScriptFunc(function()
		local var_6_0, var_6_1 = coroutine.resume(arg_5_0.co_check)

		print("Coroutine Resule: ", var_6_1)

		if var_6_1 == "end" then
			cc.Director:getInstance():getScheduler():unscheduleScriptEntry(var_5_0)
			arg_5_0:onCheckComplete()
		end
	end, 0, false)
end

function var_0_0.onCheckComplete(arg_7_0)
	cc.Director:getInstance():getEventDispatcher():dispatchEvent((cc.EventCustom:new("CHECK_DOWNLOAD_RESOURCE_COMPLETE")))
end

function var_0_0:getDownloadList()
	return self.downloadInfo.totallist
end

function var_0_0:getDownloadSize()
	return self.downloadInfo.totalsize
end

return var_0_0
