-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zoo/view/ZooselectView.lua

module("logic.extensions.zoo.view.ZooselectView", package.seeall)

local ZooselectView = class("ZooselectView", ViewComponent)

function ZooselectView:buildUI()
	ZooselectView.super.buildUI(self)

	self._closeBtn = self:getBtn("close")
	self._tableview = ScrollerList.create(self:getGo("itemview"), self:getGo("itemcell"), GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._confirmBtn = self:getBtn("confirm")
	self._cancelBtn = self:getBtn("cancel")
	self._txtC_empty = self:getTxt("TxtC_Empty")
	self._txtC_Title = self:getTxt("Nego_Title/TxtC_Title")
	self._sortDropDown = DropDownAdapter.GetFrom(self.mainGO, "sort")
	self._searchBtn = self:getBtn("searchBtn")
	self._searchInput = self:getInput("InputC_Search")
	self._searchPlaceholder = goutil.findChildTextComponent(self._searchInput.gameObject, "Placeholder")
end

function ZooselectView:bindEvents()
	ZooselectView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._confirmBtn:AddClickListener(self._onConfirm, self)
	self._cancelBtn:AddClickListener(self._onCancel, self)
	self._sortDropDown:AddOnValueChanged(self._onValueChange, self)
	self._searchBtn:AddClickListener(self._onClickSearch, self)
end

function ZooselectView:unbindEvents()
	ZooselectView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._confirmBtn:RemoveClickListener()
	self._cancelBtn:RemoveClickListener()
	self._sortDropDown:RemoveOnValueChanged()
	self._searchBtn:RemoveClickListener()
end

function ZooselectView:onEnter()
	ZooselectView.super.onEnter(self)

	self._sortType = 0
	self._selectId = {}

	self:_updateSelectTips()

	local myZoo = ZooModel.instance:getMyZoo()

	if not myZoo then
		self._useList = {}

		self:_refreshList()
		ZooController.instance:getMyZooInfo()
	else
		self:_onGetMyZooInfo()
	end

	GlobalDispatcher:addListener(GlobalNotify.OnGetMyZooInfo, self._onGetMyZooInfo, self)
	GlobalDispatcher:addListener(GlobalNotify.ZooGetAnimalsInfo, self._onZooGetAnimalsInfo, self)
end

function ZooselectView:_initParams()
	local openParam = self:getOpenParam()

	self._selectType = openParam[1]
	self._selectCallBack = openParam[2]
	self._list = openParam[3]
	self._selectModel = openParam[4]
	self._maxNum = openParam[5]
	self._tipText = openParam[6]
	self._cellAnimsShow = {}

	if not self._list or #self._list == 0 then
		if self._selectType == ZooController.ANIMALTYPE then
			self._list = ZooModel.instance:getMyAnimalList()
		elseif self._selectType == ZooController.EGGTYPE then
			local myZoo = ZooModel.instance:getMyZoo()
			local result = myZoo:getEggs()

			table.sort(result, function(a, b)
				return a.id < b.id
			end)

			self._list = result
		end
	end
end

function ZooselectView:_updateSelectTips()
	if self._selectType == ZooController.ANIMALTYPE then
		goutil.setActive(self._sortDropDown.gameObject, true)

		self._txtC_Title.text = string.format(lang("petzoo_selectpets_numtips"), self._selectModel == ZooController.Once and 1 or self._maxNum, self._tipText)
		self._searchPlaceholder.text = lang("petzoo_selectpets_tips")
	elseif self._selectType == ZooController.EGGTYPE then
		self._txtC_Title.text = string.format(lang("petzoo_selecteggs_numtips"), self._selectModel == ZooController.Once and 1 or self._maxNum, self._tipText)

		goutil.setActive(self._sortDropDown.gameObject, false)

		self._searchPlaceholder.text = lang("petzoo_selecteggs_tips")
	end
end

function ZooselectView:onExit()
	GlobalDispatcher:removeListener(GlobalNotify.ZooGetAnimalsInfo, self._onZooGetAnimalsInfo, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnGetMyZooInfo, self._onGetMyZooInfo, self)
	ZooselectView.super.onExit(self)
	self._tableview:dispose()

	if self._cellAnimsShow then
		for k, value in pairs(self._cellAnimsShow) do
			if value.animalShow then
				value.animalShow:clear()
				value.avatar:destroy()
			end
		end

		self._cellAnimsShow = nil
	end

	self._lastSelectCell = nil
end

function ZooselectView:refresh(list)
	if list and #list > 0 then
		self._tableview:reloadData(list)
		goutil.setActive(self._txtC_empty.gameObject, false)
	else
		self._txtC_empty.text = self._selectType == ZooController.EGGTYPE and lang("petzoo_selecteggs_empty") or lang("petzoo_selectpets_empty")

		goutil.setActive(self._txtC_empty.gameObject, true)
		self._tableview:reloadData({})
	end
end

function ZooselectView:_updateCell(view, cell, data)
	self:_handleEvents(cell, data)
	self:_checkSelected(cell, data)
	self:_fillInformation(cell, data)
	self:_fillGenes(cell, data)
end

function ZooselectView:_handleEvents(cell, data)
	local btn = Framework.ButtonAdapter.Get(cell.gameObject)

	btn:RemoveClickListener()
	btn:AddClickListener(function()
		self:_onClickCell(cell, data.id)
	end, self)

	local tLongPressed = typeof(UILongPressed)
	local longPressed = cell.gameObject:GetComponent(tLongPressed)

	longPressed = longPressed or cell.gameObject:AddComponent(tLongPressed)

	longPressed:RemoveListener()
	longPressed:AddListener(function()
		UIStateManager.instance:push(ViewName.ZoodetailsView, data, self._selectType)
	end, self)
end

function ZooselectView:_fillInformation(cell, data)
	local animalIcon = goutil.findChild(cell.gameObject, "animalIcon")
	local eggIcon = goutil.findChild(cell.gameObject, "eggIcon")
	local nameText = goutil.findChildTextComponent(cell.gameObject, "name")

	if self._selectType == ZooController.ANIMALTYPE then
		self:_fillInformationAnimal(cell, animalIcon, eggIcon, nameText, data)
	elseif self._selectType == ZooController.EGGTYPE then
		self:_fillInformationEggs(cell, animalIcon, eggIcon, nameText, data)
	end
end

function ZooselectView:_fillInformationAnimal(cell, animalIcon, eggIcon, nameText, data)
	local sliderDining = Framework.SliderAdapter.GetFrom(cell.gameObject, "dining/slider")
	local sliderCoffee = Framework.SliderAdapter.GetFrom(cell.gameObject, "coffee/slider")
	local sliderAmusement = Framework.SliderAdapter.GetFrom(cell.gameObject, "amusement/slider")
	local sliderStone = Framework.SliderAdapter.GetFrom(cell.gameObject, "stone/slider")
	local myZoo = ZooModel.instance:getMyZoo()
	local buildingRestaurant = myZoo:getBuildingByType(ZooBuildingType.Restaurant)
	local buildingCafe = myZoo:getBuildingByType(ZooBuildingType.Cafe)
	local buildingAmusementPark = myZoo:getBuildingByType(ZooBuildingType.AmusementPark)
	local buildingFossilQuarry = myZoo:getBuildingByType(ZooBuildingType.FossilQuarry)

	sliderDining:SetValue(buildingRestaurant:getAnimalBenefit(data.id))
	sliderCoffee:SetValue(buildingCafe:getAnimalBenefit(data.id))
	sliderAmusement:SetValue(buildingAmusementPark:getAnimalBenefit(data.id))
	sliderStone:SetValue(buildingFossilQuarry:getAnimalBenefit(data.id))

	nameText.text = data.name

	goutil.setActive(animalIcon, true)
	goutil.setActive(eggIcon, false)

	local cellAnimalShow = self._cellAnimsShow[cell]

	if cellAnimalShow == nil then
		goutil.setActive(cell.gameObject, true)

		local animalShow, avatar = data:showAnimalAvatar(animalIcon, 70, 80, 0.56, 0.45, AvatarUseType.Scene)

		self._cellAnimsShow[cell] = {
			animalShow = animalShow,
			avatar = avatar
		}
	else
		local avatarMo = cellAnimalShow.avatar:getNewUseMo()

		avatarMo:setDataByAnimalMo(data)
		cellAnimalShow.avatar:updateByMo(avatarMo)
	end
end

function ZooselectView:_fillInformationEggs(cell, animalIcon, eggIcon, nameText, data)
	local sliderDining = Framework.SliderAdapter.GetFrom(cell.gameObject, "dining/slider")
	local sliderCoffee = Framework.SliderAdapter.GetFrom(cell.gameObject, "coffee/slider")
	local sliderAmusement = Framework.SliderAdapter.GetFrom(cell.gameObject, "amusement/slider")
	local sliderStone = Framework.SliderAdapter.GetFrom(cell.gameObject, "stone/slider")

	sliderDining:SetValue(0)
	sliderCoffee:SetValue(0)
	sliderAmusement:SetValue(0)
	sliderStone:SetValue(0)

	local eggInfo = ZooConfig.instance:getAnimalById(data.raceId)

	nameText.text = eggInfo.eggName

	goutil.setActive(animalIcon, false)
	goutil.setActive(eggIcon, true)
	uGuiUtil.setSpriteToImage(eggIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(eggInfo.eggIcon))
end

function ZooselectView:_checkSelected(cell, data)
	local selected = goutil.findChild(cell.gameObject, "select")
	local isSelected = false

	for i, id in ipairs(self._selectId) do
		if id == data.id then
			isSelected = true
		end
	end

	goutil.setActive(selected, isSelected)
end

function ZooselectView:_fillGenes(cell, data)
	local gene_1 = goutil.findChild(cell.gameObject, "gene_1")
	local gene_2 = goutil.findChild(cell.gameObject, "gene_2")
	local gene_3 = goutil.findChild(cell.gameObject, "gene_3")

	goutil.setActive(gene_1, #data.headGenes > 0)
	goutil.setActive(gene_2, #data.clothesGenes > 0)
	goutil.setActive(gene_3, #data.propertyGenes > 0)
end

function ZooselectView:_clearCell(cell)
	Framework.ButtonAdapter.Get(cell.gameObject):RemoveClickListener()

	local longPressed = cell.gameObject:GetComponent(tLongPressed)

	if longPressed then
		longPressed:RemoveListener()
	end

	local eggIcon = goutil.findChild(cell.gameObject, "eggIcon")
	local bigBg = Framework.ImageBigBG.Get(eggIcon)

	if bigBg then
		bigBg:ClearImage()
	end
end

function ZooselectView:_refreshList()
	if self._sortType == 0 then
		table.sort(self._useList, function(a, b)
			return a.quality < b.quality
		end)
		self:refresh(self._useList)
	elseif self._sortType == 1 then
		table.sort(self._useList, function(a, b)
			return a.gainTime < b.gainTime
		end)
		self:refresh(self._useList)
	end
end

function ZooselectView:_onClickCell(cell, id)
	if ViewMgr.instance:isOpen(ViewName.ZoodetailsView) then
		return
	end

	if self._selectModel == ZooController.Once then
		local lastSelId = self._selectId[1]

		self._selectId[1] = self._selectId[1] ~= id and id or nil

		if self._lastSelectCell then
			local data = self._useList[self._lastSelectCell.index + 1]

			if data.id == lastSelId then
				self:_checkSelected(self._lastSelectCell, data)
			end
		end

		self._lastSelectCell = cell

		local data = self._useList[self._lastSelectCell.index + 1]

		self:_checkSelected(self._lastSelectCell, data)
	elseif self._selectModel == ZooController.Plural then
		local flag = false

		for i, v in ipairs(self._selectId) do
			if v == id then
				flag = i

				break
			end
		end

		if flag then
			table.remove(self._selectId, flag)
		elseif #self._selectId < self._maxNum then
			table.insert(self._selectId, id)
		end

		self._tableview:getView():Refresh()
	end
end

function ZooselectView:_onConfirm()
	if #self._selectId > 0 then
		self._selectCallBack(self._selectId)
	end

	self:close()
end

function ZooselectView:_onCancel()
	self:close()
end

function ZooselectView:_onValueChange(value)
	if value == 0 then
		self._sortType = 0
	elseif value == 1 then
		self._sortType = 1
	end

	self:_refreshList()
end

function ZooselectView:_onClickSearch()
	local result, name = {}, self._searchInput:GetText()

	for index, value in ipairs(self._list) do
		if name == nil or name == "" or string.find(value.name, name) then
			table.insert(result, value)
		end
	end

	self._useList = result

	self:_refreshList()
end

function ZooselectView:_onZooGetAnimalsInfo()
	self:_onGetMyZooInfo()
end

function ZooselectView:_onGetMyZooInfo()
	self:_initParams()

	self._useList = table.values(self._list)

	self:_refreshList()
end

return ZooselectView
