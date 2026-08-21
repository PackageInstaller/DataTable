-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/view/editor/MainlineEditorView.lua

module("logic.extensions.dungeon.view.editor.MainlineEditorView", package.seeall)

local M = class("MainlineEditorView", ViewComponent)
local kShowPosX = -275
local kHidePosX = 215

M.DungeonTypeEnum = {
	Branchline = 2,
	Dungeon = 1
}
M.MainlineType = {
	DungeonEnum.Difficulty.Easy,
	DungeonEnum.Difficulty.Normal
}

local DungeonType2Name = {
	[M.DungeonTypeEnum.Dungeon] = "关卡",
	[M.DungeonTypeEnum.Branchline] = "断章"
}

function M:ctor()
	self._curChapterId = 1
	self._isShowContent = false
	self._lineLeftOffset = Vector3.New(70, 0, 0)
	self._lineRightOffset = Vector3.New(-80, 0, 0)
end

function M:buildUI()
	self._dropDownID = self:getUIComponent("0&dropDown_-1238464703", UIComponentType.Dropdown)
	self._dropDownName = self:getUIComponent("1&dropDown_-1238464703", UIComponentType.Dropdown)
	self._dropAdapterID = self:getUIComponent("0&dropDown_-1238464703", UIComponentType.DropdownApapter)
	self._dropAdapterName = self:getUIComponent("1&dropDown_-1238464703", UIComponentType.DropdownApapter)
	self._textDropId = self:getText("0&dropDown_747233718")
	self._textDropName = self:getText("1&dropDown_747233718")
	self._textDungeonName = self:getText("mainline_editor_view_-342114457")
	self._dropDownDungeonType = self:getUIComponent("2&dropDown_-1238464703", UIComponentType.Dropdown)
	self._dropAdapterDungeonType = self:getUIComponent("2&dropDown_-1238464703", UIComponentType.DropdownApapter)
	self._textDungeonType = self:getText("2&dropDown_747233718")
	self._btnCreateDungeon = self:getBtn("mainline_editor_view_-1683863387")
	self._rectContentRoot = self:getRectTransform("mainline_editor_view_-784568491")
	self._btnShow = self:getBtn("mainline_editor_view_-271571084")
	self._btnClose = self:getBtn("mainline_editor_view_-1690166410")

	local goLineAngle = self:getGo("mainline_editor_view_-765258393")

	self._lineAngleCell = Astral.SimpleLuaComponentContainer.Add(goLineAngle, EditorTextInputVecCell)

	self._lineAngleCell:setData(0, self._onLineAngleChange, nil, self)

	local goLineLength = self:getGo("mainline_editor_view_833276571")

	self._lineLengthCell = Astral.SimpleLuaComponentContainer.Add(goLineLength, EditorTextInputVecCell)

	self._lineLengthCell:setData(0, self._onLineLengthChange, nil, self)

	local goDungeonPos = self:getGo("mainline_editor_view_-1951941273")
	local goLinePos = self:getGo("mainline_editor_view_1010992286")

	self._dungeonPosCell = Astral.SimpleLuaComponentContainer.Add(goDungeonPos, MainPerformEditorVec3Cell)
	self._linePosCell = Astral.SimpleLuaComponentContainer.Add(goLinePos, MainPerformEditorVec3Cell)
	self._goDungeon = self:getGo("mainline_editor_view_-2033942994")

	goutil.setActive(self._goDungeon, false)

	self._btnSaveMainline = self:getBtn("mainline_editor_view_2050041378")
	self._btnDelteMainline = self:getBtn("mainline_editor_view_1242628546")
	self._btnCreateMainline = self:getBtn("mainline_editor_view_-1761965543")
	self._btnAdjustLine = self:getBtn("mainline_editor_view_-835937799")

	local goLineLeftOffset = self:getGo("mainline_editor_view_2110558425")
	local goLineRightOffset = self:getGo("mainline_editor_view_-1373960896")

	self._lineLeftOffsetCell = Astral.SimpleLuaComponentContainer.Add(goLineLeftOffset, MainPerformEditorVec3Cell)
	self._lineRightOffsetCell = Astral.SimpleLuaComponentContainer.Add(goLineRightOffset, MainPerformEditorVec3Cell)
	self._contentWidth = RectTransformUtils.GetWidth(self._rectContentRoot)
	self._dungeonView = self._viewPresentor:getDungeonView()

	RectTransformUtils.SetAnchoredPosition(self._rectContentRoot, kHidePosX, 0)
end

function M:bindEvents()
	self._btnShow:AddClickListener(self._onClickShow, self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnCreateDungeon:AddClickListener(self._onClickCreateDungeon, self)
	self._btnSaveMainline:AddClickListener(self._onClickSaveMainline, self)
	self._btnDelteMainline:AddClickListener(self._onClickDeleteMainline, self)
	self._btnCreateMainline:AddClickListener(self._onClickCreateMainline, self)
	self._btnAdjustLine:AddClickListener(self._onClickAdjustLine, self)
	self._dropAdapterID:AddListener(self._onDropDownID, self)
	self._dropAdapterName:AddListener(self._onDropDownName, self)
	self._dropAdapterDungeonType:AddListener(self._onDropDownDungeonType, self)
end

function M:unbindEvents()
	self._btnShow:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnCreateDungeon:RemoveClickListener()
	self._btnSaveMainline:RemoveClickListener()
	self._btnDelteMainline:RemoveClickListener()
	self._btnCreateMainline:RemoveClickListener()
	self._btnAdjustLine:RemoveClickListener()
	self._dropAdapterID:RemoveClickListener()
	self._dropAdapterName:RemoveClickListener()
	self._dropAdapterDungeonType:RemoveClickListener()
end

function M:onEnter()
	self:setEvent(true)
	self._dungeonPosCell:setValueChangeListener(self._onDungeonPosChange, self)
	self._linePosCell:setValueChangeListener(self._onLinePosChange, self)
	self._lineLeftOffsetCell:setValueChangeListener(self._onLineLeftOffsetChange, self)
	self._lineRightOffsetCell:setValueChangeListener(self._onLineRightOffsetChange, self)
	self._lineLeftOffsetCell:setVec3(self._lineLeftOffset)
	self._lineRightOffsetCell:setVec3(self._lineRightOffset)
	self:_showContent(true)
	self:_init()

	self._dropDownID.value = 0

	self:_onSelectChapter()
	self:_refreshView()
end

function M:onExit()
	self:setEvent(false)
	self._dungeonPosCell:reset()
	self._linePosCell:reset()
	self._lineLeftOffsetCell:reset()
	self._lineRightOffsetCell:reset()
end

function M:destroyUI()
	return
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.MAINLINE_DUNGEON_SELECT_EDITOR, self._onSelectDungeon, self)
		GlobalDispatcher:addEventListener(EventType.MAINLINE_DUNGEON_POS_EDITOR, self._onDungeonMovePos, self)
		GlobalDispatcher:addEventListener(EventType.MAINLINE_LINE_POS_EDITOR, self._onLineMovePos, self)
	else
		GlobalDispatcher:removeEventListener(EventType.MAINLINE_DUNGEON_SELECT_EDITOR, self._onSelectDungeon, self)
		GlobalDispatcher:removeEventListener(EventType.MAINLINE_DUNGEON_POS_EDITOR, self._onDungeonMovePos, self)
		GlobalDispatcher:removeEventListener(EventType.MAINLINE_LINE_POS_EDITOR, self._onLineMovePos, self)
	end
end

function M:_openAllMainlineDungeon()
	local data = {
		cmd = GameEnum.GMCmdEnum.MainlineNoVerification,
		value = {
			{
				on = 1
			}
		}
	}

	HackToolAgent.instance:sendGmRequest(data)
	DungeonModel.instance:setAllDungeonUnlock(true)
end

function M:_init()
	self._mainlineDataList = DungeonConfig.instance:getCfgMainLineChapter()
	self._idList = {}
	self._nameList = {}

	for _, chapterCO in ipairs(self._mainlineDataList) do
		if not table.indexof(self._idList, chapterCO.chapterId) then
			table.insert(self._idList, chapterCO.chapterId)
			table.insert(self._nameList, chapterCO.name)
		end
	end

	MainScenePerformUtil.updateDropDownLst(self._dropDownID, self._idList)
end

function M:_refreshView()
	return
end

function M:_onDropDownID(index)
	self._curChapterId = self._idList[index + 1]

	self:_onSelectChapter()
end

function M:_onDropDownName(index)
	self._curChapterId = index + 1

	self:_onSelectChapter()
end

function M:_onSelectDifficulty(index)
	local difficulty = self.MainlineType[index + 1]

	self._textDropName.text = DungeonEnum.MainLineDiffName[difficulty]
end

function M:_onSelectChapter()
	self._textDropId.text = self._idList[self._curChapterId]
	self._textDungeonName.text = self._nameList[self._curChapterId]

	self._dungeonView:changeChapter(self._curChapterId)
end

function M:_onDropDownDungeonType(index)
	local dungeonType = index + 1
	local name = DungeonType2Name[dungeonType]

	self._textDungeonType.text = name
	self._curDungeonType = dungeonType
end

function M:_changeDifficult()
	return
end

function M:_onClickShow()
	self:_showContent(not self._isShowContent)
end

function M:_showContent(show)
	self._isShowContent = show

	if show then
		local posX = self:_anchorPos2Local(self._rectContentRoot, kShowPosX)

		self._rectContentRoot:DOLocalMoveX(posX, 0.3):SetEase(DG.Tweening.Ease.OutBack, 1)
	else
		local posX = self:_anchorPos2Local(self._rectContentRoot, kHidePosX)

		self._rectContentRoot:DOLocalMoveX(posX, 0.3):SetEase(DG.Tweening.Ease.OutBack, 1)
	end

	goutil.setActive(self._btnClose.gameObject, not show)
end

function M:_anchorPos2Local(rectTrans, x, y)
	local posX, posY = Astral.TransformUtil.GetAnchoredPos(rectTrans, 0, 0)

	RectTransformUtils.SetAnchoredPosition(rectTrans, x, y or posY)

	local resultX, resultY = Astral.TransformUtil.GetLocalPos(rectTrans, 0, 0, 0)

	RectTransformUtils.SetAnchoredPosition(rectTrans, posX, posY)

	return resultX, resultY
end

function M:_onClickClose()
	self:close()
end

function M:_onClickCreateDungeon()
	return
end

function M:_onClickDeleteDungeon()
	return
end

function M:_onClickCreateMainline()
	self._dungeonView:createMainline()
end

function M:_onClickSaveMainline()
	self._dungeonView:save()
end

function M:_onClickDeleteMainline()
	self._dungeonView:deleteMainline()
end

function M:_onClickAdjustLine()
	self._dungeonView:adjustLine(self._lineLeftOffset, self._lineRightOffset)
end

function M:_onDungeonPosChange(vec3)
	self._curDungeonCell:setPos(vec3)
end

function M:_onLinePosChange(vec3)
	self._curDungeonCell:setLinePos(vec3)
end

function M:_onLineAngleChange(angle)
	self._curDungeonCell:setLineAngle(angle)
end

function M:_onLineLengthChange(length)
	self._curDungeonCell:setLineLength(length)
end

function M:_onLineLeftOffsetChange(vec3)
	self._lineLeftOffset = vec3
end

function M:_onLineRightOffsetChange(vec3)
	self._lineRightOffset = vec3
end

function M:_onDungeonMovePos(_, vec3)
	self._dungeonPosCell:setVec3(vec3)
end

function M:_onLineMovePos(_, vec3)
	self._linePosCell:setVec3(vec3)
end

function M:_onSelectDungeon(_, dungeonCell)
	if self._curDungeonCell == dungeonCell then
		return
	end

	self._curDungeonCell = dungeonCell

	local focusDungeon = self._curDungeonCell ~= nil

	goutil.setActive(self._goDungeon, focusDungeon)

	if focusDungeon then
		self._dungeonPosCell:setVec3(self._curDungeonCell:getPos())
		self._linePosCell:setVec3(self._curDungeonCell:getLinePos())
		self._lineAngleCell:setVal(self._curDungeonCell:getLineAngle())
		self._lineLengthCell:setVal(self._curDungeonCell:getLineLength())
	end
end

function M:getLineLeftOffset()
	return self._lineLeftOffset
end

function M:getLineRightOffset()
	return self._lineRightOffset
end

return M
