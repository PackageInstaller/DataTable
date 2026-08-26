-- chunkname: @modules/logic/weekwalk/view/WeekWalkLayerPageItem.lua

module("modules.logic.weekwalk.view.WeekWalkLayerPageItem", package.seeall)

local WeekWalkLayerPageItem = class("WeekWalkLayerPageItem", LuaCompBase)

function WeekWalkLayerPageItem:onInitView()
	self._txtbattlename = gohelper.findChildText(self.viewGO, "info/#txt_battlename")
	self._btndetail = gohelper.findChildButtonWithAudio(self.viewGO, "info/#txt_battlename/#btn_detail")
	self._txtname = gohelper.findChildText(self.viewGO, "info/#txt_name")
	self._txtindex = gohelper.findChildText(self.viewGO, "info/#txt_index")
	self._txtnameen = gohelper.findChildText(self.viewGO, "info/#txt_index/#txt_nameen")
	self._txtprogress = gohelper.findChildText(self.viewGO, "info/#txt_progress")
	self._gounlock = gohelper.findChild(self.viewGO, "#go_unlock")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "#go_unlock/#btn_click")
	self._simagemapicon = gohelper.findChildSingleImage(self.viewGO, "#go_unlock/#btn_click/#simage_mapicon")
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "#go_unlock/#btn_click/#simage_icon")
	self._gohardmode = gohelper.findChild(self.viewGO, "#go_unlock/#btn_click/#go_hardmode")
	self._golock = gohelper.findChild(self.viewGO, "#go_lock")
	self._btnlock = gohelper.findChildButtonWithAudio(self.viewGO, "#go_lock/#btn_lock")
	self._simagelockicon = gohelper.findChildSingleImage(self.viewGO, "#go_lock/#btn_lock/#simage_lockicon")
	self._golockhardmode = gohelper.findChildSingleImage(self.viewGO, "#go_lock/#btn_lock/#go_hardmode")
	self._gomapfinish = gohelper.findChild(self.viewGO, "#go_mapfinish")
	self._btnreward = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_reward")
	self._gorewardIcon = gohelper.findChild(self.viewGO, "#btn_reward/#go_rewardIcon")
	self._gonormalIcon = gohelper.findChild(self.viewGO, "#btn_reward/#go_normalIcon")
	self._gorewardfinish = gohelper.findChild(self.viewGO, "#btn_reward/#go_rewardfinish")
	self._goline = gohelper.findChildImage(self.viewGO, "#go_mapfinish/clearancegraphics_01_mask/clearancegraphics_01")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function WeekWalkLayerPageItem:addEvents()
	self._btndetail:AddClickListener(self._btndetailOnClick, self)
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
	self._btnlock:AddClickListener(self._btnlockOnClick, self)
	self._btnreward:AddClickListener(self._btnrewardOnClick, self)
end

function WeekWalkLayerPageItem:removeEvents()
	self._btndetail:RemoveClickListener()
	self._btnclick:RemoveClickListener()
	self._btnlock:RemoveClickListener()
	self._btnreward:RemoveClickListener()
end

function WeekWalkLayerPageItem:_btnlockOnClick()
	local info = WeekWalkModel.instance:getInfo()

	if not WeekWalkModel.isShallowLayer(self._config.layer) and not info.isOpenDeep then
		GameFacade.showToast(ToastEnum.WeekWalkIsShallowLayer)

		return
	end

	local preId = self._config.preId

	if preId > 0 then
		local preMapInfo = WeekWalkModel.instance:getMapInfo(preId)

		if preMapInfo and not preMapInfo:getNoStarBattleInfo() then
			GameFacade.showToast(ToastEnum.WeekWalkNotFinishStory)

			return
		end
	end

	GameFacade.showToast(ToastEnum.WeekWalkLayerPage)
end

function WeekWalkLayerPageItem:_btnrewardOnClick()
	WeekWalkController.instance:openWeekWalkLayerRewardView({
		mapId = self._config.id
	})
end

function WeekWalkLayerPageItem:_btndetailOnClick()
	EnemyInfoController.instance:openWeekWalkEnemyInfoView(self._config.id)
end

function WeekWalkLayerPageItem:_btnclickOnClick()
	WeekWalkController.instance:openWeekWalkView({
		mapId = self._config.id
	})
end

function WeekWalkLayerPageItem:ctor(param)
	self._config = param[1]
	self._pageIndex = param[2]
	self._layerPage = param[3]
end

function WeekWalkLayerPageItem:_editableInitView()
	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if WeekWalkModel.isShallowLayer(self._config.layer) then
		self._simageicon:LoadImage(ResUrl.getWeekWalkLayerIcon("shallow"))
		self._simagelockicon:LoadImage(ResUrl.getWeekWalkLayerIcon("shallow_unknown"))
	else
		local isHardLayer = self._config.layer == WeekWalkEnum.HardDeepLayerId

		gohelper.setActive(self._gohardmode, isHardLayer)
		gohelper.setActive(self._simageicon, not isHardLayer)
		gohelper.setActive(self._golockhardmode, isHardLayer)
		gohelper.setActive(self._simagelockicon, not isHardLayer)

		if not isHardLayer then
			self._simageicon:LoadImage(ResUrl.getWeekWalkLayerIcon("deep"))
			self._simagelockicon:LoadImage(ResUrl.getWeekWalkLayerIcon("deep_unknown"))
		end
	end

	gohelper.setActive(self._btndetail.gameObject, false)
	gohelper.addUIClickAudio(self._btndetail.gameObject, AudioEnum.UI.play_ui_action_explore)
	gohelper.addUIClickAudio(self._btnclick.gameObject, AudioEnum.WeekWalk.play_artificial_ui_mapopen)
	gohelper.addUIClickAudio(self._btnreward.gameObject, AudioEnum.WeekWalk.play_artificial_ui_rewardpoints)
	WeekWalkController.instance:registerCallback(WeekWalkEvent.OnScrollPage, self._setEdgFadeStrengthen, self)

	self._goline.material = UnityEngine.GameObject.Instantiate(self._goline.material)

	self._goline.material:EnableKeyword("_EDGE_GRADUAL")
	self._goline.material:SetFloat(ShaderPropertyId.Scroll_LeftRamp, 1)
	self:openEdgFadeEffect()
end

function WeekWalkLayerPageItem:_setEdgFadeStrengthen(strengthen, pageIndex)
	if self._pageIndex ~= pageIndex then
		return
	end

	for _, v in pairs(self._graphics) do
		if v.gameObject:GetComponent(gohelper.Type_TextMesh) then
			v.fontMaterial:SetFloat(ShaderPropertyId.Scroll_LeftRamp, strengthen)
		else
			v.material:SetFloat(ShaderPropertyId.Scroll_LeftRamp, strengthen)
		end
	end
end

function WeekWalkLayerPageItem:_playAnim(name)
	self._animator.enabled = true

	self._animator:Play(name)
end

function WeekWalkLayerPageItem:onOpen()
	self:_updateStatus()
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self, LuaEventSystem.Low)
	WeekWalkController.instance:registerCallback(WeekWalkEvent.OnGetInfo, self._onGetInfo, self)
	self.addEventCb(self, WeekWalkController.instance, WeekWalkEvent.OnWeekwalkTaskUpdate, self._onWeekwalkTaskUpdate, self)
end

local SharedMats = {}

function WeekWalkLayerPageItem:openEdgFadeEffect()
	self._graphics = self._graphics or self:getUserDataTb_()

	local components = self.viewGO:GetComponentsInChildren(typeof(UnityEngine.UI.Graphic), true)
	local iter = components:GetEnumerator()
	local targetMatInstance

	while iter:MoveNext() do
		local current = iter.Current

		if current:GetComponent(gohelper.Type_TextMesh) then
			local cloneMatName = current.font.name .. "_edgefade"

			targetMatInstance = SharedMats[cloneMatName]

			if not SharedMats[cloneMatName] then
				targetMatInstance = UnityEngine.GameObject.Instantiate(current.fontSharedMaterial)
				targetMatInstance.name = cloneMatName

				targetMatInstance:EnableKeyword("_EDGE_GRADUAL")

				SharedMats[cloneMatName] = targetMatInstance
			end

			current.fontSharedMaterial = targetMatInstance
		elseif current.material.name == "edgfade" then
			if not SharedMats.imgMat then
				SharedMats.imgMat = UnityEngine.GameObject.Instantiate(current.material)
				SharedMats.imgMat.name = "img_edgefade"

				SharedMats.imgMat:EnableKeyword("_EDGE_GRADUAL")
			end

			current.material = SharedMats.imgMat
		end

		if current ~= self._goline then
			table.insert(self._graphics, iter.Current)
		end
	end
end

function WeekWalkLayerPageItem:onClose()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	WeekWalkController.instance:unregisterCallback(WeekWalkEvent.OnGetInfo, self._onGetInfo, self)
	self.removeEventCb(self, WeekWalkController.instance, WeekWalkEvent.OnWeekwalkTaskUpdate, self._onWeekwalkTaskUpdate, self)
	WeekWalkController.instance:unregisterCallback(WeekWalkEvent.OnScrollPage, self._setEdgFadeStrengthen, self)
end

function WeekWalkLayerPageItem:_onWeekwalkTaskUpdate()
	if ViewMgr.instance:isOpen(ViewName.WeekWalkView) then
		return
	end

	self:_updateStatus()
end

function WeekWalkLayerPageItem:_updateDeepConfig()
	if WeekWalkModel.isShallowLayer(self._config.layer) then
		return
	end

	local info = WeekWalkModel.instance:getInfo()
	local deepLayerList = WeekWalkConfig.instance:getDeepLayer(info.issueId)

	for i, v in ipairs(deepLayerList) do
		if v.layer == self._config.layer then
			self._config = v

			return
		end
	end
end

function WeekWalkLayerPageItem:_onGetInfo()
	self:_updateDeepConfig()

	local info = WeekWalkModel.instance:getInfo()

	if not WeekWalkModel.isShallowLayer(self._config.layer) and info.isOpenDeep and self._layerPage:getVisible() and not self._mapInfo and WeekWalkModel.instance:getMapInfo(self._config.id) then
		self._showUnlockAnim = true
	end

	self:_updateStatus()

	self._showUnlockAnim = nil
end

function WeekWalkLayerPageItem:_onCloseViewFinish(viewName)
	if viewName == ViewName.WeekWalkView then
		self:_updateStatus()
	end
end

function WeekWalkLayerPageItem:_updateProgress()
	local rewardList = TaskConfig.instance:getWeekWalkRewardList(self._config.layer)
	local cur = 0
	local total = 0

	if rewardList then
		for taskId, num in pairs(rewardList) do
			local taskConfig = lua_task_weekwalk.configDict[taskId]

			if taskConfig and WeekWalkTaskListModel.instance:checkPeriods(taskConfig) then
				total = total + num

				local taskMo = WeekWalkTaskListModel.instance:getTaskMo(taskId)
				local config = lua_task_weekwalk.configDict[taskId]
				local isGet = taskMo and taskMo.finishCount >= config.maxFinishCount

				if isGet then
					cur = cur + num
				end
			end
		end
	end

	self._txtprogress.text = string.format("%s/%s", cur, total)
	self._txtprogress.alpha = total <= cur and 0.45 or 1
end

function WeekWalkLayerPageItem:updateUnlockStatus()
	if not self._layerPage:getVisible() then
		return
	end

	local finishMapId = WeekWalkModel.instance:getFinishMapId()

	if finishMapId and finishMapId < self._config.id then
		self:_updateStatus()
	end
end

function WeekWalkLayerPageItem:_updateStatus()
	self._mapInfo = WeekWalkModel.instance:getMapInfo(self._config.id)

	if self._mapInfo then
		local sceneConfig = lua_weekwalk_scene.configDict[self._mapInfo.sceneId or self._config.sceneId]

		self._txtname.text = sceneConfig.name

		if self._mapInfo then
			self._txtbattlename.text = sceneConfig.battleName or luaLang("weekwalklayerpageitem_unknowdream")
		end

		if self._mapInfo then
			self._txtnameen.text = sceneConfig.name_en or "Dream To Be Dreamed"
		end

		self._txtindex.text = self._config.layer

		self._simagemapicon:LoadImage(ResUrl.getWeekWalkLayerIcon("img_" .. sceneConfig.icon))
		self:_updateProgress()

		if not self._mapInfo then
			gohelper.setActive(self._gorewardIcon, false)
			gohelper.setActive(self._gorewardfinish, false)
			gohelper.setActive(self._gonormalIcon, true)
			gohelper.setActive(self._gomapfinish, false)
			gohelper.setActive(self._gounlock, self._mapInfo)
			gohelper.setActive(self._golock, not self._mapInfo)

			return
		end

		local isUnlock = self._mapInfo
		local finishMapId = WeekWalkModel.instance:getFinishMapId()
		local showUnlockAnim = self._layerPage:getVisible() and finishMapId and finishMapId < self._config.id

		if showUnlockAnim or self._showUnlockAnim then
			WeekWalkModel.instance:setFinishMapId(nil)

			if self._mapInfo.isFinish ~= 1 then
				self:_playAnim("weekwalklayerpageitem_unlock_in")
				AudioMgr.instance:trigger(AudioEnum.WeekWalk.play_artificial_ui_unlockdream)
			end
		else
			if not self._layerPage:getVisible() and finishMapId and finishMapId < self._config.id then
				isUnlock = false
			end

			gohelper.setActive(self._gounlock, isUnlock)
			gohelper.setActive(self._golock, not isUnlock)
		end

		local mapId = self._config.id
		local taskType = WeekWalkRewardView.getTaskType(mapId)
		local canGetNum, unFinishNum = WeekWalkTaskListModel.instance:canGetRewardNum(taskType, mapId)
		local canGetReward = canGetNum > 0

		gohelper.setActive(self._gorewardIcon, canGetReward)
		gohelper.setActive(self._gorewardfinish, not canGetReward and unFinishNum <= 0)
		gohelper.setActive(self._gonormalIcon, not canGetReward and unFinishNum > 0)
		gohelper.setActive(self._gomapfinish, self._mapInfo.isFinished > 0)

		if (canGetReward or self._mapInfo.isFinished > 0) and not isUnlock then
			logError(string.format("WeekWalkLayerPageItem error unlock mapId:%s canGetReward:%s isUnlock:%s showUnlockAnim:%s self._showUnlockAnim:%s finishMapId:%s pageVisible:%s isFinished:%s", mapId, canGetReward, isUnlock, showUnlockAnim, self._showUnlockAnim, finishMapId, self._layerPage:getVisible(), self._mapInfo.isFinished))
		end
	end
end

function WeekWalkLayerPageItem:onDestroyView()
	return
end

function WeekWalkLayerPageItem:disableKeyword()
	if not self._graphics then
		return
	end

	for _, v in pairs(self._graphics) do
		v.material:DisableKeyword("_EDGE_GRADUAL")
	end
end

function WeekWalkLayerPageItem:init(go)
	self.viewGO = go

	self:onInitView()
	self:addEvents()
	self:onOpen()
end

function WeekWalkLayerPageItem:onDestroy()
	self._simageicon:UnLoadImage()
	self._simagelockicon:UnLoadImage()
	self._simagemapicon:UnLoadImage()
	self:onClose()
	self:removeEvents()
	self:disableKeyword()
	self:onDestroyView()

	if SharedMats then
		for k, mat in pairs(SharedMats) do
			gohelper.destroy(mat)

			SharedMats[k] = nil
		end

		SharedMats = {}
	end
end

return WeekWalkLayerPageItem
