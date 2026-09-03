-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/popup/ShowSomeWordTipsMediator.lua

ShowSomeWordTipsMediator = class("ShowSomeWordTipsMediator", DmPopupViewMediator, _M)

ShowSomeWordTipsMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

local kDefaultDelayTime = 0.1
local kMoveSensitiveDist = cc.p(5, 5)

function ShowSomeWordTipsMediator:initialize()
	super.initialize(self)
end

function ShowSomeWordTipsMediator:dispose()
	self._viewClose = true

	super.dispose(self)
end

function ShowSomeWordTipsMediator:onRemove()
	super.onRemove(self)
end

function ShowSomeWordTipsMediator:onRegister()
	super.onRegister(self)

	self._main = self:getView():getChildByName("main")

	self.mapEventListener(self, self:getEventDispatcher(), EVT_SHOW_SOME_WORDTIP, self, self.onShowContent)
end

function ShowSomeWordTipsMediator:userInject()
	return
end

function ShowSomeWordTipsMediator:enterWithData(data)
	assert(data.info ~= nil, "error:data.info=nil")
	assert(data.info.id ~= nil, "error:data.info.id=nil")
	self:setUi(data)

	local view = self:getView()
end

function ShowSomeWordTipsMediator:onShowContent(event)
	local data = event:getData()

	assert(data.info ~= nil, "error:data.info=nil")
	assert(data.info.id ~= nil, "error:data.info.id=nil")
	assert(data.icon ~= nil, "error:data.icon=nil")
	self:setUi(data)
	self:adjustPos(data.icon, data.style and data.style.direction, data.info.rightOff_x, data.info.downOff_y)
end

function ShowSomeWordTipsMediator:setUi(data)
	local Text_1 = self._main:getChildByName("Text_1")

	Text_1:setString(Strings:get(data.info.text1))

	if data.info.text2 then
		local Text_2 = self._main:getChildByName("Text_2")

		Text_2:setString(Strings:get(data.info.text2))
	else
		Text_1:setPositionY(5)
		Text_1:setTextVerticalAlignment(cc.TEXT_ALIGNMENT_CENTER)

		local Text_2 = self._main:getChildByName("Text_2")

		Text_2:setVisible(false)
	end
end

function ShowSomeWordTipsMediator:adjustPos(icon, direction, rightOff_x, downOff_y)
	if rightOff_x == nil then
		rightOff_x = 0
	end

	if downOff_y == nil then
		downOff_y = 0
	end

	local view = self:getView()

	view:setAnchorPoint(cc.p(0.5, 0.5))
	view:setIgnoreAnchorPointForPosition(false)

	local kUpMargin, kDownMargin, kLeftMargin, kRightMargin = 1, 1, 5, 5
	local viewSize = view:getContentSize()
	local iconBoundingBox = icon:getBoundingBox()
	local worldPos = icon:getParent():convertToWorldSpace(cc.p(iconBoundingBox.x, iconBoundingBox.y))
	local scene = cc.Director:getInstance():getRunningScene()
	local winSize = scene:getContentSize()

	direction = direction or worldPos.y + iconBoundingBox.height + viewSize.height + kUpMargin <= winSize.height - 30 and ItemTipsDirection.kUp or worldPos.x + iconBoundingBox.width * 0.5 < winSize.width * 0.5 and ItemTipsDirection.kRight or ItemTipsDirection.kLeft

	local iconBox = {
		x = worldPos.x,
		y = worldPos.y,
		width = icon:getContentSize().width * icon:getScale(),
		height = icon:getContentSize().height * icon:getScale()
	}
	local x, y

	if direction == ItemTipsDirection.kUp then
		x = iconBox.x + iconBox.width * 0.5
		y = iconBox.y + iconBox.height + viewSize.height * 0.5 + kUpMargin
	elseif direction == ItemTipsDirection.kDown then
		x = iconBox.x + iconBox.width * 0.5
		y = iconBox.y - viewSize.height * 0.5 - kDownMargin
	elseif direction == ItemTipsDirection.kLeft then
		x = iconBox.x - viewSize.width * 0.5 - kLeftMargin
		y = iconBox.y + iconBox.height - viewSize.height * 0.5
	elseif direction == ItemTipsDirection.kRight then
		x = iconBox.x + iconBox.width + viewSize.width * 0.5 + kRightMargin
		y = iconBox.y + iconBox.height - viewSize.height * 0.5
	end

	local nodePos = view:getParent():convertToWorldSpace(cc.p(0, 0))
	local kLeftMinMargin, kRightMinMargin, kUpMinMargin, kDownMinMargin = 0, 0, 0, 0

	if kLeftMinMargin >= x - viewSize.width * 0.5 then
		x = kLeftMinMargin + viewSize.width * 0.5
	elseif x + viewSize.width * 0.5 >= winSize.width - kRightMinMargin then
		x = winSize.width - kRightMinMargin - viewSize.width * 0.5
	end

	if kDownMinMargin > y - viewSize.height * 0.5 then
		y = kDownMinMargin + viewSize.height * 0.5
	elseif y + viewSize.height * 0.5 > winSize.height - kUpMinMargin then
		y = winSize.height - kUpMinMargin - viewSize.height * 0.5
	end

	view:setPosition(cc.p(x - nodePos.x + rightOff_x, y - nodePos.y - downOff_y))
end

function ShowSomeWordTipsMediator:checkNeedDelay(data)
	if data.style and data.style.needDelay then
		self:getView():setVisible(false)

		local icon = data.icon
		local initPos = icon:getParent():convertToWorldSpace(cc.p(icon:getPosition()))
		local delayAct = cc.DelayTime:create(data.delayTime or kDefaultDelayTime)
		local judgeShowAct = cc.CallFunc:create(function()
			local endPos = icon:getParent():convertToWorldSpace(cc.p(icon:getPosition()))

			if math.abs(endPos.x - initPos.x) < kMoveSensitiveDist.x and math.abs(endPos.y - initPos.y) < kMoveSensitiveDist.y then
				self:getView():setVisible(true)
			end
		end)
		local seqAct = cc.Sequence:create(delayAct, judgeShowAct)

		self:getView():runAction(seqAct)
	end
end
