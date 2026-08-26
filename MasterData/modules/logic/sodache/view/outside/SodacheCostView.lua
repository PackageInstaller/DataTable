-- chunkname: @modules/logic/sodache/view/outside/SodacheCostView.lua

module("modules.logic.sodache.view.outside.SodacheCostView", package.seeall)

local SodacheCostView = class("SodacheCostView", BaseView)

function SodacheCostView:onInitView()
	self._scrollContent = gohelper.findChildScrollRect(self.viewGO, "root/#scroll_Content")
	self._goTipItem = gohelper.findChild(self.viewGO, "root/#scroll_Content/viewport/content/#go_TipItem")
	self._goWinCost = gohelper.findChild(self.viewGO, "root/#scroll_Content/viewport/content/#go_WinCost")
	self._txtWinCost = gohelper.findChildText(self.viewGO, "root/#scroll_Content/viewport/content/#go_WinCost/#txt_WinCost")
	self._goFailCost = gohelper.findChild(self.viewGO, "root/#scroll_Content/viewport/content/#go_FailCost")
	self._txtFailCost = gohelper.findChildText(self.viewGO, "root/#scroll_Content/viewport/content/#go_FailCost/#txt_FailCost")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SodacheCostView:_editableInitView()
	return
end

function SodacheCostView:onOpen()
	local outSideMo = SodacheModel.instance:getOutsideMo()

	self._txtWinCost.text = outSideMo.attrContainer:getAttr(SodacheEnum.AttrId.WinCost)
	self._txtFailCost.text = outSideMo.attrContainer:getAttr(SodacheEnum.AttrId.FailCost)

	local attrMap = {}
	local buildType = SodacheEnum.BuildingType.Cost
	local buildLevel = outSideMo.buildingBox:getBuildingLv(buildType)
	local buildCfgs = lua_sodache_building.configDict[buildType]

	for i = 1, #buildCfgs do
		local config = buildCfgs[i]

		if buildLevel >= config.level then
			SodacheUtil.getGlobalAttrMap(config.globalAttri, attrMap)
		end
	end

	self:createTipItem(attrMap, "sodache_cost_buildlevel")

	attrMap = {}

	local level = outSideMo.prop.level
	local lvlCfgs = lua_sodache_level.configList

	for i = 1, #lvlCfgs do
		local config = lvlCfgs[i]

		if level >= config.level then
			SodacheUtil.getGlobalAttrMap(config.globalAttri, attrMap)
		end
	end

	self:createTipItem(attrMap, "sodache_cost_level")

	attrMap = {}

	local relics = outSideMo.relicBox.relics

	for _, mo in ipairs(relics) do
		local attrs = SodacheUtil.getRelicAttrs(mo.id, mo.level)

		for _, attr in ipairs(attrs) do
			SodacheUtil.getGlobalAttrMap(attr, attrMap)
		end
	end

	self:createTipItem(attrMap, "sodache_cost_relic")
	gohelper.setActive(self._goTipItem, false)
end

function SodacheCostView:createTipItem(attrMap, langKey)
	if not attrMap[30012] then
		local winCost = 0

		if not attrMap[30013] then
			local failCost = 0

			if winCost ~= 0 then
				local finalDesc = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang(langKey), winCost)
				local go = gohelper.cloneInPlace(self._goTipItem)

				gohelper.setSiblingAfter(go, self._goWinCost)

				local txtTip = gohelper.findChildText(go, "txt_Tip")

				txtTip.text = finalDesc
			end

			if failCost ~= 0 then
				langKey = langKey .. "_fail"

				local finalDesc = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang(langKey), failCost)
				local go = gohelper.cloneInPlace(self._goTipItem)

				gohelper.setSiblingAfter(go, self._goFailCost)

				local txtTip = gohelper.findChildText(go, "txt_Tip")

				txtTip.text = finalDesc
			end
		end
	end
end

return SodacheCostView
