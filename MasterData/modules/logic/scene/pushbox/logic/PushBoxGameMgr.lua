-- chunkname: @modules/logic/scene/pushbox/logic/PushBoxGameMgr.lua

module("modules.logic.scene.pushbox.logic.PushBoxGameMgr", package.seeall)

local PushBoxGameMgr = class("PushBoxGameMgr", BaseSceneComp)

PushBoxGameMgr.Direction = {
	Down = 2,
	Up = 1,
	Left = 3,
	Right = 4
}
PushBoxGameMgr.ElementType = {
	WallPicUp2 = 52,
	Goal = 0,
	Enemy = 6,
	WallLeft = 54,
	WallCornerTopRight = 72,
	WallUp = 50,
	WallUpDoublePic2 = 58,
	WallUpDoublePic1 = 57,
	WallCornerBottomRight = 74,
	Road = 5,
	Box = 2,
	WallRight2 = 56,
	Fan = 4,
	LightRight = 43,
	WallCornerBottomLeft = 73,
	WallCornerTopLeft = 71,
	Mechanics = 3,
	WallPicUp1 = 51,
	WallRight = 53,
	WallLeft2 = 55,
	LightLeft = 42,
	Character = 7,
	LightDown = 41,
	LightUp = 40,
	Empty = 1
}

function PushBoxGameMgr:onInit()
	return
end

function PushBoxGameMgr:setCharacterPos(x, y, direction)
	self.character:setPos(x, y, direction)
end

function PushBoxGameMgr:stepOver()
	if self:detectGameOver() then
		return
	end

	self.step_data:markStepData()

	local stranding_cell = self:getCell(self.character:getPosX(), self.character:getPosY())

	if stranding_cell:getCellType() == PushBoxGameMgr.ElementType.Goal and stranding_cell:doorIsOpend() then
		self._isFinish = true
		PushBoxGameMgr.finishNewEpisode = not PushBoxModel.instance:getPassData(self:getCurStageID()) and true or PushBoxModel.instance:getPassData(self:getCurStageID()).state == 0

		PushBoxController.instance:registerCallback(PushBoxEvent.DataEvent.FinishEpisodeReply, self._onFinishEpisodeReply, self)
		PushBoxRpc.instance:sendFinishEpisodeRequest(PushBoxModel.instance:getCurActivityID(), self:getCurStageID(), self.step_data:getStepCount(), self.data:getCurWarning())
	end
end

function PushBoxGameMgr:_onFinishEpisodeReply(resultCode)
	if resultCode == 0 then
		PushBoxController.instance:dispatchEvent(PushBoxEvent.GameWin, self.data:getCurWarning())
	end
end

function PushBoxGameMgr:detectGameOver()
	if self._isFinish then
		return
	end

	if self.data:gameOver() then
		PushBoxController.instance:dispatchEvent(PushBoxEvent.GameOver)

		return true
	end

	return false
end

function PushBoxGameMgr:revertStep()
	self._reverting = true

	self.step_data:_onRevertStep()

	self._reverting = false

	PushBoxController.instance:dispatchEvent(PushBoxEvent.RefreshWarningNum, self:getCurWarning())
end

function PushBoxGameMgr:revertGame()
	if self.step_data:getStepCount() == 0 then
		GameFacade.showToast(ToastEnum.PushBoxGame)

		return
	end

	self:onSceneClose()
	self:onSceneStart()
	self:startGame(self:getCurStageID())
	PushBoxController.instance:dispatchEvent(PushBoxEvent.RefreshWarningNum, self:getCurWarning())
end

function PushBoxGameMgr:getCurWarning()
	return self.data:getCurWarning()
end

function PushBoxGameMgr:changeWarning(num)
	if self._reverting then
		return
	end

	local cur_cell = self:getCell(self.character:getPosX(), self.character:getPosY())

	if cur_cell:getCellType() == PushBoxGameMgr.ElementType.Fan then
		return
	end

	self.data:changeWarning(num)
	PushBoxController.instance:dispatchEvent(PushBoxEvent.RefreshWarningNum, self:getCurWarning())
end

function PushBoxGameMgr:setWarning(num)
	self.data:setWarning(num)
end

function PushBoxGameMgr:setCellInvincible(state, x, y)
	local cell_list = self.cell_mgr._cell_list

	for i, cell in ipairs(cell_list) do
		if math.abs(x - cell:getPosX()) <= 1 and math.abs(y - cell:getPosY()) <= 1 then
			cell:setCellInvincible(state)
		end
	end

	if not state then
		PushBoxController.instance:dispatchEvent(PushBoxEvent.RefreshFanElement)
		PushBoxController.instance:dispatchEvent(PushBoxEvent.StepFinished)
		self:detectGameOver()
	end
end

function PushBoxGameMgr:cellIsInvincible(x, y)
	return self:getCell(x, y):getInvincible()
end

function PushBoxGameMgr:characterInArea(pos_x, pos_y)
	if pos_x == self.character:getPosX() and pos_y == self.character:getPosY() then
		return true
	end
end

function PushBoxGameMgr:cellHasBox(pos_x, pos_y)
	local cell = self:getCell(pos_x, pos_y)

	return cell:getBox()
end

function PushBoxGameMgr:pushBox(from_x, from_y, to_x, to_y)
	self.cell_mgr:pushBox(from_x, from_y, to_x, to_y)
end

function PushBoxGameMgr:_onMove(direction)
	self.character:move(direction)
end

function PushBoxGameMgr:getCell(x, y)
	return self.cell_mgr:getCell(x, y)
end

function PushBoxGameMgr:getElement(element_type, pos_x, pos_y)
	return self.cell_mgr:getElement(element_type, pos_x, pos_y)
end

function PushBoxGameMgr:outOfBounds(x, y)
	return not self.cell_mgr:getCell(x, y)
end

function PushBoxGameMgr:detectCellData()
	self.cell_mgr:detectCellData()
end

function PushBoxGameMgr:getElementLogicList(element_type)
	return self.cell_mgr._element_logic[element_type] or {}
end

function PushBoxGameMgr:getEnemyIndex(enemy_item)
	local list = self:getElementLogicList(PushBoxGameMgr.ElementType.Enemy)
	local index = 0

	for i, v in ipairs(list) do
		index = index + 1

		if enemy_item == v then
			return index
		end
	end

	return index
end

function PushBoxGameMgr:typeIsLight(cell_type)
	return cell_type == PushBoxGameMgr.ElementType.LightUp or cell_type == PushBoxGameMgr.ElementType.LightDown or cell_type == PushBoxGameMgr.ElementType.LightLeft or cell_type == PushBoxGameMgr.ElementType.LightRight
end

function PushBoxGameMgr:typeIsDoor(cell_type)
	return cell_type == PushBoxGameMgr.ElementType.Goal
end

function PushBoxGameMgr:typeIsEnemy(cell_type)
	return cell_type == PushBoxGameMgr.ElementType.Enemy
end

function PushBoxGameMgr:typeIsCharacter(cell_type)
	return cell_type == PushBoxGameMgr.ElementType.Character
end

function PushBoxGameMgr:typeIsMechanics(cell_type)
	return cell_type == PushBoxGameMgr.ElementType.Mechanics
end

function PushBoxGameMgr:getConfig()
	return PushBoxEpisodeConfig.instance:getConfig(self._stage_id)
end

function PushBoxGameMgr:onSceneStart(sceneId, levelId)
	PushBoxController.instance:registerCallback(PushBoxEvent.Move, self._onMove, self)

	self._scene = self:getCurScene()
	self._scene_root = self._scene:getSceneContainerGO()
end

function PushBoxGameMgr:onSceneClose()
	self:releaseComs()
	PushBoxController.instance:unregisterCallback(PushBoxEvent.Move, self._onMove, self)
	PushBoxController.instance:unregisterCallback(PushBoxEvent.DataEvent.FinishEpisodeReply, self._onFinishEpisodeReply, self)
end

function PushBoxGameMgr:releaseComs()
	if self.cell_mgr then
		self.cell_mgr:releaseSelf()

		self.cell_mgr = nil
	end

	if self.character then
		self.character:releaseSelf()

		self.character = nil
	end

	if self.step_data then
		self.step_data:releaseSelf()

		self.step_data = nil
	end

	if self.data then
		self.data:releaseSelf()

		self.data = nil
	end
end

function PushBoxGameMgr:getCurStageID()
	return self._stage_id
end

function PushBoxGameMgr:initComs()
	self.cell_mgr = PushBoxCellMgr.New(self)
	self.character = PushBoxCharacter.New(self)
	self.step_data = PushBoxStepDataMgr.New(self)
	self.data = PushBoxDataMgr.New(self)
end

function PushBoxGameMgr:playOpenAni()
	self._scene_root.transform:GetChild(0):GetComponent(typeof(UnityEngine.Animator)):Play("open", 0, 0)
end

function PushBoxGameMgr:hideRoot()
	gohelper.setActive(self._scene_root.transform:GetChild(0).gameObject, false)
end

function PushBoxGameMgr:gameIsFinish()
	return self._isFinish
end

function PushBoxGameMgr:startGame(stage_id)
	self._isFinish = nil

	self:releaseComs()
	self:initComs()

	self._stage_id = stage_id

	self.cell_mgr:init()
	self.character:init()
	self.step_data:init()
	self.data:init()
	PushBoxController.instance:dispatchEvent(PushBoxEvent.StartElement)
end

return PushBoxGameMgr
