-- chunkname: @modules/logic/versionactivity3_7/towerv3a7/view/TowerV3a7MapStoryView.lua

module("modules.logic.versionactivity3_7.towerv3a7.view.TowerV3a7MapStoryView", package.seeall)

local TowerV3a7MapStoryView = class("TowerV3a7MapStoryView", BaseView)

function TowerV3a7MapStoryView:onInitView()
	self._godialogcontainer = gohelper.findChild(self.viewGO, "#go_dialogcontainer")
	self._godialog = gohelper.findChild(self.viewGO, "#go_dialogcontainer/#go_dialog")
	self._simagedialogicon = gohelper.findChildSingleImage(self._godialogcontainer, "#go_dialog/container/headframe/headicon")
	self._txtcontentcn = gohelper.findChildText(self.viewGO, "#go_dialogcontainer/#go_dialog/container/go_normalcontent/#txt_contentcn")
	self._btnstory = gohelper.findChildButtonWithAudio(self.viewGO, "#go_dialogcontainer/#btn_story")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TowerV3a7MapStoryView:addEvents()
	self._btnstory:AddClickListener(self._btnstoryOnClick, self)
end

function TowerV3a7MapStoryView:removeEvents()
	self._btnstory:RemoveClickListener()
end

function TowerV3a7MapStoryView:_btnstoryOnClick()
	self._stepIndex = self._stepIndex + 1

	self:_showStoryStep(self._stepIndex)
end

function TowerV3a7MapStoryView:_editableInitView()
	gohelper.setActive(self._godialogcontainer, false)
end

function TowerV3a7MapStoryView:onOpen()
	self._storyList = TowerV3a7Model.instance:getStoryList()

	self.addEventCb(self, TowerV3a7Controller.instance, TowerV3a7Event.StoryAddChessMan, self._onStoryAddChessMan, self)
	self.addEventCb(self, TowerV3a7Controller.instance, TowerV3a7Event.StoryDeadChessMan, self._onStoryDeadChessMan, self)
	self.addEventCb(self, TowerV3a7Controller.instance, TowerV3a7Event.StoryFinishTarget, self._onStoryFinishTarget, self)
	self.addEventCb(self, TowerV3a7Controller.instance, TowerV3a7Event.StoryPlay, self._onStoryPlay, self)
end

function TowerV3a7MapStoryView:_onStoryPlay(storyId)
	if not self._storyList then
		return
	end

	local storyList = lua_tower_v3a7_story.configDict[storyId]

	self:_showStory(storyList, storyId)
end

function TowerV3a7MapStoryView:_onStoryAddChessMan(mo)
	if not self._storyList then
		return
	end

	for i, v in ipairs(self._storyList) do
		local triggerParams = v.triggerParams
		local type = triggerParams[1]
		local value = triggerParams[2]

		if type == TowerV3a7Enum.StoryTriggerType.Appear and value == mo.id then
			self:_showStory(v.storyConfig, v.id)

			break
		end
	end
end

function TowerV3a7MapStoryView:_onStoryDeadChessMan(mo)
	if not self._storyList then
		return
	end

	for i, v in ipairs(self._storyList) do
		local triggerParams = v.triggerParams
		local type = triggerParams[1]
		local value = triggerParams[2]

		if type == TowerV3a7Enum.StoryTriggerType.Die and value == mo.id then
			self:_showStory(v.storyConfig, v.id)

			break
		end
	end
end

function TowerV3a7MapStoryView:_onStoryFinishTarget(params)
	local targetParams = TowerV3a7Model.instance:getFinishTargetParams()
	local isFinishTarget = targetParams[1] == params.type

	if not isFinishTarget then
		return
	end

	if not self._storyList then
		return
	end

	for i, v in ipairs(self._storyList) do
		local triggerParams = v.triggerParams
		local type = triggerParams[1]

		if type == TowerV3a7Enum.StoryTriggerType.FinishTarget then
			params.isFinishTarget = true
			self._isFinishTarget = true

			self:_showStory(v.storyConfig, v.id)

			break
		end
	end
end

function TowerV3a7MapStoryView:_showStory(storyConfigList, storyId)
	self._storyId = storyId
	self._storyConfigList = storyConfigList

	gohelper.setActive(self._godialogcontainer, true)
	TowerV3a7Controller.instance:dispatchEvent(TowerV3a7Event.StoryShow, true, self._storyId)

	self._stepIndex = 1

	self:_showStoryStep(self._stepIndex)
end

function TowerV3a7MapStoryView:_showStoryStep(index)
	local stepConfig = self._storyConfigList[index]

	if not stepConfig then
		self:_onStoryFinish()

		return
	end

	self._txtcontentcn.text = stepConfig.dialogue

	local icon = ResUrl.getHeadIconSmall(stepConfig.head)

	self._simagedialogicon:LoadImage(icon)
end

function TowerV3a7MapStoryView:_onStoryFinish()
	self._storyConfigList = nil

	gohelper.setActive(self._godialogcontainer, false)
	TowerV3a7Controller.instance:dispatchEvent(TowerV3a7Event.StoryShow, false, self._storyId)

	if self._isFinishTarget then
		TowerV3a7Controller.instance:dispatchEvent(TowerV3a7Event.GameOver)
	end
end

function TowerV3a7MapStoryView:onClose()
	return
end

function TowerV3a7MapStoryView:onDestroyView()
	return
end

return TowerV3a7MapStoryView
