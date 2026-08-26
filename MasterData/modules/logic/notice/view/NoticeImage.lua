-- chunkname: @modules/logic/notice/view/NoticeImage.lua

module("modules.logic.notice.view.NoticeImage", package.seeall)

local NoticeImage = class("NoticeImage", LuaCompBase)

function NoticeImage:init(go)
	self._go = go
	self._img = gohelper.onceAddComponent(self._go, gohelper.Type_Image)
	self._assetItem = nil
	self._cacheSprite = {}

	gohelper.setActive(self._go, false)
end

function NoticeImage:load(url)
	local fileName = self:getFilenameFormUrl(url)

	gohelper.setActive(self._go, true)

	if NoticeModel.instance:isLoaded(fileName) then
		self._img.color = Color.white
		self._img.sprite = NoticeModel.instance:getSpriteCache(fileName)

		self:log("【load func】 load cache success , filename is : " .. fileName)

		return true
	end

	self:log("【load func】 load url is : " .. url)

	self._img.sprite = nil
	self._img.color = Color.clear

	if NoticeModel.instance:filenameInLoadingSprite(fileName) then
		self:log("【load func】 " .. fileName .. "  loading return false,")

		return false
	end

	NoticeModel.instance:addLoadingSprite(fileName)
	NoticeModel.instance:addNeedLoadImageUrl(url)
	NoticeModel.instance:addLoadTask(self._load, self)
	TaskDispatcher.runDelay(self._load, self, 0.01)

	return false
end

function NoticeImage:_load()
	local url = NoticeModel.instance:popNeedLoadImageUrl()

	while url do
		local fileName = self:getFilenameFormUrl(url)
		local resUrl = "notice/" .. fileName
		local filePath = self:getNoticeImgFilePath(resUrl)

		if SLFramework.FileHelper.IsFileExists(filePath) then
			loadPersistentRes(resUrl, SLFramework.AssetType.TEXTURE, self._onLoadCallback, self)
		else
			ZProj.SLPictureDownloader.Instance:Download(url, self._downloadCallback, self)
		end

		url = NoticeModel.instance:popNeedLoadImageUrl()
	end

	NoticeModel.instance:removeLoadTask(self._load, self)
end

function NoticeImage:addLoadCallback(callback, callbackObj)
	self._callback = callback
	self._callbackObj = callbackObj
end

function NoticeImage:_onLoadCallback(assetItem)
	local filename = self:getFilenameFormUrl(assetItem.ResPath)

	NoticeModel.instance:setLoadedSprite(filename)

	if assetItem.IsLoadSuccess then
		local oldAsstet = self._assetItem

		assetItem:Retain()

		self._assetItem = assetItem

		if oldAsstet then
			oldAsstet:Release()
		end

		local texture = assetItem:GetResource()

		NoticeModel.instance:setSpriteCache(filename, UnityEngine.Sprite.Create(texture, UnityEngine.Rect.New(0, 0, texture.width, texture.height), Vector2.zero, 100, 0))
		NoticeModel.instance:setSpriteCacheDefaultSize(filename, texture.width, texture.height)
		NoticeModel.instance:addAssetItem(assetItem)
		self:_doCallback(true, filename)
	else
		logError("load fail: " .. assetItem.ResPath)
		self:_doCallback(false, filename)
	end
end

function NoticeImage:_downloadCallback(isSuccess, texture, bytes, url)
	local filename = self:getFilenameFormUrl(url)

	NoticeModel.instance:setLoadedSprite(filename)

	if isSuccess then
		local filePath = self:getNoticeImgFilePath("notice/" .. filename)

		SLFramework.FileHelper.WriteAllBytesToPath(filePath, bytes)
		NoticeModel.instance:setSpriteCache(filename, UnityEngine.Sprite.Create(texture, UnityEngine.Rect.New(0, 0, texture.width, texture.height), Vector2.zero, 100, 0))
		NoticeModel.instance:setSpriteCacheDefaultSize(filename, texture.width, texture.height)
		self:_doCallback(true, filename)
	else
		logError("download fail: " .. url)
		self:_doCallback(false, filename)
	end
end

function NoticeImage:_doCallback(isSucc, filename)
	if isSucc then
		self:log("【_doCallback func】 load success, self.filename is " .. filename)
	else
		self:log("【_doCallback func】 load fail, self.filename is " .. filename)
	end

	NoticeModel.instance:removeLoadingSpriteCount(filename)

	if NoticeModel.instance:getLoadingSpriteCount() <= 0 then
		NoticeContentListModel.instance:onModelUpdate()
	end

	local callback = self._callback
	local callbackObj = self._callbackObj

	self._callback = nil
	self._callbackObj = nil

	if callback then
		if callbackObj then
			self._callback(callbackObj, isSucc)
		else
			self._callback(isSucc)
		end
	end
end

function NoticeImage:getNoticeImgFilePath(fileName)
	return SLFramework.FrameworkSettings.PersistentResRootDir .. "/" .. fileName
end

function NoticeImage:getFilenameFormUrl(url)
	return SLFramework.FileHelper.GetFileName(string.gsub(url, "?.*", ""), true)
end

function NoticeImage:log(msg)
	logWarn(string.format("【NoticeImageLog】msg : %s", msg))
end

function NoticeImage:onDestroy()
	if self._assetItem then
		self._assetItem:Release()

		self._assetItem = nil
	end
end

return NoticeImage
