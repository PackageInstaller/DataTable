-- chunkname: @modules/logic/sp02/dungeonmap/view/AtomicDungeonPolygonElement.lua

module("modules.logic.sp02.dungeonmap.view.AtomicDungeonPolygonElement", package.seeall)

local AtomicDungeonPolygonElement = class("AtomicDungeonPolygonElement", LuaCompBase)
local BOX_COLLIDER_SIZE = Vector2(150, 150)

function AtomicDungeonPolygonElement:ctor(param)
	self.config = param[1]
	self.mainCamera = param[2]
	self.sceneElements = param[3]
	self.type = self.config.type
	self.touchKeyElementMap = {}
	self.keyPointItemList = {}
	self.isHasSendFinishRequest = false
end

function AtomicDungeonPolygonElement:init(go)
	self.go = go
	self.trans = self.go.transform
	self.itemRootMap = self:getUserDataTb_()

	for rootType, rootUrl in pairs(AtomicDungeonEnum.PolygonElementTypeRoot) do
		local itemRoot = self.itemRootMap[rootType]

		if not itemRoot then
			itemRoot = {
				go = gohelper.findChild(self.go, "#go_" .. rootUrl)
			}
			itemRoot.bg = gohelper.findChild(itemRoot.go, "bg")
			itemRoot.finishBg = gohelper.findChild(itemRoot.go, "finishBg")
			itemRoot.icon = gohelper.findChildImage(itemRoot.go, "icon")
			itemRoot.anim = itemRoot.go:GetComponent(gohelper.Type_Animator)
			itemRoot.goNormalFinish = gohelper.findChild(itemRoot.go, "#go_NormalFinish")
			itemRoot.goKeyTouch = gohelper.findChild(itemRoot.go, "#go_KeyTouch")
			itemRoot.iconCanvasGroup = itemRoot.icon:GetComponent(gohelper.Type_CanvasGroup)
			itemRoot.goSelect = gohelper.findChild(itemRoot.go, "#go_Select")
			self.itemRootMap[rootType] = itemRoot
		end
	end

	self.goBoss = gohelper.findChild(self.go, "#go_boss")
	self.goKey = gohelper.findChild(self.go, "#go_key")
	self.imageBoss = gohelper.findChildImage(self.goBoss, "icon")
	self.animBoss = self.goBoss:GetComponent(gohelper.Type_Animator)
	self.goBossFinish = gohelper.findChild(self.goBoss, "#go_BossFinish")
	self.goBossBg = gohelper.findChild(self.goBoss, "bg")
	self.goBossFinishBg = gohelper.findChild(self.goBoss, "finishBg")
	self.goBossSelect = gohelper.findChild(self.goBoss, "#go_BossSelect")
	self.bossIconCanvasGroup = self.imageBoss:GetComponent(gohelper.Type_CanvasGroup)
	self.gotxten = gohelper.findChild(self.go, "#go_txten")
	self._goName = gohelper.findChild(self.go, "#go_name")
	self._txtName = gohelper.findChildText(self.go, "#go_name/#txt_name")
	self._goKeyPointContent = gohelper.findChild(self.go, "#go_keyDoor/#go_keyPointContent")
	self._goKeyPointItem = gohelper.findChild(self.go, "#go_keyDoor/#go_keyPointContent/#go_keyPointItem")

	self.addBoxColliderListener(self.go, self.onClickDown, self)

	local allElementCoList = AtomicDungeonConfig.instance:getMapAllElementCoList(self.config.mapId)

	self.firstElementCo = allElementCoList[1]

	gohelper.setActive(self.gotxten, self.firstElementCo.id == self.config.id)
	gohelper.setActive(self.goKey, false)
	gohelper.setActive(self.itemRootMap[self.type].goKeyTouch, false)
	gohelper.setActive(self._goKeyPointItem, false)
	gohelper.setActive(self.goBossSelect, false)
	gohelper.setActive(self.itemRootMap[self.type].goSelect, false)
	self.addEventCb(self, AtomicDungeonController.instance, AtomicDungeonEvent.OnInitTouchKeyElement, self.refreshKeyTouch, self)
	self:updateInfo()
	self:setName()
	self:checkDoorNotFinishButKeyFull()
end

function AtomicDungeonPolygonElement.addBoxColliderListener(go, callback, callbackTarget)
	gohelper.addBoxCollider2D(go, BOX_COLLIDER_SIZE)

	local clickListener = ZProj.BoxColliderClickListener.Get(go)

	clickListener:SetIgnoreUI(true)
	clickListener:AddClickListener(callback, callbackTarget)
end

function AtomicDungeonPolygonElement:onClickDown()
	self.sceneElements:onElementClickDown(self)
	AudioMgr.instance:trigger(AudioEnum3_10.Outside.play_ui_common_click)
end

function AtomicDungeonPolygonElement:addEventListeners()
	self.addEventCb(self, AtomicDungeonController.instance, AtomicDungeonEvent.OnDraggingPolygonKeyElement, self.OnDraggingPolygonKeyElement, self)
	self.addEventCb(self, AtomicDungeonController.instance, AtomicDungeonEvent.OnDragEndPolygonKeyElement, self.OnDragEndPolygonKeyElement, self)
	self.addEventCb(self, AtomicDungeonController.instance, AtomicDungeonEvent.OnPolygonKeyElementFinish, self.onKeyElementFinish, self)
end

function AtomicDungeonPolygonElement:removeEventListeners()
	self.removeEventCb(self, AtomicDungeonController.instance, AtomicDungeonEvent.OnInitTouchKeyElement, self.refreshKeyTouch, self)
	self.removeEventCb(self, AtomicDungeonController.instance, AtomicDungeonEvent.OnDraggingPolygonKeyElement, self.OnDraggingPolygonKeyElement, self)
	self.removeEventCb(self, AtomicDungeonController.instance, AtomicDungeonEvent.OnDragEndPolygonKeyElement, self.OnDragEndPolygonKeyElement, self)
	self.removeEventCb(self, AtomicDungeonController.instance, AtomicDungeonEvent.OnPolygonKeyElementFinish, self.onKeyElementFinish, self)
end

function AtomicDungeonPolygonElement:updateInfo()
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

	local isFinish = AtomicDungeonModel.instance:isElementFinish(self.config.id)

	if self.type == AtomicDungeonEnum.ElementType.Fight then
		local fightElementConfig = AtomicDungeonConfig.instance:getFightElementConfig(self.config.id)

		gohelper.setActive(self.itemRootMap[self.type].go, fightElementConfig.showType ~= AtomicDungeonEnum.FightType.PolygonBoss)
		gohelper.setActive(self.goBoss, fightElementConfig.showType == AtomicDungeonEnum.FightType.PolygonBoss)
		UISpriteSetMgr.instance:setSp02AtomicDungeonElementSprite(self.imageBoss, self.config.icon)
		gohelper.setActive(self.itemRootMap[self.type].goNormalFinish, isFinish and fightElementConfig.showType ~= AtomicDungeonEnum.FightType.PolygonBoss)
		gohelper.setActive(self.itemRootMap[self.type].bg, not isFinish and fightElementConfig.showType ~= AtomicDungeonEnum.FightType.PolygonBoss)
		gohelper.setActive(self.itemRootMap[self.type].finishBg, isFinish and fightElementConfig.showType ~= AtomicDungeonEnum.FightType.PolygonBoss)
		gohelper.setActive(self.goBossFinish, isFinish and fightElementConfig.showType == AtomicDungeonEnum.FightType.PolygonBoss)
		gohelper.setActive(self.goBossBg, not isFinish and fightElementConfig.showType == AtomicDungeonEnum.FightType.PolygonBoss)
		gohelper.setActive(self.goBossFinishBg, isFinish and fightElementConfig.showType == AtomicDungeonEnum.FightType.PolygonBoss)

		self.bossIconCanvasGroup.alpha = isFinish and 0.5 or 1
		self.itemRootMap[self.type].iconCanvasGroup.alpha = isFinish and 0.5 or 1
	else
		gohelper.setActive(self.goBoss, false)
		gohelper.setActive(self.itemRootMap[self.type].goNormalFinish, isFinish)
		gohelper.setActive(self.itemRootMap[self.type].bg, not isFinish)
		gohelper.setActive(self.itemRootMap[self.type].finishBg, isFinish)
		gohelper.setActive(self.goBossFinish, false)

		self.itemRootMap[self.type].iconCanvasGroup.alpha = isFinish and 0.5 or 1
	end

	UISpriteSetMgr.instance:setSp02AtomicDungeonElementSprite(self.itemRootMap[self.type].icon, self.config.icon)
	self:refreshKeyPoint()
end

function AtomicDungeonPolygonElement:checkDoorNotFinishButKeyFull()
	if self.isHasSendFinishRequest then
		return
	end

	local elementMo = AtomicDungeonModel.instance:getElementMo(self.config.id)
	local isAllKeyElementPut = elementMo:checkIsAllKeyElementPut()
	local isElementFinish = AtomicDungeonModel.instance:isElementFinish(self.config.id)

	if isAllKeyElementPut and not isElementFinish and self.type == AtomicDungeonEnum.ElementType.KeyDoor then
		AtomicRpc.instance:sendAtomicMapInteractRequest(self.config.id, {})

		local elementData = AtomicDungeonModel.instance:getElementStatData(self.config.id)

		AtomicDungeonStatHelper.instance:sendElementInteractInfo(elementData)

		self.isHasSendFinishRequest = true
	end
end

function AtomicDungeonPolygonElement:setName()
	if self.type == AtomicDungeonEnum.ElementType.Option then
		local optionElementConfig = AtomicDungeonConfig.instance:getOptionElementConfig(self.config.id, 1)

		self._txtName.text = optionElementConfig.title
	elseif self.type == AtomicDungeonEnum.ElementType.Fight then
		local fightElementConfig = AtomicDungeonConfig.instance:getFightElementConfig(self.config.id)

		self._txtName.text = fightElementConfig.title
	elseif self.type == AtomicDungeonEnum.ElementType.Puzzle then
		local puzzleData = string.splitToNumber(self.config.parm, "#")
		local puzzleConfig

		if puzzleData[1] == AtomicDungeonEnum.PuzzleType.Line then
			puzzleConfig = AtomicDungeonConfig.instance:getLineGameConfig(puzzleData[2])
		elseif puzzleData[1] == AtomicDungeonEnum.PuzzleType.Color then
			puzzleConfig = AtomicDungeonConfig.instance:getColorGameConfig(puzzleData[2])
		elseif puzzleData[1] == AtomicDungeonEnum.PuzzleType.Rhythm then
			puzzleConfig = AtomicDungeonConfig.instance:getRhythmGameConfig(puzzleData[2])
		end

		self._txtName.text = puzzleConfig.title
	elseif self.type == AtomicDungeonEnum.ElementType.KeyDoor then
		local doorElementConfig = AtomicDungeonConfig.instance:getDoorElementConfig(self.config.id)

		self._txtName.text = doorElementConfig.title
	end
end

function AtomicDungeonPolygonElement:refreshKeyPoint()
	if self.type ~= AtomicDungeonEnum.ElementType.KeyDoor then
		return
	end

	local elementMo = AtomicDungeonModel.instance:getElementMo(self.config.id)

	if elementMo then
		local keyPointDataList = {}
		local curKeyElementDataMap = elementMo:getCurKeyElementDataMap()

		for _, keyElementData in pairs(curKeyElementDataMap) do
			table.insert(keyPointDataList, keyElementData)
		end

		table.sort(keyPointDataList, function(a, b)
			if a.isPut ~= b.isPut then
				return a.isPut
			else
				return a.index < b.index
			end
		end)

		for index, keyElementData in ipairs(keyPointDataList) do
			local pointItem = self.keyPointItemList[index]

			if not pointItem then
				pointItem = {
					go = gohelper.clone(self._goKeyPointItem, self._goKeyPointContent, "pointItem_" .. keyElementData.id)
				}
				pointItem.goNormal = gohelper.findChild(pointItem.go, "go_normal")
				pointItem.goLight = gohelper.findChild(pointItem.go, "go_light")
				pointItem.keyElementData = keyElementData
				self.keyPointItemList[index] = pointItem
			end

			gohelper.setActive(pointItem.go, true)
			gohelper.setActive(pointItem.goNormal, not keyElementData.isPut)
			gohelper.setActive(pointItem.goLight, keyElementData.isPut)
		end

		for index = #keyPointDataList + 1, #self.keyPointItemList do
			local pointItem = self.keyPointItemList[index]

			gohelper.setActive(pointItem.go, false)
		end
	end
end

function AtomicDungeonPolygonElement:OnDraggingPolygonKeyElement(curKeyElementId, touchElementList)
	self.touchKeyElementMap[curKeyElementId] = nil

	self:refreshKeyTouch(curKeyElementId, touchElementList)
end

function AtomicDungeonPolygonElement:OnDragEndPolygonKeyElement(curKeyElementId, touchElementList)
	if self.touchKeyElementMap[curKeyElementId] then
		local elementMo = AtomicDungeonModel.instance:getElementMo(self.config.id)
		local curKeyElementDataMap = elementMo:getCurKeyElementDataMap()

		if curKeyElementDataMap[curKeyElementId] then
			if curKeyElementDataMap[curKeyElementId].isPut then
				return
			else
				elementMo:setKeyElementDataPutState(curKeyElementId, true)

				local recordStr = elementMo:getSaveKeyElementDataStr()

				AtomicRpc.instance:sendAtomicMapSaveElementRequest(self.config.id, recordStr)
				AudioMgr.instance:trigger(AudioEnum3_10.Outside.play_ui_gudu_bubble_click)
			end
		else
			self:playAnim("error")
			AudioMgr.instance:trigger(AudioEnum3_10.Outside.play_ui_mistakes)
		end

		local toastConfig = AtomicDungeonConfig.instance:getDragElementToastConfig(curKeyElementId, self.config.id)

		if toastConfig then
			GameFacade.showToastString(toastConfig.toast)
		end

		self:refreshKeyPoint()
	end
end

function AtomicDungeonPolygonElement:refreshKeyTouch(curKeyElementId, touchElementList)
	for index, touchElementId in pairs(touchElementList) do
		if touchElementId == self.config.id then
			self.touchKeyElementMap[curKeyElementId] = curKeyElementId
		end
	end

	local isTouchKey = tabletool.len(self.touchKeyElementMap) > 0

	gohelper.setActive(self.itemRootMap[self.type].goKeyTouch, isTouchKey)
end

function AtomicDungeonPolygonElement:onKeyElementFinish(curKeyElementId)
	self.touchKeyElementMap[curKeyElementId] = nil

	local isTouchKey = tabletool.len(self.touchKeyElementMap) > 0

	gohelper.setActive(self.itemRootMap[self.type].goKeyTouch, isTouchKey)
	self:refreshKeyPoint()
end

function AtomicDungeonPolygonElement:needShowArrow()
	return self.config.needFollow == 1
end

function AtomicDungeonPolygonElement:playShowOrHideAnim(show)
	if self.showState == show then
		return
	end

	self.showState = show

	self:playAnim(show and "open" or "close")
end

function AtomicDungeonPolygonElement:playAnim(animName)
	if animName == "open" then
		AudioMgr.instance:trigger(AudioEnum3_10.Outside.play_ui_langchao_icon_emerge)
	elseif animName == "close" then
		AudioMgr.instance:trigger(AudioEnum3_10.Outside.play_ui_langchao_icon_disappear)
	end

	if self.type == AtomicDungeonEnum.ElementType.Fight then
		local fightElementConfig = AtomicDungeonConfig.instance:getFightElementConfig(self.config.id)

		if fightElementConfig and fightElementConfig.showType == AtomicDungeonEnum.FightType.PolygonBoss then
			self.animBoss:Play(animName, 0, 0)
			self.animBoss:Update(0)

			return
		end
	end

	self.itemRootMap[self.type].anim:Play(animName, 0, 0)
	self.itemRootMap[self.type].anim:Update(0)
end

function AtomicDungeonPolygonElement:setSelectState(isSelect)
	if self.type == AtomicDungeonEnum.ElementType.Fight then
		local fightElementConfig = AtomicDungeonConfig.instance:getFightElementConfig(self.config.id)

		gohelper.setActive(self.goBossSelect, isSelect and fightElementConfig.showType == AtomicDungeonEnum.FightType.PolygonBoss)
		gohelper.setActive(self.itemRootMap[self.type].goSelect, isSelect and fightElementConfig.showType ~= AtomicDungeonEnum.FightType.PolygonBoss)
	else
		gohelper.setActive(self.goBossSelect, false)
		gohelper.setActive(self.itemRootMap[self.type].goSelect, isSelect)
	end
end

function AtomicDungeonPolygonElement:setNameShowState(state)
	gohelper.setActive(self._goName, state)
end

function AtomicDungeonPolygonElement:onDestroy()
	return
end

return AtomicDungeonPolygonElement
