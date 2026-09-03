-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/worldpeace/view/WordPeaceSwearRuleMediator.lua

WordPeaceSwearRuleMediator = class("WordPeaceSwearRuleMediator", DmPopupViewMediator, _M)

local Arena_RuleTranslate = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Arena_RuleTranslate", "content")

function WordPeaceSwearRuleMediator:initialize()
	super.initialize(self)
end

function WordPeaceSwearRuleMediator:dispose()
	super.dispose(self)
end

function WordPeaceSwearRuleMediator:onRegister()
	super.onRegister(self)
end

function WordPeaceSwearRuleMediator:enterWithData(data)
	data = data or {}
	self._data = data

	self:initWidgetInfo(data)
	self:initContent(data)
end

function WordPeaceSwearRuleMediator:initWidgetInfo(data)
	if not data.title1 then
		local title1 = Strings:get("Arena_UI35")

		if not data.title2 then
			local title2 = Strings:get("UITitle_EN_Guizeshuoming")

			self._bgWidget = bindWidget(self, "bg.bgNode", PopupNormalWidget, {
				ignoreWhiteBg = true,
				ignoreBtnBg = true,
				btnHandler = {
					clickAudio = "Se_Click_Close_2",
					func = bind1(self.onClickClose, self)
				},
				title = data.title1,
				title1 = title2
			})
			self._mainPanel = self:getView():getChildByFullName("bg")
			self._listView = self._mainPanel:getChildByName("listview")
		end
	end
end

function WordPeaceSwearRuleMediator:initContent(data)
	self._listView:setScrollBarEnabled(false)

	local rule = ConfigReader:getDataByNameIdAndKey("ConfigValue", "ClubMapBoss_Chat_Rule", "content")

	for i = 1, #rule do
		self:addContent(Strings:get(rule[i], params), i)
	end
end

function WordPeaceSwearRuleMediator:addContent(content, index)
	local contextPanel = self._mainPanel:getChildByName("context_panal")

	contextPanel:setVisible(false)

	local panel = contextPanel:clone()

	panel:setVisible(true)

	local context = panel:getChildByName("context")

	context:setTextAreaSize(cc.size(panel:getContentSize().width, 0))
	context:setString(content)

	local size = context:getContentSize()

	if index == 1 then
		panel:setContentSize(cc.size(size.width, size.height + 15))
	else
		panel:setContentSize(cc.size(size.width, size.height + 10))
	end

	self._listView:pushBackCustomItem(panel)
end

function WordPeaceSwearRuleMediator:onClickClose()
	self:close()
end
