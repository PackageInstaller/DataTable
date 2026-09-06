-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rankrace/view/RankRaceReportDetailView.lua

module("logic.extensions.rankrace.view.RankRaceReportDetailView", package.seeall)

local RankRaceReportDetailView = class("RankRaceReportDetailView", ViewComponent)

function RankRaceReportDetailView:ctor()
	RankRaceReportDetailView.super.ctor(self)
end

function RankRaceReportDetailView:buildUI()
	RankRaceReportDetailView.super.buildUI(self)

	self._imgBg = self:getGo("imgBg")
	self._tabBk = {}
	self._txtTab = {}

	for i = 1, 3 do
		self._tabBk[i] = self:getBtn("tabBtn/tabBk_" .. i)
		self._txtTab[i] = self:getGo("tabBtn/tabBk_" .. i .. "/txtTab"):GetComponent("Text")
	end

	self._btnBack = self:getBtn("btnBack")
	self._title = self:getGo("title"):GetComponent("Text")
end

function RankRaceReportDetailView:bindEvents()
	RankRaceReportDetailView.super.bindEvents(self)

	for i = 1, 3 do
		self._tabBk[i]:AddClickListener(function()
			self:_onClickTabBk(i)
		end, self)
	end

	self._btnBack:AddClickListener(self._onClickBtnBack, self)
end

function RankRaceReportDetailView:unbindEvents()
	RankRaceReportDetailView.super.unbindEvents(self)

	for i = 1, 3 do
		self._tabBk[i]:RemoveClickListener()
	end

	self._btnBack:RemoveClickListener()
end

function RankRaceReportDetailView:destroyUI()
	RankRaceReportDetailView.super.destroyUI(self)
end

function RankRaceReportDetailView:onEnter()
	RankRaceReportDetailView.super.onEnter(self)

	local param = self._viewPresentor:getOpenParam()

	self._detailDataAll = param and param[1]
	self._detailData = self._detailDataAll.data

	if param then
		self._curIndex = param[2] or 1
	end

	self:_onClickTabBk(self._curIndex, true)
end

function RankRaceReportDetailView:_updateTilte()
	if self._curIndex == 1 or self._curIndex == 3 then
		self._title.text = self._detailData.myAlivePetSize == self._detailData.opAlivePetSize and RankRaceConfig.instance:getWord(19) or self._detailData.myAlivePetSize > self._detailData.opAlivePetSize and RankRaceConfig.instance:getWord(17) or RankRaceConfig.instance:getWord(18)
	elseif self._curIndex == 2 then
		self._title.text = self._detailData.myAlivePetSize == self._detailData.opAlivePetSize and RankRaceConfig.instance:getWord(19) or self._detailData.myAlivePetSize < self._detailData.opAlivePetSize and RankRaceConfig.instance:getWord(17) or RankRaceConfig.instance:getWord(18)
	end
end

function RankRaceReportDetailView:onEnterFinished()
	RankRaceReportDetailView.super.onEnterFinished(self)
end

function RankRaceReportDetailView:onExit()
	RankRaceReportDetailView.super.onExit(self)
end

function RankRaceReportDetailView:onExitFinished()
	RankRaceReportDetailView.super.onExitFinished(self)
end

function RankRaceReportDetailView:_onClickTabBk(index, force)
	if not force and self._curIndex == index then
		return
	end

	if index == 1 then
		self._btnBack.gameObject:SetActive(true)

		if ViewMgr.instance:isOpen(ViewName.RankRaceResultView) then
			RankRaceController.instance:operView(ViewName.RankRaceResultView, function(_view)
				_view:setActive(false)
			end)
		end

		if ViewMgr.instance:isOpen(ViewName.RankRaceBattleResultView) then
			RankRaceController.instance:operView(ViewName.RankRaceBattleResultView, function(_view)
				_view:setActive(true, "detail", true, self._detailDataAll)
			end)
		else
			ViewMgr.instance:open(ViewName.RankRaceBattleResultView, "detail", true, self._detailDataAll)
		end
	elseif index == 2 then
		self._btnBack.gameObject:SetActive(true)

		if ViewMgr.instance:isOpen(ViewName.RankRaceResultView) then
			RankRaceController.instance:operView(ViewName.RankRaceResultView, function(_view)
				_view:setActive(false)
			end)
		end

		if ViewMgr.instance:isOpen(ViewName.RankRaceBattleResultView) then
			RankRaceController.instance:operView(ViewName.RankRaceBattleResultView, function(_view)
				_view:setActive(true, "detail", false, self._detailDataAll)
			end)
		else
			ViewMgr.instance:open(ViewName.RankRaceBattleResultView, "detail", false, self._detailDataAll)
		end
	elseif index == 3 then
		self._btnBack.gameObject:SetActive(false)

		if ViewMgr.instance:isOpen(ViewName.RankRaceBattleResultView) then
			RankRaceController.instance:operView(ViewName.RankRaceBattleResultView, function(_view)
				_view:setActive(false)
			end)
		end

		if ViewMgr.instance:isOpen(ViewName.RankRaceResultView) then
			RankRaceController.instance:operView(ViewName.RankRaceResultView, function(_view)
				_view:setActive(true, "detail", self._detailDataAll)
			end)
		else
			ViewMgr.instance:open(ViewName.RankRaceResultView, "detail", self._detailDataAll)
		end
	end

	self._curIndex = index

	self:_updateTilte()
	self:_updateTxtTab()
end

function RankRaceReportDetailView:_updateTxtTab()
	for i = 1, 3 do
		self._txtTab[i].color = i == self._curIndex and Framework.ColorUtil.ParseColor("#FFFFFF") or Framework.ColorUtil.ParseColor("#555555")
	end
end

function RankRaceReportDetailView:_onClickBtnBack()
	RankRaceController.instance:operView(ViewName.RankRaceBattleResultView, function(_view)
		_view:close()
	end)
	RankRaceController.instance:operView(ViewName.RankRaceResultView, function(_view)
		_view:close()
	end)
	self:close()
end

function RankRaceReportDetailView:setChild(_childNode)
	if not _childNode then
		return
	end

	_childNode.transform:SetParent(self.mainGO.transform)
end

return RankRaceReportDetailView
