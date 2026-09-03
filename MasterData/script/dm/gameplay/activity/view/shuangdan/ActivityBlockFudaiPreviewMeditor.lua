-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/view/shuangdan/ActivityBlockFudaiPreviewMeditor.lua

ActivityBlockFudaiPreviewMeditor = class("ActivityBlockFudaiPreviewMeditor", DmPopupViewMediator, _M)

local kBtnHandlers = {}

function ActivityBlockFudaiPreviewMeditor:initialize()
	super.initialize(self)
end

function ActivityBlockFudaiPreviewMeditor:dispose()
	super.dispose(self)
end

function ActivityBlockFudaiPreviewMeditor:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self:bindWidget("main.bgNode", PopupNormalWidget, {
		btnHandler = {
			clickAudio = "Se_Click_Close_2",
			func = bind1(self.onClickBack, self)
		},
		title = Strings:get("NewYear_LuckyBag_UI07"),
		title1 = Strings:get("DrawCard_Common_DescTitle_En"),
		bgSize = {
			width = 840,
			height = 500
		}
	})
	self:getView():getChildByFullName("main.tipTxt"):setString("")

	self._listView = self:getView():getChildByFullName("main.listview")

	self._listView:setScrollBarEnabled(false)
	self._listView:setSwallowTouches(false)

	self._rulelistView = self:getView():getChildByFullName("main.rule_list")

	self._rulelistView:setScrollBarEnabled(false)
	self._rulelistView:setSwallowTouches(false)

	self._contentPanel = self:getView():getChildByFullName("clonePanel")

	self._contentPanel:setVisible(false)

	local titlePanel = self:getView():getChildByFullName("main.titlePanel")

	for i = 1, 4 do
		titlePanel:getChildByFullName("t" .. i):setString(Strings:get("Recruit_Common_Preview_UI" .. i))
	end
end

function ActivityBlockFudaiPreviewMeditor:enterWithData(data)
	self:initData(data)
	self:initView()
end

function ActivityBlockFudaiPreviewMeditor:resumeWithData()
	return
end

function ActivityBlockFudaiPreviewMeditor:refreshView()
	self:initData()
	self:initView()
end

function ActivityBlockFudaiPreviewMeditor:initData(data)
	if data and data.rewards then
		self._rewards = data.rewards
	end

	if data and data.rate then
		self._rates = data.rate
	end
end

function ActivityBlockFudaiPreviewMeditor:initView()
	self:initContent()
end

function ActivityBlockFudaiPreviewMeditor:initContent()
	local titledes = ConfigReader:getRecordById("ConfigValue", "Newyear_LuckyBag_ShowRewardUI").content

	self._rulelistView:removeAllChildren(true)

	local contextPanel = self:getView():getChildByName("context_panal")

	contextPanel:setVisible(false)

	for i = 1, #titledes do
		local panel = contextPanel:clone()

		panel:setVisible(true)

		local context = panel:getChildByName("context")

		context:setFontSize(16)
		context:setTextAreaSize(cc.size(panel:getContentSize().width, 0))
		context:setString(Strings:get(titledes[i]))

		local size = context:getContentSize()

		panel:setContentSize(cc.size(size.width, size.height + 10))
		self._rulelistView:pushBackCustomItem(panel)
	end

	self._listView:removeAllChildren(true)

	for i = 1, #self._rewards do
		local data = {}
		local key = next(self._rewards[i])

		data.des = key
		data.num = self._rewards[i][key]
		data.rate = self._rates[i] or 0

		local panel = self._contentPanel:clone()

		panel:setVisible(true)
		self._listView:pushBackCustomItem(panel)
		self:updataCell(panel, data, i)
	end
end

function ActivityBlockFudaiPreviewMeditor:updataCell(panel, _data, index)
	if not _data.rate then
		panel:getChildByFullName("content1"):setString(_data.rate * 100 .. "%")
		panel:getChildByFullName("title"):setString(Strings:get(_data.des))
		panel:getChildByFullName("content"):setString(Strings:get(_data.num))
	end
end

function ActivityBlockFudaiPreviewMeditor:onClickBack()
	self:close()
end
