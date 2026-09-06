-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/recommendfmt/view/PetSkillAdjustCell.lua

module("logic.extensions.recommendfmt.view.PetSkillAdjustCell", package.seeall)

local PetSkillAdjustCell = class("PetSkillAdjustCell")
local SkillHeight = 62
local TxtOldHeight = 22
local TxtAfterHeight = 22

function PetSkillAdjustCell:ctor(go)
	self._cellGo = goutil.findChild(go, "cell")
	self._tableGo = goutil.findChild(go, "tableview")
	self._tableView = ScrollerList.create(self._tableGo, self._cellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearTableview, self))

	self._tableView:regGetCellSize(GameUtil.handler(self._getCellSize, self))

	local rowNum = 3

	self._totalOldHeight = TxtOldHeight * rowNum
	self._totalAfterHeight = TxtAfterHeight * rowNum
	self._skillY = -31
	self._cellHeight = SkillHeight + 8 + self._totalOldHeight + 8 + self._totalAfterHeight
	self._txtOldY = self._skillY - SkillHeight * 0.5 - 8 - self._totalOldHeight * 0.5
	self._txtAfterY = self._txtOldY - self._totalOldHeight * 0.5 - 8 - self._totalAfterHeight * 0.5
end

function PetSkillAdjustCell:init(data)
	self._tableView:reloadData(data)
end

function PetSkillAdjustCell:reset()
	self._tableView:dispose()
end

function PetSkillAdjustCell:_updateCell(view, cell, data)
	local imageObj = goutil.findChild(cell, "skill/skillicon")
	local txtName = goutil.findChildTextComponent(cell, "skill/txtName")
	local txtOld = goutil.findChildTextComponent(cell, "txtOld")
	local txtAfter = goutil.findChildTextComponent(cell, "txtAfter")
	local txtOldTrans = txtOld.gameObject:GetComponent(goutil.Type_RectTransform)
	local txtAfterTrans = txtAfter.gameObject:GetComponent(goutil.Type_RectTransform)

	MaterialMgr.setSkillByFaceId(data.skillId, data.petId, imageObj)

	local skillCo = BattleConfig.instance:getSkillCo(data.skillId, data.petId)

	txtName.text = skillCo.name
	txtOld.text = data.oldDesc
	txtAfter.text = data.newDesc

	local height, numOld, numNew = self:_getHeight(data.oldDesc, data.newDesc, self._cellHeight)

	GameUtil.setHeight(cell.gameObject, height)

	local oldHeight = self._totalOldHeight + TxtOldHeight * numOld
	local newHeight = self._totalAfterHeight + TxtAfterHeight * numNew

	GameUtil.setHeight(txtOld.gameObject, oldHeight)
	GameUtil.setHeight(txtAfter.gameObject, newHeight)

	local x1, y1 = Framework.TransformUtil.GetAnchoredPos(txtOldTrans, 0, 0)
	local newY1 = self._txtOldY - TxtOldHeight * 0.5 * numOld

	Framework.TransformUtil.SetAnchoredPos(txtOldTrans, x1, newY1)

	local x2, y2 = Framework.TransformUtil.GetAnchoredPos(txtAfterTrans, 0, 0)
	local newY2 = newY1 - oldHeight / 2 - 8 - newHeight / 2

	Framework.TransformUtil.SetAnchoredPos(txtAfterTrans, x2, newY2)
end

function PetSkillAdjustCell:_clearTableview(cell)
	local imageObj = goutil.findChild(cell, "skill/skillicon")

	MaterialMgr.resetAll(imageObj)
end

function PetSkillAdjustCell:_getCellSize(view, index)
	local height = self._cellHeight
	local data = self._tableView:getData()[index + 1]

	height = self:_getHeight(data.oldDesc, data.newDesc, height)

	return 576, height
end

function PetSkillAdjustCell:_getHeight(oldDesc, newDesc, baseHeight)
	local height = baseHeight
	local lengthOld = string.utf8len(oldDesc)
	local lengthNew = string.utf8len(newDesc)
	local numOld = 0

	for i, v in string.gmatch(oldDesc, "\n") do
		numOld = numOld + 1
	end

	local numNew = 0

	for i, v in string.gmatch(newDesc, "\n") do
		numNew = numNew + 1
	end

	local numOld = numOld + Mathf.Ceil(math.max(lengthOld - 90, 0) / 30)
	local numNew = numNew + Mathf.Ceil(math.max(lengthNew - 90, 0) / 30)

	height = height + TxtOldHeight * numOld + TxtAfterHeight * numNew

	return height, numOld, numNew
end

return PetSkillAdjustCell
