-- chunkname: @IQIGame\\Util\\UIRecorder.lua

UIRecorder = {
	__RecordMap = {}
}

function UIRecorder.RecordOperation(interactiveObj, isLocalPersistent, activeDuration)
	if interactiveObj == nil or interactiveObj.transform == nil then
		logError("参数interactiveObj错误，不是UI可交互对象")

		return false
	end

	local uiController = interactiveObj:GetComponentInParent(typeof(UIController))
	local key = uiController.UIName .. "/" .. UIRecorder.__GetOutletPath(interactiveObj.transform)
	local value

	if activeDuration ~= nil then
		value = PlayerModule.GetServerTime() + activeDuration
	else
		value = -1
	end

	local existRecord = UIRecorder.GetRecord(interactiveObj, isLocalPersistent)

	if existRecord == -1 then
		return false
	end

	if isLocalPersistent then
		UIRecorder.__RecordInLocalStorage(PlayerModule.PlayerInfo.baseInfo.pid, key, value)
	else
		UIRecorder.__RecordInMemory(key, value)
	end

	return true
end

function UIRecorder.GetRecord(interactiveObj, isLocalPersistent)
	if interactiveObj == nil or interactiveObj.transform == nil then
		logError("参数interactiveObj错误，不是UI可交互对象")

		return
	end

	local uiController = interactiveObj:GetComponentInParent(typeof(UIController))
	local pid = PlayerModule.PlayerInfo.baseInfo.pid
	local key = uiController.UIName .. "/" .. UIRecorder.__GetOutletPath(interactiveObj.transform)

	return UIRecorder.__GetRecord(pid, key, isLocalPersistent)
end

function UIRecorder.HasRecord(interactiveObj, isLocalPersistent)
	return UIRecorder.GetRecord(interactiveObj, isLocalPersistent) ~= nil
end

function UIRecorder.__GetOutletPath(trans)
	local transList = {}
	local it = trans

	while true do
		table.insert(transList, it)

		if it.parent == nil then
			break
		else
			it = it.parent
		end
	end

	local outletNameList = {}
	local lastGo, lastOutletTable

	for i = #transList, 1, -1 do
		local transEle = transList[i]
		local foundInLastOutlet = false

		if lastOutletTable ~= nil then
			for name, obj in pairs(lastOutletTable) do
				if obj == transEle.gameObject then
					table.insert(outletNameList, name)

					foundInLastOutlet = true

					break
				end
			end
		end

		if transEle == trans and not foundInLastOutlet then
			logError("UI字段绑定不符合规范，UILuaOutlet的层级关系有错。")

			break
		end

		if lastOutletTable == nil or foundInLastOutlet then
			local tempTable = {}

			LuaCodeInterface.BindOutlet(transEle.gameObject, tempTable)

			local goHasOutlet = false

			for name, obj in pairs(tempTable) do
				goHasOutlet = true

				break
			end

			if lastOutletTable ~= nil and (goHasOutlet or transEle == trans) then
				LuaCodeInterface.ClearOutlet(lastGo, lastOutletTable)
			end

			if goHasOutlet then
				lastOutletTable = tempTable
				lastGo = transEle.gameObject
			end
		end
	end

	if #outletNameList == 0 then
		logError("没有找到任何UILuaOutlet关联，请确认需要纪录的对象处于UI内部并处于正确的绑定关系中。")

		return ""
	end

	local path = ""

	for i = 1, #outletNameList do
		local name = outletNameList[i]
		local addStr

		if path == "" then
			addStr = name
		else
			addStr = "/" .. name
		end

		path = path .. addStr
	end

	return path
end

function UIRecorder.__RecordInMemory(key, value)
	UIRecorder.__RecordMap[key] = value
end

function UIRecorder.__GetRecordInMemory(key)
	return UIRecorder.__RecordMap[key]
end

function UIRecorder.__RecordInLocalStorage(pid, key, value)
	PlayerPrefsUtil.SetInt(pid, Constant.PlayerPrefsConst.UICommonRecord .. "_" .. key, value)
end

function UIRecorder.__GetRecordInLocalStorage(pid, key)
	return PlayerPrefsUtil.GetInt(pid, Constant.PlayerPrefsConst.UICommonRecord .. "_" .. key)
end

function UIRecorder.__GetRecord(pid, key, isLocalPersistent)
	local value

	if isLocalPersistent ~= nil then
		if isLocalPersistent then
			value = UIRecorder.__GetRecordInLocalStorage(pid, key)
		else
			value = UIRecorder.__GetRecordInMemory(key)
		end
	else
		value = UIRecorder.__GetRecordInMemory(key)

		if value == nil then
			value = UIRecorder.__GetRecordInLocalStorage(pid, key)
		end
	end

	if value == nil or value == 0 then
		return nil
	end

	if value == -1 then
		return value
	end

	if value < PlayerModule.GetServerTime() then
		return nil
	end

	return value
end
