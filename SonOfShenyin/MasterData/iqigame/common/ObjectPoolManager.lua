-- chunkname: @IQIGame\\Common\\ObjectPoolManager.lua

ObjectPoolManager = Class("ObjectPoolManager")

local this = ObjectPoolManager

ObjectPoolManager.AssetType = {
	Other = 2,
	GameObject = 1
}

function this:ctor()
	if self.mPoolNode == nil then
		self:Init()
	end
end

function this:Init()
	self.mPoolTable = {}
	self.mPoolNode = GameObject("PoolNode")

	GameObject.DontDestroyOnLoad(self.mPoolNode)

	self.mPoolTrans = self.mPoolNode.transform

	self.mPoolNode:SetActive(false)

	self.mClearTime = 600
end

function this:LoadAsset(game, resName, resPath, LoadresParent, assetType)
	if string.trim(resName) == "" then
		-- block empty
	end

	if not self.mPoolTable[game] then
		self.mPoolTable[game] = {}
	end

	local tempTable = self.mPoolTable[game][resName]

	if tempTable == nil then
		tempTable = {
			resList = {}
		}
		tempTable.preLoadCount = 0
		tempTable.useInstantiate = false
		tempTable.game = nil
		tempTable.resPathCnt = 0
		self.mPoolTable[game][resName] = tempTable
	end

	local resObj

	if #tempTable.resList > 0 then
		resObj = tempTable.resList[#tempTable.resList]

		table.remove(tempTable.resList, #tempTable.resList)
	elseif not assetType or assetType == ObjectPoolManager.AssetType.GameObject then
		local _obj
		local Index = 0

		while _obj == nil do
			if Index == 0 then
				logError("异步加载")

				Index = Index + 1

				AssetUtil.LoadAsset(LoadresParent, resPath, function(assetName, asset, duration, userData)
					_obj = asset

					if _obj == nil then
						logError("异常错误码  1")

						_obj = 1
					end
				end, function()
					logError("异常错误码  2")

					_obj = 2
				end)
			end
		end

		if _obj == nil or _obj == 1 or _obj == 2 then
			return nil
		end

		resObj = GameObject.Instantiate(_obj)

		resObj:SetActive(true)

		tempTable.useInstantiate = true
		tempTable.game = game
		tempTable.resPathCnt = tempTable.resPathCnt + 1
	end

	self.mPoolTable[game][resName] = tempTable

	return resObj
end

function this:AsyncLoadAsset(game, resName, resPath, LoadresParent, callBack, args, assetType)
	if not self.mPoolTable[game] then
		self.mPoolTable[game] = {}
	end

	local tempTable = self.mPoolTable[game][resName]

	if tempTable == nil then
		tempTable = {
			resList = {}
		}
		tempTable.preLoadCount = 0
		tempTable.usedFrame = 0
		tempTable.useInstantiate = false
		tempTable.game = nil
		tempTable.resPathCnt = 0
		self.mPoolTable[game][resName] = tempTable
	end

	local resObj

	if #tempTable.resList > 0 then
		resObj = tempTable.resList[#tempTable.resList]

		table.remove(tempTable.resList, #tempTable.resList)

		if callBack then
			callBack(resObj, args)
		end
	else
		AssetUtil.LoadAsset(LoadresParent, resPath, function(oldself, assetName, asset, duration, userData)
			local resObj

			if asset ~= nil then
				resObj = UnityEngine.Object.Instantiate(asset)

				resObj:SetActive(true)
				resObj.transform:SetParent(self.mPoolTrans)

				tempTable.useInstantiate = true
				tempTable.game = game
				tempTable.resPathCnt = tempTable.resPathCnt + 1
			else
				logError("对象池异步加载资源错误 1")
			end

			if callBack then
				callBack(resObj, args)
			end
		end, function()
			logError("对象池异步加载资源错误 2")
		end)
	end
end

function this:KLload(assetName, asset, duration, userData)
	if asset ~= nil then
		local resObj

		tempTable.useInstantiate = true
		tempTable.game = game
		tempTable.resPathCnt = tempTable.resPathCnt + 1
	else
		logError("对象池异步加载资源错误 1")
	end
end

function this:UnLoadAsset(game, resName, gameObject, LoadresParent, assetType, clean)
	if clean and (not resName or true) then
		return
	end

	if gameObject == nil then
		logError("有空卸载---请检查")

		return
	end

	if not self.mPoolTable[game] then
		self.mPoolTable[game] = {}
	end

	local pool = self.mPoolTable[game][resName]

	if pool == nil or pool.resList == nil then
		logError("对象池卸载异常+++++++++++++++++++++   " .. tostring(resName) .. tostring(pool == nil))

		return
	end

	local scale = gameObject.transform.localScale

	gameObject.transform:SetParent(self.mPoolTrans)

	gameObject.transform.localScale = scale

	table.insert(pool.resList, gameObject)
end

function this:UnLoadGameAsset(game, resName)
	for outIndex, gameData in pairs(self.mPoolTable) do
		if game == outIndex then
			local tempIndex = 1

			for index, assetData in pairs(gameData) do
				if not resName or resName == index then
					if assetData.resList then
						for _, data in ipairs(assetData.resList) do
							if assetData.useInstantiate then
								GameObject.Destroy(data)
							end
						end
					end

					assetData.resPathCnt = 0
					assetData.resList = {}
				end

				tempIndex = tempIndex + 1
			end
		end
	end
end

function this:Shutdown()
	for outIndex, gameData in pairs(self.mPoolTable) do
		for index, assetData in pairs(gameData) do
			if assetData.resList then
				for _, data in ipairs(assetData.resList) do
					if assetData.useInstantiate then
						GameObject.Destroy(data)

						data = nil
					end
				end

				assetData.resList = {}
			end

			if assetData.game then
				for i = 1, assetData.resPathCnt do
					-- block empty
				end

				assetData.resPathCnt = 0
			end
		end
	end

	self.mPoolTable = {}

	GameObject.Destroy(self.mPoolNode)

	self.mPoolNode = nil
end
