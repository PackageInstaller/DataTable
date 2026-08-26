-- chunkname: @modules/logic/seasonver/act123/view2_0/Season123_2_0HeroGroupReplaySelectView.lua

module("modules.logic.seasonver.act123.view2_0.Season123_2_0HeroGroupReplaySelectView", package.seeall)

local Season123_2_0HeroGroupReplaySelectView = class("Season123_2_0HeroGroupReplaySelectView", BaseView)

function Season123_2_0HeroGroupReplaySelectView:onInitView()
	self._btnmultispeed = gohelper.findChildButtonWithAudio(self.viewGO, "#go_container/btnContain/horizontal/#go_replayBtn/replayAnimRoot/#btn_multispeed")
	self._txtmultispeed = gohelper.findChildTextMesh(self.viewGO, "#go_container/btnContain/horizontal/#go_replayBtn/replayAnimRoot/#btn_multispeed/Label")
	self._btnclosemult = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_closemult")
	self._gomultPos = gohelper.findChild(self.viewGO, "#go_container/btnContain/horizontal/#go_replayBtn/replayAnimRoot/#btn_multispeed/#go_multpos")
	self._gomultispeed = gohelper.findChild(self.viewGO, "#go_multispeed")
	self._gomultContent = gohelper.findChild(self.viewGO, "#go_multispeed/Viewport/Content")
	self._gomultitem = gohelper.findChild(self.viewGO, "#go_multispeed/Viewport/Content/#go_multitem")
	self._imageicon = gohelper.findChildImage(self.viewGO, "#go_container/btnContain/horizontal/#btn_startseasonreplay/#go_cost/#image_icon")
	self._txtcostNum = gohelper.findChildText(self.viewGO, "#go_container/btnContain/horizontal/#btn_startseasonreplay/#go_cost/#txt_num")
	self._godropbg = gohelper.findChild(self.viewGO, "#go_multispeed/Viewport/bg")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season123_2_0HeroGroupReplaySelectView:addEvents()
	self._btnmultispeed:AddClickListener(self._btnmultispeedOnClick, self)
	self._btnclosemult:AddClickListener(self._btnclosemultOnClick, self)
end

function Season123_2_0HeroGroupReplaySelectView:removeEvents()
	self._btnmultispeed:RemoveClickListener()
	self._btnclosemult:RemoveClickListener()
end

function Season123_2_0HeroGroupReplaySelectView:_editableInitView()
	self._isMultiOpen = false
	self.rectdropbg = self._godropbg.transform

	self:refreshMulti()
end

function Season123_2_0HeroGroupReplaySelectView:onDestroyView()
	return
end

function Season123_2_0HeroGroupReplaySelectView:onOpen()
	self:initCostIcon()
	self:initMultiGroup()
	self:refreshSelection()
end

function Season123_2_0HeroGroupReplaySelectView:onClose()
	return
end

Season123_2_0HeroGroupReplaySelectView.ItemHeight = 92

function Season123_2_0HeroGroupReplaySelectView:initMultiGroup()
	self._multSpeedItems = {}
	self.maxMultiplicationTimes = CommonConfig.instance:getConstNum(ConstEnum.MaxMultiplication)

	local parent = self._gomultContent.transform
	local maxTimes

	if Season123HeroGroupModel.instance:isEpisodeSeason123Retail() then
		local ticketNum = Season123HeroGroupModel.instance:getMultiplicationTicket()

		maxTimes = math.min(self.maxMultiplicationTimes, ticketNum)
	else
		maxTimes = 1
	end

	for i = 1, self.maxMultiplicationTimes do
		local tfItem = parent:GetChild(i - 1)
		local times = self.maxMultiplicationTimes - i + 1

		if maxTimes < times then
			gohelper.setActive(tfItem, false)
		else
			gohelper.setActive(tfItem, true)
			self:initMultSpeedItem(tfItem.gameObject, times, maxTimes)
		end
	end

	recthelper.setHeight(self.rectdropbg, Season123_2_0HeroGroupReplaySelectView.ItemHeight * maxTimes)
end

function Season123_2_0HeroGroupReplaySelectView:initMultSpeedItem(go, multispeed, maxTimes)
	if not self._multSpeedItems[multispeed] then
		local goline = gohelper.findChild(go, "line")
		local txtnum = gohelper.findChildTextMesh(go, "num")
		local goselecticon = gohelper.findChild(go, "selecticon")

		self.addClickCb(self, gohelper.getClick(go), self.onClickSetSpeed, self, multispeed)

		txtnum.text = luaLang("multiple") .. multispeed

		gohelper.setActive(goline, multispeed ~= maxTimes)

		self._multSpeedItems[multispeed] = self:getUserDataTb_()
		self._multSpeedItems[multispeed].txtnum = txtnum
		self._multSpeedItems[multispeed].goselecticon = goselecticon
	end
end

function Season123_2_0HeroGroupReplaySelectView:initCostIcon()
	local actId = Season123HeroGroupModel.instance.activityId
	local ticketId = Season123Config.instance:getEquipItemCoin(actId, Activity123Enum.Const.UttuTicketsCoin)

	if ticketId then
		local currencyCO = CurrencyConfig.instance:getCurrencyCo(ticketId)

		if not currencyCO then
			return
		end

		UISpriteSetMgr.instance:setCurrencyItemSprite(self._imageicon, tostring(currencyCO.icon) .. "_1")
	else
		logNormal("Season123 ticketId is nil : " .. tostring(actId))
	end
end

function Season123_2_0HeroGroupReplaySelectView:refreshMulti()
	gohelper.setActive(self._gomultispeed, self._isMultiOpen)
	gohelper.setActive(self._btnclosemult, self._isMultiOpen)

	self._gomultispeed.transform.position = self._gomultPos.transform.position
end

function Season123_2_0HeroGroupReplaySelectView:onClickSetSpeed(speed)
	self:setMultSpeed(speed)
end

local selectColor = GameUtil.parseColor("#efb785")
local unSelectColor = GameUtil.parseColor("#C3BEB6")

function Season123_2_0HeroGroupReplaySelectView:setMultSpeed(speed)
	Season123HeroGroupController.instance:setMultiplication(speed)

	local replayCn = formatLuaLang("herogroupview_replaycn", GameUtil.getNum2Chinese(Season123HeroGroupModel.instance.multiplication))

	self._isMultiOpen = false

	self:refreshMulti()
	self:refreshSelection()
end

function Season123_2_0HeroGroupReplaySelectView:refreshSelection()
	local speed = Season123HeroGroupModel.instance.multiplication

	self._txtmultispeed.text = luaLang("multiple") .. speed
	self._txtcostNum.text = "-" .. tostring(speed)

	for i = 1, self.maxMultiplicationTimes do
		local item = self._multSpeedItems[i]

		if item then
			if speed == i then
				item.txtnum.color = selectColor or unSelectColor
			end

			gohelper.setActive(item.goselecticon, speed == i)
		end
	end
end

function Season123_2_0HeroGroupReplaySelectView:_btnmultispeedOnClick()
	self._isMultiOpen = not self._isMultiOpen

	self:refreshMulti()
end

function Season123_2_0HeroGroupReplaySelectView:_btnclosemultOnClick()
	self._isMultiOpen = false

	self:refreshMulti()
end

return Season123_2_0HeroGroupReplaySelectView
