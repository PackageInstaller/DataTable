-- chunkname: @modules/logic/fight/view/FightViewDeviceArea.lua

module("modules.logic.fight.view.FightViewDeviceArea", package.seeall)

local FightViewDeviceArea = class("FightViewDeviceArea", BaseView)

function FightViewDeviceArea:onInitView()
	self.goRoot = gohelper.findChild(self.viewGO, "root")
	self.rectTrRoot = self.goRoot:GetComponent(gohelper.Type_RectTransform)
	self.goPlayCard = gohelper.findChild(self.viewGO, "root/playcards")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function FightViewDeviceArea:addEvents()
	self.addEventCb(self, FightController.instance, FightEvent.OnCreateDeviceArea, self.onCreateDeviceArea, self)
	self.addEventCb(self, FightController.instance, FightEvent.BeforeChangeSubHero, self.onBeforeChangeSubHero, self)
end

function FightViewDeviceArea:onResLoadDoneAddEvents()
	self.addEventCb(self, FightController.instance, FightEvent.StageChanged, self.onStageChanged, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnPlayHandCard, self.onPlayHandCard, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnResetCard, self.onResetCard, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnDevice_DragDone, self.onDeviceDragDone, self)
	self.addEventCb(self, FightController.instance, FightEvent.AfterEffectWorkDone, self.onAfterEffectWorkDone, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnStartSequenceFinish, self.onStartSequenceFinish, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnDevice_HidePlayArea, self.OnDeviceHidePlayArea, self)
end

function FightViewDeviceArea:onBeforeChangeSubHero()
	if self.deviceArea then
		return
	end

	if FightDataHelper.hasDeviceArea() then
		self:createDevice()

		return
	end
end

function FightViewDeviceArea:OnDeviceHidePlayArea()
	if self.deviceArea then
		self.deviceArea:setActive(false)
	end
end

function FightViewDeviceArea:onStartSequenceFinish()
	if self.deviceArea then
		local actPoint = FightDataHelper.operationDataMgr.actPoint

		self.deviceArea:setActive(actPoint > 0)
		self:resetAnchor()
		self.deviceArea:appearTween()
	end
end

function FightViewDeviceArea:onAfterEffectWorkDone()
	if self.deviceArea then
		local actPoint = FightDataHelper.operationDataMgr.actPoint

		self.deviceArea:setActive(actPoint > 0)
		self:resetAnchor()
		self.deviceArea:refreshUI()
		self.deviceArea:appearTween()
	end
end

function FightViewDeviceArea:onOpen()
	if not FightDataHelper.hasDeviceArea() then
		return
	end

	self:createDevice()
end

function FightViewDeviceArea:createDevice()
	if self.deviceArea then
		self.deviceArea:refreshUI()

		return
	end

	self.deviceArea = FightDeviceArea.Create(self.goRoot, FightDeviceArea.ViewType.FightView)

	self.deviceArea:setLoadDoneCallback(self.onDeviceAreaLoadDone, self)
	self.deviceArea:startLoad()
end

function FightViewDeviceArea:onDeviceAreaLoadDone()
	local goDeviceArea = self.deviceArea:getGoDeviceArea()

	self.viewContainer:setCacheUserData(FightViewContainerCacheKey.UserDataKey.DeviceAreaGo, goDeviceArea)
	gohelper.setSiblingAfter(goDeviceArea, self.goPlayCard)

	local anchor, scale = FightPlayCardLayoutHelper.getAnchorPosAndScale(FightPlayCardLayoutHelper.PlayCardOperateType.DeviceCard)

	self.deviceArea:setDeviceAreaAnchor(anchor.x, anchor.y)
	self.deviceArea:setDeviceAreaScale(scale)
	self:onResLoadDoneAddEvents()

	local isPlaying = FightDataHelper.stageMgr:isPlayStage()

	if isPlaying or FightDataHelper.stageMgr:inFightState(FightStageMgr.FightStateType.Enter) then
		self.deviceArea:setActive(false)
	else
		self.deviceArea:setActive(true)
	end

	FightController.instance:dispatchEvent(FightEvent.AfterCreateDeviceArea)
end

function FightViewDeviceArea:resetAnchor()
	if not self.deviceArea then
		return
	end

	local anchor = FightPlayCardLayoutHelper.getAnchorPosAndScale(FightPlayCardLayoutHelper.PlayCardOperateType.DeviceCard)

	self.deviceArea:setDeviceAreaAnchor(anchor.x, anchor.y)
end

function FightViewDeviceArea:onCreateDeviceArea()
	self:createDevice()
end

function FightViewDeviceArea:onDeviceDragDone()
	if self.deviceArea then
		self.deviceArea:refreshDeviceList()
	end
end

function FightViewDeviceArea:onPlayHandCard(cardMo)
	local skillCo = lua_skill.configDict[cardMo.skillId]

	if not skillCo then
		return
	end

	local deviceArea = FightDataHelper.getDeviceArea()

	if not deviceArea then
		return
	end

	local dirty = false
	local behaviourId = FightEnum.BehaviourId.AddDevicePower
	local heDuoNieBehaviourId = FightEnum.BehaviourId.HedoneAddDevicePower

	for i = 1, FightEnum.MaxBehavior do
		local behavior = skillCo["behavior" .. i]

		if not string.nilorempty(behavior) then
			local array = FightStrUtil.instance:getSplitString2Cache(behavior, true)

			for _, behaviourArray in ipairs(array) do
				if behaviourArray[1] == behaviourId then
					deviceArea:changeOnePowerValueByClient(behaviourArray[2], behaviourArray[3])

					dirty = true
				elseif behaviourArray[1] == heDuoNieBehaviourId then
					local powerType = behaviourArray[2]
					local entityMo = FightDataHelper.entityMgr:getById(cardMo.uid)

					if entityMo then
						local count = entityMo:getHeDuoNieBuffData()

						if count then
							deviceArea:changeOnePowerValueByClient(powerType, count)

							dirty = true
						end
					end
				end
			end
		end
	end

	if dirty and self.deviceArea then
		self.deviceArea:refreshPowerList()
	end
end

function FightViewDeviceArea:onResetCard()
	local deviceArea = FightDataHelper.getDeviceArea()

	if not deviceArea then
		return
	end

	deviceArea:resetClientChange()

	if self.deviceArea then
		self.deviceArea:refreshUI()
	end
end

function FightViewDeviceArea:onSyncAreaPos()
	if FightDataHelper.stageMgr:isOperateStage() then
		return
	end

	local rectDeviceCard = self.viewContainer:getCacheUserData(FightViewContainerCacheKey.UserDataKey.RectDeviceCard)

	if not rectDeviceCard then
		return
	end

	local screenPos = recthelper.uiPosToScreenPos(rectDeviceCard)
	local anchorX, anchorY = recthelper.screenPosToAnchorPos2(screenPos, self.rectTrRoot)
	local width = FightDeviceHelper.getDeviceAreaTotalWidth()

	width = width * 0.5

	self.deviceArea:setDeviceAreaAnchor(anchorX - width, anchorY)
end

function FightViewDeviceArea:onStageChanged(curStage)
	local deviceArea = FightDataHelper.getDeviceArea()

	if deviceArea then
		deviceArea:refreshShowPowerTypeByHandCard()
	end

	if self.deviceArea then
		self.deviceArea:refreshUI()
		self.deviceArea:setLineActive(curStage == FightStageMgr.StageType.Operate)
	end
end

function FightViewDeviceArea:onDestroyView()
	if self.deviceArea then
		self.deviceArea:dispose()

		self.deviceArea = nil
	end
end

return FightViewDeviceArea
