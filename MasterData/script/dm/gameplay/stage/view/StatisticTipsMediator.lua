-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/stage/view/StatisticTipsMediator.lua

StatisticTipsMediator = class("StatisticTipsMediator", DmPopupViewMediator)

function StatisticTipsMediator:initialize()
	super.initialize(self)
end

function StatisticTipsMediator:dispose()
	super.dispose(self)
end

function StatisticTipsMediator:onRegister()
	super.onRegister(self)
	self:bindWidget("mainBg", PopupNormalWidget, {
		ignoreBtnBg = true,
		btnHandler = {
			clickAudio = "Se_Click_Close_2",
			func = bind1(self.onClickClose, self)
		},
		title = Strings:get("Statistical_Notes"),
		title1 = Strings:get("UITitle_EN_Tongjishuoming")
	})
end

function StatisticTipsMediator:enterWithData()
	local tips = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Battle_StatisticalText", "content")
	local listView = self:getView():getChildByName("tipsList")

	for _, v in ipairs(tips) do
		local text = ccui.Text:create(Strings:get(v), TTF_FONT_FZYH_M, 18)

		text:setTextColor(cc.c3b(195, 195, 195))
		text:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
		text:getVirtualRenderer():setMaxLineWidth(730)
		listView:pushBackCustomItem(text)
		listView:setScrollBarEnabled(false)
	end
end

function StatisticTipsMediator:onClickClose()
	self:close()
end
