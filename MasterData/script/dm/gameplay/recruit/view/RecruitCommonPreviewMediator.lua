-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/recruit/view/RecruitCommonPreviewMediator.lua

RecruitCommonPreviewMediator = class("RecruitCommonPreviewMediator", DmPopupViewMediator, _M)

local kBtnHandlers = {}

function RecruitCommonPreviewMediator:initialize()
	super.initialize(self)
end

function RecruitCommonPreviewMediator:dispose()
	super.dispose(self)
end

function RecruitCommonPreviewMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self:bindWidget("main.bgNode", PopupNormalWidget, {
		btnHandler = {
			clickAudio = "Se_Click_Close_2",
			func = bind1(self.onClickBack, self)
		},
		title = Strings:get("DrawCard_Common_DescTitle"),
		title1 = Strings:get("DrawCard_Common_DescTitle_En"),
		bgSize = {
			width = 840,
			height = 500
		},
		fontSize = getCurrentLanguage() ~= GameLanguageType.CN and 37 or nil
	})
	self:getView():getChildByFullName("main.tipTxt"):setString(Strings:get("Recruit_Common_Preview_Tip"))

	self._listView = self:getView():getChildByFullName("main.listview")

	self._listView:setScrollBarEnabled(false)
	self._listView:setSwallowTouches(false)

	self._contentPanel = self:getView():getChildByFullName("clonePanel")

	self._contentPanel:setVisible(false)

	local titlePanel = self:getView():getChildByFullName("main.titlePanel")

	for i = 1, 4 do
		titlePanel:getChildByFullName("t" .. i):setString(Strings:get("Recruit_Common_Preview_UI" .. i))
	end
end

function RecruitCommonPreviewMediator:enterWithData(data)
	self:initData(data)
	self:initView()
end

function RecruitCommonPreviewMediator:resumeWithData()
	return
end

function RecruitCommonPreviewMediator:refreshView()
	self:initData()
	self:initView()
end

function RecruitCommonPreviewMediator:initData(data)
	self._remainTimes = 99

	if data and data.rewards then
		self._rewards = data.rewards
	end

	if data and data.remainTimes then
		self._remainTimes = data.remainTimes
	end
end

function RecruitCommonPreviewMediator:initView()
	self:initContent()
end

function RecruitCommonPreviewMediator:initContent()
	self._listView:removeAllChildren(true)

	for i = 1, #self._rewards do
		local data = {}

		for k, v in pairs(self._rewards[i]) do
			data.pr = k
			data.data = v[1]
		end

		local panel = self._contentPanel:clone()

		panel:setVisible(true)
		self._listView:pushBackCustomItem(panel)
		self:updataCell(panel, data, i)
	end
end

function RecruitCommonPreviewMediator:updataCell(panel, _data, index)
	local data = _data.data

	if not _data.pr then
		local probability = 0
		local info = RewardSystem:parseInfo(data)
		local style = {
			showAmount = false
		}
		local showMark = index == 1 and info.rewardType == RewardType.kHero

		panel:getChildByFullName("markImg"):setVisible(showMark)
		panel:getChildByFullName("mark"):setVisible(showMark)

		if showMark then
			panel:getChildByFullName("mark"):getVirtualRenderer():setLineSpacing(-4)
			panel:getChildByFullName("content1"):setString(Strings:get("Recruit_Common_Preview_Hero_Tip", {
				num = self._remainTimes
			}))
		else
			panel:getChildByFullName("content1"):setString(probability * 100 .. "%")
		end

		panel:getChildByFullName("title"):setString(RewardSystem:getName(data))
		panel:getChildByFullName("content"):setString(info.rewardType == RewardType.kHero and 1 or info.amount)

		local iconPanel = panel:getChildByFullName("image_icon")
		local headIcon = IconFactory:createIcon(info, style)

		headIcon:addTo(iconPanel):center(iconPanel:getContentSize())
		headIcon:setScale(0.5)
		IconFactory:bindTouchHander(iconPanel, IconTouchHandler:new(self), data, {
			needDelay = true
		})
	end
end

function RecruitCommonPreviewMediator:onClickBack()
	self:close()
end

function RecruitCommonPreviewMediator:onClickRule()
	local Arena_RuleTranslate = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Rank_RuleTranslate", "content")
	local view = self:getInjector():getInstance("ArenaRuleView")
	local event = ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		rule = Arena_RuleTranslate
	}, nil)

	self:dispatch(event)
end
