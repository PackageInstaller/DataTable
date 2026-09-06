-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hoshigami/view/HoshigamimainView.lua

module("logic.extensions.hoshigami.view.HoshigamimainView", package.seeall)

local HoshigamimainView = class("HoshigamimainView", TableViewComponent)

function HoshigamimainView:ctor()
	HoshigamimainView.super.ctor(self)
end

function HoshigamimainView:buildUI()
	HoshigamimainView.super.buildUI(self)

	self._suitPreviewBtn = self:getBtn("rightRoot/suitPreviewBtn")

	self:buildEquipItems()

	self._subCon = self:getGo("subCon")
	self._recommenItemConGo = self:getGo("rightRoot/recommenItemCon")
	self._recommenItemCellGo = self:getGo("rightRoot/recommenItemCon/cell")
	self.__recommenItemCGroup = ItemGroup.New(self._recommenItemConGo, self._recommenItemCellGo, nil, nil, true)
end

function HoshigamimainView:buildEquipItems()
	local equipCell = self:getGo("rightRoot/equipRoot/cell1")
	local equipRoot = self:getGo("rightRoot/equipRoot")

	self._equipItems = {}

	local goList = {
		equipCell
	}

	for i = 2, 6 do
		goList[i] = goutil.cloneAndSetParent(equipCell, equipRoot.transform, "cell" .. i)
	end

	for i, go in ipairs(goList) do
		local btn = Framework.ButtonAdapter.GetFrom(go, "raycast")
		local icon = goutil.findChild(go, "icon")
		local selectGo = goutil.findChild(go, "select")
		local lvText = goutil.findChildTextComponent(go, "lvText")
		local bgChang = go:GetComponent(typeof(UIChangeGroup))
		local iconBgGo = goutil.findChild(go, "icon/bg")

		self._equipItems[i] = {
			btn = btn,
			icon = icon,
			selectGo = selectGo,
			lvText = lvText,
			bgChang = bgChang
		}

		local pos = GameEnum.HoshigamiEquipItemPos[i]

		GameUtil.setAnchoredPos(go, pos.x, pos.y)
		Framework.TransformUtil.SetLocalRotation(selectGo.transform, 0, 0, pos.rotate)
		Framework.TransformUtil.SetLocalRotation(iconBgGo.transform, 0, 0, pos.rotate)
	end
end

function HoshigamimainView:bindEvents()
	HoshigamimainView.super.bindEvents(self)
	self._suitPreviewBtn:AddClickListener(self._onClicksuitPreviewBtn, self)

	for i, v in ipairs(self._equipItems) do
		v.btn:AddClickListener(function()
			self:_switchEquipType(i, true)
		end)
	end
end

function HoshigamimainView:unbindEvents()
	HoshigamimainView.super.unbindEvents(self)
	self._suitPreviewBtn:RemoveClickListener()

	for i, v in ipairs(self._equipItems) do
		v.btn:RemoveClickListener()
	end
end

function HoshigamimainView:destroyUI()
	HoshigamimainView.super.destroyUI(self)

	self._equipItems = nil
end

function HoshigamimainView:onEnter()
	HoshigamimainView.super.onEnter(self)
	GlobalDispatcher:addListener(HoshigamiController.UpdateSelectPosInBag, self._setSelect, self)
	GlobalDispatcher:addListener(HoshigamiController.PM_LoadAllHoshigamiRes, self._updateView, self)
	GlobalDispatcher:addListener(HoshigamiController.PM_EquipHoshigamiRes, self._equipHoshigamiRes, self)
	GlobalDispatcher:addListener(HoshigamiController.PM_UnloadHoshigamiRes, self._updateView, self)
	GlobalDispatcher:addListener(HoshigamiController.PM_UpgradeHoshigamiRes, self._updateView, self)
	HoshigamiController.instance:sendPM_LoadAllHoshigamiReq()

	self._currPosIndex = 1

	self:_updateView()
end

function HoshigamimainView:onEnterFinished()
	HoshigamimainView.super.onEnterFinished(self)
end

function HoshigamimainView:onExit()
	HoshigamimainView.super.onExit(self)
	GlobalDispatcher:removeListener(HoshigamiController.UpdateSelectPosInBag, self._setSelect, self)
	GlobalDispatcher:removeListener(HoshigamiController.PM_LoadAllHoshigamiRes, self._updateView, self)
	GlobalDispatcher:removeListener(HoshigamiController.PM_EquipHoshigamiRes, self._equipHoshigamiRes, self)
	GlobalDispatcher:removeListener(HoshigamiController.PM_UnloadHoshigamiRes, self._updateView, self)
	GlobalDispatcher:removeListener(HoshigamiController.PM_UpgradeHoshigamiRes, self._updateView, self)
	self:_resetEquipIcon()
end

function HoshigamimainView:_resetEquipIcon()
	for i, v in ipairs(self._equipItems) do
		MaterialMgr.resetAll(v.icon)
	end
end

function HoshigamimainView:onExitFinished()
	HoshigamimainView.super.onExitFinished(self)
end

function HoshigamimainView:_onClicksuitPreviewBtn()
	if self._petId then
		UIStateManager.instance:push(ViewName.HoshigamiprefabView, self._petId)
	end
end

function HoshigamimainView:_getPath()
	return {
		cellPath = "rightRoot/attrRoot/tablecell",
		viewPath = "rightRoot/attrRoot/tableview"
	}
end

function HoshigamimainView:_updateCell(view, cell, data)
	local attrIconChange = goutil.findChild(cell.gameObject, "attr"):GetComponent(ComponentType.UIImageSpriteChange)
	local nameText = goutil.findChildTextComponent(cell.gameObject, "nameText")
	local valueText = goutil.findChildTextComponent(cell.gameObject, "valueText")

	attrIconChange:SetState(data.id - 1)

	nameText.text = GameEnum.AttrTypeName[data.id]
	valueText.text = "+" .. GameUtil.GetPropertyValue(data.id, data.value)
end

function HoshigamimainView:_clearTableview(cell)
	return
end

function HoshigamimainView:_switchEquipType(posIndex, showTip)
	self:_setSelect(posIndex)

	if showTip then
		if ViewMgr.instance:isOpen(ViewName.HoshigamibagView) then
			GlobalDispatcher:dispatch(HoshigamiController.UpdateSelectPos, posIndex)
		else
			self:showTabAt(self._subCon, ViewName.HoshigamibagView, posIndex)
		end

		local data = self._posDataList[posIndex]

		if data then
			UIStateManager.instance:push(ViewName.HoshigamiequiptipsView, data.hoshigamiId, self._petId)
		end
	end
end

function HoshigamimainView:_setSelect(posIndex)
	self._currPosIndex = posIndex

	for i, v in ipairs(self._equipItems) do
		goutil.setActive(v.selectGo, posIndex == i)
	end
end

function HoshigamimainView:_updateView()
	self:_parseData()
	self:_setEquipItem()
	self:_switchEquipType(self._currPosIndex)
	self:_updateRecommend()
	self:_updateAttr()
end

function HoshigamimainView:_parseData()
	self._petId = HoshigamiModel.instance:getCurrShowPetId()
	self._hoshigamiList = HoshigamiModel.instance:getHoshigamisByPetId(self._petId) or {}
	self._id2posList = self._id2posList or {}
	self._posDataList = {}

	for i, v in ipairs(self._hoshigamiList) do
		local cfg = HoshigamiConfig.instance:getHoshigamiCfg(v.defineId)

		self._id2posList[v.defineId] = cfg.positionType
		self._posDataList[cfg.positionType] = v
	end
end

function HoshigamimainView:_setEquipItem()
	for i, v in ipairs(self._equipItems) do
		v.lvText.text = ""

		goutil.setActive(v.icon, false)
	end

	for posType, v in pairs(self._posDataList) do
		local cfg = HoshigamiConfig.instance:getHoshigamiCfg(v.defineId)
		local iconGo = self._equipItems[posType].icon

		if v.lv then
			self._equipItems[posType].lvText.text = "+" .. v.lv or ""
		end

		self._equipItems[posType].bgChang:SetState(cfg.quality)
		goutil.setActive(iconGo, true)
		MaterialMgr.setIcon(iconGo, MatType.Hoshigami, v.defineId)
	end
end

function HoshigamimainView:_updateRecommend()
	local raceId = HoshigamiModel.instance:getCurrShowPetRaceId()
	local cfg = HoshigamiConfig.instance:getRecommend(raceId)
	local list = cfg and cfg.typeIds

	self.__recommenItemCGroup:updateWithMoArray(list, function(item, id)
		local btn = GameUtil.asBtn(item.mainGO)

		btn:RemoveClickListener()
		btn:AddClickListener(function()
			UIStateManager.instance:push(ViewName.HoshigamirecommenView, id)
		end)
	end)
end

function HoshigamimainView:_updateAttr()
	local petId = HoshigamiModel.instance:getCurrShowPetId()

	self._curViewDatas = HoshigamiModel.instance:getWearAttrList(petId)

	self:reloadData()
end

function HoshigamimainView:_equipHoshigamiRes()
	self:_updateView()
end

return HoshigamimainView
