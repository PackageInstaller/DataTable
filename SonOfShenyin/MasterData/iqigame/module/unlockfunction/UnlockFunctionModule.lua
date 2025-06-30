-- chunkname: @IQIGame\\Module\\UnlockFunction\\UnlockFunctionModule.lua

UnlockFunctionModule = {
	GMFuncType = 15
}

function UnlockFunctionModule.Initialize()
	UnlockFunctionModule.funcQueue = Queue.New()
end

function UnlockFunctionModule.OnClickInterceptor(funcType)
	local isLock = UnlockFunctionModule.IsUnlock(funcType)

	if not isLock then
		local funcSwitchCfg = UnlockFunctionModule.GetFuncSwitchByType(funcType)

		if funcSwitchCfg then
			NoticeModule.ShowNotice(funcSwitchCfg.LockNotice)

			return true
		end
	end

	return false
end

function UnlockFunctionModule.IsUnlock(funcType)
	if funcType == 0 then
		return true
	end

	if PlayerModule.PlayerInfo.unlockFuncs ~= nil then
		for k, v in pairs(PlayerModule.PlayerInfo.unlockFuncs) do
			if v.funcType == funcType then
				return v.state == 1
			end
		end
	end

	return false
end

function UnlockFunctionModule.RefreshFuncTypes(funcTypes)
	if table.len(funcTypes) <= 0 then
		return
	end

	for k, v in pairs(funcTypes) do
		PlayerModule.PlayerInfo.unlockFuncs[k] = v

		local funcSwitchCfg = UnlockFunctionModule.GetFuncSwitchByType(k)

		if funcSwitchCfg and funcSwitchCfg.OpenNotice and v.state == 1 and funcSwitchCfg.FuncType ~= UnlockFunctionModule.GMFuncType and funcSwitchCfg.IsShow then
			NoticeModule.funcQueue:Enqueue(funcSwitchCfg)
		end
	end

	EventDispatcher.Dispatch(EventID.UnlockFunction, funcTypes)
end

function UnlockFunctionModule.FuncSwitchHandler(components)
	for k, v in pairs(components) do
		local isUnlock = UnlockFunctionModule.IsUnlock(k)

		if isUnlock then
			v:SetActive(true)
		else
			local funcSwitchCfg = UnlockFunctionModule.GetFuncSwitchByType(k)

			if funcSwitchCfg then
				if funcSwitchCfg.ShowType == 0 then
					v:SetActive(false)
				elseif funcSwitchCfg.ShowType == 1 then
					v:SetActive(true)
				end
			else
				v:SetActive(false)
			end
		end
	end
end

function UnlockFunctionModule.GetFuncSwitchByType(funcType)
	for i, v in pairsCfg(CfgFuncSwitchTable) do
		if v.FuncType == funcType then
			return v
		end
	end

	return nil
end

function UnlockFunctionModule.Shutdown()
	UnlockFunctionModule.funcQueue:Clear()

	UnlockFunctionModule.funcQueue = nil
end
