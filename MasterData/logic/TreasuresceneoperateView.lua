-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/treasureraider/view/TreasuresceneoperateView.lua

module("logic.extensions.treasureraider.view.TreasuresceneoperateView", package.seeall)

local TreasuresceneoperateView = class("TreasuresceneoperateView", ViewComponent)
local OpButtonsLocalPos = {
	[2] = {
		{
			12.5,
			114.7
		},
		{
			218.8,
			114.7
		}
	},
	[3] = {
		{
			12.5,
			114.7
		},
		{
			117,
			149.2
		},
		{
			218.8,
			114.7
		}
	}
}
local OpUse = {
	[TRPopMenuController.Op_View] = 3,
	[TRPopMenuController.Op_Upgrade] = 1,
	[TRPopMenuController.Op_Reconstruct] = 2
}

function TreasuresceneoperateView:ctor()
	TreasuresceneoperateView.super.ctor(self)
end

function TreasuresceneoperateView:unbindEvents()
	TreasuresceneoperateView.super.unbindEvents(self)

	for i = 1, #self._gridOpBtns do
		GameUtil.rmClickHandler(self._gridOpBtns[i].button)
	end
end

function TreasuresceneoperateView:bindEvents()
	TreasuresceneoperateView.super.bindEvents(self)

	for i = 1, #self._gridOpBtns do
		GameUtil.addClickHandler(self._gridOpBtns[i].button, GameUtil.handler(self._onClickGridOp, self, i))
	end

	GameUtil.addClickHandler(self._BtnGM, GameUtil.handler(self._onClickGMJump, self))
end

function TreasuresceneoperateView:buildUI()
	TreasuresceneoperateView.super.buildUI(self)

	self._gridOpBtnsNode = self:getGo("gridOpBtns")
	self._gridOpBtns = {}

	for i = 1, 4 do
		local btnConfig = {}

		btnConfig.button = goutil.findChild(self._gridOpBtnsNode, "Btn" .. i)
		btnConfig.btnText = goutil.findChildTextComponent(btnConfig.button.gameObject, "Text")
		self._gridOpBtns[i] = btnConfig
	end

	self._BtnGM = self:getGo("gridOpBtns/BtnGM")

	GameUtil.SetActive(self._BtnGM, false)
end

function TreasuresceneoperateView:onExit()
	TreasuresceneoperateView.super.onExit(self)
	TRPopMenuController.instance:setOpViewShowing(-1, -1)
	GlobalDispatcher:removeListener(GlobalNotify.TreasureRaiderZoomStateChange, self._onZoomUpdate, self)
end

function TreasuresceneoperateView:onEnter()
	TreasuresceneoperateView.super.onEnter(self)
	self._gridOpBtnsNode:SetActive(true)

	local params = self:getOpenParam()

	self._opTypeMap = {}
	self._opTypes = self:_filterTypes(checktable(params[1]))
	self._opPosX = checknumber(params[2])
	self._opPosY = checknumber(params[3])
	self._opGridX = checknumber(params[4])
	self._opGridY = checknumber(params[5])
	self._gridId = checknumber(params[6])

	self:_showOpBtns()
	self:_setupBtnsFollowTargets()
	GameUtil.SetActive(self._BtnGM, false)
	GlobalDispatcher:addListener(GlobalNotify.TreasureRaiderZoomStateChange, self._onZoomUpdate, self)
end

function TreasuresceneoperateView:_filterTypes(types)
	local result = {}

	for i, v in ipairs(types) do
		if OpUse[v] then
			table.insert(result, v)
		end
	end

	return result
end

function TreasuresceneoperateView:_onServerPositionUpdated()
	return
end

function TreasuresceneoperateView:_showOpBtns()
	local len = #self._opTypes
	local posGroup = OpButtonsLocalPos[len]

	for i = 1, 4 do
		local btnConfig = self._gridOpBtns[i]

		GameUtil.SetActive(btnConfig.button, false)
	end

	for i = 1, len do
		local opType = self._opTypes[i]
		local btnConfig = self._gridOpBtns[OpUse[opType]]

		btnConfig.btnText.text = TRPopMenuController.OpNames[opType]

		GameUtil.SetActive(btnConfig.button, true)

		self._opTypeMap[OpUse[opType]] = opType

		local pos = posGroup[i]

		if pos then
			GameUtil.setLocalPos(btnConfig.button, pos[1], pos[2], 0)
		end
	end
end

function TreasuresceneoperateView:_setupBtnsFollowTargets()
	local scene = SceneMgr.instance:getCurScene()
	local tool = TreasureRaiderSceneModel.instance
	local gridX, gridY = tool:pos2Grid(self._opPosX, self._opPosY)

	TRPopMenuController.instance:setOpViewShowing(gridX, gridY)

	local elementId = tool:getElementIdByGridId(SeasonLayerTypes.LAYER_GROUND_DOWN, self._gridId)

	if elementId ~= nil and elementId > 0 then
		local unit = scene.unitFactory:getUnit(UnitTag.SceneElement, elementId)

		if unit then
			local followCom = self._gridOpBtnsNode:GetComponent(ComponentType.UIFollowTarget)

			if not followCom then
				followCom = self._gridOpBtnsNode:AddComponent(ComponentType.UIFollowTarget)

				local mainCamera = CameraTargetMgr.instance:getMainCameraTarget()

				followCom.uiCamera = GlobalModel.instance.uiCamera
				followCom.gameCamera = mainCamera:getCamera()
				followCom.canvas = UGUIToolHelper.FindCanvas(self._gridOpBtnsNode)
			end

			followCom.target = unit.go.transform
			followCom.enabled = true
			followCom.offsetY3D = 0

			if scene and scene.animation and scene.animation.getZoomType then
				self:_onZoomUpdate(scene.animation:getZoomType())
			end

			followCom:LateUpdate()
		end
	end
end

function TreasuresceneoperateView:_onZoomUpdate(zoomType)
	if self._gridOpBtnsNode then
		local followCom = self._gridOpBtnsNode:GetComponent(ComponentType.UIFollowTarget)

		if followCom then
			followCom.offsetX3D = SceneCompTreasureRaiderAnimation.ZoomIn == zoomType and -1.08 or -1.45
		end
	end
end

function TreasuresceneoperateView:_onClickGridOp(index)
	if self._opTypes then
		local opType = self._opTypeMap[index]

		TRPopMenuController.instance:handle(opType, self._opPosX, self._opPosY, self._opGridX, self._opGridY, self._gridId)
	end

	self:close()
end

function TreasuresceneoperateView:_onClickGMJump()
	self:close()
end

return TreasuresceneoperateView
