-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\SeasonPlay\\SeasonPlayUpDlg.lua

local SeasonPlayUpDlg = Class("SeasonPlayUpDlg", UIControls.Window)

function SeasonPlayUpDlg:ctor(...)
	self:initUI()
end

function SeasonPlayUpDlg:initUI(...)
	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.btnConfirm = UIControls.Button(self, "BgPanel/BtnConfirm")

	self.btnConfirm:addEventClick(self.onBtnConfirmClick)

	self.btnUp1 = UIControls.Button(self, "BgPanel/BtnUp1")

	self.btnUp1:addEventClick(self.onBtnUp1Click)

	self.txtBtnUp1 = UIControls.Label(self, "BgPanel/BtnUp1/Text")
	self.txtBtnUp2 = UIControls.Label(self, "BgPanel/BtnUp2/Text")
	self.btnUp2 = UIControls.Button(self, "BgPanel/BtnUp2")

	self.btnUp2:addEventClick(self.onBtnUp2Click)

	self.iconUp1 = UIControls.Image(self, "BgPanel/BtnUp1/IconUp")
	self.iconUp2 = UIControls.Image(self, "BgPanel/BtnUp2/IconUp")
	self.imgConfirmUp1 = UIControls.Panel(self, "BgPanel/BtnUp1/ImgConfirm")
	self.imgConfirmUp2 = UIControls.Panel(self, "BgPanel/BtnUp2/ImgConfirm")
	self.imgSoldOutUp1 = UIControls.Image(self, "BgPanel/BtnUp1/ImgSoldOut")
	self.imgSoldOutUp2 = UIControls.Image(self, "BgPanel/BtnUp2/ImgSoldOut")
	self.selPanel1 = UIControls.Panel(self, "BgPanel/BtnUp1/SelPanel")
	self.selPanel2 = UIControls.Panel(self, "BgPanel/BtnUp2/SelPanel")
	self.imgSkin1 = UIControls.Image(self, "BgPanel/BtnUp1/ImgSkin")
	self.imgSkinSel1 = UIControls.Image(self, "BgPanel/BtnUp1/SelPanel/ImgSkin2")
	self.imgSkin2 = UIControls.Image(self, "BgPanel/BtnUp2/ImgSkin")
	self.imgSkinSel2 = UIControls.Image(self, "BgPanel/BtnUp2/SelPanel/ImgSkin2")
end

function SeasonPlayUpDlg:setData(actObject, relactObject)
	self.actObject = actObject or self.actObject

	if relactObject then
		self.relactObject = relactObject
	end

	if self.actObject then
		self.actData = self.actObject.actData
		self.clientData = self.actData.clientData

		if self.clientData then
			local itemId1 = self.clientData[1][1].show_hero_id
			local itemId2 = self.clientData[1][2].show_hero_id

			self.canSelectUp1 = true
			self.canSelectUp2 = true

			for i, k in ipairs(self.clientData[1][1].index_limit_id or {}) do
				if not LimitManager.checkConditionOK(k) then
					self.imgSoldOutUp1:setVisible(true)
					self.btnUp1:setEnable(false)

					self.canSelectUp1 = false
				end
			end

			for i, k in ipairs(self.clientData[1][2].index_limit_id or {}) do
				if not LimitManager.checkConditionOK(k) then
					self.imgSoldOutUp2:setVisible(true)
					self.btnUp2:setEnable(false)

					self.canSelectUp2 = false
				end
			end

			local iconData1 = BaseObject.getItemIconPath(itemId1)
			local showData1 = CurAvatar:getItemSeasonDrawShowData(itemId1)

			if showData1 and showData1.icon_path then
				self.iconUp1:setImage(showData1.icon_path, showData1.icon_name)
				self.imgSoldOutUp1:setImage(showData1.icon_path, showData1.icon_name .. "Dis")
			end

			local showData2 = CurAvatar:getItemSeasonDrawShowData(itemId2)

			if showData2 and showData2.icon_path then
				self.iconUp2:setImage(showData2.icon_path, showData2.icon_name)
				self.imgSoldOutUp2:setImage(showData2.icon_path, showData2.icon_name .. "Dis")
			end
		end

		if self.relactObject then
			local resData = self.relactObject.actData:getResDetailData()

			if resData and resData.replace_icon_path then
				local path1 = resData.replace_icon_path .. "/SeasonPlaySkinAtlas02"
				local path2 = resData.replace_icon_path .. "/SeasonPlaySkinAtlas"

				self.imgSkin1:setImage(path1, "BtnCharacter1ADis")
				self.imgSkinSel1:setImage(path2, "BtnCharacter1A")
				self.imgSkin2:setImage(path1, "BtnCharacter1BDis")
				self.imgSkinSel2:setImage(path2, "BtnCharacter1B")
			end

			if resData and resData.replace_text1 then
				self.txtBtnUp1:setText(resData.replace_text1)
				self.txtBtnUp2:setText(resData.replace_text2)
			end
		end

		if self.actData.randReplaceData and self.actData.randReplaceData[1] then
			self.nowSelect = self.actData.randReplaceData[1].index
			self.actNowSelect = self.actData.randReplaceData[1].index
		end

		self:refreshState()
	end
end

function SeasonPlayUpDlg:refreshUI(...)
	if self.actData and self.actData.randReplaceData and self.actData.randReplaceData[1] then
		self.nowSelect = self.actData.randReplaceData[1].index
		self.actNowSelect = self.actData.randReplaceData[1].index
	end

	self:refreshState()
end

function SeasonPlayUpDlg:refreshState(...)
	if self.actNowSelect == 1 then
		self.imgConfirmUp1:setVisible(true)
		self.imgConfirmUp2:setVisible(false)
	elseif self.actNowSelect == 2 then
		self.imgConfirmUp1:setVisible(false)
		self.imgConfirmUp2:setVisible(true)
	else
		self.imgConfirmUp1:setVisible(false)
		self.imgConfirmUp2:setVisible(false)
	end

	if self.nowSelect == 1 then
		self.btnUp1:setEnable(false)
		self.btnUp2:setEnable(self.canSelectUp2)
	elseif self.nowSelect == 2 then
		self.btnUp1:setEnable(self.canSelectUp1)
		self.btnUp2:setEnable(false)
	else
		self.btnUp1:setEnable(self.canSelectUp1)
		self.btnUp2:setEnable(self.canSelectUp2)
	end

	self.selPanel1:setVisible(self.nowSelect == 1)
	self.selPanel2:setVisible(self.nowSelect == 2)

	if self.nowSelect ~= self.actNowSelect then
		self.btnConfirm:setEnable(true)
	else
		self.btnConfirm:setEnable(false)
	end
end

function SeasonPlayUpDlg:onBtnUp1Click()
	if self.nowSelect ~= 1 then
		self.nowSelect = 1
	end

	self:refreshState()
end

function SeasonPlayUpDlg:onBtnUp2Click()
	if self.nowSelect ~= 2 then
		self.nowSelect = 2
	end

	self:refreshState()
end

function SeasonPlayUpDlg:onBtnConfirmClick()
	if self.nowSelect ~= self.actNowSelect then
		local act_id = self.actObject.opId

		RPC.opActRandReplaceSet(act_id, 1, self.nowSelect)
		self:setVisible(false)
	end
end

function SeasonPlayUpDlg:onBtnCloseClick()
	self:setVisible(false)
end

function SeasonPlayUpDlg:onClose(...)
	local ui = UIManager.tryGetUI("seasonPlaySkinPoolDlg")

	if ui and ui:getVisible() then
		ui:refreshUpRedDot()
	end

	SeasonPlayUpDlg.super.onClose(self)
end

return SeasonPlayUpDlg
