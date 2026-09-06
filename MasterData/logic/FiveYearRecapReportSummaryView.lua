-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fiveyearrecap/view/FiveYearRecapReportSummaryView.lua

module("logic.extensions.fiveyearrecap.view.FiveYearRecapReportSummaryView", package.seeall)

local FiveYearRecapReportSummaryView = class("FiveYearRecapReportSummaryView", ViewComponent)

function FiveYearRecapReportSummaryView:ctor()
	FiveYearRecapReportSummaryView.super.ctor(self)
end

function FiveYearRecapReportSummaryView:buildUI()
	FiveYearRecapReportSummaryView.super.buildUI(self)

	self._txtBattleCount = self:getTxt("battleCount/txt")
	self._txtLoginTime = self:getTxt("loginTime/txt")
	self._iconHead = self:getGo("head/icon")
	self._txtNameHead = self:getTxt("head/name/txt")

	local personBarView = self:getGo("person/barView")

	self._personBarGos = GameUtil.getChildren(personBarView)

	local pveBarView = self:getGo("pve/barView")

	self._pveBarGos = GameUtil.getChildren(pveBarView)

	local pvpBarView = self:getGo("pvp/barView")

	self._pvpBarGos = GameUtil.getChildren(pvpBarView)
	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnShare = self:getGo("btnShare")
end

function FiveYearRecapReportSummaryView:bindEvents()
	FiveYearRecapReportSummaryView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnShare, self._onClickShare, self)
end

function FiveYearRecapReportSummaryView:unbindEvents()
	FiveYearRecapReportSummaryView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnShare)
end

function FiveYearRecapReportSummaryView:onEnter()
	FiveYearRecapReportSummaryView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._isAutoShare = params[2] or false
	self._subMo = FiveYearRecapController.instance:getSubMo(self._activityId)

	HeadItemController.instance:setMyHeadCell(self._iconHead)

	self._txtNameHead.text = RoleModel.instance:getUserName()

	self:_onUpdate()

	if self._isAutoShare then
		settimer(0.5, self._onClickShare, self, false)
	end

	FiveYearRecapController.instance:setHasReported(self._activityId)
end

function FiveYearRecapReportSummaryView:onExit()
	FiveYearRecapReportSummaryView.super.onExit(self)
	removetimer(self._onClickShare, self)
	HeadItemController.instance:resetHeadCell(self._iconHead)
	self:_onClear()
end

function FiveYearRecapReportSummaryView:_onUpdate()
	local firstLoginTime = self._subMo:getRecapData(FiveYearRecapEnum.DataIds_RegisterTime) or 0

	self._txtLoginTime.text = GameUtil.formatTimeStamp("%Y-%m-%d", firstLoginTime)
	self._txtBattleCount.text = self._subMo:getRecapData(FiveYearRecapEnum.DataIds_PveBattleCount) or 0

	self:_onUpdatePersonBarUI()
	self:_onUpdatePveBarUI()
	self:_onUpdatePvpBarUI()
end

function FiveYearRecapReportSummaryView:_onClear()
	self:_clearPersonBarUI()
	self:_onClearPveBarUI()
	self:_onClearPvpBarUI()
end

function FiveYearRecapReportSummaryView:_onUpdatePersonBarUI()
	local tagIdList = {}
	local datas = FiveYearRecapConfig.instance:getPersonTagDatas(self._activityId)

	for _, data in ipairs(datas) do
		table.insert(tagIdList, data.tagId)
	end

	local idList = self._subMo:filterFitTagList(tagIdList)

	ArraySort.sortOn(idList, function(tagId)
		local data = FiveYearRecapConfig.instance:getPersonTagData(self._activityId, tagId)

		return (data or nil) and (data.sortId or 0)
	end, ArraySort.NUMERIC)

	for idx, mainGo in ipairs(self._personBarGos) do
		local tagId = idList[idx]

		if tagId then
			local data = FiveYearRecapConfig.instance:getPersonTagData(self._activityId, tagId)

			self:_updatePersonBarCell(mainGo, data)
		else
			self:_clearPersonBarCell(mainGo)
		end
	end
end

function FiveYearRecapReportSummaryView:_clearPersonBarUI()
	for _, mainGo in pairs(self._personBarGos) do
		self:_clearPersonBarCell(mainGo)
	end
end

function FiveYearRecapReportSummaryView:_updatePersonBarCell(mainGo, data)
	local txtDesc = goutil.findChildTextComponent(mainGo, "txtDesc")

	GameUtil.SetActive(mainGo, true)

	txtDesc.text = data.desc
end

function FiveYearRecapReportSummaryView:_clearPersonBarCell(mainGo)
	GameUtil.SetActive(mainGo, false)
end

function FiveYearRecapReportSummaryView:_onUpdatePveBarUI()
	local datass = FiveYearRecapConfig.instance:getReportSummaryDatass(self._activityId, 1)
	local dataLength = #datass
	local childCount = #self._pveBarGos

	for barId = 1, Mathf.Max(dataLength, childCount) do
		local barData

		if barId <= dataLength then
			if not datass[barId] then
				do
					local datas = {}

					for _, data in ipairs(datas) do
						local value = self._subMo:getAdapterResult(data.value)
						local isFit = checknumber(value) > 0

						if isFit then
							barData = data

							break
						end
					end
				end

				local mainGo = self._pveBarGos[barId]

				if barData then
					self:_updatePveBarCell(mainGo, barData)
				else
					self:_clearPveBarCell(mainGo)
				end
			end
		end
	end
end

function FiveYearRecapReportSummaryView:_onClearPveBarUI()
	for _, mainGo in ipairs(self._pveBarGos) do
		self:_clearPveBarCell(mainGo)
	end
end

function FiveYearRecapReportSummaryView:_updatePveBarCell(mainGo, data)
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local txtValue = goutil.findChildTextComponent(mainGo, "txtValue")

	txtValue.text = self._subMo:getAdapterResult(data.value)
	txtName.text = data.name

	GameUtil.SetActive(mainGo, true)
end

function FiveYearRecapReportSummaryView:_clearPveBarCell(mainGo)
	GameUtil.SetActive(mainGo, false)
end

function FiveYearRecapReportSummaryView:_onUpdatePvpBarUI()
	local datass = FiveYearRecapConfig.instance:getReportSummaryDatass(self._activityId, 2)
	local dataLength = #datass
	local childCount = #self._pvpBarGos

	for barId = 1, Mathf.Max(dataLength, childCount) do
		local barData

		if barId <= dataLength then
			if not datass[barId] then
				do
					local datas = {}

					for _, data in ipairs(datas) do
						local value = self._subMo:getAdapterResult(data.value)
						local isFit = checknumber(value) > 0

						if isFit then
							barData = data

							break
						end
					end
				end

				local mainGo = self._pvpBarGos[barId]

				if barData then
					self:_updatePvpBarCell(mainGo, barData)
				else
					self:_clearPvpBarCell(mainGo)
				end
			end
		end
	end
end

function FiveYearRecapReportSummaryView:_onClearPvpBarUI()
	for _, mainGo in ipairs(self._pvpBarGos) do
		self:_clearPvpBarCell(mainGo)
	end
end

function FiveYearRecapReportSummaryView:_updatePvpBarCell(mainGo, data)
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local txtValue = goutil.findChildTextComponent(mainGo, "txtValue")

	txtValue.text = self._subMo:getAdapterResult(data.value)
	txtName.text = data.name

	GameUtil.SetActive(mainGo, true)
end

function FiveYearRecapReportSummaryView:_clearPvpBarCell(mainGo)
	GameUtil.SetActive(mainGo, false)
end

function FiveYearRecapReportSummaryView:_onClickShare()
	local actData = FiveYearRecapConfig.instance:getActivityData(self._activityId)

	ShareController.instance:share(1, {
		self._btnShare.gameObject
	}, nil, 0, function()
		if not self._subMo:isHasShared() then
			FiveYearRecapController.instance:sendPM_FiveYearRecapShareReq(self._activityId)
		end
	end)
end

return FiveYearRecapReportSummaryView
