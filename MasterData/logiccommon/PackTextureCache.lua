-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/avatar/PackTextureCache.lua

module("logiccommon.common.avatar.PackTextureCache", package.seeall)

local PackTextureCache = class("PackTextureCache", ObjectPool)
local tempTextureMap = {}

function PackTextureCache:ctor()
	PackTextureCache.super.ctor(self, 20, function()
		return PackTexture.New()
	end, function(texture)
		texture:destroy()
	end, function(texture)
		texture:reset()
	end)

	self._textures = {}
end

function PackTextureCache:getPackTexture(textures)
	table.clear(tempTextureMap)

	local textureCount = 0

	for i = 1, #textures do
		local tex = textures[i]

		if not tempTextureMap[tex.name] then
			tempTextureMap[tex.name] = tex
			textureCount = textureCount + 1
		end
	end

	local packedTex
	local found = false

	for k, v in pairs(self._textures) do
		found = textureCount == #v.packTextures

		if found then
			for k1, v1 in pairs(tempTextureMap) do
				if not v.textureMap[v1.name] then
					found = false

					break
				end
			end
		end

		if found then
			packedTex = v

			break
		end
	end

	if not packedTex then
		packedTex = self:fetchObject()

		packedTex:pack(textures)

		self._textures[packedTex] = packedTex
	end

	packedTex:retain()

	return packedTex
end

function PackTextureCache:returnPackTexture(packedTex)
	packedTex:release()

	if packedTex.refCount == 0 then
		self._textures[packedTex] = nil

		self:returnObject(packedTex)
	end
end

PackTextureCache.instance = PackTextureCache.New()

return PackTextureCache
