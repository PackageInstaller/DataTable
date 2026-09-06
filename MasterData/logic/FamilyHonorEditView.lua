-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newfamily/view/FamilyHonorEditView.lua

module("logic.extensions.newfamily.view.FamilyHonorEditView", package.seeall)

local FamilyHonorEditView = class("FamilyHonorEditView", TableViewComponent)

function FamilyHonorEditView:ctor()
	FamilyHonorEditView.super.ctor(self)

	self._btnItemList = nil
	self._honorItemList = nil
	self._searchStr = nil
	self._labelTypes = nil
	self._htDragLua = nil
	self._dragingItem = nil
	self._dragingInfo = nil
	self._offsetValue = nil
	self._gridRectWidth = nil
	self._gridRectHeight = nil
	self._onceGridSize = nil
end

function FamilyHonorEditView:bindEvents()
	FamilyHonorEditView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._previewBtn:AddClickListener(self._onClickPreviewBtn, self)
	self._resetBtn:AddClickListener(self._onClickResetBtn, self)
	self._saveBtn:AddClickListener(function()
		FamilyHonorController.instance:csRequestFamilyMedalSetMedalWallReq()
	end, self)
	self._clearBtn:AddClickListener(function()
		self._searchIpt:SetText("")
	end, self)
	self._filterBtn:AddClickListener(function()
		GameUtil.SetActive(self._filtersGo, true)
	end, self)

	if self._btnItemList and #self._btnItemList > 0 then
		for i = 1, #self._btnItemList do
			if self._btnItemList[i] then
				self._btnItemList[i]:AddClickListener(function()
					self:_onClickLabelBtnShow(i)
				end, self)
			end
		end
	end

	GameUtil.asBtn(self._clickGo):AddClickListener(function()
		GameUtil.SetActive(self._filtersGo, false)
	end, self)

	self._searchIptChangedHandler = InputFieldValueChangedHandler.Get(self._searchIpt.gameObject):AddLuaHandler(function(go, txt)
		self:_onSearchIptChanged(txt)
	end)
end

function FamilyHonorEditView:unbindEvents()
	FamilyHonorEditView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._previewBtn:RemoveClickListener()
	self._resetBtn:RemoveClickListener()
	self._saveBtn:RemoveClickListener()
	self._clearBtn:RemoveClickListener()
	self._filterBtn:RemoveClickListener()
	GameUtil.asBtn(self._clickGo):RemoveClickListener()

	for _, btn in pairs(self._btnItemList or {}) do
		if btn then
			btn:RemoveClickListener()
		end
	end

	InputFieldValueChangedHandler.Get(self._searchIpt.gameObject):RemoveLuaHandler(self._searchIptChangedHandler)
end

function FamilyHonorEditView:onExit()
	FamilyHonorEditView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdataNewFamilyHonorInfo, self._updataHonorViewShow, self)

	self._searchStr = nil
	self._labelTypes = nil
	self._dragingInfo = nil
	self._offsetValue = nil
	self._onceGridSize = nil
	self._htDragLua = nil
end

function FamilyHonorEditView:destroyUI()
	FamilyHonorEditView.super.destroyUI(self)

	for _, item in pairs(self._honorItemList or {}) do
		if item then
			if item.iconImaGo then
				uGuiUtil.clearImage(item.iconImaGo)
			end

			if item.itemGo then
				UnityEngine.GameObject.Destroy(item.itemGo)
			end
		end
	end

	self._honorItemList = nil

	if self._dragingItem and self._dragingItem.itemGo then
		UnityEngine.GameObject.Destroy(self._dragingItem.itemGo)
	end

	self._dragingItem = nil
	self._gridRectWidth = nil
	self._gridRectHeight = nil
end

function FamilyHonorEditView:buildUI()
	FamilyHonorEditView.super.buildUI(self)

	self._closeBtn = self:getBtn("closeBtn")

	local wallInfoGo = self:getGo("wallInfoGo")

	self._itemGridTran = goutil.findChild(wallInfoGo, "itemGridTran").transform
	self._honorItem = goutil.findChild(wallInfoGo, "honorItem")
	self._areaIma = goutil.findChild(wallInfoGo, "itemGridTran/areaIma"):GetComponent("UIImageSpriteChange")
	self._previewBtn = Framework.ButtonAdapter.GetFrom(wallInfoGo, "previewBtn")
	self._resetBtn = Framework.ButtonAdapter.GetFrom(wallInfoGo, "resetBtn")

	local listInfoGo = self:getGo("listInfoGo")

	self._saveBtn = Framework.ButtonAdapter.GetFrom(listInfoGo, "saveBtn")
	self._clearBtn = Framework.ButtonAdapter.GetFrom(listInfoGo, "clearBtn")
	self._filterBtn = Framework.ButtonAdapter.GetFrom(listInfoGo, "filterBtn")
	self._searchIpt = Framework.InputFieldAdapter.GetFrom(listInfoGo, "searchIpt")
	self._emptyGo = goutil.findChild(listInfoGo, "emptyGo")
	self._filtersGo = self:getGo("filtersGo")
	self._btnItemList = {
		Framework.ButtonAdapter.GetFrom(self._filtersGo, "btnItem_1"),
		Framework.ButtonAdapter.GetFrom(self._filtersGo, "btnItem_2"),
		Framework.ButtonAdapter.GetFrom(self._filtersGo, "btnItem_3"),
		Framework.ButtonAdapter.GetFrom(self._filtersGo, "btnItem_4"),
		Framework.ButtonAdapter.GetFrom(self._filtersGo, "btnItem_5"),
		Framework.ButtonAdapter.GetFrom(self._filtersGo, "btnItem_6")
	}
	self._clickGo = goutil.findChild(self._filtersGo, "clickGo")

	GameUtil.SetActive(self._honorItem, false)
	GameUtil.SetActive(self._areaIma, false)
	GameUtil.SetActive(self._filtersGo, false)
end

function FamilyHonorEditView:onEnter()
	FamilyHonorEditView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.UpdataNewFamilyHonorInfo, self._updataHonorViewShow, self)
	self._searchIpt:SetText("")

	self._gridRectWidth = goutil.getWidth(self._itemGridTran)
	self._gridRectHeight = goutil.getHeight(self._itemGridTran)
	self._onceGridSize = self._gridRectWidth / FamilyHonorModel.instance.wallWide
	self._offsetValue = 10
	self._dragingInfo = nil
	self._searchStr = nil
	self._labelTypes = nil

	self:_updataHonorViewShow()
end

function FamilyHonorEditView:_updataHonorViewShow()
	self:_showLeftHonorWallInfo()
	self:_updateShowRightHonor()
end

function FamilyHonorEditView:_showLeftHonorWallInfo()
	local wallInfo = FamilyHonorModel.instance:getEditHonorWallInfo()

	self._honorItemList = self._honorItemList or {}

	if wallInfo then
		if not #wallInfo then
			local count = 0

			for i = 1, count do
				self:_showLeftWallHonorItem(wallInfo[i], i)
			end

			if count >= #self._honorItemList then
				return
			end

			for i = count + 1, #self._honorItemList do
				if self._honorItemList[i] then
					if self._honorItemList[i].handle then
						DragHandler.Get(self._honorItemList[i].itemGo):RemoveLuaHandler(self._honorItemList[i].handle)

						self._honorItemList[i].handle = nil
					end

					if self._honorItemList[i].beginHandle then
						BeginDragHandler.Get(self._honorItemList[i].itemGo):RemoveLuaHandler(self._honorItemList[i].beginHandle)

						self._honorItemList[i].beginHandle = nil
					end

					if self._honorItemList[i].endHandle then
						EndDragHandler.Get(self._honorItemList[i].itemGo):RemoveLuaHandler(self._honorItemList[i].endHandle)

						self._honorItemList[i].endHandle = nil
					end

					if self._honorItemList[i].iconImaGo then
						uGuiUtil.clearImage(self._honorItemList[i].iconImaGo)
					end

					if self._honorItemList[i].itemGo then
						GameUtil.SetActive(self._honorItemList[i].itemGo, false)
					end
				end
			end
		end
	end
end

function FamilyHonorEditView:_showLeftWallHonorItem(info, index)
	if info == nil or checknumber(info.defineId) <= 0 then
		return
	end

	if self._honorItemList[index] == nil or self._honorItemList[index].itemGo == nil then
		self._honorItemList[index] = {}

		local go = UnityEngine.GameObject.Instantiate(self._honorItem, self._itemGridTran)

		GameUtil.SetActive(go, true)

		self._honorItemList[index] = {}
		self._honorItemList[index].itemGo = go
		self._honorItemList[index].canvasGroup = go:GetComponent(typeof(UnityEngine.CanvasGroup))
		self._honorItemList[index].kuangIma = goutil.findChild(go, "kuangIma"):GetComponent("UIImageSpriteChange")
		self._honorItemList[index].iconImaGo = goutil.findChild(go, "iconImaGo")
	else
		GameUtil.SetActive(self._honorItemList[index].itemGo, true)
	end

	self._honorItemList[index].canvasGroup.alpha = 1

	local component = HonorItemDrag.AddOnce(self._honorItemList[index].itemGo)
	local cfg = FamilyHonorConfig.instance:getFamilyMedalCfg(info.defineId)

	component:initCacheData({
		info = info,
		cfg = cfg
	})

	local item = self._honorItemList[index]

	GameUtil.setWidth(item.itemGo, self._onceGridSize * cfg.width)
	GameUtil.setHeight(item.itemGo, self._onceGridSize * cfg.height)

	local iconPath = "ui/bigbg/familycallorder/" .. cfg.icon .. ".png"

	uGuiUtil.setSpriteToImage(item.iconImaGo, uGuiUtil.SpriteType.BigBg, iconPath)
	GameUtil.setAnchoredPos(item.itemGo, info.positionX * self._onceGridSize, -info.positionY * self._onceGridSize)
	item.kuangIma:SetState(cfg.level - 1)

	if item.handle == nil then
		item.handle = DragHandler.Get(item.itemGo):AddLuaHandler(function(go, data)
			self:_OnDragHonorMove(go, data)
		end)
	end

	if item.beginHandle == nil then
		item.beginHandle = BeginDragHandler.Get(item.itemGo):AddLuaHandler(function(go, data)
			self:_OnDragHonorBegin(go, data)
		end)
	end

	if item.endHandle == nil then
		item.endHandle = EndDragHandler.Get(item.itemGo):AddLuaHandler(function(go, data)
			self:_OnDragHonorEnd(go, data)
		end)
	end
end

function FamilyHonorEditView:_OnDragHonorBegin(go, data)
	self._dragingInfo = nil

	GameUtil.SetActive(self._areaIma, false)

	self._htDragLua = HonorItemDrag.Get(go)

	if self._dragingItem == nil or self._dragingItem.itemGo == nil then
		local itemGo = UnityEngine.GameObject.Instantiate(self._honorItem, self._itemGridTran)

		self._dragingItem = {}
		self._dragingItem.itemGo = itemGo
		self._dragingItem.kuangIma = goutil.findChild(itemGo, "kuangIma"):GetComponent("UIImageSpriteChange")
		self._dragingItem.iconImaGo = goutil.findChild(itemGo, "iconImaGo")
	end

	self._dragingItem.itemGo.transform:SetAsLastSibling()
	GameUtil.SetActive(self._dragingItem.itemGo, true)

	local cfg = self._htDragLua:getHonorCfg()

	GameUtil.setWidth(self._dragingItem.itemGo, self._onceGridSize * cfg.width)
	GameUtil.setHeight(self._dragingItem.itemGo, self._onceGridSize * cfg.height)

	local iconPath = "ui/bigbg/familycallorder/" .. cfg.icon .. ".png"

	uGuiUtil.setSpriteToImage(self._dragingItem.iconImaGo, uGuiUtil.SpriteType.BigBg, iconPath)
	self._dragingItem.kuangIma:SetState(cfg.level - 1)
	self:_getDragItemPosition(self._dragingItem.itemGo)
	self:_setWallItemAlpha(cfg.id, 0.5)
end

function FamilyHonorEditView:_OnDragHonorMove(go, data)
	if self._htDragLua == nil then
		return
	end

	local ahdPos = self:_getDragItemPosition(self._dragingItem.itemGo)

	self:_onDragCalculatePos(ahdPos)
end

function FamilyHonorEditView:_OnDragHonorEnd(go, data)
	if self._htDragLua == nil then
		return
	end

	GameUtil.SetActive(self._areaIma, false)
	uGuiUtil.clearImage(self._dragingItem.iconImaGo)

	local ahdPos = GameUtil.getAnchoredPos(self._dragingItem.itemGo)

	GameUtil.SetActive(self._dragingItem.itemGo, false)
	self:_checkingConform(ahdPos)

	self._htDragLua = nil
end

function FamilyHonorEditView:_onSearchIptChanged(txt)
	if txt ~= self._searchStr then
		self._searchStr = txt
		self._labelTypes = {}

		self:_updateShowRightHonor()
	end
end

function FamilyHonorEditView:_onClickLabelBtnShow(number)
	self._searchStr = nil
	self._labelTypes = self._labelTypes or {}

	local index = table.indexof(self._labelTypes, number)

	if index then
		table.remove(self._labelTypes, index)
	else
		table.insert(self._labelTypes, number)
	end

	self:_updateShowRightHonor()
end

function FamilyHonorEditView:_updateShowRightHonor()
	for i = 1, #self._btnItemList do
		if self._labelTypes and #self._labelTypes > 0 and table.indexof(self._labelTypes, i) then
			self._btnItemList[i].gameObject:GetComponent("UIChangeGroup"):SetState(1)
		else
			self._btnItemList[i].gameObject:GetComponent("UIChangeGroup"):SetState(0)
		end
	end

	self._curViewDatas = not string.nilorempty(self._searchStr) and FamilyHonorModel.instance:getRightHonorInfoList(self._searchStr, nil) or FamilyHonorModel.instance:getRightHonorInfoList(nil, self._labelTypes)

	if self._curViewDatas == nil or #self._curViewDatas == 0 then
		GameUtil.SetActive(self._emptyGo, true)
	else
		GameUtil.SetActive(self._emptyGo, false)
	end

	self._tableview:ReloadData()
end

function FamilyHonorEditView:_onClickPreviewBtn()
	local info = FamilyModel.instance:getMyFamilyInfo()

	if info == nil or info.settings == nil then
		return
	end

	local params = {}

	params.familyId = info.familyId
	params.familyName = info.settings.familyName
	params.chiefName = info.cheifName
	params.honorList = FamilyHonorModel.instance:getEditHonorWallInfo()

	UIStateManager.instance:push(ViewName.FamilyHonorExhibit, params)
end

function FamilyHonorEditView:_onClickResetBtn()
	local str = "是否确定将所有勋章进行卸下重置？\n确定按钮将其重置，取消关闭不重置。"

	TipsFacade.instance:openPopupWindow(lang("重置编辑"), str, function()
		FamilyHonorModel.instance:resetCacheHonorWall()
	end, nil, lang("confirm"), lang("mail_cancel"), UnityEngine.TextAnchor.MiddleCenter)
end

function FamilyHonorEditView:_getPath()
	return {
		cellPath = "listInfoGo/itemCell",
		viewPath = "listInfoGo/itemListSR"
	}
end

function FamilyHonorEditView:_cellSize()
	return 130, 130
end

function FamilyHonorEditView:initCell(cell)
	local component = HonorItemDrag.AddOnce(cell.gameObject)

	component:addListener(HonorItemDrag.Events.Click, function(data)
		self:_onClickHonorItem(data)
	end)
	BeginDragHandler.Get(cell.gameObject):AddLuaHandler(function(go, data)
		self:_OnDragItemBegin(go, data)
	end)
	DragHandler.Get(cell.gameObject):AddLuaHandler(function(go, data)
		self:_OnDragItemMove(go, data)
	end)
	EndDragHandler.Get(cell.gameObject):AddLuaHandler(function(go, data)
		self:_OnDragItemEnd(go, data)
	end)
end

function FamilyHonorEditView:_updateCell(view, cell, data)
	local component = HonorItemDrag.AddOnce(cell.gameObject)

	component:initSaveData(data)

	local iconImaGo = goutil.findChild(cell, "iconImaGo")
	local chooseGo = goutil.findChild(cell, "chooseGo")
	local levelIma = goutil.findChild(cell, "levelIma"):GetComponent("UIImageSpriteChange")
	local nameTxt = goutil.findChildTextComponent(cell, "nameTxt")
	local posTran = goutil.findChild(cell, "posTran"):GetComponent(goutil.Type_RectTransform)

	uGuiUtil.clearImage(iconImaGo)

	local iconPath = "ui/bigbg/familycallorder/" .. data.cfg.icon .. ".png"

	uGuiUtil.setSpriteToImage(iconImaGo, uGuiUtil.SpriteType.BigBg, iconPath)
	GameUtil.SetActive(chooseGo, FamilyHonorModel.instance:isHonorCurrentEditWall(data.cfg.id))
	levelIma:SetState(data.cfg.level - 1)

	nameTxt.text = data.cfg.name

	goutil.setWidth(posTran, data.cfg.width * 6)
	goutil.setHeight(posTran, data.cfg.height * 6)
end

function FamilyHonorEditView:_OnDragItemBegin(go, data)
	self._htDragLua = nil

	GameUtil.SetActive(self._areaIma, false)

	self._dragingInfo = nil

	local drag = math.abs(data.delta.y) > math.abs(data.delta.x) and self._tableview:GetScrollRect().horizontal or math.abs(data.delta.y) < math.abs(data.delta.x) and self._tableview:GetScrollRect().vertical

	if drag then
		self:_OnDragHonorBegin(go, data)
	else
		self._htDragLua = nil

		self._tableview:GetScrollRect():OnBeginDrag(data)
		self._tableview:OnBeginDrag(data)
	end
end

function FamilyHonorEditView:_OnDragItemMove(go, data)
	if self._htDragLua then
		self:_OnDragHonorMove(go, data)
	else
		self._tableview:GetScrollRect():OnDrag(data)
		self._tableview:OnDrag(data)
	end
end

function FamilyHonorEditView:_OnDragItemEnd(go, data)
	GameUtil.SetActive(self._areaIma, false)

	if self._htDragLua then
		self:_OnDragHonorEnd(go, data)
	elseif self._tableview and self._tableview:GetScrollRect() and data then
		self._tableview:GetScrollRect():OnEndDrag(data)
		self._tableview:OnEndDrag(data)
	end
end

function FamilyHonorEditView:_onDragCalculatePos(ahdPos)
	local posX, posY = ahdPos.x, -ahdPos.y

	posX = math.max(0, posX)
	posX = math.min(self._gridRectWidth - self._htDragLua:getHonorItemWidth() * self._onceGridSize, posX)
	posY = math.max(0, posY)
	posY = math.min(self._gridRectHeight - self._htDragLua:getHonorItemHeight() * self._onceGridSize, posY)

	local centerX = math.floor(posX / self._onceGridSize)
	local centerY = math.floor(posY / self._onceGridSize)
	local colorIdx = 0
	local info = self._htDragLua:getHonorInfo()
	local wallInfo = FamilyHonorModel.instance:getCacheHonorWall()

	for h = 1, self._htDragLua:getHonorItemHeight() do
		for w = 1, self._htDragLua:getHonorItemWidth() do
			if wallInfo[(centerY + h - 1) * FamilyHonorModel.instance.wallWide + centerX + w] > 0 and wallInfo[(centerY + h - 1) * FamilyHonorModel.instance.wallWide + centerX + w] ~= ((info or nil) and info.defineId) then
				colorIdx = 1
			end
		end
	end

	self:_setAreaImageRect(centerX * self._onceGridSize, -centerY * self._onceGridSize, colorIdx)

	if ahdPos.x >= self._gridRectWidth or -ahdPos.y >= self._gridRectHeight then
		GameUtil.SetActive(self._areaIma, false)
	end

	self._dragingInfo = nil

	if colorIdx == 0 then
		self._dragingInfo = {}

		local cfg = self._htDragLua:getHonorCfg()

		self._dragingInfo.defineId = cfg.id
		self._dragingInfo.wallId = 1
		self._dragingInfo.positionX = centerX
		self._dragingInfo.positionY = centerY
	end
end

function FamilyHonorEditView:_checkingConform(ahdPos)
	GameUtil.SetActive(self._areaIma, false)

	if self._htDragLua == nil or self._htDragLua:getHonorInfo() == nil then
		return
	end

	local info = self._htDragLua:getHonorInfo()
	local oldCacheInfo = FamilyHonorModel.instance:getCacheHonorByDefineId(info.defineId)

	if ahdPos.x >= self._gridRectWidth or -ahdPos.y >= self._gridRectHeight then
		self._dragingInfo = nil

		if oldCacheInfo and oldCacheInfo.wallId > 0 then
			FamilyHonorModel.instance:updataCacheHonorWall(oldCacheInfo, nil)
		end

		return
	end

	if self._dragingInfo and checknumber(self._dragingInfo.defineId) > 0 then
		if oldCacheInfo and oldCacheInfo.wallId > 0 then
			FamilyHonorModel.instance:updataCacheHonorWall(oldCacheInfo, self._dragingInfo)
		else
			FamilyHonorModel.instance:updataCacheHonorWall(nil, self._dragingInfo)
		end

		self._dragingInfo = nil

		return
	end

	if oldCacheInfo and oldCacheInfo.wallId > 0 then
		FamilyHonorModel.instance:updataCacheHonorWall(nil, oldCacheInfo)
	end
end

function FamilyHonorEditView:_setWallItemAlpha(defineId, alphaValue)
	if self._honorItemList then
		for k, v in pairs(self._honorItemList) do
			local component = HonorItemDrag.Get(v.itemGo)
			local info = component:getHonorInfo()

			if info.defineId == defineId then
				local canvasGroup = v.canvasGroup

				canvasGroup.alpha = alphaValue

				break
			end
		end
	end
end

function FamilyHonorEditView:_setAreaImageRect(posx, posy, colorIdx)
	if self._htDragLua == nil then
		return
	end

	GameUtil.setUIImageColorIdx(self._areaIma, colorIdx)
	GameUtil.SetActive(self._areaIma, true)
	GameUtil.setWidth(self._areaIma, self._onceGridSize * self._htDragLua:getHonorItemWidth() + 20)
	GameUtil.setHeight(self._areaIma, self._onceGridSize * self._htDragLua:getHonorItemHeight() + 20)
	GameUtil.setAnchoredPos(self._areaIma, posx - 10, posy + 10)
end

function FamilyHonorEditView:_getDragItemPosition(go)
	if go == nil then
		return Vector2.New(0, 0)
	end

	local targetPos = self._itemGridTran:InverseTransformPoint(uGuiUtil.GetTouchWorldPosition())
	local x = targetPos.x - self._htDragLua:getHonorItemWidth() / 2 * self._onceGridSize
	local y = targetPos.y + self._htDragLua:getHonorItemWidth() / 2 * self._onceGridSize

	Framework.TransformUtil.SetLocalPos(go.transform, x, y, 0)

	return GameUtil.getAnchoredPos(go)
end

return FamilyHonorEditView
