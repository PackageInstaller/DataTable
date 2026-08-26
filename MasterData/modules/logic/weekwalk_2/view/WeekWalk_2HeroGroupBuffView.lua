-- chunkname: @modules/logic/weekwalk_2/view/WeekWalk_2HeroGroupBuffView.lua

module("modules.logic.weekwalk_2.view.WeekWalk_2HeroGroupBuffView", package.seeall)

local WeekWalk_2HeroGroupBuffView = class("WeekWalk_2HeroGroupBuffView", BaseView)

function WeekWalk_2HeroGroupBuffView:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function WeekWalk_2HeroGroupBuffView:addEvents()
	self.addEventCb(self, self.viewContainer, HeroGroupEvent.SwitchBalance, self._onSwitchBalance, self)
	self.addEventCb(self, self.viewContainer, HeroGroupEvent.BeforeEnterFight, self.beforeEnterFight, self)
	self.addEventCb(self, WeekWalk_2Controller.instance, WeekWalk_2Event.OnBuffSetupReply, self._onBuffSetupReply, self)
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.SwitchReplay, self._switchReplay, self)
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnModifyGroupSelectIndex, self._onModifyGroupSelectIndex, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
end

function WeekWalk_2HeroGroupBuffView:removeEvents()
	self.removeEventCb(self, self.viewContainer, HeroGroupEvent.SwitchBalance, self._onSwitchBalance, self)
end

function WeekWalk_2HeroGroupBuffView:beforeEnterFight()
	return
end

function WeekWalk_2HeroGroupBuffView:_onSwitchBalance()
	if self._animator then
		self._animator:Play("switch", 0, 0)
	end
end

function WeekWalk_2HeroGroupBuffView:_initFairyLandCard()
	self:_loadEffect()
end

function WeekWalk_2HeroGroupBuffView:_loadEffect()
	self._effectUrl = "ui/viewres/weekwalk/weekwalkheart/herogroupviewweekwalkheart.prefab"
	self._effectLoader = MultiAbLoader.New()

	self._effectLoader:addPath(self._effectUrl)
	self._effectLoader:startLoad(self._effectLoaded, self)
end

function WeekWalk_2HeroGroupBuffView:_effectLoaded(effectLoader)
	local gofairylandcard = gohelper.findChild(self.viewGO, "#go_fairylandcard")

	gohelper.setActive(gofairylandcard, true)

	local assetItem = effectLoader:getAssetItem(self._effectUrl)
	local effectPrefab = assetItem:GetResource(self._effectUrl)
	local go = gohelper.clone(effectPrefab, gofairylandcard)

	self._animator = go:GetComponent(typeof(UnityEngine.Animator))
	self._goBuffNew = gohelper.findChild(go, "#go_weekwalkheart/#go_new")
	self._goNoBuff = gohelper.findChild(go, "#go_weekwalkheart/#go_NoBuff")
	self._goHasBuff = gohelper.findChild(go, "#go_weekwalkheart/#go_HasBuff")
	self._buffName = gohelper.findChildText(go, "#go_weekwalkheart/#go_HasBuff/cardnamebg/#txt_buffname")
	self._imageBuff = gohelper.findChildImage(go, "#go_weekwalkheart/#go_HasBuff/#image_buff")
	self._btnclick = gohelper.findChildButtonWithAudio(go, "#go_weekwalkheart/#btn_click")

	self._btnclick:AddClickListener(self._btnclickOnClick, self)
	self:_initBuff()
	self:_updateBuffNewFlag()
end

function WeekWalk_2HeroGroupBuffView:_updateBuffNewFlag()
	local layerId = WeekWalk_2Model.instance:getCurMapId()

	if not layerId then
		return
	end

	if WeekWalk_2Controller.hasOnceActionKey(WeekWalk_2Enum.OnceAnimType.FightBuffNew, layerId) then
		return
	end

	local curMapInfo = WeekWalk_2Model.instance:getCurMapInfo()
	local prevLayerId = curMapInfo.config.preId

	if prevLayerId then
		::label_9_0::

		local prevMapInfo = WeekWalk_2Model.instance:getLayerInfo(prevLayerId)

		if not prevMapInfo then
			return
		end

		local showNewFlag = curMapInfo.config.chooseSkillNum ~= prevMapInfo.config.chooseSkillNum

		gohelper.setActive(self._goBuffNew, showNewFlag)

		self._showBuffNewFlag = showNewFlag
	end
end

function WeekWalk_2HeroGroupBuffView:_onOpenView(viewName)
	if self._showBuffNewFlag and viewName == ViewName.WeekWalk_2HeartBuffView then
		self._showBuffNewFlag = false

		gohelper.setActive(self._goBuffNew, false)

		local layerId = WeekWalk_2Model.instance:getCurMapId()

		WeekWalk_2Controller.setOnceActionKey(WeekWalk_2Enum.OnceAnimType.FightBuffNew, layerId)
	end
end

function WeekWalk_2HeroGroupBuffView:_initBuff()
	self._buffConfig = nil

	local skillId = WeekWalk_2BuffListModel.getCurHeroGroupSkillId()

	if skillId then
		self._buffConfig = lua_weekwalk_ver2_skill.configDict[skillId]
	end

	self:_updateDreamLandCardInfo()
end

function WeekWalk_2HeroGroupBuffView:_btnclickOnClick()
	if self._isReplay then
		return
	end

	WeekWalk_2Controller.instance:openWeekWalk_2HeartBuffView({
		isBattle = true
	})
end

function WeekWalk_2HeroGroupBuffView:_editableInitView()
	self:_initFairyLandCard()
end

function WeekWalk_2HeroGroupBuffView:onOpen()
	self:_setTaskDes()
end

function WeekWalk_2HeroGroupBuffView:_setTaskDes()
	return
end

function WeekWalk_2HeroGroupBuffView:_switchReplay(replay)
	if not self._taskConfig then
		return
	end

	if self._animator then
		self._animator:Play("switch", 0, 0)
	end

	self._isReplay = replay

	TaskDispatcher.cancelTask(self._doSwitchReplay, self)

	if self._isReplay then
		TaskDispatcher.runDelay(self._doSwitchReplay, self, 0.16)
	end
end

function WeekWalk_2HeroGroupBuffView:_doSwitchReplay()
	if self._isReplay then
		-- block empty
	end
end

function WeekWalk_2HeroGroupBuffView:_onModifyGroupSelectIndex()
	self:_initBuff()
end

function WeekWalk_2HeroGroupBuffView:_onBuffSetupReply()
	self:_initBuff()
end

function WeekWalk_2HeroGroupBuffView:_updateDreamLandCardInfo()
	gohelper.setActive(self._goNoBuff, false)
	gohelper.setActive(self._goHasBuff, false)

	if not self._buffConfig or not self._imageBuff then
		gohelper.setActive(self._goNoBuff, true)

		return
	end

	gohelper.setActive(self._goHasBuff, true)

	self._buffName.text = self._buffConfig.name

	UISpriteSetMgr.instance:setWeekWalkSprite(self._imageBuff, self._buffConfig.icon)
end

function WeekWalk_2HeroGroupBuffView:onClose()
	if self._btnclick then
		self._btnclick:RemoveClickListener()
	end

	if self._animator then
		self._animator.enabled = true

		self._animator:Play("close", 0, 0)
	end

	TaskDispatcher.cancelTask(self._doSwitchReplay, self)
end

function WeekWalk_2HeroGroupBuffView:onDestroyView()
	if self._effectLoader then
		self._effectLoader:dispose()
	end
end

return WeekWalk_2HeroGroupBuffView
