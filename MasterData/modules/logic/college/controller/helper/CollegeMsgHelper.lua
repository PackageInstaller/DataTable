-- chunkname: @modules/logic/college/controller/helper/CollegeMsgHelper.lua

module("modules.logic.college.controller.helper.CollegeMsgHelper", package.seeall)

local CollegeMsgHelper = class("CollegeMsgHelper")

function CollegeMsgHelper:setMsg(msg)
	self.msg = msg
end

function CollegeMsgHelper:getSceneMo()
	return CollegeModel.instance:getSceneMo()
end

function CollegeMsgHelper:process_ItemUpdate()
	self:getSceneMo().bag:updateItems(self.msg.item)
	CollegeController.instance:dispatchEvent(CollegeEvent.UpdateBag)
	self:getSceneMo().prop.clientDataMo:updateLastCoin()
end

function CollegeMsgHelper:process_ItemDel()
	self:getSceneMo().bag:delItems(self.msg.intParams)
	CollegeController.instance:dispatchEvent(CollegeEvent.UpdateBag)
	self:getSceneMo().prop.clientDataMo:updateLastCoin()
end

function CollegeMsgHelper:process_BuildingUpdate()
	for i, v in ipairs(self.msg.building) do
		self:getSceneMo().buildingBox:updateBuilding(v)
	end

	self:getSceneMo():updateCharacterStatus()
	CollegeController.instance:dispatchEvent(CollegeEvent.UpdateBuilding)
end

function CollegeMsgHelper:process_AreaUpdate()
	for i, v in ipairs(self.msg.area) do
		self:getSceneMo().worldMap:updateAreaInfo(v)
	end

	self:getSceneMo():updateCharacterStatus()
	CollegeController.instance:dispatchEvent(CollegeEvent.UpdateArea)
end

function CollegeMsgHelper:process_TaskUpdate()
	for i, v in ipairs(self.msg.task) do
		self:getSceneMo().taskBox:updateTask(v)
	end

	CollegeController.instance:dispatchEvent(CollegeEvent.UpdateTask)
end

function CollegeMsgHelper:process_PropUpdate()
	local preStage = self:getSceneMo().prop.stage

	self:getSceneMo().prop:init(self.msg.prop)

	if preStage ~= self:getSceneMo().prop.stage then
		GameFacade.showToast(ToastEnum.CollegeNewStage)
	end

	CollegeController.instance:dispatchEvent(CollegeEvent.UpdateProp)
end

function CollegeMsgHelper:process_CharacterUpdate()
	local reason = self.msg.intParams[1]
	local newMos = self:getSceneMo().characterBox:updateCharacterMos(self.msg.character)

	CollegeController.instance:dispatchEvent(CollegeEvent.UpdateCharacter)

	if newMos then
		if CollegeEnum.ServerMsgReason.RecruitCharacter == reason then
			ViewMgr.instance:openView(ViewName.CollegeRoleRecruitView, {
				newRecruitList = newMos
			})
		elseif CollegeEnum.ServerMsgReason.EventReward == reason then
			ViewMgr.instance:openView(ViewName.CollegeRoleGainView, {
				newRecruitList = newMos
			})
		end

		CollegeAudioHelper.instance:playAudio(CollegeAudioEnum.RoleRecruit)
		CollegeController.instance:dispatchEvent(CollegeEvent.NewCharacter, newMos)
	end
end

function CollegeMsgHelper:process_CharacterDel()
	self:getSceneMo().characterBox:removeCharacter(self.msg.intParams)
	CollegeController.instance:dispatchEvent(CollegeEvent.UpdateCharacter)
end

function CollegeMsgHelper:process_TriggerStory()
	CollegeStoryHelper.instance:playStory(self.msg.intParams[1])
end

function CollegeMsgHelper:process_StatusUpdate()
	local newStatusList = self:getSceneMo().player.statusBox:updateState(self.msg.status)

	CollegeController.instance:dispatchEvent(CollegeEvent.UpdateState)

	if newStatusList and #newStatusList > 0 then
		CollegeController.instance:dispatchEvent(CollegeEvent.OnGetNewState, newStatusList)
	end
end

function CollegeMsgHelper:process_StatusDel()
	self:getSceneMo().player.statusBox:removeState(self.msg.intParams)
	CollegeController.instance:dispatchEvent(CollegeEvent.UpdateState)
end

function CollegeMsgHelper:process_EventBoxUpdate()
	self:getSceneMo().eventBox:init(self.msg.eventBox)
	CollegeController.instance:dispatchEvent(CollegeEvent.UpdateEventBox)
end

function CollegeMsgHelper:process_MilestoneUpdate()
	local newActiveId

	for i, v in ipairs(self.msg.theme) do
		newActiveId = self:getSceneMo().milestoneBox:updateInfo(v) or newActiveId
	end

	if newActiveId then
		CollegeStoryHelper.instance:playStory(newActiveId, false, self._onStoryFinished, self)
		self:getSceneMo().prop.clientDataMo:updateNeedPlayFirstStory()
	end

	CollegeController.instance:dispatchEvent(CollegeEvent.MilestoneUpdate)
end

function CollegeMsgHelper:_onStoryFinished(storyId)
	CollegeController.instance:showToast(luaLang("college_toast_finishstory"))

	local storyCo = lua_college_story_node.configDict[storyId]

	if storyCo and storyCo.type ~= CollegeEnum.StoryNodeType.Milestone then
		CollegeController.instance:dispatchEvent(CollegeEvent.OnFlyStoryEffect, storyId)
	end
end

function CollegeMsgHelper:process_PlayerInfoUpdate()
	self:getSceneMo().player:update(self.msg.player)
	CollegeController.instance:dispatchEvent(CollegeEvent.UpdatePlayerInfo)
end

function CollegeMsgHelper:process_MilestoneInfoUpdate()
	self:getSceneMo().milestoneBox.score = table.remove(self.msg.intParams, 1) or 0
	self:getSceneMo().milestoneBox.gainId = self.msg.intParams

	CollegeController.instance:dispatchEvent(CollegeEvent.UpdateMilestoneInfo)
end

function CollegeMsgHelper:process_CharacterChainUpdate()
	for _, v in ipairs(self.msg.intParams) do
		self:getSceneMo().milestoneBox:updateLastChainId(v)
	end

	CollegeController.instance:dispatchEvent(CollegeEvent.UpdateLastChainId)
end

function CollegeMsgHelper:process_CheckAndCompareScene()
	if isDebugBuild then
		local sceneMo = GameUtil.rpcInfoToMo(self.msg.scene, CollegeSceneMo)

		sceneMo:compareWith(CollegeModel.instance:getSceneMo())
	end
end

CollegeMsgHelper.instance = CollegeMsgHelper.New()

return CollegeMsgHelper
