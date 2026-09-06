-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/util/uGuiUtil.lua

module("logiccommon.common.util.uGuiUtil", package.seeall)

local uGuiUtil = {}

uGuiUtil.RaceMap = {
	[GameEnum.RaceType.An] = "an",
	[GameEnum.RaceType.Cao] = "cao",
	[GameEnum.RaceType.Guang] = "guang",
	[GameEnum.RaceType.Huo] = "huo",
	[GameEnum.RaceType.Shui] = "shui",
	[GameEnum.RaceType.ShenAn] = "an",
	[GameEnum.RaceType.ShenCao] = "cao",
	[GameEnum.RaceType.ShenGuang] = "guang",
	[GameEnum.RaceType.ShenHuo] = "huo",
	[GameEnum.RaceType.ShenShui] = "shui"
}
uGuiUtil.CareerMap = {
	[GameEnum.CareerType.Dun] = "dun",
	[GameEnum.CareerType.LiZhua] = "gongji",
	[GameEnum.CareerType.Mofa] = "mofa",
	[GameEnum.CareerType.Pingheng] = "pingheng",
	[GameEnum.CareerType.JiSu] = "sudu"
}
uGuiUtil.ButtonMap = {
	[1] = "zhenxingleibie",
	[2] = "zhenxingleibiehui"
}
uGuiUtil.SpriteType = {}
uGuiUtil.SpriteType.BigBg = 0
uGuiUtil.SpriteType.Button = 2
uGuiUtil.SpriteType.Career = 3
uGuiUtil.SpriteType.Race = 4
uGuiUtil.SpriteType.Battle = 5
uGuiUtil.SpriteType.Story = 6
uGuiUtil.LoaderType_BigBg = 0
uGuiUtil.LoaderType_SpriteAsset = 1

function uGuiUtil.clearImage(go)
	local bigBg = go:GetComponent(typeof(Framework.ImageBigBG))

	if bigBg then
		bigBg:ClearImage()
	end
end

function uGuiUtil.setImagePosProgress(image, progress)
	Game.ImageUtil.SetImagePosProgress(image, progress)
end

function uGuiUtil.setImageFillAmount(image, fillAmount)
	return Game.ImageUtil.SetImageFillAmount(image, fillAmount)
end

function uGuiUtil.getPivotSprite(sourceSprite, pivotX, pivotY)
	return Game.ImageUtil.GetPivotSprite(sourceSprite, pivotX, pivotY)
end

function uGuiUtil.doFillAmount(image, fromAmount, toAmount, duration)
	return Game.ImageUtil.DoFillAmount(image, fromAmount, toAmount, duration)
end

function uGuiUtil.setImageAlpha(image, alpha)
	return Game.ImageUtil.SetImageAlpha(image, alpha)
end

function uGuiUtil.setSprite(image, sprite)
	image.sprite = nil

	if sprite then
		image.sprite = sprite
	end
end

function uGuiUtil.setSpriteToImage(go, spriteType, spriteName, handler, handlerObj)
	if spriteName == nil then
		return
	end

	spriteName = string.lower(spriteName)

	local spriteLoaderType = uGuiUtil._getLoaderTypeBySpriteType(spriteType)

	if spriteLoaderType == uGuiUtil.LoaderType_BigBg then
		uGuiUtil._setBigBgSpriteToImage(go, spriteName, handler, handlerObj)

		return
	end

	if spriteLoaderType == uGuiUtil.LoaderType_SpriteAsset then
		uGuiUtil._setSpriteAssetSpriteToImage(go, spriteType, spriteName, handler, handlerObj)

		return
	end
end

function uGuiUtil.setSpriteByAssetName(go, assetName, spriteName, handler, handlerObj)
	if spriteName == nil then
		return
	end

	spriteName = string.lower(spriteName)

	uGuiUtil._setSpriteToImageByAssetName(go, assetName, spriteName, handler, handlerObj)
end

function uGuiUtil.setTextGrayState(go, isGray)
	go:GetComponent(goutil.Type_UIText).material = isGray and CommonPreloader.instance:getSkinlibAsset(CommonResPath.GrayMat) or nil
end

function uGuiUtil.setImageGrayState(go, isGray)
	go:GetComponent(goutil.Type_UIImage).material = isGray and CommonPreloader.instance:getSkinlibAsset(CommonResPath.GrayMat) or nil
end

function uGuiUtil.setRawImageGrayState(go, isGray)
	go:GetComponent(typeof(UnityEngine.UI.RawImage)).material = isGray and CommonPreloader.instance:getSkinlibAsset(CommonResPath.GrayMat) or nil
end

function uGuiUtil.setImageGrayStateRecursive(go, isGray)
	local material = isGray and CommonPreloader.instance:getSkinlibAsset(CommonResPath.GrayMat) or nil

	if go:GetComponent(goutil.Type_UIImage) then
		go:GetComponent(goutil.Type_UIImage).material = material
	end

	local trs = go.transform
	local count = trs.childCount

	for i = count, 1, -1 do
		local child = trs:GetChild(i - 1)

		if child.childCount > 0 then
			uGuiUtil.setImageGrayStateRecursive(child, isGray)
		else
			local materialComponent = child:GetComponent(goutil.Type_UIImage)

			if materialComponent then
				materialComponent.material = material
			end
		end
	end
end

function uGuiUtil.setTextGrayStateColor(text, isGray, r, g, b, a)
	if isGray then
		Game.TextUtil.EnabledTextEffexts(text, false)
		Game.TextUtil.SetColorRGBA(text, 0.34901960784313724, 0.34901960784313724, 0.34901960784313724, 0.7843137254901961)
	else
		Game.TextUtil.EnabledTextEffexts(text, true)
		Game.TextUtil.SetColorRGBA(text, r, g, b, a)
	end
end

local function _setGoState_Impl(go, isGray)
	if go:GetComponent(goutil.Type_UIText) ~= nil and not go:GetComponent(ComponentType.OutlineEx) then
		uGuiUtil.setTextGrayState(go, isGray)
	end

	if go:GetComponent(goutil.Type_UIImage) ~= nil then
		uGuiUtil.setImageGrayState(go, isGray)
	end
end

function uGuiUtil.setGoGrayState(go, isGray)
	_setGoState_Impl(go, isGray)

	local childCount = go.transform.childCount

	for i = 0, childCount - 1 do
		uGuiUtil.setGoGrayState(go.transform:GetChild(i).gameObject, isGray)
	end
end

function uGuiUtil._getLoaderTypeBySpriteType(spriteType)
	if spriteType == uGuiUtil.SpriteType.Button or spriteType == uGuiUtil.SpriteType.Career or spriteType == uGuiUtil.SpriteType.Race or spriteType == uGuiUtil.SpriteType.Battle or spriteType == uGuiUtil.SpriteType.Story then
		return uGuiUtil.LoaderType_SpriteAsset
	end

	return uGuiUtil.LoaderType_BigBg
end

function uGuiUtil._setBigBgSpriteToImage(go, spriteName, handler, handlerObj)
	if spriteName == nil then
		return
	end

	local component = goutil.addComponentOnce(go, typeof(Framework.ImageBigBG))

	component:ClearImage()
	component:SetImage(spriteName, handler, handlerObj)
end

function uGuiUtil._setSpriteAssetSpriteToImage(go, spriteType, spriteName, handler, handlerObj)
	local spriteAsset

	spriteAsset = spriteType == uGuiUtil.SpriteType.Button and CommonPreloader.instance:getSkinlibAsset(CommonResPath.ButtonSpriteAsset) or spriteType == uGuiUtil.SpriteType.Career and CommonPreloader.instance:getSkinlibAsset(CommonResPath.CareerSpriteAsset) or spriteType == uGuiUtil.SpriteType.Race and CommonPreloader.instance:getSkinlibAsset(CommonResPath.RaceSpriteAsset) or spriteType == uGuiUtil.SpriteType.Battle and CommonPreloader.instance:getSkinlibAsset(CommonResPath.BattleBubbleSpriteAsset) or (spriteType ~= uGuiUtil.SpriteType.Story or true) and spriteAsset

	local sprite = CommonPreloader.instance:getSkinlibAsset(CommonResPath.StorySpriteAsset):Get(spriteName)
	local img = go:GetComponent(goutil.Type_UIImage)

	uGuiUtil.setSprite(img, sprite)

	img.enabled = true

	if handler ~= nil then
		handler(handlerObj, img.sprite.rect.width, img.sprite.rect.height)
	end
end

function uGuiUtil._setSpriteToImageByAssetName(go, assetName, spriteName, handler, handlerObj)
	local spriteAsset = CommonPreloader.instance:getSkinlibAsset("ui/skinlib/sp_asset/" .. assetName .. ".asset")
	local sprite = spriteAsset:Get(spriteName)
	local img = go:GetComponent(goutil.Type_UIImage)

	uGuiUtil.setSprite(img, sprite)

	img.enabled = true

	if handler ~= nil then
		handler(handlerObj, img.sprite.rect.width, img.sprite.rect.height)
	end
end

function uGuiUtil._setImgSize(imageGo, width, height)
	goutil.setHeight(imageGo.transform, height)
	goutil.setWidth(imageGo.transform, width)
end

function uGuiUtil.setLocalPosition(gameObject, value)
	if gameObject == nil or goutil.isNil(gameObject) then
		return
	end

	if value == nil then
		gameObject.transform.localPosition = Vector3.zero or value
	end
end

function uGuiUtil.setLocalScale(gameObject, value)
	if gameObject == nil or goutil.isNil(gameObject) then
		return
	end

	if value == nil then
		gameObject.transform.localScale = Vector3.one or value
	end
end

function uGuiUtil.GetTouchWorldPosition()
	local pos = UGUIToolHelper.GetTouchPosition()

	pos.z = 100

	local uiCamera = goutil.find("UICamera"):GetComponent(typeof(UnityEngine.Camera))

	return uiCamera:ScreenToWorldPoint(pos)
end

function uGuiUtil.getScreenRate()
	local d = UnityEngine.Screen.width / UnityEngine.Screen.height

	return d < 1.7777777778 and UnityEngine.Screen.width / 1280 or UnityEngine.Screen.height / 720
end

return uGuiUtil
