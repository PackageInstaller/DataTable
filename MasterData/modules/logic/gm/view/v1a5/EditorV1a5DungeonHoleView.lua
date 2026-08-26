-- chunkname: @modules/logic/gm/view/v1a5/EditorV1a5DungeonHoleView.lua

module("modules.logic.gm.view.v1a5.EditorV1a5DungeonHoleView", package.seeall)

local EditorV1a5DungeonHoleView = class("EditorV1a5DungeonHoleView", UserDataDispose)
local prefabUrl = "ui/viewres/gm/v1a5holeedit.prefab"

function EditorV1a5DungeonHoleView.start(viewContainer)
	local view = EditorV1a5DungeonHoleView.New()

	view:__onInit()
	view:init(viewContainer)

	return view
end

function EditorV1a5DungeonHoleView:init(viewContainer)
	local holeView = viewContainer._views[7]

	if holeView and not holeView.delete then
		holeView:onRecycleAllElement()
		holeView:onClose()
		holeView:onDestroyView()
		holeView:__onDispose()

		holeView.delete = true
	end

	self.viewGO = viewContainer.viewGO
	self.viewContainer = viewContainer
	self.viewName = viewContainer.viewName
	self._godispatcharea = gohelper.findChild(self.viewGO, "#go_dispatcharea")
	self._goareaitem = gohelper.findChild(self.viewGO, "#go_dispatcharea/#go_areaitem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function EditorV1a5DungeonHoleView:_editableInitView()
	gohelper.setActive(self._godispatcharea, true)
	gohelper.setActive(self._goareaitem, false)

	self.transform = self._godispatcharea:GetComponent(gohelper.Type_RectTransform)
	self.areaItemList = {}
	self.shaderParamList = self:getUserDataTb_()
	self.shaderParamValueList = {}

	for i = 1, VersionActivity1_5DungeonEnum.MaxHoleNum do
		table.insert(self.shaderParamList, UnityEngine.Shader.PropertyToID("_TransPos_" .. i))
		table.insert(self.shaderParamValueList, Vector4.zero)
	end

	self.sceneGo = self.viewContainer.mapScene:getSceneGo()
	self.sceneTrans = self.sceneGo.transform

	local shaderGo = gohelper.findChild(self.sceneGo, "Obj-Plant/FogOfWar/m_s14_hddt_mask")

	if not shaderGo then
		logError("not found shader mask go, " .. self.sceneGo.name)

		return
	end

	local meshRender = shaderGo:GetComponent(typeof(UnityEngine.MeshRenderer))

	self.shader = meshRender.sharedMaterial

	self:hideAllHoles()
	self:changeTestPos(0, 0)
	self.addEventCb(self, VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnMapPosChanged, self.onMapPosChanged, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self.onCloseView, self)

	self.loader = PrefabInstantiate.Create(self.viewGO)

	self.loader:startLoad(prefabUrl, self.onLoadFinish, self)
end

function EditorV1a5DungeonHoleView:onLoadFinish()
	self.itemList = {}
	self.go = self.loader:getInstGO()
	self.keyList = {
		"X",
		"Y"
	}

	for _, key in ipairs(self.keyList) do
		self:initItem(key)
	end

	self.closeBtn = gohelper.findChildButtonWithAudio(self.go, "closeBtn")

	self.closeBtn:AddClickListener(self.onClickCloseBtn, self)
end

function EditorV1a5DungeonHoleView:hideAllHoles()
	for index = 1, VersionActivity1_5DungeonEnum.MaxHoleNum do
		local value = self.shaderParamValueList[index]

		value:Set(VersionActivity1_5DungeonEnum.OutSideAreaPos.X, VersionActivity1_5DungeonEnum.OutSideAreaPos.Y)
		self.shader:SetVector(self.shaderParamList[index], value)
	end
end

function EditorV1a5DungeonHoleView:changeTestPos(x, y)
	self.configPosX = x
	self.configPosY = y

	self:onMapPosChanged()
end

function EditorV1a5DungeonHoleView:onMapPosChanged()
	local worldX, worldY
	local x, y, z = transformhelper.getPos(self.sceneTrans)
	local value = self.shaderParamValueList[1]

	value:Set(self.configPosX + x, self.configPosY + y)
	self.shader:SetVector(self.shaderParamList[1], value)
	self:refreshAreaItem(1)
end

function EditorV1a5DungeonHoleView:refreshAreaItem(index)
	local areaItem = self.areaItemList[index]

	areaItem = areaItem or self:createAreaItem()

	gohelper.setActive(areaItem.go, true)

	local worldPos = self.shaderParamValueList[index]
	local anchor = recthelper.worldPosToAnchorPos(worldPos, self.transform)

	recthelper.setAnchor(areaItem.rectTr, anchor.x, anchor.y + VersionActivity1_5DungeonEnum.AreaItemOffsetY)
end

function EditorV1a5DungeonHoleView:createAreaItem()
	local areaItem = self:getUserDataTb_()

	areaItem.go = gohelper.cloneInPlace(self._goareaitem)
	areaItem.rectTr = areaItem.go:GetComponent(gohelper.Type_RectTransform)

	table.insert(self.areaItemList, areaItem)

	return areaItem
end

function EditorV1a5DungeonHoleView:initItem(key)
	local item = self:getUserDataTb_()

	item.go = gohelper.findChild(self.go, "item" .. key)

	if not item.go then
		logError("not found item " .. tostring(key))

		return
	end

	item.txtValue = gohelper.findChildText(item.go, "value")
	item.reduceBtn = gohelper.findChildButtonWithAudio(item.go, "reducebtn")
	item.addBtn = gohelper.findChildButtonWithAudio(item.go, "addbtn")
	item.intervalInput = gohelper.findChildTextMeshInputField(item.go, "intervalInput")

	item.reduceBtn:AddClickListener(self.onClickReduceBtn, self, item)
	item.addBtn:AddClickListener(self.onClickAddBtn, self, item)

	item.value = 0
	item.txtValue.text = item.value

	item.intervalInput:SetText(1)
	table.insert(self.itemList, item)

	return item
end

function EditorV1a5DungeonHoleView:onClickReduceBtn(item)
	local interval = tonumber(item.intervalInput:GetText())

	if not interval then
		ToastController.instance:showToastWithString("间隔请输入数字")

		return
	end

	item.value = item.value - interval
	item.txtValue.text = item.value

	self:setConfigPos()
end

function EditorV1a5DungeonHoleView:onClickAddBtn(item)
	local interval = tonumber(item.intervalInput:GetText())

	if not interval then
		ToastController.instance:showToastWithString("间隔请输入数字")

		return
	end

	item.value = item.value + interval
	item.txtValue.text = item.value

	self:setConfigPos()
end

function EditorV1a5DungeonHoleView:setConfigPos()
	local x = self.itemList[1].value
	local y = self.itemList[2].value

	self:changeTestPos(x, y)
end

function EditorV1a5DungeonHoleView:onClickCloseBtn()
	self:close()
end

function EditorV1a5DungeonHoleView:onCloseView(viewName)
	if viewName == ViewName.VersionActivity1_5DungeonMapView then
		self:close()
	end
end

function EditorV1a5DungeonHoleView:close()
	for _, item in ipairs(self.itemList) do
		item.reduceBtn:RemoveClickListener()
		item.addBtn:RemoveClickListener()
	end

	for _, areaItem in ipairs(self.areaItemList) do
		gohelper.destroy(areaItem.go)
	end

	self.closeBtn:RemoveClickListener()
	gohelper.destroy(self.go)
	self:__onDispose()
end

return EditorV1a5DungeonHoleView
