-- chunkname: @modules/logic/dungeon/view/DungeonHuaRongView.lua

module("modules.logic.dungeon.view.DungeonHuaRongView", package.seeall)

local DungeonHuaRongView = class("DungeonHuaRongView", BaseView)

function DungeonHuaRongView:onInitView()
	self._gocontainer = gohelper.findChild(self.viewGO, "#go_container")
	self._goitem = gohelper.findChild(self.viewGO, "#go_container/#go_item")
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#go_container/#go_item/#simage_bg")
	self._txtnumber = gohelper.findChildText(self.viewGO, "#go_container/#go_item/#txt_number")
	self._btnshowsteps = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_showsteps")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function DungeonHuaRongView:addEvents()
	self._btnshowsteps:AddClickListener(self._btnshowstepsOnClick, self)
end

function DungeonHuaRongView:removeEvents()
	self._btnshowsteps:RemoveClickListener()
end

DungeonHuaRongView.originData = {
	0,
	1,
	2,
	3,
	4,
	5,
	6,
	7,
	8,
	9,
	10,
	11,
	12,
	13,
	14,
	15
}
DungeonHuaRongView.moveDuration = 0.5

function DungeonHuaRongView:_btnshowstepsOnClick()
	local msg = ""

	for i = 1, #self.clickedPoses do
		msg = msg .. "\n" .. string.format("Vector2(%s, %s),", self.clickedPoses[i].x, self.clickedPoses[i].y)
	end

	logWarn(msg)
end

function DungeonHuaRongView:_editableInitView()
	self.gridLayoutComp = self._gocontainer:GetComponent(gohelper.Type_GridLayoutGroup)

	gohelper.setActive(self._goitem, false)
	gohelper.setActive(self._btnshowsteps.gameObject, SLFramework.FrameworkSettings.IsEditor)
end

function DungeonHuaRongView:onUpdateParam()
	return
end

function DungeonHuaRongView:onOpen()
	self._callBack = self.viewParam.callBack
	self._callBackObject = self.viewParam.callBackObject
	self.itemList = self:getEmpty4x4List()
	self.clickList = {}
	self.emptyPos = Vector2(0, 0)
	self.boardData = self:initBoardData(DungeonHuaRongView.originData)
	self.movingCount = 0
	self._succ = false

	self:resetMoveProperties()
	self:refreshBoard(self.boardData)

	if SLFramework.FrameworkSettings.IsEditor then
		self.clickedPoses = {}
	end
end

function DungeonHuaRongView:onOpenFinish()
	self.gridLayoutComp.enabled = false
end

function DungeonHuaRongView:initBoardData(originData)
	local board = self:getEmpty4x4List(0)

	for i = 1, #originData do
		local x, y = self:_numTo4x4Pos(i)

		board[x][y] = originData[i]
	end

	return board
end

function DungeonHuaRongView:refreshBoard(boardData)
	for i = 1, #boardData do
		for j = 1, #boardData[i] do
			local item = self:getUserDataTb_()

			item.pos = Vector2(i, j)
			item.data = boardData[i][j]
			item.go = gohelper.clone(self._goitem, self._gocontainer, string.format("item%s_%s", i, j))

			gohelper.setActive(item.go, true)

			item.txtnumber = gohelper.findChildText(item.go, "#txt_number")
			item.simagebg = gohelper.findChildSingleImage(item.go, "#simage_bg")
			item.click = gohelper.getClick(item.go)

			item.click:AddClickListener(self._onClickItem, self, item)

			if boardData[i][j] ~= 0 then
				item.txtnumber.text = boardData[i][j]

				gohelper.setActive(item.txtnumber.gameObject, true)
				gohelper.setActive(item.simagebg.gameObject, true)
			else
				self.emptyPos = Vector2(i, j)

				gohelper.setActive(item.txtnumber.gameObject, false)
				gohelper.setActive(item.simagebg.gameObject, false)
			end

			self.itemList[i][j] = item

			table.insert(self.clickList, item.click)
		end
	end
end

function DungeonHuaRongView:_onClickItem(item)
	if self.movingCount ~= 0 then
		return
	end

	local x, y = item.pos.x, item.pos.y

	if x == self.emptyPos.x and y == self.emptyPos.y then
		return
	end

	if x ~= self.emptyPos.x and y ~= self.emptyPos.y then
		return
	end

	self:resetMoveProperties()

	self.clickAnchorPos = item.go.transform.anchoredPosition

	if x == self.emptyPos.x then
		if y > self.emptyPos.y then
			for i = self.emptyPos.y + 1, y do
				table.insert(self.currSrcTransform, self.itemList[x][i].go.transform)
				table.insert(self.currDestTransforms, self.itemList[x][i - 1].go.transform)
				table.insert(self.currSrcPos, Vector2(x, i))
				table.insert(self.currDestPos, Vector2(x, i - 1))
			end
		else
			for i = self.emptyPos.y - 1, y, -1 do
				table.insert(self.currSrcTransform, self.itemList[x][i].go.transform)
				table.insert(self.currDestTransforms, self.itemList[x][i + 1].go.transform)
				table.insert(self.currSrcPos, Vector2(x, i))
				table.insert(self.currDestPos, Vector2(x, i + 1))
			end
		end
	end

	if y == self.emptyPos.y then
		if x > self.emptyPos.x then
			for i = self.emptyPos.x + 1, x do
				table.insert(self.currSrcTransform, self.itemList[i][y].go.transform)
				table.insert(self.currDestTransforms, self.itemList[i - 1][y].go.transform)
				table.insert(self.currSrcPos, Vector2(i, y))
				table.insert(self.currDestPos, Vector2(i - 1, y))
			end
		else
			for i = self.emptyPos.x - 1, x, -1 do
				table.insert(self.currSrcTransform, self.itemList[i][y].go.transform)
				table.insert(self.currDestTransforms, self.itemList[i + 1][y].go.transform)
				table.insert(self.currSrcPos, Vector2(i, y))
				table.insert(self.currDestPos, Vector2(i + 1, y))
			end
		end
	end

	if SLFramework.FrameworkSettings.IsEditor then
		table.insert(self.clickedPoses, item.pos)
	end

	self:moveItems(self.currSrcTransform, self.currDestTransforms)
end

function DungeonHuaRongView:moveItems(srcTransforms, destTransforms)
	self.movingCount = #srcTransforms

	for i = 1, #srcTransforms do
		local destItemAnchorX, destItemAnchorY = recthelper.getAnchor(destTransforms[i])

		ZProj.TweenHelper.DOAnchorPos(srcTransforms[i], destItemAnchorX, destItemAnchorY, DungeonHuaRongView.moveDuration, self.moveDoneCallback, self)
	end
end

function DungeonHuaRongView:moveDoneCallback()
	self.movingCount = self.movingCount - 1

	if self.movingCount == 0 then
		self:changeBoardData()
		self:checkSuccess()
		self:resetMoveProperties()
	end
end

function DungeonHuaRongView:changeBoardData()
	local clickPos = self.currSrcPos[#self.currSrcPos]
	local emptyItem = self.itemList[self.emptyPos.x][self.emptyPos.y]

	self.emptyPos = clickPos
	emptyItem.go.transform.anchoredPosition = self.clickAnchorPos

	for i = 1, #self.currDestPos do
		self.itemList[self.currDestPos[i].x][self.currDestPos[i].y] = self.itemList[self.currSrcPos[i].x][self.currSrcPos[i].y]
		self.itemList[self.currDestPos[i].x][self.currDestPos[i].y].pos = Vector2(self.currDestPos[i].x, self.currDestPos[i].y)
	end

	self.itemList[clickPos.x][clickPos.y] = emptyItem
end

function DungeonHuaRongView:checkSuccess()
	if self:isValidBoard() then
		logWarn("success")

		self._succ = true

		for _, click in ipairs(self.clickList) do
			click:RemoveClickListener()
		end
	end
end

function DungeonHuaRongView:isValidBoard()
	for x = 1, 4 do
		for y = 1, 4 do
			if self.itemList[x][y].data + 1 ~= self:_4x4ToNumPos(x, y) then
				return false
			end
		end
	end

	return true
end

function DungeonHuaRongView:resetMoveProperties()
	self.currSrcTransform = {}
	self.currSrcPos = {}
	self.currDestTransforms = {}
	self.currDestPos = {}
	self.clickAnchorPos = nil
end

function DungeonHuaRongView:getEmpty4x4List(defaultValue)
	local list4x4 = {}

	for i = 1, 4 do
		list4x4[i] = {}

		for j = 1, 4 do
			table.insert(list4x4[i], defaultValue or 0)
		end
	end

	return list4x4
end

function DungeonHuaRongView:_numTo4x4Pos(num)
	local x = math.ceil(num / 4)
	local y = num % 4

	if y == 0 then
		y = 4
	end

	return x, y
end

function DungeonHuaRongView:_4x4ToNumPos(x, y)
	return (x - 1) * 4 + y
end

function DungeonHuaRongView:onClose()
	for _, click in ipairs(self.clickList) do
		click:RemoveClickListener()
	end

	self.itemList = {}

	if self._callBack then
		self._callBack(self._callBackObject, self._succ)
	end
end

function DungeonHuaRongView:onDestroyView()
	return
end

return DungeonHuaRongView
