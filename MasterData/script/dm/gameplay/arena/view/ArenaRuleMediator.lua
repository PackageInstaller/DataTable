-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/arena/view/ArenaRuleMediator.lua

ArenaRuleMediator = class("ArenaRuleMediator", DmPopupViewMediator, _M)

ArenaRuleMediator:has("_arenaSystem", {
	is = "r"
}):injectWith("ArenaSystem")

local Arena_RuleTranslate = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Arena_RuleTranslate", "content")

function ArenaRuleMediator:initialize()
	super.initialize(self)
end

function ArenaRuleMediator:dispose()
	super.dispose(self)
end

function ArenaRuleMediator:onRegister()
	super.onRegister(self)
end

function ArenaRuleMediator:enterWithData(data)
	data = data or {}
	self._data = data

	self:initWidgetInfo(data)
	self:initContent(data)
end

function ArenaRuleMediator:initWidgetInfo(data)
	if not data.title1 then
		local title1 = Strings:get("Arena_UI35")

		if not data.title2 then
			local title2 = Strings:get("UITitle_EN_Guizeshuoming")

			self._bgWidget = bindWidget(self, "bg.bgNode", PopupNormalWidget, {
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

function ArenaRuleMediator:initContent(data)
	self._listView:setScrollBarEnabled(false)

	if data then
		if not data.rule then
			local rule = Arena_RuleTranslate

			if data and data.useParam then
				if not data.extraParams then
					data.extraParams.param1 = data.param1
					data.extraParams.param2 = data.param2

					for i = 1, #rule do
						self:addContent(Strings:get(rule[i], data.extraParams), i)
					end
				end
			else
				for i = 1, #rule do
					if i == 1 then
						self:addContent(Strings:get(rule[i], {
							topic = self._data.topic
						}), i)
					elseif i == 2 then
						self:addContent(Strings:get(rule[i], {
							starttime = self._data.starttime,
							endtime = self._data.endtime
						}), i)
					elseif i == 3 then
						self:addContent(Strings:get(rule[i], {
							buff = self._data.buff
						}), i)
					elseif i == 4 then
						self:addContent(Strings:get(rule[i], {
							level = self._data.level
						}), i)
					else
						self:addContent(Strings:get(rule[i]), i)
					end
				end
			end
		end
	end
end

function ArenaRuleMediator:addContent(content, index)
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

function ArenaRuleMediator:onClickClose()
	self:close()
end
