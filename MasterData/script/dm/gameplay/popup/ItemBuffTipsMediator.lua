-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/popup/ItemBuffTipsMediator.lua

ItemBuffTipsMediator = class("ItemBuffTipsMediator", DmPopupViewMediator, _M)

ItemBuffTipsMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

function ItemBuffTipsMediator:initialize()
	super.initialize(self)
end

function ItemBuffTipsMediator:dispose()
	self._viewClose = true

	super.dispose(self)
end

function ItemBuffTipsMediator:onRemove()
	super.onRemove(self)
end

function ItemBuffTipsMediator:onRegister()
	super.onRegister(self)

	self._main = self:getView():getChildByName("main")

	self.mapEventListener(self, self:getEventDispatcher(), EVT_SHOW_ITEMTIP, self, self.onShowContent)
end

function ItemBuffTipsMediator:enterWithData(data)
	return
end

function ItemBuffTipsMediator:onShowContent(event)
	local data = event:getData()

	self:setUi(data)
	self:adjustPos(data.icon, data.style and data.style.direction)
end

function ItemBuffTipsMediator:setUi(data)
	local buffInfo = data.info
	local icon = self._main:getChildByFullName("icon")

	icon:removeAllChildren()

	local info = {}

	info.id = buffInfo.id

	local buffIcon

	;(buffInfo.icon and buffInfo.icon ~= "" and ccui.ImageView:create(buffInfo.icon) or IconFactory:createBuffIcon(info, {
		scale = 0.55
	})):addTo(icon):center(icon:getContentSize())

	local effectConfig = ConfigReader:getRecordById("Skill", buffInfo.id)
	local nameLab = self._main:getChildByFullName("title")

	if buffInfo.title and buffInfo.title ~= "" then
		nameLab:setString(Strings:get(buffInfo.title))
	else
		nameLab:setString(Strings:get(effectConfig.Name))
	end

	local descLab = self._main:getChildByFullName("desc")
	local desc = Strings:get(effectConfig.Desc, {
		fontSize = 18,
		fontName = TTF_FONT_FZYH_M
	})
	local richText = ccui.RichText:createWithXML(desc, {})

	richText:setAnchorPoint(descLab:getAnchorPoint())
	richText:setPosition(cc.p(descLab:getPosition()))
	richText:addTo(descLab:getParent())
	richText:renderContent(descLab:getContentSize().width, 0, true)

	local effectLab = self._main:getChildByFullName("effect")

	effectLab:setVisible(false)

	if buffInfo.desc and buffInfo.desc ~= "" then
		effectLab:setVisible(true)
		effectLab:setString(buffInfo.desc)
	end

	local tipImg = self._main:getChildByFullName("tag")
	local tipText = self._main:getChildByFullName("tag.text")

	if buffInfo.buffType == "OneTimeBuff" then
		tipImg:setVisible(true)
		tipImg:loadTexture("bg_mjt_jilibiaoshi.png", ccui.TextureResType.plistType)
		tipText:setString(Strings:get("DreamChallenge_Buff_Type_JL"))
	elseif buffInfo.buffType == "TimeBuff" then
		tipImg:setVisible(true)
		tipImg:loadTexture("bg_mjt_xianshi.png", ccui.TextureResType.plistType)
		tipText:setString(Strings:get("DreamChallenge_Buff_Type_XS"))
	else
		tipImg:setVisible(false)
	end

	tipImg:setPositionX(99 + nameLab:getContentSize().width)
end

function ItemBuffTipsMediator:adjustPos(icon, direction)
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
