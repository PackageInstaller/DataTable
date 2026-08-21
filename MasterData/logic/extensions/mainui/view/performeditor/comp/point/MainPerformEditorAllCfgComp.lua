-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/view/performeditor/comp/point/MainPerformEditorAllCfgComp.lua

module("logic.extensions.mainui.view.performeditor.comp.point.MainPerformEditorAllCfgComp", package.seeall)

local M = class("MainPerformEditorAllCfgComp", MainPerformEditorCompBase)

function M:ctor(mainGo)
	M.super.ctor(self, mainGo)
end

function M:buildUI()
	M.super.buildUI(self)

	local mainGO = self:getMainGo()

	self._txtStatus = goutil.findChildTextComponent(mainGO, "txtStatus")
	self._goCfgTemplate = goutil.findChild(mainGO, "item_cfg").gameObject

	goutil.setActive(self._goCfgTemplate, false)
end

function M:destroyUI()
	M.super.destroyUI(self)
	removetimer(self.refreshView, self)

	self._txtStatus = nil
	self._goCfgTemplate = nil

	self:_clearItems()
end

function M:bindEvents()
	M.super.bindEvents(self)
end

function M:unbindEvents()
	M.super.unbindEvents(self)
end

function M:onEnter()
	M.super.onEnter(self)
	self:refreshView()
end

function M:onExit()
	M.super.onExit(self)
	removetimer(self.refreshView, self)
end

function M:canShow()
	return true
end

function M:IsDataDirty()
	return false
end

function M:onEditHeroChange(heroId)
	settimer(0.3, self.refreshView, self, false)
end

function M:getHeroUnit()
	if not SceneFace.instance:isCurScene(SceneType.Room) then
		return nil
	end

	local curSceneFlow = SceneFace.instance:getCurSceneFlow()
	local point = self:getPoint()
	local unitHero = curSceneFlow.unitFactory:getUnitHeroByPoint(point)

	return unitHero
end

function M:refreshView()
	if self:getMainGo() and self:getMainGo().activeSelf then
		local heroUnit = self:getHeroUnit()
		local heroId = heroUnit and heroUnit:getHeroId() or nil
		local modelId = heroUnit and heroUnit:getModelId() or nil

		if heroId and heroId > 0 then
			self._txtStatus.text = string.format("%s (%s) %s", modelId, heroId, MainScenePerformUtil.getHeroName(heroId))

			self:_refreshItemLst()
		else
			self:_clearItems()

			self._txtStatus.text = string.format("交互点 %s , 没有角色", self:getPoint())
		end
	end
end

function M:_clearItems()
	for index, cell in pairs(self._itemLst or {}) do
		cell.destroyUI()
		goutil.destroy(cell.go)
	end

	self._itemLst = {}
end

function M:_refreshItemLst()
	local cfgHero, cfgTemplate = self:_getCfgAndTemplate()

	self:_clearItems()

	local len = #cfgTemplate.title - 1

	if len > 0 then
		for i = 2, #cfgTemplate.title do
			local cfgKey = cfgTemplate.title[i]
			local dataFormat = cfgTemplate.format[i]
			local titleName = cfgTemplate.titleName[i]

			self:_addItem(i)
			self._itemLst[i].updateTitle(cfgKey .. titleName)
			self._itemLst[i].updateInput(self:_cfg2Str(cfgHero[cfgKey], dataFormat))
		end
	end
end

function M:_addItem(index)
	if self._itemLst[index] then
		printError("已有index:", index)
	else
		local mainGO = self:getMainGo()
		local go = goutil.cloneAndSetParent(self._goCfgTemplate, mainGO.transform)
		local cell = self:_buildItem(go, index)

		goutil.setActive(go, true)

		self._itemLst[index] = cell
	end
end

function M:_buildItem(go, index)
	local data = {}

	data.go = go
	data.index = index
	data.txtIndex = goutil.findChildTextComponent(go, "step")
	data.input = UIComponentType.InputFieldAdapter(goutil.findChild(go, "input_output"))
	data.btnSave = UIComponentType.ButtonAdapter(goutil.findChild(go, "btnGroup/btnSave").gameObject)
	data.btnRest = UIComponentType.ButtonAdapter(goutil.findChild(go, "btnGroup/btnReset").gameObject)

	data.btnSave:AddClickListener(function()
		self:_onCellClickSave(index)
	end, self)
	data.btnRest:AddClickListener(function()
		self:_onCellClickRest(index)
	end, self)

	function data.destroyUI()
		data.btnSave:RemoveClickListener()
		data.btnRest:RemoveClickListener()
	end

	function data.getStr()
		return data.input:GetText()
	end

	function data.updateInput(str)
		data.input:SetText(str)
	end

	function data.updateTitle(str)
		data.txtIndex.text = str
	end

	function data.getTitle()
		return data.txtIndex.text
	end

	return data
end

function M:_onCellClickSave(index)
	local heroUnit = self:getHeroUnit()
	local modelId = heroUnit and heroUnit:getModelId() or nil
	local heroId = heroUnit and heroUnit:getHeroId() or nil

	if modelId and modelId > 0 then
		local tag = self:getPoint() == 0 and UnitTag.Player or UnitTag.Npc
		local cfgHero, cfgTemplate = self:_getCfgAndTemplate()
		local cfgKey = cfgTemplate.title[index]
		local dataFormat = cfgTemplate.format[index]
		local str = self._itemLst[index].getStr()
		local _writeData = {}

		if dataFormat == "array" then
			if string.nilorempty(str) then
				_writeData[cfgKey] = "nil"
			else
				_writeData[cfgKey] = {}

				local arrSingleStep = string.split(str, ",")

				for index, value in ipairs(arrSingleStep) do
					table.insert(_writeData[cfgKey], tonumber(value))
				end
			end
		elseif dataFormat == "arrayStr" then
			if string.nilorempty(str) then
				_writeData[cfgKey] = "nil"
			else
				_writeData[cfgKey] = {}

				local arrSingleStep = string.split(str, ",")

				for index, value in ipairs(arrSingleStep) do
					table.insert(_writeData[cfgKey], value)
				end
			end
		elseif dataFormat == "string" then
			_writeData[cfgKey] = str
		elseif dataFormat == "number" then
			_writeData[cfgKey] = string.nilorempty(str) and 0 or tonumber(str)
		else
			printError("暂不支持类型:", dataFormat)

			_writeData = nil
		end

		if _writeData then
			if tag == UnitTag.Player then
				MainScenePerformUtil.changeOrCreateLuaCfg(ConfigName.MainPerformLandladyR, MainPerformConfig.instance, modelId, _writeData)
			elseif tag == UnitTag.Npc then
				MainScenePerformUtil.changeOrCreateLuaCfg(ConfigName.MainPerformHeroR, MainPerformConfig.instance, modelId, _writeData)
			end
		end
	end
end

function M:_onCellClickRest(index)
	local cfgHero, cfgTemplate = self:_getCfgAndTemplate()

	for i = 2, #cfgTemplate.title do
		if index == i then
			local cfgKey = cfgTemplate.title[i]
			local dataFormat = cfgTemplate.format[i]

			self._itemLst[i].updateInput(self:_cfg2Str(cfgHero[cfgKey], dataFormat))
		end
	end
end

function M:_cfg2Str(cfgData, dataFormat)
	local str

	if cfgData then
		if dataFormat == "array" and (cfgData ~= "nil" or true) then
			str = table.concat(cfgData, ",")
		elseif dataFormat == "arrayStr" then
			str = nil

			if cfgData then
				str = table.concat(cfgData, ",")
			end
		elseif dataFormat == "string" then
			str = cfgData
		elseif dataFormat == "number" then
			str = cfgData and tonumber(cfgData) or 0
		else
			printError("暂不支持类型:", dataFormat)

			str = cfgData
		end
	end

	return str
end

function M:_getCfgAndTemplate()
	local cfgHero, cfgTemplate
	local heroUnit = self:getHeroUnit()
	local heroId = heroUnit and heroUnit:getHeroId() or nil
	local modelId = heroUnit and heroUnit:getModelId() or nil

	if modelId and modelId > 0 then
		local tag = self:getPoint() == 0 and UnitTag.Player or UnitTag.Npc

		if tag == UnitTag.Player then
			cfgTemplate = MainPerformEnum.Cfg2Template.main_perform_landlady_r
			cfgHero = MainPerformConfig.instance:getConfigByKey(ConfigName.MainPerformLandladyR, modelId)
		elseif tag == UnitTag.Npc then
			cfgTemplate = MainPerformEnum.Cfg2Template.main_perform_hero_r
			cfgHero = MainPerformConfig.instance:getConfigByKey(ConfigName.MainPerformHeroR, modelId)
		end
	end

	return cfgHero, cfgTemplate
end

return M
