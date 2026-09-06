-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lionculture/view/LioncultureView.lua

module("logic.extensions.lionculture.view.LioncultureView", package.seeall)

local LioncultureView = class("LioncultureView", ViewComponent)

function LioncultureView:ctor()
	LioncultureView.super.ctor(self)

	self._effectList = {}
end

function LioncultureView:unbindEvents()
	LioncultureView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnCulture:RemoveClickListener()
end

function LioncultureView:bindEvents()
	LioncultureView.super.bindEvents(self)
	self._closeButton:AddClickListener(function()
		self:close()
	end, self)
	self._btnTip:AddClickListener(function()
		UIStateManager.instance:push(ViewName.RulesView, "lionculture_rule1")
	end, self)
	self._btnCulture:AddClickListener(self._cultureOnClick, self)
end

function LioncultureView:buildUI()
	LioncultureView.super.buildUI(self)

	self._closeButton = self:getBtn("leftTop/btnClose")
	self._btnTip = self:getBtn("leftTop/btnTip")
	self._btnCulture = self:getBtn("btnCulture")
	self._openDate = self:getTxt("time/txt")
	self._con = self:getGo("con")
	self._bubble = self:getGo("bubble")
	self._cellItem = self:getGo("level/cell")
	self._listContent = self:getGo("level/tableview/Viewport/Content")
	self._redCulture = self:getGo("btnCulture/redpoint")
	self._tabRange = self:getGo("level/tableview")

	self:_initList()
end

function LioncultureView:onExit()
	LioncultureView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.LionCultureGetInfoRes, self.onRefreshList, self)
	RoleObjectPool.instance:removeRole(self._roleModel)
	removetimer(self._hideBubble, self)

	for i = 1, #self._listObjs do
		local obj = self._listObjs[i]
		local item = goutil.findChild(obj, "item")

		MaterialMgr.resetAll(item)
	end

	for k, v in pairs(self._effectList) do
		self:_clearEffect(k)
	end
end

function LioncultureView:onEnter()
	LioncultureView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.LionCultureGetInfoRes, self.onRefreshList, self)

	if not GameUtil.getUserData(ViewName.LionculturestartView) then
		UIStateManager.instance:push(ViewName.LionculturestartView)
	end

	LioncultureController.instance:sendPM_LioncultureGetInfoReq()

	local startDate, endDate = ActivityDefineController.instance:getStartTimeAndEndTime(237, LioncultureModel.instance.activityId)
	local startDateTable = GameUtil.time2date(startDate)
	local endDateTable = GameUtil.time2date(endDate)

	self._openDate.text = string.format("活动时间：%02d.%02d %02d:%02d-%02d.%02d %02d:%02d", startDateTable.month, startDateTable.day, startDateTable.hour, startDateTable.min, endDateTable.month, endDateTable.day, endDateTable.hour, endDateTable.min)

	self:_showSpriteRawInfo()
	self:_showBubble()
	goutil.setActive(self._redCulture, not GameUtil.getUserData("LioncultureViewredCulture"))
end

function LioncultureView:_initList()
	self._configs = LioncultureConfig.instance:getGamesCfg()
	self._listObjs = {}

	local listPos = {
		205,
		265,
		285,
		265,
		205
	}

	for i = 1, #self._configs do
		local config = self._configs[i]
		local obj = goutil.clone(self._cellItem, i)

		obj:SetActive(true)
		GameUtil.setLocalPos(obj.transform, listPos[i], 315 - 125 * i, 0)
		goutil.addChildToParent(obj, self._listContent)

		self._listObjs[i] = obj
		goutil.findChildTextComponent(obj, "txtTitle").text = config.name

		local btn = goutil.findChild(obj, "cover/btnChallenge")

		GameUtil.addClickHandler(btn, function()
			if config.gameActivityId > 0 then
				local cfg = BrotherHoodConfig.instance:getActivityCfg(config.gameActivityId)

				if cfg and cfg.plotPlan then
					UIStateManager.instance:push(config.ui, config.gameActivityId, cfg.plotPlan[1])
				end
			else
				UIStateManager.instance:push(config.ui)
			end
		end)

		local btnGet = goutil.findChild(obj, "btnGet")

		GameUtil.addClickHandler(btnGet, function()
			LioncultureController.instance:sendPM_WakingLionGameGainPrizeReq(config.gameId)
		end)
	end
end

function LioncultureView:onRefreshList()
	for i = 1, #self._configs do
		local config = self._configs[i]
		local isTimeOn = GameUtil.string2time(config.startTime) < ServerTime.now()
		local isOpen = i == 1 and true or LioncultureModel.instance.gameFinishs[i - 1]
		local isOver = LioncultureModel.instance.gameFinishs[i]
		local haveGetPrize = LioncultureModel.instance.gameGetPrizes[i]

		if i > 1 then
			if not self._configs[i - 1].name then
				local beforeName = ""
				local obj = self._listObjs[i]
				local date = GameUtil.string2date(config.startTime)
				local lockObj = goutil.findChild(obj, "lock")

				lockObj:SetActive(not isTimeOn)

				goutil.findChildTextComponent(lockObj, "txtTime").text = string.format("%s月%s日%s点解锁", date.month, date.day, date.hour)

				local curText = string.format("完成【%s】后可解锁", beforeName)
				local tipText = goutil.findChildTextComponent(obj, "cover/txtProgress")

				tipText.gameObject:SetActive(isTimeOn and not isOpen)

				tipText.text = curText

				local btn = goutil.findChild(obj, "cover/btnChallenge")
				local btnText = goutil.findChild(obj, "cover/btnChallenge/txt")

				btn.gameObject:SetActive(isTimeOn and isOpen)
				btnText:SetActive(not isOver)

				local descText = goutil.findChildTextComponent(obj, "txtDesc/Viewport/Content")
				local descGo = goutil.findChild(obj, "txtDesc")

				descText.text = config.levelDesc

				descText.gameObject:SetActive(isOver)
				descGo:SetActive(isOver)
				goutil.findChild(obj, "markGet"):SetActive(haveGetPrize)

				local btnGet = goutil.findChild(obj, "btnGet")

				btnGet:SetActive(isOver and not haveGetPrize)
				self:_clearEffect(i)

				if isOver and not haveGetPrize then
					self._effectList[i] = self:_showEffect(btnGet)
				end

				local item = goutil.findChild(obj, "item")

				MaterialMgr.setCellByCfg(config.prize, item)
			end
		end
	end
end

function LioncultureView:_cultureOnClick()
	if not GameUtil.getUserData("LioncultureViewredCulture") then
		GameUtil.saveUserData("LioncultureViewredCulture", true)
	end

	UIStateManager.instance:push(ViewName.LioncultureclassView)
	goutil.setActive(self._redCulture, false)
end

function LioncultureView:_showSpriteRawInfo()
	local x, y, scale = 0, 0, 0.5

	self._roleModel = RoleObjectPool.instance:removeRole(self._roleModel)
	self._roleModel = RoleObjectPool.instance:addRoleToParent(self._roleModel, 1014603, self._con, scale, function(obj)
		return
	end, true, x, y)
end

function LioncultureView:_showBubble()
	self:getTxt("bubble/txtDesc").text = "通关醒狮文化考验，\n赢召唤券&限定称号！"

	self._bubble:SetActive(true)
	removetimer(self._hideBubble, self)
	settimer(3, self._hideBubble, self, false)
end

function LioncultureView:_hideBubble()
	self._bubble:SetActive(false)
end

function LioncultureView:_showEffect(parent)
	local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"
	local uiEffect = UIEffectManager.instance:playEffect(self, effPath, parent.transform, 0, 0, true, false, nil, function(target, eff)
		if not goutil.isNil(self._tabRange.transform) then
			eff:setClipping(self._tabRange.transform)
		end
	end)

	uiEffect:setParent(parent.transform)
	uiEffect:setLocalPos(0, 0, 0)
	uiEffect:setScale(0.64)

	return uiEffect
end

function LioncultureView:_clearEffect(index)
	if self._effectList[index] then
		UIEffectManager.instance:stopEffect(self._effectList[index])

		self._effectList[index] = nil
	end
end

return LioncultureView
