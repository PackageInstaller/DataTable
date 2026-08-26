-- chunkname: @modules/logic/versionactivity3_3/igor/view/comp/IgorSkillLevupItem.lua

module("modules.logic.versionactivity3_3.igor.view.comp.IgorSkillLevupItem", package.seeall)

local IgorSkillLevupItem = class("IgorSkillLevupItem", IgorSkillBaseItem)

function IgorSkillLevupItem:onInit()
	self.goMax = gohelper.findChildTextMesh(self.go, "Cost/max")
end

function IgorSkillLevupItem:refreshCost()
	local maxLevup = self:isMaxLevup()

	gohelper.setActive(self.goMax, maxLevup)
	gohelper.setActive(self.txtCost, not maxLevup)

	if maxLevup then
		SLFramework.UGUI.GuiHelper.SetColor(self.imgBtn, "#7B7B7B")

		return
	end

	local gameMO = IgorModel.instance:getCurGameMo()
	local curCost = gameMO:getGameCost()
	local cost = self:getCost()
	local isEnough = cost <= curCost

	self.txtCost.text = isEnough and tostring(cost) or string.format("<color=#B24444>%s</color>", cost)

	SLFramework.UGUI.GuiHelper.SetColor(self.imgBtn, isEnough and "#FFFFFF" or "#7B7B7B")
end

function IgorSkillLevupItem:isMaxLevup()
	local gameMO = IgorModel.instance:getCurGameMo()

	return gameMO:getOursideMo():isMaxLevel()
end

function IgorSkillLevupItem:onUseCard()
	AudioMgr.instance:trigger(AudioEnum3_3.Igor.play_ui_transverse_tabs_click)

	if self:isInCD() or self:isMaxLevup() or not self:isCostEnough() then
		return
	end

	local gameMO = IgorModel.instance:getCurGameMo()

	if not gameMO:getOursideMo():levelup() then
		return
	end

	self:refreshCost()
	self:enterCD()
end

function IgorSkillLevupItem:showTips()
	local datas = {}
	local desc = IgorConfig.instance:getConstValue2(IgorEnum.ConstId.LevelUpTips)
	local attr = string.split(desc, "#")

	table.insert(datas, {
		title = attr[1],
		desc = attr[2]
	})

	local screenPos = recthelper.uiPosToScreenPos(self.transform)
	local offsetX = 400
	local offsetY = 50

	ViewMgr.instance:openView(ViewName.IgorTipsView, {
		list = datas,
		pivot = Vector2(0.5, 0.5),
		screenPos = screenPos,
		offsetX = offsetX,
		offsetY = offsetY
	})
end

return IgorSkillLevupItem
