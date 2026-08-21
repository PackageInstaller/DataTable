-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\PettyPay\\PettyPayDailyPayPanel.lua

local ResOpActivityAchieveDetail = require("ClientData/ResOpActivityAchieveDetail")
local ResRandClient = require("ClientData/ResRandClient")
local ResPettyPayTab = require("ClientData/ResPettyPayTab")
local RechargeManager = require("System/Recharge/RechargeManager")
local strClassName = "PettyPayDailyPayPanel"
local PettyPayDailyPayPanel = Class(strClassName, UIControls.Panel)

function PettyPayDailyPayPanel:ctor()
	self:initUI()
end

function PettyPayDailyPayPanel:initUI(...)
	self.sliderProgress = UIControls.Slider(self, self.mPath .. "/Slider")
	self.txtTarget = UIControls.Label(self, self.mPath .. "/TextTarget")
	self.txtProgress = UIControls.Label(self, self.mPath .. "/Slider/TextProgress")
	self.btnConfirm = UIControls.Button(self, self.mPath .. "/BtnConfirm")

	self.btnConfirm:addEventClick(self.onBtnConfirmClick)

	self.btnGo = UIControls.Button(self, self.mPath .. "/BtnGo")

	self.btnGo:addEventClick(self.onBtnGoClick)

	self.awardPanel = UIControls.Panel(self, "MainInfoPanel/DailyPayPanel/AwardPanel")
	self.txtState = UIControls.Label(self, self.mPath .. "/TextState")
end

function PettyPayDailyPayPanel:setResData(resData)
	self.resData = resData

	self:refreshUI()
end

local constDailyPayAchieveType = 111

function PettyPayDailyPayPanel:refreshUI(...)
	if self.resData then
		local templID = self.resData.templ_id

		if templID then
			local actObj

			for opActId, activityObj in pairs(CurAvatar.opActivityObjs) do
				if activityObj and activityObj:isValid() and activityObj.templateData and activityObj.templateData.template_id == templID then
					actObj = activityObj
				end

				if actObj then
					self.actObj = actObj
				end
			end
		end

		if self.actObj then
			self.actData = self.actObj.actData
			self.templateData = self.actObj.templateData

			if self.templateData then
				self:setItemData()
			end

			self.serverData = self.actData.serverData
			self.clientData = self.actData.clientData

			local param = 1800
			local award

			if self.clientData and self.clientData[constDailyPayAchieveType] and self.clientData[constDailyPayAchieveType][1] then
				if self.clientData[constDailyPayAchieveType][1].param then
					param = self.clientData[constDailyPayAchieveType][1].param
				end

				if self.clientData[constDailyPayAchieveType][1].award then
					award = self.clientData[constDailyPayAchieveType][1].award
				end
			end

			local progress = 0

			if self.serverData and self.serverData[constDailyPayAchieveType] then
				progress = self.serverData[constDailyPayAchieveType].progress
			end

			progress = math.min(progress, param)

			if progress == 0 then
				self.sliderProgress:setValue(0)
			elseif param then
				local value = progress / param

				self.sliderProgress:setValue(value)
			end

			self.txtProgress:setText(utils.format("%1s/%2s", progress / 100, param / 100))

			if progress == param then
				self.btnGo:setVisible(false)

				local flagGoted = false

				if self.serverData and self.serverData[constDailyPayAchieveType].got and self.serverData[constDailyPayAchieveType].got[1] == true then
					flagGoted = true
				end

				self.btnConfirm:setVisible(not flagGoted)
				self.txtState:setVisible(flagGoted)
			else
				self.btnGo:setVisible(true)
				self.btnConfirm:setVisible(false)
				self.txtState:setVisible(false)
			end
		end
	end
end

function PettyPayDailyPayPanel:setItemData()
	if self.templateData then
		local detailID = self.templateData.detail_id

		if detailID then
			local resData = ResOpActivityAchieveDetail[detailID]

			if resData and resData[constDailyPayAchieveType] and resData[constDailyPayAchieveType][1] then
				local desc = resData[constDailyPayAchieveType][1].desc_name

				if desc then
					self.txtTarget:setText(desc)
				end

				local randId = resData[constDailyPayAchieveType][1].award

				if randId and ResRandClient[randId] then
					if not self.itemGrids then
						self.itemGrids = {}
					end

					local randData = ResRandClient[randId]
					local num = math.min(#randData.show_ids, #randData.show_nums)

					for i = 1, num do
						if not self.itemGrids[i] then
							self.itemGrids[i] = UIControls.getGridAwardContainer(self, "AwardPanel")

							self.itemGrids[i]:setVisible(true)
						end

						local itemId = randData.show_ids[i]
						local itemNum = randData.show_nums[i]
						local item = BaseObject.GetObject(itemId, itemNum)

						self.itemGrids[i]:setObj(item)

						self.itemGrids[i].grid.mDisableWays = true
						self.itemGrids[i].grid.mEnableTips = true
						self.itemGrids[i].grid.mEventClick = self.slotOfClickGrid
					end

					if randData.show_flag then
						local showdata = randData.show_flag

						for index, flag in pairs(showdata) do
							if flag and flag ~= 0 and self.itemGrids[index] then
								self.itemGrids[index].imgSpe:setVisible(true)
								self.itemGrids[index]:setSpe(true, 3, flag)
							end
						end
					end
				end
			end
		end
	end
end

function PettyPayDailyPayPanel:checkRedDot(...)
	return
end

function PettyPayDailyPayPanel:onBtnGoClick()
	if self.resData and self.resData.jump_id then
		JumpGuideManager.jump(self.resData.jump_id)
	end
end

function PettyPayDailyPayPanel:onBtnConfirmClick()
	if self.actData then
		local actId = self.actObj.opId
		local index = 1
		local type = constDailyPayAchieveType

		RPC.opActGetAward(actId, index, type)
	end
end

return PettyPayDailyPayPanel
