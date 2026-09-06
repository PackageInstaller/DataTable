-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hoshigami/view/HoshigamiequiptipBaseView.lua

module("logic.extensions.hoshigami.view.HoshigamiequiptipBaseView", package.seeall)

local HoshigamiequiptipBaseView = class("HoshigamiequiptipBaseView", TableViewComponent)

function HoshigamiequiptipBaseView:ctor()
	HoshigamiequiptipBaseView.super.ctor(self)

	self._isCompare = false
	self._hoshigamiId = false
	self._hoshigamiInfo = false
end

function HoshigamiequiptipBaseView:buildUI()
	HoshigamiequiptipBaseView.super.buildUI(self)

	self._strengthBtn = self:getBtn("root/btns/strengthBtn")
	self._takeoffBtn = self:getBtn("root/btns/takeoffBtn")
	self._takeonBtn = self:getBtn("root/btns/takeonBtn")
	self._iconGo = self:getGo("root/icon")
	self._wearTipTextGo = self:getGo("root/wearTipText")
	self._compareConGo = self:getGo("root/compareCon")
	self._rootTr = self:getGo("root").transform
	self._takeonBtnText = goutil.findChildTextComponent(self.mainGO, "root/btns/takeonBtn/text")
	self._activeCellGo = self:getGo("root/attr/activeCon/tableview")
	self._activeConGo = self:getGo("root/attr/activeCon/tablecell")
	self._activeScrollList = ScrollerList.create(self._activeCellGo, self._activeConGo, GameUtil.handler(self._updateActiveCell, self), GameUtil.handler(self._clearActiveCell, self))

	self._activeScrollList:regGetCellSize(GameUtil.handler(self._getActiveCellSize, self))

	self._attrUpConGo = self:getGo("root/attr/attrUpCon/tableview")
	self._attrUpCellGo = self:getGo("root/attr/attrUpCon/tablecell")
	self._attrScrollList = ScrollerList.create(self._attrUpConGo, self._attrUpCellGo, GameUtil.handler(self._updateAttrCell, self), GameUtil.handler(self._clearAttrCell, self))

	self._attrScrollList:regGetCellSize(GameUtil.handler(self._getAttrCellSize, self))

	self._TxtC_Test = goutil.findChildTextComponent(self.mainGO, "TxtC_Test")
	self._nameText = goutil.findChildTextComponent(self.mainGO, "root/nameText")
	self._powerText = goutil.findChildTextComponent(self.mainGO, "root/powerText")
	self._bgQualityChange = self:getGo("root/imgQuality"):GetComponent(ComponentType.UIImageSpriteChange)
end

function HoshigamiequiptipBaseView:bindEvents()
	HoshigamiequiptipBaseView.super.bindEvents(self)
	self._strengthBtn:AddClickListener(self._onClickstrengthBtn, self)
	self._takeoffBtn:AddClickListener(self._onClicktakeoffBtn, self)
	self._takeonBtn:AddClickListener(self._onClicktakeonBtn, self)
end

function HoshigamiequiptipBaseView:unbindEvents()
	HoshigamiequiptipBaseView.super.unbindEvents(self)
	self._strengthBtn:RemoveClickListener()
	self._takeoffBtn:RemoveClickListener()
	self._takeonBtn:RemoveClickListener()
end

function HoshigamiequiptipBaseView:destroyUI()
	HoshigamiequiptipBaseView.super.destroyUI(self)
end

function HoshigamiequiptipBaseView:onEnter()
	HoshigamiequiptipBaseView.super.onEnter(self)

	local params = self:getOpenParam()

	self._hoshigamiId = params[1]

	self:_initBase()
	self:_initActiveData()
	self:_initAttrData()
	self:_initSuitData()
	self:_initPower()
end

function HoshigamiequiptipBaseView:onEnterFinished()
	HoshigamiequiptipBaseView.super.onEnterFinished(self)
end

function HoshigamiequiptipBaseView:onExit()
	HoshigamiequiptipBaseView.super.onExit(self)
	MaterialMgr.resetAll(self._iconGo)
	self._activeScrollList:dispose()
	self._attrScrollList:dispose()
end

function HoshigamiequiptipBaseView:onExitFinished()
	HoshigamiequiptipBaseView.super.onExitFinished(self)
end

function HoshigamiequiptipBaseView:_onClickstrengthBtn()
	return
end

function HoshigamiequiptipBaseView:_onClicktakeonBtn()
	return
end

function HoshigamiequiptipBaseView:_onClicktakeoffBtn()
	return
end

function HoshigamiequiptipBaseView:_updateActiveCell(view, cell, data)
	local bgChange = cell.gameObject:GetComponent(ComponentType.UIChangeGroup)
	local txt = goutil.findChildTextComponent(cell.gameObject, "text")

	bgChange:SetState(data.isActive and 1 or 0)

	if data.isActive then
		local value = GameUtil.GetPropertyValue(data.data.proertyType, checknumber(string.format("%.4f", data.data.value)))

		txt.text = string.format("%s +%s", GameEnum.AttrTypeName[data.data.proertyType], value)
	else
		txt.text = string.format("强化+%s 激活", data.needLv)
	end
end

function HoshigamiequiptipBaseView:_clearActiveCell(cell)
	return
end

function HoshigamiequiptipBaseView:_getActiveCellSize(view, index)
	return 100, 100
end

function HoshigamiequiptipBaseView:_updateAttrCell(view, cell, data)
	local nameText = goutil.findChildTextComponent(cell.gameObject, "nameText")
	local currText = goutil.findChildTextComponent(cell.gameObject, "currText")

	nameText.text = GameEnum.AttrTypeName[data.id]
	currText.text = GameUtil.GetPropertyValue(data.id, data.value)
end

function HoshigamiequiptipBaseView:_clearAttrCell(cell)
	return
end

function HoshigamiequiptipBaseView:_getAttrCellSize(view, index)
	return 100, 30
end

function HoshigamiequiptipBaseView:_updateAttr()
	self._hoshigamiInfo = HoshigamiModel.instance:getHoshigamisInfo(self._hoshigamiId)

	self:_initAttrData()
end

function HoshigamiequiptipBaseView:_initPower()
	self._powerText.text = HoshigamiModel.instance:getFightingPower(self._hoshigamiId)
end

function HoshigamiequiptipBaseView:_initBase()
	self._hoshigamiInfo = HoshigamiModel.instance:getHoshigamisInfo(self._hoshigamiId)
	self._hoshigamiCfg = HoshigamiConfig.instance:getHoshigamiCfg(self._hoshigamiInfo.defineId)
	self._hoshigamiSuitCfg = HoshigamiConfig.instance:getSuitCfg(self._hoshigamiCfg.type)

	local lvPlan = HoshigamiModel.instance:getLvPlanIdByHoshigamiId(self._hoshigamiId)

	self._strengthCfgs = HoshigamiConfig.instance:getLvStrenCfg(lvPlan)
	self._nameText.text = self._hoshigamiCfg.name .. " +" .. self._hoshigamiInfo.lv

	self._bgQualityChange:SetState(self._hoshigamiCfg.quality)
	goutil.setActive(self._strengthBtn.gameObject, self._strengthCfgs[self._hoshigamiInfo.lv + 1])
end

function HoshigamiequiptipBaseView:_initActiveData()
	if not self._hoshigamiInfo then
		return
	end

	self._activePropDatas = {}

	if self._hoshigamiInfo.subPropertyApps then
		for i, v in ipairs(self._hoshigamiInfo.subPropertyApps) do
			table.insert(self._activePropDatas, {
				isActive = true,
				data = v
			})
		end
	end

	local activeNum = #self._activePropDatas
	local needLvActiveList = {}

	for i = 0, #self._strengthCfgs do
		if self._strengthCfgs[i].subPropPlan > 0 then
			if activeNum <= 0 then
				table.insert(needLvActiveList, self._strengthCfgs[i].level)
			else
				activeNum = activeNum - 1
			end
		end
	end

	table.sort(needLvActiveList, function(a, b)
		return a < b
	end)

	for i, v in ipairs(needLvActiveList) do
		table.insert(self._activePropDatas, {
			isActive = false,
			needLv = v
		})
	end

	self._activeScrollList:reloadData(self._activePropDatas)
end

function HoshigamiequiptipBaseView:_initAttrData()
	if not self._hoshigamiInfo then
		return
	end

	local currCfg = self._strengthCfgs[self._hoshigamiInfo.lv]
	local list = {}
	local res = FightingPowerFormula.instance:parseAttrValues(currCfg.mainPropertyApp) or {}

	for k, v in pairs(res) do
		table.insert(list, {
			id = k,
			value = v
		})
	end

	for i, v in ipairs(self._hoshigamiInfo.subPropertyApps) do
		res[v.proertyType] = (res[v.proertyType] or 0) + v.value
	end

	self._attrScrollList:reloadData(list)
end

function HoshigamiequiptipBaseView:_initSuitData()
	self._curViewDatas = {}

	local list = {}

	for k, v in pairs(self._hoshigamiSuitCfg) do
		table.insert(list, v)
	end

	table.sort(list, function(a, b)
		return a.count < b.count
	end)

	local currSuitInfos = self:getCurrSuitInfos()
	local currTypeActiveNum = 0
	local hCfg

	for k, v in pairs(currSuitInfos) do
		if self._hoshigamiCfg.type == HoshigamiConfig.instance:getHoshigamiCfg(v.defineId).type then
			currTypeActiveNum = currTypeActiveNum + 1
		end
	end

	for i, v in ipairs(list) do
		table.insert(self._curViewDatas, {
			isActive = currTypeActiveNum >= v.count,
			cfg = v
		})
	end

	self:reloadData()
end

function HoshigamiequiptipBaseView:getCurrSuitInfos()
	return {}
end

function HoshigamiequiptipBaseView:_getPath()
	return {
		cellPath = "root/suitcell",
		viewPath = "root/suitview"
	}
end

function HoshigamiequiptipBaseView:_updateCell(view, cell, data)
	local numText = goutil.findChildTextComponent(cell.gameObject, "numText")
	local effectText = goutil.findChildTextComponent(cell.gameObject, "effectText")

	numText.text = string.format("%s件：", data.cfg.count)
	effectText.text = data.cfg.desc
end

function HoshigamiequiptipBaseView:_clearTableview(cell)
	return
end

function HoshigamiequiptipBaseView:_cellSize(view, index)
	local data = self._curViewDatas[index + 1]

	return 100, self:_getTextHeight(data.cfg.desc) + 10
end

function HoshigamiequiptipBaseView:_getTextHeight(content)
	self._TxtC_Test.text = content

	return self._TxtC_Test.preferredHeight
end

function HoshigamiequiptipBaseView:_setRootPos(showCompareHoshigamiId)
	if showCompareHoshigamiId then
		GameUtil.setAnchoredPos(self._rootTr, -184, 0)
	else
		GameUtil.setAnchoredPos(self._rootTr, 0, 0)
	end
end

return HoshigamiequiptipBaseView
