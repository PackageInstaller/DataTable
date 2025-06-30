-- chunkname: @IQIGame\\Module\\Dialog\\DialogModule.lua

DialogModule = {
	LastDialogCid = 0,
	Pausing = false
}

function DialogModule.Pause()
	DialogModule.Pausing = true
end

function DialogModule.Resume()
	DialogModule.Pausing = false

	if DialogModule.DataWhenPause ~= nil then
		UIModule.Open(Constant.UIControllerName.DialogUI, Constant.UILayer.UI, DialogModule.DataWhenPause)

		DialogModule.DataWhenPause = nil
	end
end

function DialogModule.OpenDialog(dialogCid, isInMaze, serverMode)
	local userData = {
		dialogCid = dialogCid,
		isInMaze = isInMaze,
		serverMode = serverMode
	}

	if DialogModule.Pausing then
		if DialogModule.DataWhenPause ~= nil then
			logError("打开对话出错：存在还没有被使用的对话缓存数据. 当前对话id：" .. dialogCid .. " 上一次对话id：" .. DialogModule.LastDialogCid)

			return
		end

		DialogModule.DataWhenPause = userData

		return
	end

	if isInMaze and serverMode then
		logError("对话不能既是迷宫对话，又是服务器模式。")
	end

	DialogModule.LastDialogCid = dialogCid

	UIModule.Open(Constant.UIControllerName.DialogUI, Constant.UILayer.UI, userData)
end

function DialogModule.CheckSkip(dialogCid, onConfirm)
	local cfgDialogData = CfgDialogTable[dialogCid]
	local cfgDialogProfileData

	if cfgDialogData.ProfileId ~= 0 then
		cfgDialogProfileData = CfgDialogProfileTable[cfgDialogData.ProfileId]
	end

	if cfgDialogProfileData == nil then
		onConfirm()

		return
	end

	UIModule.Open(Constant.UIControllerName.DialogSkipConfirmUI, Constant.UILayer.UI, {
		subTitle = cfgDialogProfileData.Title,
		profile = cfgDialogProfileData.Describe,
		onConfirm = onConfirm
	})
end

function DialogModule.Shutdown()
	DialogModule.Pausing = false
	DialogModule.DataWhenPause = nil
	DialogModule.LastDialogCid = 0
end
