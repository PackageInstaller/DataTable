-- chunkname: @modules/logic/versionactivity3_3/arcade/view/game/ArcadeGameEntityIcon.lua

module("modules.logic.versionactivity3_3.arcade.view.game.ArcadeGameEntityIcon", package.seeall)

local ArcadeGameEntityIcon = class("ArcadeGameEntityIcon", LuaCompBase)

function ArcadeGameEntityIcon:init(go)
	self.go = go
	self.trans = go.transform
	self.viewTrans = self.trans.parent
	self._goportal = gohelper.findChild(self.go, "#go_portal")
	self._imageportalicon = gohelper.findChildImage(self.go, "#go_portal/#image_icon")
	self._txtportalname = gohelper.findChildText(self.go, "#go_portal/#txt_name")
	self._gogoods = gohelper.findChild(self.go, "#go_goods")
	self._goodsAnimator = self._gogoods:GetComponent(gohelper.Type_Animator)
	self._txtgoodsprice = gohelper.findChildText(self.go, "#go_goods/#txt_price")
	self._godiscount = gohelper.findChild(self.go, "#go_goods/#txt_discount")
	self._txtdiscount = gohelper.findChildText(self.go, "#go_goods/#txt_discount")
	self._gochat = gohelper.findChild(self.go, "#go_chat")
	self._transchat = self._gochat.transform
	self._gochartcontent = gohelper.findChild(self.go, "#go_chat/#go_content")
	self._txtchartdesc = gohelper.findChildText(self.go, "#go_chat/#go_content/layout/#txt_desc")
	self._gochatbubble = gohelper.findChild(self.go, "#go_chat/#go_bubble")
	self._chatContentAnimator = self._gochartcontent:GetComponent(gohelper.Type_Animator)
	self._chatBubbleAnimator = gohelper.findChildComponent(self.go, "#go_chat/#go_bubble/icon/ani", gohelper.Type_Animator)
	self._goFrames = gohelper.findChild(self.go, "#go_frame")
	self._goFrame1 = gohelper.findChild(self.go, "#go_frame/frame1")
	self._translu1 = gohelper.findChild(self.go, "#go_frame/frame1/leftup").transform
	self._transrd1 = gohelper.findChild(self.go, "#go_frame/frame1/rightdown").transform
	self._goFrame2 = gohelper.findChild(self.go, "#go_frame/frame2")
	self._translu2 = gohelper.findChild(self.go, "#go_frame/frame2/leftup").transform
	self._transrd2 = gohelper.findChild(self.go, "#go_frame/frame2/rightdown").transform
	self._gopassword = gohelper.findChild(self.go, "#go_pwd")
	self._transpassword = self._gopassword.transform
	self._txtpassword = gohelper.findChildText(self.go, "#go_pwd/#txt_pwd")

	gohelper.setActive(self._goportal, false)
	gohelper.setActive(self._gogoods, false)
	gohelper.setActive(self._gochatbubble, false)

	local stepWaitTime = ArcadeConfig.instance:getArcadeConst(ArcadeEnum.ConstId.NextStepTimeMS, true)

	if stepWaitTime then
		self._nextStepTimeMS = stepWaitTime * 0.001 or 1
	end

	self._spawnInterval = ArcadeConfig.instance:getArcadeConst(ArcadeEnum.ConstId.TalkIntervalTime, true) * 0.001
end

function ArcadeGameEntityIcon:setEntity(entityType, uid, id)
	self._entityType = entityType
	self._uid = uid
	self._id = id
	self.go.name = string.format("icon-%s-%s", self._entityType, self._uid)
	self._isAlreadyBeBombAttacked = false
	self._curTalkingGroup = nil
	self._curTalkingStep = nil
	self._contentIndex = 0
	self._contentList = nil
	self._lastShowContentTime = nil
	self._groupDict = {}

	self:refresh()
end

function ArcadeGameEntityIcon:addEventListeners()
	self.addEventCb(self, ArcadeGameController.instance, ArcadeEvent.RefreshEntityIcon, self._onRefreshEntityIcon, self)
	self.addEventCb(self, ArcadeGameController.instance, ArcadeEvent.RefreshGameEventTip, self._onRefreshGameEventTip, self)
	self.addEventCb(self, ArcadeGameController.instance, ArcadeEvent.CheckEntityTalk, self._onCheckTalk, self)
	self.addEventCb(self, ArcadeGameController.instance, ArcadeEvent.OnEntityTweenMove, self._onEntityTweenMove, self)
	self.addEventCb(self, ArcadeGameController.instance, ArcadeEvent.OnCharacterResourceCountUpdate, self._onCharacterResourceUpdate, self)
	self.addEventCb(self, ArcadeGameController.instance, ArcadeEvent.OnSkillResourceChange, self._onSkillChangeRes, self)
end

function ArcadeGameEntityIcon:removeEventListeners()
	self.removeEventCb(self, ArcadeGameController.instance, ArcadeEvent.RefreshEntityIcon, self._onRefreshEntityIcon, self)
	self.removeEventCb(self, ArcadeGameController.instance, ArcadeEvent.RefreshGameEventTip, self._onRefreshGameEventTip, self)
	self.removeEventCb(self, ArcadeGameController.instance, ArcadeEvent.CheckEntityTalk, self._onCheckTalk, self)
	self.removeEventCb(self, ArcadeGameController.instance, ArcadeEvent.OnEntityTweenMove, self._onEntityTweenMove, self)
	self.removeEventCb(self, ArcadeGameController.instance, ArcadeEvent.OnCharacterResourceCountUpdate, self._onCharacterResourceUpdate, self)
	self.removeEventCb(self, ArcadeGameController.instance, ArcadeEvent.OnSkillResourceChange, self._onSkillChangeRes, self)
end

function ArcadeGameEntityIcon:_onRefreshEntityIcon(entityType, uid)
	if self._entityType and self._uid and entityType == self._entityType and uid == self._uid then
		self:refresh()
	end
end

function ArcadeGameEntityIcon:_onRefreshGameEventTip(entityType, uid, isCharacterMove)
	if self._entityType and self._uid and entityType == self._entityType and uid == self._uid and isCharacterMove then
		self:checkTalk(ArcadeGameEnum.TalkTriggerType.Near)
	end
end

function ArcadeGameEntityIcon:_onCheckTalk(entityType, uid, triggerType, param)
	if self._entityType and self._uid and entityType == self._entityType and uid == self._uid then
		if triggerType == ArcadeGameEnum.TalkTriggerType.BeBombAttack then
			if self._isAlreadyBeBombAttacked then
				return
			end

			self._isAlreadyBeBombAttacked = true
		end

		self:checkTalk(triggerType, param)
	end
end

function ArcadeGameEntityIcon:checkTalk(triggerType, param)
	local talkGroupList = ArcadeConfig.instance:getGroupListByTrigger(self._id, triggerType)

	if not talkGroupList or #talkGroupList <= 0 then
		return
	end

	local groupList = {}
	local weightList = {}
	local totalWeight = 0

	for _, groupId in ipairs(talkGroupList) do
		local isCanTalk = true

		if triggerType == ArcadeGameEnum.TalkTriggerType.Interactive then
			local strTriggerParam = ArcadeConfig.instance:getTalkGroupTriggerParam(self._id, groupId)

			if not string.nilorempty(strTriggerParam) then
				isCanTalk = false

				local paramArr = string.splitToNumber(strTriggerParam, "#")

				if tabletool.indexOf(paramArr, param) then
					isCanTalk = true
				end
			end
		end

		if isCanTalk then
			local weight = ArcadeConfig.instance:getTalkGroupWeight(self._id, groupId)
			local index = #groupList + 1

			groupList[index] = groupId
			weightList[index] = weight
			totalWeight = totalWeight + weight
		end
	end

	local randomIndex = ArcadeGameHelper.getRandomIndex(weightList, totalWeight)
	local newTalkGroup = groupList[randomIndex]
	local isPlay = not not (not self._curTalkingGroup and newTalkGroup or self._curTalkingGroup and not newTalkGroup)

	self._curTalkingGroup = newTalkGroup
	self._curTalkingStep = 0
	self._contentIndex = 0
	self._contentList = nil
	self._lastShowContentTime = nil

	self:_talking()
	self:refreshChatContentShow(isPlay)
	AudioMgr.instance:trigger(AudioEnum3_3.Arcade.play_ui_yuanzheng_bubble_popup)
	gohelper.setAsLastSibling(self.go)
end

function ArcadeGameEntityIcon:_onEntityTweenMove(entityType, uid, isTween)
	if self._entityType and self._uid and entityType == self._entityType and uid == self._uid then
		self._tweenMoving = isTween

		self:refreshPos()
	end
end

function ArcadeGameEntityIcon:_onCharacterResourceUpdate(resId)
	if resId == ArcadeGameEnum.CharacterResource.GameCoin then
		self:refreshGoods()
	end
end

function ArcadeGameEntityIcon:_onSkillChangeRes(entityType, uid, resId, val, gainPosList)
	if entityType == ArcadeGameEnum.EntityType.Character then
		self:_onCharacterResourceUpdate(resId)
	end
end

function ArcadeGameEntityIcon:onUpdate()
	if self._isDisposed or not self._entityType or not self._uid then
		return
	end

	self:_talking()

	if self._tweenMoving then
		self:refreshPos()
	end
end

function ArcadeGameEntityIcon:_talking()
	if not self._curTalkingGroup then
		return
	end

	local curTime = Time.time

	if self._lastShowContentTime and curTime - self._lastShowContentTime < self._spawnInterval then
		return
	end

	local nextContent = self:_getNextTalkContent(curTime)

	if nextContent then
		self._txtchartdesc.text = nextContent
		self._lastShowContentTime = curTime
	end
end

function ArcadeGameEntityIcon:_getNextTalkContent(curTime)
	self._contentIndex = self._contentIndex + 1

	if self._contentList then
		local content = self._contentList[self._contentIndex]

		if not self._contentList and (not self._lastShowContentTime or curTime - self._lastShowContentTime > self._nextStepTimeMS) then
			local newContentList = self:_getNextStepContentList()

			if not newContentList or #newContentList <= 0 then
				self:_finishTalk()
				self:refreshChatContentShow(true)
			else
				self._curTalkingStep = self._curTalkingStep + 1
				self._contentList = newContentList
				self._contentIndex = 1
				content = self._contentList[self._contentIndex]
			end
		end

		return self._contentList
	end
end

function ArcadeGameEntityIcon:_getNextStepContentList()
	local nextStepId = self._curTalkingStep + 1
	local stepDict = self._groupDict[self._curTalkingGroup]

	if not stepDict then
		stepDict = {}

		local stepCfgDict = ArcadeConfig.instance:getTalkStepGroupCfg(self._curTalkingGroup)

		for stepId, stepCfg in pairs(stepCfgDict) do
			stepDict[tonumber(stepId)] = ArcadeGameHelper.getTalkCharList(stepCfg.content)
		end

		self._groupDict[self._curTalkingGroup] = stepDict
	end

	return stepDict[nextStepId]
end

function ArcadeGameEntityIcon:_finishTalk()
	self._curTalkingGroup = nil
	self._curTalkingStep = 0
	self._contentIndex = 0
	self._contentList = nil
	self._lastShowContentTime = nil
end

function ArcadeGameEntityIcon:refresh()
	self:refreshPos()
	self:refreshGoods(true)
	self:refreshPortal()
	self:refreshTalk()
	self:refreshFrame()
	self:refreshPassword()
end

function ArcadeGameEntityIcon:refreshPos()
	self:checkShow()

	if not self._isShow then
		return
	end

	local scene = ArcadeGameController.instance:getGameScene()

	if not self._entityType or not self._uid or not scene then
		return
	end

	local entity = scene.entityMgr:getEntityWithType(self._entityType, self._uid)

	if entity then
		local x, y, z = entity:getPosition()
		local rectPosX, rectPosY = recthelper.worldPosToAnchorPosXYZ(x, y, z, self.viewTrans)

		recthelper.setAnchor(self.trans, rectPosX, rectPosY)
	end
end

function ArcadeGameEntityIcon:checkShow()
	local isShow = false
	local gridX, gridY

	if self._entityType and self._uid then
		local mo = ArcadeGameModel.instance:getMOWithType(self._entityType, self._uid)

		if mo then
			gridX, gridY = mo:getGridPos()
		end
	end

	if gridX and gridX >= ArcadeGameEnum.Const.RoomMinCoordinateValue and gridX <= ArcadeGameEnum.Const.RoomSize and gridY and gridY >= ArcadeGameEnum.Const.RoomMinCoordinateValue and gridY <= ArcadeGameEnum.Const.RoomSize then
		isShow = true
	end

	if self._isShow == isShow then
		return
	end

	gohelper.setActive(self.go, isShow)

	self._isShow = isShow
end

function ArcadeGameEntityIcon:refreshGoods(isPlay)
	local isGoods = self._entityType == ArcadeGameEnum.EntityType.Goods

	if isGoods then
		local characterMO = ArcadeGameModel.instance:getCharacterMO()
		local hasCoin = characterMO and characterMO:getResourceCount(ArcadeGameEnum.CharacterResource.GameCoin) or 0
		local mo = ArcadeGameModel.instance:getMOWithType(self._entityType, self._uid)
		local price = mo and mo:getPrice() or 0
		local isCanBuy = price <= hasCoin

		SLFramework.UGUI.GuiHelper.SetColor(self._txtgoodsprice, isCanBuy and "#FFFFED" or "#FF1300")

		self._txtgoodsprice.text = price

		local goodsDiscount = ArcadeGameModel.instance:getGameAttribute(ArcadeGameEnum.GameAttribute.GoodsDiscount)
		local isDiscount = mo and mo:getIsDiscount()
		local showDiscount = isDiscount and goodsDiscount and goodsDiscount > 0

		if showDiscount then
			local percentStr = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("percent"), string.format("%02d", goodsDiscount / 10))

			self._txtdiscount.text = string.format("-%s", percentStr)
		end

		gohelper.setActive(self._godiscount, showDiscount)

		if isPlay then
			self._goodsAnimator:Play("refresh", 0, 0)
		end
	end

	gohelper.setActive(self._gogoods, isGoods)
end

function ArcadeGameEntityIcon:refreshPortal()
	local isPortal = self._entityType == ArcadeGameEnum.EntityType.Portal

	if isPortal then
		local icon = ArcadeConfig.instance:getInteractiveSceneIcon(self._id)

		UISpriteSetMgr.instance:setV3a3EliminateSprite(self._imageportalicon, icon)

		self._txtportalname.text = ArcadeConfig.instance:getInteractiveName(self._id)
	end

	gohelper.setActive(self._goportal, isPortal)
end

function ArcadeGameEntityIcon:refreshTalk()
	local hasTalk = false

	if self._entityType == ArcadeGameEnum.EntityType.BaseInteractive then
		hasTalk = ArcadeConfig.instance:isEntityHasTalk(self._id)

		if hasTalk then
			local sizeX, sizeY = ArcadeConfig.instance:getInteractiveGrid(self._id)
			local uiGridSize = ArcadeConfig.instance:getArcadeGameUIGridSize()

			transformhelper.setLocalPosXY(self._transchat, (sizeX - 1) / 2 * uiGridSize, (sizeY - 1) * uiGridSize)
		end
	end

	gohelper.setActive(self._gochartcontent, true)
	gohelper.setActive(self._gochatbubble, true)
	gohelper.setActive(self._gochat, hasTalk)
	self:refreshChatContentShow()
end

function ArcadeGameEntityIcon:refreshChatContentShow(isPlay)
	TaskDispatcher.cancelTask(self._delayPlayChatOpen, self)

	if isPlay then
		if self._curTalkingGroup then
			self._chatBubbleAnimator:Play("close", 0, 0)
		else
			self._chatContentAnimator:Play("close", 0, 0)
		end

		TaskDispatcher.runDelay(self._delayPlayChatOpen, self, 0.167)
	else
		self._chatBubbleAnimator:Play(self._curTalkingGroup and "close" or "open", 0, 1)
		self._chatContentAnimator:Play(self._curTalkingGroup and "open" or "close", 0, 1)
	end
end

function ArcadeGameEntityIcon:_delayPlayChatOpen()
	if self._curTalkingGroup then
		self._chatContentAnimator:Play("open", 0, 0)
	else
		self._chatBubbleAnimator:Play("open", 0, 0)
	end
end

function ArcadeGameEntityIcon:refreshFrame()
	local scene = ArcadeGameController.instance:getGameScene()

	if not self._entityType or not self._uid or not scene then
		return
	end

	local showFrame = false
	local uiGridSize = ArcadeConfig.instance:getArcadeGameUIGridSize()
	local halfUIGridSize = uiGridSize / 2

	if self._entityType == ArcadeGameEnum.EntityType.Character then
		showFrame = true

		local sizeX, sizeY = ArcadeConfig.instance:getCharacterSize(self._id)

		transformhelper.setLocalPosXY(self._translu1, -halfUIGridSize, (sizeY - 0.5) * uiGridSize)
		transformhelper.setLocalPosXY(self._transrd1, (sizeX - 0.5) * uiGridSize, -halfUIGridSize)
		gohelper.setActive(self._goFrame1, true)
		gohelper.setActive(self._goFrame2, false)
	elseif self._entityType == ArcadeGameEnum.EntityType.Monster then
		showFrame = ArcadeGameHelper.isShowMonsterFrame(self._id)

		if showFrame then
			local sizeX, sizeY = ArcadeConfig.instance:getMonsterSize(self._id)

			transformhelper.setLocalPosXY(self._translu2, -halfUIGridSize, (sizeY - 0.5) * uiGridSize)
			transformhelper.setLocalPosXY(self._transrd2, (sizeX - 0.5) * uiGridSize, -halfUIGridSize)
			gohelper.setActive(self._goFrame1, false)
			gohelper.setActive(self._goFrame2, true)
		end
	end

	gohelper.setActive(self._goFrames, showFrame)
end

function ArcadeGameEntityIcon:refreshPassword()
	local isPWDValidator = self._entityType == ArcadeGameEnum.EntityType.PWDValidator

	if isPWDValidator then
		local mo = ArcadeGameModel.instance:getMOWithType(self._entityType, self._uid)

		self._txtpassword.text = mo and mo:getPassword() or ""

		local sizeX, sizeY = mo:getSize()
		local uiGridSize = ArcadeConfig.instance:getArcadeGameUIGridSize()

		transformhelper.setLocalPosXY(self._transpassword, sizeX / 2 * uiGridSize, (sizeY - 1) * uiGridSize)
	end

	gohelper.setActive(self._gopassword, isPWDValidator)
end

function ArcadeGameEntityIcon:reset()
	self._entityType = nil
	self._uid = nil
	self.go.name = "icon"
	self._tweenMoving = nil
	self._isAlreadyBeBombAttacked = false
	self._groupDict = {}

	self:_finishTalk()
	TaskDispatcher.cancelTask(self._delayPlayChatOpen, self)

	self._isShow = false

	gohelper.setActive(self.go, false)
end

function ArcadeGameEntityIcon:onDestroy()
	self:reset()
end

return ArcadeGameEntityIcon
