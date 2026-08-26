-- chunkname: @modules/logic/versionactivity3_3/igor/view/comp/IgorSkillDefenseItem.lua

module("modules.logic.versionactivity3_3.igor.view.comp.IgorSkillDefenseItem", package.seeall)

local IgorSkillDefenseItem = class("IgorSkillDefenseItem", IgorSkillBaseItem)

function IgorSkillDefenseItem:onInit()
	self.goMask = gohelper.findChild(self.go, "Mask")
	self.txtNum = gohelper.findChildTextMesh(self.go, "Num/txtcost")
end

function IgorSkillDefenseItem:refreshTimes()
	local _hasTimes = self:hasRemainTimes()

	gohelper.setActive(self.goMask, not _hasTimes)

	local remainTimes = self.skillData:getSkillRemainTimes()

	self.txtNum.text = string.format("<color=%s>%s</color>", _hasTimes and "#482915" or "#BF2E11", remainTimes)
end

function IgorSkillDefenseItem:onUseCard()
	if self:isInCD() or not self:isCostEnough() or not self:hasRemainTimes() then
		return
	end

	local gameMO = IgorModel.instance:getCurGameMo()

	if not gameMO:getOursideMo():defenseup() then
		return
	end

	self:refreshTimes()
	self:enterCD()
end

function IgorSkillDefenseItem:showTips()
	local datas = {}
	local desc = IgorConfig.instance:getConstValue2(IgorEnum.ConstId.DefenseTips)
	local attr = string.split(desc, "#")

	table.insert(datas, {
		title = attr[1],
		desc = attr[2]
	})

	local screenPos = recthelper.uiPosToScreenPos(self.transform)
	local offsetX = -140
	local offsetY = 100

	ViewMgr.instance:openView(ViewName.IgorTipsView, {
		list = datas,
		pivot = Vector2(0, 0),
		screenPos = screenPos,
		offsetX = offsetX,
		offsetY = offsetY
	})
end

return IgorSkillDefenseItem
