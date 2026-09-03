-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/view/ActivityStageFinishMediator.lua

ActivityStageFinishMediator = class("ActivityStageFinishMediator", DmPopupViewMediator)

ActivityStageFinishMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")

local kBtnHandlers = {
	mTouchLayout = "onTouchLayout"
}
local starDiamondCount = ConfigReader:getDataByNameIdAndKey("ConfigValue", "BlockStarDiamond", "content").num

function ActivityStageFinishMediator:dispose()
	super.dispose(self)

	if self._audioEffectId then
		AudioEngine:getInstance():stopEffect(self._audioEffectId)

		self._audioEffectId = nil
	end
end

function ActivityStageFinishMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	local btn = self:getView():getChildByFullName("content.btnStatistic")

	btn:setVisible(false)
end

function ActivityStageFinishMediator:enterWithData(data)
	AudioEngine:getInstance():playBackgroundMusic("Mus_Battle_Common_Win")

	self._data = data
	self._activity = self._activitySystem:getActivityById(self._data.activityId)
	self._model = self._activity:getSubActivityById(self._data.subActivityId) or data.model

	if self._model:getType() == ActivityType.KActivityBlockMapNew then
		local params = data.params

		self._pointId = params.pointId
		self._point = self._model:getSubPointById(params.pointId)
		self._notShowStar = true
		self._showCondition = true
	else
		self._pointId = self._data.pointId
		self._mapId = self._data.mapId
		self._point = self._model:getPointById(self._pointId, self._mapId)
	end

	self._starNum = 0
	self._stars = {}

	if self._data.stars then
		for _, index in pairs(self._data.stars) do
			self._starNum = self._starNum + 1
			self._stars[index] = true
		end
	end

	self:initWidget()

	if self._point:isBoss() then
		self._state = 2

		self:refreshHeroAndReward()
	else
		self:refreshView()
	end
end

function ActivityStageFinishMediator:refreshHeroAndReward()
	self:initRewardPanel()

	local function showReward(rewards)
		local hasFirstRewards

		if self._data.rewards.firstRewards then
			hasFirstRewards = true

			for k, v in ipairs(self._data.rewards.firstRewards) do
				local layout = ccui.Layout:create()

				if k == 1 then
					local extMc = cc.MovieClip:create("titleText_fubenjiesuan")

					extMc:addEndCallback(function()
						extMc:stop()
					end)
					extMc:addTo(layout)
					extMc:setPosition(cc.p(35, 45))

					local firstRewardText = ccui.Text:create(Strings:get("Stage_Win_FirstReward"), TTF_FONT_FZYH_M, 24)
					local mcPanel = extMc:getChildByName("lastText")

					firstRewardText:addTo(mcPanel):posite(-2, 1)

					local lineGradiantVec2 = {
						{
							ratio = 0.1,
							color = cc.c4b(255, 255, 255, 255)
						},
						{
							ratio = 0.9,
							color = cc.c4b(254, 245, 162, 255)
						}
					}

					firstRewardText:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, {
						x = 0,
						y = -1
					}))
					firstRewardText:setTextVerticalAlignment(cc.TEXT_ALIGNMENT_CENTER)
					firstRewardText:getVirtualRenderer():setOverflow(cc.LabelOverflow.SHRINK)
					firstRewardText:getVirtualRenderer():setDimensions(100, 38)
				end

				layout:setContentSize(cc.size(100.5, 85))

				local icon = IconFactory:createRewardIcon(v, {
					isWidget = true
				})

				IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), v, {
					needDelay = true
				})
				icon:setScaleNotCascade(0.8)
				icon:addTo(layout):center(layout:getContentSize()):setName("rewardIcon")
				self._rewardListView:pushBackCustomItem(layout)
			end
		end

		local commonRewards = self._data.rewards.itemRewards
		local extReward = self._data.rewards.heroExtraReward
		local num

		if extReward then
			num = #commonRewards

			for i = 1, #extReward do
				commonRewards[#commonRewards + 1] = extReward[i]
			end
		end

		for k, v in ipairs(commonRewards) do
			local layout = ccui.Layout:create()

			if k == 1 then
				local extMc = cc.MovieClip:create("titleText_fubenjiesuan")

				extMc:addEndCallback(function()
					extMc:stop()
				end)
				extMc:addTo(layout)
				extMc:setPosition(cc.p(35, 45))

				local secondRewardText = ccui.Text:create(Strings:get("Stage_Win_CommonReward"), TTF_FONT_FZYH_M, 24)
				local mcPanel = extMc:getChildByName("lastText")

				secondRewardText:addTo(mcPanel):posite(-2, 1)
				secondRewardText:setTextVerticalAlignment(cc.TEXT_ALIGNMENT_CENTER)
				secondRewardText:getVirtualRenderer():setOverflow(cc.LabelOverflow.SHRINK)
				secondRewardText:getVirtualRenderer():setDimensions(100, 38)

				if hasFirstRewards then
					local imaLayout = ccui.Layout:create()

					imaLayout:setContentSize(cc.size(20, 84))

					local image = ccui.ImageView:create("zdjs_bg_line.png", ccui.TextureResType.plistType)

					image:addTo(imaLayout):center(imaLayout:getContentSize()):setName("line")
					self._rewardListView:pushBackCustomItem(imaLayout)
				end
			end

			if num and num + 1 == k then
				local imaLayout = ccui.Layout:create()

				imaLayout:setContentSize(cc.size(20, 84))

				local image = ccui.ImageView:create("zdjs_bg_line.png", ccui.TextureResType.plistType)

				image:addTo(imaLayout):center(imaLayout:getContentSize()):setName("line")
				self._rewardListView:pushBackCustomItem(imaLayout)

				local extMc = cc.MovieClip:create("titleText_fubenjiesuan")

				extMc:addEndCallback(function()
					extMc:stop()
				end)
				extMc:addTo(layout)
				extMc:setPosition(cc.p(35, 45))

				local secondRewardText = ccui.Text:create(Strings:get("BLOCKSP_UI21"), TTF_FONT_FZYH_M, 24)
				local mcPanel = extMc:getChildByName("lastText")

				secondRewardText:addTo(mcPanel):posite(-2, 1)
			end

			layout:setContentSize(cc.size(100.5, 85))

			local icon = IconFactory:createRewardIcon(v, {
				isWidget = true
			})

			IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), v, {
				needDelay = true
			})
			icon:addTo(layout):center(layout:getContentSize()):setName("rewardIcon")
			icon:setScaleNotCascade(0.8)
			self._rewardListView:pushBackCustomItem(layout)

			if v.isActivityExtra then
				local markImg = ccui.ImageView:create("asset/common/shaungdan_img_xianshidiaoluojiaobiao.png")

				markImg:addTo(layout, 10):posite(45, 75)

				local text = ccui.Text:create(Strings:get("Newyear_Item_LimitedTimeDrop"), TTF_FONT_FZYH_M, 18)

				text:addTo(markImg):center(markImg:getContentSize()):offset(-3, 3)
			end
		end

		local items = self._rewardListView:getItems()

		for i = 1, #items do
			local _item = items[i]:getChildByName("rewardIcon")

			if _item then
				local posX, posY = _item:getPosition()

				_item:setPositionX(posX + 30)
				_item:setOpacity(0)
				_item:runAction(cc.Spawn:create(cc.FadeIn:create(0.2), cc.MoveTo:create(0.2, cc.p(posX, posY))))
			else
				_item = items[i]:getChildByName("line")

				_item:setOpacity(0)
				_item:runAction(cc.FadeIn:create(0.2))
			end
		end
	end

	for i = 1, 3 do
		self._starPanel:getChildByFullName("star" .. i):setVisible(false)
	end

	local herosAnim = cc.MovieClip:create("kapai_zhandoujiesuan")

	herosAnim:addTo(self._expPanel):posite(160, 85)
	herosAnim:addCallbackAtFrame(45, function()
		if self._mvpAudioEffect then
			self._audioEffectId = AudioEngine:getInstance():playRoleEffect(self._mvpAudioEffect, false)
		end

		herosAnim:stop()
	end)
	herosAnim:stop()

	self._herosAnim = herosAnim

	local battleStatist = self._data.statist.players
	local developSystem = self:getInjector():getInstance(DevelopSystem)
	local player = developSystem:getPlayer()
	local playerBattleData = battleStatist[player:getRid()]
	local team = self._model:getTeam()
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

	model = IconFactory:getSpMvpBattleEndMid(model)

	local mvpSprite = IconFactory:createRoleIconSpriteNew({
		useAnim = true,
		frameId = "bustframe17",
		id = model
	})

	mvpSprite:setScale(0.8)

	self._mvpSprite = mvpSprite

	local roleId = ConfigReader:getDataByNameIdAndKey("RoleModel", model, "Hero")
	local heroMvpText

	if roleId then
		heroMvpText = ConfigReader:getDataByNameIdAndKey("HeroBase", roleId, "MVPText")
	end

	if heroMvpText then
		self._mvpAudioEffect = "Voice_" .. roleId .. "_" .. 31

		local text = self._wordPanel:getChildByName("text")

		text:setString(Strings:get(heroMvpText))

		local size = text:getContentSize()
		local posX, posY = text:getPosition()
		local img = self._wordPanel:getChildByName("Image_24")

		img:setPosition(cc.p(posX + size.width - 30, posY - size.height - 10))
		self._wordPanel:runAction(cc.FadeIn:create(0.6))
	end

	self._herosAnim:addCallbackAtFrame(130, function()
		self._herosAnim:stop()

		local testReward = self._data.rewards

		if testReward and self._data.rewards.itemRewards then
			self._rewardPanel:setVisible(true)
			showReward(self._data.rewards.itemRewards)
		else
			self._rewardPanel:setVisible(false)
		end

		self:initBossStage()
	end)
	self:showHeroPanelAnim()
	self._herosAnim:gotoAndPlay(90)
end

function ActivityStageFinishMediator:initBossStage()
	local bossView = self:getView():getChildByFullName("content.bossPanel")

	bossView:setPosition(585, 260)

	local nameText = bossView:getChildByName("pointName")

	nameText:setString(Strings:get("Activity_Boss_Point_Text1") .. "  " .. self._point:getName())

	local oldRate = self._point:getOldRate()
	local curRate
	local battleStatist = self._data.statist.players
	local pointStatistData = battleStatist[self._pointId]

	curRate = pointStatistData and pointStatistData.hpRatio or self._point:getHpRate()

	local expBarSp = cc.Sprite:createWithSpriteFrameName("common_bar_l03.png")
	local progressTimer = cc.ProgressTimer:create(expBarSp)

	progressTimer:addTo(bossView:getChildByName("bg"))
	progressTimer:setAnchorPoint(0, 0)
	progressTimer:setPosition(2, 2)
	progressTimer:setScaleX(91.25)
	progressTimer:setScaleY(1.5)
	progressTimer:setType(1)
	progressTimer:setMidpoint(cc.p(0, 0))
	progressTimer:setBarChangeRate(cc.p(1, 0))
	progressTimer:setPercentage(oldRate * 100)
	bossView:setOpacity(0)
	bossView:runAction(cc.FadeIn:create(0.3))

	local act = cc.Sequence:create(cc.DelayTime:create(0.2), cc.ProgressFromTo:create(0.3, oldRate * 100, curRate * 100))

	progressTimer:runAction(act)

	local rateText = bossView:getChildByName("rate")
	local str = math.ceil(curRate * 100) .. "%"

	rateText:setString(str)
end

function ActivityStageFinishMediator:initWidget()
	self._main = self:getView():getChildByName("content")
	self._mTouchLayout = self:getView():getChildByName("mTouchLayout")
	self._starPanel = self._main:getChildByFullName("Panel_star")
	self._rewardPanel = self._main:getChildByFullName("Panel_reward")
	self._rewardListView = self._rewardPanel:getChildByFullName("mRewardList")

	self._rewardListView:setScrollBarEnabled(false)

	self._wordPanel = self._main:getChildByName("word")
	self._expPanel = self._main:getChildByFullName("Panel_exp")
	self._state = 1
	self._conditionPanel = self._main:getChildByFullName("condition")

	self._conditionPanel:setVisible(false)
end

function ActivityStageFinishMediator:refreshView()
	self:showHeroPanel()
	performWithDelay(self:getView(), function()
		if self._state == 1 then
			self:showExpPanel()
		end
	end, 2.2)
end

function ActivityStageFinishMediator:showHeroPanelAnim()
	self._starPanel:setVisible(false)
	self._rewardPanel:setVisible(false)

	local lv = self._main:getChildByName("lvLabel")

	lv:setVisible(false)

	local lvName = self._main:getChildByName("mLevelNum")

	lvName:setVisible(false)

	local developSystem = self:getInjector():getInstance(DevelopSystem)
	local curLevel = developSystem:getPlayer():getLevel()

	lvName:setString(curLevel)

	local anim

	if self._point:isBoss() then
		anim = cc.MovieClip:create("tiaozhanjieshu_fubenjiesuan")

		local winNode = anim:getChildByFullName("winNode")
		local winAnim = cc.MovieClip:create("shengliz_jingjijiesuan")

		winAnim:addEndCallback(function()
			winAnim:stop()
		end)
		winAnim:addTo(winNode)

		local winPanel = winAnim:getChildByFullName("winTitle")
		local title = ccui.ImageView:create("zyfb_tzjs.png", 1)

		title:addTo(winPanel)
		anim:addEndCallback(function()
			anim:stop()
		end)
	else
		anim = cc.MovieClip:create("stageshengli_fubenjiesuan")

		anim:addCallbackAtFrame(45, function()
			anim:stop()
		end)
	end

	local bgPanel = self._main:getChildByName("heroAndBgPanel")
	local mvpSpritePanel = anim:getChildByName("roleNode")

	mvpSpritePanel:addChild(self._mvpSprite)
	self._mvpSprite:setPosition(cc.p(-200, -200))
	anim:addTo(bgPanel):center(bgPanel:getContentSize())
	anim:gotoAndPlay(1)
end

function ActivityStageFinishMediator:getOwnMasterId(pointid)
	local masterid = ConfigReader:getDataByNameIdAndKey("ActivityBlockPoint", pointid, "Master")

	if masterid ~= "" then
		return masterid
	end

	return nil
end

function ActivityStageFinishMediator:getOwnMasterRoleModel(masterid)
	return (ConfigReader:getDataByNameIdAndKey("EnemyMaster", masterid, "RoleModel"))
end

function ActivityStageFinishMediator:showHeroPanel()
	self._state = 1
	self._levelUpExpBar = {}
	self._normalExpBar = {}

	local battleStatist = self._data.statist.players
	local developSystem = self:getInjector():getInstance(DevelopSystem)
	local player = developSystem:getPlayer()
	local playerBattleData = battleStatist[player:getRid()]
	local team = self._model:getTeam()
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

	if self:getOwnMasterId(self._data.pointId) then
		model = self:getOwnMasterRoleModel(self:getOwnMasterId(self._data.pointId))
	end

	model = IconFactory:getSpMvpBattleEndMid(model)

	local mvpSprite = IconFactory:createRoleIconSpriteNew({
		useAnim = true,
		frameId = "bustframe17",
		id = model
	})

	mvpSprite:setScale(0.8)

	self._mvpSprite = mvpSprite

	local roleId = ConfigReader:getDataByNameIdAndKey("RoleModel", model, "Hero")
	local heroMvpText

	if roleId then
		heroMvpText = ConfigReader:getDataByNameIdAndKey("HeroBase", roleId, "MVPText")
	end

	if heroMvpText then
		self._mvpAudioEffect = "Voice_" .. roleId .. "_" .. 31

		local text = self._wordPanel:getChildByName("text")

		text:setString(Strings:get(heroMvpText))

		local size = text:getContentSize()
		local posX, posY = text:getPosition()
		local img = self._wordPanel:getChildByName("Image_24")

		img:setPosition(cc.p(posX + size.width - 30, posY - size.height - 10))
		self._wordPanel:runAction(cc.FadeIn:create(0.6))
	end

	self:showHeroPanelAnim()

	local herosAnim = cc.MovieClip:create("kapai_zhandoujiesuan")

	herosAnim:addTo(self._expPanel):posite(160, 85)
	herosAnim:addCallbackAtFrame(45, function()
		if self._mvpAudioEffect then
			self._audioEffectId = AudioEngine:getInstance():playRoleEffect(self._mvpAudioEffect, false)
		end

		herosAnim:stop()
	end)
	herosAnim:stop()

	self._herosAnim = herosAnim

	local cloneCell = self._expPanel:getChildByName("clone_cell")
	local heroSystem = developSystem:getHeroSystem()
	local rowTeam = self._activitySystem:getBattleTeam()
	local rowTeamHeroes = rowTeam.teamHeroInfo
	local i = 0
	local lineCellCount = 5

	for id, v in pairs(rowTeamHeroes) do
		i = i + 1

		local heroInfo = heroSystem:getHeroById(id)
		local heroData = {
			id = id,
			level = v.level,
			star = heroInfo:getStar(),
			quality = heroInfo:getQuality(),
			rarity = heroInfo:getRarity(),
			qualityLevel = heroInfo:getQualityLevel(),
			name = heroInfo:getName(),
			roleModel = heroInfo:getModel()
		}
		local cell = cloneCell:clone()
		local icon = IconFactory:createHeroLargeNotRemoveIcon(heroData, {
			hideName = true
		})
		local imageNode = icon:getChildByFullName("main.actionNode.image")

		imageNode:setVisible(true)
		icon:setScale(0.6)

		local lvText = icon:getChildByFullName("main.actionNode.level")

		lvText:setScale(1.67)
		icon:addTo(cell):posite(43, 66):setTag(10)

		local expBarSp = cc.Sprite:createWithSpriteFrameName("common_bar_l03.png")
		local progressTimer = cc.ProgressTimer:create(expBarSp)

		progressTimer:addTo(cell):posite(41, -3.9):setName("progressTimer")
		progressTimer:setScaleX(19.5)
		progressTimer:setScaleY(0.5)
		progressTimer:setVisible(false)
		progressTimer:setType(1)
		progressTimer:setMidpoint(cc.p(0, 0))
		progressTimer:setBarChangeRate(cc.p(1, 0))

		local expBar = cell:getChildByName("expBar")
		local exp
		local heroExp = heroInfo:getExp()
		local heroLevel = heroInfo:getLevel()
		local maxExpAmount = heroSystem:getNextLvlAddExp(id, v.level)
		local expBarAmount = v.exp

		expBar:setPercent(expBarAmount * 100 / maxExpAmount)
		progressTimer:setPercentage(expBarAmount * 100 / maxExpAmount)

		expBar.nextPercent = heroExp * 100 / heroSystem:getNextLvlAddExp(id, heroInfo:getLevel())
		expBar.nextLevel = heroLevel

		if heroLevel ~= v.level then
			self._levelUpExpBar[#self._levelUpExpBar + 1] = expBar
			exp = "Exp +" .. self._data.rewards.heroExp
		else
			self._normalExpBar[#self._normalExpBar + 1] = expBar
			exp = "Exp +" .. tostring(heroExp - v.exp)
		end

		local namePanel = icon:getChildByFullName("main.actionNode.namePanel")
		local nameLabel = namePanel:getChildByName("name")

		nameLabel:setString(exp)
		nameLabel:setScale(1.67)
		nameLabel:setVisible(true)
		nameLabel:setPosition(24, 10)

		local _cellAnimPanel = herosAnim:getChildByName("hero" .. i)

		cell:addTo(_cellAnimPanel)

		local j = i % lineCellCount

		if j == 0 then
			j = lineCellCount
		end

		local tail = j * 20

		cell:setPositionX(cell:getPositionX() + tail)

		if lineCellCount < i then
			cell:setPositionY(cell:getPositionY() - 15)
		end

		cell:setVisible(true)
	end

	herosAnim:addCallbackAtFrame(30, function()
		for k, v in ipairs(self._normalExpBar) do
			local curPercent = v:getPercent()
			local nextPercent = v.nextPercent
			local progressTimer = v:getParent():getChildByName("progressTimer")

			progressTimer:setVisible(true)
			v:setVisible(false)
			v:setPercent(nextPercent)

			local actions = {}

			actions[#actions + 1] = cc.ProgressFromTo:create(0.3, curPercent, nextPercent)
			actions[#actions + 1] = cc.CallFunc:create(function()
				progressTimer:setVisible(false)
				v:setVisible(true)
			end)

			progressTimer:runAction(cc.Sequence:create(unpack(actions)))
		end

		for k, v in ipairs(self._levelUpExpBar) do
			local curPercent = v:getPercent()
			local nextPercent = v.nextPercent
			local cell = v:getParent()
			local progressTimer = cell:getChildByName("progressTimer")

			progressTimer:setVisible(true)
			v:setVisible(false)
			v:setPercent(nextPercent)

			local actions = {}

			actions[#actions + 1] = cc.ProgressFromTo:create(0.3, curPercent, 100)
			actions[#actions + 1] = cc.CallFunc:create(function()
				local mc = cc.MovieClip:create("liuguangss_zhandoujiesuan")

				mc:addEndCallback(function()
					mc:stop()
				end)
				mc:setScaleX(0.42)
				mc:setScaleY(0.45)
				mc:addTo(cell):posite(42.3, 52)

				local flashMc = cc.MovieClip:create("lizi_zhandoujiesuan")

				flashMc:addTo(cell):posite(42.3, 52)
				flashMc:addEndCallback(function()
					flashMc:stop()
				end)

				local levelUpAnim = cc.MovieClip:create("sjt_zhandoujiesuant")

				levelUpAnim:addTo(cell):posite(75, 66)

				local extraLevelPanel = v:getParent():getChildByTag(10):getChildByFullName("main.actionNode.level")

				extraLevelPanel:setString("Lv." .. v.nextLevel)
			end)
			actions[#actions + 1] = cc.ProgressFromTo:create(0.3, 0, nextPercent)
			actions[#actions + 1] = cc.CallFunc:create(function()
				progressTimer:setVisible(false)
				v:setVisible(true)
			end)

			progressTimer:runAction(cc.Sequence:create(unpack(actions)))
		end
	end)
	herosAnim:gotoAndPlay(1)
end

function ActivityStageFinishMediator:showExpPanel()
	self._state = 2

	local point = self._model:getPointById(self._data.pointId, self._mapId)

	if not self._notShowStar then
		local oldStarState = point:getOldStar()
		local starPanel = self._starPanel
		local descs = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Block_StarConditionDesc", "content")
		local starCondition = point:getStarCondition()

		for i = 1, 3 do
			local diamondNode = self._starPanel:getChildByFullName("star" .. i .. ".diamond")

			if self._stars[i] then
				if oldStarState[i] then
					diamondNode:setColor(cc.c3b(127, 127, 127))
					diamondNode:getChildByName("diamondNum"):setVisible(false)
					diamondNode:getChildByName("onFinish"):setVisible(true)
				else
					diamondNode:setColor(cc.c3b(255, 255, 255))
					diamondNode:getChildByName("onFinish"):setVisible(true)

					local diamondNum = diamondNode:getChildByName("diamondNum")

					diamondNum:setVisible(true)
					diamondNum:setString("+" .. starDiamondCount)
				end
			else
				diamondNode:setColor(cc.c3b(255, 255, 255))
				diamondNode:getChildByName("onFinish"):setVisible(false)

				local diamondNum = diamondNode:getChildByName("diamondNum")

				diamondNum:setVisible(true)
				diamondNum:setString("+" .. starDiamondCount)
			end

			local star = starPanel:getChildByFullName("star" .. i)
			local labelText = star:getChildByFullName("text")

			labelText:setString(Strings:get(descs[starCondition[i].type], {
				value = starCondition[i].value
			}))
		end
	else
		self._starPanel:setVisible(false)
	end

	if self._showCondition then
		self._conditionPanel:setVisible(true)

		local conditionkeeper = self:getInjector():getInstance(Conditionkeeper)
		local conditions = self._point:getConfig().VictoryConditions
		local desc = conditionkeeper:getVictoryConditionsDesc(conditions, {
			assist = self._point:getAssist()
		})
		local descText = self._conditionPanel:getChildByName("Text_desc")

		descText:setString("")

		desc = string.gsub(desc, "${fontName}", "asset/font/CustomFont_FZYH_M.TTF")

		local richdesc = descText:getParent():getChildByName("richdesc")

		if not richdesc then
			richdesc = ccui.RichText:createWithXML("", {})

			richdesc:setAnchorPoint(cc.p(0, 1))
			richdesc:renderContent(300, 0, true)
			richdesc:addTo(descText:getParent()):posite(descText:getPosition()):setName("richdesc")
		end

		richdesc:setString(desc)
	end

	self:initRewardPanel()

	local function showReward(rewards)
		local hasFirstRewards

		if self._data.rewards.firstRewards then
			hasFirstRewards = true

			for k, v in ipairs(self._data.rewards.firstRewards) do
				local layout = ccui.Layout:create()

				if k == 1 then
					local extMc = cc.MovieClip:create("titleText_fubenjiesuan")

					extMc:addEndCallback(function()
						extMc:stop()
					end)
					extMc:addTo(layout)
					extMc:setPosition(cc.p(35, 45))

					local firstRewardText = ccui.Text:create(Strings:get("Stage_Win_FirstReward"), TTF_FONT_FZYH_M, 24)
					local mcPanel = extMc:getChildByName("lastText")

					firstRewardText:addTo(mcPanel):posite(-2, 1)

					local lineGradiantVec2 = {
						{
							ratio = 0.1,
							color = cc.c4b(255, 255, 255, 255)
						},
						{
							ratio = 0.9,
							color = cc.c4b(254, 245, 162, 255)
						}
					}

					firstRewardText:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, {
						x = 0,
						y = -1
					}))
					firstRewardText:setTextVerticalAlignment(cc.TEXT_ALIGNMENT_CENTER)
					firstRewardText:getVirtualRenderer():setOverflow(cc.LabelOverflow.SHRINK)
					firstRewardText:getVirtualRenderer():setDimensions(100, 38)
				end

				layout:setContentSize(cc.size(100.5, 85))

				local icon = IconFactory:createRewardIcon(v, {
					isWidget = true
				})

				IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), v, {
					needDelay = true
				})
				icon:setScaleNotCascade(0.8)
				icon:addTo(layout):center(layout:getContentSize()):setName("rewardIcon")
				self._rewardListView:pushBackCustomItem(layout)
			end
		end

		local commonRewards = {}
		local itemRewards = self._data.rewards.itemRewards

		for i, v in pairs(itemRewards) do
			if v.amount > 0 then
				commonRewards[#commonRewards + 1] = v
			end
		end

		local extReward = self._data.rewards.heroExtraReward
		local num

		if extReward then
			num = #commonRewards

			for i = 1, #extReward do
				commonRewards[#commonRewards + 1] = extReward[i]
			end
		end

		for k, v in ipairs(commonRewards) do
			local layout = ccui.Layout:create()

			if k == 1 then
				local extMc = cc.MovieClip:create("titleText_fubenjiesuan")

				extMc:addEndCallback(function()
					extMc:stop()
				end)
				extMc:addTo(layout)
				extMc:setPosition(cc.p(35, 45))

				local secondRewardText = ccui.Text:create(Strings:get("Stage_Win_CommonReward"), TTF_FONT_FZYH_M, 24)
				local mcPanel = extMc:getChildByName("lastText")

				secondRewardText:addTo(mcPanel):posite(-2, 1)
				secondRewardText:setTextVerticalAlignment(cc.TEXT_ALIGNMENT_CENTER)
				secondRewardText:getVirtualRenderer():setOverflow(cc.LabelOverflow.SHRINK)
				secondRewardText:getVirtualRenderer():setDimensions(100, 38)

				if hasFirstRewards then
					local imaLayout = ccui.Layout:create()

					imaLayout:setContentSize(cc.size(20, 84))

					local image = ccui.ImageView:create("zdjs_bg_line.png", ccui.TextureResType.plistType)

					image:addTo(imaLayout):center(imaLayout:getContentSize()):setName("line")
					self._rewardListView:pushBackCustomItem(imaLayout)
				end
			end

			if num and num + 1 == k then
				local imaLayout = ccui.Layout:create()

				imaLayout:setContentSize(cc.size(20, 84))

				local image = ccui.ImageView:create("zdjs_bg_line.png", ccui.TextureResType.plistType)

				image:addTo(imaLayout):center(imaLayout:getContentSize()):setName("line")
				self._rewardListView:pushBackCustomItem(imaLayout)

				local extMc = cc.MovieClip:create("titleText_fubenjiesuan")

				extMc:addEndCallback(function()
					extMc:stop()
				end)
				extMc:addTo(layout)
				extMc:setPosition(cc.p(35, 45))

				local secondRewardText = ccui.Text:create(Strings:get("BLOCKSP_UI21"), TTF_FONT_FZYH_M, 24)
				local mcPanel = extMc:getChildByName("lastText")

				secondRewardText:addTo(mcPanel):posite(-2, 1)
			end

			layout:setContentSize(cc.size(100.5, 85))

			local icon = IconFactory:createRewardIcon(v, {
				isWidget = true
			})

			IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), v, {
				needDelay = true
			})
			icon:addTo(layout):center(layout:getContentSize()):setName("rewardIcon")
			icon:setScaleNotCascade(0.8)

			if v.isActivityExtra then
				local markImg = ccui.ImageView:create("asset/common/shaungdan_img_xianshidiaoluojiaobiao.png")

				markImg:addTo(layout, 10):posite(45, 75)

				local text = ccui.Text:create(Strings:get("Newyear_Item_LimitedTimeDrop"), TTF_FONT_FZYH_M, 18)

				text:addTo(markImg):center(markImg:getContentSize()):offset(-3, 3)
			end

			self._rewardListView:pushBackCustomItem(layout)
		end

		local items = self._rewardListView:getItems()

		for i = 1, #items do
			local _item = items[i]:getChildByName("rewardIcon")

			if _item then
				local posX, posY = _item:getPosition()

				_item:setPositionX(posX + 30)
				_item:setOpacity(0)
				_item:runAction(cc.Spawn:create(cc.FadeIn:create(0.2), cc.MoveTo:create(0.2, cc.p(posX, posY))))
			else
				_item = items[i]:getChildByName("line")

				_item:setOpacity(0)
				_item:runAction(cc.FadeIn:create(0.2))
			end
		end
	end

	local actOffSet = 680

	if not self._notShowStar then
		self._starPanel:setVisible(true)
	end

	local _star1 = self._starPanel:getChildByFullName("star1")
	local posX1, posY1 = _star1:getPosition()
	local _star2 = self._starPanel:getChildByFullName("star2")
	local posX2, posY2 = _star2:getPosition()
	local _star3 = self._starPanel:getChildByFullName("star3")
	local posX3, posY3 = _star3:getPosition()

	_star1:setPositionX(posX1 + actOffSet)
	_star2:setPositionX(posX2 + actOffSet)
	_star3:setPositionX(posX3 + actOffSet)

	local lv = self._main:getChildByName("lvLabel")

	lv:setVisible(true)

	local posX4, posY4 = lv:getPosition()

	lv:setPositionX(posX4 + actOffSet)

	local lvName = self._main:getChildByName("mLevelNum")

	lvName:setVisible(true)

	local posX5, posY5 = lvName:getPosition()

	lvName:setPositionX(posX5 + actOffSet)

	local condPosX, condPosY = self._conditionPanel:getPosition()

	if self._showCondition then
		self._conditionPanel:setVisible(true)
		self._conditionPanel:setPositionX(condPosX + actOffSet)
	end

	self._herosAnim:addCallbackAtFrame(108, function()
		local easeBackOutAni = cc.EaseBackOut:create(cc.MoveTo:create(0.5, cc.p(posX1, posY1)))

		easeBackOutAni:update(1)
		_star1:runAction(easeBackOutAni)
		lv:runAction(cc.MoveTo:create(0.5, cc.p(posX4, posY4)))
		lvName:runAction(cc.MoveTo:create(0.5, cc.p(posX5, posY5)))
		self._conditionPanel:runAction(cc.MoveTo:create(0.5, cc.p(condPosX, condPosY)))
	end)
	self._herosAnim:addCallbackAtFrame(113, function()
		local easeBackOutAni = cc.EaseBackOut:create(cc.MoveTo:create(0.5, cc.p(posX2, posY2)))

		easeBackOutAni:update(0.8)
		_star2:runAction(easeBackOutAni)
	end)
	self._herosAnim:addCallbackAtFrame(118, function()
		local easeBackOutAni = cc.EaseBackOut:create(cc.MoveTo:create(0.5, cc.p(posX3, posY3)))

		easeBackOutAni:update(0.6)
		_star3:runAction(easeBackOutAni)
	end)
	self._herosAnim:addCallbackAtFrame(130, function()
		self._herosAnim:stop()

		if self._data.rewards and self._data.rewards.itemRewards then
			local n = #self._data.rewards.itemRewards

			if self._data.rewards.firstRewards then
				n = n + #self._data.rewards.firstRewards
			end

			self._rewardPanel:setVisible(n > 0 and true or false)
			showReward(self._data.rewards.itemRewards)
			self:setPointStarCondition()
		else
			self._rewardPanel:setVisible(false)
		end
	end)
	self._herosAnim:gotoAndPlay(90)
end

function ActivityStageFinishMediator:setPointStarCondition()
	local starCount = 0

	for i = 1, 3 do
		if self._stars[i] then
			starCount = i

			local _starBg = self._starPanel:getChildByFullName("star" .. i .. ".star")
			local anim = cc.MovieClip:create("aa_yinghunshengxing")

			anim:addTo(_starBg):setName("starAnim")
			anim:addEndCallback(function()
				anim:gotoAndPlay(30)
			end)
			anim:setPosition(cc.p(33, 45))
			anim:stop()
			performWithDelay(_starBg, function()
				anim:gotoAndPlay(1)
				AudioEngine:getInstance():playEffect("Se_Effect_Win_Star", false)
			end, 0.15 * i)
		end
	end

	if starCount ~= 0 then
		performWithDelay(self:getView(), function()
			AudioEngine:getInstance():playEffect("Se_Effect_Star_Shine", false)
		end, 0.05 + 0.15 * starCount)
	end
end

function ActivityStageFinishMediator:initRewardPanel()
	if not self._data.rewards then
		return
	end

	local crystalAmount = 0
	local goldAmount = 0

	if self._data.rewards.goldReward then
		goldAmount = tonumber(self._data.rewards.goldReward)
	end

	if self._data.rewards.crystalReward then
		crystalAmount = tonumber(self._data.rewards.crystalReward)
	end

	self._data.rewards.itemRewards = self._data.rewards.itemRewards or {}

	if goldAmount > 0 then
		local _tab = self._data.rewards.itemRewards
		local tag = false

		for _, v in ipairs(_tab) do
			if v.code == "IR_Gold" and v.type == 2 then
				v.amount = v.amount + goldAmount
				tag = true

				break
			end
		end

		if not tag then
			local goldRewardTable = {}

			goldRewardTable.amount = goldAmount
			goldRewardTable.code = "IR_Gold"
			goldRewardTable.type = 2
			self._data.rewards.itemRewards[#self._data.rewards.itemRewards + 1] = goldRewardTable
		end
	end

	if crystalAmount > 0 then
		local _tab = self._data.rewards.itemRewards
		local tag = false

		for _, v in ipairs(_tab) do
			if v.code == "IR_Crystal" and v.type == 2 then
				v.amount = v.amount + crystalAmount
				tag = true

				break
			end
		end

		if not tag then
			local crystalRewardTable = {}

			crystalRewardTable.amount = crystalAmount
			crystalRewardTable.code = "IR_Crystal"
			crystalRewardTable.type = 2
			self._data.rewards.itemRewards[#self._data.rewards.itemRewards + 1] = crystalRewardTable
		end
	end

	if self._data.rewards.activityExtraReward then
		for _, v in ipairs(self._data.rewards.activityExtraReward) do
			v.isActivityExtra = true
			self._data.rewards.itemRewards[#self._data.rewards.itemRewards + 1] = v
		end
	end

	for k, v in ipairs(self._data.rewards.itemRewards) do
		if v.type == RewardType.kExp then
			v.quality = 100
		elseif v.type == RewardType.kHero then
			v.quality = RewardSystem:getQuality(v) + 50
		else
			local quality = RewardSystem:getQuality(v)

			v.quality = quality == nil and 0 or quality
		end
	end

	table.sort(self._data.rewards.itemRewards, function(a, b)
		return a.quality > b.quality
	end)

	local firstRewardList = self._data.rewards.firstRewards

	if firstRewardList and #firstRewardList > 0 then
		local replaceConfig = ConfigReader:getDataByNameIdAndKey("ConfigValue", "NewPlayer_StageShowReward", "content")

		for k, v in pairs(replaceConfig) do
			if self._data.pointId == k then
				local replaceRewards = ConfigReader:getDataByNameIdAndKey("Reward", v, "Content")

				for i = 1, #replaceRewards do
					firstRewardList[#firstRewardList + 1] = replaceRewards[i]
				end

				break
			end
		end

		for k, v in ipairs(firstRewardList) do
			v.quality = v.type == RewardType.kExp and 100 or v.type == RewardType.kHero and RewardSystem:getQuality(v) + 50 or RewardSystem:getQuality(v)
		end

		table.sort(firstRewardList, function(a, b)
			return a.quality > b.quality
		end)
	end
end

function ActivityStageFinishMediator:leaveWithData()
	self:onTouchLayout()
end

function ActivityStageFinishMediator:onTouchLayout(sender, eventType)
	self:getView():getChildByName("mTouchLayout"):setTouchEnabled(false)
	self:checkHiddenStory()
end

function ActivityStageFinishMediator:checkHiddenStory()
	local function storyEndCall()
		BattleLoader:popBattleView(self, {})
	end

	local pointId = self._pointId
	local hiddenStory = self._point:getHiddenStory()
	local storyId = ""
	local conditions

	for id, condition in pairs(hiddenStory) do
		storyId = id
		conditions = condition

		break
	end

	if storyId == "" or not conditions then
		storyEndCall()

		return
	end

	local curTeam = self._model:getTeam()

	for nK, nHero in pairs(conditions) do
		if not table.indexof(curTeam._heroes, nHero) then
			storyEndCall()

			return
		end
	end

	self:onPlayHiddenStory(pointId, storyId, true, storyEndCall)
end

function ActivityStageFinishMediator:onPlayHiddenStory(pointId, storyId, isCheck, storyEndCall)
	local storyDirector = self:getInjector():getInstance(story.StoryDirector)

	local function endCallBack()
		local hidden = self:checkShowHiddenStory(pointId)

		if not hidden then
			self._activitySystem:requestDoChildActivity(self._activity:getId(), self._model:getId(), {
				doActivityType = 106,
				pointId = storyId
			}, function(response)
				local delegate, outSelf = {}, self

				storyDirector:notifyWaiting("story_play_end")
				storyEndCall()

				function delegate:willClose(popupMediator, data)
					return
				end

				local view = self._activitySystem:getInjector():getInstance("getRewardView")

				if not response.data.reward then
					self._activitySystem:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
						maskOpacity = 0
					}, {
						rewards = response.data.reward
					}, delegate))
				end
			end)
		else
			storyEndCall()
		end
	end

	local storyAgent = storyDirector:getStoryAgent()
	local storyLink = ConfigReader:getDataByNameIdAndKey("ActivityStoryPoint", storyId, "StoryLink")

	storyAgent:setSkipCheckSave(not isCheck)
	storyAgent:trigger(storyLink, nil, endCallBack)
end

function ActivityStageFinishMediator:checkShowHiddenStory(pointId)
	local storyDirector = self:getInjector():getInstance(story.StoryDirector)
	local storyAgent = storyDirector:getStoryAgent()
	local pointInfo, pointType = self._model:getPointById(pointId, self._mapId)
	local stageType = self._activitySystem.curStageType
	local map = self._model:getStageByStageType(stageType)

	if pointType == kStageTypeMap.point and map then
		local hiddenStory = pointInfo:getHiddenStory()

		for link, v in pairs(hiddenStory) do
			local storyPoint = map:getStoryPointById(link)

			return storyPoint:isPass()
		end
	end

	return true
end
