-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainMenu\\MainMenuRecommendPanel.lua

local ResMainMenuActivityConfig = require("ClientData/ResMainMenuActivityConfig")
local ResActivityGatherConfig = require("ClientData/ResActivityGatherConfig")
local WorldBossCommon = require("Logic/WorldBoss/WorldBossCommon")
local ResRandClient = require("ClientData/ResRandClient")
local BTN_TYPE_ACTIVITY = 1
local BTN_TYPE_ACT_GATHER = 2
local BTN_TYPE_RENT = 3
local BTN_TYPE_CUSTOM_BTN = 4
local PREFAB_TYPE = {
	WORLD_BOSS = "worldboss"
}

local function JumpRebackBtn()
	CurAvatar:openRebackDlg()
end

local CUSTOM_BTN_CONFIG = {
	{
		"CheckRebackBtn",
		UIConst.RD_HINT_REBACK,
		JumpRebackBtn
	}
}
local MainMenuRecommendBtn = Class("MainMenuRecommendBtn", UIControls.Child)

function MainMenuRecommendBtn:ctor()
	self.btnSensor = UIControls.Button(self, "")

	self.btnSensor:addEventClick(self.onSensorClick)

	self.panelNew = UIControls.Panel(self, "IconNewContainer")
	self.btnRD = UIControls.RedDot(self, "IconNewContainer/IconNew")
	self.iconNewOpen = UIControls.RedDot(self, "IconNewOpen")
end

function MainMenuRecommendBtn:setData(btnConfig)
	self.btnConfig = btnConfig

	self.btnRD:clearHint()

	self.isGray = false

	if btnConfig.btn_type == BTN_TYPE_ACTIVITY then
		self.actId = btnConfig.btn_args[1]
		self.actObj = CurAvatar:getActivityObj(self.actId)

		if self.actObj then
			if not self.actObj:isValid() and self.btnConfig.show_condition and not ConditionLimitManager.inLimitState(self.btnConfig.show_condition) then
				self.btnSensor:setObjGray(true)

				self.isGray = true
			else
				if self.actObj.redDotId then
					self.btnRD:addHint({
						self.actObj.redDotId
					})
				end

				self.btnSensor:setObjGray(false)
			end

			if self.isGray then
				self.panelNew:setVisible(false)
				self.iconNewOpen:setVisible(false)
			elseif self.actObj:isNewOpened() then
				self.iconNewOpen:setVisible(true)
				self.panelNew:setVisible(false)
			else
				self.panelNew:setVisible(true)
				self.iconNewOpen:setVisible(false)
			end

			local btnName = "TextTime"

			if UIControls.checkControlFunc(self, btnName) then
				local leftTime = self.actObj:getRemainOpenTime()

				if leftTime > 0 then
					self.btnTime = UIControls.Label(self, btnName)

					ClientTimerManager.AddSecondFormatTickUI(self.btnTime, leftTime, false, Lang.get(48655), Slot(self._onTimeDownEnd, self), nil, 1)
				else
					self:setVisible(false)
				end
			end
		end
	elseif btnConfig.btn_type == BTN_TYPE_CUSTOM_BTN then
		self.customConfig = CUSTOM_BTN_CONFIG[btnConfig.btn_args[1]]

		if self.customConfig and self.customConfig[2] then
			self.panelNew:setVisible(true)
			self.btnRD:addHint({
				self.customConfig[2]
			})
		end
	end
end

function MainMenuRecommendBtn:onSensorClick()
	if self.actId and self.actObj then
		local isValid, unlockDesc = self.actObj:isValid()

		if isValid then
			CurAvatar:jumpToShowActivity(self.actId)

			if self.actObj:isNewOpened() then
				RPC.opActSetFocus(self.actObj.opId, 1)
			end
		else
			MsgManager.notice(unlockDesc)
		end
	elseif self.customConfig and self.customConfig[3] then
		self.customConfig[3]()
	end
end

function MainMenuRecommendBtn:_onTimeDownEnd(...)
	self.mParent:onRefresh()
end

local WorldBossBtn = Class("WorldBossBtn", MainMenuRecommendBtn)
local NAME_COLOR = {
	{
		g = 0.7764705882352941,
		b = 0,
		r = 1
	},
	{
		g = 0.6196078431372549,
		b = 0.00392156862745098,
		r = 1
	},
	{
		g = 0.17254901960784313,
		b = 0.17254901960784313,
		r = 1
	},
	{
		g = 0.8627450980392157,
		b = 1,
		r = 0.03137254901960784
	}
}
local COLOR_GRAY = {
	r = ResColor.GREYMAIN.r / 255,
	g = ResColor.GREYMAIN.g / 255,
	b = ResColor.GREYMAIN.b / 255
}

function WorldBossBtn:ctor(...)
	self:initUI()
end

function WorldBossBtn:initUI(...)
	self.imgIcon = UIControls.Image(self, "Img")
	self.txtName = UIControls.Label(self, "Text")
	self.imgLock = UIControls.Panel(self, "ImgLock")
	self.aniTip = UIControls.UIAni(self, "Text")
end

function WorldBossBtn:setData(btnConfig)
	WorldBossBtn.super.setData(self, btnConfig)
	ClientTimerManager.RemoveSecondTickUI(self.txtName)

	if self.actObj then
		local leftTime = WorldBossCommon.getCurBossLeftTime()

		self.aniTip:stopAni("LoopBtnWorldBoss")

		local bossInfo = self.actObj.actData:getCurBossInfo()

		self.imgIcon:setImage("Atlas/MainMenuAtlas/MainMenuActAtlas", "BtnWorldBoss" .. bossInfo.type)
		self.imgLock:setVisible(self.isGray)

		if self.isGray then
			self.txtName:setText(bossInfo.name)
		elseif leftTime >= 0 and leftTime <= WorldBossCommon.getConfigFrozenTime() then
			local redColor = NAME_COLOR[3]

			self.txtName:setColorByRGBA(redColor.r, redColor.g, redColor.b, 1)
			self.txtName:setText(Lang.get(30121))
		elseif leftTime > WorldBossCommon.getConfigFrozenTime() and leftTime <= 86400 then
			leftTime = leftTime - WorldBossCommon.getConfigFrozenTime()

			ClientTimerManager.AddSecondTickUI(self.txtName, leftTime, false, "", "", Slot(self._onTimeDownEnd, self))

			local redColor = NAME_COLOR[3]

			self.txtName:setColorByRGBA(redColor.r, redColor.g, redColor.b, 1)
			self.aniTip:startAniLoop("LoopBtnWorldBoss")
			self.imgLock:setVisible(false)
		else
			self.txtName:setText(bossInfo.name)

			local color = NAME_COLOR[bossInfo.type]

			self.txtName:setColorByRGBA(color.r, color.g, color.b, 1)
		end
	end
end

function WorldBossBtn:_onTimeDownEnd(...)
	self.mParent:onRefresh()
end

local WishSignInBtn = Class("WishSignInBtn", MainMenuRecommendBtn)

function WishSignInBtn:ctor()
	self.imgIcon = UIControls.Image(self, "ImgBack/Img")
	self.imgAwardIcon = UIControls.Image(self, "ImgBack/Img2")
	self.txtName = UIControls.Panel(self, "Text")
	self.txtTime = UIControls.Label(self, "TimeText")
end

function WishSignInBtn:setData(btnConfig)
	WishSignInBtn.super.setData(self, btnConfig)

	local state = self.actObj.actData:getState()
	local actData = self.actObj.actData

	self.iconNewOpen:setVisible(false)
	self.txtName:setVisible(true)
	self.txtTime:setVisible(false)
	ClientTimerManager.RemoveSecondTickUI(self.txtTime)

	if state == 3 then
		if #actData.wishPool > 0 then
			local awardId = actData.wishPool[#actData.wishPool].index

			if actData.resAwards[awardId] then
				local rewardId = actData.resAwards[awardId].reward_id
				local showId = ResRandClient[rewardId].show_ids[1]
				local obj = BaseObject.GetObject(showId)
				local iconPath = obj:getIconPath()

				if iconPath then
					self.imgAwardIcon:setImage(iconPath[1], iconPath[2])
					self.imgIcon:setVisible(false)
					self.imgAwardIcon:setVisible(true)
				end
			end
		end

		self.panelNew:setVisible(true)
		self.btnRD:setVisible(true)
		self.iconNewOpen:setVisible(false)
	elseif state == 2 then
		self.iconNewOpen:setVisible(false)
		self.panelNew:setVisible(false)
		self.imgIcon:setVisible(true)
		self.imgAwardIcon:setVisible(false)

		if actData.rewardTime and actData.rewardTime > 0 then
			local timeLeft = actData.rewardTime - ClientUtils.getServerTime()

			if timeLeft > 0 then
				ClientTimerManager.AddSecondTickUI(self.txtTime, timeLeft, false, "", "", Slot(self._onTimeDownEnd, self))
			end
		end

		self.txtName:setVisible(false)
		self.txtTime:setVisible(true)
	elseif state == 1 then
		self.iconNewOpen:setVisible(true)
		self.panelNew:setVisible(false)
		self.imgIcon:setVisible(true)
		self.imgAwardIcon:setVisible(false)
	else
		self.iconNewOpen:setVisible(false)
		self.panelNew:setVisible(false)
		self.imgIcon:setVisible(true)
		self.imgAwardIcon:setVisible(false)
	end
end

function WishSignInBtn:_onTimeDownEnd(...)
	self.txtName:setVisible(true)
	self.txtTime:setVisible(false)
	self.mParent:onRefresh()
end

local ActivityGatherBtn = Class("ActivityGatherBtn", MainMenuRecommendBtn)

function ActivityGatherBtn:ctor()
	self.panelWillEnd = UIControls.Panel(self, "TimeUpPanel")
end

function ActivityGatherBtn:setData(btnConfig)
	self.btnConfig = btnConfig

	self.btnRD:clearHint()

	local newOpen = false
	local willEnd = false
	local rdId = {}

	for _, configInfo in ipairs(ResActivityGatherConfig) do
		if configInfo.btn_type == BTN_TYPE_ACTIVITY then
			local actObj

			for _, actId in ipairs(configInfo.btn_args) do
				actObj = CurAvatar:getActivityObj(actId)

				if actObj and actObj:isValid() then
					break
				end
			end

			if actObj and actObj:isValid() then
				if actObj.redDotId then
					table.insert(rdId, actObj.redDotId)
				end

				if configInfo.pos ~= 1 and actObj:isNewOpened() then
					newOpen = true

					break
				end

				if actObj:willEnd() then
					willEnd = true
				end
			end
		elseif configInfo.btn_type == BTN_TYPE_RENT and CurAvatar.rentTaskFlag then
			local isValid = not ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_RENTTASK)

			if isValid then
				self.btnRD:addHint({
					UIConst.RD_HINT_RENT_MAIN
				})
			end
		end
	end

	if willEnd then
		self.panelWillEnd:setVisible(true)
		self.iconNewOpen:setVisible(false)
		self.panelNew:setVisible(false)
	elseif newOpen then
		self.panelWillEnd:setVisible(false)
		self.iconNewOpen:setVisible(true)
		self.panelNew:setVisible(false)
	else
		self.panelWillEnd:setVisible(false)
		self.iconNewOpen:setVisible(false)
		self.panelNew:setVisible(true)

		if #rdId > 0 then
			self.btnRD:addHint(rdId)
		end
	end
end

function ActivityGatherBtn:onSensorClick()
	UIManager.getUI("activityGatherMainDlg", true)

	local actId = CurAvatar:getTopPVPActivityOpId()

	if actId then
		local actData = CurAvatar:getTopPVPActivityData()

		if actData then
			local check = actData:checkTopPvpCrossdata()

			if check then
				RPC.bPPvpActivityStateGet(actId)
			end
		end
	end
end

local function ActGatherOpened()
	for _, configInfo in ipairs(ResActivityGatherConfig) do
		if configInfo.pos ~= 1 then
			if configInfo.btn_type == BTN_TYPE_ACTIVITY then
				if configInfo.btn_args then
					for _, actId in ipairs(configInfo.btn_args) do
						local actObj = CurAvatar:getActivityObj(actId)

						if actObj and actObj:isValid() then
							return true
						end
					end

					if configInfo.show_condition and not ConditionLimitManager.inLimitState(configInfo.show_condition) then
						return true
					end
				end
			elseif configInfo.btn_type == BTN_TYPE_RENT and CurAvatar.rentTaskFlag then
				if not ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_RENTTASK) then
					return true
				end

				if configInfo.show_condition and not ConditionLimitManager.inLimitState(configInfo.show_condition) then
					return true
				end
			end
		end
	end

	return false
end

local PREFAB_INFO = {
	worldboss = WorldBossBtn,
	wishSignIn = WishSignInBtn,
	actgather = ActivityGatherBtn,
	customBtn = MainMenuRecommendBtn
}
local MainMenuRecommendPanel = Class("MainMenuRecommendPanel", UIControls.Panel)

function MainMenuRecommendPanel:ctor()
	self.recomBtns = {}
	self.moreBtns = {}
	self.btnMore = UIControls.Button(self, self.mPath .. "/BtnMoreActivity")

	self.btnMore:addEventClick(self.onMoreClick)

	self.imgMore = UIControls.Image(self, self.mPath .. "/BtnMoreActivity/ImgArrow")
	self.rdMore = UIControls.RedDot(self, self.mPath .. "/BtnMoreActivity/IconNew")
end

local SORT_FUNC = utils.getSortingFunc("priority")

function MainMenuRecommendPanel:onRefresh()
	local sortData = {}
	local hideIds = {}

	self.showData = {}

	for index, btnConfig in ipairs(ResMainMenuActivityConfig) do
		local canShow = false

		if btnConfig.prefab and btnConfig.btn_type == BTN_TYPE_ACTIVITY then
			local actId = btnConfig.btn_args[1]

			if CurAvatar:isActivityValid(actId) then
				canShow = true
			elseif btnConfig.show_condition and not ConditionLimitManager.inLimitState(btnConfig.show_condition) then
				canShow = true
			end
		elseif btnConfig.btn_type == BTN_TYPE_ACT_GATHER then
			if (not VersionUtils.IsReviewVersion() or not RegionUtils.isJP()) and ActGatherOpened() then
				for _, hideIndex in ipairs(btnConfig.btn_args) do
					hideIds[hideIndex] = true
					self.showData[hideIndex] = nil

					for pos, sData in ipairs(sortData) do
						if sData.id == hideIndex then
							table.remove(sortData, pos)

							break
						end
					end

					if self.recomBtns[hideIndex] then
						self.recomBtns[hideIndex]:setVisible(false)
					end
				end

				canShow = true
			end
		elseif btnConfig.btn_type == BTN_TYPE_CUSTOM_BTN then
			local config = CUSTOM_BTN_CONFIG[btnConfig.btn_args[1]]

			if config and self[config[1]](self) then
				canShow = true
			end
		end

		if canShow and not hideIds[index] then
			self.showData[index] = btnConfig

			table.insert(sortData, btnConfig)
		end
	end

	for _, btn in pairs(self.recomBtns) do
		btn:setVisible(false)
	end

	table.sort(sortData, SORT_FUNC)

	self.moreData = {}

	for index, btnConfig in ipairs(sortData) do
		local btnKey = btnConfig.id

		if not self.recomBtns[btnKey] then
			local childClass = MainMenuRecommendBtn

			if PREFAB_INFO[btnConfig.prefab_type] then
				childClass = PREFAB_INFO[btnConfig.prefab_type]
			end

			self.recomBtns[btnKey] = childClass(self, self.mPath, "System/MainMenu/" .. btnConfig.prefab)
		end

		if index <= 2 then
			self.recomBtns[btnKey]:setVisible(true)
			self.recomBtns[btnKey]:setData(btnConfig)
		else
			table.insert(self.moreData, btnConfig)
		end
	end

	if next(self.showData) then
		self:setVisible(true)

		if #self.moreData >= 1 then
			self.btnMore:setVisible(true)
			self.rdMore:clearHint()

			local moreHint = {}

			for _, btnConfig in ipairs(self.moreData) do
				if btnConfig.btn_type == BTN_TYPE_ACTIVITY then
					local actObj = CurAvatar:getActivityObj(btnConfig.btn_args[1])

					if not actObj or not actObj:isValid() and btnConfig.show_condition and not ConditionLimitManager.inLimitState(btnConfig.show_condition) then
						-- block empty
					elseif actObj.redDotId then
						table.insert(moreHint, actObj.redDotId)
					end
				end
			end

			if #moreHint > 0 then
				self.rdMore:addHint(moreHint)
			end
		else
			self.btnMore:setVisible(false)
		end
	else
		self:setVisible(false)
	end

	self.panelMore:setVisible(false)
	self.imgMore:setRotate(0, 0)
end

function MainMenuRecommendPanel:setMorePanelPath(morePath)
	self.morePath = morePath
	self.panelMore = UIControls.Button(self.mParent, morePath)

	self.panelMore:addEventClick(self.onPanelMoreClick)
	self.panelMore:setVisible(false)
end

function MainMenuRecommendPanel:onMoreClick()
	if self.panelMore:getVisible() then
		self.panelMore:setVisible(false)
	else
		self:showMorePanel()
	end
end

function MainMenuRecommendPanel:onPanelMoreClick(sender)
	sender:setVisible(false)
	self.mWindow.panelRecommendBtn.imgMore:setRotate(0, 0)
end

function MainMenuRecommendPanel:showMorePanel()
	self.panelMore:setVisible(true)
	self.imgMore:setRotate(180, 0)

	for index, child in ipairs(self.moreBtns) do
		child:destroy()
	end

	self.moreBtns = {}

	for index, btnConfig in ipairs(self.moreData) do
		local childClass = MainMenuRecommendBtn

		if PREFAB_INFO[btnConfig.prefab_type] then
			childClass = PREFAB_INFO[btnConfig.prefab_type]
		end

		local newBtn = childClass(self.mParent, self.morePath .. "/RecActivityPanel", "System/MainMenu/" .. btnConfig.prefab)

		newBtn:setVisible(true)
		newBtn:setData(btnConfig)
		table.insert(self.moreBtns, newBtn)
	end
end

function MainMenuRecommendPanel:CheckRebackBtn()
	return CurAvatar:rebackEntryEnable()
end

return MainMenuRecommendPanel
