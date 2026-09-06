-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hoshigami/view/HoshigamiprefabView.lua

module("logic.extensions.hoshigami.view.HoshigamiprefabView", package.seeall)

local HoshigamiprefabView = class("HoshigamiprefabView", TableViewComponent)
local CURRSUITID = -999
local NEWSUITID = -998

function HoshigamiprefabView:ctor()
	HoshigamiprefabView.super.ctor(self)
end

function HoshigamiprefabView:buildUI()
	HoshigamiprefabView.super.buildUI(self)

	self._useBtn = self:getBtn("useBtn")
	self._editBtn = self:getBtn("editBtn")
	self._closeBtn = self:getBtn("closeBtn")
	self._resetBtn = self:getBtn("resetBtn")
	self._equipComponent = GameUtil.AddLuaOnce(self:getGo("equipRoot"), HoshigamiEquipComponent)
	self._attrUpConGo = self:getGo("bottomRoot/attrRoot/tableview")
	self._attrUpCellGo = self:getGo("bottomRoot/attrRoot/tablecell")
	self._attrScrollList = ScrollerList.create(self._attrUpConGo, self._attrUpCellGo, GameUtil.handler(self._updateAttrCell, self), GameUtil.handler(self._clearAttrCell, self))

	self._attrScrollList:regGetCellSize(GameUtil.handler(self._getAttrCellSize, self))

	self._suitConGo = self:getGo("bottomRoot/suitRoot/tableview")
	self._suitCellGo = self:getGo("bottomRoot/suitRoot/tablecell")
	self._suitScrollList = ScrollerList.create(self._suitConGo, self._suitCellGo, GameUtil.handler(self._updateSuitCell, self), GameUtil.handler(self._clearSuitCell, self))

	self._suitScrollList:regGetCellSize(GameUtil.handler(self._getSuitCellSize, self))

	self._TxtC_Test = goutil.findChildTextComponent(self.mainGO, "TxtC_Test")
end

function HoshigamiprefabView:bindEvents()
	HoshigamiprefabView.super.bindEvents(self)
	self._useBtn:AddClickListener(self._onClickuseBtn, self)
	self._editBtn:AddClickListener(self._onClickeditBtn, self)
	self._closeBtn:AddClickListener(self._onClickcloseBtn, self)
	self._resetBtn:AddClickListener(self._onClickresetBtn, self)
end

function HoshigamiprefabView:unbindEvents()
	HoshigamiprefabView.super.unbindEvents(self)
	self._useBtn:RemoveClickListener()
	self._editBtn:RemoveClickListener()
	self._closeBtn:RemoveClickListener()
	self._resetBtn:RemoveClickListener()
end

function HoshigamiprefabView:destroyUI()
	HoshigamiprefabView.super.destroyUI(self)
end

function HoshigamiprefabView:onEnter()
	HoshigamiprefabView.super.onEnter(self)
	self._equipComponent:onEnter(self._switchEquipType, self)
	GlobalDispatcher:addListener(HoshigamiController.PM_GetAllHoshigamiPrefabSuitRes, self._updateView, self)
	GlobalDispatcher:addListener(HoshigamiController.PM_UnloadHoshigamiRes, self._updateView, self)
	GlobalDispatcher:addListener(HoshigamiController.PM_SaveHoshigamiPrefabSuitRes, self._updateView, self)
	GlobalDispatcher:addListener(HoshigamiController.PM_UseHoshigamiPrefabSuitRes, self._onUseSuitRes, self)

	self._petId = HoshigamiModel.instance:getCurrShowPetId()
	self._isFirstEnter = true

	HoshigamiAgent.instance:sendPM_GetAllHoshigamiPrefabSuitReq()
	self:_updateView()
end

function HoshigamiprefabView:onEnterFinished()
	HoshigamiprefabView.super.onEnterFinished(self)
end

function HoshigamiprefabView:onExit()
	HoshigamiprefabView.super.onExit(self)
	self._equipComponent:onExit()

	self._isFirstEnter = false

	GlobalDispatcher:removeListener(HoshigamiController.PM_GetAllHoshigamiPrefabSuitRes, self._updateView, self)
	GlobalDispatcher:removeListener(HoshigamiController.PM_UnloadHoshigamiRes, self._updateView, self)
	GlobalDispatcher:removeListener(HoshigamiController.PM_SaveHoshigamiPrefabSuitRes, self._updateView, self)
	GlobalDispatcher:removeListener(HoshigamiController.PM_UseHoshigamiPrefabSuitRes, self._onUseSuitRes, self)
	self._attrScrollList:dispose()
	self._suitScrollList:dispose()
end

function HoshigamiprefabView:onExitFinished()
	HoshigamiprefabView.super.onExitFinished(self)
end

function HoshigamiprefabView:_onClickuseBtn()
	if self._posDataList then
		local inUsePetIds = {}

		for i, info in pairs(self._posDataList) do
			if info.equippedPetId > 0 and info.equippedPetId ~= self._petId then
				table.insert(inUsePetIds, {
					petId = info.equippedPetId,
					hoshigamiId = info.hoshigamiId
				})
			end
		end

		local function okFunc()
			HoshigamiAgent.instance:sendPM_UseHoshigamiPrefabSuitReq(self._petId, self._lastSuitId)
		end

		if #inUsePetIds > 0 then
			UIStateManager.instance:push(ViewName.HoshigamireplaceView, inUsePetIds, okFunc)
		else
			okFunc()
		end
	end
end

function HoshigamiprefabView:_onClickeditBtn(isNew)
	local suitId = not isNew and self._lastSuitId

	UIStateManager.instance:push(ViewName.HoshigamieditprefabView, suitId)
end

function HoshigamiprefabView:_onClickcloseBtn()
	self:close()
end

function HoshigamiprefabView:_onClickresetBtn()
	local content = "是否确定重置此方案？"

	local function okFunc()
		local empty = {}

		HoshigamiModel.instance:setCurrEditPrefabIdList(self._lastSuitId, empty)
		HoshigamiAgent.instance:sendPM_SaveHoshigamiPrefabSuitReq(self._lastSuitId, empty)
	end

	if self._lastSuitId then
		TipsFacade.instance:openPopupWindow("提示", content, okFunc)
	end
end

function HoshigamiprefabView:_onClickicon1()
	self:_switchEquipType(1)
end

function HoshigamiprefabView:_onClickicon2()
	self:_switchEquipType(2)
end

function HoshigamiprefabView:_onClickicon3()
	self:_switchEquipType(3)
end

function HoshigamiprefabView:_onClickicon4()
	self:_switchEquipType(4)
end

function HoshigamiprefabView:_onClickicon5()
	self:_switchEquipType(5)
end

function HoshigamiprefabView:_onClickicon6()
	self:_switchEquipType(6)
end

function HoshigamiprefabView:_getPath()
	return {
		cellPath = "tablecell",
		viewPath = "tableview"
	}
end

function HoshigamiprefabView:_cellSize(view, index)
	return 100, 100
end

function HoshigamiprefabView:_updateCell(view, cell, data)
	local component = GameUtil.AddLuaOnce(cell.gameObject, HoshigamiprefabItem)

	component:onEnter(data, self._lastSuitId, self._onClickTab, self)
end

function HoshigamiprefabView:_clearTableview(cell)
	local component = GameUtil.GetLua(cell.gameObject, HoshigamiprefabItem)

	if component then
		component:onExit()
	end
end

function HoshigamiprefabView:_updateView()
	self._hoshigamis = HoshigamiModel.instance:getHoshigamisByPetId(self._petId)

	self:_preCalCurrAttrs()

	local hoshigamiIds = {}

	for i, v in ipairs(self._hoshigamis) do
		hoshigamiIds[i] = v.hoshigamiId
	end

	self._curViewDatas = {}

	local newSuitData = {
		suitId = NEWSUITID
	}
	local currSuitData = {
		suitId = CURRSUITID,
		hoshigamiIds = hoshigamiIds
	}

	table.insert(self._curViewDatas, newSuitData)
	table.insert(self._curViewDatas, currSuitData)

	local list = HoshigamiModel.instance:getPrefabSuit()

	for i, v in ipairs(list) do
		table.insert(self._curViewDatas, v)
	end

	self:reloadData()

	if self._isFirstEnter then
		self._lastSuitId = CURRSUITID
		self._isFirstEnter = false
	end

	self:_onClickTab(self._lastSuitId, true)
end

function HoshigamiprefabView:_onClickTab(id, force)
	if id == NEWSUITID then
		self:_onClickeditBtn(true)

		return
	end

	if self._lastSuitId == id and not force then
		return
	end

	self._lastSuitId = id

	for k, v in pairs(self._curViewDatas) do
		if v.suitId == id then
			self._currSuitData = v

			break
		end
	end

	self:_setBtnState(id)
	self:_setEquipItem()
	self:reloadData()
	self:_showCompareAttrs()
end

function HoshigamiprefabView:_setEquipItem()
	self._posDataList = {}

	if self._currSuitData then
		self._id2posList = self._id2posList or {}

		for i, id in ipairs(self._currSuitData.hoshigamiIds) do
			local info = HoshigamiModel.instance:getHoshigamisInfo(id)
			local cfg = HoshigamiConfig.instance:getHoshigamiCfg(info.defineId)

			self._id2posList[info.defineId] = cfg.positionType
			self._posDataList[cfg.positionType] = info
		end

		HoshigamiModel.instance:setCurrEditPrefabIdList(self._lastSuitId, self._currSuitData.hoshigamiIds)
	end

	self._equipComponent:setEquipItem(self._posDataList)
	self:_setSuitData()
end

function HoshigamiprefabView:_setSuitData()
	local hCfg
	local currTypeActiveNumList = {}

	for k, v in pairs(self._posDataList) do
		hCfg = HoshigamiConfig.instance:getHoshigamiCfg(v.defineId)
		currTypeActiveNumList[hCfg.type] = (currTypeActiveNumList[hCfg.type] or 0) + 1
	end

	self._suitDataList = {}

	for typeId, activeNum in pairs(currTypeActiveNumList) do
		local scfgs = HoshigamiConfig.instance:getSuitCfg(typeId)
		local sinfocfg = HoshigamiConfig.instance:getSuitInfo(typeId)

		for needNum, v in pairs(scfgs) do
			if needNum <= activeNum then
				table.insert(self._suitDataList, {
					typeId = typeId,
					activeNum = activeNum,
					desc = v.desc,
					name = sinfocfg.name
				})
			end
		end
	end

	table.sort(self._suitDataList, function(a, b)
		if a.typeId == b.typeId then
			return a.activeNum < b.activeNum
		else
			return a.typeId < b.typeId
		end
	end)
	self._suitScrollList:reloadData(self._suitDataList)
end

function HoshigamiprefabView:_switchEquipType(posType)
	local data = self._posDataList[posType]

	if data then
		UIStateManager.instance:push(ViewName.HoshigamieprefabquiptipsView, data.hoshigamiId, true)
	end
end

function HoshigamiprefabView:_setBtnState(id)
	goutil.setActive(self._useBtn.gameObject, id ~= CURRSUITID)
	goutil.setActive(self._resetBtn.gameObject, id ~= CURRSUITID)
	goutil.setActive(self._editBtn.gameObject, id ~= CURRSUITID)
end

function HoshigamiprefabView:_onUseSuitRes()
	self._lastSuitId = CURRSUITID

	self:_updateView()
end

function HoshigamiprefabView:_updateAttrCell(view, cell, data)
	local txtChange = goutil.findChild(cell.gameObject, "nextText"):GetComponent(ComponentType.UITextColorChange)
	local nameText = goutil.findChildTextComponent(cell.gameObject, "nameText")
	local currText = goutil.findChildTextComponent(cell.gameObject, "currText")
	local nextText = goutil.findChildTextComponent(cell.gameObject, "nextText")
	local imgDown = goutil.findChild(cell.gameObject, "imgDown")
	local imgUp = goutil.findChild(cell.gameObject, "imgUp")
	local name, value = GameUtil.getPropertyInfo(data.id, data.currValue)
	local isDown = data.currValue > data.nextValue

	txtChange:SetState(isDown and 1 or 0)
	goutil.setActive(imgDown, isDown)
	goutil.setActive(imgUp, not isDown)

	nameText.text = name
	currText.text = value

	if data.nextValue == 0 then
		nextText.text = 0
	else
		local _, value2 = GameUtil.getPropertyInfo(data.id, data.nextValue)

		nextText.text = value2
	end
end

function HoshigamiprefabView:_clearAttrCell(cell)
	return
end

function HoshigamiprefabView:_getAttrCellSize(view, index)
	return 100, 30
end

function HoshigamiprefabView:_updateSuitCell(view, cell, data)
	local nameText = goutil.findChildTextComponent(cell.gameObject, "nameText")
	local effectText = goutil.findChildTextComponent(cell.gameObject, "effectText")

	nameText.text = string.format("%s%s件套：", data.name, data.activeNum)
	effectText.text = data.desc
end

function HoshigamiprefabView:_clearSuitCell(cell)
	return
end

function HoshigamiprefabView:_getSuitCellSize(view, index)
	local data = self._suitDataList[index + 1]

	return 100, self:_getTextHeight(data.desc)
end

function HoshigamiprefabView:_preCalCurrAttrs()
	self._currWearEquipAttrs = HoshigamiModel.instance:getWearAttrList(self._petId, true) or {}
end

function HoshigamiprefabView:_showCompareAttrs()
	local hoshigamis = {}

	for i, id in ipairs(self._currSuitData.hoshigamiIds) do
		local info = HoshigamiModel.instance:getHoshigamisInfo(id)

		table.insert(hoshigamis, info)
	end

	local currSuitAttrs = HoshigamiModel.instance:getAttrByHoshigamis(hoshigamis) or {}
	local dataList = {}

	for id, value in pairs(currSuitAttrs) do
		self._currWearEquipAttrs[id] = self._currWearEquipAttrs[id] or 0
	end

	for id, value in pairs(self._currWearEquipAttrs) do
		local var_41_1 = {
			id = id,
			currValue = value
		}

		var_41_1.nextValue = currSuitAttrs[id] or 0

		table.insert(dataList, var_41_1)
	end

	self._attrScrollList:reloadData(dataList)
end

function HoshigamiprefabView:_getTextHeight(content)
	self._TxtC_Test.text = content

	return self._TxtC_Test.preferredHeight
end

return HoshigamiprefabView
