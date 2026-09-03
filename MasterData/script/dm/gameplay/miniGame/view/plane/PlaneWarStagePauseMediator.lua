-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/miniGame/view/plane/PlaneWarStagePauseMediator.lua

PlaneWarStagePauseMediator = class("PlaneWarStagePauseMediator", DmPopupViewMediator, _M)

function PlaneWarStagePauseMediator:initialize()
	super.initialize(self)
end

function PlaneWarStagePauseMediator:enterWithData(data)
	local bgNode = self:getView():getChildByFullName("main.bg_node")

	self:bindWidget(bgNode, PopupNormalWidget, {
		btnHandler = bind1(self.onContinueClicked, self),
		title = Strings:get("MiniPlaneText28")
	})

	local starPanel = self:getView():getChildByFullName("main.star_panel")
	local btnReset = self:getView():getChildByFullName("main.reset_btn")
	local btnContinue = self:getView():getChildByFullName("main.continue_btn")
	local condTitle = self:getView():getChildByFullName("main.label1")

	condTitle:setString(Strings:get("44238247_e279_11e8_8b6c_7c04d0d9796c"))

	local cond = {}

	cond[1] = starPanel:getChildByName("condition_text_1")
	cond[2] = starPanel:getChildByName("condition_text_2")
	cond[3] = starPanel:getChildByName("condition_text_3")

	local star = {}

	star[1] = starPanel:getChildByName("star_1")
	star[2] = starPanel:getChildByName("star_2")
	star[3] = starPanel:getChildByName("star_3")

	if data.showStar then
		starPanel:setVisible(true)

		for k, v in pairs(data.condText) do
			cond[k]:setString(Strings:get(v.desc, {
				num = v.score
			}))
		end
	else
		starPanel:setVisible(false)
	end

	local starNum = #data.condText

	if starNum and starNum == 1 then
		star[2]:setVisible(false)
		star[3]:setVisible(false)
		cond[2]:setVisible(false)
		cond[3]:setVisible(false)
		star[1]:setPositionX(star[2]:getPositionX())
		cond[1]:setPositionX(cond[2]:getPositionX())
	elseif starNum and starNum == 2 then
		star[3]:setVisible(false)
		cond[3]:setVisible(false)
		star[1]:setPositionX(star[1]:getPositionX() + 50)
		cond[1]:setPositionX(cond[1]:getPositionX() + 50)
		star[2]:setPositionX(star[2]:getPositionX() + 50)
		cond[2]:setPositionX(cond[2]:getPositionX() + 50)
	end
end

function PlaneWarStagePauseMediator:onRegister()
	super.onRegister(self)
	self:bindWidgets()
end

function PlaneWarStagePauseMediator:bindWidgets()
	self:bindWidget("main.continue_btn", TwoLevelMainButton, {
		handler = bind1(self.onContinueClicked, self)
	})
	self:bindWidget("main.leave_btn", TwoLevelViceButton, {
		handler = bind1(self.onLeaveClicked, self)
	})
end

function PlaneWarStagePauseMediator:onTouchMaskLayer()
	return
end

function PlaneWarStagePauseMediator:onContinueClicked(sender, eventType)
	if eventType == ccui.TouchEventType.ended and self._popupDelegate and self._popupDelegate.onContinue then
		self._popupDelegate:onContinue(self)

		self._buttonResponsed = true

		self:close()
	end
end

function PlaneWarStagePauseMediator:onLeaveClicked(sender, eventType)
	if eventType == ccui.TouchEventType.ended and self._popupDelegate and self._popupDelegate.onLeave then
		self._popupDelegate:onLeave(self)

		self._buttonResponsed = true

		self:close()
	end
end

function PlaneWarStagePauseMediator:close()
	if not self._buttonResponsed and self._popupDelegate and self._popupDelegate.onContinue then
		self._popupDelegate:onContinue(self)
	end

	super.close(self)
end
