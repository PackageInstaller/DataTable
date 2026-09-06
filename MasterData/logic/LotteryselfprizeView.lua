-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lottery/view/LotteryselfprizeView.lua

module("logic.extensions.lottery.view.LotteryselfprizeView", package.seeall)

local LotteryselfprizeView = class("LotteryselfprizeView", ViewComponent)

function LotteryselfprizeView:ctor()
	LotteryselfprizeView.super.ctor(self)
end

function LotteryselfprizeView:unbindEvents()
	LotteryselfprizeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._closeBtn)
	GameUtil.rmClickHandler(self._btnSort)
end

function LotteryselfprizeView:bindEvents()
	LotteryselfprizeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._closeBtn, self._onClickCloseBtn, self)
	GameUtil.addClickHandler(self._btnSort, self._onClickSort, self)
end

function LotteryselfprizeView:buildUI()
	LotteryselfprizeView.super.buildUI(self)

	self._closeBtn = self:getGo("viewInfoGo/closeBtn")
	self._desStrTxt = self:getTxt("viewInfoGo/desStrTxt")
	self._tipsTxt = self:getGo("viewInfoGo/tipsTxt")
	self._choiMatGo = self:getGo("viewInfoGo/choiMatGo")
	self._addImaGo = self:getGo("viewInfoGo/choiMatGo/addImaGo")

	GameUtil.SetActive(self._tipsTxt, false)
	GameUtil.SetActive(self._choiMatGo, false)

	self._btnSort = self:getGo("viewInfoGo/btnSort")
	self._imgChangeSort = goutil.findChildComponent(self._btnSort, "imgSort", "UIImageSpriteChange")

	local scroll = self:getGo("viewInfoGo/cellItemSR")
	local cell = self:getGo("viewInfoGo/cellItem")

	self._scrollList = ScrollerList.create(scroll, cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self.clearCell, self))
end

function LotteryselfprizeView:onExit()
	LotteryselfprizeView.super.onExit(self)
	self._scrollList:dispose()
end

function LotteryselfprizeView:onEnter()
	LotteryselfprizeView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._poolId = checknumber(params[1])
	self._groupId = checknumber(params[2])
	self._gridId = checknumber(params[3])
	self._sortType = 0

	self:_refreshUI()
end

function LotteryselfprizeView:_refreshUI()
	local cfg = LotteryConfig.instance:GetSelfSelectPetGroupCfgByGirdId(self._poolId, self._gridId) or {}

	if not cfg.raceIds then
		local raceIds = {}
		local curRaceIds = {}

		for i, raceId in ipairs(raceIds) do
			table.insert(curRaceIds, raceId)
		end

		if self._sortType == 0 then
			-- block empty
		elseif self._sortType == 1 then
			ArraySort.sortOn(curRaceIds, {
				function(data)
					if BagModel.instance:isExistRaceId(data) then
						return 1
					else
						return 0
					end
				end,
				function(data)
					return BagModel.instance:getMaxAwakenLv(data)
				end
			}, {
				ArraySort.DESCENDING,
				ArraySort.DESCENDING
			})
		elseif self._sortType == 2 then
			ArraySort.sortOn(curRaceIds, {
				function(data)
					if BagModel.instance:isExistRaceId(data) then
						return 1
					else
						return 0
					end
				end,
				function(data)
					return BagModel.instance:getMaxAwakenLv(data)
				end
			}, {
				ArraySort.NUMERIC,
				ArraySort.NUMERIC
			})
		end

		self._scrollList:reloadData(curRaceIds)
		self._imgChangeSort:SetState(self._sortType)
	end
end

function LotteryselfprizeView:_updateCell(view, cell, data, tag)
	local iconGo = goutil.findChild(cell, "iconGo")
	local stageGo = goutil.findChild(cell, "stageGo")
	local buyBtnGo = goutil.findChild(cell, "buyBtn")
	local limitTxt = goutil.findChildTextComponent(cell, "limitTxt")
	local nameTxt = goutil.findChildTextComponent(cell, "nameTxt")
	local awake = goutil.findChild(cell, "awake")
	local imgAwake = goutil.findChildComponent(cell, "awake/imgLv", "UIImageSpriteChange")
	local goNotGain = goutil.findChild(cell, "notGain")

	GameUtil.rmClickHandler(buyBtnGo)

	limitTxt.text = ""

	GameUtil.SetActive(stageGo, false)

	local cfgStr = MaterialMgr.createSerName(MatType.Pet, data)

	MaterialMgr.setCellByCfg(cfgStr, iconGo)
	GameUtil.addClickHandler(buyBtnGo, function()
		self:_onSelectPet(data)
	end)
	GameUtil.SetActive(goNotGain, false)

	local awakenLv = BagModel.instance:getMaxAwakenLv(data)

	if BagModel.instance:isExistRaceId(data) then
		goutil.setActive(awake, true)
		imgAwake:SetState(awakenLv)
	else
		goutil.setActive(awake, false)
		GameUtil.SetActive(goNotGain, true)
	end
end

function LotteryselfprizeView:clearCell(cell)
	local iconGo = goutil.findChild(cell, "iconGo")
	local stageGo = goutil.findChild(cell, "stageGo")
	local buyBtnGo = goutil.findChild(cell, "buyBtn")
	local limitTxt = goutil.findChildTextComponent(cell, "limitTxt")
	local nameTxt = goutil.findChildTextComponent(cell, "nameTxt")

	GameUtil.rmClickHandler(buyBtnGo)
	MaterialMgr.resetAll(iconGo)
end

function LotteryselfprizeView:_onSelectPet(raceId)
	self._currSelectRaceId = raceId

	local name = MaterialMgr.getMaterialsName(MatType.Pet, self._currSelectRaceId)
	local content = langPara("是否将%s设置为概率up精灵，选择后需要重置奖励才可更改", name)

	TipsFacade.instance:openPopupWindow(lang("tip"), content, function()
		LotteryController.instance:sendSelfSelectPetUp(self._poolId, self._groupId, self._gridId, self._currSelectRaceId)
		self:close()
	end, function()
		self._currSelectRaceId = 0
	end)
end

function LotteryselfprizeView:_onClickCloseBtn()
	self:close()
end

function LotteryselfprizeView:_onClickSort()
	self._sortType = self._sortType + 1

	if self._sortType > 2 then
		self._sortType = 0
	end

	self:_refreshUI()
end

return LotteryselfprizeView
