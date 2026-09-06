-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guardcity/view/GuardCityRewardScoreView.lua

module("logic.extensions.guardcity.view.GuardCityRewardScoreView", package.seeall)

local GuardCityRewardScoreView = class("GuardCityRewardScoreView", ViewComponent)

function GuardCityRewardScoreView:ctor()
	GuardCityRewardScoreView.super.ctor(self)
end

function GuardCityRewardScoreView:buildUI()
	GuardCityRewardScoreView.super.buildUI(self)

	self._tableView = self:getGo("rewardCol/tableview")
	self._tableCell = self:getGo("rewardCol/rewardCell")
	self._emptyGo = self:getGo("rewardCol/empty")
end

function GuardCityRewardScoreView:bindEvents()
	GuardCityRewardScoreView.super.buildUI(self)
end

function GuardCityRewardScoreView:unbindEvents()
	GuardCityRewardScoreView.super.unbindEvents(self)
end

function GuardCityRewardScoreView:onEnter()
	GuardCityRewardScoreView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.PM_GuardCityGetPrizeInfoRes, self._refreshView, self)
	GlobalDispatcher:addListener(GlobalNotify.GuardCityRewardRecvieAll, self._onClickOneKey, self)
	GlobalDispatcher:addListener(GlobalNotify.PM_GuardCityGainPrizeRes, self._PM_GuardCityGainPrizeRes, self)

	self._tabScroll = ScrollerList.create(self._tableView, self._tableCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self._tabScroll:regGetTagByIdx(GameUtil.handler(self._getScrollTag, self))

	self._activityId = self:getFirstParam()
	self._actCfg = GuardCityConfig.instance:getActivityCfg(self._activityId)
	self._abilityCfg = GuardCityConfig.instance:getAbilityCfgs(self._actCfg.abilityPlanId)

	self:_refreshView()
	GuardCityAgent.instance:sendPM_GuardCityGetPrizeInfoReq(self._activityId)
end

function GuardCityRewardScoreView:onExit()
	GuardCityRewardScoreView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_GuardCityGetPrizeInfoRes, self._refreshView, self)
	GlobalDispatcher:removeListener(GlobalNotify.GuardCityRewardRecvieAll, self._onClickOneKey, self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_GuardCityGainPrizeRes, self._PM_GuardCityGainPrizeRes, self)
	self._tabScroll:dispose()
end

function GuardCityRewardScoreView:_refreshView()
	local list = GuardCiytModel.instance:getRewardScoreInfo()

	self._tabScroll:reloadData(list)
	GameUtil.SetActive(self._emptyGo, #list <= 0)
end

function GuardCityRewardScoreView:_getScrollTag(data, index)
	return data.prizeType
end

function GuardCityRewardScoreView:_updateCell(view, cell, data, tag)
	if tag == 1 then
		self:_updataCityCell(cell, data)
	end
end

function GuardCityRewardScoreView:_updataCityCell(cell, data)
	local go = cell.gameObject
	local btnDetail = GameUtil.asBtn(goutil.findChild(go, "btnDetail"))
	local btnReceive = GameUtil.asBtn(goutil.findChild(go, "btnReceive"))
	local txtReceive = goutil.findChildTextComponent(go, "btnReceive/txt")
	local bloodGo = goutil.findChild(go, "blood")
	local bloodList = {}

	for i = 1, bloodGo.transform.childCount do
		bloodList[i] = goutil.findChild(bloodGo, "bloodDot_" .. i)
	end

	local txtResult = goutil.findChildTextComponent(go, "topCol/txtResult")
	local txtTime = goutil.findChildTextComponent(go, "topCol/txtTime")
	local imgScore = goutil.findChildComponent(go, "scoreCol/imgScore", "UIImgNumeralText")
	local cityImgChange = goutil.findChildComponent(go, "city", "UIImageSpriteChange")
	local resultJson = GameUtil.jsonToTable(data.jsonParams)

	for i, v in ipairs(bloodList) do
		GameUtil.SetActive(v, i <= GuardCityConfig.instance:getCommonValue("CITY_HP_LIMIT", true))

		local uichange = v:GetComponent(ComponentType.UIImageColorChange)

		if i > checknumber(resultJson.ch) then
			uichange:SetState(1)
		else
			uichange:SetState(0)
		end
	end

	if resultJson.ch == 1 then
		cityImgChange:SetState(1)
	elseif resultJson.ch == 0 then
		cityImgChange:SetState(2)
	else
		cityImgChange:SetState(0)
	end

	local time = GameUtil.time2date(checknumber(data.time) / 1000)

	txtTime.text = langPara("%02d.%02d %02d:%02d:%02d", time.month, time.day, time.hour, time.min, time.sec)

	local totalLevel = #self._abilityCfg
	local abilityLv = 1

	for i = totalLevel, 1, -1 do
		if checknumber(resultJson.dd[i]) >= self._abilityCfg[i].defeat then
			abilityLv = self._abilityCfg[i].abilityLv

			break
		end
	end

	local abilityCfg = GuardCityConfig.instance:getAbilityCfg(self._actCfg.abilityPlanId, abilityLv)
	local hpList = string.split(abilityCfg.hpScore, "#")
	local scoreNum = checknumber(hpList[checknumber(resultJson.ch) + 1])

	imgScore:SetNum(scoreNum)

	txtReceive.text = scoreNum <= 0 and lang("确认") or lang("领取")

	btnDetail:RemoveClickListener()
	btnDetail:AddClickListener(function()
		self:_onClickDetail(data)
	end)
	btnReceive:RemoveClickListener()
	btnReceive:AddClickListener(function()
		self:_onClickReceive(data.prizeId)
	end)
end

function GuardCityRewardScoreView:_clearCell(cell)
	local go = cell.gameObject
	local btnDetail = GameUtil.asBtn(goutil.findChild(go, "btnDetail"))
	local btnReceive = GameUtil.asBtn(goutil.findChild(go, "btnReceive"))

	btnDetail:RemoveClickListener()
	btnReceive:RemoveClickListener()
end

function GuardCityRewardScoreView:_onClickDetail(reportData)
	UIStateManager.instance:push(ViewName.GuardCityScoreDetailView, self._activityId, reportData)
end

function GuardCityRewardScoreView:_onClickReceive(prizeId)
	local prizeIds = {
		prizeId
	}

	GuardCityAgent.instance:sendPM_GuardCityGainPrizeReq(self._activityId, prizeIds)
end

function GuardCityRewardScoreView:_onClickOneKey(tabId)
	if tabId ~= 2 then
		return
	end

	local dataList = GuardCiytModel.instance:getRewardScoreInfo()
	local prizeIds = {}

	for i, v in ipairs(dataList) do
		table.insert(prizeIds, v.prizeId)
	end

	if #prizeIds > 0 then
		GuardCityAgent.instance:sendPM_GuardCityGainPrizeReq(self._activityId, prizeIds)
	else
		FloatWordMgr.instance:show(lang("无可领取对象"))
	end
end

function GuardCityRewardScoreView:_PM_GuardCityGainPrizeRes()
	FloatWordMgr.instance:show(lang("领取成功"))
	GuardCityAgent.instance:sendPM_GuardCityGetPrizeInfoReq(self._activityId)
end

return GuardCityRewardScoreView
