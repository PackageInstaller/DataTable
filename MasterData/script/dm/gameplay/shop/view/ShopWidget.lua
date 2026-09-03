-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/shop/view/ShopWidget.lua

ShopTalk = class("ShopTalk", BaseWidget, _M)

ShopTalk:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")

function ShopTalk.class:createWidgetNode()
	local resFile = "asset/ui/shopTalk.csb"

	return cc.CSLoader:createNode(resFile)
end

function ShopTalk:initialize(view)
	super.initialize(self, view)
	self:initSubviews(view)
end

function ShopTalk:dispose()
	super.dispose(self)
end

function ShopTalk:initSubviews(view)
	self._view = view
	self._touchPanelRole = self._mainPanel:getChildByName("Panel_bg_0")
	self._bgImage = self._touchPanel:getChildByName("Image_bg")
	self._talkBg = self._touchPanelRole:getChildByName("Image_20")
	self._talkText = self._touchPanelRole:getChildByName("Text_talk")

	self._touchPanel:addTouchEventListener(function(sender, eventType)
		self:onClickItem(sender, eventType)
	end)
	self._touchPanelRole:addTouchEventListener(function(sender, eventType)
		self:onClickRole(sender, eventType)
	end)
	self._talkText:setString(self._shopSystem:getShopTalkShow())
	self._talkBg:setVisible(self._showTalk)
	self._talkText:setVisible(self._showTalk)
end

function ShopTalk:setTime(data)
	if self._titleText and data.title then
		self._titleText:setString("【" .. data.title .. "】")
	end

	self:updateTime(data)

	if data.icon then
		local icon = self._view:getChildByName("Image_icon")

		if icon then
			icon:loadTexture(data.icon, ccui.TextureResType.plistType)
		end
	end
end

function ShopTalk:updateTime(data)
	if self._timeText and self._timer == nil then
		local function update()
			local remainTime = self._activitySystem:getActivityRemainTime(data.activityId)

			self._timeText:setString(TimeUtil:formatTime(Strings:get("ActivityCommon_UI01"), remainTime * 0.001))
		end

		self._timer = LuaScheduler:getInstance():schedule(update, 1, true)

		update()
	end
end

KShopAction = {
	clickEnd = "SDTZ_Shop_Stand2",
	begin = "SDTZ_Shop_Action1",
	click = "SDTZ_Shop_Action2",
	beginEnd = "SDTZ_Shop_Stand1"
}
KShopVoice = {
	click = "Voice_SDTZi_71_4",
	begin = "Voice_SDTZi_71_1",
	buyEnd = "Voice_SDTZi_71_2"
}
ShopSpine = class("ShopSpine", objectlua.Object, _M)

function ShopSpine:initialize()
	super.initialize(self)
	self:initMember()
end

function ShopSpine:initMember()
	self._canClick = false
end

function ShopSpine:addSpine(view)
	self:createRoleIconSprite(view)
end

function ShopSpine:createRoleIconSprite(view)
	local animPath = "asset/anim/portraitpic_SDTZ_Shop.skel"

	if cc.FileUtils:getInstance():isFileExist(animPath) then
		self._spineNode = sp.SkeletonAnimation:create(animPath)

		self._spineNode:addTo(view):posite(180, 0)
		self._spineNode:setScale(0.4)
		self._spineNode:registerSpineEventHandler(handler(self, self.spineAnimEvent), sp.EventType.ANIMATION_COMPLETE)
		self._spineNode:registerSpineEventHandler(handler(self, self.spineAnimEvent), sp.EventType.ANIMATION_START)
		self._spineNode:registerSpineEventHandler(handler(self, self.spineAnimEvent), sp.EventType.ANIMATION_END)
	end
end

function ShopSpine:spineAnimEvent(event)
	if event.animation == KShopAction.begin then
		if event.type == "start" then
			self._canClick = false
		elseif event.type == "complete" then
			self._canClick = true

			self._spineNode:playAnimation(0, KShopAction.beginEnd, true)
		end
	elseif event.animation == KShopAction.click then
		if event.type == "start" then
			self._canClick = false
		elseif event.type == "complete" then
			self._canClick = true

			self._spineNode:playAnimation(0, KShopAction.clickEnd, true)
		end
	elseif event.animation == KShopAction.beginEnd then
		self._canClick = true
	elseif event.animation == KShopAction.clickEnd then
		self._canClick = true
	end
end

function ShopSpine:playAnimation(action, actionRepeat, voice, callback)
	if action and self._spineNode then
		self._spineNode:playAnimation(0, action, actionRepeat or false)
	end

	if voice then
		self:stopEffect()
		dump(voice, "播放了 ：")

		self._heroEffect, _ = AudioEngine:getInstance():playEffect(voice, false, function()
			if callback then
				callback(voice)
			end
		end)
	end
end

function ShopSpine:stopEffect(action, voice)
	if self._heroEffect then
		AudioEngine:getInstance():stopEffect(self._heroEffect)

		self._heroEffect = nil
	end
end

function ShopSpine:getActionStatus()
	return self._canClick
end
