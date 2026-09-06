-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summontower/view/SummontowerRewardView.lua

module("logic.extensions.summontower.view.SummontowerRewardView", package.seeall)

local SummontowerRewardView = class("SummontowerRewardView", ViewComponent)

function SummontowerRewardView:buildUI()
	SummontowerRewardView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnScore = self:getBtn("btnScore")
	self._btnFristpass = self:getBtn("btnFristpass")
	self._btnRank = self:getBtn("btnRank")
	self._btnScoreChange = self._btnScore:GetComponent(ComponentType.UIChangeGroup)
	self._btnFristpassChange = self._btnFristpass:GetComponent(ComponentType.UIChangeGroup)
	self._btnRankChange = self._btnRank:GetComponent(ComponentType.UIChangeGroup)
	self._scoresView = self:getGo("scoreView")
	self._txtRule = self:getTxt("scoreView/txtRule")
	self._txtRule.text = lang("text_summon_scores_rewardstips")
	self._scoresView = self:getGo("scoreView")
	self._rankView = self:getGo("rankView")
	self._fristPassView = self:getGo("fristPassView")
	self._firstpassTableview = self:getGo("fristPassView/tableview"):GetComponent(ComponentType.UITableview)
	self._fristPassCell = self:getGo("fristPassView/cell")

	self._fristPassCell:SetActive(false)

	self._rankTableview = self:getGo("rankView/tableview"):GetComponent(ComponentType.UITableview)
	self._rankCell = self:getGo("rankView/cell")

	self._rankCell:SetActive(false)

	self._txtTip = self:getTxt("txtTip")
	self._btnFristpassPoint = self:getGo("btnFristpass/redpoint")
end

function SummontowerRewardView:bindEvents()
	SummontowerRewardView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnScore:AddClickListener(self._onClickScores, self)
	self._btnFristpass:AddClickListener(self._onClickFristpass, self)
	self._btnRank:AddClickListener(self._onClickRank, self)
	self._firstpassTableview:RegisterCallback(self._numberCellsInFirstRewardsView, nil, self._firstRewardCellAtIndex, self)
	self._rankTableview:RegisterCallback(self._numberCellsInRankRewardsView, nil, self._rankRewardCellAtIndex, self)
end

function SummontowerRewardView:unbindEvents()
	SummontowerRewardView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnScore:RemoveClickListener()
	self._btnFristpass:RemoveClickListener()
	self._btnRank:RemoveClickListener()
	self._firstpassTableview:UnRegisterAllCallbacks()
	self._rankTableview:UnRegisterAllCallbacks()
end

function SummontowerRewardView:onEnter()
	SummontowerRewardView.super.onEnter(self)
	self:_showScoresRewards()
	GlobalDispatcher:addListener(GlobalNotify.OnSommonGainFirstPassPrize, self._onSommonGainFirstPassPrize, self)
end

function SummontowerRewardView:onExit()
	SummontowerRewardView.super.onExit(self)

	self._rankData = nil
	self._firstpassData = nil

	GlobalDispatcher:removeListener(GlobalNotify.OnSommonGainFirstPassPrize, self._onSommonGainFirstPassPrize, self)
	self._firstpassTableview:Travel(self._clearFirstPassView, self)
	self._rankTableview:Travel(self._clearRankView, self)
end

function SummontowerRewardView:_showScoresRewards()
	self._btnScoreChange:SetState(1)
	self._btnFristpassChange:SetState(0)
	self._btnRankChange:SetState(0)
	self._btnFristpassPoint:SetActive(RedPointModel.instance:isActiveByServer(RedPointModel.ID_WUMMONTOWER_REWARDS))
	self._scoresView:SetActive(true)
	self._rankView:SetActive(false)
	self._fristPassView:SetActive(false)
	self._txtTip.gameObject:SetActive(false)
end

function SummontowerRewardView:_showFirstPassRewards()
	self._btnScoreChange:SetState(0)
	self._btnFristpassChange:SetState(1)
	self._btnRankChange:SetState(0)
	self._scoresView:SetActive(false)
	self._rankView:SetActive(false)
	self._fristPassView:SetActive(true)
	self._btnFristpassPoint:SetActive(false)

	local currSeason = SummontowerModel.instance:getCurSeason()

	self._firstpassData = SummontowerConfig.instance:getFirstRewardsCos(currSeason)

	self._firstpassTableview:SetOffsetWithoutRefresh(0)
	self._firstpassTableview:ReloadData()

	self._txtTip.text = lang("text_summon_firstpassreward_tips")

	self._txtTip.gameObject:SetActive(true)
end

function SummontowerRewardView:_showRankRewards()
	self._btnScoreChange:SetState(0)
	self._btnFristpassChange:SetState(0)
	self._btnRankChange:SetState(1)
	self._scoresView:SetActive(false)
	self._rankView:SetActive(true)
	self._fristPassView:SetActive(false)
	self._btnFristpassPoint:SetActive(RedPointModel.instance:isActiveByServer(RedPointModel.ID_WUMMONTOWER_REWARDS))

	local currSeason = SummontowerModel.instance:getCurSeason()
	local rankData = SummontowerConfig.instance:getRankRewardsCos(currSeason)

	self._rankData = {}

	for k, v in pairs(rankData) do
		table.insert(self._rankData, v)
	end

	table.sort(self._rankData, function(x, y)
		return x.rightTop < y.rightTop
	end)
	self._rankTableview:SetOffsetWithoutRefresh(0)
	self._rankTableview:ReloadData()

	self._txtTip.text = lang("text_summon_ranksreward_tips")

	self._txtTip.gameObject:SetActive(true)
end

function SummontowerRewardView:_numberCellsInRankRewardsView(view)
	if not self._rankData then
		return 0
	end

	return #self._rankData
end

function SummontowerRewardView:_rankRewardCellAtIndex(view, idx)
	local data = self._rankData[idx + 1]
	local cell = self._rankTableview:DequeueCell()

	cell = cell or self._rankTableview:AddChild(self._rankCell)

	self:_fillRankViewRank(cell, data, self._rankData[idx])
	self:_fillViewItems(cell, data)
	self:_initRankItemViewDrag(cell)

	return cell
end

function SummontowerRewardView:_fillRankViewRank(cell, data, dataPre)
	local gameObject = cell.gameObject
	local txtRank = goutil.findChildTextComponent(gameObject, "txtRank")
	local imgRank = goutil.findChild(gameObject, "imgRank")

	if data.rightTop == 1 then
		txtRank.gameObject:SetActive(false)
		imgRank:SetActive(true)
	else
		txtRank.gameObject:SetActive(true)
		imgRank:SetActive(false)

		txtRank.text = (not dataPre or data.rightTop - dataPre.rightTop == 1) and string.format(lang("text_summon_rank"), data.rightTop) or string.format(lang("text_summon_rank_range"), dataPre.rightTop + 1, data.rightTop)
	end
end

function SummontowerRewardView:_fillViewItems(cell, data)
	local itemViewContent = goutil.findChild(cell.gameObject, "tableview/Viewport/Content").transform
	local itemViewLayout = goutil.findChild(cell.gameObject, "tableview/Viewport/Content/items")

	itemViewLayout = itemViewLayout or goutil.findChild(cell.gameObject, "tableview/Viewport/Content/itemsNode/items")

	if not data.prize then
		local prize = ""

		itemViewLayout = itemViewLayout:GetComponent(ComponentType.UILayoutSingleLine)

		local awards = string.split(prize, "#")
		local transform = itemViewLayout.transform
		local childCount = transform.childCount
		local itemNum = #awards

		while childCount < itemNum do
			local go = UGUIToolHelper.AddChild(transform.gameObject, transform:GetChild(0).gameObject)

			Framework.TransformUtil.SetLocalScale(go.transform, 0.8, 0.8, 0.8)

			childCount = childCount + 1
		end

		for i = 1, itemNum do
			local data = awards[i]
			local go = transform:GetChild(i - 1).gameObject

			MaterialMgr.resetAll(go)
			MaterialMgr.setCellByCfg(data, go)
			go:SetActive(true)
		end

		for i = itemNum + 1, childCount do
			local go = transform:GetChild(i - 1).gameObject

			go:SetActive(false)
		end

		itemViewLayout:Layout()

		local sizeDelta = itemViewContent.sizeDelta

		sizeDelta.x = itemNum * 80 + 6
		itemViewContent.sizeDelta = sizeDelta
	end
end

function SummontowerRewardView:_numberCellsInFirstRewardsView(view)
	if not self._firstpassData then
		return 0
	end

	return #self._firstpassData
end

function SummontowerRewardView:_firstRewardCellAtIndex(view, idx)
	local data = self._firstpassData[idx + 1]
	local cell = self._firstpassTableview:DequeueCell()

	cell = cell or self._firstpassTableview:AddChild(self._fristPassCell)

	local gameObject = cell.gameObject
	local txtLevel = goutil.findChildTextComponent(gameObject, "txtLevel")
	local btnReceive = Framework.ButtonAdapter.GetFrom(gameObject, "btnReceive")
	local goReceive = goutil.findChild(gameObject, "receive")

	txtLevel.text = string.format(lang("tip_missionnum"), data.stageReq)

	btnReceive:RemoveClickListener()

	local hasGainedPrize = SummontowerModel.instance:hasGainedFirstPassPrize(data.prizeId)

	btnReceive.gameObject:SetActive(not hasGainedPrize)
	goReceive:SetActive(hasGainedPrize)

	local isLevelPassed = SummontowerModel.instance:isLevelPassed(data.stageReq)

	btnReceive:AddClickListener(function()
		if not isLevelPassed then
			FloatWordMgr.instance:show("未满足奖励领取条件")

			return
		end

		local activityId = SummontowerModel.instance:getActivityId()

		SummonMasterTowerAgent.instance:sendPM_SMTGainFirstPassPrizeReq(activityId, data.prizeId)
	end)
	GameUtil.SetGray(btnReceive.gameObject, not isLevelPassed)
	self:_fillViewItems(cell, data)
	self:_initFirstPassItemViewDrag(cell)

	return cell
end

function SummontowerRewardView:_initFirstPassItemViewDrag(cell)
	local drag = self:_clearFirstPassViewItemDrag(cell)

	drag:AddDragListener(self._onDragFirstPassItemView, self)
	drag:AddBeginDragListener(self._onBeginDragFirstPassItemView, self)
	drag:AddEndDragListener(self._onEndDragFirstPassItemView, self)
end

function SummontowerRewardView:_clearFirstPassViewItemDrag(cell)
	local itemViewContent = goutil.findChild(cell.gameObject, "tableview")
	local drag = Framework.UIDragTrigger.Get(itemViewContent)

	drag:RemoveDragListener()
	drag:RemoveBeginDragListener()
	drag:RemoveEndDragListener()

	return drag
end

function SummontowerRewardView:_onDragFirstPassItemView(eventData)
	if self._firstpassTableview then
		self._firstpassTableview:GetScrollRect():OnDrag(eventData)
	end
end

function SummontowerRewardView:_onBeginDragFirstPassItemView(eventData)
	if self._firstpassTableview then
		self._firstpassTableview:GetScrollRect():OnBeginDrag(eventData)
	end
end

function SummontowerRewardView:_onEndDragFirstPassItemView(eventData)
	if self._firstpassTableview then
		self._firstpassTableview:GetScrollRect():OnEndDrag(eventData)
	end
end

function SummontowerRewardView:_clearFirstPassView(cell)
	local gameObject = cell.gameObject
	local btnReceive = Framework.ButtonAdapter.GetFrom(gameObject, "btnReceive")

	btnReceive:RemoveClickListener()
	self:_clearFirstPassViewItemDrag(cell)

	local itemViewLayout = goutil.findChild(gameObject, "tableview/Viewport/Content/items")
	local childCount = itemViewLayout.transform.childCount - 1

	for i = 0, childCount do
		local go = itemViewLayout.transform:GetChild(i).gameObject

		MaterialMgr.resetAll(go)
	end
end

function SummontowerRewardView:_initRankItemViewDrag(cell)
	local drag = self:_clearRankViewItemDrag(cell)

	drag:AddDragListener(self._onDragRankItemView, self)
	drag:AddBeginDragListener(self._onBeginDragRankItemView, self)
	drag:AddEndDragListener(self._onEndDragRankItemView, self)
end

function SummontowerRewardView:_clearRankViewItemDrag(cell)
	local itemViewContent = goutil.findChild(cell.gameObject, "tableview")
	local drag = Framework.UIDragTrigger.Get(itemViewContent)

	drag:RemoveDragListener()
	drag:RemoveBeginDragListener()
	drag:RemoveEndDragListener()

	return drag
end

function SummontowerRewardView:_onDragRankItemView(eventData)
	if self._rankTableview then
		self._rankTableview:GetScrollRect():OnDrag(eventData)
	end
end

function SummontowerRewardView:_onBeginDragRankItemView(eventData)
	if self._rankTableview then
		self._rankTableview:GetScrollRect():OnBeginDrag(eventData)
	end
end

function SummontowerRewardView:_onEndDragRankItemView(eventData)
	if self._rankTableview then
		self._rankTableview:GetScrollRect():OnEndDrag(eventData)
	end
end

function SummontowerRewardView:_clearRankView(cell)
	local gameObject = cell.gameObject

	self:_clearRankViewItemDrag(cell)

	local itemViewLayout = goutil.findChild(gameObject, "tableview/Viewport/Content/itemsNode/items")
	local childCount = itemViewLayout.transform.childCount - 1

	for i = 0, childCount do
		local go = itemViewLayout.transform:GetChild(i).gameObject

		MaterialMgr.resetAll(go)
	end
end

function SummontowerRewardView:_onSommonGainFirstPassPrize()
	self._firstpassTableview:Refresh()
end

function SummontowerRewardView:_onClickClose()
	self:close()
end

function SummontowerRewardView:_onClickScores()
	self:_showScoresRewards()
end

function SummontowerRewardView:_onClickFristpass()
	self:_showFirstPassRewards()
end

function SummontowerRewardView:_onClickRank()
	self:_showRankRewards()
end

return SummontowerRewardView
