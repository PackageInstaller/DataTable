-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/view/performeditor/comp/point/MainPerformEditorBgFormatComp.lua

module("logic.extensions.mainui.view.performeditor.comp.point.MainPerformEditorBgFormatComp", package.seeall)

local M = class("MainPerformEditorBgFormatComp", MainPerformEditorCompBase)

function M:ctor(mainGo)
	M.super.ctor(self, mainGo)
end

function M:buildUI()
	M.super.buildUI(self)

	local mainGO = self:getMainGo()

	self._canvasGroup = goutil.addComponentOnce(mainGO, ComponentType.CanvasGroup)
	self._btnShow = UIComponentType.ButtonAdapter(goutil.findChild(mainGO, "btnGroup/btnShow").gameObject)
	self._btnHide = UIComponentType.ButtonAdapter(goutil.findChild(mainGO, "btnGroup/btnHide").gameObject)
	self._btnSave = UIComponentType.ButtonAdapter(goutil.findChild(mainGO, "btnGroup/btnSave").gameObject)
	self._btnSaveAndExcute = UIComponentType.ButtonAdapter(goutil.findChild(mainGO, "btnGroup/btnSaveAndExcute").gameObject)
	self._dropPointComps = {
		self:_buildDropPointItem(goutil.findChild(mainGO, "item_p_1").gameObject, 1),
		self:_buildDropPointItem(goutil.findChild(mainGO, "item_p_2").gameObject, 2),
		(self:_buildDropPointItem(goutil.findChild(mainGO, "item_p_3").gameObject, 3))
	}
end

function M:destroyUI()
	M.super.destroyUI(self)

	for _, comps in pairs(self._dropPointComps) do
		comps.destroyUI()
	end
end

function M:bindEvents()
	M.super.bindEvents(self)
	self._btnShow:AddClickListener(self._onClickShow, self)
	self._btnHide:AddClickListener(self._onClickHide, self)
	self._btnSave:AddClickListener(self._onClickSave, self)
	self._btnSaveAndExcute:AddClickListener(self._onClickSaveAndExcute, self)
end

function M:unbindEvents()
	M.super.unbindEvents(self)
	self._btnShow:RemoveClickListener()
	self._btnHide:RemoveClickListener()
	self._btnSave:RemoveClickListener()
	self._btnSaveAndExcute:RemoveClickListener()
end

function M:onEnter()
	M.super.onEnter(self)

	self._canvasGroup.interactable = true

	self:refreshView()
end

function M:onExit()
	M.super.onExit(self)
end

function M:canShow()
	return true
end

function M:IsDataDirty()
	return false
end

function M:onEditHeroChange(heroId)
	return
end

function M:refreshView()
	if self:getMainGo() and self:getMainGo().activeSelf then
		self:_refreshDrop()
	end
end

function M:_onClickShow()
	local displayHero, displayHeroSkin = MainScenePerformUtil.getDisplayAdjutantHeroId()
	local forceSet = false
	local prefix = MainPerformEnum.AnimPrefix.Shafa
	local mixDuration
	local isChange = false

	MainScenePerformUtil.changeHeroReq(MainPerformEnum.ElementPointAdjutant, displayHero, displayHeroSkin, forceSet, prefix, mixDuration, isChange)
	MainScenePerformUtil.setBgHeroShow(true, true)
end

function M:_onClickHide()
	MainScenePerformUtil.setBgHeroShow(false, true, true)
end

function M:_onClickSave()
	local ele_1, hero_1, skin_1 = self._dropPointComps[1].getCurData()
	local ele_2, hero_2, skin_2 = self._dropPointComps[2].getCurData()
	local ele_3, hero_3, skin_3 = self._dropPointComps[3].getCurData()

	printWarn(string.format("[%s]%s %s, [%s]%s %s, [%s]%s %s", ele_1, hero_1, skin_1, ele_2, hero_2, skin_2, ele_3, hero_3, skin_3))

	local adjutantHero = MainScenePerformUtil.getDisplayAdjutantHeroId()

	if hero_1 == adjutantHero or hero_2 == adjutantHero or hero_3 == adjutantHero then
		FloatWordMgr.instance:show("设置角色与副官角色冲突，不能设置")

		return
	end

	local lastData = MainUIModel.instance:getLastBgPerformData()
	local pointPerformData = lastData.pointPerformData

	pointPerformData[1] = {
		point = 1,
		forceSet = true,
		heroId = hero_1,
		skinId = skin_1,
		elementId = ele_1
	}
	pointPerformData[2] = {
		point = 2,
		forceSet = true,
		heroId = hero_2,
		skinId = skin_2,
		elementId = ele_2
	}
	pointPerformData[3] = {
		point = 3,
		forceSet = true,
		heroId = hero_3,
		skinId = skin_3,
		elementId = ele_3
	}

	local recordTime = true

	MainUIModel.instance:setLastBgPerformFormula(lastData.formulaId, pointPerformData, recordTime, false)
end

function M:_onClickSaveAndExcute()
	self._canvasGroup.interactable = false

	self:_onClickSave()
	self:_onClickHide()
	settimer(0.3, function()
		self:_onClickShow()

		if self._canvasGroup then
			self._canvasGroup.interactable = true
		end
	end, self, false)
end

function M:_onDropEle(point, index)
	local cfgLst = MainPerformConfig.instance:getElementLstByPointId(point)
	local cfg = cfgLst[index + 1]
	local elementId = cfg and cfg.id or -1

	self._dropPointComps[point].setTxtEle(elementId > 0 and MainScenePerformUtil.getElementName(elementId) or "nil")

	local idLst, nameLst, modelIds, skinIds, skinNames, tabNameLst, tabSkinName = self:_getHeroDropListData(point)

	self._dropPointComps[point].updateDropHero(tabNameLst)
	self._dropPointComps[point].setSelectHero(0)
	self._dropPointComps[point].setTxtHero(tabNameLst[1])
	self._dropPointComps[point].updateDropSkin(tabSkinName)
	self._dropPointComps[point].setSelectSkin(0)
	self._dropPointComps[point].setTxtSkin(tabSkinName[1])
end

function M:_onDropHero(point, index)
	local idLst, nameLst, modelIds, skinIds, skinNames, tabNameLst, tabSkinName = self:_getHeroDropListData(point)
	local newHeroId = idLst[index + 1]
	local newHeroName = tabNameLst[index + 1] or "nil"

	if not newHeroId then
		FloatWordMgr.instance:show(string.format("无法定位index[%s]对应的heroId", index))
	end

	self._dropPointComps[point].setTxtHero(newHeroName)
	self._dropPointComps[point].updateDropSkin(tabSkinName)
	self._dropPointComps[point].setSelectSkin(0)
	self._dropPointComps[point].setTxtSkin(tabSkinName[1])
end

function M:_onDropSkin(point, index)
	local idLst, nameLst, modelIds, skinIds, skinNames, tabNameLst, tabSkinName = self:_getHeroDropListData(point)
	local newSkinId = skinIds[index + 1]
	local newSkinName = tabSkinName[index + 1] or "nil"

	if not newSkinId then
		FloatWordMgr.instance:show(string.format("无法定位index[%s]对应的skinId", index))
	end

	self._dropPointComps[point].setTxtSkin(newSkinName)
end

function M:_getHeroDropListData(point)
	local idLst, nameLst, modelIds, skinIds, skinNames = MainScenePerformUtil.getHeroDropLstData(point)

	table.insert(idLst, 1, -1)
	table.insert(nameLst, 1, "无")
	table.insert(modelIds, 1, 0)
	table.insert(skinIds, 1, 0)
	table.insert(skinNames, 1, "")

	local tabNameLst = {}
	local tabSkinName = {}

	for _index, _id in ipairs(idLst) do
		local name = _id > 0 and string.format("%s %s", modelIds[_index], nameLst[_index]) or nameLst[_index]

		if not string.nilorempty(skinNames[_index]) then
			name = string.format("%s-%s", name, skinNames[_index])
		end

		table.insert(tabNameLst, name)

		local skinName = skinIds[_index] > 0 and string.format("%s-%s", skinIds[_index], skinNames[_index]) or "--原皮肤--"

		table.insert(tabSkinName, skinName)
	end

	return idLst, nameLst, modelIds, skinIds, skinNames, tabNameLst, tabSkinName
end

function M:_refreshDrop()
	local lastData = MainUIModel.instance:getLastBgPerformData()
	local pointPerformData = lastData.pointPerformData

	for _, comps in pairs(self._dropPointComps) do
		local elementLst = {}
		local selectIndex = 1
		local point = comps.getPointId()

		if pointPerformData[point] then
			local cfgLst = MainPerformConfig.instance:getElementLstByPointId(point)
			local elementId = pointPerformData[point].elementId

			for index, cfg in ipairs(cfgLst) do
				table.insert(elementLst, MainScenePerformUtil.getElementName(cfg.id))

				if elementId == cfg.id then
					selectIndex = index
				end
			end
		end

		comps.updateDropEle(elementLst)
		comps.setSelectEle(selectIndex - 1)
		comps.setTxtEle(elementLst[selectIndex])
	end

	for _, comps in pairs(self._dropPointComps) do
		local point = comps.getPointId()
		local idLst, nameLst, modelIds, skinIds, skinNames, tabNameLst, tabSkinName = self:_getHeroDropListData(point)

		comps.updateDropSkin(tabSkinName)

		local selectIndex = 1

		if pointPerformData[point] then
			selectIndex = table.indexof(skinIds, pointPerformData[point].skinId) or 1
		end

		comps.setSelectSkin(selectIndex - 1)
		comps.setTxtSkin(tabSkinName[selectIndex])
	end

	for _, comps in pairs(self._dropPointComps) do
		local point = comps.getPointId()
		local idLst, nameLst, modelIds, skinIds, skinNames, tabNameLst, tabSkinName = self:_getHeroDropListData(point)

		comps.updateDropHero(tabNameLst)

		local selectIndex = 1

		if pointPerformData[point] then
			selectIndex = table.indexof(idLst, pointPerformData[point].heroId) or 1
		end

		comps.setSelectHero(selectIndex - 1)
		comps.setTxtHero(tabNameLst[selectIndex])

		if skinIds[selectIndex] and skinIds[selectIndex] > 0 then
			comps.setSelectSkin(selectIndex - 1, false)
			comps.setTxtSkin(tabSkinName[selectIndex])
		end
	end
end

function M:_buildDropPointItem(go, pointId)
	local data = {}

	data.go = go
	data.pointId = pointId
	data.dropEle = goutil.findChildComponent(go, "element/dropDown", UIComponentType.Dropdown)
	data.dropEleAdapter = goutil.findChildComponent(go, "element/dropDown", UIComponentType.DropdownApapter)
	data.txtDropEle = goutil.findChildComponent(go, "element/dropDown/Label", UIComponentType.Text)
	data.dropHero = goutil.findChildComponent(go, "hero/dropDown", UIComponentType.Dropdown)
	data.dropHeroAdapter = goutil.findChildComponent(go, "hero/dropDown", UIComponentType.DropdownApapter)
	data.txtDropHero = goutil.findChildComponent(go, "hero/dropDown/Label", UIComponentType.Text)
	data.dropSkin = goutil.findChildComponent(go, "skin/dropDown", UIComponentType.Dropdown)
	data.dropSkinAdapter = goutil.findChildComponent(go, "skin/dropDown", UIComponentType.DropdownApapter)
	data.txtDropSkin = goutil.findChildComponent(go, "skin/dropDown/Label", UIComponentType.Text)

	function data.getPointId()
		return data.pointId
	end

	function data.setTxtEle(str)
		data.txtDropEle.text = str
	end

	function data.setTxtHero(str)
		data.txtDropHero.text = str
	end

	function data.setTxtSkin(str)
		data.txtDropSkin.text = str
	end

	function data.setSelectEle(index, notify)
		if notify then
			data.dropEle.value = index
		else
			data.dropEle:SetValueWithoutNotify(index)
		end
	end

	function data.setSelectHero(index, notify)
		if notify then
			data.dropHero.value = index
		else
			data.dropHero:SetValueWithoutNotify(index)
		end
	end

	function data.setSelectSkin(index, notify)
		if notify then
			data.dropSkin.value = index
		else
			data.dropSkin:SetValueWithoutNotify(index)
		end
	end

	function data.updateDropEle(nameLst)
		MainScenePerformUtil.updateDropDownLst(data.dropEle, nameLst)
	end

	function data.updateDropHero(nameLst)
		MainScenePerformUtil.updateDropDownLst(data.dropHero, nameLst)
	end

	function data.updateDropSkin(nameLst)
		MainScenePerformUtil.updateDropDownLst(data.dropSkin, nameLst)
	end

	function data.getCurData()
		local idLst, nameLst, modelIds, skinIds, skinNames, tabNameLst = self:_getHeroDropListData(data.getPointId())
		local cfgLst = MainPerformConfig.instance:getElementLstByPointId(data.getPointId())
		local cfg = cfgLst[data.dropEle.value + 1]
		local elementId = cfg and cfg.id or -1
		local heroId = idLst[data.dropHero.value + 1] or -1
		local skinId = skinIds[data.dropHero.value + 1] or 0

		return elementId, heroId, skinId
	end

	function data.destroyUI()
		data.dropEleAdapter:RemoveClickListener()
		data.dropHeroAdapter:RemoveClickListener()
		data.dropSkinAdapter:RemoveClickListener()
	end

	data.dropEleAdapter:AddListener(function(comp, index)
		self:_onDropEle(data.getPointId(), index)
	end, self)
	data.dropHeroAdapter:AddListener(function(comp, index)
		self:_onDropHero(data.getPointId(), index)
	end, self)
	data.dropSkinAdapter:AddListener(function(comp, index)
		self:_onDropSkin(data.getPointId(), index)
	end, self)

	return data
end

return M
