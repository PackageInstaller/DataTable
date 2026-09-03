-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/view/ActivityFateEncountersMediator.lua

ActivityFateEncountersMediator = class("ActivityFateEncountersMediator", BaseActivityMediator, _M)

ActivityFateEncountersMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")

local kBtnHandlers = {
	["main.interfaceView.chooseBtn"] = {
		func = "onChooseBtnClicked"
	},
	["main.interfaceView.roleInfoBtn"] = {
		func = "onRoleInfoBtnClicked"
	},
	["main.interfaceView.infoBtn"] = {
		func = "onInfoBtnClicked"
	}
}

function ActivityFateEncountersMediator:initialize()
	super.initialize(self)
end

function ActivityFateEncountersMediator:dispose()
	super.dispose(self)
end

function ActivityFateEncountersMediator:onRemove()
	super.onRemove(self)
end

function ActivityFateEncountersMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
end

function ActivityFateEncountersMediator:enterWithData(data)
	self._activity = data.activity
	self._parentMediator = data.parentMediator
	self._activityConfig = self._activity:getConfig()
	self._modleIds = self._activity:getModelIdList()
	self._curModleId = self._modleIds[1]
	self._modelCellList = {}

	self:initWidget()
end

function ActivityFateEncountersMediator:initWidget()
	self._main = self:getView():getChildByFullName("main")
	self._interface = self._main:getChildByFullName("interfaceView")
	self._activityMainView = self._main:getChildByFullName("activityView")

	if self._activity:isChooseTask() then
		self._roleList = self._main:getChildByFullName("interfaceView.taskList")
		self._heroQuality = self._main:getChildByFullName("interfaceView.heroQuality")
		self._heroName = self._main:getChildByFullName("interfaceView.roleInfoBtn.name")
		self._roldNode = self._main:getChildByFullName("interfaceView.rolePanel.roleNode")
		self._modelCellClone = self._main:getChildByFullName("modleItemClone")
		self._roleKuang = self._main:getChildByFullName("kuang")

		self:setupViewOnChoose()
		self:resetKuangMaskState()
		self:chooseRoleCell()
		self:refreshViewOnChoose()
	else
		self:setupViewOnTask()
	end

	if getCurrentLanguage() ~= GameLanguageType.CN then
		local infoBtn = self._main:getChildByFullName("interfaceView.infoBtn")

		if infoBtn then
			infoBtn:setPositionX(950)
		end
	end
end

function ActivityFateEncountersMediator:setupViewOnChoose()
	self._interface:setVisible(true)
	self._activityMainView:setVisible(false)
	self._roleList:removeAllItems()
	self._roleList:setScrollBarEnabled(false)

	for i = 1, #self._modleIds do
		local cell = self._modelCellClone:clone()

		self:initRoleCell(cell, self._modleIds[i])
		cell:getChildByFullName("rolePanel"):addTouchEventListener(function(sender, eventType)
			if eventType == ccui.TouchEventType.ended then
				AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

				self._curModleId = sender:getParent():getName()

				self:resetKuangMaskState()
				self:chooseRoleCell(sender)
				self:refreshViewOnChoose()
			end
		end)
		self._roleList:pushBackCustomItem(cell)
	end

	self:refreshViewOnChoose()
end

function ActivityFateEncountersMediator:refreshViewOnChoose()
	local heroId = ConfigReader:getDataByNameIdAndKey("RoleModel", self._curModleId, "Model")
	local nameStr = ConfigReader:getDataByNameIdAndKey("HeroBase", heroId, "Name")
	local rareity = ConfigReader:getDataByNameIdAndKey("HeroBase", heroId, "Rareity")

	self._heroQuality:loadTexture(GameStyle:getHeroRarityImage(rareity), 1)
	self._heroName:setString(Strings:get(nameStr))
	self._roldNode:removeAllChildren()

	local heroSprite = IconFactory:createRoleIconSpriteNew({
		frameId = "bustframe9",
		iconType = 6,
		id = self._curModleId
	})

	heroSprite:setScale(0.8)
	heroSprite:addTo(self._roldNode)
end

function ActivityFateEncountersMediator:initRoleCell(node, modelId)
	local heroPanel = node:getChildByName("rolePanel")

	heroPanel:removeAllChildren()

	local heroIcon = IconFactory:createRoleIconSpriteNew({
		frameId = "bustframe4_8",
		id = modelId
	})

	heroIcon:setScale(0.6)
	heroIcon:addTo(heroPanel)
	heroIcon:setPosition(cc.p(heroPanel:getContentSize().width / 2 - 2, heroPanel:getContentSize().height / 2 - 10))
	node:setName(tostring(modelId))
end

function ActivityFateEncountersMediator:resetKuangMaskState()
	local modelCellList = self._roleList:getItems()

	for i = 1, #modelCellList do
		modelCellList[i]:getChildByFullName("mask"):setVisible(true)
	end
end

function ActivityFateEncountersMediator:chooseRoleCell(sender)
	if sender then
		local var_12_0 = sender:getParent()

		if not var_12_0 then
			var_12_0 = self._roleList:getItem(0)

			local baseView = var_12_0

			baseView:getChildByFullName("mask"):setVisible(false)

			local size = baseView:getContentSize()

			self._roleKuang:setVisible(true)
			self._roleKuang:setPosition(size.width / 2, size.height / 2)
			self._roleKuang:setLocalZOrder(999)
			self._roleKuang:changeParent(baseView)
		end
	end
end

function ActivityFateEncountersMediator:onChooseBtnClicked()
	local outSelf, delegate = self, {}

	function delegate:willClose(popupMediator, data)
		if data.response == "ok" then
			local activityId = outSelf._activity:getId()
			local param = {
				doActivityType = 102,
				selectIndex = outSelf._activity:getSelectIndex(outSelf._curModleId)
			}

			outSelf._activitySystem:requestDoActivity(activityId, param, function(response)
				if response.data then
					outSelf:setupViewOnTask()
				end
			end)
		elseif data.response == "cancel" then
			-- block empty
		elseif data.response == "close" then
			-- block empty
		end
	end

	local heroId = ConfigReader:getDataByNameIdAndKey("RoleModel", self._curModleId, "Model")
	local nameStr = ConfigReader:getDataByNameIdAndKey("HeroBase", heroId, "Name")
	local data = {
		title = Strings:get("Act_MYXH_Text3"),
		title1 = Strings:get("UITitle_EN_Huobanxuanze"),
		content = Strings:get("Act_MYXH_Text4", {
			heroname = Strings:get(nameStr)
		}),
		sureBtn = {},
		cancelBtn = {}
	}
	local view = self:getInjector():getInstance("AlertView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, data, delegate))
end

function ActivityFateEncountersMediator:onRoleInfoBtnClicked()
	local modleId = self._curModleId
	local heroId = ConfigReader:getDataByNameIdAndKey("RoleModel", modleId, "Model")
	local view = self:getInjector():getInstance("HeroInfoView")

	self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, {
		heroId = heroId
	}))
end

function ActivityFateEncountersMediator:onInfoBtnClicked()
	local Hero_EquipEnergyTranslate = ConfigReader:getDataByNameIdAndKey("ConfigValue", "ACT_MYXH_RuleTranslate", "content")
	local view = self:getInjector():getInstance("ArenaRuleView")
	local event = ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		rule = Hero_EquipEnergyTranslate
	}, nil)

	self:dispatch(event)
end

function ActivityFateEncountersMediator:setupViewOnTask()
	self._interface:setVisible(false)
	self._activityMainView:setVisible(true)
	self:refreshViewOnTask()
end

function ActivityFateEncountersMediator:refreshViewOnTask()
	if not self._activityMainView:getChildByName("eightView") then
		local UIConfig = ConfigReader:getDataByNameIdAndKey("Activity", self._activity:getSelectId(), "UI")
		local viewName = ActivityUI[UIConfig]
		local view = self:getInjector():getInstance(viewName)

		view:addTo(self._activityMainView):center(self._activityMainView:getContentSize())
		view:setName("eightView")

		local mediator = self:getMediatorMap():retrieveMediator(view)

		if mediator then
			mediator:enterWithData({
				activity = self._activity,
				parentMediator = self._parentMediator
			})
		end
	end
end
