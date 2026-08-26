-- chunkname: @modules/logic/versionactivity1_3/astrology/view/VersionActivity1_3AstrologyResultView.lua

module("modules.logic.versionactivity1_3.astrology.view.VersionActivity1_3AstrologyResultView", package.seeall)

local VersionActivity1_3AstrologyResultView = class("VersionActivity1_3AstrologyResultView", BaseView)

function VersionActivity1_3AstrologyResultView:onInitView()
	self._goAnalyze = gohelper.findChild(self.viewGO, "#go_Analyze")
	self._txtDesc = gohelper.findChildText(self.viewGO, "#go_Analyze/#txt_Desc")
	self._simageAbstractSystem = gohelper.findChildSingleImage(self.viewGO, "#go_Analyze/#simage_AbstractSystem")
	self._imagePlanetSun = gohelper.findChildImage(self.viewGO, "#go_Analyze/#simage_AbstractSystem/#image_PlanetSun")
	self._goshuixing = gohelper.findChild(self.viewGO, "#go_Analyze/#simage_AbstractSystem/#go_shuixing")
	self._gojinxing = gohelper.findChild(self.viewGO, "#go_Analyze/#simage_AbstractSystem/#go_jinxing")
	self._goyueliang = gohelper.findChild(self.viewGO, "#go_Analyze/#simage_AbstractSystem/#go_yueliang")
	self._gohuoxing = gohelper.findChild(self.viewGO, "#go_Analyze/#simage_AbstractSystem/#go_huoxing")
	self._gomuxing = gohelper.findChild(self.viewGO, "#go_Analyze/#simage_AbstractSystem/#go_muxing")
	self._gotuxing = gohelper.findChild(self.viewGO, "#go_Analyze/#simage_AbstractSystem/#go_tuxing")
	self._goRewards = gohelper.findChild(self.viewGO, "#go_Rewards")
	self._scrollRewards = gohelper.findChildScrollRect(self.viewGO, "#go_Rewards/#scroll_Rewards")
	self._gocontent = gohelper.findChild(self.viewGO, "#go_Rewards/#scroll_Rewards/Viewport/#go_content")
	self._btnAstrologyAgain = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Rewards/#btn_AstrologyAgain")
	self._btnClaim = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Rewards/#btn_Claim")
	self._goreddot = gohelper.findChild(self.viewGO, "#go_Rewards/#btn_Claim/#go_reddot")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity1_3AstrologyResultView:addEvents()
	self._btnAstrologyAgain:AddClickListener(self._btnAstrologyAgainOnClick, self)
	self._btnClaim:AddClickListener(self._btnClaimOnClick, self)
end

function VersionActivity1_3AstrologyResultView:removeEvents()
	self._btnAstrologyAgain:RemoveClickListener()
	self._btnClaim:RemoveClickListener()
end

function VersionActivity1_3AstrologyResultView:_btnAstrologyAgainOnClick()
	GameFacade.showMessageBox(MessageBoxIdDefine.Activity126_msg1, MsgBoxEnum.BoxType.Yes_No, function()
		Activity126Rpc.instance:sendResetProgressRequest(VersionActivity1_3Enum.ActivityId.Act310)
	end)
end

function VersionActivity1_3AstrologyResultView:_btnClaimOnClick()
	GameFacade.showMessageBox(MessageBoxIdDefine.Activity126_msg3, MsgBoxEnum.BoxType.Yes_No, function()
		local resultId = Activity126Model.instance:receiveHoroscope()

		Activity126Rpc.instance:sendGetHoroscopeRequest(VersionActivity1_3Enum.ActivityId.Act310, resultId)
	end)
end

function VersionActivity1_3AstrologyResultView:_editableInitView()
	self:_initPlanets()
	self.addEventCb(self, Activity126Controller.instance, Activity126Event.onResetProgressReply, self._onResetProgressReply, self)
	self.addEventCb(self, Activity126Controller.instance, Activity126Event.onGetHoroscopeReply, self._onGetHoroscopeReply, self)
	RedDotController.instance:addRedDot(self._goreddot, RedDotEnum.DotNode.Activity1_3RedDot5)
end

function VersionActivity1_3AstrologyResultView:_initPlanets()
	for name, id in pairs(VersionActivity1_3AstrologyEnum.Planet) do
		if id >= VersionActivity1_3AstrologyEnum.Planet.shuixing then
			local go = self["_go" .. name]
			local mo = VersionActivity1_3AstrologyModel.instance:getPlanetMo(id)

			self:_rotate(go, mo.angle)
		end
	end
end

function VersionActivity1_3AstrologyResultView:_rotate(go, angle)
	local rad = (360 - angle) * Mathf.Deg2Rad
	local radius = math.abs(recthelper.getAnchorY(go.transform))
	local x = radius * Mathf.Cos(rad)
	local y = radius * Mathf.Sin(rad)

	recthelper.setAnchor(go.transform, x, y)
end

function VersionActivity1_3AstrologyResultView:_onGetHoroscopeReply()
	self:_checkResult()
end

function VersionActivity1_3AstrologyResultView:_onResetProgressReply()
	self.viewContainer:switchTab(1)
end

function VersionActivity1_3AstrologyResultView:onUpdateParam()
	return
end

function VersionActivity1_3AstrologyResultView:onOpen()
	self:_checkResult()
	self:_showRewardList()

	local animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	animator:Play("open", 0, 0)
end

function VersionActivity1_3AstrologyResultView:_checkResult()
	local result = Activity126Model.instance:receiveGetHoroscope()
	local finish = result and result > 0

	gohelper.setActive(self._btnAstrologyAgain, not finish)
	gohelper.setActive(self._btnClaim, not finish)
end

function VersionActivity1_3AstrologyResultView:_showRewardList()
	local rewardId = Activity126Model.instance:receiveHoroscope()

	if not rewardId or rewardId <= 0 then
		return
	end

	gohelper.destroyAllChildren(self._gocontent)

	local config = Activity126Config.instance:getHoroscopeConfig(VersionActivity1_3Enum.ActivityId.Act310, rewardId)
	local bonusList = GameUtil.splitString2(config.bonus, true)

	for i, itemConfig in ipairs(bonusList) do
		local rewardItem = IconMgr.instance:getCommonPropItemIcon(self._gocontent)

		rewardItem:setMOValue(itemConfig[1], itemConfig[2], itemConfig[3])
	end

	self._txtDesc.text = config.desc
end

function VersionActivity1_3AstrologyResultView:onClose()
	return
end

function VersionActivity1_3AstrologyResultView:onDestroyView()
	return
end

return VersionActivity1_3AstrologyResultView
