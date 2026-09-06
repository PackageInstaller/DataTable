-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/components/ImageTexBlendChangeComponent.lua

module("logiccommon.common.components.ImageTexBlendChangeComponent", package.seeall)

local ImageTexBlendChangeComponent = class("ImageTexBlendChangeComponent")

function ImageTexBlendChangeComponent:ctor(go)
	self._go = go
	self._image = go:GetComponent(ComponentType.Image)
	self._mat = UnityEngine.Material.New(Framework.ShaderCache.Find("aounity/ui/ui_texblend"))
	self._rawImageContain = {}

	self._mat:DisableKeyword("_CARDEFFECT_NONE")
	self._mat:DisableKeyword("_CARDEFFECT_LASER")
	self._mat:EnableKeyword("_CARDEFFECT_RAINBOW")

	self._image.material = self._mat
end

function ImageTexBlendChangeComponent:setTexture(tex1, tex2)
	self._mat:SetTexture("_MainTex", tex1)
	self._mat:SetTexture("_BlendTex", tex2)
end

function ImageTexBlendChangeComponent:setBlendFactor(num)
	self._mat:SetFloat("_BlendFactor", num)
end

function ImageTexBlendChangeComponent:setBlendSoft(num)
	self._mat:SetFloat("_BlendSoft", num)
end

function ImageTexBlendChangeComponent:setBlendRotate(angle)
	self._mat:SetFloat("_BaseMap02_Rotation", angle)
end

function ImageTexBlendChangeComponent:dispose()
	self._image.material = nil

	goutil.destroy(self._mat)

	if self._rawImageContain[1] then
		local pet1Show = PetPhotoShow.Get(self._rawImageContain[1])

		pet1Show:destroy()
		goutil.destroy(self._rawImageContain[1])

		self._rawImageContain[1] = nil
	end

	if self._rawImageContain[2] then
		local pet2Show = PetPhotoShow.Get(self._rawImageContain[2])

		pet2Show:destroy()
		goutil.destroy(self._rawImageContain[2])

		self._rawImageContain[2] = nil
	end
end

function ImageTexBlendChangeComponent:setRenderTextureWithRaceId(raceId1, raceId2)
	if not self._rawImageContain[1] then
		self._rawImageContain[1] = goutil.create("render1", true)

		goutil.addChildToParent(self._rawImageContain[1], self._go)
	end

	if not self._rawImageContain[2] then
		self._rawImageContain[2] = goutil.create("render2", true)

		goutil.addChildToParent(self._rawImageContain[2], self._go)
	end

	local showWidth = GameUtil.getWidth(self._go)
	local showHeight = GameUtil.getWidth(self._go)

	GameUtil.setWidth(self._rawImageContain[1], showWidth)
	GameUtil.setWidth(self._rawImageContain[2], showWidth)
	GameUtil.setHeight(self._rawImageContain[1], showHeight)
	GameUtil.setHeight(self._rawImageContain[2], showHeight)

	local rawImage1 = goutil.addComponentOnce(self._rawImageContain[1], ComponentType.RawImage)
	local rawImage2 = goutil.addComponentOnce(self._rawImageContain[2], ComponentType.RawImage)
	local pet1Show = PetPhotoShow.Get(self._rawImageContain[1])
	local petShow2 = PetPhotoShow.Get(self._rawImageContain[2])

	pet1Show:showPetEffect(raceId1, true)
	petShow2:showPetEffect(raceId2, true)
	GameUtil.setWidth(self._rawImageContain[1], 0)
	GameUtil.setWidth(self._rawImageContain[2], 0)
	GameUtil.setHeight(self._rawImageContain[1], 0)
	GameUtil.setHeight(self._rawImageContain[2], 0)
	self:setTexture(rawImage1.texture, rawImage2.texture)
end

return ImageTexBlendChangeComponent
