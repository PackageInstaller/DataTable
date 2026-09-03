-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/view/ActivityStageUnFinishMediator.lua

ActivityStageUnFinishMediator = class("ActivityStageUnFinishMediator", DmPopupViewMediator)

ActivityStageUnFinishMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")
ActivityStageUnFinishMediator:has("_systemKeeper", {
	is = "r"
}):injectWith("SystemKeeper")

local kBtnHandlers = {
	mTouchLayout = "onTouchLayout",
	["content.mRecruitBtn"] = "onClickRecruit",
	["content.mSkillBtn"] = "onClickSkill",
	["content.mEquipBtn"] = "onClickEquip"
}

function ActivityStageUnFinishMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	local btn = self:getView():getChildByFullName("content.btnStatistic")

	btn:setVisible(false)
end

function ActivityStageUnFinishMediator:enterWithData(data)
	self._data = data
	self._activity = self._activitySystem:getActivityById(self._data.activityId)
	self._model = self._activity:getSubActivityById(self._data.subActivityId) or data.model

	if self._model:getType() == ActivityType.KActivityBlockMapNew then
		local params = data.params

		self._mapId = params.type
		self._sortId = params.mapId
		self._pointId = params.pointId
		self._sort = self._model:getPointById(self._sortId)
		self._point = self._sort:getPointById(self._pointId)
		self._notShowStar = true
	else
		self._pointId = self._data.pointId
		self._mapId = self._data.mapId
		self._point = self._model:getPointById(self._pointId, self._mapId)
	end

	AudioEngine:getInstance():playBackgroundMusic("Mus_Battle_Common_Lose")
	self:initWidget()
	self:refreshView()

	if self._data.activeLeave then
		self:refreshView()
		self:checkResumeActionPoint()
	elseif self._point:isBoss() then
		-- block empty
	else
		self:refreshView()
		self:checkResumeActionPoint()
	end
end

function ActivityStageUnFinishMediator:getOwnMasterId(pointid)
	local masterid = ConfigReader:getDataByNameIdAndKey("ActivityBlockPoint", pointid, "Master")

	if masterid ~= "" then
		return masterid
	end

	return nil
end

function ActivityStageUnFinishMediator:getOwnMasterRoleModel(masterid)
	return (ConfigReader:getDataByNameIdAndKey("EnemyMaster", masterid, "RoleModel"))
end

function ActivityStageUnFinishMediator:checkResumeActionPoint()
	local resumeNode = self:getView():getChildByFullName("content.resumePowerNode")

	resumeNode:setOpacity(0)
	resumeNode:setVisible(true)

	local info = ConfigReader:getDataByNameIdAndKey("ActivityBlockBattle", self._pointId, "StaminaBack")
	local cost = ConfigReader:getDataByNameIdAndKey("ActivityBlockBattle", self._pointId, "StaminaCostAgain")

	local function showBack(...)
		if info then
			resumeNode:setVisible(true)

			local countText = resumeNode:getChildByName("resume")

			for k, v in pairs(info) do
				countText:setString("+" .. v)
				countText:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)

				local icon = IconFactory:createPic({
					id = k
				})

				icon:setScale(2)
				icon:addTo(resumeNode, -1):setPosition(cc.p(750, 378))

				break
			end

			resumeNode:runAction(cc.Sequence:create(cc.DelayTime:create(0.25), cc.FadeIn:create(0.2)))
		else
			resumeNode:setVisible(false)
		end
	end

	local pass = self._point:isPass()

	if pass then
		if cost == 1 then
			showBack()
		else
			resumeNode:setVisible(false)
		end
	else
		showBack()
	end
end

function ActivityStageUnFinishMediator:initWidget()
	self._bg = self:getView():getChildByName("content")
	self._skillBtn = self._bg:getChildByName("mSkillBtn")

	self._skillBtn:getChildByName("text"):enableOutline(cc.c4b(33, 33, 61, 219.29999999999998), 2)

	self._equipBtn = self._bg:getChildByName("mEquipBtn")

	self._equipBtn:getChildByName("text"):enableOutline(cc.c4b(33, 33, 61, 219.29999999999998), 2)

	self._recruitBtn = self._bg:getChildByName("mRecruitBtn")

	self._recruitBtn:getChildByName("text"):enableOutline(cc.c4b(33, 33, 61, 219.29999999999998), 2)

	self._wordPanel = self._bg:getChildByName("word")
end

function ActivityStageUnFinishMediator:refreshView()
	local anim = cc.MovieClip:create("shibai_fubenjiesuan")
	local bgPanel = self._bg:getChildByName("heroAndBgPanel")

	anim:addCallbackAtFrame(45, function()
		anim:stop()
	end)
	anim:addTo(bgPanel):center(bgPanel:getContentSize())

	local svpSpritePanel = anim:getChildByName("roleNode")

	self:initSvpRole()
	svpSpritePanel:addChild(self._svpSprite)
	self._svpSprite:setPosition(cc.p(-200, -200))
	anim:gotoAndPlay(1)

	local action1 = cc.Sequence:create(cc.DelayTime:create(0.1), cc.FadeIn:create(0.1))
	local action2 = cc.Sequence:create(cc.DelayTime:create(0.2), cc.FadeIn:create(0.1))
	local action3 = cc.Sequence:create(cc.DelayTime:create(0.3), cc.FadeIn:create(0.1))

	self._skillBtn:runAction(action1)
	self._equipBtn:runAction(action2)
	self._recruitBtn:runAction(action3)
end

function ActivityStageUnFinishMediator:initSvpRole()
	local team = self._model:getTeam()
	local developSystem = self:getInjector():getInstance(DevelopSystem)
	local masterSystem = developSystem:getMasterSystem()
	local masterData = masterSystem:getMasterById(team:getMasterId())
	local model = masterData:getModel()

	if self:getOwnMasterId(self._data.pointId) then
		model = self:getOwnMasterRoleModel(self:getOwnMasterId(self._data.pointId))
	end

	model = IconFactory:getSpMvpBattleEndMid(model)

	local svpSprite = IconFactory:createRoleIconSpriteNew({
		useAnim = true,
		frameId = "bustframe17",
		id = model
	})

	svpSprite:setScale(0.8)

	self._svpSprite = svpSprite
end

function ActivityStageUnFinishMediator:onClickSkill()
	local systemKeeper = self:getInjector():getInstance(SystemKeeper)
	local result, tip = systemKeeper:isUnlock("Master_All")

	if not result then
		self:dispatch(ShowTipEvent({
			duration = 0.35,
			tip = tip
		}))

		return
	end

	local view = "MasterMainView"
	local data = {}

	BattleLoader:popBattleView(self, data, view, data)
end

function ActivityStageUnFinishMediator:onClickRecruit()
	local unlock, tips = self._systemKeeper:isUnlock("Draw_Hero")

	if not unlock then
		self:dispatch(ShowTipEvent({
			duration = 0.2,
			tip = tips
		}))

		return
	end

	local view = "RecruitView"
	local data = {}

	data.pointId = self._data.pointId
	data.chapterId = self._data.mapId

	BattleLoader:popBattleView(self, data, view)
end

function ActivityStageUnFinishMediator:onClickEquip()
	local view = "HeroShowListView"
	local data = {}

	data.pointId = self._data.pointId
	data.chapterId = self._data.mapId

	BattleLoader:popBattleView(self, data, view)
end

function ActivityStageUnFinishMediator:leaveWithData()
	self:onTouchLayout()
end

function ActivityStageUnFinishMediator:onTouchLayout(sender, eventType)
	BattleLoader:popBattleView(self, {})
end

function ActivityStageUnFinishMediator:onTouchMaskLayer()
	return
end
