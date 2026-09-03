-- chunkname: @/tmp/or_script/lua_compile/dm/assets/AnimLoadUtils.lua

AnimLoadUtils = AnimLoadUtils or {}

local textureCache = cc.Director:getInstance():getTextureCache()
local skeletonDataCache = sp.SkeletonAnimationCache:getInstance()
local spriteFrameCache = cc.SpriteFrameCache:getInstance()
local relativePath = "asset/anim/"
local dataExtension = ".plist"
local textureExtension = ".png"

local function getAllPlist(skeletonFilename)
	if not AnimLoadUtils._data then
		local ok, data = pcall(require, "assetscript.AnimMainfest")

		if not ok then
			if DEBUG ~= nil and DEBUG > 1 then
				cclog("assetScript.AnimMainfest non-exist!")
			end

			return false
		end

		AnimLoadUtils._data = data
	end

	if not skeletonFilename then
		if DEBUG ~= nil and DEBUG > 1 then
			cclog("AnimLoadUtils.preLoadSkeletonAnimation(skeletonFilename), skeletonFilename is nil!")
		end

		return false
	end

	local refAllPlist = AnimLoadUtils._data[tostring(skeletonFilename)]

	if not refAllPlist then
		if DEBUG ~= nil and DEBUG > 1 then
			cclog(skeletonFilename .. " reference plist is nil")
		end

		return false
	end

	return true, refAllPlist
end

local function getTextureFromPlist(plistPath)
	local texturePath = string.gsub(plistPath, dataExtension, textureExtension)

	return display.getImage(texturePath)
end

function AnimLoadUtils.asyncLoadSkeletonAnimation(skeletonFilename, finishedHandler)
	AnimLoadUtils._finishedHandlers = AnimLoadUtils._finishedHandlers or {}

	local ok, refAllPlist = getAllPlist(skeletonFilename)

	if not ok then
		if finishedHandler then
			finishedHandler(skeletonFilename)
		end

		return
	end

	local plistCount = #refAllPlist
	local textures = {}
	local handlers = AnimLoadUtils._finishedHandlers[skeletonFilename]

	if handlers then
		handlers[#handlers + 1] = finishedHandler

		return
	end

	AnimLoadUtils._finishedHandlers[skeletonFilename] = {
		finishedHandler
	}

	for index, plistPath in pairs(refAllPlist) do
		textureCache:addImageAsync(string.gsub(plistPath, dataExtension, textureExtension), function(texture)
			if texture then
				texture:retain()
				table.insert(textures, texture)
			end

			plistCount = plistCount - 1

			spriteFrameCache:addSpriteFrames(plistPath)

			if plistCount == 0 then
				for _, v in pairs(textures) do
					v:release()
				end

				textures = nil

				local animHandlers = AnimLoadUtils._finishedHandlers[skeletonFilename]

				if animHandlers then
					skeletonDataCache:addSkeletonDataExtend(relativePath .. skeletonFilename)

					for _, animHandler in ipairs(animHandlers) do
						animHandler(skeletonFilename)
					end

					AnimLoadUtils._finishedHandlers[skeletonFilename] = nil
				end
			end
		end)
	end
end

function AnimLoadUtils.retainSkeletonAnimation(skeletonFilename)
	local ok, refAllPlist = getAllPlist(skeletonFilename)

	if not ok then
		return
	end

	for plistIndex, plistPath in pairs(refAllPlist) do
		if display and display.getImage then
			local image = getTextureFromPlist(plistPath)

			if image then
				image:retain()
			end
		end
	end
end

function AnimLoadUtils.releaseSkeletonAnimation(skeletonFilename)
	local ok, refAllPlist = getAllPlist(skeletonFilename)

	if not ok then
		return
	end

	for plistIndex, plistPath in pairs(refAllPlist) do
		if display and display.getImage then
			local image = getTextureFromPlist(plistPath)

			if image then
				image:release()
			end
		end
	end
end

function AnimLoadUtils.preLoadSkeletonAnimation(skeletonFilename)
	local ok, refAllPlist = getAllPlist(skeletonFilename)

	if not ok then
		return false
	end

	for plistIndex, plistPath in pairs(refAllPlist) do
		spriteFrameCache:addSpriteFrames(plistPath)
	end

	skeletonDataCache:addSkeletonDataExtend(relativePath .. skeletonFilename)

	return true
end
