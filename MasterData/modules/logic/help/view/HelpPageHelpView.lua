-- chunkname: @modules/logic/help/view/HelpPageHelpView.lua

module("modules.logic.help.view.HelpPageHelpView", package.seeall)

local HelpPageHelpView = class("HelpPageHelpView", HelpView)

function HelpPageHelpView:onUpdateParam()
	return
end

function HelpPageHelpView:onOpen()
	if self.viewContainer then
		self.addEventCb(self, self.viewContainer, HelpEvent.UIPageTabSelectChange, self._onVoideFullScreenChange, self)
	end

	self._showParam = {}
end

function HelpPageHelpView:_refreshHelpPage()
	if self._helpItems then
		for _, v in pairs(self._helpItems) do
			v:destroy()
			gohelper.destroy(v._go)
		end
	end

	self._helpItems = {}

	self:_refreshView()
end

function HelpPageHelpView:setSelectItem()
	local path = self.viewContainer:getSetting().otherRes[1]

	for i = 1, #self._pagesCo do
		local selectItem = self._selectItems[i]
		local pos = 55 * (i - 0.5 * (#self._pagesCo + 1))

		if not selectItem then
			local child = self:getResInst(path, self._goslider, "HelpSelectItem")

			selectItem = HelpSelectItem.New()

			selectItem:init({
				go = child,
				index = i,
				config = self._pagesCo[i],
				pos = pos
			})

			selectItem._goTrs = child.transform

			table.insert(self._selectItems, selectItem)
		else
			transformhelper.setLocalPos(selectItem._goTrs, pos, 0, 0)
			gohelper.setActive(selectItem._go, true)
		end

		selectItem:updateItem()
	end

	for i = #self._pagesCo + 1, #self._selectItems do
		gohelper.setActive(self._selectItems[i]._go, false)
	end
end

function HelpPageHelpView:_onlyShowLastGuideQuitBtn()
	for i, helpItem in ipairs(self._helpItems) do
		helpItem:showQuitBtn(false)
	end
end

function HelpPageHelpView:_refreshView()
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

			table.insert(self._pagesCo, pageCo)
		end
	elseif self._pageId then
		HelpModel.instance:setTargetPageIndex(1)

		local pageCo = HelpConfig.instance:getHelpPageCo(self._pageId)

		table.insert(self._pagesCo, pageCo)
	end

	if #self._pagesCo < 1 then
		logError(string.format("help view(helpId : %s) not found can show pages", self._helpId))

		return
	end

	self:setSelectItem()
	self:setHelpItem()
	self:setBtnItem()
	self:_onlyShowLastGuideQuitBtn()
	NavigateMgr.instance:addEscape(ViewName.HelpView, self.closeThis, self)
	FightAudioMgr.instance:obscureBgm(true)
end

function HelpPageHelpView:_onVoideFullScreenChange(cfg)
	self:setPageTabCfg(cfg)
end

function HelpPageHelpView:setPageTabCfg(cfg)
	if cfg and cfg.showType == HelpEnum.PageTabShowType.HelpView and self._curShowHelpId ~= cfg.helpId then
		self._curShowHelpId = cfg.helpId
		self._showParam.id = cfg.helpId
		self.viewParam = self._showParam

		self:_refreshHelpPage()
	end
end

return HelpPageHelpView
