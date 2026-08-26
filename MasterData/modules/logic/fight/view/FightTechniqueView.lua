-- chunkname: @modules/logic/fight/view/FightTechniqueView.lua

module("modules.logic.fight.view.FightTechniqueView", package.seeall)

local FightTechniqueView = class("FightTechniqueView", BaseView)

function FightTechniqueView:onInitView()
	self._golefttop = gohelper.findChild(self.viewGO, "#go_lefttop")
	self._gocategorycontent = gohelper.findChild(self.viewGO, "left/scroll_category/viewport/#go_categorycontent")
	self._gostorecategoryitem = gohelper.findChild(self.viewGO, "left/scroll_category/viewport/#go_categorycontent/#go_storecategoryitem")
	self._gocenter = gohelper.findChild(self.viewGO, "#go_center")
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "#go_center/#simage_icon")
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function FightTechniqueView:addEvents()
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, self._onOpenView, self)
end

function FightTechniqueView:removeEvents()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, self._onOpenView, self)
end

function FightTechniqueView:_onOpenView(viewName)
	if viewName == ViewName.GuideView then
		self:closeThis()
	end
end

function FightTechniqueView:_editableInitView()
	self._simagebg:LoadImage(ResUrl.getTechniqueBg("banner_di"))
end

function FightTechniqueView:onUpdateParam()
	if self.viewParam then
		local defaultConfigId = self.viewParam.defaultShowId

		if defaultConfigId then
			local defaultShowConfig = lua_fight_technique.configDict[defaultConfigId]

			if defaultShowConfig then
				local defaultMainIndex = defaultShowConfig.mainTitleId
				local defaultSubIndex = tabletool.indexOf(self.btn_data_list[defaultMainIndex], defaultShowConfig)

				if self.cur_select_main_index == defaultMainIndex then
					self.cur_select_sub_index = nil

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

function FightTechniqueView:onOpen()
	self.btn_data_list = {}

	if self.viewParam then
		if not self.viewParam.isGMShowAll then
			local isGMShowAll = false

			if self.viewParam then
				local defaultConfigId = self.viewParam.defaultShowId
				local temp_tab = {}
				local defaultShowConfig

				for _, config in ipairs(lua_fight_technique.configList) do
					if config.mainTitleId ~= 0 then
						temp_tab[config.mainTitleId] = temp_tab[config.mainTitleId] or {}

						if self:checkIsNeedShowTechnique(config, isGMShowAll) then
							table.insert(temp_tab[config.mainTitleId], config)

							if defaultConfigId == config.id then
								defaultShowConfig = config
							end
						end
					end
				end

				for k, _ in pairs(temp_tab) do
					table.sort(temp_tab[k], FightTechniqueView.sortSubTechniqueConfig)

					if #temp_tab[k] > 0 then
						table.insert(self.btn_data_list, temp_tab[k])
					end
				end

				table.sort(self.btn_data_list, FightTechniqueView.sortTechniqueConfig)

				self.btn_list = self:getUserDataTb_()
				self.sub_btn_height = {}
				self.btn_sub_list = self:getUserDataTb_()

				gohelper.CreateObjList(self, self._onBtnShow, self.btn_data_list, self._gocategorycontent, self._gostorecategoryitem)

				if #self.btn_data_list > 0 then
					local defaultMainIndex = 1
					local defaultSubIndex = 1

					if defaultShowConfig then
						defaultMainIndex = defaultShowConfig.mainTitleId
						defaultSubIndex = tabletool.indexOf(self.btn_data_list[defaultShowConfig.mainTitleId], defaultShowConfig)

						self:_onBtnClick({
							index = defaultShowConfig.mainTitleId,
							subIndex = defaultSubIndex
						})
					else
						recthelper.setHeight(self.btn_list[1].transform, 130)
						recthelper.setHeight(self.btn_list[1].transform:Find("go_childcategory").transform, 0)

						self.cur_select_main_index = defaultMainIndex
						self.cur_select_sub_index = nil

						self:_detectBtnState()
						self:_onSubBtnClick(defaultSubIndex)
						gohelper.setActive(self.btn_list[1].transform:Find("go_line").gameObject, false)
						self:_btn_tween_open_end()

						self.cur_select_main_index = nil
					end
				end

				FightAudioMgr.instance:obscureBgm(true)
			end
		end
	end
end

function FightTechniqueView:checkIsNeedShowTechnique(techniqueCo, isGMShowAll)
	if techniqueCo then
		local episode_config = DungeonConfig.instance:getEpisodeCO(DungeonModel.instance.curSendEpisodeId)
		local canShowEpisodeType, notShowEpisodeType = true, false

		if not string.nilorempty(techniqueCo.displayType) then
			canShowEpisodeType = self:checkCurEpisodeTypeIsMatch(techniqueCo.displayType)
		end

		local isMatchEpisodeCondition = canShowEpisodeType and not ((not string.nilorempty(techniqueCo.noDisplayType) or nil) and self:checkCurEpisodeTypeIsMatch(techniqueCo.noDisplayType))
		local isMatchOtherCondition = isGMShowAll or string.nilorempty(techniqueCo.condition) or FightViewTechniqueModel.instance:isUnlock(techniqueCo.id)

		return isMatchEpisodeCondition and isMatchOtherCondition
	end
end

function FightTechniqueView:checkCurEpisodeTypeIsMatch(episodeTypeStr)
	local episode_config = DungeonConfig.instance:getEpisodeCO(DungeonModel.instance.curSendEpisodeId)
	local curEpisodeType = episode_config and episode_config.type
	local episodeTypes = string.split(episodeTypeStr, "#")

	if episodeTypes then
		for _, episodeType in ipairs(episodeTypes) do
			if tonumber(episodeType) == curEpisodeType then
				return true
			end
		end
	end

	return false
end

function FightTechniqueView:_onBtnShow(obj, data, index)
	local transform = obj.transform
	local clickArea = gohelper.getClickWithAudio(transform:Find("clickArea").gameObject, AudioEnum.UI.UI_transverse_tabs_click)
	local txt_itemcn1 = transform:Find("go_unselected/txt_itemcn1"):GetComponent(gohelper.Type_TextMesh)
	local txt_itemen1 = transform:Find("go_unselected/txt_itemen1"):GetComponent(gohelper.Type_TextMesh)
	local txt_itemcn2 = transform:Find("go_selected/txt_itemcn2"):GetComponent(gohelper.Type_TextMesh)
	local txt_itemen2 = transform:Find("go_selected/txt_itemen2"):GetComponent(gohelper.Type_TextMesh)

	txt_itemcn1.text = data[1].mainTitle_cn
	txt_itemen1.text = data[1].mainTitle_en
	txt_itemcn2.text = data[1].mainTitle_cn
	txt_itemen2.text = data[1].mainTitle_en
	self.sub_belong_index = index
	self.sub_btn_pos_y = -60

	gohelper.CreateObjList(self, self._onSubBtnShow, data, transform:Find("go_childcategory").gameObject, transform:Find("go_childcategory/go_childitem").gameObject)

	self.sub_btn_height[index] = math.abs(self.sub_btn_pos_y + 70)

	table.insert(self.btn_list, obj)
	self:removeClickCb(clickArea)
	self.addClickCb(self, clickArea, self._onBtnClick, self, {
		index = index
	})
end

function FightTechniqueView:_onBtnClick(param)
	local index = param.index

	if not param.subIndex then
		if self.cur_select_main_index == index then
			if self._btn_ani then
				ZProj.TweenHelper.KillById(self._btn_ani)
			end

			self._btn_ani = ZProj.TweenHelper.DOTweenFloat(1, 0, 0.3, self._onBtnAniFrameCallback, self._btn_tween_end, self)

			return
		end

		if self.cur_select_main_index then
			recthelper.setHeight(self.btn_list[self.cur_select_main_index].transform, 130)
			recthelper.setHeight(self.btn_list[self.cur_select_main_index].transform:Find("go_childcategory").transform, 0)
		end

		self.cur_select_main_index = index
		self.cur_select_sub_index = nil

		self:_detectBtnState()
		self:_onSubBtnClick(param.subIndex)

		if self._btn_ani then
			ZProj.TweenHelper.KillById(self._btn_ani)
		end

		gohelper.setActive(self.btn_list[self.cur_select_main_index].transform:Find("go_line").gameObject, true)

		self._btn_ani = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.3, self._onBtnAniFrameCallback, self._btn_tween_open_end, self)
	end
end

function FightTechniqueView:_onBtnAniFrameCallback(value)
	recthelper.setHeight(self.btn_list[self.cur_select_main_index].transform, 130 + self.sub_btn_height[self.cur_select_main_index] * value)
	recthelper.setHeight(self.btn_list[self.cur_select_main_index].transform:Find("go_childcategory").transform, self.sub_btn_height[self.cur_select_main_index] * value)
end

function FightTechniqueView:scrollItemIsVisible(scroll_view, target_obj)
	local target_pos_y = scroll_view.transform:InverseTransformPoint(target_obj.transform.position).y + recthelper.getHeight(target_obj.transform) / 2

	if target_pos_y >= 65 or target_pos_y <= -785 then
		recthelper.setAnchorY(self._gocategorycontent.transform, 130 * (self.cur_select_main_index - 1) - 60)
	end
end

function FightTechniqueView:_btn_tween_open_end()
	self:scrollItemIsVisible(gohelper.findChild(self.viewGO, "left/scroll_category"), self.btn_list[self.cur_select_main_index])
end

function FightTechniqueView:_btn_tween_end()
	gohelper.setActive(self.btn_list[self.cur_select_main_index].transform:Find("go_line").gameObject, false)

	self.cur_select_main_index = nil
end

function FightTechniqueView:_detectBtnState()
	if self.btn_list then
		for i, v in ipairs(self.btn_list) do
			local select = v == self.btn_list[self.cur_select_main_index]
			local transform = v.transform

			gohelper.setActive(transform:Find("go_line").gameObject, select)
			gohelper.setActive(transform:Find("go_unselected").gameObject, not select)
			gohelper.setActive(transform:Find("go_selected").gameObject, select)
			gohelper.setActive(transform:Find("go_childcategory").gameObject, select)
		end
	end
end

function FightTechniqueView:_onSubBtnShow(obj, data, index)
	local transform = obj.transform

	recthelper.setAnchorY(transform, self.sub_btn_pos_y)

	self.sub_btn_pos_y = self.sub_btn_pos_y - 110

	local clickArea = gohelper.getClickWithAudio(transform:Find("clickArea").gameObject, AudioEnum.UI.UI_transverse_tabs_click)
	local txt_itemcn1 = transform:Find("go_unselected/txt_itemcn1"):GetComponent(gohelper.Type_TextMesh)
	local txt_itemen1 = transform:Find("go_unselected/txt_itemen1"):GetComponent(gohelper.Type_TextMesh)
	local txt_itemcn2 = transform:Find("go_selected/txt_itemcn2"):GetComponent(gohelper.Type_TextMesh)
	local txt_itemen2 = transform:Find("go_selected/txt_itemen2"):GetComponent(gohelper.Type_TextMesh)

	txt_itemcn1.text = data.title_cn
	txt_itemen1.text = data.title_en
	txt_itemcn2.text = data.title_cn
	txt_itemen2.text = data.title_en
	self.btn_sub_list[self.sub_belong_index] = self.btn_sub_list[self.sub_belong_index] or {}

	table.insert(self.btn_sub_list[self.sub_belong_index], obj)
	self:removeClickCb(clickArea)
	self.addClickCb(self, clickArea, self._onSubBtnClick, self, index)
end

function FightTechniqueView:_onSubBtnClick(index)
	if self.cur_select_sub_index == index then
		return
	end

	self.cur_select_sub_index = index
	self.cur_select_data = self.btn_data_list[self.cur_select_main_index][index]

	self:_detectSubBtnState()
	self:_refreshContentData()
end

function FightTechniqueView:_detectSubBtnState()
	if self.btn_sub_list then
		for i, v in ipairs(self.btn_sub_list[self.cur_select_main_index]) do
			local select = v == self.btn_sub_list[self.cur_select_main_index][self.cur_select_sub_index]
			local transform = v.transform

			gohelper.setActive(transform:Find("go_unselected").gameObject, not select)
			gohelper.setActive(transform:Find("go_selected").gameObject, select)
		end
	end
end

function FightTechniqueView.sortTechniqueConfig(item1, item2)
	return item1[1].mainTitleId < item2[1].mainTitleId
end

function FightTechniqueView.sortSubTechniqueConfig(item1, item2)
	return item1.subTitleId < item2.subTitleId
end

function FightTechniqueView:_refreshContentData()
	if self.viewParam then
		if not self.viewParam.isGMShowAll then
			local isGMShowAll = false

			if not isGMShowAll then
				FightViewTechniqueModel.instance:readTechnique(self.cur_select_data.id)
			end

			self._simageicon:LoadImage(ResUrl.getTechniqueLangIcon(self.cur_select_data.picture1, self.cur_select_data.isCn == 1))

			local string_list = string.split(self.cur_select_data.content1, "|")

			for k, v in pairs(lua_fight_technique.configDict) do
				local obj = gohelper.findChild(self.viewGO, "#go_center/content/" .. v.id)

				if obj then
					gohelper.setActive(obj, v.id == self.cur_select_data.id)

					if self.cur_select_data.id == v.id then
						for i, str in ipairs(string_list) do
							str = string.gsub(str, "%{", string.format("<color=%s>", "#ff906a"))
							str = string.gsub(str, "%}", "</color>")
							gohelper.findChildTextMesh(obj, "txt_" .. i).text = str
						end
					end
				end
			end
		end
	end
end

function FightTechniqueView:onClose()
	if self._btn_ani then
		ZProj.TweenHelper.KillById(self._btn_ani)
	end

	FightAudioMgr.instance:obscureBgm(false)
end

function FightTechniqueView:onDestroyView()
	self._simageicon:UnLoadImage()
	self._simagebg:UnLoadImage()
end

return FightTechniqueView
