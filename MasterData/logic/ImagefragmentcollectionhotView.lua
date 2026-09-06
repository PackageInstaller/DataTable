-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/imagefragmentcollection/view/ImagefragmentcollectionhotView.lua

module("logic.extensions.imagefragmentcollection.view.ImagefragmentcollectionhotView", package.seeall)

local ImagefragmentcollectionhotView = class("ImagefragmentcollectionhotView", ViewComponent)

function ImagefragmentcollectionhotView:unbindEvents()
	ImagefragmentcollectionhotView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function ImagefragmentcollectionhotView:bindEvents()
	ImagefragmentcollectionhotView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
end

function ImagefragmentcollectionhotView:buildUI()
	ImagefragmentcollectionhotView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._bg = self:getGo("bg")

	goutil.setActive(self._bg, false)
end

function ImagefragmentcollectionhotView:onExit()
	ImagefragmentcollectionhotView.super.onExit(self)

	if self._resLoader then
		GameUtil.unloadMultiResLoaderResource(self._resLoader)

		self._resLoader = nil
	end

	if self._resDict then
		for k, v in pairs(self._resDict) do
			v:Release()
		end

		self._resDict = nil
	end
end

function ImagefragmentcollectionhotView:onEnter()
	ImagefragmentcollectionhotView.super.onEnter(self)

	local params = self:getOpenParam()

	self._imageId = params[2]
	self._activityId = params[1]

	self:_loadBg()
end

function ImagefragmentcollectionhotView:_onClickbtnClose()
	self:close()
end

function ImagefragmentcollectionhotView:_loadBg()
	local cfg = ImagefragmentcollectionConfig.instance:getCollectionCfg(self._activityId)
	local pcfgs = ImagefragmentcollectionConfig.instance:getPrizePlanCfgs(cfg.prizePlanId)
	local pcfg = pcfgs[self._imageId]

	self._shareId = 0

	if pcfg then
		self._shareId = pcfg.shareId

		if string.nilorempty(pcfg.shareImg) then
			printError("ImagefragmentcollectionhotView Empty shareImg ")
			self:_onShare()
		else
			local spriteName = GameUrl.getBigbgFolderUrl("imagefragmentcollection", pcfg.shareImg)

			self._spriteName = spriteName

			local toloadList = {
				spriteName
			}

			self._resLoader = self._resLoader or MultiResLoader.New()

			self._resLoader:setResPaths(toloadList)
			self._resLoader:load(self._onResourcesLoaded, nil, self)
		end
	else
		printError("ImagefragmentcollectionhotView Empty self._imageId: ", self._imageId)
		self:_onShare()
	end
end

function ImagefragmentcollectionhotView:_onResourcesLoaded(loader)
	if loader then
		self._resDict = self._resDict or {}

		local resources = loader:getResources()

		for k, v in pairs(resources) do
			self._resDict[k] = v

			v:Retain()
		end

		loader:clear()
	else
		printError("loader不存在：")
	end

	if self._resDict[self._spriteName] then
		local texture2d = {
			width = 964,
			height = 544
		}
		local _outTexture = UnityEngine.Texture2D.New(texture2d.width, texture2d.height)

		Framework.TextureUtil.DrawTexture(self._resDict[self._spriteName]:GetMainAsset(), _outTexture, 0, 0)
		self:_onShare(_outTexture)
	else
		printError("加载不出图片了：", self._spriteName)
		self:_onShare()
	end
end

function ImagefragmentcollectionhotView:_onShare(_outTexture)
	if self._shareId and self._shareId > 0 then
		ShareController.instance:share(self._shareId, {
			self._btnClose.gameObject
		}, _outTexture, 200473)
		self:close()
	end
end

return ImagefragmentcollectionhotView
