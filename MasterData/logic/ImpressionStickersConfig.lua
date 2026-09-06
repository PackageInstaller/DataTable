-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/impressionstickers/config/ImpressionStickersConfig.lua

module("logic.extensions.improveinfo.config.ImpressionStickersConfig", package.seeall)

local ImpressionStickersConfig = class("ImpressionStickersConfig", BaseConfig)

function ImpressionStickersConfig:onInit()
	ImpressionStickersConfig.super.onInit(self)

	self._cofignameCfg = nil
end

function ImpressionStickersConfig:getNames()
	return {
		"impression_stickers",
		"poster_stickers",
		"impression_stickers_fix_rank"
	}
end

function ImpressionStickersConfig:handleConfig(name, content)
	if name == "impression_stickers" then
		self._impression_stickers = content
	elseif name == "impression_stickers_fix_rank" then
		self._impression_stickers_fix_rank = content
	elseif name == "poster_stickers" then
		self._poster_stickers = content
	end
end

function ImpressionStickersConfig:getSticker(id)
	return self._impression_stickers[id]
end

function ImpressionStickersConfig:getStickerCfgs()
	return self._impression_stickers
end

function ImpressionStickersConfig:getPosterStickerCfgs()
	return self._poster_stickers
end

function ImpressionStickersConfig:getPosterSticker(id)
	return self._poster_stickers[id]
end

function ImpressionStickersConfig:getStickerRankCfg(id)
	return self._impression_stickers_fix_rank[id]
end

ImpressionStickersConfig.instance = ImpressionStickersConfig.New()

return ImpressionStickersConfig
