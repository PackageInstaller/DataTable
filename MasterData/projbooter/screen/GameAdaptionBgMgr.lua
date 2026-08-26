-- chunkname: @projbooter/screen/GameAdaptionBgMgr.lua

module("projbooter.screen.GameAdaptionBgMgr", package.seeall)

local GameAdaptionBgMgr = class("GameAdaptionBgMgr")

function GameAdaptionBgMgr:ctor()
	self.standRate = 1.7777777777777777
	self.imageRate = 2.4
	self.loaded = false
end

function GameAdaptionBgMgr:onAssetResLoaded(assetItem)
	if self.assetItem then
		logError("GameAdaptionBgMgr:onAssetResLoaded 已经设置资源 assetItem")

		return
	end

	self.assetItem = assetItem

	self.assetItem:Retain()

	self.prefab = assetItem:GetResource()
end

function GameAdaptionBgMgr:checkNeedLoadAdaptionBg()
	return UnityEngine.Screen.width / UnityEngine.Screen.height < self.standRate
end

function GameAdaptionBgMgr:loadAdaptionBg()
	if self.loaded then
		return
	end

	if not self:checkNeedLoadAdaptionBg() then
		return
	end

	local adaptionParentGo = UnityEngine.GameObject.Find("UIRoot/Adaption")
	local adaptionViewGo = SLFramework.GameObjectHelper.Clone(self.prefab, adaptionParentGo, nil)

	self.loaded = true

	local goAdaption = UnityEngine.GameObject.Find("UIRoot/Adaption")
	local goUpNode = SLFramework.GameObjectHelper.FindChild(goAdaption, "Up")
	local goBottomNode = SLFramework.GameObjectHelper.FindChild(goAdaption, "Bottom")
	local height = 1920 / self.imageRate

	SLFramework.UGUI.RectTrHelper.SetHeight(goUpNode.transform, height)
	SLFramework.UGUI.RectTrHelper.SetHeight(goBottomNode.transform, height)

	local imageType = typeof(UnityEngine.UI.Image)
	local image = adaptionViewGo:GetComponent(imageType)
	local upImage = goUpNode:GetComponent(imageType)
	local bottomImage = goBottomNode:GetComponent(imageType)

	upImage.sprite = image.sprite
	bottomImage.sprite = image.sprite
	upImage.color = Color.white
	bottomImage.color = Color.white

	local bottomRectTrans = goBottomNode.transform

	SLFramework.TransformHelper.SetLocalScale(bottomRectTrans, 1, 1, 1)

	bottomRectTrans.pivot = Vector2(0.5, 1)

	UnityEngine.GameObject.Destroy(adaptionViewGo)
end

function GameAdaptionBgMgr:tryAddEvents()
	if self.loaded then
		return
	end

	GameGlobalMgr.instance:registerCallback(GameStateEvent.OnScreenResize, self.onScreenSizeChanged, self)
end

function GameAdaptionBgMgr:onScreenSizeChanged(width, height)
	self:loadAdaptionBg()

	if self.loaded then
		GameGlobalMgr.instance:unregisterCallback(GameStateEvent.OnScreenResize, self.onScreenSizeChanged, self)
	end
end

GameAdaptionBgMgr.instance = GameAdaptionBgMgr.New()

return GameAdaptionBgMgr
