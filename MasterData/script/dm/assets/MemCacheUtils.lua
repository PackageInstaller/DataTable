-- chunkname: @/tmp/or_script/lua_compile/dm/assets/MemCacheUtils.lua

local plistExtension = ".plist"
local textureExtension = ".png"
local permenant = "permanent"
local cacheExpireTimes = 2

MemCacheUtils = MemCacheUtils or {
	_textures = {},
	_movieClips = {},
	_spines = {},
	_caches = {},
	_audioList = {}
}

local function releaseMovieClip(data)
	data.object:release()
end

function MemCacheUtils:clear()
	for texturePath, _ in pairs(self._textures) do
		local texture = display.getImage(texturePath)

		if texture then
			texture:release()
		end
	end

	self._textures = {}

	for animName, data in pairs(self._movieClips) do
		releaseMovieClip(data)
	end

	self._movieClips = {}

	for skel, _ in pairs(self._spines) do
		AnimLoadUtils.releaseSkeletonAnimation(skel)
	end

	self._spines = {}
	self._caches = {}

	for _packageName, _ in pairs(self._audioList) do
		dmAudio.releaseAcb(_packageName)
	end

	self._audioList = {}
end

function MemCacheUtils:clearHolder(holder)
	local holder = holder or permenant
	local textureRemoved = {}

	for texturePath, holders in pairs(self._textures) do
		if holders[holder] then
			holders[holder] = nil

			if next(holders) == nil then
				textureRemoved[#textureRemoved + 1] = texturePath
			end
		end
	end

	for _, texturePath in ipairs(textureRemoved) do
		self._textures[texturePath] = nil

		local texture = display.getImage(texturePath)

		if texture then
			texture:release()
		end
	end

	local movieClipRemoved = {}

	for animName, data in pairs(self._movieClips) do
		local holders = data.holders

		if holders[holder] then
			holders[holder] = nil

			if next(holders) == nil then
				movieClipRemoved[#movieClipRemoved + 1] = animName
			end
		end
	end

	for _, animName in ipairs(movieClipRemoved) do
		local data = self._movieClips[animName]

		self._movieClips[animName] = nil

		releaseMovieClip(data)
	end

	local spineRemoved = {}

	for skel, holders in pairs(self._spines) do
		if holders[holder] then
			holders[holder] = nil

			if next(holders) == nil then
				spineRemoved[#spineRemoved + 1] = skel
			end
		end
	end

	for _, skel in ipairs(spineRemoved) do
		self._spines[skel] = nil

		AnimLoadUtils.releaseSkeletonAnimation(skel)
	end

	local audioRemoved = {}

	for packageName, holders in pairs(self._audioList) do
		if holders[holder] then
			holders[holder] = nil

			if next(holders) == nil then
				audioRemoved[#audioRemoved + 1] = packageName
			end
		end
	end

	for _, packageName in ipairs(audioRemoved) do
		self._audioList[packageName] = nil

		dmAudio.releaseAcb(packageName)
	end
end

function MemCacheUtils:releaseTexture(resourceName, holder)
	local holder = holder or permenant
	local texturePath = string.gsub(resourceName, plistExtension, textureExtension)
	local holders = self._textures[texturePath]

	if holders and holders[holder] then
		holders[holder] = nil

		if next(holders) == nil then
			self._textures[texturePath] = nil

			local texture = display.getImage(texturePath)

			if texture then
				texture:release()
			end
		end
	end
end

function MemCacheUtils:addTexture(resourceName, holder)
	local holder = holder or permenant
	local texturePath = string.gsub(resourceName, plistExtension, textureExtension)
	local holders = self._textures[texturePath]

	if holders then
		holders[holder] = true
	else
		local texture = display.loadImage(texturePath)

		if texture then
			texture:retain()

			self._textures[texturePath] = {
				[holder] = true
			}
		else
			local err = "addImage failed, file: " .. texturePath

			print(err)
		end
	end
end

function MemCacheUtils:asyncAddTexture(resourceName, holder)
	local holder = holder or permenant
	local texturePath = string.gsub(resourceName, plistExtension, textureExtension)
	local holders = self._textures[texturePath]

	if holders then
		holders[holder] = true
	else
		local function finishFunc(texture)
			local holders = self._textures[texturePath]

			if holders then
				holders[holder] = true
			elseif texture then
				texture:retain()

				self._textures[texturePath] = {
					[holder] = true
				}
			else
				local err = "addTextureAsync failed, file: " .. texturePath

				print(err)
			end
		end

		display.loadImage(texturePath, finishFunc)
	end
end

function MemCacheUtils:addPlist(plistPath, holder)
	local holder = holder or permenant
	local texturePath = string.gsub(plistPath, plistExtension, textureExtension)
	local holders = self._textures[texturePath]

	if holders then
		holders[holder] = true
	else
		local texture = display.loadImage(texturePath)

		if texture then
			cc.SpriteFrameCache:getInstance():addSpriteFrames(plistPath, texture)
			texture:retain()

			self._textures[texturePath] = {
				[holder] = true
			}
		else
			local err = "addImage failed, file: " .. texturePath

			print(err)
		end
	end
end

function MemCacheUtils:asyncAddPlist(plistPath, holder)
	local holder = holder or permenant
	local texturePath = string.gsub(plistPath, plistExtension, textureExtension)
	local holders = self._textures[texturePath]

	if holders then
		holders[holder] = true
	else
		local function finishFunc(texture)
			local holders = self._textures[texturePath]

			if holders then
				holders[holder] = true
			elseif texture then
				cc.SpriteFrameCache:getInstance():addSpriteFrames(plistPath, texture)
				texture:retain()

				self._textures[texturePath] = {
					[holder] = true
				}
			else
				local err = "addTextureAsync failed, file: " .. texturePath

				print(err)
			end
		end

		display.loadImage(texturePath, finishFunc)
	end
end

function MemCacheUtils:releasePlist(plistPath, holder)
	local holder = holder or permenant
	local texturePath = string.gsub(plistPath, plistExtension, textureExtension)
	local holders = self._textures[texturePath]

	if holders and holders[holder] then
		holders[holder] = nil

		if next(holders) == nil then
			self._textures[texturePath] = nil

			local texture = display.getImage(texturePath)

			if texture then
				texture:release()
			end

			display.removeSpriteFrames(plistPath, texturePath)
		end
	end
end

function MemCacheUtils:hasPlist(plistPath)
	if not holder then
		local texturePath = string.gsub(plistPath, plistExtension, textureExtension)
		local holders = self._textures[texturePath]

		if holders then
			return true
		end

		return false
	end
end

function MemCacheUtils:releaseMovieClip(animName, holder)
	local holder = holder or permenant
	local data = self._movieClips[animName]
	local holders = data and data.holders

	if holders and holders[holder] then
		holders[holder] = nil

		if next(holders) == nil then
			self._movieClips[animName] = nil

			releaseMovieClip(data)
		end
	end
end

function MemCacheUtils:addMovieClip(animName, holder)
	local holder = holder or permenant
	local data = self._movieClips[animName]

	if data then
		data.holders[holder] = true
	else
		local object = cc.MovieClip:create(animName)

		if object then
			data = {
				object = object,
				holders = {
					[holder] = true
				}
			}
			self._movieClips[animName] = data

			object:retain()

			return object
		end
	end
end

function MemCacheUtils:getMovieClip(animName, holder)
	local holder = holder or permenant
	local data = self._movieClips[animName]

	if data then
		data.holders[holder] = true

		return data.object
	else
		return self:addMovieClip(animName, holder)
	end
end

function MemCacheUtils:releaseSpine(skelName, holder)
	local holder = holder or permenant
	local holders = self._spines[skelName]

	if holders and holders[holder] then
		holders[holder] = nil

		if next(holders) == nil then
			self._spines[skelName] = nil

			AnimLoadUtils.releaseSkeletonAnimation(skelName)
		end
	end
end

function MemCacheUtils:addSpine(skelName, holder)
	local holder = holder or permenant
	local holders = self._spines[skelName]

	if holders then
		holders[holder] = true
	elseif AnimLoadUtils.preLoadSkeletonAnimation(skelName) then
		AnimLoadUtils.retainSkeletonAnimation(skelName)

		self._spines[skelName] = {
			[holder] = true
		}
	end
end

function MemCacheUtils:asyncAddSpine(skelName, holder)
	local function loadSpineFinishFunc(name)
		local holders = self._spines[skelName]

		if holders then
			holders[holder] = true
		else
			AnimLoadUtils.retainSkeletonAnimation(skelName)

			self._spines[skelName] = {
				[holder] = true
			}
		end
	end

	local holder = holder or permenant
	local holders = self._spines[skelName]

	if holders then
		holders[holder] = true
	else
		AnimLoadUtils.asyncLoadSkeletonAnimation(skelName, loadSpineFinishFunc)
	end
end

function MemCacheUtils:registSpineCache(skelName, holder)
	self:asyncAddSpine(skelName, "cache_" .. holder)

	local cache = self._caches[holder]

	if cache == nil then
		cache = {}
		self._caches[holder] = cache
	end

	cache[skelName] = cacheExpireTimes
end

function MemCacheUtils:releaseCache(cache, holder)
	if cache then
		local toRemove = {}

		for skelName, times in pairs(cache) do
			times = times - 1
			cache[skelName] = times

			if times <= 0 then
				toRemove[#toRemove + 1] = skelName
			end
		end

		for _, skelName in ipairs(toRemove) do
			cache[skelName] = nil

			self:releaseSpine(skelName, "cache_" .. holder)
		end
	end
end

function MemCacheUtils:updateSpineCache(holder)
	if not self._caches[holder] then
		return
	end

	self:releaseCache(self._caches[holder], holder)

	if next(self._caches[holder]) == nil then
		self._caches[holder] = nil
	end
end

function MemCacheUtils:releaseAllCaches()
	local toRemove = {}

	for holder, cache in pairs(self._caches) do
		self:releaseCache(cache, holder)

		if next(cache) == nil then
			toRemove[#toRemove + 1] = holder
		end
	end

	for _, holder in ipairs(toRemove) do
		self._caches[holder] = nil
	end
end

function MemCacheUtils:addAudio(packageName, holder)
	local holder = holder or permenant
	local holders = self._audioList[packageName]

	if holders then
		holders[holder] = true
	elseif dmAudio.loadAcbFile(packageName) then
		self._audioList[packageName] = {
			[holder] = true
		}
	end
end
