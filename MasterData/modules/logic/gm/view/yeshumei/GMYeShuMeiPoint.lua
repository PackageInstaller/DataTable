-- chunkname: @modules/logic/gm/view/yeshumei/GMYeShuMeiPoint.lua

module("modules.logic.gm.view.yeshumei.GMYeShuMeiPoint", package.seeall)

local GMYeShuMeiPoint = class("GMYeShuMeiPoint", LuaCompBase)

function GMYeShuMeiPoint:init(go)
	self.go = go
	self._tr = go.transform

	self:initPos(0, 0)
	gohelper.setActive(self.go, true)

	self._dropdown = gohelper.findChildDropdown(go, "Dropdown")
	self._btndelete = gohelper.findChildButton(go, "btn/btn_delete")
	self._txtpos = gohelper.findChildText(go, "#txt_pos")
	self._txtindex = gohelper.findChildText(go, "#txt_index")
	self._gostart = gohelper.findChild(go, "#go_start")
	self._gonormal = gohelper.findChild(go, "#go_normal")
	self._godisturb = gohelper.findChild(go, "#go_disturb")

	CommonDragHelper.instance:registerDragObj(self.go, self._beginDrag, self._onDrag, self._endDrag, self._checkDrag, self, nil, true)
end

function GMYeShuMeiPoint:initPos(posX, posY)
	self._localPosX = posX
	self._localPosY = posY

	transformhelper.setLocalPosXY(self._tr, posX, posY)
end

function GMYeShuMeiPoint:getLocalPos()
	return self._localPosX, self._localPosY
end

function GMYeShuMeiPoint:updateInfo(mo)
	if not mo then
		return
	end

	self._mo = mo
	self.id = mo.id
	self.typeId = mo.typeId
	self.posX = mo.posX
	self.posY = mo.posY

	self:initPos(self.posX, self.posY)

	self._txtpos.text = string.format("(%.1f, %.1f)", self.posX, self.posY)
	self._txtindex.text = self.id

	self:_initTypeDropdown()
	self:_updateType(self.typeId)
end

function GMYeShuMeiPoint:clearPoint()
	self.id = 0
	self.typeId = 1
	self.posX = 0
	self.posY = 0

	self:initPos(self.posX, self.posY)
	gohelper.setActive(self.go, false)
end

function GMYeShuMeiPoint:addEventListeners()
	self._dropdown:AddOnValueChanged(self._dropdownChange, self)
	self._btndelete:AddClickListener(self._onClickBtnDelete, self)
end

function GMYeShuMeiPoint:removeEventListeners()
	self._dropdown:RemoveOnValueChanged()
	self._btndelete:RemoveClickListener()
	CommonDragHelper.instance:unregisterDragObj(self.go)
end

function GMYeShuMeiPoint:_initTypeDropdown()
	self._typeNameIdList = {}

	if self._dropdown then
		local typeNameList = YeShuMeiEnum.PointTypeName

		for typeId, name in ipairs(typeNameList) do
			table.insert(self._typeNameIdList, typeId)
		end

		self._dropdown:ClearOptions()
		self._dropdown:AddOptions(typeNameList)

		local index = 0
		local typeId = 1

		for i = 1, #self._typeNameIdList do
			if self._mo.typeId ~= 0 and self._typeNameIdList[i] == self._mo.typeId then
				index = i - 1
				typeId = self._mo.typeId
			end
		end

		self._dropdown:SetValue(index)

		self.typeId = typeId
	end
end

function GMYeShuMeiPoint:_dropdownChange(idx)
	if self.isDraging then
		return
	end

	local typeId = (idx + 1 ~= 1 or nil) and self._typeNameIdList[idx + 1]

	if typeId ~= self.typeId then
		self.typeId = typeId

		self._mo:updateTypeId(self.typeId)
	end

	self:_updateType(self.typeId)
end

function GMYeShuMeiPoint:_beginDrag()
	self.isDraging = true
end

function GMYeShuMeiPoint:_onDrag(_, pointerEventData)
	local position = pointerEventData.position
	local anchorPos = recthelper.screenPosToAnchorPos(position, self._tr.parent)

	recthelper.setAnchor(self._tr, anchorPos.x, anchorPos.y)
	self:updateLocalPos()
end

function GMYeShuMeiPoint:updateLocalPos()
	local x, y = transformhelper.getLocalPos(self._tr)

	self._localPosX = x
	self._localPosY = y

	self._mo:updatePos(self._localPosX, self._localPosY)

	self._txtpos.text = string.format("(%.1f, %.1f)", self._localPosX, self._localPosY)

	self._refreshLineCb(self._refreshLineObj)
end

function GMYeShuMeiPoint:_endDrag()
	self.isDraging = false
end

function GMYeShuMeiPoint:checkPointId(id)
	return id == self.id
end

function GMYeShuMeiPoint:_onClickBtnDelete()
	if self._deleteCb ~= nil then
		self._deleteCb(self._deleteObj, self.id)
	end
end

function GMYeShuMeiPoint:_onClick()
	local line = GMYeShuMeiModel.instance:getCurLine()

	if line == nil then
		return
	end

	line:addPoint(self)
end

function GMYeShuMeiPoint:addDeleteCb(cb, obj)
	self._deleteCb = cb
	self._deleteObj = obj
end

function GMYeShuMeiPoint:addRefreshLineCb(cb, obj)
	self._refreshLineCb = cb
	self._refreshLineObj = obj
end

function GMYeShuMeiPoint:_updateType(typeId)
	if typeId == YeShuMeiEnum.PointType.Start then
		gohelper.setActive(self._gostart, true)
		gohelper.setActive(self._gonormal, false)
		gohelper.setActive(self._godisturb, false)
	elseif typeId == YeShuMeiEnum.PointType.Disturb then
		gohelper.setActive(self._gostart, false)
		gohelper.setActive(self._gonormal, false)
		gohelper.setActive(self._godisturb, true)
	else
		gohelper.setActive(self._gostart, false)
		gohelper.setActive(self._gonormal, true)
		gohelper.setActive(self._godisturb, false)
	end
end

function GMYeShuMeiPoint:onDestroy()
	self:clearPoint()
	self:removeEventListeners()
	gohelper.destroy(self.go)
end

return GMYeShuMeiPoint
