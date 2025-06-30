-- chunkname: @IQIGame\\Module\\UnlockFunction\\UnlockFunctionModule.lua

UnlockFunctionModule = {}

function UnlockFunctionModule.IsUnlock(id)
	if PlayerModule.PlayerInfo.functionTypes ~= nil then
		for i, v in pairs(PlayerModule.PlayerInfo.functionTypes) do
			if v == id then
				return true
			end
		end
	end

	return false
end

function UnlockFunctionModule.CanUserOperate(cid)
	if not GmListModule.EnableGuide() or PlayerModule.PlayerInfo.disableGuide then
		return true
	end

	local cfgFunctionTypeData = CfgFunctionTypeTable[cid]

	if cfgFunctionTypeData.UserOpUnlockMaze == 0 then
		return true
	end

	local cfgMazeInstanceData = CfgMazeInstanceTable[cfgFunctionTypeData.UserOpUnlockMaze]
	local cfgChapterData = CfgChapterTable[cfgMazeInstanceData.ChapterId]
	local mazeInfo = PlayerModule.PlayerInfo.mazeInfoPOD[cfgFunctionTypeData.UserOpUnlockMaze]

	if mazeInfo == nil and GuideModule.currentGuide == nil then
		NoticeModule.ShowNoticeNoCallback(21045014, MiscApi:GetString("FunctionUserOpUnlockMazeName", cfgChapterData.Name, cfgChapterData.Order, cfgMazeInstanceData.Name, cfgMazeInstanceData.Order))

		return false
	end

	return true
end

function UnlockFunctionModule.LockTitle(id)
	return CfgFunctionTypeTable[id].LockNotice
end

function UnlockFunctionModule.GetUnlockFunctionCfg(id)
	for i, v in pairsCfg(CfgFunctionTypeTable) do
		if v.Id == id then
			return v
		end
	end

	return nil
end

function UnlockFunctionModule.OpenUnlock(id)
	local meta = UnlockFunctionModule.GetUnlockFunctionCfg(id)

	if meta ~= nil then
		EventDispatcher.Dispatch(EventID.UnlockFunction, id)

		if CfgFunctionTypeTable[id].IsNeedShow then
			NoticeModule.AddQueueTipData(id, NoticeModule.QueueTip.tipTypeEnum.UnlockFunction)
		else
			EventDispatcher.Dispatch(EventID.RefreshMainUIUnlockBtn, id)
		end

		NoticeModule.CheckNeedShowQueueTip()
	else
		logError("没有找到FunctionTypeId: " .. id)
	end
end
