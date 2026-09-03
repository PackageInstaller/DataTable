-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/miniGame/view/common/MiniGameQuitConfirmMediator.lua

MiniGameQuitConfirmMediator = class("MiniGameQuitConfirmMediator", DmPopupViewMediator, _M)

function MiniGameQuitConfirmMediator:initialize()
	super.initialize(self)
end

function MiniGameQuitConfirmMediator:dispose()
	super.dispose(self)
end

function MiniGameQuitConfirmMediator:userInject()
	return
end

function MiniGameQuitConfirmMediator:onRegister()
	super.onRegister(self)

	self._cancelBtn = self:bindWidget("main.cancel_btn", OneLevelViceButton, {
		handler = {
			clickAudio = "Se_Click_Cancle",
			func = bind1(self.onClickBack, self)
		}
	})
	self._confirmBtn = self:bindWidget("main.confirm_btn", OneLevelMainButton, {
		handler = {
			clickAudio = "Se_Click_Confirm",
			func = bind1(self.onClickConfirm, self)
		}
	})
end

function MiniGameQuitConfirmMediator:adjustLayout(targetFrame)
	return
end

function MiniGameQuitConfirmMediator:enterWithData(data)
	self._data = data

	self:setupView()
end

function MiniGameQuitConfirmMediator:setupView()
	self._mainPanel = self:getView():getChildByFullName("main")

	self:refreshBg()
	self:setReWardIcon()
end

function MiniGameQuitConfirmMediator:refreshBg()
	local bgNode = self:getView():getChildByFullName("main.bg")

	bindWidget(self, bgNode, PopupNormalWidget, {
		btnHandler = {
			clickAudio = "Se_Click_Close_2",
			func = bind1(self.onClickBack, self)
		},
		title = Strings:get("MiniGame_Common_UI1"),
		title1 = Strings:get("MiniGame_Common_UI2")
	})
end

local rewardOffset = {
	{
		0
	},
	{
		-40,
		40
	},
	{
		-100,
		0,
		100
	},
	{
		-150,
		-50,
		50,
		150
	},
	{
		-200,
		-100,
		0,
		100,
		200
	}
}

function MiniGameQuitConfirmMediator:setReWardIcon()
	local rewards = self._data.reward
	local showList = {}
	local itempos = self:getView():getChildByFullName("main.Panel_Item_pos")

	for k, v in pairs(rewards) do
		if v.num > 0 then
			local icon = IconFactory:createIcon({
				id = v.id,
				amount = v.num
			})

			icon:setAnchorPoint(0.5, 0.5)
			icon:addTo(itempos, 1):posite(0, 0)

			showList[#showList + 1] = icon
		end
	end

	for i = 1, #showList do
		showList[i]:setScale(0.6)
		showList[i]:setPositionX(showList[i]:getPositionX() + rewardOffset[#showList][i])
	end
end

function MiniGameQuitConfirmMediator:onClickClose(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		self:dispatch(Event:new(self._data.eventback, {}))
		self:close()
	end
end

function MiniGameQuitConfirmMediator:onClickBack(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		self:dispatch(Event:new(self._data.eventback, {}))
		self:close()
	end
end

function MiniGameQuitConfirmMediator:onTouchMaskLayer()
	return
end

function MiniGameQuitConfirmMediator:onClickConfirm(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		self:dispatch(Event:new(self._data.eventconfirm, {}))
		self:close()
	end
end
