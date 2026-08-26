-- chunkname: @modules/logic/help/view/HelpPageTabView.lua

module("modules.logic.help.view.HelpPageTabView", package.seeall)

local HelpPageTabView = class("HelpPageTabView", BaseView)

function HelpPageTabView:onInitView()
	self._golefttop = gohelper.findChild(self.viewGO, "#go_lefttop")
	self._govoidepage = gohelper.findChild(self.viewGO, "#go_voidepage")
	self._gohelpview = gohelper.findChild(self.viewGO, "#go_helpview")
	self._gocategorycontent = gohelper.findChild(self.viewGO, "left/scroll_category/viewport/#go_categorycontent")
	self._gostorecategoryitem = gohelper.findChild(self.viewGO, "left/scroll_category/viewport/#go_categorycontent/#go_storecategoryitem")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function HelpPageTabView:addEvents()
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, self._onOpenView, self)
end

function HelpPageTabView:removeEvents()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, self._onOpenView, self)
end

function HelpPageTabView:_onOpenView(viewName)
	if viewName == ViewName.GuideView then
		self:closeThis()
	end
end

function HelpPageTabView:_editableInitView()
	self._goleft = gohelper.findChild(self.viewGO, "left")
end

function HelpPageTabView:setVideoFullScreen(isfull)
	local isShow = isfull ~= true

	gohelper.setActive(self._goleft, isShow)
	gohelper.setActive(self._golefttop, isShow)
	gohelper.setActive(self._gobtns, isShow)
end

function HelpPageTabView:onUpdateParam()
	if self.viewParam then
		local defaultConfigId = self.viewParam.defaultShowId

		if defaultConfigId then
			local defaultShowConfig = lua_help_page_tab.configDict[defaultConfigId]

			if defaultShowConfig then
				local defaultMainIndex = defaultShowConfig.mainTitleId
				local defaultSubIndex = tabletool.indexOf(self._tagDataList[defaultMainIndex], defaultShowConfig)

				if self._curSelectMainIndex == defaultMainIndex then
					self._curSelectSubIndex = nil

					self:_onSubBtnClick(defaultSubIndex)
					self:_btn_tween_open_end()
				else
					self:_onBtnClick({
						index = defaultMainIndex,
						subIndex = defaultSubIndex
					})
				end
			end
		end
	end
end

function HelpPageTabView:onOpen()
	if self.viewContainer then
		self.addEventCb(self, self.viewContainer, HelpEvent.UIPageTabSelectChange, self._onVoideFullScreenChange, self)
		NavigateMgr.instance:addEscape(self.viewContainer.viewName, self.closeThis, self)
	end

	self:setPageTabCfg(nil)
end

function HelpPageTabView:onOpenFinish()
	self._tagDataList = {}

	if self.viewParam then
		if not self.viewParam.isGMShowAll then
			local isGMShowAll = false

			if self.viewParam then
				local defaultConfigId = self.viewParam.defaultShowId

				self._matchGuideId = nil
				self._matchAllPage = false

				if self.viewParam and self.viewParam.guideId then
					self._matchGuideId = tonumber(self.viewParam.guideId)
					self._matchAllPage = self.viewParam.matchAllPage
				end

				local temp_tab = {}
				local defaultShowConfig

				for _, config in ipairs(lua_help_page_tab.configList) do
					if config.parentId ~= 0 and self:checkIsNeedShowPageTabCfg(config, isGMShowAll) then
						if not temp_tab[config.parentId] then
							if not lua_help_page_tab.configDict[config.parentId] then
								temp_tab[config.parentId] = {
									id = lua_help_page_tab.configDict[config.parentId].id,
									sortIdx = lua_help_page_tab.configDict[config.parentId].sortIdx,
									config = lua_help_page_tab.configDict[config.parentId],
									childCfgList = {}
								}
							end
						end

						table.insert(temp_tab[config.parentId].childCfgList, config)

						if defaultConfigId == config.id then
							defaultShowConfig = config
						end
					end
				end

				for k, _ in pairs(temp_tab) do
					table.sort(temp_tab[k].childCfgList, HelpPageTabView._sortSubConfig)
					table.insert(self._tagDataList, temp_tab[k])
				end

				table.sort(self._tagDataList, HelpPageTabView._sortConfig)

				self._mainBtnTbList = self:getUserDataTb_()
				self._subBtnHeightList = {}
				self._subBtnTbList = self:getUserDataTb_()

				gohelper.CreateObjList(self, self._onMainBtnShow, self._tagDataList, self._gocategorycontent, self._gostorecategoryitem)

				if #self._tagDataList > 0 then
					local defaultMainIndex = 1
					local defaultSubIndex = 1

					if defaultShowConfig then
						defaultMainIndex = defaultShowConfig.mainTitleId
						defaultSubIndex = tabletool.indexOf(self._tagDataList[defaultShowConfig.mainTitleId], defaultShowConfig)

						self:_onBtnClick({
							index = defaultShowConfig.mainTitleId,
							subIndex = defaultSubIndex
						})
					else
						recthelper.setHeight(self._mainBtnTbList[1].transform, 130)
						recthelper.setHeight(self._mainBtnTbList[1].go_childcategoryTrs, 0)

						self._curSelectMainIndex = defaultMainIndex
						self._curSelectSubIndex = nil

						self:_refreshMainBtnState()
						self:_onSubBtnClick(defaultSubIndex)
						gohelper.setActive(self._mainBtnTbList[1].go_line, false)
						self:_btn_tween_open_end()

						self._curSelectMainIndex = nil
					end
				end
			end
		end
	end
end

function HelpPageTabView:_onVoideFullScreenChange(cfg)
	self:setPageTabCfg(cfg)
end

function HelpPageTabView:setPageTabCfg(cfg)
	if cfg then
		if not cfg.showType then
			local showType = -1

			gohelper.setActive(self._govoidepage, showType == HelpEnum.PageTabShowType.Video)
			gohelper.setActive(self._gohelpview, showType == HelpEnum.PageTabShowType.HelpView)
		end
	end
end

function HelpPageTabView:checkIsNeedShowPageTabCfg(pageTabCfg, isGMShowAll)
	local showType = pageTabCfg and pageTabCfg.showType
	local helpId = pageTabCfg and pageTabCfg.helpId

	if showType == HelpEnum.PageTabShowType.HelpView then
		return self:_checkHelpViewByHelpId(helpId)
	elseif showType == HelpEnum.PageTabShowType.Video then
		return self:_checkHelpVideoById(helpId)
	end

	return false
end

function HelpPageTabView:_checkHelpViewByHelpId(helpId)
	local helpCfg = HelpConfig.instance:getHelpCO(helpId)

	if not helpCfg or string.nilorempty(helpCfg.page) then
		logError("请检查帮助说明配置" .. tostring(helpId) .. "相关配置是否完整！")

		return false
	end

	local pageIdList = string.split(helpCfg.page, "#")

	if #pageIdList < 1 then
		logError("请检查帮助界面" .. tostring(helpId) .. "相关配置是否完整！")

		return false
	end

	for i = 1, #pageIdList do
		local pageCfg = HelpConfig.instance:getHelpPageCo(tonumber(pageIdList[i]))

		if self.viewContainer:checkHelpPageCfg(pageCfg, self._matchAllPage, self._matchGuideId) then
			return true
		end
	end

	return false
end

function HelpPageTabView:_checkHelpVideoById(videoId)
	local videoCfg = HelpConfig.instance:getHelpVideoCO(videoId)

	if not videoCfg or string.nilorempty(videoCfg.videopath) then
		logError("请检查【export_帮助视频】" .. tostring(videoId) .. "相关配置是否完整！")

		return false
	end

	return self.viewContainer:checkHelpVideoCfg(videoCfg, self._matchAllPage, self._matchGuideId)
end

function HelpPageTabView:_onMainBtnShow(obj, data, index)
	local tb = self:getUserDataTb_()
	local transform = obj.transform

	tb.gameObject = obj
	tb.go = obj
	tb.goTrs = transform
	tb.transform = transform
	tb.index = index
	tb.data = data

	local config = data.config

	tb.go_selected = gohelper.findChild(obj, "go_selected")
	tb.go_unselected = gohelper.findChild(obj, "go_unselected")
	tb.go_childcategory = gohelper.findChild(obj, "go_childcategory")
	tb.go_childitem = gohelper.findChild(obj, "go_childcategory/go_childitem")
	tb.go_line = gohelper.findChild(obj, "go_line")
	tb.go_lineTrs = tb.go_line.transform
	tb.go_childcategoryTrs = tb.go_childcategory.transform

	local goclickArea = gohelper.findChild(obj, "clickArea")
	local clickArea = gohelper.getClickWithAudio(goclickArea, AudioEnum.UI.UI_transverse_tabs_click)
	local txt_itemcn1 = gohelper.findChildText(obj, "go_unselected/txt_itemcn1")
	local txt_itemen1 = gohelper.findChildText(obj, "go_unselected/txt_itemen1")
	local txt_itemcn2 = gohelper.findChildText(obj, "go_selected/txt_itemcn2")
	local txt_itemen2 = gohelper.findChildText(obj, "go_selected/txt_itemen2")

	txt_itemcn1.text = config.title
	txt_itemen1.text = config.title_en
	txt_itemcn2.text = config.title
	txt_itemen2.text = config.title_en
	self._subBelongIndex = index
	self._subBtnPosY = -60

	gohelper.CreateObjList(self, self._onSubBtnShow, data.childCfgList, tb.go_childcategory, tb.go_childitem)

	self._subBtnHeightList[index] = math.abs(self._subBtnPosY + 70)

	table.insert(self._mainBtnTbList, tb)
	self:removeClickCb(clickArea)
	self.addClickCb(self, clickArea, self._onBtnClick, self, tb)
end

function HelpPageTabView:_onBtnClick(param)
	local index = param.index

	if not param.subIndex then
		if self._curSelectMainIndex == index then
			if self._btnAniTweenId then
				ZProj.TweenHelper.KillById(self._btnAniTweenId)
			end

			self._btnAniTweenId = ZProj.TweenHelper.DOTweenFloat(1, 0, 0.3, self._onBtnAniFrameCallback, self._btn_tween_end, self)

			return
		end

		if self._curSelectMainIndex then
			recthelper.setHeight(self._mainBtnTbList[self._curSelectMainIndex].transform, 130)
			recthelper.setHeight(self._mainBtnTbList[self._curSelectMainIndex].go_childcategoryTrs, 0)
		end

		self._curSelectMainIndex = index
		self._curSelectSubIndex = nil

		self:_refreshMainBtnState()
		self:_onSubBtnClick(param.subIndex)

		if self._btnAniTweenId then
			ZProj.TweenHelper.KillById(self._btnAniTweenId)
		end

		gohelper.setActive(self._mainBtnTbList[self._curSelectMainIndex].go_line, true)

		self._btnAniTweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.3, self._onBtnAniFrameCallback, self._btn_tween_open_end, self)
	end
end

function HelpPageTabView:_onBtnAniFrameCallback(value)
	recthelper.setHeight(self._mainBtnTbList[self._curSelectMainIndex].transform, 130 + self._subBtnHeightList[self._curSelectMainIndex] * value)
	recthelper.setHeight(self._mainBtnTbList[self._curSelectMainIndex].go_childcategoryTrs, self._subBtnHeightList[self._curSelectMainIndex] * value)
end

function HelpPageTabView:scrollItemIsVisible(scroll_view, target_obj)
	local target_pos_y = scroll_view.transform:InverseTransformPoint(target_obj.transform.position).y + recthelper.getHeight(target_obj.transform) / 2

	if target_pos_y >= 65 or target_pos_y <= -785 then
		recthelper.setAnchorY(self._gocategorycontent.transform, 130 * (self._curSelectMainIndex - 1) - 60)
	end
end

function HelpPageTabView:_btn_tween_open_end()
	self:scrollItemIsVisible(gohelper.findChild(self.viewGO, "left/scroll_category"), self._mainBtnTbList[self._curSelectMainIndex])
end

function HelpPageTabView:_btn_tween_end()
	gohelper.setActive(self._mainBtnTbList[self._curSelectMainIndex].go_line, false)

	self._curSelectMainIndex = nil
end

function HelpPageTabView:_refreshMainBtnState()
	if self._mainBtnTbList then
		local selectTb = self._mainBtnTbList[self._curSelectMainIndex]

		for i, tb in ipairs(self._mainBtnTbList) do
			local select = tb == selectTb

			gohelper.setActive(tb.go_line, select)
			gohelper.setActive(tb.go_unselected, not select)
			gohelper.setActive(tb.go_selected, select)
			gohelper.setActive(tb.go_childcategory, select)
		end
	end
end

function HelpPageTabView:_onSubBtnShow(obj, data, index)
	local tb = self:getUserDataTb_()
	local transform = obj.transform

	tb.gameObject = obj
	tb.go = obj
	tb.transform = transform
	tb.goTrs = transform
	tb.data = data
	tb.index = index
	tb.go_selected = gohelper.findChild(obj, "go_selected")
	tb.go_unselected = gohelper.findChild(obj, "go_unselected")

	recthelper.setAnchorY(transform, self._subBtnPosY)

	self._subBtnPosY = self._subBtnPosY - 110

	local goclickArea = gohelper.findChild(obj, "clickArea")
	local clickArea = gohelper.getClickWithAudio(goclickArea, AudioEnum.UI.UI_transverse_tabs_click)
	local txt_itemcn1 = gohelper.findChildText(obj, "go_unselected/txt_itemcn1")
	local txt_itemen1 = gohelper.findChildText(obj, "go_unselected/txt_itemen1")
	local txt_itemcn2 = gohelper.findChildText(obj, "go_selected/txt_itemcn2")
	local txt_itemen2 = gohelper.findChildText(obj, "go_selected/txt_itemen2")

	txt_itemcn1.text = data.title
	txt_itemen1.text = data.title_en
	txt_itemcn2.text = data.title
	txt_itemen2.text = data.title_en
	self._subBtnTbList[self._subBelongIndex] = self._subBtnTbList[self._subBelongIndex] or {}

	table.insert(self._subBtnTbList[self._subBelongIndex], tb)
	self:removeClickCb(clickArea)
	self.addClickCb(self, clickArea, self._onSubBtnClick, self, index)
end

function HelpPageTabView:_onSubBtnClick(index)
	if self._curSelectSubIndex == index then
		return
	end

	self._curSelectSubIndex = index
	self._curSelectSubData = self._tagDataList[self._curSelectMainIndex].childCfgList[index]

	self:_refreshSubBtnState()

	if self.viewContainer then
		self.viewContainer:dispatchEvent(HelpEvent.UIPageTabSelectChange, self._curSelectSubData)
	end
end

function HelpPageTabView:_refreshSubBtnState()
	if self._subBtnTbList then
		local tbList = self._subBtnTbList[self._curSelectMainIndex]
		local selectTb = tbList[self._curSelectSubIndex]

		for i, tb in ipairs(tbList) do
			local select = tb == selectTb

			gohelper.setActive(tb.go_unselected, not select)
			gohelper.setActive(tb.go_selected, select)
		end
	end
end

function HelpPageTabView._sortConfig(a, b)
	return HelpPageTabView._sortSubConfig(a, b)
end

function HelpPageTabView._sortSubConfig(a, b)
	if a.sortIdx ~= b.sortIdx then
		return a.sortIdx < b.sortIdx
	end

	if a.id ~= b.id then
		return a.id < b.id
	end
end

function HelpPageTabView:onClose()
	if self._btnAniTweenId then
		ZProj.TweenHelper.KillById(self._btnAniTweenId)
	end
end

function HelpPageTabView:onDestroyView()
	return
end

return HelpPageTabView
