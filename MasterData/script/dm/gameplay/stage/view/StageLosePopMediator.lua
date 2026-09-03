-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/stage/view/StageLosePopMediator.lua

StageLosePopMediator = class("StageLosePopMediator", DmPopupViewMediator, _M)

StageLosePopMediator:has("_stageSystem", {
	is = "r"
}):injectWith("StageSystem")
StageLosePopMediator:has("_systemKeeper", {
	is = "r"
}):injectWith("SystemKeeper")
StageLosePopMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
StageLosePopMediator:has("_arenaNewSystem", {
	is = "r"
}):injectWith("ArenaNewSystem")

local kBtnHandlers = {
	["content.btnStatistic"] = "onTouchStatistic",
	mTouchLayout = "onTouchLayout",
	["content.mEquipBtn"] = "onClickEquip",
	["content.mRecruitBtn"] = "onClickRecruit",
	["content.mSkillBtn"] = "onClickSkill"
}
local kViewType = {
	KArenaNew = "arenaNew",
	kCrusade = "crusade",
	kArena = "arena"
}

function StageLosePopMediator:initialize()
	super.initialize(self)
end

function StageLosePopMediator:dispose()
	super.dispose(self)
end

function StageLosePopMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	local btn = self:getView():getChildByFullName("content.btnStatistic")
	local unlockSystem = self:getInjector():getInstance(SystemKeeper)

	if not unlockSystem:isUnlock("DataStatistics") then
		btn:setVisible(false)
	end
end

function StageLosePopMediator:onRemove()
	super.onRemove(self)
end

function StageLosePopMediator:enterWithData(data)
	self._data = data

	AudioEngine:getInstance():playBackgroundMusic("Mus_Battle_Common_Lose")
	self:initWidget()
	self:refreshView()
	self:setupClickEnvs()
end

function StageLosePopMediator:initWidget()
	self._bg = self:getView():getChildByName("content")
	self._skillBtn = self._bg:getChildByName("mSkillBtn")

	self._skillBtn:getChildByName("text"):enableOutline(cc.c4b(33, 33, 61, 219.29999999999998), 2)

	self._equipBtn = self._bg:getChildByName("mEquipBtn")

	self._equipBtn:getChildByName("text"):enableOutline(cc.c4b(33, 33, 61, 219.29999999999998), 2)

	self._recruitBtn = self._bg:getChildByName("mRecruitBtn")

	self._recruitBtn:getChildByName("text"):enableOutline(cc.c4b(33, 33, 61, 219.29999999999998), 2)

	self._wordPanel = self._bg:getChildByName("word")
end

function StageLosePopMediator:refreshView()
	local anim = cc.MovieClip:create("shibai_fubenjiesuan")
	local bgPanel = self._bg:getChildByName("heroAndBgPanel")

	anim:addCallbackAtFrame(45, function()
		anim:stop()
	end)
	anim:addTo(bgPanel):center(bgPanel:getContentSize())

	local svpSpritePanel = anim:getChildByName("roleNode")

	self:initSvpRole()
	self:checkResumeActionPoint()
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

function StageLosePopMediator:leaveWithData()
	self:onTouchLayout()
end

function StageLosePopMediator:onTouchLayout(sender, eventType)
	self:toStageView()
end

function StageLosePopMediator:initSvpRole()
	local model

	if self._data.SVPHeroId then
		model = IconFactory:getRoleModelByKey("HeroBase", self._data.SVPHeroId)

		local btn = self:getView():getChildByFullName("content.btnStatistic")

		btn:setVisible(false)
	else
		local battleStatist = self._data.battleStatist
		local developSystem = self:getInjector():getInstance(DevelopSystem)
		local playerBattleData

		if battleStatist then
			local player = developSystem:getPlayer()

			if not self._data.loseId then
				local id = player:getRid()

				playerBattleData = battleStatist[id]
			end
		else
			playerBattleData = {
				unitSummary = {}
			}
		end

		local team = developSystem:getTeamByType(StageTeamType.STAGE_NORMAL)

		if self._data.viewType == kViewType.kCrusade then
			team = developSystem:getSpTeamByType(StageTeamType.CRUSADE)
		elseif self._data.viewType == kViewType.kArena then
			team = developSystem:getSpTeamByType(StageTeamType.ARENA_ATK)
		elseif self._data.viewType == kViewType.KArenaNew then
			team = developSystem:getSpTeamByType(StageTeamType.CHESS_ARENA_ATK)
		end

		local mvpPoint = 0
		local masterSystem = developSystem:getMasterSystem()
		local masterData = masterSystem:getMasterById(team:getMasterId())

		model = masterData:getModel()

		for k, v in pairs(playerBattleData.unitSummary) do
			local roleType = ConfigReader:getDataByNameIdAndKey("RoleModel", v.model, "Type")

			if roleType == RoleModelType.kHero then
				local unitMvpPoint = 0
				local _unitDmg = v.damage

				if _unitDmg then
					unitMvpPoint = unitMvpPoint + _unitDmg
				end

				local _unitCure = v.cure

				if _unitCure then
					unitMvpPoint = unitMvpPoint + _unitCure
				end

				if mvpPoint < unitMvpPoint then
					mvpPoint = unitMvpPoint
					model = v.model
				end
			end
		end
	end

	model = IconFactory:getSpMvpBattleEndMid(model)

	local svpSprite = IconFactory:createRoleIconSpriteNew({
		useAnim = true,
		frameId = "bustframe17",
		id = model
	})

	svpSprite:setScale(0.8)

	self._svpSprite = svpSprite

	local heroMvpText

	if self._data.SVPHeroId then
		heroMvpText = ConfigReader:getDataByNameIdAndKey("HeroBase", self._data.SVPHeroId, "SVPText")
	else
		local roleId = ConfigReader:getDataByNameIdAndKey("RoleModel", model, "Hero")

		if roleId then
			heroMvpText = ConfigReader:getDataByNameIdAndKey("HeroBase", roleId, "SVPText")
		end
	end

	if heroMvpText then
		local text = self._wordPanel:getChildByName("text")

		text:setString(Strings:get(heroMvpText))

		local size = text:getContentSize()
		local posX, posY = text:getPosition()
		local img = self._wordPanel:getChildByName("Image_24")

		img:setPosition(cc.p(posX + size.width - 20, posY - size.height - 15))
		self._wordPanel:runAction(cc.FadeIn:create(0.6))
	end
end

function StageLosePopMediator:checkResumeActionPoint()
	local point = self._data.pointId
	local resumeNode = self:getView():getChildByFullName("content.resumePowerNode")

	resumeNode:setOpacity(0)

	local info = ConfigReader:getDataByNameIdAndKey("BlockPoint", point, "StaminaBack")

	if not info then
		info = ConfigReader:getDataByNameIdAndKey("HeroStoryPoint", point, "StaminaBack")
	elseif self._stageSystem:hasStaminaBackEffect() then
		info = ConfigReader:getDataByNameIdAndKey("BlockPoint", point, "StaminaCost")
	end

	if info and info ~= "" then
		local countText = resumeNode:getChildByName("resume")

		countText:setString("+" .. info)
		countText:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
		resumeNode:runAction(cc.Sequence:create(cc.DelayTime:create(0.25), cc.FadeIn:create(0.2)))
	end
end

function StageLosePopMediator:onClickSkill()
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

	data.pointId = self._data.pointId
	data.chapterId = self._data.mapId
	data.id = self._developSystem:getTeamByType(StageTeamType.STAGE_NORMAL):getMasterId()
	data.showType = 2

	BattleLoader:popBattleView(self, data, view, data)
end

function StageLosePopMediator:onClickRecruit()
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

function StageLosePopMediator:onClickEquip()
	local view = "HeroShowListView"
	local data = {}

	data.pointId = self._data.pointId
	data.chapterId = self._data.mapId

	BattleLoader:popBattleView(self, data, view)
end

function StageLosePopMediator:onTouchStatistic()
	local data = self._data
	local view = self:getInjector():getInstance("FightStatisticPopView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		remainLastView = true,
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		players = data.battleStatist
	}))
end

function StageLosePopMediator:toStageView()
	if self._data.viewType and self._data.viewType == kViewType.kCrusade then
		BattleLoader:popBattleView(self, {
			viewName = "CrusadeMainView"
		})
	elseif self._data.popName and self._data.popName ~= "" then
		BattleLoader:popBattleView(self, {
			viewName = self._data.popName
		})

		if self._data.popName == "ArenaNewView" and self._data.refreshRival then
			self._arenaNewSystem:requestGainChessArena()

			local dispatcher = DmGame:getInstance()

			dispatcher:dispatch(ViewEvent:new(EVT_PUSH_VIEW, dispatcher:getInjector():getInstance(self._data.popName)))
		end
	elseif self._data.SVPHeroId then
		BattleLoader:popBattleView(self, {
			viewName = "HeroStoryChapterView"
		})
	else
		self._stageSystem:requestStageProgress(function()
			local data = {}

			data.pointId = self._data.pointId
			data.chapterId = self._data.mapId
			data.pushPackage = true
			data.viewName = "CommonStageChapterView"

			BattleLoader:popBattleView(self, data)
		end, true)
	end
end

function StageLosePopMediator:setupClickEnvs()
	if GameConfigs.closeGuide then
		return
	end

	local guideName = "guide_Battle_Failure"
	local storyDirector = self:getInjector():getInstance(story.StoryDirector)
	local guideAgent = storyDirector:getGuideAgent()
	local guideSaved = guideAgent:isSaved(guideName)

	if guideSaved then
		return
	end

	local developSystem = self:getInjector():getInstance(DevelopSystem)
	local systemKeeper = self:getInjector():getInstance(SystemKeeper)
	local unlock, tips = systemKeeper:isUnlock("Hero_LevelUp")

	if not unlock then
		return
	end

	guideAgent:trigger(guideName, nil, nil)
	guideAgent:saveGuideStep(guideName)

	local sequence = cc.Sequence:create(cc.CallFunc:create(function()
		local equipBtn = self._equipBtn

		storyDirector:setClickEnv("StageLosePopView.equipBtn", equipBtn, function(sender, eventType)
			self:onClickEquip()
		end)
		storyDirector:notifyWaiting("enter_StageLosePopView")
	end))

	self:getView():runAction(sequence)
end

function StageLosePopMediator:onTouchMaskLayer()
	return
end
