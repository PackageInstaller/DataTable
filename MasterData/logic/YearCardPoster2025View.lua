-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/yearcard2025/hud/YearCardPoster2025View.lua

module("logic.extensions.yearcard.view.yearcard2025.hud.YearCardPoster2025View", package.seeall)

local YearCardPoster2025View = class("YearCardPoster2025View", YearCardPoster2023View)

function YearCardPoster2025View:_getUDKey()
	return ViewName.YearCardPoster2025View .. "_show_poster"
end

function YearCardPoster2025View:buildUI()
	self._btnClose = self:getGo("btnClose")
	self._btnLeft = self:getGo("btnLeft")
	self._btnRight = self:getGo("btnRight")
	self._comList = {}

	for i = 1, 5 do
		self._comList[i] = self:getGo("comList/com_" .. i)
	end

	self._itemList = {}

	for i = 1, 8 do
		self._itemList[i] = goutil.findChild(self._comList[3], "itemList/item_" .. i .. "/itemPos")
	end
end

function YearCardPoster2025View:onEnter()
	YearCardPoster2023View.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._curShowId = checkint(params[1])
	self._activityId = checknumber(params[2])

	if self._curShowId == 0 then
		self._curShowId = 1
	end

	self._udKey = self:_getUDKey()
	self._isFirstShow = checkint(GameUtil.getUserData(self._udKey)) <= 0

	self:_onTurn()

	local matStr = YearCardConfig.instance:getYearcardCommonValue("Poster2025")
	local matStrArr = string.split(matStr, "#")

	for i = 1, #self._itemList do
		local str = matStrArr[i]

		if not string.nilorempty(str) then
			MaterialMgr.setCellByCfg(str, self._itemList[i])
		end
	end
end

function YearCardPoster2025View:_getUDKey()
	return YearCardController.YearCard2025_AniKey .. "_show_poster"
end

return YearCardPoster2025View
