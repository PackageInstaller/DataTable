-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cutepet/view/CutePetSortView.lua

module("logic.extensions.cutepet.view.CutePetSortView", package.seeall)

local CutePetSortView = class("CutePetSortView", ViewComponent)

function CutePetSortView:ctor()
	CutePetSortView.super.ctor(self)
end

function CutePetSortView:destroyUI()
	CutePetSortView.super.destroyUI(self)
end

function CutePetSortView:onExitFinished()
	CutePetSortView.super.onExitFinished(self)
end

function CutePetSortView:onEnterFinished()
	CutePetSortView.super.onEnterFinished(self)
end

function CutePetSortView:unbindEvents()
	CutePetSortView.super.unbindEvents(self)
	self._customInput:RemoveListener()
end

function CutePetSortView:bindEvents()
	CutePetSortView.super.bindEvents(self)
	self._customInput:AddListener(self._onCustomInputCallback, self)
end

function CutePetSortView:onExit()
	CutePetSortView.super.onExit(self)
	removetimer(self.showMainGo, self)
	GlobalDispatcher:dispatch(GlobalNotify.CutePetFilterClose)
end

function CutePetSortView:buildUI()
	CutePetSortView.super.buildUI(self)

	self._content = goutil.findChild(self.mainGO, "content")
	self._adjustPosition = self._content:GetComponent("UIAdjustPosition")
	self._customInput = UICustomInput.Get(self._content)
	self._tableView = self:getGo("content/tableview")
	self._tableCell = self:getGo("content/cell")
end

function CutePetSortView:_onCustomInputCallback(hover)
	if not hover then
		self:close()
	end
end

function CutePetSortView:onEnter()
	CutePetSortView.super.onEnter(self)

	self._tableList = ScrollerList.create(self._tableView, self._tableCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	local params = self._viewPresentor._openParam

	if params then
		self:_adjustView()

		self.parentPresentor = params[3]
		self._curSelect = checknumber(params[4])
		self._isReverse = params[5]

		self:checkPresentor()
	end

	self._showList = {
		{
			condition = CutePetModel.SortType.Time,
			name = lang("最新")
		},
		{
			condition = CutePetModel.SortType.Level,
			name = lang("等级")
		},
		{
			condition = CutePetModel.SortType.Star,
			name = lang("星级")
		},
		{
			condition = CutePetModel.SortType.Quality,
			name = lang("品质")
		},
		{
			condition = CutePetModel.SortType.Score,
			name = lang("评分")
		},
		{
			condition = CutePetModel.SortType.Discard,
			name = lang("弃置")
		}
	}

	self:_refreshView()
end

function CutePetSortView:_refreshView()
	self._tableList:reloadData(self._showList)
end

function CutePetSortView:checkPresentor(callback)
	if not self.parentPresentor or not self.parentPresentor:isOpen() then
		self:close()

		return
	end

	GameUtil.callBack(callback)
end

function CutePetSortView:_adjustView()
	local pos = self._viewPresentor._openParam[1]

	self.pos = pos
	self.sizeDelta = self._viewPresentor._openParam[2]

	if pos then
		GameUtil.SetActive(self.mainGO, false)
		settimer(0.1, self.showMainGo, self, false)
	else
		Framework.TransformUtil.SetLocalPos(self._content.transform, 0, 0, 0)
	end
end

function CutePetSortView:showMainGo()
	GameUtil.SetActive(self.mainGO, true)
	Framework.TransformUtil.SetLocalScale(self.mainGO.transform, 1, 1, 1)
	self._adjustPosition:AdjustScreenPosition(self.pos, self.sizeDelta[1], self.sizeDelta[2])
	self:checkPresentor()
end

function CutePetSortView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local txtName = goutil.findChildTextComponent(go, "txt")
	local imgSort = goutil.findChild(go, "ImgSort")
	local changeGroup = go:GetComponent(ComponentType.UIChangeGroup)

	txtName.text = data.name

	if self._curSelect == data.condition then
		if self._isReverse == true then
			changeGroup:SetState(2)
		else
			changeGroup:SetState(1)
		end
	else
		changeGroup:SetState(0)
	end

	GameUtil.addClickHandler(go, function()
		if self._curSelect ~= data.condition then
			self._isReverse = false
			self._curSelect = data.condition
		elseif not self._isReverse then
			self._isReverse = true
		else
			self._isReverse = false
			self._curSelect = 0
		end

		self:_dispatchSortEvent(self._curSelect, self._isReverse)
		self:_refreshView()
	end)
end

function CutePetSortView:_dispatchSortEvent(condition, isReverse)
	GlobalDispatcher:dispatch(GlobalNotify.CutePetBagSortSelect, condition, isReverse)
end

function CutePetSortView:_clearCell(cell)
	local go = cell.gameObject
	local btnClick = goutil.findChild(go, "raycast")

	GameUtil.rmClickHandler(go)
end

return CutePetSortView
