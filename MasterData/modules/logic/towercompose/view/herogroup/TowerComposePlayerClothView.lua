-- chunkname: @modules/logic/towercompose/view/herogroup/TowerComposePlayerClothView.lua

module("modules.logic.towercompose.view.herogroup.TowerComposePlayerClothView", package.seeall)

local TowerComposePlayerClothView = class("TowerComposePlayerClothView", PlayerClothView)

function TowerComposePlayerClothView:onOpen()
	if self.viewParam then
		self._curGroupModel = self.viewParam.groupModel or HeroGroupModel.instance
	end

	if self.viewParam then
		self._useCallback = self.viewParam.useCallback or nil
	end

	if self.viewParam then
		self._useCallbackObj = self.viewParam.useCallbackObj or nil
	end

	self.themeId = self.viewParam and self.viewParam.themeId
	self.curPlaneId = self.viewParam and self.viewParam.planeId
	self.towerEpisodeConfig = self.viewParam and self.viewParam.towerEpisodeConfig

	PlayerClothListViewModel.instance:setGroupModel(self._curGroupModel)
	HeroGroupController.instance:registerCallback(HeroGroupEvent.OnModifyHeroGroup, self._onModifyHeroGroup, self)
	HeroGroupController.instance:registerCallback(HeroGroupEvent.OnSnapshotSaveSucc, self._onSnapshotSaveSucc, self)
	PlayerController.instance:registerCallback(PlayerEvent.SelectCloth, self._onSelectCloth, self)
	self._imgBg:LoadImage(ResUrl.getPlayerClothIcon("full/zhujuejineng_guangyun_manual"))
	self:_initGroupInfo()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_formation_scale)
end

function TowerComposePlayerClothView:_initGroupInfo()
	local clothId = 0

	if self.viewParam and self.viewParam.isTip then
		clothId = self.viewParam.id
	else
		local defaultSelectClothId = lua_cloth.configList[1].id

		if self.towerEpisodeConfig then
			self.curSelectPlaneClothId = TowerComposeHeroGroupModel.instance:getThemePlaneBuffId(self.towerEpisodeConfig.themeId, self.curPlaneId, TowerComposeEnum.TeamBuffType.Cloth)
			defaultSelectClothId = self.curSelectPlaneClothId > 0 and self.curSelectPlaneClothId or defaultSelectClothId
		end

		clothId = PlayerClothModel.instance:getSpEpisodeClothID() or defaultSelectClothId
	end

	PlayerController.instance:dispatchEvent(PlayerEvent.SelectCloth, clothId)
end

function TowerComposePlayerClothView:_onSelectCloth(clothId)
	self._clothId = clothId
	self._clothMO = PlayerClothModel.instance:getById(clothId)
	self._clothCO = lua_cloth.configDict[clothId]

	self:_refreshView()
end

function TowerComposePlayerClothView:_refreshView()
	self:_updateInfo()

	if self._clothMO then
		if not self._clothMO.level then
			local level = 1

			if self.viewParam then
				local isTip = self.viewParam.isTip

				level = (PlayerClothModel.instance:getSpEpisodeClothID() or isTip) and 1

				local levelCOList = lua_cloth_level.configDict[self._clothId]

				self._levelCO = levelCOList and levelCOList[level]

				gohelper.setActive(self._furiousGO, self._levelCO ~= nil)
				gohelper.setActive(self._aspellGO, self._levelCO ~= nil)
				gohelper.setActive(self._skillGO, not isTip)

				self.curSelectPlaneClothId = TowerComposeHeroGroupModel.instance:getThemePlaneBuffId(self.towerEpisodeConfig.themeId, self.curPlaneId, TowerComposeEnum.TeamBuffType.Cloth)

				local isUsing = self.curSelectPlaneClothId == self._clothId

				gohelper.setActive(self._useBtnGO, self._levelCO ~= nil and not isTip and not isUsing)
				gohelper.setActive(self._inUsingGO, self._levelCO ~= nil and not isTip and isUsing)

				if self._levelCO then
					self:_updateLevelInfo()
				else
					logError("clothId = " .. self._clothId .. " level " .. level .. "配置不存在")
				end
			end
		end
	end
end

function TowerComposePlayerClothView:_onClickUse()
	self._curGroupModel:replaceCloth(self._clothId)
	TowerComposeHeroGroupModel.instance:setThemePlaneBuffId(self.towerEpisodeConfig.themeId, self.curPlaneId, TowerComposeEnum.TeamBuffType.Cloth, self._clothId)
	TowerComposeHeroGroupModel.instance:saveThemePlaneBuffData()
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
	self:_refreshView()

	local callBackParam = {}

	callBackParam.clothId = self._clothId
	callBackParam.planeId = self.curPlaneId

	if self._useCallback then
		self._useCallback(self._useCallbackObj, callBackParam)
	end

	TowerComposeController.instance:dispatchEvent(TowerComposeEvent.TowerComposeSelectCloth)
end

return TowerComposePlayerClothView
