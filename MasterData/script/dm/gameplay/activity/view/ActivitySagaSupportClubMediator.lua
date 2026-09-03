-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/view/ActivitySagaSupportClubMediator.lua

ActivitySagaSupportClubMediator = class("ActivitySagaSupportClubMediator", DmPopupViewMediator, _M)

ActivitySagaSupportClubMediator:has("_rankSystem", {
	is = "rw"
}):injectWith("RankSystem")
ActivitySagaSupportClubMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")

local kBtnHandlers = {}

function ActivitySagaSupportClubMediator:initialize()
	super.initialize(self)
end

function ActivitySagaSupportClubMediator:dispose()
	super.dispose(self)
end

function ActivitySagaSupportClubMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self:bindWidget("main.bgNode", PopupNormalWidget, {
		btnHandler = {
			clickAudio = "Se_Click_Close_2",
			func = bind1(self.onClickBack, self)
		},
		title = Strings:get("Activity_Saga_UI_21"),
		title1 = Strings:get("Activity_Saga_UI_22"),
		bgSize = {
			width = 840,
			height = 570
		}
	})
	self:getView():getChildByFullName("main.tipTxt"):setString(Strings:get("Activity_Saga_UI_23"))

	self._listView = self:getView():getChildByFullName("main.listview")

	self._listView:setScrollBarEnabled(false)
	self._listView:setSwallowTouches(false)

	self._contentPanel = self:getView():getChildByFullName("clonePanel")

	self._contentPanel:setVisible(false)

	local titlePanel = self:getView():getChildByFullName("main.titlePanel")

	for i = 1, 4 do
		titlePanel:getChildByFullName("t" .. i):setString(Strings:get("Activity_Saga_UI_24_" .. i))
	end
end

function ActivitySagaSupportClubMediator:enterWithData(data)
	self._data = data.data
	self._activityId = data.activityId or ActivityId.kActivityBlockZuoHe
	self._activity = self._activitySystem:getActivityById(self._activityId)

	self:initData()
	self:initView()
end

function ActivitySagaSupportClubMediator:resumeWithData()
	return
end

function ActivitySagaSupportClubMediator:refreshView()
	self:initData()
	self:initView()
end

function ActivitySagaSupportClubMediator:initData()
	return
end

function ActivitySagaSupportClubMediator:initView()
	self:initContent()

	local tipStr = Strings:get("Activity_Saga_UI_23_1")
	local tipStr

	if #self._data > 0 then
		tipStr = ""
	end

	self:getView():getChildByFullName("main.tipTxtNo"):setString(tipStr)

	local titlePanel = self:getView():getChildByFullName("main.titlePanel")

	if self._activityId == ActivityId.kActivityWxh or self._activity and self._activity:getUI() == ActivityType_UI.KActivityReZhan then
		titlePanel:getChildByFullName("t3"):setString(Strings:get("Activity_Saga_UI_24_3_wxh"))
		titlePanel:getChildByFullName("t4"):setString(Strings:get("Activity_Saga_UI_24_4_wxh"))
	end
end

function ActivitySagaSupportClubMediator:initContent()
	self._listView:removeAllChildren(true)

	for i = 1, #self._data do
		local panel = self._contentPanel:clone()

		panel:setVisible(true)
		self._listView:pushBackCustomItem(panel)
		self:updataCell(panel, self._data[i], i)
	end
end

function ActivitySagaSupportClubMediator:updataCell(panel, _data, index)
	local data = _data
	local iconPanel = panel:getChildByFullName("image_icon")
	local headIcon, oldIcon = IconFactory:createPlayerIcon({
		clipType = 4,
		id = data.headImg,
		headFrameId = data.headFrame
	})

	headIcon:addTo(iconPanel):center(iconPanel:getContentSize())
	oldIcon:setScale(0.4)
	headIcon:setScale(0.85)
	panel:getChildByFullName("rank"):setString(tostring(index))

	if RankTopImage[index] then
		panel:getChildByFullName("Image_14"):loadTexture(RankTopImage[index], 1)
	end

	panel:getChildByFullName("Image_14"):setVisible(RankTopImage[index] and true or false)
	panel:getChildByFullName("rank"):setString(tostring(index))
	panel:getChildByFullName("title"):setString(data.name)
	panel:getChildByFullName("content"):setString(data.buff * 100 .. "%")
	panel:getChildByFullName("content1"):setString(data.score)
end

function ActivitySagaSupportClubMediator:onClickBack()
	self:close()
end

function ActivitySagaSupportClubMediator:onClickRule()
	local Arena_RuleTranslate = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Rank_RuleTranslate", "content")
	local view = self:getInjector():getInstance("ArenaRuleView")
	local event = ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		rule = Arena_RuleTranslate
	}, nil)

	self:dispatch(event)
end
