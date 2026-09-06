-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/yearcard2023/main/YearCardPerMonth2023View.lua

module("logic.extensions.yearcard.view.yearcard2023.main.YearCardPerMonth2023View", package.seeall)

local YearCardPerMonth2023View = class("YearCardPerMonth2023View", ViewComponent)

function YearCardPerMonth2023View:ctor()
	YearCardPerMonth2023View.super.ctor(self)
end

function YearCardPerMonth2023View:unbindEvents()
	YearCardPerMonth2023View.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnInfo)
	GameUtil.rmClickHandler(self._btnSkill)
end

function YearCardPerMonth2023View:bindEvents()
	YearCardPerMonth2023View.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnInfo, self._onClickInfo, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickSkill, self)
end

function YearCardPerMonth2023View:onExit()
	YearCardPerMonth2023View.super.onExit(self)
	self._scrollList:dispose()
	MaterialMgr.resetAll(self._rare)
	removetimer(self._timeTipActiveFalse, self)
	GlobalDispatcher:removeListener(GlobalNotify.AnnuityInfoChange, self._refreshView, self)
	GlobalDispatcher:removeListener(GlobalNotify.AnnuityGainMonthPrize, self._refreshView, self)

	for k, scrollList in pairs(self._itemScrollListDic) do
		scrollList:dispose()
	end
end

function YearCardPerMonth2023View:buildUI()
	YearCardPerMonth2023View.super.buildUI(self)

	self._btnInfo = self:getBtn("btnInfo")
	self._tableView = self:getGo("doubleScrollViewport")
	self._cell = self:getGo("cell")
	self._rewardCell = self:getGo("rewardCell")
	self._effMask = self:getGo("effMask")
	self._scrollRect = self._tableView:GetComponent("ScrollRect")
	self._effList = {}
	self._timeGo = {}
	self._scrollList = ScrollerList.create(self._tableView, self._cell, GameUtil.handler(self._updateMonthCell, self), GameUtil.handler(self._clearMonthCell, self))
	self.skinId = 16010
	self._rare = self:getGo("petInfo/rare")
	self._btnInfo = self:getGo("petInfo/btnInfo")
	self._btnSkill = self:getGo("petInfo/btnSkill")
	self._txtName = self:getTxt("petInfo/txtName")
end

function YearCardPerMonth2023View:onEnter()
	YearCardPerMonth2023View.super.onEnter(self)

	self._itemScrollListDic = {}
	self._curActId = self:_getActId()
	self._curTimeGo = nil
	self._monthRewardCfg = YearCardConfig.instance:getMonthRewardCfgs(self._curActId)

	if self._monthRewardCfg then
		self._scrollList:reloadData(self._monthRewardCfg)
		self:_refreshView()
	end

	MaterialMgr.setCell(MatType.Rare, self.skinId, self._rare)

	self._txtName.text = PetSkinConfig.instance:getPetSkinName(self.skinId)

	GlobalDispatcher:addListener(GlobalNotify.AnnuityInfoChange, self._refreshView, self)
	GlobalDispatcher:addListener(GlobalNotify.AnnuityGainMonthPrize, self._refreshView, self)
end

function YearCardPerMonth2023View:_getActId()
	return YearCardModel.instance:getCurAnnuityId()
end

function YearCardPerMonth2023View:_refreshView()
	self._actInfo = YearCardModel.instance:getAnnuityInfo(self._curActId)

	if self._monthRewardCfg then
		local moveIdx = -1

		for i, v in ipairs(self._monthRewardCfg) do
			if self:_refreshRewardState(v.month) == 1 then
				moveIdx = i - 1

				break
			end
		end

		if moveIdx > -1 then
			self._scrollList:MoveCellToCenter(moveIdx)
		end
	end

	self._scrollList:refresh()
end

function YearCardPerMonth2023View:_refreshRewardState(monthId)
	if self._actInfo and self._actInfo.active then
		local curMonthCfg = YearCardConfig.instance:getMonthRewardCfgById(self._curActId, monthId)
		local isCanGet = YearCardController.instance:isCanGet(self._curActId, curMonthCfg)

		if curMonthCfg and isCanGet then
			if not YearCardModel.instance:getIsGainMonthPrize(self._curActId, curMonthCfg.prizeId) then
				return 1
			else
				return 2
			end
		else
			return 0
		end
	else
		return 0
	end
end

function YearCardPerMonth2023View:_refreshRewardList(monthId, rewardList)
	local targetList = {}
	local preList = {}
	local curMonthCfg = YearCardConfig.instance:getMonthRewardCfgById(self._curActId, monthId)
	local isCanGet = self:_refreshRewardState(monthId) == 1

	if curMonthCfg and curMonthCfg.campaignConsumeId > 0 then
		local planId = AccumulategiftConfig.instance:GetActivityPlanID(curMonthCfg.campaignConsumeId)
		local cfgs = AccumulategiftConfig.instance:GetConsumeGiftCfg(planId)

		if cfgs then
			for i = 1, 4 do
				if cfgs[i] and not string.nilorempty(cfgs[i].gift) then
					local isGeted = YearCardModel.instance:getIsGetedRewardById(self._curActId, curMonthCfg.prizeId, i)
					local list = string.split(cfgs[i].gift, "#")

					for k, v in ipairs(list) do
						local element = {}

						element.isCanGet = isCanGet
						element.isGeted = isGeted
						element.rewardStr = v
						element.monthId = monthId

						if string.sub(v, 1, 3) == "4:3" then
							table.insert(preList, element)
						else
							table.insert(targetList, element)
						end
					end
				end
			end
		end
	elseif not string.nilorempty(curMonthCfg.prize) then
		local list = string.split(curMonthCfg.prize, "#")

		for i, v in ipairs(list) do
			local element = {}

			element.isCanGet = isCanGet
			element.isGeted = YearCardModel.instance:getIsGainMonthPrize(self._curActId, curMonthCfg.prizeId)
			element.rewardStr = v
			element.monthId = monthId

			table.insert(targetList, element)
		end
	end

	if #preList > 0 then
		table.insertto(targetList, preList)
	end

	GameUtil.reverse(targetList)
	rewardList:reloadData(targetList)
end

function YearCardPerMonth2023View:_updateMonthCell(view, goCell, data, tag)
	local cell = self:_clearMonthCell(goCell)

	self._timeGo[data.prizeId] = cell.time

	goutil.setActive(cell.time, false)

	local dateStart = GameUtil.string2date(data.startTime)
	local dateEnd = GameUtil.time2date(YearCardModel.instance:getEndTime(self._curActId))

	cell.txtMonth.text = string.format("%s月奖励", data.month)
	cell.txtTime.text = "领取时间：" .. string.format("%d.%02d.%02d 05:00-%d.%02d.%02d 05:00", dateStart.year, dateStart.month, dateStart.day, dateEnd.year, dateEnd.month, dateEnd.day)

	GameUtil.addClickHandler(cell.btnMonth, function()
		self:_timeTip(self._timeGo[data.month])
	end, self)

	local curState = self:_refreshRewardState(data.month)

	goutil.setActive(cell.btnReceive.gameObject, curState == 1)
	GameUtil.addClickHandler(cell.btnReceive, function()
		AnnuityAgent.instance:sendPM_AnnuityGainMonthPrizeReq(self._curActId, data.prizeId)
		self._scrollList:refresh()
	end, self)
	self:_refreshRewardList(data.month, cell.rewardList)
	cell.dragExclusive:AddDragListener(self._onDrag, self)
	cell.dragExclusive:AddBeginDragListener(self._onBeginDrag, self)
	cell.dragExclusive:AddEndDragListener(self._onEndDrag, self)
end

function YearCardPerMonth2023View:_clearMonthCell(goCell)
	local cell = {}

	cell.go = goCell
	cell.time = goutil.findChild(cell.go, "time")
	cell.rewardView = goutil.findChild(cell.go, "rewardview")
	cell.txtTime = goutil.findChildTextComponent(cell.go, "time/txtTime")
	cell.txtMonth = goutil.findChildTextComponent(cell.go, "btnMonth/txtMonth")
	cell.btnMonth = goutil.findChildButtonComponent(cell.go, "btnMonth")
	cell.btnReceive = goutil.findChildButtonComponent(cell.go, "btnRecieve")
	self._itemScrollListDic[goCell] = self._itemScrollListDic[goCell] or ScrollerList.create(cell.rewardView, self._rewardCell, GameUtil.handler(self._updateRewardCell, self), GameUtil.handler(self._clearRewardCell, self))
	cell.rewardList = self._itemScrollListDic[goCell]
	cell.dragExclusive = Framework.UIDragTrigger.Get(cell.rewardView)

	GameUtil.rmClickHandler(cell.btnMonth)
	GameUtil.rmClickHandler(cell.btnReceive)
	cell.dragExclusive:RemoveDragListener()
	cell.dragExclusive:RemoveBeginDragListener()
	cell.dragExclusive:RemoveEndDragListener()

	return cell
end

function YearCardPerMonth2023View:_updateRewardCell(view, cell, data, tag)
	local rewardCell = self:_clearRewardCell(cell)

	if self._effList[cell] then
		UIEffectManager.instance:stopEffect(self._effList[cell])

		self._effList[cell] = nil
	end

	if data.isCanGet then
		local effectPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"
		local pmEff = UIEffectManager.instance:playEffect(self, effectPath, rewardCell.go, 0, 0, true, false, nil, function(target, pmEff)
			pmEff:setClipping(self._effMask:GetComponent(goutil.Type_RectTransform))
		end)

		pmEff:setParent(rewardCell.item.transform)
		pmEff:setLocalPos(0, 0, 0)
		pmEff:setScale(1)

		self._effList[cell] = pmEff
	end

	goutil.setActive(rewardCell.tag, data.isGeted)

	local proxy = MaterialMgr.setCellByCfg(data.rewardStr, rewardCell.item)

	proxy:setCallBack(function()
		self:_timeTip(self._timeGo[data.monthId])
	end)
end

function YearCardPerMonth2023View:_clearRewardCell(cell)
	local rewardCell = {}

	rewardCell.go = cell
	rewardCell.item = goutil.findChild(cell, "item")
	rewardCell.tag = goutil.findChild(cell, "tag")

	goutil.setActive(rewardCell.tag, false)
	MaterialMgr.resetAll(rewardCell.item)

	return rewardCell
end

function YearCardPerMonth2023View:_timeTip(goTime)
	removetimer(self._timeTipActiveFalse, self)
	goutil.setActive(self._curTimeGo, false)

	self._curTimeGo = goTime

	settimer(3, self._timeTipActiveFalse, self, false)
	goutil.setActive(goTime, true)
end

function YearCardPerMonth2023View:_timeTipActiveFalse()
	goutil.setActive(self._curTimeGo, false)
end

function YearCardPerMonth2023View:_onClickInfo()
	PetbookController.instance:openPetinfoView(self.skinId)
end

function YearCardPerMonth2023View:_onClickSkill()
	local cfg = PetSkinConfig.instance:getPetSkinCfg(self.skinId)

	if cfg then
		PetbookController.instance:previewBattle(cfg.raceId, self.skinId)
	end
end

function YearCardPerMonth2023View:_onDrag(eventData)
	self._scrollRect:OnDrag(eventData)
end

function YearCardPerMonth2023View:_onBeginDrag(eventData)
	self._scrollRect:OnBeginDrag(eventData)
end

function YearCardPerMonth2023View:_onEndDrag(eventData)
	self._scrollRect:OnEndDrag(eventData)
end

return YearCardPerMonth2023View
