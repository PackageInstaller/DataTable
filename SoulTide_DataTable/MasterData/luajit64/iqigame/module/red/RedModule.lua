-- chunkname: @IQIGame\\Module\\Red\\RedModule.lua

RedModule = {}
RedModule.ServerRedDic = {}
RedModule.ClientRedDic = {}

function RedModule.SetServerRed(readPoint)
	RedModule.ServerRedDic = readPoint

	if RedModule.ServerRedDic == nil then
		RedModule.ServerRedDic = {}
	end

	for type, show in pairs(readPoint) do
		EventDispatcher.Dispatch(EventID.RedServerNotice, type, show)
	end
end

function RedModule.IsServerRed(type)
	if RedModule.ServerRedDic[type] ~= nil then
		return RedModule.ServerRedDic[type]
	else
		return false
	end
end

function RedModule.SetClientRed(id, show)
	local typeValue = type(show)

	if typeValue ~= "boolean" then
		if RedModule.ClientRedDic[id] == nil then
			RedModule.ClientRedDic[id] = {}
		end

		local has = false

		for i, v in pairs(RedModule.ClientRedDic[id]) do
			if v.id == show.id then
				RedModule.ClientRedDic[id][i] = show
				has = true

				break
			end
		end

		if has == false then
			table.insert(RedModule.ClientRedDic[id], show)
		end

		show = show.value
	else
		RedModule.ClientRedDic[id] = show
	end

	EventDispatcher.Dispatch(EventID.RedClientNotice, id, show)
end

function RedModule.IsClientRed(id)
	if RedModule.ClientRedDic[id] ~= nil then
		local typeValue = type(RedModule.ClientRedDic[id])

		if typeValue ~= "boolean" then
			local isRed = false

			for i, v in pairs(RedModule.ClientRedDic[id]) do
				isRed = v.value

				if isRed == true then
					break
				end
			end

			return isRed
		else
			return RedModule.ClientRedDic[id]
		end
	else
		return false
	end
end
