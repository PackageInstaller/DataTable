-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petskinpreview/view/PetSkinPreviewCell.lua

module("logic.extensions.petskinpreview.view.PetSkinPreviewCell", package.seeall)

local PetSkinPreviewCell = class("PetSkinPreviewCell")

PetSkinPreviewCell.ShowShengpingFullCell = true
PetSkinPreviewCell.CellType = {
	Default = 1,
	Shengpin = 2
}

function PetSkinPreviewCell.Get(go)
	local component = Framework.LuaComponentContainer.Get(go, PetSkinPreviewCell)

	component = component or Framework.LuaComponentContainer.Add(go, PetSkinPreviewCell)

	return component
end

function PetSkinPreviewCell:ctor(luaComponentContainer)
	local go = luaComponentContainer.gameObject

	self._tableviewGo = goutil.findChild(go, "childtableview")
	self._scrollRect = goutil.findChild(go, "childtableview"):GetComponent(ComponentType.ScrollRect)
	self._rectTrans = goutil.findChild(go, "childtableview/viewport"):GetComponent(goutil.Type_RectTransform)
	self._tablecellGo = goutil.findChild(go, "childtablecell")
	self._tablecellGo2 = goutil.findChild(go, "childtablecell2")
	self._txtName = goutil.findChildTextComponent(go, "nameBg/txtName")
	self._scrollList = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self._scrollList:setTagCell(self._tablecellGo, PetSkinPreviewCell.CellType.Default)
	self._scrollList:setTagCell(self._tablecellGo2, PetSkinPreviewCell.CellType.Shengpin)
	self._scrollList:regGetTagByIdx(function(data)
		if self._myData.isShengpin then
			return PetSkinPreviewCell.CellType.Shengpin
		else
			return PetSkinPreviewCell.CellType.Default
		end
	end)
	self._scrollList:regGetCellSize(GameUtil.handler(self._cellSize, self))
	self._scrollList:regReloadFinish(GameUtil.handler(self._onReloadFinish, self))

	self._uiTableGrid = self._tableviewGo:GetComponent(typeof(UITableGrid))
	self._cacheV2 = Vector2.New(0, 0)

	BeginDragHandler.Get(self._tableviewGo):AddLuaHandler(function(_go, eventData)
		PetSkinlPreviewController.instance:beginDrag()
	end)
	EndDragHandler.Get(self._tableviewGo):AddLuaHandler(function(_go, eventData)
		PetSkinlPreviewController.instance:endDrag()
	end)
end

function PetSkinPreviewCell:init(data)
	self._myData = data

	self:_setSingleLineNum()
	goutil.setActive(self._tableviewGo, true)

	self._scrollRect.horizontal = false
	self._scrollRect.vertical = true
	self._cacheV2.y = 0
	self._uiTableGrid.cellOffset = self._cacheV2

	self._scrollList:dragNotifyParent()

	if self._myData.quality == PetskinpreskinView.ShengPinQuality and not PetSkinPreviewCell.ShowShengpingFullCell then
		self._scrollRect.horizontal = true
		self._scrollRect.vertical = false

		goutil.setHeight(self._rectTrans, PetskinpreskinView.ShengpinSkinHeight * 2)

		self._cacheV2.y = -PetskinpreskinView.ShengpinSkinHeight
		self._uiTableGrid.cellOffset = self._cacheV2
	else
		goutil.setHeight(self._rectTrans, self:_getHeight())
	end

	self._scrollList:reloadData(data.skinCfgs)

	self._txtName.text = self._myData.name
end

function PetSkinPreviewCell:_setSingleLineNum()
	if self._myData.isShengpin then
		self._uiTableGrid.gridWidth = PetskinpreskinView.ShengpinSkinWidth
		self._uiTableGrid.gridHeight = PetskinpreskinView.ShengpinSkinHeight
		self._uiTableGrid.numRowsOrCols = PetskinpreskinView.ShengpinSkinLineNum
	else
		self._uiTableGrid.gridWidth = PetskinpreskinView.SkinWidth
		self._uiTableGrid.gridHeight = PetskinpreskinView.SkinHeight
		self._uiTableGrid.numRowsOrCols = PetskinpreskinView.SkinLineNum
	end
end

function PetSkinPreviewCell:_getHeight()
	local totalCount = #self._myData.skinCfgs

	if self._myData.isShengpin then
		local lineNum = Mathf.Floor(Mathf.Max(totalCount - 1, 0) / PetskinpreskinView.ShengpinSkinLineNum) + 1

		return PetskinpreskinView.ShengpinSkinHeight * lineNum
	else
		local lineNum = Mathf.Floor(Mathf.Max(totalCount - 1, 0) / PetskinpreskinView.SkinLineNum) + 1

		return PetskinpreskinView.SkinHeight * lineNum
	end
end

function PetSkinPreviewCell:clear()
	self._scrollList:dispose()
	self._scrollList:removeDragNotifyParent()
end

function PetSkinPreviewCell:_updateCell(view, cell, skinCfg, tag)
	if self._myData.isShengpin then
		self:_updateShengpinCell(view, cell, skinCfg, tag)
	else
		self:_updateDefaultCell(view, cell, skinCfg, tag)
	end
end

function PetSkinPreviewCell:_updateShengpinCell(view, cell, skinCfg, tag)
	local goCon = goutil.findChild(cell.gameObject, "container/mask/con")
	local txtName = goutil.findChildTextComponent(cell.gameObject, "container/nameBg/txtName")
	local goSkin = goutil.findChild(cell.gameObject, "container/layout/Nego_Skin")
	local goType = goutil.findChild(cell.gameObject, "container/layout/Nego_Type")
	local goLock = goutil.findChild(cell.gameObject, "container/lock")
	local imgChangeSkin = goutil.findChild(cell.gameObject, "container/layout/Nego_Skin/skin"):GetComponent(ComponentType.UIImageSpriteChange)
	local typeChange = goutil.findChild(cell.gameObject, "container/layout/Nego_Type/skin")
	local btnObj = goutil.findChild(cell.gameObject, "container/btnObj")
	local isHaveType = not string.nilorempty(skinCfg.skinTypeName)
	local rare = CharacterConfig.instance:getInitRare(skinCfg.raceId)
	local rareSkin = PetSkinConfig.instance:getPetSkinCfg(skinCfg.skinId).quality
	local isHadSkin = PetSkinlPreviewController.instance:isHadSkin(skinCfg.skinId)

	txtName.text = skinCfg.skinName

	goSkin:SetActive(not isHaveType)
	goType:SetActive(isHaveType)
	uGuiUtil.clearImage(typeChange)

	if isHaveType then
		uGuiUtil.setSpriteToImage(typeChange, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgFolderUrl("skintype", skinCfg.skinTypeName))
	end

	imgChangeSkin:SetState(rareSkin)

	local imgPath = GameUrl.getBigbgFolderUrl("petskinpreview", skinCfg.previewResName)

	uGuiUtil.setSpriteToImage(goCon, uGuiUtil.SpriteType.BigBg, imgPath)
	goutil.setActive(goLock, not isHadSkin)
	GameUtil.addClickHandler(btnObj, function()
		self:_onClickPet(skinCfg)
	end)
end

function PetSkinPreviewCell:_updateDefaultCell(view, cell, skinCfg, tag)
	local goCon = goutil.findChild(cell.gameObject, "container/mask/con")
	local btnObj = goutil.findChild(cell.gameObject, "container/bg")
	local bgChange = goutil.findChild(cell.gameObject, "container/bg"):GetComponent(ComponentType.UIImageSpriteChange)
	local goSkin = goutil.findChild(cell.gameObject, "container/cover/layout/Nego_Skin")
	local goType = goutil.findChild(cell.gameObject, "container/cover/layout/Nego_Type")
	local imgChangeImg_attr = goutil.findChild(cell.gameObject, "container/cover/layout/Nego_Attr/Img_attr"):GetComponent(ComponentType.UIImageSpriteChange)
	local imgChangeSkin = goutil.findChild(cell.gameObject, "container/cover/layout/Nego_Skin/skin"):GetComponent(ComponentType.UIImageSpriteChange)
	local txtName = goutil.findChildTextComponent(cell.gameObject, "container/cover/txtName")
	local goLock = goutil.findChild(cell.gameObject, "container/lock")
	local typeChange = goutil.findChild(cell.gameObject, "container/cover/layout/Nego_Type/skin")
	local ModelCo = CharacterConfig.instance:getModelCo(checknumber(skinCfg.skinId))
	local imgPath = GameUrl.getPetImgUrl(ModelCo.cardName)
	local rare = CharacterConfig.instance:getInitRare(skinCfg.raceId)
	local race = PetSkinConfig.instance:getFisrtEleAttrIdx(skinCfg.skinId) % 10 - 1
	local isHaveType = not string.nilorempty(skinCfg.skinTypeName)
	local rareSkin = PetSkinConfig.instance:getPetSkinCfg(skinCfg.skinId).quality
	local isHadSkin = PetSkinlPreviewController.instance:isHadSkin(skinCfg.skinId)

	uGuiUtil.setSpriteToImage(goCon, uGuiUtil.SpriteType.BigBg, imgPath)
	bgChange:SetState(rare)
	imgChangeImg_attr:SetState(race)
	imgChangeSkin:SetState(rareSkin)
	goSkin:SetActive(not isHaveType)
	goType:SetActive(isHaveType)

	txtName.text = skinCfg.skinName

	uGuiUtil.clearImage(typeChange)

	if isHaveType then
		uGuiUtil.setSpriteToImage(typeChange, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgFolderUrl("skintype", skinCfg.skinTypeName))
	end

	GameUtil.addClickHandler(btnObj, function()
		self:_onClickPet(skinCfg)
	end)
	goutil.setActive(goLock, not isHadSkin)
end

function PetSkinPreviewCell:_clearCell(cell)
	GameUtil.rmClickHandler(goutil.findChild(cell, "container"))
	GameUtil.rmClickHandler(goutil.findChild(cell, "container/imgBook"))

	local typeChange = goutil.findChild(cell, "container/cover/layout/Nego_Type/skin")

	typeChange = typeChange or goutil.findChild(cell.gameObject, "container/layout/Nego_Type/skin")

	local goCon = goutil.findChild(cell, "container/mask/con")

	uGuiUtil.clearImage(typeChange)
	uGuiUtil.clearImage(goCon)
end

function PetSkinPreviewCell:_getOpenDateStr(leftTime)
	local day, hour, min, sec = GameUtil.getTimeDDHHMMSS(leftTime > 0 and leftTime or 0)

	return day > 0 and string.format("%d天 %d小时", day, hour) or hour > 0 and string.format("%d小时", hour) or "1小时"
end

function PetSkinPreviewCell:_cellSize(view, index)
	return PetSummaryView.BigWidth, PetSummaryView.BigHeight
end

function PetSkinPreviewCell:_onReloadFinish()
	self._scrollList:getView():GetScrollRect().verticalNormalizedPosition = 1.01
end

function PetSkinPreviewCell:_onClickPet(skinCfg)
	UIStateManager.instance:push(ViewName.PetskinView, PetskinView.TYPE_SHOP, skinCfg.skinId)
end

return PetSkinPreviewCell
