-- chunkname: @modules/logic/versionactivity2_5/liangyue/view/LiangYueDragItem.lua

module("modules.logic.versionactivity2_5.liangyue.view.LiangYueDragItem", package.seeall)

local LiangYueDragItem = class("LiangYueDragItem", LuaCompBase)

function LiangYueDragItem:init(go)
	self.go = go
	self.rectTran = go.transform
	self._image_illustration = gohelper.findChildSingleImage(go, "Piece")
	self._image_illustration_frame = gohelper.findChildSingleImage(go, "PieceFrame")
	self._txtNum = gohelper.findChildTextMesh(go, "Tips/image_NumBG/#txt_Num")
	self._goTips = gohelper.findChild(go, "Tips")
	self._goTargetIconOneRow = gohelper.findChild(go, "Tips/TargetIconOneRow")
	self._goTargetIconTwoColumn = gohelper.findChild(go, "Tips/TargetIconTwoColumn")
	self._goTargetIconOneColumn = gohelper.findChild(go, "Tips/TargetIconOneColumn")

	self:initComp()
end

function LiangYueDragItem:initComp()
	self._iconHeight = recthelper.getHeight(self._image_illustration.transform)
	self._iconWidth = recthelper.getWidth(self._image_illustration.transform)
	self._attributeItemList = {}

	local tempList = {
		self._goTargetIconOneColumn,
		self._goTargetIconTwoColumn,
		self._goTargetIconOneRow
	}

	for _, itemObj in ipairs(tempList) do
		local item = LiangYueAttributeItem.New()

		item:init(itemObj)
		table.insert(self._attributeItemList, item)
	end
end

function LiangYueDragItem:setActive(active)
	gohelper.setActive(self.go, active)
end

function LiangYueDragItem:setInfo(id, config, isStatic, isFinish)
	self.id = id
	self.config = config
	self.isStatic = isStatic
	self.isFinish = isFinish

	local iconName = string.format("v2a5_liangyue_game_list_piece%s", config.imageId)

	self._image_illustration:LoadImage(ResUrl.getV2a5LiangYueImg(iconName), self.onIllustrationLoadBack, self)

	if isStatic then
		local frameName = string.format("v2a5_liangyue_game_pieceframe%s", config.imageId)

		self._image_illustration_frame:LoadImage(ResUrl.getV2a5LiangYueImg(frameName), self.onIllustrationBgLoadBack, self)
	end

	gohelper.setActive(self._goTips, isStatic and not isFinish)
	gohelper.setActive(self._image_illustration_frame.gameObject, isStatic)
end

function LiangYueDragItem:setIndex(index)
	self._txtNum.text = index
end

function LiangYueDragItem:setAttributeState(active)
	gohelper.setActive(self._goTips, active)
end

function LiangYueDragItem:onIllustrationBgLoadBack()
	ZProj.UGUIHelper.SetImageSize(self._image_illustration_frame.gameObject)
end

function LiangYueDragItem:onIllustrationLoadBack()
	local imgTr = self._image_illustration.transform

	ZProj.UGUIHelper.SetImageSize(imgTr.gameObject)

	local width = recthelper.getWidth(imgTr)
	local height = recthelper.getHeight(imgTr)

	self.width = width
	self.height = height

	recthelper.setSize(self.go.transform, width, height)

	local isStatic = self.isStatic

	if not isStatic or self.isFinish then
		return
	end

	local config = self.config

	self:setAttributeInfo(config.activityId, config.id, isStatic)
end

function LiangYueDragItem:setAttributeInfo(actId, id, isStatic)
	local attributeData = LiangYueConfig.instance:getIllustrationAttribute(actId, id)
	local shape = LiangYueConfig.instance:getIllustrationShape(actId, id)
	local width = #shape[1]
	local height = #shape
	local type = Mathf.Clamp(width, LiangYueEnum.AttributeType.OneColumn, LiangYueEnum.AttributeType.OneRow)
	local item = self._attributeItemList[type]

	item:setInfo(attributeData)

	if self._shapeId == id then
		return
	end

	self._shapeId = id

	for currentType, attributeItem in ipairs(self._attributeItemList) do
		attributeItem:setActive(currentType == type)
	end

	for y, rowData in ipairs(shape) do
		local columnCount = 0

		for x, data in ipairs(rowData) do
			if data == 1 then
				columnCount = columnCount + 1

				if columnCount == width then
					self._currentItem = item

					item:setItemPos(y, height)
					logNormal("第一个最宽的行索引: " .. y)

					if isStatic then
						self:delayRefreshInfo()
					end

					return
				end
			end
		end
	end

	logError("can not find fixable row")

	self._currentItem = item

	item:setItemPos(1, height)

	if isStatic then
		self:delayRefreshInfo()
	end
end

function LiangYueDragItem:delayRefreshInfo()
	ZProj.UGUIHelper.RebuildLayout(self._currentItem.go.transform)
	self:setAttributeState(false)
	TaskDispatcher.runDelay(self.setItemPosY, self, 0.1)
end

function LiangYueDragItem:setItemPosY()
	TaskDispatcher.cancelTask(self.setItemPosY, self)
	self:setAttributeState(true)

	local item = self._currentItem

	if item == nil then
		logError("没有找到对应的数值组件")

		return
	end

	local y = item.yPos
	local columnCount = item.columnCount
	local meshHeight = self.height / columnCount

	ZProj.UGUIHelper.RebuildLayout(self._currentItem.go.transform)

	local halfWidth = LiangYueEnum.AttributeOffset
	local halfItemWidth = self.height * 0.5

	recthelper.setAnchorY(self._goTips.transform, (y <= 1 and (columnCount - y + 1) * meshHeight - halfWidth or (columnCount - y) * meshHeight + halfWidth) - halfItemWidth)
end

function LiangYueDragItem:onDestroy()
	TaskDispatcher.cancelTask(self.setItemPosY, self)
end

return LiangYueDragItem
