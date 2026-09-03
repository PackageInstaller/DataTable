-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/popup/BaseRewardBoxMediator.lua

BaseRewardBoxMediator = class("BaseRewardBoxMediator", DmPopupViewMediator, _M)

local kBtnHandlers = {}

function BaseRewardBoxMediator:initialize()
	super.initialize(self)
end

function BaseRewardBoxMediator:dispose()
	super.dispose(self)
end

function BaseRewardBoxMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._sureBtn = self:bindWidget("main.sure_btn", OneLevelViceButton, {
		handler = {
			clickAudio = "Se_Click_Confirm",
			func = bind1(self.onClickSure, self)
		}
	})
	self._receiveBtn = self:bindWidget("main.receive_btn", OneLevelMainButton, {
		handler = {
			clickAudio = "Se_Click_Confirm",
			func = bind1(self.onClickReceive, self)
		}
	})

	self:glueFieldAndUi()
end

function BaseRewardBoxMediator:enterWithData(data)
	if data == nil then
		return
	end

	self:setupView(data)
end

function BaseRewardBoxMediator:setupView(data)
	local bgNode = self._main:getChildByFullName("bg_node")

	if data.title then
		local var_5_0 = Strings:get(data.title)

		if not var_5_0 then
			var_5_0 = Strings:get("RewardPreview_Title")

			local title = var_5_0

			if data.titleEn then
				local var_5_1 = Strings:get(data.titleEn)

				if not var_5_1 then
					var_5_1 = Strings:get("UITitle_EN_Jiangli")

					local titleEn = var_5_1

					self:bindWidget(bgNode, PopupNormalWidget, {
						btnHandler = {
							clickAudio = "Se_Click_Close_2",
							func = bind1(self.onClickClose, self)
						},
						title = title,
						title1 = titleEn
					})
				end
			end
		end
	end
end

function BaseRewardBoxMediator:glueFieldAndUi()
	local view = self:getView()

	self._main = view:getChildByFullName("main")

	self._sureBtn:setVisible(false)
	self._receiveBtn:setVisible(false)

	self._hasReceivedImg = self._main:getChildByFullName("has_received_img")

	self._hasReceivedImg:setVisible(false)

	self._normalBoxInfo = self._main:getChildByFullName("box_info")

	self._normalBoxInfo:setVisible(false)

	self._descTextNode = self._main:getChildByFullName("desc_text_node")

	self._descTextNode:setVisible(false)
end

rewardShowType = {
	firstBig = "firstBig",
	normal = "normal"
}

local showTypeParams = {
	normal = {
		diffY = 0,
		width = 100,
		scale = 0.8
	},
	firstBig = {
		diffY = -8,
		width = 115,
		scale = 0.65
	}
}

function BaseRewardBoxMediator:addRewardIcons(rewards, showType)
	local iconsRect = self._main:getChildByFullName("icons_rect")
	local count = #rewards

	showType = showType or rewardShowType.normal

	local width = showTypeParams[showType].width
	local scale = showTypeParams[showType].scale
	local diffY = showTypeParams[showType].diffY
	local poxY = iconsRect:getPositionY()
	local firstIconPosX = iconsRect:getPositionX() - (count - 1) * width / 2

	for index = 1, #rewards do
		local reward = rewards[index]
		local icon = IconFactory:createRewardIcon(reward, {
			isWidget = true
		})

		IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), reward, {
			needDelay = true
		})
		icon:addTo(iconsRect:getParent()):posite(firstIconPosX + (index - 1) * width, poxY)
		icon:setScaleNotCascade(0.8)

		if index > 1 then
			icon:setScaleNotCascade(scale)
			icon:setPositionY(icon:getPositionY() + diffY)
		end
	end
end

function BaseRewardBoxMediator:onClickClose()
	self:close()
end

function BaseRewardBoxMediator:onClickSure()
	self:close()
end

function BaseRewardBoxMediator:onClickReceive(sender, eventType)
	return
end
