-- chunkname: @projbooter/BootResMgr.lua

module("projbooter.BootResMgr", package.seeall)

local BootResMgr = class("BootResMgr")

BootResMgr.OriginBgPath = "bootres/prefabs/originbg.prefab"
BootResMgr.LoadingViewPath = "bootres/prefabs/loadingview.prefab"
BootResMgr.MsgBoxViewPath = "bootres/prefabs/msgboxview.prefab"
BootResMgr.NoticeViewPath = "bootres/prefabs/noticeview.prefab"
BootResMgr.VoiceViewPath = "bootres/prefabs/voicedownloadview.prefab"
BootResMgr.VersionViewPath = "bootres/prefabs/versionview.prefab"
BootResMgr.AdaptionBgViewPath = "bootres/prefabs/adaptionbg.prefab"

function BootResMgr:ctor()
	math.randomseed(tonumber(tostring(os.time()):reverse():sub(1, 7)))

	self._loadedCount = 0
	self._orginBgRoot = UnityEngine.GameObject.Find("UIRoot/OriginBg")
	self._popupTopRoot = UnityEngine.GameObject.Find("UIRoot/POPUP_TOP")
	self._topRoot = UnityEngine.GameObject.Find("UIRoot/TOP")
	self._msgRoot = UnityEngine.GameObject.Find("UIRoot/MESSAGE")
	self._allRes = {}
	self._allRes.imgs = {}
	self._hasShowIndexs = {}

	local co = self:_getRandomCO()
	local imgPath = string.format("bootres/textures/%s.png", co.bg)

	self._allRes.imgs[imgPath] = {
		path = imgPath,
		config = co
	}
	self._allRes.prefabs = {
		[BootResMgr.OriginBgPath] = {
			path = BootResMgr.OriginBgPath,
			layer = self._orginBgRoot
		},
		[BootResMgr.LoadingViewPath] = {
			path = BootResMgr.LoadingViewPath,
			layer = self._topRoot
		},
		[BootResMgr.MsgBoxViewPath] = {
			path = BootResMgr.MsgBoxViewPath,
			layer = self._msgRoot
		},
		[BootResMgr.NoticeViewPath] = {
			path = BootResMgr.NoticeViewPath,
			layer = self._topRoot
		},
		[BootResMgr.VoiceViewPath] = {
			path = BootResMgr.VoiceViewPath,
			layer = self._topRoot
		},
		[BootResMgr.VersionViewPath] = {
			path = BootResMgr.VersionViewPath,
			layer = self._popupTopRoot
		},
		[BootResMgr.AdaptionBgViewPath] = {
			path = BootResMgr.AdaptionBgViewPath,
			layer = self._topRoot
		}
	}
end

function BootResMgr:getAutoMaskGo()
	return self._allRes.prefabs[BootResMgr.AutoMaskPath].go
end

function BootResMgr:getLoadingViewGo()
	return self._allRes.prefabs[BootResMgr.LoadingViewPath].go
end

function BootResMgr:getMsgBoxGo()
	return self._allRes.prefabs[BootResMgr.MsgBoxViewPath].go
end

function BootResMgr:getNoticeViewGo()
	return self._allRes.prefabs[BootResMgr.NoticeViewPath].go
end

function BootResMgr:getVoiceViewGo()
	return self._allRes.prefabs[BootResMgr.VoiceViewPath].go
end

function BootResMgr:getVersionViewGo()
	return self._allRes.prefabs[BootResMgr.VersionViewPath].go
end

function BootResMgr:getAdaptionViewGo()
	return self._allRes.prefabs[BootResMgr.AdaptionBgViewPath].go
end

function BootResMgr:getOriginBgGo()
	return self._allRes.prefabs[BootResMgr.OriginBgPath].go
end

function BootResMgr:getLoadingBg(index, callback, callbackObj)
	if index == 1 then
		for _, v in pairs(self._allRes.imgs) do
			if callback then
				callback(callbackObj, v.texture, v.config)
			end

			return
		end
	else
		local co = self:_getRandomCO()
		local imgPath = string.format("bootres/textures/%s.png", co.bg)

		self._allRes.imgs[imgPath] = self._allRes.imgs[imgPath] or {}
		self._allRes.imgs[imgPath].path = imgPath
		self._allRes.imgs[imgPath].config = co

		if not self._allRes.imgs[imgPath].texture then
			loadAbAsset(self._allRes.imgs[imgPath].path, false, function(assetItem)
				if not self._allRes then
					return
				end

				self._allRes.imgs[imgPath].texture = assetItem:GetResource()

				if callback then
					callback(callbackObj, self._allRes.imgs[imgPath].texture, self._allRes.imgs[imgPath].config)
				end
			end)
		elseif callback then
			callback(callbackObj, self._allRes.imgs[imgPath].texture, self._allRes.imgs[imgPath].config)
		end
	end
end

function BootResMgr:_getPrefsNumber(key, defaultValue)
	local hasKey = UnityEngine.PlayerPrefs.HasKey(key)

	if hasKey then
		return UnityEngine.PlayerPrefs.GetFloat(key)
	end

	return defaultValue
end

function BootResMgr:_getRandomCO()
	local list = booterLoadingConfig()
	local bgCos = {}
	local totalWeight = 0

	for index, co in ipairs(list) do
		if not co.episodeId then
			local episodeId = 0

			if episodeId == 0 or self:_getPrefsNumber("GameEpisodeIdPassKey_" .. episodeId, 0) ~= 0 then
				table.insert(bgCos, co)
			end
		end
	end

	for index, co in ipairs(bgCos) do
		if not self._hasShowIndexs[index] then
			totalWeight = totalWeight + co.weight
		end
	end

	local rand = math.floor(math.random() * totalWeight)

	for index, co in ipairs(bgCos) do
		if not self._hasShowIndexs[index] then
			if rand < co.weight then
				self._hasShowIndexs[index] = true

				return co
			else
				rand = rand - co.weight
			end
		end
	end

	self._hasShowIndexs = {}

	local leftIndex = math.random(1, #bgCos)

	self._hasShowIndexs[leftIndex] = true

	return bgCos[leftIndex]
end

function BootResMgr:startLoading(loadedCb, cbObj)
	logNormal("BootResMgr.startLoading loadedCb = " .. tostring(loadedCb) .. " cbObj = " .. tostring(cbObj))

	self._loadedCb = loadedCb
	self._cbObj = cbObj

	for path, _ in pairs(self._allRes.prefabs) do
		self._loadedCount = self._loadedCount + 1

		loadAbAsset(path, false, self._onPrefabLoaded, self)
	end

	for _, img in pairs(self._allRes.imgs) do
		self._loadedCount = self._loadedCount + 1

		loadAbAsset(img.path, false, self._onImgLoaded, self)
	end
end

function BootResMgr:_onImgLoaded(assetItem)
	if assetItem.IsLoadSuccess then
		self._loadedCount = self._loadedCount - 1
		self._allRes.imgs[assetItem.ResPath].texture = assetItem:GetResource()

		self:_checkResLoadFinished()
	end
end

function BootResMgr:_onPrefabLoaded(assetItem)
	if assetItem.IsLoadSuccess then
		if BootResMgr.AdaptionBgViewPath == assetItem.ResPath then
			GameAdaptionBgMgr.instance:onAssetResLoaded(assetItem)
		end

		self._loadedCount = self._loadedCount - 1

		local go = assetItem:GetResource()
		local newGo = UnityEngine.GameObject.Instantiate(go)

		newGo:SetActive(false)

		if not self._allRes.prefabs[assetItem.ResPath].layer then
			newGo.transform:SetParent(self._allRes.prefabs[assetItem.ResPath].layer.transform, false)

			self._allRes.prefabs[assetItem.ResPath].go = newGo

			self:_checkResLoadFinished()
		end
	end
end

function BootResMgr:_checkResLoadFinished()
	if self._loadedCount == 0 then
		logNormal("BootResMgr onloaded, 所有的启动UI资源都加载完成了！")

		if self._loadedCb then
			self._loadedCb(self._cbObj)
		end
	end
end

function BootResMgr:dispose()
	if self._disposed then
		return
	end

	BootLoadingView.instance:dispose()
	BootMsgBox.instance:dispose()
	BootNoticeView.instance:dispose()
	BootVoiceView.instance:dispose()
	BootVersionView.instance:dispose()

	if self._allRes then
		for _, v in pairs(self._allRes.prefabs) do
			UnityEngine.GameObject.Destroy(v.go)
		end

		self._allRes = nil
	end

	self._disposed = true
end

BootResMgr.instance = BootResMgr.New()

return BootResMgr
