-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mangtower/view/MangTowerRankView.lua

module("logic.extensions.mangtower.view.MangTowerRankView", package.seeall)

local MangTowerRankView = class("MangTowerRankView", ViewComponent)
local RANK_TYPE_ZHUO = 1
local RANK_TYPE_DUI = 2

function MangTowerRankView:ctor()
	MangTowerRankView.super.ctor(self)
end

function MangTowerRankView:buildUI()
	MangTowerRankView.super.buildUI(self)

	self._closeButton = self:getBtn("Close")
	self._btnZhuo = self:getBtn("zhuoCell")
	self._btnZhuoSelect = self:getGo("zhuoCell/imgSelected")
	self._txtColorChange1 = self:getGo("zhuoCell/txtName"):GetComponent("UITextColorChange")
	self._btnDui = self:getBtn("duiCell")
	self._btnDuiSelect = self:getGo("duiCell/imgSelected")
	self._txtColorChange2 = self:getGo("duiCell/txtName"):GetComponent("UITextColorChange")
	self._rankListView = goutil.findChildComponent(self.mainGO, "right/rankListView", "UITableview")
	self._rankCell = self:getGo("right/rankCell")

	goutil.setActive(self._rankCell, false)
	self._rankListView:RegisterCallback(self._rankNumInView, self._rankCellSize, self._rankCellAtIndex, self)
	self._rankListView:RegisterUpdateCellCallback(self._updateRankCell)
	self._rankListView:SetOffsetWithoutRefresh(0)

	self._txtChange1 = self:getTxt("right/description/txtChange1")
	self._txtEx = self:getTxt("right/description/txtEx")
	self._txtRecord = self:getTxt("right/description/txtRecord")
	self._txtTime = self:getTxt("right/description/txtTime")
	self._txtMyRank = self:getTxt("right/myRank/txtMyRank")
	self._txtTip = self:getTxt("right/myRank/txtTip")
end

function MangTowerRankView:bindEvents()
	MangTowerRankView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnZhuo:AddClickListener(function()
		self:switchRank(RANK_TYPE_ZHUO)
	end)
	self._btnDui:AddClickListener(function()
		self:switchRank(RANK_TYPE_DUI)
	end)
end

function MangTowerRankView:unbindEvents()
	MangTowerRankView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
end

function MangTowerRankView:destroyUI()
	MangTowerRankView.super.destroyUI(self)
end

function MangTowerRankView:onEnter()
	MangTowerRankView.super.onEnter(self)

	self._type = RANK_TYPE_ZHUO
	self._getZhuoData = false
	self._getDuiData = false

	TimedChallengeAgent.instance:sendPM_TimedChallengeGetPetRankReq(9, function(msg)
		self._getDuiData = true
		self._duiList = {}
		self._duiRank = checknumber(msg.myRank)

		for k, v in ipairs(msg.infoList) do
			table.insert(self._duiList, v)
		end

		self:checkToRefresh()
	end)
	GlobalDispatcher:addListener(PursueDreamAgent.PM_PursueDreamGetRanksRes, function(status, msg)
		self._getZhuoData = true
		self._zhuoList = {}
		self._zhuoRank = checknumber(msg.myRank)

		for k, v in ipairs(msg.rankList) do
			table.insert(self._zhuoList, v)
		end

		self:checkToRefresh()
	end)

	local actID = MangTowerModel.instance:getActId()

	PursueDreamAgent.instance:sendPM_PursueDreamGetRanksReq(actID)
end

function MangTowerRankView:onEnterFinished()
	MangTowerRankView.super.onEnterFinished(self)
end

function MangTowerRankView:onExit()
	MangTowerRankView.super.onExit(self)
	self._rankListView:Travel(self._clearTableview, self)
end

function MangTowerRankView:onExitFinished()
	MangTowerRankView.super.onExitFinished(self)
end

function MangTowerRankView:checkToRefresh()
	if self._getZhuoData == true and self._getDuiData == true then
		if self._type == RANK_TYPE_ZHUO then
			self._rankViewDatas = self._zhuoList
			self._txtChange1.text = "普通挑战通关层数"

			if self._zhuoRank > 0 then
				self._txtMyRank.text = self._zhuoRank or "未上榜"
			end

			self._txtTip.text = "1，根据<color=#ebad32>创界之路</color>中对通关层数进行排名！最新通关时间涵盖通关高难挑战。\n2，只会展示前100名的奥奇。"
		else
			self._rankViewDatas = self._duiList
			self._txtChange1.text = "家族"

			if self._duiRank > 0 then
				self._txtMyRank.text = self._duiRank or "未上榜"
			end

			self._txtTip.text = "1，兑换创界灵尊·芒最快的<color=#ebad32>9999名玩家</color>，可获得<color=#ebad32>创界神尊</color>头像框。\n2，兑换创界灵尊·芒之后，每次在精灵背包中<color=#ebad32>展示</color>创界灵尊·芒，会显示兑换创界灵尊·芒的<color=#ebad32>名次</color>。"
		end

		goutil.setActive(self._txtEx.gameObject, self._type == RANK_TYPE_ZHUO)
		goutil.setActive(self._txtRecord.gameObject, self._type == RANK_TYPE_ZHUO)
		goutil.setActive(self._txtTime.gameObject, self._type == RANK_TYPE_DUI)
		goutil.setActive(self._btnZhuoSelect, self._type == RANK_TYPE_ZHUO)
		goutil.setActive(self._btnDuiSelect, self._type == RANK_TYPE_DUI)
		self._txtColorChange1:SetState(self._type == RANK_TYPE_ZHUO and 0 or 1)
		self._txtColorChange2:SetState(self._type == RANK_TYPE_DUI and 0 or 1)
		self._rankListView:ReloadData()
	end
end

function MangTowerRankView:switchRank(type)
	if self._type ~= type then
		self._type = type

		self:checkToRefresh()
	end
end

function MangTowerRankView:_rankNumInView()
	return math.max(0, #self._rankViewDatas)
end

function MangTowerRankView:_rankCellSize()
	return 1027, 110
end

function MangTowerRankView:_rankCellAtIndex(view, index)
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self._rankCell)
	cell.index = index

	self:_updateRankCell(view, cell)

	return cell
end

function MangTowerRankView:_updateRankCell(view, cell)
	local idx = cell.index
	local data = self._rankViewDatas[idx + 1]
	local txtRank = goutil.findChildTextComponent(cell, "txtRank")
	local imgIcon = goutil.findChild(cell, "imgIcon")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtNormalPhase = goutil.findChildTextComponent(cell, "txtNormalPhase")
	local txtTime2 = goutil.findChildTextComponent(cell, "txtExPhase")
	local txtRecord = goutil.findChildTextComponent(cell, "txtRecord")
	local txtPassTime = goutil.findChildTextComponent(cell, "txtPassTime")
	local txtFamily = goutil.findChildTextComponent(cell, "txtFamily")

	goutil.setActive(txtNormalPhase.gameObject, self._type == RANK_TYPE_ZHUO)
	goutil.setActive(txtTime2.gameObject, self._type == RANK_TYPE_ZHUO)
	goutil.setActive(txtRecord.gameObject, self._type == RANK_TYPE_ZHUO)
	goutil.setActive(txtPassTime.gameObject, self._type == RANK_TYPE_DUI)
	goutil.setActive(txtFamily.gameObject, self._type == RANK_TYPE_DUI)
	HeadItemController.instance:setHeadCellByInfo(imgIcon, data.headInfo)

	txtName.text = data.headInfo.userName
	txtRank.text = data.rank

	if self._type == RANK_TYPE_ZHUO then
		local timeTab = GameUtil.time2date(math.floor(data.time / 1000))

		txtTime2.text = langPara("%s月%s日\n%02d:%02d:%02d", timeTab.month, timeTab.day, timeTab.hour, timeTab.min, timeTab.sec)
		txtNormalPhase.text = data.normalPhase
		txtRecord.text = data.score
	else
		local timeTab = GameUtil.time2date(math.floor(data.gainTime / 1000))

		txtPassTime.text = langPara("%s月%s日\n%02d:%02d:%02d", timeTab.month, timeTab.day, timeTab.hour, timeTab.min, timeTab.sec)
		txtFamily.text = data.familyName
	end

	return cell
end

function MangTowerRankView:_onClickClose(view, cell)
	self:close()
end

function MangTowerRankView:_clearTableview(cell)
	local imgIcon = goutil.findChild(cell, "imgIcon")

	MaterialMgr.resetAll(imgIcon)
end

return MangTowerRankView
