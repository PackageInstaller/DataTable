-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/yearcard2026/hud/YearCardPoster2026View.lua

module("logic.extensions.yearcard.view.yearcard2026.hud.YearCardPoster2026View", package.seeall)

local YearCardPoster2026View = class("YearCardPoster2026View", YearCardPoster2023View)

function YearCardPoster2026View:_getUDKey()
	return ViewName.YearCardPoster2026View .. "_show_poster"
end

function YearCardPoster2026View:buildUI()
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

function YearCardPoster2026View:onEnter()
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

	local matStr = YearCardConfig.instance:getYearcardCommonValue("Poster2026")
	local matStrArr = string.split(matStr, "#")

	for i = 1, #self._itemList do
		local str = matStrArr[i]

		if not string.nilorempty(str) then
			MaterialMgr.setCellByCfg(str, self._itemList[i])
		end
	end
end

function YearCardPoster2026View:_getUDKey()
	return YearCardController.YearCard2026_AniKey .. "_show_poster"
end

return YearCardPoster2026View
