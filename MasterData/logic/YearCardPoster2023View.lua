-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/yearcard2023/hud/YearCardPoster2023View.lua

module("logic.extensions.yearcard.view.yearcard2023.hud.YearCardPoster2023View", package.seeall)

local YearCardPoster2023View = class("YearCardPoster2023View", ViewComponent)

function YearCardPoster2023View:buildUI()
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
		self._itemList[i] = goutil.findChild(self._comList[3], "itemList/item_" .. i .. "/itemPos")
	end
end

function YearCardPoster2023View:bindEvents()
	YearCardPoster2023View.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnLeft, self._onClickLeft, self)
	GameUtil.addClickHandler(self._btnRight, self._onClickRight, self)
end

function YearCardPoster2023View:unbindEvents()
	YearCardPoster2023View.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnLeft)
	GameUtil.rmClickHandler(self._btnRight)
end

function YearCardPoster2023View:onEnter()
	YearCardPoster2023View.super.onEnter(self)

	self._curShowId = checkint(self:getFirstParam())

	if self._curShowId == 0 then
		self._curShowId = 1
	end

	self._udKey = self:_getUDKey()
	self._isFirstShow = checkint(GameUtil.getUserData(self._udKey)) <= 0

	self:_onTurn()

	local matStr = "4:90345:1#1004:1155:1#4:70003:7#1004:1162:1#1004:1163:1#1004:1165:1#1004:1166:1#1004:1167:1"
	local matStrArr = string.split(matStr, "#")

	for i = 1, #self._itemList do
		local str = matStrArr[i]

		if not string.nilorempty(str) then
			MaterialMgr.setCellByCfg(str, self._itemList[i])
		end
	end
end

function YearCardPoster2023View:onExit()
	YearCardPoster2023View.super.onExit(self)

	for k, v in ipairs(self._itemList) do
		MaterialMgr.resetAll(v)
	end
end

function YearCardPoster2023View:_onClickLeft()
	self._curShowId = self._curShowId - 1

	if self._curShowId < 1 then
		self._curShowId = 1
	end

	self:_onTurn()
end

function YearCardPoster2023View:_onClickRight()
	self._curShowId = self._curShowId + 1

	if self._curShowId > #self._comList then
		self._curShowId = #self._comList
	end

	self:_onTurn()
end

function YearCardPoster2023View:_onTurn()
	goutil.setActive(self._btnLeft, self._curShowId > 1)
	goutil.setActive(self._btnRight, self._curShowId < #self._comList)

	for i = 1, #self._comList do
		goutil.setActive(self._comList[i], self._curShowId == i)
	end

	if self._isFirstShow and self._curShowId == #self._comList then
		self._isFirstShow = false

		GameUtil.saveUserData(self._udKey, 1)
	end

	goutil.setActive(self._btnClose, not self._isFirstShow)
end

function YearCardPoster2023View:_getUDKey()
	return ViewName.YearCardPoster2023View .. "_show_poster"
end

return YearCardPoster2023View
