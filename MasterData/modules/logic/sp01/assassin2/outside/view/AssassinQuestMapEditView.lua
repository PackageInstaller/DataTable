-- chunkname: @modules/logic/sp01/assassin2/outside/view/AssassinQuestMapEditView.lua

module("modules.logic.sp01.assassin2.outside.view.AssassinQuestMapEditView", package.seeall)

local AssassinQuestMapEditView = class("AssassinQuestMapEditView", BaseView)
local SingleQuestLabelItemWidth = 300
local SingleQuestLabelItemHeight = 50
local QuestLabelListPosX = -352
local QuestLabelListPosY = 0

function AssassinQuestMapEditView:onInitView()
	self._goroot = gohelper.findChild(self.viewGO, "root")
	self._gocontainer = gohelper.findChild(self.viewGO, "root/#go_drag/simage_fullbg/#go_container")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AssassinQuestMapEditView:addEvents()
	self.frameHandle = UpdateBeat:CreateListener(self.onFrame, self)

	UpdateBeat:AddListener(self.frameHandle)
end

function AssassinQuestMapEditView:removeEvents()
	if self._questEditItemTab then
		for _, questEditItem in pairs(self._questEditItemTab) do
			questEditItem.btnQuestItem:RemoveClickListener()
		end
	end

	if self._btnexport then
		self._btnexport:RemoveClickListener()
	end

	if self._drag then
		self._drag:RemoveDragBeginListener()
		self._drag:RemoveDragListener()
		self._drag:RemoveDragEndListener()
	end
end

function AssassinQuestMapEditView:onFrame()
	if UnityEngine.Input.GetKeyUp(UnityEngine.KeyCode.Q) then
		if self._isEditMode then
			self._isEditMode = false

			gohelper.setActive(self.goDrag, false)
		else
			if gohelper.isNil(self.goEditBtnList) then
				self:initEditorTools()
				self:initQuestCoList()
			end

			self._isEditMode = true

			GameFacade.showToastString(string.format("进入编辑模式，MapId : %s", self._mapId))
		end

		gohelper.setActive(self.goEditBtnList, self._isEditMode)
	end
end

function AssassinQuestMapEditView:_btnquestItemOnClick(index)
	local item = self._questEditItemTab[index]
	local questId = item and item.questId
	local questCo = AssassinConfig.instance:getQuestCfg(questId)

	if not questCo then
		return
	end

	if self._curEditItemIndex then
		local lastEditItem = self._questEditItemTab[self._curEditItemIndex]

		if lastEditItem then
			SLFramework.UGUI.GuiHelper.SetColor(lastEditItem.txtQuestName, "#FFFFFF")
		end

		if self._curEditItemIndex == index then
			self._editItemIcon = nil
			self._curEditItemIndex = false
		else
			self._editItemIcon = self:_getQuestIconItem(questCo.id)
			self._curEditItemIndex = index
		end

		gohelper.setActive(self.goDrag, self._curEditItemIndex)

		if self._curEditItemIndex then
			if self._curEditItemIndex then
				SLFramework.UGUI.GuiHelper.SetColor(self._curEditItemIndex.txtQuestName, "#FF0000")
			end
		end
	end
end

function AssassinQuestMapEditView:_getQuestIconItem(questId)
	local questMapView = self.viewContainer.assassinMapView

	if questMapView and questMapView._showQuestItemDict then
		return questMapView._showQuestItemDict[questId]
	end
end

function AssassinQuestMapEditView:_onDrag(_, pointerEventData)
	if not self._editItemIcon then
		return
	end

	local temp_pos = recthelper.screenPosToAnchorPos(GamepadController.instance:getMousePosition(), self._transcontainer)

	self._editItemIcon:setPosition(temp_pos.x, temp_pos.y)
end

function AssassinQuestMapEditView:_btnexportOnClick()
	if not self._editItemIcon then
		GameFacade.showToastString("Export Failed\nNo selected edit item")

		return
	end

	local questId = self._editItemIcon:getQuestId()
	local posX, posY = self._editItemIcon:getPosition()

	posX = string.format("%.2f", posX)
	posY = string.format("%.2f", posY)

	local exportPosStr = string.format("%s#%s", posX, posY)

	ZProj.UGUIHelper.CopyText(exportPosStr)
	GameFacade.showToastString(string.format("Export Quest:%s\nPos:(%s, %s)", questId, posX, posY))
end

function AssassinQuestMapEditView:_editableInitView()
	self._isEditMode = false
	self._transcontainer = self._gocontainer.transform
end

function AssassinQuestMapEditView:onOpen()
	self._mapId = self.viewParam and self.viewParam.mapId
end

function AssassinQuestMapEditView:_createBtnNotGraphic(rootGo, goName)
	local go = gohelper.create2d(rootGo, goName)

	ZProj.UGUIHelper.SetColorAlpha(gohelper.onceAddComponent(go, gohelper.Type_Image), 0)
	gohelper.onceAddComponent(go, typeof(UnityEngine.UI.Button))

	return go, gohelper.findChildButtonWithAudio(rootGo, goName, AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)
end

function AssassinQuestMapEditView:initEditorTools()
	local tempTxtComp = self.viewGO:GetComponentInChildren(gohelper.Type_TextMesh)

	self._txtCompFont = tempTxtComp and tempTxtComp.font
	self.goDrag = self:_createBtnNotGraphic(self._goroot, "edit_DragArea")

	local gocontainerWidth = recthelper.getWidth(self._transcontainer)
	local gocontainerHeight = recthelper.getHeight(self._transcontainer)
	local gocontainerPosX, gocontainerPosY = recthelper.getAnchor(self._transcontainer)

	recthelper.setSize(self.goDrag.transform, gocontainerWidth, gocontainerHeight)
	recthelper.setAnchor(self.goDrag.transform, gocontainerPosX, gocontainerPosY)

	self._drag = SLFramework.UGUI.UIDragListener.Get(self.goDrag)

	self._drag:AddDragBeginListener(self._onDrag, self)
	self._drag:AddDragListener(self._onDrag, self)
	self._drag:AddDragEndListener(self._onDrag, self)

	self._questEditItemTab = self:getUserDataTb_()
end

function AssassinQuestMapEditView:initQuestCoList()
	local unlockQuestIdList = AssassinOutsideModel.instance:getMapUnlockQuestIdList(self._mapId)

	self.goEditBtnList = gohelper.create2d(self.viewGO, "edit_BtnList")

	local questListWidth = SingleQuestLabelItemWidth
	local questListHeight = SingleQuestLabelItemHeight * #unlockQuestIdList

	recthelper.setSize(self.goEditBtnList.transform, questListWidth, questListHeight)
	recthelper.setAnchor(self.goEditBtnList.transform, QuestLabelListPosX, QuestLabelListPosY)

	local lg = gohelper.onceAddComponent(self.goEditBtnList, gohelper.Type_VerticalLayoutGroup)

	lg.childControlWidth = false
	lg.childControlHeight = false
	lg.childForceExpandWidth = false
	lg.childForceExpandHeight = false

	for index, questId in ipairs(unlockQuestIdList) do
		local questCo = AssassinConfig.instance:getQuestCfg(questId)
		local questEditItem = self:_createSingleQuestEditItem(self.goEditBtnList, index, questId)

		questEditItem.txtQuestName.text = questCo.title
	end

	self._goexportbtn, self._btnexport = self:_createBtnNotGraphic(self.goEditBtnList, "edit_export")

	recthelper.setSize(self._goexportbtn.transform, SingleQuestLabelItemWidth, SingleQuestLabelItemHeight)

	local goText = gohelper.create2d(self._goexportbtn, "txt_name")

	recthelper.setSize(goText.transform, SingleQuestLabelItemWidth, SingleQuestLabelItemHeight)

	local exprotTxtComp = gohelper.onceAddComponent(goText, gohelper.Type_TextMesh)

	exprotTxtComp.text = "Export"
	exprotTxtComp.font = self._txtCompFont

	self._btnexport:AddClickListener(self._btnexportOnClick, self)
end

function AssassinQuestMapEditView:_createSingleQuestEditItem(rootGo, index, questId)
	local questEditItem = self._questEditItemTab[index]

	if not questEditItem then
		questEditItem = self:getUserDataTb_()
		questEditItem.go, questEditItem.btnQuestItem = self:_createBtnNotGraphic(rootGo, "edit_questitem_" .. index)

		questEditItem.btnQuestItem:AddClickListener(self._btnquestItemOnClick, self, index)

		local goText = gohelper.create2d(questEditItem.go, "txt_name")

		questEditItem.txtQuestName = gohelper.onceAddComponent(goText, gohelper.Type_TextMesh)
		questEditItem.txtQuestName.font = self._txtCompFont

		recthelper.setSize(goText.transform, SingleQuestLabelItemWidth, SingleQuestLabelItemHeight)
		recthelper.setSize(questEditItem.go.transform, SingleQuestLabelItemWidth, SingleQuestLabelItemHeight)

		self._questEditItemTab[index] = questEditItem
	end

	questEditItem.questId = questId

	return questEditItem
end

function AssassinQuestMapEditView:onClose()
	if self.frameHandle then
		UpdateBeat:RemoveListener(self.frameHandle)
	end

	self.frameHandle = nil
end

function AssassinQuestMapEditView:onDestroyView()
	return
end

return AssassinQuestMapEditView
