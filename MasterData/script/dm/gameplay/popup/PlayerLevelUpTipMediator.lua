-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/popup/PlayerLevelUpTipMediator.lua

PlayerLevelUpTipMediator = class("PlayerLevelUpTipMediator", DmPopupViewMediator, _M)

PlayerLevelUpTipMediator:has("_systemKeeper", {
	is = "rw"
}):injectWith("SystemKeeper")
PlayerLevelUpTipMediator:has("_developSystem", {
	is = "rw"
}):injectWith("DevelopSystem")

local kBtnHandlers = {}

function PlayerLevelUpTipMediator:initialize()
	super.initialize(self)
end

function PlayerLevelUpTipMediator:dispose()
	local developSystem = self:getInjector():getInstance(DevelopSystem)

	developSystem._playerLevelUpTipViewShowSta = false

	local storyDirector = self:getInjector():getInstance(story.StoryDirector)
	local guideAgent = storyDirector:getGuideAgent()
	local scriptCtx = guideAgent:getCurrentScriptCtx()

	if scriptCtx then
		local userData = scriptCtx:getUserData()

		userData.isPlayerLevelup = false
	end

	storyDirector:notifyWaiting("exit_playerlevelup_view")
	super.dispose(self)
end

function PlayerLevelUpTipMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
end

function PlayerLevelUpTipMediator:mapEventListeners()
	return
end

function PlayerLevelUpTipMediator:onRemove()
	super.onRemove(self)
end

function PlayerLevelUpTipMediator:enterWithData(data)
	self:createUI(data)
	self:setupView()
end

function PlayerLevelUpTipMediator:setupView()
	local main = self:getView():getChildByName("main")
	local animNode = main:getChildByName("animNode")
	local descNode = main:getChildByName("descNode")

	descNode:setOpacity(0)

	local anim = cc.MovieClip:create("huodetishi_huodetishi")

	anim:setPlaySpeed(1.5)
	anim:addTo(animNode, 1)
	anim:addCallbackAtFrame(39, function()
		anim:stop()
	end)

	local cnText = anim:getChildByFullName("cnText")
	local enText = anim:getChildByFullName("enText")
	local desParent = anim:getChildByFullName("icon")

	descNode:setParent(desParent)

	local title1 = cc.Label:createWithTTF(Strings:get("RewardTitle_LeaderLVUP"), CUSTOM_TTF_FONT_1, 50)

	title1:enableOutline(cc.c4b(0, 0, 0, 255), 1)
	title1:addTo(cnText):offset(0, -3)

	local title2 = cc.Label:createWithTTF(Strings:get("UITitle_EN_Zhujueshengji"), TTF_FONT_FZYH_M, 18)

	title2:setColor(cc.c3b(150, 160, 255))
	title2:addTo(enText)
	anim:addCallbackAtFrame(14, function()
		descNode:fadeIn({
			time = 0.2
		})
	end)
end

function PlayerLevelUpTipMediator:createUI(info)
	AudioEngine:getInstance():playEffect("Se_Alert_Team_Levelup", false)

	local main = self:getView():getChildByName("main")
	local descNode = main:getChildByName("descNode")
	local NodeProperty = descNode:getChildByName("NodeProperty")
	local image1 = NodeProperty:getChildByFullName("image1.image")
	local image2 = NodeProperty:getChildByFullName("image2.image")
	local image3 = NodeProperty:getChildByFullName("image3.image")
	local TextGrade = NodeProperty:getChildByName("TextUpgrade")
	local TextUpgradeNum = NodeProperty:getChildByName("TextUpgradeNum")
	local TextCri = NodeProperty:getChildByName("TextCri")
	local TextCriNum = NodeProperty:getChildByName("TextCriNum")
	local TextCriNumAdd = NodeProperty:getChildByName("TextCriNumAdd")
	local TextSuck = NodeProperty:getChildByName("TextSuck")
	local TextSuckNum = NodeProperty:getChildByName("TextSuckNum")
	local TextSuckNumAdd = NodeProperty:getChildByName("TextSuckNumAdd")
	local NodeUnlock = descNode:getChildByName("NodeUnlock")
	local TextUnlock = NodeUnlock:getChildByName("Text_180")
	local TextUnlockName = NodeUnlock:getChildByName("TextUnlockName")
	local TextUnlockDes = NodeUnlock:getChildByName("TextUnlockDes")
	local descStrList, nameTtileList, num = self:getUnlockSystemDesc(info)
	local desStr = ""

	TextGrade:setString(Strings:get("Team_Level"))
	TextCri:setString(Strings:get("Tili_Text"))
	TextSuck:setString(Strings:get("Tili_Limit"))
	TextUnlock:setString(Strings:get("NEW_SYSTEM_OPEN"))

	for i, des in ipairs(descStrList) do
		desStr = i == #descStrList and desStr .. des or desStr .. des .. "、"
	end

	local preData = info.preData
	local curData = info.curData

	TextUpgradeNum:setString(curData.level or 0)

	local enemyAddNum = ConfigReader:getDataByNameIdAndKey("LevelConfig", curData.level, "GetActionPoint")

	TextCriNum:setString(math.max(tonumber(curData.enery) - enemyAddNum, 0))
	TextCriNumAdd:setString(math.abs(tonumber(curData.enery)))
	TextSuckNum:setString(preData.eneryLimt)
	TextSuckNumAdd:setString(math.abs(tonumber(curData.eneryLimt)))
	main:setTouchEnabled(true)
	main:addTouchEventListener(function(sender, eventType)
		self:onClickOK(sender, eventType)
	end)
	NodeUnlock:setVisible(#nameTtileList > 0)

	if #nameTtileList > 0 then
		TextUnlockName:setString(nameTtileList[1])
	end

	TextUnlockDes:setString(desStr)
	image1:setScaleX((TextGrade:getAutoRenderWidth() + 10) / image1:getContentSize().width)
	image2:setScaleX((TextCri:getAutoRenderWidth() + 10) / image2:getContentSize().width)
	image3:setScaleX((TextSuck:getAutoRenderWidth() + 10) / image3:getContentSize().width)
end

function PlayerLevelUpTipMediator:getUnlockSystemDesc(info)
	dump(info, "解锁系统描述")

	local preData = info.preData
	local curData = info.curData
	local strList = {}
	local strNameList = {}

	for i = preData.level + 1, curData.level do
		local configs = self._systemKeeper:getUnlockSystemsByLevel(i)

		if configs then
			for i = 1, #configs do
				local unLockConfig = configs[i]
				local nameStr = unLockConfig.LongDesc
				local titleStr = unLockConfig.Name

				if nameStr and nameStr ~= "" then
					strList[#strList + 1] = Strings:get(nameStr)
					strNameList[#strNameList + 1] = Strings:get(titleStr)
				end
			end
		end
	end

	dump(strList, "解锁系统内容")
	dump(strNameList, "解锁系统内容")

	return strList, strNameList, #strList
end

function PlayerLevelUpTipMediator:onClickOK(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

		local storyDirector = self:getInjector():getInstance(story.StoryDirector)
		local guideAgent = storyDirector:getGuideAgent()
		local guideSystem = self:getInjector():getInstance(GuideSystem)
		local guideNames, guideViewName = guideSystem:checkLevelUpGuide()

		if #guideNames > 0 then
			if guideAgent:isGuiding() then
				guideAgent:setStoryEnd(function()
					delayCallByTime(0.016666666666666666, function()
						guideAgent:trigger(guideNames, nil, nil)

						local dispatcher = DmGame:getInstance()

						dispatcher:dispatch(Event:new(EVT_POP_TO_TARGETVIEW, "homeView"))
					end)
				end)
			else
				guideAgent:trigger(guideNames, nil, nil)

				local scene = self:getInjector():getInstance("BaseSceneMediator", "activeScene")
				local topViewName = scene:getTopViewName()
				local topView = scene:getTopView()

				if topViewName == "homeView" and topView then
					self:dispatch(Event:new(EVT_POP_TO_TARGETVIEW, "homeView"))
					self:close()
				else
					self:dispatch(Event:new(EVT_POP_TO_TARGETVIEW, "homeView"))
				end

				return
			end
		end

		self:close()
	end
end
