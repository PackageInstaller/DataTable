-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/popup/ItemShowTipsMediator.lua

ItemShowTipsMediator = class("ItemShowTipsMediator", DmPopupViewMediator, _M)

ItemShowTipsMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

function ItemShowTipsMediator:initialize()
	super.initialize(self)
end

function ItemShowTipsMediator:dispose()
	self._viewClose = true

	super.dispose(self)
end

function ItemShowTipsMediator:onRemove()
	super.onRemove(self)
end

function ItemShowTipsMediator:onRegister()
	super.onRegister(self)

	self._main = self:getView():getChildByName("main")

	self.mapEventListener(self, self:getEventDispatcher(), EVT_SHOW_ITEMTIP, self, self.onShowContent)
end

function ItemShowTipsMediator:enterWithData(data)
	return
end

function ItemShowTipsMediator:onShowContent(event)
	local data = event:getData()

	self:setUi(data)
	self:adjustPos(data.icon, data.style and data.style.direction)
end

function ItemShowTipsMediator:setUi(data)
	local info = data.info
	local icon = self._main:getChildByFullName("icon")

	icon:removeAllChildren()

	local buffIcon = IconFactory:createSprite(info.icon)

	buffIcon:addTo(icon):center(icon:getContentSize())

	local nameLab = self._main:getChildByFullName("title")

	nameLab:setString(info.title)

	local descLab = self._main:getChildByFullName("desc")
	local richText = ccui.RichText:createWithXML(info.desc, {})

	richText:setAnchorPoint(descLab:getAnchorPoint())
	richText:setPosition(cc.p(descLab:getPosition()))
	richText:addTo(descLab:getParent())
	richText:renderContent(descLab:getContentSize().width, 0, true)

	local tipsLab = self._main:getChildByFullName("tips")

	tipsLab:setVisible(false)

	if info.tips and info.tips ~= "" then
		tipsLab:setVisible(true)
		tipsLab:setString(info.tips)
	end
end

function ItemShowTipsMediator:adjustPos(icon, direction)
	local view = self:getView()

	view:setAnchorPoint(cc.p(0.5, 0.5))
	view:setIgnoreAnchorPointForPosition(false)

	local kUpMargin, kDownMargin, kLeftMargin, kRightMargin = 0, 0, 0, 0
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

	view:setPosition(cc.p(x - nodePos.x, y - nodePos.y))
end
