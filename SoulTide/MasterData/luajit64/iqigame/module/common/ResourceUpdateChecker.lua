-- chunkname: @IQIGame\\Module\\Common\\ResourceUpdateChecker.lua

local m = {
	isDownloading = false,
	isCheckingMD5 = false
}

function m.CheckResourcesByTag(tag, onComplete)
	if tag == nil then
		logError("tag不能为空")

		return
	end

	m._CheckResourcesByTags({
		tag
	}, onComplete, true)
end

function m.CheckResourcesByTags(tags, onComplete)
	if tags == nil then
		logError("tags不能为空")

		return
	end

	m._CheckResourcesByTags(tags, onComplete, false)
end

function m._CheckResourcesByTags(tags, onComplete, onlyOneTag)
	m.checkingTags = tags
	m.checkCallback = onComplete

	local list = LuaCodeInterface.ConvertTableToIntList(tags)

	IQIGame.Onigao.Game.GameEntry.Resource:CheckResourcesByTags(list, function(removedCount, updateCount, updateTotalLength, updateTotalZipLength)
		if m.checkCallback ~= nil then
			local returnTagObj = tags

			if onlyOneTag then
				returnTagObj = tags[1]
			end

			m.checkCallback(returnTagObj, updateCount, tonumber(tostring(updateTotalLength)))

			m.checkCallback = nil
		end
	end)
end

function m.CheckResourcesForRepair(onComplete)
	m.isCheckingMD5 = true
	m.checkCallback = onComplete

	IQIGame.Onigao.Game.GameEntry.Resource:CalcNativeResourceMd5(function(removedCount, updateCount, updateTotalLength, updateTotalZipLength)
		if m.checkCallback ~= nil then
			m.checkCallback(updateCount, tonumber(tostring(updateTotalLength)))

			m.checkCallback = nil
		end
	end)
end

function m.UpdateResourcesByTag(tag, onComplete)
	local tags

	if tag ~= nil then
		tags = {
			tag
		}
	end

	m._UpdateResources(tags, false, onComplete, true)
end

function m.UpdateResourcesByTags(tags, onComplete)
	m._UpdateResources(tags, false, onComplete, false)
end

function m.UpdateResourcesForRepair(onComplete)
	m._UpdateResources(nil, true, onComplete, false)
end

function m._UpdateResources(tags, isRepair, onComplete, onlyOneTag)
	if tags == nil and not isRepair then
		logError("参数非法")

		return
	end

	if tags ~= nil and isRepair then
		logError("参数tags和isRepair互斥")

		return
	end

	if m.checkingTags == nil and not m.isCheckingMD5 then
		logError("尚未检查资源，请程序于交互处规避此报错。")

		return
	end

	local errorMsg = "请求更新的资源与上一次检查的资源类型不匹配。"

	if tags ~= nil then
		if not onlyOneTag and (m.checkingTags == nil or not table.elementEquals(tags, m.checkingTags)) then
			logError(errorMsg)

			return
		end

		if onlyOneTag and (m.checkingTags == nil or m.checkingTags[1] ~= tags[1]) then
			logError(errorMsg)

			return
		end
	elseif isRepair and (not m.isCheckingMD5 or m.isCheckingMD5 ~= isRepair) then
		logError(errorMsg)

		return
	end

	if m.isDownloading then
		return
	end

	m.downloadedCallback = onComplete
	m.isDownloading = true

	IQIGame.Onigao.Game.GameEntry.Resource:UpdateResources(function(resourceGroup, isAllComplete)
		m.checkingTags = nil
		m.isDownloading = false

		local returnTagObj = tags

		if onlyOneTag then
			returnTagObj = tags[1]
		end

		if m.downloadedCallback ~= nil then
			m.downloadedCallback(returnTagObj, isRepair, isAllComplete)

			m.downloadedCallback = nil
		end

		if onlyOneTag then
			EventDispatcher.Dispatch(EventID.DownloadResByTagComplete, returnTagObj, isRepair, isAllComplete)
		else
			EventDispatcher.Dispatch(EventID.DownloadResByTagsComplete, returnTagObj, isRepair, isAllComplete)
		end
	end)
end

function m.RemoveCheckCallback(callback)
	if m.checkCallback == callback then
		m.checkCallback = nil
	end
end

function m.RemoveUpdateCallback(callback)
	if m.downloadedCallback == callback then
		m.downloadedCallback = nil
	end
end

function m.GetSizeStr(resSize)
	if type(resSize) ~= Constant.Type.Number then
		logError("输入参数不是数字类型")

		return "0B"
	end

	local size = resSize / 1024
	local sizeStr

	if size >= 1024 then
		size = size / 1024

		if size < 10 then
			size = math.round(size * 10) / 10
		else
			size = math.round(size)
		end

		sizeStr = size .. "M"
	else
		sizeStr = math.round(size) .. "K"
	end

	return sizeStr
end

ResourceUpdateChecker = m
