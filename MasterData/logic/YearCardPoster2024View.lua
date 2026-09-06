-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/yearcard2024/hud/YearCardPoster2024View.lua

module("logic.extensions.yearcard.view.yearcard2024.hud.YearCardPoster2024View", package.seeall)

local YearCardPoster2024View = class("YearCardPoster2024View", YearCardPoster2023View)

function YearCardPoster2024View:_getUDKey()
	return ViewName.YearCardPoster2024View .. "_show_poster"
end

function YearCardPoster2024View:buildUI()
	YearCardPoster2023View.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnLeft = self:getGo("btnLeft")
	self._btnRight = self:getGo("btnRight")
	self._comList = {}

	for i = 1, 5 do
		self._comList[i] = self:getGo("comList/com_" .. i)
	end

	self._itemList = {}

	for i = 1, 8 do
		self._itemList[i] = goutil.findChild(self._comList[2], "itemList/item_" .. i .. "/itemPos")
	end
end

function YearCardPoster2024View:onEnter()
	YearCardPoster2023View.super.onEnter(self)

	self._curShowId = checkint(self:getFirstParam())

	if self._curShowId == 0 then
		self._curShowId = 1
	end

	self._udKey = self:_getUDKey()
	self._isFirstShow = checkint(GameUtil.getUserData(self._udKey)) <= 0

	self:_onTurn()

	local matStr = "4:90425:1#4:70003:7#1004:1337:1#1004:1344:1#1004:1345:1#1004:1347:1#1004:1348:1#1004:1349:1"
	local matStrArr = string.split(matStr, "#")

	for i = 1, #self._itemList do
		local str = matStrArr[i]

		if not string.nilorempty(str) then
			MaterialMgr.setCellByCfg(str, self._itemList[i])
		end
	end
end

return YearCardPoster2024View
