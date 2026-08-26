-- chunkname: @modules/logic/versionactivity1_3/armpipe/view/ArmPuzzlePipeItem.lua

module("modules.logic.versionactivity1_3.armpipe.view.ArmPuzzlePipeItem", package.seeall)

local ArmPuzzlePipeItem = class("ArmPuzzlePipeItem", LuaCompBase)

function ArmPuzzlePipeItem:init(go)
	self.viewGO = go
	self._gocontent = gohelper.findChild(self.viewGO, "#go_content")
	self._imageBg = gohelper.findChildImage(self.viewGO, "#go_content/#image_Bg")
	self._imageicon = gohelper.findChildImage(self.viewGO, "#go_content/#image_icon")
	self._imagenum = gohelper.findChildImage(self.viewGO, "#go_content/#image_num")
	self._imageconn = gohelper.findChildImage(self.viewGO, "#go_content/#image_conn")
	self.tf = self._gocontent.transform

	self:_editableInitView()
end

function ArmPuzzlePipeItem:addEventListeners()
	return
end

function ArmPuzzlePipeItem:removeEventListeners()
	return
end

function ArmPuzzlePipeItem:onStart()
	return
end

function ArmPuzzlePipeItem:onDestroy()
	return
end

function ArmPuzzlePipeItem:_editableInitView()
	self._goEffLight = gohelper.findChild(self.viewGO, "#go_content/eff_light")
	self._effLightAnimator = self._goEffLight:GetComponent(ArmPuzzlePipeEnum.ComponentType.Animator)
	self._imageconnTrs = self._imageconn.transform

	self:_playAnim(false, nil)
	gohelper.setActive(self._imageBg, false)
end

function ArmPuzzlePipeItem:initItem(mo)
	if not mo or mo.typeId == 0 then
		gohelper.setActive(self._gocontent, false)

		return
	end

	gohelper.setActive(self._gocontent, true)

	local isPlaceItem = ArmPuzzlePipeModel.instance:isPlaceByXY(mo.x, mo.y)

	if mo.typeId == ArmPuzzlePipeEnum.type.zhanwei then
		local isSelect = ArmPuzzlePipeModel.instance:isPlaceSelectXY(mo.x, mo.y)

		self:_playAnim(isSelect, isSelect and "turngreen" or "turnred")
	else
		self:_playAnim(false, nil)
	end

	gohelper.setActive(self._imageBg, isPlaceItem and mo.typeId ~= ArmPuzzlePipeEnum.type.zhanwei)
	UISpriteSetMgr.instance:setArmPipeSprite(self._imageicon, mo:getBackgroundRes(), true)

	local numPath = ArmPuzzlePipeEnum.resNumIcons[mo.numIndex]

	if mo:isEntry() then
		if numPath then
			UISpriteSetMgr.instance:setArmPipeSprite(self._imagenum, numPath, true)
		end
	elseif ArmPuzzlePipeEnum.pathConn[mo.typeId] then
		UISpriteSetMgr.instance:setArmPipeSprite(self._imageconn, mo:getConnectRes(), true)
	end

	if not ArmPuzzlePipeEnum.entryTypeColor[mo.typeId] then
		local entryColor = ArmPuzzlePipeEnum.entryColor

		if not entryColor[mo.pathIndex] then
			local colorStr = ArmPuzzlePipeEnum.entryColor[0]

			SLFramework.UGUI.GuiHelper.SetColor(self._imagenum, colorStr)
			SLFramework.UGUI.GuiHelper.SetColor(self._imageicon, colorStr)
			gohelper.setActive(self._imagenum, mo:isEntry() and numPath ~= nil)
			gohelper.setActive(self._imageconn, false)
			self:syncRotation(mo)
		end
	end
end

function ArmPuzzlePipeItem:_getEntryColor(mo)
	local colorStr

	if mo.typeId ~= ArmPuzzlePipeEnum.type.first and mo.typeId == ArmPuzzlePipeEnum.type.last then
		-- block empty
	end

	return colorStr or "#FFFFFF"
end

function ArmPuzzlePipeItem:_playAnim(isActive, animName)
	if self._lastEffActivie ~= isActive then
		self._lastEffActivie = isActive

		gohelper.setActive(self._goEffLight, isActive)
	end

	if isActive then
		if animName and self._lastEffActivie ~= animName then
			self._lastEffActivie = animName

			self._effLightAnimator:Play(animName)
		end
	else
		self._lastEffAnimName = nil
	end
end

function ArmPuzzlePipeItem:initConnectObj(mo)
	local showConn = false

	if mo then
		if ArmPuzzlePipeEnum.pathConn[mo.typeId] then
			showConn = mo:getConnectValue() ~= 0
		elseif ArmPuzzlePipeEnum.type.wrong == mo.typeId then
			local spriteName = mo:getConnectValue() >= 2 and mo:getConnectRes() or mo:getBackgroundRes()

			UISpriteSetMgr.instance:setArmPipeSprite(self._imageicon, spriteName, true)
		end

		if showConn then
			local connTypeId, rotation = self:_getConnectParam(mo)

			UISpriteSetMgr.instance:setArmPipeSprite(self._imageconn, ArmPuzzleHelper.getConnectRes(connTypeId), true)
			SLFramework.UGUI.GuiHelper.SetColor(self._imageconn, ArmPuzzlePipeEnum.pathColor[mo.connectPathIndex] or "#FFFFFF")
			transformhelper.setLocalRotation(self._imageconnTrs, 0, 0, rotation)
		end
	end

	gohelper.setActive(self._imageconn, showConn)
end

function ArmPuzzlePipeItem:_getConnectParam(mo)
	if ArmPuzzlePipeEnum.type.t_shape == mo.typeId then
		local connValue = mo:getConnectValue()

		for typeId, roataDic in pairs(ArmPuzzlePipeEnum.rotate) do
			if roataDic[connValue] then
				local rotation = ArmPuzzleHelper.getRotation(typeId, connValue) - mo:getRotation()

				return typeId, rotation
			end
		end
	end

	return mo.typeId, 0
end

function ArmPuzzlePipeItem:syncRotation(mo)
	if mo then
		local rotation = mo:getRotation()

		transformhelper.setLocalRotation(self.tf, 0, 0, rotation)
	end
end

ArmPuzzlePipeItem.prefabPath = "ui/viewres/versionactivity_1_3/v1a3_arm/v1a3_armpuzzleitem.prefab"

return ArmPuzzlePipeItem
