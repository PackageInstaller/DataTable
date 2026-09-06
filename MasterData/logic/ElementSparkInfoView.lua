-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/elementspark/view/ElementSparkInfoView.lua

module("logic.extensions.elementspark.view.ElementSparkInfoView", package.seeall)

local ElementSparkInfoView = class("ElementSparkInfoView", ViewComponent)

ElementSparkInfoView.TabConst = {
	CampRank = 2,
	Info = 1,
	Resource = 4,
	PersonRank = 3
}

local viewname = {
	[ElementSparkInfoView.TabConst.Info] = ViewName.ElementSparkDetailView,
	[ElementSparkInfoView.TabConst.CampRank] = ViewName.ElementSparkCampRankView,
	[ElementSparkInfoView.TabConst.PersonRank] = ViewName.ElementSparkPersonRankView,
	[ElementSparkInfoView.TabConst.Resource] = ViewName.ElementSparkResourceView
}
local title = {
	[ElementSparkInfoView.TabConst.Info] = "信息",
	[ElementSparkInfoView.TabConst.CampRank] = "阵营排行榜",
	[ElementSparkInfoView.TabConst.PersonRank] = "个人排行榜",
	[ElementSparkInfoView.TabConst.Resource] = "资源地"
}
local tipIndex = {
	[ElementSparkInfoView.TabConst.Info] = "ElementSparkDetail_rule",
	[ElementSparkInfoView.TabConst.CampRank] = "ElementSparkCampRank_rule",
	[ElementSparkInfoView.TabConst.PersonRank] = "ElementSparkPersonRank_rule",
	[ElementSparkInfoView.TabConst.Resource] = "ElementSparkResource_rule"
}

function ElementSparkInfoView:ctor()
	ElementSparkInfoView.super.ctor(self)
end

function ElementSparkInfoView:unbindEvents()
	ElementSparkInfoView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)

	for _, v in ipairs(self._btns) do
		GameUtil.rmClickHandler(v.btn)
	end

	for i, v in ipairs(self._campCell) do
		GameUtil.rmClickHandler(v.go)
	end
end

function ElementSparkInfoView:bindEvents()
	ElementSparkInfoView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)

	for i, v in ipairs(self._btns) do
		GameUtil.addClickHandler(v.btn, GameUtil.handler(self._onClickShowTab, self, i))
	end
end

function ElementSparkInfoView:buildUI()
	ElementSparkInfoView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._txtTitle = self:getTxt("txtTitle")
	self._btnTip = self:getBtn("txtTitle/btnTip")
	self._container = self:getGo("container")
	self._btnCon = self:getGo("btns")
	self._btnCampCell = self:getGo("btnCamp")
	self._cellsCon = self:getGo("btns/btn_3/cells")
	self._resourceRd = self:getGo("btns/btn_4/btn/redpoint")
	self._btnCount = 4
	self._btns = {}
	self._campCell = {}

	for i = 1, self._btnCount do
		local tab = {}

		tab.go = self:getGo("btns/btn_" .. i)
		tab.btn = self:getBtn("btns/btn_" .. i .. "/btn")
		tab.change = tab.btn:GetComponent("UIChangeGroup")

		tab.change:SetState(0)
		table.insert(self._btns, tab)
	end
end

function ElementSparkInfoView:onExit()
	ElementSparkInfoView.super.onExit(self)
end

function ElementSparkInfoView:onExit()
	ElementSparkInfoView.super.onExit(self)
	self._btns[self._tabId].change:SetState(0)
	self._campCell[self._campId].change:SetState(0)
	GameUtil.SetActive(self._cellsCon, false)
end

function ElementSparkInfoView:onEnter()
	ElementSparkInfoView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.ElementSparkMoveChunkToCenter, self.close, self)
	self.addGEvent(self, GlobalNotify.EleSparkGainResourceRes, self._hideResourceRd, self)

	self._activityId = ElementSparkController.instance:getActivityId()
	self._myCampId = ElementSparkModel.instance:getMyCampId()
	self._campId = self._myCampId

	if self._myCampId <= 0 then
		self._campId = 1
	end

	self._isResultTime = ElementSparkController.instance:isResultTime()

	self:_refreshStageInfo()
	self:_onClickShowTab(self._tabId)

	self._isShowDropDown = false

	local campCfg = ElementSparkConfig.instance:getCampCfg(self._activityId)

	if campCfg and #campCfg > 0 then
		for i, v in ipairs(campCfg) do
			if self._campCell[v.campId] == nil then
				self._campCell[v.campId] = {}
				cellGo = goutil.cloneAndSetParent(self._btnCampCell, self._cellsCon.transform, "btnCamp_" .. v.campId)
				self._campCell[v.campId].go = cellGo
				self._campCell[v.campId].txtName = goutil.findChildTextComponent(cellGo, "txt")
				self._campCell[v.campId].tag = goutil.findChild(cellGo, "tag")
				self._campCell[v.campId].change = cellGo:GetComponent("UIChangeGroup")
			end

			local isMyCamp = self._myCampId == i

			self._campCell[v.campId].txtName.text = v.name

			GameUtil.SetActive(self._campCell[v.campId].tag, isMyCamp)
			GameUtil.addClickHandler(self._campCell[v.campId].go, GameUtil.handler(self._onClickRank, self, v.campId))
		end
	end
end

function ElementSparkInfoView:_refreshStageInfo()
	local params = self:getOpenParam()
	local isHide = false

	isHide = params[2] and true or self._myCampId <= 0 and self._isResultTime
	self._tabId = not isHide and (checknumber(params[1]) or 1) or 2

	GameUtil.SetActive(self._btns[1].go.gameObject, not isHide)
	GameUtil.SetActive(self._btns[4].go.gameObject, not isHide)
	self:_refreshRd()
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._btnCon:GetComponent(goutil.Type_RectTransform))
end

function ElementSparkInfoView:_refreshRd()
	if not self._isResultTime then
		local isCanGain = ElementSparkController.instance:isCanGainResource()

		GameUtil.SetActive(self._resourceRd, isCanGain)
	else
		GameUtil.SetActive(self._resourceRd, false)
	end
end

function ElementSparkInfoView:_hideResourceRd()
	GameUtil.SetActive(self._resourceRd, false)
end

function ElementSparkInfoView:_onClickShowTab(i)
	local view = viewname[i]

	self._btns[self._tabId].change:SetState(0)

	self._tabId = i
	self._txtTitle.text = title[i]

	if self._isShowDropDown and i ~= 3 then
		self:_showDropDown()
	end

	if view then
		if i == 3 then
			self:showTabAt(self._container, view, self._myCampId)
			self:_showDropDown()
			self:_onShowCamp()
		else
			self:showTabAt(self._container, view)
		end
	else
		self:showTabAt(self._container, viewname[1])
	end

	self._btns[self._tabId].change:SetState(1)
end

function ElementSparkInfoView:_onClickRank(campId)
	local cell = self._campCell[campId].go

	if cell then
		self._campCell[self._campId].change:SetState(0)
		self._campCell[campId].change:SetState(1)

		self._campId = campId

		ElementSparkController.instance:sendPM_EleSparkGetPersonRankReq(self._activityId, self._campId)
	end
end

function ElementSparkInfoView:_showDropDown()
	self._isShowDropDown = not self._isShowDropDown

	GameUtil.SetActive(self._cellsCon, self._isShowDropDown)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._btnCon:GetComponent(goutil.Type_RectTransform))
end

function ElementSparkInfoView:_onShowCamp()
	if self._isShowDropDown then
		self._campCell[self._campId].change:SetState(0)

		self._campId = self._myCampId

		if self._campId <= 0 then
			self._campId = 1
		end

		self:_onClickRank(self._campId)
	end
end

function ElementSparkInfoView:_onClickTip()
	TipsFacade.instance:openRulesView(tipIndex[self._tabId])
end

return ElementSparkInfoView
