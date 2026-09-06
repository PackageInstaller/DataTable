-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/treasureraider/view/TreasureraiderhexguideView.lua

module("logic.extensions.treasureraider.view.TreasureraiderhexguideView", package.seeall)

local TreasureraiderhexguideView = class("TreasureraiderhexguideView", ViewComponent)
local Slot2Index = {
	[0] = {
		4,
		2,
		5,
		8,
		7,
		6
	},
	{
		1,
		2,
		3,
		5,
		7,
		4
	}
}

function TreasureraiderhexguideView:ctor()
	TreasureraiderhexguideView.super.ctor(self)
end

function TreasureraiderhexguideView:unbindEvents()
	TreasureraiderhexguideView.super.unbindEvents(self)

	for i, btn in ipairs(self.btnList) do
		GameUtil.rmClickHandler(btn)
	end
end

function TreasureraiderhexguideView:bindEvents()
	TreasureraiderhexguideView.super.bindEvents(self)

	for i, btn in ipairs(self.btnList) do
		GameUtil.addClickHandler(btn, GameUtil.handler(self.onBtnClick, self, i))
	end
end

function TreasureraiderhexguideView:buildUI()
	TreasureraiderhexguideView.super.buildUI(self)

	self._hexagonuiholemaskobj = self:getGo("hexagonuiholemaskobj")
	self._moveNode = self:getGo("move")
	self.btnList = {}
	self.maskList = {}

	for i = 1, 6 do
		local btn = self:getGo("move/btn_" .. i)

		table.insert(self.btnList, btn)

		local mask = self:getGo("hexagonuiholemaskobj/HexagonUIHoleMask_" .. i)

		table.insert(self.maskList, mask)
	end
end

function TreasureraiderhexguideView:onExit()
	TreasureraiderhexguideView.super.onExit(self)
	removetimer(self.onTimer, self)
end

function TreasureraiderhexguideView:onEnter()
	TreasureraiderhexguideView.super.onEnter(self)

	local tool = TreasureRaiderSceneModel.instance
	local myPlayerMo = TreasureRaiderModel.instance:getCurSceneMo().myPlayerMo

	self._curGridId = myPlayerMo.serverGridId
	self._curGridX, self._curGridY = tool:id2Grid(self._curGridId)

	local array = tool:getCurGridNeighbourBuildingSlot(self._curGridId)
	local offset = self._curGridX % 2
	local slots = Slot2Index[offset]

	self._slotMap = {}

	for i, v in ipairs(array) do
		self._slotMap[v[4]] = v
	end

	for i = 1, 6 do
		local btn = self.btnList[i]
		local mask = self.maskList[i]
		local index = slots[i]
		local isNeeShow = self._slotMap[index] ~= nil

		GameUtil.SetActive(btn, isNeeShow)
		GameUtil.SetActive(mask, isNeeShow)
	end

	self:_setupBtnsFollowTargets()
end

function TreasureraiderhexguideView:onBtnClick(idx)
	local tool = TreasureRaiderSceneModel.instance
	local offset = self._curGridX % 2
	local slots = Slot2Index[offset]
	local index = slots[idx]
	local data = self._slotMap[index]
	local gridX, gridY, gridId = data[1], data[2], data[3]
	local posX, posY = tool:grid2Pos(gridX, gridY)

	GlobalDispatcher:dispatch(GlobalNotify.TreasureRaiderSelectPos, posX, posY, gridX, gridY)
	GuideController.instance:finishGuide()
	self:close()
end

function TreasureraiderhexguideView:_setupBtnsFollowTargets()
	local scene = SceneMgr.instance:getCurScene()
	local tool = TreasureRaiderSceneModel.instance
	local elementId = tool:getElementIdByGridId(SeasonLayerTypes.LAYER_GROUND_DOWN, self._curGridId)

	if elementId ~= nil and elementId > 0 then
		local unit = scene.unitFactory:getUnit(UnitTag.SceneElement, elementId)

		if unit then
			self:addFollowCom(unit, self._moveNode)
			removetimer(self.onTimer, self)
			settimer(0, self.onTimer, self, true)
		end
	end
end

function TreasureraiderhexguideView:onTimer()
	local x, y, z = Framework.TransformUtil.GetLocalPos(self._moveNode.transform, 0, 0, 0)

	Framework.TransformUtil.SetLocalPos(self._hexagonuiholemaskobj.transform, x, y, z)
end

function TreasureraiderhexguideView:addFollowCom(unit, node)
	local followCom = node:GetComponent(ComponentType.UIFollowTarget)

	if not followCom then
		followCom = node:AddComponent(ComponentType.UIFollowTarget)

		local mainCamera = CameraTargetMgr.instance:getMainCameraTarget()

		followCom.uiCamera = GlobalModel.instance.uiCamera
		followCom.gameCamera = mainCamera:getCamera()
		followCom.canvas = UGUIToolHelper.FindCanvas(node)
	end

	followCom.target = unit.go.transform
	followCom.enabled = true
	followCom.offsetX3D = -0.8
	followCom.offsetY3D = 0

	followCom:LateUpdate()
end

return TreasureraiderhexguideView
