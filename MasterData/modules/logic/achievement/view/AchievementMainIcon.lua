-- chunkname: @modules/logic/achievement/view/AchievementMainIcon.lua

module("modules.logic.achievement.view.AchievementMainIcon", package.seeall)

local AchievementMainIcon = class("AchievementMainIcon", UserDataDispose)

function AchievementMainIcon:init(go)
	self:__onInit()

	self.viewGO = go

	self:initComponents()
end

function AchievementMainIcon:initComponents()
	self._txtname = gohelper.findChildText(self.viewGO, "#txt_name")
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "#image_icon")
	self._imageicon = gohelper.findChildImage(self.viewGO, "#image_icon")
	self._goLocked = gohelper.findChild(self.viewGO, "#go_Locked")
	self._goselect = gohelper.findChild(self.viewGO, "#go_select")
	self._index = gohelper.findChildText(self.viewGO, "#go_select/#txt_index")
	self._goBadgeBG = gohelper.findChild(self.viewGO, "#go_BadgeBG")
	self._goBadgeGetBG = gohelper.findChild(self.viewGO, "#go_BadgeGetBG")
	self._animator = gohelper.onceAddComponent(self.viewGO, typeof(UnityEngine.Animator))
end

function AchievementMainIcon:setData(taskCO)
	self.taskCO = taskCO
	self._animClipName = nil
	self._isBgVisible = true

	self:refreshUI()
end

function AchievementMainIcon:getTaskCO()
	return self.taskCO
end

function AchievementMainIcon:setIsLocked(isLocked)
	gohelper.setActive(self._goLocked, isLocked)
end

function AchievementMainIcon:setIconColor(color)
	SLFramework.UGUI.GuiHelper.SetColor(self._imageicon, color or "#FFFFFF")
end

function AchievementMainIcon:setIconVisible(isVisible)
	gohelper.setActive(self._imageicon.gameObject, isVisible)
end

function AchievementMainIcon:setBgVisible(isVisible)
	self._isBgVisible = isVisible

	self:refreshBg()
end

function AchievementMainIcon:refreshBg()
	local isTaskFinished = false

	if self._isBgVisible then
		if self.taskCO then
			isTaskFinished = AchievementModel.instance:isAchievementTaskFinished(self.taskCO)
		end
	end

	gohelper.setActive(self._goBadgeBG.gameObject, self._isBgVisible and not isTaskFinished)
	gohelper.setActive(self._goBadgeGetBG.gameObject, self._isBgVisible and isTaskFinished)
end

function AchievementMainIcon:setNameTxtAlpha(alpha)
	ZProj.UGUIHelper.SetColorAlpha(self._txtname, alpha or 1)
end

function AchievementMainIcon:setNameTxtVisible(isVisible)
	gohelper.setActive(self._txtname, isVisible)
end

function AchievementMainIcon:setSelectIconVisible(isVisible)
	gohelper.setActive(self._goselect, isVisible)
end

function AchievementMainIcon:setSelectIndex(index)
	self._index.text = tostring(index)
end

function AchievementMainIcon:refreshUI()
	local achievementCO = AchievementConfig.instance:getAchievement(self.taskCO.achievementId)

	if achievementCO then
		self._txtname.text = achievementCO.name
	end

	if not string.nilorempty(self.taskCO.icon) then
		self._simageicon:LoadImage(ResUrl.getAchievementIcon("badgeicon/" .. self.taskCO.icon))
	end

	self:refreshBg()
end

function AchievementMainIcon:setClickCall(callback, callbackObj, param)
	self._clickCallback = callback
	self._clickCallbackObj = callbackObj
	self._clickParam = param

	if not self._btnself then
		self._btnself = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_self")

		self._btnself:AddClickListener(self.onClickSelf, self)
	end
end

function AchievementMainIcon:onClickSelf()
	if self._clickCallback then
		self._clickCallback(self._clickCallbackObj, self._clickParam)
	end
end

AchievementMainIcon.AnimClip = {
	New = "unlock",
	Idle = "idle",
	Loop = "loop"
}

function AchievementMainIcon:playAnim(animClipName)
	self._animator:Play(animClipName, 0, 0)
end

function AchievementMainIcon:isPlaingAnimClip(animClipName)
	local stateInfo = self._animator:GetCurrentAnimatorStateInfo(0)

	return stateInfo:IsName(animClipName)
end

function AchievementMainIcon:dispose()
	self._clickCallback = nil
	self._clickCallbackObj = nil
	self._clickParam = nil

	if self._btnself then
		self._btnself:RemoveClickListener()

		self._btnself = nil
	end

	self._simageicon:UnLoadImage()
	self:__onDispose()
end

return AchievementMainIcon
