-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goldendten/view/GoldendTenMainView.lua

module("logic.extensions.goldendten.view.GoldendTenMainView", package.seeall)

local GoldendTenMainView = class("GoldendTenMainView", ViewComponent)

function GoldendTenMainView:buildUI()
	GoldendTenMainView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnTip = self:getGo("btnTip")
	self._btnTask = self:getGo("btnTask")
	self._btnGoto = self:getGo("btnGoto")
	self._btnJumpTo = self:getGo("btnJumpTo")
	self._rpTask = goutil.findChild(self._btnTask, "redPoint")
	self._goCell = self:getGo("cell")
	self._goTableView = self:getGo("tableview")
	self._tableView = ScrollerList.create(self._goTableView, self._goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._scrollRect = self._goTableView:GetComponent(ComponentType.ScrollRect)
	self._com1 = self:getGo("com1")
	self._btnBecomes = {}

	for i = 1, 2 do
		self._btnBecomes[i] = goutil.findChild(self._com1, "btn" .. i)
	end

	self._com2 = self:getGo("com2")
	self._memberCells = {}

	for i = 1, 4 do
		local cell = {}

		cell.go = goutil.findChild(self._com2, "teamMember/cell_" .. i)
		cell.headcell = goutil.findChild(cell.go, "headcell")
		cell.btnAdd = goutil.findChild(cell.go, "btnAdd")
		cell.mark = goutil.findChild(cell.go, "mark")
		cell.txtName = goutil.findChildTextComponent(cell.go, "txtName")
		self._memberCells[i] = cell
	end

	self._sldProgress = self:getSlider("tableview/Viewport/Content/sldProgress")
	self._iconItem = self:getGo("iconItem")
	self._txtNum = self:getTxt("txtNum")
	self._txtTime = self:getTxt("time/txt")
end

function GoldendTenMainView:bindEvents()
	GoldendTenMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnTask, self._onClickTask, self)
	GameUtil.addClickHandler(self._btnGoto, self._onClickGoto, self)
	GameUtil.addClickHandler(self._btnJumpTo, self._onClickJumpTo, self)

	for i, v in ipairs(self._btnBecomes) do
		GameUtil.addClickHandler(v, GameUtil.handler(self._onClickBecome, self, i))
	end

	for i, v in ipairs(self._memberCells) do
		GameUtil.addClickHandler(v.btnAdd, self._onClickShare, self)
	end
end

function GoldendTenMainView:unbindEvents()
	GoldendTenMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnTask)
	GameUtil.rmClickHandler(self._btnGoto)

	for i, v in ipairs(self._btnBecomes) do
		GameUtil.rmClickHandler(v)
	end

	for i, v in ipairs(self._memberCells) do
		GameUtil.rmClickHandler(v.btnAdd)
	end
end

function GoldendTenMainView:onEnter()
	GoldendTenMainView.super.onEnter(self)

	local params = self:getOpenParam()

	self._curActId = checkint(params[1])
	self._inputCode = params[2]

	if ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.GoldendTen, self._curActId) then
		self:_refreshCfg()
		GoldendTenController.instance:getInfo(self._curActId)
	else
		TipsFacade.instance:openTipWindowNoX(lang("tip"), lang("活动不在时间内"), GameUtil.handler(self.close, self))
	end

	GlobalDispatcher:addListener(GlobalNotify.GoldendTenError, self._onError, self)
	GlobalDispatcher:addListener(GlobalNotify.GoldendTenUpdateInfo, self._refreshInfo, self)
	GlobalDispatcher:addListener(GlobalNotify.GoldendTenUpdatePrizeInfo, self._refreshPrizeInfo, self)
	GlobalDispatcher:addListener(GlobalNotify.OnMaterialCountChange, self._refreshPrizeInfo, self)
	RedPointController.instance:regRedPoint(self._rpTask, 470)

	local effPath = "20230331/huangjinshengshituan/fx_ui_huangjinshengshituan.prefab"

	self._mainEff = UIEffectManager.instance:playEffect(self, effPath, nil, 0, 0, true, false, nil, function(target, eff)
		eff:setParent(self.mainGO.transform)
		eff:setLocalPos(0, 0, 0)
		eff:setScale(1)

		eff.hideEffWhileNotOnTop = true
	end)
end

function GoldendTenMainView:onExit()
	GoldendTenMainView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.GoldendTenError, self._onError, self)
	GlobalDispatcher:removeListener(GlobalNotify.GoldendTenUpdateInfo, self._refreshInfo, self)
	GlobalDispatcher:removeListener(GlobalNotify.GoldendTenUpdatePrizeInfo, self._refreshPrizeInfo, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnMaterialCountChange, self._refreshPrizeInfo, self)
	self._tableView:dispose()
	MaterialMgr.resetAll(self._iconItem)

	for i, cell in ipairs(self._memberCells) do
		HeadItemController.instance:resetHeadCell(cell.headcell)
	end

	RedPointController.instance:unregRedPoint(self._rpTask)

	if self._mainEff then
		UIEffectManager.instance:stopEffect(self._mainEff)

		self._mainEff = nil
	end
end

function GoldendTenMainView:_onClickTip()
	UIStateManager.instance:push(ViewName.RulesView, "Goldend_Ten_Main_Rule")
end

function GoldendTenMainView:_onClickTask()
	UIStateManager.instance:push(ViewName.GoldendTenTaskView, self._curActId)
end

function GoldendTenMainView:_onClickGoto()
	GotoMgr.gotoByString("func#5076")
end

function GoldendTenMainView:_onClickJumpTo()
	GotoMgr.gotoByString("itemsource#100:10313")
end

function GoldendTenMainView:_onClickShare()
	if self._ownIdentity ~= 1 then
		FloatWordMgr.instance:show(lang("您不是次元圣使，无法邀请别的玩家加入哦~"))

		return
	end

	UIStateManager.instance:push(ViewName.Share, GameEnum.ShareType.GoldendTen, self._curActId)
end

function GoldendTenMainView:_onClickBecome(i)
	if i == 1 then
		if self._dealType == 1 then
			local isUnlock = HandbookModel.instance:isHasPet(self._actCfg.raceUnlock)

			if isUnlock then
				UIStateManager.instance:push(ViewName.GoldendTenTipsView, self._curActId, 3)
			else
				FloatWordMgr.instance:show(string.format("暂未获得精灵【%s】，无法成为圣使噢", MaterialMgr.getMaterialsName(MatType.Pet, self._actCfg.raceUnlock)))

				return
			end
		else
			UIStateManager.instance:push(ViewName.GoldendTenTipsView, self._curActId, i)
		end
	else
		UIStateManager.instance:push(ViewName.GoldendTenTipsView, self._curActId, i)
	end
end

function GoldendTenMainView:_onError(status)
	return
end

function GoldendTenMainView:_refreshCfg()
	self._actCfg = GoldendTenConfig.instance:getActCfgById(self._curActId)
	self._prizeCfgs = GoldendTenConfig.instance:getPrizeCfgsById(self._curActId)

	GoldendTenModel.instance:setCurActId(self._curActId)
	MaterialMgr.setCell(MatType.ACTIVITY_ITEM, self._actCfg.activityItemId, self._iconItem)
	self._sldProgress:SetValue(0)

	self._actTimeCfg = ActivityDefineConfig.instance:getCfgById(GameEnum.ActivityType.GoldendTen, self._curActId)

	local startTime, endTime = self._actTimeCfg.startTime, self._actTimeCfg.endTime
	local startDate, endDate = GameUtil.string2date(startTime), GameUtil.string2date(endTime)

	self._txtTime.text = string.format("活动时间：%02d.%02d %02d:%02d - %02d.%02d %02d:%02d", startDate.month, startDate.day, startDate.hour, startDate.min, endDate.month, endDate.day, endDate.hour, endDate.min)
	self._dealType = self._actCfg.raceUnlock ~= 0 and 1 or 0
end

function GoldendTenMainView:_refreshInfo()
	self._ownIdentity = GoldendTenModel.instance:getOwnIdentity(self._curActId)

	if self._ownIdentity == 0 then
		goutil.setActive(self._com1, true)
		goutil.setActive(self._com2, false)
	else
		goutil.setActive(self._com1, false)
		goutil.setActive(self._com2, true)
	end

	self:_refreshPlayerInfo()
	self:_refreshPrizeInfo()

	if self._inputCode then
		if self._ownIdentity == 0 then
			UIStateManager.instance:push(ViewName.GoldendTenTipsView, self._curActId, 2, self._inputCode)
		end

		self._inputCode = nil
	elseif self._dealType == 1 and self._ownIdentity == 0 and HandbookModel.instance:isHasPet(self._actCfg.raceUnlock) then
		local userDataKey = string.format("%s_firstEnter_%s", ViewName.GoldendTenMainView, self._curActId)

		if checknumber(GameUtil.getUserData(userDataKey)) <= 0 then
			UIStateManager.instance:push(ViewName.GoldendTenTipsView, self._curActId, 3)
			GameUtil.saveUserData(userDataKey, 1)
		end
	end
end

function GoldendTenMainView:_refreshPlayerInfo()
	self._ownIdentity = GoldendTenModel.instance:getOwnIdentity(self._curActId)
	self._teammateInfos = GoldendTenModel.instance:getCurTeamMateList(self._curActId)

	for i, cell in ipairs(self._memberCells) do
		local info = self._teammateInfos[i]

		if info then
			goutil.setActive(cell.btnAdd, false)
			HeadItemController.instance:setHeadCellByInfo(cell.headcell, info)

			cell.txtName.text = info.userName
		else
			cell.txtName.text = ""

			goutil.setActive(cell.btnAdd, true)
		end

		goutil.setActive(cell.mark, i == 1)
	end
end

function GoldendTenMainView:_refreshPrizeInfo()
	self.curProgress = MaterialModel.instance:getMaterialsNumber(MatType.ACTIVITY_ITEM, self._actCfg.activityItemId)
	self._txtNum.text = self.curProgress

	self._tableView:reloadData(self._prizeCfgs)

	self._stepValue = 1 / checknumber(#self._prizeCfgs + 0.2 - 1)
	self._stepCount = 0

	for i, cfg in ipairs(self._prizeCfgs) do
		if self.curProgress >= cfg.score then
			self._stepCount = i == 1 and self._stepCount + 0.2 or self._stepCount + 1
		else
			local addStep = 0

			if i == 1 then
				addStep = self.curProgress / checknumber(cfg.score) * 0.2
			else
				local lastCfg = self._prizeCfgs[i - 1]

				addStep = (self.curProgress - lastCfg.score) / checknumber(cfg.score - lastCfg.score)
			end

			self._stepCount = self._stepCount + addStep

			break
		end
	end

	self._sldProgress:SetValue(self._stepCount * self._stepValue)
end

function GoldendTenMainView:_updateCell(view, goCell, data)
	local cell = self:_clearCell(goCell)

	cell.txtProgress.text = data.score

	goutil.setActive(cell.invite, data.inviteNeed > 0)

	cell.txtInvite.text = langPara("邀请%s人解锁", data.inviteNeed)

	local prizeParams = string.split(data.leaderPrize, "#")

	for i, str in ipairs(prizeParams) do
		local itemCell = cell.showItemComs[1].itemList[i]

		goutil.setActive(itemCell.go, true)

		itemCell.proxy = MaterialMgr.setCellByCfg(str, itemCell.go)
	end

	prizeParams = string.split(data.followerPrize, "#")

	for i, str in ipairs(prizeParams) do
		local itemCell = cell.showItemComs[2].itemList[i]

		goutil.setActive(itemCell.go, true)

		itemCell.proxy = MaterialMgr.setCellByCfg(str, itemCell.go)
	end

	local subCell = cell.showItemComs[self._ownIdentity]

	if subCell then
		local gainStatus = GoldendTenModel.instance:getPrizeStatus(self._curActId, data.prizeId)
		local isAbleGain = not gainStatus and data.score <= self.curProgress

		goutil.setActive(subCell.rp, isAbleGain)
		goutil.setActive(subCell.mark, gainStatus)

		if isAbleGain then
			for _, itemCell in ipairs(subCell.itemList) do
				if GameUtil.GetActive(itemCell.go) then
					self:_playCellEff(itemCell.go)
					itemCell.proxy:setAutoTips(false)
					itemCell.proxy:setCallBack(function()
						if self._ownIdentity == 1 and #self._teammateInfos <= data.inviteNeed then
							FloatWordMgr.instance:show("当前邀请人数不满足领取要求")

							return
						end

						GoldendTenController.instance:gainPrize(self._curActId, data.prizeId, false)
					end)
				end
			end
		end
	end

	local anotherSubCell

	if self._ownIdentity == 1 then
		anotherSubCell = cell.showItemComs[2]
	elseif self._ownIdentity == 2 then
		anotherSubCell = cell.showItemComs[1]
	end

	if anotherSubCell then
		local anotherGainStatus = GoldendTenModel.instance:getAnotherPrizeStatus(self._curActId, data.prizeId)
		local isAbleGainAnother = not anotherGainStatus and data.score <= self.curProgress

		goutil.setActive(anotherSubCell.rp, isAbleGainAnother)
		goutil.setActive(anotherSubCell.mark, anotherGainStatus)

		if isAbleGainAnother then
			for _, itemCell in ipairs(anotherSubCell.itemList) do
				if GameUtil.GetActive(itemCell.go) then
					self:_playCellEff(itemCell.go)
					itemCell.proxy:setAutoTips(false)
					itemCell.proxy:setCallBack(function()
						if self._ownIdentity == 1 then
							if #self._teammateInfos <= data.inviteNeed then
								FloatWordMgr.instance:show("当前邀请人数不满足领取要求")
							else
								GoldendTenController.instance:gainPrize(self._curActId, data.prizeId, true)
							end
						elseif self._ownIdentity == 2 and self._dealType == 1 then
							local isUnlock = HandbookModel.instance:isHasPet(self._actCfg.raceUnlock)

							if isUnlock then
								GoldendTenController.instance:gainPrize(self._curActId, data.prizeId, true)
							else
								FloatWordMgr.instance:show(string.format("暂未获得精灵【%s】，无法领取该奖励噢", MaterialMgr.getMaterialsName(MatType.Pet, self._actCfg.raceUnlock)))
							end
						end
					end)
				end
			end
		end
	end
end

function GoldendTenMainView:_clearCell(goCell)
	local cell = {}

	cell.go = goCell
	cell.invite = goutil.findChild(cell.go, "invite")
	cell.txtInvite = goutil.findChildTextComponent(cell.invite, "txtInvite")
	cell.com = goutil.findChild(cell.go, "com")
	cell.arrow = goutil.findChild(cell.com, "arrow")
	cell.txtProgress = goutil.findChildTextComponent(cell.com, "txtProgress")
	cell.showItemComs = {}

	for i = 1, 2 do
		local subCell = {}

		subCell.go = goutil.findChild(cell.com, "itemCom_" .. i)
		subCell.mark = goutil.findChild(subCell.go, "mark")
		subCell.rp = goutil.findChild(subCell.go, "rp")
		subCell.giftGroup = goutil.findChild(subCell.go, "giftGroup")
		subCell.itemList = {}

		for k = 1, 4 do
			local itemCell = {}

			itemCell.go = goutil.findChild(subCell.giftGroup, "item_" .. k)
			itemCell.proxy = nil
			subCell.itemList[k] = itemCell

			self:_removeCellEff(itemCell.go)
			MaterialMgr.resetAll(itemCell.go)
			goutil.setActive(itemCell.go, false)
		end

		goutil.setActive(subCell.rp, false)
		goutil.setActive(subCell.mark, false)

		cell.showItemComs[i] = subCell
	end

	return cell
end

function GoldendTenMainView:_playCellEff(go)
	if not go then
		return
	end

	self._effs = self._effs or {}

	self:_removeCellEff(go)

	local resPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"

	local function loadCallBack()
		self._effs[go]:setScrollRectClipping(self._scrollRect)
	end

	self._effs[go] = UIEffectManager.instance:playEffect(self, resPath, nil, nil, nil, true, nil, nil, loadCallBack)

	self._effs[go]:setParent(go.transform)
	self._effs[go]:setScaleXYZ(1, 1, 0.8)
	self._effs[go]:setLocalPos(0, 0, 0)

	self._effs[go].hideEffWhileNotOnTop = true
end

function GoldendTenMainView:_removeCellEff(go)
	if not go then
		return
	end

	self._effs = self._effs or {}

	if self._effs[go] then
		UIEffectManager.instance:stopEffect(self._effs[go])

		self._effs[go] = nil
	end
end

return GoldendTenMainView
