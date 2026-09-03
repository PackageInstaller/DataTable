-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/stagePractice/view/StagePracticeLoseMediator.lua

StagePracticeLoseMediator = class("StagePracticeLoseMediator", DmPopupViewMediator, _M)

StagePracticeLoseMediator:has("_stageSystem", {
	is = "r"
}):injectWith("StageSystem")
StagePracticeLoseMediator:has("_systemKeeper", {
	is = "r"
}):injectWith("SystemKeeper")

local kBtnHandlers = {
	["leavebtn.button"] = "onClickLeave",
	mTouchLayout = "onTouchLayout",
	["againbtn.button"] = "onFightAgain"
}

function StagePracticeLoseMediator:initialize()
	super.initialize(self)
end

function StagePracticeLoseMediator:dispose()
	super.dispose(self)
end

function StagePracticeLoseMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self:bindWidget("againbtn", TwoLevelViceButton, {
		ignoreAddKerning = true
	})
	self:bindWidget("leavebtn", TwoLevelViceButton, {
		ignoreAddKerning = true
	})
end

function StagePracticeLoseMediator:onRemove()
	super.onRemove(self)
end

function StagePracticeLoseMediator:enterWithData(data)
	AudioEngine:getInstance():playBackgroundMusic("Mus_Battle_Common_Lose")

	self._data = data

	self:initWidget()

	local storyDirector = self:getInjector():getInstance(story.StoryDirector)

	storyDirector:notifyWaiting("enter_StagePracticeFightMediator")
end

function StagePracticeLoseMediator:showLoseAni()
	local anim = cc.MovieClip:create("shibaixunlianben_zhandoujiesuan")
	local mvpSpritePanel = anim:getChildByName("heroSprite")
	local battleStatist = self._data.battleStatist
	local developSystem = self:getInjector():getInstance(DevelopSystem)
	local player = developSystem:getPlayer()
	local playerBattleData = battleStatist.players[player:getRid()]
	local team = developSystem:getTeamByType(StageTeamType.PRACTICE)
	local mvpPoint = 0
	local model

	for k, v in pairs(playerBattleData.unitSummary) do
		local roleId = ConfigReader:getDataByNameIdAndKey("RoleModel", v.model, "Model")

		if roleId then
			local checkIsHero = ConfigReader:getRecordById("HeroBase", roleId)

			if checkIsHero then
				local unitMvpPoint = 0

				if not v.damage then
					if v.damage then
						unitMvpPoint = unitMvpPoint + v.damage
					end

					if not v.cure then
						local _unitCure = 0

						if _unitCure then
							unitMvpPoint = unitMvpPoint + _unitCure
						end

						if mvpPoint <= unitMvpPoint then
							mvpPoint = unitMvpPoint
							model = v.model
						end
					end
				end
			end
		end
	end

	if not model then
		for k, v in pairs(playerBattleData.unitSummary) do
			model = v.model
		end
	end

	if model then
		model = IconFactory:getSpMvpBattleEndMid(model)
		self._mvpSprite = IconFactory:createRoleIconSpriteNew({
			frameId = "bustframe17",
			id = model
		})

		local roleId = ConfigReader:getDataByNameIdAndKey("RoleModel", model, "Model")
		local heroMvpText = ConfigReader:getDataByNameIdAndKey("HeroBase", roleId, "MVPText")

		if heroMvpText then
			local text = self._wordPanel:getChildByName("text")

			text:setString(Strings:get(heroMvpText))

			local size = text:getContentSize()
			local posX, posY = text:getPosition()
			local img = self._wordPanel:getChildByName("Image_24")

			img:setPosition(cc.p(posX + size.width - 18, posY - size.height))
			self._wordPanel:runAction(cc.FadeIn:create(0.6))
		end

		mvpSpritePanel:addChild(self._mvpSprite)
		self._mvpSprite:setPosition(cc.p(-360, -200))
	end

	anim:addCallbackAtFrame(45, function()
		anim:stop()
		self._mTouchLayer:setTouchEnabled(true)
	end)
	anim:addTo(self._aniPanel):center(self._aniPanel:getContentSize())
end

function StagePracticeLoseMediator:initWidget()
	self._aniPanel = self:getView():getChildByFullName("anipanel")
	self._wordPanel = self:getView():getChildByFullName("word")
	self._mTouchLayer = self:getView():getChildByFullName("mTouchLayout")

	self:showLoseAni()
end

function StagePracticeLoseMediator:leaveWithData()
	self:onTouchLayout(nil, ccui.TouchEventType.ended)
end

function StagePracticeLoseMediator:onTouchLayout(sender, eventType)
	if eventType ~= ccui.TouchEventType.ended then
		return
	end

	local data = {}

	data.pointId = self._data.pointId
	data.chapterId = self._data.mapId
	data.isInit = false

	if not self._data.mapId then
		BattleLoader:popBattleView(self, {
			viewName = "CommonStageChapterView"
		})
	else
		BattleLoader:popBattleView(self, {
			viewName = "StagePracticeMainView",
			userdata = data
		})
	end
end

function StagePracticeLoseMediator:onClickLeave(sender, eventType)
	local data = {}

	data.pointId = self._data.pointId
	data.chapterId = self._data.mapId
	data.isInit = false

	if not self._data.mapId then
		BattleLoader:popBattleView(self, {
			viewName = "CommonStageChapterView"
		})
	else
		BattleLoader:popBattleView(self, {
			viewName = "StagePracticeMainView",
			userdata = data
		})
	end
end

function StagePracticeLoseMediator:onFightAgain(sender, eventType)
	local data = {}

	data.pointId = self._data.pointId
	data.chapterId = self._data.mapId
	data.isInit = false

	BattleLoader:popBattleView(self, data)
end

function StagePracticeLoseMediator:toStageView()
	self._stageSystem:requestStageProgress(function()
		local data = {}

		data.pointId = self._data.pointId
		data.chapterId = self._data.mapId

		BattleLoader:popBattleView(self, {
			viewName = "StagePracticeMainView",
			userdata = data
		})
	end, false)
end
