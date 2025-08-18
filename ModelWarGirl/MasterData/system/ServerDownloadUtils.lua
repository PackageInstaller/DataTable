-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/System\\ServerDownloadUtils.lua

local UrlConfig = require("Network/UrlConfig")
local HeadHelper = require("UI/RoleInfo/HeadHelper")
local HttpUtils = Framework.Network.HttpUtils
local WebResourcesHelperForHead = Framework.Network.WebResourcesHelperForHead.Instance
local tolua = tolua
local ServerDownloadUtils = {}
local self = ServerDownloadUtils

ServerDownloadUtils.APPID = 100
ServerDownloadUtils.TENCENT_API_KEY = "FIGBZ-TKCKJ-CHKFN-FMN5S-T4O3F-MWFTH"
ServerDownloadUtils.TENCENT_API_URL = "https://apis.map.qq.com/ws/geocoder/v1/?location=%f,%f&key=%s&get_poi=1"

function ServerDownloadUtils.init()
	self.uid = CurAvatar.uid

	WebResourcesHelperForHead:setLocalCacheFolder("HeadCache")
	WebResourcesHelperForHead:setCacheValid(true)
	WebResourcesHelperForHead:setWebParams(3, -1, -1)
end

function ServerDownloadUtils.uploadImage(filePath, domain, resId, subResId, callback)
	local data = {
		scene = "head",
		resid = self.formatHeadResKey(resId, subResId)
	}

	if RegionUtils.isJP() then
		data.sdk_openid = SDKAgent.getUserID()
	end

	local _url = SvrListManager.getFileSvr():Get()

	if not RegionUtils.isTW() and not RegionUtils.isKR() and not RegionUtils.isSEA() then
		_url = string.gsub(_url, "flowfile", "upimg")
	end

	local uploadUrl = _url .. "/upload" .. domain

	HttpUtils.PostFile(uploadUrl, filePath, "file", ClientUtils.table2String(data), callback, 1)
end

function ServerDownloadUtils.uploadHead(filePath, callback, subResId)
	local token = AccountManager.getToken()
	local tokenStr = "?token=" .. token

	ServerDownloadUtils.uploadImage(filePath, tokenStr, self.uid, subResId, callback)
end

function ServerDownloadUtils.getImage(domain, resId, subResId, image, callback, skipWriteCache, readCache)
	local resKey = self.formatHeadResKey(resId, subResId)
	local url = SvrListManager.getFileSvr():Get() .. "/head/" .. resKey

	if readCache == nil then
		readCache = true
	end

	readCache = true

	if skipWriteCache then
		self.loadTextureWithoutCache(url, resKey, callback, readCache)
	else
		self.loadTexture(url, resKey, callback, readCache)
	end
end

function ServerDownloadUtils.getHeadImage(uid, subResId, callback, readCache)
	ServerDownloadUtils.getImage("head", uid, subResId, 1, callback, false, readCache)
end

function ServerDownloadUtils.displayWebImage(domain, uid, subResId, displayUI, stateTxt, readCache)
	local callback = Functor(ServerDownloadUtils.getImageCommonCallback, domain, displayUI, stateTxt)

	if stateTxt then
		stateTxt:setText(Lang.get(30052))
	end

	ServerDownloadUtils.getHeadImage(uid, subResId, callback, readCache)
end

function ServerDownloadUtils.displayHeadWithUidCheck(uid, subResId, displayUI, uiRoot, readCache)
	local callback = Functor(ServerDownloadUtils.checkHeadCallback, uid, displayUI, uiRoot)

	ServerDownloadUtils.getHeadImage(uid, subResId, callback, readCache)
end

function ServerDownloadUtils.checkHeadCallback(uid, displayUI, uiRoot, code, texture, msg)
	local useDefaultImage = true
	local uiValid = displayUI ~= nil and displayUI:isAlive()

	if uiRoot and uiRoot.uid then
		uiValid = uiValid and uiRoot.uid == uid
	end

	if uiValid then
		displayUI:setVisible(true)
	else
		return
	end

	if code == Const.WEB_REQ_STATE_CODE.SUCCESS and texture then
		displayUI:setImageWithTexture(texture)

		useDefaultImage = false
	end

	if useDefaultImage then
		HeadHelper.setDefaultIcon(displayUI)
	end
end

function ServerDownloadUtils.getImageCommonCallback(domain, displayUI, stateTxt, code, texture, msg)
	local useDefaultImage = true
	local uiValid = displayUI ~= nil and displayUI:isAlive()

	if uiValid then
		displayUI:setVisible(true)
	else
		return
	end

	if code == Const.WEB_REQ_STATE_CODE.SUCCESS and texture then
		displayUI:setImageWithTexture(texture)

		useDefaultImage = false
	end

	if stateTxt and stateTxt:isExist() then
		stateTxt:setText("")
	end

	if useDefaultImage then
		HeadHelper.setDefaultIcon(displayUI)
	end
end

function ServerDownloadUtils.releaseLoader(uid, subResId)
	local resKey = self.formatHeadResKey(uid, subResId)

	self._releaseLoader(resKey)
	self.deleteCache(resKey)
end

function ServerDownloadUtils.getHeadFromWeb(uid, subResId, callback, readCache)
	ServerDownloadUtils.getHeadImage(uid, subResId, callback, readCache)
end

function ServerDownloadUtils.formatHeadResKey(uid, headId)
	return string.format("%s_%s", uid, headId)
end

function ServerDownloadUtils.loadTexture(url, resKey, callback, readCache)
	WebResourcesHelperForHead:LoadTexture(url, resKey, callback, true, readCache)
end

function ServerDownloadUtils.loadTextureWithoutCache(url, resKey, callback, readCache)
	WebResourcesHelperForHead:LoadTexture(url, resKey, callback, false, readCache)
end

function ServerDownloadUtils._releaseLoader(key)
	WebResourcesHelperForHead:ReleaseLoader(key)
end

function ServerDownloadUtils.isTextureCached(resKey)
	return WebResourcesHelperForHead:FileExistInCache(resKey)
end

function ServerDownloadUtils.deleteCache(resKey)
	WebResourcesHelperForHead:DeleteCache(resKey)
end

function ServerDownloadUtils.loadFromCache(resKey, callback)
	WebResourcesHelperForHead:LoadTextureFromCache(resKey, callback)
end

function ServerDownloadUtils.LoadLocalTextureByFile(filePath)
	return WebResourcesHelperForHead:LoadLocalTextureByFile(filePath)
end

return ServerDownloadUtils
