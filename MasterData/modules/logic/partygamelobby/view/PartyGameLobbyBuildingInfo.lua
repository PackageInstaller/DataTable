-- chunkname: @modules/logic/partygamelobby/view/PartyGameLobbyBuildingInfo.lua

module("modules.logic.partygamelobby.view.PartyGameLobbyBuildingInfo", package.seeall)

local PartyGameLobbyBuildingInfo = class("PartyGameLobbyBuildingInfo", ListScrollCellExtend)

function PartyGameLobbyBuildingInfo:onInitView()
	self._gobuildingArrow = gohelper.findChild(self.viewGO, "#go_buildingArrow")
	self._imagebuilding1 = gohelper.findChildImage(self.viewGO, "#go_buildingArrow/building/#image_building1")
	self._goarrow = gohelper.findChild(self.viewGO, "#go_buildingArrow/arrow/#go_arrow")
	self._gobuildingBubble = gohelper.findChild(self.viewGO, "#go_buildingBubble")
	self._imagebuilding2 = gohelper.findChildImage(self.viewGO, "#go_buildingBubble/#image_building2")
	self._txtname = gohelper.findChildText(self.viewGO, "#go_buildingBubble/#txt_name")
	self._txten = gohelper.findChildText(self.viewGO, "#go_buildingBubble/#txt_en")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "#go_buildingBubble/#btn_click")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function PartyGameLobbyBuildingInfo:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function PartyGameLobbyBuildingInfo:removeEvents()
	self._btnclick:RemoveClickListener()
end

function PartyGameLobbyBuildingInfo:_btnclickOnClick()
	PartyGameLobbyController.instance:dispatchEvent(PartyGameLobbyEvent.ClickBuilding, self._id)
end

function PartyGameLobbyBuildingInfo:_editableInitView()
	local root = ViewMgr.instance:getUIRoot().transform

	self._screenWidth = recthelper.getWidth(root)
	self._screenHeight = recthelper.getHeight(root)
	self._maxWidth = 0.5 * self._screenWidth + 160
	self._minWidth = -0.5 * self._screenWidth - 160
	self._maxHeight = 0.5 * self._screenHeight + 50
	self._minHeight = -0.5 * self._screenHeight
	self._arrowOffsetWidth = 260
	self._arrowOffsetHeight = 100

	gohelper.setActive(self._gobuildingBubble, true)
	gohelper.setActive(self._gobuildingArrow, false)
	TaskDispatcher.runRepeat(self._checkArrow, self, 0)
end

function PartyGameLobbyBuildingInfo:_checkArrow()
	local posX, posY = recthelper.getAnchor(self._gobuildingBubble.transform)
	local showBubble = posX >= self._minWidth and posX <= self._maxWidth and posY >= self._minHeight and posY <= self._maxHeight

	gohelper.setActive(self._gobuildingArrow, not showBubble)

	if not showBubble then
		local arrowX = Mathf.Clamp(posX, self._minWidth + self._arrowOffsetWidth, self._maxWidth - self._arrowOffsetWidth)
		local arrowY = Mathf.Clamp(posY, self._minHeight + self._arrowOffsetHeight, self._maxHeight - self._arrowOffsetHeight - 100)

		recthelper.setAnchor(self._gobuildingArrow.transform, arrowX, arrowY)

		local angle = 90 + Mathf.Atan2(arrowY - posY, arrowX - posX) * Mathf.Rad2Deg

		transformhelper.setLocalRotation(self._goarrow.transform, 0, 0, angle)
	end
end

function PartyGameLobbyBuildingInfo:_editableAddEvents()
	return
end

function PartyGameLobbyBuildingInfo:_editableRemoveEvents()
	return
end

function PartyGameLobbyBuildingInfo:onUpdateMO(id, config)
	self._id = id
	self._config = config

	if self._config then
		self._txtname.text = self._config.name
		self._txten.text = self._config.enName

		UISpriteSetMgr.instance:setV3a4LaplaceSprite(self._imagebuilding1, self._config.icon .. "_1")
		UISpriteSetMgr.instance:setV3a4LaplaceSprite(self._imagebuilding2, self._config.icon .. "_2")
	end

	local scene = GameSceneMgr.instance:getCurScene()
	local sceneGo = scene.level:getSceneGo()
	local buildingGo = gohelper.findChild(sceneGo, self._config.scenePath)

	if not buildingGo then
		logError("PartyGameLobbyBuildingInfo buildingGo is nil path:", self._config.scenePath)

		return
	end
end

function PartyGameLobbyBuildingInfo:bindBuildingGo(entity)
	if self._uiFollower then
		return
	end

	self._uiFollower = gohelper.onceAddComponent(self._gobuildingBubble, typeof(ZProj.UIFollower))

	local mainCamera = CameraMgr.instance:getMainCamera()
	local uiCamera = CameraMgr.instance:getUICamera()
	local plane = ViewMgr.instance:getUIRoot().transform

	self._uiFollower:Set(mainCamera, uiCamera, plane, entity.transform, 0, 0, 0, 0, 0)
	self._uiFollower:SetEnable(true)
	self._uiFollower:ForceUpdate()
end

function PartyGameLobbyBuildingInfo:onDestroyView()
	TaskDispatcher.cancelTask(self._checkArrow, self)
end

return PartyGameLobbyBuildingInfo
