-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/firework/view/FireworkprogressView.lua

module("logic.extensions.firework.view.FireworkprogressView", package.seeall)

local FireworkprogressView = class("FireworkprogressView", ViewComponent)

function FireworkprogressView:ctor()
	FireworkprogressView.super.ctor(self)
end

function FireworkprogressView:unbindEvents()
	FireworkprogressView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
end

function FireworkprogressView:bindEvents()
	FireworkprogressView.super.bindEvents(self)
	self._closeButton:AddClickListener(self.close, self)
end

function FireworkprogressView:buildUI()
	FireworkprogressView.super.buildUI(self)

	self._closeButton = self:getBtn("leftTop/btnClose")
	self._progressBar = self:getGo("progressview/scrollerview/ViewPort/Content/progressBar")
	self._progressSlider = self:getSlider("progressview/scrollerview/ViewPort/Content/progressBar")
	self._cellGroup = self:getGo("progressview/scrollerview/ViewPort/Content/cellGroup")
	self._listContent = self:getGo("progressview/scrollerview/ViewPort/Content")
	self._cell = self:getGo("progressview/cell")
	self._numText = self:getTxt("progressview/total/txtNum")
	self._scrollRectTransform = self:getGo("progressview/scrollerview"):GetComponent(goutil.Type_RectTransform)
	self.txtTab = {}

	for i = 1, 5 do
		self.txtTab[i] = self:getTxt(string.format("theme_%d/txtProgress", i))
	end

	self.rewardTab = {}
end

function FireworkprogressView:onExit()
	FireworkprogressView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_FIREWORK_GETPRIZE, self._refreshWorldPrizeState, self)

	for i = 1, #self.rewardTab do
		local go = goutil.findChild(self.rewardTab[i], "item/itemcell")

		MaterialMgr.resetAll(go)
	end

	for k, v in pairs(self._effectList) do
		UIEffectManager.instance:stopEffect(v)
	end

	table.clear(self._effectList)
end

function FireworkprogressView:onEnter()
	FireworkprogressView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.PM_FIREWORK_GETPRIZE, self._refreshWorldPrizeState, self)

	self._effectList = {}
	self.curActId = FireworkModel.instance.curActId
	self.prizeCfgs = FireworkConfig.instance:getWorldPrizeCfgs(self.curActId)
	self.prizeCount = #self.prizeCfgs
	self.maxTimes = self.prizeCfgs[self.prizeCount].progress
	self.totalTimes = FireworkModel.instance:getWorldTotal()

	local siderLength = 170 * self.prizeCount

	GameUtil.setHeight(self._progressBar, siderLength)
	GameUtil.setHeight(self._listContent, siderLength + 50)

	self._numText.text = string.format("累积<color=#CD7800FF>%d</color>次", self.totalTimes)

	self._progressSlider:SetValue(self.totalTimes / self.maxTimes)

	if #self.rewardTab == 0 then
		for i = 1, self.prizeCount do
			local obj = UGUIToolHelper.AddChild(self._cellGroup, self._cell)
			local x = self.prizeCfgs[i].progress / self.maxTimes * siderLength

			GameUtil.setLocalPos(obj, 0, x, 0)
			obj:SetActive(true)
			table.insert(self.rewardTab, obj)
		end
	end

	for i = 1, self.prizeCount do
		local id = self.prizeCfgs[i].id
		local prize = self.prizeCfgs[i].prize
		local progress = self.prizeCfgs[i].progress
		local obj = self.rewardTab[i]
		local go = goutil.findChild(obj, "item/itemcell")
		local get = goutil.findChild(obj, "btnGet")

		goutil.findChildTextComponent(obj, "txtNum").text = string.format("%d万次", math.floor(progress / 10000))

		GameUtil.addClickHandler(get, function()
			FireworkController.instance:gainWorldPrize(id)
		end)
		MaterialMgr.resetAll(go)
		MaterialMgr.setCellByCfg(prize, go)
	end

	self:_refreshWorldPrizeState()
	self:_refreshWorldProgress()
end

function FireworkprogressView:_refreshWorldPrizeState()
	for i = 1, self.prizeCount do
		local id = self.prizeCfgs[i].id
		local progress = self.prizeCfgs[i].progress
		local isGet = FireworkModel.instance.gainedworldprizeids[id] == true
		local canGet = progress <= self.totalTimes and not isGet
		local obj = self.rewardTab[i]
		local get = goutil.findChild(obj, "btnGet")

		get:SetActive(canGet)
		goutil.findChild(obj, "item/received"):SetActive(isGet)

		if canGet then
			if self._effectList[i] == nil then
				local _effect = UIEffectManager.instance:playEffect(self, "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab", nil, 0, 0, true, nil, nil, function(target, uiEffect)
					uiEffect:setClipping(self._scrollRectTransform)
				end)

				_effect:setParent(get.transform)
				_effect:setScale(0.7)
				_effect:setLocalPos(0, 0, 0)

				self._effectList[i] = _effect
			end
		else
			UIEffectManager.instance:stopEffect(self._effectList[i])
		end
	end
end

function FireworkprogressView:_refreshWorldProgress()
	local cfgs = FireworkConfig.instance:getWorldProgressCfgs(self.curActId)

	for i, v in ipairs(cfgs) do
		local times = FireworkModel.instance.worldProgress[v.id]

		if not times then
			return
		end

		self.txtTab[i].text = string.format("已点燃<color=#CD7800FF>%d</color>次", times)
	end
end

return FireworkprogressView
