-- chunkname: @modules/logic/weekwalk/view/WeekWalkRewardItem.lua

module("modules.logic.weekwalk.view.WeekWalkRewardItem", package.seeall)

local WeekWalkRewardItem = class("WeekWalkRewardItem", ListScrollCellExtend)

function WeekWalkRewardItem:onInitView()
	self._gonormal = gohelper.findChild(self.viewGO, "#go_normal")
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#go_normal/#simage_bg")
	self._txttaskdes = gohelper.findChildText(self.viewGO, "#go_normal/#txt_taskdes")
	self._imageprogress = gohelper.findChildImage(self.viewGO, "#go_normal/progressbar/#image_progress")
	self._gorewards = gohelper.findChild(self.viewGO, "#go_normal/#go_rewards")
	self._gorewarditem = gohelper.findChild(self.viewGO, "#go_normal/#go_rewards/#go_rewarditem")
	self._gonotget = gohelper.findChild(self.viewGO, "#go_normal/#go_notget")
	self._btnnotfinishbg = gohelper.findChildButtonWithAudio(self.viewGO, "#go_normal/#go_notget/#btn_notfinishbg")
	self._btnfinishbg = gohelper.findChildButtonWithAudio(self.viewGO, "#go_normal/#go_notget/#btn_finishbg")
	self._goblackmask = gohelper.findChild(self.viewGO, "#go_normal/#go_blackmask")
	self._goget = gohelper.findChild(self.viewGO, "#go_normal/#go_get")
	self._gogetall = gohelper.findChild(self.viewGO, "#go_getall")
	self._simagegetallbg = gohelper.findChildSingleImage(self.viewGO, "#go_getall/#simage_getallbg")
	self._btncollectall = gohelper.findChildButtonWithAudio(self.viewGO, "#go_getall/go_getall/#btn_collectall")
	self._gofullprogress = gohelper.findChild(self.viewGO, "#go_normal/progressbar/#go_fullprogress")
	self._txtindex = gohelper.findChildText(self.viewGO, "#go_normal/#txt_index")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function WeekWalkRewardItem:addEvents()
	self._btnnotfinishbg:AddClickListener(self._btnnotfinishbgOnClick, self)
	self._btnfinishbg:AddClickListener(self._btnfinishbgOnClick, self)
	self._btncollectall:AddClickListener(self._btncollectallOnClick, self)
end

function WeekWalkRewardItem:removeEvents()
	self._btnnotfinishbg:RemoveClickListener()
	self._btnfinishbg:RemoveClickListener()
	self._btncollectall:RemoveClickListener()
end

function WeekWalkRewardItem:_btncollectallOnClick()
	WeekWalkController.instance:dispatchEvent(WeekWalkEvent.OnGetTaskReward, self)
	TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.WeekWalk, self._mo.minTypeId)
end

function WeekWalkRewardItem:_btnnotfinishbgOnClick()
	local paramList = string.split(self._mo.listenerParam, "#")
	local mapId = paramList[1]

	WeekWalkController.instance:openWeekWalkLayerView({
		mapId = tonumber(mapId)
	})
end

function WeekWalkRewardItem:_btnfinishbgOnClick()
	WeekWalkController.instance:dispatchEvent(WeekWalkEvent.OnGetTaskReward, self)
	TaskRpc.instance:sendFinishTaskRequest(self._mo.id)
end

function WeekWalkRewardItem:_editableInitView()
	self._rewardItems = self:getUserDataTb_()
	self._canvasgroup = self.viewGO:GetComponent(typeof(UnityEngine.CanvasGroup))
	self._animator = SLFramework.AnimatorPlayer.Get(self.viewGO)

	self:_getGraphicMats()
	gohelper.setActive(self.viewGO, false)
	self._simagegetallbg:LoadImage(ResUrl.getWeekWalkBg("btn_yijiandi.png"))
end

function WeekWalkRewardItem:_editableAddEvents()
	gohelper.addUIClickAudio(self._btnnotfinishbg.gameObject, AudioEnum.UI.play_ui_activity_jump)
	gohelper.addUIClickAudio(self._btnfinishbg.gameObject, AudioEnum.WeekWalk.play_artificial_ui_taskreceive)
	gohelper.addUIClickAudio(self._btncollectall.gameObject, AudioEnum.WeekWalk.play_artificial_ui_taskreceive)
end

function WeekWalkRewardItem:_editableRemoveEvents()
	return
end

function WeekWalkRewardItem:_playAnim()
	if self._firstPlayAnim then
		return
	end

	self._firstPlayAnim = true

	local startTime = WeekWalkTaskListModel.instance.openRewardTime

	if Time.time - startTime >= 0.5 then
		gohelper.setActive(self.viewGO, true)

		return
	end

	local index = self._index - 1
	local time = index * 0.07

	TaskDispatcher.runDelay(self._delayPlayAnim, self, time)
end

function WeekWalkRewardItem:_delayPlayAnim()
	self:_playAnimName(UIAnimationName.Open)
end

function WeekWalkRewardItem:_playAnimName(name, callback, callbackTarget)
	gohelper.setActive(self.viewGO, true)

	if self.viewGO.activeInHierarchy then
		self._animator:Play(name, self._playAnimDone, self)
	end
end

function WeekWalkRewardItem:_playAnimDone()
	return
end

function WeekWalkRewardItem:playOutAnim()
	gohelper.setActive(self._goblackmask, true)
	self:_playAnimName("out")
end

function WeekWalkRewardItem:onUpdateMO(mo)
	self._canvasgroup.alpha = mo.isDirtyData and 0 or 1
	self._canvasgroup.interactable = not mo.isDirtyData
	self._canvasgroup.blocksRaycasts = not mo.isDirtyData
	self._canGet = false

	if mo.isDirtyData then
		return
	end

	self._mo = mo

	gohelper.setActive(self._gonormal, not mo.isGetAll)
	gohelper.setActive(self._gogetall, mo.isGetAll)

	if mo.isGetAll then
		self._canGet = true

		self:_playAnim()

		return
	end

	self._config = lua_task_weekwalk.configDict[mo.id]

	local layerId = tonumber(mo.layerId)

	if layerId and layerId > 0 then
		local map = WeekWalkModel.instance:getMapInfo(layerId)
		local layerConfig = lua_weekwalk.configDict[layerId]

		if map then
			if not map.sceneId then
				local sceneId = layerConfig.sceneId
				local sceneConfig = lua_weekwalk_scene.configDict[sceneId]

				self._txttaskdes.text = string.format(mo.desc, sceneConfig.battleName)
			end
		end
	else
		self._txttaskdes.text = mo.desc
	end

	self._txtindex.text = string.format("%02d", self._mo.id - 71000)

	self:_addRewards()
	self:_updateStatus()
	self:_setMaterialAndOpenEdgFade()
	self:_playAnim()
end

local SharedMats

function WeekWalkRewardItem:_getGraphicMats()
	local container = ViewMgr.instance:getContainer(ViewName.WeekWalkRewardView)
	local imgMatPath = container:getSetting().otherRes[2]
	local imgMatInstance = container._abLoader:getAssetItem(imgMatPath):GetResource()

	SharedMats = SharedMats or self:getUserDataTb_()
	SharedMats.imgMat = imgMatInstance

	self:_setMaterialAndOpenEdgFade()
end

local BottomGradualCtrl = UnityEngine.Shader.PropertyToID("_BottomGradualCtrl")
local BottomGradualColor = Color.New(7.6, -3.44, 0, 0)

function WeekWalkRewardItem:_setMaterialAndOpenEdgFade()
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

				targetMatInstance:SetColor(BottomGradualCtrl, BottomGradualColor)

				SharedMats[cloneMatName] = targetMatInstance
			end

			current.fontSharedMaterial = targetMatInstance
		else
			current.material = SharedMats and SharedMats.imgMat
		end
	end

	for _, v in pairs(SharedMats) do
		v:EnableKeyword("_BOTTOM_GRADUAL")
	end
end

function WeekWalkRewardItem:_updateStatus()
	self._taskMo = WeekWalkTaskListModel.instance:getTaskMo(self._mo.id)

	if not self._taskMo then
		return
	end

	self._imageprogress.fillAmount = self._taskMo.progress / self._config.maxProgress

	gohelper.setActive(self._gofullprogress, self._taskMo.progress >= self._config.maxProgress)

	local isGet = self._taskMo.finishCount >= self._config.maxFinishCount

	gohelper.setActive(self._gonotget, not isGet)
	gohelper.setActive(self._goget, isGet)
	gohelper.setActive(self._goblackmask, isGet)

	if not isGet then
		local isFinish = self._taskMo.hasFinished

		gohelper.setActive(self._btnnotfinishbg.gameObject, not isFinish)
		gohelper.setActive(self._btnfinishbg.gameObject, isFinish)

		self._canGet = isFinish
	end

	local itemBgName = not isGet and self._taskMo.hasFinished and "img_bg_claim_hl.png" or "img_bg_claim_nor.png"

	self._simagebg:LoadImage(ResUrl.getWeekWalkBg(itemBgName))
end

function WeekWalkRewardItem:_addRewards()
	for _, v in pairs(self._rewardItems) do
		gohelper.destroy(v.itemIcon.go)
		gohelper.destroy(v.parentGo)
		v.itemIcon:onDestroy()
	end

	self._rewardItems = self:getUserDataTb_()

	local rewards = string.split(self._mo.bonus, "|")

	for i = 1, #rewards do
		local item = {}

		item.parentGo = gohelper.cloneInPlace(self._gorewarditem)

		gohelper.setActive(item.parentGo, true)

		local itemCo = string.splitToNumber(rewards[i], "#")

		item.itemIcon = IconMgr.instance:getCommonPropItemIcon(item.parentGo)

		item.itemIcon:setMOValue(itemCo[1], itemCo[2], itemCo[3], nil, true)
		item.itemIcon:isShowCount(itemCo[1] ~= MaterialEnum.MaterialType.Hero)
		item.itemIcon:setCountFontSize(40)
		item.itemIcon:showStackableNum2()
		item.itemIcon:setHideLvAndBreakFlag(true)
		item.itemIcon:hideEquipLvAndBreak(true)
		table.insert(self._rewardItems, item)
	end
end

function WeekWalkRewardItem:onSelect(isSelect)
	return
end

function WeekWalkRewardItem:onDestroyView()
	for _, v in pairs(self._rewardItems) do
		gohelper.destroy(v.itemIcon.go)
		gohelper.destroy(v.parentGo)
		v.itemIcon:onDestroy()
	end

	self._rewardItems = nil

	self._simagebg:UnLoadImage()
	self._simagegetallbg:UnLoadImage()

	if self._matLoader then
		self._matLoader:dispose()

		self._matLoader = nil
	end

	if SharedMats then
		for k, v in pairs(SharedMats) do
			v:DisableKeyword("_BOTTOM_GRADUAL")

			if k ~= "imgMat" then
				gohelper.destroy(v)
			end

			SharedMats[k] = nil
		end

		SharedMats = nil
	end

	TaskDispatcher.cancelTask(self._delayPlayAnim, self)
end

return WeekWalkRewardItem
