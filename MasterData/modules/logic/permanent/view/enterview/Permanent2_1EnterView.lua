-- chunkname: @modules/logic/permanent/view/enterview/Permanent2_1EnterView.lua

module("modules.logic.permanent.view.enterview.Permanent2_1EnterView", package.seeall)

local Permanent2_1EnterView = class("Permanent2_1EnterView", BaseView)

function Permanent2_1EnterView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._btnEntranceRole1 = gohelper.findChildButtonWithAudio(self.viewGO, "Left/EntranceRole1/#btn_EntranceRole1")
	self._goReddot1 = gohelper.findChild(self.viewGO, "Left/EntranceRole1/#go_Reddot1")
	self._btnEntranceRole2 = gohelper.findChildButtonWithAudio(self.viewGO, "Left/EntranceRole2/#btn_EntranceRole2")
	self._goReddot2 = gohelper.findChild(self.viewGO, "Left/EntranceRole2/#go_Reddot2")
	self._btnPlay = gohelper.findChildButtonWithAudio(self.viewGO, "Title/#btn_Play")
	self._btnAchievement = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_Achievement")
	self._btnEntranceDungeon = gohelper.findChildButtonWithAudio(self.viewGO, "Right/EntranceDungeon/#btn_EntranceDungeon")
	self._goReddot = gohelper.findChild(self.viewGO, "Right/EntranceDungeon/#go_Reddot")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Permanent2_1EnterView:addEvents()
	self.addClickCb(self, self._btnEntranceRole1, self._btnEntranceRole1OnClick, self)
	self.addClickCb(self, self._btnEntranceRole2, self._btnEntranceRole2OnClick, self)
	self.addClickCb(self, self._btnPlay, self._btnPlayOnClick, self)
	self.addClickCb(self, self._btnAchievement, self._btnAchievementOnClick, self)
	self.addClickCb(self, self._btnEntranceDungeon, self._btnEntranceDungeonOnClick, self)
	self.addEventCb(self, Activity165Controller.instance, Activity165Event.refreshStoryReddot, self._act165RedDot, self)
end

function Permanent2_1EnterView:removeEvents()
	self.removeEventCb(self, Activity165Controller.instance, Activity165Event.refreshStoryReddot, self._act165RedDot, self)
end

local kRoleIndex2ActId = {
	{
		actId = VersionActivity2_1Enum.ActivityId.LanShouPa,
		redDotId = RedDotEnum.DotNode.V2a1LanShouPaTaskRed
	},
	{
		actId = VersionActivity2_1Enum.ActivityId.Aergusi,
		redDotId = RedDotEnum.DotNode.V2a1AergusiTaskRed
	}
}

Permanent2_1EnterView.kRoleIndex2ActId = kRoleIndex2ActId

local function _getActId(roleIndex)
	local actInfo = kRoleIndex2ActId[roleIndex]

	return (actInfo or nil) and (actInfo.actId or 0)
end

local function _getRedDotId(roleIndex)
	local actInfo = kRoleIndex2ActId[roleIndex]

	return (actInfo or nil) and (actInfo.redDotId or 0)
end

local function _addRedDot(goReddot, roleIndex)
	local actId = _getActId(roleIndex)
	local activityCo = ActivityConfig.instance:getActivityCo(actId)
	local redDotId = _getRedDotId(roleIndex) or activityCo.redDotId

	RedDotController.instance:addRedDot(goReddot, redDotId, actId)
end

local function _showLanShouPa(actId, isReqInfo)
	if isReqInfo == nil then
		isReqInfo = true
	end

	LanShouPaController.instance:openLanShouPaMapView(actId or _getActId(1), isReqInfo)
end

local function _showAergusi(actId, isReqInfo)
	if isReqInfo == nil then
		isReqInfo = true
	end

	AergusiController.instance:openAergusiLevelView(actId or _getActId(2), isReqInfo)
end

function Permanent2_1EnterView:_btnEntranceRole1OnClick()
	_showLanShouPa()
end

function Permanent2_1EnterView:_btnEntranceRole2OnClick()
	_showAergusi()
end

function Permanent2_1EnterView:_btnPlayOnClick()
	local param = {}

	param.isVersionActivityPV = true

	StoryController.instance:playStory(self.actCfg.storyId, param)
end

function Permanent2_1EnterView:_btnAchievementOnClick()
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Achievement) then
		ViewMgr.instance:openView(ViewName.AchievementMainView, {
			categoryType = AchievementEnum.Type.Activity
		})
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Achievement))
	end
end

function Permanent2_1EnterView:_btnEntranceDungeonOnClick()
	VersionActivity2_1DungeonController.instance:openVersionActivityDungeonMapView()
end

function Permanent2_1EnterView:_editableInitView()
	self.actCfg = ActivityConfig.instance:getActivityCo(VersionActivity2_1Enum.ActivityId.EnterView)

	gohelper.setActive(self._btnAchievement.gameObject, false)

	self._commonRedDotIcon = RedDotController.instance:addRedDot(self._goReddot, 0, 0, self._act165RedDotOverrideRefreshFunc, self)
end

function Permanent2_1EnterView:onOpen()
	if self.viewParam then
		local viewParam = self.viewParam

		if viewParam.isJumpAergusi then
			_showAergusi(viewParam.roleActId, viewParam.roleActNeedReqInfo)
		elseif viewParam.isJumpLanShouPa then
			_showLanShouPa(viewParam.roleActId, viewParam.roleActNeedReqInfo)
		end
	end

	_addRedDot(self._goReddot1, 1)
	_addRedDot(self._goReddot2, 2)
end

function Permanent2_1EnterView:onClose()
	PermanentModel.instance:undateActivityInfo(self.actCfg.id)
end

function Permanent2_1EnterView:_act165RedDotOverrideRefreshFunc(redDotIcon)
	redDotIcon.show = Activity165Model.instance:isShowAct165Reddot()

	redDotIcon:showRedDot(RedDotEnum.Style.Normal)
end

function Permanent2_1EnterView:_act165RedDot()
	self._commonRedDotIcon:refreshDot()
end

return Permanent2_1EnterView
