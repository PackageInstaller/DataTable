-- chunkname: @modules/logic/dungeon/view/puzzle/DungeonPuzzleCircuit.lua

module("modules.logic.dungeon.view.puzzle.DungeonPuzzleCircuit", package.seeall)

local DungeonPuzzleCircuit = class("DungeonPuzzleCircuit", BaseView)

function DungeonPuzzleCircuit:onInitView()
	self._gocube = gohelper.findChild(self.viewGO, "#go_basepoint/#go_cube")
	self._gobasepoint = gohelper.findChild(self.viewGO, "#go_basepoint")
	self._goclick = gohelper.findChild(self.viewGO, "#go_click")
	self._btnreset = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_reset")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function DungeonPuzzleCircuit:addEvents()
	self._click:AddClickListener(self._onClick, self)
	self._btnreset:AddClickListener(self._btnresetOnClick, self)
	self.addEventCb(self, DungeonPuzzleCircuitController.instance, DungeonPuzzleEvent.CircuitClick, self._onGuideClick, self)
end

function DungeonPuzzleCircuit:removeEvents()
	self._click:RemoveClickListener()
	self._btnreset:RemoveClickListener()
	self.removeEventCb(self, DungeonPuzzleCircuitController.instance, DungeonPuzzleEvent.CircuitClick, self._onGuideClick, self)
end

function DungeonPuzzleCircuit:_btnresetOnClick()
	if self._rule:isWin() then
		GameFacade.showToast(ToastEnum.DungeonPuzzle)

		return
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.DungeonPuzzleResetGame, MsgBoxEnum.BoxType.Yes_No, function()
		self:_resetGame()
	end)
end

function DungeonPuzzleCircuit:_resetGame()
	for x = 1, self._gameHeight do
		for y = 1, self._gameWidth do
			local mo = DungeonPuzzleCircuitModel.instance:getData(x, y)

			if mo then
				mo.value = mo.rawValue

				self:_syncRotation(x, y, mo)
			end
		end
	end

	self._rule:refreshAllConnection()
	self:_refreshAllConnectionStatus()
end

function DungeonPuzzleCircuit:_editableInitView()
	self:initConst()

	self._touch = TouchEventMgrHepler.getTouchEventMgr(self._gobasepoint)

	self._touch:SetOnlyTouch(true)
	self._touch:SetIgnoreUI(true)
	self._touch:SetOnClickCb(self._onClickContainer, self)

	self._click = SLFramework.UGUI.UIClickListener.Get(self._goclick)
	self._rule = DungeonPuzzleCircuitRule.New()

	local finishGo = gohelper.findChild(self.viewGO, "biaopan")

	self._animator = finishGo:GetComponent(typeof(UnityEngine.Animator))
	self._capacitanceEffectList = {}
end

function DungeonPuzzleCircuit:initConst()
	self._itemSizeX = 109
	self._itemSizeY = 109
	self._gameWidth, self._gameHeight = DungeonPuzzleCircuitModel.instance:getGameSize()
end

function DungeonPuzzleCircuit:onUpdateParam()
	return
end

function DungeonPuzzleCircuit:onOpen()
	self._gridObjs = {}

	for x = 1, self._gameHeight do
		for y = 1, self._gameWidth do
			self._gridObjs[x] = self._gridObjs[x] or {}

			self:addNewItem(x, y)
		end
	end

	self._rule:refreshAllConnection()
	self:_refreshAllConnectionStatus()
end

function DungeonPuzzleCircuit:addNewItem(x, y)
	self:initItem(x, y)
end

function DungeonPuzzleCircuit:_newPipeItem(x, y)
	if self._gridObjs[x][y] then
		return
	end

	local itemGo = gohelper.cloneInPlace(self._gocube, x .. "_" .. y)

	gohelper.setActive(itemGo, true)

	local rectTf = itemGo.transform
	local anchorX, anchorY = DungeonPuzzleCircuitModel.instance:getRelativePosition(x, y, self._itemSizeX, self._itemSizeY)

	recthelper.setAnchor(rectTf, anchorX, anchorY)

	local itemObj = self:getUserDataTb_()

	itemObj.go = itemGo
	itemObj.image = gohelper.findChildImage(itemGo, "icon")
	itemObj.imageTf = itemObj.image.transform
	itemObj.tf = rectTf
	itemObj.capacitanceEffect = gohelper.findChild(itemGo, "#vx_dianzu")
	itemObj.errorEffect = gohelper.findChild(itemGo, "error")
	self._gridObjs[x][y] = itemObj
end

function DungeonPuzzleCircuit:initItem(x, y)
	local mo = DungeonPuzzleCircuitModel.instance:getData(x, y)

	if not mo then
		return
	end

	self:_newPipeItem(x, y)

	local itemObj = self._gridObjs[x][y]

	if mo.type == 0 then
		gohelper.setActive(itemObj.go, false)

		return
	end

	gohelper.setActive(itemObj.go, true)

	local resConst = DungeonPuzzleCircuitEnum.res[mo.type]
	local path = resConst[1]

	UISpriteSetMgr.instance:setPuzzleSprite(itemObj.image, path, true)
	self:_syncRotation(x, y, mo)
end

function DungeonPuzzleCircuit:_getItem(mo)
	return self._gridObjs[mo.x][mo.y]
end

function DungeonPuzzleCircuit:_syncRotation(x, y, mo)
	local itemObj = self._gridObjs[x][y]
	local rotateConfig = DungeonPuzzleCircuitEnum.rotate[mo.type]

	if not rotateConfig then
		mo.value = 0

		transformhelper.setLocalRotation(itemObj.tf, 0, 0, 0)

		return
	end

	local config = rotateConfig[mo.value]

	if not config then
		for k, v in pairs(rotateConfig) do
			mo.value = k

			break
		end
	end

	config = rotateConfig[mo.value]

	local rotation = rotateConfig[mo.value][1]

	transformhelper.setLocalRotation(itemObj.tf, 0, 0, rotation)
end

function DungeonPuzzleCircuit:_onClick()
	self._isClick = true
end

function DungeonPuzzleCircuit:_onClickContainer(position)
	if not self._isClick then
		return
	end

	self._isClick = false

	if self._rule:isWin() then
		return
	end

	local tempPos = recthelper.screenPosToAnchorPos(position, self._gobasepoint.transform)
	local x, y = DungeonPuzzleCircuitModel.instance:getIndexByTouchPos(tempPos.x, tempPos.y, self._itemSizeX, self._itemSizeY)

	if x ~= -1 then
		self:_onClickGridItem(x, y)
	end
end

function DungeonPuzzleCircuit:_onGuideClick(param)
	local sp = string.splitToNumber(param, "_")

	self:_onClickGridItem(sp[1], sp[2])
end

function DungeonPuzzleCircuit:_onClickGridItem(x, y)
	local mo = DungeonPuzzleCircuitModel.instance:getData(x, y)

	if not mo then
		return
	end

	self._clickItemMo = mo

	AudioMgr.instance:trigger(AudioEnum.PuzzleCircuit.play_ui_circuit_click)
	self._rule:changeDirection(x, y, true)
	self._rule:refreshAllConnection()
	self:_syncRotation(x, y, mo)
	self:_checkAudio()
	self:_refreshAllConnectionStatus()

	if self._rule:isWin() then
		AudioMgr.instance:trigger(AudioEnum.PuzzleCircuit.play_ui_powersupply_connection)
		GameFacade.showToast(ToastEnum.DungeonPuzzle2)

		local elementCo = DungeonPuzzleCircuitModel.instance:getElementCo()

		DungeonRpc.instance:sendPuzzleFinishRequest(elementCo.id)
		self._animator:Play(UIAnimationName.Open)
	end
end

function DungeonPuzzleCircuit:_refreshAllConnectionStatus()
	self:_refreshItemsStatus(self._rule:getOldCircuitList(), DungeonPuzzleCircuitEnum.status.normal)
	self:_refreshItemsStatus(self._rule:getOldCapacitanceList(), DungeonPuzzleCircuitEnum.status.normal)
	self:_refreshItemsStatus(self._rule:getOldWrongList(), DungeonPuzzleCircuitEnum.status.normal)
	self:_refreshItemsStatus(self._rule:getCircuitList(), DungeonPuzzleCircuitEnum.status.correct)
	self:_refreshItemsStatus(self._rule:getCapacitanceList(), DungeonPuzzleCircuitEnum.status.correct)
	self:_refreshItemsStatus(self._rule:getWrongList(), DungeonPuzzleCircuitEnum.status.error)

	for k, itemObj in pairs(self._capacitanceEffectList) do
		gohelper.setActive(itemObj.capacitanceEffect, false)
		rawset(self._capacitanceEffectList, k, nil)
	end
end

function DungeonPuzzleCircuit:_checkAudio()
	if tabletool.len(self._rule:getCapacitanceList()) > tabletool.len(self._rule:getOldCapacitanceList()) then
		AudioMgr.instance:trigger(AudioEnum.PuzzleCircuit.play_ui_capacitors_connection)
		self._animator:Play("onece", 0, 0)
	end

	if tabletool.len(self._rule:getWrongList()) > tabletool.len(self._rule:getOldWrongList()) then
		AudioMgr.instance:trigger(AudioEnum.PuzzleCircuit.play_ui_circuit_shortcircuit)

		self._clickItemMo = nil
	end
end

function DungeonPuzzleCircuit:_refreshItemsStatus(list, status)
	if not list then
		return
	end

	for i, mo in pairs(list) do
		local itemObj = self:_getItem(mo)
		local resConst = DungeonPuzzleCircuitEnum.res[mo.type]
		local path = resConst[status]

		if path then
			UISpriteSetMgr.instance:setPuzzleSprite(itemObj.image, path, true)
		end

		if status == DungeonPuzzleCircuitEnum.status.normal then
			if mo.type == DungeonPuzzleCircuitEnum.type.capacitance then
				self._capacitanceEffectList[mo] = itemObj
			end

			gohelper.setActive(itemObj.errorEffect, false)
		elseif mo.type == DungeonPuzzleCircuitEnum.type.capacitance and status == DungeonPuzzleCircuitEnum.status.correct then
			gohelper.setActive(itemObj.capacitanceEffect, true)

			self._capacitanceEffectList[mo] = nil
		elseif status == DungeonPuzzleCircuitEnum.status.error and mo.type >= DungeonPuzzleCircuitEnum.type.straight and mo.type <= DungeonPuzzleCircuitEnum.type.t_shape then
			gohelper.setActive(itemObj.errorEffect, true)

			local _, _, z = transformhelper.getLocalRotation(itemObj.tf)

			transformhelper.setLocalRotation(itemObj.errorEffect.transform, 0, 0, -z)

			if self._clickItemMo == mo then
				AudioMgr.instance:trigger(AudioEnum.PuzzleCircuit.play_ui_circuit_shortcircuit)
			end
		end
	end
end

function DungeonPuzzleCircuit:_doEdit(x, y)
	local editIndex = DungeonPuzzleCircuitModel.instance:getEditIndex()

	if not editIndex or editIndex <= 0 then
		return false
	end

	local mo = DungeonPuzzleCircuitModel.instance:getData(x, y)

	if UnityEngine.Input.GetKey(UnityEngine.KeyCode.LeftAlt) then
		if not mo then
			return true
		end

		mo.type = 0

		self:initItem(x, y)

		return true
	end

	if not UnityEngine.Input.GetKey(UnityEngine.KeyCode.LeftShift) then
		return false
	end

	mo = mo or DungeonPuzzleCircuitModel.instance:_getMo(x, y)

	if editIndex >= DungeonPuzzleCircuitEnum.type.power1 and editIndex <= DungeonPuzzleCircuitEnum.type.t_shape then
		mo.type = editIndex

		self:initItem(x, y)
	end

	return true
end

function DungeonPuzzleCircuit:onClose()
	if self._touch then
		TouchEventMgrHepler.remove(self._touch)

		self._touch = nil
	end
end

function DungeonPuzzleCircuit:onDestroyView()
	return
end

return DungeonPuzzleCircuit
