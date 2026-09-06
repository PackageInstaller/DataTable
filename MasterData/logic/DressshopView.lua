-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dress/view/DressshopView.lua

module("logic.extensions.dress.view.DressshopView", package.seeall)

local DressshopView = class("DressshopView", ViewComponent)
local Gender = {
	[0] = "Girl",
	"Boy"
}
local GoodsTypes = {
	Suit = 1,
	Single = 2
}
local SortTypes = {
	"默认排序",
	"价格递增",
	"价格递减"
}
local OwnTypes = {
	"永久",
	"限时",
	"未拥有"
}

function DressshopView:_getPath()
	return {
		cellPath = "right/CellDress",
		viewPath = "right/ScrollView"
	}
end

function DressshopView:buildUI()
	DressshopView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnHelp = self:getBtn("btnHelp")
	self._btnTakeOff = self:getBtn("btnTakeOff")
	self._btnOneKey = self:getBtn("btnOneKey")
	self._modelCam = self:getGo("modelCam")
	self._modelBG = goutil.findChild(self._modelCam, "bg")
	self._middleBG = goutil.findChild(self._modelCam, "middleBg")
	self._rolePoint = self:getGo("modelCam/rolePoint")
	self._goldBarCon = self:getGo("goldBarCon")
	self._drag = Framework.UIDragTrigger.Get(self:getGo("middle/drag"))
	self._btnRRight = self:getBtn("middle/btnRRight")
	self._btnRLeft = self:getBtn("middle/btnRLeft")
	self._goEmpty = self:getGo("right/empty")
	self._goSlogan = self:getGo("slogan_yrzx")

	self:_initDataList()
	self:buildUIAboutGender()
	self:buildUIAboutOtherFilters()
	self:buildUIAboutLeftTabs()
	self:buildUIAvoutSort()
	self:_buildRoleAvatar()

	self._selectDatas = {}
	self._CellDress = self:getGo("right/CellDress")
	self._ScrollView = self:getGo("right/ScrollView")
	self._scrollList = ScrollerList.create(self._ScrollView, self._CellDress, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearTableview, self))
end

function DressshopView:buildUIAboutGender()
	self._genderUIs = {}

	for k, v in pairs(Gender) do
		local cell = {}

		cell.btn = self:getBtn("gender/btn" .. v)
		cell.lock = goutil.findChild(cell.btn.gameObject, "imglock")
		cell.select = goutil.findChild(cell.btn.gameObject, "imgSelect")
		self._genderUIs[k] = cell
	end
end

function DressshopView:buildUIAboutOtherFilters()
	self._otherFilters = {}

	for k, v in pairs(OwnTypes) do
		local cell = {}

		cell.tog = self:getToggle("right/fiters/tog" .. k)
		cell.id = k
		cell.mark = goutil.findChild(cell.tog.gameObject, "Background/mark")
		cell.txt = goutil.findChildTextComponent(cell.tog.gameObject, "Label")
		cell.txt.text = lang(v)
		self._otherFilters[k] = cell
	end
end

function DressshopView:buildUIAboutLeftTabs()
	local btnTab = self:getGo("SVLeftTabs/Viewport/Content/btnTab")
	local parent = self:getGo("SVLeftTabs/Viewport/Content")
	local temTab

	self._leftTabs = {}

	for k, v in pairs(self._leftTagDataList) do
		local copytab = {}
		local go = goutil.clone(btnTab)

		copytab.go = go

		goutil.setActive(go, true)

		copytab.redPoint = goutil.findChild(go, "redPoint")

		goutil.setActive(copytab.redPoint, false)

		copytab.txt = goutil.findChildTextComponent(go, "txt")
		copytab.btn = Framework.ButtonAdapter.Get(go)
		copytab.changes = go:GetComponent("UIChangeGroup")
		copytab.data = v
		copytab.txt.text = v.tabShow

		goutil.addChildToParent(copytab.go, parent)

		self._leftTabs[copytab.data._showType] = copytab
	end

	goutil.setActive(btnTab, false)
end

function DressshopView:buildUIAvoutSort()
	self._btnChangeSort = self:getBtn("right/btnChangeSort")
	self._sortTypes = self:getGo("right/btnChangeSort/sortTypes")
	self._showSortTxt = self:getTxt("right/btnChangeSort/Text")
	self._useSorts = self._useSorts or {}

	for k, v in pairs(SortTypes) do
		local useSort = {}

		useSort.id = k
		useSort.btn = self:getBtn("right/btnChangeSort/sortTypes/btn" .. k)
		self._useSorts[k] = useSort
	end
end

function DressshopView:bindEvents()
	DressshopView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnHelp:AddClickListener(self._onClickBtnHelp, self)
	self._btnChangeSort:AddClickListener(self._switchSortsActive, self)
	self._btnTakeOff:AddClickListener(self._onClickBtnTakeOff, self)
	self._btnOneKey:AddClickListener(self._onClickOneKey, self)
	self._drag:AddDragListener(self._onDrag, self)
	self._btnRLeft:AddClickListener(function()
		self:_onClickBtnR(true)
	end, self)
	self._btnRRight:AddClickListener(function()
		self:_onClickBtnR(false)
	end, self)

	for g, v in pairs(self._genderUIs) do
		v.btn:AddClickListener(function()
			self:_onClickGender(g)
		end, self)
	end

	for k, v in pairs(self._otherFilters) do
		v.tog:AddOnValueChanged(function()
			self:_onFilterValueChanged(v.tog.isOn, v.id)
		end, self)
	end

	for k, v in pairs(self._leftTabs) do
		v.btn:AddClickListener(function()
			self:_switchTabs(v)
		end, self)
	end

	for k, v in pairs(self._useSorts) do
		v.btn:AddClickListener(function()
			self:_onChangeSort(k)
		end, self)
	end
end

function DressshopView:unbindEvents()
	DressshopView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnHelp:RemoveClickListener()
	self._btnTakeOff:RemoveClickListener()
	self._btnChangeSort:RemoveClickListener()
	self._drag:RemoveDragListener()
	self._btnRLeft:RemoveClickListener()
	self._btnRRight:RemoveClickListener()
	self._btnOneKey:RemoveClickListener()

	for g, v in pairs(self._genderUIs) do
		v.btn:RemoveClickListener()
	end

	for k, v in pairs(self._otherFilters) do
		v.tog:RemoveOnValueChanged()
	end

	for k, v in pairs(self._leftTabs) do
		v.btn:RemoveClickListener()
	end

	for k, v in pairs(self._useSorts) do
		v.btn:RemoveClickListener()
	end
end

function DressshopView:destroyUI()
	DressshopView.super.destroyUI(self)
	self:_resetRoleAvatar()
end

function DressshopView:onEnter()
	DressshopView.super.onEnter(self)

	local params = self:getOpenParam()

	self._openRoot = GoodsTypes.Single
	self._openLeaf = 0
	self._selectClothId = 0

	if params then
		self._openRoot = checknumber(params[1])
		self._openLeaf = checknumber(params[2])
		self._selectClothId = checknumber(params[3])
	end

	for _, v in pairs(self._leftTabs) do
		goutil.setActive(v.redpoint, false)
	end

	self:_updateRedPoint()
	self:_initUIValue()
	GlobalModel.instance:visibleSceneHUDs(false)
	LightMgr.instance:setLightParam(LightMgr.LightType.UILight)
	goutil.addChildToParent(self._modelCam)

	local btnList = {
		{
			showAdd = true,
			id = GameEnum.GoldType.DressCoin
		},
		{
			showAdd = true,
			id = GameEnum.GoldType.Diamond
		},
		{
			showAdd = true,
			id = GameEnum.GoldType.GodDiamondCoin
		}
	}

	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, btnList)

	self.avatarMo = DressModel.instance:getAvatarMoWithDefaultSuit(RoleModel.instance:getGender())

	if DressModel.instance:getIsInitData() then
		self:_firstUpdateView()
	else
		DressController.instance:sendGetNotoutInfoReq(self._firstUpdateView, self)
	end

	GlobalDispatcher:addListener(GlobalNotify.UpdateDressInfo, self.updateView, self)
	GlobalDispatcher:addListener(GlobalNotify.NotifyPayShopItemBuySucRes, self.updateView, self)
	GlobalDispatcher:addListener(PayShopController.BuyItemRes, self.updateView, self)

	self._selectDatas = {}
end

function DressshopView:onEnterFinished()
	DressshopView.super.onEnterFinished(self)
	self:updateAvatar()
end

function DressshopView:onExit()
	DressshopView.super.onExit(self)
	goutil.addChildToParent(self._modelCam, self.mainGO)
	GlobalModel.instance:visibleSceneHUDs(true)
	LightMgr.instance:setLightForNormalScene()
	GlobalDispatcher:removeListener(GlobalNotify.UpdateDressInfo, self.updateView, self)
	GlobalDispatcher:removeListener(GlobalNotify.NotifyPayShopItemBuySucRes, self.updateView, self)
	GlobalDispatcher:removeListener(PayShopController.BuyItemRes, self.updateView, self)
	DressController.instance:saveRedPointKeyValue()

	self._selectDatas = {}

	self._scrollList:dispose()
end

function DressshopView:_initUIValue()
	for k, v in ipairs(self._leftTabs) do
		if v.data.rootTab == self._openRoot and v.data.leftTab == self._openLeaf then
			self:_switchTabs(v)

			break
		end
	end

	self:_onChangeSort(1)

	self._userGender = RoleModel.instance:getGender()

	for g, v in pairs(self._genderUIs) do
		goutil.setActive(v.lock, g ~= self._userGender)
		goutil.setActive(v.select, g == self._userGender)
	end

	for k, v in ipairs(self._otherFilters) do
		v.tog.isOn = true
	end
end

function DressshopView:_onClickClose()
	self:close()
end

function DressshopView:_onClickBtnHelp()
	goutil.setActive(self._sortTypes, false)
	ViewMgr.instance:open(ViewName.RulesView, "dressshop")
end

function DressshopView:_switchTabs(tab)
	goutil.setActive(tab.redPoint, false)

	if self._curSelectTag == tab then
		return
	end

	for _, v in pairs(self._leftTabs) do
		if v ~= tab then
			v.changes:SetState(0)
		else
			v.changes:SetState(1)
		end
	end

	if self._curSelectTag and (tab.data._isAdd ~= self._curSelectTag.data._isAdd or tab.data.rootTab and self._curSelectTag.data.rootTab ~= tab.data.rootTab) then
		if self.avatarMo then
			self.avatarMo:resetUIState()
			self.avatarMo:setDefaultState()
			self:updateAvatar()
		end

		self._selectDatas = {}
	end

	self._curSelectTag = tab

	goutil.setActive(self._btnOneKey.gameObject, not self._curSelectTag.data._isAdd)
	goutil.setActive(self._goSlogan, self._curSelectTag.data._isAdd)

	self.curSelectData = nil

	self:updateView()
end

function DressshopView:_onClickGender(g)
	if g ~= self._userGender then
		FloatWordMgr.instance:show(lang("当前还不支持切换性别喔"))
	end
end

function DressshopView:_onFilterValueChanged(isOn, id)
	goutil.setActive(self._otherFilters[id].mark, isOn)
	self:updateView()
end

function DressshopView:_onChangeSort(sortId)
	goutil.setActive(self._sortTypes, false)

	self._showSortTxt.text = SortTypes[sortId]
	self._useSortType = sortId

	self:updateView()
end

function DressshopView:_switchSortsActive()
	local isActive = self._sortTypes.activeSelf

	goutil.setActive(self._sortTypes, not isActive)
end

function DressshopView:_onClickBtnTakeOff()
	goutil.setActive(self._sortTypes, false)

	if self._avatar and self.avatarMo then
		self.avatarMo:resetUIState()
		self.avatarMo:setDefaultState()
		self._avatar:updateByMo(self.avatarMo)

		self._selectDatas = {}

		self:reloadData()
	end
end

function DressshopView:_onClickOneKey()
	local datalist = {}
	local payDatalist = {}

	for k, v in pairs(self._selectDatas) do
		if v:getIsAbleToOneKeyBuy() then
			table.insert(datalist, v)
		end

		if v:getIsAbleToBuy() then
			table.insert(payDatalist, v)
		end
	end

	local num = table.nums(datalist)

	if num == 0 then
		if #payDatalist == 1 then
			self:tryToBuyDress(payDatalist[1])
		else
			FloatWordMgr.instance:show(langPara("当前穿戴的服装不支持批量购买"))
		end
	elseif num == 1 then
		self:tryToBuyDress(datalist[1])
	else
		UIStateManager.instance:push(ViewName.DressbatchsellView, datalist)
	end
end

function DressshopView:_onDrag(eventData)
	local avatarGo = self._avatar and self._avatar:getGameObject() or nil

	if avatarGo then
		local localRotation = Quaternion.Euler(0, -0.5 * eventData.delta.x * 1, 0) * avatarGo.transform.localRotation
		local eulerAngles = localRotation.eulerAngles

		Framework.TransformUtil.SetLocalRotation(avatarGo.transform, 0, eulerAngles.y, 0)
	end
end

function DressshopView:_onClickBtnR(isLeft)
	local avatarGo = self._avatar and self._avatar:getGameObject() or nil

	if avatarGo then
		local localRotation = avatarGo.transform.localRotation
		local addAngle = isLeft and 30 or -30
		local eulerAngles = localRotation.eulerAngles

		Framework.TransformUtil.SetLocalRotation(avatarGo.transform, 0, eulerAngles.y + addAngle, 0)
	end
end

function DressshopView:_getFilters()
	local filterParas = {}

	for k, v in ipairs(self._otherFilters) do
		if v.tog.isOn then
			table.insert(filterParas, v.id)
		end
	end

	return filterParas
end

function DressshopView:_buildRoleAvatar()
	if not self._avatar then
		self._avatar = AvatarsMgrNew.instance:getAvatarByType(AvatarCreateType.Player)

		self._avatar:setParent(self._rolePoint.transform)
		self._avatar:setLayer(SceneLayer.UI3D_Value)
	end
end

function DressshopView:_resetRoleAvatar()
	if self._avatar then
		AvatarsMgrNew.instance:removeAvatar(self._avatar)

		self._avatar = nil
	end
end

function DressshopView:updateAvatar()
	if self._avatar and self.avatarMo then
		self._avatar:updateByMo(self.avatarMo)
		self._avatar:updateExtBgParent(self._modelBG, self._middleBG, self)
	end
end

function DressshopView:_initDataList()
	local goodsCfgs = PayShopConfig.instance:getGoodsCfgsByShopType(GameEnum.PayShopShopType.DressShop) or {}

	self._dataListAll = {}

	local belongTags = {}

	for k, v in pairs(goodsCfgs) do
		for k1, v1 in pairs(v) do
			if v1.id then
				local data = DressShopData.New()

				data:initDataByCfg(v1)
				table.insert(self._dataListAll, data)

				for k, blTag in pairs(data.belongTags) do
					belongTags[blTag] = true
				end
			end
		end
	end

	self._leftTagDataList = {}

	local temDataList = {}
	local tabCfgs = DressConfig.instance:getAllTabCfgs()

	for k, v in pairs(tabCfgs.dataList) do
		v._isAdd = false
		v._showType = #temDataList + 1

		if v.rootTab == GoodsTypes.Single or v.rootTab == GoodsTypes.Suit then
			table.insert(temDataList, v)
		end
	end

	for k, v in pairs(belongTags) do
		if not temDataList[k] then
			local tagData = {
				_isAdd = true,
				_showType = k,
				tabShow = k
			}

			table.insert(self._leftTagDataList, tagData)
		end
	end

	table.insertto(self._leftTagDataList, temDataList)
end

function DressshopView:_updateRedPoint()
	local hasShow = GameUtil.getUserDayData(DressController.AddNewDressGoodItems) ~= nil

	if hasShow then
		return
	end

	local showRedPointTabs = {}

	for _, data in pairs(self._dataListAll) do
		if data.tag == lang("新") then
			for k, v in pairs(data.belongTags) do
				showRedPointTabs[v] = true
			end
		end
	end

	for k, v in pairs(showRedPointTabs) do
		goutil.setActive(self._leftTabs[k].redPoint, true)
	end
end

function DressshopView:_createDataList()
	local dataList = {}

	for k, data in pairs(self._dataListAll) do
		if table.keyof(data.belongTags, self._curSelectTag.data._showType) then
			table.insert(dataList, data)
		end
	end

	local dataListNext = {}

	for _, data in pairs(dataList) do
		if self._otherFilters[3].tog.isOn then
			if not data:getIsOwn() then
				if self._otherFilters[1].tog.isOn and not data:getIsTrialCard() then
					dataListNext[data] = true
				end

				if self._otherFilters[2].tog.isOn and data:getIsTrialCard() then
					dataListNext[data] = true
				end
			end
		elseif data:getIsOwn() then
			if self._otherFilters[1].tog.isOn and not data:getIsTrialCard() then
				dataListNext[data] = true
			end

			if self._otherFilters[2].tog.isOn and data:getIsTrialCard() then
				dataListNext[data] = true
			end
		end
	end

	return dataListNext
end

function DressshopView:_firstUpdateView()
	self:updateView()

	if self._selectClothId > 0 then
		for i, data in ipairs(self._curViewDatas) do
			if data.goodsCfg.id == self._selectClothId then
				self:selectDress(data)
				self._scrollList:MoveCellToCenter(i - 1)

				break
			end
		end

		self._selectClothId = 0
	end
end

function DressshopView:updateView()
	goutil.setActive(self._sortTypes, false)

	local curDatas = self:_createDataList()

	self._curViewDatas = {}

	for data, _ in pairs(curDatas) do
		if PayShopModel.instance:getPayShopGoodsCanBuyById(data.goodsCfg.id) then
			table.insert(self._curViewDatas, data)
		end
	end

	self:sortAndReloadData()
	goutil.setActive(self._goEmpty, #self._curViewDatas == 0)
end

function DressshopView:sortAndReloadData()
	if self._useSortType == 1 then
		table.sort(self._curViewDatas, function(a, b)
			return a.goodsCfg.id > b.goodsCfg.id
		end)
	elseif self._useSortType == 2 then
		local dataList = {
			{},
			{},
			{},
			{}
		}

		for _, data in ipairs(self._curViewDatas) do
			table.insert(dataList[data.costType], data)
		end

		self._curViewDatas = {}

		for _, tab in ipairs(dataList) do
			table.sort(tab, function(a, b)
				return a.costNum > b.costNum
			end)
			table.insertto(self._curViewDatas, tab)
		end
	elseif self._useSortType == 3 then
		local dataList = {
			{},
			{},
			{},
			{}
		}

		for _, data in ipairs(self._curViewDatas) do
			table.insert(dataList[data.costType], data)
		end

		self._curViewDatas = {}

		for _, tab in ipairs(dataList) do
			table.sort(tab, function(a, b)
				return a.costNum < b.costNum
			end)
			table.insertto(self._curViewDatas, tab)
		end
	end

	table.sort(self._curViewDatas, function(a, b)
		local indexA = table.keyof(DressConfig.ShopShowTags, a.tag)
		local indexB = table.keyof(DressConfig.ShopShowTags, b.tag)

		if indexA == 2 and indexB ~= 2 then
			return true
		else
			return false
		end
	end)
	self:reloadData()
end

function DressshopView:reloadData()
	self._scrollList:reloadData(self._curViewDatas)
end

function DressshopView:_updateCell(view, cell, data)
	local com = GameUtil.AddLuaOnce(cell.gameObject, DressCellItem)

	com:setData(self, data)
end

function DressshopView:_clearTableview(cell)
	return
end

function DressshopView:selectDress(selectData)
	goutil.setActive(self._sortTypes, false)

	self.curSelectData = selectData

	if selectData:getIsSuit() then
		self.avatarMo:resetUIState()

		if table.keyof(self._selectDatas, selectData) then
			self._selectDatas = {}
		else
			for k, dressId in ipairs(self.curSelectData.dressIds) do
				self.avatarMo:dressCloth(dressId)
			end

			self:addSelectGoodsData(self.curSelectData, true)
		end
	else
		local dressCfg = selectData:getFirstDressCfg()

		if table.keyof(self._selectDatas, selectData) then
			table.removebyvalue(self._selectDatas, selectData)
			self.avatarMo:undressCloth(dressCfg.id)

			self._selectDatas[selectData.goodsCfg.id] = nil
		else
			self.avatarMo:dressCloth(dressCfg.id)
			self:addSelectGoodsData(self.curSelectData)
		end
	end

	self.avatarMo:setDefaultState()
	self:updateAvatar()
	self:reloadData()
end

function DressshopView:addSelectGoodsData(data, isReset)
	if not data then
		return
	end

	if isReset then
		self._selectDatas = {}
	end

	if not data:getIsSuit() then
		local addDressCfg = data:getFirstDressCfg()

		for k, d in pairs(self._selectDatas) do
			local dressCfg = d:getFirstDressCfg()

			if not self.avatarMo:isdressById(dressCfg.id) then
				self._selectDatas[k] = nil
			elseif addDressCfg.id == dressCfg.id then
				self._selectDatas[k] = nil
			end
		end
	end

	self._selectDatas[data.goodsCfg.id] = data
end

function DressshopView:tryToBuyDress(buyData)
	if not buyData:getIsAbleToBuy() then
		FloatWordMgr.instance:show(langPara("当前商品不可购买"))

		return
	end

	goutil.setActive(self._sortTypes, false)

	if buyData.costType == 1 then
		PayShopController.instance:buyShopItem(buyData.goodsCfg.id)
	else
		UIStateManager.instance:push(ViewName.DressselltipView, buyData)
	end
end

return DressshopView
