-- chunkname: @modules/logic/weekwalk/view/WeekWalkReviveView.lua

module("modules.logic.weekwalk.view.WeekWalkReviveView", package.seeall)

local WeekWalkReviveView = class("WeekWalkReviveView", BaseView)

function WeekWalkReviveView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._txtruledesc = gohelper.findChildText(self.viewGO, "#txt_ruledesc")
	self._btndetail = gohelper.findChildButtonWithAudio(self.viewGO, "bottomLeft/#btn_detail")
	self._btnok = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_ok")
	self._gocardlist = gohelper.findChild(self.viewGO, "#go_cardlist")
	self._gotemplate = gohelper.findChild(self.viewGO, "#go_cardlist/#go_template")
	self._gorecommendAttr = gohelper.findChild(self.viewGO, "#go_recommendAttr")
	self._goattritem = gohelper.findChild(self.viewGO, "#go_recommendAttr/attrlist/#go_attritem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function WeekWalkReviveView:addEvents()
	self._btndetail:AddClickListener(self._btndetailOnClick, self)
	self._btnok:AddClickListener(self._btnokOnClick, self)
end

function WeekWalkReviveView:removeEvents()
	self._btndetail:RemoveClickListener()
	self._btnok:RemoveClickListener()
end

function WeekWalkReviveView:_btndetailOnClick()
	EnemyInfoController.instance:openWeekWalkEnemyInfoView(self._mapInfo.id)
end

function WeekWalkReviveView:_btnokOnClick()
	local heroList = {}

	for k, v in pairs(self._heroItemList) do
		if v._isSelected then
			table.insert(heroList, v._mo.heroId)
		end
	end

	if #heroList <= 0 then
		return
	end

	WeekwalkRpc.instance:sendSelectNotCdHeroRequest(heroList)
end

function WeekWalkReviveView:_editableInitView()
	self.addEventCb(self, WeekWalkController.instance, WeekWalkEvent.OnSelectNotCdHeroReply, self.closeThis, self)
	self._simagebg:LoadImage(ResUrl.getWeekWalkBg("full/bg_beijigntu.png"))
	gohelper.addUIClickAudio(self._btnok.gameObject, AudioEnum.WeekWalk.play_artificial_ui_commonchoose)
	gohelper.addUIClickAudio(self._btndetail.gameObject, AudioEnum.UI.play_ui_action_explore)
end

function WeekWalkReviveView:onUpdateParam()
	return
end

function WeekWalkReviveView:_recommendCareer()
	local battleInfo = self._mapInfo:getNoStarBattleInfo()

	if not battleInfo then
		gohelper.setActive(self._gorecommendAttr, false)

		return
	end

	local battleId = battleInfo.battleId
	local battleConfig = lua_battle.configDict[battleId]
	local monsterGroupIds = string.splitToNumber(battleConfig.monsterGroupIds, "#")
	local recommended, counter = FightHelper.getAttributeCounter(monsterGroupIds)
	local data_len = #recommended

	gohelper.setActive(self._gorecommendAttr, data_len > 0)

	if data_len > 0 then
		for i, v in ipairs(recommended) do
			local career = "career_" .. v
			local go = gohelper.cloneInPlace(self._goattritem)

			gohelper.setActive(go, true)

			local icon = gohelper.findChildImage(go, "icon")

			UISpriteSetMgr.instance:setHeroGroupSprite(icon, career)
		end
	end
end

function WeekWalkReviveView:onOpen()
	self._mapInfo = WeekWalkModel.instance:getCurMapInfo()
	self._mapConfig = WeekWalkModel.instance:getCurMapConfig()
	self._heroItemList = {}
	self._txtruledesc.text = formatLuaLang("weekwalkreviveview_ruledesc", self._mapConfig.notCdHeroCount)

	self:_showHeroList()
	self:_updateBtn()
	self:_recommendCareer()

	local sceneType = GameSceneMgr.instance:getCurSceneType()

	if sceneType == SceneType.Fight then
		self:_playBgm(AudioEnum.WeekWalk.play_artificial_layer_type_1)
	end
end

function WeekWalkReviveView:_playBgm(bgmId)
	self._bgmId = bgmId

	AudioMgr.instance:trigger(self._bgmId)
end

function WeekWalkReviveView:_stopBgm()
	if self._bgmId then
		AudioMgr.instance:trigger(AudioEnum.WeekWalk.stop_sleepwalkingaudio)

		self._bgmId = nil
	end
end

function WeekWalkReviveView:_showHeroList()
	local heroList = self._mapInfo:getHeroInfoList()

	for i, v in ipairs(heroList) do
		self:_addHeroItem(v)
	end
end

function WeekWalkReviveView:_addHeroItem(heroInfo)
	local child = gohelper.cloneInPlace(self._gotemplate)

	gohelper.setActive(child, true)

	local retainGo = gohelper.findChild(child, "go_retain")

	gohelper.setActive(retainGo, false)

	local heroGo = gohelper.findChild(child, "hero")
	local heroItem = IconMgr.instance:getCommonHeroItem(heroGo)
	local heroId = heroInfo.heroId
	local mo = HeroModel.instance:getByHeroId(heroId)

	heroItem:setStyle_CharacterBackpack()
	heroItem:onUpdateMO(mo)
	heroItem:addClickListener(self._heroItemClick, self)
	heroItem:setDamage(true)
	heroItem:setNewShow(false)
	heroItem:setEffectVisible(false)
	heroItem:setInjuryTxtVisible(false)

	local heroObj = self:getUserDataTb_()

	heroObj._mo = mo
	heroObj._isSelected = false
	heroObj._heroItem = heroItem
	heroObj._retainGo = retainGo
	self._heroItemList[mo] = heroObj
end

function WeekWalkReviveView:_heroItemClick(mo)
	local heroObj = self._heroItemList[mo]

	AudioMgr.instance:trigger(AudioEnum.WeekWalk.play_artificial_ui_fight_choosecard)

	if not heroObj._isSelected and self._canRevive then
		GameFacade.showToast(ToastEnum.WeekWalkRevive)

		return
	end

	heroObj._isSelected = not heroObj._isSelected

	self:_updateBtn()
end

function WeekWalkReviveView:_updateBtn()
	local num = 0
	local heroNum = 0

	for k, v in pairs(self._heroItemList) do
		heroNum = heroNum + 1

		if v._isSelected then
			num = num + 1
		end
	end

	local targetNum = math.min(heroNum, self._mapConfig.notCdHeroCount)

	self._canRevive = targetNum <= num
	self._btnok.button.interactable = self._canRevive

	for k, v in pairs(self._heroItemList) do
		v._heroItem:setSelect(false)

		if v._isSelected then
			gohelper.setActive(v._retainGo, true)
			v._heroItem:setDamage(false)
			v._heroItem:setInjuryTxtVisible(false)
			v._heroItem:setSelect(true)
		else
			gohelper.setActive(v._retainGo, false)
			v._heroItem:setDamage(true)
			v._heroItem:setInjuryTxtVisible(false)
		end
	end
end

function WeekWalkReviveView:onClose()
	self:_stopBgm()
end

function WeekWalkReviveView:onDestroyView()
	self._simagebg:UnLoadImage()
end

return WeekWalkReviveView
