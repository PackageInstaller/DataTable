-- chunkname: @modules/logic/player/view/PlayerClothView.lua

module("modules.logic.player.view.PlayerClothView", package.seeall)

local PlayerClothView = class("PlayerClothView", BaseView)
local PropNameList = {
	"use",
	"move",
	"compose",
	"recover",
	"initial",
	"defeat",
	"death",
	"useDeviceCard"
}

function PlayerClothView:onInitView()
	self._imgBg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._skillGO = gohelper.findChild(self.viewGO, "#scroll_skills")
	self._txtcn = gohelper.findChildText(self.viewGO, "right/info/skill/#txt_skillname")
	self._txten = gohelper.findChildText(self.viewGO, "right/info/skill/#txt_skillname/#txt_skillnameen")
	self._txtDesc = gohelper.findChildText(self.viewGO, "right/#scroll_info/Viewport/Content/#txt_skilldesc")
	self._furiousGO = gohelper.findChild(self.viewGO, "right/info/furious")
	self._aspellGO = gohelper.findChild(self.viewGO, "right/info/aspell")
	self._useBtnGO = gohelper.findChild(self.viewGO, "right/#btn_use")
	self._inUsingGO = gohelper.findChild(self.viewGO, "right/#go_inuse")
	self._clickUseThis = gohelper.getClick(self._useBtnGO)
	self._txtFuriousPropList = self:getUserDataTb_()
	self._furiousPropGOList = self:getUserDataTb_()

	for i = 1, #PropNameList do
		local name = string.format("right/#scroll_info/Viewport/Content/furious/furiouslist/#furiousitem%d/#txt_furious", i)

		table.insert(self._txtFuriousPropList, gohelper.findChildText(self.viewGO, name))

		name = string.format("right/#scroll_info/Viewport/Content/furious/furiouslist/#furiousitem%d", i)

		table.insert(self._furiousPropGOList, gohelper.findChild(self.viewGO, name))
	end

	self._txtFuriousDesc = gohelper.findChildText(self.viewGO, "right/#scroll_info/Viewport/Content/furious/#txt_furiousdesc")
	self._txtAspellList = {}

	for i = 1, 3 do
		local name = string.format("right/#scroll_info/Viewport/Content/aspell/aspells/#go_aspellitem%d/aspelldesc", i)

		table.insert(self._txtAspellList, gohelper.findChildText(self.viewGO, name))
	end

	self._modelList = {}

	for _, clothCO in ipairs(lua_cloth.configList) do
		self._modelList[clothCO.id] = gohelper.findChild(self.viewGO, "model/" .. clothCO.id)
	end
end

function PlayerClothView:addEvents()
	self._clickUseThis:AddClickListener(self._onClickUse, self)
end

function PlayerClothView:removeEvents()
	self._clickUseThis:RemoveClickListener()
end

function PlayerClothView:onOpen()
	if self.viewParam then
		self._curGroupModel = self.viewParam.groupModel or HeroGroupModel.instance
	end

	if self.viewParam then
		self._useCallback = self.viewParam.useCallback or nil
	end

	if self.viewParam then
		self._useCallbackObj = self.viewParam.useCallbackObj or nil
	end

	PlayerClothListViewModel.instance:setGroupModel(self._curGroupModel)
	HeroGroupController.instance:registerCallback(HeroGroupEvent.OnModifyHeroGroup, self._onModifyHeroGroup, self)
	HeroGroupController.instance:registerCallback(HeroGroupEvent.OnSnapshotSaveSucc, self._onSnapshotSaveSucc, self)
	PlayerController.instance:registerCallback(PlayerEvent.SelectCloth, self._onSelectCloth, self)
	self._imgBg:LoadImage(ResUrl.getPlayerClothIcon("full/zhujuejineng_guangyun_manual"))
	self:_initGroupInfo()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_formation_scale)
end

function PlayerClothView:_initGroupInfo()
	local clothId = 0

	if self.viewParam and self.viewParam.isTip then
		clothId = self.viewParam.id
	else
		local curGroupMO = self._curGroupModel:getCurGroupMO()

		clothId = PlayerClothModel.instance:getSpEpisodeClothID() or (curGroupMO and curGroupMO.clothId and curGroupMO and curGroupMO.clothId > 0 or nil) and curGroupMO.clothId
	end

	PlayerController.instance:dispatchEvent(PlayerEvent.SelectCloth, clothId)
end

function PlayerClothView:onUpdateParam()
	self:_initGroupInfo()
end

function PlayerClothView:onCloseFinish()
	HeroGroupController.instance:unregisterCallback(HeroGroupEvent.OnModifyHeroGroup, self._onModifyHeroGroup, self)
	HeroGroupController.instance:unregisterCallback(HeroGroupEvent.OnSnapshotSaveSucc, self._onSnapshotSaveSucc, self)
	PlayerController.instance:unregisterCallback(PlayerEvent.SelectCloth, self._onSelectCloth, self)
	self._imgBg:UnLoadImage()
end

function PlayerClothView:onDestroyView()
	self._scrollRectWrap = nil
end

function PlayerClothView:_onSelectCloth(clothId)
	self._clothId = clothId
	self._clothMO = PlayerClothModel.instance:getById(clothId)
	self._clothCO = lua_cloth.configDict[clothId]

	self:_refreshView()
end

function PlayerClothView:_refreshView()
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

				local curGroupMO = self._curGroupModel:getCurGroupMO()
				local isUsing = curGroupMO and curGroupMO.clothId == self._clothId

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

function PlayerClothView:_updateInfo()
	local first = GameUtil.utf8sub(self._clothCO.name, 1, 1)

	self._txtcn.text = first .. ((GameUtil.utf8len(self._clothCO.name) >= 2 or nil) and string.format("<size=55>%s</size>", GameUtil.utf8sub(self._clothCO.name, 2, GameUtil.utf8len(self._clothCO.name) - 1)))
	self._txten.text = self._clothCO.enname
	self._txtDesc.text = self._clothCO.desc

	for _, clothCO in ipairs(lua_cloth.configList) do
		local modelGO = self._modelList[clothCO.id]

		gohelper.setActive(modelGO, clothCO.id == self._clothCO.id)
	end
end

function PlayerClothView:_updateLevelInfo()
	for i, propName in ipairs(PropNameList) do
		local configText = self._levelCO[propName]
		local needShow = false
		local configTextType = type(configText)

		if configTextType == "string" then
			needShow = not string.nilorempty(configText)
		elseif configTextType == "number" then
			needShow = configText > 0
		end

		gohelper.setActive(self._furiousPropGOList[i], needShow)

		if needShow then
			if propName == "recover" then
				local recover = GameUtil.splitString2(self._levelCO.recover)

				configText = recover and recover[1] and recover[1][2] or self._levelCO.recover
			end

			self._txtFuriousPropList[i].text = "+" .. configText
		end
	end

	self._txtFuriousDesc.text = self._levelCO.desc

	for i = 1, 3 do
		local skillId = self._levelCO["skill" .. i]
		local skillCO = lua_skill.configDict[skillId]

		gohelper.setActive(self._txtAspellList[i].transform.parent.gameObject, skillCO ~= nil)

		if skillCO then
			self._txtAspellList[i].text = FightConfig.instance:getSkillEffectDesc(nil, skillCO)
		elseif skillId > 0 then
			self._txtAspellList[i].text = ""

			logError("技能不存在：" .. skillId)
		end
	end
end

function PlayerClothView:_onModifyHeroGroup()
	GameFacade.showToast(ToastEnum.PlayerCloth)
end

function PlayerClothView:_onSnapshotSaveSucc()
	self:_refreshView()
	GameFacade.showToast(ToastEnum.PlayerCloth)
end

function PlayerClothView:_onClickUse()
	self._curGroupModel:replaceCloth(self._clothId)
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
	self:_refreshView()
	self._curGroupModel:saveCurGroupData()

	local callBackParam = {}

	callBackParam.clothId = self._clothId

	if self._useCallback then
		self._useCallback(self._useCallbackObj, callBackParam)
	end
end

return PlayerClothView
