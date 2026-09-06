-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timewheel/view/TimeWheelWhiteListView.lua

module("logic.extensions.timewheel.view.TimeWheelWhiteListView", package.seeall)

local TimeWheelWhiteListView = class("TimeWheelWhiteListView", TableViewComponent)

function TimeWheelWhiteListView:ctor()
	TimeWheelWhiteListView.super.ctor(self)

	self.petColumnCount = 5
end

function TimeWheelWhiteListView:_getPath()
	return {
		cellPath2 = "viewBgIma/callItemSR/Viewport/Content/petRate",
		viewPath = "viewBgIma/callItemSR"
	}
end

function TimeWheelWhiteListView:buildUI()
	local path = self:_getPath()

	print("path.viewPath:" .. path.viewPath)

	self._tableview = self:getGo(path.viewPath):GetComponent(ComponentType.UITableview)

	self:registCallbacks()

	self.viewCloseGo = self:getGo("Button")
	self.viewDesTxt = goutil.findChildComponent(self.mainGO, "viewBgIma/left/titleDesTxt", "Text")
	self.petLockGo = self:getGo("viewBgIma/petLockGo")

	self.petLockGo:SetActive(false)

	local path = self:_getPath()

	if path and path.cellPath2 then
		self._tableCell2 = self:getGo(path.cellPath2)

		self._tableCell2:SetActive(false)
	end
end

function TimeWheelWhiteListView:bindEvents()
	TimeWheelWhiteListView.super.bindEvents(self)
	GameUtil.asBtn(self.viewCloseGo):AddClickListener(function()
		self:close()
	end, self)
end

function TimeWheelWhiteListView:unbindEvents()
	TimeWheelWhiteListView.super.unbindEvents(self)
	GameUtil.asBtn(self.viewCloseGo):RemoveClickListener()
end

function TimeWheelWhiteListView:onEnter()
	TimeWheelWhiteListView.super.onEnter(self)

	self.viewDesTxt.text = lang("timewheel_tip3")

	self:_updateList()
end

function TimeWheelWhiteListView:_getSubTitle(index)
	if index == 1 then
		return "时间消逝"
	elseif index == 2 then
		return "时间重置"
	elseif index == 3 then
		return "时间倒退"
	else
		return "时间溯源"
	end
end

function TimeWheelWhiteListView:_updateList()
	local list = {}

	for i = 1, 4 do
		local data = {}

		data.petList = {}
		data.titleDesc = self:_getSubTitle(i)
		data.petList = TimeWheelConfig.instance:getPetListByType(i + 1)

		table.insert(list, data)
	end

	self:updateListData(list)
end

function TimeWheelWhiteListView:_cellSize(sv, index)
	local petListNum = #self._curViewDatas[index + 1].petList
	local row = math.ceil(petListNum / self.petColumnCount)

	return 640, 42 + row * 116.5 + 15
end

function TimeWheelWhiteListView:_updateCell(view, cell, data)
	self:_updatePetRateInfo(cell, data)
end

function TimeWheelWhiteListView:_updatePetRateInfo(cell, data)
	local rateTxt = goutil.findChildTextComponent(cell, "rateTitle/rateTxt")

	rateTxt.text = "以下精灵无法进行" .. data.titleDesc

	local petListRoot = goutil.findChild(cell, "petList")
	local petItem = goutil.findChild(cell, "item")

	petItem:SetActive(false)

	local childCount = petListRoot.transform.childCount
	local petNum = #data.petList

	for i = 1, childCount do
		local go = petListRoot.transform:GetChild(i - 1).gameObject

		MaterialMgr.resetAll(go)
		go:SetActive(false)
	end

	local width = 110
	local scale = 0.85
	local realWidth = width * scale
	local gap = 15
	local gapY = 23
	local col = childCount + 1
	local row = 1

	while col > self.petColumnCount do
		col = col - self.petColumnCount
		row = row + 1
	end

	while childCount < petNum do
		local go = goutil.clone(petItem, "pet" .. childCount + 1)

		go.transform:SetParent(petListRoot.transform)
		Framework.TransformUtil.SetLocalPos(go.transform, (col - 1) * (realWidth + gap), -(row - 1) * (realWidth + gapY), 0)
		Framework.TransformUtil.SetLocalScale(go.transform, scale, scale, scale)

		childCount = childCount + 1
		col = col + 1

		if col > self.petColumnCount then
			col = 1
			row = row + 1
		end
	end

	for i = 1, petNum do
		local go = petListRoot.transform:GetChild(i - 1).gameObject

		go:SetActive(true)
		MaterialMgr.resetAll(go)

		local proxy = MaterialMgr.setCell(MatType.Pet, data.petList[i].raceId, go)

		proxy.binder:setShowName(true)
	end
end

function TimeWheelWhiteListView:_cellAtIndex(view, idx)
	local cell = view:DequeueCellByTag(1)

	cell = cell or view:AddChild(self._tableCell2, 1)

	local data = self._curViewDatas[idx + 1]

	cell.data = idx + 1
	cell.index = idx

	self:_updateCell(view, cell, data)

	return cell
end

return TimeWheelWhiteListView
