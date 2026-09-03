-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/crusade/view/CrusadeBattleWinMediator.lua

CrusadeBattleWinMediator = class("CrusadeBattleWinMediator", DmPopupViewMediator, _M)

CrusadeBattleWinMediator:has("_crusadeSystem", {
	is = "r"
}):injectWith("CrusadeSystem")
CrusadeBattleWinMediator:has("_crusade", {
	is = "r"
}):injectWith("Crusade")

local kBtnHandlers = {
	["content.touchPanel"] = "onTouchMaskLayer"
}

function CrusadeBattleWinMediator:initialize()
	super.initialize(self)
end

function CrusadeBattleWinMediator:dispose()
	local storyDirector = self:getInjector():getInstance(story.StoryDirector)

	storyDirector:notifyWaiting("exit_minigame_win_view")
	super.dispose(self)
end

function CrusadeBattleWinMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
end

function CrusadeBattleWinMediator:onRemove()
	super.onRemove(self)
end

function CrusadeBattleWinMediator:enterWithData(data)
	self._data = data
	self._passReward = {}

	table.deepcopy(self._data.rewards, self._passReward)

	self._rewards = self._data.firstPointReward and self._data.firstPointReward or self._data.rewards or {}

	self:initWidget()
	self:refreshView()

	self._crusadeSystem._isShowPassFloorReward = self._data.firstFloorReward and self._data.firstFloorReward or self._data.floorReward
end

function CrusadeBattleWinMediator:initWidget()
	AudioEngine:getInstance():playBackgroundMusic("Mus_Battle_Common_Win")

	self._main = self:getView():getChildByName("content")
	self._wordPanel = self._main:getChildByFullName("word")

	local textlbl = self._main:getChildByFullName("Panel_reward.Image_bg.text")

	textlbl:setString("")

	self._winPanel = self._main:getChildByFullName("panel_win")
end

function CrusadeBattleWinMediator:refreshView()
	self._winPanel:setVisible(true)
	self._winPanel:setOpacity(0)

	local text1 = self._winPanel:getChildByFullName("text1")
	local text2 = self._winPanel:getChildByFullName("text2")
	local anim = cc.MovieClip:create("shengli_fubenjiesuan")

	anim:addEndCallback(function()
		anim:stop()
	end)
	anim:addTo(self._main:getChildByName("animNode"))
	anim:addCallbackAtFrame(9, function()
		self._wordPanel:fadeIn({
			time = 0.3333333333333333
		})
	end)
	anim:addCallbackAtFrame(17, function()
		self._winPanel:fadeIn({
			time = 0.2
		})
		self:initWinView()
	end)

	local battleStatist = self._data.battleStatist.players
	local developSystem = self:getInjector():getInstance(DevelopSystem)
	local player = developSystem:getPlayer()
	local playerBattleData = battleStatist[player:getRid()]
	local team = developSystem:getSpTeamByType(StageTeamType.CRUSADE)
	local mvpPoint = 0
	local masterSystem = developSystem:getMasterSystem()
	local masterData = masterSystem:getMasterById(team:getMasterId())
	local model = masterData:getModel()

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

	local lastNum = self._crusadeSystem:getLastPowerNum()
	local buffDesc, valueNum = self._crusadeSystem:getCurBuffDesc(lastNum)

	if valueNum == 0 then
		text1:setString(Strings:get("Crusade_Point_26"))
		text2:setString(Strings:get("Crusade_Point_27"))
	else
		local num = 0

		if playerBattleData.usedHeroCards then
			for k, v in pairs(playerBattleData.usedHeroCards) do
				if v.cost then
					num = num + v.cost
				end
			end
		end

		text1:setString(Strings:get("Crusade_Point_21", {
			value = num
		}))
		text2:setString(Strings:get("Crusade_Point_22", {
			value = valueNum
		}))
	end

	if model then
		local roleNode = anim:getChildByName("roleNode")

		model = IconFactory:getSpMvpBattleEndMid(model)

		local mvpSprite = IconFactory:createRoleIconSpriteNew({
			useAnim = true,
			frameId = "bustframe17",
			id = model
		})

		mvpSprite:addTo(roleNode)
		mvpSprite:setScale(0.8)
		mvpSprite:setPosition(cc.p(cc.p(-200, -200)))

		local roleId = ConfigReader:getDataByNameIdAndKey("RoleModel", model, "Hero")
		local heroMvpText = ""

		if roleId then
			heroMvpText = ConfigReader:getDataByNameIdAndKey("HeroBase", roleId, "MVPText")
		end

		if heroMvpText then
			self._wordPanel:setVisible(true)

			local text = self._wordPanel:getChildByName("text")

			text:setString(Strings:get(heroMvpText))

			local image1 = self._wordPanel:getChildByFullName("image1")
			local image2 = self._wordPanel:getChildByFullName("image2")
			local size = text:getContentSize()

			image2:setPosition(cc.p(image1:getPositionX() + size.width - 40, image1:getPositionY() - size.height + 80))
		else
			self._wordPanel:setVisible(false)
		end
	end
end

function CrusadeBattleWinMediator:initWinView()
	local rewardNode = self._main:getChildByFullName("Panel_reward.rewardNode")

	rewardNode:setScrollBarEnabled(false)
	rewardNode:removeAllItems()

	local textlbl = self._main:getChildByFullName("Panel_reward.Image_bg.text")
	local lineGradiantVec2 = {
		{
			ratio = 0.3,
			color = cc.c4b(255, 255, 255, 255)
		},
		{
			ratio = 0.7,
			color = cc.c4b(254, 245, 162, 255)
		}
	}
	local lineGradiantDir = {
		x = 0,
		y = -1
	}

	textlbl:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, lineGradiantDir))

	local isFrist = not not self._data.firstPointReward

	textlbl:setString((isFrist or nil) and (Strings:get("Crusade_Point_1") or Strings:get("Crusade_Point_2")))

	local i = 0

	local function showReward(rewards)
		if #rewards == 0 then
			return
		end

		local rewardData = table.remove(rewards, 1)

		i = i + 1

		local layout = ccui.Layout:create()

		layout:setContentSize(cc.size(90, 90))

		local icon = IconFactory:createRewardIcon(rewardData, {
			isWidget = true
		})

		icon:addTo(layout):center(layout:getContentSize())
		rewardNode:pushBackCustomItem(layout)
		icon:setScale(1)
		icon:setOpacity(0)

		local scale = cc.ScaleTo:create(0.2, 0.7)
		local fadeIn = cc.FadeIn:create(0.2)
		local spawn = cc.Spawn:create(scale, fadeIn)

		icon:runAction(spawn)
		performWithDelay(self:getView(), function()
			showReward(rewards)
		end, i * 0.05)
	end

	showReward(self._rewards)
end

function CrusadeBattleWinMediator:onTouchMaskLayer()
	AudioEngine:getInstance():playEffect("Se_Click_Close_1", false)
	BattleLoader:popBattleView(self, {
		viewName = "CrusadeMainView"
	})
end

function CrusadeBattleWinMediator:onTouchStatistic()
	local data = self._data.battleStatist
	local view = self:getInjector():getInstance("FightStatisticPopView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		remainLastView = true,
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, data))
end
