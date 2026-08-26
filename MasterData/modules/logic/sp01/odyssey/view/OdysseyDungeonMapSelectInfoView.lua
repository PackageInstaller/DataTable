-- chunkname: @modules/logic/sp01/odyssey/view/OdysseyDungeonMapSelectInfoView.lua

module("modules.logic.sp01.odyssey.view.OdysseyDungeonMapSelectInfoView", package.seeall)

local OdysseyDungeonMapSelectInfoView = class("OdysseyDungeonMapSelectInfoView", BaseView)

function OdysseyDungeonMapSelectInfoView:onInitView()
	self._txtmapName = gohelper.findChildText(self.viewGO, "root/title/#txt_mapName")
	self._simagemap = gohelper.findChildSingleImage(self.viewGO, "root/#simage_map")
	self._scrollinfo = gohelper.findChildScrollRect(self.viewGO, "root/#scroll_info")
	self._goexploreBar = gohelper.findChild(self.viewGO, "root/#scroll_info/Viewport/Content/explore/#go_exploreBar")
	self._txtexplore = gohelper.findChildText(self.viewGO, "root/#scroll_info/Viewport/Content/explore/txt/#txt_explore")
	self._txtrecommendLevel = gohelper.findChildText(self.viewGO, "root/#scroll_info/Viewport/Content/recommendLevel/txt/#txt_recommendLevel")
	self._gotask = gohelper.findChild(self.viewGO, "root/#scroll_info/Viewport/Content/#go_task")
	self._txttask = gohelper.findChildText(self.viewGO, "root/#scroll_info/Viewport/Content/#go_task/taskContent/#txt_task")
	self._goconquer = gohelper.findChild(self.viewGO, "root/#scroll_info/Viewport/Content/#go_conquer")
	self._txtconquer = gohelper.findChildText(self.viewGO, "root/#scroll_info/Viewport/Content/#go_conquer/#txt_conquer")
	self._gomyth = gohelper.findChild(self.viewGO, "root/#scroll_info/Viewport/Content/#go_myth")
	self._imagemythResult = gohelper.findChildImage(self.viewGO, "root/#scroll_info/Viewport/Content/#go_myth/txt/#image_mythResult")
	self._txtmyth = gohelper.findChildText(self.viewGO, "root/#scroll_info/Viewport/Content/#go_myth/#txt_myth")
	self._btnenter = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_enter")
	self._golock = gohelper.findChild(self.viewGO, "root/#go_lock")
	self._txtlock = gohelper.findChildText(self.viewGO, "root/#go_lock/#txt_lock")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function OdysseyDungeonMapSelectInfoView:addEvents()
	self._btnenter:AddClickListener(self._btnenterOnClick, self)
	self.addEventCb(self, OdysseyController.instance, OdysseyEvent.DailyRefresh, self.dailyRefresh, self)
end

function OdysseyDungeonMapSelectInfoView:removeEvents()
	self._btnenter:RemoveClickListener()
	self.removeEventCb(self, OdysseyController.instance, OdysseyEvent.DailyRefresh, self.dailyRefresh, self)
	TaskDispatcher.cancelTask(self.refreshLockDesc, self)
end

function OdysseyDungeonMapSelectInfoView:_btnenterOnClick()
	OdysseyDungeonModel.instance:setCurMapId(self.mapId)
	OdysseyDungeonModel.instance:setIsMapSelect(false)
	OdysseyDungeonController.instance:dispatchEvent(OdysseyEvent.OnMapSelectItemEnter)
	self:closeThis()
end

function OdysseyDungeonMapSelectInfoView:_editableInitView()
	self.anim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._imageExploreBar = self._goexploreBar:GetComponent(gohelper.Type_Image)
end

function OdysseyDungeonMapSelectInfoView:onUpdateParam()
	self:initData()
	self:refreshUI()
	AudioMgr.instance:trigger(AudioEnum2_9.Odyssey.play_ui_cikexia_link_popup_unfold)

	self.anim.enabled = true

	self.anim:Play("open", 0, 0)
	self.anim:Update(0)
end

function OdysseyDungeonMapSelectInfoView:onOpen()
	OdysseyDungeonController.instance:dispatchEvent(OdysseyEvent.ShowDungeonRightUI, false)
	self:initData()
	self:refreshUI()
	AudioMgr.instance:trigger(AudioEnum2_9.Odyssey.play_ui_cikexia_link_popup_unfold)
end

function OdysseyDungeonMapSelectInfoView:dailyRefresh()
	self:initData()
	self:refreshUI()
end

function OdysseyDungeonMapSelectInfoView:initData()
	self.mapId = self.viewParam.mapId
	self.mapConfig = OdysseyConfig.instance:getDungeonMapConfig(self.mapId)
	self.mapMo = OdysseyDungeonModel.instance:getMapInfo(self.mapId)
end

function OdysseyDungeonMapSelectInfoView:refreshUI()
	self._scrollinfo.verticalNormalizedPosition = 1
	self._txtmapName.text = self.mapConfig.mapName
	self._txtexplore.text = self.mapMo and string.format("%s%%", math.floor(self.mapMo.exploreValue / 10)) or "???"

	if self.mapMo then
		self._imageExploreBar.fillAmount = self.mapMo.exploreValue / 1000 or 0
	end

	local recommendLevelList = string.splitToNumber(self.mapConfig.recommendLevel, "#")

	self._txtrecommendLevel.text = self.mapMo and string.format("%s-%s", recommendLevelList[1], recommendLevelList[2]) or "???"

	self._simagemap:LoadImage(ResUrl.getSp01OdysseySingleBg("map/odyssey_bigmap_pic_" .. self.mapId))
	gohelper.setActive(self._gotask, self.mapMo)
	gohelper.setActive(self._goconquer, self.mapMo)
	gohelper.setActive(self._gomyth, self.mapMo)
	gohelper.setActive(self._btnenter.gameObject, self.mapMo)
	gohelper.setActive(self._golock, not self.mapMo)

	if self.mapMo then
		local mainTaskMapCo, mainTaskElementCo = OdysseyDungeonModel.instance:getCurMainElement()

		gohelper.setActive(self._gotask, mainTaskElementCo and mainTaskElementCo.mapId == self.mapId)

		if mainTaskElementCo then
			self._txttask.text = mainTaskElementCo.taskDesc or ""
		end

		local conquerEleMoList = OdysseyDungeonModel.instance:getMapFightElementMoList(self.mapId, OdysseyEnum.FightType.Conquer)

		gohelper.setActive(self._goconquer, #conquerEleMoList > 0)

		if #conquerEleMoList > 0 then
			local conquerEleData = conquerEleMoList[1]:getConquestEleData()

			self._txtconquer.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("odyssey_dungeon_mapselectinfo_conquest"), conquerEleData.highWave)
		end

		local mythEleMoList = OdysseyDungeonModel.instance:getMapFightElementMoList(self.mapId, OdysseyEnum.FightType.Myth)

		if #mythEleMoList > 0 then
			local mythEleData = mythEleMoList[1]:getMythicEleData()

			gohelper.setActive(self._gomyth, true)

			self._txtmyth.text = mythEleData.evaluation > 0 and luaLang("odyssey_dungeon_mapselectinfo_mythRecord" .. mythEleData.evaluation) or luaLang("odyssey_myth_record_empty")

			gohelper.setActive(self._imagemythResult.gameObject, mythEleData.evaluation > 0)

			if mythEleData.evaluation > 0 then
				UISpriteSetMgr.instance:setSp01OdysseyDungeonSprite(self._imagemythResult, "pingji_x_" .. mythEleData.evaluation)
			end
		else
			gohelper.setActive(self._gomyth, false)
		end
	elseif not string.nilorempty(self.mapConfig.unlockCondition) then
		TaskDispatcher.cancelTask(self.refreshLockDesc, self)
		TaskDispatcher.runRepeat(self.refreshLockDesc, self, 1)
		self:refreshLockDesc()
	end
end

function OdysseyDungeonMapSelectInfoView:refreshLockDesc()
	local canUnlock, unlockInfoParam = OdysseyDungeonModel.instance:checkConditionCanUnlock(self.mapConfig.unlockCondition)

	if canUnlock then
		TaskDispatcher.cancelTask(self.refreshLockDesc, self)
	elseif unlockInfoParam.type == OdysseyEnum.ConditionType.Time then
		local remainTimeStamp = unlockInfoParam.remainTimeStamp
		local minDate, minDateformate = TimeUtil.secondToRoughTime3(remainTimeStamp)

		self._txtlock.text = GameUtil.getSubPlaceholderLuaLang(luaLang("odyssey_mapselect_lock_time"), {
			minDate,
			minDateformate
		})
	else
		TaskDispatcher.cancelTask(self.refreshLockDesc, self)

		self._txtlock.text = self.mapConfig.unlockDesc
	end
end

function OdysseyDungeonMapSelectInfoView:onClose()
	TaskDispatcher.cancelTask(self.refreshLockDesc, self)
	OdysseyDungeonController.instance:dispatchEvent(OdysseyEvent.ShowDungeonRightUI, true)
	AudioMgr.instance:trigger(AudioEnum2_9.Odyssey.play_ui_cikexia_link_popup_fold)
end

function OdysseyDungeonMapSelectInfoView:onDestroyView()
	self._simagemap:UnLoadImage()
end

return OdysseyDungeonMapSelectInfoView
