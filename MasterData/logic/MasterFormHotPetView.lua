-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/masterform/view/MasterFormHotPetView.lua

module("logic.extensions.masterform.view.MasterFormHotPetView", package.seeall)

local MasterFormHotPetView = class("MasterFormHotPetView", ViewComponent)

function MasterFormHotPetView:ctor()
	MasterFormHotPetView.super.ctor(self)
end

function MasterFormHotPetView:unbindEvents()
	MasterFormHotPetView.super.unbindEvents(self)
end

function MasterFormHotPetView:bindEvents()
	MasterFormHotPetView.super.bindEvents(self)
end

function MasterFormHotPetView:buildUI()
	MasterFormHotPetView.super.buildUI(self)

	self._petView = self:getGo("contentCol/petCol/petView")
	self._petCell = self:getGo("contentCol/petCol/petView/petCell")
	self._testRecordPos = self._petView:GetComponent(ComponentType.TestRecordPos)
	self._txtName = self:getTxt("contentCol/topCol/txtName")
	self._emptyGo = self:getGo("contentCol/petCol/emptyGo")
	self._txtTime = self:getTxt("contentCol/time/txtTime")
	self._tabScrollerview = self:getGo("tabCol/tabScrollerview")
	self._tabScrollercell = self:getGo("tabCol/tabScrollercell")
	self._tabScrollList = ScrollerList.create(self._tabScrollerview, self._tabScrollercell, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))
	self._petTableview = self:getGo("contentCol/petCol/petTableview")
	self._petTableCell = self:getGo("contentCol/petCol/petTableview/petTableCell")
	self._petTableList = ScrollerList.create(self._petTableview, self._petTableCell, GameUtil.handler(self._updatePetTableCell, self), GameUtil.handler(self._clearPetTableCell, self))
end

function MasterFormHotPetView:onExit()
	MasterFormHotPetView.super.onExit(self)
	GameUtil.clearCells(self._petView, self._clearPetCell, self)
end

function MasterFormHotPetView:onEnter()
	MasterFormHotPetView.super.onEnter(self)

	self._periodId = MasterFormController.instance:getPeriodId()

	if self._periodId == 0 then
		FloatWordMgr.instance:show("not in activity time")

		return
	end

	local baseData = MasterFormConfig.instance:getMfBaseData(self._periodId)

	self._hotPetPlanId = baseData and checknumber(baseData.hotPetPlanId) or 0
	self._curTabIdx = 1

	self:initView()
	self:_refreshView()
end

function MasterFormHotPetView:initView()
	local baseData = MasterFormConfig.instance:getMfBaseData(self._periodId)

	if baseData then
		if not baseData.winRateStatisticalPeriod then
			local statisticalPeriod = ""
			local timeArray = string.split(statisticalPeriod, "#")

			if #timeArray >= 2 then
				local startDate = GameUtil.string2date(timeArray[1])
				local endDate = GameUtil.string2date(timeArray[2])

				self._txtTime.text = langPara("统计时间：%s.%s-%s.%s", startDate.month, startDate.day, endDate.month, endDate.day)
			else
				self._txtTime.text = ""
			end
		end
	end
end

function MasterFormHotPetView:_refreshView()
	local tabList = MasterFormConfig.instance:getHotPetTab(self._hotPetPlanId) or {}
	local tabData = tabList[self._curTabIdx]

	if tabData then
		if not tabData.raceId then
			local raceIdList = {}

			self._tabScrollList:reloadData(tabList)

			if tabData then
				self._txtName.text = tabData.name or ""
			end

			GameUtil.SetActive(self._emptyGo, #raceIdList == 0)
			GameUtil.SetActive(self._petView, #raceIdList > 0 and #raceIdList <= 6)
			GameUtil.SetActive(self._petTableview, #raceIdList > 6)

			if #raceIdList > 0 then
				if #raceIdList <= 6 then
					GameUtil.updateCellsList(self._petView, self._petCell, raceIdList, self._updatePetCell, self)
					self._testRecordPos:LoadPlan(#raceIdList - 1)
				else
					self._petTableList:reloadData(raceIdList)
				end
			end
		end
	end
end

function MasterFormHotPetView:_updateTabCell(view, cell, data, tag)
	local go = cell.gameObject
	local tabIdx = data.index
	local imgSelect = goutil.findChild(go, "imgSelect")
	local txtName = goutil.findChildTextComponent(go, "txtName")

	txtName.text = data.name

	GameUtil.SetActive(imgSelect, tabIdx == self._curTabIdx)
	GameUtil.rmClickHandler(go)
	GameUtil.addClickHandler(go, GameUtil.handler(self._onClickTab, self, tabIdx))
end

function MasterFormHotPetView:_clearTabCell(cell)
	local go = cell.gameObject

	GameUtil.rmClickHandler(go)
end

function MasterFormHotPetView:_onClickTab(tabIdx)
	if self._curTabIdx == tabIdx then
		return
	end

	self._curTabIdx = tabIdx

	self:_refreshView()
end

function MasterFormHotPetView:_updatePetCell(cell, raceId, index)
	local con = goutil.findChild(cell, "con")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtWinRate = goutil.findChildTextComponent(cell, "winRate/txtWinRate")
	local hotPetData = MasterFormConfig.instance:getHotPetCfg(raceId)

	MaterialMgr.resetAll(con)

	local proxy = MaterialMgr.setCell(MatType.Pet, raceId, con)

	txtName.text = MaterialMgr.getMaterialsName(MatType.Pet, raceId)

	if hotPetData then
		txtWinRate.text = hotPetData.winRate or ""
	end

	if proxy then
		proxy.binder:setClickCallBack(GameUtil.handler(self._onClickPet, self, raceId))
	end
end

function MasterFormHotPetView:_clearPetCell(cell)
	local con = goutil.findChild(cell, "con")

	MaterialMgr.resetAll(con)
end

function MasterFormHotPetView:_updatePetTableCell(view, cell, raceId, index)
	local go = cell.gameObject
	local con = goutil.findChild(go, "con")
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local txtWinRate = goutil.findChildTextComponent(go, "winRate/txtWinRate")
	local hotPetData = MasterFormConfig.instance:getHotPetCfg(raceId)

	MaterialMgr.resetAll(con)

	local proxy = MaterialMgr.setCell(MatType.Pet, raceId, con)

	txtName.text = MaterialMgr.getMaterialsName(MatType.Pet, raceId)

	if hotPetData then
		txtWinRate.text = hotPetData.winRate or ""
	end

	if proxy then
		proxy.binder:setClickCallBack(GameUtil.handler(self._onClickPet, self, raceId))
	end
end

function MasterFormHotPetView:_clearPetTableCell(cell)
	local go = cell.gameObject
	local con = goutil.findChild(go, "con")

	MaterialMgr.resetAll(con)
end

function MasterFormHotPetView:_onClickPet(raceId)
	local hotPetCfg = MasterFormConfig.instance:getHotPetCfg(raceId)

	if hotPetCfg and (checknumber(hotPetCfg.cutePetId) > 0 or hotPetCfg.equipDefineId or hotPetCfg.holyStripeId or hotPetCfg.starGodsId) then
		UIStateManager.instance:push(ViewName.MasterFormHotPetDetailView, raceId)
	else
		local str = string.format("%s:%s", MatType.Pet, raceId)

		TipsFacade.instance:openItemSourceView(str)
	end
end

return MasterFormHotPetView
