-- chunkname: @modules/logic/sp02/atomic/view/AtomicCultivateNodeItem.lua

module("modules.logic.sp02.atomic.view.AtomicCultivateNodeItem", package.seeall)

local AtomicCultivateNodeItem = class("AtomicCultivateNodeItem", LuaCompBase)

function AtomicCultivateNodeItem:init(go)
	self.go = go
	self.goLineRight = gohelper.findChild(go, "#go_lineRight")
	self.goLineRightLight = gohelper.findChild(go, "#go_lineRight/#go_light")
	self.goLineRightDark = gohelper.findChild(go, "#go_lineRight/#go_dark")
	self.goLineBottom = gohelper.findChild(go, "#go_lineBottom")
	self.goLineBottomLight = gohelper.findChild(go, "#go_lineBottom/#go_light")
	self.goLineBottomDark = gohelper.findChild(go, "#go_lineBottom/#go_dark")
	self.goItemPos = gohelper.findChild(go, "#go_itemScale")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AtomicCultivateNodeItem:addEventListeners()
	return
end

function AtomicCultivateNodeItem:removeEventListeners()
	return
end

function AtomicCultivateNodeItem:_btnclickOnClick()
	if not self.data then
		return
	end
end

function AtomicCultivateNodeItem:_editableInitView()
	return
end

function AtomicCultivateNodeItem:updateData(data)
	self.data = data

	gohelper.setActive(self.go, data ~= nil)

	if not data then
		return
	end

	self:refreshUI()
end

function AtomicCultivateNodeItem:refreshUI()
	local row = self.data.row
	local col = self.data.col
	local rightData = AtomicTalentViewModel.instance:getNodeDataByPos(row, col + 1)
	local bottomData = AtomicTalentViewModel.instance:getNodeDataByPos(row + 1, col)
	local hasRight = rightData ~= nil
	local hasBottom = bottomData ~= nil

	gohelper.setActive(self.goLineRight, hasRight)
	gohelper.setActive(self.goLineBottom, hasBottom)

	if hasRight then
		local isUnlock = AtomicTalentViewModel.instance:isNodeUnlocked(rightData.config.id)

		gohelper.setActive(self.goLineRightLight, isUnlock)
		gohelper.setActive(self.goLineRightDark, not isUnlock)
	end

	if hasBottom then
		local isUnlock = AtomicTalentViewModel.instance:isNodeUnlocked(bottomData.config.id)

		gohelper.setActive(self.goLineBottomLight, isUnlock)
		gohelper.setActive(self.goLineBottomDark, not isUnlock)
	end

	self:refreshSkillItem(self.data.config)
end

function AtomicCultivateNodeItem:refreshSkillItem(config)
	if not self.skillItem then
		local viewContainer = ViewMgr.instance:getContainer(ViewName.AtomicCultivateView)
		local resPath = viewContainer:getSetting().otherRes[1]
		local go = viewContainer:getResInst(resPath, self.goItemPos, "skillItem")

		self.skillItem = MonoHelper.addNoUpdateLuaComOnceToGo(go, AtomicCultivateSkillItem)
	end

	self.skillItem:updateData(config)
end

function AtomicCultivateNodeItem:onDestroy()
	return
end

return AtomicCultivateNodeItem
