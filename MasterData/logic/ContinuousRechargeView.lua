-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/doubleeleven/view/ContinuousRechargeView.lua

module("logic.extensions.doubleeleven.view.ContinuousRechargeView", package.seeall)

local ContinuousRechargeView = class("ContinuousRechargeView", TableViewComponent)

function ContinuousRechargeView:ctor()
	ContinuousRechargeView.super.ctor(self)

	self._choiTabIndex = nil
	self._daysItemList = nil
	self._scoreItemList = nil
	self._scoreInfoList = nil
	self._scoreEffList = nil
end

function ContinuousRechargeView:bindEvents()
	ContinuousRechargeView.super.bindEvents(self)
	self._btnTips:AddClickListener(self._onClickbtnTips, self)
end

function ContinuousRechargeView:unbindEvents()
	ContinuousRechargeView.super.unbindEvents(self)
	self._btnTips:RemoveClickListener()
end

function ContinuousRechargeView:onExit()
	ContinuousRechargeView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.DE_UpdataContinuousRechargeInfo, self._updateViewRechargeItemList, self)
	GlobalDispatcher:removeListener(GlobalNotify.DE_UpdataContinuousRechargePrize, self._updateViewRechargeItemList, self)

	self._loader = RoleObjectPool.instance:removeRole(self._loader)

	if self.pmEff then
		UIEffectManager.instance:stopEffect(self.pmEff)
	end

	self.pmEff = nil
end

function ContinuousRechargeView:destroyUI()
	ContinuousRechargeView.super.destroyUI(self)

	self._choiTabIndex = nil
	self._daysItemList = nil
end

function ContinuousRechargeView:buildUI()
	ContinuousRechargeView.super.buildUI(self)

	self._descTxt = self:getTxt("descTxt")
	self._modelPos = self:getGo("modelPos")

	local allDaysTran = self:getGo("allDayTran").transform

	self._daysItemList = {}

	for i = 1, allDaysTran.childCount do
		local go = allDaysTran:GetChild(i - 1).gameObject
		local names = string.split(go.name, "_")

		self._daysItemList[tonumber(names[2])] = {
			itemGo = go,
			itemGrp = go:GetComponent("UIChangeGroup"),
			itemTxt = goutil.findChildTextComponent(go, "btnTxt"),
			redGo = goutil.findChild(go, "redGo"),
			lockGo = goutil.findChild(go, "lockGo")
		}
	end

	self._descTxt.text = ""
	self._btnTips = self:getBtn("btnTips")
	self._txtTime = goutil.findChildTextComponent(self.mainGO, "time/txtTime")
end

function ContinuousRechargeView:onEnter()
	ContinuousRechargeView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.DE_UpdataContinuousRechargeInfo, self._updateViewRechargeItemList, self)
	GlobalDispatcher:addListener(GlobalNotify.DE_UpdataContinuousRechargePrize, self._updateViewRechargeItemList, self)

	self._actId = DoubleElevenConfig.instance:getDaysRechargeCommonValue("CONTIMUOUSRE_ACTID", true)

	DoubleElevenModel.instance:setActivityId(self._actId)

	self._tabList, self._allList = DoubleElevenModel.instance:getDaysRechargeCfgs()

	if self._tabList == nil or #self._tabList == 0 then
		printError("sr---连续充值   ContinuousRechargeView:onEnter()   检查配置！！")
		self:close()

		return
	end

	self._choiTabIndex = math.max(checknumber(DoubleElevenModel.instance.crSubTabIndex), 1)

	for i = 1, #self._daysItemList do
		GameUtil.asBtn(self._daysItemList[i].itemGo):RemoveClickListener()

		if self._tabList[i] then
			GameUtil.SetActive(self._daysItemList[i].itemGo, true)
			self._daysItemList[i].itemGrp:SetState(0)
			GameUtil.SetActive(self._daysItemList[i].redGo, false)
			GameUtil.SetActive(self._daysItemList[i].lockGo, false)

			self._daysItemList[i].itemTxt.text = self._tabList[i] .. "元"

			GameUtil.asBtn(self._daysItemList[i].itemGo):AddClickListener(function()
				self:_onClickTabItemBtn(i)
			end, self)
		else
			GameUtil.SetActive(self._daysItemList[i].itemGo, false)
		end
	end

	self:_updateViewRechargeItemList()

	local showRaceId = DoubleElevenConfig.instance:getDaysRechargeCommonValue("SHOW_RACE_ID", true)

	self._loader = RoleObjectPool.instance:addRoleToParent(self._loader, showRaceId, self._modelPos, 1, nil, true, 0, 0)

	local effPath = "fx_ui_qirirenwu/fx_qirirenwu_pingmu.prefab"

	self.pmEff = UIEffectManager.instance:playEffect(self, effPath, self.mainGO, 0, 0, true, nil, nil, nil, self)

	self.pmEff:setParent(self.mainGO.transform)
	self.pmEff:setLocalPos(0, 0, 0)
	self.pmEff:setScale(1)
	DoubleElevenController.instance:csGetDaysRechargeGetInfoReq(self._actId)
	self:_setActTime()
end

function ContinuousRechargeView:_updateViewRechargeItemList()
	self._descTxt.text = langPara("text_doubleeleven_desc_15", DoubleElevenModel.instance:getTodayRechargeMoney())

	self:_onClickTabItemBtn(self._choiTabIndex, true)

	for i = 1, #self._tabList do
		if self._daysItemList[i] and self._daysItemList[i].redGo then
			local isRed = DoubleElevenModel.instance:getRechargeTabRedpoint(self._tabList[i])

			GameUtil.SetActive(self._daysItemList[i].redGo, isRed)
		end
	end
end

function ContinuousRechargeView:_onClickTabItemBtn(index, isForce)
	if self._choiTabIndex == index and not isForce then
		return
	end

	if self._tabList == nil or self._tabList[index] == nil then
		return
	end

	if self._daysItemList[self._choiTabIndex] and self._daysItemList[self._choiTabIndex].itemGrp then
		self._daysItemList[self._choiTabIndex].itemGrp:SetState(0)
	end

	if self._daysItemList[index] and self._daysItemList[index].itemGrp then
		self._daysItemList[index].itemGrp:SetState(1)
	end

	self._choiTabIndex = index
	DoubleElevenModel.instance.crSubTabIndex = index
	self._curViewDatas = {}

	if self._allList and self._allList[self._tabList[index]] then
		self._curViewDatas = self._allList[self._tabList[index]]
	end

	self._tableview:ReloadData()
	self._tableview:MoveCellInView(0, false)
end

function ContinuousRechargeView:_getPath()
	return {
		cellPath = "taskItem",
		viewPath = "taskItemSR"
	}
end

function ContinuousRechargeView:_cellSize()
	return 700, 106
end

function ContinuousRechargeView:_updateCell(view, cell, data)
	local titleTxt = goutil.findChildTextComponent(cell, "titleGo/titleTxt")
	local receiveBtnGo = goutil.findChild(cell, "receiveBtn")
	local receiveTxt = goutil.findChildTextComponent(receiveBtnGo, "receiveTxt")
	local receiveBtnIsc = receiveBtnGo:GetComponent("UIImageSpriteChange")
	local receiveGo = goutil.findChild(cell, "receiveGo")
	local matPosList = {
		goutil.findChild(cell, "matPos_1"),
		goutil.findChild(cell, "matPos_2"),
		goutil.findChild(cell, "matPos_3"),
		goutil.findChild(cell, "matPos_4"),
		goutil.findChild(cell, "matPos_5"),
		goutil.findChild(cell, "matPos_6"),
		goutil.findChild(cell, "matPos_7"),
		goutil.findChild(cell, "matPos_8")
	}

	GameUtil.asBtn(receiveBtnGo):RemoveClickListener()

	for i = 1, #matPosList do
		if matPosList[i] then
			MaterialMgr.resetAll(matPosList[i])
		end
	end

	titleTxt.text = string.format("第%s天", data.rechargeDays)

	local goodsList = string.split(data.prize, "#")

	if goodsList and #goodsList > 0 then
		for i = 1, #goodsList do
			if matPosList[i] then
				MaterialMgr.setCellByCfg(goodsList[i], matPosList[i])
			end
		end
	end

	local state = DoubleElevenModel.instance:getRechargeItemState(data.money, data.itemId)

	if state > 1 then
		receiveBtnGo:SetActive(false)
		receiveGo:SetActive(true)

		return
	end

	receiveBtnGo:SetActive(true)
	receiveGo:SetActive(false)

	if state == 1 then
		receiveTxt.text = "领取"

		receiveBtnIsc:SetState(1)
	else
		receiveTxt.text = "前往充值"

		receiveBtnIsc:SetState(0)
	end

	GameUtil.asBtn(receiveBtnGo):AddClickListener(function()
		if state == 1 then
			DoubleElevenController.instance:csGetDaysRechargeGainPrizeReq(self._actId, data.itemId)
		else
			GotoMgr.gotoByString("func#95#GodDiamond")
		end
	end, self)
end

function ContinuousRechargeView:_onClickbtnTips()
	TipsFacade.instance:openRulesView("continuousrechargeview")
end

function ContinuousRechargeView:_setActTime()
	self._txtTime.text = GameUtil.getActTimeDesc(GameEnum.ActivityType.DaysRecharge, self._actId)
end

return ContinuousRechargeView
