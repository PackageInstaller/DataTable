-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\ActivitySimpleShowPage.lua

local ActivityPanelMixin = require("UI/OpActivity/ActivityPanelMixin")
local ResRechargeRebateMisc = require("ClientData/ResRechargeRebateMisc")
local ShareAchievePanel = require("UI/Achieve/ShareAchievePanel")
local ResShopExchg = require("ClientData/ResShopExchg")
local ResOpActivityShopMisc = require("ClientData/ResOpActivityShopMisc")
local UIControls = UIControls
local classNameStr = "ActivitySimpleShowPage"
local ActivitySimpleShowPage = Class(classNameStr, UIControls.Child)

MixinClass(ActivitySimpleShowPage, ActivityPanelMixin)

function ActivitySimpleShowPage:initUI()
	if UIControls.checkControlFunc(self, "BgDes/TextDes") then
		self.textRule = UIControls.Label(self, "BgDes/TextDes")
	end

	if UIControls.checkControlFunc(self, "BgTime/TextTime") then
		self.textTime = UIControls.Label(self, "BgTime/TextTime")
	end

	if UIControls.checkControlFunc(self, "BtnGo") then
		self.btnJump = UIControls.Button(self, "BtnGo")

		self.btnJump:addEventClick(self.onJumpClick)

		self.grids = {}
	end

	if UIControls.checkControlFunc(self, "BtnConfirm") then
		self.btnConfirm = UIControls.Button(self, "BtnConfirm")

		self.btnConfirm:addEventClick(self.onGetAwardClick)

		if UIControls.checkControlFunc(self, "ImgGet") then
			self.ImgGet = UIControls.Image(self, "ImgGet")
		end

		self:reChargeCanGet()

		if self.actObj.actType == Const.ACT_TYPE_RECHARGE_REBATE then
			-- block empty
		end
	end

	if UIControls.checkControlFunc(self, "SharePanel") then
		self.sharePanel = ShareAchievePanel(self, "SharePanel")
	end
end

function ActivitySimpleShowPage:_setData()
	self.showArgs = self.clientTemplateData.template_args

	if self.showArgs and self.btnJump then
		local bonusId = tonumber(self.showArgs[1])

		if bonusId > 0 then
			ClientUtils.CreateBonusGrid(self, self.grids, "HookPanel/HookList/Content", bonusId, false, 3, true)
		end
	end

	if self.actObj.actType == Const.ACT_TYPE_RECHARGE_REBATE then
		self:awardShowType()
	end

	if self.sharePanel then
		self.sharePanel:setShareVisible(false)

		local templateData = self.actObj.templateData

		if templateData and templateData.relate_share_act then
			local shareActObj = CurAvatar:getActivityObj(templateData.relate_share_act)

			if shareActObj then
				local clientData = shareActObj.actData.clientData
				local exchangeId, newRewardBtn

				if clientData then
					for i, v in pairs(clientData) do
						if v.index == 1 then
							exchangeId = v.exchgid
							newRewardBtn = self:checkPageReward(exchangeId, shareActObj.actData.serverData)

							break
						end
					end
				end

				if exchangeId then
					local shareActId = shareActObj.actId
					local miscData = ResOpActivityShopMisc[shareActId]

					self.sharePanel:setShopInfo(shareActId)
					self.sharePanel:setShareVisible(true)
					self.sharePanel:setShareFrame(miscData.shareFrameID and miscData.shareFrameID[1], exchangeId, newRewardBtn)
				end
			end
		end
	end
end

function ActivitySimpleShowPage:checkPageReward(exchgid, serverData)
	if not ResShopExchg[exchgid] or not ResShopExchg[exchgid].exchgmax or ResShopExchg[exchgid].exchgmax == 0 then
		return false
	end

	if not serverData or not serverData[exchgid] then
		return true
	end

	local exchgmax = ResShopExchg[exchgid].exchgmax
	local hasBought = serverData[exchgid] and serverData[exchgid].count or 0

	if exchgmax and exchgmax - hasBought > 0 then
		return true
	else
		return false
	end
end

function ActivitySimpleShowPage:onJumpClick()
	if self.showArgs then
		local jumpId = tonumber(self.showArgs[2])

		if jumpId then
			JumpGuideManager.jump(jumpId)
		end
	end
end

function ActivitySimpleShowPage:reChargeCanGet()
	if self.btnConfirm then
		local btnState = self.actObj.actData:isOver()

		if btnState then
			self.ImgGet:setVisible(true)
			self.btnConfirm:setVisible(false)
		else
			self.btnConfirm:setVisible(true)
		end
	end
end

function ActivitySimpleShowPage:awardShowType()
	if UIControls.checkControlFunc(self, "AwardPanel/Award1") then
		self.Award1TextNum = UIControls.Label(self, "AwardPanel/Award1/TextNum")
	end

	if UIControls.checkControlFunc(self, "AwardPanel/Award2") then
		self.Award2TextNum = UIControls.Label(self, "AwardPanel/Award2/TextNum")
	end

	if UIControls.checkControlFunc(self, "AwardPanel/Award3") then
		self.Award3 = UIControls.Panel(self, "AwardPanel/Award3")
		self.Award3TextNum = UIControls.Label(self, "AwardPanel/Award3/TextNum")
	end

	if UIControls.checkControlFunc(self, "AwardPanel/Award4") then
		self.Award4 = UIControls.Panel(self, "AwardPanel/Award4")
		self.Award4TextNum = UIControls.Label(self, "AwardPanel/Award4/TextNum")
	end

	local gemnum = self.actObj.actData.serverData.gem

	self.Award1TextNum:setText("x" .. gemnum * 1)
	self.Award2TextNum:setText("x" .. gemnum * 10)

	local normal_vip_gem = ResRechargeRebateMisc[1].normal_vip_gem
	local super_vip_gem = ResRechargeRebateMisc[1].super_vip_gem
	local max_diamond = ResRechargeRebateMisc[1].max_diamond

	if gemnum < normal_vip_gem then
		self.Award3:setVisible(false)
		self.Award4:setVisible(false)
	elseif normal_vip_gem <= gemnum and gemnum < super_vip_gem then
		self.Award4:setVisible(false)
	elseif gemnum > max_diamond / 10 then
		self.Award2TextNum:setText("x" .. max_diamond)
	end
end

function ActivitySimpleShowPage:onGetAwardClick()
	local ResClientNotice = require("ClientData/ResClientNotice")

	if ResClientNotice then
		UIManager.showConfirmWithId(1010, self.yesFunc, nil)
	end
end

function ActivitySimpleShowPage:yesFunc()
	RPC.rechargeRebateAward()
end

function ActivitySimpleShowPage:onActivityDataRefresh(actObj)
	self:reChargeCanGet()
end

return ActivitySimpleShowPage
