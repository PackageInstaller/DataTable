-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/yearcard2025/main/YearCardMain2025View.lua

module("logic.extensions.yearcard.view.yearcard2025.main.YearCardMain2025View", package.seeall)

local YearCardMain2025View = class("YearCardMain2025View", YearCardMain2022View)

function YearCardMain2025View:buildUI()
	self._curActId = 8005
	self._btnTip = self:getBtn("btnTip")
	self._btnClose = self:getBtn("btnClose")
	self._txtTime = self:getTxt("txtTime")
	self._curPage = self:getGo("container")
	self._bg = self:getGo("bg")
	self._dropLine = self:getGo("tablist/viewport/content/dropLine")
	self._tablist = self:getGo("tablist")
	self._rootcell = self:getGo("tablist/rootcell")
	self._leafcell = self:getGo("tablist/leafcell")
	self._tableView = ScrollerList.create(self._tablist, {
		self._rootcell,
		self._leafcell
	}, GameUtil.handler(self._updateTagCell, self), GameUtil.handler(self._clearTagCell, self))

	self._tableView:regGetTagByIdx(GameUtil.handler(self._getTagByData, self))
	self._tableView:regGetCellSize(GameUtil.handler(self._getCellSize, self))

	self._dropLineGo = self._dropLine

	if self._dropLineGo then
		self._dropLineTr = self._dropLineGo.transform

		local x, y, z = Framework.TransformUtil.GetAnchoredPos(self._dropLineTr, 0, 0)

		self._dropLineOffsetX = x
		self._dropLineV2 = Vector2.New(self._dropLineTr.sizeDelta.x, 0)
		self._dropLineTr.sizeDelta = self._dropLineV2
	end
end

function YearCardMain2025View:_getTagByData(data, idx)
	if data.leaf == 1 then
		return 1
	else
		return 2
	end
end

function YearCardMain2025View:_getCellSize(view, idx)
	local list = self._tableView:getData()

	if not list[idx + 1] then
		if list[idx + 1].leaf == 1 then
			return 192, 72
		else
			return 192, 62
		end
	end
end

function YearCardMain2025View:_clearTagCell(cell)
	return
end

function YearCardMain2025View:_updateTagCell(view, cell, tabData, tag)
	if tag == 1 then
		self:_updateRootCell(view, cell, tabData, tag)
	elseif tag == 2 then
		self:_updateLeafCell(view, cell, tabData, tag)
	end
end

function YearCardMain2025View:_updateRootCell(view, cell, data, tag)
	GameUtil.addClickHandler(cell, GameUtil.handler(self._onClickCell, self, data.root, data.leaf))

	local imgNor = goutil.findChild(cell, "imgNor")
	local imgSelect = goutil.findChild(cell, "imgSelect")
	local txtNorGo = goutil.findChild(cell, "txtNorGo")
	local txtNor = goutil.findChildTextComponent(cell, "txtNorGo/txt")
	local txtSelectGo = goutil.findChild(cell, "txtSelectGo")
	local txtSelect = goutil.findChildTextComponent(cell, "txtSelectGo/txt")
	local dot = goutil.findChild(cell, "dot")
	local newTag = goutil.findChild(cell, "newTag")
	local txtTag = goutil.findChildTextComponent(cell, "newTag/txtTag")

	GameUtil.SetActive(dot, false)
	GameUtil.SetActive(newTag, false)

	txtNor.text = data.tag
	txtSelect.text = data.tag

	GameUtil.SetActive(imgSelect, data.root == self._selectRoot)
	GameUtil.SetActive(txtSelectGo, data.root == self._selectRoot)
	GameUtil.SetActive(imgNor, data.root ~= self._selectRoot)
	GameUtil.SetActive(txtNorGo, data.root ~= self._selectRoot)
	goutil.setActive(dot, false)
	RedPointController.instance:unregRedPoint(dot)

	if not string.nilorempty(data.redpointId) then
		if data.root == 1 then
			RedPointController.instance:regRedPoint(dot, RedPointModel.ID_YEAR, data.redpointId)
		else
			RedPointController.instance:regRedPoint(dot, data.redpointId)
		end
	end
end

function YearCardMain2025View:_updateLeafCell(view, cell, data, tag)
	GameUtil.addClickHandler(cell, GameUtil.handler(self._onClickCell, self, data.root, data.leaf))

	local imgNor = goutil.findChild(cell, "imgNor")
	local imgSelect = goutil.findChild(cell, "imgSelect")
	local txtNorGo = goutil.findChild(cell, "txtNorGo")
	local txtNor = goutil.findChildTextComponent(cell, "txtNorGo/txt")
	local txtSelectGo = goutil.findChild(cell, "txtSelectGo")
	local txtSelect = goutil.findChildTextComponent(cell, "txtSelectGo/txt")
	local dot = goutil.findChild(cell, "dot")
	local newTag = goutil.findChild(cell, "newTag")
	local txtTag = goutil.findChildTextComponent(cell, "newTag/txtTag")

	GameUtil.SetActive(dot, false)
	GameUtil.SetActive(newTag, false)

	txtNor.text = data.tag
	txtSelect.text = data.tag

	GameUtil.SetActive(imgSelect, data == self._selectData)
	GameUtil.SetActive(txtSelectGo, data == self._selectData)
	GameUtil.SetActive(imgNor, data ~= self._selectData)
	GameUtil.SetActive(txtNorGo, data ~= self._selectData)
	goutil.setActive(dot, false)

	if not string.nilorempty(data.redpointId) then
		if data.root == 1 then
			RedPointController.instance:regRedPoint(dot, RedPointModel.ID_YEAR, data.redpointId)
		else
			RedPointController.instance:regRedPoint(dot, data.redpointId)
		end
	end
end

function YearCardMain2025View:_reloadList()
	YearCardMain2025View.super._reloadList(self)

	local dropLineSizeY = 0
	local dropLineHeight = 0
	local gap = 0

	for i, v in ipairs(self._curDataList or {}) do
		if v.leaf == 1 then
			dropLineSizeY = dropLineSizeY - 72
		elseif v.root == self._selectRoot and self._isOpen then
			dropLineHeight = dropLineHeight + 62
			gap = 25
		end

		if v == self._selectData then
			self._tableView:MoveCellToCenter(i - 1)
		end
	end

	if self._dropLineGo then
		if self._isOpen then
			self._dropLineV2.y = dropLineHeight + gap
			self._dropLineTr.sizeDelta = self._dropLineV2

			GameUtil.setAnchoredPos(self._dropLineGo, self._dropLineOffsetX, dropLineSizeY + 20)
		else
			self._dropLineV2.y = 0
			self._dropLineTr.sizeDelta = self._dropLineV2
		end
	end
end

function YearCardMain2025View:_onClickTip()
	UIStateManager.instance:push(ViewName.RulesView, "yearcardRule2025")
end

function YearCardMain2025View:onEnter()
	YearCardMain2025View.super.onEnter(self)
	ImpressionStickersController.instance:sendPM_Annuity2025ChangeRankInfoReq()
end

return YearCardMain2025View
