-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/clearstargame/view/ClearStarCell.lua

module("logic.extensions.clearstargame.view.ClearStarCell", package.seeall)

local ClearStarCell = class("ClearStarCell")

function ClearStarCell:ctor(go)
	self._mainGo = go

	self:_buildUI()
	self:reset()
	self:updateUI()
end

function ClearStarCell:reset()
	self._typeId = -1
	self._isSubSelect = false
	self._isSelect = false
	self._curRow = -1
	self._curCol = -1
	self._horStarPos = -1
	self._verStarPos = -1
	self._cellWidth = 0

	goutil.setActive(self._goSelect, false)
	goutil.setActive(self._goSubSelect, false)
	goutil.setActive(self.goCom, false)

	if self._tween then
		self._tween:Kill(false)

		self._tween = nil
	end
end

function ClearStarCell:updateUI()
	if self._tween then
		self._tween:Kill(false)

		self._tween = nil
	end

	if self._typeId > 0 then
		self:updatePos()
		goutil.setActive(self._mainGo, true)
		goutil.setActive(self.goCom, true)
	end
end

function ClearStarCell:_buildUI()
	self.goCom = goutil.findChild(self._mainGo, "com")
	self.effPos = goutil.findChild(self._mainGo, "eff")
	self._goSelect = goutil.findChild(self.goCom, "select")
	self._goSubSelect = goutil.findChild(self.goCom, "subselect")
	self._changeGroup = self.goCom:GetComponent("UIChangeGroup")

	goutil.setActive(self._goSelect, false)
	goutil.setActive(self._goSubSelect, false)
end

function ClearStarCell:setTypeId(typeId)
	self._typeId = typeId

	if self._changeGroup then
		self._changeGroup:SetState(self._typeId - 1)
	end
end

function ClearStarCell:getTypeId()
	return self._typeId
end

function ClearStarCell:moveToPos(row, col)
	if row == self._curRow and col == self._curCol then
		self:updateUI()
	else
		local addPosX = self._horStarPos + col * self._cellWidth - self._lastPosX
		local addPosY = self._verStarPos + row * self._cellWidth - self._lastPosY

		if self._tween then
			self._tween:Kill(false)

			self._tween = nil
		end

		self._tween = TweenUtil.ValueTo(0, 1, 0.25, function(val)
			GameUtil.setAnchoredPos(self._mainGo, self._lastPosX + addPosX * val, self._lastPosY + addPosY * val)
		end, function()
			self:updateUI()
		end, self, DG.Tweening.Ease.Linear)
	end

	self._curRow = row
	self._curCol = col
end

function ClearStarCell:setRowAndCol(row, col)
	self._curRow = row
	self._curCol = col
end

function ClearStarCell:getRowAndCol()
	return self._curRow, self._curCol
end

function ClearStarCell:setSelect(isSelect)
	self._isSelect = isSelect

	goutil.setActive(self._goSelect, isSelect)
end

function ClearStarCell:setSubSelect(isSubSelect)
	self._isSubSelect = isSubSelect

	goutil.setActive(self._goSubSelect, isSubSelect)
end

function ClearStarCell:clear()
	self:reset()

	self._mainGo = nil
end

function ClearStarCell:setPosParams(totalRow, totalCol, cellWidth)
	self._totalRow = totalRow
	self._totalCol = totalCol
	self._cellWidth = cellWidth

	local totalWidth = totalCol * self._cellWidth
	local totalHeight = totalRow * self._cellWidth
	local halfCellLength = self._cellWidth / 2

	self._horStarPos = -totalWidth / 2 + halfCellLength
	self._verStarPos = -totalHeight / 2 + halfCellLength
end

function ClearStarCell:updatePos()
	self._lastPosX = self._horStarPos + self._curCol * self._cellWidth
	self._lastPosY = self._verStarPos + self._curRow * self._cellWidth

	GameUtil.setAnchoredPos(self._mainGo, self._lastPosX, self._lastPosY)
end

return ClearStarCell
