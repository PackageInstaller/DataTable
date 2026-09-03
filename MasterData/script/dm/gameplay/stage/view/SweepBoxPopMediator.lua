-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/stage/view/SweepBoxPopMediator.lua

SweepBoxPopMediator = class("SweepBoxPopMediator", DmPopupViewMediator, _M)

local btnHandlers = {}

function SweepBoxPopMediator:initialize()
	super.initialize(self)
end

function SweepBoxPopMediator:dispose()
	super.dispose(self)
end

function SweepBoxPopMediator:onRegister()
	super:onRegister(self)

	self._return = 0

	self:mapButtonHandlersClick(btnHandlers)
	self:bindWidget("sweepBox", PopupNormalWidget, {
		bg = "paihangbang_bg_di_4.png",
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onClickClose, self)
		},
		title = Strings:get("Stage_Sweep_BoxTitle"),
		title1 = Strings:get("UITitle_EN_Xuanzezhandoumoshi"),
		fontSize = getCurrentLanguage() ~= GameLanguageType.CN and 40 or nil
	})
	self:bindWidget("fight", OneLevelViceButton, {
		ignoreAddKerning = true,
		handler = {
			ignoreClickAudio = true,
			func = bind1(self.onChallenge, self)
		}
	})
	self:bindWidget("wipeTen", OneLevelViceButton, {
		ignoreAddKerning = true,
		handler = {
			ignoreClickAudio = true,
			func = bind1(self.onClickWipeTimes, self)
		}
	})
	self:bindWidget("wipeOne", OneLevelViceButton, {
		ignoreAddKerning = true,
		handler = {
			ignoreClickAudio = true,
			func = bind1(self.onClickWipeOnce, self)
		}
	})

	local text = self:getView():getChildByName("Text_1")

	text:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
end

local buttonPosXTable2 = {
	447,
	704
}
local buttonPosXTable3 = {
	575
}

function SweepBoxPopMediator:enterWithData(data)
	if data.normalType then
		local bottomText = self:getView():getChildByFullName("wipeTen.name1")

		bottomText:setString(Strings:get("Ten"))

		local contentTxt = self:getView():getChildByFullName("Text_1")

		contentTxt:setString(Strings:get("Raid_PopUp_Text"))

		local tenBtn = self:getView():getChildByFullName("wipeTen")
		local oneBtn = self:getView():getChildByFullName("wipeOne")
		local fightBtn = self:getView():getChildByFullName("fight")

		fightBtn:setVisible(false)

		if data.challengeTimes == 1 then
			tenBtn:setVisible(false)
			oneBtn:setPositionX(buttonPosXTable3[1])
		else
			tenBtn:setVisible(true)
			oneBtn:setPositionX(buttonPosXTable2[1])
			tenBtn:setPositionX(buttonPosXTable2[2])
		end

		local title1 = self:getView():getChildByFullName("sweepBox.title_node.Text_1")
		local title2 = self:getView():getChildByFullName("sweepBox.title_node.Text_2")

		title1:setString(Strings:get("Raid_PopUp_Title"))
		title2:setString(Strings:get("Raid_PopUp_TitleEN"))

		local posX = title1:getPositionX()
		local width = title1:getAutoRenderSize().width

		title2:setAnchorPoint(cc.p(0.5, 0.5))
		title2:setPositionX(posX + width / 2)

		if data.stageType == StageType.kElite then
			local btnText = self:getView():getChildByFullName("wipeTen.name")
			local changeTimes = data.challengeTimes

			btnText:setString(Strings:get("Sweep_Set_Amount", {
				num = changeTimes
			}))
		end
	elseif data.stageType == StageType.kElite then
		local btnText = self:getView():getChildByFullName("wipeTen.name")
		local changeTimes = data.challengeTimes

		btnText:setString(Strings:get("Sweep_Set_Amount", {
			num = changeTimes
		}))

		btnText = self:getView():getChildByFullName("wipeOne.name")

		btnText:setString(Strings:get("Stage_Wipe_Title"))
	elseif data.stageType == kHeroStroy then
		local tenBtn = self:getView():getChildByFullName("wipeTen")
		local oneBtn = self:getView():getChildByFullName("wipeOne")
		local fightBtn = self:getView():getChildByFullName("fight")

		tenBtn:setVisible(false)
		oneBtn:setPositionX(buttonPosXTable2[1])
		fightBtn:setPositionX(buttonPosXTable2[2])
	else
		local bottomText = self:getView():getChildByFullName("wipeTen.name1")

		bottomText:setString(Strings:get("Ten"))
	end

	if data and data.desc then
		local contentTxt = self:getView():getChildByFullName("Text_1")

		contentTxt:setString(Strings:get(data.desc))
	end
end

function SweepBoxPopMediator:onRemove()
	super.onRemove(self)
end

function SweepBoxPopMediator:onChallenge()
	self._return = 1

	self:onClickClose()
end

function SweepBoxPopMediator:onClickWipeTimes()
	self._return = 2

	self:onClickClose()
end

function SweepBoxPopMediator:onClickWipeOnce()
	self._return = 3

	self:onClickClose()
end

function SweepBoxPopMediator:onClickClose()
	self:close({
		returnValue = self._return
	})
end
