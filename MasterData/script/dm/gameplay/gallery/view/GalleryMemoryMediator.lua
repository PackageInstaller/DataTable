-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/gallery/view/GalleryMemoryMediator.lua

GalleryMemoryMediator = class("GalleryMemoryMediator", DmAreaViewMediator, _M)

GalleryMemoryMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
GalleryMemoryMediator:has("_gallerySystem", {
	is = "r"
}):injectWith("GallerySystem")

local kBtnHandlers = {}
local MemoryNode = {
	GalleryMemoryType.STORY,
	GalleryMemoryType.HERO,
	GalleryMemoryType.ACTIVI
}
local MemoryNodePos = {
	cc.p(730, 517),
	cc.p(400, 312),
	cc.p(832, 213)
}
local MemoryNodeRotate = {
	27.5,
	-21,
	15.5
}
local MemoryTitle = {
	[GalleryMemoryType.STORY] = Strings:get("GALLERY_UI15"),
	[GalleryMemoryType.HERO] = Strings:get("GALLERY_UI16"),
	[GalleryMemoryType.ACTIVI] = Strings:get("GALLERY_UI17")
}
local MemoryText = {
	[GalleryMemoryType.HERO] = Strings:get("Gallery_Memory_text_2"),
	[GalleryMemoryType.ACTIVI] = Strings:get("Gallery_Memory_text_3")
}
local MemoryView = {
	[GalleryMemoryType.STORY] = "GalleryMemoryPackView",
	[GalleryMemoryType.HERO] = "GalleryMemoryListView",
	[GalleryMemoryType.ACTIVI] = "GalleryMemoryListView"
}

function GalleryMemoryMediator:initialize()
	super.initialize(self)
end

function GalleryMemoryMediator:dispose()
	super.dispose(self)
end

function GalleryMemoryMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._heroSystem = self._developSystem:getHeroSystem()
end

function GalleryMemoryMediator:enterWithData(data)
	self:setupTopInfoWidget()
	self:setupView(data)
	self:runStartAnim()
end

function GalleryMemoryMediator:setupTopInfoWidget()
	local topInfoNode = self:getView():getChildByFullName("topinfo_node")
	local config = {
		style = 1,
		currencyInfo = {},
		title = Strings:get("GALLERY_UI2"),
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onClickBack, self)
		}
	}
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)
end

function GalleryMemoryMediator:onClickBack(sender, eventType)
	self:dismiss()
end

function GalleryMemoryMediator:setupView()
	self:initWidgetInfo()
	self:initView()
end

function GalleryMemoryMediator:resumeWithData()
	self._bg:stopAllActions()
	self._bg:setOpacity(255)
	self._bg:setPosition(cc.p(813, 320))
	self:refreshRedPoint()

	for i = 1, #MemoryNode do
		local panel = self._panelArr[i]

		panel:stopAllActions()
		panel:setPosition(MemoryNodePos[i])
		panel:setRotation(MemoryNodeRotate[i])
	end
end

function GalleryMemoryMediator:initWidgetInfo()
	self._main = self:getView():getChildByFullName("main")
	self._bg = self:getView():getChildByFullName("bg")
end

function GalleryMemoryMediator:initView()
	self._panelArr = {}

	for i = 1, #MemoryNode do
		local data = self._gallerySystem:getMemoryValueByType(MemoryNode[i])
		local panel = self._main:getChildByName("panel_" .. i)

		assert(panel ~= nil, "没有这个名称为:" .. "panel_" .. i .. "的节点")
		panel:setTouchEnabled(true)
		panel:addTouchEventListener(function(sender, eventType)
			self:onClickMemory(sender, eventType, MemoryNode[i])
		end)
		panel:getChildByName("name"):setString(MemoryTitle[MemoryNode[i]])

		if i ~= 1 then
			panel:getChildByName("text"):setString(MemoryText[MemoryNode[i]])
		end

		local currentNum = panel:getChildByName("currentNum")
		local limitNum = panel:getChildByName("limitNum")

		if not data then
			currentNum:setString("")
			limitNum:setString("")
		else
			currentNum:setString(data[1])

			if i ~= 3 then
				limitNum:setString("/" .. data[2])
			else
				limitNum:setString("")
			end

			currentNum:setPositionX(limitNum:getPositionX() - limitNum:getContentSize().width)
		end

		self._panelArr[#self._panelArr + 1] = panel
	end
end

function GalleryMemoryMediator:updateCurNum()
	local data = self._gallerySystem:getMemoryValueByType(MemoryNode[2])
	local panel = self._main:getChildByName("panel_2")
	local currentNum = panel:getChildByName("currentNum")

	if data then
		currentNum:setString(data[1])
	end
end

function GalleryMemoryMediator:refreshOneRedPoint(index)
	local panel = self._main:getChildByName("panel_" .. index)
	local redPoint = panel:getChildByName("redPoint" .. index)

	if not redPoint then
		redPoint = RedPoint:createDefaultNode()

		redPoint:addTo(panel):posite(325, 203)
		redPoint:setLocalZOrder(99901)
		redPoint:setName("redPoint" .. index)
		redPoint:setScale(1.2)
	end

	redPoint:setVisible(self._gallerySystem:checkNewMemory(MemoryNode[index]))
end

function GalleryMemoryMediator:refreshRedPoint()
	for i = 1, #MemoryNode do
		self:refreshOneRedPoint(i)
	end
end

function GalleryMemoryMediator:onClickMemory(sender, eventType, type)
	if eventType == ccui.TouchEventType.began then
		local data = self._gallerySystem:getMemoryValueByType(type)

		if data then
			local scale1 = cc.ScaleTo:create(0.1, 0.9)

			sender:runAction(scale1)
		end
	elseif eventType == ccui.TouchEventType.ended then
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

		local data = self._gallerySystem:getMemoryValueByType(type)

		if not data then
			self:dispatch(ShowTipEvent({
				duration = 0.2,
				tip = Strings:get("Source_General_Unknown")
			}))

			return
		end

		if type == GalleryMemoryType.ACTIVI then
			local customDataSystem = self:getInjector():getInstance(CustomDataSystem)

			customDataSystem:setValue(PrefixType.kGlobal, "GalleryCGRed", "0")
		end

		local scale3 = cc.ScaleTo:create(0.1, 1)
		local callfunc = cc.CallFunc:create(function()
			self:showMenoryAnim(type)
		end)
		local seq = cc.Sequence:create(scale3, callfunc)

		sender:runAction(seq)
	elseif eventType == ccui.TouchEventType.canceled then
		sender:stopAllActions()
		sender:setScale(1)
	end
end

function GalleryMemoryMediator:runStartAnim()
	self._main:stopAllActions()
	self._bg:stopAllActions()
	self:updateCurNum()
	self:refreshRedPoint()

	local speed = 0.8

	self._bg:setPosition(cc.p(1890, 315))

	local moveto1 = cc.MoveTo:create(0.3 * speed, cc.p(813, 320))

	self._bg:runAction(moveto1)
	self._main:setPosition(cc.p(1150, 1242))

	local delay = cc.DelayTime:create(0.3 * speed)
	local moveto = cc.MoveTo:create(0.3 * speed, cc.p(568, 320))
	local seq = cc.Sequence:create(delay, moveto)

	self._main:runAction(seq)

	local panel = self._panelArr[1]

	panel:stopAllActions()
	panel:setPosition(cc.p(816, 580))

	delay = cc.DelayTime:create(0.6 * speed)
	moveto = cc.MoveTo:create(0.2 * speed, MemoryNodePos[1])
	seq = cc.Sequence:create(delay, moveto)

	panel:runAction(seq)

	panel = self._panelArr[3]

	self._panelArr[3]:stopAllActions()
	panel:setPosition(cc.p(817, 126))

	delay = cc.DelayTime:create(0.5 * speed)
	moveto = cc.MoveTo:create(0.2 * speed, MemoryNodePos[3])
	seq = cc.Sequence:create(delay, moveto)

	panel:runAction(seq)
end

function GalleryMemoryMediator:showMenoryAnim(type)
	local speed = 0.3

	self._bg:stopAllActions()
	self._bg:fadeOut({
		time = 0.5 * speed
	})

	local panel = self._panelArr[3]

	panel:stopAllActions()

	local rotate = cc.RotateTo:create(0.6 * speed, 360000)
	local moveto1 = cc.MoveTo:create(0.5 * speed, cc.p(-276, 744))
	local spawn = cc.Spawn:create(rotate, moveto1)
	local callfunc = cc.CallFunc:create(function()
		local view = self:getInjector():getInstance(MemoryView[type])

		self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, {
			type = type
		}, nil))
	end)
	local seq = cc.Sequence:create(spawn, callfunc)

	panel:runAction(seq)

	for i = 1, #MemoryNode - 1 do
		panel = self._panelArr[i]
		moveto1 = cc.MoveTo:create(0.5 * speed, cc.p(self._panelArr[i]:getContentSize().width + 800, self._panelArr[i]:getContentSize().height + 733))

		self._panelArr[i]:runAction(moveto1)
	end
end
