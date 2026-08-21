-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\DrawCard\\DrawGroupPoolChild.lua

local DrawPoolChildBase = require("UI/DrawCard/DrawPoolChildBase")
local DrawCardUtils = require("UI/DrawCard/DrawCardUtils")
local DrawGroupActivityPanel = require("UI/DrawCard/DrawGroupActivityPanel")
local DrawGroupActivityMultiPanel = require("UI/DrawCard/DrawGroupActivityMultiPanel")
local DrawGroupSelectPanel = require("UI/DrawCard/DrawGroupSelectPanel")
local strClassName = "DrawGroupPoolChild"
local DrawGroupPoolChild = Class(strClassName, DrawPoolChildBase)

function DrawGroupPoolChild:ctor(...)
	self:initUI()
end

function DrawGroupPoolChild:initUI(...)
	self.bannerBg = UIControls.RawImage(self, "Bg")
	self.needItemIcon = UIControls.Image(self, "PricePanel/IconPrice")
	self.priceTxt = UIControls.Label(self, "PricePanel/TextPriceNum")
	self.freeLineImg = UIControls.Image(self, "PricePanel/TextPriceNum/ImgLine")
	self.buyBtn = UIControls.Button(self, "BtnBuy")

	self.buyBtn:addEventClick(self._onClickDraw)

	self.slotOfRealDraw = Slot(self._realDraw, self)
	self.buyOneBtn = UIControls.Button(self, "BtnBuyNumPanel/BtnOne")

	self.buyOneBtn:addEventClick(self._selectBuyOne)

	self.buyOneBoxImg = UIControls.Image(self, "BtnBuyNumPanel/BtnOne/Icon")
	self.buyTenBtn = UIControls.Button(self, "BtnBuyNumPanel/BtnTen")

	self.buyTenBtn:addEventClick(self._selectBuyTen)

	self.buyTenBoxImg = UIControls.Image(self, "BtnBuyNumPanel/BtnTen/Icon")
	self.buyOneDisImg = UIControls.Image(self, "BtnBuyNumPanel/BtnOne/ImgDis")
	self.buyTenDisImg = UIControls.Image(self, "BtnBuyNumPanel/BtnTen/ImgDis")
	self.countdownTxt = UIControls.Label(self, "TextNumTime")
	self.slotOfCountDown = Slot(self._changeGroupCountdown, self)
	self.slotOfSwitchActPool = Slot(self._onSwitchActPool, self)
	self.slotOfOpenChooseHero = Slot(self._onChooseHero, self)
	self.selectGroupPanel = DrawGroupSelectPanel(self, "")

	if UIControls.checkControlFunc(self, "limitNumPanel") then
		self.limitNumPanel = UIControls.Panel(self, "limitNumPanel")

		self.limitNumPanel:setVisible(false)

		self.node01 = UIControls.Panel(self, "limitNumPanel/Node01")
		self.node02 = UIControls.Panel(self, "limitNumPanel/Node02")
		self.remainTxt = UIControls.Label(self, "limitNumPanel/Node01/TextNum01")
	end
end

function DrawGroupPoolChild:_initData(...)
	self.needItemIcon:setImage(self.needItemIconPath[1], self.needItemIconPath[2])
end

function DrawGroupPoolChild:onPanelOpen(...)
	self:_startCountDown()
	self:selectDefaultGroup()

	if DrawCardUtils.checkDrawCost(self.poolId, 10, true) ~= false then
		self.totalDrawCount = 10

		self.buyOneBtn:setEnable(true)
		self.buyTenBtn:setEnable(false)
	else
		self.totalDrawCount = 1

		self.buyOneBtn:setEnable(false)
		self.buyTenBtn:setEnable(true)
	end
end

function DrawGroupPoolChild:onPanelClose(...)
	self:_stopCountDown()

	if self.selectGroupPanel then
		self.selectGroupPanel:onPanelClose()
	end

	CurAvatar.lastSelectGroupId = self.currentSelectGroup
end

function DrawGroupPoolChild:selectDefaultGroup()
	local openSelectGroup

	if CurAvatar.lastSelectGroupId and DrawCardUtils.groupValid(CurAvatar.lastSelectGroupId) then
		openSelectGroup = CurAvatar.lastSelectGroupId
		CurAvatar.lastSelectGroupId = nil
	elseif CurAvatar:poolHasReplaced(Const.DrawPoolIdLightDark) then
		openSelectGroup = Const.DrawCampLightDark
	elseif CurAvatar.todayDrawGroup then
		openSelectGroup = CurAvatar.todayDrawGroup
	end

	self:selectGroup(openSelectGroup or 1)
end

function DrawGroupPoolChild:_refreshPanel(...)
	self.selectGroupPanel:refreshGroupsInfo()
	self:_refreshDrawInfo()
	self:_refreshReplacePool()
	self:_refreshRemainCount()
end

function DrawGroupPoolChild:selectGroup(groupId)
	self.currentSelectGroup = groupId

	if groupId == Const.DrawCampLightDark then
		self.poolType = Const.DrawTypeLightDark
		self.poolId = Const.DrawPoolIdLightDark
	else
		self.poolType = Const.DrawTypeGroup
		self.poolId = Const.DrawPoolIdCamp
	end

	self.mParent.poolId = self.poolId

	local selectImgPath = DrawCardUtils.GROUP_SELECT_IMG[groupId]

	if selectImgPath then
		self.buyOneDisImg:setImage(selectImgPath[1], selectImgPath[2])
		self.buyTenDisImg:setImage(selectImgPath[1], selectImgPath[2])
	end

	local buyImgPath = DrawCardUtils.GROUP_BUY_IMG[groupId]

	if buyImgPath then
		self.buyBtn:setImage(buyImgPath[1], buyImgPath[2])
	end

	local buyOneBoxPath = DrawCardUtils.GROUP_ONE_BOX_IMG[groupId]

	if buyOneBoxPath then
		self.buyOneBoxImg:setImage(buyOneBoxPath[1], buyOneBoxPath[2])
	end

	local buyTenBoxPath = DrawCardUtils.GROUP_TEN_BOX_IMG[groupId]

	if buyTenBoxPath then
		self.buyTenBoxImg:setImage(buyTenBoxPath[1], buyTenBoxPath[2])
	end

	self:_refreshReplacePool()
	self.selectGroupPanel:refreshGroupsInfo(self.currentSelectGroup)
end

function DrawGroupPoolChild:_refreshReplacePool()
	local replaceBgPath, replaceOriBgPath, timeTxt
	local hasRepalceActivity = false
	local skipReplace = false

	self.replaceOpId = nil

	local detailData
	local actObjs = CurAvatar:getReplacePoolActivity()

	if actObjs then
		local actObj = actObjs[self.poolId]

		if actObj then
			hasRepalceActivity = true
			self.replaceOpId = actObj.opId
			skipReplace = actObj.actData:getNowSelection(self.poolId) == 0
			detailData = actObj.actData:getNowUpDetail(self.poolId)
			detailData = detailData or actObj.actData:getDefaultDetail(self.poolId)
			replaceBgPath = detailData.banner
			replaceOriBgPath = detailData.ori_banner

			if self.actPanel and self.actPanel.opId ~= self.replaceOpId then
				self.actPanel:destroy()

				self.actPanel = nil
			end

			local viewPoolId = detailData.fake_pool_id

			if viewPoolId then
				local viewPoolInfo = DrawCardUtils.getPoolClientInfo(viewPoolId)

				if viewPoolInfo and viewPoolInfo.prefab_path and not self.actPanel then
					if actObj.actData:isMultiUp(self.poolId) then
						self.actPanel = DrawGroupActivityMultiPanel(self, "ActivityGroupPanel", viewPoolInfo.prefab_path, 0, 0, true)

						self.actPanel:setActivityInfo(actObj)
					else
						self.actPanel = DrawGroupActivityPanel(self, "ActivityGroupPanel", viewPoolInfo.prefab_path, 0, 0, true)

						self.actPanel:setActivityInfo(actObj)
					end
				end
			end
		end

		local mainDlg = UIManager.getUI("drawCardMainDlg", nil, false)

		if mainDlg then
			mainDlg:initReplacePools()
		end
	end

	local bgPath

	if hasRepalceActivity then
		if not skipReplace then
			bgPath = replaceBgPath
		else
			bgPath = replaceOriBgPath
		end
	end

	bgPath = hasRepalceActivity and bgPath or DrawCardUtils.GROUP_BG[self.currentSelectGroup]

	if bgPath then
		self.bannerBg:setImage(bgPath)
	end

	if self.actPanel then
		self.actPanel:setVisible(hasRepalceActivity)

		if hasRepalceActivity then
			self.actPanel:refresActivityPanel(skipReplace, detailData)
		end
	end

	self.skipReplaceFlag = skipReplace
end

function DrawGroupPoolChild:_onSwitchActPool()
	local skipReplace = self.skipReplaceFlag

	if self.replaceOpId then
		skipReplace = not skipReplace

		if skipReplace then
			RPC.opActDrawReplaceChangeIndex(self.replaceOpId, 0)
		else
			RPC.opActDrawReplaceChangeIndex(self.replaceOpId, 1)
		end
	end
end

function DrawGroupPoolChild:_onChooseHero()
	local chooseDlg = UIManager.getUI("drawGroupChooseHeroDlg", true)

	chooseDlg:initHeroChooseData(self.poolId)
end

function DrawGroupPoolChild:_refreshDrawInfo()
	if not self.needItemId then
		return
	end

	local curItemNum = CurAvatar:getItemNumById(self.needItemId)

	self.totalNeedItem = 0
	self.totalNeedItem = self.needItemNum * self.totalDrawCount

	if curItemNum >= self.totalNeedItem then
		self.priceTxt:setText(self.totalNeedItem)
	else
		self.priceTxt:setTextWithColor(self.totalNeedItem, "RED")
	end
end

function DrawGroupPoolChild:_selectBuyOne()
	self.totalDrawCount = 1

	self.buyOneBtn:setEnable(false)
	self.buyTenBtn:setEnable(true)
	self:_refreshPanel()
end

function DrawGroupPoolChild:_selectBuyTen()
	self.totalDrawCount = 10

	self.buyOneBtn:setEnable(true)
	self.buyTenBtn:setEnable(false)
	self:_refreshPanel()
end

function DrawGroupPoolChild:_onClickDraw(...)
	if not DrawCardUtils.groupValid(self.currentSelectGroup) then
		MsgManager.notice(Lang.get(43756))
		self:selectGroup(CurAvatar.todayDrawGroup)

		return
	end

	if self.poolType == Const.DrawTypeLightDark and CurAvatar:isAllLightBlackMaxStar() and not CurAvatar.DrawLightNoMaxConfirm then
		UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, "", ClientUtils.getClientNotice(291), self.slotOfRealDraw, nil)

		local confirmDlg = UIManager.getUI("confirmui", nil, false)

		confirmDlg:showToggle(Lang.get(30272), CurAvatar.DrawLightNoMaxConfirm or false)

		self.hasMaxConfirm = true

		return
	end

	if self.replaceOpId then
		local actObjs = CurAvatar:getReplacePoolActivity()
		local actObj = actObjs[self.poolId]

		if not actObj or not actObj:isOpen() then
			MsgManager.notice(Lang.get(30273))

			local mainDlg = UIManager.getUI("drawCardMainDlg", nil, false)

			if mainDlg then
				mainDlg:setVisible(false)
			end

			return
		end

		local lastSetValid = actObj.actData:lastSetValid(self.poolId)
		local isMultiUp = actObj.actData:isMultiUp(self.poolId)

		if isMultiUp and not lastSetValid then
			local function yesFunc(poolId)
				local chooseDlg = UIManager.getUI("drawGroupChooseHeroDlg", true)

				chooseDlg:initHeroChooseData(poolId)
			end

			UIManager.showConfirmWithId(1029, Functor(yesFunc, self.poolId), nil, nil, nil)

			return
		end

		local selectDetail = actObj.actData:getNowUpDetail(self.poolId)

		if selectDetail then
			local selectHeroId = selectDetail.fake_hero_id

			if selectHeroId then
				local isStarMax = CurAvatar:hasMaxStarHeroId(selectHeroId)

				if isStarMax then
					UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, "", ClientUtils.getClientNotice(368), self.slotOfRealDraw, nil)

					return
				end
			end
		end
	end

	if self.replaceOpId and self.skipReplaceFlag then
		if not CurAvatar.SkipReplaceNoConfirm then
			UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, "", ClientUtils.getClientNotice(327), self.slotOfRealDraw, nil)

			local confirmDlg = UIManager.getUI("confirmui", nil, false)

			confirmDlg:showToggle(Lang.get(30272), CurAvatar.SkipReplaceNoConfirm or false)
		else
			self:_realDraw()
		end

		return
	end

	if self.poolType ~= Const.DrawTypeLightDark or CurAvatar.DrawLightNoConfirm then
		self:_realDraw()
	else
		local noticeId = 278

		if self.replaceOpId then
			noticeId = 328
		end

		UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, "", ClientUtils.getClientNotice(noticeId), self.slotOfRealDraw, nil)

		local confirmDlg = UIManager.getUI("confirmui", nil, false)

		confirmDlg:showToggle(Lang.get(30272), CurAvatar.DrawLightNoConfirm or false)
	end
end

function DrawGroupPoolChild:_realDraw()
	local confirmDlg = UIManager.getUI("confirmui", nil, false)

	if confirmDlg then
		if self.hasMaxConfirm then
			CurAvatar.DrawLightNoMaxConfirm = confirmDlg:getToggleState()
			self.hasMaxConfirm = nil
		elseif self.replaceOpId and self.skipReplaceFlag then
			CurAvatar.SkipReplaceNoConfirm = confirmDlg:getToggleState()
		else
			CurAvatar.DrawLightNoConfirm = confirmDlg:getToggleState()
		end
	end

	DrawGroupPoolChild.super._onClickDraw(self)
end

function DrawGroupPoolChild:_startCountDown(...)
	self:_changeGroupCountdown()

	if not self.nextChangeTimer then
		self.nextChangeTimer = Timer.New(self.slotOfCountDown, 1, -1)
	end

	self.nextChangeTimer:Restart()
end

function DrawGroupPoolChild:_stopCountDown(...)
	if self.nextChangeTimer then
		self.nextChangeTimer:Stop()

		self.nextChangeTimer = nil
	end
end

function DrawGroupPoolChild:_changeGroupCountdown()
	if not self.nextChangeTick or self.nextChangeTick <= 0 then
		self.nextChangeTick = ClientUtils.getServerTimeNextDay() - ClientUtils.getServerTime()
	end

	local timeStr = utils.calcTimeTxt(self.nextChangeTick)

	self.countdownTxt:setText(string.format(Lang.get(55290), timeStr))

	self.nextChangeTick = self.nextChangeTick - 1
end

function DrawGroupPoolChild:_refreshRemainCount(...)
	if self.limitNumPanel and CurAvatar:dayDrawCountLimitOpen() then
		self.limitNumPanel:setVisible(true)

		local todayRemain = CurAvatar:getDrawDayCount(self.poolType, Const.DayDrawMaxCountFree)

		if todayRemain >= Const.DayDrawMaxCountFree then
			self.node01:setVisible(false)
			self.node02:setVisible(true)
		else
			self.node01:setVisible(true)
			self.node02:setVisible(false)
			self.remainTxt:setText(todayRemain .. "/" .. Const.DayDrawMaxCountFree)
		end
	end
end

return DrawGroupPoolChild
