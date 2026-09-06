-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/growup/view/HeartGrowUpTaskView.lua

module("logic.extensions.growup.view.HeartGrowUpTaskView", package.seeall)

local HeartGrowUpTaskView = class("HeartGrowUpTaskView", ViewComponent)

function HeartGrowUpTaskView:unbindEvents()
	HeartGrowUpTaskView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._tipBtn:RemoveClickListener()
	self._levelBtn:RemoveClickListener()
	self._starBtn:RemoveClickListener()
	self._equipBtn:RemoveClickListener()
	self._potentialBtn:RemoveClickListener()
	self._awakeBtn:RemoveClickListener()
	self._helpBtn:RemoveClickListener()
end

function HeartGrowUpTaskView:bindEvents()
	HeartGrowUpTaskView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._tipBtn:AddClickListener(self._onClickTip, self)
	self._levelBtn:AddClickListener(self._onClickLevel, self)
	self._starBtn:AddClickListener(self._onClickStar, self)
	self._equipBtn:AddClickListener(self._onClickEquip, self)
	self._potentialBtn:AddClickListener(self._onClickPotential, self)
	self._awakeBtn:AddClickListener(self._onClickAwake, self)
	self._helpBtn:AddClickListener(self._onClickHelp, self)
end

function HeartGrowUpTaskView:buildUI()
	HeartGrowUpTaskView.super.buildUI(self)

	self._bg = self:getGo("bg")
	self._closeBtn = self:getBtn("bg/topleft/btnClose")
	self._tipBtn = self:getBtn("bg/topleft/btnTip")
	self._role = self:getGo("bg/pet/con")
	self._infoGo = self:getGo("bg/pet/info")
	self._quality = self:getGo("bg/pet/info/quality")
	self._desc = self:getTxt("bg/pet/info/desc")
	self._name = self:getTxt("bg/pet/info/name")
	self._attrBg = self:getGo("bg/pet/info/attrBg")
	self._attrIcon = goutil.findChildComponent(self._attrBg, "img", ComponentType.UIImageSpriteChange)
	self._jobBg = self:getGo("bg/pet/info/jobBg_1")
	self._jobIcon = goutil.findChildComponent(self._jobBg, "icon", ComponentType.UIImageSpriteChange)
	self._jobBg2 = self:getGo("bg/pet/info/jobBg_2")
	self._jobIcon2 = goutil.findChildComponent(self._jobBg2, "icon", ComponentType.UIImageSpriteChange)
	self._powerTransform = self:getGo("bg/pet/info/ImgZdl"):GetComponent(goutil.Type_RectTransform)
	self._powerTxt = self:getTxt("bg/pet/info/ImgZdl/TxtZdl")
	self._helpBtn = self:getBtn("bg/pet/info/help")
	self._helpBubble = self:getGo("bg/pet/info/help/bubble")
	self._helpBubbleTxt = self:getGo("bg/pet/info/help/bubble/txtDesc")
	self._levelBtn = self:getBtn("bg/pet/levelBtn")
	self._levelBtnImageChange = self._levelBtn:GetComponent(ComponentType.UIImageSpriteChange)
	self._levelBtnRed = self:getGo("bg/pet/levelBtn/red")
	self._levelBtnIcon = self:getGo("bg/pet/levelBtn/txtIntegral/icon")
	self._levelBtnText = self:getTxt("bg/pet/levelBtn/Text")
	self._levelIntegral = self:getTxt("bg/pet/levelBtn/txtIntegral")
	self._starBtn = self:getBtn("bg/pet/starBtn")
	self._starBtnImageChange = self._starBtn:GetComponent(ComponentType.UIImageSpriteChange)
	self._starBtnRed = self:getGo("bg/pet/starBtn/red")
	self._starBtnIcon = self:getGo("bg/pet/starBtn/txtIntegral/icon")
	self._starBtnText = self:getTxt("bg/pet/starBtn/Text")
	self._starIntegral = self:getTxt("bg/pet/starBtn/txtIntegral")
	self._equipBtn = self:getBtn("bg/pet/equipBtn")
	self._equipBtnImageChange = self._equipBtn:GetComponent(ComponentType.UIImageSpriteChange)
	self._equipBtnRed = self:getGo("bg/pet/equipBtn/red")
	self._equipBtnIcon = self:getGo("bg/pet/equipBtn/txtIntegral/icon")
	self._equipStar = {}

	for i = 1, 5 do
		self._equipStar[i] = self:getGo("bg/pet/equipBtn/star/star_" .. i)
	end

	self._equipIntegral = self:getTxt("bg/pet/equipBtn/txtIntegral")
	self._potentialBtn = self:getBtn("bg/pet/potentialBtn")
	self._potentialBtnImageChange = self._potentialBtn:GetComponent(ComponentType.UIImageSpriteChange)
	self._potentialBtnRed = self:getGo("bg/pet/potentialBtn/red")
	self._potentialBtnIcon = self:getGo("bg/pet/potentialBtn/txtIntegral/icon")
	self._potentialBtnText = self:getTxt("bg/pet/potentialBtn/Text")
	self._potentialIntegral = self:getTxt("bg/pet/potentialBtn/txtIntegral")
	self._awakeBtn = self:getBtn("bg/pet/awakeBtn")
	self._awakeBtnImageChange = self._awakeBtn:GetComponent(ComponentType.UIImageSpriteChange)
	self._awakeBtnRed = self:getGo("bg/pet/awakeBtn/red")
	self._awakeBtnIcon = self:getGo("bg/pet/awakeBtn/txtIntegral/icon")
	self._awakeBtnText = self:getTxt("bg/pet/awakeBtn/Text")
	self._awakeIntegral = self:getTxt("bg/pet/awakeBtn/txtIntegral")
	self._taskCell = self:getGo("bg/taskCell")
	self._taskViewGo = self:getGo("bg/taskView")
	self._taskViewMask = self:getGo("bg/taskView/Viewport")
	self._taskView = ScrollerList.create(self._taskViewGo, self._taskCell, GameUtil.handler(self._updateTaskCell, self), GameUtil.handler(self._clearCell, self))
	self._goldBar = self:getGo("bg/goldBar")
	self._itemCell = self:getGo("itemCell")
end

function HeartGrowUpTaskView:onExit()
	HeartGrowUpTaskView.super.onExit(self)
	MaterialMgr.clearIcon(self._levelBtnIcon)
	MaterialMgr.clearIcon(self._starBtnIcon)
	MaterialMgr.clearIcon(self._equipBtnIcon)
	MaterialMgr.clearIcon(self._potentialBtnIcon)
	MaterialMgr.clearIcon(self._awakeBtnIcon)
	UIEffectManager.instance:stopEffect(self._strengthEff)
	self._taskView:dispose()

	self._roleObj = RoleObjectPool.instance:removeRole(self._roleObj)

	GlobalDispatcher:removeListener(GrowUpRoadController.PM_PetGrowthPathGetTaskInfosRes, self._handlePM_PetGrowthPathGetTaskInfosRes, self)
	GlobalDispatcher:removeListener(GrowUpRoadController.PM_PetGrowthPathGainTaskPrizeRes, self._handlePM_PetGrowthPathGainTaskPrizeRes, self)
	GlobalDispatcher:removeListener(GrowUpRoadController.PM_PetGrowthPathStrengthenRes, self._handlePM_PetGrowthPathStrengthenRes, self)
end

function HeartGrowUpTaskView:onEnter()
	HeartGrowUpTaskView.super.onEnter(self)

	local openParam = self:getOpenParam()

	self._activityInfo = openParam[1]

	GlobalDispatcher:addListener(GrowUpRoadController.PM_PetGrowthPathGetTaskInfosRes, self._handlePM_PetGrowthPathGetTaskInfosRes, self)
	GlobalDispatcher:addListener(GrowUpRoadController.PM_PetGrowthPathGainTaskPrizeRes, self._handlePM_PetGrowthPathGainTaskPrizeRes, self)
	GlobalDispatcher:addListener(GrowUpRoadController.PM_PetGrowthPathStrengthenRes, self._handlePM_PetGrowthPathStrengthenRes, self)

	self._cellProxy = {}

	PetGrowthPathAgent.instance:sendPM_PetGrowthPathGetTaskInfosReq(self._activityInfo.activityId)

	self._roleObj = RoleObjectPool.instance:addRoleToParent(self._roleObj, self._activityInfo.raceId, self._role, nil, nil, true)

	local petCo = CharacterConfig.instance:getPetCo(self._activityInfo.raceId)
	local race = PetSkinConfig.instance:getFisrtEleAttrIdx(self._activityInfo.raceId)

	race = race % 10

	self._attrIcon:SetState(race - 1)

	local firstJobIdx = PetSkinConfig.instance:getFirstJobIdx(self._activityInfo.raceId)

	self._jobIcon:SetState(firstJobIdx - 1)

	local secondJobIdx = PetSkinConfig.instance:getSecondJobIdx(self._activityInfo.raceId)

	goutil.setActive(self._jobBg2, secondJobIdx > 0)

	if secondJobIdx > 0 then
		self._jobIcon2:SetState(secondJobIdx - 1 - 20)
	end

	self._desc.text = petCo.stragegy
	self._strengthPlan = GrowUpRoadConfig.instance:getStrengthById(self._activityInfo.strengthenPlanId)
	self._levelIntegral.text = "x" .. self._strengthPlan[1].needScore
	self._starIntegral.text = "x" .. self._strengthPlan[2].needScore
	self._equipIntegral.text = "x" .. self._strengthPlan[3].needScore
	self._potentialIntegral.text = "x" .. self._strengthPlan[4].needScore
	self._awakeIntegral.text = "x" .. self._strengthPlan[5].needScore
	self._scoreStr = MatType.Item_Fake .. ":" .. self._activityInfo.scoreId

	MaterialMgr.setIcon(self._levelBtnIcon, MatType.Item_Fake, self._activityInfo.scoreId)
	MaterialMgr.setIcon(self._starBtnIcon, MatType.Item_Fake, self._activityInfo.scoreId)
	MaterialMgr.setIcon(self._equipBtnIcon, MatType.Item_Fake, self._activityInfo.scoreId)
	MaterialMgr.setIcon(self._potentialBtnIcon, MatType.Item_Fake, self._activityInfo.scoreId)
	MaterialMgr.setIcon(self._awakeBtnIcon, MatType.Item_Fake, self._activityInfo.scoreId)

	local objList = {
		{
			showAdd = false,
			id = self._scoreStr
		}
	}

	MainUIController.instance:showGlodBar(self._goldBar, self._viewPresentor, objList)
	goutil.setActive(self._helpBubble, false)

	local flag = openParam[2] == GameEnum.GrowUpRoad.RightTask

	Framework.TransformUtil.SetLocalScale(self._bg.transform, flag and -1 or 1, 1, 1)
	Framework.TransformUtil.SetAnchoredPos(self._bg:GetComponent(goutil.Type_RectTransform), flag and -10 or 10, -11)
	Framework.TransformUtil.SetLocalScale(self._tipBtn.transform, flag and -1 or 1, 1, 1)
	Framework.TransformUtil.SetLocalScale(self._infoGo.transform, flag and -1 or 1, 1, 1)
	self:_reverseBtn(self._levelBtn.transform, flag)
	self:_reverseBtn(self._starBtn.transform, flag)
	self:_reverseBtn(self._equipBtn.transform, flag)
	self:_reverseBtn(self._potentialBtn.transform, flag)
	self:_reverseBtn(self._awakeBtn.transform, flag)
	Framework.TransformUtil.SetLocalScale(self._taskViewMask.transform, flag and -1 or 1, 1, 1)
	Framework.TransformUtil.SetLocalScale(self._goldBar.transform, flag and -1 or 1, 1, 1)
	Framework.TransformUtil.SetAnchoredPos(self._taskViewGo:GetComponent(goutil.Type_RectTransform), flag and 567 or -64.5, 274.3)
	Framework.TransformUtil.SetAnchoredPos(self._helpBtn.gameObject:GetComponent(goutil.Type_RectTransform), flag and -36 or 62.5, 88)
	Framework.TransformUtil.SetLocalScale(self._helpBubble.transform, flag and -1 or 1, 1, 1)
	Framework.TransformUtil.SetAnchoredPos(self._helpBubble:GetComponent(goutil.Type_RectTransform), flag and -72.7 or 60, 62.8)
	Framework.TransformUtil.SetLocalScale(self._helpBubbleTxt.transform, flag and -1 or 1, 1, 1)
	Framework.TransformUtil.SetAnchoredPos(self._closeBtn:GetComponent(goutil.Type_RectTransform), flag and -1190 or 30, 4)
	Framework.TransformUtil.SetAnchoredPos(self._powerTransform, flag and -218 or 218, -231)
end

function HeartGrowUpTaskView:_reverseBtn(transform, flag)
	for i = 0, transform.childCount - 1 do
		Framework.TransformUtil.SetLocalScale(transform:GetChild(i), flag and -1 or 1, 1, 1)
	end

	local txtIntegral = goutil.findChild(transform, "txtIntegral")

	if txtIntegral then
		local x, y = Framework.TransformUtil.GetAnchoredPos(txtIntegral:GetComponent(goutil.Type_RectTransform), 0, 0)

		Framework.TransformUtil.SetAnchoredPos(txtIntegral:GetComponent(goutil.Type_RectTransform), math.abs(x) * (flag and -1 or 1), y)
	end
end

function HeartGrowUpTaskView:_handlePM_PetGrowthPathGetTaskInfosRes()
	self._petInfo = GrowUpRoadController.instance:getPetInfo(self._activityInfo.raceId)

	goutil.setActive(self._helpBtn.gameObject, self._petInfo.sham)

	self._name.text = self._petInfo.name

	local proxy = MaterialMgr.setCell(MatType.Rare, self._activityInfo.raceId, self._quality)

	proxy.binder:setRare(self._petInfo.rare)

	self._powerTxt.text = self._petInfo:getFightingPower()
	self._levelBtnText.text = lang("tip_level") .. self._petInfo.level

	local maxLv = 0

	if self._petInfo.sham then
		maxLv = self._petInfo.starLv
	else
		for i, starGod in ipairs(self._petInfo.starGodPlusSlots) do
			local Lv = StargodplusModel.instance:getSlotLv(i, starGod.exp)

			if maxLv < Lv then
				maxLv = Lv
			end
		end
	end

	self._starBtnText.text = lang("tip_stargod") .. maxLv
	maxLv = 0

	if self._petInfo.sham then
		maxLv = self._petInfo.equipLv
	else
		local list = PetEquipModel.instance:GetWearEquipInfosByPetInfo(self._petInfo)

		for k, v in pairs(list) do
			if v.info and maxLv < v.info.starCount then
				maxLv = v.info.starCount
			end
		end

		if self._petInfo.decoration and maxLv < self._petInfo.decoration.starCount then
			maxLv = self._petInfo.decoration.starCount
		end
	end

	for i, v in ipairs(self._equipStar) do
		goutil.setActive(v, i <= maxLv)
	end

	maxLv = self._petInfo.sham and self._petInfo.potential or math.max(math.max(self._petInfo.normalSkillLv, self._petInfo.ultimateSkillLv), self._petInfo.passiveSkillLv)
	self._potentialBtnText.text = maxLv
	self._awakeBtnText.text = self._petInfo.awakeLevel == 0 and lang("tip_null_awake") or GameEnum.RomanNumber[self._petInfo.awakeLevel]

	self._taskView:reloadData(GrowUpRoadController.instance:getTaskContentByPlanId(self._activityInfo.taskPlanId))
	self:_updateStrengBtn()
end

function HeartGrowUpTaskView:_handlePM_PetGrowthPathGainTaskPrizeRes()
	self._taskView:refresh(GrowUpRoadController.instance:getTaskContentByPlanId(self._activityInfo.taskPlanId))
end

function HeartGrowUpTaskView:_handlePM_PetGrowthPathStrengthenRes()
	self:_handlePM_PetGrowthPathGetTaskInfosRes()
	UIEffectManager.instance:stopEffect(self._strengthEff)

	self._strengthEff = UIEffectManager.instance:playEffect(self, "fx_ui_20211014/chengzhangzhilu/fx_ui_chengzhang_xxnn.prefab", nil, nil, nil, false, nil, nil, function(_, eff)
		if GrowUpRoadModel.instance:getCurStrengthenType() == 1 then
			eff:setParent(self._levelBtn.transform)
		elseif GrowUpRoadModel.instance:getCurStrengthenType() == 2 then
			eff:setParent(self._starBtn.transform)
		elseif GrowUpRoadModel.instance:getCurStrengthenType() == 3 then
			eff:setParent(self._equipBtn.transform)
		elseif GrowUpRoadModel.instance:getCurStrengthenType() == 4 then
			eff:setParent(self._potentialBtn.transform)
		elseif GrowUpRoadModel.instance:getCurStrengthenType() == 5 then
			eff:setParent(self._awakeBtn.transform)
		end

		eff:setScale(1)
		eff:setLocalPos()
	end)

	self:_updateStrengBtn()
end

function HeartGrowUpTaskView:_onClickTip()
	UIStateManager.instance:push(ViewName.RulesView, self._activityInfo.taskRule)
end

function HeartGrowUpTaskView:_onClickLevel()
	if GrowUpRoadModel.instance:getCurStrengthenType() <= 0 and MaterialFacade.instance:getMatNumber(MatType.Item_Fake, self._activityInfo.scoreId) >= self._strengthPlan[1].needScore then
		UIStateManager.instance:push(ViewName.HeartGrowUpTipView, GameEnum.GrowUpRoad.Lv, self._petInfo, self._activityInfo.activityId, self._activityInfo.strengthenPlanId)
	elseif GrowUpRoadModel.instance:getCurStrengthenType() > 0 then
		FloatWordMgr.instance:show(string.format(lang("heart_grow_up_tip_strengthen_ed"), self._petInfo.name, lang("tip_level")))
	else
		local len = StringUtil.GetUtf8Length(lang("heart_grow_up_tip_strengthen"))

		FloatWordMgr.instance:show(StringUtil.SubUtf8String(lang("heart_grow_up_tip_strengthen"), len - 3, len))
	end
end

function HeartGrowUpTaskView:_onClickStar()
	if GrowUpRoadModel.instance:getCurStrengthenType() == 1 and MaterialFacade.instance:getMatNumber(MatType.Item_Fake, self._activityInfo.scoreId) >= self._strengthPlan[2].needScore then
		UIStateManager.instance:push(ViewName.HeartGrowUpTipView, GameEnum.GrowUpRoad.Star, self._petInfo, self._activityInfo.activityId, self._activityInfo.strengthenPlanId)
	elseif GrowUpRoadModel.instance:getCurStrengthenType() > 1 then
		FloatWordMgr.instance:show(string.format(lang("heart_grow_up_tip_strengthen_ed"), self._petInfo.name, lang("tip_stargod")))
	else
		FloatWordMgr.instance:show(string.format(lang("heart_grow_up_tip_strengthen"), self._petInfo.name, lang("tip_level")))
	end
end

function HeartGrowUpTaskView:_onClickEquip()
	if GrowUpRoadModel.instance:getCurStrengthenType() == 2 and MaterialFacade.instance:getMatNumber(MatType.Item_Fake, self._activityInfo.scoreId) >= self._strengthPlan[3].needScore then
		TipsFacade.instance:openPopupWindow(lang("tip"), string.format(lang("heart_grow_up_tip_desc"), self._strengthPlan[3].needScore, lang("tip_equip")), function()
			PetGrowthPathAgent.instance:sendPM_PetGrowthPathStrengthenReq(self._activityInfo.activityId, self._petInfo.petId)
		end)
	elseif GrowUpRoadModel.instance:getCurStrengthenType() > 2 then
		FloatWordMgr.instance:show(string.format(lang("heart_grow_up_tip_strengthen_ed"), self._petInfo.name, lang("tip_equip")))
	else
		FloatWordMgr.instance:show(string.format(lang("heart_grow_up_tip_strengthen"), self._petInfo.name, lang("tip_stargod")))
	end
end

function HeartGrowUpTaskView:_onClickPotential()
	if GrowUpRoadModel.instance:getCurStrengthenType() == 3 and MaterialFacade.instance:getMatNumber(MatType.Item_Fake, self._activityInfo.scoreId) >= self._strengthPlan[4].needScore then
		UIStateManager.instance:push(ViewName.HeartGrowUpTipView, GameEnum.GrowUpRoad.Potential, self._petInfo, self._activityInfo.activityId, self._activityInfo.strengthenPlanId)
	elseif GrowUpRoadModel.instance:getCurStrengthenType() > 3 then
		FloatWordMgr.instance:show(string.format(lang("heart_grow_up_tip_strengthen_ed"), self._petInfo.name, lang("tip_potential")))
	else
		FloatWordMgr.instance:show(string.format(lang("heart_grow_up_tip_strengthen"), self._petInfo.name, lang("tip_equip")))
	end
end

function HeartGrowUpTaskView:_onClickAwake()
	if GrowUpRoadModel.instance:getCurStrengthenType() == 4 and MaterialFacade.instance:getMatNumber(MatType.Item_Fake, self._activityInfo.scoreId) >= self._strengthPlan[5].needScore then
		UIStateManager.instance:push(ViewName.HeartGrowUpTipView, GameEnum.GrowUpRoad.Awake, self._petInfo, self._activityInfo.activityId, self._activityInfo.strengthenPlanId)
	elseif GrowUpRoadModel.instance:getCurStrengthenType() > 4 then
		FloatWordMgr.instance:show(string.format(lang("heart_grow_up_tip_strengthen_ed"), self._petInfo.name, lang("tip_awake")))
	else
		FloatWordMgr.instance:show(string.format(lang("heart_grow_up_tip_strengthen"), self._petInfo.name, lang("tip_potential")))
	end
end

function HeartGrowUpTaskView:_onClickHelp()
	goutil.setActive(self._helpBubble, true)
	settimer(3, self._timer, self, false)
end

function HeartGrowUpTaskView:_timer()
	goutil.setActive(self._helpBubble, false)
end

function HeartGrowUpTaskView:_updateStrengBtn()
	goutil.setActive(self._levelBtnRed, GrowUpRoadModel.instance:getCurStrengthenType() <= 0 and MaterialFacade.instance:getMatNumber(MatType.Item_Fake, self._activityInfo.scoreId) >= self._strengthPlan[1].needScore)
	goutil.setActive(self._levelIntegral.gameObject, GrowUpRoadModel.instance:getCurStrengthenType() < 1)
	self._levelBtnImageChange:SetState(GrowUpRoadModel.instance:getCurStrengthenType() < 1 and 0 or 1)
	goutil.setActive(self._starBtnRed, GrowUpRoadModel.instance:getCurStrengthenType() == 1 and MaterialFacade.instance:getMatNumber(MatType.Item_Fake, self._activityInfo.scoreId) >= self._strengthPlan[2].needScore)
	goutil.setActive(self._starIntegral.gameObject, GrowUpRoadModel.instance:getCurStrengthenType() < 2)
	self._starBtnImageChange:SetState(GrowUpRoadModel.instance:getCurStrengthenType() < 2 and 0 or 1)
	goutil.setActive(self._equipBtnRed, GrowUpRoadModel.instance:getCurStrengthenType() == 2 and MaterialFacade.instance:getMatNumber(MatType.Item_Fake, self._activityInfo.scoreId) >= self._strengthPlan[3].needScore)
	goutil.setActive(self._equipIntegral.gameObject, GrowUpRoadModel.instance:getCurStrengthenType() < 3)
	self._equipBtnImageChange:SetState(GrowUpRoadModel.instance:getCurStrengthenType() < 3 and 0 or 1)
	goutil.setActive(self._potentialBtnRed, GrowUpRoadModel.instance:getCurStrengthenType() == 3 and MaterialFacade.instance:getMatNumber(MatType.Item_Fake, self._activityInfo.scoreId) >= self._strengthPlan[4].needScore)
	goutil.setActive(self._potentialIntegral.gameObject, GrowUpRoadModel.instance:getCurStrengthenType() < 4)
	self._potentialBtnImageChange:SetState(GrowUpRoadModel.instance:getCurStrengthenType() < 4 and 0 or 1)
	goutil.setActive(self._awakeBtnRed, GrowUpRoadModel.instance:getCurStrengthenType() == 4 and MaterialFacade.instance:getMatNumber(MatType.Item_Fake, self._activityInfo.scoreId) >= self._strengthPlan[5].needScore)
	goutil.setActive(self._awakeIntegral.gameObject, GrowUpRoadModel.instance:getCurStrengthenType() < 5)
	self._awakeBtnImageChange:SetState(GrowUpRoadModel.instance:getCurStrengthenType() < 5 and 0 or 1)
end

function HeartGrowUpTaskView:_updateTaskCell(view, cell, data)
	goutil.findChildTextComponent(cell.gameObject, "desc").text = data.desc

	local taskProgress = GrowUpRoadModel.instance:getTaskInfoById(data.id)

	goutil.findChildTextComponent(cell.gameObject, "progress").text = taskProgress.curProcess .. "/" .. data.maxProgress

	goutil.setActive(goutil.findChild(cell.gameObject, "receive"), taskProgress.hasGainPrize)

	local receiveBtn = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnReceive")

	goutil.setActive(receiveBtn.gameObject, not taskProgress.hasGainPrize and taskProgress.curProcess >= data.maxProgress)
	receiveBtn:AddClickListener(function()
		PetGrowthPathAgent.instance:sendPM_PetGrowthPathGainTaskPrizeReq(self._activityInfo.activityId, data.id)
	end)

	local goBtn = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnGo")

	goutil.setActive(goBtn.gameObject, not taskProgress.hasGainPrize and taskProgress.curProcess < data.maxProgress)
	goBtn:AddClickListener(function()
		if string.nilorempty(data.jumpTo) then
			FloatWordMgr.instance:show(lang("text_recall_desc_17"))
		elseif GrowUpRoadController.instance:isNotGotoByTaskType(data.type) then
			FloatWordMgr.instance:show("护送期间不可操作！")
		else
			GotoMgr.gotoByString(data.jumpTo)
			self:close()
		end
	end)

	self._cellProxy[cell] = self._cellProxy[cell] or {}

	local prizes = string.split(data.prize, "#")

	for i = 1, math.max(#prizes + 1, #self._cellProxy[cell]) do
		local prizeStr = true

		goto label_21_0

		::label_21_0::

		if prizeStr then
			if self._cellProxy[cell][i] == nil then
				local itemGo = goutil.cloneAndSetParent(self._itemCell, goutil.findChild(cell.gameObject, "item").transform)

				self._cellProxy[cell][i] = MaterialMgr.setCellByCfg(prizeStr, itemGo)
			else
				local matype, id, num = MaterialMgr.getMatParams(prizeStr)

				self._cellProxy[cell][i]:initCfg(matype, id)
				self._cellProxy[cell][i].binder:setNum(num)
			end
		elseif self._cellProxy[cell][i] then
			MaterialMgr.resetPorxy(self._cellProxy[cell][i])

			self._cellProxy[cell][i] = nil
		end
	end
end

function HeartGrowUpTaskView:_clearCell(cell)
	for i, v in ipairs(self._cellProxy[cell] or {}) do
		MaterialMgr.resetPorxy(self._cellProxy[cell][i])
	end

	local itemGo = goutil.findChild(cell.gameObject, "item")

	for i = itemGo.transform.childCount - 1, 0, -1 do
		goutil.destroy(itemGo.transform:GetChild(i).gameObject)
	end
end

return HeartGrowUpTaskView
