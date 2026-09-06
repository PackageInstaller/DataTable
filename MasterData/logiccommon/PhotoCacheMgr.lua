-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/viewlib/photo/PhotoCacheMgr.lua

module(..., package.seeall)

local PhotoCacheMgr = class("PhotoCacheMgr")

function PhotoCacheMgr:ctor()
	self._cacheSizes = {}
	self._photoCache = Framework.PhotoProducerCache.Instance

	self._photoCache:SetCullingLayer(self:getCullingLayer())
	self._photoCache:SetAALevel(1)
end

function PhotoCacheMgr:getCullingLayer()
	return Framework.LayerUtil.NameToLayer(SceneLayer.UI3D)
end

function PhotoCacheMgr:_cache(w, h, count)
	local t = self._cacheSizes[w]

	if not t then
		t = {}
		self._cacheSizes[w] = t
	end

	t[h] = count

	self._photoCache:SetCapacity(w, h, count)
end

function PhotoCacheMgr:isCached(w, h)
	local t = self._cacheSizes[w]

	if t and t[h] then
		return true
	end

	return false
end

function PhotoCacheMgr:checkPhotoGo(go)
	if enableLog then
		local rtw = goutil.getWidth(go.transform)
		local rth = goutil.getHeight(go.transform)

		if not self:isCached(rtw, rth) then
			local goPath = go.name
			local trs = go.transform.parent

			while not goutil.isNil(trs) do
				goPath = trs.name .. "/" .. goPath
				trs = trs.parent
			end

			printError("UI界面上的3D元素尺寸未设置缓存，联系对应开发，goPath=", goPath, rtw, rth)
		end
	end
end

function PhotoCacheMgr:getFullScreenTextureSize()
	local screenW = UnityEngine.Screen.width
	local screenH = UnityEngine.Screen.height
	local isFringeDevice = screenW / screenH - 2 > 0.01

	if isFringeDevice then
		screenW = screenW - 160 * (screenH / 720)
	end

	return screenW, screenH
end

function PhotoCacheMgr:init()
	local fullScerrnW, fullScerrnH = self:getFullScreenTextureSize()

	self:_cache(fullScerrnW, fullScerrnH, 1)
	self:_cache(512, 512, 1)
	self:_cache(256, 256, 7)
	self:_cache(116, 664, 1)
end

PhotoCacheMgr.instance = PhotoCacheMgr.New()

return PhotoCacheMgr
