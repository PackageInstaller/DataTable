-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddessglory/view/GoddesGloryRankView.lua

module("logic.extensions.goddessglory.view.GoddesGloryRankView", package.seeall)

local GoddesGloryRankView = class("GoddesGloryRankView", ViewComponent)

function GoddesGloryRankView:buildUI()
	GoddesGloryRankView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._tableviewType = self:getGo("tableview"):GetComponent(ComponentType.UITableview)
	self._tableCellType = self:getGo("stageCell")

	self._tableCellType:SetActive(false)

	self._tableview = self:getGo("right/rankListView"):GetComponent(ComponentType.UITableview)
	self._tableCell = self:getGo("right/rankCell")

	self._tableCell:SetActive(false)

	self._myRank = self:getTxt("right/myRank/txtMyRank")
	self._txtTip = self:getTxt("right/myRank/txtTip")
	self._goEmpty = self:getGo("right/goEmpty")
end

function GoddesGloryRankView:bindEvents()
	GoddesGloryRankView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._tableviewType:RegisterCallback(self._numStageTypesInView, self._stageCellSizeForIndex, self._stageTypeCellAtIndex, self)
	self._tableview:RegisterCallback(self._numRanksInView, self._rankCellSizeForIndex, self._rankCellAtIndex, self)
end

function GoddesGloryRankView:unbindEvents()
	GoddesGloryRankView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._tableview:UnRegisterAllCallbacks()
	self._tableviewType:UnRegisterAllCallbacks()
end

function GoddesGloryRankView:onEnter()
	GoddesGloryRankView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.OnGoddeddGloryRankList, self._onGoddeddGloryRankList, self)

	local challengeId = GoddessGloryModel.instance:getCurGoddessGloryId()

	self._challengeMO = GoddessGloryModel.instance:getGoddessGlory(challengeId)
	self._curStageId = 0
	self._challengeId = challengeId

	self._tableviewType:SetOffsetWithoutRefresh(0)

	self._stagesData = {}

	if self._challengeMO then
		for k, v in pairs(self._challengeMO.stages) do
			table.insert(self._stagesData, v)
		end

		table.sort(self._stagesData, function(x, y)
			return x.stageId < y.stageId
		end)
	end

	if self._stagesData and self._stagesData[1] then
		self:_selectStage(self._stagesData[1].stageId)
	else
		self:_selectStage(0)
	end
end

function GoddesGloryRankView:onExit()
	GoddesGloryRankView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.OnGoddeddGloryRankList, self._onGoddeddGloryRankList, self)

	self._challengeMO = nil
	self._stagesData = nil
	self._curStageId = nil
	self._challengeId = nil
	self._rankDataList = nil
	self._stageMo = nil

	self._tableviewType:Travel(function(cell)
		local btn = Framework.ButtonAdapter.Get(cell.gameObject)

		btn:RemoveClickListener()
	end, nil)
	self._tableview:Travel(function(cell)
		local imgIcon = goutil.findChild(cell.gameObject, "imgIcon")

		HeadItemController.instance:resetHeadCell(imgIcon)
	end, nil)
end

function GoddesGloryRankView:_selectStage(stageId)
	if self._curStageId == stageId then
		return
	end

	self._curStageId = stageId

	self._tableviewType:ReloadData()
	self._tableview:SetOffsetWithoutRefresh(0)
	self:_refreshRankView()
end

function GoddesGloryRankView:_refreshRankView()
	self._stageMo = GoddessGloryModel.instance:getGoddessGloryStage(self._challengeId, self._curStageId)
	self._rankDataList = self._stageMo:getRankList()

	if not self._stageMo:isRankListValid() then
		GoddessGloryController.instance:requestGoddessGloryViewRank(self._challengeId, self._curStageId)
	end

	self._tableview:ReloadData()

	local myRank = self._stageMo:getMyRank()

	self._myRank.text = myRank > 0 and tostring(myRank) or "未上榜"

	self._goEmpty:SetActive(not self._rankDataList or #self._rankDataList == 0)
end

function GoddesGloryRankView:_onClickClose()
	self:close()
end

function GoddesGloryRankView:_numStageTypesInView(view)
	if not self._stagesData then
		return 0
	end

	return #self._stagesData
end

function GoddesGloryRankView:_stageCellSizeForIndex(view)
	return 120, 60
end

function GoddesGloryRankView:_stageTypeCellAtIndex(view, idx)
	local cell = self._tableviewType:DequeueCell()

	cell = cell or self._tableviewType:AddChild(self._tableCellType)

	local stageData = self._stagesData[idx + 1]
	local btn = Framework.ButtonAdapter.Get(cell.gameObject)
	local imgBg = cell:GetComponent(ComponentType.UIImageSpriteChange)
	local txtStage = goutil.findChildTextComponent(cell.gameObject, "txtName")
	local txtColor = txtStage:GetComponent(ComponentType.UITextColorChange)

	btn:RemoveClickListener()

	local state = stageData.stageId ~= self._curStageId and 0 or 1

	txtStage.text = stageData.stageName

	imgBg:SetState(state)
	txtColor:SetState(state)
	btn:AddClickListener(function()
		local timeStart = GameUtil.string2time(stageData.startTime)
		local nowTime = ServerTime.now()

		if nowTime < timeStart then
			FloatWordMgr.instance:show("当前试炼尚未开启")

			return
		end

		self:_selectStage(stageData.stageId)
	end)

	return cell
end

function GoddesGloryRankView:_numRanksInView(view)
	if not self._rankDataList then
		return 0
	end

	return #self._rankDataList
end

function GoddesGloryRankView:_rankCellSizeForIndex(view, idx)
	return 600, 110
end

function GoddesGloryRankView:_rankCellAtIndex(view, idx)
	local cell = self._tableview:DequeueCell()

	cell = cell or self._tableview:AddChild(self._tableCell)

	local rankData = self._rankDataList[idx + 1]
	local go = cell.gameObject
	local txtRank = goutil.findChildTextComponent(go, "txtRank")
	local imgRank = goutil.findChildComponent(go, "imgRank", typeof(UIImageSpriteChange))
	local imgIcon = goutil.findChild(go, "imgIcon")
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local txtDamage = goutil.findChildTextComponent(go, "txtDamage")
	local rank = checknumber(rankData.rank)
	local isTop3 = rank <= 3

	imgRank.gameObject:SetActive(isTop3)
	txtRank.gameObject:SetActive(not isTop3)

	if isTop3 then
		imgRank:SetState(rank - 1)
	end

	txtName.text = rankData.headInfo.userName

	local proxy = HeadItemController.instance:setHeadCellByInfo(imgIcon, rankData.headInfo)

	proxy.binder:setCallBack(function()
		FriendController.instance:showInfoView(rankData.headInfo.userId, imgIcon)
	end)

	txtRank.text = rankData.rank
	txtDamage.text = rankData.damage

	return cell
end

function GoddesGloryRankView:_onGoddeddGloryRankList(challengeId, stageId)
	if challengeId == self._challengeId and stageId == self._curStageId then
		self:_refreshRankView()
	end
end

return GoddesGloryRankView
