-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/view/worldBoss/WorldBossBuffMediator.lua

WorldBossBuffMediator = class("WorldBossBuffMediator", DmPopupViewMediator, _M)

function WorldBossBuffMediator:initialize()
	super.initialize(self)
end

function WorldBossBuffMediator:dispose()
	super.dispose(self)
end

function WorldBossBuffMediator:onRegister()
	super.onRegister(self)
end

function WorldBossBuffMediator:enterWithData(data)
	data = data or {}
	self._data = data

	self:initWidgetInfo(data)
	self:initContent()
end

function WorldBossBuffMediator:initWidgetInfo(data)
	self._bgWidget = bindWidget(self, "bg.bgNode", PopupNormalWidget, {
		btnHandler = {
			clickAudio = "Se_Click_Close_2",
			func = bind1(self.onClickClose, self)
		},
		title = Strings:get("WorldBosstiTleText")
	})
	self._mainPanel = self:getView():getChildByFullName("bg")
	self._listView = self._mainPanel:getChildByName("listview")

	self._listView:setScrollBarEnabled(false)

	local contextPanel = self._mainPanel:getChildByName("context_panal")

	contextPanel:setVisible(false)
end

function WorldBossBuffMediator:initContent()
	local buffData = self._data.buffData

	dump(buffData, "buffData")

	if buffData.FirstDesc then
		self:addContent(Strings:get(buffData.FirstDesc))
	end

	if buffData.HeroId then
		self:addContent(Strings:get("WorldBosstiTle1"))
		self:addHeroBuff(buffData)
	end

	if buffData.Party then
		self:addContent(Strings:get("WorldBosstiTle2"))
		self:addPartyBuff(buffData)
	end

	if self._data.nextBuffData then
		local nextBuffData = self._data.nextBuffData
		local startTime = nextBuffData.startTime
		local date = TimeUtil:localDate("%Y-%m-%d %H:%M:%S", startTime)

		self:addContent(Strings:get("WorldBosstiTle3", {
			Time = date
		}))

		if nextBuffData.HeroId then
			self:addContent(Strings:get("WorldBosstiTle4"))
			self:addHeroBuff(nextBuffData)
		end

		if nextBuffData.Party then
			self:addContent(Strings:get("WorldBosstiTle5"))
			self:addPartyBuff(nextBuffData)
		end
	end
end

function WorldBossBuffMediator:addHeroBuff(buffData)
	local strArr = {}

	for i, v in pairs(buffData.HeroId) do
		local heroConfig = ConfigReader:getRecordById("HeroBase", v)

		strArr[#strArr + 1] = Strings:get(heroConfig.Name)
	end

	local string = Strings:get("WorldBossheroname", {
		HeroName = table.concat(strArr, "、")
	})

	strArr = {}

	if buffData.HeroBuffId then
		for i, v in pairs(buffData.HeroBuffId) do
			local buffDesc = SkillPrototype:getEffectDesc(v, 1)

			string = string .. buffDesc
		end
	end

	self:addContent(string)
end

function WorldBossBuffMediator:addPartyBuff(buffData)
	local titleArray = ConfigReader:getDataByNameIdAndKey("ConfigValue", "HeroPartyName", "content")
	local strArr = {}

	for i, v in pairs(buffData.Party) do
		strArr[#strArr + 1] = Strings:get(titleArray[v])
	end

	local string = Strings:get("WorldBossPartyname", {
		PartyName = table.concat(strArr, "、")
	})

	if buffData.PartyBuffId then
		local buffDesc = SkillPrototype:getEffectDesc(buffData.PartyBuffId, 1)

		string = string .. buffDesc
	end

	self:addContent(string)
end

function WorldBossBuffMediator:addContent(content)
	local textData = string.split(content, "<font")

	if #textData <= 1 then
		content = string.format("<font face='asset/font/CustomFont_FZYH_M.TTF' size='18' color='#D2D2D2'>%s</font>", content)
	end

	local layout = ccui.Layout:create()
	local context = ccui.RichText:createWithXML("", {})

	context:setString(content)
	context:setAnchorPoint(cc.p(0, 1))
	context:renderContent(self._listView:getContentSize().width, 0, true)

	local length = context:getContentSize().height + 10

	context:addTo(layout):posite(0, length - 10)
	layout:setContentSize(cc.size(self._listView:getContentSize().width, length))
	self._listView:pushBackCustomItem(layout)
end

function WorldBossBuffMediator:onClickClose()
	self:close()
end
