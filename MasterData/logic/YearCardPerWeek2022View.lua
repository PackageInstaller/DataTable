-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/YearCard2022/YearCardPerWeek2022View.lua

module("logic.extensions.yearcard.view.2022.YearCardPerWeek2022View", package.seeall)

local YearCardPerWeek2022View = class("YearCardPerWeek2022View", ViewComponent)

function YearCardPerWeek2022View:ctor()
	YearCardPerWeek2022View.super.ctor(self)

	self._curPrizeNum = 5
end

function YearCardPerWeek2022View:buildUI()
	YearCardPerWeek2022View.super.buildUI(self)

	self._btnSure = self:getBtn("reward/btnSure")
	self._getedGo = self:getGo("reward/btnSure/geted")
	self._cellList = {}

	for i = 1, self._curPrizeNum do
		local cell = {}

		cell.go = self:getGo("reward/cell_" .. i)
		cell.item = goutil.findChild(cell.go, "item")
		cell.tag = goutil.findChild(cell.go, "tag")
		self._cellList[i] = cell
	end
end

function YearCardPerWeek2022View:bindEvents()
	YearCardPerWeek2022View.super.bindEvents(self)
	self._btnSure:AddClickListener(self._onClickSure, self)
end

function YearCardPerWeek2022View:unbindEvents()
	YearCardPerWeek2022View.super.unbindEvents(self)
	self._btnSure:RemoveClickListener()
end

function YearCardPerWeek2022View:onEnter()
	YearCardPerWeek2022View.super.onEnter(self)

	self._curActId = self:_getActId()
	self._actInfo = YearCardModel.instance:getAnnuityInfo(self._curActId)
	self._curCfg = PayShopConfig.instance:getAnnuityCfgById(self._curActId)

	for k, v in ipairs(self._cellList) do
		MaterialMgr.setCellByCfg(((not string.nilorempty(self._curCfg.weeklyGain) or nil) and string.split(self._curCfg.weeklyGain, "#"))[k], v.item)
	end

	self:_refreshView()
	GlobalDispatcher:addListener(GlobalNotify.AnnuityInfoChange, self._refreshView, self)
end

function YearCardPerWeek2022View:onExit()
	YearCardPerWeek2022View.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.AnnuityInfoChange, self._refreshView, self)

	for k, v in ipairs(self._cellList) do
		MaterialMgr.resetAll(v.item)
	end
end

function YearCardPerWeek2022View:_getActId()
	return YearCardModel.instance:getCurAnnuityId()
end

function YearCardPerWeek2022View:_onClickSure()
	YearCardController.instance:onClickWeekReward(self._curActId)
end

function YearCardPerWeek2022View:_refreshView()
	if self._actInfo and self._actInfo.active then
		local hasGain = YearCardModel.instance:getHasGainWeeklyPrize(self._curActId)

		self:_refreshGetState(hasGain)

		for k, v in ipairs(self._cellList) do
			goutil.setActive(v.tag, hasGain)
		end
	else
		self:_refreshGetState(false)

		for k, v in ipairs(self._cellList) do
			goutil.setActive(v.tag, false)
		end
	end
end

function YearCardPerWeek2022View:_refreshGetState(hasGain)
	self._getedGo:SetActive(hasGain)
	GameUtil.SetGray(self._btnSure, hasGain)
end

return YearCardPerWeek2022View
