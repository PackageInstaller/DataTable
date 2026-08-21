-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/view/editor/MainlineDungeonEditorCell.lua

module("logic.extensions.dungeon.view.editor.MainlineDungeonEditorCell", package.seeall)

local M = class("MainlineDungeonEditorCell", SimpleCellComponent)

function M:ctor(container)
	self.super.ctor(self, container)

	self._isSelected = false
end

function M:buildUI()
	self.mainGO = self._go
	self._transf = self._go.transform
	self._goClick = goutil.findChild(self._go, "click")
	self._goLine = goutil.findChild(self._go, "line")
	self._imgIcon = self._goLine:GetComponent(UIComponentType.Image)
	self._transfLine = goutil.addComponentOnce(self._goLine, UIComponentType.RectTransform)
	self._normalLockGo = goutil.findChild(self.mainGO, "normal_lock_point")
	self._normalUnlockGo = goutil.findChild(self.mainGO, "normal_unlock_point")
	self._normalUnlockSelected = goutil.findChild(self._normalUnlockGo, "imgSelect")
	self._bossLockGo = goutil.findChild(self.mainGO, "boss_lock_point")
	self._bossUnlockGo = goutil.findChild(self.mainGO, "boss_unlock_point")
	self._bossUnlockSelected = goutil.findChild(self._bossUnlockGo, "imgSelect")
	self._plotLockGo = goutil.findChild(self.mainGO, "special_lock_point")
	self._plotUnlockGo = goutil.findChild(self.mainGO, "special_unlock_point")
	self._plotUnlockSelected = goutil.findChild(self._plotUnlockGo, "imgSelect")
	self._starPanelGo = goutil.findChild(self.mainGO, "star")
	self._starGetList = {}
	self._starGetList[1] = goutil.findChild(self.mainGO, "star/star1/type2")
	self._starGetList[2] = goutil.findChild(self.mainGO, "star/star2/type2")
	self._starGetList[3] = goutil.findChild(self.mainGO, "star/star3/type2")
	self._normalLockTxt = goutil.findChildTextComponent(self.mainGO, "normal_lock_point/Text")
	self._normalUnlockTxt = goutil.findChildTextComponent(self.mainGO, "normal_unlock_point/Text")
	self._bossLockTxt = goutil.findChildTextComponent(self.mainGO, "boss_lock_point/Text")
	self._bossUnlockTxt = goutil.findChildTextComponent(self.mainGO, "boss_unlock_point/Text")
	self._plotLockTxt = goutil.findChildTextComponent(self.mainGO, "special_lock_point/Text")
	self._plotUnlockTxt = goutil.findChildTextComponent(self.mainGO, "special_unlock_point/Text")
	self._goStatus = goutil.findChild(self.mainGO, "logContent")
	self._goStatusTypeDungeon = goutil.findChild(self._goStatus, "lay/item1")
	self._txtStatusTypeDungeon = goutil.findChildComponent(self._goStatusTypeDungeon, "txtContent1", UIComponentType.TMPText)
	self._goStatusTypePlot = goutil.findChild(self._goStatus, "lay/item2")
	self._goStatusAttribute = goutil.findChild(self._goStatus, "lay/item3")
	self._txtStatusAttribute = goutil.findChildComponent(self._goStatusAttribute, "txtContent", UIComponentType.TMPText)
	self._teachSignGo = goutil.findChild(self.mainGO, "normal_unlock_point/teachSign")
	self._unlockPlotImg = goutil.findChildImageComponent(self.mainGO, "special_unlock_point/Image1")
	self._lockPlotImg = goutil.findChildImageComponent(self.mainGO, "special_lock_point/Image1")

	self:enterEditMode()
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	return
end

function M:bindDispatcherEvent()
	GlobalDispatcher:addEventListener(EventType.MAINLINE_DUNGEON_SELECT_EDITOR, self._onSelectDungeon, self)
end

function M:unbindDispatcherEvent()
	GlobalDispatcher:removeEventListener(EventType.MAINLINE_DUNGEON_SELECT_EDITOR, self._onSelectDungeon, self)
end

function M:onEnter()
	return
end

function M:onExit()
	return
end

function M:destroyUI()
	if not goutil.isNil(self._raycastProxy) then
		self._raycastProxy:RemoveClickListener()
		self._raycastProxy:RemoveBeginDragListener()
		self._raycastProxy:RemoveDragListener()
		self._raycastProxy:RemoveEndDragListener()

		self._raycastProxy = nil
	end

	if not goutil.isNil(self._lineRaycastProxy) then
		self._lineRaycastProxy:RemoveClickListener()
		self._lineRaycastProxy:RemoveBeginDragListener()
		self._lineRaycastProxy:RemoveDragListener()
		self._lineRaycastProxy:RemoveEndDragListener()

		self._lineRaycastProxy = nil
	end
end

function M:_setData(dungeonId, isUnlock)
	self._dungeonId = dungeonId
	self._isUnlock = isUnlock
end

function M:_refreshUI()
	local dungeonMo = DungeonMainLineChapterModel.instance:getDungeonMoById(self._dungeonId)

	if not dungeonMo then
		goutil.setActive(self.mainGO, false)

		return
	end

	self._normalLockTxt.text = dungeonMo:getIndex()
	self._normalUnlockTxt.text = dungeonMo:getIndex()
	self._bossLockTxt.text = dungeonMo:getIndex()
	self._bossUnlockTxt.text = dungeonMo:getIndex()
	self._plotLockTxt.text = dungeonMo:getIndex()
	self._plotUnlockTxt.text = dungeonMo:getIndex()

	local isUnlock = self._isUnlock

	if dungeonMo:getIsPlotNode() then
		goutil.setActive(self._normalLockGo, false)
		goutil.setActive(self._normalUnlockGo, false)
		goutil.setActive(self._bossLockGo, false)
		goutil.setActive(self._bossUnlockGo, false)
		goutil.setActive(self._plotLockGo, not isUnlock)
		goutil.setActive(self._plotUnlockGo, isUnlock)

		local dungeonCo = DungeonConfig.instance:getMainlinePlotDungeonCOByDungeonId(self._dungeonId)

		IconLoader.setSprite(self._unlockPlotImg, IconType.MainlinePlotDungeon, dungeonCo.imgName)
		IconLoader.setSprite(self._lockPlotImg, IconType.MainlinePlotDungeon, dungeonCo.imgName)
	else
		local dungeonCo = DungeonConfig.instance:getMainlineDungeonUnlockCOByDungeonId(self._dungeonId)

		if dungeonCo and dungeonCo.isBoss == 1 then
			goutil.setActive(self._normalLockGo, false)
			goutil.setActive(self._normalUnlockGo, false)
			goutil.setActive(self._bossLockGo, not isUnlock)
			goutil.setActive(self._bossUnlockGo, isUnlock)
		else
			goutil.setActive(self._teachSignGo, isUnlock and dungeonCo.isTeach == 1)
			goutil.setActive(self._normalLockGo, not isUnlock)
			goutil.setActive(self._normalUnlockGo, isUnlock)
			goutil.setActive(self._bossLockGo, false)
			goutil.setActive(self._bossUnlockGo, false)
		end

		goutil.setActive(self._plotLockGo, false)
		goutil.setActive(self._plotUnlockGo, false)
		goutil.setActive(self._starPanelGo, isUnlock)

		if isUnlock then
			local count = dungeonMo:getStarCount()

			for i, star in ipairs(self._starGetList) do
				goutil.setActive(star, i <= count)
			end
		end
	end

	self:updateSelected()
	self:updateStatus()
end

function M:_createLineEditWidget()
	return
end

function M:_onSelectDungeon(_, cell)
	if cell == nil or cell ~= self then
		self:setSelect(false)
	end
end

function M:_onClickSelf()
	PrefabUtilityHelper.SetActiveObject(self._go)
	self:setSelect(true)
	GlobalDispatcher:dispatchEvent(EventType.MAINLINE_DUNGEON_SELECT_EDITOR, self)
end

function M:_onBeginDrag(posX, posY, pointerId)
	if self._isSelected == false then
		return
	end

	PrefabUtilityHelper.SetActiveObject(self._go)

	self._goBeginDragX = self._transf.localPosition.x
	self._goBeginDragY = self._transf.localPosition.y
	self._beginDragX = posX
	self._beginDragY = posY
end

function M:_onDrag(posX, posY, pointerId)
	if self._isSelected == false then
		return
	end

	local deltaX = posX - self._beginDragX
	local deltaY = posY - self._beginDragY
	local x = self._goBeginDragX + deltaX
	local y = self._goBeginDragY + deltaY

	Astral.TransformUtil.SetLocalPos(self._transf, x, y, 0)
	GlobalDispatcher:dispatchEvent(EventType.MAINLINE_DUNGEON_POS_EDITOR, Vector3.New(x, y, 0))
end

function M:_onEndDrag(posX, posY, pointerId)
	return
end

function M:_onClickLine()
	PrefabUtilityHelper.SetActiveObject(self._goLine)
	self:setSelect(true)
	GlobalDispatcher:dispatchEvent(EventType.MAINLINE_DUNGEON_SELECT_EDITOR, self)
end

function M:_onBeginDragLine(posX, posY, pointerId)
	if self._isSelected == false then
		return
	end

	PrefabUtilityHelper.SetActiveObject(self._goLine)

	self._lineBeginDragX = self._transfLine.localPosition.x
	self._lineBeginDragY = self._transfLine.localPosition.y
	self._beginDragX = posX
	self._beginDragY = posY
end

function M:_onDragLine(posX, posY, pointerId)
	if self._isSelected == false then
		return
	end

	local deltaX = posX - self._beginDragX
	local deltaY = posY - self._beginDragY
	local x = self._lineBeginDragX + deltaX
	local y = self._lineBeginDragY + deltaY

	Astral.TransformUtil.SetLocalPos(self._transfLine, x, y, 0)
	GlobalDispatcher:dispatchEvent(EventType.MAINLINE_LINE_POS_EDITOR, self:getLinePos())
end

function M:_onEndDragLine(posX, posY, pointerId)
	return
end

function M:setSelect(isSelect)
	self._isSelected = isSelect

	self:updateSelected()
end

function M:updateSelected()
	goutil.setActive(self._normalUnlockSelected, self._isSelected)
	goutil.setActive(self._bossUnlockSelected, self._isSelected)
	goutil.setActive(self._plotUnlockSelected, self._isSelected)
end

function M:updateStatus()
	if checknumber(self._dungeonId) > 0 then
		local hasUnlockTarget, unlock = DungeonMainLineChapterModel.instance:hasUnlockDungeon(self._dungeonId)

		unlock = true

		local hasTypePlot = false
		local dungeonMo = DungeonMainLineChapterModel.instance:getDungeonMoById(self._dungeonId)

		if not dungeonMo:getIsPlotNode() then
			local levelCode = dungeonMo:getDungeonBattleCode()
			local levelCO = BattleConfig.instance:getBattleLevelCO(levelCode)
			local plotEventGroup = levelCO.plotEventGroup

			if plotEventGroup > 0 then
				hasTypePlot = BattleConfig.instance:hasAnswerByGroupCode(plotEventGroup)
			end
		end

		local configs = PlayerConfig.instance:getAttributeOfMainline()
		local canGet = false

		for i, v in ipairs(configs) do
			if self._dungeonId == v.id then
				canGet = true
			end
		end

		if not goutil.isNil(self._goStatus) and (hasUnlockTarget or hasTypePlot or canGet) then
			goutil.setActive(self._goStatusTypeDungeon, hasUnlockTarget)

			local colorStr = unlock and "#989898" or "#FFFFFF"

			self._txtStatusTypeDungeon.color = parsecolor(colorStr)

			local img = goutil.findChildImageComponent(self._txtStatusTypeDungeon.gameObject, "Image1")

			img.color = parsecolor(colorStr)

			local txtStr = unlock and lang("tip_mainline_lang_1") or lang("tip_mainline_lang_2")

			self._txtStatusTypeDungeon.text = txtStr

			goutil.setActive(self._goStatusTypePlot, hasTypePlot)

			local attrType, attrName, attrLevel = MainlineDungeonUtil.getAttribute(self._dungeonId)

			if attrType and not dungeonMo:hasPassed() then
				local attrStr = attrName .. attrType .. attrLevel

				self._txtStatusTypeDungeon.text = string.format("%s (%s%s)", txtStr, lang("tip_chapter_node_static1"), attrStr)
			end

			self._txtStatusAttribute.text = MainlineDungeonUtil.getPassAttrDesc()

			goutil.setActive(self._goStatusAttribute, canGet and not dungeonMo:hasPassed())
			goutil.setActive(self._goStatus, self._goStatusTypeDungeon.activeSelf or self._goStatusTypePlot.activeSelf or self._goStatusAttribute.activeSelf)
		else
			goutil.setActive(self._goStatus, false)
		end
	end
end

function M:setPos(vec3)
	Astral.TransformUtil.SetLocalPos(self._transf, vec3.x, vec3.y, 0)
end

function M:setLinePos(vec3)
	Astral.TransformUtil.SetLocalPos(self._transfLine, vec3.x, vec3.y, 0)
end

function M:setLineAngle(angle)
	TransformUtils.SetLocalEulerAngles(self._transfLine, 0, 0, angle)
end

function M:setLineLength(length)
	RectTransformUtils.SetHeight(self._transfLine, length)
end

function M:getPos()
	return self._transf.localPosition
end

function M:getLinePos()
	return Vector3.New(Astral.TransformUtil.GetAnchoredPos(self._transfLine, 0, 0))
end

function M:getLineAngle()
	local x, y, z = TransformUtils.GetLocalEulerAngles(self._transfLine, 0, 0, 0)

	return z
end

function M:getLineLength()
	return RectTransformUtils.GetHeight(self._transfLine)
end

function M:setLineLength(length)
	RectTransformUtils.SetHeight(self._transfLine, length)
end

function M:setLinePortPos(beginPos, endPos, rightOffset)
	local delta = beginPos - endPos
	local angle = Vector3.Angle(Vector3.up, beginPos - endPos)

	self:setLineAngle(angle)

	local length = delta:Magnitude()

	self:setLineLength(length)
	Astral.TransformUtil.SetAnchoredPos(self._transfLine, rightOffset.x, rightOffset.y)
end

function M:setlineVisible(visible)
	goutil.setActive(self._goLine, visible)
end

function M:enterEditMode()
	self._raycastProxy = RaycastProxy.Get(self._goClick)

	self._raycastProxy:SetClickListener(self._onClickSelf, self)
	self._raycastProxy:SetBeginDragListener(self._onBeginDrag, self)
	self._raycastProxy:SetDragListener(self._onDrag, self)
	self._raycastProxy:SetEndDragListener(self._onEndDrag, self)

	self._lineRaycastProxy = RaycastProxy.Get(self._goLine)

	self._lineRaycastProxy:SetClickListener(self._onClickLine, self)
	self._lineRaycastProxy:SetBeginDragListener(self._onBeginDragLine, self)
	self._lineRaycastProxy:SetDragListener(self._onDragLine, self)
	self._lineRaycastProxy:SetEndDragListener(self._onEndDragLine, self)

	self._imgIcon.raycastTarget = true
	self._btnLine = self._goLine:AddComponent(typeof(UnityEngine.UI.Button))
end

function M:exitEditMode()
	self._imgIcon.raycastTarget = false

	UnityEngine.GameObject.Destroy(self._btnLine)
	UnityEngine.GameObject.Destroy(self._raycastProxy)
	UnityEngine.GameObject.Destroy(self._lineRaycastProxy)
	UnityEngine.GameObject.Destroy(self._container)

	local unlockDynIcon = Astral.ImageDynIcon.Get(self._unlockPlotImg.gameObject)
	local lockDynIcon = Astral.ImageDynIcon.Get(self._lockPlotImg.gameObject)

	UnityEngine.GameObject.Destroy(unlockDynIcon)
	UnityEngine.GameObject.Destroy(lockDynIcon)
end

return M
