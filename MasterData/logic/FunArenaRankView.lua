-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/funarena/view/FunArenaRankView.lua

module("logic.extensions.funarena.view.FunArenaRankView", package.seeall)

local FunArenaRankView = class("FunArenaRankView", ViewComponent)

function FunArenaRankView:ctor()
	FunArenaRankView.super.ctor(self)
end

function FunArenaRankView:buildUI()
	FunArenaRankView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "txtTitle")
	self._txtMyRank = goutil.findChildTextComponent(self.mainGO, "content/myRank/txtMyRank")
	self._goEmpty = goutil.findChild(self.mainGO, "content/goEmpty")

	local scrollerGo = goutil.findChild(self.mainGO, "content/rankview")
	local cellGo = goutil.findChild(self.mainGO, "content/rankcell")
	local updateCell = GameUtil.handler(self._updateRankCell, self)
	local clearCell = GameUtil.handler(self._clearRankCell, self)

	self._rankScrollList = ScrollerList.create(scrollerGo, cellGo, updateCell, clearCell)

	GameUtil.SetActive(cellGo, false)

	self._rankCellList = {}
end

function FunArenaRankView:bindEvents()
	FunArenaRankView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickBtnClose, self)
end

function FunArenaRankView:unbindEvents()
	FunArenaRankView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function FunArenaRankView:onEnter()
	FunArenaRankView.super.onEnter(self)

	self._activityId = FunArenaModel.instance.activityId

	if self._activityId == 0 then
		self:_onClickBtnClose()

		return
	end

	GlobalDispatcher:addListener(GlobalNotify.FunArenaGetInfo, self._onUpdateUI, self)
	FunArenaController.instance:onSendViewRankReq(self._activityId)
end

function FunArenaRankView:onExit()
	FunArenaRankView.super.onExit(self)

	for _, cell in pairs(self._rankCellList) do
		-- block empty
	end

	GlobalDispatcher:removeListener(GlobalNotify.FunArenaGetInfo, self._onUpdateUI, self)
end

function FunArenaRankView:_onUpdateUI()
	if self._txtMyRank then
		local myRank = FunArenaModel.instance._viewRankRes.myRank

		self._txtMyRank.text = myRank == -1 and lang("FunArena_RankView_Tips_1") or FunArenaModel.instance._viewRankRes.myRank
	end

	local rankList = FunArenaModel.instance._viewRankRes.rankList

	GameUtil.SetActive(self._goEmpty, #rankList == 0)
	self:_onUpdateRankScroller()
end

function FunArenaRankView:_onClickBtnClose()
	self:close()
end

function FunArenaRankView:_onUpdateRankScroller()
	local rankList = FunArenaModel.instance._viewRankRes.rankList
	local dataList = {}

	for i = 1, #rankList do
		table.insert(dataList, rankList[i])
	end

	self._rankScrollList:reloadData(rankList)
	self._rankScrollList:refresh()
end

function FunArenaRankView:_updateRankCell(_, cellModel, data, tag)
	local cell = {}

	cell._mainGo = cellModel
	cell._imgHeadIcon = goutil.findChild(cell._mainGo, "imgHeadIcon")
	cell._btnHead = goutil.findChild(cell._mainGo, "btnHead")
	cell._imgRank = goutil.findChild(cell._mainGo, "imgRank")
	cell._txtRank = goutil.findChildTextComponent(cell._mainGo, "txtRank")
	cell._txtName = goutil.findChildTextComponent(cell._mainGo, "txtName")
	cell._txtTime = goutil.findChildTextComponent(cell._mainGo, "txtTime")
	cell._txtWin = goutil.findChildTextComponent(cell._mainGo, "txtWin")
	cell._txtStreakWin = goutil.findChildTextComponent(cell._mainGo, "txtStreakWin")

	local headInfo = data.headInfo

	HeadItemController.instance:setHeadCellByInfo(cell._imgHeadIcon, headInfo)

	local function func()
		FriendController.instance:showInfoView(headInfo.userId, cell._btnHead)
	end

	GameUtil.addClickHandler(cell._btnHead, func, self)

	local isNeedChange = data.rank <= 3 and cell._imgRank

	GameUtil.SetActive(cell._imgRank, isNeedChange)
	GameUtil.SetActive(cell._txtRank.gameObject, not isNeedChange)

	if isNeedChange then
		local UIImageSpriteChange = cell._imgRank:GetComponent(ComponentType.UIImageSpriteChange)

		if UIImageSpriteChange then
			UIImageSpriteChange:SetState(data.rank - 1)
		end
	end

	if cell._txtName then
		cell._txtName.text = data.headInfo.userName
	end

	if cell._txtRank then
		cell._txtRank.text = data.rank
	end

	if cell._txtTime then
		local timer = data.time
		local time = GameUtil.time2date(checknumber(timer / 1000))

		cell._txtTime.text = langPara("FunArena_RankView_Tips_2", time.month, time.day, time.hour, time.min, time.sec)
	end

	if cell._txtWin then
		cell._txtWin.text = data.winTimes
	end

	if cell._txtStreakWin then
		cell._txtStreakWin.text = data.winStreakTimes
	end
end

function FunArenaRankView:_clearRankCell(cellGo)
	return
end

return FunArenaRankView
