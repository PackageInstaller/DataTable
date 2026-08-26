-- chunkname: @modules/logic/sp02/dungeonmap/view/AtomicDungeonElement.lua

module("modules.logic.sp02.dungeonmap.view.AtomicDungeonElement", package.seeall)

local AtomicDungeonElement = class("AtomicDungeonElement", LuaCompBase)

function AtomicDungeonElement:ctor(param)
	self.config = param[1]
	self.mainCamera = param[2]
	self.sceneElements = param[3]
	self.type = self.config.type
	self.isPolygonEnter = self.config.isPolygonEnter
end

function AtomicDungeonElement:init(go)
	self.go = go
	self.trans = self.go.transform
	self.itemRootMap = self:getUserDataTb_()

	for rootType, rootUrl in pairs(AtomicDungeonEnum.ElementTypeRoot) do
		if rootType ~= AtomicDungeonEnum.ElementType.KeyDoor then
			local itemRoot = self.itemRootMap[rootType]

			if not itemRoot then
				itemRoot = {
					go = gohelper.findChild(self.go, "#go_" .. rootUrl)
				}
				itemRoot.icon = gohelper.findChildImage(itemRoot.go, "icon")
				itemRoot.anim = itemRoot.go:GetComponent(gohelper.Type_Animator)
				self.itemRootMap[rootType] = itemRoot
			end
		end
	end

	self.txtPolygon = gohelper.findChildText(self.go, "#go_polygon_enter/namebg/#txt_polygon")
	self.goEmergency = gohelper.findChild(self.go, "#go_emergency")
	self.txtTime = gohelper.findChildText(self.go, "#go_emergency/time/#txt_time")
	self.animEmergency = self.goEmergency:GetComponent(gohelper.Type_Animator)

	self:setElementScale()
	self:updateInfo()
end

function AtomicDungeonElement:setElementScale()
	local mapId = self.config.mapId
	local arenaId = AtomicDungeonConfig.instance:getDungeonMapId(mapId)
	local arenaConfig = AtomicDungeonConfig.instance:getArenaConfig(arenaId)
	local scale = tonumber(arenaConfig.scale)

	transformhelper.setLocalScale(self.trans, scale, scale, scale)
end

function AtomicDungeonElement:getCameraDistance()
	if not self.trans or not self.mainCamera.transform then
		return 0
	end

	return (Vector3.Distance(self.trans.position, self.mainCamera.transform.position))
end

function AtomicDungeonElement:onClickDown()
	local canClickElement = AtomicDungeonModel.instance:getCanClickElementState()
	local isElemenetFinish = AtomicDungeonModel.instance:isElementFinish(self.config.id)

	if not canClickElement or not self.canClick or isElemenetFinish and self.config.isPermanent == 0 then
		return
	end

	self.sceneElements:onElementClickDown(self)
end

function AtomicDungeonElement:updateInfo()
	TaskDispatcher.cancelTask(self.removeElement, self)

	local posParam = {}

	if string.nilorempty(self.config.pos) then
		posParam = {
			0,
			0,
			0
		}

		logError("事件坐标为空，请检查：" .. self.config.id)
	else
		posParam = string.splitToNumber(self.config.pos, "#")
	end

	transformhelper.setLocalPos(self.trans, posParam[1], posParam[2], posParam[3])

	for rootType, itemRoot in pairs(self.itemRootMap) do
		gohelper.setActive(itemRoot.go, rootType == self.type)
	end

	self.canClick = true

	UISpriteSetMgr.instance:setSp02AtomicDungeonElementSprite(self.itemRootMap[self.type].icon, self.config.icon)

	if self.go and not self.isPolygonEnter then
		TaskDispatcher.cancelTask(self.addEmergencyCurrentSeconds, self)
		TaskDispatcher.runRepeat(self.addEmergencyCurrentSeconds, self, 1)

		self.isOpenEmergency = false

		self:refreshEmergencyTime()

		if self.elementMo and self.config.isEmergency == 1 then
			AtomicDungeonController.instance:dispatchEvent(AtomicDungeonEvent.OnEmergencyElementGuide)
		end
	end
end

function AtomicDungeonElement:addEmergencyCurrentSeconds()
	if self.go and not self.isPolygonEnter and self.elementMo and self.config.isEmergency == 1 then
		self.elementMo:addEmergencyCurrentSeconds(1)
		self:refreshEmergencyTime()
	else
		TaskDispatcher.cancelTask(self.addEmergencyCurrentSeconds, self)
	end
end

function AtomicDungeonElement:stopAddEmergencyCurrentSeconds()
	TaskDispatcher.cancelTask(self.addEmergencyCurrentSeconds, self)
end

function AtomicDungeonElement:restartAddEmergencyCurrentSeconds()
	if self.go and not self.isPolygonEnter and self.elementMo and self.config.isEmergency == 1 then
		TaskDispatcher.cancelTask(self.addEmergencyCurrentSeconds, self)
		TaskDispatcher.runRepeat(self.addEmergencyCurrentSeconds, self, 1)
		self:refreshEmergencyTime()
	end
end

function AtomicDungeonElement:refreshEmergencyTime()
	self.elementMo = AtomicDungeonModel.instance:getElementMo(self.config.id)

	if self.elementMo and self.config.isEmergency == 1 then
		local canShowExpired, timeStamp = self.elementMo:showEmergency()

		if canShowExpired and timeStamp > 0 then
			self.txtTime.text = TimeUtil.second2TimeString(timeStamp, true)

			gohelper.setActive(self.goEmergency, true)

			if not self.isOpenEmergency then
				self.animEmergency:Play("open", 0, 0)
				self.animEmergency:Update(0)

				self.isOpenEmergency = true
			end
		else
			TaskDispatcher.cancelTask(self.addEmergencyCurrentSeconds, self)
			AtomicRpc.instance:sendAtomicUpdateEmergencyTimeRequest({
				self.config.id
			}, (self.elementMo.emergencyAddSeconds == 0 or nil) and (AtomicDungeonEnum.SendEmergencyAddSecondTime or self.elementMo.emergencyAddSeconds + 1))
			self:playShowOrHideAnim(false)
			self.animEmergency:Play("close", 0, 0)
			self.animEmergency:Update(0)

			self.isOpenEmergency = false

			AtomicDungeonController.instance:dispatchEvent(AtomicDungeonEvent.OnRemoveElement, self.config.id)

			self.canClick = false

			TaskDispatcher.runDelay(self.removeElement, self, 0.5)
			AtomicDungeonController.instance:showTipToast(AtomicDungeonEnum.TipToastType.EmergencyExpired)
		end
	else
		gohelper.setActive(self.goEmergency, false)
		TaskDispatcher.cancelTask(self.addEmergencyCurrentSeconds, self)
	end
end

function AtomicDungeonElement:checkCanShowEmergency()
	if self.elementMo and self.config.isEmergency == 1 then
		local canShowExpired, timeStamp = self.elementMo:showEmergency()

		return canShowExpired and timeStamp > 0
	end
end

function AtomicDungeonElement:onUpdate()
	if self.go then
		transformhelper.setRotation(self.trans, 0, 0, 0, 1)
	end
end

function AtomicDungeonElement:needShowArrow()
	return self.config.needFollow == 1
end

function AtomicDungeonElement:playShowOrHideAnim(show)
	if self.showState == show then
		return
	end

	self.showState = show

	local isElementFinish = AtomicDungeonModel.instance:isElementFinish(self.config.id)

	if show and isElementFinish and self.config.isPermanent == 0 then
		return
	end

	self:playAnim(show and "open" or "close")

	local canShowEmergency = self:checkCanShowEmergency()

	if canShowEmergency then
		self.animEmergency:Play(show and "open" or "close", 0, 0)
		self.animEmergency:Update(0)
	end
end

function AtomicDungeonElement:playAnim(animName)
	if animName == "open2" then
		AudioMgr.instance:trigger(AudioEnum3_10.Outside.play_ui_langchao_icon_emerge)
	elseif animName == "close" then
		AudioMgr.instance:trigger(AudioEnum3_10.Outside.play_ui_langchao_icon_disappear)
	end

	self.itemRootMap[self.type].anim:Play(animName, 0, 0)
	self.itemRootMap[self.type].anim:Update(0)
end

function AtomicDungeonElement:removeElement()
	self.sceneElements:removeElement(self.config.id)
	self.sceneElements:removeArrow(self.config.id)
end

function AtomicDungeonElement:onDestroy()
	TaskDispatcher.cancelTask(self.removeElement, self)
	TaskDispatcher.cancelTask(self.addEmergencyCurrentSeconds, self)
end

return AtomicDungeonElement
