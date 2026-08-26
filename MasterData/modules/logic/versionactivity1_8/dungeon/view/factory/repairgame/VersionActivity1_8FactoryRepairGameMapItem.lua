-- chunkname: @modules/logic/versionactivity1_8/dungeon/view/factory/repairgame/VersionActivity1_8FactoryRepairGameMapItem.lua

module("modules.logic.versionactivity1_8.dungeon.view.factory.repairgame.VersionActivity1_8FactoryRepairGameMapItem", package.seeall)

local VersionActivity1_8FactoryRepairGameMapItem = class("VersionActivity1_8FactoryRepairGameMapItem", LuaCompBase)

function VersionActivity1_8FactoryRepairGameMapItem:init(go)
	self.viewGO = go
	self._gocontent = gohelper.findChild(self.viewGO, "#go_content")
	self._contentTrans = self._gocontent.transform
	self._imageBg = gohelper.findChildImage(self.viewGO, "#go_content/#image_Bg")

	gohelper.setActive(self._imageBg, false)

	self._imageicon = gohelper.findChildImage(self.viewGO, "#go_content/#image_icon")
	self._goEffLight = gohelper.findChild(self.viewGO, "#go_content/eff_light")
	self._effLightAnimator = self._goEffLight:GetComponent(ArmPuzzlePipeEnum.ComponentType.Animator)
	self._imageconn = gohelper.findChildImage(self.viewGO, "#go_content/#image_conn")
	self._imageconnTrs = self._imageconn.transform
	self._imagenum = gohelper.findChildImage(self.viewGO, "#go_content/#image_num")

	self:_playAnim(false, nil)
end

function VersionActivity1_8FactoryRepairGameMapItem:initItem(mo)
	if not mo or mo.typeId == 0 then
		gohelper.setActive(self._gocontent, false)

		return
	end

	gohelper.setActive(self._gocontent, true)

	local isPlaceItem = Activity157RepairGameModel.instance:isPlaceByXY(mo.x, mo.y)

	if mo.typeId == ArmPuzzlePipeEnum.type.zhanwei then
		local isSelect = Activity157RepairGameModel.instance:isPlaceSelectXY(mo.x, mo.y)

		self:_playAnim(isSelect, isSelect and "turngreen" or "turnred")
	else
		self:_playAnim(false, nil)
	end

	gohelper.setActive(self._imageBg, isPlaceItem and mo.typeId ~= ArmPuzzlePipeEnum.type.zhanwei)

	local backgroundRes, isUseActSprite = mo:getBackgroundRes()

	if isUseActSprite then
		UISpriteSetMgr.instance:setV1a8FactorySprite(self._imageicon, backgroundRes, true)
	else
		UISpriteSetMgr.instance:setArmPipeSprite(self._imageicon, backgroundRes, true)
	end

	local numPath = ArmPuzzlePipeEnum.resNumIcons[mo.numIndex]

	if mo:isEntry() then
		if numPath then
			UISpriteSetMgr.instance:setArmPipeSprite(self._imagenum, numPath, true)
		end
	elseif ArmPuzzlePipeEnum.pathConn[mo.typeId] then
		local connRes, isConnUseActSprite = mo:getBackgroundRes()

		if isConnUseActSprite then
			UISpriteSetMgr.instance:setV1a8FactorySprite(self._imageconn, connRes, true)
		else
			UISpriteSetMgr.instance:setArmPipeSprite(self._imageconn, connRes, true)
		end
	end

	if not Activity157Enum.entryTypeColor[mo.typeId] then
		local entryColor = Activity157Enum.entryColor

		if not entryColor[mo.pathIndex] then
			local colorStr = Activity157Enum.entryColor[0]

			SLFramework.UGUI.GuiHelper.SetColor(self._imagenum, colorStr)
			SLFramework.UGUI.GuiHelper.SetColor(self._imageicon, colorStr)
			gohelper.setActive(self._imagenum, mo:isEntry() and numPath ~= nil)
			gohelper.setActive(self._imageconn, false)
			self:syncRotation(mo)
		end
	end
end

function VersionActivity1_8FactoryRepairGameMapItem:_playAnim(isActive, animName)
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

function VersionActivity1_8FactoryRepairGameMapItem:syncRotation(mo)
	if not mo then
		return
	end

	local rotation = mo:getRotation()

	transformhelper.setLocalRotation(self._contentTrans, 0, 0, rotation)
end

function VersionActivity1_8FactoryRepairGameMapItem:initConnectObj(mo)
	local showConn = false

	if mo then
		if ArmPuzzlePipeEnum.pathConn[mo.typeId] then
			showConn = mo:getConnectValue() ~= 0
		elseif ArmPuzzlePipeEnum.type.wrong == mo.typeId then
			local spriteNam, isUseActSprite

			if mo:getConnectValue() >= 2 then
				spriteNam, isUseActSprite = mo:getConnectRes()
			else
				spriteNam, isUseActSprite = mo:getBackgroundRes()
			end

			if isUseActSprite then
				UISpriteSetMgr.instance:setV1a8FactorySprite(self._imageicon, spriteNam, true)
			else
				UISpriteSetMgr.instance:setArmPipeSprite(self._imageicon, spriteNam, true)
			end
		end

		if showConn then
			local connTypeId, rotation = self:_getConnectParam(mo)
			local spriteNam, isUseActSprite = ArmPuzzleHelper.getConnectRes(connTypeId, Activity157Enum.res)

			if isUseActSprite then
				UISpriteSetMgr.instance:setV1a8FactorySprite(self._imageconn, spriteNam, true)
			else
				UISpriteSetMgr.instance:setArmPipeSprite(self._imageconn, spriteNam, true)
			end

			SLFramework.UGUI.GuiHelper.SetColor(self._imageconn, Activity157Enum.pathColor[mo.connectPathIndex] or "#FFFFFF")
			transformhelper.setLocalRotation(self._imageconnTrs, 0, 0, rotation)
		end
	end

	gohelper.setActive(self._imageconn, showConn)
end

function VersionActivity1_8FactoryRepairGameMapItem:_getConnectParam(mo)
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

function VersionActivity1_8FactoryRepairGameMapItem:onDestroy()
	return
end

return VersionActivity1_8FactoryRepairGameMapItem
