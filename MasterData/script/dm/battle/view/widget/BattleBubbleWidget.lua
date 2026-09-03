-- chunkname: @/tmp/or_script/lua_compile/dm/battle/view/widget/BattleBubbleWidget.lua

BattleBubbleWidget = class("BattleBubbleWidget", BaseWidget)

function BattleBubbleWidget:initialize(view, args, callback)
	super.initialize(self, view)

	self._callback = callback
	self._data = args

	view:setScale(0.1)
end

function BattleBubbleWidget:dispose()
	self._callback = nil

	if self._textTask then
		self._textTask:stop()

		self._textTask = nil
	end

	super.dispose(self)
end

function BattleBubbleWidget:removeView()
	if self._view then
		self._view:removeFromParent(true)

		self._view = nil
	end
end

function BattleBubbleWidget:setViewContext(context)
	self._viewContext = context

	self:setupView()
end

function BattleBubbleWidget:setupView()
	local view = self:getView()
	local bg = view:getChildByName("bg")
	local text = bg:getChildByName("text")
	local data = self._data
	local style = data.style

	if style and style == "boom" then
		bg:loadTexture("zhandou_bg_qipao_2.png", 1)
		bg:setCapInsets(cc.rect(23, 12, 27, 15))

		self._textAreaSize = cc.size(153, 0)
	else
		self._textAreaSize = cc.size(153, 0)
	end

	self:setTextContent(1)
	view:runAction(cc.ScaleTo:create(0.2, 1))
end

function BattleBubbleWidget:setTextContent(index)
	local data = self._data
	local stmts = data.stmts
	local stmt = stmts[index]
	local content, duration = stmt[1], stmt[2] / 1000
	local scheduler = self._viewContext:getScalableScheduler()

	if self._textTask then
		self._textTask:stop()

		self._textTask = nil
	end

	self._textTask = scheduler:schedule(function(task, dt)
		duration = duration - dt

		if duration <= 0 then
			task:stop()

			self._textTask = nil
			index = index + 1

			if index <= #stmts then
				self:setTextContent(index)
			elseif self._callback then
				self:_callback()
			end
		end
	end)

	local view = self:getView()
	local bg = view:getChildByName("bg")
	local text = bg:getChildByName("text")

	text:setString(Strings:get(content))

	local tsize = text:getContentSize()

	if tsize.width > self._textAreaSize.width then
		text:setTextAreaSize(self._textAreaSize)

		tsize = text:getContentSize()
	end

	if data.style and data.style == "boom" then
		text:offset(7, 0)
		bg:setContentSize(cc.size(tsize.width + 32, tsize.height + 50))
		bg:offset(76 - tsize.width / 2 + 25, -16)
	else
		bg:setContentSize(cc.size(tsize.width + 32, tsize.height + 35))
		bg:offset(76 - tsize.width / 2 + 25, -16)
	end
end

BattleEmoteWidget = class("BattleEmoteWidget", BaseWidget)

function BattleEmoteWidget:initialize(view, args, callback)
	super.initialize(self, view)

	self._callback = callback
	self._data = args
end

function BattleEmoteWidget:dispose()
	self._callback = nil

	if self._emoteTask then
		self._emoteTask:stop()

		self._emoteTask = nil
	end

	super.dispose(self)
end

function BattleEmoteWidget:removeView()
	if self._view then
		self._view:removeFromParent(true)

		self._view = nil
	end
end

function BattleEmoteWidget:setViewContext(context)
	self._viewContext = context

	self:setupView()
end

function BattleEmoteWidget:setupView()
	local data = self._data
	local resId = data.id

	if data.dur then
		if not (data.dur / 1000) then
			local duration
			local emote = cc.MovieClip:create(resId)

			emote:addTo(self:getView())

			if duration then
				local scheduler = self._viewContext:getScalableScheduler()

				self._emoteTask = scheduler:schedule(function(task, dt)
					duration = duration - dt

					if duration <= 0 then
						emote:stop()
						emote:removeFromParent(true)

						if self._callback then
							self:_callback()
						end

						task:stop()

						self._emoteTask = nil
					end
				end)

				emote:addEndCallback(function(cid, mc)
					mc:stop()
				end)
			else
				emote:addEndCallback(function(cid, mc)
					mc:stop()
					mc:removeFromParent(true)

					if self._callback then
						self:_callback()
					end
				end)
			end
		end
	end
end

BattleRTPKEmojiPanelWidget = class("BattleRTPKEmojiPanelWidget", BaseWidget)

function BattleRTPKEmojiPanelWidget:initialize(view, args, callback)
	super.initialize(self, view)

	self._developSystem = DmGame:getInstance()._injector:getInstance("DevelopSystem")
	self._player = self._developSystem:getPlayer()

	local data = self._player:getUsedEmoji()

	self._data = {}

	for k, v in pairs(data) do
		self._data[k + 1] = v
	end

	self._coolTimeTotal = 0
	self._totalSelectCnt = 0
	self._defalutCoolTime = ConfigReader:getRecordById("ConfigValue", "EMJ_LongCD_Num").content
	self._defalutLangCnt = ConfigReader:getRecordById("ConfigValue", "EMJ_LongCD_Num").content - 1
	self._defalutLangTime = ConfigReader:getRecordById("ConfigValue", "EMJ_LongCD_T").content
	self._defalutLangCoolTime = ConfigReader:getRecordById("ConfigValue", "EMJ_Short_CD").content

	self:setupView()
end

function BattleRTPKEmojiPanelWidget:setListener(listener)
	self._listener = listener
end

function BattleRTPKEmojiPanelWidget:dispose()
	super.dispose(self)
end

function BattleRTPKEmojiPanelWidget:onEmojiSelect(emojiId)
	print(self._totalSelectCnt, self._defalutLangCnt, self._coolTimeTotal, self._defalutLangTime, self._defalutLangCoolTime)

	if self._totalSelectCnt >= self._defalutLangCnt and self._coolTimeTotal < self._defalutLangTime and self._coolTimeTotal > self._defalutCoolTime then
		self._coolTime = self._defalutLangCoolTime
		self._coolTimeTotal = 0 - self._defalutLangCoolTime
		self._totalSelectCnt = 0
	else
		self._coolTime = self._defalutCoolTime
	end

	self._btn_emoji:getChildByName("icon"):setGray(true)
	self._btn_emoji:getChildByName("icon"):setOpacity(100)
	self._cool:setString(self._coolTime)
	self._cool:setVisible(true)
	self._btn_emoji:setTouchEnabled(false)

	local countDown = cc.Sequence:create(cc.DelayTime:create(1), cc.CallFunc:create(function()
		self._coolTime = self._coolTime - 1

		self._cool:setVisible(true)
		self._cool:setString(self._coolTime)

		if self._coolTime <= 0 then
			self._totalSelectCnt = self._totalSelectCnt + 1

			self._btn_emoji:setTouchEnabled(true)
			self:getView():stopAllActions()

			self._coolTime = self._defalutCoolTime

			self._cool:setVisible(false)
			self._btn_emoji:getChildByName("icon"):setGray(false)
			self._btn_emoji:getChildByName("icon"):setOpacity(255)
		end
	end))
	local coolDown = cc.RepeatForever:create(countDown)

	self:getView():runAction(coolDown)
	self._btn_emoji:getChildByName("cool"):stopAllActions()
	self._btn_emoji:getChildByName("cool"):runAction(cc.RepeatForever:create(cc.Sequence:create(cc.DelayTime:create(1), cc.CallFunc:create(function()
		self._coolTimeTotal = self._coolTimeTotal + 1
	end))))

	if self._listener then
		self._listener:onEmojiSelect(emojiId)
	end
end

function BattleRTPKEmojiPanelWidget:setupView()
	local tips = self:getView():getChildByName("tips")
	local btn_emoji = self:getView():getChildByName("btn_emoji")
	local cool = btn_emoji:getChildByName("cool")

	cool:setVisible(false)

	self._tips = tips
	self._btn_emoji = btn_emoji
	self._cool = cool

	local function openFunc()
		tips.isOpen = true

		tips:stopAllActions()

		easeBackOutAni = cc.EaseBackOut:create(cc.ScaleTo:create(0.2, 1))

		easeBackOutAni:update(0.8)

		local acton = cc.Sequence:create(easeBackOutAni, cc.CallFunc:create(function()
			btn_emoji:setTouchEnabled(true)
		end))

		btn_emoji:setTouchEnabled(false)
		tips:runAction(acton)
	end

	local function closeFunc(isselect)
		tips.isOpen = false

		tips:stopAllActions()

		local acton = cc.Sequence:create(cc.ScaleTo:create(0.05, 0), cc.CallFunc:create(function()
			if not isselect then
				btn_emoji:setTouchEnabled(true)
			end
		end))

		btn_emoji:setTouchEnabled(false)
		tips:runAction(acton)
	end

	local line01x, line01y = 40, 50
	local panelSize = {
		width = {
			83,
			166,
			249
		},
		height = {
			87,
			174
		}
	}
	local data = self._data
	local flip = #data > 3

	for k, v in pairs(self._data) do
		local faceIcon = ConfigReader:getRecordById("MasterFace", v).EMJPic
		local emoji = ccui.ImageView:create("asset/emotion/" .. faceIcon)

		emoji:setScale(0.3)
		emoji:addTo(tips)

		if flip then
			k = k <= 3 and k + 3 or k - 3
		end

		emoji:setTouchEnabled(true)
		emoji:setPosition(line01x + (k - 1) % 3 * 78, line01y + math.floor((k - 1) / 3) * 80)
		emoji:addTouchEventListener(function(sender, eventType)
			if eventType == ccui.TouchEventType.ended then
				self:onEmojiSelect(v)
				closeFunc(true)
			end
		end)
	end

	local width_base = #self._data > 3 and 3 or #self._data
	local height_base = math.floor((#self._data - 1) / 3) + 1 > 2 and 2 or math.floor((#self._data - 1) / 3) + 1

	tips:setContentSize(cc.size(panelSize.width[width_base], panelSize.height[height_base]))
	tips:setScale(0)
	btn_emoji:addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.ended then
			AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

			if tips.isOpen then
				closeFunc()
			else
				openFunc()
			end
		end
	end)
end

BattleRTPKEmoteWidget = class("BattleRTPKEmoteWidget", BaseWidget)

function BattleRTPKEmoteWidget:initialize(view, args, callback)
	super.initialize(self, view)

	self._callback = callback
	self._data = args
end

function BattleRTPKEmoteWidget:dispose()
	self._callback = nil

	if self._emoteTask then
		self._emoteTask:stop()

		self._emoteTask = nil
	end

	super.dispose(self)
end

function BattleRTPKEmoteWidget:removeView()
	if self._view then
		if not tolua.isnull(self._view) then
			self._view:removeFromParent(true)
		end

		self._view = nil
	end
end

function BattleRTPKEmoteWidget:setViewContext(context)
	self._viewContext = context

	self:setupView()
end

function BattleRTPKEmoteWidget:setupView()
	local data = self._data
	local faceIcon = ConfigReader:getRecordById("MasterFace", data.emojiId).EMJPic
	local icon = self:getView():getChildByName("bg"):getChildByName("icon")

	icon:loadTexture("asset/emotion/" .. faceIcon, ccui.TextureResType.localType)
	icon:setScale(1.3)

	local scheduler = self._viewContext:getScalableScheduler()
	local duration = 3

	self._emoteTask = scheduler:schedule(function(task, dt)
		duration = duration - dt

		if duration <= 0 then
			self:removeView()

			if self._callback then
				self:_callback()
			end

			task:stop()

			self._emoteTask = nil
		end
	end)
end
