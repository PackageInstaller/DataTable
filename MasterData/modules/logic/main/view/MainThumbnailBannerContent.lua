-- chunkname: @modules/logic/main/view/MainThumbnailBannerContent.lua

module("modules.logic.main.view.MainThumbnailBannerContent", package.seeall)

local MainThumbnailBannerContent = class("MainThumbnailBannerContent", LuaCompBase)

function MainThumbnailBannerContent:init(param)
	self._go = param.go
	self._config = param.config
	self._index = param.index

	transformhelper.setLocalPos(self._go.transform, param.pos, 0, 0)
end

function MainThumbnailBannerContent:loadBanner()
	if self._isLoadedBanner then
		return
	end

	self._isLoadedBanner = true
	self._simagebanner = gohelper.findChildSingleImage(self._go, "#simage_banner")
	self._txtdesc = gohelper.findChildText(self._go, "#txt_des")
	self._txtdesc.text = self._config.des

	self._simagebanner:LoadImage(SLFramework.LanguageMgr.Instance:GetLangPathFromAssetPath(ResUrl.getAdventureTaskLangPath(self._config.res)))
end

function MainThumbnailBannerContent:updateItem(index)
	if not index then
		return
	end

	if self._index == index or self._index - index == 1 then
		self:loadBanner()
	end
end

function MainThumbnailBannerContent:destroy()
	if self._simagebanner then
		self._simagebanner:UnLoadImage()
	end
end

return MainThumbnailBannerContent
