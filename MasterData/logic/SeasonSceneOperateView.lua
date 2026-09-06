-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonSceneOperateView.lua

module("logic.extensions.season.view.SeasonSceneOperateView", package.seeall)

local SeasonSceneOperateView = class("SeasonSceneOperateView", ViewComponent)
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
	},
	[4] = {
		{
			12.5,
			114.7
		},
		{
			87,
			139.2
		},
		{
			157,
			139.2
		},
		{
			218.8,
			114.7
		}
	}
}
local OpUse = {
	[SeasonGridEvtModel.Op_View] = 1,
	[SeasonGridEvtModel.Op_Mark] = 2,
	[SeasonGridEvtModel.Op_UnMark] = 2,
	[SeasonGridEvtModel.Op_MoveTo] = 3,
	[SeasonGridEvtModel.Op_Open] = 3,
	[SeasonGridEvtModel.Op_Fight] = 4,
	[SeasonGridEvtModel.Op_Game] = 3,
	[SeasonGridEvtModel.Op_AutoFight] = 5,
	[SeasonGridEvtModel.Op_LaunchFire] = 6,
	[SeasonGridEvtModel.Op_RotateFire] = 7
}

function SeasonSceneOperateView:ctor()
	SeasonSceneOperateView.super.ctor(self)
end

function SeasonSceneOperateView:unbindEvents()
	SeasonSceneOperateView.super.unbindEvents(self)

	for i = 1, #self._gridOpBtns do
		GameUtil.rmClickHandler(self._gridOpBtns[i].button)
	end
end

function SeasonSceneOperateView:bindEvents()
	SeasonSceneOperateView.super.bindEvents(self)

	for i = 1, #self._gridOpBtns do
		GameUtil.addClickHandler(self._gridOpBtns[i].button, GameUtil.handler(self._onClickGridOp, self, i))
	end

	GameUtil.addClickHandler(self._BtnGM, GameUtil.handler(self._onClickGMJump, self))
end

function SeasonSceneOperateView:buildUI()
	SeasonSceneOperateView.super.buildUI(self)

	self._gridOpBtnsNode = self:getGo("gridOpBtns")
	self._gridOpBtns = {}

	for i = 1, 7 do
		local btnConfig = {}

		btnConfig.button = goutil.findChild(self._gridOpBtnsNode, "Btn" .. i)
		btnConfig.btnText = goutil.findChildTextComponent(btnConfig.button.gameObject, "Text")
		self._gridOpBtns[i] = btnConfig
	end

	self._BtnGM = self:getGo("gridOpBtns/BtnGM")

	GameUtil.SetActive(self._BtnGM, false)
end

function SeasonSceneOperateView:onExit()
	SeasonSceneOperateView.super.onExit(self)
	SeasonModel.instance:setOpViewShowing(-1, -1)
	GlobalDispatcher:removeListener(GlobalNotify.SeasonTeamServerPosUpdated, self._onServerPositionUpdated, self)
end

function SeasonSceneOperateView:onEnter()
	SeasonSceneOperateView.super.onEnter(self)
	self._gridOpBtnsNode:SetActive(true)

	local params = self:getOpenParam()

	self._opTypes = checktable(params[1])
	self._opTypeMap = {}
	self._opGridX = checknumber(params[2])
	self._opGridY = checknumber(params[3])
	self._gridId = checknumber(params[4])

	self:_showOpBtns()
	self:_setupBtnsFollowTargets()
	GameUtil.SetActive(self._BtnGM, false)

	if enableDebug then
		GameUtil.SetActive(self._BtnGM, true)
	end

	SeasonAutoFightController.instance:stopAutoFight()
	GlobalDispatcher:addListener(GlobalNotify.SeasonTeamServerPosUpdated, self._onServerPositionUpdated, self)
end

function SeasonSceneOperateView:_onServerPositionUpdated()
	self._opTypes = SeasonGridEvtModel.instance:getOpGroups(self._gridId) or {}

	if not self._opTypes or #self._opTypes == 0 then
		self:close()

		return
	end

	self:_showOpBtns()
end

function SeasonSceneOperateView:_showOpBtns()
	local len = #self._opTypes
	local posGroup = OpButtonsLocalPos[len]

	for i, btnConfig in ipairs(self._gridOpBtns) do
		GameUtil.SetActive(btnConfig.button, false)
	end

	for i = 1, len do
		local opType = self._opTypes[i]
		local btnConfig = self._gridOpBtns[OpUse[opType]]

		btnConfig.btnText.text = SeasonGridEvtModel.OpNames[opType]

		GameUtil.SetActive(btnConfig.button, true)

		if opType == SeasonGridEvtModel.Op_Mark then
			GameUtil.setUIImageSpriteIdx(btnConfig.button, 0)
		elseif opType == SeasonGridEvtModel.Op_UnMark then
			GameUtil.setUIImageSpriteIdx(btnConfig.button, 1)
		end

		self._opTypeMap[OpUse[opType]] = opType

		local pos = posGroup[i]

		if pos then
			GameUtil.setLocalPos(btnConfig.button, pos[1], pos[2], 0)
		end
	end
end

function SeasonSceneOperateView:_setupBtnsFollowTargets()
	local scene = SceneMgr.instance:getCurScene()
	local gridX, gridY = self._opGridX, self._opGridY

	SeasonModel.instance:setOpViewShowing(gridX, gridY)

	local elementId = scene.gridUnitsMgr:getUnitElementId(gridX, gridY)

	printInfo("SeasonSceneOperateView:_setupBtnsFollowTargets....................", elementId)

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
			followCom.offsetX3D = -1.15
			followCom.offsetY3D = 0

			followCom:LateUpdate()
		end
	end
end

function SeasonSceneOperateView:_onClickGridOp(index)
	if self._opTypes then
		local opType = self._opTypeMap[index]

		if opType == SeasonGridEvtModel.Op_AutoFight then
			TipsFacade.instance:openPopupWindow(lang("tip"), lang("确定使用当前队伍开始自动行走？行走过程中占领地块将自动消耗体力。"), function()
				local teamModel = SeasonTeamsModel.instance
				local teamId = teamModel:getCurrTeamId()

				SeasonAutoFightController.instance:startAutoFight(teamId, opType, self._opGridX, self._opGridY)
				SeasonOpHandler.instance:handle(opType, self._opGridX, self._opGridY)
			end)
		else
			SeasonOpHandler.instance:handle(opType, self._opGridX, self._opGridY)
		end
	end

	self:close()
end

function SeasonSceneOperateView:_onClickGMJump()
	local data = SeasonPathFindingDataModel.instance
	local toGridX, toGridY = self._opGridX, self._opGridY
	local id = data:grid2Id(toGridX, toGridY)
	local teamModel = SeasonTeamsModel.instance
	local teamId = teamModel:getCurrTeamId()

	GMAgent.instance:sendPM_SeasonModePveMapJumpReq(checknumber(id), checknumber(teamId))
	self:close()
end

return SeasonSceneOperateView
