-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/pass/view/PassDelayExpMediator.lua

PassDelayExpMediator = class("PassDelayExpMediator", DmPopupViewMediator, _M)

PassDelayExpMediator:has("_passSystem", {
	is = "r"
}):injectWith("PassSystem")
PassDelayExpMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")

local kBtnHandlers = {}

function PassDelayExpMediator:initialize()
	super.initialize(self)
end

function PassDelayExpMediator:dispose()
	super.dispose(self)
end

function PassDelayExpMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self:mapEventListeners()

	local view = self:getView()
end

function PassDelayExpMediator:mapEventListeners()
	return
end

function PassDelayExpMediator:setupView()
	return
end

function PassDelayExpMediator:enterWithData(data)
	self:initData(data)
	self:initView()
end

function PassDelayExpMediator:initData(data)
	self._data = data
end

function PassDelayExpMediator:initView(data)
	bindWidget(self, self:getView():getChildByName("bgNode"), PopupNormalWidget, {
		btnHandler = {
			clickAudio = "Se_Click_Close_2",
			func = bind1(self.onClickClose, self)
		},
		title = Strings:get("Pass_UI50"),
		title1 = Strings:get("Pass_UI51")
	})

	self._ensureBtn = self:bindWidget("sureBtn", OneLevelMainButton, {
		handler = {
			clickAudio = "Se_Click_Common_1",
			func = bind1(self.onClickEnsure, self)
		}
	})
	self._buyBtn = self:getView():getChildByName("buyBtn")
	self._closeBtn = self:getView():getChildByName("closeBtn")
	self._tipLabel = self:getView():getChildByName("tipLabel")
	self._buyPanel = self:getView():getChildByName("buyPanel")

	self._buyBtn:setVisible(false)
	self._tipLabel:setVisible(false)
	self._closeBtn:setVisible(false)
	self._buyPanel:setVisible(true)
	self._buyPanel:getChildByName("tipLabel"):setString(Strings:get("Pass_UI52"))
	GameStyle:setCommonOutlineEffect(self._buyPanel:getChildByName("tipLabel"))
	self._buyPanel:getChildByName("tipLabel"):setPositionY(130)

	local rewardIcon = IconFactory:createIcon({
		id = "IGM_BP_Exp",
		amount = self._data.dailyExp
	}, {
		isWidget = false
	})

	rewardIcon:setAnchorPoint(cc.p(0.5, 0.5))
	rewardIcon:addTo(self._buyPanel):posite(30, 55)
	rewardIcon:setScale(0.7)
end

function PassDelayExpMediator:onClickEnsure()
	local activityId = self._passSystem:getCurrentActivityID()
	local data = {
		doActivityType = 104,
		placeholder = "Pass"
	}

	self._activitySystem:requestDoActivity(activityId, data, function(response)
		if response.resCode == GS_SUCCESS then
			self:afterClearDelayExp(response)
		end
	end)
end

function PassDelayExpMediator:onClickClose()
	self:onClickEnsure()
end

function PassDelayExpMediator:afterClearDelayExp(response)
	local currentLevel = self._passSystem:getCurrentLevel()

	if self._data.dailyLevel > 0 then
		self._passSystem:showLevelUpView({
			type = 2,
			level1 = currentLevel - self._data.dailyLevel,
			level2 = currentLevel
		})
	end

	self:close()
end
