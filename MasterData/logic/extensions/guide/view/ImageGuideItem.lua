-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guide/view/ImageGuideItem.lua

module("logic.extensions.guide.view.ImageGuideItem", package.seeall)

local ImageGuideItem = class("ImageGuideItem")

function ImageGuideItem:ctor(compContainer)
	self._compContainer = compContainer
	self._go = self._compContainer.gameObject
	self._trs = self._go.transform
end

function ImageGuideItem:Awake()
	self._imgContent = UIComponentType.ImageBigBG(self._go)
end

function ImageGuideItem:setCellData(imgName)
	self._imgContent:ClearImage()
	self._imgContent:SetNativeSize(true)
	self._imgContent:SetImage(GameUrl.getImageGuideUrl(imgName), self._onImageGuideLoaded, self)
end

function ImageGuideItem:_onImageGuideLoaded()
	return
end

function ImageGuideItem:OnDestroy()
	self._imgContent:ClearImage()

	self._imgContent = nil
end

return ImageGuideItem
