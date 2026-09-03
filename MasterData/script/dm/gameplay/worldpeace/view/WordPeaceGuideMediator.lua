-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/worldpeace/view/WordPeaceGuideMediator.lua

WordPeaceGuideMediator = class("WordPeaceGuideMediator", DmPopupViewMediator, _M)

local kBtnHandlers = {}

function WordPeaceGuideMediator:initialize()
	super.initialize(self)
end

function WordPeaceGuideMediator:dispose()
	super.dispose(self)
end

function WordPeaceGuideMediator:onRegister()
	super.onRegister(self)

	self._bgWidget = bindWidget(self, "bg", PopupNormalWidget, {
		ignoreWhiteBg = true,
		ignoreBtnBg = true,
		btnHandler = {
			clickAudio = "Se_Click_Close_2",
			func = bind1(self.onClickClose, self)
		},
		title = Strings:get("DrawCard_UP_DescTitle"),
		bgSize = {
			width = 1000,
			height = 580
		}
	})

	self:mapButtonHandlersClick(kBtnHandlers)
end

function WordPeaceGuideMediator:enterWithData(data)
	self._page = self:getView():getChildByName("PageView")
	self._clone = self:getView():getChildByName("clone")
	self._left = self:getView():getChildByName("left")
	self._right = self:getView():getChildByName("right")
	self._bg = self:getView():getChildByName("bg")

	self._bg:offset(-75)

	local showList = ConfigReader:getDataByNameIdAndKey("ConfigValue", "ClubMapBoss_ImageRules3", "content")

	if data and data.showType then
		if data.showType == "chatSwear" then
			showList = ConfigReader:getDataByNameIdAndKey("ConfigValue", "ClubMapBoss_ImageRules1", "content")
		end

		if data.showType == "battle" then
			showList = ConfigReader:getDataByNameIdAndKey("ConfigValue", "ClubMapBoss_ImageRules2", "content")
		end
	end

	local imgList = showList[1]
	local descList = showList[2]
	local count = #imgList

	for i = 1, count do
		local cell = self._clone:clone()

		cell:loadTexture(imgList[i] .. ".png", 1)
		self._page:addPage(cell)
	end

	self._left:addClickEventListener(function()
		self._page:scrollToPage(self._page:getCurrentPageIndex() <= 0 and 0 or self._page:getCurrentPageIndex() - 1)
	end)
	self._right:addClickEventListener(function()
		self._page:scrollToPage((self._page:getCurrentPageIndex() > count or nil) and (count - 1 or self._page:getCurrentPageIndex() + 1))
	end)
	self._page:scrollToPage(0)
	self:getView():getChildByName("desc"):setString(Strings:get(descList[1]))
	self._page:addEventListener(function(sender, type)
		if type == 0 then
			self:getView():getChildByName("desc"):setString(Strings:get(descList[self._page:getCurrentPageIndex() + 1]))
			self._left:setVisible(self._page:getCurrentPageIndex() > 0)
			self._right:setVisible(self._page:getCurrentPageIndex() < count - 1)
		end
	end)
	self:getView():getChildByName("desc"):setString(Strings:get("ClubMapBoss_Tutorial1"))
end

function WordPeaceGuideMediator:onClickClose()
	self:close()
end

function WordPeaceGuideMediator:onTouchMaskLayer()
	return
end
