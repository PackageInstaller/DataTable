-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/view/PreferentialView.lua

module("logic.extensions.bonus.view.PreferentialView", package.seeall)

local PreferentialView = class("PreferentialView", ViewComponent)

PreferentialView.MainCellSizeY = 75
PreferentialView.SubCellSizeY = 65
PreferentialView.ReduceSize = 15

function PreferentialView:buildUI()
	PreferentialView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._bg = self:getGo("bg")
	self.container = self:getGo("container")
	self._goCell = self:getGo("tablecell")
	self._goTableview = self:getGo("tableview")
	self._tableview = ScrollerList.create(self._goTableview, self._goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self._tableview:regValueChanged(GameUtil.handler(self._onValueChanged, self))
	self._tableview:regReloadFinish(function()
		self:_onReloadFinish()
	end)
	self._tableview:regGetCellSize(function(view, index)
		return self:_cellSize(view, index)
	end)

	self._lastOpenTagKey = "PreferentialView_LastOpenTag"
	self._tip = self:getGo("tip")
	self._tipRect = self:getGo("tip"):GetComponent(goutil.Type_RectTransform)
	self._dropLineGo = goutil.findChild(self.mainGO, "tableview/Nego_Viewport/Nego_Content/dropLine")
	self._tabContent = goutil.findChild(self.mainGO, "tableview/Nego_Viewport/Nego_Content").transform
	self._dropLineV2 = Vector2.New(141, 0)

	goutil.setActive(self._dropLineGo, false)

	self._dropLineList = {}
end

function PreferentialView:bindEvents()
	PreferentialView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
end

function PreferentialView:unbindEvents()
	PreferentialView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function PreferentialView:onEnter()
	PreferentialView.super.onEnter(self)

	self._preferentialCfgs = BonusConfig.instance:getPreferentialCfgs()
	self._isFirstEnter = true

	local leafId = 0
	local firstParam = self:getFirstParam()
	local selectId = 0

	if string.nilorempty(firstParam) then
		firstParam = BounsModel.instance:getLastPreferentialviewTag()
	end

	local dataList = self:_getCurDataList()

	for i, v in ipairs(dataList) do
		if firstParam == v.uniqueTag then
			selectId = v.id
			leafId = v.leafId

			break
		end
	end

	if selectId <= 0 then
		selectId = BounsModel.instance:getLastOpenTagId()
	end

	self:_onClickTab(selectId, leafId)

	self._viewPresentor._openParam = nil
	self._isUnfold = true
	self._startY = 32
	self._moveY = 5
	self._animInterval = 1
	self._animTime = 0.3
	self._moveSequence = nil
	self._moveSequence = DG.Tweening.DOTween.Sequence()

	self:_setTipAnim()
end

function PreferentialView:onExit()
	PreferentialView.super.onExit(self)
	self._tableview:dispose()

	if self._curSelectData then
		BounsModel.instance:setLastOpenTagId(self._curSelectData.id)
	end

	self._curSelectData = nil

	self._moveSequence:Kill(true)

	self._moveSequence = nil
end

function PreferentialView:_setTipAnim()
	for i = 1, 2 do
		local moveUpTween = self._tipRect:DOAnchorPosY(self._startY + self._moveY, self._animTime):SetEase(DG.Tweening.Ease.Linear)
		local moveDownTween = self._tipRect:DOAnchorPosY(self._startY - self._moveY, self._animTime):SetEase(DG.Tweening.Ease.Linear)

		self._moveSequence:Append(moveUpTween)
		self._moveSequence:Append(moveDownTween)
	end

	local moveBackTween = self._tipRect:DOAnchorPosY(self._startY, self._animTime):SetEase(DG.Tweening.Ease.Linear)

	self._moveSequence:Append(moveBackTween)
	self._moveSequence:AppendInterval(self._animInterval)
	self._moveSequence:SetLoops(-1)
end

function PreferentialView:_updateCell(view, goCell, data)
	local cell = self:_clearCell(goCell)
	local isSelectedRoot = false
	local isSelected = false

	if data.leafId == 0 then
		isSelectedRoot = data.id == self._selectRootId
	else
		isSelected = data.id == self._selectRootId and data.leafId == self._selectLeafId
	end

	local state = isSelected and 1 or 0

	cell.imgChange:SetState(isSelectedRoot and 1 or 0)
	cell.subImgChange:SetState(state)
	goutil.setActive(cell.imgChange.gameObject, data.leafId == 0)
	goutil.setActive(cell.subImgChange.gameObject, data.leafId ~= 0)

	if data.leafId ~= 0 then
		cell.txtChange:SetState(isSelected and 3 or 2)
	else
		cell.txtChange:SetState(isSelectedRoot and 1 or 0)
	end

	cell.txt.text = string.format("<size=%s>%s</size>", data.leafId == 0 and 26 or 22, data.name)

	if not string.nilorempty(data.showTag) then
		cell.txtTag.text = data.showTag

		goutil.setActive(cell.goTag, true)
	end

	RedPointController.instance:regRedPoint(cell.redpoint, unpack(string.split(data.redpointId or "", "#")))
	GameUtil.addClickHandler(cell.btn, GameUtil.handler(self._onClickTab, self, data.id, data.leafId))
	GameUtil.addClickHandler(cell.btnSub, GameUtil.handler(self._onClickTab, self, data.id, data.leafId))

	if isSelectedRoot and data.leafId == 0 then
		self._cellIdx = goCell.index
	end
end

function PreferentialView:_clearCell(goCell)
	local cell = {}

	cell.go = goCell
	cell.imgChange = goutil.findChildComponent(cell.go, "imgBg", "UIImageSpriteChange")
	cell.subImgChange = goutil.findChildComponent(cell.go, "imgSmallBg", "UIImageSpriteChange")
	cell.txtChange = goutil.findChildComponent(cell.go, "text", "UITextColorChange")
	cell.goTag = goutil.findChild(cell.go, "tag")
	cell.txtTag = goutil.findChildTextComponent(cell.goTag, "Text")
	cell.btn = goutil.findChild(cell.go, "imgBg")
	cell.btnSub = goutil.findChild(cell.go, "imgSmallBg")
	cell.redpoint = goutil.findChild(cell.go, "dot")
	cell.txt = goutil.findChildTextComponent(cell.go, "text")

	GameUtil.rmClickHandler(cell.btn)
	GameUtil.rmClickHandler(cell.btnSub)
	goutil.setActive(cell.redpoint, false)
	goutil.setActive(cell.goTag, false)
	RedPointController.instance:unregRedPoint(cell.redpoint)

	return cell
end

function PreferentialView:_onClickTab(rootId, leafId)
	local selectRootId = rootId
	local selectLeafId = leafId or 0
	local isClickRoot = selectLeafId == 0

	if isClickRoot then
		if self._curSelectData and self._curSelectData.id == selectRootId then
			self._isUnfold = not self._isUnfold
			selectLeafId = self._curSelectData.leafId
		else
			self._isUnfold = true
		end
	end

	if self._preferentialCfgs[selectRootId] then
		local showData = self._preferentialCfgs[selectRootId][selectLeafId]
		local dataList = self:_getCurDataList(selectRootId)

		showData = showData or dataList[1]

		local curShowData
		local showRootId = showData.id

		if self._preferentialCfgs[showRootId][1] then
			local isShowLeafData = showData.leafId == 0

			if isShowLeafData then
				for i, v in ipairs(dataList) do
					if v.id == showRootId and v.leafId ~= 0 then
						curShowData = v

						break
					end
				end
			else
				curShowData = showData
			end

			if self._curSelectData ~= curShowData then
				self._curSelectData = curShowData
				self._selectRootId = curShowData.id
				self._selectLeafId = curShowData.leafId

				self:showTabAt(self.container)
				goutil.setActive(self._bg, not self._curSelectData.hideBg)
				self:showTabAt(self.container, self._curSelectData.viewname, self._curSelectData.parameter)
				SurveyController.instance:reportBehavior(checknumber(self._curSelectData.reportBehavior))
			end

			self._curViewDatas = dataList

			self._tableview:reloadData(dataList)

			if curShowData then
				BounsModel:setLastPreferentialviewTag(curShowData.uniqueTag)
			end
		end
	end
end

function PreferentialView:_getCurDataList(selectRootId)
	local sortDataList = {}

	for k, v in pairs(self._preferentialCfgs) do
		if type(k) == "number" then
			local v0 = v[0]
			local cnt = table.nums(v)

			if cnt > 1 then
				for _, child in pairs(v) do
					if not string.nilorempty(child.viewname) and (child.funcId == 0 or FuncOpenModel.instance:getFuncIsOpen(child.funcId)) then
						table.insert(sortDataList, v)

						if not selectRootId or not self._preferentialCfgs[selectRootId] then
							selectRootId = k
						end

						break
					end
				end
			elseif not string.nilorempty(v0.viewname) and (v0.funcId == 0 or FuncOpenModel.instance:getFuncIsOpen(v0.funcId)) then
				table.insert(sortDataList, v)

				if not selectRootId or not self._preferentialCfgs[selectRootId] then
					selectRootId = k
				end
			end
		end
	end

	table.sort(sortDataList, function(a, b)
		return a[0].sort < b[0].sort
	end)

	local dataList = {}

	for k, v in ipairs(sortDataList) do
		table.insert(dataList, v[0])

		if v[0].noFold or v[0].id == selectRootId and self._isUnfold then
			for k1, v1 in ipairs(v) do
				if not string.nilorempty(v1.viewname) and (v1.funcId == 0 or FuncOpenModel.instance:getFuncIsOpen(v1.funcId)) then
					table.insert(dataList, v1)
				end
			end
		end
	end

	return dataList
end

function PreferentialView:_onClickClose()
	self._curSelectData = nil

	BounsModel.instance:setLastOpenTagId(0)
	self:close()
end

function PreferentialView:_onValueChanged()
	GameUtil.SetActive(self._tip, not self._tableview:isShowFinishCell())
end

function PreferentialView:_onReloadFinish()
	for i, v in ipairs(self._dropLineList) do
		v.isActive = false

		goutil.setActive(v.go, false)
	end

	local cellY = -38.4

	for i, v in ipairs(self._curViewDatas) do
		if i > 1 then
			local x, y = self:_cellSize(nil, i - 2)

			cellY = cellY - y
		end

		if self._curViewDatas[i].leafId == 0 and (self._curViewDatas[i].noFold or self._selectRootId == self._curViewDatas[i].id) then
			local count = 0

			for j = i + 1, #self._curViewDatas do
				if self._curViewDatas[j].id == self._curViewDatas[i].id then
					count = count + 1
				else
					break
				end
			end

			if count > 0 then
				local cbg = self:_getFreeContentBg()

				self._dropLineV2.y = PreferentialView.MainCellSizeY + count * PreferentialView.SubCellSizeY - PreferentialView.ReduceSize
				cbg.transform.sizeDelta = self._dropLineV2

				GameUtil.setAnchoredPos(cbg, 8.13, cellY + 22)
			end
		end
	end

	if self._isFirstEnter then
		self._isFirstEnter = false

		for i, v in ipairs(self._curViewDatas) do
			if v.id == self._selectRootId and v.leafId == 0 then
				self._tableview:MoveCellToBegin(i - 1)

				break
			end
		end
	end
end

function PreferentialView:_getFreeContentBg()
	local data

	for i, v in ipairs(self._dropLineList) do
		if not v.isActive then
			data = v

			break
		end
	end

	if not data then
		data = {
			isActive = true,
			go = goutil.cloneAndSetParent(self._dropLineGo, self._tabContent)
		}

		data.go.transform:SetAsFirstSibling()
		table.insert(self._dropLineList, data)
	end

	data.isActive = true

	goutil.setActive(data.go, true)

	return data.go
end

function PreferentialView:_cellSize(view, index)
	local data = self._curViewDatas[index + 1]

	if data.leafId == 0 then
		return 100, PreferentialView.MainCellSizeY
	end

	return 100, PreferentialView.SubCellSizeY
end

return PreferentialView
