-- chunkname: @IQIGame\\Util\\AssetUtil.lua

AssetUtil = {
	__LoadedAssets = {},
	__LoadingImageCache = {},
	__ImageCurrentPathMap = {},
	__OwnerCache = {}
}

function AssetUtil.LoadAsset(owner, path, onSuccess, onFail, userData)
	AssetUtil.__OwnerCache[owner] = owner

	GameEntry.Resource:LoadAsset(path, LoadAssetCallbacks(AssetUtil.OnSuccess, AssetUtil.OnFail, nil, nil), {
		owner = owner,
		onSuccess = onSuccess,
		onFail = onFail,
		userData = userData
	})
end

function AssetUtil.OnSuccess(assetName, asset, duration, userData)
	if AssetUtil.__OwnerCache[userData.owner] == nil then
		GameEntry.Resource:UnloadAsset(asset)

		return
	end

	AssetUtil.AddAssetCache(userData.owner, asset)

	if userData.onSuccess ~= nil then
		userData.onSuccess(userData.owner, assetName, asset, duration, userData.userData)
	end
end

function AssetUtil.AddAssetCache(owner, asset)
	local assetList = AssetUtil.__LoadedAssets[owner]

	if assetList == nil then
		assetList = {}
		AssetUtil.__LoadedAssets[owner] = assetList
	end

	table.insert(assetList, asset)
end

function AssetUtil.OnFail(assetName, status, errorMessage, userData)
	logError("资源" .. assetName .. "加载出错，请根据资源名称查询错误并修改配表，如果无法找到，请立刻联系程序处理。ErrorMessage: " .. errorMessage)

	if AssetUtil.__OwnerCache[userData.owner] == nil then
		return
	end

	if userData.onFail ~= nil then
		userData.onFail(userData.owner, assetName, status, errorMessage, userData.userData)
	end
end

function AssetUtil.LoadImage(owner, path, imageComponent, onSuccess, onFail, userData, hideBeforeLoaded)
	if imageComponent == nil then
		logError("AssetUtil.LoadImage Error. ErrorMessage:parameter imageComponent is null. Path:" .. path)

		return
	end

	if LuaCodeInterface.GameObjIsDestroy(imageComponent) then
		return
	end

	if AssetUtil.__ImageCurrentPathMap[owner] ~= nil then
		if path == AssetUtil.__ImageCurrentPathMap[owner][imageComponent] then
			return Constant.AssetUtilErrorCode.RepeatLoad
		end

		AssetUtil.__ImageCurrentPathMap[owner][imageComponent] = nil
	end

	AssetUtil.__OwnerCache[owner] = owner

	if hideBeforeLoaded == nil then
		hideBeforeLoaded = true
	end

	if hideBeforeLoaded then
		imageComponent.enabled = false
	end

	AssetUtil.__LoadingImageCache[imageComponent] = path

	GameEntry.Resource:LoadAsset(path, LoadAssetCallbacks(AssetUtil.OnLoadImageSuccess, AssetUtil.OnLoadImageFail, nil, nil), {
		owner = owner,
		onSuccess = onSuccess,
		onFail = onFail,
		image = imageComponent,
		userData = userData,
		hideBeforeLoaded = hideBeforeLoaded
	})
end

function AssetUtil.OnLoadImageSuccess(assetName, asset, duration, userData)
	if AssetUtil.__OwnerCache[userData.owner] == nil then
		GameEntry.Resource:UnloadAsset(asset)

		return
	end

	if LuaCodeInterface.GameObjIsDestroy(userData.image) then
		GameEntry.Resource:UnloadAsset(asset)

		return
	end

	local latestPath = AssetUtil.__LoadingImageCache[userData.image]

	if assetName ~= latestPath then
		GameEntry.Resource:UnloadAsset(asset)

		return
	end

	AssetUtil.__LoadingImageCache[userData.image] = nil
	userData.image.sprite = LuaCodeInterface.ToSprite(asset)

	if userData.hideBeforeLoaded then
		userData.image.enabled = true
	end

	AssetUtil.__ImageCurrentPathMap[userData.owner] = AssetUtil.__ImageCurrentPathMap[userData.owner] or {}
	AssetUtil.__ImageCurrentPathMap[userData.owner][userData.image] = assetName

	AssetUtil.OnSuccess(assetName, asset, duration, userData)
end

function AssetUtil.OnLoadImageFail(assetName, status, errorMessage, userData)
	if AssetUtil.__OwnerCache[userData.owner] == nil then
		return
	end

	local latestPath = AssetUtil.__LoadingImageCache[userData.image]

	if assetName ~= latestPath then
		return
	end

	AssetUtil.__LoadingImageCache[userData.image] = nil

	AssetUtil.OnFail(assetName, status, errorMessage, userData)
end

function AssetUtil.UnloadAsset(owner)
	AssetUtil.__OwnerCache[owner] = nil

	local assets = AssetUtil.__LoadedAssets[owner]

	if assets ~= nil then
		for i = 1, #assets do
			GameEntry.Resource:UnloadAsset(assets[i])

			assets[i] = nil
		end

		AssetUtil.__LoadedAssets[owner] = nil
	end

	local imagePathMap = AssetUtil.__ImageCurrentPathMap[owner]

	if imagePathMap ~= nil then
		for image, path in pairs(imagePathMap) do
			imagePathMap[image] = nil
		end

		AssetUtil.__ImageCurrentPathMap[owner] = nil
	end
end

function AssetUtil.PrintAssetCacheHandle()
	local debugStr = "Lua: 未卸载的资源：\n"

	for owner, assets in pairs(AssetUtil.__LoadedAssets) do
		local ownerName

		if type(owner) == "table" then
			if owner.UIController ~= nil and owner.__ctype ~= nil then
				ownerName = owner.UIController.UIName
			else
				ownerName = "Controller: "

				local viewStr = ""

				for fieldName, fieldValue in pairs(owner) do
					if type(fieldValue) ~= "function" then
						if type(fieldValue) ~= "number" and type(fieldValue) ~= "string" and type(fieldValue) ~= "boolean" and fieldValue.GetType ~= nil and fieldValue:GetType() == typeof(UnityEngine.GameObject) then
							viewStr = viewStr .. "[" .. fieldName .. ": " .. fieldValue.name .. "] "
						else
							viewStr = viewStr .. "[" .. fieldName .. ": " .. tostring(fieldValue) .. "] "
						end
					end

					if viewStr == "" then
						if owner.Host ~= nil then
							viewStr = viewStr .. "[Host: " .. owner.Host.UIController.UIName .. "]"
						elseif owner.UIController ~= nil then
							viewStr = viewStr .. "[Host: " .. owner.UIController.UIName .. "]"
						end
					end
				end

				ownerName = ownerName .. viewStr
			end
		else
			ownerName = tostring(owner)
		end

		debugStr = debugStr .. "Handle " .. ownerName .. ". \n"
	end

	warning(debugStr)
end

function AssetUtil.LoadImage_SetNativeSize(owner, path, imageGo)
	local imageComponent = imageGo:GetComponent("Image")

	AssetUtil.LoadImage(owner, path, imageComponent, function()
		imageComponent:SetNativeSize()
	end)
end

function AssetUtil.LoadImage_VerticalDraw(owner, path, imageGo)
	local imageComponent = imageGo:GetComponent("Image")

	AssetUtil.LoadImage(owner, path, imageComponent, function()
		imageComponent:SetNativeSize()
		LuaUtility.SetImageRectTransformPivot(imageGo:GetComponent("RectTransform"), imageComponent)
	end)
end

function AssetUtil.LoadImage_SpriteRenderer(owner, path, spriteRendererGo)
	local spriteRenderer = spriteRendererGo.gameObject:GetComponent(typeof(UnityEngine.SpriteRenderer))

	AssetUtil.LoadAsset(owner, path, function(_owner, _assetName, _asset, _duration, _userData)
		local sprite = UnityEngine.Object.Instantiate(_asset)

		_userData.SpriteRendererCom.sprite = sprite
	end, function()
		warning("load Sprite Error. {0}", path)
	end, {
		SpriteRendererCom = spriteRenderer
	})
end
