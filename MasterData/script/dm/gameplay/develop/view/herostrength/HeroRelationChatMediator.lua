-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/view/herostrength/HeroRelationChatMediator.lua

HeroRelationChatMediator = class("HeroRelationChatMediator", DmPopupViewMediator, _M)

HeroRelationChatMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

local kBtnHandlers = {
	backBtn = {
		clickAudio = "Se_Click_Close_1",
		func = "onClickBack"
	}
}
local kRelationWidgetPos = {
	cc.p(360, 172),
	cc.p(711, 172),
	cc.p(360, 56),
	cc.p(711, 56),
	cc.p(360, 292),
	cc.p(595, 292),
	cc.p(829, 292),
	cc.p(360, 436)
}

function HeroRelationChatMediator:initialize()
	super.initialize(self)
end

function HeroRelationChatMediator:dispose()
	self._viewClose = true

	super.dispose(self)
end

function HeroRelationChatMediator:onRemove()
	super.onRemove(self)
end

function HeroRelationChatMediator:onRegister()
	super.onRegister(self)
end

function HeroRelationChatMediator:adjustLayout(targetFrame)
	super.adjustLayout(self, targetFrame)
end

function HeroRelationChatMediator:enterWithData(data)
	self:mapButtonHandlersClick(kBtnHandlers)
	self:initNodes()
	self:refreshView(data)
end

function HeroRelationChatMediator:initNodes()
	self._mainPanel = self:getView():getChildByFullName("main")
	self._relationNode = self._mainPanel:getChildByFullName("relationnode")
	self._playerLabel = self._mainPanel:getChildByFullName("playerlabel")
end

function HeroRelationChatMediator:refreshView(data)
	self:refreshData(data)
	self:refreshRelationPanel()
	self:refreshHeroInfoWidget()
	self._playerLabel:setString(self._data.nickName)
end

function HeroRelationChatMediator:refreshData(data)
	self._data = data.viewData
end

function HeroRelationChatMediator:refreshRelationPanel()
	self._relationCahce = {}

	local relationArr = self._data.relations
	local injector = self:getInjector()

	self._relationLevel = 0

	local unlockNum = 0

	for i = 1, #relationArr do
		local relationData = relationArr[i]

		self._relationLevel = self._relationLevel + relationData.level

		local config = ConfigReader:getRecordById("HeroRelation", tostring(relationData.id))

		if config.Type ~= RelationType.kEquip then
			local widget = self:autoManageObject(injector:injectInto(RelationInfoWidget:new(RelationInfoWidget:createWidgetNode(), {
				hideButton = true,
				index = i,
				config = config,
				clickFunc = function(index)
					local view = self:getInjector():getInstance("RelationInfoTipView")

					self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
						transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
					}, {
						index = index,
						heroId = self._heroId
					}))
				end
			})))

			widget:getView():addTo(self._relationNode, 999)
			widget:getView():setPosition(kRelationWidgetPos[i])

			self._relationCahce[i] = widget
			relationData.config = config

			if relationData.lock == RelationLockState.kCanDevelop then
				relationData.lock = RelationLockState.kLock
			end

			if i ~= #relationArr then
				if relationData.lock ~= RelationLockState.kLock then
					unlockNum = unlockNum + 1
				end
			else
				relationData.unlockNum = unlockNum
			end

			self:updateRelationByIndex(i, relationData.level, relationData.lock, relationData)
		end
	end
end

function HeroRelationChatMediator:updateRelationByIndex(index, level, lockState, relationData)
	local config = relationData.config

	if config.Type == RelationType.kEquip then
		return
	end

	local widget = self._relationCahce[index]

	widget:updateView(level, lockState, relationData)
end

function HeroRelationChatMediator:refreshHeroInfoWidget()
	if not self._heroNode then
		local injector = self:getInjector()

		self._heroNode = self._mainPanel:getChildByFullName("heronode")
		self._heroInfoWidget = self:autoManageObject(injector:injectInto(RelationHeroWidget:new(self._heroNode)))
	end

	local data = self._data.hero
	local config = ConfigReader:getRecordById("HeroBase", tostring(data.id))
	local var_13_0 = {
		qualityLevel = 0,
		combat = 0,
		id = data.id
	}

	var_13_0.quality = data.quality or 10
	var_13_0.star = data.star
	var_13_0.rariety = config.Rareity
	var_13_0.cost = config.Cost
	var_13_0.name = Strings:get(config.Name)

	self._heroInfoWidget:updateRoleInfo(var_13_0, {
		hideCombat = true
	})
end

function HeroRelationChatMediator:onClickBack(sender, eventType)
	self:close()
end
