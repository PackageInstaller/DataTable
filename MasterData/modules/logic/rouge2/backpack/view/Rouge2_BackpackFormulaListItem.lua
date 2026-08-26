-- chunkname: @modules/logic/rouge2/backpack/view/Rouge2_BackpackFormulaListItem.lua

module("modules.logic.rouge2.backpack.view.Rouge2_BackpackFormulaListItem", package.seeall)

local Rouge2_BackpackFormulaListItem = class("Rouge2_BackpackFormulaListItem", ListScrollCellExtend)

function Rouge2_BackpackFormulaListItem:onInitView()
	return
end

function Rouge2_BackpackFormulaListItem:initInternal(go, view)
	Rouge2_BackpackFormulaListItem.super.initInternal(self, go, view)

	self._goRoot = gohelper.findChild(go, "go_Root")
	self._goFormula = view:getResInst(Rouge2_Enum.ResPath.BackpackFormulaItem, self._goRoot, "formulaItem")

	local goScroll = gohelper.findChild(view.viewGO, view._param.scrollGOPath)

	self._scrollOverview = gohelper.findChild(self._goFormula, "go_Root/scroll_overview"):GetComponent(typeof(ZProj.LimitedScrollRect))
	self._scrollOverview.parentGameObject = goScroll
	self._simageFormulaIcon = gohelper.findChildSingleImage(self._goFormula, "go_Root/Relics/image_FormulaIcon")
	self._imageFormulaRare = gohelper.findChildImage(self._goFormula, "go_Root/Relics/image_FormulaRare")
	self._txtFormulaName = gohelper.findChildText(self._goFormula, "go_Root/Relics/txt_FormulaName")
	self._txtFormulaDesc = gohelper.findChildText(self._goFormula, "go_Root/scroll_overview/Viewport/Content/txt_Desc")
	self._goFormulaRoot = gohelper.findChild(self._goFormula, "go_Root")
	self._animator = gohelper.onceAddComponent(self._goFormulaRoot, gohelper.Type_Animator)

	SkillHelper.addHyperLinkClick(self._txtFormulaDesc)
	Rouge2_ItemDescHelper.addFixTmpBreakLine(self._txtFormulaDesc)
end

function Rouge2_BackpackFormulaListItem:addEvents()
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
end

function Rouge2_BackpackFormulaListItem:removeEvents()
	return
end

function Rouge2_BackpackFormulaListItem:onUpdateMO(formulaMo)
	self._formulaMo = formulaMo

	local formulaId = formulaMo:getItemId()
	local formulaCo = formulaMo:getConfig()

	self._txtFormulaName.text = formulaCo and formulaCo.name

	Rouge2_IconHelper.setFormulaIcon(formulaId, self._simageFormulaIcon)
	self:refreshDesc()
	self:showOpenAnim()
end

function Rouge2_BackpackFormulaListItem:refreshDesc()
	local alchemyInfo = self._formulaMo.alchemyInfo
	local mainEffect = alchemyInfo and alchemyInfo:getMainEffect()
	local subEffectList = alchemyInfo and alchemyInfo:getSubEffectList()
	local effectDescList = {}

	if mainEffect and mainEffect ~= 0 then
		local mainEffectDesc = Rouge2_ItemDescHelper.getItemDescStr(Rouge2_Enum.ItemDataType.Config, mainEffect)

		table.insert(effectDescList, mainEffectDesc)
	end

	if subEffectList then
		for _, subEffectId in ipairs(subEffectList) do
			if subEffectId ~= 0 then
				local subEffectDesc = Rouge2_ItemDescHelper.getItemDescStr(Rouge2_Enum.ItemDataType.Config, subEffectId)

				table.insert(effectDescList, subEffectDesc)
			end
		end
	end

	local effectDescStr = table.concat(effectDescList, "\n")

	Rouge2_ItemDescHelper.buildAndSetDesc(self._txtFormulaDesc, effectDescStr)
end

function Rouge2_BackpackFormulaListItem:showOpenAnim()
	self._canPlayOpenAnim = Rouge2_BackpackRelicsListModel.instance:canPlayAinm(self._index)

	local animName = self._canPlayOpenAnim and "open" or "normal"

	self._animator:Play(animName, 0, 0)
end

function Rouge2_BackpackFormulaListItem:_onCloseView(viewName)
	if viewName ~= ViewName.Rouge2_BackpackTabView then
		return
	end

	self._animator:Play("close", 0, 0)
end

function Rouge2_BackpackFormulaListItem:onDestroyView()
	return
end

return Rouge2_BackpackFormulaListItem
