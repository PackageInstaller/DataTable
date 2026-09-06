-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zoo/view/ZoowarehouseView.lua

module("logic.extensions.zoo.view.ZoowarehouseView", package.seeall)

local ZoowarehouseView = class("ZoowarehouseView", ViewComponent)

function ZoowarehouseView:buildUI()
	ZoowarehouseView.super.buildUI(self)

	self._closeBtn = self:getBtn("bg/close")
	self._gridAnimal = self:getGo("bg/gridAnimal")
	self._animalCell = self:getGo("bg/animalCell")
	self._number = goutil.findChildTextComponent(self.mainGO, "bg/number/Text")
	self._searchInput = self:getInput("bg/search/input")
	self._searchPlaceholder = goutil.findChildTextComponent(self._searchInput.gameObject, "Placeholder")
	self._searchEnter = self:getBtn("bg/enterBtn")
	self._pageText = goutil.findChildTextComponent(self.mainGO, "bg/page")
	self._upPage = self:getBtn("bg/page/up")
	self._downPage = self:getBtn("bg/page/down")
	self._noneGo = self:getGo("bg/noneTip")
	self._noneTip = goutil.findChildTextComponent(self._noneGo, "tipsNull")
	self._raceCell = self:getGo("bg/raceCell")
	self._raceTab = self:getGo("bg/raceTab")
	self._raceView = ScrollerList.create(self._raceTab, self._raceCell, GameUtil.handler(self._updateRaceCell, self))
	self._animalTab = self:getBtn("bg/species/animalTab")
	self._animalSelect = self:getGo("bg/species/animalTab/select")
	self._eggTab = self:getBtn("bg/species/eggTab")
	self._eggSelect = self:getGo("bg/species/eggTab/select")
end

function ZoowarehouseView:bindEvents()
	ZoowarehouseView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._searchEnter:AddClickListener(self._onClickSearchEnter, self)
	self._upPage:AddClickListener(self._onClickUpPage, self)
	self._downPage:AddClickListener(self._onClickDownPage, self)
	self._animalTab:AddClickListener(self._onClickAnimalTab, self)
	self._eggTab:AddClickListener(self._onClickEggTab, self)
end

function ZoowarehouseView:unbindEvents()
	ZoowarehouseView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._searchEnter:RemoveClickListener()
	self._upPage:RemoveClickListener()
	self._downPage:RemoveClickListener()
	self._animalTab:RemoveClickListener()
	self._eggTab:RemoveClickListener()
end

function ZoowarehouseView:onEnter()
	ZoowarehouseView.super.onEnter(self)
	goutil.setActive(self._animalCell, false)

	self._myZoo = ZooModel.instance:getMyZoo()
	self._animalCellList = {}
	self._animalShowList = {}
	self._animalAvatarList = {}
	self._page = 1

	local animalType = ZooConfig.instance:getAnimal()
	local animalTypeList = {
		{
			raceId = 0,
			name = lang("tip_all")
		}
	}

	for i, value in ipairs(animalType) do
		table.insert(animalTypeList, value)
	end

	self._selectRaceId = 0

	self._raceView:reloadData(animalTypeList)
	self:_onClickAnimalTab()
	GlobalDispatcher:addListener(GlobalNotify.OnZooUpdateAnimalData, self._onClickAnimalTab, self)
	GlobalDispatcher:addListener(GlobalNotify.ZooGetAnimalsInfo, self._onGetZooAnimalInfoRes, self)
	settimer(1, self._updateMatchTimeCD, self)
end

function ZoowarehouseView:onExit()
	ZoowarehouseView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.ZooGetAnimalsInfo, self._onGetZooAnimalInfoRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnZooUpdateAnimalData, self._onClickAnimalTab, self)
	removetimer(self._updateMatchTimeCD, self)
	self._raceView:dispose()
	self:_clearIconImages()

	for k, v in pairs(self._animalShowList) do
		self._animalAvatarList[k]:destroy()
		v:clear()
	end

	self._currDataList = nil
end

function ZoowarehouseView:_clearIconImages()
	for i = 1, 8 do
		local cell = self._animalCellList[i]

		if cell then
			local eggIcon = goutil.findChild(cell.gameObject, "eggIcon")

			uGuiUtil.clearImage(eggIcon)
			goutil.destroy(cell)
		end

		self._animalCellList[i] = nil
	end
end

function ZoowarehouseView:_updateCell(cell, data)
	Framework.ButtonAdapter.Get(cell.gameObject):RemoveClickListener()

	goutil.findChildTextComponent(cell.gameObject, "name").text = data.name

	local flag = self._tab == 1

	goutil.setActive(goutil.findChild(cell.gameObject, "eggIcon"), not flag)
	goutil.setActive(goutil.findChild(cell.gameObject, "animalShow"), flag)

	if flag then
		self:_updateAnimalCell(cell, data)
	else
		self:_updateEggCell(cell, data)
	end
end

function ZoowarehouseView:_updateAnimalCell(cell, data)
	goutil.setActive(goutil.findChild(cell.gameObject, "follow"), data.state == 0)
	goutil.setActive(goutil.findChild(cell.gameObject, "sell"), false)
	goutil.setActive(goutil.findChild(cell.gameObject, "pair"), false)

	local btn = Framework.ButtonAdapter.Get(cell.gameObject)

	self:_updateMatchTime(cell, data)
	btn:RemoveClickListener()
	btn:AddClickListener(function()
		local index = 1

		for i, value in ipairs(self._dataList) do
			if value.id == data.id then
				index = i

				break
			end
		end

		ZoowarehouseController.instance:recordAnimalList(self._dataList, index)
		UIStateManager.instance:push(ViewName.ZooanimalView, data)
	end)

	if self._animalShowList[cell.gameObject] == nil then
		self._animalShowList[cell.gameObject], self._animalAvatarList[cell.gameObject] = data:showAnimalAvatar(goutil.findChild(cell.gameObject, "animalShow"), 256, 256, 0.8, 0.65, AvatarUseType.Scene)
	else
		local avatarMo = self._animalAvatarList[cell.gameObject]:getNewUseMo()

		avatarMo:setDataByAnimalMo(data)
		self._animalAvatarList[cell.gameObject]:updateByMo(avatarMo)
		self._animalAvatarList[cell.gameObject]:setAnimatorLayerByCoverData()
	end
end

function ZoowarehouseView:_updateMatchTime(cell, data)
	local timesBg = goutil.findChild(cell.gameObject, "timesBg")

	goutil.setActive(timesBg, data.restMatchTimes > 0)

	if timesBg.activeSelf then
		local matchCD = data:getMatchCD()
		local timeText = goutil.findChildTextComponent(cell.gameObject, "timesBg/times")

		goutil.setActive(timeText.gameObject, true)

		timeText.text = matchCD > 0 and string.format(lang("petzoo_matchtimes_cd_time"), math.floor(matchCD)) or string.format(lang("petzoo_matchtimes_remain"), data.restMatchTimes)
	end
end

function ZoowarehouseView:_updateMatchTimeCD()
	if self._tab ~= 1 or not self._animalCellList then
		return
	end

	local cnt = #self._animalCellList

	for i = 1, cnt do
		local cell = self._animalCellList[i]
		local data = self._currDataList[i]

		if cell and data then
			self:_updateMatchTime(cell, data)
		end
	end
end

function ZoowarehouseView:_updateEggCell(cell, data)
	goutil.setActive(goutil.findChild(cell.gameObject, "follow"), false)
	goutil.setActive(goutil.findChild(cell.gameObject, "sell"), false)
	goutil.setActive(goutil.findChild(cell.gameObject, "pair"), false)
	goutil.setActive(goutil.findChild(cell.gameObject, "timesBg"), false)

	local eggIcon = goutil.findChild(cell.gameObject, "eggIcon")

	uGuiUtil.setSpriteToImage(eggIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(data.icon))
	Framework.ButtonAdapter.Get(cell.gameObject):AddClickListener(function()
		UIStateManager.instance:push(ViewName.ZoodetailsView, data, ZooController.EGGTYPE)
	end)
end

function ZoowarehouseView:_updateRaceCell(view, cell, data)
	goutil.findChildTextComponent(cell.gameObject, "Text").text = data.name

	local uiSpChange = cell.gameObject:GetComponent(ComponentType.UIImageSpriteChange)

	if self._selectRaceId == data.raceId then
		uiSpChange:SetState(1)
	else
		uiSpChange:SetState(0)
	end

	local btn = Framework.ButtonAdapter.Get(cell.gameObject)

	btn:RemoveClickListener()
	btn:AddClickListener(function()
		self._selectRaceId = data.raceId

		self._raceView:refresh()

		if self._tab == 1 then
			self:_onClickAnimalTab()
		else
			self:_onClickEggTab()
		end
	end)
end

function ZoowarehouseView:_updatePage(noneTip)
	goutil.setActive(self._noneGo, #self._dataList == 0)
	goutil.setActive(self._animalSelect, self._tab == 1)
	goutil.setActive(self._eggSelect, self._tab == 2)

	if #self._dataList == 0 then
		self._noneTip.text = self._tab == 1 and lang("petzoo_noanimals") or lang("petzoo_noeggs")
	end

	local list = {}

	for i = -7 + self._page * 8, self._page * 8 do
		if self._dataList[i] then
			table.insert(list, self._dataList[i])
		else
			break
		end
	end

	for i = 1, 8 do
		if self._animalCellList[i] == nil then
			self._animalCellList[i] = goutil.cloneAndSetParent(self._animalCell, self._gridAnimal.transform)
		end

		if list[i] then
			goutil.setActive(self._animalCellList[i], true)
			self:_updateCell(self._animalCellList[i], list[i])
		else
			goutil.setActive(self._animalCellList[i], false)
		end
	end

	self._currDataList = list
	self._pageText.text = string.format("%d/%d", self._page, self._maxPage)

	goutil.setActive(self._upPage.gameObject, self._page > 1)
	goutil.setActive(self._downPage.gameObject, self._page < self._maxPage)
end

function ZoowarehouseView:_onClickSearchEnter()
	if self._tab == 1 then
		self:_onClickAnimalTab()
	else
		self:_onClickEggTab()
	end
end

function ZoowarehouseView:_onGetZooAnimalInfoRes()
	if self._tab == 1 then
		self:_onClickAnimalTab()
	end
end

function ZoowarehouseView:_onClickUpPage()
	if self._page > 1 then
		self._page = self._page - 1

		self:_updatePage()
	end
end

function ZoowarehouseView:_onClickDownPage()
	if self._page < self._maxPage then
		self._page = self._page + 1

		self:_updatePage()
	end
end

function ZoowarehouseView:_onClickAnimalTab()
	self._tab = 1

	ZoowarehouseController.instance:setSearchName(self._searchInput:GetText())
	ZoowarehouseController.instance:setSearchRace(self._selectRaceId)

	self._dataList = ZoowarehouseController.instance:search(self._myZoo:getAnimalList())
	self._maxPage = math.ceil(#self._dataList / 8) or 1
	self._number.text = #self._dataList .. "/" .. ZooConfig.instance:getMaxAnimalNum()
	self._page = 1
	self._searchPlaceholder.text = lang("petzoo_selectpets_tips")

	self:_updatePage()
end

function ZoowarehouseView:_onClickEggTab()
	self._tab = 2

	ZoowarehouseController.instance:setSearchName(self._searchInput:GetText())
	ZoowarehouseController.instance:setSearchRace(self._selectRaceId)

	self._dataList = ZoowarehouseController.instance:search(self._myZoo:getEggs())
	self._page = 1
	self._maxPage = math.ceil(#self._dataList / 8) or 1
	self._number.text = #self._dataList .. "/" .. ZooConfig.instance:getMaxAnimalEggsNum()
	self._searchPlaceholder.text = lang("petzoo_selecteggs_tips")

	self:_updatePage()
end

return ZoowarehouseView
