-- chunkname: @modules/logic/versionactivity1_2/yaxian/controller/game/status/YaXianInteractStatusBase.lua

module("modules.logic.versionactivity1_2.yaxian.controller.game.status.YaXianInteractStatusBase", package.seeall)

local YaXianInteractStatusBase = class("YaXianInteractStatusBase", UserDataDispose)

function YaXianInteractStatusBase:ctor()
	self:__onInit()
end

function YaXianInteractStatusBase:init(interactItem)
	self.interactItem = interactItem
	self.interactMo = interactItem.interactMo
	self.iconGoContainer = interactItem.iconGoContainer
	self.config = self.interactMo.config

	self.addEventCb(self, YaXianGameController.instance, YaXianEvent.OnUpdateEffectInfo, self.onUpdateEffectInfo, self)
	self.addEventCb(self, YaXianGameController.instance, YaXianEvent.RefreshInteractStatus, self.refreshStatus, self)
end

function YaXianInteractStatusBase:onUpdateEffectInfo()
	self:refreshStatus(self.isShow)
end

function YaXianInteractStatusBase:refreshStatus(isShow)
	self:stopLoopSwitchAnimation()

	self.isShow = isShow

	if not isShow then
		gohelper.setActive(self.iconGo, false)

		return
	end

	if not self.iconGo then
		self:loadIconPrefab()

		return
	end

	if not YaXianGameController.instance:isSelectingPlayer() then
		gohelper.setActive(self.iconGo, false)

		return
	end

	self:updateStatus()

	local hasStatus = self:hasStatus()

	gohelper.setActive(self.iconGo, hasStatus)

	if hasStatus then
		self:startStatusAnimation()
	end
end

function YaXianInteractStatusBase:updateStatus()
	self.statusDict = {}
end

function YaXianInteractStatusBase:addStatus(status, direction)
	local statusMo = self.statusDict[status]

	if not statusMo then
		local statusPool = YaXianGameController.instance:getInteractStatusPool()

		statusMo = statusPool:getObject()
		self.statusDict[status] = statusMo
	end

	statusMo:addStatus(status, direction)
end

function YaXianInteractStatusBase:hasStatus()
	return self.statusDict and next(self.statusDict)
end

function YaXianInteractStatusBase:loadIconPrefab()
	if self.iconLoader then
		return
	end

	self.iconLoader = PrefabInstantiate.Create(self.iconGoContainer)

	self.iconLoader:startLoad(YaXianGameEnum.SceneResPath.MonsterStatus, self.onIconLoadCallback, self)
end

function YaXianInteractStatusBase:onIconLoadCallback()
	self.iconGo = self.iconLoader:getInstGO()
	self.statusGoDict = self:getUserDataTb_()
	self.statusGoDict[YaXianGameEnum.IconStatus.Assassinate] = gohelper.findChild(self.iconGo, "ansha")
	self.statusGoDict[YaXianGameEnum.IconStatus.Fight] = gohelper.findChild(self.iconGo, "zhandou")
	self.statusGoDict[YaXianGameEnum.IconStatus.InVisible] = gohelper.findChild(self.iconGo, "yingsheng")
	self.statusGoDict[YaXianGameEnum.IconStatus.ThroughWall] = gohelper.findChild(self.iconGo, "chuanqiang")
	self.statusGoDict[YaXianGameEnum.IconStatus.PlayerAssassinate] = gohelper.findChild(self.iconGo, "dead")
	self.statusAnimatorDict = self:getUserDataTb_()
	self.statusDirectionDict = {}

	for status, go in pairs(self.statusGoDict) do
		self.statusAnimatorDict[status] = go:GetComponent(typeof(UnityEngine.Animator))

		if YaXianGameEnum.DirectionIcon[status] then
			self.statusDirectionDict[status] = self:getUserDataTb_()

			for _, direction in pairs(YaXianGameEnum.MoveDirection) do
				self.statusDirectionDict[status][direction] = gohelper.findChild(go, YaXianGameEnum.DirectionName[direction])
			end
		end
	end

	self:refreshStatus(self.isShow)
end

function YaXianInteractStatusBase:startStatusAnimation()
	if not self.statusDict then
		gohelper.setActive(self.iconGo, false)

		return
	end

	self.statusLen = tabletool.len(self.statusDict)

	if self.statusLen <= 0 then
		gohelper.setActive(self.iconGo, false)

		return
	end

	gohelper.setActive(self.iconGo, true)

	if self.statusLen == 1 then
		for status, _ in pairs(self.statusDict) do
			self:showOneStatusIcon(status)
		end

		return
	end

	self.statusList = {}

	for status, _ in pairs(self.statusDict) do
		table.insert(self.statusList, status)
	end

	self.currentShowStatusIndex = 0

	self:startLoopSwitchAnimation()
end

function YaXianInteractStatusBase:showOneStatusIcon(showStatus)
	for _, go in pairs(self.statusGoDict) do
		gohelper.setActive(go, false)
	end

	gohelper.setActive(self.statusGoDict[showStatus], true)

	if YaXianGameEnum.DirectionIcon[showStatus] then
		local statusMo = self.statusDict[showStatus]

		for _, directGo in pairs(self.statusDirectionDict[showStatus]) do
			gohelper.setActive(directGo, false)
		end

		if statusMo.directionList then
			for _, direction in pairs(statusMo.directionList) do
				gohelper.setActive(self.statusDirectionDict[showStatus][direction], true)
			end
		end
	end
end

function YaXianInteractStatusBase:stopStatusAnimation()
	self:stopLoopSwitchAnimation()
	gohelper.setActive(self.iconGo, false)

	if self.statusDict then
		for _, statusMo in pairs(self.statusDict) do
			local statusPool = YaXianGameController.instance:getInteractStatusPool()

			statusPool:putObject(statusMo)
		end
	end

	self.statusDict = nil
	self.statusList = nil
end

function YaXianInteractStatusBase:startLoopSwitchAnimation()
	self.flow = FlowSequence.New()

	local preShowStatusIndex = self.currentShowStatusIndex

	if preShowStatusIndex > 0 then
		local status = self.statusList[preShowStatusIndex]
		local animator = self.statusAnimatorDict[status]

		self.flow:addWork(DelayFuncWork.New(self.playIconCloseAnimation, self, YaXianGameEnum.IconAnimationDuration, animator))
	end

	self.currentShowStatusIndex = self.currentShowStatusIndex + 1

	if self.currentShowStatusIndex > self.statusLen then
		self.currentShowStatusIndex = 1
	end

	local status = self.statusList[self.currentShowStatusIndex]
	local animator = self.statusAnimatorDict[status]

	self.flow:addWork(DelayFuncWork.New(self.playIconOpenAnimation, self, YaXianGameEnum.IconAnimationDuration, animator))
	self.flow:registerDoneListener(self.onSwitchAnimationDone, self)
	self.flow:start()
end

function YaXianInteractStatusBase:playIconCloseAnimation(animator)
	animator:Play("close")
end

function YaXianInteractStatusBase:playIconOpenAnimation(animator)
	self:showOneStatusIcon(self.statusList[self.currentShowStatusIndex])
	animator:Play("open")
end

function YaXianInteractStatusBase:onSwitchAnimationDone()
	TaskDispatcher.runDelay(self.startLoopSwitchAnimation, self, YaXianGameEnum.IconAnimationSwitchInterval)
end

function YaXianInteractStatusBase:stopLoopSwitchAnimation()
	if self.flow then
		self.flow:destroy()
	end

	TaskDispatcher.cancelTask(self.startLoopSwitchAnimation, self)
end

function YaXianInteractStatusBase:dispose()
	self:stopStatusAnimation()

	if self.iconLoader then
		self.iconLoader:dispose()
	end

	self:__onDispose()
end

return YaXianInteractStatusBase
