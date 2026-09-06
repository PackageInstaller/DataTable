-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesswaken/view/GoddessWakenView.lua

module("logic.extensions.goddesswaken.view.GoddessWakenView", package.seeall)

local GoddessWakenView = class("GoddessWakenView", TableViewComponent)
local MAXCOUNT = 5
local PLOTDIALOGUE = "goddesswakenfirstdialogue"
local RewardState = {
	CanGet = 2,
	NoGet = 1,
	Geted = 3
}

function GoddessWakenView:ctor()
	GoddessWakenView.super.ctor(self)
end

function GoddessWakenView:buildUI()
	GoddessWakenView.super.buildUI(self)

	self._btnClose = self:getBtn("leftTop/btnClose")
	self._btnTask = self:getBtn("btnTask")
	self._btnTip = self:getBtn("leftTop/btnTip")
	self._btnInject = self:getBtn("btnInject")
	self._txtTime = self:getTxt("time/txtTime")
	self._goldBarCon = self:getGo("goldBarCon")
	self._txtInjectTip = self:getTxt("btnInject/txtInjectTip")
	self._roleGo = self:getGo("role")
	self._roleOutline = self:getGo("roleOutline")
	self._bubbleLeft = self:getGo("bubbleLeft")
	self._btnClickArea = self:getBtn("clickArea")
	self._bubblePet = self:getGo("bubblePet")
	self._redPoint = self:getGo("btnTask/redPoint")
	self._bgGo = self:getGo("bg")
	self._injectItems = {}

	for i = 1, MAXCOUNT do
		local element = {}

		element.go = self:getGo("injectItems/item" .. i)
		element.bg = self:getGo(string.format("injectItems/item%d/bg", i))
		element.imgMask = self:getImg(string.format("injectItems/item%d/bg/mask", i))
		element.progressGo = self:getGo(string.format("injectItems/item%d/bg/progress", i))
		element.txtProgress = self:getTxt(string.format("injectItems/item%d/bg/progress/txt", i))
		element.txtName = self:getTxt(string.format("injectItems/item%d/bg/txtName", i))
		element.icon = self:getGo(string.format("injectItems/item%d/icon", i))
		element.btnIcon = self:getBtn(string.format("injectItems/item%d/icon", i))
		element.txtNum = self:getTxt(string.format("injectItems/item%d/icon/txtNumber", i))
		element.btnItem = self:getBtn(string.format("injectItems/item%d", i))
		element.getedGo = self:getGo(string.format("injectItems/item%d/icon/geted", i))
		element.effectGo = self:getGo(string.format("injectItems/item%d/bg/effect", i))
		element.bgGradient = element.txtName.gameObject:GetComponent(ComponentType.UIGradient)
		element.bgOutlineEx = element.txtName.gameObject:GetComponent(ComponentType.OutlineEx)

		table.insert(self._injectItems, element)
	end

	self._changeGroup = self:getGo("changeGroup"):GetComponent(ComponentType.UIChangeGroup)

	local txtInjectName = self:getGo("btnInject/txtName")

	self._injectGradient = txtInjectName:GetComponent(ComponentType.UIGradient)
	self._injectOutlineEx = txtInjectName:GetComponent(ComponentType.OutlineEx)

	local txtTaskName = self:getGo("btnTask/txtName")

	self._taskGradient = txtTaskName:GetComponent(ComponentType.UIGradient)
	self._taskOutlineEx = txtTaskName:GetComponent(ComponentType.OutlineEx)
end

function GoddessWakenView:_getPath()
	return {
		cellPath = "tablecell",
		viewPath = "tableview"
	}
end

function GoddessWakenView:bindEvents()
	GoddessWakenView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnTask:AddClickListener(self._onClickTask, self)
	self._btnTip:AddClickListener(self._onClickTip, self)
	self._btnInject:AddClickListener(self._onClickInject, self)
	self._btnClickArea:AddClickListener(self._onClickArea, self)
end

function GoddessWakenView:unbindEvents()
	GoddessWakenView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnTask:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnInject:RemoveClickListener()
	self._btnClickArea:RemoveClickListener()
end

function GoddessWakenView:onEnter()
	GoddessWakenView.super.onEnter(self)
	self:_setBubbleLeft(false)

	self._activityId = GoddessWakenModel.instance:getActivityId()

	local isInTime = ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.GoddessWaken, self._activityId)

	if not isInTime then
		self:_showCloseTip()

		return
	end

	self._cfgActivity = GoddessWakenConfig.instance:getActivityCfg(self._activityId)

	if not self._cfgActivity then
		return
	end

	GlobalDispatcher:addListener(GlobalNotify.GoddessWakenGetInfo, self._onGetInfo, self)
	GlobalDispatcher:addListener(GlobalNotify.GoddessWakenInjectPower, self._onInjectPower, self)
	GlobalDispatcher:addListener(GlobalNotify.GoddessWakenGainProgressPrize, self._onGainProgressPrize, self)
	GlobalDispatcher:addListener(GlobalNotify.GoddessWakenGainTaskPrize, self._onGainTaskPrize, self)
	GoddessWakenModel.instance:markDailyRedPoint()

	self._petPlanId = GoddessWakenModel.instance:getPetPlanId()
	self._petPlanList = GoddessWakenConfig.instance:getPetList(self._cfgActivity.petPlanId)

	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.GoddessWaken, self._activityId)

	self._startTimestamp = startTime
	self._selectPetIndex = 1

	self:_setActivityTime(startTime, endTime)
	self:_setGoldBarCon()
	self:_setText()
	self:_initPetList()
	self:_playBgEffect()
	self:_playFirstDialogue()
	GoddessWakenAgent.instance:sendPM_GoddessWakenGetInfoReq(self._activityId)
end

function GoddessWakenView:onExit()
	GoddessWakenView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.GoddessWakenGetInfo, self._onGetInfo, self)
	GlobalDispatcher:removeListener(GlobalNotify.GoddessWakenInjectPower, self._onInjectPower, self)
	GlobalDispatcher:removeListener(GlobalNotify.GoddessWakenGainProgressPrize, self._onGainProgressPrize, self)
	GlobalDispatcher:removeListener(GlobalNotify.GoddessWakenGainTaskPrize, self._onGainTaskPrize, self)
	PetCvController.instance:turnOffCurCv(false)
	self:_clearItemRewards()
	self:_resetRoleModel()
	self:_clearEffects()
	self:_removeBgEffect()
	self:_clearDianliangEffect()
end

function GoddessWakenView:_onClickClose()
	self:close()
end

function GoddessWakenView:_onClickTask()
	UIStateManager.instance:push(ViewName.GoddessWakenTaskView, self._selectPetIndex)
end

function GoddessWakenView:_onClickTip()
	UIStateManager.instance:open(ViewName.RulesView, "goddesswakenrule")
end

function GoddessWakenView:_onClickInject()
	local cfgPet = self._petPlanList[self._selectPetIndex]

	if not cfgPet then
		return
	end

	local curProgress = GoddessWakenModel.instance:getCurInjectProgress(cfgPet.goddessId)
	local maxProgress = self:_getMaxProgress(cfgPet.qualityPlanId)
	local leftProgress = 0

	if maxProgress <= curProgress then
		FloatWordMgr.instance:show("已为当前女神注满星能")

		return
	elseif curProgress < maxProgress then
		leftProgress = maxProgress - curProgress
	end

	local matType, id, costNum = MaterialMgr.getMatParams(self._cfgActivity.cost)
	local curItemNum = MaterialModel.instance:getMaterialsNumber(matType, id)

	if curItemNum < costNum then
		FloatWordMgr.instance:show("星能数量不足")

		return
	end

	local num = Mathf.Floor(curItemNum / costNum)

	num = leftProgress < num and leftProgress or num

	GoddessWakenAgent.instance:sendPM_GoddessWakenInjectPowerReq(self._activityId, self._selectPetIndex, num)
end

function GoddessWakenView:_onClickArea()
	local cfgPet = self._petPlanList[self._selectPetIndex]

	if not cfgPet then
		return
	end

	local skinId = cfgPet.skinId

	if skinId > 0 then
		local pos = self._bubblePet.transform.position

		PetCvController.instance:playPetCv(skinId, nil, true, pos)
	end
end

function GoddessWakenView:_getMaxProgress(qualityPlanId)
	local list = GoddessWakenConfig.instance:getPlanList(qualityPlanId)
	local maxCount = #list

	if list[maxCount] then
		return list[maxCount].progress
	else
		return 0
	end
end

function GoddessWakenView:_onGetInfo()
	self:_updateMainShow(self._petPlanList[self._selectPetIndex])
	self:_updateTaskRedPoint()
	self:reloadData()
end

function GoddessWakenView:_onInjectPower()
	if self._petPlanList[self._selectPetIndex].skinId > 0 then
		self:_updateMainShow(self._petPlanList[self._selectPetIndex])
		self:reloadData()
	end
end

function GoddessWakenView:_onGainProgressPrize(goddessId, qualityId)
	if self._petPlanList[self._selectPetIndex].skinId > 0 then
		self:_updateMainShow(self._petPlanList[self._selectPetIndex])
		self:reloadData()
	end

	local petPlanId = GoddessWakenModel.instance:getPetPlanId()
	local cfgPetPlan = GoddessWakenConfig.instance:getPetCfg(petPlanId, goddessId)

	if cfgPetPlan then
		local cfg = GoddessWakenConfig.instance:getPlanCfg(cfgPetPlan.qualityPlanId, qualityId)

		if cfg then
			GlobalDispatcher:dispatch(GlobalNotify.StartStory, cfg.storyId)
		end
	end
end

function GoddessWakenView:_onGainTaskPrize()
	self:_updateTaskRedPoint()
end

function GoddessWakenView:_cellSize(view, index)
	local data = self._curViewDatas[index + 1]

	if not data.isExist then
		return 136, 192
	else
		return 136, 102
	end
end

function GoddessWakenView:_updateCell(view, cell, data)
	local headIcon = goutil.findChild(cell, "btnHead/headIcon")
	local imgUnknown = goutil.findChild(cell, "btnHead/imgUnknown")
	local select = goutil.findChild(cell, "btnHead/select")
	local vote = goutil.findChild(cell, "vote")
	local txtTip = goutil.findChildTextComponent(cell, "vote/txtTip")
	local btnHead = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnHead")
	local btnGo = Framework.ButtonAdapter.GetFrom(cell.gameObject, "vote/btnGo")
	local redPoint = goutil.findChild(cell, "redPoint")

	btnHead:AddClickListener(function()
		if self._selectPetIndex ~= data.cfg.goddessId then
			self._selectPetIndex = data.cfg.goddessId

			PetCvController.instance:turnOffCurCv(false)
			self:_setRoleShow(data.cfg.skinId, data.cfg.pos, data.cfg.scale)
			self:_updatePetList(self._selectPetIndex)
			self:_updateMainShow(data.cfg)
			self:_setBubbleLeft(not data.isExist)
		end
	end)

	local jumpTo = data.cfg.jumpTo

	btnGo:AddClickListener(function()
		if not string.nilorempty(jumpTo) then
			GotoMgr.gotoByString(jumpTo)
		end
	end)

	if data.isExist then
		goutil.setActive(vote, false)
		goutil.setActive(headIcon, true)
		goutil.setActive(imgUnknown, false)
		MaterialMgr.setIcon(headIcon, MatType.Pet, data.cfg.skinId)
	else
		MaterialMgr.clearIcon(headIcon)
		goutil.setActive(vote, true)
		goutil.setActive(headIcon, false)
		goutil.setActive(imgUnknown, true)

		local startDay = data.cfg.startDay + 1
		local duration = 100
		local availableStartTime = GameUtil.getTimestampOnStartAndEnd(self._startTimestamp, startDay, duration)
		local date = GameUtil.time2date(availableStartTime)

		txtTip.text = string.format("%d.%02d 5:00后\n开启注能", date.month, date.day)
	end

	goutil.setActive(select, data.isSelect)
	self:_updateGoddessRedPoint(redPoint, data.cfg.goddessId)
end

function GoddessWakenView:_clearTableview(cell)
	local btnHead = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnHead")
	local btnGo = Framework.ButtonAdapter.GetFrom(cell.gameObject, "vote/btnGo")
	local headIcon = goutil.findChild(cell, "btnHead/headIcon")

	btnHead:RemoveClickListener()
	btnGo:RemoveClickListener()
	MaterialMgr.clearIcon(headIcon)
end

function GoddessWakenView:_setActivityTime(startTime, endTime)
	local startDate = GameUtil.time2date(startTime)
	local endDate = GameUtil.time2date(endTime)

	self._txtTime.text = string.format("活动时间：%02d.%02d 5:00-%02d.%02d 5:00", startDate.month, startDate.day, endDate.month, endDate.day)
end

function GoddessWakenView:_setGoldBarCon()
	local cfg = self._cfgActivity
	local name = cfg.injectItemType
	local objList = {
		{
			showAdd = false,
			id = name
		}
	}

	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, objList)
end

function GoddessWakenView:_setText()
	local matType, id, costNum = MaterialMgr.getMatParams(self._cfgActivity.cost)

	self._txtInjectTip.text = string.format("每次消耗%d星能", costNum)
end

function GoddessWakenView:_initPetList()
	self._selectPetIndex = 1

	local list = {}

	for i, v in ipairs(self._petPlanList) do
		local element = {}

		element.isExist = v.skinId > 0
		element.cfg = v
		element.isSelect = self._selectPetIndex == i

		table.insert(list, element)
	end

	local cfg = self._petPlanList[self._selectPetIndex]

	self:_setRoleShow(cfg.skinId, cfg.pos, cfg.scale)
	self:updateListData(list)
	self:_updateMainShow(self._petPlanList[self._selectPetIndex])
end

function GoddessWakenView:_updatePetList(selectIndex)
	for i, v in ipairs(self._curViewDatas) do
		v.isSelect = selectIndex == i
	end

	self:reloadData()
end

function GoddessWakenView:_updateMainShow(cfg)
	printInfo("test 精灵品质id", self._selectPetIndex, cfg.qualityPlanId)
	self:_clearItemRewards()
	self:_clearEffects()
	self._changeGroup:SetState(self._selectPetIndex - 1)

	local qualityPlanId = cfg.qualityPlanId
	local isExist = cfg.skinId > 0

	goutil.setActive(self._btnInject.gameObject, isExist)

	local cfgList = GoddessWakenConfig.instance:getPlanList(qualityPlanId)
	local curProgress = GoddessWakenModel.instance:getCurInjectProgress(self._selectPetIndex)

	for i, v in ipairs(cfgList) do
		if self._injectItems[i] then
			local element = self._injectItems[i]
			local rewardState = RewardState.NoGet

			if isExist then
				GameUtil.setWidth(element.go, 202)
				goutil.setActive(element.bg, true)

				element.txtName.text = v.name

				local maxProgress = 1

				maxProgress = i == 1 and v.progress or v.progress - cfgList[i - 1].progress

				if curProgress < maxProgress then
					if curProgress == 0 then
						element.txtProgress.text = string.format("%d/%d", 0, maxProgress)
						element.imgMask.fillAmount = 1
					else
						element.txtProgress.text = string.format("%d/%d", curProgress, maxProgress)
						element.imgMask.fillAmount = Mathf.Clamp(1 - curProgress / maxProgress, 0, 1)
						curProgress = 0
					end
				else
					element.txtProgress.text = string.format("%d/%d", maxProgress, maxProgress)
					element.imgMask.fillAmount = 0
					curProgress = curProgress - maxProgress

					local isGeted = GoddessWakenModel.instance:isInjectRewardGeted(cfg.goddessId, v.qualityId)

					rewardState = isGeted and RewardState.Geted or RewardState.CanGet
				end
			else
				GameUtil.setWidth(element.go, 102)
				goutil.setActive(element.bg, false)
			end

			local matType, id, matNum = MaterialMgr.getMatParams(v.prize)

			MaterialMgr.setIcon(element.icon, matType, id)

			element.txtNum.text = matNum

			element.btnIcon:AddClickListener(function()
				if rewardState == RewardState.CanGet then
					GoddessWakenAgent.instance:sendPM_GoddessWakenGainProgressPrizeReq(self._activityId, cfg.goddessId, v.qualityId)
				elseif not goutil.isNil(element.icon) then
					CommonTipsMgr.instance:openMaterialTips(element.icon, matType, id, 0)
				end
			end)
			element.btnItem:AddClickListener(function()
				if rewardState == RewardState.Geted then
					GlobalDispatcher:dispatch(GlobalNotify.StartStory, v.storyId)
				end
			end)

			if rewardState == RewardState.CanGet then
				self:_loadEffect(element.icon)
			end

			goutil.setActive(element.getedGo, rewardState == RewardState.Geted)
			goutil.setActive(element.effectGo, rewardState ~= RewardState.NoGet)
			goutil.setActive(element.progressGo, rewardState == RewardState.NoGet)
			self:_updateDianliangEffect(i, rewardState ~= RewardState.NoGet, element.effectGo.transform)

			local cfg = GoddessWakenConfig.instance:getUICfg(self._petPlanId, self._selectPetIndex)

			if cfg then
				local color2 = GameUtil.getColorByHexColor(cfg.color2, true)
				local color3 = GameUtil.getColorByHexColor(cfg.color3, true)

				element.bgGradient:SetColor(UnityEngine.Color32.New(color2.r, color2.g, color2.b, color2.a), UnityEngine.Color32.New(color3.r, color3.g, color3.b, color3.a))

				local outColor = GameUtil.getColorByHexColor(cfg.color1)

				element.bgOutlineEx:SetColorRGBA(outColor.r, outColor.g, outColor.b, outColor.a)
				self:_updateBtnColor(cfg)
			end
		end
	end
end

function GoddessWakenView:_updateBtnColor(cfg)
	local color5 = GameUtil.getColorByHexColor(cfg.color5, true)
	local color6 = GameUtil.getColorByHexColor(cfg.color6, true)

	self._injectGradient:SetColor(UnityEngine.Color32.New(color5.r, color5.g, color5.b, color5.a), UnityEngine.Color32.New(color6.r, color6.g, color6.b, color6.a))

	local outInjectColor = GameUtil.getColorByHexColor(cfg.color4)

	self._injectOutlineEx:SetColorRGBA(outInjectColor.r, outInjectColor.g, outInjectColor.b, outInjectColor.a)

	local color8 = GameUtil.getColorByHexColor(cfg.color8, true)
	local color9 = GameUtil.getColorByHexColor(cfg.color9, true)

	self._taskGradient:SetColor(UnityEngine.Color32.New(color8.r, color8.g, color8.b, color8.a), UnityEngine.Color32.New(color9.r, color9.g, color9.b, color9.a))

	local outtaskColor = GameUtil.getColorByHexColor(cfg.color7)

	self._taskOutlineEx:SetColorRGBA(outtaskColor.r, outtaskColor.g, outtaskColor.b, outtaskColor.a)
end

function GoddessWakenView:_updateDianliangEffect(index, isShow, transform)
	self._dianliangDic = self._dianliangDic or {}

	if isShow then
		if not self._dianliangDic[index] then
			local effectPath = GoddessWakenViewPresentor.DianLiang
			local uiEffect = UIEffectManager.instance:playEffect(self, effectPath, transform, 0, 0, true, false)

			uiEffect:setParent(transform)
			uiEffect:setScale(1)

			uiEffect.hideEffWhileNotOnTop = false
			self._dianliangDic[index] = uiEffect
		end
	elseif self._dianliangDic[index] then
		UIEffectManager.instance:stopEffect(self._dianliangDic[index])

		self._dianliangDic[index] = nil
	end
end

function GoddessWakenView:_clearDianliangEffect()
	if self._dianliangDic then
		for i = 1, MAXCOUNT do
			if self._dianliangDic[i] then
				UIEffectManager.instance:stopEffect(self._dianliangDic[i])

				self._dianliangDic[i] = nil
			end
		end

		table.clear(self._dianliangDic)
	end
end

function GoddessWakenView:_clearItemRewards()
	for i, v in ipairs(self._injectItems) do
		v.btnIcon:RemoveClickListener()
		MaterialMgr.clearIcon(v.icon)
	end
end

function GoddessWakenView:_loadEffect(parent)
	self._effectList = self._effectList or {}

	local effectPath = "fx_ui_fuli/fx_ui_fuli_lingqu.prefab"
	local uiEffect = UIEffectManager.instance:playEffect(self, effectPath, parent.transform, 0, 0, true, false)

	uiEffect:setParent(parent.transform)
	uiEffect:setScale(0.8)
	table.insert(self._effectList, uiEffect)
end

function GoddessWakenView:_clearEffects()
	if self._effectList then
		for i, v in ipairs(self._effectList) do
			UIEffectManager.instance:stopEffect(v)
		end

		table.clear(self._effectList)
	end
end

function GoddessWakenView:_setRoleShow(curFaceId, pos, scale)
	if curFaceId > 0 then
		self:_showRoleModel(curFaceId, pos, scale)
		goutil.setActive(self._roleOutline, false)
	else
		self:_resetRoleModel()
		goutil.setActive(self._roleOutline, true)
	end
end

function GoddessWakenView:_showRoleModel(curFaceId, pos, scale)
	local x, y, realScale = 0, 0, 1

	x = checknumber(pos[1])
	y = checknumber(pos[2])

	self:_resetRoleModel()

	self.loader = RoleObjectPool.instance:addRoleToParent(self.loader, curFaceId, self._roleGo, scale[1], nil, true, x, y)
end

function GoddessWakenView:_resetRoleModel()
	self.loader = RoleObjectPool.instance:removeRole(self.loader)
end

function GoddessWakenView:_setBubbleLeft(active)
	goutil.setActive(self._bubbleLeft, active)
end

function GoddessWakenView:_updateTaskRedPoint()
	goutil.setActive(self._redPoint, GoddessWakenModel.instance:isTaskRewardCanGet())
end

function GoddessWakenView:_updateGoddessRedPoint(redPoint, goddessId)
	goutil.setActive(redPoint, GoddessWakenModel.instance:isInjectRewardCanGet(goddessId))
end

function GoddessWakenView:_playBgEffect()
	local effectPath = GoddessWakenViewPresentor.FenWei
	local uiEffect = UIEffectManager.instance:playEffect(self, effectPath, self._bgGo.transform, 0, 0, true, false)

	uiEffect:setParent(self._bgGo.transform)
	uiEffect:setScale(1)

	uiEffect.hideEffWhileNotOnTop = false
	self._bgEffect = uiEffect
end

function GoddessWakenView:_removeBgEffect()
	if self._bgEffect then
		UIEffectManager.instance:stopEffect(self._bgEffect)

		self._bgEffect = nil
	end
end

function GoddessWakenView:_playFirstDialogue()
	local isPlayed = GameUtil.getUserData(PLOTDIALOGUE)

	if not isPlayed then
		GameUtil.saveUserData(PLOTDIALOGUE, true)

		local dialogueId = 4180021

		GlobalDispatcher:dispatch(GlobalNotify.StartStory, dialogueId)
	end
end

return GoddessWakenView
