-- chunkname: @/tmp/or_script/lua_compile/dm/init.lua

local fps = cc.UserDefault:getInstance():getIntegerForKey("GAME_MAX_FPS", GAME_MAX_FPS)

GAME_MAX_FPS = fps or 30

local director = cc.Director:getInstance()

director:setAnimationInterval(1 / fps)

if GAME_SHOW_FPS or app.pkgConfig.showGameFPS == 1 then
	director:setDisplayStats(true)

	if director.getStatsPresenter then
		local stats = director:getStatsPresenter()
		local format = "GL verts:%6(VERTICES)\n" .. "GL calls:%6(DRAW_CALLS)\n" .. "Tex Memory: %.2(TEXTURE_MEMORY)\n" .. "%.1(FPS) / %.3(SPF)\n" .. "Scheduler: %.3(UPDATE_TIME)\n" .. "Spine: %.3(SPINE_UPDATE_TIME) / %(SPINE_UPDATED_COUNT)\n" .. "MovieClip: %.3(MC_UPDATE_TIME) / %(MC_UPDATED_COUNT)\n"

		stats:setDisplayFormat(format)
		stats:setInteger("SPINE_UPDATED_COUNT", 0)
		stats:setFloat("SPINE_UPDATE_TIME", 0)
		stats:setInteger("MC_UPDATED_COUNT", 0)
		stats:setFloat("MC_UPDATE_TIME", 0)
	end
else
	director:setDisplayStats(false)
end

cc.Image:setPVRImagesHavePremultipliedAlpha(true)
cc.Label:setDefaultTTFAAScale(2)
cc.SpriteFrameCache:getInstance():loadIndicesFromJsonFile("asset/ui/index.json")
cc.SpriteFrameCache:getInstance():loadIndicesFromJsonFile("asset/anim/index.json")
cc.MCLibrary:getInstance():loadIndicesFromJsonFile("asset/anim/mclib.index")

local localLanguage = getCurrentLanguageForRes()

if localLanguage and localLanguage ~= "" then
	cc.SpriteFrameCache:getInstance():loadIndicesFromJsonFile("asset/ui/index_" .. localLanguage .. ".json")
	cc.SpriteFrameCache:getInstance():loadIndicesFromJsonFile("asset/anim/index_" .. localLanguage .. ".json")
	cc.MCLibrary:getInstance():loadIndicesFromJsonFile("asset/anim/mclib_" .. localLanguage .. ".json")
end

require("dm.statistic.StatisticSystem")

if cc.Application:getInstance():getTargetPlatform() ~= 2 then
	StatisticSystem:init()
end
