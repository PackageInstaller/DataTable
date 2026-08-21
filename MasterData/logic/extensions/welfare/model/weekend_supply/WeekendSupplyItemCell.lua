-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/welfare/model/weekend_supply/WeekendSupplyItemCell.lua

module("logic.extensions.welfare.model.weekend_supply.WeekendSupplyItemCell", package.seeall)

local M = class("WeekendSupplyItemCell")

function M:ctor(compContainer)
	self.mainGO = compContainer.gameObject
end

function M:Awake()
	self:buildUI()
	self:bindEvents()
end

function M:OnDestroy()
	self:unbindEvents()
end

function M:buildUI()
	local mainGO = self:getMainGo()

	self._canvasGroup = mainGO:GetComponent(ComponentType.CanvasGroup)
	self._imgDoneDi = goutil.findChild(mainGO, "imgDoneDi")

	local imgDi = goutil.findChild(mainGO, "imgDi")

	self._imgDiCanvasGroup = imgDi.gameObject:GetComponent(ComponentType.CanvasGroup)
	self._stateOverdue = goutil.findChild(mainGO, "stateOverdue")
	self._stateOverdueTxt1 = goutil.findChildTextComponent(mainGO, "stateOverdue/txt1")
	self._stateOverdueTxt2 = goutil.findChildTextComponent(mainGO, "stateOverdue/txt2")

	local txtContent = goutil.findChild(mainGO, "txtContent")

	self._txtContentCanvasGroup = txtContent.gameObject:GetComponent(ComponentType.CanvasGroup)

	local rewardGroup = goutil.findChild(mainGO, "rewardGroup")

	self._rewardGropCanvasGroup = rewardGroup.gameObject:GetComponent(ComponentType.CanvasGroup)

	local itemGo1 = goutil.findChild(mainGO, "rewardGroup/backpack_item")
	local itemGo2 = goutil.findChild(mainGO, "rewardGroup/backpack_item2")

	self._item1 = Astral.LuaComponentContainer.Add(itemGo1.gameObject, ItemCell)

	self._item1:Awake()
	self._item1:setShowSelectedEffect(false)

	self._item2 = Astral.LuaComponentContainer.Add(itemGo2.gameObject, ItemCell)

	self._item2:Awake()
	self._item2:setShowSelectedEffect(false)

	self._stateAvailable = goutil.findChild(mainGO, "stateAvailable")
	self._txtTips = goutil.findChildTextComponent(mainGO, "stateAvailable/txtTips")
	self._imgAvailable = goutil.findChild(mainGO, "stateAvailable/imgAvailable")
	self._btnReceive = Astral.SimpleLuaComponentContainer.Add(goutil.findChild(mainGO, "stateAvailable/btnReceive"), CommButton)
	self._stateDone = goutil.findChild(mainGO, "stateDone")
end

function M:bindEvents()
	self._btnReceive:AddClickListener(self._onClickGet, self)
end

function M:unbindEvents()
	self._btnReceive:RemoveClickListener()
end

function M:getMainGo()
	return self.mainGO
end

function M:updateReward(mo)
	self._id = mo:getId()
	self._status = mo:getRewardStatus()
	self._cfgID = mo:getCfgID()

	self:setRewardStatus()

	local dataList = mo:getRewardItemDataList()

	self._item1:updateData(dataList[1])
	self._item2:updateData(dataList[2])
end

function M:setRewardStatus()
	if self._status == 1 then
		self:setNoOpen()
	elseif self._status == 2 then
		self:setPrepare()
	elseif self._status == 3 then
		self:setCanReceive()
	elseif self._status == 4 then
		self:setFinish()
	elseif self._status == 5 then
		self:setExpired()
	end
end

function M:setTimeShow(timenumber)
	if timenumber < 0 or timenumber > 86399 then
		self._txtTips.text = ""
	else
		local timeTxt = TimeUtil.instance:autoFormatSecondToString(timenumber, true)

		if self._status == 3 then
			self._txtTips.text = timeTxt .. lang("tip_weekend_supply_cannot_receive")
		elseif self._status == 2 then
			self._txtTips.text = timeTxt .. lang("tip_weekend_supply_can_receive")
		else
			self._txtTips.text = ""
		end
	end
end

function M:setNoOpen()
	goutil.setActive(self._stateOverdue.gameObject, true)
	goutil.setActive(self._stateOverdueTxt2.gameObject, true)
	goutil.setActive(self._imgDoneDi.gameObject, false)
	goutil.setActive(self._stateAvailable.gameObject, false)
	goutil.setActive(self._stateDone.gameObject, false)
	goutil.setActive(self._stateOverdueTxt1.gameObject, false)
	goutil.setActive(self._imgAvailable.gameObject, false)
end

function M:setExpired()
	self._txtContentCanvasGroup.alpha = 1
	self._rewardGropCanvasGroup.alpha = 1
	self._imgDiCanvasGroup.alpha = 1

	goutil.setActive(self._stateOverdue.gameObject, true)
	goutil.setActive(self._stateOverdueTxt1.gameObject, true)
	goutil.setActive(self._imgDoneDi.gameObject, false)
	goutil.setActive(self._stateAvailable.gameObject, false)
	goutil.setActive(self._stateDone.gameObject, false)
	goutil.setActive(self._stateOverdueTxt2.gameObject, false)
	goutil.setActive(self._imgAvailable.gameObject, false)
end

function M:setPrepare()
	goutil.setActive(self._stateAvailable.gameObject, true)
	self._btnReceive:setActiveState(false)
	goutil.setActive(self._imgDoneDi.gameObject, false)
	goutil.setActive(self._stateDone.gameObject, false)
	goutil.setActive(self._stateOverdue.gameObject, false)
	goutil.setActive(self._stateOverdueTxt1.gameObject, false)
	goutil.setActive(self._stateOverdueTxt2.gameObject, false)
	goutil.setActive(self._imgAvailable.gameObject, false)
end

function M:setCanReceive()
	goutil.setActive(self._stateAvailable.gameObject, true)
	goutil.setActive(self._imgAvailable.gameObject, true)
	self._btnReceive:setActiveState(true)
	goutil.setActive(self._imgDoneDi.gameObject, false)
	goutil.setActive(self._stateDone.gameObject, false)
	goutil.setActive(self._stateOverdue.gameObject, false)
	goutil.setActive(self._stateOverdueTxt1.gameObject, false)
	goutil.setActive(self._stateOverdueTxt2.gameObject, false)
end

function M:setFinish()
	goutil.setActive(self._imgDoneDi.gameObject, true)
	goutil.setActive(self._stateDone.gameObject, true)

	self._txtContentCanvasGroup.alpha = 0.2
	self._rewardGropCanvasGroup.alpha = 0.2
	self._imgDiCanvasGroup.alpha = 0.5

	goutil.setActive(self._stateAvailable.gameObject, false)
	goutil.setActive(self._stateOverdue.gameObject, false)
	goutil.setActive(self._stateOverdueTxt1.gameObject, false)
	goutil.setActive(self._stateOverdueTxt2.gameObject, false)
	goutil.setActive(self._imgAvailable.gameObject, false)
end

function M:_onClickGet()
	local txtBtn = goutil.findChildTextComponent(self._btnReceive:getGo(), "normal/Text1")

	UserUtil.uploadActivityTabBuryPoint(UserUtil.activityFirstTabName, UserUtil.activitySecondTabName, txtBtn and txtBtn.text or "")

	if self._status == 3 then
		ActivityAgent.instance:sendTakeWeekendSuppliesRequest(self._cfgID, self._id)
	else
		FloatWordMgr.instance:show(lang("tip_weekend_supply_inconformity"))
	end
end

return M
