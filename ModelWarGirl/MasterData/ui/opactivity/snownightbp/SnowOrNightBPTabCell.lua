-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\SnowNightBP\\SnowOrNightBPTabCell.lua

local strClassName = "SnowOrNightBPTabCell"
local SnowOrNightBPTabCell = Class(strClassName, UIControls.Child)
local ResOpActivityConditionLimit = require("ClientData/ResOpActivityConditionLimit")

function SnowOrNightBPTabCell:ctor()
	self:initUI()
end

function SnowOrNightBPTabCell:initUI()
	self.labelPanel = UIControls.Panel(self, "BtnTask/LabelPanel")
	self.efxSpecialPanel = UIControls.LazyEffectPlayer(self, "BtnTask/ImgSel/EfxSpecialPanel")
	self.efxUnLock = UIControls.LazyEffectPlayer(self, "BtnTask/EfxUnLockPanel/EfxUnLock")
	self.efxSpecialUnLock = UIControls.LazyEffectPlayer(self, "BtnTask/EfxUnLockPanel/EfxSpecialUnLock")
	self.iconNewOpen = UIControls.UIAni(self, "BtnTask/IconNewOpen")
	self.bgLock = UIControls.Image(self, "BtnTask/BgLock")
	self.efxPanel = UIControls.LazyEffectPlayer(self, "BtnTask/ImgSel/EfxPanel")
	self.imgSel = UIControls.Image(self, "BtnTask/ImgSel")
	self.imgStar = UIControls.Image(self, "BtnTask/HeroStarPanel/ImgStar")
	self.btnTask = UIControls.Button(self, "BtnTask")

	self.btnTask:addEventClick(self.onBtnTaskClick)

	self.taskPanel = UIControls.Panel(self, "BtnTask/TaskPanel")
	self.bg = UIControls.Image(self, "BtnTask/TaskPanel/Bg")
	self.textTask = UIControls.Label(self, "BtnTask/TaskPanel/TextTask")
	self.textLockTask = UIControls.Label(self, "BtnTask/TaskLockPanel/TextTask")
	self.taskLockPanel = UIControls.Panel(self, "BtnTask/TaskLockPanel")
	self.iconNew = UIControls.Image(self, "BtnTask/IconNew")
	self.imgHeroHead = UIControls.Image(self, "BtnTask/HeroStarPanel/Mask/ImgHeroHead")
	self.uiAni = UIControls.UIAni(self, "")
end

function SnowOrNightBPTabCell:setGroupTabData(resAchieveGroup, idx)
	self.resAchieveGroup = resAchieveGroup
	self.actData = self.mWindow.actObj.actData
	self.idx = idx
	self.isSelected = self.mWindow.currentPageIndex and self.mWindow.currentPageIndex == self.idx or false

	if self.resAchieveGroup.condition_id then
		self.isUnlock, self.lockDesc = CurAvatar:checkActivityConditionLimit(self.resAchieveGroup.condition_id)

		local groupUnlockData = self.actData:getGroupUnlockAchieveData(self.resAchieveGroup.group_id)

		if groupUnlockData then
			local achieveType = groupUnlockData.type
			local achieveIndex = groupUnlockData.index
			local miscData = self.actData:getAchieveMiscDataByType(achieveType)

			if miscData and miscData.arg then
				local needStar = self.actData.clientData[achieveType][achieveIndex].param
				local fakeHero = BaseObject.GetObject(miscData.arg)

				if fakeHero then
					local largeStarPath = fakeHero:getLargeStarPath(needStar)

					if largeStarPath then
						self.imgStar:setImage(largeStarPath[1], largeStarPath[2])
					end
				end
			end
		end
	else
		self.isUnlock = true
	end

	self.imgHeroHead:setImageGray(not self.isUnlock)
	self.imgStar:setImageGray(not self.isUnlock)
	self.taskLockPanel:setVisible(not self.isUnlock or self.actData.cacheNewUnlockGroup and self.actData.cacheNewUnlockGroup == self.resAchieveGroup.group_id)
	self.bgLock:setVisible(not self.isUnlock or self.actData.cacheNewUnlockGroup and self.actData.cacheNewUnlockGroup == self.resAchieveGroup.group_id)
	self.textLockTask:setText(self.resAchieveGroup.title or "")
	self.textTask:setText(self.resAchieveGroup.title or "")
	self.labelPanel:setVisible(self.resAchieveGroup.big_award_flag ~= nil)
	self.imgSel:setVisible(self.isSelected)

	if self.isSelected then
		if self.resAchieveGroup.big_award_flag then
			self.imgSel:setImage(self.mWindow.atlasFolderPath .. "/SnowOrNightBPAtlas", "BtnTapSpecialSel")
			self.efxPanel:setVisible(false)
			self.efxSpecialPanel:setVisible(true)
		else
			self.imgSel:setImage(self.mWindow.atlasFolderPath .. "/SnowOrNightBPAtlas", "BtnTapSel")
			self.efxPanel:setVisible(true)
			self.efxSpecialPanel:setVisible(false)
		end
	end

	local groupAwardAchieveData = self.actData:getGroupAwardAchieveData(self.resAchieveGroup.group_id)
	local groupAwardAchieveState

	if groupAwardAchieveData then
		groupAwardAchieveState = self.actData:getAchieveState(groupAwardAchieveData.type, groupAwardAchieveData.index)
	end

	if self.resAchieveGroup.big_award_flag then
		if groupAwardAchieveState == Const.ACT_ACHIEVE_STATE_GOT then
			self.taskPanel:playStateAnimator("FulSpeTaskTab")
		else
			self.taskPanel:playStateAnimator("NmlSpeTaskTab")
		end
	elseif groupAwardAchieveState == Const.ACT_ACHIEVE_STATE_GOT then
		self.taskPanel:playStateAnimator("FulTaskTab")
	else
		self.taskPanel:playStateAnimator("NmlTaskTab")
	end

	self.taskPanel:setVisible(self.isUnlock)
	self.iconNew:setVisible(groupAwardAchieveState == Const.ACT_ACHIEVE_STATE_ENOUGH and self.actData:isAllCompleteFromGroup(self.resAchieveGroup.group_id))
end

function SnowOrNightBPTabCell:playUnlock()
	self.uiAni:startAni("UnLockSnowOrNightBPTabCell", true)

	if self.resAchieveGroup.big_award_flag then
		self.efxSpecialUnLock:playEffect()
		self.efxSpecialUnLock:setVisible(true)
	else
		self.efxUnLock:playEffect()
		self.efxUnLock:setVisible(true)
	end
end

function SnowOrNightBPTabCell:onBtnTaskClick()
	self.mWindow:selectGroupTab(self)
end

return SnowOrNightBPTabCell
