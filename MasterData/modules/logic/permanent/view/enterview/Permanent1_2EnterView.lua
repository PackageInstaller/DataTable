-- chunkname: @modules/logic/permanent/view/enterview/Permanent1_2EnterView.lua

module("modules.logic.permanent.view.enterview.Permanent1_2EnterView", package.seeall)

local Permanent1_2EnterView = class("Permanent1_2EnterView", BaseView)

function Permanent1_2EnterView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._btnEntranceRole1 = gohelper.findChildButtonWithAudio(self.viewGO, "Left/EntranceRole1/#btn_EntranceRole1")
	self._goReddot1 = gohelper.findChild(self.viewGO, "Left/EntranceRole1/#go_Reddot1")
	self._btnEntranceRole2 = gohelper.findChildButtonWithAudio(self.viewGO, "Left/EntranceRole2/#btn_EntranceRole2")
	self._goReddot2 = gohelper.findChild(self.viewGO, "Left/EntranceRole2/#go_Reddot2")
	self._btnPlay = gohelper.findChildButtonWithAudio(self.viewGO, "Title/#btn_Play")
	self._btnEntranceDungeon = gohelper.findChildButtonWithAudio(self.viewGO, "Right/EntranceDungeon/#btn_EntranceDungeon")
	self._goReddot3 = gohelper.findChild(self.viewGO, "Right/#go_Reddot3")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Permanent1_2EnterView:addEvents()
	self._btnEntranceRole1:AddClickListener(self._btnEntranceRole1OnClick, self)
	self._btnEntranceRole2:AddClickListener(self._btnEntranceRole2OnClick, self)
	self._btnPlay:AddClickListener(self._btnPlayOnClick, self)
	self._btnEntranceDungeon:AddClickListener(self._btnEntranceDungeonOnClick, self)
end

function Permanent1_2EnterView:removeEvents()
	self._btnEntranceRole1:RemoveClickListener()
	self._btnEntranceRole2:RemoveClickListener()
	self._btnPlay:RemoveClickListener()
	self._btnEntranceDungeon:RemoveClickListener()
end

function Permanent1_2EnterView:_btnEntranceRole1OnClick()
	local activityCO = ActivityConfig.instance:getActivityCo(VersionActivity1_2Enum.ActivityId.YaXian)
	local condition = activityCO.confirmCondition

	if string.nilorempty(condition) then
		YaXianController.instance:openYaXianMapView()
	else
		local strs = string.split(condition, "=")
		local openId = tonumber(strs[2])
		local userid = PlayerModel.instance:getPlayinfo().userId
		local key = PlayerPrefsKey.EnterRoleActivity .. "#" .. tostring(VersionActivity1_2Enum.ActivityId.YaXian) .. "#" .. tostring(userid)
		local hasTiped = PlayerPrefsHelper.getNumber(key, 0) == 1

		if OpenModel.instance:isFunctionUnlock(openId) or hasTiped then
			YaXianController.instance:openYaXianMapView()
		else
			local openCO = OpenConfig.instance:getOpenCo(openId)
			local dungeonDisplay = DungeonConfig.instance:getEpisodeDisplay(openCO.episodeId)
			local dungeonName = DungeonConfig.instance:getEpisodeCO(openCO.episodeId).name
			local name = dungeonDisplay .. dungeonName

			GameFacade.showMessageBox(MessageBoxIdDefine.RoleActivityOpenTip, MsgBoxEnum.BoxType.Yes_No, function()
				PlayerPrefsHelper.setNumber(key, 1)
				YaXianController.instance:openYaXianMapView()
			end, nil, nil, nil, nil, nil, name)
		end
	end
end

function Permanent1_2EnterView:_btnEntranceRole2OnClick()
	Activity114Controller.instance:openAct114View()
end

function Permanent1_2EnterView:_btnPlayOnClick()
	local param = {}

	param.isVersionActivityPV = true

	StoryController.instance:playStory(self.actCfg.storyId, param)
end

function Permanent1_2EnterView:_btnEntranceDungeonOnClick()
	VersionActivity1_2DungeonController.instance:openDungeonView()
end

function Permanent1_2EnterView:_editableInitView()
	self.actCfg = ActivityConfig.instance:getActivityCo(VersionActivity1_2Enum.ActivityId.EnterView)
end

function Permanent1_2EnterView:onOpen()
	local act1MO = ActivityConfig.instance:getActivityCo(VersionActivity1_2Enum.ActivityId.YaXian)
	local act2MO = ActivityConfig.instance:getActivityCo(VersionActivity1_2Enum.ActivityId.JieXiKa)
	local act3MO = ActivityConfig.instance:getActivityCo(VersionActivity1_2Enum.ActivityId.Dungeon)

	if act1MO.redDotId ~= 0 then
		RedDotController.instance:addRedDot(self._goReddot1, act1MO.redDotId)
	end

	if act2MO.redDotId ~= 0 then
		RedDotController.instance:addRedDot(self._goReddot2, act2MO.redDotId)
	end

	if act3MO.redDotId ~= 0 then
		RedDotController.instance:addRedDot(self._goReddot3, act3MO.redDotId)
	end
end

function Permanent1_2EnterView:onClose()
	PermanentModel.instance:undateActivityInfo(self.actCfg.id)
end

return Permanent1_2EnterView
