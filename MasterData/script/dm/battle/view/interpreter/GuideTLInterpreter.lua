-- chunkname: @/tmp/or_script/lua_compile/dm/battle/view/interpreter/GuideTLInterpreter.lua

require("dm.battle.view.widget.BattleGuideWidget")
require("dm.battle.view.widget.BattleGuideOptionalWidget")

GuideTLInterpreter = class("GuideTLInterpreter", TLInterpreter)

function GuideTLInterpreter:initialize(viewContext)
	super.initialize(self)

	self._context = viewContext
	self._eventCenter = viewContext:getValue("EventCenter")
	self._mainMediator = viewContext:getValue("BattleMainMediator")
	self._battleGround = viewContext:getValue("BattleGroundLayer")
	self._battleUIMediator = viewContext:getValue("BattleUIMediator")
	self._unitManager = viewContext:getValue("BattleUnitManager")
	self._screenEffectLayer = viewContext:getValue("BattleScreenEffectLayer")
	self._viewFrame = self._mainMediator:getTargetFrame()
	self._dragHeroCount = 0

	local injector = self._mainMediator:getInjector()
	local customDataSystem = injector:getInstance("CustomDataSystem")

	self._complexityNum = tonumber(customDataSystem:getValue(PrefixType.kGlobal, "GuideComplexityNum")) or 999
end

function GuideTLInterpreter:doAction(action, args, mode)
	Bdump("GuideTLInterpreter:doAction", action)
	super.doAction(self, action, args, mode)
end

function GuideTLInterpreter:act_Prologue(action, val)
	self._context:setValue("Prologue", val)
end

function GuideTLInterpreter:act_SGuideSpeak(action, args)
	local resPath = "asset/ui/BattleGuideSpeakWidget.csb"
	local node = cc.CSLoader:createNode(resPath)
	local widget = self._mainMediator:autoManageObject(BattleGuideSpeakWidget:new(node, args))
	local uiLayer = self._battleUIMediator:getView()
	local viewFrame = self._mainMediator:getTargetFrame()
	local pos

	widget:getView():setPosition(args.style == "right" and cc.p(viewFrame.width - viewFrame.right, viewFrame.height - 200) or cc.p(viewFrame.left, viewFrame.height - 200))
	widget:getView():addTo(uiLayer)
	widget:setViewContext(self._context)
end

function GuideTLInterpreter:act_SGuideOption(action, args)
	local resPath = "asset/ui/Option2Dialogue.csb"
	local node = cc.CSLoader:createNode(resPath)
	local widget = self._mainMediator:autoManageObject(PortraitOptionWidget:new(node))
	local uiLayer = self._battleUIMediator:getView()

	widget:getView():addTo(uiLayer):center(uiLayer:getContentSize())
	widget:setupView()
	self:_pauseBattle()

	local function callback(optionId)
		self:_resumeBattle()
		args.callback(optionId)
	end

	widget:updateView(args, callback)
end

function GuideTLInterpreter:act_RmGuideSpeak(action, args)
	self._mainMediator:removeGuideSpeak(args)
end

function GuideTLInterpreter:act_PauseBattle(action, args)
	self:_pauseBattle()
end

function GuideTLInterpreter:act_ResumeBattle(action, args)
	self:_resumeBattle()
end

function GuideTLInterpreter:act_HideTime(actin, args)
	if self._battleUIMediator._timerWidget then
		self._battleUIMediator._timerWidget:getView():setVisible(false)
	end
end

function GuideTLInterpreter:act_HideRightButton(action, args)
	self._battleUIMediator._ctrlButtons:getView():setVisible(false)
end

function GuideTLInterpreter:act_HidePauseButton(action, args)
	self._battleUIMediator._ctrlButtons:getView():getChildByFullName("pause_panel"):setVisible(false)
end

function GuideTLInterpreter:act_ShowRightButton(action, args)
	self._battleUIMediator._ctrlButtons:getView():setVisible(true)
end

function GuideTLInterpreter:act_HideSkillButton(action, args)
	self._battleUIMediator._masterWidget:getView():setVisible(false)
end

function GuideTLInterpreter:act_ShowSkillButton(action, args)
	self._battleUIMediator._masterWidget:getView():setVisible(true)
end

function GuideTLInterpreter:act_HideCardArray(action, args)
	self._battleUIMediator._cardArray:getView():setVisible(false)
end

function GuideTLInterpreter:act_ShowCardArray(action, args)
	self._battleUIMediator._cardArray:getView():setVisible(true)
end

function GuideTLInterpreter:act_ShowEnergyBar(action, args)
	self._battleUIMediator._energyBar:getView():setVisible(true)
end

function GuideTLInterpreter:act_HideEnergyBar(action, args)
	self._battleUIMediator._energyBar:getView():setVisible(false)
end

function GuideTLInterpreter:act_StartGuide(action, args)
	if args.complexityNum and args.complexityNum > self._complexityNum then
		return
	end

	if not args.style then
		local style = "card"

		if not args.offset then
			local offset = {
				x = 0,
				y = 0
			}

			local function sendStatisticPoint()
				if args.statisticPoint then
					local content = {
						type = "loginpoint",
						point = args.statisticPoint
					}

					StatisticSystem:send(content)
				end
			end

			local function onClickGuideCard(sender, eventType, endCallback)
				if eventType == ccui.TouchEventType.ended then
					self._mainMediator:setTimeScale(1)

					if args.pause then
						self:_resumeBattle()
					end

					endCallback()
				end
			end

			local targetNode, targetNextNode
			local effectRotation = 0

			if style == "viewCard" then
				local cardArray = self._battleUIMediator:getCardArray()
				local cardIndex = args.cardIndex
				local realCard

				if cardArray then
					cardArray:visitCards(function(slot, card, index)
						if card and (cardIndex == nil or index == cardIndex) then
							local heroId = card:getHeroId()

							if args.hero == nil or heroId == args.hero then
								targetNode = card:getView():getChildByFullName("card_node.card_bg")
								realCard = card
							end
						end
					end)

					function onClickGuideCard(sender, eventType, endCallback)
						if eventType == ccui.TouchEventType.ended then
							cardArray:setActiveCard(realCard)
							sendStatisticPoint()

							if args.pause then
								self:_resumeBattle()
							end

							endCallback()
						end
					end
				end
			elseif style == "card" then
				local cardArray = self._battleUIMediator:getCardArray()
				local cardIndex = args.cardIndex
				local realCard

				if cardArray then
					cardArray:visitCards(function(slot, card, index)
						if card and (cardIndex == nil or index == cardIndex) then
							local heroId = card:getHeroId()

							if args.hero == nil or heroId == args.hero then
								targetNode = card:getView():getChildByFullName("card_node.card_bg")
								realCard = card
							end
						end
					end)

					function onClickGuideCard(sender, eventType, endCallback)
						if eventType == ccui.TouchEventType.ended then
							cardArray:setActiveCard(realCard)

							if args.pause then
								self:_resumeBattle()
							end

							endCallback()
							self:act_StartGuide("StartGuide", args.cell)
						end
					end
				end
			elseif style == "cell" then
				local cell = self._battleGround:getCellById(args.cell)

				if cell and cell:getStatus() ~= GroundCellStatus.OCCUPIED then
					targetNode = cell:getDisplayNode()

					function onClickGuideCard(sender, eventType, endCallback)
						if eventType == ccui.TouchEventType.ended then
							self._battleGround:onClickedCell(args.cell)

							if args.pause then
								self:_resumeBattle()
							end

							endCallback()
						end
					end
				end
			elseif style == "unique" then
				local masterWidget = self._battleUIMediator:getMasterWidget()
				local skillNode = masterWidget:getSkillNode(args.skillIndex)

				if skillNode == nil then
					return
				end

				targetNode = skillNode

				function onClickGuideCard(sender, eventType, endCallback)
					if eventType == ccui.TouchEventType.ended then
						masterWidget:executeSkill(skillNode)
						sendStatisticPoint()

						if args.pause then
							self:_resumeBattle()
						end

						endCallback()
					end
				end
			elseif style == "slideCard" then
				local cardArray = self._battleUIMediator:getCardArray()
				local cardIndex = args.cardIndex
				local cellNum = args.cell
				local realCard, realSlot
				local cell = self._battleGround:getCellById(cellNum)

				if cardArray and cell then
					if cell:getStatus() ~= GroundCellStatus.OCCUPIED then
						targetNextNode = cell:getDisplayNode()
					end

					local cardView = self._battleUIMediator._cardArray:getView()

					if cardIndex then
						targetNode = cardView:getChildByFullName("C" .. cardIndex)
					end

					cardArray:visitCards(function(slot, card, index)
						if card and (cardIndex == nil or index == cardIndex) then
							local heroId = card._modelId

							if args.hero == nil or heroId == args.hero then
								realCard = card
								realSlot = slot
								targetNode = cardView:getChildByFullName("C" .. index)
							end
						end
					end)

					local moveSta = false

					function onClickGuideCard(sender, eventType, endCallback, endSta)
						if not realCard then
							endCallback()
							sendStatisticPoint()

							return
						end

						if endSta then
							cardArray:setActiveCard(realCard)
							self._battleGround:onClickedCell(args.cell)

							if args.pause then
								self:_resumeBattle()
							end

							endCallback()
							sendStatisticPoint()
						else
							local pos

							if eventType == ccui.TouchEventType.began then
								pos = sender:getTouchBeganPosition()

								if realSlot:hitTest(pos) then
									moveSta = true

									cardArray:guideTouchBegan(realCard, pos)
								end
							elseif eventType == ccui.TouchEventType.moved then
								if moveSta then
									pos = sender:getTouchMovePosition()

									cardArray:guideTouchMoved(pos)
								end
							elseif eventType == ccui.TouchEventType.ended or eventType == ccui.TouchEventType.canceled then
								if moveSta then
									pos = sender:getTouchEndPosition()

									local aabb = cell:getAABB()
									local wpos = cell:getDisplayNode():convertToWorldSpace(cc.p(0, 0))

									aabb = cc.rect(wpos.x - aabb.width / 2, wpos.y - aabb.height / 2, aabb.width, aabb.height)

									if cc.rectContainsPoint(aabb, pos) then
										cardArray:guideTouchEnded(wpos, true)

										if args.pause then
											self:_resumeBattle()
										end

										endCallback()
										sendStatisticPoint()
									else
										endCallback(true)
										cardArray:guideTouchEnded(cc.p(100000, 100000))
									end

									moveSta = false
								else
									endCallback(true)
								end
							end
						end
					end

					if args.autoRotation and targetNode and targetNextNode then
						local targetSize = targetNode:getContentSize()
						local targetNodeAP = targetNode:getAnchorPoint()
						local offset = offset or cc.p(0, 0)
						local pt = cc.p(targetNode:getPositionX() + offset.x, targetNode:getPositionY() + offset.y)
						local centerPt = cc.p(pt.x + targetSize.width * (0.5 - targetNodeAP.x), pt.y + targetSize.height * (0.5 - targetNodeAP.y))
						local posB = targetNode:getParent():convertToWorldSpace(centerPt)
						local posE = targetNextNode:convertToWorldSpace(cc.p(0, 0))
						local angle = math.deg(math.atan2(posE.y - posB.y, posE.x - posB.x))

						effectRotation = 90 - angle
					end
				end
			elseif style == "autoBtn" then
				targetNode = self._battleUIMediator._ctrlButtons:getView():getChildByName("auto_panel")

				function onClickGuideCard(sender, eventType, endCallback)
					if eventType == ccui.TouchEventType.ended then
						self._battleUIMediator._ctrlButtons:guideChangeAutoBtns(true)
						sendStatisticPoint()

						if args.pause then
							self:_resumeBattle()
						end

						endCallback()
					end
				end
			end

			if targetNode then
				if args.pause then
					self:_pauseBattle()
				end

				local widgetData = {}

				widgetData.text = args.text or ""
				widgetData.nextText = args.celltext or ""
				widgetData.textRefpt = args.textRefpt
				widgetData.hasMask = true
				widgetData.targetNode = targetNode
				widgetData.targetNextNode = targetNextNode
				widgetData.clickListener = onClickGuideCard
				widgetData.offset = offset
				widgetData.style = args.effectStyle
				widgetData.maskNodeScale = args.maskNodeScale
				widgetData.duration = args.duration
				widgetData.arrowOffset = args.arrowOffset or {
					x = 0,
					y = 0
				}
				widgetData.arrowScale = args.arrowScale or {
					x = 1,
					y = 1
				}
				widgetData.rotation = args.rotation or effectRotation
				widgetData.arrowPos = args.arrowPos
				widgetData.circleScale = args.circleScale
				widgetData.heroId = args.heroId

				local guideWidget = BattleGuideWidget:new(cc.Node:create())

				guideWidget:getView():addTo(self._mainMediator:getView():getParent())
				guideWidget:setupView(widgetData)
			end
		end
	end
end

function GuideTLInterpreter:act_StartStory(action, args)
	if args.complexityNum and args.complexityNum > self._complexityNum then
		return
	end

	local injector = self._mainMediator:getInjector()
	local storyDirector = injector:getInstance(story.StoryDirector)
	local storyAgent = storyDirector:getStoryAgent()
	local storyName = args.story

	if args.pause then
		self:_pauseBattle()
	end

	if args.statisticPoint then
		local content = {
			type = "loginpoint",
			point = args.statisticPoint
		}

		StatisticSystem:send(content)
	end

	local function callback(script, context)
		storyAgent:setSkipCheckSave(false)

		if args.pause then
			self:_resumeBattle()
		else
			self._mainMediator:setTimeScale(args.timeScale or 0.9)
		end

		if args.leaveBattle then
			self._mainMediator:tryLeaving()
		end
	end

	storyAgent:setSkipCheckSave(true)
	storyAgent:play(storyName, nil, callback)
end

function GuideTLInterpreter:act_SetupOptionalGuide(action, args)
	local node = self._mainMediator:getView()
	local waitTime = ConfigReader:getDataByNameIdAndKey("ConfigValue", "NewPlayerGuide_Time", "content")
	local textDes = ConfigReader:getDataByNameIdAndKey("ConfigValue", "NewPlayerGuide_Text", "content")

	performWithDelay(node, function()
		local args = {
			text = Strings:get(textDes, {
				fontName = TTF_FONT_FZYH_R
			}),
			textRefpt = {
				x = 0.65,
				y = 0.4
			}
		}

		self:act_StartOptionalGuide(action, args)
	end, waitTime / 1000)
end

function GuideTLInterpreter:act_StartOptionalGuide(action, args)
	local teamTab = {}

	for i = 1, 9 do
		if i ~= 8 then
			local cell = self._battleGround:getCellById(i)

			if cell and cell:getStatus() ~= GroundCellStatus.OCCUPIED then
				table.insert(teamTab, i)
			end
		end
	end

	if #teamTab <= 6 or self._dragHeroCount >= 2 then
		return
	end

	local cellIndex = teamTab[math.random(1, #teamTab)]
	local cardArray = self._battleUIMediator:getCardArray()
	local cardIndex

	cardArray:visitCards(function(slot, card, index)
		if card and cardIndex == nil then
			cardIndex = index
		end
	end)

	if cardIndex == nil then
		return
	end

	self:act_touchNodeToNextNode(args, cardIndex, cellIndex)
end

function GuideTLInterpreter:act_EndOptionalGuide(action, args)
	self._dragHeroCount = self._dragHeroCount + 1

	local node = self._mainMediator:getView()

	if node then
		node:stopAllActions()

		if self._dragHeroCount < 2 then
			local waitTime = ConfigReader:getDataByNameIdAndKey("ConfigValue", "NewPlayerGuide_Time2", "content")
			local textDes = ConfigReader:getDataByNameIdAndKey("ConfigValue", "NewPlayerGuide_Text", "content")

			performWithDelay(node, function()
				local args = {
					text = Strings:get(textDes, {
						fontName = TTF_FONT_FZYH_R
					}),
					textRefpt = {
						x = 0.65,
						y = 0.4
					}
				}

				self:act_StartOptionalGuide(action, args)
			end, waitTime / 1000)
		end
	end
end

function GuideTLInterpreter:act_touchNodeToNextNode(args, cardIndex, cellNum)
	local battleType = SettingBattleTypes.kNormalStage
	local isAuto = self._mainMediator:getInjector():getInstance(SettingSystem):getSettingModel():getBattleSetting(battleType)

	if isAuto then
		return
	end

	local cardArray = self._battleUIMediator:getCardArray()
	local targetNode, targetNextNode, effectRotation
	local cell = self._battleGround:getCellById(cellNum)

	if cardArray and cell then
		if cell:getStatus() ~= GroundCellStatus.OCCUPIED then
			targetNextNode = cell:getDisplayNode()
		end

		local key = "C" .. cardIndex .. ".node"

		targetNode = self._battleUIMediator:getView():getChildByFullName("bottom.card_array." .. key)

		if targetNode and targetNextNode then
			local targetSize = targetNode:getContentSize()
			local targetNodeAP = targetNode:getAnchorPoint()

			if not offset then
				local offset = cc.p(0, 0)
				local pt = cc.p(targetNode:getPositionX() + offset.x, targetNode:getPositionY() + offset.y)
				local centerPt = cc.p(pt.x + targetSize.width * (0.5 - targetNodeAP.x), pt.y + targetSize.height * (0.5 - targetNodeAP.y))
				local posB = targetNode:getParent():convertToWorldSpace(centerPt)
				local posE = targetNextNode:convertToWorldSpace(cc.p(0, 0))
				local angle = math.deg(math.atan2(posE.y - posB.y, posE.x - posB.x))

				effectRotation = 90 - angle
			end
		end
	end

	if targetNode and targetNextNode then
		local widgetData = {}

		widgetData.text = args.text or ""
		widgetData.textRefpt = args.textRefpt
		widgetData.targetNode = targetNode
		widgetData.targetNextNode = targetNextNode
		widgetData.rotation = effectRotation or 0
		widgetData.arrowOffset = args.arrowOffset or {
			x = 0,
			y = 0
		}
		widgetData.heroId = args.heroId

		local guideWidget = BattleGuideOptionalWidget:new(cc.Node:create())

		self._mainMediator:retainGuideLayer(guideWidget:getView())
		guideWidget:setupView(widgetData)
	end
end

function GuideTLInterpreter:act_SaveGuide(action, args)
	local injector = self._mainMediator:getInjector()
	local customDataSystem = injector:getInstance(CustomDataSystem)
	local name = args.name

	customDataSystem:setValue(PrefixType.kGlobal, name, true)
end

function GuideTLInterpreter:act_GuideAutoBtn(action, args)
	self._battleUIMediator._ctrlButtons:guideChangeAutoBtns(false)
end

function GuideTLInterpreter:act_ShowMode(action, args)
	if args.complexityNum and args.complexityNum > self._complexityNum then
		return
	end

	local function sendStatisticPoint()
		if args.statisticPoint then
			local content = {
				type = "loginpoint",
				point = args.statisticPoint
			}

			StatisticSystem:send(content)
		end
	end

	self:_pauseBattle()

	if not args.style then
		local style = ""
		local targetNodeList = {}

		if args.style == "card" then
			if args.cardIndex and args.cardIndex > 0 and args.cardIndex < 5 then
				local key = "C" .. args.cardIndex .. ".node"

				targetNodeList[1] = self._battleUIMediator:getView():getChildByFullName("bottom.card_array." .. key)
			else
				targetNodeList[1] = self._battleUIMediator:getView():getChildByFullName("bottom.card_array.bg")
			end
		elseif args.style == "energy" then
			targetNodeList[1] = self._battleUIMediator:getView():getChildByFullName("bottom.energy_bar.bg")
		elseif args.style == "skill" then
			local masterWidget = self._battleUIMediator:getMasterWidget()

			targetNodeList[1] = masterWidget:getSkillNode(args.skillIndex)
		elseif args.style == "anger" then
			targetNodeList[1] = self._battleUIMediator:getView():getChildByFullName("header.leftHead")
		elseif args.style == "cardinfo" then
			targetNodeList[1] = self._battleUIMediator._heroTipWidget:getView():getChildByFullName("genreIcon")
		elseif args.style == "cardcost" then
			local heroCard = self._battleUIMediator:getCardArray():getCardAtIndex(args.cardIndex)

			if heroCard then
				targetNodeList[1] = heroCard._costBg
			end
		elseif args.style == "cardjob" then
			if type(args.cardIndex) == "table" then
				for i, v in ipairs(args.cardIndex) do
					local heroCard = self._battleUIMediator:getCardArray():getCardAtIndex(v)

					if heroCard then
						targetNodeList[i] = heroCard._genrePic
					end
				end
			else
				local heroCard = self._battleUIMediator:getCardArray():getCardAtIndex(args.cardIndex)

				if heroCard then
					targetNodeList[1] = heroCard._genrePic
				end
			end
		elseif args.style == "autoBtn" then
			targetNodeList[1] = self._battleUIMediator._ctrlButtons:getView():getChildByName("auto_panel")
		elseif args.style == "speedBtn" then
			targetNodeList[1] = self._battleUIMediator._ctrlButtons:getView():getChildByName("speed_panel")
		end

		local winSize = cc.Director:getInstance():getVisibleSize()
		local renderNode = cc.Node:create()

		renderNode:setContentSize(winSize)
		renderNode:addTo(self._mainMediator:getView():getParent(), 1000)

		local clippingNode = cc.ClippingNode:create()

		clippingNode:addTo(renderNode, 1)

		local stencil = cc.Node:create()
		local maskLayer = cc.LayerColor:create(cc.c4b(0, 0, 0, 150))

		maskLayer:setContentSize(cc.size(winSize.width, winSize.height))
		maskLayer:setTouchEnabled(true)
		maskLayer:setSwallowsTouches(true)

		if #targetNodeList > 0 then
			for i, targetNode in ipairs(targetNodeList) do
				if targetNode then
					if not args.offset then
						local offset = {
							x = 0,
							y = 0
						}
						local targetSize = targetNode:getContentSize()
						local targetNodeAP = targetNode:getAnchorPoint()
						local pt = cc.p(targetNode:getPositionX() + offset.x, targetNode:getPositionY() + offset.y)
						local centerPt = cc.p(pt.x + targetSize.width * (0.5 - targetNodeAP.x), pt.y + targetSize.height * (0.5 - targetNodeAP.y))
						local targetPt = targetNode:getParent():convertToWorldSpace(centerPt)
						local image = ccui.ImageView:create(args.maskRes)
						local msSize = image:getContentSize()

						if args.maskSize then
							local size = args.maskSize

							image:setScale(size.w / msSize.width, size.h / msSize.height)
						end

						stencil:addChild(image)
						image:setPosition(targetPt)
						image:offset(offset.x, offset.y)

						if not args.maskSize then
							local maskSize = {
								w = msSize.width,
								h = msSize.height
							}

							self:createMaskBox(renderNode, maskSize, targetPt, offset)
						end
					end
				end
			end
		end

		clippingNode:setInverted(true)
		clippingNode:addChild(maskLayer)
		clippingNode:setAlphaThreshold(0.05)
		clippingNode:setStencil(stencil)

		local textNode = GuideText:new(args)
		local guideTextView = textNode:getView()

		guideTextView:addTo(renderNode, 1000)

		local function destoryNode()
			cancelDelayCall(self._touchSchedule)
			cancelDelayCall(self._timeSchedule)

			if style == "cardinfo" then
				local cardArray = self._battleUIMediator:getCardArray()

				cardArray:resetActiveCard()
			end

			if self._energyAnims then
				for k, v in pairs(self._energyAnims) do
					v:removeFromParent(true)
				end
			end

			self._energyAnims = nil

			renderNode:removeFromParent(true)
			sendStatisticPoint()

			if args.next then
				self:act_ShowMode(action, args.next)

				return
			end

			self:_resumeBattle()
		end

		if args.energyEffect then
			self._energyAnims = {}

			local cardArray = self._battleUIMediator:getCardArray()

			if cardArray then
				cardArray:visitCards(function(slot, card, index)
					if slot then
						local energyNode = slot:getContainerNode()
						local energyAnim = cc.MovieClip:create("saoguang_yindaoguangquan")

						energyAnim:addTo(energyNode):center(energyNode:getContentSize())

						self._energyAnims[#self._energyAnims + 1] = energyAnim
					end
				end)
			end
		end

		local waitTimeClick = ConfigReader:getDataByNameIdAndKey("ConfigValue", "NewPlayerGuide_Time3", "content") or 2000
		local waitTimeRemove = ConfigReader:getDataByNameIdAndKey("ConfigValue", "NewPlayerGuide_Time4", "content") or 5000

		self._touchSchedule = delayCallByTime(waitTimeClick, function()
			maskLayer:onTouch(function(event)
				if event.name == "began" then
					destoryNode()
				end
			end)
		end)
		self._timeSchedule = delayCallByTime(waitTimeRemove, function()
			destoryNode()
		end)
	end
end

function GuideTLInterpreter:act_ShowGuideText(action, args)
	if args.complexityNum and args.complexityNum > self._complexityNum then
		return
	end

	self:_pauseBattle()

	local function sendStatisticPoint()
		if args.statisticPoint then
			local content = {
				type = "loginpoint",
				point = args.statisticPoint
			}

			StatisticSystem:send(content)
		end
	end

	local winSize = cc.Director:getInstance():getVisibleSize()
	local renderNode = cc.Node:create()

	renderNode:setContentSize(winSize)
	renderNode:addTo(self._mainMediator:getView():getParent(), 1000)

	local maskLayer = cc.LayerColor:create(cc.c4b(0, 0, 0, args.opacity or 0))

	maskLayer:setContentSize(cc.size(winSize.width, winSize.height))
	maskLayer:addTo(renderNode, 2)
	maskLayer:setTouchEnabled(true)
	maskLayer:setSwallowsTouches(true)

	if args.cardShowNum and #args.cardShowNum > 0 then
		local node_label = self:createCardCellNum(args.cardShowNum)

		node_label:addTo(renderNode, 999)
	end

	local textNode = GuideText:new(args)
	local guideTextView = textNode:getView()

	if not args.textRefpt then
		guideTextView:addTo(renderNode, 1000)

		local function destoryNode()
			sendStatisticPoint()
			cancelDelayCall(self._touchSchedule)
			cancelDelayCall(self._timeSchedule)
			renderNode:removeFromParent(true)
			self:_resumeBattle()
		end

		local waitTimeClick = ConfigReader:getDataByNameIdAndKey("ConfigValue", "NewPlayerGuide_Time3", "content") or 2000
		local waitTimeRemove = ConfigReader:getDataByNameIdAndKey("ConfigValue", "NewPlayerGuide_Time4", "content") or 5000

		self._touchSchedule = delayCallByTime(waitTimeClick, function()
			maskLayer:onTouch(function(event)
				if event.name == "began" then
					destoryNode()
				end
			end)
		end)
		self._timeSchedule = delayCallByTime(waitTimeRemove, function()
			destoryNode()
		end)
	end
end

function GuideTLInterpreter:createMaskBox(parent, maskSize, targetPt, offset)
	local scaleAnim = cc.MovieClip:create("suofang_yindao")

	scaleAnim:addTo(parent, 999)

	local scaleNode = scaleAnim:getChildByFullName("Image")
	local scaleImg = ccui.Scale9Sprite:createWithSpriteFrameName("zz_yindaoimage.png")

	scaleImg:setAnchorPoint(0.5, 0.5)
	scaleImg:setCapInsets(cc.rect(57, 57, 61, 61))

	if maskSize then
		scaleImg:setContentSize(cc.size(maskSize.w + 20, maskSize.h + 20))
	end

	local actionPos = {}

	actionPos.x = targetPt.x
	actionPos.y = targetPt.y

	scaleImg:addTo(parent, 999)
	scaleImg:setPosition(actionPos)
	scaleImg:offset(offset.x, offset.y)

	local nodeToActionMap = {}

	nodeToActionMap[scaleImg] = scaleNode

	local startFunc, stopFunc = CommonUtils.bindNodeToActionNode(nodeToActionMap, parent, true)
	local flickerAnim = cc.MovieClip:create("faguang_yindao")

	flickerAnim:addTo(parent, 999)

	local flickerNode = flickerAnim:getChildByFullName("Image")
	local flickerImg = ccui.Scale9Sprite:createWithSpriteFrameName("zg_yindaoimage.png")

	flickerImg:setAnchorPoint(0.5, 0.5)
	flickerImg:setCapInsets(cc.rect(73, 73, 49, 49))

	local deltaOffsetX = 0
	local deltaOffsetY = 0

	if maskSize then
		local deltaW = maskSize.w >= 120 and 60 or 60 * maskSize.w / 146

		deltaOffsetX = maskSize.w >= 120 and 0 or 30 - 30 * maskSize.w / 146

		local deltaH = maskSize.h >= 120 and 60 or 60 * maskSize.h / 146

		deltaOffsetY = maskSize.h >= 120 and 0 or 30 - 30 * maskSize.h / 146

		flickerImg:setContentSize(cc.size(maskSize.w + deltaW, maskSize.h + deltaH))
	end

	flickerImg:addTo(parent, 999)
	flickerImg:setPosition(actionPos)
	flickerImg:offset(offset.x - deltaOffsetX / 4, offset.y - deltaOffsetY / 4)

	local nodeToActionMap2 = {}

	nodeToActionMap2[flickerImg] = flickerNode

	local startFunc2, stopFunc2 = CommonUtils.bindNodeToActionNode(nodeToActionMap2, flickerNode)

	startFunc()
	scaleAnim:addCallbackAtFrame(17, function()
		stopFunc()
		scaleAnim:setVisible(false)
		scaleImg:setVisible(false)
		startFunc2()
	end)
end

function GuideTLInterpreter:act_ShowHero(action, args)
	local function sendStatisticPoint()
		if args.statisticPoint then
			local content = {
				type = "loginpoint",
				point = args.statisticPoint
			}

			StatisticSystem:send(content)
		end
	end

	self:_pauseBattle()

	local winSize = cc.Director:getInstance():getVisibleSize()
	local renderNode = cc.Node:create()

	renderNode:setContentSize(winSize)
	renderNode:addTo(self._mainMediator:getView():getParent(), 1000)

	local clippingNode = cc.ClippingNode:create()

	clippingNode:addTo(renderNode, 1)

	local stencil = cc.Node:create()
	local maskLayer = cc.LayerColor:create(cc.c4b(0, 0, 0, 125))

	maskLayer:setContentSize(cc.size(winSize.width, winSize.height))
	maskLayer:setTouchEnabled(true)
	maskLayer:setSwallowsTouches(true)

	if args.hideMask then
		maskLayer:setVisible(false)
	end

	local function createMaskNode(style, pos)
		local roleId

		if style == "enemy" then
			local leftTeam = self._unitManager._rightTeam
			local heroInfo = leftTeam[pos]

			roleId = heroInfo._roleId
		else
			local leftTeam = self._unitManager._leftTeam
			local heroInfo = leftTeam[pos]

			roleId = heroInfo._roleId
		end

		local roleObject = self._unitManager._members[roleId]
		local targetNode = roleObject._modelNode

		if not args.offset then
			local targetPt = targetNode:getParent():convertToWorldSpace(cc.p(0, 0))
			local image = ccui.ImageView:create(args.maskRes)
			local msSize = image:getContentSize()

			if args.maskSize then
				local size = args.maskSize

				image:setScale(size.w / msSize.width, size.h / msSize.height)
			end

			stencil:addChild(image)
			image:setPosition(targetPt)
			image:offset(args.offset.x, args.offset.y)

			if not args.maskSize then
				local maskSize = {
					w = msSize.width,
					h = msSize.height
				}

				self:createMaskBox(renderNode, maskSize, targetPt, args.offset)
			end
		end
	end

	local style = args.style

	if not args.pos then
		createMaskNode(style, args.pos)

		if args.nextStyle and args.nextPos then
			createMaskNode(args.nextStyle, args.nextPos)
		end

		clippingNode:setInverted(true)
		clippingNode:addChild(maskLayer)
		clippingNode:setAlphaThreshold(0.05)
		clippingNode:setStencil(stencil)

		if not args.nextShow then
			local nextShow
			local nextShowGuideText = args.nextShowGuideText

			local function destoryNode()
				cancelDelayCall(self._touchSchedule)
				cancelDelayCall(self._timeSchedule)
				renderNode:removeFromParent(true)
				sendStatisticPoint()
				self:_resumeBattle()

				if nextShow then
					self:act_ShowHero(action, nextShow)
				elseif nextShowGuideText then
					self:act_ShowGuideText(action, nextShowGuideText)
				end
			end

			if args.cardShowNum and #args.cardShowNum > 0 then
				local node_label = self:createCardCellNum(args.cardShowNum)

				node_label:addTo(renderNode, 999)
			end

			local textNode = GuideText:new(args)
			local guideTextView = textNode:getView()

			if not args.textRefpt then
				guideTextView:addTo(renderNode, 1000)

				local cellStatusArray = {}

				if args.effectStyle and type(args.effectStyle) == "table" then
					for animName, v in pairs(args.effectStyle) do
						if animName == "leftRightAnim" then
							local arrowAnim2 = cc.MovieClip:create("zz_xinshouyindao")

							arrowAnim2:addTo(renderNode, 4)
							arrowAnim2:setPosition(targetPt)
							arrowAnim2:offset(offset.x + v.x, offset.y + v.y)

							if v.rotation then
								arrowAnim2:setRotation(v.rotation)
							end
						end

						if animName == "upDownAnim" then
							local arrowAnim1 = cc.MovieClip:create("xiangxia_xinshouyindao")

							arrowAnim1:addTo(renderNode, 4)
							arrowAnim1:setPosition(targetPt)
							arrowAnim1:offset(offset.x + v.x, offset.y + v.y)
						end

						if animName == "positionAnim" then
							for i = 1, 9 do
								local cell = self._battleGround:getCellById(i)

								if cell then
									cellStatusArray[i] = cell:getStatus()

									if table.indexof(v, i) then
										cell:setStatus(GroundCellStatus.HIGHLIGHT)
										cell:setOpacity(255)
									end
								end
							end
						end
					end
				end

				local function resetCellStatus()
					for i, v in pairs(cellStatusArray) do
						local cell = self._battleGround:getCellById(i)

						if cell then
							cell._displayNode:removeChildByName("NumberLabel")
							cell:setStatus(v)
							cell:setOpacity(100)
						end
					end
				end

				local waitTimeClick = ConfigReader:getDataByNameIdAndKey("ConfigValue", "NewPlayerGuide_Time3", "content") or 2000
				local waitTimeRemove = ConfigReader:getDataByNameIdAndKey("ConfigValue", "NewPlayerGuide_Time4", "content") or 5000

				self._touchSchedule = delayCallByTime(waitTimeClick, function()
					maskLayer:onTouch(function(event)
						if event.name == "began" then
							resetCellStatus()
							destoryNode()
						end
					end)
				end)
				self._timeSchedule = delayCallByTime(waitTimeRemove, function()
					resetCellStatus()
					destoryNode()
				end)
			end
		end
	end
end

function GuideTLInterpreter:act_AutoGuide(action, args)
	local autoGuide = true

	for i = 1, 9 do
		if i ~= 8 then
			local cell = self._battleGround:getCellById(i)

			if cell and cell:getStatus() == GroundCellStatus.OCCUPIED then
				autoGuide = false
			end
		end
	end

	if autoGuide then
		local cardArray = self._battleUIMediator:getCardArray()

		cardArray:guideTouchEnded(cc.p(-100000, -100000))
		self:act_StartGuide(action, args)
	end
end

function GuideTLInterpreter:act_HideRoleObject(action, args)
	if not args.pos then
		local pos = 1
		local leftTeam = self._unitManager._rightTeam
		local heroInfo = leftTeam[pos]

		if heroInfo and heroInfo._roleId then
			local roleId = heroInfo._roleId
			local roleObject = self._unitManager._members[roleId]

			if roleObject then
				roleObject:guideHideObject()
			end
		end
	end
end

function GuideTLInterpreter:act_RoleGoBattle(action, args)
	if not args.pos then
		local pos = 1
		local leftTeam = self._unitManager._rightTeam
		local heroInfo = leftTeam[pos]

		if heroInfo and heroInfo._roleId then
			local roleId = heroInfo._roleId
			local roleObject = self._unitManager._members[roleId]

			if roleObject then
				roleObject:guideGoBattle()
			end
		end
	end
end

function GuideTLInterpreter:act_HideGroundLayer()
	self._battleGround:getGroundLayer():setVisible(false)
end

function GuideTLInterpreter:act_ShowGroundLayer()
	self._battleGround:getGroundLayer():setVisible(true)
end

function GuideTLInterpreter:act_PleaseClickCard()
	self._battleGround:getGroundLayer():setVisible(true)
end

function GuideTLInterpreter:act_1v1Scene()
	local camera = self._context:getValue("Camera")

	camera:focusOn(display.cx, display.cy, 1.2, 0.3)
	delayCallByTime(300, function()
		camera:focusOn(display.cx, display.cy, 1)
		camera:setBaseScale(1.2)
	end)
end

function GuideTLInterpreter:act_FlashScreen(action, args)
	local flashConfig = {}

	flashConfig[#flashConfig + 1] = {
		color = "#FF0000",
		duration = 6
	}

	self._battleGround:flashScreen(flashConfig, 24)
	self._battleGround:slowDown({
		{
			value = 0.1,
			duration = 0.2
		},
		{
			value = 0.2,
			duration = 0.2
		},
		{
			value = 0.5,
			duration = 0.2
		}
	})
end

function GuideTLInterpreter:act_RockScreen(action, args)
	self._battleGround:rock(4, 2)
end

function GuideTLInterpreter:act_ResumeTime(action, args)
	self._battleUIMediator:resumeTiming()
	self._battleUIMediator:resumeEnergyIncreasing()
end

function GuideTLInterpreter:act_PauseTime(action, args)
	self._battleUIMediator:pauseTiming()
	self._battleUIMediator:pauseEnergyIncreasing()
end

function GuideTLInterpreter:act_ResetTime(action, args)
	self._battleUIMediator:resetTiming(args.time)
end

function GuideTLInterpreter:act_TimeScale(action, args)
	self._mainMediator:setTimeScale(args.timeScale)
end

function GuideTLInterpreter:act_PlayMusic(action, args)
	AudioEngine:getInstance():playEffect(args.music)
end

function GuideTLInterpreter:act_TouchEnabled(action, val)
	self._battleUIMediator:setTouchEnabled(val)
	self._battleGround:setTouchEnabled(val)
end

function GuideTLInterpreter:act_HideMasterSkills(action)
	local masterWidget = self._battleUIMediator:getMasterWidget()

	if masterWidget then
		masterWidget:setVisible(false)
	end
end

function GuideTLInterpreter:_pauseBattle()
	local battleMenu = self._battleUIMediator:getCtrlButtons()

	self._opTouch = self._battleUIMediator:isTouchEnabled()
	self._groundTouch = self._battleGround:isTouchEnabled()
	self._menuTouch = battleMenu and battleMenu:isTouchEnabled()

	print("menuTouch pause", self._menuTouch)

	if battleMenu then
		battleMenu:setTouchEnabled(false)
	end

	self._mainMediator:pause()
end

function GuideTLInterpreter:_resumeBattle()
	local battleMenu = self._battleUIMediator:getCtrlButtons()

	print("menuTouch resume", self._menuTouch)

	if battleMenu then
		battleMenu:setTouchEnabled(self._menuTouch)
	end

	self._mainMediator:resume()
end

function GuideTLInterpreter:act_LeaveBattle(action, args)
	self._mainMediator:tryLeaving()
end

function GuideTLInterpreter:act_HideStartBattleAni(action, args)
	local aniNode = self._screenEffectLayer._view:getChildByName("xkz_xinkaizhan")

	if aniNode then
		aniNode:setVisible(false)
	end

	local blackMaskLayer = self._screenEffectLayer.blackMaskLayer

	if blackMaskLayer then
		blackMaskLayer:setVisible(false)
	end
end

function GuideTLInterpreter:act_HideHeroCard(action, args)
	if not args.cardIndex then
		local cardIndex = 1
		local cardView = self._battleUIMediator._cardArray:getView()
		local cardNode = cardView:getChildByFullName("C" .. cardIndex)

		if cardNode then
			cardNode:setVisible(false)
		end
	end
end

function GuideTLInterpreter:act_HeroGoBattle(action, args)
	if not args.cell then
		if not args.cardIndex then
			local cardIndex = 1
			local cardArray = self._battleUIMediator:getCardArray()

			if cardArray then
				local cardView = self._battleUIMediator._cardArray:getView()
				local cardNode = cardView:getChildByFullName("C" .. cardIndex)

				if cardNode then
					cardNode:setVisible(true)
				end

				local card = cardArray:getCardAtIndex(cardIndex)

				cardArray:setActiveCard(card)

				if args.pause then
					self:_resumeBattle()
				end

				self._battleGround:onClickedCell(args.cell)

				if args.statisticPoint then
					local content = {
						type = "loginpoint",
						point = args.statisticPoint
					}

					StatisticSystem:send(content)
				end
			end
		end
	end
end

function GuideTLInterpreter:createCardCellNum(numInfo)
	local node = cc.Node:create()

	for k, v in pairs(numInfo) do
		local pos = v.pos

		if not v.num then
			local num = pos
			local style = v.style
			local targetNode
			local offsetX = 35

			if style == 1 then
				local groundCells = self._battleGround:getRightGroundCells()

				targetNode = groundCells[pos]:getDisplayNode()
				offsetX = 0 - offsetX
			else
				local groundCells = self._battleGround:getLeftGroundCells()

				targetNode = groundCells[pos]:getDisplayNode()
			end

			local targetPt = targetNode:convertToWorldSpace(cc.p(0, 0))
			local label = cc.Label:createWithTTF(num, TTF_FONT_FZYH_M, 40)

			label:setPosition(targetPt)
			label:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
			label:addTo(node):offset(offsetX, -8)
			label:setColor(cc.c3b(255, 255, 255))
		end
	end

	return node
end

function GuideTLInterpreter:act_ShowRedCells(action, args)
	local cellsIndex = args.cellsIndex

	if cellsIndex then
		local rightGroundCells = self._battleGround._rightGroundCells

		for i, v in ipairs(cellsIndex) do
			rightGroundCells[v]:setPreview({
				color = "Red",
				isRandom = false
			})
		end
	end

	self:act_ShowGuideText(action, args)
end

function GuideTLInterpreter:act_HideRedCells(action, args)
	local rightGroundCells = self._battleGround._rightGroundCells

	for i, v in ipairs(rightGroundCells) do
		rightGroundCells[i]:resumePreview()
	end
end

function GuideTLInterpreter:act_ShowUnitSpeak(action, args)
	local pos = args.pos
	local dataModel = self._unitManager._rightTeam[pos]

	if dataModel then
		local role = self._unitManager:getUnitById(dataModel:getRoleId())

		if role then
			role:speakBubble(args)
		end
	end
end
