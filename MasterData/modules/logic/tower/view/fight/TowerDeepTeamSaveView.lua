-- chunkname: @modules/logic/tower/view/fight/TowerDeepTeamSaveView.lua

module("modules.logic.tower.view.fight.TowerDeepTeamSaveView", package.seeall)

local TowerDeepTeamSaveView = class("TowerDeepTeamSaveView", BaseView)

function TowerDeepTeamSaveView:onInitView()
	self._btncloseFullView = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_closeFullView")
	self._txttitle = gohelper.findChildText(self.viewGO, "title/#txt_title")
	self._scrolllist = gohelper.findChildScrollRect(self.viewGO, "#scroll_list")
	self._goteamContent = gohelper.findChild(self.viewGO, "#scroll_list/Viewport/#go_teamContent")
	self._goteamitem = gohelper.findChild(self.viewGO, "#scroll_list/Viewport/#go_teamContent/#go_teamitem")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TowerDeepTeamSaveView:addEvents()
	self._btncloseFullView:AddClickListener(self._btncloseFullViewOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self.addEventCb(self, TowerController.instance, TowerEvent.OnSaveTeamSuccess, self.onSaveTeamSuccess, self)
	self.addEventCb(self, TowerController.instance, TowerEvent.OnLoadTeamSuccess, self.onLoadTeamSuccess, self)
end

function TowerDeepTeamSaveView:removeEvents()
	self._btncloseFullView:RemoveClickListener()
	self._btnclose:RemoveClickListener()
	self.removeEventCb(self, TowerController.instance, TowerEvent.OnSaveTeamSuccess, self.onSaveTeamSuccess, self)
	self.removeEventCb(self, TowerController.instance, TowerEvent.OnLoadTeamSuccess, self.onLoadTeamSuccess, self)
end

function TowerDeepTeamSaveView:onTeamItemCoverClick(teamItem)
	if not teamItem.saveGroupMo then
		return
	end

	GameFacade.showOptionMessageBox(MessageBoxIdDefine.TowerDeepCoverCurSaveData, MsgBoxEnum.BoxType.Yes_No, MsgBoxEnum.optionType.Daily, function()
		TowerDeepRpc.instance:sendTowerDeepSaveArchiveRequest(teamItem.saveGroupMo.archiveId)
	end, nil, nil, self)
end

function TowerDeepTeamSaveView:onTeamItembtnLoadClick(teamItem)
	if not teamItem.saveGroupMo then
		return
	end

	GameFacade.showOptionMessageBox(MessageBoxIdDefine.TowerDeepLoadCurSaveData, MsgBoxEnum.BoxType.Yes_No, MsgBoxEnum.optionType.Daily, function()
		TowerDeepRpc.instance:sendTowerDeepLoadArchiveRequest(teamItem.saveGroupMo.archiveId)
	end)
end

function TowerDeepTeamSaveView:onTeamItembtnSaveClick(teamItem)
	TowerDeepRpc.instance:sendTowerDeepSaveArchiveRequest(teamItem.index)
end

function TowerDeepTeamSaveView:_btncloseFullViewOnClick()
	self:closeThis()
end

function TowerDeepTeamSaveView:_btncloseOnClick()
	self:closeThis()
end

function TowerDeepTeamSaveView:_editableInitView()
	self.teamItemMap = self:getUserDataTb_()

	gohelper.setActive(self._goteamitem, false)
end

function TowerDeepTeamSaveView:onUpdateParam()
	return
end

function TowerDeepTeamSaveView:onOpen()
	self.curOperateType = self.viewParam.teamOperateType
	self.teamSaveCount = TowerDeepConfig.instance:getConstConfigValue(TowerDeepEnum.ConstId.HeroGroupSaveCount)

	self:refreshUI()
end

function TowerDeepTeamSaveView:refreshUI()
	self._txttitle.text = self.curOperateType == TowerDeepEnum.TeamOperateType.Save and luaLang("TowerDeep_teamSave_save") or luaLang("TowerDeep_teamSave_load")

	self:createAndRefreshTeamsItem()
end

function TowerDeepTeamSaveView:createAndRefreshTeamsItem()
	self.saveDeepGroupMoMap = TowerPermanentDeepModel.instance:getSaveDeepGroupMoMap()

	for index = 1, self.teamSaveCount do
		local teamItem = self.teamItemMap[index]

		if not teamItem then
			teamItem = {
				index = index,
				go = gohelper.clone(self._goteamitem, self._goteamContent, "teamItem" .. index)
			}
			teamItem.goTeamInfo = gohelper.findChild(teamItem.go, "go_teamInfo")
			teamItem.imageDeepBg = gohelper.findChildImage(teamItem.goTeamInfo, "depth/image_deepBg")
			teamItem.txtDepth = gohelper.findChildText(teamItem.goTeamInfo, "depth/txt_depth")
			teamItem.txtRound = gohelper.findChildText(teamItem.goTeamInfo, "round/txt_round")
			teamItem.txtSaveTime = gohelper.findChildText(teamItem.goTeamInfo, "time/txt_saveTime")
			teamItem.goHeroContent = gohelper.findChild(teamItem.goTeamInfo, "go_heroContent")
			teamItem.goHeroItem = gohelper.findChild(teamItem.goTeamInfo, "go_heroContent/go_heroItem")
			teamItem.btnCover = gohelper.findChildButtonWithAudio(teamItem.goTeamInfo, "btn_cover")

			teamItem.btnCover:AddClickListener(self.onTeamItemCoverClick, self, teamItem)

			teamItem.btnLoad = gohelper.findChildButtonWithAudio(teamItem.goTeamInfo, "btn_load")

			teamItem.btnLoad:AddClickListener(self.onTeamItembtnLoadClick, self, teamItem)

			teamItem.goEmptySave = gohelper.findChild(teamItem.go, "go_emptySave")
			teamItem.btnEmptySave = gohelper.findChildButtonWithAudio(teamItem.goEmptySave, "btn_save")

			teamItem.btnEmptySave:AddClickListener(self.onTeamItembtnSaveClick, self, teamItem)

			teamItem.goEmptyLoad = gohelper.findChild(teamItem.go, "go_emptyLoad")
			teamItem.gorefreshAnim = gohelper.findChild(teamItem.go, "ani_refresh")
			teamItem.heroItemList = {}
			self.teamItemMap[index] = teamItem
		end

		gohelper.setActive(teamItem.gorefreshAnim, false)
		gohelper.setActive(teamItem.go, true)

		teamItem.saveGroupMo = self.saveDeepGroupMoMap[teamItem.index]

		gohelper.setActive(teamItem.goTeamInfo, teamItem.saveGroupMo)
		gohelper.setActive(teamItem.goEmptyLoad, not teamItem.saveGroupMo and self.curOperateType == TowerDeepEnum.TeamOperateType.Load)
		gohelper.setActive(teamItem.goEmptySave, not teamItem.saveGroupMo and self.curOperateType == TowerDeepEnum.TeamOperateType.Save)
		gohelper.setActive(teamItem.btnCover.gameObject, teamItem.saveGroupMo and self.curOperateType == TowerDeepEnum.TeamOperateType.Save)
		gohelper.setActive(teamItem.btnLoad.gameObject, teamItem.saveGroupMo and self.curOperateType == TowerDeepEnum.TeamOperateType.Load)

		if teamItem.saveGroupMo then
			local deepRare = TowerPermanentDeepModel.instance:getDeepRare(teamItem.saveGroupMo.curDeep)

			UISpriteSetMgr.instance:setFightTowerSprite(teamItem.imageDeepBg, "fight_tower_numbg_" .. deepRare)

			teamItem.txtDepth.text = string.format("%sM", teamItem.saveGroupMo.curDeep)

			local teamDataList = teamItem.saveGroupMo:getTeamDataList()

			teamItem.txtRound.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("TowerDeep_teamSave_round"), GameUtil.getNum2Chinese(#teamDataList))
			teamItem.txtSaveTime.text = os.date("%Y.%m.%d %H:%M:%S", teamItem.saveGroupMo.createTime)

			self:createHeroItem(teamItem)
		end
	end
end

function TowerDeepTeamSaveView:createHeroItem(teamItem)
	local allHeroDataList = teamItem.saveGroupMo:getAllHeroData()

	gohelper.setActive(teamItem.goHeroItem, false)

	for index, heroData in ipairs(allHeroDataList) do
		local heroItem = teamItem.heroItemList[index]

		if not heroItem then
			heroItem = {
				go = gohelper.clone(teamItem.goHeroItem, teamItem.goHeroContent, "heroItem" .. index)
			}
			heroItem.simageRole = gohelper.findChildSingleImage(heroItem.go, "simage_role")
			teamItem.heroItemList[index] = heroItem
		end

		gohelper.setActive(heroItem.go, true)

		local skinId = 0

		if heroData.trialId and heroData.trialId > 0 then
			local trialConfig = lua_hero_trial.configDict[heroData.trialId][0]

			skinId = trialConfig.skin
		elseif heroData.heroId and heroData.heroId > 0 then
			local heroConfig = HeroConfig.instance:getHeroCO(heroData.heroId)

			skinId = heroConfig.skinId
		end

		local skinConfig = SkinConfig.instance:getSkinCo(skinId)

		heroItem.simageRole:LoadImage(ResUrl.getHeadIconSmall(skinConfig.retangleIcon))
	end

	for index = #allHeroDataList + 1, #teamItem.heroItemList do
		local heroItem = teamItem.heroItemList[index]

		if heroItem then
			gohelper.setActive(heroItem.go, false)
		end
	end
end

function TowerDeepTeamSaveView:onSaveTeamSuccess(archiveInfo)
	self:createAndRefreshTeamsItem()

	local index = archiveInfo.archiveNo
	local teamItem = self.teamItemMap[index]

	if teamItem then
		gohelper.setActive(teamItem.gorefreshAnim, false)
		gohelper.setActive(teamItem.gorefreshAnim, true)
	end
end

function TowerDeepTeamSaveView:onLoadTeamSuccess(archiveInfo)
	self:createAndRefreshTeamsItem()
	GameFacade.showToast(ToastEnum.TowerDeepLoadDataSuccess)
	self:closeThis()
end

function TowerDeepTeamSaveView:onClose()
	return
end

function TowerDeepTeamSaveView:onDestroyView()
	for _, teamItem in pairs(self.teamItemMap) do
		for _, heroItem in ipairs(teamItem.heroItemList) do
			heroItem.simageRole:UnLoadImage()
		end

		teamItem.btnCover:RemoveClickListener()
		teamItem.btnLoad:RemoveClickListener()
		teamItem.btnEmptySave:RemoveClickListener()
	end
end

return TowerDeepTeamSaveView
