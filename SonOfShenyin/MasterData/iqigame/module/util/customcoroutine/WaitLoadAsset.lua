-- chunkname: @IQIGame\\Module\\Util\\CustomCoroutine\\WaitLoadAsset.lua

WaitLoadAsset = class({
	waitType = "WaitLoadAsset"
}, CustomWait)
WaitLoadAsset.IsLog = false

function WaitLoadAsset:ctor(owner, assetUrl, completeCallback)
	AssetUtil.LoadAsset(owner, assetUrl, function(_, assetUrl, asset, duration, userData)
		self.result = asset

		if type(completeCallback) == "function" then
			completeCallback(assetUrl, asset, duration, userData)
		end

		self.isComplete = true

		if WaitLoadAsset.IsLog then
			logDebug("加载资源" .. assetUrl .. "完成")
		end
	end, function(assetName, status, errorMessage, userData)
		self.isComplete = true
	end)
end

function WaitLoadAsset:Dispose()
	self.result = nil
end
