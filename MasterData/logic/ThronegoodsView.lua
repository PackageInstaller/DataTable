-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/throne/view/ThronegoodsView.lua

module("logic.extensions.throne.view.ThronegoodsView", package.seeall)

local ThronegoodsView = class("ThronegoodsView", ViewComponent)
local pageCount = 15

function ThronegoodsView:ctor()
	ThronegoodsView.super.ctor(self)
end

function ThronegoodsView:buildUI()
	ThronegoodsView.super.buildUI(self)

	self._tableDrag = self:getGo("itemCon"):GetComponent(typeof(UITableDragViewForLua))
	self._tableDrag.canMove = false
	self._cellList = {}
	self._cell = self:getGo("cell")
	self._itemCon = self:getGo("itemCon")
	self._itemGroup = ItemGroup.New(self._itemCon, self._cell, nil, nil, true)
	self._leftBtn = self:getBtn("leftBtn")
	self._rightBtn = self:getBtn("rightBtn")
	self._pageCon = self:getGo("page")
	self._pageCell = self:getGo("page/pagecell")
	self._pageGroup = ItemGroup.New(self._pageCon, self._pageCell, nil, nil, true)
	self._linesGo = self:getGo("lines")
	self._emptyTipGo = self:getGo("emptyTip")
end

function ThronegoodsView:bindEvents()
	ThronegoodsView.super.bindEvents(self)
	self._tableDrag:AddListener(self._updatePage, self)
	self._leftBtn:AddClickListener(self._onClickleftBtn, self)
	self._rightBtn:AddClickListener(self._onClickrightBtn, self)
end

function ThronegoodsView:unbindEvents()
	ThronegoodsView.super.unbindEvents(self)
	self._tableDrag:RemoveListener()
	self._leftBtn:RemoveClickListener()
	self._rightBtn:RemoveClickListener()
end

function ThronegoodsView:destroyUI()
	ThronegoodsView.super.destroyUI(self)
	self._itemGroup:dispose(function(item)
		local icon = goutil.findChild(item.mainGO, "icon")

		MaterialMgr.clearIcon(icon)
	end)
end

function ThronegoodsView:onEnter()
	ThronegoodsView.super.onEnter(self)
	GlobalDispatcher:addListener(ThroneController.UpdateRedDot, self._updateView, self)

	self._currSelectId = false
	self._selectTab = self:getFirstParam()

	local list = ThroneModel.instance:getThroneByShowType(self._selectTab)
	local rareList = {}

	for i, v in ipairs(list) do
		local cfg = ThroneConfig.instance:getThroneCfg(v.throneId)

		rareList[v.throneId] = cfg.quality
	end

	table.sort(list, function(a, b)
		if rareList[a.throneId] == rareList[b.throneId] then
			return a.lv > b.lv
		else
			return rareList[a.throneId] > rareList[b.throneId]
		end
	end)

	self._dataList = {}

	local count = 0
	local index = 1

	for i, v in ipairs(list) do
		count = count + 1
		self._dataList[index] = self._dataList[index] or {}

		table.insert(self._dataList[index], v)

		if count >= pageCount then
			count = 0
			index = index + 1
		end
	end

	self._tableDrag:SetMaxIndex(#self._dataList)
	self._tableDrag:SetCurIndex(0)
end

function ThronegoodsView:onEnterFinished()
	ThronegoodsView.super.onEnterFinished(self)
end

function ThronegoodsView:onExit()
	ThronegoodsView.super.onExit(self)
	GlobalDispatcher:removeListener(ThroneController.UpdateRedDot, self._updateView, self)
end

function ThronegoodsView:onExitFinished()
	ThronegoodsView.super.onExitFinished(self)
end

function ThronegoodsView:_setStar(startList, starNum, lv)
	for i, v in ipairs(startList) do
		if starNum < i then
			break
		end

		goutil.setActive(v.mainGO, true)
		goutil.setActive(v.lightGO, i <= lv)
	end
end

function ThronegoodsView:_updatePage(pageIndex)
	self._pageIndex = pageIndex

	self:_updatePageItemState()
	self:_updateView()
end

function ThronegoodsView:_updateView()
	local list = {}

	if self._pageIndex then
		list = self._dataList[self._pageIndex]
	end

	self._itemGroup:updateWithMoArray(list, function(item, data, idx)
		self:_updateCell(item, data, idx)
	end)
	goutil.setActive(self._leftBtn.gameObject, self._pageIndex and self._pageIndex > 1)
	goutil.setActive(self._rightBtn.gameObject, self._pageIndex and self._dataList and self._pageIndex < #self._dataList)
	goutil.setActive(self._linesGo, list and #list > 0)
	goutil.setActive(self._emptyTipGo, not list or #list <= 0)
end

function ThronegoodsView:_updateCell(cell, data, idx)
	local stageBg = goutil.findChild(cell.mainGO, "stageBg")
	local bgChange = goutil.findChild(cell.mainGO, "starBg"):GetComponent(ComponentType.UIImageSpriteChange)
	local redDot = goutil.findChild(cell.mainGO, "dot")
	local iconBtn = goutil.findChild(cell.mainGO, "icon")

	goutil.setActive(redDot, ThroneModel.instance:checkThroneGoodsItemRedDot(data.throneId, data))

	local startList = {}
	local starRoot = goutil.findChild(cell.mainGO, "starBg/con")
	local stageText = goutil.findChildTextComponent(cell.mainGO, "stageText")

	for i = 1, 5 do
		startList[i] = {
			mainGO = goutil.findChild(starRoot, "start" .. i),
			lightGO = goutil.findChild(starRoot, "start" .. i .. "/start")
		}

		goutil.setActive(startList[i].lightGO, false)
		goutil.setActive(startList[i].mainGO, false)
	end

	local itemCon = goutil.findChild(cell.mainGO, "itemCon")
	local cfg = ThroneConfig.instance:getThroneCfg(data.throneId)
	local lvStrategyCfg = ThroneConfig.instance:getLvStrategyCfg(cfg.levelStrategy)
	local starNum = 0

	for i, v in ipairs(lvStrategyCfg) do
		if not string.nilorempty(v.subProps) then
			break
		end

		starNum = i
	end

	self:_setStar(startList, starNum, data.lv)
	bgChange:SetState(cfg.quality - 2)
	goutil.setActive(stageBg, starNum < data.lv)

	stageText.text = starNum < data.lv and string.format("%s阶", data.lv - starNum) or ""
	cell.mainGO.name = "cell_" .. data.throneId

	local isFix = false

	if cell.mainGO and not cell.mainGO.transform.parent:Equals(self._itemCon.transform) then
		goutil.addChildToParent(cell.mainGO, self._itemCon.transform)

		isFix = true
	end

	local xx = (idx - 1) % 5 * 153
	local yy = math.floor((idx - 1) / 5) * -176

	GameUtil.setLocalPos(cell.mainGO, xx, yy, 0)

	if isFix then
		GlobalDispatcher:dispatch(ThroneController.ON_RESET_THE_CELL, cell.mainGO)
	end

	MaterialMgr.setIcon(iconBtn.gameObject, MatType.Throne, data.throneId)
	GameUtil.addClickHandler(cell.mainGO, function()
		self._currSelectId = data.throneId

		self:_updateView()
		ThroneModel.instance:setLookThrone(data.throneId)
		UIStateManager.instance:push(ViewName.ThronestrengthView, data.throneId)
	end)
end

function ThronegoodsView:_onClickleftBtn()
	if self._pageIndex then
		self._tableDrag:SetCurIndex(self._pageIndex - 2)
	end
end

function ThronegoodsView:_onClickrightBtn()
	if self._pageIndex then
		self._tableDrag:SetCurIndex(self._pageIndex)
	end
end

function ThronegoodsView:_updatePageItemState()
	self._pageGroup:updateWithMoArray(self._dataList, function(item, data)
		local change = item.mainGO:GetComponent(ComponentType.UIImageSpriteChange)

		change:SetState(item.index == self._pageIndex and 1 or 0)
	end)
end

return ThronegoodsView
