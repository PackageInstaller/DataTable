-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/photo/PhotoCacheMgr.lua

module("logic.common.photo.PhotoCacheMgr", package.seeall)

local PhotoCacheMgr = class("PhotoCacheMgr")

PhotoCacheMgr.SIZE_FULL_H_WIDTH = 1952
PhotoCacheMgr.SIZE_FULL_H_HEIGHT = 900
PhotoCacheMgr.SIZE_FULL_WIDTH = 1624
PhotoCacheMgr.SIZE_FULL_HEIGHT = 750
PhotoCacheMgr.SIZE_FULL_L_WIDTH = 1300
PhotoCacheMgr.SIZE_FULL_L_HEIGHT = 600
PhotoCacheMgr.SIZE_H_BLOCK = 1300
PhotoCacheMgr.SIZE_M2_BLOCK = 800
PhotoCacheMgr.SIZE_M_BLOCK = 760
PhotoCacheMgr.SIZE_L_BLOCK = 640

function PhotoCacheMgr:ctor()
	self._cacheSizes = {}
	self._photoCache = Astral.PhotoProducerCache.Instance

	self._photoCache:SetCullingLayer(Astral.LayerUtil.NameToLayer(SceneLayer.UI3D))
end

function PhotoCacheMgr:_cache(w, h, count, txtf, anti)
	txtf = txtf or UnityEngine.RenderTextureFormat.ARGB32
	anti = anti or 1

	if not self._cacheSizes[w] then
		self._cacheSizes[w] = {}
	end

	if not self._cacheSizes[w][h] then
		self._cacheSizes[w][h] = {}
	end

	if not self._cacheSizes[w][h][txtf] then
		self._cacheSizes[w][h][txtf] = {}
	end

	self._cacheSizes[w][h][txtf][anti] = count

	self._photoCache:SetCapacity(w, h, count, txtf, anti)
end

function PhotoCacheMgr:isCached(w, h, txtf, anti)
	txtf = txtf or UnityEngine.RenderTextureFormat.ARGB32
	anti = anti or 1

	local t = self._cacheSizes[w]

	if t and t[h] and t[h][txtf] and t[h][txtf][anti] then
		return true
	end

	return false
end

function PhotoCacheMgr:checkPhotoCached(w, h, txtf, anti)
	if not self:isCached(w, h, txtf, anti) then
		printError(string.format("UI界面上的3D元素尺寸未设置缓存，width:%s，height:%s，textureFormat:%s，antiAliasing:%s", w, h, txtf, anti))
	end
end

function PhotoCacheMgr:init()
	self:_setupConfig()
	self:_setupCache()
end

function PhotoCacheMgr:clearCache()
	self._photoCache:ClearCache()
end

function PhotoCacheMgr:_setupConfig()
	self._photoCache:SetCameraDistanceAndDiemensionLength(50, 4)
	self._photoCache:SetCounterIndexPoolCapacity(8)
	self._photoCache:SetRenderTextureDepth(0)
end

function PhotoCacheMgr:_setupCache()
	self:_cache(PhotoCacheMgr.SIZE_FULL_WIDTH, PhotoCacheMgr.SIZE_FULL_HEIGHT, 1, UnityEngine.RenderTextureFormat.ARGB32)
	self:_cache(PhotoCacheMgr.SIZE_FULL_WIDTH, PhotoCacheMgr.SIZE_FULL_HEIGHT, 1, UnityEngine.RenderTextureFormat.ARGB32, 2)
	self:_cache(PhotoCacheMgr.SIZE_FULL_WIDTH, PhotoCacheMgr.SIZE_FULL_HEIGHT, 1, UnityEngine.RenderTextureFormat.ARGB32, 4)
	self:_cache(PhotoCacheMgr.SIZE_FULL_L_WIDTH, PhotoCacheMgr.SIZE_FULL_L_HEIGHT, 1, UnityEngine.RenderTextureFormat.ARGB32)
	self:_cache(PhotoCacheMgr.SIZE_FULL_WIDTH, PhotoCacheMgr.SIZE_FULL_HEIGHT, 1, UnityEngine.RenderTextureFormat.ARGBHalf)
	self:_cache(PhotoCacheMgr.SIZE_FULL_WIDTH, PhotoCacheMgr.SIZE_FULL_HEIGHT, 1, UnityEngine.RenderTextureFormat.RGB111110Float)
	self:_cache(PhotoCacheMgr.SIZE_FULL_H_WIDTH, PhotoCacheMgr.SIZE_FULL_H_HEIGHT, 1, UnityEngine.RenderTextureFormat.ARGBHalf)
	self:_cache(PhotoCacheMgr.SIZE_FULL_H_WIDTH, PhotoCacheMgr.SIZE_FULL_H_HEIGHT, 1, UnityEngine.RenderTextureFormat.RGB111110Float)
	self:_cache(PhotoCacheMgr.SIZE_H_BLOCK, PhotoCacheMgr.SIZE_H_BLOCK, 1)
	self:_cache(PhotoCacheMgr.SIZE_H_BLOCK, PhotoCacheMgr.SIZE_H_BLOCK, 1, UnityEngine.RenderTextureFormat.ARGBHalf)
	self:_cache(PhotoCacheMgr.SIZE_M_BLOCK, PhotoCacheMgr.SIZE_M_BLOCK, 1, UnityEngine.RenderTextureFormat.ARGB32, 1)
	self:_cache(PhotoCacheMgr.SIZE_M_BLOCK, PhotoCacheMgr.SIZE_M_BLOCK, 1, UnityEngine.RenderTextureFormat.ARGB32, 4)
	self:_cache(PhotoCacheMgr.SIZE_M2_BLOCK, PhotoCacheMgr.SIZE_M2_BLOCK, 1, UnityEngine.RenderTextureFormat.ARGB32, 4)
	self:_cache(PhotoCacheMgr.SIZE_L_BLOCK, PhotoCacheMgr.SIZE_L_BLOCK, 1)
	self:_cache(PhotoCacheMgr.SIZE_FULL_HEIGHT, PhotoCacheMgr.SIZE_FULL_HEIGHT, 1)
	self:_cache(512, 512, 5, UnityEngine.RenderTextureFormat.ARGB32)
	self:_cache(512, 512, 5, UnityEngine.RenderTextureFormat.ARGBHalf)

	local uiRoot = ViewMgr.instance:getUIRoot()
	local rectTransform = uiRoot.transform
	local width = math.ceil(rectTransform.rect.width)
	local height = math.ceil(rectTransform.rect.height)

	self:_cache(width, height, 1, UnityEngine.RenderTextureFormat.ARGB32, 2)
	self:_cache(1077, 688, 1, UnityEngine.RenderTextureFormat.RGB111110Float, 1)
	self:_cache(344, 1616, 2, UnityEngine.RenderTextureFormat.RGB111110Float)
end

PhotoCacheMgr.instance = PhotoCacheMgr.New()

return PhotoCacheMgr
