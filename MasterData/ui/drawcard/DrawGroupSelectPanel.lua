-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\DrawCard\\DrawGroupSelectPanel.lua

local ResDrawMisc = require("ClientData/ResDrawMisc")
local DrawCardConfig = require("DesignerScript/DrawCardConfig")
local strClassName = "DrawCardSelectPanel"
local DrawCardSelectPanel = Class(strClassName, UIControls.Panel)
local GroupPanel = Class("GroupPanel", UIControls.Panel)

function GroupPanel:ctor(...)
	self:initUI()
end

function GroupPanel:initUI(...)
	self.rootBtn = UIControls.Button(self, self.mPath)

	self.rootBtn:addEventClick(self.onClickRoot)

	self.normalPanel = UIControls.Panel(self, self.mPath .. "/NmlPanel")
	self.lockPanel = UIControls.Panel(self, self.mPath .. "/LockPanel")
	self.lockImg = UIControls.Panel(self, self.mPath .. "/LockPanel/Lock")
	self.normalBg = UIControls.Image(self, self.mPath .. "/NmlPanel")
	self.unlockEfx = UIControls.Panel(self, self.mPath .. "/LockPanel/EfxPanel")
end

function GroupPanel:initExtraUI()
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
	self.lockPanel:setVisible(not isEnable)
end

function GroupPanel:playUnlockEfx(isPlay)
	self.unlockEfx:setVisible(isPlay)
	self.lockImg:setVisible(not isPlay)
end

function GroupPanel:onSelected(isSelected)
	if self.groupEnabled then
		self.rootBtn:setEnable(not isSelected)

		local iconPath, iconName

		if isSelected then
			iconPath = "Atlas/HeroPoolAtlas/HeroPoolAtlas"
			iconName = "BtnCampSelectionSel"
		else
			iconPath = "Atlas/HeroPoolAtlas/HeroPoolAtlas"
			iconName = "BtnCampSelectionNml"
		end

		self.normalBg:setImage(iconPath, iconName)
	end
end

function GroupPanel:needActTab(need)
	if self.activityImg then
		self.activityImg:setVisible(need)
	end
end

function GroupPanel:replaceActSign(imgPath, imgName)
	if self.activityImg then
		self.activityImg:setImage(imgPath, imgName)
	end
end

function DrawCardSelectPanel:ctor(...)
	self:initUI()
	self:initData()
end

function DrawCardSelectPanel:initUI(...)
	self.groupBtns = {}
	self.maxGroupCount = 4

	for i = 1, self.maxGroupCount do
		local btn = GroupPanel(self, "BtnGroup" .. i)

		if i == 4 then
			btn:initExtraUI()
		end

		self.groupBtns[i] = btn
	end
end

function DrawCardSelectPanel:initData(...)
	local drawMiscInfo = ResDrawMisc[1]

	if not drawMiscInfo then
		return
	end

	self.unlockItem = drawMiscInfo.unlock_camp_id or Const.MONEY_ID_DIAMOND
	self.unlockCost = drawMiscInfo.unlock_camp_count or 300

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

	self:initReplacePool()
end

function DrawCardSelectPanel:initReplacePool(...)
	local actObjs = CurAvatar:getReplacePoolActivity()
	local hasReplaceAct = false

	for poolId, actObj in pairs(actObjs) do
		local targetGroupId

		if poolId == Const.DrawPoolIdLightDark then
			targetGroupId = 100
		elseif poolId == Const.DrawPoolIdCamp then
			-- block empty
		end

		if targetGroupId then
			hasReplaceAct = true

			local detailData = actObj.actData:getNowUpDetail(poolId)
			local defaultDetailData = actObj.actData:getDefaultDetail(poolId)
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

	if not hasReplaceAct then
		for i, btn in ipairs(self.groupBtns) do
			btn:needActTab(false)
		end
	end
end

function DrawCardSelectPanel:refreshGroupsInfo(currentSelectGroup, nextChangeTick)
	local unlockFlag = CurAvatar:isAllGroupUnlock()
	local unlockThisTime = self.unlockToday == false and unlockFlag == true

	self.unlockToday = unlockFlag
	self.todayGroup = CurAvatar.todayDrawGroup or 1

	if CurAvatar:poolHasReplaced(Const.DrawPoolIdLightDark) then
		self.replaceGroup = Const.DrawCampLightDark
	else
		self.replaceGroup = nil
	end

	self:_refreshGroupsInfo(unlockThisTime)

	if currentSelectGroup then
		for i = 1, self.maxGroupCount do
			local btn = self.groupBtns[i]

			btn:onSelected(btn.groupId == currentSelectGroup)
		end
	end
end

function DrawCardSelectPanel:selectGroup(groupId)
	local drawMainDlg = UIManager.getUI("drawCardMainDlg", nil, false)

	if drawMainDlg and drawMainDlg.poolPage and drawMainDlg.poolPage.selectGroup ~= nil then
		drawMainDlg.poolPage:selectGroup(groupId)
	end

	for i = 1, self.maxGroupCount do
		local btn = self.groupBtns[i]

		btn:onSelected(btn.groupId == groupId)
	end
end

function DrawCardSelectPanel:_refreshGroupsInfo(showUnlockEfx)
	for i = 1, self.maxGroupCount do
		local btn = self.groupBtns[i]

		if btn then
			if showUnlockEfx then
				if self.todayGroup ~= btn.groupId and (not self.replaceGroup or self.replaceGroup ~= btn.groupId) then
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
end

function DrawCardSelectPanel:_delaySetBtns(...)
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

function DrawCardSelectPanel:onPanelClose()
	self:_stopCountDown()
end

function DrawCardSelectPanel:_onClickUnlock(groupId)
	local function yesFunc()
		ClientUtils.checkMoneyChange(self.unlockItem, self.unlockCost, self._unlockYesFunc)
	end

	self.unlockDefaultGroupId = groupId

	local msgContent = string.format(Lang.get(31298), self.unlockCost)

	UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, "", msgContent, yesFunc, nil, -1, Lang.get(8), Lang.get(7))
end

function DrawCardSelectPanel._unlockYesFunc()
	RPC.drawUnlockCamp()
end

function DrawCardSelectPanel:_stopCountDown(...)
	if self.unlockEfxTimer then
		self.unlockEfxTimer:Stop()

		self.unlockEfxTimer = nil
	end
end

return DrawCardSelectPanel
