-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/uifollow/UIBattleUnitProperty.lua

module("logic.battle.uifollow.UIBattleUnitProperty", package.seeall)

local UIBattleUnitProperty = class("UIBattleUnitProperty", IBattleReusable)

function UIBattleUnitProperty:getCapacity()
	return BattleConst.ObjPoolCapacityMid
end

function UIBattleUnitProperty:ctor()
	local sceneGoMgr = BattleMgr.instance:getSceneGameObjectMgr()
	local parentGo = sceneGoMgr:getUnitUIRoot(UIFollowType.Top)

	self.rootGO = goutil.create("UIBattleUnitProperty", true)

	goutil.addChildToParent(self.rootGO, parentGo)

	self.mainGO = false
	self._url = false
	self._isInBossView = false
end

function UIBattleUnitProperty:reuse()
	goutil.setActive(self.rootGO, true)
end

function UIBattleUnitProperty:reset()
	if self._canvasGroup then
		self._canvasGroup.alpha = 1
	end

	if self.mainGO then
		self:setMask(false)
		self._buffGroup:reset()
		self._buffRemoveGroup:reset()
		self._timelineTask:clear()
		self._weakPoint:reset()
	end

	self._isInBossView = false

	goutil.setActive(self.rootGO, false)
end

function UIBattleUnitProperty:destroy()
	if self.mainGO then
		self._timelineTask:clear()
		self._buffRemoveGroup:destroy()
	end

	self:_clearResource()

	if self.rootGO then
		goutil.destroy(self.rootGO)

		self.rootGO = false
	end
end

function UIBattleUnitProperty:_clearResource()
	if self.mainGO then
		self:destroyUI()
		goutil.destroy(self.mainGO)

		self.mainGO = false
	end

	self._url = false
end

function UIBattleUnitProperty:buidUI()
	self._canvasGroup = self.mainGO:GetComponent(ComponentType.CanvasGroup)
	self._weakPointPanelGo = goutil.findChild(self.mainGO, "lay/weak")
	self._weakPoint = UIBattleWeakPointFillComp.New(goutil.findChild(self.mainGO, "lay/weak/weak_fill1"))
	self._buffGroup = UIBattleBuffGroup.New(goutil.findChild(self.mainGO, "lay/buffList"))
	self._buffRemoveGroup = UIBattleBuffRemoveGroup.New(goutil.findChild(self.mainGO, "buff_remove_unit"))

	self._buffRemoveGroup:setBuffGroup(self._buffGroup)
	self._weakPoint:setVisibleCallBack(self._onWeakPointVisibleChange, self)
	self._weakPoint:setVisible(false)
	self._weakPoint:setPercentTextVisible(false)

	self._timelineTask = TimelineTask.New()
	self._signTable = {
		[BattleUnitCompUIProxy.SignEnum.LOCKED] = goutil.findChild(self.mainGO, "lay/leader"),
		[BattleUnitCompUIProxy.SignEnum.ASSISTANT] = goutil.findChild(self.mainGO, "lay/support"),
		[BattleUnitCompUIProxy.SignEnum.KILL] = goutil.findChild(self.mainGO, "lay/imgKill"),
		[BattleUnitCompUIProxy.SignEnum.PROTECT] = goutil.findChild(self.mainGO, "lay/imgProtect")
	}
	self._signAnimationTable = {
		[BattleUnitCompUIProxy.SignEnum.LOCKED] = {
			"unit_property_leader_open",
			"unit_property_leader_close"
		},
		[BattleUnitCompUIProxy.SignEnum.ASSISTANT] = {
			"unit_property_support_open",
			"unit_property_support_close"
		},
		[BattleUnitCompUIProxy.SignEnum.KILL] = {
			"unit_property_improtect_imkill_open",
			"unit_property_improtect_imkill_loop",
			"unit_property_improtect_imkill_close"
		},
		[BattleUnitCompUIProxy.SignEnum.PROTECT] = {
			"unit_property_improtect_imkill_open",
			"unit_property_improtect_imkill_loop",
			"unit_property_improtect_imkill_close"
		}
	}

	self:hideAllSign()
	self:setBossUIStatus(self._isInBossView)
end

function UIBattleUnitProperty:destroyUI()
	self._weakPoint:destroy()
	self._buffGroup:destroy()

	self._weakPoint = nil
	self._buffGroup = nil
end

function UIBattleUnitProperty:setUrl(url)
	if self._url == url then
		return
	end

	self:_clearResource()

	local resMgr = BattleMgr.instance:getResourceMgr()
	local mainGO = resMgr:getInst(url)

	goutil.addChildToParent(mainGO, self.rootGO)

	self._url = url
	self.mainGO = mainGO

	self:buidUI()
end

function UIBattleUnitProperty:setPlaySpeed(playSpeed)
	return
end

function UIBattleUnitProperty:updateBaseInfo(unit, hasAnim)
	self._unit = unit
	self._weakPoint.name = self._unit.property:getName()

	if hasAnim then
		self._weakPoint:updatePerformance(unit)
	else
		self._weakPoint:updateBaseInfo(unit, true)
	end
end

function UIBattleUnitProperty:setSelected(isSelected)
	self._weakPoint:setSelected(isSelected)
	self._weakPoint:setPercentTextVisible(isSelected)
end

function UIBattleUnitProperty:setBossUIStatus(isInBoss)
	self._isInBossView = isInBoss

	if self.mainGO then
		self._weakPoint:setVisible(not isInBoss, "isBoss")
		self._buffGroup:setVisible(not isInBoss)
	end
end

function UIBattleUnitProperty:updateBuffInfo(unit)
	if self._buffGroup then
		local buffTable = unit.buff:getAllBuff()

		self._buffGroup:setLimitCount(unit.transform:isComposite() and 8 or 4)
		self._buffGroup:updateBuffTable(buffTable)
	end
end

function UIBattleUnitProperty:playBuffRemoveAnim(buffCodes)
	self._buffRemoveGroup:addBuffList(buffCodes)
end

function UIBattleUnitProperty:clearForecast()
	if self._weakPoint then
		self._weakPoint:updateBaseInfo(self._unit, true)
	end
end

function UIBattleUnitProperty:forecast(forecastEntityInfo)
	local weakPointHp = forecastEntityInfo:getAttribute(BattleEnum.Attribute.CURRENT_WEAKPOINT_HP)

	self._weakPoint:forecast(nil, weakPointHp)
end

function UIBattleUnitProperty:setSignEnable(signEnum, enable)
	if enable then
		self:_playOpenAnimation(signEnum)
	else
		self:_playCloseAnimation(signEnum)
	end
end

function UIBattleUnitProperty:hideAllSign()
	for signEnum, _ in pairs(self._signTable) do
		local animations = self._signAnimationTable[signEnum]

		if #animations > 2 then
			self:_playSignAnimation(signEnum, 3)
		else
			self:_playSignAnimation(signEnum, 2)
		end
	end

	self._timelineTask:clear()
	self._timelineTask:addTask(0.5, self._onHideAllAnimationFinish, self)
	self._timelineTask:start()
end

function UIBattleUnitProperty:_onHideAllAnimationFinish()
	for _, goSign in pairs(self._signTable) do
		goutil.setActive(goSign, false)
	end
end

function UIBattleUnitProperty:doFade(isFade, duration)
	if self.mainGO then
		if isFade then
			self._canvasGroup:DOKill(false)
			self._canvasGroup:DOFade(0, duration)
		else
			self._canvasGroup:DOKill(false)
			self._canvasGroup:DOFade(1, duration)
		end
	end
end

function UIBattleUnitProperty:_onAddEffectFinished(unit)
	goutil.setActive(unit.mainGO, false)
end

function UIBattleUnitProperty:_onWeakPointVisibleChange(status)
	goutil.setActive(self._weakPointPanelGo, status)
end

function UIBattleUnitProperty:_playOpenAnimation(signEnum)
	local goSign = self._signTable[signEnum]
	local animations = self._signAnimationTable[signEnum]

	goutil.setActive(goSign, true)

	if #animations > 2 then
		self._timelineTask:clear()
		self._timelineTask:addTask(0, self._tPlayOpenAnimation01, self)
		self._timelineTask:addTask(0.5, self._tPlayOpenAnimation02, self)
		self._timelineTask:start(signEnum)
	else
		self._timelineTask:clear()
		self._timelineTask:addTask(0, self._tPlayOpenAnimation01, self)
		self._timelineTask:start(signEnum)
	end
end

function UIBattleUnitProperty:_playCloseAnimation(signEnum)
	local animations = self._signAnimationTable[signEnum]

	if #animations > 2 then
		self:_playSignAnimation(signEnum, 3)
	else
		self:_playSignAnimation(signEnum, 2)
	end

	self._timelineTask:clear()
	self._timelineTask:addTask(0.5, self._onCloseAnimationFinish, self)
	self._timelineTask:start(signEnum)
end

function UIBattleUnitProperty:_onCloseAnimationFinish()
	local go = self._signTable[signEnum]

	goutil.setActive(go, false)
end

function UIBattleUnitProperty:_tPlayOpenAnimation01(signEnum)
	self:_playSignAnimation(signEnum, 1)
end

function UIBattleUnitProperty:_tPlayOpenAnimation02(signEnum)
	self:_playSignAnimation(signEnum, 2)
end

function UIBattleUnitProperty:_playSignAnimation(signEnum, index)
	local go = self._signTable[signEnum]
	local animationNames = self._signAnimationTable[signEnum]
	local animation = goutil.addComponentOnce(go, ComponentType.Animation)

	animation:Play(animationNames[index])
end

function UIBattleUnitProperty:setMask(isMask)
	if self._buffGroup then
		self._buffGroup:setMask(isMask)
	end
end

return UIBattleUnitProperty
