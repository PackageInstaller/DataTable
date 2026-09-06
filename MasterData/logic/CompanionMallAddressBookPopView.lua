-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/companionmall/view/CompanionMallAddressBookPopView.lua

module("logic.extensions.companionmall.view.CompanionMallAddressBookPopView", package.seeall)

local CompanionMallAddressBookPopView = class("CompanionMallAddressBookPopView", ViewComponent)
local ADD_NEW_ADDRESS = 1
local CHANGE_ADDRESS = 2

function CompanionMallAddressBookPopView:ctor()
	CompanionMallAddressBookPopView.super.ctor(self)
end

function CompanionMallAddressBookPopView:unbindEvents()
	CompanionMallAddressBookPopView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnAddAddress)
	GameUtil.rmClickHandler(self._btnClose)
end

function CompanionMallAddressBookPopView:bindEvents()
	CompanionMallAddressBookPopView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnAddAddress, self._onClickBtnAddAddress, self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function CompanionMallAddressBookPopView:buildUI()
	CompanionMallAddressBookPopView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnAddAddress = self:getGo("noAddress/btnAddAddress")
	self._address = self:getGo("address")
	self._noAddress = self:getGo("noAddress")
	self._writeAddress = self:getGo("writeAddress")
	self._txtAddressNum = self:getTxt("address/txtAddressNum")
	self._cellList = {}

	for i = 1, 3 do
		local tablecell = self:getGo("address/addressGroup/Viewport/Content/tablecell" .. i)

		table.insert(self._cellList, tablecell)
	end

	self._btnSure = self:getGo("writeAddress/btnSure")
end

function CompanionMallAddressBookPopView:onExit()
	CompanionMallAddressBookPopView.super.onExit(self)

	self._selectIdx = nil

	for idx, cellGo in ipairs(self._cellList) do
		local btnReWrite = goutil.findChild(cellGo, "address/btnReWrite")
		local btnDelete = goutil.findChild(cellGo, "address/btnDelete")
		local btnSelect = goutil.findChild(cellGo, "address/btnSelect")
		local btnAdd = goutil.findChild(cellGo, "btnAdd")

		GameUtil.rmClickHandler(btnReWrite)
		GameUtil.rmClickHandler(btnDelete)
		GameUtil.rmClickHandler(btnSelect)
		GameUtil.rmClickHandler(btnAdd)
	end
end

function CompanionMallAddressBookPopView:onEnter()
	CompanionMallAddressBookPopView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.COMPANION_MALL_GET_INFO, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.COMPANION_MALL_ADRESS_INFO, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.PM_CompanionMallDeleteAddressRes, self._onDeleteAddressRes, self)

	local params = self:getOpenParam() or {}
	local activityId = checknumber(params[1])

	self._activityId = activityId == 0 and CompanionMallController.instance:getDefaultActId() or activityId
	self._companionId = checknumber(params[2])
	self._companionIdList = CompanionMallModel.instance:getCurBatchCompanionIdList(self._activityId, self._companionId)
	self._writeAddressType = ADD_NEW_ADDRESS
	self._selectAddressIdx = 0
	self._provinceCfgs = CompanionMallConfig.instance:getProvinceCfgs()
	self._cityDic = CompanionMallConfig.instance:getCityDic()
	self._districtDic = CompanionMallConfig.instance:getDistrictDic()

	self:_initBookCellUI()
	CompanionMallController.instance:sendGetInfo(self._activityId)
	CompanionMallController.instance:sendGetAddressInfo(self._activityId)
end

function CompanionMallAddressBookPopView:_initBookCellUI()
	for i, cellGo in ipairs(self._cellList) do
		local btnAdd = goutil.findChild(cellGo, "btnAdd")
		local address = goutil.findChild(cellGo, "address")
		local select = goutil.findChild(cellGo, "address/select")

		GameUtil.addClickHandler(btnAdd, self._onClickBtnAddAddress, self)
		GameUtil.SetActive(btnAdd, true)
		GameUtil.SetActive(address, false)
		GameUtil.SetActive(select, false)
	end
end

function CompanionMallAddressBookPopView:_onUpdate()
	self:_initBookCellUI()

	self._hasGainCompanion = false
	self._hasAddress = false

	local actInfo = CompanionMallModel.instance:getInfo(self._activityId) or {}

	if not actInfo.companionInfo then
		local companionInfoList = {}

		self._hasComMap = {}
		self._hasFinishMap = {}

		for i, v in ipairs(companionInfoList) do
			if v.hasGainCompanion then
				self._hasGainCompanion = true

				break
			end
		end

		local infos = CompanionMallModel.instance:getAddressInfo(self._activityId)
		local cellUpdateIdx = 1

		if infos then
			for addressId, info in pairs(infos) do
				local addressId = info.addressId
				local addressBookInfo = CompanionMallModel.instance:getAddressBookInfoById(addressId)
				local cellGo = self._cellList[cellUpdateIdx]
				local address = goutil.findChild(cellGo, "address")
				local btnAdd = goutil.findChild(cellGo, "btnAdd")

				if addressBookInfo then
					local select = goutil.findChild(cellGo, "address/select")
					local btnReWrite = goutil.findChild(cellGo, "address/btnReWrite")
					local btnDelete = goutil.findChild(cellGo, "address/btnDelete")
					local btnSelect = goutil.findChild(cellGo, "address/btnSelect")
					local txtAddressNum = goutil.findChildTextComponent(cellGo, "address/txtAddressNum")
					local txtName = goutil.findChildTextComponent(cellGo, "address/txtName")
					local txtPhone = goutil.findChildTextComponent(cellGo, "address/txtPhone")
					local txtAddress = goutil.findChildTextComponent(cellGo, "address/txtAddress")

					if self._selectIdx == nil then
						local curSelectAddressId = CompanionMallController.instance:getAddressIdByCompanionId(self._activityId, self._companionId)

						GameUtil.SetActive(select, curSelectAddressId == addressId)
					else
						GameUtil.SetActive(select, self._selectIdx == cellUpdateIdx)
					end

					txtName.text = addressBookInfo.recipientName
					txtPhone.text = addressBookInfo.phoneNumber
					txtAddress.text = addressBookInfo.address
					txtAddressNum.text = string.format("地址%d", cellUpdateIdx)

					GameUtil.addClickHandler(btnReWrite, GameUtil.handler(self._onClickBtnReWrite, self, addressId))
					GameUtil.addClickHandler(btnDelete, GameUtil.handler(self._onClickBtnDelete, self, addressId))
					GameUtil.addClickHandler(btnSelect, GameUtil.handler(self._onClickBtnSelect, self, cellUpdateIdx, addressId))

					cellUpdateIdx = cellUpdateIdx + 1
					self._hasAddress = true
				end

				GameUtil.SetActive(address, addressBookInfo ~= nil)
				GameUtil.SetActive(btnAdd, addressBookInfo == nil)
			end
		end

		self._txtAddressNum.text = string.format("地址上限:%d/3", cellUpdateIdx - 1)
		self._writeAddressType = not self._hasAddress and ADD_NEW_ADDRESS or CHANGE_ADDRESS

		GameUtil.SetActive(self._noAddress, not self._hasAddress)
		GameUtil.SetActive(self._address, self._hasAddress)
		GameUtil.SetActive(self._writeAddress, false)
	end
end

function CompanionMallAddressBookPopView:_onProvinceScrCustomInputCallback(hover)
	if not hover then
		GameUtil.SetActive(self._tableviewProvince, false)
		GameUtil.SetActive(self._imgArrowProvince, true)
	end
end

function CompanionMallAddressBookPopView:_onCityScrCustomInputCallback(hover)
	if not hover then
		GameUtil.SetActive(self._tableviewCity, false)
		GameUtil.SetActive(self._imgArrowCity, true)
	end
end

function CompanionMallAddressBookPopView:_onDistrictScrCustomInputCallback(hover)
	if not hover then
		GameUtil.SetActive(self._tableviewDistrict, false)
		GameUtil.SetActive(self._imgArrowDistrict, true)
	end
end

function CompanionMallAddressBookPopView:_onClickBtnAddAddress()
	local isReWrite = false

	if not self._hasGainCompanion then
		FloatWordMgr.instance:show("在本活动成功获得周边后可填写地址")

		return
	end

	UIStateManager.instance:push(ViewName.CompanionmalladdressView, self._activityId, -1, isReWrite, self._companionId)
end

function CompanionMallAddressBookPopView:_onClickBtnReWrite(addressId)
	local isReWrite = false

	UIStateManager.instance:push(ViewName.CompanionmalladdressView, self._activityId, addressId, isReWrite, self._companionId)
end

function CompanionMallAddressBookPopView:_onClickBtnDelete(addressId)
	local isReWrite = true
	local isUsingAddress = CompanionMallModel.instance:isUsingAddress(self._activityId, addressId)
	local contentStr = "地址删除后无法找回，需重新填写\n是否确认删除本地址？"

	if isUsingAddress then
		local actInfo = CompanionMallModel.instance:getInfo(self._activityId) or {}

		if not actInfo.companionInfo then
			local companionInfos = {}
			local nameStr = ""

			for i, companionInfo in ipairs(companionInfos) do
				if companionInfo.addressId == addressId then
					local companionId = companionInfo.companionId
					local itemCfg = CompanionMallConfig.instance:getItemCfgById(self._activityId, companionId)
					local companionName = string.format("【%s】 ", itemCfg.name)

					nameStr = nameStr .. companionName
				end
			end

			contentStr = string.format("当前地址已用于%s中\n删除后这些周边关联的地址将清空，需重新选择地址\n是否确认删除本地址？", nameStr)
		end
	else
		contentStr = "地址删除后无法找回，需重新填写\n是否确认删除本地址？"
	end

	local function okFunc()
		self._selectIdx = nil

		CompanionMallController.instance:sendPM_CompanionMallDeleteAddressReq(self._activityId, addressId, isReWrite)
	end

	TipsFacade.instance:openPopupWindow("提示", contentStr, okFunc, nil, "确定", "取消")
end

function CompanionMallAddressBookPopView:_onClickBtnSelect(cellUpdateIdx, addressId)
	for idx, cellGo in ipairs(self._cellList) do
		local selelct = goutil.findChild(cellGo, "address/select")

		GameUtil.SetActive(selelct, cellUpdateIdx == idx)
	end

	self._selectIdx = cellUpdateIdx

	CompanionMallController.instance:sendPM_CompanionMallSelectAddressReq(self._activityId, self._companionIdList, addressId)
end

function CompanionMallAddressBookPopView:_onDeleteAddressRes()
	self._selectIdx = nil

	self:_onUpdate()
end

return CompanionMallAddressBookPopView
