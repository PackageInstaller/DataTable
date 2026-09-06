-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tourarena/view/TourArenaSelectView.lua

module("logic.extensions.tourarena.view.TourArenaSelectView", package.seeall)

local TourArenaSelectView = class("TourArenaSelectView", ViewComponent)
local ViewState = {}

ViewState.Nothing = 1
ViewState.HasBinding = 2
ViewState.NeedAutoBinding = 3
ViewState.NeedHandBinding = 4

function TourArenaSelectView:buildUI()
	TourArenaSelectView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._btnSure = goutil.findChild(self.mainGO, "btnSure")
	self._btnExit = goutil.findChild(self.mainGO, "btnExit")
	self._txtTips = goutil.findChildTextComponent(self.mainGO, "txtTips")
	self._txtArea = goutil.findChildTextComponent(self.mainGO, "txtArea")
	self._selectCol_dropdown = goutil.findChild(self.mainGO, "selectCol/dropdown")
	self._selectCol_dropdownComp = DropDownAdapter.Get(self._selectCol_dropdown)
end

function TourArenaSelectView:bindEvents()
	TourArenaSelectView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
	GameUtil.addClickHandler(self._btnExit, self._onClickBtnExit, self)
end

function TourArenaSelectView:unbindEvents()
	TourArenaSelectView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.rmClickHandler(self._btnExit)
end

function TourArenaSelectView:onEnter()
	TourArenaSelectView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._termId = checknumber(params[1])

	if self._termId <= 0 then
		self:close()

		return
	end

	self._viewState = ViewState.Nothing
	self._zoneId = nil
	self._province = nil

	self.addGEvent(self, GlobalNotify.TourArenaZoneInfoRes, self._handleTourArenaZoneInfoRes, self)
	self.addGEvent(self, GlobalNotify.TourArenaZoneBindingRes, self._handleTourArenaZoneBindingRes, self)
	self.addGEvent(self, GlobalNotify.TourArenaZoneSelectBindingRes, self._handleTourArenaZoneSelectBindingRes, self)
	TourArenaController.instance:sendPM_TourArenaZoneInfoReq(self._termId)
	self:_onUpdate()
end

function TourArenaSelectView:onExit()
	TourArenaSelectView.super.onExit(self)
	self:_onClearDropdownUI()
end

function TourArenaSelectView:_handleTourArenaZoneInfoRes(msg)
	local termId = msg.termId
	local zoneId = checknumber(msg.zoneId)
	local province = msg.province

	if termId ~= self._termId then
		return
	end

	if zoneId == 0 then
		self._viewState = ViewState.NeedAutoBinding
	else
		self._viewState = ViewState.HasBinding
		self._zoneId = zoneId
		self._province = province
	end

	if self._viewState == ViewState.Nothing then
		self:_onUpdate()
	elseif self._viewState == ViewState.HasBinding then
		self:_onUpdate()
	elseif self._viewState == ViewState.NeedAutoBinding then
		TourArenaController.instance:sendPM_TourArenaZoneBindingReq(self._termId)
	elseif self._viewState == ViewState.NeedHandBinding then
		self:_onUpdate()
	end
end

function TourArenaSelectView:_handleTourArenaZoneBindingRes(status, msg)
	if status ~= 0 then
		local text = string.format("地区自动绑定失败,请重新尝试")

		local function func()
			self:close()
		end

		local btnText = "确定"
		local alignment = UnityEngine.TextAnchor.MiddleCenter

		TipsFacade.instance:openTipWindow("提示", text, func, btnText, alignment)
	end

	local termId = msg.termId
	local zoneId = checknumber(msg.zoneId)
	local province = msg.province

	if termId ~= self._termId then
		return
	end

	if zoneId == 0 then
		self._viewState = ViewState.NeedHandBinding
	else
		self._viewState = ViewState.HasBinding
		self._zoneId = zoneId
		self._province = province
	end

	self:_onUpdate()
end

function TourArenaSelectView:_handleTourArenaZoneSelectBindingRes(status, msg)
	if status ~= 0 then
		local text = string.format("地区自动绑定失败,请重新尝试")

		local function func()
			self:close()
		end

		local btnText = "确定"
		local alignment = UnityEngine.TextAnchor.MiddleCenter

		TipsFacade.instance:openTipWindow("提示", text, func, btnText, alignment)
	else
		self:close()
	end
end

function TourArenaSelectView:_onUpdate()
	self:_onUpdateDropdownData()
	self:_onUpdateDropdownUI()
	self:_onUpdatePlaneUI()
	self:_onUpdateSelectedUI()
end

function TourArenaSelectView:_onUpdatePlaneUI()
	if self._viewState == ViewState.Nothing then
		self._txtTips.text = "未检测到您当前所在区域，请手动选择您的家乡的所在区域，选择之后不可再更改。"
	elseif self._viewState == ViewState.HasBinding then
		self._txtTips.text = "检测到您当前所在区域"
	elseif self._viewState == ViewState.NeedAutoBinding then
		self._txtTips.text = "未检测到您当前所在区域，请手动选择您的家乡的所在区域，选择之后不可再更改。"
	elseif self._viewState == ViewState.NeedHandBinding then
		self._txtTips.text = "未检测到您当前所在区域，请手动选择您的家乡的所在区域，选择之后不可再更改。"
	end
end

function TourArenaSelectView:_onUpdateDropdownData()
	if self._zoneList == nil then
		self._zoneList = {}
	else
		table.clear(self._zoneList)
	end

	if self._viewState == ViewState.Nothing then
		-- block empty
	elseif self._viewState == ViewState.HasBinding then
		table.insert(self._zoneList, self._province)
	elseif self._viewState == ViewState.NeedAutoBinding then
		-- block empty
	elseif self._viewState == ViewState.NeedHandBinding then
		local dataList = TourArenaZoneConfig.instance:getTazDataList()

		for _, data in ipairs(dataList) do
			for _, v in ipairs(data.provinces) do
				table.insert(self._zoneList, v)
			end
		end
	end
end

function TourArenaSelectView:_onUpdateDropdownUI()
	self:_onClearDropdownUI()

	local dropdownComp = self._selectCol_dropdownComp

	dropdownComp:AddOnValueChanged(self._onValueChanged, self)
	dropdownComp:AddOptions("选择地区")

	if self._viewState == ViewState.Nothing then
		self._txtArea.text = ""
	elseif self._viewState == ViewState.HasBinding then
		dropdownComp:AddOptions(self._zoneList[1])
		dropdownComp:SetValue(1)

		local name = self:_getCurZoneName()

		self._txtArea.text = string.format("属于【%s】，快去参加竞技王者赛吧~", name)
	elseif self._viewState == ViewState.NeedAutoBinding then
		self._txtArea.text = ""
	elseif self._viewState == ViewState.NeedHandBinding then
		for _, v in ipairs(self._zoneList) do
			dropdownComp:AddOptions(v)

			local name = self:_getCurZoneName()

			self._txtArea.text = string.format("属于【%s】，快去参加竞技王者赛吧~", name)
		end
	end

	dropdownComp:SetValue(dropdownComp:GetValue())
	self:_onValueChanged(dropdownComp:GetValue())
end

function TourArenaSelectView:_onClearDropdownUI()
	local dropdownComp = self._selectCol_dropdownComp

	if dropdownComp then
		dropdownComp:RemoveOnValueChanged()
		dropdownComp:ClearOptions()
	end
end

function TourArenaSelectView:_onUpdateSelectedUI()
	GameUtil.SetActive(self._btnSure, self._viewState == ViewState.NeedHandBinding)

	local province = self:_getCurProvince()

	GameUtil.SetGray(self._btnSure, string.nilorempty(province))
	GameUtil.SetActive(self._btnExit, self._viewState == ViewState.HasBinding)

	local name = self:_getCurZoneName()

	self._txtArea.text = not string.nilorempty(name) and string.format("属于【%s】，快去参加竞技王者赛吧~", name) or ""
end

function TourArenaSelectView:_onValueChanged(value)
	self:_onUpdateSelectedUI()
end

function TourArenaSelectView:_getCurProvince()
	local value = self._selectCol_dropdownComp:GetValue()

	return self._zoneList[value]
end

function TourArenaSelectView:_getCurZoneId()
	local zoneId = 0
	local curProvince = self:_getCurProvince()
	local dataList = TourArenaZoneConfig.instance:getTazDataList()

	for _, data in ipairs(dataList) do
		for _, province in ipairs(data.provinces) do
			if curProvince == province then
				zoneId = data.zoneId

				break
			end
		end
	end

	return zoneId
end

function TourArenaSelectView:_getCurZoneName()
	local curZoneId = self:_getCurZoneId()
	local data = TourArenaZoneConfig.instance:getTazData(curZoneId)

	return (data or nil) and data.name
end

function TourArenaSelectView:_onClickBtnSure()
	local province = self:_getCurProvince()

	if not string.nilorempty(province) then
		TourArenaController.instance:sendPM_TourArenaZoneSelectBindingReq(self._termId, province)
	else
		FloatWordMgr.instance:show("未选择区域")
	end
end

function TourArenaSelectView:_onClickBtnExit()
	self:close()
end

return TourArenaSelectView
