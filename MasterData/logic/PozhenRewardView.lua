-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/breakformation/view/PozhenRewardView.lua

module("logic.extensions.breakformation.view.PozhenRewardView", package.seeall)

local PozhenRewardView = class("PozhenRewardView", ViewComponent)

function PozhenRewardView:ctor()
	PozhenRewardView.super.ctor(self)

	self.isShowProg = true
	self.ownHurtCount = 0
	self.progInfoList = nil
	self.rankInfoList = nil
end

function PozhenRewardView:bindEvents()
	BreakFormationController.instance:registerLocalNotify("onDataLoaded", self.ForceUpdateCellList, self)
	BreakFormationController.instance:registerLocalNotify("onProgReceiveChange", self.ForceUpdateCellList, self)
	GameUtil.asBtn(self.viewCloseBtn):AddClickListener(function()
		self:close()
	end, self)
	GameUtil.asBtn(self.progressClickBtn):AddClickListener(function()
		self:ShowProgOrRank(true)
	end, self)
	GameUtil.asBtn(self.rankClickBtn):AddClickListener(function()
		self:ShowProgOrRank(false)
	end, self)
end

function PozhenRewardView:unbindEvents()
	BreakFormationController.instance:unregisterLocalNotify("onDataLoaded", self.ForceUpdateCellList, self)
	BreakFormationController.instance:unregisterLocalNotify("onProgReceiveChange", self.ForceUpdateCellList, self)
	GameUtil.asBtn(self.viewCloseBtn):RemoveClickListener()
	GameUtil.asBtn(self.progressClickBtn):RemoveClickListener()
	GameUtil.asBtn(self.rankClickBtn):RemoveClickListener()
end

function PozhenRewardView:buildUI()
	PozhenRewardView.super.buildUI(self)

	self.titleShowTxt = goutil.findChildComponent(self.mainGO, "viewInfoTran/titleShowTxt", "Text")
	self.viewCloseBtn = self:getBtn("viewInfoTran/viewCloseBtn")
	self.progressClickBtn = self:getBtn("viewInfoTran/progressClickBtn")
	self.progressClickIma = goutil.findChildComponent(self.mainGO, "viewInfoTran/progressClickBtn", "UIChangeGroup")
	self.rankClickBtn = self:getBtn("viewInfoTran/rankClickBtn")
	self.rankClickIma = goutil.findChildComponent(self.mainGO, "viewInfoTran/rankClickBtn", "UIChangeGroup")
	self.titleShowTxt.text = ""
	self._redPoint = self:getGo("viewInfoTran/progressClickBtn/redPoint")
	self.progListBgGo = self:getGo("viewInfoTran/progListBgGo")
	self.progListSR = goutil.findChildComponent(self.progListBgGo, "progListSR", "UITableview")
	self.progTitleGo = goutil.findChild(self.progListBgGo, "progTitleGo")
	self.sszTxt = goutil.findChildComponent(self.progTitleGo, "sszTxt", "Text")
	self.progDownGo = goutil.findChild(self.progListBgGo, "progDownGo")
	self.dqsshzTxt = goutil.findChildComponent(self.progDownGo, "dqsshzTxt", "Text")
	self.dqtgtsTxt = goutil.findChildComponent(self.progDownGo, "dqtgtsTxt", "Text")
	self.progItemGo = goutil.findChild(self.progListBgGo, "progItemGo")
	self.sszTxt.text = ""

	self.progItemGo:SetActive(false)
	self.progListSR:RegisterCallback(self.GetProgCellCount, self.GetProgCellSize, self.GetProgCellAtIndex, self)
	self.progListSR:RegisterUpdateCellCallback(self.UpadteProgCellInfo)
	self.progListSR:SetOffsetWithoutRefresh(0)

	self.rankListBgGo = self:getGo("viewInfoTran/rankListBgGo")
	self.rankTitleTxt = goutil.findChildComponent(self.rankListBgGo, "rankTitleTxt", "Text")
	self.rankListSR = goutil.findChildComponent(self.rankListBgGo, "rankListSR", "UITableview")
	self.rankItemGo = goutil.findChild(self.rankListBgGo, "rankItemGo")
	self.txtMyRank = self:getTxt("viewInfoTran/rankListBgGo/rankTip/rankNum")
	self.rankTitleTxt.text = ""

	self.rankItemGo:SetActive(false)
	self.rankListSR:RegisterCallback(self.GetRankCellCount, self.GetRankCellSize, self.GetRankCellAtIndex, self)
	self.rankListSR:RegisterUpdateCellCallback(self.UpadteRankCellInfo)
	self.rankListSR:SetOffsetWithoutRefresh(0)
	self.rankListBgGo:SetActive(false)
end

function PozhenRewardView:destroyUI()
	return
end

function PozhenRewardView:onEnter()
	self.rankInfoList = BreakFormationConfig.instance:GetPozhenRankByWeek()
	self.ownHurtCount, self.progInfoList = BreakFormationModel.instance:GetPozhenProgReceiveList()

	local tem = {}

	for k, v in pairs(self.progInfoList) do
		v.__state = BreakFormationModel.instance:getBtnState(BreakFormationModel.instance:getFightId(), v.__index)

		table.insert(tem, v)
	end

	self.progInfoList = tem

	ArraySort.sortOn(self.progInfoList, {
		"__state",
		"__index"
	}, {
		ArraySort.DESCENDING,
		ArraySort.NUMERIC
	})
	self:ShowProgOrRank(true, true)
	self:_updateRedPoint()
	GlobalDispatcher:addListener(GlobalNotify.RedPointUpdate, self._updateRedPoint, self)
end

function PozhenRewardView:_updateRedPoint()
	goutil.setActive(self._redPoint, RedPointModel.instance:isActive(27))
end

function PozhenRewardView:onExit()
	GlobalDispatcher:removeListener(GlobalNotify.RedPointUpdate, self._updateRedPoint, self)
end

function PozhenRewardView:ForceUpdateCellList()
	if not self.isShowProg then
		return
	end

	if self.isShowProg then
		self.ownHurtCount, self.progInfoList = BreakFormationModel.instance:GetPozhenProgReceiveList()

		local tem = {}

		for k, v in pairs(self.progInfoList) do
			v.__state = BreakFormationModel.instance:getBtnState(BreakFormationModel.instance:getFightId(), v.__index)

			table.insert(tem, v)
		end

		self.progInfoList = tem

		ArraySort.sortOn(self.progInfoList, {
			"__state",
			"__index"
		}, {
			ArraySort.DESCENDING,
			ArraySort.NUMERIC
		})
	else
		self.rankInfoList = BreakFormationConfig.instance:GetPozhenRankByWeek()
	end

	self:ShowProgOrRank(self.isShowProg, true)
end

function PozhenRewardView:ShowProgOrRank(isProg, isForce)
	if not isForce and isProg == self.isShowProg then
		return
	end

	self.isShowProg = isProg

	if self.isShowProg then
		local isInTime, title, startTime, endTime, cfg = ActivityDefineController.instance:isInTimeForMultiplyReward(GameEnum.CampaignType.breachWorldPrize)

		self._curPrizeMul = 1

		if isInTime and cfg then
			self._curPrizeMul = math.max(checknumber(cfg.featureParam), 1)
		end

		if self.rankListBgGo and self.rankListBgGo.activeSelf then
			self.rankTitleTxt.text = ""

			self.rankListBgGo:SetActive(false)
		end

		if self.progListBgGo and not self.progListBgGo.activeSelf then
			self.progListBgGo:SetActive(true)
		end

		self.progressClickIma:SetState(1)
		self.rankClickIma:SetState(0)

		local cfg = BreakFormationConfig.instance:GetPozhenTeamCfg()

		if self.ownHurtCount < 0 then
			self.ownHurtCount = 0
		end

		if cfg then
			self.dqsshzTxt.text = "我的评分：" .. self.ownHurtCount .. "分             累积总评分达到对应分数即可获得对应奖励"
		end

		self.titleShowTxt.text = "进度奖励"
		self.dqtgtsTxt.text = "提示：通关所有的阵形后，才能解锁进度奖励！"

		self.progListSR:ReloadData()
	else
		if self.progListBgGo and self.progListBgGo.activeSelf then
			self.dqsshzTxt.text = ""
			self.dqtgtsTxt.text = ""

			self.progListBgGo:SetActive(false)
		end

		if self.rankListBgGo and not self.rankListBgGo.activeSelf then
			self.rankTitleTxt.text = "每周四早上5:00结算排行榜奖励，通过邮件发放！"

			self.rankListBgGo:SetActive(true)

			self.txtMyRank.text = ""

			BreachFormationAgent.instance:sendPM_BreachFormationGetRankInfoReq(1, 100, function(msg)
				RankModel.instance:setRankData(msg, GameEnum.RankType.BreakFormation, 0)

				local rankMo = RankModel.instance:getRankMo(GameEnum.RankType.BreakFormation, 0)

				self.txtMyRank.text = rankMo and checknumber(rankMo.myRank) > 0 and string.format("%d", rankMo.myRank) or "未上榜"
			end)
		end

		self.progressClickIma:SetState(0)
		self.rankClickIma:SetState(1)

		self.titleShowTxt.text = "排行奖励"

		self.rankListSR:ReloadData()
	end
end

function PozhenRewardView:GetProgCellCount()
	return (self.progInfoList and #self.progInfoList >= 1 or nil) and #self.progInfoList
end

function PozhenRewardView:GetProgCellSize()
	return 950, 115
end

function PozhenRewardView:GetProgCellAtIndex(view, index)
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self.progItemGo)
	cell.index = index

	self:UpadteProgCellInfo(view, cell)

	return cell
end

function PozhenRewardView:UpadteProgCellInfo(view, cell)
	local data
	local index = cell.index

	if self.progInfoList then
		data = self.progInfoList[index + 1]
	end

	if data == nil then
		print("sr_PozhenRewardView:UpadteProgCellInfo()     获取进度奖励为空 index = ", index + 1)

		return
	end

	local cellBgIma = cell:GetComponent("UIImageSpriteChange")
	local hurtCountTxt = goutil.findChildTextComponent(cell.gameObject, "hurtCountTxt")
	local goodsItemTran = goutil.findChild(cell.gameObject, "goodsItemTran")
	local receiveClickBtn = goutil.findChild(cell.gameObject, "receiveClickBtn")
	local receiveTxt = goutil.findChildTextComponent(cell.gameObject, "receiveClickBtn/receiveTxt")
	local doubleGo = goutil.findChild(cell, "doubleGo")
	local num = index - math.floor(index / 2) * 2

	cellBgIma:SetState(num)

	local cfg = BreakFormationConfig.instance:GetPozhenTeamCfg()

	hurtCountTxt.text = cfg and string.format(cfg.itemDesc, data.needScore) or tostring(data.needScore)

	if checknumber(self._curPrizeMul) > 1 then
		GameUtil.SetActive(doubleGo, true)
		self:_setProgressPrizeMul(goodsItemTran, data.prize, self._curPrizeMul)
	else
		GameUtil.SetActive(doubleGo, false)
		MaterialMgr.setCellListByCfg(data.prize, goodsItemTran)
	end

	local state = BreakFormationModel.instance:getBtnState(BreakFormationModel.instance:getFightId(), data.__index)

	if state == BreakFormationModel.CAN_GET then
		receiveTxt.text = "领取"

		GameUtil.SetGray(receiveClickBtn, false)
	elseif state == BreakFormationModel.HAS_GET then
		receiveTxt.text = "已领取"

		GameUtil.SetGray(receiveClickBtn, true)
	else
		receiveTxt.text = "领取"

		GameUtil.SetGray(receiveClickBtn, true)
	end

	GameUtil.asBtn(receiveClickBtn):AddClickListener(function()
		if state == BreakFormationModel.NO_PASS then
			FloatWordMgr.instance:show("未通关所有阵型")

			return
		end

		if state == BreakFormationModel.NOT_ENOUGH then
			FloatWordMgr.instance:show("未达到指定要求")

			return
		end

		if state == BreakFormationModel.HAS_GET then
			FloatWordMgr.instance:show("已经领取过了")

			return
		end

		BreakFormationController.instance:ReceiveProgressReward(data.__index - 1)
	end)
end

function PozhenRewardView:_setProgressPrizeMul(parent, prizes, mul)
	local list = MaterialMgr.changeItemStrArr(prizes)

	if list == nil or #list == 0 then
		return
	end

	local matStr = ""

	for _, str in ipairs(list) do
		local aa = string.split(str, ":")
		local count = checknumber(table.remove(aa))

		matStr = not string.nilorempty(matStr) and string.format("%s#%s:%s", matStr, table.concat(aa, ":"), math.max(count, 1) * mul) or string.format("%s:%s", table.concat(aa, ":"), math.max(count, 1) * mul)
	end

	MaterialMgr.setCellListByCfg(matStr, parent)
end

function PozhenRewardView:GetRankCellCount()
	return (self.rankInfoList and #self.rankInfoList > 0 or nil) and #self.rankInfoList
end

function PozhenRewardView:GetRankCellSize()
	return 950, 115
end

function PozhenRewardView:GetRankCellAtIndex(view, index)
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self.rankItemGo)
	cell.index = index

	self:UpadteRankCellInfo(view, cell)

	return cell
end

function PozhenRewardView:UpadteRankCellInfo(view, cell)
	local data

	if self.rankInfoList then
		data = self.rankInfoList[cell.index + 1]
	end

	if data == nil then
		print("sr_PozhenRewardView:UpadteRankCellInfo()     获取排行奖励为空 cell = ", cell.name, cell.index + 1)

		return
	end

	local rankCountTxt = goutil.findChildTextComponent(cell.gameObject, "rankCountTxt")
	local goodsItemTran = goutil.findChild(cell.gameObject, "goodsItemTran")
	local num = cell.index - math.floor(cell.index / 2) * 2

	rankCountTxt.text = string.format("第%d-%d名", data.begin, data.tail)

	MaterialMgr.setCellListByCfg(data.prize, goodsItemTran)
end

return PozhenRewardView
