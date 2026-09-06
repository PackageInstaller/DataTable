-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/popularitylist/view/PopularityListView.lua

module("logic.extensions.popularitylist.view.PopularityListView", package.seeall)

local PopularityListView = class("PopularityListView", ViewComponent)

function PopularityListView:unbindEvents()
	PopularityListView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._painterBtn:RemoveClickListener()
	self._petBtn:RemoveClickListener()
	self._tipBtn:RemoveClickListener()
end

function PopularityListView:bindEvents()
	PopularityListView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._painterBtn:AddClickListener(self._onClickPainter, self)
	self._petBtn:AddClickListener(self._onClickPet, self)
	self._tipBtn:AddClickListener(self._onClickTip, self)
end

function PopularityListView:buildUI()
	PopularityListView.super.buildUI(self)

	self._closeBtn = self:getBtn("topleft/btnClose")
	self._anchor = self:getGo("anchor")
	self._cell = self:getGo("cell")
	self._painterBtn = self:getBtn("painterBtn")
	self._painterSelect = self:getGo("painterBtn/select")
	self._petBtn = self:getBtn("petBtn")
	self._petSelect = self:getGo("petBtn/select")
	self._timeText = self:getTxt("timeBg/Text")
	self._times = self:getTxt("times")
	self._tipBtn = self:getBtn("topleft/btnTip")
	self._imgTitle = self:getGo("imgTitle")
end

function PopularityListView:onExit()
	PopularityListView.super.onExit(self)

	self._selectType = nil

	self:_clearCell()
	removetimer(self._timer, self)
	FixedUpdateBeat:Remove(self._roteAnim, self)
	GlobalDispatcher:removeListener(PopularityListController.PM_GetSkinVoteCountsRes, self._handlePM_GetSkinVoteCountsRes, self)
	GlobalDispatcher:removeListener(PopularityListController.PM_SkinVoteRes, self._handlePM_SkinVoteRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.ItemGetViewDoClosed, self._itemGet, self)
	uGuiUtil.clearImage(self._imgTitle)
	self._beginDrag:RemoveLuaHandler(self._beginDragCode)
	self._endDrag:RemoveLuaHandler(self._endDragCode)
	self._drag:RemoveLuaHandler(self._dragCode)
	UIEffectManager.instance:stopEffect(self._viewEff)
end

function PopularityListView:onEnter()
	PopularityListView.super.onEnter(self)

	self._initRad = 7
	self._spaceAngle = 7
	self._curAngle = 0
	self._radius = 2800
	self._cellList = {}
	self._activityInfo = PopularityListController.instance:getActivity()

	Framework.TransformUtil.SetLocalRotation(self._anchor.transform, 0, 0, self._initRad)

	self._beginDrag = BeginDragHandler.Get(self._anchor)
	self._endDrag = EndDragHandler.Get(self._anchor)
	self._drag = DragHandler.Get(self._anchor)
	self._beginDragCode = self._beginDrag:AddLuaHandler(function(_go, eventData)
		self:_OnBeginDrag(_go, eventData)
	end)
	self._endDragCode = self._endDrag:AddLuaHandler(function(_go, eventData)
		self:_OnEndDrag(_go, eventData)
	end)
	self._dragCode = self._drag:AddLuaHandler(function(_go, eventData)
		self:_OnDrag(_go, eventData)
	end)

	GlobalDispatcher:addListener(PopularityListController.PM_GetSkinVoteCountsRes, self._handlePM_GetSkinVoteCountsRes, self)
	GlobalDispatcher:addListener(PopularityListController.PM_SkinVoteRes, self._handlePM_SkinVoteRes, self)
	GlobalDispatcher:addListener(GlobalNotify.ItemGetViewDoClosed, self._itemGet, self)
	PopularityListController.instance:sendPM_GetSkinVoteCountsReq(self._activityInfo.activityId)
	self:_timer()
	settimer(1, self._timer, self, true)

	self._viewEff = UIEffectManager.instance:playEffect(self, "fx_ui_2021930/fx_ui_pifuhuashirenyixuan/fx_ui_pifuhuashirennixuan.prefab", nil, nil, nil, true, nil, nil, function(_, eff)
		eff:setParent(self.mainGO.transform)
		eff:setScale(1)
		eff:setLocalPos()
	end)
end

function PopularityListView:_handlePM_GetSkinVoteCountsRes()
	if GameUtil.getUserData(GameEnum.PopularityList.First) == nil then
		UIStateManager.instance:push(ViewName.DialogueView, PopularityListConfig.instance:getTextByKey("DIALOG_1"))
		GameUtil.saveUserData(GameEnum.PopularityList.First, true)
		GameUtil.saveUserDayData(GameEnum.PopularityList.PetVote, true)
	elseif PopularityListModel.instance:getTimes(GameEnum.PopularityList.Pet) > 0 and GameUtil.getUserDayData(GameEnum.PopularityList.PetVote) == nil then
		UIStateManager.instance:push(ViewName.DialogueView, PopularityListConfig.instance:getTextByKey("DIALOG_2"))
		GameUtil.saveUserDayData(GameEnum.PopularityList.PetVote, true)
	elseif PopularityListModel.instance:getTimes(GameEnum.PopularityList.Painter) > 0 and PopularityListModel.instance:getTimes(GameEnum.PopularityList.Pet) == 0 and GameUtil.getUserDayData(GameEnum.PopularityList.PainterVote) == nil then
		UIStateManager.instance:push(ViewName.DialogueView, PopularityListConfig.instance:getTextByKey("DIALOG_3"))
		GameUtil.saveUserDayData(GameEnum.PopularityList.PainterVote, true)
	end

	self:_initCellList()

	if PopularityListModel.instance:getSelectType() == GameEnum.PopularityList.Painter then
		self:_onClickPainter()
	elseif PopularityListModel.instance:getTimes(GameEnum.PopularityList.Pet) > 0 or PopularityListModel.instance:getSelectType() == GameEnum.PopularityList.Pet then
		self:_onClickPet()
	else
		if PopularityListModel.instance:getTimes(GameEnum.PopularityList.Painter) > 0 and GameUtil.getUserDayData(GameEnum.PopularityList.PainterVote) == nil then
			UIStateManager.instance:push(ViewName.DialogueView, PopularityListConfig.instance:getTextByKey("DIALOG_3"))
			GameUtil.saveUserDayData(GameEnum.PopularityList.PainterVote, true)
		end

		self:_onClickPainter()
	end

	PopularityListModel.instance:setSelectType()
end

function PopularityListView:_handlePM_SkinVoteRes()
	self._times.text = PopularityListController.instance:getText("TEXT_2", PopularityListModel.instance:getTimes(self._selectType))

	for i, cell in ipairs(self._cellList) do
		if self._data[cell.index] then
			cell.voteChange:SetState(PopularityListModel.instance:isVote(self._data[cell.index].id) and 1 or 0)

			cell.voteNum.text = self._data[cell.index].count
		end
	end
end

function PopularityListView:_itemGet()
	if PopularityListModel.instance:getTimes(GameEnum.PopularityList.Pet) <= 0 and self._selectType == GameEnum.PopularityList.Pet then
		UIStateManager.instance:push(ViewName.DialogueView, PopularityListConfig.instance:getTextByKey("DIALOG_3"))
		GameUtil.saveUserDayData(GameEnum.PopularityList.PainterVote, true)
		self:_onClickPainter()
	end
end

function PopularityListView:_onClickPainter()
	if PopularityListModel.instance:getTimes(GameEnum.PopularityList.Pet) <= 0 then
		goutil.setActive(self._painterSelect, true)
		goutil.setActive(self._petSelect, false)
		self:_updateView(GameEnum.PopularityList.Painter)
	else
		FloatWordMgr.instance:show(PopularityListController.instance:getText("TEXT_8"))
	end
end

function PopularityListView:_onClickPet()
	goutil.setActive(self._painterSelect, false)
	goutil.setActive(self._petSelect, true)
	self:_updateView(GameEnum.PopularityList.Pet)
end

function PopularityListView:_onClickTip()
	UIStateManager.instance:push(ViewName.RulesView, "popularitylist")
end

function PopularityListView:_initCellList()
	self._data = PopularityListModel.instance:getItemData(self._activityInfo.activityId, GameEnum.PopularityList.Painter)
	self._maxAngle = #self._data * self._spaceAngle - 2 * self._spaceAngle

	for i = 1, 10 do
		local angle = self._initRad - i * self._spaceAngle + 90

		if angle < 0 - self._initRad then
			break
		end

		local cell = goutil.cloneAndSetParent(self._cell, self._anchor.transform)

		goutil.setActive(cell, true)

		local cellRect = cell:GetComponent(goutil.Type_RectTransform)

		Framework.TransformUtil.SetAnchoredPos(cellRect, self._radius * math.cos(math.rad(angle)), self._radius * math.sin(math.rad(angle)))
		Framework.TransformUtil.SetLocalRotation(cell.transform, 0, 0, angle - 90)

		self._cellList[i] = self:_getPainerCellTable(cell)
		self._cellList[i].angle = angle
		self._cellList[i].index = i

		self:_updatePainterCell(self._cellList[i], self._data[i])
	end

	goutil.setActive(self._cell, false)
end

function PopularityListView:_getPainerCellTable(go)
	local tab = {
		go = go,
		name = goutil.findChildTextComponent(go, "painter/name")
	}

	tab.rect = go:GetComponent(goutil.Type_RectTransform)
	tab.con = goutil.findChild(go, "painter/con")
	tab.conBtn = Framework.ButtonAdapter.Get(tab.con)
	tab.rank = goutil.findChild(go, "painter/rank")
	tab.rankNum = goutil.findChildTextComponent(go, "painter/rank/num/txt")
	tab.rankGroup = goutil.findChildComponent(go, "painter/rank/num", ComponentType.UIChangeGroup)
	tab.voteChange = goutil.findChildComponent(go, "painter/voteBtn", ComponentType.UIImageSpriteChange)
	tab.voteBtn = Framework.ButtonAdapter.GetFrom(go, "painter/voteBtn")
	tab.voteNum = goutil.findChildTextComponent(go, "painter/voteNum")
	tab.head = goutil.findChild(go, "painter/head/con")
	tab.info = goutil.findChildTextComponent(go, "painter/info")

	return tab
end

function PopularityListView:_getPetCellTable(go)
	local tab = {
		go = go,
		name = goutil.findChildTextComponent(go, "pet/name")
	}

	tab.rect = go:GetComponent(goutil.Type_RectTransform)
	tab.con = goutil.findChild(go, "pet/con")
	tab.conBtn = Framework.ButtonAdapter.Get(tab.con)
	tab.rank = goutil.findChild(go, "pet/rank")
	tab.rankNum = goutil.findChildTextComponent(go, "pet/rank/num/txt")
	tab.rankGroup = goutil.findChildComponent(go, "pet/rank/num", ComponentType.UIChangeGroup)
	tab.voteChange = goutil.findChildComponent(go, "pet/voteBtn", ComponentType.UIImageSpriteChange)
	tab.voteBtn = Framework.ButtonAdapter.GetFrom(go, "pet/voteBtn")
	tab.voteNum = goutil.findChildTextComponent(go, "pet/voteNum")

	return tab
end

function PopularityListView:_updateView(selectType)
	if selectType == self._selectType then
		return
	end

	self._selectType = selectType

	if selectType == GameEnum.PopularityList.Painter then
		uGuiUtil.setSpriteToImage(self._imgTitle, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgFolderUrl("popularitylist", "board_pfhs_03"))
	else
		uGuiUtil.setSpriteToImage(self._imgTitle, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgFolderUrl("popularitylist", "board_pfhs_04"))
	end

	self._times.text = PopularityListController.instance:getText("TEXT_2", PopularityListModel.instance:getTimes(self._selectType))
	self._data = PopularityListModel.instance:getItemData(self._activityInfo.activityId, selectType)
	self._maxAngle = #self._data * self._spaceAngle - 2 * self._spaceAngle

	local exitInfo = PopularityListModel.instance:getExitInfo()

	for i = 1, #self._cellList do
		if exitInfo then
			if not (exitInfo.firstIndex + i - 1) then
				local cell, dataIndex = nil, i
				local angle = self._initRad - dataIndex * self._spaceAngle + 90

				if selectType == GameEnum.PopularityList.Painter then
					cell = self:_getPainerCellTable(self._cellList[i].go)
					cell.index = dataIndex

					goutil.setActive(goutil.findChild(cell.go, "painter"), true)
					goutil.setActive(goutil.findChild(cell.go, "pet"), false)
				else
					cell = self:_getPetCellTable(self._cellList[i].go)
					cell.index = dataIndex

					goutil.setActive(goutil.findChild(cell.go, "painter"), false)
					goutil.setActive(goutil.findChild(cell.go, "pet"), true)
				end

				goutil.setActive(cell.go, self._data[dataIndex])

				if self._data[dataIndex] then
					self:_updateCell(cell, self._data[dataIndex])
				end

				cell.angle = angle

				Framework.TransformUtil.SetAnchoredPos(cell.rect, self._radius * math.cos(math.rad(angle)), self._radius * math.sin(math.rad(angle)))
				Framework.TransformUtil.SetLocalRotation(cell.go.transform, 0, 0, angle - 90)

				self._cellList[i] = cell
			end
		end
	end

	if exitInfo then
		self._curAngle = exitInfo.curAngle or self._initRad
	end

	Framework.TransformUtil.SetLocalRotation(self._anchor.transform, 0, 0, (exitInfo or nil) and (exitInfo.curAngle or self._initRad))
	PopularityListModel.instance:saveExitInfo()
end

function PopularityListView:_updateCell(cell, data)
	cell.name.text = data.name
	cell.voteNum.text = data.count

	uGuiUtil.setSpriteToImage(cell.con, uGuiUtil.SpriteType.BigBg, GameUrl.getLotteryPetImgUrl(data.faceId))
	goutil.setActive(cell.rank, cell.index <= 3)
	cell.voteChange:SetState(PopularityListModel.instance:isVote(data.id) and 1 or 0)

	if cell.index <= 3 then
		cell.rankGroup:SetState(cell.index - 1)

		cell.rankNum.text = cell.index
	end

	if self._selectType == GameEnum.PopularityList.Painter then
		self:_updatePainterCell(cell, data)
	else
		self:_updatePetCell(cell, data)
	end
end

function PopularityListView:_updatePainterCell(cell, data)
	cell.info.text = data.painterStyle

	uGuiUtil.setSpriteToImage(cell.head, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(data.painterIcon))
	cell.conBtn:AddClickListener(function()
		PopularityListModel.instance:setSelectType(self._selectType)
		PopularityListModel.instance:saveExitInfo({
			curAngle = self._curAngle,
			firstIndex = self._cellList[1].index
		})
		UIStateManager.instance:push(ViewName.PopularityPainterView, data.faceId)
	end)
	cell.voteBtn:AddClickListener(function()
		if not PopularityListModel.instance:isVote(data.id) then
			if PopularityListModel.instance:getTimes(self._selectType) > 0 then
				TipsFacade.instance:openPopupWindow(lang("tip"), PopularityListController.instance:getText("TEXT_4", data.painterName, data.name, 1), function()
					PopularityListController.instance:sendPM_SkinVoteReq(self._activityInfo.activityId, data.id, self._selectType)
				end)
			else
				FloatWordMgr.instance:show(PopularityListController.instance:getText("TEXT_6"))
			end
		else
			FloatWordMgr.instance:show(PopularityListController.instance:getText("TEXT_7"))
		end
	end)
end

function PopularityListView:_updatePetCell(cell, data)
	cell.conBtn:AddClickListener(function()
		PopularityListModel.instance:setSelectType(self._selectType)
		PopularityListModel.instance:saveExitInfo({
			curAngle = self._curAngle,
			firstIndex = self._cellList[1].index
		})
		UIStateManager.instance:push(ViewName.PopularityPetView, data.faceId)
	end)
	cell.voteBtn:AddClickListener(function()
		if not PopularityListModel.instance:isVote(data.id) then
			if PopularityListModel.instance:getTimes(self._selectType) > 0 then
				TipsFacade.instance:openPopupWindow(lang("tip"), PopularityListController.instance:getText("TEXT_3", data.name, 1), function()
					PopularityListController.instance:sendPM_SkinVoteReq(self._activityInfo.activityId, data.id, self._selectType)
				end)
			else
				FloatWordMgr.instance:show(PopularityListController.instance:getText("TEXT_6"))
			end
		else
			FloatWordMgr.instance:show(PopularityListController.instance:getText("TEXT_7"))
		end
	end)
end

function PopularityListView:_clearCell()
	for i = self._anchor.transform.childCount - 1, 0, -1 do
		goutil.destroy(self._anchor.transform:GetChild(i).gameObject)
	end
end

function PopularityListView:_OnBeginDrag(_go, eventData)
	self:_rotate(_go, eventData)
	FixedUpdateBeat:Remove(self._roteAnim, self)
end

function PopularityListView:_OnEndDrag(_go, eventData)
	self:_rotate(_go, eventData)

	self._animAngle = eventData.delta.x

	FixedUpdateBeat:Add(self._roteAnim, self)
end

function PopularityListView:_OnDrag(_go, eventData)
	self:_rotate(_go, eventData)
end

function PopularityListView:_rotate(_go, eventData)
	local rotAngle = self:_toAngel(eventData.delta.x)

	self._curAngle = Mathf.Clamp(self._curAngle + rotAngle, self._initRad, self._maxAngle)

	Framework.TransformUtil.SetLocalRotation(_go.transform, 0, 0, self._curAngle)

	local firstCell = self._cellList[1]
	local lastCell = self._cellList[#self._cellList]

	if rotAngle > 0 and self._curAngle + firstCell.angle > 135 then
		if self._data[lastCell.index + 1] then
			local cellData = table.remove(self._cellList, 1)

			cellData.index = lastCell.index + 1

			self:_updateCell(cellData, self._data[cellData.index])

			cellData.angle = lastCell.angle - self._spaceAngle

			Framework.TransformUtil.SetAnchoredPos(cellData.rect, self._radius * math.cos(math.rad(cellData.angle)), self._radius * math.sin(math.rad(cellData.angle)))
			Framework.TransformUtil.SetLocalRotation(cellData.go.transform, 0, 0, cellData.angle - 90)
			table.insert(self._cellList, cellData)
		end
	elseif rotAngle < 0 and self._curAngle + lastCell.angle < 45 and self._data[firstCell.index - 1] then
		local cellData = table.remove(self._cellList)

		cellData.index = firstCell.index - 1

		self:_updateCell(cellData, self._data[cellData.index])

		cellData.angle = firstCell.angle + self._spaceAngle

		Framework.TransformUtil.SetAnchoredPos(cellData.rect, self._radius * math.cos(math.rad(cellData.angle)), self._radius * math.sin(math.rad(cellData.angle)))
		Framework.TransformUtil.SetLocalRotation(cellData.go.transform, 0, 0, cellData.angle - 90)
		table.insert(self._cellList, 1, cellData)
	end
end

function PopularityListView:_toAngel(x)
	local _x = -x / 30

	if _x > 0 then
		return math.min(_x, 5)
	else
		return math.max(_x, -5)
	end
end

function PopularityListView:_timer()
	self._timeText.text = self._activityInfo.endTime - ServerTime.now() > 0 and PopularityListController.instance:getText("TEXT_1", GameUtil.FormatTimeSymbol(self._activityInfo.endTime - ServerTime.now())) or lang("text_activity_end")
end

function PopularityListView:_roteAnim()
	self._animAngle = Mathf.Lerp(self._animAngle, 0, 0.1)

	if math.abs(self._animAngle) > 0.11 then
		self:_rotate(self._anchor, {
			delta = {
				x = self._animAngle
			}
		})
	end
end

return PopularityListView
