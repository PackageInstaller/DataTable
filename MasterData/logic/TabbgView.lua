-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tabbg/view/TabbgView.lua

module("logic.extensions.tabbg.view.TabbgView", package.seeall)

local TabbgView = class("TabbgView", TableViewComponent)

TabbgView.goldBarConComp = 1
TabbgView.tableViewComp = 2
TabbgView.topLeftComp = 3

function TabbgView:ctor()
	TabbgView.super.ctor(self)
end

function TabbgView:buildUI()
	TabbgView.super.buildUI(self)

	self._topleft = self:getGo("topleft")
	self._btnClose = self:getBtn("topleft/btnClose")
	self._txtTitle = self:getGo("topleft/txtTitle"):GetComponent("Text")
	self._goldBarCon = self:getGo("goldBarCon")
	self._coinCon = self:getGo("goldBarCon/coinCon")
	self._imgCoin = self:getGo("goldBarCon/coinCon/imgCoin")
	self._btnCoinAdd = self:getBtn("goldBarCon/coinCon/btnCoinAdd")
	self._txtCoin = self:getGo("goldBarCon/coinCon/txtCoin"):GetComponent("Text")
	self._diamondCon = self:getGo("goldBarCon/diamondCon")
	self._imgDiamond = self:getGo("goldBarCon/diamondCon/imgDiamond")
	self._btnDiamondAdd = self:getBtn("goldBarCon/diamondCon/btnDiamondAdd")
	self._txtDiamond = self:getGo("goldBarCon/diamondCon/txtDiamond"):GetComponent("Text")
	self._diamondLockedCon = self:getGo("goldBarCon/diamondLockedCon")
	self._imgDiamondLocked = self:getGo("goldBarCon/diamondLockedCon/imgDiamondLocked")
	self._btnDiamondLockedAdd = self:getBtn("goldBarCon/diamondLockedCon/btnDiamondLockedAdd")
	self._txtDiamondLocked = self:getGo("goldBarCon/diamondLockedCon/txtDiamondLocked"):GetComponent("Text")
	self._tableViewComp = self:getGo("tableview")
end

function TabbgView:bindEvents()
	TabbgView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickBtnClose, self)
	self._btnCoinAdd:AddClickListener(self._onClickBtnCoinAdd, self)
	self._btnDiamondAdd:AddClickListener(self._onClickBtnDiamondAdd, self)
	self._btnDiamondLockedAdd:AddClickListener(self._onClickBtnDiamondLockedAdd, self)
end

function TabbgView:unbindEvents()
	TabbgView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnCoinAdd:RemoveClickListener()
	self._btnDiamondAdd:RemoveClickListener()
	self._btnDiamondLockedAdd:RemoveClickListener()
end

function TabbgView:destroyUI()
	TabbgView.super.destroyUI(self)
end

function TabbgView:onEnter()
	TabbgView.super.onEnter(self)

	self._viewConfig = TabbgController.instance:getViewConfig()
	self._curTabIndex = 1
	self._imgSelected = {}
	self._imgRedPoint = {}
	self._presentorRecord = {}

	self:_initResMatConfig()
	GlobalDispatcher:addListener(GlobalNotify.OnMaterialCountChange, self._onMatCountChange, self)
	GlobalDispatcher:addListener(GlobalNotify.UpdataTiliCount, self._onMatCountChange, self)
	self:_onMatCountChange()
	self:_updateSvData()
	self:_updateTxtTitle(self._viewConfig.tabViewName)
	self:_openFirstView()

	self._updateRedPointCurIndex = 1
	self._updateRedPointAllTime = 2

	settimer(self._updateRedPointAllTime / #self._viewConfig.tabInfo, self._updateRedPoint, self)

	if self._viewConfig.tabOpenCallBack then
		self._viewConfig.tabOpenCallBack()
	end
end

function TabbgView:_openFirstView()
	self._presentorRecord[self._curTabIndex] = ViewMgr.instance:open(self._curViewDatas[self._curTabIndex].view)
end

function TabbgView:onEnterFinished()
	TabbgView.super.onEnterFinished(self)
end

function TabbgView:onExit()
	TabbgView.super.onExit(self)
	removetimer(self._updateRedPoint, self)

	self._updateRedPointCurIndex = nil

	GlobalDispatcher:removeListener(GlobalNotify.OnMaterialCountChange, self._onMatCountChange, self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdataTiliCount, self._onMatCountChange, self)

	if self._presentorRecord then
		for dataId, presentor in pairs(self._presentorRecord) do
			ViewMgr.instance:close(presentor.viewName)

			self._presentorRecord[dataId] = nil
		end
	end

	self._presentorRecord = nil
	self._curViewDatas = nil
	self._curTabIndex = nil
	self._imgSelected = nil
	self._imgRedPoint = nil

	self:_clearTabViewConfig()
end

function TabbgView:onExitFinished()
	TabbgView.super.onExitFinished(self)
end

function TabbgView:_onClickBtnClose()
	self:close()
end

function TabbgView:setActiveComp(_type, show)
	if _type == TabbgView.goldBarConComp then
		if self._goldBarCon then
			self._goldBarCon:SetActive(show)
		end
	elseif _type == TabbgView.tableViewComp then
		if self._tableViewComp then
			self._tableViewComp:SetActive(show)
		end
	elseif _type == TabbgView.topLeftComp and self._topleft then
		self._topleft:SetActive(show)
	end
end

function TabbgView:_onClickBtnCoinAdd()
	FloatWordMgr.instance:show(ConstString.NotRelease)
end

function TabbgView:_onClickBtnDiamondAdd()
	FloatWordMgr.instance:show(ConstString.NotRelease)
	SurveyController.instance:reportBehavior(SurveyBehaviorID.ClickDiamondChargeButton)
end

function TabbgView:_onClickBtnDiamondLockedAdd()
	FuncOpenController.instance:openFunc(57)
end

function TabbgView:_initResMatConfig()
	self.resMatConfig = {
		{
			id = 1,
			matType = MatType.Coin
		},
		{
			id = 2,
			matType = MatType.Diamond
		},
		{
			id = 1,
			matType = MatType.Strength
		}
	}
end

function TabbgView:_onMatCountChange()
	local matMo = self.resMatConfig[1]

	self._txtCoin.text = MaterialModel.instance:getMaterialsNumber(matMo.matType, matMo.id)
	matMo = self.resMatConfig[2]
	self._txtDiamond.text = MaterialModel.instance:getMaterialsNumber(self.resMatConfig[2].matType, self.resMatConfig[2].id)
	matMo = self.resMatConfig[3]
	self._txtDiamondLocked.text = MaterialModel.instance:getMaterialsNumber(self.resMatConfig[3].matType, self.resMatConfig[3].id)
end

function TabbgView:_updateSvData()
	self._curViewDatas = {}

	for i = 1, #self._viewConfig.tabInfo do
		table.insert(self._curViewDatas, {
			id = i,
			view = self._viewConfig.tabInfo[i].view,
			name = self._viewConfig.tabInfo[i].name
		})
	end

	self._tableview:ReloadData()
end

function TabbgView:_getPath()
	return {
		cellPath = "tablecell",
		viewPath = "tableview"
	}
end

function TabbgView:_cellSize()
	return 210, 80
end

function TabbgView:SetColorTag(record_value, limit_value)
	if not record_value or not limit_value then
		return
	end

	return (record_value and limit_value < record_value or nil) and Color.red
end

function TabbgView:_updateCell(view, cell, data)
	Framework.ButtonAdapter.GetFrom(cell.gameObject, "rootCell"):AddClickListener(function()
		if self._curTabIndex == data.id then
			return
		end

		if self._presentorRecord and self._presentorRecord[self._curTabIndex] then
			self._presentorRecord[self._curTabIndex]:hideSelf()

			if self._viewConfig.tabInfo[self._curTabIndex].hideCallBack then
				self._viewConfig.tabInfo[self._curTabIndex].hideCallBack()
			end
		end

		self._curTabIndex = data.id

		self:_updateImgSelected()

		if not self._presentorRecord[data.id] then
			self._presentorRecord[data.id] = ViewMgr.instance:open(data.view)
		else
			self._presentorRecord[data.id]:showSelf()
		end

		if self._viewConfig.tabInfo[self._curTabIndex].showCallBack then
			self._viewConfig.tabInfo[self._curTabIndex].showCallBack()
		end
	end, self)

	local imgSelected = goutil.findChildComponent(cell.gameObject, "rootCell/imgSelected", "Image")

	self._imgSelected[data.id] = imgSelected

	if self._curTabIndex == data.id then
		imgSelected.gameObject:SetActive(true)
	else
		imgSelected.gameObject:SetActive(false)
	end

	local imgRedPoint = goutil.findChildComponent(cell.gameObject, "rootCell/imgRedPoint", "Image")

	self._imgRedPoint[data.id] = imgRedPoint

	if self._viewConfig.tabInfo[data.id].redPointCheck then
		imgRedPoint.gameObject:SetActive(self._viewConfig.tabInfo[data.id].redPointCheck())
	else
		imgRedPoint.gameObject:SetActive(false)
	end

	local txtName = goutil.findChildComponent(cell.gameObject, "rootCell/txtName", "Text")

	txtName.text = data.name
end

function TabbgView:_updateImgSelected()
	if not self._curTabIndex then
		return
	end

	for i = 1, #self._curViewDatas do
		if self._curTabIndex == self._curViewDatas[i].id then
			self._imgSelected[self._curViewDatas[i].id].gameObject:SetActive(true)
		else
			self._imgSelected[self._curViewDatas[i].id].gameObject:SetActive(false)
		end
	end
end

function TabbgView:_updateRedPoint()
	if not self._imgRedPoint or not self._updateRedPointCurIndex or not self._viewConfig.tabInfo then
		return
	end

	if self._viewConfig.tabInfo[self._updateRedPointCurIndex] and self._viewConfig.tabInfo[self._updateRedPointCurIndex].redPointCheck then
		self._imgRedPoint[self._updateRedPointCurIndex].gameObject:SetActive(self._viewConfig.tabInfo[self._updateRedPointCurIndex].redPointCheck())
	else
		self._imgRedPoint[self._updateRedPointCurIndex].gameObject:SetActive(false)
	end

	self._updateRedPointCurIndex = self._updateRedPointCurIndex + 1

	if self._updateRedPointCurIndex > #self._viewConfig.tabInfo then
		self._updateRedPointCurIndex = 1
	end
end

function TabbgView:setUpdateRedPointAllTime(update_redpoint_alltime)
	if not self._viewConfig or not self._viewConfig.tabInfo then
		return
	end

	self._updateRedPointAllTime = update_redpoint_alltime

	removetimer(self._updateRedPoint, self)
	settimer(self._updateRedPointAllTime / #self._viewConfig.tabInfo, self._updateRedPoint, self)
end

function TabbgView:_updateTxtTitle(title)
	self._txtTitle.text = title
end

function TabbgView:_clearTabViewConfig()
	for i = 1, #self._viewConfig.tabInfo do
		if self._viewConfig.tabInfo[i].closeCallBack then
			self._viewConfig.tabInfo[i].closeCallBack()
		end
	end

	if self._viewConfig.tabCloseCallBack then
		self._viewConfig.tabCloseCallBack()
	end

	self._viewConfig = nil
end

return TabbgView
