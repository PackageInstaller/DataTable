-- chunkname: @modules/logic/partygame/view/snatcharea/SnatchAreaEditGameView.lua

module("modules.logic.partygame.view.snatcharea.SnatchAreaEditGameView", package.seeall)

local SnatchAreaEditGameView = class("SnatchAreaEditGameView", BaseView)

function SnatchAreaEditGameView:onInitView()
	self.titleItem = gohelper.findChild(self.viewGO, "root/left/Scroll View/Viewport/Content/titleitem")
	self.leftItem = gohelper.findChild(self.viewGO, "root/left/Scroll View/Viewport/Content/cellitem")

	gohelper.setActive(self.titleItem, false)
	gohelper.setActive(self.leftItem, false)

	self.rowInput = gohelper.findChildTextMeshInputField(self.viewGO, "root/center/top/row_input")
	self.columnInput = gohelper.findChildTextMeshInputField(self.viewGO, "root/center/top/column_input")
	self.area1Input = gohelper.findChildTextMeshInputField(self.viewGO, "root/center/top/area1count_input")
	self.area2Input = gohelper.findChildTextMeshInputField(self.viewGO, "root/center/top/area2count_input")
	self.area3Input = gohelper.findChildTextMeshInputField(self.viewGO, "root/center/top/area3count_input")
	self.area4Input = gohelper.findChildTextMeshInputField(self.viewGO, "root/center/top/area4count_input")
	self.randomStepBtn = gohelper.findChildButton(self.viewGO, "root/center/top/random_step_btn")
	self.randomBtn = gohelper.findChildButton(self.viewGO, "root/center/top/random_btn")
	self.areaLabelText = gohelper.findChildText(self.viewGO, "root/center/top/area_label")
	self.copyBtn = gohelper.findChildButton(self.viewGO, "root/center/top/copy_btn")
	self.clearBtn = gohelper.findChildButton(self.viewGO, "root/center/top/clear_btn")
	self.centerRectTr = gohelper.findChildComponent(self.viewGO, "root/center/center", gohelper.Type_RectTransform)
	self.cellItem = gohelper.findChild(self.viewGO, "root/center/center/item")

	gohelper.setActive(self.cellItem, false)

	self.centerWidth = recthelper.getWidth(self.centerRectTr)
	self.centerHeight = recthelper.getHeight(self.centerRectTr)
	self.cellItemList = {}
	self.goEditTip = gohelper.findChild(self.viewGO, "root/center/center/edit_tip")
	self.editTipRect = self.goEditTip:GetComponent(gohelper.Type_RectTransform)
	self.goEditItem = gohelper.findChild(self.goEditTip, "edit_item")

	gohelper.setActive(self.goEditItem, false)

	self.updateHandle = UpdateBeat:CreateListener(self.frameUpdate, self)

	self:setInputTextColor()

	self.row = 0
	self.column = 0
	self.area1 = 0
	self.area2 = 0
	self.area3 = 0
	self.area4 = 0
	self.leftItemList = {}
	self.leftTitleList = {}
end

function SnatchAreaEditGameView:setInputTextColor()
	local text = gohelper.findChildText(self.area1Input.gameObject, "Text Area/Text")

	SLFramework.UGUI.GuiHelper.SetColor(text, SnatchEnum.Color[SnatchEnum.AreaType.One])

	text = gohelper.findChildText(self.area2Input.gameObject, "Text Area/Text")

	SLFramework.UGUI.GuiHelper.SetColor(text, SnatchEnum.Color[SnatchEnum.AreaType.Two])

	text = gohelper.findChildText(self.area3Input.gameObject, "Text Area/Text")

	SLFramework.UGUI.GuiHelper.SetColor(text, SnatchEnum.Color[SnatchEnum.AreaType.Three])

	text = gohelper.findChildText(self.area4Input.gameObject, "Text Area/Text")

	SLFramework.UGUI.GuiHelper.SetColor(text, SnatchEnum.Color[SnatchEnum.AreaType.Four])
end

function SnatchAreaEditGameView:addEvents()
	self.randomBtn:AddClickListener(self.onClickRandomBtn, self)
	self.randomStepBtn:AddClickListener(self.onClickRandomStepBtn, self)
	self.rowInput:AddOnEndEdit(self.onRowInputEndEdit, self)
	self.columnInput:AddOnEndEdit(self.onColumnInputEndEdit, self)
	self.copyBtn:AddClickListener(self.onClickCopyBtn, self)
	self.clearBtn:AddClickListener(self.onClickClearBtn, self)
end

function SnatchAreaEditGameView:removeEvents()
	self.randomBtn:RemoveClickListener()
	self.randomStepBtn:RemoveClickListener()
	self.rowInput:RemoveOnEndEdit()
	self.columnInput:RemoveOnEndEdit()
	self.copyBtn:RemoveClickListener()
	self.clearBtn:RemoveClickListener()
end

function SnatchAreaEditGameView:onClickCopyBtn()
	if not self.mapData then
		return
	end

	if not self:checkMapGenerateDone() then
		GameFacade.showToastString("地图数据还未编辑完成")

		return
	end

	for id, mapData in pairs(self.id2MapDataDict) do
		local success, rate = SnatchAreaHelper.findTwoMapSameRate(mapData, self.mapData)

		if success and rate >= 1 then
			GameFacade.showToastString(string.format("当前地图数据和配置中id : %s 的数据一样", id))

			return
		end
	end

	SnatchAreaHelper.encodeMapData(self.mapData)
end

function SnatchAreaEditGameView:onClickClearBtn()
	self.mapData = nil
	self.typePosDict = nil
	self.typeCountDict = nil

	self:refreshMapData()
end

function SnatchAreaEditGameView:onRowInputEndEdit()
	self:autoFillInput()
end

function SnatchAreaEditGameView:onColumnInputEndEdit()
	self:autoFillInput()
end

function SnatchAreaEditGameView:autoFillInput()
	local row = tonumber(self.rowInput:GetText())

	if not row then
		return
	end

	local column = tonumber(self.columnInput:GetText())

	if not column then
		return
	end

	local totalCount = row * column
	local perCount = totalCount / 4
	local avg = math.floor(perCount)
	local area2 = avg
	local area3 = avg + 1
	local area4 = avg + 2
	local area1 = totalCount - area2 - area3 - area4

	self.area1Input:SetText(area1)
	self.area2Input:SetText(area2)
	self.area3Input:SetText(area3)
	self.area4Input:SetText(area4)
end

function SnatchAreaEditGameView:onClickRandomBtn()
	if self.mapData then
		GameFacade.showToastString("已存在地图数据，先清空")

		return
	end

	if not self:buildInput() then
		return
	end

	logNormal("开始生成")

	local row, column, x, y, z, w = self.row, self.column, self.area1, self.area2, self.area3, self.area4
	local success, mapData, typePosDict, typeCountDict = SnatchAreaHelper.randomMap(row, column, x, y, z, w)

	if not success then
		if mapData then
			SnatchAreaHelper.logMapData(mapData)
			self:refreshMapData(mapData)
		end

		logError("生成失败")

		return
	end

	self.mapData = mapData
	self.typePosDict = typePosDict
	self.typeCountDict = typeCountDict

	self:refreshMapData(self.mapData)
end

function SnatchAreaEditGameView:onClickRandomStepBtn()
	if self.mapData then
		GameFacade.showToastString("已存在地图数据，先清空")

		return
	end

	if not self:buildInput() then
		return
	end

	logNormal("开始生成")

	local row, column, x, y, z, w = self.row, self.column, self.area1, self.area2, self.area3, self.area4
	local success, mapData, typePosDict, typeCountDict = SnatchAreaHelper.randomMapByStep(row, column, x, y, z, w)

	if not success then
		if mapData then
			SnatchAreaHelper.logMapData(mapData)
			self:refreshMapData(mapData)
		end

		logError("生成失败")

		return
	end

	self.mapData = mapData
	self.typePosDict = typePosDict
	self.typeCountDict = typeCountDict

	self:refreshMapData(mapData)
end

function SnatchAreaEditGameView:tryNextGenerateStep()
	SnatchAreaHelper.randomOneStepMapData(self.mapData, self.typePosDict, self.typeCountDict)
	self:refreshMapData(self.mapData)
end

function SnatchAreaEditGameView:checkMapGenerateDone()
	if not self.typePosDict then
		return true
	end

	if not self.typeCountDict then
		return true
	end

	if #self.typePosDict[SnatchEnum.AreaType.One] < self.typeCountDict[SnatchEnum.AreaType.One] then
		return false
	end

	if #self.typePosDict[SnatchEnum.AreaType.Two] < self.typeCountDict[SnatchEnum.AreaType.Two] then
		return false
	end

	if #self.typePosDict[SnatchEnum.AreaType.Three] < self.typeCountDict[SnatchEnum.AreaType.Three] then
		return false
	end

	if #self.typePosDict[SnatchEnum.AreaType.Four] < self.typeCountDict[SnatchEnum.AreaType.Four] then
		return false
	end

	return true
end

function SnatchAreaEditGameView:buildInput()
	local row = tonumber(self.rowInput:GetText())

	if not row then
		GameFacade.showToastString("行输入不合法")

		return
	end

	local column = tonumber(self.columnInput:GetText())

	if not column then
		GameFacade.showToastString("列输入不合法")

		return
	end

	local area1 = tonumber(self.area1Input:GetText())

	if not area1 then
		GameFacade.showToastString("区域1输入不合法")

		return
	end

	local area2 = tonumber(self.area2Input:GetText())

	if not area2 then
		GameFacade.showToastString("区域2输入不合法")

		return
	end

	local area3 = tonumber(self.area3Input:GetText())

	if not area3 then
		GameFacade.showToastString("区域3输入不合法")

		return
	end

	local area4 = tonumber(self.area4Input:GetText())

	if not area4 then
		GameFacade.showToastString("区域4输入不合法")

		return
	end

	local totalCount = row * column
	local areaCount = area1 + area2 + area3 + area4

	if totalCount ~= areaCount then
		GameFacade.showToastString("区域个数和总的个数不匹配")

		return
	end

	self.row = row
	self.column = column
	self.area1 = area1
	self.area2 = area2
	self.area3 = area3
	self.area4 = area4

	return true
end

function SnatchAreaEditGameView:onOpen()
	self:rebuildConfig()

	self.areaLabelText.text = ""

	self:initEditTipItem()
	self:addUpdateHandle()
	self:refreshLeft()
	self:selectCo(lua_partygame_snatch_area_map.configList[1])
end

local SelectedColor = "#BEBEBE"
local NotSelectedColor = "#FFFFFF"

function SnatchAreaEditGameView:refreshLeftSelectStatus()
	for _, leftItem in ipairs(self.leftItemList) do
		local co = leftItem.config
		local select = co.id == self.selectedId

		if select then
			if not SelectedColor then
				local color = NotSelectedColor

				SLFramework.UGUI.GuiHelper.SetColor(leftItem.image, color)
			end
		end
	end
end

function SnatchAreaEditGameView:refreshLeft()
	self:hideAllLeftItem()

	local titleIndex = 0
	local itemIndex = 0

	for title, configList in pairs(self.title2ConfigListDict) do
		titleIndex = titleIndex + 1

		local titleItem = self.leftTitleList[titleIndex]

		if not titleItem then
			titleItem = self:createTitleItem()

			table.insert(self.leftTitleList, titleItem)
		end

		gohelper.setActive(titleItem.go, true)
		gohelper.setAsLastSibling(titleItem.go)

		titleItem.text.text = title

		for _, co in ipairs(configList) do
			itemIndex = itemIndex + 1

			local leftItem = self.leftItemList[itemIndex]

			if not leftItem then
				leftItem = self:createLeftItem()

				table.insert(self.leftItemList, leftItem)
			end

			leftItem.config = co

			gohelper.setActive(leftItem.go, true)
			gohelper.setAsLastSibling(leftItem.go)

			leftItem.text.text = co.id
		end
	end
end

function SnatchAreaEditGameView:createLeftItem()
	local leftItem = self:getUserDataTb_()

	leftItem.go = gohelper.cloneInPlace(self.leftItem)
	leftItem.text = gohelper.findChildText(leftItem.go, "text")
	leftItem.click = gohelper.getClick(leftItem.go)

	leftItem.click:AddClickListener(self.onClickLeftItem, self, leftItem)

	leftItem.image = leftItem.go:GetComponent(gohelper.Type_Image)

	return leftItem
end

function SnatchAreaEditGameView:onClickLeftItem(leftItem)
	self:selectCo(leftItem.config)
end

function SnatchAreaEditGameView:createTitleItem()
	local titleItem = self:getUserDataTb_()

	titleItem.go = gohelper.cloneInPlace(self.titleItem)
	titleItem.text = gohelper.findChildText(titleItem.go, "text")

	return titleItem
end

function SnatchAreaEditGameView:hideAllLeftItem()
	for _, leftItem in pairs(self.leftItemList) do
		gohelper.setActive(leftItem.go, false)
	end

	for _, leftTitle in pairs(self.leftTitleList) do
		gohelper.setActive(leftTitle.go, false)
	end
end

function SnatchAreaEditGameView:rebuildConfig()
	self.title2ConfigListDict = {}
	self.id2MapDataDict = {}

	for _, co in ipairs(lua_partygame_snatch_area_map.configList) do
		local title = self:getTitle(co)
		local configList = self.title2ConfigListDict[title]

		if not configList then
			configList = {}
			self.title2ConfigListDict[title] = configList
		end

		table.insert(configList, co)

		self.id2MapDataDict[co.id] = SnatchAreaHelper.decodeMapData(co.mapdata)
	end
end

function SnatchAreaEditGameView:getTitle(co)
	return string.format("%s*%s", co.row, co.column)
end

function SnatchAreaEditGameView:selectCo(config)
	if self.selectedId == config.id then
		return
	end

	self.selectedId = config.id
	self.selectedCo = config

	local mapData, typePosDict, typeCountDict = SnatchAreaHelper.decodeMapData(config.mapdata)

	self.mapData = mapData
	self.typePosDict = typePosDict
	self.typeCountDict = typeCountDict
	self.row = config.row
	self.column = config.column
	self.area1 = typeCountDict[SnatchEnum.AreaType.One]
	self.area2 = typeCountDict[SnatchEnum.AreaType.Two]
	self.area3 = typeCountDict[SnatchEnum.AreaType.Three]
	self.area4 = typeCountDict[SnatchEnum.AreaType.Four]

	self.rowInput:SetText(self.row)
	self.columnInput:SetText(self.column)
	self.area1Input:SetText(typeCountDict[SnatchEnum.AreaType.One])
	self.area2Input:SetText(typeCountDict[SnatchEnum.AreaType.Two])
	self.area3Input:SetText(typeCountDict[SnatchEnum.AreaType.Three])
	self.area4Input:SetText(typeCountDict[SnatchEnum.AreaType.Four])
	self:refreshMapData(self.mapData)
	self:refreshLeftSelectStatus()
end

function SnatchAreaEditGameView:refreshLeftSameRate()
	if self.mapData then
		local showRate = self:checkMapGenerateDone()

		for _, leftItem in ipairs(self.leftItemList) do
			local id = leftItem.config.id

			if not self.mapData then
				leftItem.text.text = id
			else
				local success, rate = SnatchAreaHelper.findTwoMapSameRate(self.mapData, self.id2MapDataDict[id])

				if success then
					rate = rate * 100
					leftItem.text.text = string.format("%s (%d%%)", id, rate)
				else
					leftItem.text.text = id
				end
			end
		end
	end
end

function SnatchAreaEditGameView:initEditTipItem()
	gohelper.setActive(self.goEditTip, false)

	for _, areaType in pairs(SnatchEnum.AreaType) do
		local editTipItem = self:getUserDataTb_()

		editTipItem.go = gohelper.cloneInPlace(self.goEditItem)
		editTipItem.text = gohelper.findChildText(editTipItem.go, "text")
		editTipItem.image = gohelper.findChildImage(editTipItem.go, "image")
		editTipItem.click = gohelper.getClick(editTipItem.go)

		self.addClickCb(self, editTipItem.click, self.onClickEditTipItem, self, areaType)

		editTipItem.text.text = SnatchEnum.AreaTypeName[areaType]

		SLFramework.UGUI.GuiHelper.SetColor(editTipItem.image, SnatchEnum.Color[areaType])
		gohelper.setActive(editTipItem.go, true)
	end
end

function SnatchAreaEditGameView:onClickEditTipItem(areaType)
	if not self.curSelectIndex then
		return
	end

	local cellItem = self.cellItemList[self.curSelectIndex]

	if not cellItem then
		logError(string.format("cell item is nil, index : " .. tostring(self.curSelectIndex)))

		return
	end

	local x, y = self:getCellPos(self.curSelectIndex)
	local srcAreaType = self.mapData[x][y]

	if srcAreaType == areaType then
		GameFacade.showToastString("和原数据相等")
		self:hideEditTip()

		return
	end

	if areaType ~= SnatchEnum.AreaType.None and not SnatchAreaHelper.checkAddAreaIsValid(x, y, self.typePosDict[areaType]) then
		GameFacade.showToastString("添加点位不合法，必须和周围的相邻")
		self:hideEditTip()

		return
	end

	SnatchAreaHelper.setMapData(self.mapData, Vector2(x, y), areaType, self.typePosDict, self.typeCountDict)
	self:refreshMapData(self.mapData)
	self:hideEditTip()
end

function SnatchAreaEditGameView:refreshMapData(mapData)
	self:hideAllCell()

	if not mapData then
		self:refreshAreaLabel()
		self:refreshLeftSameRate()

		return
	end

	local row = #mapData
	local column = #mapData[1]
	local spaceWidth = (column + 1) * SnatchEnum.Space
	local spaceHeight = (row + 1) * SnatchEnum.Space
	local remainWidth = self.centerWidth - spaceWidth
	local remainHeight = self.centerHeight - spaceHeight
	local cellWidth, cellHeight = remainWidth / column, remainHeight / row

	for i = 1, row do
		for j = 1, column do
			local index = self:getCellIndex(i, j)
			local cellItem = self.cellItemList[index]

			if not cellItem then
				cellItem = self:createCellItem()
				self.cellItemList[index] = cellItem
			end

			gohelper.setActive(cellItem.go, true)
			recthelper.setSize(cellItem.rectTr, cellWidth, cellHeight)

			local anchorX = (j + 1) * SnatchEnum.Space + (j - 1) * cellWidth
			local anchorY = (i + 1) * SnatchEnum.Space + (i - 1) * cellHeight

			recthelper.setAnchor(cellItem.rectTr, anchorX, -anchorY)
			SLFramework.UGUI.GuiHelper.SetColor(cellItem.image, SnatchEnum.Color[mapData[i][j]])
		end
	end

	self.cellWidth = cellWidth
	self.cellHeight = cellHeight

	gohelper.setAsLastSibling(self.goEditTip)
	self:refreshAreaLabel()
	self:refreshLeftSameRate()
end

function SnatchAreaEditGameView:refreshAreaLabel()
	if self.typeCountDict then
		if not self.typeCountDict[SnatchEnum.AreaType.One] then
			local area1Count = 0

			if self.typeCountDict then
				if not self.typeCountDict[SnatchEnum.AreaType.Two] then
					local area2Count = 0

					if self.typeCountDict then
						if not self.typeCountDict[SnatchEnum.AreaType.Three] then
							local area3Count = 0

							if self.typeCountDict then
								if not self.typeCountDict[SnatchEnum.AreaType.Four] then
									local area4Count = 0

									if self.typePosDict and self.typePosDict[SnatchEnum.AreaType.One] then
										if not #self.typePosDict[SnatchEnum.AreaType.One] then
											local area1CurCount = 0

											if self.typePosDict and self.typePosDict[SnatchEnum.AreaType.Two] then
												if not #self.typePosDict[SnatchEnum.AreaType.Two] then
													local area2CurCount = 0

													if self.typePosDict and self.typePosDict[SnatchEnum.AreaType.Three] then
														if not #self.typePosDict[SnatchEnum.AreaType.Three] then
															local area3CurCount = 0

															if self.typePosDict and self.typePosDict[SnatchEnum.AreaType.Four] then
																if not #self.typePosDict[SnatchEnum.AreaType.Four] then
																	local area4CurCount = 0

																	self.areaLabelText.text = string.format("生成区域:<color=%s>%s/%s</color>, <color=%s>%s/%s</color>, <color=%s>%s/%s</color>, <color=%s>%s/%s</color>", SnatchEnum.Color[SnatchEnum.AreaType.One], area1CurCount, area1Count, SnatchEnum.Color[SnatchEnum.AreaType.Two], area2CurCount, area2Count, SnatchEnum.Color[SnatchEnum.AreaType.Three], area3CurCount, area3Count, SnatchEnum.Color[SnatchEnum.AreaType.Four], area4CurCount, area4Count)
																end
															end
														end
													end
												end
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end
end

function SnatchAreaEditGameView:createCellItem()
	local cellItem = self:getUserDataTb_()

	cellItem.go = gohelper.cloneInPlace(self.cellItem)
	cellItem.rectTr = cellItem.go:GetComponent(gohelper.Type_RectTransform)
	cellItem.image = cellItem.go:GetComponent(gohelper.Type_Image)

	return cellItem
end

function SnatchAreaEditGameView:hideAllCell()
	for _, cellItem in ipairs(self.cellItemList) do
		gohelper.setActive(cellItem.go, false)
	end
end

function SnatchAreaEditGameView:frameUpdate()
	self:handleSpaceKey()
	self:handleMouseInput()
end

function SnatchAreaEditGameView:handleMouseInput()
	if not UnityEngine.Input.GetMouseButton(1) then
		return
	end

	local mousePos = UnityEngine.Input.mousePosition
	local anchorPosX, anchorPosY = recthelper.screenPosToAnchorPos2(mousePos, self.centerRectTr)
	local halfWidth = self.centerWidth * 0.5
	local halfHeight = self.centerHeight * 0.5

	anchorPosX = anchorPosX + halfWidth
	anchorPosY = anchorPosY - halfHeight

	local cellIndex = self:getCellIndexByAnchorPos(anchorPosX, anchorPosY)

	if not cellIndex then
		self.curSelectIndex = nil

		self:hideEditTip()

		return
	end

	self:resetCellItemSelect()

	self.curSelectIndex = cellIndex

	local cellItem = self.cellItemList[cellIndex]

	ZProj.UGUIHelper.SetColorAlpha(cellItem.image, 0.5)
	gohelper.setActive(self.goEditTip, true)
	recthelper.setAnchor(self.editTipRect, anchorPosX, anchorPosY)
end

function SnatchAreaEditGameView:hideEditTip()
	self:resetCellItemSelect()
	gohelper.setActive(self.goEditTip, false)
end

function SnatchAreaEditGameView:resetCellItemSelect()
	for _, cellItem in ipairs(self.cellItemList) do
		ZProj.UGUIHelper.SetColorAlpha(cellItem.image, 1)
	end
end

function SnatchAreaEditGameView:handleSpaceKey()
	local space = UnityEngine.Input.GetKey(UnityEngine.KeyCode.Space)

	if not space then
		return
	end

	if self:checkMapGenerateDone() then
		return
	end

	self:tryNextGenerateStep()
end

function SnatchAreaEditGameView:getCellIndexByAnchorPos(anchorPosX, anchorPosY)
	anchorPosX = math.abs(anchorPosX)
	anchorPosY = math.abs(anchorPosY)

	local cellWidth = self.cellWidth + SnatchEnum.Space
	local columnIndex = math.floor(anchorPosX / cellWidth)
	local remainWidth = anchorPosX % cellWidth

	if remainWidth > 0 and remainWidth < SnatchEnum.Space then
		return
	end

	columnIndex = remainWidth == 0 and columnIndex or columnIndex + 1

	if columnIndex > self.column then
		logError(string.format("columnIndex : %s, column : %s", columnIndex, self.column))

		return
	end

	local cellHeight = self.cellHeight + SnatchEnum.Space
	local rowIndex = math.floor(anchorPosY / cellHeight)
	local remainHeight = anchorPosY % cellHeight

	if remainHeight > 0 and remainHeight < SnatchEnum.Space then
		return
	end

	rowIndex = remainHeight == 0 and rowIndex or rowIndex + 1

	if rowIndex > self.row then
		logError(string.format("rowIndex : %s, row : %s", rowIndex, self.row))

		return
	end

	return self:getCellIndex(rowIndex, columnIndex)
end

function SnatchAreaEditGameView:getCellIndex(x, y)
	return (x - 1) * self.column + y
end

function SnatchAreaEditGameView:getCellPos(index)
	local remain = index % self.column
	local rowIndex = remain == 0 and index / self.column - 1 or math.floor(index / self.column)
	local columnIndex = index - rowIndex * self.column

	rowIndex = rowIndex + 1

	return rowIndex, columnIndex
end

function SnatchAreaEditGameView:removeUpdateHandle()
	UpdateBeat:RemoveListener(self.updateHandle)
end

function SnatchAreaEditGameView:addUpdateHandle()
	UpdateBeat:AddListener(self.updateHandle)
end

function SnatchAreaEditGameView:onDestroyView()
	for _, leftItem in ipairs(self.leftItemList) do
		leftItem.click:RemoveClickListener()

		leftItem.click = nil
	end

	self:removeUpdateHandle()
end

return SnatchAreaEditGameView
