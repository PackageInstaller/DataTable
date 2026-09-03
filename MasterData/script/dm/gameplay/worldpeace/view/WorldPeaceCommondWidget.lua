-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/worldpeace/view/WorldPeaceCommondWidget.lua

WorldPeaceCommondWidget = class("WorldPeaceCommondWidget", BaseWidget, _M)

WorldPeaceCommondWidget:has("_worldPeaceSystem", {
	is = "r"
}):injectWith("WorldPeaceSystem")
WorldPeaceCommondWidget:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
WorldPeaceCommondWidget:has("_clubSystem", {
	is = "r"
}):injectWith("ClubSystem")

local TagInfosBack = {
	"CB_ico_jingong3.png",
	"CB_ico_jihuo3.png",
	"CB_ico_fangyu3.png",
	"CB_ico_zhiyuan3.png"
}
local TagInfos = {
	"CB_ico_jingong.png",
	"CB_ico_jihuo.png",
	"CB_ico_fangyu.png",
	"CB_ico_zhiyuan.png"
}

function WorldPeaceCommondWidget:runSupportAnim()
	self._btnAnimRun = true

	local clubBoss_ClickLimit = ConfigReader:getDataByNameIdAndKey("ConfigValue", "ClubCommandCd", "content")

	for k, v in pairs(self._commondSlots) do
		v._clickAnim:setPlaySpeed(2 / clubBoss_ClickLimit)
		v._clickAnim:setVisible(true)
		v._clickAnim:gotoAndPlay(1)
		v._clickAnim:addEndCallback(function(cid, mc)
			self._btnAnimRun = false

			v._clickAnim:setVisible(false)
			v._clickAnim:stop()
		end)
	end
end

function WorldPeaceCommondWidget:initialize(view, parent)
	super.initialize(self, view)

	self._view = view
	self._parent = parent
	self._wordPeaceGame = parent._wordPeaceGame
	self._isInBattle = self._wordPeaceGame:getDisplayMode() == K_RENDER_DISPLAYMODE.ALL

	local clubSystem = DmGame:getInstance()._injector:getInstance("ClubSystem")

	self._isManager = clubSystem:canVerify()
	self._commondSlots = {}

	for i = 1, 4 do
		self._commondSlots[i] = view:getChildByName("commond" .. i)
		self._commondSlots[i].orgPos = cc.p(self._commondSlots[i]:getPosition())
		self._commondSlots[i].tag = i

		if not self._commondSlots[i]._clickAnim then
			self._commondSlots[i]._clickAnim = cc.MovieClip:create("anniu_djs_qiuqiuanniu")

			self._commondSlots[i]._clickAnim:addTo(self._commondSlots[i], 999):center(self._commondSlots[i]:getContentSize()):offset(3, 6)
			self._commondSlots[i]._clickAnim:setScale(0.3)
		end

		self._commondSlots[i]._clickAnim:setVisible(false)
	end

	local listener = cc.EventListenerTouchOneByOne:create()

	listener:setSwallowTouches(true)
	listener:registerScriptHandler(function(touch, event)
		return self:onTouchBegan(touch, event)
	end, cc.Handler.EVENT_TOUCH_BEGAN)
	listener:registerScriptHandler(function(touch, event)
		return self:onTouchMoved(touch, event)
	end, cc.Handler.EVENT_TOUCH_MOVED)
	listener:registerScriptHandler(function(touch, event)
		return self:onTouchEnded(touch, event)
	end, cc.Handler.EVENT_TOUCH_ENDED)
	listener:registerScriptHandler(function(touch, event)
		return self:onTouchCancel(touch, event)
	end, cc.Handler.EVENT_TOUCH_CANCELLED)
	view:getEventDispatcher():addEventListenerWithSceneGraphPriority(listener, view)
end

function WorldPeaceCommondWidget:updateInfo(battlefeild)
	local groupTags = battlefeild:getGroup()

	for i = 1, 4 do
		self._commondSlots[tonumber(i)]:loadTexture(TagInfos[tonumber(i)], 1)
		self._commondSlots[tonumber(i)]:ignoreContentAdaptWithSize(true)

		self._commondSlots[tonumber(i)].isbattle = false
	end

	for k, v in pairs(groupTags.bossTag or {}) do
		self._commondSlots[tonumber(k)]:loadTexture(TagInfosBack[tonumber(k)], 1)
		self._commondSlots[tonumber(k)]:ignoreContentAdaptWithSize(true)

		self._commondSlots[tonumber(k)].isbattle = true
	end

	self._statues = self._worldPeaceSystem:getStatus()
end

function WorldPeaceCommondWidget:setDelegate(listener)
	self._listener = listener
end

function WorldPeaceCommondWidget:unregisterTouchEvents()
	if self._touchListener then
		self:getView():getEventDispatcher():removeEventListener(self._touchListener)

		self._touchListener = nil
	end
end

function WorldPeaceCommondWidget:onTouchCancel(touch, event)
	self._parent:getScrollView():setTouchEnabled(true)

	return false
end

function WorldPeaceCommondWidget:hitTest(sender, globalPoint)
	local localPoint = sender:convertToNodeSpace(globalPoint)
	local size = sender:getContentSize()
	local cardRect = cc.rect(0, 0, size.width, size.height)

	return cc.rectContainsPoint(cardRect, localPoint)
end

function WorldPeaceCommondWidget:onTouchBegan(touch, event)
	local pt = touch:getLocation()
	local hittedSlot

	for i, slot in pairs(self._commondSlots) do
		if self:hitTest(slot, pt) then
			hittedSlot = slot

			break
		end
	end

	if not hittedSlot then
		return false
	end

	AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)

	self._hittedSlot = hittedSlot
	self._touchBeginPosition = pt
	self._moving = false

	return true
end

function WorldPeaceCommondWidget:onTouchMoved(touch, event)
	if self._btnAnimRun then
		return
	end

	self._parent:getScrollView():setTouchEnabled(false)

	local hittedSlot = self._hittedSlot

	if hittedSlot == nil then
		return
	end

	local pt = touch:getLocation()
	local moved = cc.pSub(pt, self._touchBeginPosition)

	if cc.pGetLength(moved) > 10 and self._statues ~= WPStatus.kBattle then
		self._parent:dispatch(ShowTipEvent({
			tip = Strings:get("Error_80604")
		}))
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

		self._hittedSlot = nil

		return
	end

	if cc.pGetLength(moved) > 10 and hittedSlot.isbattle then
		self._parent:dispatch(ShowTipEvent({
			tip = Strings:get("ClubClickTips")
		}))

		self._hittedSlot = nil

		return
	end

	if cc.pGetLength(moved) > 10 and not self._isManager then
		self._parent:dispatch(ShowTipEvent({
			tip = Strings:get("ClubAuthority")
		}))

		self._hittedSlot = nil

		return
	end

	if self._moving then
		local newPos = cc.pAdd(self._originPosition, moved)

		self._hittedSlot:setPosition(newPos)

		if self._listener then
			self._listener:dragMoved(self, self._hittedSlot, pt)
		end
	elseif cc.pGetLength(moved) > 10 then
		self._moving = true
		self._originPosition = cc.p(self._hittedSlot:getPosition())
	end
end

function WorldPeaceCommondWidget:resetPosition(sender)
	sender:runAction(cc.MoveTo:create(0.1, sender.orgPos))
end

function WorldPeaceCommondWidget:onTouchEnded(touch, event)
	self._parent:getScrollView():setTouchEnabled(true)

	if self._hittedSlot == nil then
		return
	end

	if self._btnAnimRun then
		return
	end

	local pt = touch:getLocation()

	if self._moving then
		local hittedSlot = self._hittedSlot

		if self._listener then
			self._listener:dragEnded(self, hittedSlot, pt, function()
				self:runSupportAnim()
			end)
		end
	else
		local hittedSlot

		for i, slot in pairs(self._commondSlots) do
			if self:hitTest(slot, pt) then
				hittedSlot = slot

				break
			end
		end

		if hittedSlot and self._hittedSlot == hittedSlot then
			if hittedSlot.isbattle then
				self:runSupportAnim()
				self._listener:backTag(self, hittedSlot, pt)
			elseif self._isInBattle then
				self._listener:dragEnded(self, hittedSlot, pt, function()
					self:runSupportAnim()
				end, true)
			else
				self._parent:dispatch(ShowTipEvent({
					tip = Strings:get("ClubDragTips")
				}))
			end
		end
	end

	self._hittedSlot = nil

	return true
end

function WorldPeaceCommondWidget:dispose()
	super.dispose(self)

	if self._scheduler then
		cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self._scheduler)

		self._scheduler = nil
	end
end

function WorldPeaceCommondWidget:update()
	return
end
