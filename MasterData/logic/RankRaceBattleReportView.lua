-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rankrace/view/RankRaceBattleReportView.lua

module("logic.extensions.rankrace.view.RankRaceBattleReportView", package.seeall)

local RankRaceBattleReportView = class("RankRaceBattleReportView", TableViewComponent)

function RankRaceBattleReportView:ctor()
	RankRaceBattleReportView.super.ctor(self)
end

function RankRaceBattleReportView:buildUI()
	RankRaceBattleReportView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._txtEmpty = self:getGo("txtEmpty"):GetComponent("Text")
	self._txtEmpty.text = RankRaceConfig.instance:getWord(23)
end

function RankRaceBattleReportView:bindEvents()
	RankRaceBattleReportView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickBtnClose, self)
end

function RankRaceBattleReportView:unbindEvents()
	RankRaceBattleReportView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function RankRaceBattleReportView:destroyUI()
	RankRaceBattleReportView.super.destroyUI(self)
end

function RankRaceBattleReportView:onEnter()
	RankRaceBattleReportView.super.onEnter(self)

	local param = self._viewPresentor:getOpenParam()

	self._viewType = param and param[1]
	self._detailData = param and param[2]

	if self._detailData then
		self._videoBackForDetail = param and param[3]

		UIStateManager.instance:push(ViewName.RankRaceReportDetailView, self._detailData, self._videoBackForDetail and 1 or 2)
	end

	self._myName = RoleModel.instance:getUserName() or ""

	RankingMatchAgent.instance:sendRM_GetBattleRecordReq(self._viewType)
end

function RankRaceBattleReportView:onEnterFinished()
	RankRaceBattleReportView.super.onEnterFinished(self)
end

function RankRaceBattleReportView:onExit()
	RankRaceBattleReportView.super.onExit(self)
	self._tableview:Travel(self._clearTableview, self)

	self._curViewDatas = nil
end

function RankRaceBattleReportView:onExitFinished()
	RankRaceBattleReportView.super.onExitFinished(self)
end

function RankRaceBattleReportView:_onClickBtnClose()
	RankRaceController.instance:setDataForDetail(nil)
	RankRaceModel.instance:setReportTo(false)
	self:close()
end

function RankRaceBattleReportView:_getPath()
	return {
		cellPath = "sv_item",
		viewPath = "sv_info"
	}
end

function RankRaceBattleReportView:_cellSize()
	return 1130, 140
end

function RankRaceBattleReportView:_updateCell(view, cell, data)
	Framework.ButtonAdapter.GetFrom(cell.gameObject, "bk/btnDetail"):AddClickListener(function()
		self._detailData = {
			data = data
		}

		RankRaceModel.instance:setReportTo(true)
		RankingMatchAgent.instance:sendRM_GetBattleVideoReq(data.myAttackBattleId, data.opAttackBattleId)
	end, self)

	local _txtResult = goutil.findChildComponent(cell.gameObject, "bk/txtResult", "Text")

	if data.myAlivePetSize > data.opAlivePetSize then
		_txtResult.text = RankRaceConfig.instance:getWord(17)
		_txtResult.color = Framework.ColorUtil.ParseColor("#F38418")
	elseif data.myAlivePetSize < data.opAlivePetSize then
		_txtResult.text = RankRaceConfig.instance:getWord(18)
		_txtResult.color = Framework.ColorUtil.ParseColor("#97A6B2")
	else
		_txtResult.text = RankRaceConfig.instance:getWord(19)
		_txtResult.color = Framework.ColorUtil.ParseColor("#74ADE8")
	end

	local _txtLifeRemainLeft = goutil.findChildComponent(cell.gameObject, "bk/txtLifeRemainLeft", "Text")

	_txtLifeRemainLeft.text = data.myAlivePetSize

	local _txtLifeRemainRight = goutil.findChildComponent(cell.gameObject, "bk/txtLifeRemainRight", "Text")

	_txtLifeRemainRight.text = data.opAlivePetSize

	local _txtTime = goutil.findChildComponent(cell.gameObject, "bk/txtTime", "Text")
	local curDate = GameUtil.time2date(math.floor(data.recordTime / 1000))

	if curDate.month < 10 then
		curDate.month = "0" .. curDate.month
	end

	if curDate.day < 10 then
		curDate.day = "0" .. curDate.day
	end

	if curDate.hour < 10 then
		curDate.hour = "0" .. curDate.hour
	end

	if curDate.min < 10 then
		curDate.min = "0" .. curDate.min
	end

	_txtTime.text = curDate.month .. "-" .. curDate.day .. " " .. curDate.hour .. ":" .. curDate.min

	local _leftHead = goutil.findChild(cell, "bk/leftHead/imgHead")

	HeadItemController.instance:setMyHeadCell(_leftHead)

	local _leftName = goutil.findChild(cell, "bk/leftHead/txtName"):GetComponent("Text")
	local _myAreaName = RankRaceController.instance:getMyAreaIdAndAreaName()

	_leftName.text = _myAreaName and _myAreaName .. "\n" .. self._myName or self._myName

	local _rightHead = goutil.findChild(cell, "bk/rightHead/imgHead")

	HeadItemController.instance:setHeadCellByInfo(_rightHead, data.opHeadInfo)

	local _rightName = goutil.findChild(cell, "bk/rightHead/txtName"):GetComponent("Text")

	if data.opHeadInfo and data.opHeadInfo.areaName then
		local _areaName = RankRaceController.instance:parseOpAreaInfo(data.opHeadInfo)

		_rightName.text = _areaName and _areaName .. "\n" .. data.opHeadInfo.userName or data.opHeadInfo.userName
	else
		_rightName.text = data.opHeadInfo.userName
	end
end

function RankRaceBattleReportView:_clearTableview(cell)
	Framework.ButtonAdapter.GetFrom(cell.gameObject, "bk/btnDetail"):RemoveClickListener()
end

function RankRaceBattleReportView:updateView()
	self._curViewDatas = RankRaceController.instance:getBattleRecords()

	if not self._curViewDatas or #self._curViewDatas <= 0 then
		self._txtEmpty.gameObject:SetActive(true)
	else
		self._txtEmpty.gameObject:SetActive(false)
	end

	self._tableview:ReloadData()
end

function RankRaceBattleReportView:showReportDetailView(myAttackBattleResult, opAttackBattleResult)
	if self._detailData then
		self._detailData.myAttackBattleResult = myAttackBattleResult
		self._detailData.opAttackBattleResult = opAttackBattleResult

		RankRaceController.instance:setDataForDetail(self._detailData)
		UIStateManager.instance:push(ViewName.RankRaceReportDetailView, self._detailData)
	end
end

return RankRaceBattleReportView
