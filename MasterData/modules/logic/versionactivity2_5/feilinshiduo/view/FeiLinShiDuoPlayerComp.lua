-- chunkname: @modules/logic/versionactivity2_5/feilinshiduo/view/FeiLinShiDuoPlayerComp.lua

module("modules.logic.versionactivity2_5.feilinshiduo.view.FeiLinShiDuoPlayerComp", package.seeall)

local FeiLinShiDuoPlayerComp = class("FeiLinShiDuoPlayerComp", LuaCompBase)

function FeiLinShiDuoPlayerComp:init(go)
	self.playerGO = go
	self.playerTrans = self.playerGO.transform
	self.isGround = true
	self.fallAddSpeed = FeiLinShiDuoEnum.FallSpeed
	self.fallYSpeed = 0
	self.isTouchElementList = {}
	self.fixFallDeltaMoveX = 0
	self.hasFixFallPos = false
	self.isJumping = false
	self.isClimbing = false
	self.startClimbing = false
	self.curStairsItem = nil
	self.isFalling = false
	self.isDying = false
	self.curStandWallItem = nil
	self.deltaMoveX = 0
	self.tempClickDeltaMoveX = 0
	self.curCheckPosIndex = 1
	self.canShowOption = false
end

function FeiLinShiDuoPlayerComp:setScene(sceneGO, viewCls)
	self.sceneGO = sceneGO
	self.sceneTrans = self.sceneGO.transform
	self.sceneViewCls = viewCls
	self.playerAnimComp = viewCls:getPlayerAnimComp()
	self.gameUIView = viewCls:getGameUIView()
	self.curGuideCheckData = self.sceneViewCls:getCurGuideCheckData()
end

function FeiLinShiDuoPlayerComp:addEventListeners()
	FeiLinShiDuoGameController.instance:registerCallback(FeiLinShiDuoEvent.resetGame, self.resetData, self)
end

function FeiLinShiDuoPlayerComp:removeEventListeners()
	FeiLinShiDuoGameController.instance:unregisterCallback(FeiLinShiDuoEvent.resetGame, self.resetData, self)
end

function FeiLinShiDuoPlayerComp:resetData()
	self:killTween()

	self.isGround = true
	self.fallYSpeed = 0
	self.isTouchElementList = {}
	self.fixFallDeltaMoveX = 0
	self.hasFixFallPos = false
	self.isJumping = false
	self.isClimbing = false
	self.startClimbing = false
	self.curStairsItem = nil
	self.isFalling = false
	self.isDying = false
	self.curStandWallItem = nil
	self.isInTarget = false
	self.tempClickDeltaMoveX = 0
	self.canShowOption = false
end

function FeiLinShiDuoPlayerComp:setUIClickRightDown()
	self.clickRightDown = true
end

function FeiLinShiDuoPlayerComp:setUIClickRightUp()
	self.clickRightDown = false
end

function FeiLinShiDuoPlayerComp:setUIClickLeftDown()
	self.clickLeftDown = true
end

function FeiLinShiDuoPlayerComp:setUIClickLeftUp()
	self.clickLeftDown = false
end

function FeiLinShiDuoPlayerComp:onTick()
	self:checkBoxHitPlayer()

	local canDoTick = self:playerMove()

	self:checkPlayerFall()

	if canDoTick then
		self:handleEvent()
	end

	self:checkPlayerInGuidePos()
end

function FeiLinShiDuoPlayerComp:playerMove()
	if not self.playerTrans or not self.playerAnimComp or self:checkPlayerIsInElement() or self.isInTarget then
		return false
	end

	local isGuideViewOpen = ViewMgr.instance:isOpen(ViewName.GuideView)

	self.deltaMoveX = 0

	if self.isGround and (UnityEngine.Input.GetKey(UnityEngine.KeyCode.LeftArrow) or UnityEngine.Input.GetKey(UnityEngine.KeyCode.A) or self.clickLeftDown) then
		self.deltaMoveX = -1
	elseif self.isGround and (UnityEngine.Input.GetKey(UnityEngine.KeyCode.RightArrow) or UnityEngine.Input.GetKey(UnityEngine.KeyCode.D) or self.clickRightDown) then
		FeiLinShiDuoGameController.instance:dispatchEvent(FeiLinShiDuoEvent.OnClickGuideRightMoveBtn)

		self.deltaMoveX = 1
	elseif self.isGround and UnityEngine.Input.GetKey(UnityEngine.KeyCode.Space) and self.canShowOption and not isGuideViewOpen then
		self:startClimbStairs()
	end

	if self.tempClickDeltaMoveX ~= self.deltaMoveX then
		self.tempClickDeltaMoveX = self.deltaMoveX

		if self.tempClickDeltaMoveX > 0 then
			self.gameUIView:rightClickUp()
			self.gameUIView:rightClickDown()
		elseif self.tempClickDeltaMoveX < 0 then
			self.gameUIView:leftClickUp()
			self.gameUIView:leftClickDown()
		else
			self.gameUIView:leftClickUp()
			self.gameUIView:rightClickUp()
		end
	end

	local limitClickRight = GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.FeiLinShiDuoBanOper)

	if isGuideViewOpen then
		if limitClickRight and self.deltaMoveX == -1 then
			self.deltaMoveX = 0
		elseif not limitClickRight then
			self.deltaMoveX = 0
		end
	end

	if UIBlockMgr.instance:isBlock() or ZProj.TouchEventMgr.Fobidden then
		self.deltaMoveX = 0
	end

	if self.deltaMoveX ~= 0 and self:checkPlayerInNoneColorElement(self.playerTrans.localPosition.x, self.playerTrans.localPosition.y) and not self.isDying then
		GameFacade.showToast(ToastEnum.Act185TrapTip)

		return false
	end

	self.isTouchElementList = FeiLinShiDuoGameModel.instance:checkTouchElement(self.playerTrans.localPosition.x + self.deltaMoveX * (FeiLinShiDuoEnum.HalfSlotWidth / 2 + 1), self.playerTrans.localPosition.y + FeiLinShiDuoEnum.HalfSlotWidth / 2)

	if not self:checkPlayerInState() then
		self.deltaMoveX = self.playerAnimComp:setMoveAnim(self.deltaMoveX, self.isTouchElementList)
	end

	if self.sceneTrans then
		local screenPosX, screenPosY = self.sceneViewCls:fixSceneBorder(-self.playerTrans.localPosition.x, -self.playerTrans.localPosition.y)

		self.sceneTrans.localPosition = Vector3.Lerp(self.sceneTrans.localPosition, Vector3(screenPosX, screenPosY, self.sceneTrans.localPosition.z), FeiLinShiDuoEnum.SceneMoveSpeed)
	end

	if self.deltaMoveX ~= 0 then
		self.fixFallDeltaMoveX = self.deltaMoveX or self.fixFallDeltaMoveX
	end

	if self.deltaMoveX ~= 0 and not self:checkPlayerInState() then
		local canMoveForward = self:checkForwardCanMove(self.playerTrans.localPosition.x + self.deltaMoveX * (FeiLinShiDuoEnum.HalfSlotWidth / 2 + 1), self.playerTrans.localPosition.y + FeiLinShiDuoEnum.HalfSlotWidth / 2, self.deltaMoveX)

		if not canMoveForward then
			self.playerAnimComp:setForward(self.deltaMoveX)

			return false
		end
	end

	if self.jumpForwardElementList and #self.jumpForwardElementList == 0 and not self:checkPlayerInState() then
		self.playerAnimComp:setPlayerMove(self.playerTrans)
	end

	return true
end

function FeiLinShiDuoPlayerComp:handleEvent()
	if not self.sceneViewCls then
		return
	end

	self:playerTouchElement()
	self:checkClimbStairs()
	self:checkPlayerDropFromStairs()
end

function FeiLinShiDuoPlayerComp:checkPlayerFall(manualCheck)
	if (self.isGround or self.deltaMoveX == 0 and not self.isGround) and not self.isJumping and not self.isClimbing or manualCheck then
		local ignoreTypeList = {
			FeiLinShiDuoEnum.ObjectType.Jump,
			FeiLinShiDuoEnum.ObjectType.Option,
			FeiLinShiDuoEnum.ObjectType.Start
		}
		local isTouchElementList = FeiLinShiDuoGameModel.instance:checkTouchElement(self.playerTrans.localPosition.x - self.deltaMoveX * FeiLinShiDuoEnum.HalfSlotWidth / 4, self.playerTrans.localPosition.y - 2, ignoreTypeList, nil, true)
		local isTouchElementList1 = FeiLinShiDuoGameModel.instance:checkTouchElement(self.playerTrans.localPosition.x + self.deltaMoveX * FeiLinShiDuoEnum.HalfSlotWidth / 4, self.playerTrans.localPosition.y - 2, ignoreTypeList, nil, true)

		if #isTouchElementList == 0 and #isTouchElementList1 == 0 and not self:checkPlayerIsInElement() then
			if not self.hasFixFallPos then
				if self.jumpForwardElementList and #self.jumpForwardElementList > 0 then
					transformhelper.setLocalPosXY(self.playerTrans, self.playerTrans.localPosition.x, self.playerTrans.localPosition.y - self.fallYSpeed * Time.deltaTime)
				elseif manualCheck then
					if not self.playerTrans.localPosition.x then
						local fallX = self.playerTrans.localPosition.x + self.fixFallDeltaMoveX * FeiLinShiDuoEnum.HalfSlotWidth / 4

						transformhelper.setLocalPosXY(self.playerTrans, fallX, self.playerTrans.localPosition.y - self.fallYSpeed * Time.deltaTime)
					end
				end

				self.hasFixFallPos = true
			else
				transformhelper.setLocalPosXY(self.playerTrans, self.playerTrans.localPosition.x, self.playerTrans.localPosition.y - self.fallYSpeed * Time.deltaTime)
			end

			self.isGround = false
			self.fallYSpeed = self.fallYSpeed + self.fallAddSpeed

			self.playerAnimComp:playFallAnim()

			self.isFalling = true
		else
			if not self.isGround then
				self.playerTrans.localPosition = self:fixStandPos(isTouchElementList)

				self.playerAnimComp:playFallEndAnim()
			end

			self:setCurStandWall(isTouchElementList, self.deltaMoveX)

			self.isGround = true
			self.fallYSpeed = 0
			self.hasFixFallPos = false
			self.jumpForwardElementList = {}
			self.isFalling = false
		end
	end
end

function FeiLinShiDuoPlayerComp:fixStandPos(isTouchElementList)
	local subItemBLPos, subItemTRPos = FeiLinShiDuoGameModel.instance:getFixStandePos(isTouchElementList, self.playerTrans.localPosition.x, self.playerTrans.localPosition.y)

	if subItemBLPos and subItemTRPos then
		return Vector3(self.playerTrans.localPosition.x, subItemTRPos.y, 0)
	end

	return self.playerTrans.localPosition
end

function FeiLinShiDuoPlayerComp:setCurStandWall(isTouchElementList)
	for index, element in pairs(isTouchElementList) do
		if element.type == FeiLinShiDuoEnum.ObjectType.Wall then
			self.curStandWallItem = element

			break
		end
	end
end

function FeiLinShiDuoPlayerComp:playerTouchElement()
	if self.isGround then
		self.isTouchElementList = FeiLinShiDuoGameModel.instance:checkTouchElement(self.playerTrans.localPosition.x + self.deltaMoveX * (FeiLinShiDuoEnum.HalfSlotWidth / 2 + 1), self.playerTrans.localPosition.y + FeiLinShiDuoEnum.HalfSlotWidth / 2)

		if #self.isTouchElementList > 0 then
			for _, element in pairs(self.isTouchElementList) do
				if element.type == FeiLinShiDuoEnum.ObjectType.Box and not self:checkPlayerInState() and self.deltaMoveX ~= 0 then
					local boxComp = self.sceneViewCls:getBoxComp(element.id)

					boxComp:setMove(self.playerTrans, self.deltaMoveX)
				end

				if element.type == FeiLinShiDuoEnum.ObjectType.Jump and self.deltaMoveX ~= 0 and Mathf.Abs(element.pos[1] + element.width / 2 - self.playerTrans.localPosition.x) <= FeiLinShiDuoEnum.touchElementRange then
					self.isGround = false
					self.isJumping = true
					self.isFalling = true
					self.jumpStartPos = Vector3(element.pos[1] + element.width / 2, element.pos[2], 0)

					local lookDir = self.playerAnimComp:getLookDir()
					local MoveXDistance = lookDir * 2 * FeiLinShiDuoEnum.SlotWidth

					self.jumpTargetPos = Vector3(element.pos[1] + element.width / 2 + MoveXDistance, element.pos[2], 0)

					self.playerAnimComp:playJumpAnim()

					local ignoreTypeList = {
						FeiLinShiDuoEnum.ObjectType.Stairs,
						FeiLinShiDuoEnum.ObjectType.Start
					}

					self.jumpForwardElementList = FeiLinShiDuoGameModel.instance:checkTouchElement(self.jumpTargetPos.x, element.pos[2] + FeiLinShiDuoEnum.HalfSlotWidth, ignoreTypeList) or {}

					local halfPosX = element.pos[1] + element.width / 2 + lookDir * FeiLinShiDuoEnum.SlotWidth
					local halfPosY = element.pos[2] + FeiLinShiDuoEnum.SlotWidth

					self.jumpTargetPos = #self.jumpForwardElementList > 0 and Vector3(halfPosX, halfPosY, 0) or self.jumpTargetPos

					if #self.jumpForwardElementList > 0 then
						if not (FeiLinShiDuoEnum.jumpAnimTime / 2) then
							local jumpXTime = FeiLinShiDuoEnum.jumpAnimTime

							self.jumpTweenX = ZProj.TweenHelper.DOAnchorPosX(self.playerTrans, self.jumpTargetPos.x, jumpXTime)
							self.jumpTweenY = ZProj.TweenHelper.DOAnchorPosY(self.playerTrans, halfPosY, FeiLinShiDuoEnum.jumpAnimTime / 2, self.doJumpHalfXFinish, self, nil, EaseType.OutCubic)

							local jumpAnim = self.sceneViewCls:getJumpAnim(element)

							if jumpAnim then
								jumpAnim.enabled = true

								jumpAnim:Play("active", 0, 0)
							end
						end
					end
				end

				if element.type == FeiLinShiDuoEnum.ObjectType.Target and self.deltaMoveX ~= 0 and not self.isInTarget and Mathf.Abs(element.pos[1] + element.width / 2 - self.playerTrans.localPosition.x) <= FeiLinShiDuoEnum.touchElementRange then
					local curGameConfig = FeiLinShiDuoGameModel.instance:getCurGameConfig()

					Activity185Rpc.instance:sendAct185FinishEpisodeRequest(curGameConfig.activityId, curGameConfig.episodeId, self.openGameResultView, self)

					self.isInTarget = true

					self.playerAnimComp:playIdleAnim()
					FeiLinShiDuoStatHelper.instance:sendMapFinish(self.playerGO)
				end
			end
		end

		self.isTouchElementList = FeiLinShiDuoGameModel.instance:checkTouchElement(self.playerTrans.localPosition.x, self.playerTrans.localPosition.y - FeiLinShiDuoEnum.HalfSlotWidth / 2)

		if #self.isTouchElementList > 0 then
			for _, element in pairs(self.isTouchElementList) do
				if element.type == FeiLinShiDuoEnum.ObjectType.Trap then
					self.playerAnimComp:playDieAnim()

					if not self.isDying then
						self.gameUIView:showDeadEffect()
					end

					self.isDying = true

					break
				end
			end
		end
	end
end

function FeiLinShiDuoPlayerComp:openGameResultView()
	local param = {}

	param.isSuccess = true

	FeiLinShiDuoGameController.instance:openGameResultView(param)
end

function FeiLinShiDuoPlayerComp:doJumpHalfXFinish()
	if self.jumpForwardElementList and #self.jumpForwardElementList > 0 then
		self:doJumpFinish()
	else
		self.jumpTweenY2 = ZProj.TweenHelper.DOAnchorPosY(self.playerTrans, self.jumpTargetPos.y, FeiLinShiDuoEnum.jumpAnimTime / 2, self.doJumpFinish, self, nil, EaseType.InCubic)
	end
end

function FeiLinShiDuoPlayerComp:doJumpFinish()
	if self.jumpForwardElementList and #self.jumpForwardElementList > 0 then
		self.isJumping = false
	end

	self.playerTrans.localPosition = self.jumpTargetPos
	self.jumpForwardElementList = {}

	self:killTween()
end

function FeiLinShiDuoPlayerComp:startClimbStairs()
	if self:checkPlayerInState() then
		return
	end

	self.isClimbing = true
	self.startClimbing = true

	if not self:checkStairsCanClimb() then
		GameFacade.showToast(ToastEnum.Act185ClimbTip)

		self.isClimbing = false
		self.startClimbing = false

		self.gameUIView:showOptionCanDoState(false)

		return
	end

	if self.isTopStairs then
		transformhelper.setLocalPosXY(self.playerTrans, self.curStairsItem.pos[1] + self.curStairsItem.width / 2, self.curStairsItem.pos[2] + self.curStairsItem.height - FeiLinShiDuoEnum.HalfSlotWidth)
	end
end

function FeiLinShiDuoPlayerComp:checkStairsCanClimb()
	local topElementList = FeiLinShiDuoGameModel.instance:checkItemTouchElemenet(self.curStairsItem.pos[1], self.curStairsItem.pos[2], self.curStairsItem, FeiLinShiDuoEnum.checkDir.Top)
	local bottomBoxList = FeiLinShiDuoGameModel.instance:checkItemTouchElemenet(self.curStairsItem.pos[1], self.curStairsItem.pos[2] + FeiLinShiDuoEnum.HalfSlotWidth, self.curStairsItem, FeiLinShiDuoEnum.checkDir.Bottom, self.sceneViewCls:getAllBoxCompList())

	return #topElementList == 0 and #bottomBoxList == 0
end

function FeiLinShiDuoPlayerComp:checkClimbStairs()
	if self.isGround and not self.isClimbing then
		local topTouchElementList = FeiLinShiDuoGameModel.instance:checkTouchElement(self.playerTrans.localPosition.x, self.playerTrans.localPosition.y + FeiLinShiDuoEnum.HalfSlotWidth / 4)
		local bottomTouchElementList = FeiLinShiDuoGameModel.instance:checkTouchElement(self.playerTrans.localPosition.x, self.playerTrans.localPosition.y - FeiLinShiDuoEnum.HalfSlotWidth / 4)

		self.curStairsItem = nil

		for _, element in pairs(topTouchElementList) do
			if element.type == FeiLinShiDuoEnum.ObjectType.Stairs then
				self.curStairsItem = element
				self.isTopStairs = false

				break
			end
		end

		for _, element in pairs(bottomTouchElementList) do
			if element.type == FeiLinShiDuoEnum.ObjectType.Stairs then
				self.curStairsItem = element
				self.isTopStairs = true

				break
			end
		end

		if self.curStairsItem and Mathf.Abs(self.curStairsItem.pos[1] + self.curStairsItem.width / 2 - self.playerTrans.localPosition.x) > FeiLinShiDuoEnum.stairsTouchCheckRange then
			self.curStairsItem = nil
		end

		self.gameUIView:showOptionState(self.curStairsItem ~= nil)

		self.canShowOption = self.curStairsItem ~= nil

		if self.curStairsItem then
			self.gameUIView:showOptionCanDoState(self:checkStairsCanClimb())
		end
	elseif self.isClimbing and self.startClimbing then
		self.gameUIView:showOptionState(false)

		self.canShowOption = false

		self.playerAnimComp:playStartClimbAnim()

		if self.isTopStairs then
			transformhelper.setLocalPosXY(self.playerTrans, self.curStairsItem.pos[1] + self.curStairsItem.width / 2, self.playerTrans.localPosition.y - FeiLinShiDuoEnum.climbSpeed * Time.deltaTime)

			if Mathf.Abs(self.curStairsItem.pos[2] - self.playerTrans.localPosition.y) <= FeiLinShiDuoEnum.HalfSlotWidth / 3 then
				transformhelper.setLocalPosXY(self.playerTrans, self.curStairsItem.pos[1] + self.curStairsItem.width / 2, self.curStairsItem.pos[2])
				self.playerAnimComp:playEndClimbAnim()

				self.isTopStairs = false
				self.startClimbing = false
			end
		else
			transformhelper.setLocalPosXY(self.playerTrans, self.curStairsItem.pos[1] + self.curStairsItem.width / 2, self.playerTrans.localPosition.y + FeiLinShiDuoEnum.climbSpeed * Time.deltaTime)

			if Mathf.Abs(self.curStairsItem.pos[2] + self.curStairsItem.height - self.playerTrans.localPosition.y) <= FeiLinShiDuoEnum.HalfSlotWidth then
				transformhelper.setLocalPosXY(self.playerTrans, self.curStairsItem.pos[1] + self.curStairsItem.width / 2, self.curStairsItem.pos[2] + self.curStairsItem.height)
				self.playerAnimComp:playEndClimbAnim()

				self.isTopStairs = true
				self.startClimbing = false
			end
		end
	end
end

function FeiLinShiDuoPlayerComp:checkPlayerDropFromStairs()
	if not self.isClimbing and not self.startClimbing and self.curStairsItem and self.playerTrans.localPosition.y - FeiLinShiDuoEnum.HalfSlotWidth / 4 < self.curStairsItem.pos[2] then
		self:checkPlayerFall(true)
	end
end

function FeiLinShiDuoPlayerComp:checkBoxHitPlayer()
	local boxCompMap = self.sceneViewCls:getAllBoxComp()

	for _, boxComp in pairs(boxCompMap) do
		if boxComp.isGround == false and not self.isDying and self.playerTrans.localPosition.x >= boxComp.itemInfo.pos[1] and self.playerTrans.localPosition.x <= boxComp.itemInfo.pos[1] + boxComp.itemInfo.width and self.playerTrans.localPosition.y < boxComp.itemInfo.pos[2] and Mathf.Abs(boxComp.itemInfo.pos[2] - self.playerTrans.localPosition.y) <= FeiLinShiDuoEnum.HalfSlotWidth then
			self.curHitBoxComp = boxComp

			self.playerAnimComp:playDieAnim()

			if not self.isDying then
				self.gameUIView:showDeadEffect()
			end

			self.isDying = true

			break
		end
	end

	if self.curHitBoxComp and not self.isDying then
		self:playerReborn()

		self.curHitBoxComp = nil
	end
end

function FeiLinShiDuoPlayerComp:playerReborn()
	if self.curHitBoxComp then
		local lookForward = self.playerAnimComp:getLookDir()
		local bornLeftPos = self.curHitBoxComp.itemInfo.pos[1] - FeiLinShiDuoEnum.HalfSlotWidth
		local bornRightPos = self.curHitBoxComp.itemInfo.pos[1] + self.curHitBoxComp.itemInfo.width + FeiLinShiDuoEnum.HalfSlotWidth
		local bornPosX = lookForward > 0 and bornLeftPos or bornRightPos

		if self:checkPlayerInNoneColorElement(bornPosX, self.playerTrans.localPosition.y) and lookForward > 0 then
			bornPosX = bornRightPos
		elseif self:checkPlayerInNoneColorElement(bornPosX, self.playerTrans.localPosition.y) and lookForward < 0 then
			bornPosX = bornLeftPos
		end

		transformhelper.setLocalPosXY(self.playerTrans, bornPosX, self.playerTrans.localPosition.y)
	elseif self.curStandWallItem then
		local isBornLeft = Mathf.Abs(self.playerTrans.localPosition.x - self.curStandWallItem.pos[1]) < Mathf.Abs(self.playerTrans.localPosition.x - (self.curStandWallItem.pos[1] + self.curStandWallItem.width))

		if isBornLeft then
			if not (self.curStandWallItem.pos[1] + FeiLinShiDuoEnum.HalfSlotWidth) then
				local bornPosX = self.curStandWallItem.pos[1] + self.curStandWallItem.width - FeiLinShiDuoEnum.HalfSlotWidth

				transformhelper.setLocalPosXY(self.playerTrans, bornPosX, self.curStandWallItem.pos[2] + self.curStandWallItem.height)
			end
		end
	end

	UIBlockHelper.instance:startBlock("FeiLinShiDuoPlayerComp_playerReborn", 0.4, ViewName.FeiLinShiDuoGameView)
	self.gameUIView:_onLeftClickUp()
	self.gameUIView:_onRightClickUp()
end

function FeiLinShiDuoPlayerComp:checkForwardCanMove(checkPosX, checkPosY, deltaMoveX, mapItem, isBox)
	if not self:checkPlayerCanMove() then
		return false
	end

	return FeiLinShiDuoGameModel.instance:checkForwardCanMove(checkPosX, checkPosY, deltaMoveX, mapItem, isBox)
end

function FeiLinShiDuoPlayerComp:checkPlayerCanMove()
	local boxCompMap = self.sceneViewCls:getAllBoxComp()

	for _, boxComp in pairs(boxCompMap) do
		if boxComp:getShowState() and boxComp.isGround == false then
			return false
		end
	end

	if self:checkPlayerIsInElement() or self.isInTarget then
		return false
	end

	return true
end

function FeiLinShiDuoPlayerComp:checkPlayerIsInElement()
	local elementMap = FeiLinShiDuoGameModel.instance:getElementMap()

	if not elementMap then
		return false
	end

	local checkElementItems = {}

	if not elementMap[FeiLinShiDuoEnum.ObjectType.Box] then
		if not elementMap[FeiLinShiDuoEnum.ObjectType.ColorPlane] then
			local colorPlaneItems = {}

			if not elementMap[FeiLinShiDuoEnum.ObjectType.Door] then
				for index, item in pairs(colorPlaneItems) do
					table.insert(checkElementItems, item)
				end

				for index, item in pairs(elementMap[FeiLinShiDuoEnum.ObjectType.Box]) do
					table.insert(checkElementItems, item)
				end

				local touchElementList = FeiLinShiDuoGameModel.instance:checkTouchElement(self.playerTrans.localPosition.x, self.playerTrans.localPosition.y + FeiLinShiDuoEnum.HalfSlotWidth / 4, {}, checkElementItems)

				return #touchElementList > 0
			end
		end
	end
end

function FeiLinShiDuoPlayerComp:checkPlayerInNoneColorElement(posX, posY)
	local elementMap = FeiLinShiDuoGameModel.instance:getElementMap()

	if not elementMap then
		return false
	end

	local checkElementItems = {}

	if not elementMap[FeiLinShiDuoEnum.ObjectType.Box] then
		if not elementMap[FeiLinShiDuoEnum.ObjectType.ColorPlane] then
			local colorPlaneItems = {}

			if not elementMap[FeiLinShiDuoEnum.ObjectType.Wall] then
				local wallItems = {}

				for index, item in pairs(colorPlaneItems) do
					if item.color == FeiLinShiDuoEnum.ColorType.None then
						table.insert(checkElementItems, item)
					end
				end

				for index, item in pairs(elementMap[FeiLinShiDuoEnum.ObjectType.Box]) do
					if item.color == FeiLinShiDuoEnum.ColorType.None then
						table.insert(checkElementItems, item)
					end
				end

				for index, item in pairs(wallItems) do
					table.insert(checkElementItems, item)
				end

				local touchElementList = FeiLinShiDuoGameModel.instance:checkTouchElement(posX, posY + FeiLinShiDuoEnum.HalfSlotWidth / 2, {}, checkElementItems)

				return #touchElementList > 0
			end
		end
	end
end

function FeiLinShiDuoPlayerComp:checkPlayerInGuidePos()
	if self.curGuideCheckData and #self.curGuideCheckData.guideList > 0 and self.curCheckPosIndex <= #self.curGuideCheckData.guideList then
		local checkData = self.curGuideCheckData.guideList[self.curCheckPosIndex]

		if not checkData then
			return
		end

		if self.playerTrans.localPosition.x >= checkData.posX and self.playerTrans.localPosition.x <= checkData.posX + checkData.rangeX and self.playerTrans.localPosition.y >= checkData.posY and self.playerTrans.localPosition.y <= checkData.posY + checkData.rangeY then
			FeiLinShiDuoGameController.instance:dispatchEvent(FeiLinShiDuoEvent.PlayerInGuideCheckPos, checkData.id)

			self.curCheckPosIndex = self.curCheckPosIndex + 1
		end
	end
end

function FeiLinShiDuoPlayerComp:checkPlayerInState()
	return self.isClimbing or self.isFalling or self.isDying or self.isJumping
end

function FeiLinShiDuoPlayerComp:setIdleState()
	self.isClimbing = false
	self.isFalling = false
	self.isDying = false
	self.isJumping = false
end

function FeiLinShiDuoPlayerComp:killTween()
	if self.jumpTweenX then
		ZProj.TweenHelper.KillById(self.jumpTweenX)
	end

	if self.jumpTweenY then
		ZProj.TweenHelper.KillById(self.jumpTweenY)
	end

	if self.jumpTweenY2 then
		ZProj.TweenHelper.KillById(self.jumpTweenY2)
	end
end

function FeiLinShiDuoPlayerComp:onDestroy()
	self:killTween()
end

return FeiLinShiDuoPlayerComp
