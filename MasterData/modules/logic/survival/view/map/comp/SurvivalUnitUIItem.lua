-- chunkname: @modules/logic/survival/view/map/comp/SurvivalUnitUIItem.lua

module("modules.logic.survival.view.map.comp.SurvivalUnitUIItem", package.seeall)

local SurvivalUnitUIItem = class("SurvivalUnitUIItem", LuaCompBase)

function SurvivalUnitUIItem:ctor(unitMo)
	self._unitMo = unitMo
	self._isShowStar = false
end

function SurvivalUnitUIItem:init(go)
	self.go = go
	self.trans = go.transform

	transformhelper.setLocalPos(self.trans, 9999, 9999, 0)

	self._imagebubble = gohelper.findChildImage(go, "#image_bubble")
	self._imageicon = gohelper.findChildImage(go, "#image_icon")
	self._golevel = gohelper.findChild(go, "level")
	self._txtlevel = gohelper.findChildTextMesh(go, "level/#txt_level")
	self._goarrow = gohelper.findChild(go, "arrow")
	self._goarrowright = gohelper.findChild(go, "arrow/right")
	self._goarrowtop = gohelper.findChild(go, "arrow/top")
	self._goarrowleft = gohelper.findChild(go, "arrow/left")
	self._goarrowbottom = gohelper.findChild(go, "arrow/bottom")
	self._imagearrowright = gohelper.findChildImage(go, "arrow/right")
	self._imagearrowtop = gohelper.findChildImage(go, "arrow/top")
	self._imagearrowleft = gohelper.findChildImage(go, "arrow/left")
	self._imagearrowbottom = gohelper.findChildImage(go, "arrow/bottom")
	self._gostar = gohelper.findChildImage(go, "star")
	self._anim = gohelper.findChildAnim(go, "")
	self._grid = gohelper.findChild(go, "grid")
	self._item = gohelper.findChild(go, "grid/item")

	local clickGo = gohelper.findChild(go, "goRaycast")

	self._click = gohelper.getClick(clickGo)
	self._isFollow = self:getIsFollow()

	self:initFollow()
	self:refreshInfo()
end

function SurvivalUnitUIItem:addEventListeners()
	self._click:AddClickListener(self._onClickIcon, self)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnMapPlayerPosChange, self._onMapPlayerPosChange, self)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnMapUnitPosChange, self._onMapUnitPosChange, self)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnUnitBeginMove, self._onMapUnitBeginMove, self)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnUnitEndMove, self._onMapUnitEndMove, self)
	GameGlobalMgr.instance:registerCallback(GameStateEvent.OnScreenResize, self._onScreenResize, self)
end

function SurvivalUnitUIItem:removeEventListeners()
	self._click:RemoveClickListener()
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnMapPlayerPosChange, self._onMapPlayerPosChange, self)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnMapUnitPosChange, self._onMapUnitPosChange, self)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnUnitBeginMove, self._onMapUnitBeginMove, self)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnUnitEndMove, self._onMapUnitEndMove, self)
	GameGlobalMgr.instance:unregisterCallback(GameStateEvent.OnScreenResize, self._onScreenResize, self)
end

function SurvivalUnitUIItem:onStart()
	self.go:GetComponent(typeof(SLFramework.LuaMonobehavier)).enabled = false

	self:checkEnabled()
end

function SurvivalUnitUIItem:initFollow()
	if not self._isFollow then
		gohelper.setActive(self._goarrow, false)

		self._uiFollower = gohelper.onceAddComponent(self.go, typeof(ZProj.UIFollower))
	else
		gohelper.setActive(self._goarrow, true)

		self._uiFollower = gohelper.onceAddComponent(self.go, typeof(ZProj.UIFollowerInRange))

		self._uiFollower:SetBoundArrow(self._goarrowleft, self._goarrowright, self._goarrowtop, self._goarrowbottom)
		self._uiFollower:SetArrowCallback(self._onArrowChange, self)
		self:_onScreenResize()
	end

	self._uiFollower:SetEnable(true)

	local entity = SurvivalMapHelper.instance:getEntity(self._unitMo.id)
	local mainCamera = CameraMgr.instance:getMainCamera()
	local uiCamera = CameraMgr.instance:getUICamera()
	local plane = ViewMgr.instance:getUIRoot().transform

	self._uiFollower:Set(mainCamera, uiCamera, plane, entity.go.transform, 0, 0.4, 0, 0, 0)
	self:checkEnabled()
end

function SurvivalUnitUIItem:_onScreenResize()
	if not self._isFollow or not self._uiFollower then
		return
	end

	local root = ViewMgr.instance:getUIRoot().transform
	local screenRightX = recthelper.getWidth(root)
	local screenTopY = recthelper.getHeight(root)

	screenTopY = screenRightX / screenTopY < 1.7777777777777777 and 1080 or screenTopY

	local halfScreenWidth = screenRightX / 2
	local halfScreenHeight = screenTopY / 2

	self._uiFollower:SetRange(-halfScreenWidth + 250, halfScreenWidth - 150, -halfScreenHeight + 210, halfScreenHeight - 110)
end

function SurvivalUnitUIItem:_onFollowTaskUpdate()
	local isFollow = self:getIsFollow()

	if isFollow ~= self._isFollow then
		self._isFollow = isFollow

		UnityEngine.Object.DestroyImmediate(self._uiFollower)
		self:initFollow()
	end
end

function SurvivalUnitUIItem:getIsFollow()
	if self._unitMo.co then
		if tabletool.indexOf(SurvivalConfig.instance:getHighValueUnitSubTypes(), self._unitMo.co) then
			return true
		end

		local followTask = SurvivalMapModel.instance:getSceneMo().followTask
		local mainTask = SurvivalMapModel.instance:getSceneMo().mainTask

		return self._unitMo.unitType == SurvivalEnum.UnitType.Exit or self._unitMo.id == followTask.followUnitUid or self._unitMo.id == mainTask.followUnitUid or self._unitMo.id == 0
	end
end

function SurvivalUnitUIItem:refreshInfo()
	gohelper.setActive(self._golevel, false)
	self:updateIconAndBg()
	self:checkEnabled()
end

function SurvivalUnitUIItem:updateIconAndBg()
	local icon, bg, arrow = SurvivalUnitIconHelper.instance:getUnitIconAndBg(self._unitMo)

	UISpriteSetMgr.instance:setSurvivalSprite(self._imageicon, icon)
	UISpriteSetMgr.instance:setSurvivalSprite(self._imagebubble, bg)
	UISpriteSetMgr.instance:setSurvivalSprite(self._imagearrowright, arrow)
	UISpriteSetMgr.instance:setSurvivalSprite(self._imagearrowtop, arrow)
	UISpriteSetMgr.instance:setSurvivalSprite(self._imagearrowleft, arrow)
	UISpriteSetMgr.instance:setSurvivalSprite(self._imagearrowbottom, arrow)
end

function SurvivalUnitUIItem:_onMapPlayerPosChange()
	self:checkEnabled()
end

function SurvivalUnitUIItem:_onMapUnitPosChange(_, unitMo)
	self:checkEnabled()
end

function SurvivalUnitUIItem:_onMapUnitBeginMove(unitId)
	if unitId ~= self._unitMo.id then
		return
	end

	self._isUnitMoving = true

	if self._isMult then
		self:checkEnabled()
	end
end

function SurvivalUnitUIItem:_onMapUnitEndMove(unitId)
	if unitId ~= self._unitMo.id then
		return
	end

	self._isUnitMoving = false

	self:checkEnabled()
end

function SurvivalUnitUIItem:checkEnabled()
	local playerPos = SurvivalMapModel.instance:getSceneMo().player.pos
	local isPosSame = playerPos == self._unitMo.pos
	local sceneMo = SurvivalMapModel.instance:getSceneMo()
	local list = sceneMo:getUnitIconListByPos(self._unitMo.pos)
	local enabled = list[1] == self._unitMo and not isPosSame

	self._uiFollower:SetEnable(enabled)

	self._uiFollower.enabled = enabled

	self._uiFollower:ForceUpdate()

	self._isMult = false

	if not enabled then
		transformhelper.setLocalPos(self.trans, 9999, 9999, 0)
	elseif #list > 1 then
		self._isMult = true

		gohelper.setActive(self._grid, not self._isUnitMoving)
		tabletool.revert(list)
		gohelper.CreateObjList(self, self._createIcons, list, self._grid, self._item, nil, nil, nil, 0)
	else
		gohelper.setActive(self._grid, false)
	end

	gohelper.setActive(self._imagebubble, not self._isArrowShow and (not self._isMult or self._isUnitMoving))
	gohelper.setActive(self._imageicon, not self._isMult or self._isUnitMoving)
	gohelper.setActive(self._gostar, (self._isMult or nil) and self._isUnitMoving and self._isShowStar)
end

function SurvivalUnitUIItem:_createIcons(obj, data, index)
	local imagebubble = gohelper.findChildImage(obj, "#image_bubble")
	local imageicon = gohelper.findChildImage(obj, "#image_icon")
	local icon, bg = SurvivalUnitIconHelper.instance:getUnitIconAndBg(data)

	UISpriteSetMgr.instance:setSurvivalSprite(imageicon, icon)
	UISpriteSetMgr.instance:setSurvivalSprite(imagebubble, bg .. "2")
end

function SurvivalUnitUIItem:_onClickIcon()
	local x, y, z = SurvivalHelper.instance:hexPointToWorldPoint(self._unitMo.pos.q, self._unitMo.pos.r)

	SurvivalController.instance:dispatchEvent(SurvivalEvent.TweenCameraFocus, Vector3(x, y, z))
end

function SurvivalUnitUIItem:_onArrowChange(show)
	self._isArrowShow = show

	gohelper.setActive(self._click, show)
	gohelper.setActive(self._imagebubble, not show and not self._isMult)
end

function SurvivalUnitUIItem:playCloseAnim()
	self._anim:Play("close", 0, 0)
	TaskDispatcher.runDelay(self.dispose, self, 0.2)
end

function SurvivalUnitUIItem:dispose()
	TaskDispatcher.cancelTask(self.dispose, self)
	gohelper.destroy(self.go)
end

return SurvivalUnitUIItem
