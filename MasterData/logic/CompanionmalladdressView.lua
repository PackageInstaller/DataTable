-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/companionmall/view/CompanionmalladdressView.lua

module("logic.extensions.companionmall.view.CompanionmalladdressView", package.seeall)

local CompanionmalladdressView = class("CompanionmalladdressView", ViewComponent)
local PHONE_NUM_LENGTH = 11

function CompanionmalladdressView:ctor()
	CompanionmalladdressView.super.ctor(self)
end

function CompanionmalladdressView:unbindEvents()
	CompanionmalladdressView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.rmClickHandler(self._btnProvince)
	GameUtil.rmClickHandler(self._btnCity)
	GameUtil.rmClickHandler(self._btnDistrict)
	self._provinceScrCustomInput:RemoveListener()
	self._cityScrCustomInput:RemoveListener()
	self._districtScrCustomInput:RemoveListener()
end

function CompanionmalladdressView:bindEvents()
	CompanionmalladdressView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
	GameUtil.addClickHandler(self._btnProvince, self._onClickBtnProvince, self)
	GameUtil.addClickHandler(self._btnCity, self._onClickBtnCity, self)
	GameUtil.addClickHandler(self._btnDistrict, self._onClickBtnDistrict, self)
	self._provinceScrCustomInput:AddListener(self._onProvinceScrCustomInputCallback, self)
	self._cityScrCustomInput:AddListener(self._onCityScrCustomInputCallback, self)
	self._districtScrCustomInput:AddListener(self._onDistrictScrCustomInputCallback, self)
end

function CompanionmalladdressView:buildUI()
	CompanionmalladdressView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnSure = self:getGo("btnSure")
	self._txtBtnSure = self:getTxt("btnSure/txt")
	self._btnProvince = self:getGo("btnProvince")
	self._txtProvince = self:getTxt("btnProvince/txt")
	self._tipProvince = self:getGo("btnProvince/txtTip")
	self._imgArrowProvince = self:getGo("btnProvince/imgArrow")
	self._tableviewProvince = self:getGo("tableviewProvince")
	self._tablecellProvince = self:getGo("tableviewProvince/tablecell")
	self._provinceScrCustomInput = UICustomInput.Get(self._tableviewProvince)
	self._scrollListProvince = ScrollerList.create(self._tableviewProvince, self._tablecellProvince, GameUtil.handler(self._updateCellProvince, self), GameUtil.handler(self._clearCellProvince, self))
	self._btnCity = self:getGo("btnCity")
	self._txtCity = self:getTxt("btnCity/txt")
	self._tipCity = self:getGo("btnCity/txtTip")
	self._imgArrowCity = self:getGo("btnCity/imgArrow")
	self._tableviewCity = self:getGo("tableviewCity")
	self._tablecellCity = self:getGo("tableviewCity/tablecell")
	self._cityScrCustomInput = UICustomInput.Get(self._tableviewCity)
	self._scrollListCity = ScrollerList.create(self._tableviewCity, self._tablecellCity, GameUtil.handler(self._updateCellCity, self), GameUtil.handler(self._clearCellCity, self))
	self._btnDistrict = self:getGo("btnDistrict")
	self._txtDistrict = self:getTxt("btnDistrict/txt")
	self._tipDistrict = self:getGo("btnDistrict/txtTip")
	self._imgArrowDistrict = self:getGo("btnDistrict/imgArrow")
	self._tableviewDistrict = self:getGo("tableviewDistrict")
	self._tablecellDistrict = self:getGo("tableviewDistrict/tablecell")
	self._districtScrCustomInput = UICustomInput.Get(self._tableviewDistrict)
	self._scrollListDistrict = ScrollerList.create(self._tableviewDistrict, self._tablecellDistrict, GameUtil.handler(self._updateCellDistrict, self), GameUtil.handler(self._clearCellDistrict, self))
	self._inputName = self:getInput("inputName")
	self._inputNumber = self:getInput("inputNumber")
	self._inputAddress = self:getInput("inputAddress")
	self._selectTabList = {}

	table.insert(self._selectTabList, self._imgSelect1)
	table.insert(self._selectTabList, self._imgSelect2)
end

function CompanionmalladdressView:onExit()
	CompanionmalladdressView.super.onExit(self)
	self._scrollListProvince:dispose()
	self._scrollListCity:dispose()
	self._scrollListDistrict:dispose()
end

function CompanionmalladdressView:onEnter()
	CompanionmalladdressView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._addressId = checknumber(params[2])
	self._isReWrite = params[3]
	self._isMsgInfoOk = false
	self._adressInfoOk = false
	self._provinceId = 0
	self._cityId = 0
	self._districtId = 0
	self._provinceCfgs = CompanionMallConfig.instance:getProvinceCfgs()
	self._cityDic = CompanionMallConfig.instance:getCityDic()
	self._districtDic = CompanionMallConfig.instance:getDistrictDic()

	self.addGEvent(self, GlobalNotify.COMPANION_MALL_GET_INFO, self._refreshUI, self)
	self.addGEvent(self, GlobalNotify.PM_CompanionMallSubmitOrModifyAddressRes, self._onSubmitOrModifyAddressRes, self)
	CompanionMallController.instance:sendGetInfo(self._activityId)
	CompanionMallController.instance:sendGetAddressInfo(self._activityId)
	GameUtil.SetActive(self._imgSelect1, false)
	GameUtil.SetActive(self._imgSelect2, false)

	if not self._isReWrite then
		self:_initUI()
	end

	CompanionMallModel.instance:hasOpenAddressView()
end

function CompanionmalladdressView:_onAdressOK()
	TipsFacade.instance:openCommonTips("填写成功，请留意签收")
	CompanionMallController.instance:sendGetAddressInfo(self._activityId)
end

function CompanionmalladdressView:_onAdressInfoOk()
	self._adressInfoOk = true

	if self._isMsgInfoOk and self._adressInfoOk then
		self:_refreshUI()
	end
end

function CompanionmalladdressView:_onMsgInfoOk()
	self._isMsgInfoOk = true

	if self._isMsgInfoOk and self._adressInfoOk then
		self:_refreshUI()
	end
end

function CompanionmalladdressView:_initUI()
	self._txtProvince.text = ""
	self._txtCity.text = ""
	self._txtDistrict.text = ""

	self._inputName:SetText("")
	self._inputNumber:SetText("")
	self._inputAddress:SetText("")
	GameUtil.SetActive(self._tipProvince, false)
	GameUtil.SetActive(self._tipCity, false)
	GameUtil.SetActive(self._tipDistrict, false)
end

function CompanionmalladdressView:_refreshUI()
	local actInfo = CompanionMallModel.instance:getInfo(self._activityId) or {}

	if not actInfo.companionInfo then
		self._hasComMap = {}
		self._hasFinishMap = {}
		self._provinceId = CompanionMallConfig.instance:getProvinceIdByProvince(self._txtProvince.text)
		self._cityId = CompanionMallConfig.instance:getCityIdByCity(self._txtCity.text)
		self._districtId = CompanionMallConfig.instance:getDirectIdByDirect(self._txtDistrict.text)

		local addressInfo = CompanionMallModel.instance:getAddressBookInfoById(self._addressId)

		if addressInfo then
			self._provinceId = CompanionMallConfig.instance:getProvinceIdByProvince(addressInfo.province)
			self._cityId = CompanionMallConfig.instance:getCityIdByCity(addressInfo.city)
			self._districtId = CompanionMallConfig.instance:getDirectIdByDirect(addressInfo.district)
			self._txtProvince.text = addressInfo.province
			self._txtCity.text = addressInfo.city
			self._txtDistrict.text = addressInfo.district

			self._inputName:SetText(addressInfo.recipientName)
			self._inputNumber:SetText(addressInfo.phoneNumber)
			self._inputAddress:SetText(addressInfo.address)
		end

		GameUtil.SetActive(self._tipProvince, addressInfo == nil)
		GameUtil.SetActive(self._tipCity, addressInfo == nil)
		GameUtil.SetActive(self._tipDistrict, addressInfo == nil)
	end
end

function CompanionmalladdressView:_onClickSure()
	local recipientName = self._inputName:GetText()
	local phoneNumber = self._inputNumber:GetText()
	local address = self._inputAddress:GetText()
	local province = self._txtProvince.text
	local city = self._txtCity.text
	local district = self._txtDistrict.text

	if string.nilorempty(recipientName) then
		TipsFacade.instance:openCommonTips("请正确填入收件人姓名")

		return
	end

	if string.nilorempty(phoneNumber) or not self:_checkPhoneNumIsLegal(phoneNumber) then
		TipsFacade.instance:openCommonTips("请正确填入手机号码")

		return
	end

	if string.nilorempty(address) then
		TipsFacade.instance:openCommonTips("请正确填入收货地址")

		return
	end

	if string.nilorempty(self._txtProvince.text) or string.nilorempty(self._txtCity.text) or string.nilorempty(self._txtDistrict.text) then
		if self._txtProvince.text ~= "其他" then
			TipsFacade.instance:openCommonTips("请选择省市区")

			return
		else
			city = "其他"
			district = "其他"
		end
	end

	local addressInfo = CompanionMallModel.instance:getAddressBookInfoById(self._addressId)

	if addressInfo and province == addressInfo.province and city == addressInfo.city and district == addressInfo.district and recipientName == addressInfo.recipientName and phoneNumber == addressInfo.phoneNumber and address == addressInfo.address then
		TipsFacade.instance:openCommonTips("地址无变化")

		return
	end

	local isUsingAddress = CompanionMallModel.instance:isUsingAddress(self._activityId, self._addressId)

	if isUsingAddress then
		local actInfo = CompanionMallModel.instance:getInfo(self._activityId) or {}

		if not actInfo.companionInfo then
			local companionInfos = {}
			local nameStr = ""

			for i, companionInfo in ipairs(companionInfos) do
				if companionInfo.addressId == self._addressId then
					local companionId = companionInfo.companionId
					local itemCfg = CompanionMallConfig.instance:getItemCfgById(self._activityId, companionId)
					local companionName = string.format("【%s】 ", itemCfg.name)

					nameStr = nameStr .. companionName
				end
			end

			local contentStr = string.format("当前地址已用于%s中\n修改后这些周边使用的地址将将同步修改\n是否确认修改本地址？", nameStr)

			local function okFunc()
				CompanionMallController.instance:sendSubmitAddressInfo(self._activityId, self._addressId, recipientName, phoneNumber, address, province, city, district)
				TipsFacade.instance:openCommonTips("修改成功")
			end

			TipsFacade.instance:openPopupWindow("提示", contentStr, okFunc, nil, "确定", "取消")
		end
	else
		CompanionMallController.instance:sendSubmitAddressInfo(self._activityId, self._addressId, recipientName, phoneNumber, address, province, city, district)
		TipsFacade.instance:openCommonTips("修改成功")
	end
end

function CompanionmalladdressView:_checkPhoneNumIsLegal(phoneNumber)
	local arr = string.split(phoneNumber, "-")
	local isLegal = true

	if arr[2] == nil then
		local number = checknumber(phoneNumber)
		local numberLength = self:_getNumLength(phoneNumber)

		if number == 0 or numberLength ~= PHONE_NUM_LENGTH then
			isLegal = false
		end
	else
		local preNumber = checknumber(arr[1])
		local lastNum = checknumber(arr[2])
		local preNumberLength = self:_getNumLength(preNumber)
		local lastNumberLength = self:_getNumLength(lastNum)
		local preNumLenIsLegal = preNumberLength >= 3 and preNumberLength <= 4
		local lastNumLenIsLegal = lastNumberLength >= 7 and lastNumberLength <= 8
		local numIsLegal = preNumber ~= 0 and lastNum ~= 0 and preNumLenIsLegal and lastNumLenIsLegal

		if not numIsLegal then
			isLegal = false
		end
	end

	return isLegal
end

function CompanionmalladdressView:_getNumLength(phoneNumber)
	local num = 0

	if checknumber(phoneNumber) == 0 then
		return num
	end

	while phoneNumber ~= 0 do
		phoneNumber = math.floor(phoneNumber / 10)
		num = num + 1
	end

	return num
end

function CompanionmalladdressView:_onClickBtnProvince()
	GameUtil.SetActive(self._tableviewProvince, true)
	GameUtil.SetActive(self._imgArrowProvince, false)
	self._scrollListProvince:reloadData(self._provinceCfgs)
end

function CompanionmalladdressView:_onClickBtnCity()
	if string.nilorempty(self._txtProvince.text) then
		FloatWordMgr.instance:show("请按照“省-市-区”的顺序选择")

		return
	elseif self._txtProvince.text == "其他" then
		FloatWordMgr.instance:show("请直接填写详细地址，注意只能填写国内地址")

		return
	end

	self._cityCfgs = self._cityDic[self._provinceId]

	GameUtil.SetActive(self._tableviewCity, true)
	GameUtil.SetActive(self._imgArrowCity, false)
	self._scrollListCity:reloadData(self._cityCfgs)
end

function CompanionmalladdressView:_onClickBtnDistrict()
	if string.nilorempty(self._txtCity.text) or string.nilorempty(self._txtProvince.text) then
		FloatWordMgr.instance:show("请按照“省-市-区”的顺序选择")

		return
	elseif self._txtProvince.text == "其他" then
		FloatWordMgr.instance:show("请直接填写详细地址，注意只能填写国内地址")

		return
	end

	self._districtCfgs = self._districtDic[self._cityId]

	GameUtil.SetActive(self._tableviewDistrict, true)
	GameUtil.SetActive(self._imgArrowDistrict, false)
	self._scrollListDistrict:reloadData(self._districtCfgs)
end

function CompanionmalladdressView:_onProvinceScrCustomInputCallback(hover)
	if not hover then
		GameUtil.SetActive(self._tableviewProvince, false)
		GameUtil.SetActive(self._imgArrowProvince, true)
	end
end

function CompanionmalladdressView:_onCityScrCustomInputCallback(hover)
	if not hover then
		GameUtil.SetActive(self._tableviewCity, false)
		GameUtil.SetActive(self._imgArrowCity, true)
	end
end

function CompanionmalladdressView:_onDistrictScrCustomInputCallback(hover)
	if not hover then
		GameUtil.SetActive(self._tableviewDistrict, false)
		GameUtil.SetActive(self._imgArrowDistrict, true)
	end
end

function CompanionmalladdressView:_updateCellProvince(view, cell, data)
	local btn = goutil.findChild(cell, "btn")
	local changeComp = cell:GetComponent(ComponentType.UIChangeGroup)
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local imgSelect = 0

	if data.provinceCode == self._provinceId then
		imgSelect = 1
	end

	txtName.text = data.province

	changeComp:SetState(imgSelect)
	GameUtil.addClickHandler(btn, function()
		self._provinceId = data.provinceCode
		self._txtProvince.text = data.province
		self._txtCity.text = ""
		self._txtDistrict.text = ""

		GameUtil.SetActive(self._tipProvince, false)
		GameUtil.SetActive(self._tipCity, true)
		GameUtil.SetActive(self._tipDistrict, true)
		self._scrollListProvince:reloadData(self._provinceCfgs)
	end, self)
end

function CompanionmalladdressView:_clearCellProvince(cell)
	local btn = goutil.findChild(cell, "btn")

	GameUtil.rmClickHandler(btn)
end

function CompanionmalladdressView:_updateCellCity(view, cell, data)
	local btn = goutil.findChild(cell, "btn")
	local changeComp = cell:GetComponent(ComponentType.UIChangeGroup)
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local imgSelect = 0

	if data.cityCode == self._cityId then
		imgSelect = 1
	end

	txtName.text = data.city

	changeComp:SetState(imgSelect)
	GameUtil.addClickHandler(btn, function()
		self._cityId = data.cityCode
		self._txtCity.text = data.city
		self._txtDistrict.text = ""

		self._scrollListCity:reloadData(self._cityCfgs)
		GameUtil.SetActive(self._tipCity, false)
		GameUtil.SetActive(self._tipDistrict, true)
	end, self)
end

function CompanionmalladdressView:_clearCellCity(cell)
	local btn = goutil.findChild(cell, "btn")

	GameUtil.rmClickHandler(btn)
end

function CompanionmalladdressView:_updateCellDistrict(view, cell, data)
	local btn = goutil.findChild(cell, "btn")
	local changeComp = cell:GetComponent(ComponentType.UIChangeGroup)
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local imgSelect = 0

	if data.districtCode == self._districtId then
		imgSelect = 1
	end

	txtName.text = data.city

	changeComp:SetState(imgSelect)
	GameUtil.addClickHandler(btn, function()
		self._districtId = data.districtCode
		self._txtDistrict.text = data.city

		self._scrollListDistrict:reloadData(self._districtCfgs)
		GameUtil.SetActive(self._tipDistrict, false)
	end, self)
end

function CompanionmalladdressView:_clearCellDistrict(cell)
	local btn = goutil.findChild(cell, "btn")

	GameUtil.rmClickHandler(btn)
end

function CompanionmalladdressView:_onSubmitOrModifyAddressRes(addressId)
	self._addressId = addressId

	self:_refreshUI()
end

return CompanionmalladdressView
