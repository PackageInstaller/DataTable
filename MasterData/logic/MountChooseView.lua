-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mount/view/MountChooseView.lua

module("logic.extensions.mount.view.MountChooseView", package.seeall)

local MountChooseView = class("MountChooseView", ViewComponent)
local MAX_POTENTIAL_STATE = 3
local MAX_LIGHT_NUM = 5
local sortName = {
	[1] = "战力",
	[2] = "助战"
}
local sortIndex = {
	power = 1,
	goFight = 2
}

function MountChooseView:ctor()
	MountChooseView.super.ctor(self)
end

function MountChooseView:unbindEvents()
	MountChooseView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnSure:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnCloseTip:RemoveClickListener()
	self._btnSort:RemoveClickListener()
	self._btnCloseSortTab:RemoveClickListener()

	for i, v in ipairs(self._sortTable) do
		GameUtil.asBtn(v.go):RemoveClickListener()
	end
end

function MountChooseView:bindEvents()
	MountChooseView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._closeView, self)
	self._btnSure:AddClickListener(self._onClickBtnSure, self)
	self._btnCloseTip:AddClickListener(self._onClickBtnCloseTip, self)
	self._btnTip:AddClickListener(self._onClickBtnOpenTip, self)
	self._btnSort:AddClickListener(self._onClickOpenSortTab, self)
	self._btnCloseSortTab:AddClickListener(self._onClickCloseSortTab, self)

	for i, v in ipairs(self._sortTable) do
		GameUtil.asBtn(v.go):AddClickListener(function()
			self:_onClickSort(v.sortIdx)
		end)
	end
end

function MountChooseView:buildUI()
	MountChooseView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnSure = self:getBtn("btnSure")
	self._btnCloseTip = self:getBtn("tip")
	self._btnTip = self:getBtn("goFightValue/btnTip")
	self._btnSort = self:getBtn("btnSort")
	self._btnCloseSortTab = self:getBtn("sortGo")

	local scrollerGo = self:getGo("tableview")
	local cellGo = self:getGo("tabStar")

	self._tableview = ScrollerList.create(scrollerGo, cellGo, GameUtil.handler(self._updateCell, self))

	local tipScrollerGo = self:getGo("tip/tableview")
	local tipCellGo = self:getGo("tip/cell")

	self._tipTab = ScrollerList.create(tipScrollerGo, tipCellGo, GameUtil.handler(self._updateTipCell, self))
	self._txtName = self:getTxt("info/base/name/txtName")
	self._txtPotency = self:getTxt("info/base/potency/txtVal")
	self._txtPower = self:getTxt("info/base/power/txtVal")
	self._txtNum = self:getTxt("txtNum")
	self._txtGoFightValue = self:getTxt("tip/txtGoFightValue")
	self._txtTipNum = self:getTxt("tip/txtNum")
	self._txtSort = self:getTxt("btnSort/text")
	self._zdlNum = self:getGo("goFightValue/imgNum"):GetComponent(typeof(UIImgNumeralText))
	self._mount = self:getGo("mount")
	self._tipGo = self:getGo("tip")
	self._sortGo = self:getGo("sortGo")
	self._imgArrow = self:getGo("btnSort/imgArrow")
	self._sliders = {}

	for i = 1, 4 do
		local attr = {}

		attr.go = goutil.findChild(self.mainGO, "info/attribute/attr" .. i)
		attr._txtVal = goutil.findChildTextComponent(attr.go, "txtVal")
		attr._txtName = goutil.findChildTextComponent(attr.go, "txtName")
		attr._txtBarrage = goutil.findChildTextComponent(attr.go, "txtBarrage")
		attr._goBarrage = goutil.findChild(attr.go, "txtBarrage")
		attr._icon = GameUtil.getUIImageSpriteChange(goutil.findChild(attr.go, "icon"))

		table.insert(self._sliders, attr)
	end

	self._breachAttr = {}
	self._breachAttr.go = goutil.findChild(self.mainGO, "info/attribute/attr5")
	self._breachAttr._txtVal = goutil.findChildTextComponent(self._breachAttr.go, "txtVal")
	self._breachAttr._txtName = goutil.findChildTextComponent(self._breachAttr.go, "txtName")
	self._breachAttr._txtBarrage = goutil.findChildTextComponent(self._breachAttr.go, "txtBarrage")
	self._breachAttr._goBarrage = goutil.findChild(self._breachAttr.go, "txtBarrage")
	self._breachAttr._icon = GameUtil.getUIImageSpriteChange(goutil.findChild(self._breachAttr.go, "icon"))
	self._sortTable = {}

	for i, v in ipairs(sortName) do
		local list = {}

		list.go = self:getGo("sortGo/content/Cell" .. i)
		list.txtName = goutil.findChildTextComponent(list.go, "name")
		list.name = v
		list.sortIdx = i
		list.imgChange = goutil.findChildComponent(list.go, "ImgSort", "UIImageSpriteChange")
		list.txtName.text = v

		table.insert(self._sortTable, list)
	end
end

function MountChooseView:onEnter()
	MountChooseView.super.onEnter(self)

	self._selectMountIndex = -1
	self._activeMountIds = MountModel.instance:getActiveMountIds() or {}
	self._mountInfo = {}
	self._mountLimit = MountConfig.instance:getMountLimitNum()

	self:_refreshTabs()
	self:_setAllZdl()

	self._txtNum.text = string.format("(<color=#20b376>%s</color>/%s)", #self._activeMountIds, self._mountLimit)

	GlobalDispatcher:addListener(GlobalNotify.MountAttrActive, self._closeView, self)

	self._isSortReverse = nil
	self._curSortIdx = nil
end

function MountChooseView:onExit()
	MountChooseView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.MountAttrActive, self._closeView, self)
	uGuiUtil.clearImage(self._mount)
end

function MountChooseView:_updateCell(view, cell, data)
	local unlock = MountController.instance:getIfLock(data.id)
	local txtStarName = goutil.findChildTextComponent(cell, "txtStarName")
	local select = goutil.findChild(cell, "select")
	local fight = goutil.findChild(cell, "btnFight/fight")
	local btnFight = goutil.findChild(cell, "btnFight")
	local lock = goutil.findChild(cell, "lock")
	local tabImg = cell.gameObject:GetComponent("UIImageSpriteChange")
	local redPoint = goutil.findChild(cell, "imgRed")
	local tag = goutil.findChild(cell, "tag")
	local txtTag = goutil.findChildTextComponent(cell, "tag/txt")
	local imgQuality = goutil.findChild(cell, "quality"):GetComponent("UIImageSpriteChange")

	imgQuality:SetState(data.quality)
	tabImg:SetState(data.id - 1)

	txtStarName.text = data.name

	GameUtil.SetActive(tag, false)

	if not string.nilorempty(data.sqContent) then
		GameUtil.SetActive(tag, true)

		txtTag.text = data.sqContent
	end

	if self._selectMountIndex == -1 then
		self:onClickTab(data, cell.index)
	end

	local selectMount = self._selectMountIndex == cell.index

	GameUtil.SetActive(lock, not unlock)
	GameUtil.SetActive(select, selectMount)
	GameUtil.SetActive(fight, table.indexof(self._activeMountIds, data.id))
	GameUtil.rmClickHandler(cell)
	GameUtil.addClickHandler(cell, GameUtil.handler(self.onClickTab, self, data, cell.index))
	GameUtil.rmClickHandler(btnFight)
	GameUtil.addClickHandler(btnFight, GameUtil.handler(self.onClickFight, self, data, fight, cell.index, unlock))
end

function MountChooseView:onClickFight(data, fight, selectIndex, unlock)
	if not unlock then
		FloatWordMgr.instance:show("未激活坐骑无法助战")

		return
	end

	local index = table.indexof(self._activeMountIds, data.id)

	if not index and self._mountLimit <= #self._activeMountIds then
		FloatWordMgr.instance:show("已经到达上阵上限，无法上阵")

		return
	end

	if index then
		GameUtil.SetActive(fight, false)
		table.remove(self._activeMountIds, index)
	else
		GameUtil.SetActive(fight, true)
		table.insert(self._activeMountIds, data.id)
	end

	local zdl = MountModel.instance:getTempMountZdl(self._activeMountIds)

	self._zdlNum:SetNum(zdl)

	self._txtNum.text = string.format("(<color=#20b376>%s</color>/%s)", #self._activeMountIds, self._mountLimit)
end

function MountChooseView:onClickTab(data, selectIndex)
	local mountCfg = MountConfig.instance:getMountCo(data.id)

	uGuiUtil.setSpriteToImage(self._mount, uGuiUtil.SpriteType.BigBg, string.format("ui/bigbg/mount/%s.png", mountCfg.AssistCardName))

	self._selectMountIndex = selectIndex

	self:_refreshAttr(data)
	self._tableview:refresh()
end

function MountChooseView:_refreshAttr(data)
	local curAtt = MountModel.instance:getCurAtt(data.id)
	local lockMo = MountModel.instance:getLockmountsById(data.id)
	local level = lockMo and checknumber(lockMo.level) or 0
	local maxLevel = MountConfig.instance:getMaxLevel(data.id)
	local attr = MountModel.instance:getActiveAtt(data.id, level)
	local maxAttr = MountModel.instance:getActiveAtt(data.id, maxLevel)
	local maxArr = self:getAttrValue(attr, maxAttr)

	if lockMo then
		local attMaxList = MountModel.instance:getAttMax(data.id, level)

		for i, attr in ipairs(self._sliders) do
			print(i, v)

			local type = attMaxList[i].type
			local curVal = curAtt[i].value
			local maxVal = checknumber(attMaxList[i].value)

			attr._txtVal.text = tostring(curVal) .. "/" .. tostring(maxVal)
			attr._txtName.text = ConstString.Attr[type]

			attr._icon:SetState(checknumber(type) - 1)
		end
	else
		local attMaxList = MountModel.instance:getAttMax(data.id, 1)

		for i = 1, 4 do
			local type = attMaxList[i].type
			local maxVal = checknumber(attMaxList[i].value)

			self._sliders[i]._txtVal.text = "0/" .. maxVal
			self._sliders[i]._txtName.text = ConstString.Attr[type]

			self._sliders[i]._icon:SetState(checknumber(type) - 1)
		end
	end

	self._breachAttr._txtVal.text = maxArr.value .. "/" .. maxArr.maxValue
	self._breachAttr._txtName.text = maxArr.name

	if lockMo then
		self._txtName.text = data.name or data.name .. "(未激活)"
	end

	self._txtPotency.text = string.format("%s/%s级", level, maxLevel)
	self._txtPower.text = data.power
end

function MountChooseView:getPotentialState(index, level)
	local res = 0

	for i = MAX_POTENTIAL_STATE, 0, -1 do
		if level >= index + i * MAX_LIGHT_NUM then
			res = i + 1

			break
		end
	end

	return res
end

function MountChooseView:getAttrValue(attr, maxAttr)
	local list = {}
	local arr = string.split(attr or "", "+")
	local maxArr = string.split(maxAttr, "+")
	local id = table.indexof(GameEnum.AttrTypeName, arr[1])
	local value = attr and GameUtil.GetPropertyValue(id, checknumber(arr[2])) or 0
	local propertyVal = GameUtil.GetPropertyValue(id, value)

	list.name = maxArr[1]
	list.value = value
	list.maxValue = GameUtil.GetPropertyValue(id, checknumber(maxArr[2]))

	return list
end

function MountChooseView:_updateTipCell(view, cell, data)
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtPower = goutil.findChildTextComponent(cell, "txtPower")

	txtName.text = data.name
	txtPower.text = string.format("战力：<color=#69fb91>%s</color>", data.value)
end

function MountChooseView:_refreshTabs()
	if self._mountAllCfgs == nil then
		self._mountAllCfgs = MountController.instance:getAllMounts()
	end

	local curId = checknumber(MountModel.instance:getCurMountId())

	self._mountCfgs = {}

	for k, v in pairs(self._mountAllCfgs) do
		if not string.nilorempty(v.sqContent) then
			v.power = MountModel.instance:getMountZDLById(v.id)

			table.insert(self._mountCfgs, v)
		end
	end

	self:_onClickSort(sortIndex.goFight)
end

function MountChooseView:_onClickBtnSure()
	MountAgent.instance:sendMountSelectActiveMountReq(self._activeMountIds)
end

function MountChooseView:_closeView()
	self:close()
end

function MountChooseView:_onClickBtnCloseTip()
	goutil.setActive(self._tipGo, false)
end

function MountChooseView:_onClickBtnOpenTip()
	self:_setMountInfo()
	self:_refrenshMountTipInfo()
	goutil.setActive(self._tipGo, true)
end

function MountChooseView:_onClickOpenSortTab()
	goutil.setActive(self._sortGo, true)
end

function MountChooseView:_onClickCloseSortTab()
	goutil.setActive(self._sortGo, false)
end

function MountChooseView:_setAllZdl()
	local zdl = MountModel.instance:getMountZDL()

	self._zdlNum:SetNum(zdl)
end

function MountChooseView:_setMountInfo()
	if #self._mountInfo > 0 then
		return
	end

	for k, v in pairs(self._mountCfgs) do
		if MountModel.instance:getLockmountsById(v.id) then
			local list = {}

			list.id = v.id
			list.name = v.name
			list.value = MountModel.instance:getMountZDLById(v.id)

			table.insert(self._mountInfo, list)
		end
	end
end

function MountChooseView:_refrenshMountTipInfo()
	local list = {}

	for k, v in pairs(self._mountInfo) do
		if table.indexof(self._activeMountIds, v.id) then
			table.insert(list, v)
		end
	end

	self._tipTab:reloadData(list)

	local zdl = MountModel.instance:getTempMountZdl(self._activeMountIds)

	self._txtGoFightValue.text = string.format("助战总战力：<color=#69fb91>%s</color>", zdl)
	self._txtTipNum.text = string.format("<color=#69fb91>%s</color>/%s", #self._activeMountIds, self._mountLimit)
end

function MountChooseView:_onClickSort(idx)
	if self._curSortIdx == idx then
		if self._isSortReverse == true then
			self._isSortReverse = nil
			self._curSortIdx = sortIndex.goFight
		else
			self._isSortReverse = self._isSortReverse == false
		end
	else
		self._isSortReverse = false
		self._curSortIdx = idx
	end

	if self._curSortIdx == sortIndex.power then
		if not self._isSortReverse then
			self:_sortPowerDown()
		else
			self:_sortPowerUp()
		end
	elseif self._curSortIdx == sortIndex.goFight then
		self:_sortGoFight()
	else
		self._tableview:reloadData(self._mountCfgs)
	end

	if self._isSortReverse == true then
		GameUtil.setLocalScale(self._imgArrow.transform, 1, -1, 1)
	else
		GameUtil.setLocalScale(self._imgArrow.transform, 1, 1, 1)
	end

	if sortName[self._curSortIdx] then
		self._txtSort.text = sortName[self._curSortIdx]
	end

	for i, v in ipairs(self._sortTable) do
		if i ~= self._curSortIdx then
			v.imgChange:SetState(0)
		elseif self._isSortReverse == true then
			v.imgChange:SetState(2)
		elseif self._isSortReverse == false then
			v.imgChange:SetState(1)
		else
			v.imgChange:SetState(0)
		end
	end
end

function MountChooseView:_sortPowerDown()
	table.sort(self._mountCfgs, function(a, b)
		if a.power == b.power then
			return a.id < b.id
		end

		return a.power > b.power
	end)
	self._tableview:reloadData(self._mountCfgs)
end

function MountChooseView:_sortPowerUp()
	table.sort(self._mountCfgs, function(a, b)
		local alock = MountController.instance:getIfLock(a.id)
		local block = MountController.instance:getIfLock(b.id)

		if alock and block then
			return a.power < b.power
		elseif alock or block then
			return alock
		else
			return a.id < b.id
		end
	end)
	self._tableview:reloadData(self._mountCfgs)
end

function MountChooseView:_sortGoFight()
	table.sort(self._mountCfgs, function(a, b)
		local alock = MountController.instance:getIfLock(a.id)
		local block = MountController.instance:getIfLock(b.id)
		local aselect = MountModel.instance:getIsActive(a.id)
		local bselect = MountModel.instance:getIsActive(b.id)

		if aselect and bselect then
			return a.id < b.id
		elseif aselect or bselect then
			if self._isSortReverse == true then
				return bselect
			else
				return aselect
			end
		end

		if alock and block then
			return a.id < b.id
		elseif alock or block then
			return alock
		else
			return a.id < b.id
		end
	end)
	self._tableview:reloadData(self._mountCfgs)
end

return MountChooseView
