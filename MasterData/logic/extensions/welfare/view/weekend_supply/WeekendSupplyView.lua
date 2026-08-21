-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/welfare/view/weekend_supply/WeekendSupplyView.lua

module("logic.extensions.welfare.view.weekend_supply.WeekendSupplyView", package.seeall)

local M = class("WeekendSupplyView", DynamicFragmentView)

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	self._saturdayItemGo = self._registry:getGo("weekend_supply_panel_2015209420")
	self._sundayItemGo = self._registry:getGo("weekend_supply_panel_-865230447")
	self._mondayItemGo = self._registry:getGo("weekend_supply_panel_-212155052")
	self._extraItemGo = self._registry:getGo("weekend_supply_panel_1894138515")
	self._extraBtnReceive = Astral.SimpleLuaComponentContainer.Add(self._registry:getGo("10&btn_right_1251431307"), CommButton)
	self._extraStateReceived = self._registry:getGo("weekend_supply_panel_280681094")
	self._extraTxtContent = self._registry:getGo("weekend_supply_panel_1453875275")
	self._extraClose = self._registry:getGo("weekend_supply_panel_1389702174")
	self._extraNot = self._registry:getGo("weekend_supply_panel_1862780289")
	self._extraTxt = self._registry:getText("weekend_supply_panel_1453875275")
	self._explainTxt = self._registry:getText("weekend_supply_panel_-358653805")

	local extraRewardCellGo = self._registry:getGo("9&rewards_detail_item_2141037416")

	self._extraRewardCell = Astral.LuaComponentContainer.Add(extraRewardCellGo.gameObject, ItemCell)

	self._extraRewardCell:Awake()
	self._extraRewardCell:setShowSelectedEffect(false)

	local info = WelfareConfig.instance:getActivityTabCfg(self.params[1])

	self._cfgId = info.planIds[1]

	local class = WeekendSupplyItemCell

	self._saturdayData = Astral.LuaComponentContainer.Get(self._saturdayItemGo.gameObject, class)

	if not self._saturdayData then
		self._saturdayData = Astral.LuaComponentContainer.Add(self._saturdayItemGo.gameObject, class)
	end

	self._sundayData = Astral.LuaComponentContainer.Get(self._sundayItemGo.gameObject, class)

	if not self._sundayData then
		self._sundayData = Astral.LuaComponentContainer.Add(self._sundayItemGo.gameObject, class)
	end

	self._mondayData = Astral.LuaComponentContainer.Get(self._mondayItemGo.gameObject, class)

	if not self._mondayData then
		self._mondayData = Astral.LuaComponentContainer.Add(self._mondayItemGo.gameObject, class)
	end
end

function M:destroyUI()
	self._activityData = nil
	self._saturdayData = nil
	self._sundayData = nil
	self._mondayData = nil
	self._cfgId = nil
end

function M:bindEvents()
	self._extraBtnReceive:AddClickListener(self._onClickGetExtra, self)
end

function M:unbindEvents()
	self._extraBtnReceive:RemoveClickListener()
end

function M:onEnter()
	self:setEvent(true)
	goutil.setActive(self._extraNot.gameObject, false)
	WelfareUtil.playWelfareViewAnim(self.mainGO, "open")

	self._explainTxt.text = lang("tip_weekend_supply_explain")
	self._activityData = ActivityController.instance:getActivityByLogicTypeAndCode(ActivityEnum.LogicType.WEEKEND_SUPPLIES, self._cfgId)

	if self._activityData and self._activityData:getNeedRquest() then
		self._activityData:setNeedRquest(false)
		ActivityAgent.instance:sendGetActivityInfoRequest()
	end

	if self._activityData then
		self._actID = self._activityData:getId()

		self:_refreshShowTime()
		self:refreshRedDot()
		settimer(1, self._refreshShowTime, self, true)
	else
		self:_refreshShowTime()
	end
end

function M:onExit()
	self:setEvent(false)
	WelfareUtil.playWelfareViewAnim(self.mainGO, "close")
	removetimer(self._refreshShowTime, self)
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.WEEKEND_SUPPLIES, self._refreshShowTime, self)
	else
		GlobalDispatcher:removeEventListener(EventType.WEEKEND_SUPPLIES, self._refreshShowTime, self)
	end
end

function M:refreshView(timef)
	self._saturdayData:updateReward(self._activityData:getsaturdayMo())
	self._sundayData:updateReward(self._activityData:getsundayMo())
	self._mondayData:updateReward(self._activityData:getmondayMo())
	self:setExtraCell(timef)
end

function M:setExtraCell(timef)
	self._extraMo = self._activityData:getextraMo()

	local dataList = self._extraMo:getRewardItemDataList()

	self._extraRewardCell:updateData(dataList[1])

	if self._extraMo:getRewardStatus() == 1 then
		goutil.setActive(self._extraClose.gameObject, true)
		self._extraBtnReceive:setActive(false)
		goutil.setActive(self._extraStateReceived.gameObject, false)
		goutil.setActive(self._extraTxtContent.gameObject, false)
	elseif self._extraMo:getRewardStatus() == 3 then
		self._extraBtnReceive:setActiveState(true)
		self._extraBtnReceive:setActive(true)
		goutil.setActive(self._extraStateReceived.gameObject, false)
		goutil.setActive(self._extraTxtContent.gameObject, true)
		goutil.setActive(self._extraClose.gameObject, false)

		if timef < 0 or timef > 86399 then
			self._txtTips.text = ""
		else
			local timeTxt = TimeUtil.instance:autoFormatSecondToString(timef, true)

			self._extraTxt.text = timeTxt .. lang("tip_weekend_supply_cannot_receive")
		end
	elseif self._extraMo:getRewardStatus() == 4 then
		self._extraBtnReceive:setActive(false)
		goutil.setActive(self._extraStateReceived.gameObject, true)
		goutil.setActive(self._extraTxtContent.gameObject, false)
		goutil.setActive(self._extraClose.gameObject, false)
	elseif self._extraMo:getRewardStatus() == 2 then
		self._extraBtnReceive:setActiveState(false)
		self._extraBtnReceive:setActive(true)
		goutil.setActive(self._extraStateReceived.gameObject, false)
		goutil.setActive(self._extraTxtContent.gameObject, true)
		goutil.setActive(self._extraClose.gameObject, false)

		self._extraTxt.text = lang("tip_weekend_supply_extral")
	end
end

function M:refreshRedDot()
	local firdayTable = self._activityData:isInOneday(5, 6)

	if firdayTable.isr then
		local redPointTask = RedDotModel.instance:getRedDotDetailList(GameEnum.RedPointEnum.Activity) or {}

		for k, v in ipairs(redPointTask) do
			if tonumber(v) == self._actID then
				RedDotAgent.instance:sendRemoveRedPointRequest(GameEnum.RedPointEnum.Activity, {
					self._actID
				})

				break
			end
		end
	end
end

function M:_refreshShowTime()
	if self._activityData and self._activityData:getIsOpen() then
		self._activityData:refreshDatas()

		local saturdayTable = self._activityData:isInOneday(6, 7)
		local sundayTable = self._activityData:isInSunday()
		local mondayTable = self._activityData:isInOneday(1, 2)

		if saturdayTable.isr then
			self:refreshView()
			self._saturdayData:setTimeShow(saturdayTable.isT)
			self._sundayData:setTimeShow(saturdayTable.isT)
		elseif sundayTable.isr then
			self:refreshView()
			self._sundayData:setTimeShow(sundayTable.isT)
			self._mondayData:setTimeShow(sundayTable.isT)
		elseif mondayTable.isr then
			self:refreshView(mondayTable.isT)
			self._mondayData:setTimeShow(mondayTable.isT)
		else
			self:refreshView()
		end
	else
		self._saturdayData:setExpired()
		self._sundayData:setExpired()
		self._mondayData:setExpired()
		goutil.setActive(self._extraNot.gameObject, true)
		goutil.setActive(self._extraClose.gameObject, false)
		self._extraBtnReceive:setActive(false)
		goutil.setActive(self._extraStateReceived.gameObject, false)
		goutil.setActive(self._extraTxtContent.gameObject, false)
	end
end

function M:_onClickGetExtra()
	local txtBtn = goutil.findChildTextComponent(self._extraBtnReceive:getGo(), "normal/Text1")

	UserUtil.uploadActivityTabBuryPoint(UserUtil.activityFirstTabName, UserUtil.activitySecondTabName, txtBtn and txtBtn.text or "")

	if self._extraMo:getRewardStatus() == 3 then
		ActivityAgent.instance:sendTakeWeekendSuppliesRequest(self._cfgId, ActivityExtension_pb.Day.EXTRA)
	else
		FloatWordMgr.instance:show(lang("tip_weekend_supply_inconformity"))
	end
end

return M
