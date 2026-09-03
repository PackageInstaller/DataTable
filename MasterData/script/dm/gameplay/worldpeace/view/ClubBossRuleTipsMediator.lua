-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/worldpeace/view/ClubBossRuleTipsMediator.lua

ClubBossRuleTipsMediator = class("ClubBossRuleTipsMediator", DmPopupViewMediator, _M)

ClubBossRuleTipsMediator:has("_recruitSystem", {
	is = "r"
}):injectWith("RecruitSystem")

local kBtnHandlers = {}

function ClubBossRuleTipsMediator:initialize()
	super.initialize(self)
end

function ClubBossRuleTipsMediator:dispose()
	super.dispose(self)
end

function ClubBossRuleTipsMediator:onRegister()
	super.onRegister(self)

	self._bgWidget = bindWidget(self, "main.bg", PopupNormalWidget, {
		btnHandler = {
			clickAudio = "Se_Click_Close_2",
			func = bind1(self.onClickClose, self)
		},
		title = Strings:get("DrawCard_UP_DescTitle")
	})

	self:mapButtonHandlersClick(kBtnHandlers)
end

function ClubBossRuleTipsMediator:enterWithData(data)
	self._main = self:getView():getChildByName("main")
	self._bgImg = self._main:getChildByName("bgimg")
	self._desc = self._main:getChildByName("desc")
	self._leftBtn = self._main:getChildByName("leftbtn")
	self._index = 1

	local showList = ConfigReader:getDataByNameIdAndKey("ConfigValue", "ClubBoss_Rules", "content")

	self._leftBtn:addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.ended then
			AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

			self._index = self._index - 1

			if self._index < 1 then
				self._index = #showList
			end

			self:refreshView()
		end
	end)

	self._rightBtn = self._main:getChildByName("rightbtn")

	self._rightBtn:addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.ended then
			AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

			self._index = self._index + 1

			if self._index > #showList then
				self._index = 1
			end

			self:refreshView()
		end
	end)
	self:refreshView()
end

function ClubBossRuleTipsMediator:refreshView()
	local showList = ConfigReader:getDataByNameIdAndKey("ConfigValue", "ClubBoss_Rules", "content")
	local data = showList[self._index]

	self._desc:setString(Strings:get(data.Desc))

	local imgPath = "asset/scene/" .. data.Img

	self._bgImg:loadTexture(imgPath)
end

function ClubBossRuleTipsMediator:onClickClose()
	self:close()
end
