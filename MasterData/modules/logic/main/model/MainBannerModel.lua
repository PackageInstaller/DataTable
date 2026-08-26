-- chunkname: @modules/logic/main/model/MainBannerModel.lua

module("modules.logic.main.model.MainBannerModel", package.seeall)

local MainBannerModel = class("MainBannerModel", BaseModel)

function MainBannerModel:onInit()
	self._notShowIds = {}

	local bannersNotShow = PlayerPrefsHelper.getString(PlayerPrefsKey.BannersNotShow, "")
	local banners = string.split(bannersNotShow, "#")

	for _, v in pairs(banners) do
		if v ~= nil and v ~= "" then
			table.insert(self._notShowIds, tonumber(v))
		end
	end
end

function MainBannerModel:addNotShowid(id)
	for _, v in pairs(self._notShowIds) do
		if v == id then
			return
		end
	end

	table.insert(self._notShowIds, id)

	local bannersNotShow = table.concat(self._notShowIds, "#")

	PlayerPrefsHelper.setString(PlayerPrefsKey.BannersNotShow, bannersNotShow)
end

function MainBannerModel:getBannerInfo()
	return self._notShowIds
end

MainBannerModel.instance = MainBannerModel.New()

return MainBannerModel
