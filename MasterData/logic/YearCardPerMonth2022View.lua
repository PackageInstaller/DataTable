-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/YearCard2022/YearCardPerMonth2022View.lua

module("logic.extensions.yearcard.view.2022.YearCardPerMonth2022View", package.seeall)

local YearCardPerMonth2022View = class("YearCardPerMonth2022View", ViewComponent)

function YearCardPerMonth2022View:buildUI()
	YearCardPerMonth2022View.super.buildUI(self)

	self._goCell = self:getGo("reward/cell")
	self._goTable = self:getGo("reward/tableview")
	self._tableView = ScrollerList.create(self._goTable, self._goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._txtDesc = self:getTxt("reward/txtDesc")
	self._imgText = self:getGo("reward/title/img1"):GetComponent(typeof(UIImgNumeralText))
	self._btnSure = self:getBtn("reward/btnSure")
	self._getedGo = self:getGo("reward/btnSure/geted")
end

function YearCardPerMonth2022View:bindEvents()
	YearCardPerMonth2022View.super.bindEvents(self)
	self._btnSure:AddClickListener(self._onClickSure, self)
end

function YearCardPerMonth2022View:unbindEvents()
	YearCardPerMonth2022View.super.unbindEvents(self)
	self._btnSure:RemoveClickListener()
end

function YearCardPerMonth2022View:onEnter()
	YearCardPerMonth2022View.super.onEnter(self)

	self._curActId = YearCardModel.instance:getCurAnnuityId()
	self._curMonthId = checkint(self:getFirstParam())
	self._curCfg = YearCardConfig.instance:getMonthRewardCfgById(self._curActId, self._curMonthId)

	if self._curCfg then
		self._imgText:SetText(self._curCfg.month)
		self:_refreshView()
	end

	GlobalDispatcher:addListener(GlobalNotify.AnnuityInfoChange, self._refreshView, self)
	GlobalDispatcher:addListener(GlobalNotify.AnnuityGainMonthPrize, self._refreshView, self)
end

function YearCardPerMonth2022View:onExit()
	YearCardPerMonth2022View.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.AnnuityInfoChange, self._refreshView, self)
	GlobalDispatcher:removeListener(GlobalNotify.AnnuityGainMonthPrize, self._refreshView, self)
end

function YearCardPerMonth2022View:_updateCell(view, goCell, data)
	local cell = self:_clearCell(goCell)

	goutil.setActive(cell.tag, data.isGeted)
	MaterialMgr.setCellByCfg(data.rewardStr, cell.item)
end

function YearCardPerMonth2022View:_clearCell(goCell)
	local cell = {}

	cell.go = goCell
	cell.item = goutil.findChild(goCell, "item")
	cell.tag = goutil.findChild(goCell, "tag")

	goutil.setActive(cell.tag, false)
	MaterialMgr.resetAll(cell.item)

	return cell
end

function YearCardPerMonth2022View:_refreshView()
	self._actInfo = YearCardModel.instance:getAnnuityInfo(self._curActId)

	self:_setTimeTxt()
	self:_refreshPrizeList()
	self:_refreshBtnState()
end

function YearCardPerMonth2022View:_setTimeTxt()
	local dateStart = GameUtil.string2date(self._curCfg.startTime)
	local dateEnd = GameUtil.time2date(YearCardModel.instance:getEndTime(self._curActId))

	self._txtDesc.text = "领取时间：" .. string.format("<color=#FAD68E>%d.%02d.%02d 05:00-%d.%02d.%02d 05:00</color>", dateStart.year, dateStart.month, dateStart.day, dateEnd.year, dateEnd.month, dateEnd.day)
end

function YearCardPerMonth2022View:_refreshPrizeList()
	local targetList = {}
	local preList = {}

	if self._curCfg.campaignConsumeId > 0 then
		local planId = AccumulategiftConfig.instance:GetActivityPlanID(self._curCfg.campaignConsumeId)
		local cfgs = AccumulategiftConfig.instance:GetConsumeGiftCfg(planId)

		if cfgs then
			for i = 1, 4 do
				if cfgs[i] and not string.nilorempty(cfgs[i].gift) then
					local isGeted = YearCardModel.instance:getIsGetedRewardById(self._curActId, self._curCfg.prizeId, i)
					local list = string.split(cfgs[i].gift, "#")

					for k, v in ipairs(list) do
						local element = {}

						element.isGeted = isGeted
						element.rewardStr = v

						if string.sub(v, 1, 3) == "4:3" then
							table.insert(preList, element)
						else
							table.insert(targetList, element)
						end
					end
				end
			end
		end
	elseif not string.nilorempty(self._curCfg.prize) then
		local list = string.split(self._curCfg.prize, "#")

		for i, v in ipairs(list) do
			local element = {}

			element.isGeted = YearCardModel.instance:getIsGainMonthPrize(self._curActId, self._curCfg.prizeId)
			element.rewardStr = v

			table.insert(targetList, element)
		end
	end

	if #preList > 0 then
		table.insertto(targetList, preList)
	end

	GameUtil.reverse(targetList)
	self._tableView:reloadData(targetList)
end

function YearCardPerMonth2022View:_refreshBtnState()
	if self._actInfo and self._actInfo.active then
		local isCanGet = YearCardController.instance:isCanGet(self._curActId, self._curCfg)

		if self._curCfg and isCanGet then
			GameUtil.SetGray(self._btnSure, false)

			if not YearCardModel.instance:getIsGainMonthPrize(self._curActId, self._curCfg.prizeId) then
				self._getedGo.gameObject:SetActive(false)
			else
				self._getedGo:SetActive(true)
			end
		else
			self._getedGo:SetActive(false)
			GameUtil.SetGray(self._btnSure, true)
		end
	else
		self._getedGo:SetActive(false)
		GameUtil.SetGray(self._btnSure, false)
	end
end

function YearCardPerMonth2022View:_onClickSure()
	local activityId = self._curActId
	local annuityInfo = YearCardModel.instance:getAnnuityInfo(activityId)

	if annuityInfo and annuityInfo.active then
		local cfg = self._curCfg
		local isCanGet = YearCardController.instance:isCanGet(activityId, cfg)

		if cfg and isCanGet then
			if not YearCardModel.instance:getIsGainMonthPrize(activityId, cfg.prizeId) then
				AnnuityAgent.instance:sendPM_AnnuityGainMonthPrizeReq(activityId, cfg.prizeId)
			else
				FloatWordMgr.instance:show("奖励已领取")
			end
		else
			FloatWordMgr.instance:show("未在对应领取时间！")
		end
	else
		FloatWordMgr.instance:show("成为2022年费可领取！")
	end
end

return YearCardPerMonth2022View
