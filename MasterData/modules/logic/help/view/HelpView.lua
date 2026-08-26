-- chunkname: @modules/logic/help/view/HelpView.lua

module("modules.logic.help.view.HelpView", package.seeall)

local HelpView = class("HelpView", BaseView)

function HelpView:onInitView()
	self._goslider = gohelper.findChild(self.viewGO, "#go_slider")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")
	self._scrollcontent = gohelper.findChildScrollRect(self.viewGO, "#scroll_content")
	self._gocontent = gohelper.findChild(self.viewGO, "#go_content")
	self._btnleft = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_left")
	self._btnright = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_right")
	self._goscroll = gohelper.findChild(self.viewGO, "#go_scroll")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function HelpView:addEvents()
	self._btnleft:AddClickListener(self._btnleftOnClick, self)
	self._btnright:AddClickListener(self._btnrightOnClick, self)
end

function HelpView:removeEvents()
	self._btnleft:RemoveClickListener()
	self._btnright:RemoveClickListener()
end

function HelpView:_btnleftOnClick()
	local index = HelpModel.instance:getTargetPageIndex()

	if index <= 1 then
		return
	end

	HelpModel.instance:setTargetPageIndex(index - 1)
	self:selectHelpItem()
end

function HelpView:_btnrightOnClick()
	local index = HelpModel.instance:getTargetPageIndex()

	if index >= #self._pagesCo then
		return
	end

	HelpModel.instance:setTargetPageIndex(index + 1)
	self:selectHelpItem()
end

function HelpView:_editableInitView()
	gohelper.addUIClickAudio(self._btnleft.gameObject, AudioEnum.UI.Play_UI_help_switch)
	gohelper.addUIClickAudio(self._btnright.gameObject, AudioEnum.UI.Play_UI_help_switch)

	self._selectItems = {}
	self._helpItems = {}

	local parentWidth = recthelper.getWidth(self.viewGO.transform)

	self._space = parentWidth + 80
	self._scroll = SLFramework.UGUI.UIDragListener.Get(self._goscroll)

	self._scroll:AddDragBeginListener(self._onScrollDragBegin, self)
	self._scroll:AddDragEndListener(self._onScrollDragEnd, self)

	self._viewClick = gohelper.getClick(self._gocontent)

	self._viewClick:AddClickListener(self._onClickView, self)
	self.addEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self._onScreenResize, self)
end

function HelpView:_onScreenResize()
	local parentWidth = recthelper.getWidth(self.viewGO.transform)

	self._space = parentWidth + 80

	if self._helpItems then
		for i = 1, #self._helpItems do
			local pos = self._space * (i - 1)

			self._helpItems[i]:updatePos(pos)
		end
	end

	local x = (1 - HelpModel.instance:getTargetPageIndex()) * self._space

	recthelper.setAnchorX(self._gocontent.transform, x)
end

function HelpView:_onScrollDragBegin(param, eventData)
	self._scrollStartPos = eventData.position
end

function HelpView:_onScrollDragEnd(param, eventData)
	local scrollEndPos = eventData.position
	local deltaX = scrollEndPos.x - self._scrollStartPos.x
	local deltaY = scrollEndPos.y - self._scrollStartPos.y

	if math.abs(deltaX) < math.abs(deltaY) then
		return
	end

	if deltaX > 100 and self._btnleft.gameObject.activeInHierarchy then
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_help_switch)
		HelpModel.instance:setTargetPageIndex(HelpModel.instance:getTargetPageIndex() - 1)
		self:selectHelpItem()
	elseif deltaX < -100 and self._btnright.gameObject.activeInHierarchy then
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_help_switch)
		HelpModel.instance:setTargetPageIndex(HelpModel.instance:getTargetPageIndex() + 1)
		self:selectHelpItem()
	end
end

function HelpView:_onClickView()
	if self.viewParam.guideId then
		self:_btnrightOnClick()
	end
end

function HelpView:onUpdateParam()
	if self._helpItems then
		for _, v in pairs(self._helpItems) do
			v:destroy()
			gohelper.destroy(v._go)
		end
	end

	self._helpItems = {}

	self:_refreshView()
end

function HelpView:onOpen()
	self:_refreshView()
end

function HelpView:_refreshView()
	self._helpId = self.viewParam.id
	self._pageId = self.viewParam.pageId

	if self.viewParam.guideId then
		self._helpId = tonumber(self.viewParam.viewParam)
		self._matchGuideId = tonumber(self.viewParam.guideId)
		self._matchAllPage = self.viewParam.matchAllPage
	end

	if not self.viewParam.openFromGuide then
		self.addEventCb(self, GuideController.instance, GuideEvent.FinishStep, self._onFinishGuideStep, self)
	end

	self._pagesCo = {}

	if self._helpId then
		local helpCfg = HelpConfig.instance:getHelpCO(self._helpId)

		if not helpCfg then
			logError("请检查帮助说明配置" .. tostring(self._helpId) .. "相关配置是否完整！")
		end

		local co = string.split(helpCfg.page, "#")

		if #co < 1 then
			logError("请检查帮助界面" .. tostring(self._helpId) .. "相关配置是否完整！")

			return
		end

		HelpModel.instance:setTargetPageIndex(1)

		for i = 1, #co do
			local pageCo = HelpConfig.instance:getHelpPageCo(tonumber(co[i]))

			if self._matchAllPage then
				if HelpController.instance:canShowPage(pageCo) or pageCo.unlockGuideId == self._matchGuideId then
					table.insert(self._pagesCo, pageCo)
				end
			elseif self._matchGuideId then
				if pageCo.unlockGuideId == self._matchGuideId then
					table.insert(self._pagesCo, pageCo)
				end
			elseif HelpController.instance:canShowPage(pageCo) then
				table.insert(self._pagesCo, pageCo)
			end
		end
	elseif self._pageId then
		HelpModel.instance:setTargetPageIndex(1)

		local pageCo = HelpConfig.instance:getHelpPageCo(self._pageId)

		table.insert(self._pagesCo, pageCo)
	end

	if #self._pagesCo < 1 then
		logError(string.format("help view(helpId : %s) not found can show pages", self._helpId))
		self:closeThis()

		return
	end

	self:setSelectItem()
	self:setHelpItem()
	self:setBtnItem()
	self:setBtnShow()
	self:_onlyShowLastGuideQuitBtn()
	NavigateMgr.instance:addEscape(ViewName.HelpView, self.closeThis, self)
	FightAudioMgr.instance:obscureBgm(true)
end

function HelpView:_onFinishGuideStep()
	self:closeThis()
end

function HelpView:_onlyShowLastGuideQuitBtn()
	if self.viewParam.guideId or self.viewParam.auto then
		for i, helpItem in ipairs(self._helpItems) do
			helpItem:showQuitBtn(i == #self._helpItems)
		end
	end
end

function HelpView:onOpenFinish()
	HelpModel.instance:setShowedHelp(self._helpId)
	HelpController.instance:dispatchEvent(HelpEvent.RefreshHelp)
end

function HelpView:setSelectItem()
	local path = self.viewContainer:getSetting().otherRes[1]

	for i = 1, #self._pagesCo do
		local child = self:getResInst(path, self._goslider, "HelpSelectItem")
		local selectItem = HelpSelectItem.New()

		selectItem:init({
			go = child,
			index = i,
			config = self._pagesCo[i],
			pos = 55 * (i - 0.5 * (#self._pagesCo + 1))
		})
		selectItem:updateItem()
		table.insert(self._selectItems, selectItem)
	end
end

function HelpView:setHelpItem()
	for i = 1, #self._pagesCo do
		if self._pagesCo[i].type == HelpEnum.HelpType.Normal then
			local path = self.viewContainer:getSetting().otherRes[2]
			local child = self:getResInst(path, self._gocontent, "HelpContentItem")
			local conItem = HelpContentItem.New()

			conItem:init({
				go = child,
				index = i,
				config = self._pagesCo[i],
				pos = self._space * (i - 1)
			})
			conItem:updateItem()
			table.insert(self._helpItems, conItem)
		elseif self._pagesCo[i].type == HelpEnum.HelpType.VersionActivity then
			local path = self.viewContainer:getSetting().otherRes[3]
			local child = self:getResInst(path, self._gocontent, "HelpVAContentItem")
			local conItem = HelpVersionActivityContentItem.New()

			conItem:init({
				go = child,
				index = i,
				config = self._pagesCo[i],
				pos = self._space * (i - 1)
			})
			conItem:updateItem()
			table.insert(self._helpItems, conItem)
		end
	end
end

function HelpView:setBtnItem()
	local index = HelpModel.instance:getTargetPageIndex()

	gohelper.setActive(self._btnright.gameObject, index < #self._pagesCo)
	gohelper.setActive(self._btnleft.gameObject, index > 1)
	gohelper.setActive(self._goscroll, #self._pagesCo > 1)
end

function HelpView:setBtnShow()
	local index = HelpModel.instance:getTargetPageIndex()
	local config = self._pagesCo[index]

	if config and not string.nilorempty(config.icon) then
		self.viewContainer:setBtnShow(false)
	else
		self.viewContainer:setBtnShow(true)
	end
end

function HelpView:selectHelpItem()
	for _, v in pairs(self._selectItems) do
		v:updateItem()
	end

	local x = (1 - HelpModel.instance:getTargetPageIndex()) * self._space

	ZProj.TweenHelper.DOAnchorPosX(self._gocontent.transform, x, 0.25)
	self:setBtnItem()
	self:setBtnShow()
end

function HelpView:onClickModalMask()
	HelpController.instance:dispatchEvent(HelpEvent.OnClickHelpViewMask)
end

function HelpView:onClose()
	self.removeEventCb(self, GuideController.instance, GuideEvent.FinishStep, self._onFinishGuideStep, self)
	FightAudioMgr.instance:obscureBgm(false)
end

function HelpView:onDestroyView()
	if self._selectItems then
		for _, v in pairs(self._selectItems) do
			v:destroy()
		end

		self._selectItems = nil
	end

	if self._helpItems then
		for _, v in pairs(self._helpItems) do
			v:destroy()
		end

		self._helpItems = nil
	end

	self._scroll:RemoveDragBeginListener()
	self._scroll:RemoveDragEndListener()
	self._viewClick:RemoveClickListener()
	self.removeEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self._onScreenResize, self)
end

return HelpView
