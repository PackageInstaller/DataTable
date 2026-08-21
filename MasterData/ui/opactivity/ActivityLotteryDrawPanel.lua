-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\ActivityLotteryDrawPanel.lua

local ResOpActivityLotteryDetail = require("ClientData/ResOpActivityLotteryDetail")
local ResRandClient = require("ClientData/ResRandClient")
local ResOpActivityLotteryMsic = require("ClientData/ResOpActivityLotteryMsic")
local PlayerCell = Class("PlayerCell", UIControls.Child)

function PlayerCell:ctor()
	self.txtName = UIControls.Label(self, "TxtName")
	self.txtServer = UIControls.Label(self, "TxtServer")
	self.btnHead = UIControls.PlayerHeadGridChild(self, "BgPlayer/GridPlayer", "System/Common/Grid/GridPlayerCommon")

	self.btnHead:setEnable(false)
end

function PlayerCell:setData(winner)
	local winnerInfo = CurAvatar:getRoleInfoByUid(winner.uid)

	if winnerInfo then
		self:setVisible(true)

		local commonInfo = winnerInfo.commInfo
		local strName = utils.GetPlayerName(commonInfo.name)

		self.btnHead:setCommInfo(commonInfo, false, self)
		self.btnHead:hideLevel()
		self.txtName:setText(strName)
		self.txtServer:setText(commonInfo.serverName)
	else
		self:setVisible(false)
	end
end

local ActivityLotteryDrawPanel = Class("ActivityLotteryDrawPanel", UIControls.Panel)

function ActivityLotteryDrawPanel:ctor()
	self.winnerCells = {}
	self.awardItems = {}
	self.roleInfo = CurAvatar:getMyCommInfo()

	self:initUI()
end

function ActivityLotteryDrawPanel:initUI()
	self.btnClose = UIControls.Button(self, self.mPath .. "/BtnPrize")

	self.btnClose:addEventClick(self.onClickClose)

	self.txtMyName = UIControls.Label(self, self.mPath .. "/PrizeInfoPanel/TxtName")
	self.txtMyId = UIControls.Label(self, self.mPath .. "/PrizeInfoPanel/TxtId")
	self.absentPanel = UIControls.Panel(self, self.mPath .. "/PrizePanel/AbsentPanel")
	self.specialPrizePanel = UIControls.Panel(self, self.mPath .. "/PrizePanel/SpecialPrizePanel")
	self.txtSpcRank = UIControls.Label(self, self.mPath .. "/PrizePanel/SpecialPrizePanel/TxtPrize")
	self.txtSpcCode = UIControls.Label(self, self.mPath .. "/PrizePanel/SpecialPrizePanel/TxtPrizeCode")
	self.nomPrizePanel = UIControls.Panel(self, self.mPath .. "/PrizePanel/NomPrizePanel")
	self.txtNmlRank = UIControls.Label(self, self.mPath .. "/PrizePanel/NomPrizePanel/ShowPrizePanel/TxtPrize")
	self.txtNmlCode = UIControls.Label(self, self.mPath .. "/PrizePanel/NomPrizePanel/ShowPrizePanel/TxtPrizeCode")
	self.waitPanel = UIControls.Panel(self, self.mPath .. "/PrizePanel/WaitPanel")

	if UIControls.checkControlFunc(self, self.mPath .. "/PrizePanel/SpecialPrizePanel/BtnAdress") then
		self.btnAdress = UIControls.Button(self, self.mPath .. "/PrizePanel/SpecialPrizePanel/BtnAdress")

		self.btnAdress:addEventClick(self.onBtnAdressClick)
	end
end

function ActivityLotteryDrawPanel:setData(actObj, closeCB, mainActObj)
	self.actId = actObj.actId
	self.actObj = actObj
	self.mainActObj = mainActObj or self.actObj

	if self.mainActObj.clientTemplateData and self.mainActObj.clientTemplateData.src_replace and self.mainActObj.clientTemplateData.src_replace[1] then
		self.cellPath = "System/Activity/" .. self.mainActObj.clientTemplateData.src_replace[1] .. "/PlayerInfoCell"
	else
		self.cellPath = "System/Activity/ActivityDoubleEleven/PlayerInfoCell"
	end

	self.winnerList = actObj.actData.winners
	self.closeCB = closeCB

	self.txtMyName:setText(self.roleInfo.name)
	self.txtMyId:setText(CurAvatar.shortUid or "")
	self:initWinnerInfo()
	self:initAwardInfo(actObj.actData.awardInfo)
end

function ActivityLotteryDrawPanel:initWinnerInfo()
	for i, winner in ipairs(self.winnerList) do
		local cell = self.winnerCells[i]

		cell = cell or PlayerCell(self, self.mPath .. "/PlayerInfoPanel/Content", self.cellPath)

		cell:setData(winner)

		self.winnerCells[i] = cell
	end

	if #self.winnerList < #self.winnerCells then
		for i = #self.winnerList + 1, #self.winnerCells do
			self.winnerCells[i]:destroy()

			self.winnerCells[i] = nil
		end
	end
end

function ActivityLotteryDrawPanel:initAwardInfo(awardInfo)
	local codeItems = self.actObj.actData.codeItems

	self.waitPanel:setVisible(false)

	if #codeItems > 0 then
		if awardInfo and (not awardInfo.has_get or awardInfo.has_get ~= 1) then
			self.waitPanel:setVisible(true)
			self.absentPanel:setVisible(false)
			self.nomPrizePanel:setVisible(false)
			self.specialPrizePanel:setVisible(false)
		elseif awardInfo and awardInfo.cdkey and tonumber(awardInfo.cdkey) ~= 0 then
			self.absentPanel:setVisible(false)

			local uid = CurAvatar.uid
			local isSpec = false

			for i, winner in ipairs(self.winnerList) do
				if winner.uid == uid then
					isSpec = true

					break
				end
			end

			local prizeData = ResOpActivityLotteryDetail[self.actId]
			local rank = awardInfo.rank
			local index = #prizeData

			for i, data in ipairs(prizeData) do
				if data.limit_min and data.limit_max and rank >= data.limit_min and rank <= data.limit_max then
					index = i

					break
				end
			end

			local selfPrizeData = prizeData[index]
			local prizeDesc = selfPrizeData.rank_desc
			local isSpec = selfPrizeData.is_spec == 1

			if isSpec then
				self.txtSpcRank:setText(prizeDesc)
				self.txtSpcCode:setText(awardInfo.cdkey)
				self.nomPrizePanel:setVisible(false)
				self.specialPrizePanel:setVisible(true)

				if selfPrizeData.spec_bg_path then
					if not self.specImgBg then
						self.specImgBg = UIControls.Image(self, self.mPath .. "/PrizePanel/SpecialPrizePanel/ImgFigure")
					end

					self.specImgBg:setImage(selfPrizeData.spec_bg_path, selfPrizeData.spec_bg)
				elseif selfPrizeData.award or selfPrizeData.show_award then
					for i = #self.awardItems, 1, -1 do
						self.awardItems[i]:destroy()

						self.awardItems[i] = nil
					end

					ClientUtils.CreateBonusGrid(self, self.awardItems, self.mPath .. "/PrizePanel/SpecialPrizePanel/GridPanel", selfPrizeData.award or selfPrizeData.show_award, true, nil, true)
				end
			else
				self.txtNmlRank:setText(prizeDesc)
				self.txtNmlCode:setText(awardInfo.cdkey)
				self.nomPrizePanel:setVisible(true)
				self.specialPrizePanel:setVisible(false)

				if selfPrizeData.award or selfPrizeData.show_award then
					for i = #self.awardItems, 1, -1 do
						self.awardItems[i]:destroy()

						self.awardItems[i] = nil
					end

					ClientUtils.CreateBonusGrid(self, self.awardItems, self.mPath .. "/PrizePanel/NomPrizePanel/GridPanel", selfPrizeData.award or selfPrizeData.show_award, true, nil, true)
				end
			end
		else
			self.absentPanel:setVisible(false)

			local prizeData = ResOpActivityLotteryMsic[self.actId]

			if prizeData and prizeData.normal_award then
				local award = prizeData.normal_award

				self.txtNmlRank:setText(prizeData.rank_desc)
				self.txtNmlCode:setVisible(false)
				self.nomPrizePanel:setVisible(true)
				self.specialPrizePanel:setVisible(false)

				for i = #self.awardItems, 1, -1 do
					self.awardItems[i]:destroy()

					self.awardItems[i] = nil
				end

				ClientUtils.CreateBonusGrid(self, self.awardItems, self.mPath .. "/PrizePanel/NomPrizePanel/GridPanel", award, true, nil, true)
			else
				self.nomPrizePanel:setVisible(false)
				self.specialPrizePanel:setVisible(false)
			end
		end
	else
		self.absentPanel:setVisible(true)
		self.nomPrizePanel:setVisible(false)
		self.specialPrizePanel:setVisible(false)
	end
end

function ActivityLotteryDrawPanel:onBtnAdressClick()
	UIManager.getUI("editAdressDlg", true):setData()
end

function ActivityLotteryDrawPanel:onClickClose()
	if self.closeCB then
		self.closeCB()
	end
end

return ActivityLotteryDrawPanel
