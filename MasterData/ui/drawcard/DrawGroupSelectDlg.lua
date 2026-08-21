-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\DrawCard\\DrawGroupSelectDlg.lua

local ResDrawMisc = require("ClientData/ResDrawMisc")
local DrawCardConfig = require("DesignerScript/DrawCardConfig")
local strClassName = "DrawGroupSelectDlg"
local DrawGroupSelectDlg = Class(strClassName, UIControls.Window)
local GroupPanel = Class("GroupPanel", UIControls.Panel)

function GroupPanel:ctor(...)
	self:initUI()
end

function GroupPanel:initUI(...)
	self.unlockEfx = UIControls.Panel(self, self.mPath .. "/EfxUnlock")
	self.normalPanel = UIControls.Panel(self, self.mPath .. "/GroupOpenPanel")
	self.disablePanel = UIControls.Panel(self, self.mPath .. "/GroupLockPanel")
	self.rootBtn = UIControls.Button(self, self.mPath)

	self.rootBtn:addEventClick(self.onClickRoot)

	self.normalBg = UIControls.RawImage(self, self.mPath .. "/GroupOpenPanel/Bg")
	self.disableBg = UIControls.RawImage(self, self.mPath .. "/GroupLockPanel")
	self.activityImg = UIControls.Image(self, self.mPath .. "/IconActivity")
end

function GroupPanel:setGroupInfo(groupId, groupName, groupIcon)
	self.groupId = groupId
end

function GroupPanel:addEventClick(normalClickFunc, disableClickFunc)
	self.normalClickFunc = normalClickFunc
	self.disableClickFunc = disableClickFunc
end

function GroupPanel:onClickRoot()
	if self.unlocking then
		return
	end

	if self.groupEnabled then
		if self.normalClickFunc then
			self.normalClickFunc()
		end
	elseif self.disableClickFunc then
		self.disableClickFunc()
	end
end

function GroupPanel:setEnable(isEnable)
	self.groupEnabled = isEnable

	self.normalPanel:setVisible(isEnable)
	self.disablePanel:setVisible(not isEnable)

	if not isEnable then
		self.disablePanel:setObjGray(true)
	end
end

function GroupPanel:onSelected(isSelected)
	if self.groupEnabled then
		self.rootBtn:setEnable(not isSelected)
	end
end

function GroupPanel:playUnlockEfx(isPlay)
	self.unlockEfx:setVisible(isPlay)
end

function GroupPanel:replaceBg(bgPath)
	if bgPath then
		self.normalBg:setImage(bgPath)
		self.disableBg:setImage(bgPath)
	end
end

function GroupPanel:needActTab(need)
	self.activityImg:setVisible(need)
end

function GroupPanel:replaceActSign(imgPath, imgName)
	self.activityImg:setImage(imgPath, imgName)
end

function DrawGroupSelectDlg:ctor(...)
	self:initUI()
	self:initData()
end

function DrawGroupSelectDlg:initUI(...)
	self.groupBtns = {}
	self.maxGroupCount = 4

	for i = 1, self.maxGroupCount do
		local btn = GroupPanel(self, "BgPanel/BtnGroup" .. i)

		self.groupBtns[i] = btn
	end

	self.unlockAllBtn = UIControls.Button(self, "BgPanel/BtnGroupOpen", "TextNum")

	self.unlockAllBtn:addEventClick(self._onClickUnlockAll)

	self.unlockItemImg = UIControls.Image(self, "BgPanel/BtnGroupOpen/Icon")
	self.countdownTxt = UIControls.Label(self, "BgPanel/TextNumTime")
end

function DrawGroupSelectDlg:initData(...)
	local drawMiscInfo = ResDrawMisc[1]

	if not drawMiscInfo then
		return
	end

	self.unlockItem = drawMiscInfo.unlock_camp_id or Const.MONEY_ID_DIAMOND
	self.unlockCost = drawMiscInfo.unlock_camp_count or 300

	self.unlockAllBtn:setText(self.unlockCost)

	local moneyInfo = ClientUtils.getMoneyIcon(self.unlockItem)

	if moneyInfo then
		self.unlockItemImg:setImage(moneyInfo[1], moneyInfo[2])
	end

	local groupList = {
		1,
		2,
		3,
		100
	}

	for i = 1, self.maxGroupCount do
		local btn = self.groupBtns[i]
		local groupId = groupList[i]

		if not groupId then
			btn:setVisible(false)
		else
			btn:setVisible(true)
			btn:setGroupInfo(groupId)
			btn:addEventClick(Functor(self.selectGroup, self, groupId), Functor(self._onClickUnlock, self, groupId))
		end
	end

	self:_initReplacePool()
end

function DrawGroupSelectDlg:_initReplacePool(...)
	local actObjs = CurAvatar:getReplacePoolActivity()

	for poolId, actObj in pairs(actObjs) do
		local targetGroupId

		if poolId == Const.DrawPoolIdLightDark then
			targetGroupId = 100
		elseif poolId == Const.DrawPoolIdCamp then
			-- block empty
		end

		if targetGroupId then
			local detailData = actObj.actData:getNowUpDetail(poolId)
			local defaultDetailData = actObj.actData:getDefaultDetail(poolId)
			local bgPath

			if detailData then
				bgPath = detailData.group_bg
			else
				bgPath = defaultDetailData.ori_group_bg
			end

			local actPath, needActTab

			if detailData and detailData.tab_sign_path then
				needActTab = detailData.tab_sign == 1
				actPath = detailData.tab_sign_path
			elseif defaultDetailData and defaultDetailData.ori_tab_sign then
				needActTab = defaultDetailData.tab_sign == 1
				actPath = defaultDetailData.ori_tab_sign
			end

			for i, btn in ipairs(self.groupBtns) do
				if btn.groupId == targetGroupId then
					btn:replaceBg(bgPath)
					btn:needActTab(needActTab or false)

					if actPath then
						local imgPath = utils.splitString(actPath, ";")

						if imgPath and #imgPath == 2 then
							btn:replaceActSign(imgPath[1], imgPath[2])
						end
					end
				end
			end
		end
	end
end

function DrawGroupSelectDlg:refreshGroupsInfo(currentSelectGroup, nextChangeTick)
	local unlockFlag = CurAvatar:isAllGroupUnlock()
	local unlockThisTime = self.unlockToday == false and unlockFlag == true

	self.unlockToday = unlockFlag
	self.todayGroup = CurAvatar.todayDrawGroup or 1

	if CurAvatar:poolHasReplaced(Const.DrawPoolIdLightDark) then
		self.replaceGroup = Const.DrawCampLightDark
	end

	self:_refreshGroupsInfo(unlockThisTime)

	if currentSelectGroup then
		for i = 1, self.maxGroupCount do
			local btn = self.groupBtns[i]

			btn:onSelected(btn.groupId == currentSelectGroup)
		end
	end

	if nextChangeTick then
		local timeStr = utils.calcTimeTxt(nextChangeTick + 1)

		self.countdownTxt:setText(timeStr)
	end
end

function DrawGroupSelectDlg:selectGroup(groupId)
	local drawMainDlg = UIManager.getUI("drawCardMainDlg", nil, false)

	if drawMainDlg and drawMainDlg.poolPage and drawMainDlg.poolPage.selectGroup ~= nil then
		drawMainDlg.poolPage:selectGroup(groupId)
	end

	for i = 1, self.maxGroupCount do
		local btn = self.groupBtns[i]

		btn:onSelected(btn.groupId == groupId)
	end
end

function DrawGroupSelectDlg:_refreshGroupsInfo(showUnlockEfx)
	for i = 1, self.maxGroupCount do
		local btn = self.groupBtns[i]

		if btn then
			if showUnlockEfx then
				if self.todayGroup ~= btn.groupId or self.replaceGroup and self.replaceGroup ~= btn.groupId then
					btn:playUnlockEfx(true)

					btn.unlocking = true
				end
			else
				local groupIsUnlock = self.unlockToday or self.todayGroup == btn.groupId or self.replaceGroup and self.replaceGroup == btn.groupId

				btn:setEnable(groupIsUnlock)
			end
		end
	end

	if showUnlockEfx then
		self.unlockEfxTimer = Timer.New(Slot(self._delaySetBtns, self), DrawCardConfig.UNLOCK_GROUPS_LENGTH)

		self.unlockEfxTimer:Start()
	end

	self.unlockAllBtn:setVisible(not self.unlockToday)
end

function DrawGroupSelectDlg:_delaySetBtns(...)
	for i = 1, self.maxGroupCount do
		local btn = self.groupBtns[i]

		if btn then
			btn.unlocking = false

			btn:playUnlockEfx(false)
			btn:setEnable(true)
		end
	end

	if self.unlockDefaultGroupId then
		self:selectGroup(self.unlockDefaultGroupId)

		self.unlockDefaultGroupId = nil
	end

	self.unlockEfxTimer = nil
end

function DrawGroupSelectDlg:onOpen(...)
	DrawGroupSelectDlg.super.onOpen(self)
end

function DrawGroupSelectDlg:onClose(...)
	self:_stopCountDown()
	DrawGroupSelectDlg.super.onClose(self)
end

function DrawGroupSelectDlg:_onClickUnlockAll()
	self:_onClickUnlock()
end

function DrawGroupSelectDlg:_onClickUnlock(groupId)
	local function yesFunc()
		ClientUtils.checkMoneyChange(self.unlockItem, self.unlockCost, self._unlockYesFunc, self)
	end

	self.unlockDefaultGroupId = groupId

	local msgContent = string.format(Lang.get(31298), self.unlockCost)

	UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, "", msgContent, yesFunc, nil, -1, Lang.get(8), Lang.get(7))
end

function DrawGroupSelectDlg._unlockYesFunc()
	RPC.drawUnlockCamp()
end

function DrawGroupSelectDlg:_stopCountDown(...)
	if self.unlockEfxTimer then
		self.unlockEfxTimer:Stop()

		self.unlockEfxTimer = nil
	end
end

return DrawGroupSelectDlg
