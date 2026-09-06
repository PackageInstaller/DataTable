-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bag/view/stack/PetAwakeSelectView.lua

module("logic.extensions.bag.view.stack.PetAwakeSelectView", package.seeall)

local PetAwakeSelectView = class("PetAwakeSelectView", ViewComponent)

PetAwakeSelectView.SORT_NAME = {
	function(petMo)
		return HandbookModel.instance:getAttributeLevel(petMo.raceId)
	end,
	"awakeLevel",
	function(petMo)
		return petMo:getFightingPower()
	end,
	"petId"
}
PetAwakeSelectView.SORT_VALUE = {
	{
		-1,
		ArraySort.DESCENDING,
		ArraySort.NONE
	},
	{
		-1,
		ArraySort.DESCENDING,
		ArraySort.NONE
	},
	{
		-1,
		ArraySort.DESCENDING,
		ArraySort.NONE
	},
	{
		ArraySort.NONE,
		ArraySort.DESCENDING
	}
}

function PetAwakeSelectView:buildUI()
	PetAwakeSelectView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnSure = self:getGo("btnSure")
	self._btnFilter = self:getGo("btnFilter")
	self._txtSure = goutil.findChildTextComponent(self._btnSure, "Text")
	self._btnCancel = self:getGo("btnCancel")
	self._goCell = self:getGo("cell")
	self._goTableView = self:getGo("tableView")
	self._tableView = ScrollerList.create(self._goTableView, self._goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._txtTip = self:getTxt("txtTip")
	self._btnOwnedProps = self:getBtn("top/showaction/btnOwnedProps")
	self._gouGo = self:getGo("top/showaction/gou")
	self._btnSort = self:getBtn("top/btnSort")
	self._sortpaneGo = self:getGo("sortpane")
	self._contentGo = self:getGo("sortpane/content")
	self._customInput = UICustomInput.Get(self._contentGo)

	self:_buildSortCells()

	self._empty = self:getGo("empty")
end

function PetAwakeSelectView:_buildSortCells()
	self._sortCellList = {}

	for k, v in pairs(PetAwakeSelectView.SORT_NAME) do
		local go = goutil.findChild(self._contentGo, "Cell" .. k)

		if go then
			local imgSort = goutil.findChild(go, "ImgSort"):GetComponent("UIImageSpriteChange")

			self._sortCellList[k] = {
				go = go,
				imgSort = imgSort
			}

			GameUtil.rmClickHandler(go)
			GameUtil.addClickHandler(go, GameUtil.handler(self._onClickSortCell, self, k))
		end
	end
end

function PetAwakeSelectView:bindEvents()
	PetAwakeSelectView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnCancel, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
	GameUtil.addClickHandler(self._btnFilter, self._onClickFilter, self)
	self._btnOwnedProps:AddClickListener(self._onClickBtnOwnedProps, self)
	self._btnSort:AddClickListener(self._onClickbtnSort, self)
	self._customInput:AddListener(self._onCustomInputCallback, self)
end

function PetAwakeSelectView:unbindEvents()
	PetAwakeSelectView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnCancel)
	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.rmClickHandler(self._btnFilter)
	self._btnOwnedProps:RemoveClickListener()
	self._btnSort:RemoveClickListener()
	self._customInput:RemoveListener()
end

function PetAwakeSelectView:onEnter()
	PetAwakeSelectView.super.onEnter(self)

	self._totalSelectPetNumLimit = BagModel.ONE_KEY_AWAKE_LIMIT_COUNT
	self._isOwnedProps = true

	self:_refreshList()
	self:_updateOwnedPropsState()
	goutil.setActive(self._sortpaneGo, false)
end

function PetAwakeSelectView:onExit()
	PetAwakeSelectView.super.onExit(self)
	self._tableView:dispose()
	PetFilterMgr.instance:resetDataByType(PetFilterMgr.TYPE_PETVIEW)
end

function PetAwakeSelectView:_updateCell(view, goCell, data)
	local cell = self:_clearCell(goCell)
	local proxy = MaterialMgr.setCellByMo(data, cell.posPet)

	proxy:setCallBack(function()
		CommonTipsMgr.instance:showPetTips(data)
	end)
	goutil.setActive(cell.mark, self._curSelectPetMoHash[data.raceId])
	GameUtil.addClickHandler(cell.btnSelect, GameUtil.handler(self._onClickSelect, self, data))

	for i = 1, data.awakenLv do
		goutil.setActive(cell.stars[i], true)
	end

	cell.txtName.text = data:getName()

	cell.starsLayout:Layout()
end

function PetAwakeSelectView:_clearCell(goCell)
	local cell = {}

	cell.go = goCell
	cell.posPet = goutil.findChild(cell.go, "posPet")
	cell.btnSelect = goutil.findChild(cell.go, "btnSelect")
	cell.mark = goutil.findChild(cell.btnSelect, "mark")
	cell.txtName = goutil.findChildTextComponent(cell.go, "txtName")
	cell.starsLayout = goutil.findChild(cell.go, "starLv"):GetComponent(ComponentType.UILayoutSingleLine)

	goutil.setActive(cell.mark, false)
	GameUtil.rmClickHandler(cell.btnSelect)
	MaterialMgr.resetAll(cell.posPet)

	cell.stars = {}

	for i = 1, 6 do
		cell.stars[i] = goutil.findChild(cell.go, "starLv/star_" .. i)

		goutil.setActive(cell.stars[i], false)
	end

	return cell
end

function PetAwakeSelectView:_onClickSure()
	local dataList = {}

	for k, v in pairs(self._curSelectPetMoHash) do
		table.insert(dataList, v)
	end

	if #dataList == 0 then
		local curDataList = self:_getCurDataList()

		for i, v in ipairs(curDataList) do
			if i <= self._totalSelectPetNumLimit then
				table.insert(dataList, v)
			else
				break
			end
		end
	end

	local petMoList = self:getFirstParam() or {}

	UIStateManager.instance:push(ViewName.PetOneKeyAwakeView, dataList, petMoList)
	self:close()
end

function PetAwakeSelectView:_onClickSelect(petMo)
	local petSelectCount = table.nums(self._curSelectPetMoHash)

	if petMo then
		if petMo == self._curSelectPetMoHash[petMo.raceId] then
			self._curSelectPetMoHash[petMo.raceId] = nil
			petSelectCount = petSelectCount - 1
		elseif petSelectCount >= self._totalSelectPetNumLimit then
			FloatWordMgr.instance:show(string.format("最多可选中%s只精灵", self._totalSelectPetNumLimit))

			return
		else
			self._curSelectPetMoHash[petMo.raceId] = petMo
			petSelectCount = petSelectCount + 1
		end

		self._tableView:refresh()
	end

	self._txtTip.text = langPara("最多可选%s只精灵（%s/%s）", self._totalSelectPetNumLimit, petSelectCount, self._totalSelectPetNumLimit)
	self._txtSure.text = petSelectCount <= 0 and lang("一键选中") or lang("确定")
end

function PetAwakeSelectView:_getCurDataList()
	local dataList = {}
	local petMoList = self:getFirstParam() or {}

	for k, mo in ipairs(petMoList) do
		if self:_onFilterOwnedProps(mo) and self:onFilter(mo) then
			table.insert(dataList, mo)
		end
	end

	if self._sortValue then
		local opt = {}
		local names = {}

		for k, v in pairs(self._sortValue) do
			local vArr = PetAwakeSelectView.SORT_VALUE[k]

			if vArr[v + 1] ~= -1 then
				local sortName = PetAwakeSelectView.SORT_NAME[k]

				table.insert(names, sortName)
				table.insert(opt, vArr[v + 1])
			end
		end

		ArraySort.sortOn(dataList, names, opt)
	end

	return dataList
end

function PetAwakeSelectView:onFilter(pet)
	local petCo = CharacterConfig.instance:getPetCo(pet.raceId)

	return (PetFilterMgr.instance:checkIsMatch(PetFilterMgr.TYPE_PETVIEW, petCo, pet.rare, pet.curFaceId))
end

function PetAwakeSelectView:_refreshList()
	self._curSelectPetMoHash = {}

	local dataList = self:_getCurDataList()

	self._tableView:reloadData(dataList)

	if #dataList > 0 then
		self._tableView:MoveCellToBegin(0)
	end

	self:_onClickSelect()
	goutil.setActive(self._empty, #dataList <= 0)
end

function PetAwakeSelectView:_onClickFilter()
	local pos, sizeDelta = self:_getPosAndSizeDelta(self._btnFilter)

	PetFilterMgr.instance:openFilterViewByType(self, PetFilterMgr.TYPE_PETVIEW, pos, sizeDelta, GameUtil.handler(self.updateFilterData, self))
end

function PetAwakeSelectView:updateFilterData(starList, jobList, rareList)
	self:_refreshList()
end

function PetAwakeSelectView:_getPosAndSizeDelta(go)
	local rect = go.gameObject:GetComponent("RectTransform")
	local pos = go.gameObject.transform.position
	local uiCamera = CameraTargetMgr.instance:getUICameraTarget():getCamera()

	pos = uiCamera:WorldToScreenPoint(pos)

	return pos, (rect ~= nil or nil) and {
		rect.sizeDelta.x,
		rect.sizeDelta.y
	}
end

function PetAwakeSelectView:_onClickBtnOwnedProps()
	self._isOwnedProps = not self._isOwnedProps

	self:_refreshList()
	self:_updateOwnedPropsState()
end

function PetAwakeSelectView:_updateOwnedPropsState()
	goutil.setActive(self._gouGo, self._isOwnedProps)
end

function PetAwakeSelectView:_onFilterOwnedProps(mo)
	if not self._isOwnedProps then
		return true
	end

	local petMos = BagModel.instance:getPetsByRaceId(mo.raceId)

	for _, petMo in ipairs(petMos) do
		if petMo.petId ~= mo.petId and not petMo:isLocked() then
			return true
		end
	end

	local replaceItemCfgs = ItemConfig.instance:getAllReplaceItemCfgList(mo)

	for _, cfg in ipairs(replaceItemCfgs) do
		if cfg.race ~= 0 and MaterialModel.instance:getMaterialsNumber(MatType.Item, cfg.id) > 0 then
			return true
		end
	end
end

function PetAwakeSelectView:_onClickbtnSort()
	self._sortValue = self:_getSortState()

	goutil.setActive(self._sortpaneGo, true)
end

function PetAwakeSelectView:_setTxtComSrot()
	local isHit = false
	local sortValue = BagModel.instance:GetSortState()
	local sortState = 0

	for k, v in ipairs(sortValue) do
		local vArr = BagModel.SORT_VALUE[k]

		sortState = v

		if vArr[v + 1] ~= -1 then
			local sortName = BagModel.SORT_NAME[k]

			if sortName == "awakeLevel" then
				self.txtComSort.text = "觉醒"
				isHit = true

				break
			elseif sortName == "level" then
				self.txtComSort.text = "等级"
				isHit = true

				break
			elseif sortName == "rare" then
				self.txtComSort.text = "品质"
				isHit = true

				break
			elseif sortName == "petId" then
				self.txtComSort.text = "最新"
				isHit = true
			elseif sortName == BagModel.SORT_NAME[1] then
				self.txtComSort.text = "战力"
				isHit = true

				break
			end
		end
	end

	if not isHit then
		self.txtComSort.text = "排序"
	end

	if sortState >= 0 then
		self._imgSortChange:SetState(sortState)
	else
		self._imgSortChange:SetState(0)
	end
end

function PetAwakeSelectView:_onCustomInputCallback(hover)
	if not hover then
		goutil.setActive(self._sortpaneGo, false)
	end
end

function PetAwakeSelectView:_onClickSortCell(idx)
	self:_onClickNextSort(idx)
	self:_updateSortCellState()
	self:_refreshList()
end

function PetAwakeSelectView:_getSortState()
	if self._sortValue == nil then
		self._sortValue = {}

		for i = 1, #PetAwakeSelectView.SORT_NAME do
			self._sortValue[i] = 0
		end
	end

	return self._sortValue
end

function PetAwakeSelectView:_onClickNextSort(idx)
	local v = self._sortValue[idx]

	v = v + 1

	local vArr = PetAwakeSelectView.SORT_VALUE[idx]

	v = v % #vArr

	if idx ~= #PetAwakeSelectView.SORT_VALUE then
		for i = 1, #PetAwakeSelectView.SORT_VALUE - 1 do
			self._sortValue[i] = 0
		end
	end

	self._sortValue[idx] = v
end

function PetAwakeSelectView:_updateSortCellState()
	for i, v in ipairs(self._sortCellList) do
		v.imgSort:SetState(self._sortValue[i])
	end
end

return PetAwakeSelectView
