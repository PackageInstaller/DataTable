-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/contract/view/ContractBookView.lua

module("logic.extensions.contract.view.ContractBookView", package.seeall)

local ContractBookView = class("ContractBookView", ViewComponent)

function ContractBookView:ctor()
	ContractBookView.super.ctor(self)
end

function ContractBookView:destroyUI()
	ContractBookView.super.destroyUI(self)
end

function ContractBookView:onExitFinished()
	ContractBookView.super.onExitFinished(self)
end

function ContractBookView:onEnterFinished()
	ContractBookView.super.onEnterFinished(self)
end

function ContractBookView:unbindEvents()
	ContractBookView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	GameUtil.rmClickHandler(self._filterButton)
	GameUtil.rmClickHandler(self._InputC_Search_Clear)
	self._raceFilter:unbindEvents()
	self._jobFilter:unbindEvents()
	self._inputSearch:RemoveOnValueChanged()
	self._customInput:RemoveListener()
end

function ContractBookView:bindEvents()
	ContractBookView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
	GameUtil.addClickHandler(self._filterButton, self._onClickFilter, self)
	GameUtil.addClickHandler(self._InputC_Search_Clear, self._onClearSearchClick, self)
	self._inputSearch:AddOnValueChanged(self._OnSearchTextChanged, self)
	self._customInput:AddListener(self._onCustomInputCallback, self)
	self._raceFilter:bindEvents()
	self._jobFilter:bindEvents()
	self._raceFilter:setValueChanged(self._updateList, self)
	self._jobFilter:setValueChanged(self._updateList, self)
end

function ContractBookView:onExit()
	ContractBookView.super.onExit(self)
	self._masterScrollList:dispose()
	self._itemScrollList:dispose()
	self._leftScrollList:dispose()

	self._loader = RoleObjectPool.instance:removeRole(self._loader)
end

function ContractBookView:buildUI()
	ContractBookView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self._con = self:getGo("con")

	local tableview = self:getGo("bottom/tableview")
	local item = self:getGo("bottom/item")

	self._masterScrollList = ScrollerList.create(tableview, item, GameUtil.handler(self._updateMasterCell, self), GameUtil.handler(self.clearMasterCell, self))
	self._skillicon = self:getGo("right/skill/skillicon")
	self._rightEmpty = self:getGo("right/rightEmpty")
	self._txtSkillDesc = self:getTxt("right/skill/txtDesc")

	local r_tableview = self:getGo("right/tableview")
	local r_item = self:getGo("right/item")

	self._itemScrollList = ScrollerList.create(r_tableview, r_item, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self.clearItemCell, self))

	local l_tableview = self:getGo("left/tableview")
	local l_item = self:getGo("left/item")

	self._leftScrollList = ScrollerList.create(l_tableview, l_item, GameUtil.handler(self._updateLeftCell, self), GameUtil.handler(self.clearLeftCell, self))
	self._txtTitle = self:getTxt("left/title/txt")
	self._filterButton = self:getBtn("bottom/btnFilter")
	self._inputSearch = self:getInput("bottom/InputC_Search")
	self._InputC_Search_Clear = self:getBtn("bottom/InputC_Search/BtnClear")
	self._filter = self:getGo("bottom/filter")
	self._content = self:getGo("bottom/filter/content")
	self._RaceFilter = self:getGo("bottom/filter/content/RaceFilter")
	self._JobFilter = self:getGo("bottom/JobFilter")
	self._raceFilter = ItemFilterExt.New(self._RaceFilter, 1, 8, false, "Cell", "Mark")
	self._jobFilter = ItemFilterExt.New(self._JobFilter, 1, 2, false, "Cell", "Mark")
	self._customInput = UICustomInput.Get(self._content)
end

function ContractBookView:onEnter()
	ContractBookView.super.onEnter(self)

	self._searchingStr = ""

	GameUtil.SetActive(self._filter, false)

	local data = {}

	data.raceSelectList = {}
	data.raceActiveList = {}
	data.raceClickAble = {}

	for i = 1, 8 do
		data.raceSelectList[i] = false
		data.raceActiveList[i] = true
		data.raceClickAble[i] = true
	end

	self._raceFilter:initData(data.raceSelectList)
	self._raceFilter:initActiveList(data.raceActiveList)
	self._raceFilter:initClickAble(data.raceClickAble)

	local data = {}

	data.jobSelectList = {}
	data.jobActiveList = {}
	data.jobClickAble = {}

	for i = 1, 2 do
		data.jobSelectList[i] = false
		data.jobActiveList[i] = true
		data.jobClickAble[i] = true
	end

	self._jobFilter:initData(data.jobSelectList)
	self._jobFilter:initActiveList(data.jobActiveList)
	self._jobFilter:initClickAble(data.jobClickAble)
	self:refreshUI()
end

function ContractBookView:_onCustomInputCallback(hover)
	if not hover then
		GameUtil.SetActive(self._filter, false)
	end
end

function ContractBookView:_updateList()
	self:_refreshPetList()
end

function ContractBookView:refreshUI()
	local masterPool = {}
	local pool = {}
	local arr = ContractConfig.instance:getContractList()

	for i, cfg in ipairs(arr) do
		if not cfg.isHide then
			local summonMasterRaceIds = cfg.summonMasterRaceIds

			for j, mid in ipairs(summonMasterRaceIds) do
				if masterPool[mid] == nil then
					masterPool[mid] = {}
				end

				table.insert(masterPool[mid], cfg)
			end

			local summonedRaceIds = cfg.summonedRaceIds

			for j, mid in ipairs(summonedRaceIds) do
				if pool[mid] == nil then
					pool[mid] = {}
				end

				table.insert(pool[mid], cfg)
			end
		end
	end

	local list = {}

	for k, v in pairs(masterPool) do
		local obj = {}

		obj.isMaster = true
		obj.raceId = checknumber(k)

		local map = {}
		local temp = {}

		for i, cfg in ipairs(v or {}) do
			local summonedRaceIds = cfg.summonedRaceIds

			for j, raceId in ipairs(summonedRaceIds or {}) do
				if map[raceId] == nil then
					map[raceId] = raceId

					table.insert(temp, raceId)
				end
			end
		end

		obj.list = temp

		table.insert(list, obj)
	end

	self._masterPool = masterPool

	for k, v in pairs(pool) do
		local obj = {}

		obj.isMaster = false
		obj.raceId = checknumber(k)

		local map = {}
		local temp = {}

		for i, cfg in ipairs(v or {}) do
			local summonMasterRaceIds = cfg.summonMasterRaceIds

			for j, raceId in ipairs(summonMasterRaceIds or {}) do
				if map[raceId] == nil then
					map[raceId] = raceId

					table.insert(temp, raceId)
				end
			end
		end

		obj.list = temp

		table.insert(list, obj)
	end

	if self._currData == nil and #list > 0 then
		self._currData = list[1]
	end

	self._totalList = list

	self:_refreshPetList()
	self:updateLeft()
	self:updateRightTop()
end

function ContractBookView:_onClickClose()
	self:close()
end

function ContractBookView:_updateItemCell(view, cell, data, tag)
	MaterialMgr.setCellByCfg(data, cell)
end

function ContractBookView:clearItemCell(cell)
	MaterialMgr.resetAll(cell)
end

function ContractBookView:_updateMasterCell(view, cell, data, tag)
	local con = goutil.findChild(cell, "con")
	local select = goutil.findChild(cell, "select")
	local top = goutil.findChild(cell, "top")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local raceId = data.raceId

	MaterialMgr.setCell(MatType.Pet, raceId, con)

	txtName.text = MaterialMgr.getMaterialsName(MatType.Pet, raceId)

	GameUtil.SetActive(select, raceId == self._currData.raceId and data.isMaster == self._currData.isMaster)
	GameUtil.addClickHandler(top, GameUtil.handler(self.onClickDownPet, self, data))
end

function ContractBookView:clearMasterCell(cell)
	local con = goutil.findChild(cell, "con")

	MaterialMgr.resetAll(con)
end

function ContractBookView:_updateLeftCell(view, cell, data, tag)
	local con = goutil.findChild(cell, "con")
	local select = goutil.findChild(cell, "select")
	local top = goutil.findChild(cell, "top")
	local txtName = goutil.findChildTextComponent(cell, "txtName")

	MaterialMgr.setCell(MatType.Pet, data, con)

	txtName.text = MaterialMgr.getMaterialsName(MatType.Pet, data)

	GameUtil.addClickHandler(top, GameUtil.handler(self.onClickLeft, self, data))
end

function ContractBookView:clearLeftCell(cell)
	local con = goutil.findChild(cell, "con")

	MaterialMgr.resetAll(con)
end

function ContractBookView:onClickDownPet(data)
	if self._currData == nil or self._currData.raceId ~= data.raceId or self._currData.isMaster ~= data.isMaster then
		self._currData = data

		self:updateLeft()
		self:updateRightTop()
		self._masterScrollList:refresh()
	end
end

function ContractBookView:onClickLeft(raceId)
	CommonTipsMgr.instance:showMaxLvlPetTips(raceId)

	self._currSelectRaceId = raceId

	self._leftScrollList:refresh()
end

function ContractBookView:_OnSearchTextChanged()
	local text = self._inputSearch:GetText()

	if text ~= self._searchingStr then
		self._searchingStr = text

		self:_refreshPetList()
	end
end

function ContractBookView:_onClearSearchClick()
	self._searchingStr = ""
	self._inputSearch.input.text = ""

	self:_refreshPetList()
end

function ContractBookView:_onClickFilter()
	GameUtil.SetActive(self._filter, true)
end

function ContractBookView:_refreshPetList()
	local list = {}

	for k, v in pairs(self._totalList) do
		if self:onFilter(v.raceId) then
			table.insert(list, v)
		end
	end

	self._masterScrollList:reloadData(list)
end

function ContractBookView:onFilter(raceId)
	local petCo = CharacterConfig.instance:getPetCo(raceId)
	local isHit = self:_isMatch(petCo)

	if not isHit then
		return false
	end

	if not string.nilorempty(self._searchingStr) then
		local str = StringUtil.RelpaceEscapeChar(self._searchingStr)
		local count = string.find(petCo.name, str)

		if not count then
			return false
		end
	end

	return isHit
end

function ContractBookView:_isMatch(petCo)
	local racdIdx = PetSkinConfig.instance:getFisrtEleAttrIdx(petCo.raceId)

	racdIdx = racdIdx % 10

	return ItemFilter.checkIsMatch(self._raceFilter:getData(), racdIdx) and ItemFilter.checkIsMatch(self._jobFilter:getData(), self._masterPool[petCo.raceId] and 1 or 2)
end

function ContractBookView:updateLeft()
	local arr = self._currData.list

	self._leftScrollList:reloadData(arr)
end

function ContractBookView:updateRightTop()
	local raceId = self._currData.raceId
	local isMaster = self._currData.isMaster

	self._txtTitle.text = isMaster and "可契约的精灵" or "可契约的召唤师"

	local modelCfg = CharactorFacade.instance:getPetDisplayModelUIPosAndScale(raceId)

	if not modelCfg[1] then
		if not modelCfg[2] then
			local y = 0

			if not modelCfg[3] then
				local scale = 1

				self._loader = RoleObjectPool.instance:addRoleToParent(self._loader, raceId, self._con, scale, nil, true, modelCfg[1], y)
			end
		end
	end
end

return ContractBookView
