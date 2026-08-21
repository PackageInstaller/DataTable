-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\PettyPay\\Activity30DaysSignInDlg.lua

local ResOpActivityAchieveDetail = require("ClientData/ResOpActivityAchieveDetail")
local ResRecharge = require("ClientData/ResRecharge")
local ResRandClient = require("ClientData/ResRandClient")
local ResPettyPayTab = require("ClientData/ResPettyPayTab")
local constSignInAchieveType = 113
local constRechargeTenAchieveType = 112
local Activity30DaysSignInAwardCell = Class("Activity30DaysSignInAwardCell", UIControls.Child)

function Activity30DaysSignInAwardCell:ctor(...)
	self:initUI()
end

function Activity30DaysSignInAwardCell:initUI(...)
	return
end

function Activity30DaysSignInAwardCell:setItemData(randId)
	if randId and ResRandClient[randId] then
		local randData = ResRandClient[randId]

		self.itemId = randData.show_ids[1]
		self.itemNum = randData.show_nums[1]

		if not self.itemGrid then
			self.itemGrid = UIControls.ItemGridChild(self, "GridItem", "System/Common/Grid/GridMaterialItem", 0, 0, true)

			self.itemGrid:setVisible(true)

			self.itemGrid.mEventClick = Slot(self.onButtonClick, self)
		end

		self.item = BaseObject.GetObject(self.itemId, self.itemNum)
		self.itemGrid.mDisableWays = true

		self.itemGrid:setObj(self.item)
	end
end

function Activity30DaysSignInAwardCell:onButtonClick()
	if self.locked == true then
		if self.got ~= true and not self.canGet and self.index == self.progress then
			MsgManager.notice(Lang.get(86802))
		end

		return
	end

	if self.canGet == true then
		local actId = self.mParent.mParent.mParent.actObj.opId
		local index = self.index
		local type = constSignInAchieveType

		RPC.opActGetAward(actId, index, type)
	else
		UIManager.getUI("itemTips"):showObj(self, self.item)
	end
end

local Activity30DaysSignInNormalAwardCell = Class("Activity30DaysSignInNormalAwardCell", Activity30DaysSignInAwardCell)

function Activity30DaysSignInNormalAwardCell:ctor(...)
	self:initUI()
end

function Activity30DaysSignInNormalAwardCell:initUI(...)
	self.panelDis = UIControls.Image(self, "DisPanel")
	self.panelGet = UIControls.Panel(self, "GetPanel")
end

function Activity30DaysSignInNormalAwardCell:refreshUI(...)
	self.index = self.mParent.index

	if not self.index then
		return
	end

	local progress = self.mParent.mParent.mParent.progress or 0

	if self.got == true then
		self.cannotClick = true

		self.panelDis:setVisible(true)
		self.panelGet:setVisible(false)
	elseif progress >= self.index then
		self.panelGet:setVisible(true)
		self.panelDis:setVisible(false)
	else
		self.panelGet:setVisible(false)
		self.panelDis:setVisible(false)
	end

	self.canGet = false

	if self.got ~= true then
		if progress < self.index then
			self.canGet = false
		else
			self.canGet = not self.got
		end
	end

	if self.canGet == true then
		if self.itemGrid then
			self.itemGrid.mEnableTips = false
		end
	elseif self.itemGrid then
		self.itemGrid.mEnableTips = true
	end
end

local Activity30DaysSignInPaidAwardCell = Class("Activity30DaysSignInPaidAwardCell", Activity30DaysSignInAwardCell)

function Activity30DaysSignInPaidAwardCell:ctor(...)
	return
end

function Activity30DaysSignInPaidAwardCell:initUI(...)
	self.panelDis = UIControls.Image(self, "DisPanel")
	self.panelLock = UIControls.Panel(self, "LockPanel")
	self.panelMiss = UIControls.Image(self, "MissPanel")
	self.panelGet = UIControls.Panel(self, "GetPanel")
end

function Activity30DaysSignInPaidAwardCell:refreshUI(...)
	self.index = self.mParent.index

	if not self.index then
		return
	end

	local progress = self.mParent.mParent.mParent.progress or 0

	self.progress = progress

	if self.got == true then
		self.cannotClick = true

		self.panelGet:setVisible(false)
		self.panelDis:setVisible(true)
		self.panelLock:setVisible(false)
		self.panelMiss:setVisible(false)

		self.locked = false
	elseif self.unLocked == true then
		self.panelGet:setVisible(true)
		self.panelDis:setVisible(false)
		self.panelLock:setVisible(false)
		self.panelMiss:setVisible(false)

		self.locked = false
	elseif progress > self.index then
		self.cannotClick = true

		self.panelGet:setVisible(false)
		self.panelDis:setVisible(false)
		self.panelLock:setVisible(false)
		self.panelMiss:setVisible(true)

		self.locked = false
	else
		self.panelGet:setVisible(false)
		self.panelDis:setVisible(false)

		self.locked = true

		self.panelLock:setVisible(true)
		self.panelMiss:setVisible(false)
	end

	self.canGet = false

	if self.got ~= true then
		if progress < self.index then
			self.canGet = false
		else
			self.canGet = not self.got and self.unLocked
		end
	end

	if self.canGet == true then
		if self.itemGrid then
			self.itemGrid.mEnableTips = false
		end
	elseif self.itemGrid then
		self.itemGrid.mEnableTips = true
	end
end

local Activity30DaysSignInCell = Class("Activity30DaysSignInCell", UIControls.Child)

function Activity30DaysSignInCell:ctor()
	self:initUI()
end

function Activity30DaysSignInCell:initUI(...)
	self.txtDate = UIControls.Label(self, "TextDate")
	self.bgSignIn = UIControls.Image(self, "BgSignIn")
	self.normalCell = Activity30DaysSignInNormalAwardCell(self, "GridNormalAward", "System/Activity/ActivityPettyPay/GridSignInNormalAwardContainer")

	self.normalCell:setVisible(true)

	self.paidCell = Activity30DaysSignInPaidAwardCell(self, "GridPaidAward", "System/Activity/ActivityPettyPay/GridSignInPaidAwardContainer")

	self.paidCell:setVisible(true)
end

function Activity30DaysSignInCell:setData(bigIndex, index)
	if not bigIndex or not index then
		return
	end

	self.index = (bigIndex - 1) * 5 + index

	if self.index then
		self.txtDate:setText(utils.format(Lang.get(89891), self.index))
	end

	local suffName

	if self.index then
		if self.index >= 1 and self.index <= 10 then
			self.bgSignIn:setImage("Atlas/ActivityAtlas/ActivityPettyPayAtlas/ActivityPettyPayAtlas01", "BgSignInAward1")
			self.txtDate:setFontColor(ResColor.SIGN30DAYS01)

			self.suffName = 1
		elseif self.index >= 11 and self.index <= 20 then
			self.bgSignIn:setImage("Atlas/ActivityAtlas/ActivityPettyPayAtlas/ActivityPettyPayAtlas01", "BgSignInAward2")

			self.suffName = 2

			self.txtDate:setFontColor(ResColor.SIGN30DAYS02)
		else
			self.bgSignIn:setImage("Atlas/ActivityAtlas/ActivityPettyPayAtlas/ActivityPettyPayAtlas01", "BgSignInAward3")

			self.suffName = 3

			self.txtDate:setFontColor(ResColor.SIGN30DAYS03)
		end
	end

	if self.index and self.index == self.mParent.mParent.progress then
		self.bgSignIn:setImage("Atlas/ActivityAtlas/ActivityPettyPayAtlas/ActivityPettyPayAtlas01", "BgSignInAwardToday" .. self.suffName)
		self:setScale(1.1)
		self.txtDate:setFontColor(ResColor.SIGN30DAYS04)
	else
		self:setScale(1)
	end

	self:setItemData()
	self:refreshUI()
end

function Activity30DaysSignInCell:setItemData(resData)
	if not self.index then
		return
	end

	local resData = self.mParent.mParent.signAwardResData

	if resData and resData[self.index] then
		local data = resData[self.index]

		if data.award then
			self.normalCell:setItemData(data.award)
		end

		if data.recharge_award then
			self.paidCell:setItemData(data.recharge_award)
		end
	end
end

function Activity30DaysSignInCell:refreshUI(...)
	if not self.index then
		return
	end

	local got = self.mParent.mParent.got

	if got and got[self.index] and got[self.index] == true then
		self.normalCell.got = true
	else
		self.normalCell.got = false
	end

	local rechargeGot = self.mParent.mParent.rechargeGot

	if rechargeGot and rechargeGot[self.index] and rechargeGot[self.index] == true then
		self.paidCell.got = true
	else
		self.paidCell.got = false
	end

	local rechargeExtraLock = self.mParent.mParent.rechargeExtraLock

	if rechargeExtraLock and rechargeExtraLock[self.index] and rechargeExtraLock[self.index] == true then
		self.paidCell.unLocked = true
	else
		self.paidCell.unLocked = false
	end

	self.paidCell:refreshUI()
	self.normalCell:refreshUI()

	if self.normalCell.cannotClick == true and self.paidCell.cannotClick == true and self.mParent.mParent.progress and self.index < self.mParent.mParent.progress then
		self.bgSignIn:setImage("Atlas/ActivityAtlas/ActivityPettyPayAtlas/ActivityPettyPayAtlas01", "BgSignInAward4")
		self.txtDate:setFontColor(ResColor.SIGN30DAYS05)
	end
end

local Activity30DaysSignWrapCell = Class("Activity30DaysSignWrapCell", UIControls.ScrollViewLoopCell)

function Activity30DaysSignWrapCell:ctor(...)
	self.cells = {}
end

function Activity30DaysSignWrapCell:setData(index)
	if not index then
		return
	end

	if #self.cells == 0 then
		for i = 1, 5 do
			self.cells[i] = Activity30DaysSignInCell(self, "Cell" .. i, "System/Activity/ActivityPettyPay/30DaysSignInCell")

			self.cells[i]:setVisible(true)
		end
	end

	for i = 1, 5 do
		if self.cells[i] then
			self.cells[i]:setData(index, i)
		end
	end
end

function Activity30DaysSignWrapCell:refreshUI(...)
	for i = 1, 5 do
		if self.cells[i] then
			self.cells[i]:refreshUI()
		end
	end
end

local strClassName = "Activity30DaysSignInDlg"
local Activity30DaysSignInDlg = Class(strClassName, UIControls.Window)

function Activity30DaysSignInDlg:ctor(...)
	self:initUI()
end

local maxCellNum = 30

function Activity30DaysSignInDlg:initUI(...)
	self.txtProgress = UIControls.Label(self, "SliderPanel/TextProgress")
	self.btnGetAward = UIControls.Button(self, "BtnGetAward")

	self.btnGetAward:addEventClick(self.onBtnGetAwardClick)

	self.panel10DaysAvailable = UIControls.Panel(self, "Efx10DaysAvailable")
	self.bg10DaysAward = UIControls.Image(self, "Bg10DaysAward")
	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.btnRecharge = UIControls.Button(self, "BtnRecharge")

	self.btnRecharge:addEventClick(self.onBtnRechargeClick)

	self.btnTips = UIControls.Button(self, "BtnTips")

	self.btnTips:addEventClick(self.onBtnTipsClick)

	self.txtRechatgeTen = UIControls.Label(self, "Text2")
	self.slider = UIControls.Slider(self, "SliderPanel/Slider")
	self.txtProgress = UIControls.Label(self, "SliderPanel/TextProgress")
	self.cells = {}
	self.scrollView = UIControls.ScrollViewLoopV(self, "SignInList", 0, self.onCellChanged)

	self:initData()
end

function Activity30DaysSignInDlg:initData()
	local constSignInType = 2

	if ResPettyPayTab and ResPettyPayTab[constSignInType] then
		self.resData = ResPettyPayTab[constSignInType]

		if self.resData then
			local templID = self.resData.templ_id

			if templID then
				for opActId, activityObj in pairs(CurAvatar.opActivityObjs) do
					if activityObj and activityObj:isValid() and activityObj.templateData and activityObj.templateData.template_id == templID then
						self.actObj = activityObj
					end
				end
			end
		end
	end

	if self.actObj then
		self.actData = self.actObj.actData

		if self.actData then
			self.templateData = self.actObj.templateData
			self.serverData = self.actData.serverData
			self.clientData = self.actData.clientData
		end
	end

	if self.serverData and self.serverData[constSignInAchieveType] then
		local data = self.serverData[constSignInAchieveType]

		self.progress = data.progress
		self.got = data.got
		self.rechargeGot = data.rechargeGot
		self.rechargeExtraLock = data.rechargeExtraLock
	end

	if self.templateData then
		self.detailID = self.templateData.detail_id

		if self.detailID then
			local resData = ResOpActivityAchieveDetail[self.detailID]

			if resData and resData[constSignInAchieveType] then
				local data = resData[constSignInAchieveType]

				self.signAwardResData = data
			end
		end
	end

	local focusIdex = 1

	if self.progress and self.progress > 0 then
		local progressindex = math.floor((self.progress - 1) / 5)

		focusIdex = progressindex
	end

	self.scrollView:setTotalCount(6, focusIdex)
	self:refreshUI()
end

function Activity30DaysSignInDlg:onCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = Activity30DaysSignWrapCell(sender, "System/Activity/ActivityPettyPay/30DaysSignIn5Cell", newIdx, 0, 0)
		targetCell.index = newIdx
	end

	self.cells[targetCell.index] = nil
	self.cells[newIdx] = targetCell

	targetCell:setData(newIdx)
end

local function stringSplitTonumber(longString)
	local splittedData = utils.splitString(tostring(longString), ",")

	for index = 1, #splittedData do
		splittedData[index] = tonumber(splittedData[index])
	end

	return splittedData
end

function Activity30DaysSignInDlg:setRelaActObtData(...)
	if self.resData and self.resData.rela_templ_id then
		local templIds = stringSplitTonumber(self.resData.rela_templ_id)

		if templIds and templIds[1] then
			local templId = templIds[1]

			if templId then
				local relaActObj

				for opActId, activityObj in pairs(CurAvatar.opActivityObjs) do
					if activityObj and activityObj:isValid() and activityObj.templateData and activityObj.templateData.template_id == templId then
						relaActObj = activityObj
						self.relaActObj = activityObj
					end
				end

				if relaActObj then
					local actData = relaActObj.actData
					local templateData = relaActObj.templateData
					local serverData = actData.serverData
					local clientData = actData.clientData

					if templateData then
						local detailID = templateData.detail_id

						if detailID then
							local detailData = ResOpActivityAchieveDetail[detailID]

							if detailData and detailData[constRechargeTenAchieveType] and detailData[constRechargeTenAchieveType][1] then
								local desc = detailData[constRechargeTenAchieveType][1].desc_name

								if desc then
									self.txtRechatgeTen:setText(desc)
								end
							end
						end
					end

					local param = 10
					local award

					if clientData and clientData[constRechargeTenAchieveType] and clientData[constRechargeTenAchieveType][1] then
						param = clientData[constRechargeTenAchieveType][1].param

						if clientData[constRechargeTenAchieveType][1].award then
							award = clientData[constRechargeTenAchieveType][1].award
						end
					end

					local progress = 0

					if serverData and serverData[constRechargeTenAchieveType] then
						progress = serverData[constRechargeTenAchieveType].progress
					end

					progress = math.min(progress, param)

					local value = progress / param

					if value then
						self.slider:setValue(value)
					end

					self.txtProgress:setText(utils.format("%1s/%2s", progress, param))

					if award then
						if not self.relaAward then
							self.relaAward = UIControls.ItemGridChild(self, "Grid10daysAward", "System/Common/Grid/GridMaterialItem", 0, 0, true)

							self.relaAward:setVisible(true)
						end

						if award and ResRandClient[award] then
							local awardData = ResRandClient[award]
							local itemId = awardData.show_ids[1]
							local itemNum = awardData.show_nums[1]
							local item = BaseObject.GetObject(itemId, itemNum)

							self.relaAward:setObj(item)

							self.relaAward.mDisableWays = true

							self.relaAward:onConfigHideBg()
							self.relaAward:onConfigHideQuality()
						end
					end

					if progress == param then
						self.txtProgress:setText(Lang.get(32787))
						self.btnGetAward:setVisible(true)
						self.bg10DaysAward:setVisible(false)
						self.panel10DaysAvailable:setVisible(true)
					else
						self.btnGetAward:setVisible(false)
						self.bg10DaysAward:setVisible(true)
						self.panel10DaysAvailable:setVisible(false)
					end
				end
			end
		end
	end
end

function Activity30DaysSignInDlg:refreshUI(...)
	if self.actObj then
		self.actData = self.actObj.actData

		if self.actData then
			self.templateData = self.actObj.templateData
			self.serverData = self.actData.serverData
			self.clientData = self.actData.clientData
		end
	end

	if self.serverData and self.serverData[constSignInAchieveType] then
		local data = self.serverData[constSignInAchieveType]

		self.progress = data.progress
		self.got = data.got
		self.rechargeGot = data.rechargeGot
		self.rechargeExtraLock = data.rechargeExtraLock
	end

	if self.resData and self.resData.rela_templ_id then
		self:setRelaActObtData()
	end

	for _, cell in pairs(self.cells) do
		cell:refreshUI()
	end
end

function Activity30DaysSignInDlg:checkRedDot(...)
	return
end

function Activity30DaysSignInDlg:onBtnRechargeClick()
	if self.resData and self.resData.jump_id then
		JumpGuideManager.jump(self.resData.jump_id)
	end
end

function Activity30DaysSignInDlg:onBtnTipsClick()
	if self.resData and self.resData.tips_id then
		UIManager.getUI("infoNotice", true):showSystemInfo(self.resData.tips_id)
	end
end

function Activity30DaysSignInDlg:updateActivityData(...)
	self:refreshUI()
end

function Activity30DaysSignInDlg:onBtnGetAwardClick()
	if self.relaActObj then
		local actId = self.relaActObj.opId
		local type = constRechargeTenAchieveType

		RPC.opActGetAward(actId, 1, type)
	end
end

function Activity30DaysSignInDlg:onBtnCloseClick()
	self:setVisible(false)
end

return Activity30DaysSignInDlg
