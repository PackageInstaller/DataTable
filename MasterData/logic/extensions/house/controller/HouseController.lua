-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/house/controller/HouseController.lua

module("logic.extensions.house.controller.HouseController", package.seeall)

local M = class("HouseController", BaseController)
local GM_NAMEBAR_KEY = "GM_house_namebar_visible"

function M:onInit()
	self._namebarVisible = Astral.LocalStorage.Instance:GetString(GM_NAMEBAR_KEY, "0") == "1"

	GlobalDispatcher:addEventListener(EventType.SCENE_CACHE_MAIN_PLAYER_POS, self._recordMainPlayerPos, self)
end

function M:onReset()
	return
end

function M:setNamebarVisible(visible)
	self._namebarVisible = visible

	if visible then
		Astral.LocalStorage.Instance:SetString(GM_NAMEBAR_KEY, "1")
	else
		Astral.LocalStorage.Instance:SetString(GM_NAMEBAR_KEY, "0")
	end

	HouseDispatcher:dispatchEvent(HouseEventType.CHANGE_HERO_NAMEBAR_VISIBLE)
end

function M:getNamebarVisible()
	return self._namebarVisible
end

function M:onHeroThoughtEduSuccess(heroId)
	local heroFeatureMo = HeroHouseFeatureModel.instance:getFeatureMO(heroId)

	if heroFeatureMo then
		heroFeatureMo:setIsThoughtEdu(true)
		HouseDispatcher:dispatchEvent(HouseEventType.REPLY_GET_SINGLE_HERO_FEATURE, heroId)

		local formula = heroFeatureMo:getThoughtEduFormula()
		local cfgThoughtEdu = HouseConfig.instance:getConfigByKey(ConfigName.HouseThoughtEdu, formula)
		local plotId = cfgThoughtEdu and cfgThoughtEdu.plot or 0

		if plotId > 0 then
			StoryMgr.instance:clearStep()
			StoryMgr.instance:startSingle(plotId)
		else
			FloatWordMgr.instance:show("思想教育成功，可进行工作入驻")
		end
	end
end

function M:_recordMainPlayerPos(e, x, y, z)
	local save = true

	HouseModel.instance:recordMainPlayerPos(x, y, z, save)
end

function M:getRoomPicPath(roomId)
	return string.format("%s/house_room_cap/%s.png", PlayerModel.instance:getPersonalPath(), roomId)
end

M.instance = M.New()

return M
