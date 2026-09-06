-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wishlist/config/WishListConfig.lua

module("logic.extensions.wishlist.config.WishListConfig", package.seeall)

local WishListConfig = class("WishListConfig", BaseConfig)

function WishListConfig:onInit()
	WishListConfig.super.onInit(self)

	self._prizeCfgs = nil
	self._blessCfgs = nil
	self._blessShowCfgs = nil
end

function WishListConfig:getNames()
	return {
		"wish_list_day",
		"wish_list_content"
	}
end

function WishListConfig:handleConfig(name, content)
	if name == "wish_list_day" then
		self._prizeCfgs = content
	elseif name == "wish_list_content" then
		self._blessCfgs = {}

		for _, cfg in ipairs(content.dataList) do
			self._blessCfgs[cfg.activityId] = self._blessCfgs[cfg.activityId] or {}
			self._blessCfgs[cfg.activityId][cfg.belongDay] = self._blessCfgs[cfg.activityId][cfg.belongDay] or {}

			table.insert(self._blessCfgs[cfg.activityId][cfg.belongDay], cfg)
		end

		self._blessShowCfgs = content
	end
end

function WishListConfig:getPrizeCfg(actId, dayId)
	if not dayId then
		return self._prizeCfgs[actId]
	else
		return self._prizeCfgs[actId][dayId]
	end
end

function WishListConfig:getBlessCfgByDayId(actId, dayId)
	if not dayId then
		return self._blessCfgs[actId]
	else
		return self._blessCfgs[actId][dayId]
	end
end

function WishListConfig:getBlessCfgById(actId, id)
	return self._blessShowCfgs[actId][id]
end

WishListConfig.instance = WishListConfig.New()

return WishListConfig
