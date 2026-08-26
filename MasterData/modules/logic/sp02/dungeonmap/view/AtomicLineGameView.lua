-- chunkname: @modules/logic/sp02/dungeonmap/view/AtomicLineGameView.lua

module("modules.logic.sp02.dungeonmap.view.AtomicLineGameView", package.seeall)

local AtomicLineGameView = class("AtomicLineGameView", BaseView)

function AtomicLineGameView:onInitView()
	self._gotipBg = gohelper.findChild(self.viewGO, "titlebg")
	self._goplaneItem = gohelper.findChild(self.viewGO, "#go_planeItem")
	self._goshootItem = gohelper.findChild(self.viewGO, "#go_shootItem")
	self._golineItem = gohelper.findChild(self.viewGO, "#go_lineItem")
	self._goplaneBg = gohelper.findChild(self.viewGO, "#go_planeBg")
	self._goplaneBgContent = gohelper.findChild(self.viewGO, "#go_planeBgContent")
	self._goplaneContent = gohelper.findChild(self.viewGO, "#go_planeContent")
	self._goselectBg = gohelper.findChild(self.viewGO, "#go_selectBg")
	self._gotarget = gohelper.findChild(self.viewGO, "#go_target")
	self._imageendColor1 = gohelper.findChildImage(self.viewGO, "#go_target/#image_endColor1")
	self._imageendColor2 = gohelper.findChildImage(self.viewGO, "#go_target/#image_endColor2")
	self._imageendColor3 = gohelper.findChildImage(self.viewGO, "#go_target/#image_endColor3")
	self._golineContent = gohelper.findChild(self.viewGO, "shootContent/#go_lineContent")
	self._goshootItemContent = gohelper.findChild(self.viewGO, "shootContent/#go_shootItemContent")
	self._goclickMask = gohelper.findChild(self.viewGO, "#go_clickMask")
	self._btnreset = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_reset", AudioEnum3_10.Outside.play_ui_langchao_decrypt_click)
	self._btnrotate = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_rotate", AudioEnum3_10.Outside.play_ui_langchao_decrypt_click)
	self._gosucc = gohelper.findChild(self.viewGO, "#go_succ")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#go_succ/#btn_close")
	self._btnForceSucc = gohelper.findChildClick(self.viewGO, "#btn_forceSucc")
	self._imageForceProgress = gohelper.findChildImage(self.viewGO, "#btn_forceSucc/#image_forceProgress")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AtomicLineGameView:addEvents()
	self._btnreset:AddClickListener(self._btnresetOnClick, self)
	self._btnrotate:AddClickListener(self._btnrotateOnClick, self)
	self._btnclose:AddClickListener(self.closeThis, self)
	self._btnForceSucc:AddClickDownListener(self._btnForceSuccOnClickDown, self)
	self._btnForceSucc:AddClickUpListener(self._btnForceSuccOnClickUp, self)
end

function AtomicLineGameView:removeEvents()
	self._btnreset:RemoveClickListener()
	self._btnrotate:RemoveClickListener()
	self._btnclose:RemoveClickListener()
	self._btnForceSucc:RemoveClickDownListener()
	self._btnForceSucc:RemoveClickUpListener()
end

function AtomicLineGameView:_btnForceSuccOnClickDown()
	self:cleanProgressTween()

	self.progressTweenId = ZProj.TweenHelper.DOFillAmount(self._imageForceProgress, 1, (1 - self._imageForceProgress.fillAmount) * 2, self.onForceSuccProgressFull, self)

	AudioMgr.instance:trigger(AudioEnum3_10.Outside.play_ui_langchao_crack_loop)
	self.btnForceSuccAnim:Play("click", 0, 0)
	self.btnForceSuccAnim:Update(0)
end

function AtomicLineGameView:_btnForceSuccOnClickUp()
	self:cleanProgressTween()

	if self._imageForceProgress.fillAmount >= 1 or self.isSucc then
		return
	end

	self.progressTweenId = ZProj.TweenHelper.DOFillAmount(self._imageForceProgress, 0, self._imageForceProgress.fillAmount * 2)

	AudioMgr.instance:trigger(AudioEnum3_10.Outside.stop_ui_langchao_crack_loop)
	self.btnForceSuccAnim:Play("reset", 0, 0)
	self.btnForceSuccAnim:Update(0)
end

function AtomicLineGameView:onForceSuccProgressFull()
	self.isForceSucc = true
	self.isSucc = self:checkSucc()

	self:refreshSuccUI()

	if self.isSucc then
		self.targetAnim:Play("light", 0, 0)
		self.targetAnim:Update(0)
		AudioMgr.instance:trigger(AudioEnum3_10.Outside.play_ui_langchao_ray_success)
		AudioMgr.instance:trigger(AudioEnum3_10.Outside.play_ui_langchao_decrypt_success)
	end

	AudioMgr.instance:trigger(AudioEnum3_10.Outside.stop_ui_langchao_crack_loop)
end

function AtomicLineGameView:_btnPlaneItemOnClick(planeItem)
	self.curRotatePlaneItem = planeItem

	self:refreshSelectBg()
end

function AtomicLineGameView:_btnresetOnClick()
	self.isSucc = false
	self.curRotatePlaneItem = nil

	gohelper.setActive(self._gosucc, false)
	gohelper.setActive(self._gotipBg, true)
	self:initScene()
	self:refreshUI()
	self:refreshSelectBg()
end

function AtomicLineGameView:_btnrotateOnClick()
	if self.isSucc then
		return
	end

	if not self.curRotatePlaneItem then
		GameFacade.showToast(ToastEnum.AtomicLineGameRotateTip)

		return
	end

	self.isInit = false

	self.btnRotateAnim:Play("click", 0, 0)
	self.btnRotateAnim:Update(0)
	self:rotatePlane(self.curRotatePlaneItem)
end

function AtomicLineGameView:_editableInitView()
	self.planeItemMap = self:getUserDataTb_()
	self.shootItemPosMap = self:getUserDataTb_()
	self.shootItemMap = self:getUserDataTb_()
	self.lineItemMap = self:getUserDataTb_()

	gohelper.setActive(self._goplaneItem, false)
	gohelper.setActive(self._goshootItem, false)
	gohelper.setActive(self._golineItem, false)
	gohelper.setActive(self._goplaneBg, false)
	gohelper.setActive(self._goclickMask, false)
	gohelper.setActive(self._gosucc, false)
	gohelper.setActive(self._goselectBg, false)
	gohelper.setActive(self._gotipBg, true)
	gohelper.setActive(self._btnForceSucc.gameObject, false)

	self.planeXNum = 3
	self.planeYNum = 2
	self.planeCount = self.planeXNum * self.planeYNum
	self.planeItemRadius = 170
	self.initLineCount = self.planeXNum * (self.planeYNum + 1)
	self.tempLineVector = Vector2(0, 0)
	self.curShootPosVector = Vector2(0, 0)
	self.nextShootPosVector = Vector2(0, 0)
	self.rotatePlaneTime = 0.9
	self.targetAnim = self._gotarget:GetComponent(gohelper.Type_Animator)
	self.btnRotateAnim = self._btnrotate.gameObject:GetComponent(gohelper.Type_Animator)
	self._golightLayout = gohelper.findChild(self.viewGO, "lightlayout")
	self._gotopLeft = gohelper.findChild(self.viewGO, "#go_topleft")
	self.isForceSucc = false
	self.gameSuccTime = AtomicConfig.instance:getConstValue(AtomicEnum.ConstId.AtomicGameSuccTime, true)
	self.btnForceSuccAnim = self._btnForceSucc.gameObject:GetComponent(gohelper.Type_Animator)
end

function AtomicLineGameView:onUpdateParam()
	return
end

function AtomicLineGameView:onOpen()
	AudioMgr.instance:trigger(AudioEnum3_10.Outside.play_ui_molu_arm_repair)
	self:initConfig()
	self:initScene()
	self:refreshUI()
	TaskDispatcher.runDelay(self.showForceSucc, self, self.gameSuccTime)

	self._imageForceProgress.fillAmount = 0
end

function AtomicLineGameView:initConfig()
	local gameId = self.viewParam.gameId

	self.elementId = self.viewParam.elementId
	self.optionId = self.viewParam.optionId
	self.nextOptionConfig = self.viewParam.nextOptionConfig

	local gameConfig = AtomicDungeonConfig.instance:getLineGameConfig(gameId)

	self.targetTypeData = string.splitToNumber(gameConfig.targetType, "#")
	self.shootTypeData = GameUtil.splitString2(gameConfig.shootType, true)
	self.isSucc = false
end

function AtomicLineGameView:refreshUI()
	self:refreshShootItemInfo()
	self:refreshLineType()
end

function AtomicLineGameView:initScene()
	self.isInit = true

	self:initPlaneItem()
	self:initShootItem()
	self:initLineItem()
end

function AtomicLineGameView:initPlaneItem()
	for index = 1, self.planeCount do
		local planeItem = self.planeItemMap[index]

		if not planeItem then
			planeItem = {
				pos = gohelper.findChild(self._goplaneContent, "go_pos" .. index)
			}
			planeItem.go = gohelper.clone(self._goplaneItem, planeItem.pos, "planeItem" .. index)
			planeItem.planeBg = gohelper.clone(self._goplaneBg, self._goplaneBgContent, "planeBg" .. index)
			planeItem.anchorPosX, planeItem.anchorPosY = recthelper.getAnchor(planeItem.pos.transform)
			planeItem.btnClick = gohelper.findChildButtonWithAudio(planeItem.go, "btn_click", AudioEnum3_10.Outside.play_ui_langchao_decrypt_click)

			planeItem.btnClick:AddClickListener(self._btnPlaneItemOnClick, self, planeItem)

			planeItem.planeId = index
			planeItem.posX = math.ceil(planeItem.planeId / self.planeYNum)
			self.planeItemMap[index] = planeItem

			recthelper.setAnchor(planeItem.planeBg.transform, planeItem.anchorPosX, planeItem.anchorPosY)
		end

		gohelper.setActive(planeItem.planeBg, true)
		gohelper.setActive(planeItem.go, true)
	end

	for index = 1, 3 do
		local endTargetType = self.targetTypeData[index]

		UISpriteSetMgr.instance:setSp02AtomicIconSprite(self["_imageendColor" .. index], endTargetType == AtomicDungeonEnum.LineType.Minus and "sp02_atomicheart_lightblue" or "sp02_atomicheart_lightred")
	end

	local targetPosX, targetPosY = recthelper.getAnchor(self._gotarget.transform)

	self.targetPosVector = Vector2(targetPosX, targetPosY)

	local shootRowNum = self.planeYNum + 1

	for posX = 1, self.planeXNum do
		for posY = 1, shootRowNum do
			self.shootItemPosMap[posX] = self.shootItemPosMap[posX] or {}

			local shootItemPosInfo = self.shootItemPosMap[posX][posY]

			if not shootItemPosInfo then
				shootItemPosInfo = {}
				self.shootItemPosMap[posX][posY] = shootItemPosInfo
			end

			local posIndex = (posX - 1) * (self.planeYNum + 1) + posY

			shootItemPosInfo.index = posIndex

			local planeId = posIndex - posX
			local isFirstRow = false

			if (posIndex - 1) % (self.planeYNum + 1) == 0 then
				planeId = planeId + 1
				isFirstRow = true
			end

			local planeItem = self.planeItemMap[planeId]

			shootItemPosInfo.anchorPosX = planeItem.anchorPosX
			shootItemPosInfo.anchorPosY = planeItem.anchorPosY - (isFirstRow and -1 or 1) * self.planeItemRadius
			shootItemPosInfo.planeId = planeId
		end
	end
end

function AtomicLineGameView:initShootItem()
	for posX, shootDataList in ipairs(self.shootTypeData) do
		self.shootItemMap[posX] = self.shootItemMap[posX] or {}

		for posY, shootType in ipairs(shootDataList) do
			local shootItem = self.shootItemMap[posX][posY]

			if not shootItem then
				shootItem = {
					go = gohelper.clone(self._goshootItem, self._goshootItemContent, "shootItem" .. posX .. "_" .. posY),
					typeIcons = {}
				}
				self.shootItemMap[posX][posY] = shootItem
			end

			for type = 1, 5 do
				local typeIcon = gohelper.findChild(shootItem.go, "go_icon" .. type)

				shootItem.typeIcons[type] = typeIcon

				gohelper.setActive(typeIcon, type == shootType)
			end

			shootItem.type = shootType
			shootItem.parentList = {}

			local posInfo = self.shootItemPosMap[posX][posY]

			shootItem.posX = posX
			shootItem.posY = posY

			if shootType == AtomicDungeonEnum.ShootType.Minus then
				shootItem.lineType = AtomicDungeonEnum.LineType.Minus or AtomicDungeonEnum.LineType.Plus
			end

			recthelper.setAnchor(shootItem.go.transform, posInfo.anchorPosX, posInfo.anchorPosY)
			gohelper.setActive(shootItem.go, true)
		end
	end
end

function AtomicLineGameView:initLineItem()
	for posX, shootItemList in ipairs(self.shootItemMap) do
		for posY, shootItem in ipairs(shootItemList) do
			self.lineItemMap[posX] = self.lineItemMap[posX] or {}

			local lineItemList = self.lineItemMap[posX][posY]

			if not lineItemList then
				lineItemList = {}
				self.lineItemMap[posX][posY] = lineItemList
			end

			local posInfo = self.shootItemPosMap[posX][posY]

			for index = 1, 2 do
				local lineItem = lineItemList[index]

				if not lineItem then
					lineItem = {
						go = gohelper.clone(self._golineItem, self._golineContent, "lineItem" .. posX .. "_" .. posY .. "_" .. index)
					}
					lineItem.comp = MonoHelper.addLuaComOnceToGo(lineItem.go, AtomicLineGameLineItem)
				end

				gohelper.setActive(lineItem.go, false)
				lineItem.comp:setLineItemAnim(nil, "idle")
				recthelper.setAnchor(lineItem.go.transform, posInfo.anchorPosX, posInfo.anchorPosY)

				lineItemList[index] = lineItem
			end
		end
	end
end

function AtomicLineGameView:refreshShootItemInfo()
	for posY = 1, self.planeYNum + 1 do
		for posX = 1, self.planeXNum do
			local shootItem = self.shootItemMap[posX][posY]

			shootItem.parentList = {}
			shootItem.childList = {}
		end
	end

	for posY = 1, self.planeYNum + 1 do
		for posX = 1, self.planeXNum do
			local shootItem = self.shootItemMap[posX][posY]

			shootItem.go.name = "shootItem" .. posX .. "_" .. posY

			if posX + 1 <= self.planeXNum then
				local nextForwardShootItem = self.shootItemMap[posX + 1][posY]

				table.insert(nextForwardShootItem.parentList, shootItem)
				table.insert(shootItem.childList, nextForwardShootItem)

				local lineItemList = self.lineItemMap[posX][posY]

				gohelper.setActive(lineItemList[1].go, true)
				lineItemList[1].comp:setLineItemAnim(true)

				if shootItem.type == AtomicDungeonEnum.ShootType.ForwardDown then
					if posY + 1 <= self.planeYNum + 1 then
						local nextUpShootItem = self.shootItemMap[posX + 1][posY + 1]

						table.insert(nextUpShootItem.parentList, shootItem)
						table.insert(shootItem.childList, nextUpShootItem)
						gohelper.setActive(lineItemList[2].go, true)
						lineItemList[2].comp:setLineItemAnim(true)
					elseif self.isInit then
						gohelper.setActive(lineItemList[2].go, false)
					else
						lineItemList[2].comp:setLineItemAnim(false)
					end
				elseif shootItem.type == AtomicDungeonEnum.ShootType.ForwardUp then
					if posY - 1 > 0 then
						local nextDownShootItem = self.shootItemMap[posX + 1][posY - 1]

						table.insert(nextDownShootItem.parentList, shootItem)
						table.insert(shootItem.childList, nextDownShootItem)
						gohelper.setActive(lineItemList[2].go, true)
						lineItemList[2].comp:setLineItemAnim(true)
					elseif self.isInit then
						gohelper.setActive(lineItemList[2].go, false)
					else
						lineItemList[2].comp:setLineItemAnim(false)
					end
				end
			end

			self:setLineRotate(shootItem)
		end
	end
end

function AtomicLineGameView:setLineRotate(shootItem)
	local childShootItemList = shootItem.childList
	local shootItemPosInfo = self.shootItemPosMap[shootItem.posX][shootItem.posY]
	local lineItemList = self.lineItemMap[shootItem.posX][shootItem.posY]

	self.curShootPosVector:Set(shootItemPosInfo.anchorPosX, shootItemPosInfo.anchorPosY)

	for index, childShootItem in ipairs(childShootItemList) do
		local childShootItemPosInfo = self.shootItemPosMap[childShootItem.posX][childShootItem.posY]

		self.nextShootPosVector:Set(childShootItemPosInfo.anchorPosX, childShootItemPosInfo.anchorPosY)

		local distance = Vector2.Distance(self.curShootPosVector, self.nextShootPosVector)

		self.tempLineVector:Set(self.curShootPosVector.x - self.nextShootPosVector.x, self.curShootPosVector.y - self.nextShootPosVector.y)

		local lineItem = lineItemList[index]

		recthelper.setAnchor(lineItem.go.transform, self.curShootPosVector.x, self.curShootPosVector.y)
		recthelper.setWidth(lineItem.go.transform, distance)

		local angle = Mathf.Atan2(self.tempLineVector.y, self.tempLineVector.x) * Mathf.Rad2Deg

		transformhelper.setLocalRotation(lineItem.go.transform, 0, 0, angle)
	end

	if shootItem.posX == self.planeXNum then
		local distance = Vector2.Distance(self.curShootPosVector, self.targetPosVector)

		self.tempLineVector:Set(self.curShootPosVector.x - self.targetPosVector.x, self.curShootPosVector.y - self.targetPosVector.y)

		local lineItem = lineItemList[1]

		gohelper.setActive(lineItem.go, true)
		lineItem.comp:setLineItemAnim(true)
		recthelper.setAnchor(lineItem.go.transform, self.curShootPosVector.x, self.curShootPosVector.y)
		recthelper.setWidth(lineItem.go.transform, distance)

		local angle = Mathf.Atan2(self.tempLineVector.y, self.tempLineVector.x) * Mathf.Rad2Deg

		transformhelper.setLocalRotation(lineItem.go.transform, 0, 0, angle)
	end
end

function AtomicLineGameView:refreshLineType()
	for posX = 1, self.planeXNum do
		for posY = 1, self.planeYNum + 1 do
			local shootItem = self.shootItemMap[posX][posY]

			if shootItem.type == AtomicDungeonEnum.ShootType.Plus then
				shootItem.lineType = AtomicDungeonEnum.LineType.Plus
			elseif shootItem.type == AtomicDungeonEnum.ShootType.Minus then
				shootItem.lineType = AtomicDungeonEnum.LineType.Minus
			end

			for _, parentShootItem in ipairs(shootItem.parentList) do
				shootItem.lineType = (parentShootItem.type == AtomicDungeonEnum.ShootType.Plus or parentShootItem.type == AtomicDungeonEnum.ShootType.Minus) and parentShootItem.lineType or shootItem.lineType * parentShootItem.lineType
			end

			local curLineType = shootItem.lineType > 0 and 1 or 2
			local lineItemList = self.lineItemMap[posX][posY]

			for _, lineItem in ipairs(lineItemList) do
				lineItem.comp:setLineTypeShow(curLineType)
			end
		end
	end
end

function AtomicLineGameView:refreshSelectBg()
	if self.curRotatePlaneItem then
		gohelper.setActive(self._goselectBg, true)
		recthelper.setAnchor(self._goselectBg.transform, self.curRotatePlaneItem.anchorPosX, self.curRotatePlaneItem.anchorPosY)
	else
		gohelper.setActive(self._goselectBg, false)
	end
end

function AtomicLineGameView:rotatePlane(planeItem)
	gohelper.setActive(self._goclickMask, true)

	for posX = 1, self.planeXNum do
		for posY = 1, self.planeYNum + 1 do
			local shootItem = self.shootItemMap[posX][posY]

			shootItem.lineType = AtomicDungeonEnum.LineType.Plus

			local lineItemList = self.lineItemMap[posX][posY]

			for index, lineItem in ipairs(lineItemList) do
				lineItem.comp:setLineItemAnim(false)
			end
		end
	end

	local topShootItemIndex = planeItem.planeId + planeItem.posX - 1
	local bottomShootItemIndex = planeItem.planeId + planeItem.posX

	self.topPosY = topShootItemIndex - (self.planeYNum + 1) * (planeItem.posX - 1)
	self.bottomPosY = bottomShootItemIndex - (self.planeYNum + 1) * (planeItem.posX - 1)
	self.topShootItem = self.shootItemMap[planeItem.posX][self.topPosY]
	self.bottomShootItem = self.shootItemMap[planeItem.posX][self.bottomPosY]
	_, _, self.planeRotation = transformhelper.getLocalRotation(planeItem.go.transform)
	self.top2BottomTweenId = ZProj.TweenHelper.DOTweenFloat(math.pi, math.pi * 2, self.rotatePlaneTime, self.doRotateTop2Bottom, self.doRotateTop2BottomFinish, self)
	self.bottom2TopTweenId = ZProj.TweenHelper.DOTweenFloat(0, math.pi, self.rotatePlaneTime, self.doRotateBottom2Top, self.doRotateBottom2TopFinish, self)
	self.planeTweenId = ZProj.TweenHelper.DOTweenFloat(0, 180, self.rotatePlaneTime, self.doRotatePlane, self.doRotatePlaneFinish, self)

	AudioMgr.instance:trigger(AudioEnum3_10.Outside.play_ui_langchao_ray_rotate)
end

function AtomicLineGameView:doRotateTop2Bottom(value)
	local curAnchorPosX = self.curRotatePlaneItem.anchorPosX + self.planeItemRadius * math.sin(value)
	local curAnchorPosY = self.curRotatePlaneItem.anchorPosY - self.planeItemRadius * math.cos(value)

	recthelper.setAnchor(self.topShootItem.go.transform, curAnchorPosX, curAnchorPosY)
end

function AtomicLineGameView:doRotateTop2BottomFinish()
	if self.top2BottomTweenId then
		ZProj.TweenHelper.KillById(self.top2BottomTweenId)
	end
end

function AtomicLineGameView:doRotateBottom2Top(value)
	local curAnchorPosX = self.curRotatePlaneItem.anchorPosX + self.planeItemRadius * math.sin(value)
	local curAnchorPosY = self.curRotatePlaneItem.anchorPosY - self.planeItemRadius * math.cos(value)

	recthelper.setAnchor(self.bottomShootItem.go.transform, curAnchorPosX, curAnchorPosY)
end

function AtomicLineGameView:doRotateBottom2TopFinish()
	if self.bottom2TopTweenId then
		ZProj.TweenHelper.KillById(self.bottom2TopTweenId)
	end
end

function AtomicLineGameView:doRotatePlane(value)
	local rotateZ = self.planeRotation + value

	transformhelper.setLocalRotation(self.curRotatePlaneItem.go.transform, 0, 0, rotateZ)
end

function AtomicLineGameView:doRotatePlaneFinish()
	gohelper.setActive(self._goclickMask, false)

	if self.planeTweenId then
		ZProj.TweenHelper.KillById(self.planeTweenId)
	end

	self.shootItemMap[self.curRotatePlaneItem.posX][self.bottomPosY].posY = self.topPosY
	self.shootItemMap[self.curRotatePlaneItem.posX][self.topPosY].posY = self.bottomPosY
	self.shootItemMap[self.curRotatePlaneItem.posX][self.topPosY] = self.shootItemMap[self.curRotatePlaneItem.posX][self.bottomPosY]
	self.shootItemMap[self.curRotatePlaneItem.posX][self.bottomPosY] = self.shootItemMap[self.curRotatePlaneItem.posX][self.topPosY]

	self:refreshUI()

	self.isSucc = self:checkSucc()

	if self.isSucc then
		TaskDispatcher.cancelTask(self.showForceSucc, self)
	end

	self:refreshSuccUI()

	if self.isSucc then
		self.targetAnim:Play("light", 0, 0)
		self.targetAnim:Update(0)
		AudioMgr.instance:trigger(AudioEnum3_10.Outside.play_ui_langchao_ray_success)
		AudioMgr.instance:trigger(AudioEnum3_10.Outside.play_ui_langchao_decrypt_success)
	end
end

function AtomicLineGameView:refreshSuccUI()
	gohelper.setActive(self._gosucc, self.isSucc)
	gohelper.setActive(self._gotipBg, not self.isSucc)
	gohelper.setActive(self._golightLayout, not self.isSucc)
	gohelper.setActive(self._btnrotate.gameObject, not self.isSucc)
	gohelper.setActive(self._btnreset.gameObject, not self.isSucc)
	gohelper.setActive(self._gotopLeft, not self.isSucc)

	if self.isSucc then
		gohelper.setActive(self._btnForceSucc.gameObject, false)
	end
end

function AtomicLineGameView:checkSucc()
	if self.isForceSucc then
		return true
	end

	for posY = 1, self.planeYNum + 1 do
		local shootItem = self.shootItemMap[self.planeXNum][posY]

		if shootItem.lineType ~= self.targetTypeData[posY] then
			return false
		end
	end

	return true
end

function AtomicLineGameView:showForceSucc()
	if self.isSucc then
		return
	end

	gohelper.setActive(self._btnForceSucc.gameObject, true)
end

function AtomicLineGameView:killTweens()
	if self.planeTweenId then
		ZProj.TweenHelper.KillById(self.planeTweenId)
	end

	if self.top2BottomTweenId then
		ZProj.TweenHelper.KillById(self.top2BottomTweenId)
	end

	if self.bottom2TopTweenId then
		ZProj.TweenHelper.KillById(self.bottom2TopTweenId)
	end

	self:cleanProgressTween()
end

function AtomicLineGameView:cleanProgressTween()
	if self.progressTweenId then
		ZProj.TweenHelper.KillById(self.progressTweenId)

		self.progressTweenId = nil
	end
end

function AtomicLineGameView:onClose()
	local isFinish = AtomicDungeonModel.instance:isElementFinish(self.elementId)

	if self.isSucc and not self.nextOptionConfig and not isFinish then
		local optionParam = {}

		optionParam.optionId = self.optionId

		AtomicRpc.instance:sendAtomicMapInteractRequest(self.elementId, optionParam)

		local statData = AtomicDungeonModel.instance:getElementStatData(self.elementId)

		AtomicDungeonStatHelper.instance:sendPuzzleGameInteractInfo(statData, self.isForceSucc)
	end

	if self.isSucc then
		AtomicDungeonController.instance:dispatchEvent(AtomicDungeonEvent.GameFinish)
	end

	TaskDispatcher.cancelTask(self.showForceSucc, self)
	AudioMgr.instance:trigger(AudioEnum3_10.Outside.stop_ui_langchao_crack_loop)
end

function AtomicLineGameView:onDestroyView()
	for index, planeItem in pairs(self.planeItemMap) do
		planeItem.btnClick:RemoveClickListener()
	end

	self:killTweens()
end

return AtomicLineGameView
