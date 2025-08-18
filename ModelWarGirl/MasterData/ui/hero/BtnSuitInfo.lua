-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Hero\\BtnSuitInfo.lua

local strClassName = "BtnSuitInfo"
local BtnSuitInfo = Class(strClassName, UIControls.ScrollViewLoopCell)

function BtnSuitInfo:ctor()
	self:initUI()
end

function BtnSuitInfo:initUI()
	self.iconSuit = UIControls.Image(self, "SuitNamePanel/IconSuit")
	self.btnSuitInfo = UIControls.Button(self, "")

	self.btnSuitInfo:addEventClick(self.onBtnSuitInfoClick)

	self.txtSuitName = UIControls.Label(self, "SuitNamePanel/TxtSuitName")
	self.imgHero = UIControls.Image(self, "ImgHero")
	self.txtAttr = UIControls.Label(self, "TxtAttr")
end

function BtnSuitInfo:onBtnSuitInfoClick()
	if self.suitInfoCellData then
		if self.suitInfoCellData.status == Const.CUSTOM_SUIT_INFO_STATUS_ACTIVE then
			self.mWindow:addSelectedSuit(self.suitInfoCellData.resData.suit_id)
		elseif self.suitInfoCellData.status == Const.CUSTOM_SUIT_INFO_STATUS_NO_ENOUGH then
			MsgManager.clientNotice(641)
		else
			MsgManager.clientNotice(642)
		end
	end
end

function BtnSuitInfo:setSuitInfoCellData(suitInfoCellData)
	self.suitInfoCellData = suitInfoCellData

	self.iconSuit:setImage(UIConst.COMMON_ICON_PATH .. self.suitInfoCellData.resData.iconPath, self.suitInfoCellData.resData.icon)
	self.txtSuitName:setText(self.suitInfoCellData.resData.name)
	self.iconSuit:setImageGray(self.suitInfoCellData.status ~= Const.CUSTOM_SUIT_INFO_STATUS_ACTIVE)

	local attrColor = self.suitInfoCellData.status == Const.CUSTOM_SUIT_INFO_STATUS_ACTIVE and ResColor.ORANGE or ResColor.GREYLIGHT
	local nameColor = self.suitInfoCellData.status == Const.CUSTOM_SUIT_INFO_STATUS_ACTIVE and ResColor.WHITE or ResColor.GREYLIGHT

	self.txtAttr:setText(self.suitInfoCellData.resData.des)
	self.txtAttr:setFontColor(attrColor)
	self.txtSuitName:setFontColor(nameColor)

	if self.suitInfoCellData.isHaveDefine ~= 0 then
		self.imgHero:setVisible(true)

		local fakeHero = BaseObject.GetObject(self.suitInfoCellData.isHaveDefine)
		local iconPath = fakeHero:getQIconPath()

		if iconPath then
			self.imgHero:setImage(iconPath[1], iconPath[2])
		end

		self.imgHero:setImageGray(self.suitInfoCellData.status ~= Const.CUSTOM_SUIT_INFO_STATUS_ACTIVE)
	else
		self.imgHero:setVisible(false)
	end
end

return BtnSuitInfo
