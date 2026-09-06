-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sunranbattle/view/SunranRankView.lua

module("logic.extensions.sunranbattle.view.SunranRankView", package.seeall)

local SunranRankView = class("SunranRankView", ViewComponent)

function SunranRankView:ctor()
	SunranRankView.super.ctor(self)

	self._curLeftDatas = nil
	self._choLeftIndex = 1
	self._curRightDatas = nil
end

function SunranRankView:bindEvents()
	SunranRankView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
end

function SunranRankView:unbindEvents()
	SunranRankView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
end

function SunranRankView:onExit()
	SunranRankView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.BattleRankInfo, self._updataRankItemListShow, self)

	self._curLeftDatas = nil
	self._choLeftIndex = 1
	self._curRightDatas = nil
end

function SunranRankView:destroyUI()
	SunranRankView.super.destroyUI(self)
end

function SunranRankView:buildUI()
	SunranRankView.super.buildUI(self)

	self._closeBtn = self:getBtn("closeBtn")
	self._leftListSR = self:getGo("tabListSR"):GetComponent("UITableview")
	self._leftItem = self:getGo("tabItme")

	self._leftItem:SetActive(false)

	local rightInfoGo = self:getGo("rightInfoGo")

	self._rightListSR = goutil.findChild(rightInfoGo, "rankListSR"):GetComponent("UITableview")
	self._rightItem = goutil.findChild(rightInfoGo, "rankItem")

	self._rightItem:SetActive(false)

	self._emptyGo = goutil.findChild(rightInfoGo, "emptyGo")

	local myRankGo = goutil.findChild(rightInfoGo, "myRankGo")

	self._myRankTxt = goutil.findChildTextComponent(myRankGo, "myRankTxt")
	self._myRankTxt.text = ""

	self._emptyGo:SetActive(false)
	self:registCallbacks()
end

function SunranRankView:registCallbacks()
	self._leftListSR:RegisterCallback(self._LeftInView, function()
		return 170, 65
	end, self._LeftAtIndex, self)
	self._leftListSR:RegisterUpdateCellCallback(self._OnLeftCellUpdate)
	self._rightListSR:RegisterCallback(self._RightInView, function()
		return 1070, 110
	end, self._RightAtIndex, self)
	self._rightListSR:RegisterUpdateCellCallback(self._OnRightCellUpdate)
end

function SunranRankView:_LeftInView()
	if not self._curLeftDatas then
		return 0
	end

	return #self._curLeftDatas
end

function SunranRankView:_LeftAtIndex(view, index)
	local cell
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self._leftItem)

	local data = self._curLeftDatas[index + 1]

	cell.data = index + 1
	cell.index = index

	self:_UpdateLeftCell(view, cell, data)

	return cell
end

function SunranRankView:_OnLeftCellUpdate(view, cell)
	local index = cell.index
	local data = self._curLeftDatas[index + 1]

	cell.data = index + 1

	self:_UpdateLeftCell(view, cell, data)
end

function SunranRankView:_RightInView()
	if not self._curRightDatas then
		return 0
	end

	return #self._curRightDatas
end

function SunranRankView:_RightAtIndex(view, index)
	local cell
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self._rightItem)

	local data = self._curRightDatas[index + 1]

	cell.data = index + 1
	cell.index = index

	self:_UpdateRightCell(view, cell, data)

	return cell
end

function SunranRankView:_OnRightCellUpdate(view, cell)
	local index = cell.index
	local data = self._curRightDatas[index + 1]

	cell.data = index + 1

	self:_UpdateRightCell(view, cell, data)
end

function SunranRankView:onEnter()
	SunranRankView.super.onEnter(self)

	self._stageCfg = self:getFirstParam()
	self._choLeftIndex = 1

	if self._stageCfg == nil or checknumber(self._stageCfg.stageId) <= 0 then
		printError("sr---挑战 SunranRankView:onEnter()   传入的关卡配置空")

		return
	end

	GlobalDispatcher:addListener(GlobalNotify.BattleRankInfo, self._updataRankItemListShow, self)

	self._curLeftDatas = SunranBattleModel.instance:getStageRankTabList(self._stageCfg.seasonId)

	if self._curLeftDatas and #self._curLeftDatas > 0 then
		for i = 1, #self._curLeftDatas do
			if self._curLeftDatas[i] and self._curLeftDatas[i].stageId == self._stageCfg.stageId then
				self._choLeftIndex = i
			end
		end
	end

	self._leftListSR:ReloadData()
end

function SunranRankView:_updataRankItemListShow()
	local rankInfo

	if self._curLeftDatas and #self._curLeftDatas > 0 then
		local info = self._curLeftDatas[self._choLeftIndex]

		if info == nil or checknumber(info.stageId) <= 0 then
			info = self._curLeftDatas[1]
		end

		rankInfo = SunranBattleModel.instance:getStageRankInfoList(info.stageId)
	end

	self._curRightDatas = {}

	if rankInfo then
		self._curRightDatas = rankInfo.rankList
		self._myRankTxt.text = checknumber(rankInfo.myRank) <= 0 and "未上榜" or tostring(rankInfo.myRank)
	else
		self._myRankTxt.text = "未上榜"
	end

	if self._curRightDatas == nil or #self._curRightDatas == 0 then
		self._emptyGo:SetActive(true)
	else
		self._emptyGo:SetActive(false)
	end

	self._rightListSR:ReloadData()
end

function SunranRankView:_UpdateLeftCell(view, cell, data)
	local iconIma = goutil.findChild(cell, "iconIma"):GetComponent("UIImageSpriteChange")
	local nameTxt = goutil.findChildTextComponent(cell, "nameTxt")
	local lockGo = goutil.findChild(cell, "lockGo")

	GameUtil.asBtn(cell):RemoveClickListener()

	local index = cell.data

	if self._choLeftIndex == index then
		iconIma:SetState(1)
		SunranBattleController.instance:csGetDarkDragonRankInfoReq(data.stageId)
	else
		iconIma:SetState(0)
	end

	nameTxt.text = data.stageName

	local isLock = data.startTime > ServerTime.now()

	lockGo:SetActive(isLock)
	GameUtil.asBtn(cell):AddClickListener(function()
		if isLock then
			FloatWordMgr.instance:show(data.unlockTips)

			return
		end

		if self._choLeftIndex == index then
			return
		end

		self._choLeftIndex = index

		self._leftListSR:ReloadData()
	end, self)
end

function SunranRankView:_UpdateRightCell(view, cell, data)
	local rankTxt = goutil.findChildTextComponent(cell, "rankTxt")
	local headGo = goutil.findChild(cell, "headGo")
	local nameTxt = goutil.findChildTextComponent(cell, "nameTxt")
	local familyTxt = goutil.findChildTextComponent(cell, "familyTxt")
	local powerTxt = goutil.findChildTextComponent(cell, "powerTxt")
	local timerTxt = goutil.findChildTextComponent(cell, "timerTxt")

	rankTxt.text = tostring(data.rank)

	HeadItemController.instance:setHeadCellByInfo(headGo, data.headInfo)

	nameTxt.text = data.headInfo.userName
	familyTxt.text = data.familyName
	powerTxt.text = tostring(data.score)

	local timer = GameUtil.time2date(data.time / 1000)

	timerTxt.text = string.format(lang("text_timeinfo"), timer.month, timer.day, timer.hour, timer.min, timer.sec)
end

return SunranRankView
