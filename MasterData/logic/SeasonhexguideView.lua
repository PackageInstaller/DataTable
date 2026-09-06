-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonhexguideView.lua

module("logic.extensions.season.view.SeasonhexguideView", package.seeall)

local SeasonhexguideView = class("SeasonhexguideView", ViewComponent)

function SeasonhexguideView:ctor()
	SeasonhexguideView.super.ctor(self)
end

function SeasonhexguideView:unbindEvents()
	SeasonhexguideView.super.unbindEvents(self)
end

function SeasonhexguideView:bindEvents()
	SeasonhexguideView.super.bindEvents(self)

	for i, btn in ipairs(self.btnList) do
		GameUtil.addClickHandler(btn, GameUtil.handler(self.onBtnClick, self, i))
	end
end

function SeasonhexguideView:buildUI()
	SeasonhexguideView.super.buildUI(self)

	self._hexagonuiholemaskobj = self:getGo("hexagonuiholemaskobj")
	self._moveNode = self:getGo("move")
	self.btnList = {}

	for i = 1, 3 do
		local btn = self:getGo("move/btn_" .. i)

		table.insert(self.btnList, btn)
	end
end

function SeasonhexguideView:onExit()
	SeasonhexguideView.super.onExit(self)
	removetimer(self.onTimer, self)
end

function SeasonhexguideView:onEnter()
	SeasonhexguideView.super.onEnter(self)
	self:_setupBtnsFollowTargets()
end

function SeasonhexguideView:onBtnClick(idx)
	local curTeamMo = SeasonTeamsModel.instance:getCurrTeamMo()
	local gridX, gridY = curTeamMo:getServerCurGridXY()
	local gapX = 0
	local gapY = 0

	if idx == 1 then
		gapX = -1
		gapY = gridX % 2
	elseif idx == 2 then
		gapX = 0
		gapY = 1
	elseif idx == 3 then
		gapX = 1
		gapY = gridX % 2
	end

	local nextX, nextY = gridX + gapX, gridY + gapY

	GlobalDispatcher:dispatch(GlobalNotify.SeasonSelectGrid, nextX, nextY)
	GuideController.instance:finishGuide()
	self:close()
end

function SeasonhexguideView:_setupBtnsFollowTargets()
	local scene = SceneMgr.instance:getCurScene()
	local curTeamMo = SeasonTeamsModel.instance:getCurrTeamMo()

	if scene and scene.changeFocus then
		scene:changeFocus(curTeamMo.teamId)
	end

	local gridX, gridY = curTeamMo:getServerCurGridXY()
	local elementId = scene.gridUnitsMgr:getUnitElementId(gridX, gridY)

	if elementId ~= nil and elementId > 0 then
		local unit = scene.unitFactory:getUnit(UnitTag.SceneElement, elementId)

		if unit then
			self:addFollowCom(unit, self._moveNode)
			removetimer(self.onTimer, self)
			settimer(0, self.onTimer, self, true)
		end
	end
end

function SeasonhexguideView:onTimer()
	local x, y, z = Framework.TransformUtil.GetLocalPos(self._moveNode.transform, 0, 0, 0)

	Framework.TransformUtil.SetLocalPos(self._hexagonuiholemaskobj.transform, x, y, z)
end

function SeasonhexguideView:addFollowCom(unit, node)
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
	followCom.offsetX3D = -1.15
	followCom.offsetY3D = 0

	followCom:LateUpdate()
end

return SeasonhexguideView
