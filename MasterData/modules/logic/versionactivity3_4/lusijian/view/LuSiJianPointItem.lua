-- chunkname: @modules/logic/versionactivity3_4/lusijian/view/LuSiJianPointItem.lua

module("modules.logic.versionactivity3_4.lusijian.view.LuSiJianPointItem", package.seeall)

local LuSiJianPointItem = class("LuSiJianPointItem", ListScrollCellExtend)

function LuSiJianPointItem:init(go)
	self.go = go
	self._tr = go.transform

	self:initPos(0, 0)
	gohelper.setActive(self.go, true)

	self._gonormal = gohelper.findChild(go, "#go_normal")
	self._godisturb = gohelper.findChild(go, "#go_disturb")
	self._goconnected = gohelper.findChild(go, "#go_connected")
	self._gofirst = gohelper.findChild(go, "#go_fristpoint")
	self._click = gohelper.getClickWithDefaultAudio(self.go)
end

function LuSiJianPointItem:addEventListeners()
	return
end

function LuSiJianPointItem:removeEventListeners()
	return
end

function LuSiJianPointItem:initPos(posX, posY)
	self._localPosX = posX
	self._localPosY = posY

	transformhelper.setLocalPosXY(self._tr, posX, posY)
end

function LuSiJianPointItem:getLocalPos()
	return self._localPosX, self._localPosY
end

function LuSiJianPointItem:updateInfo(mo)
	if not mo then
		return
	end

	self._mo = mo
	self.id = mo.id
	self.typeId = mo.typeId
	self.posX = mo.posX
	self.posY = mo.posY

	self:initPos(self.posX, self.posY)
	self:updateUI()
end

function LuSiJianPointItem:updateUI()
	local startIds = YeShuMeiGameModel.instance:getStartPointIds()

	if startIds then
		for _, pointId in ipairs(startIds) do
			if self.id == pointId then
				self._isStart = true

				break
			else
				self._isStart = false
			end
		end
	end

	if self._mo.state == YeShuMeiEnum.StateType.Normal then
		gohelper.setActive(self._gonormal, not self._isStart)
		gohelper.setActive(self._gofirst, self._isStart)
		gohelper.setActive(self._goconnected, false)
		gohelper.setActive(self._godisturb, false)
	elseif self._mo.state == YeShuMeiEnum.StateType.Connect then
		gohelper.setActive(self._gonormal, not self._isStart)
		gohelper.setActive(self._gofirst, self._isStart)
		gohelper.setActive(self._goconnected, true)
		gohelper.setActive(self._godisturb, false)
	else
		gohelper.setActive(self._gofirst, false)
		gohelper.setActive(self._gonormal, false)
		gohelper.setActive(self._goconnected, false)
		gohelper.setActive(self._godisturb, true)
	end
end

function LuSiJianPointItem:checkIsStartPoint()
	return self.isStart
end

function LuSiJianPointItem:clearPoint()
	self.id = 0
	self.typeId = 1
	self.posX = 0
	self.posY = 0

	self:initPos(self.posX, self.posY)
	gohelper.setActive(self.go, false)
end

function LuSiJianPointItem:checkPointId(id)
	return id == self.id
end

function LuSiJianPointItem:onDestroy()
	self:clearPoint()
end

return LuSiJianPointItem
