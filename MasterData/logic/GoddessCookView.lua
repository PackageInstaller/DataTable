-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddessdelicacy/view/GoddessCookView.lua

module("logic.extensions.goddessdelicacy.view.GoddessCookView", package.seeall)

local GoddessCookView = class("GoddessCookView", ViewComponent)

function GoddessCookView:ctor()
	GoddessCookView.super.ctor(self)

	self._delicacyGoList = nil
	self._materialGoList = nil
	self._goddessInfo = nil
	self._choisMatList = nil
	self._selectFood = {}
end

function GoddessCookView:bindEvents()
	GoddessCookView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._tipsBtn:AddClickListener(function()
		UIStateManager.instance:push(ViewName.RulesView, "goddessdelicacy")
	end, self)
	self._recipeBtn:AddClickListener(function()
		UIStateManager.instance:push(ViewName.GoddessRecipe)
	end, self)
	GameUtil.addClickHandler(self._cookingBtn, self._onClickCooking, self)

	for i = 1, #self._materialGoList do
		if self._materialGoList[i] and self._materialGoList[i].itemGo then
			GameUtil.asBtn(self._materialGoList[i].itemGo):AddClickListener(function()
				local index = i

				self:_onClickMaterialBtn(index)
			end, self)
		end
	end

	for i = 1, #self._delicacyGoList do
		if self._delicacyGoList[i] and self._delicacyGoList[i].itemGo then
			GameUtil.asBtn(self._delicacyGoList[i].itemGo):AddClickListener(function()
				local index = i

				self:_onClickDelicacyMenuBtn(index)
			end, self)
		end
	end

	GameUtil.addClickHandler(self._btnJumpShop, self._onJumpShop, self)
	GameUtil.addClickHandler(self._btnJumpItem, self._onJumpItem, self)
end

function GoddessCookView:unbindEvents()
	GoddessCookView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._tipsBtn:RemoveClickListener()
	self._recipeBtn:RemoveClickListener()
	GameUtil.rmClickHandler(self._cookingBtn)

	for _, item in pairs(self._materialGoList or {}) do
		if item and item.itemGo then
			GameUtil.asBtn(item.itemGo):RemoveClickListener()
		end
	end

	for _, item in pairs(self._delicacyGoList or {}) do
		if item and item.itemGo then
			GameUtil.asBtn(item.itemGo):RemoveClickListener()
		end
	end
end

function GoddessCookView:onExit()
	GoddessCookView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdataGoddessDelicacyCook, self._updataViewShow, self)

	if self.pmEff then
		UIEffectManager.instance:stopEffect(self.pmEff)
	end

	self.pmEff = nil
	self._isCooking = false
	self._goddessInfo = nil
	self._choisMatList = nil

	self._flyFoodGroup:dispose(self._clearFlyFood, self)
end

function GoddessCookView:destroyUI()
	GoddessCookView.super.destroyUI(self)

	for _, item in pairs(self._delicacyGoList) do
		if item and item.foodImaGo then
			uGuiUtil.clearImage(item.foodImaGo)
		end
	end

	self._delicacyGoList = nil

	for _, item in pairs(self._materialGoList) do
		if item and item.foodImaGo then
			uGuiUtil.clearImage(item.foodImaGo)
		end
	end

	self._materialGoList = nil
end

function GoddessCookView:buildUI()
	GoddessCookView.super.buildUI(self)

	local mainViewGo = self:getGo("mainViewGo")

	self._closeBtn = Framework.ButtonAdapter.GetFrom(mainViewGo, "closeBtn")
	self._tipsBtn = Framework.ButtonAdapter.GetFrom(mainViewGo, "tipsBtn")
	self._guoImaGo = goutil.findChild(mainViewGo, "guoImaGo")

	local menuGo = goutil.findChild(mainViewGo, "menuGo")

	self._rightTitleTxt = goutil.findChildTextComponent(menuGo, "rightTitleTxt")
	self._noDelicacyGo = goutil.findChild(menuGo, "noDelicacyGo")
	self._delicacyGoList = {}

	local targetGo = goutil.findChild(menuGo, "targetGo_1")

	self._delicacyGoList[1] = {
		itemGo = targetGo,
		foodImaGo = goutil.findChild(targetGo, "foodIma"),
		finishGo = goutil.findChild(targetGo, "finishGo"),
		nameTxt = goutil.findChildTextComponent(targetGo, "nameTxt")
	}
	targetGo = goutil.findChild(menuGo, "targetGo_2")
	self._delicacyGoList[2] = {
		itemGo = targetGo,
		foodImaGo = goutil.findChild(targetGo, "foodIma"),
		finishGo = goutil.findChild(targetGo, "finishGo"),
		nameTxt = goutil.findChildTextComponent(targetGo, "nameTxt")
	}
	targetGo = goutil.findChild(menuGo, "targetGo_3")
	self._delicacyGoList[3] = {
		itemGo = targetGo,
		foodImaGo = goutil.findChild(targetGo, "foodIma"),
		finishGo = goutil.findChild(targetGo, "finishGo"),
		nameTxt = goutil.findChildTextComponent(targetGo, "nameTxt")
	}

	GameUtil.SetActive(self._delicacyGoList[1].finishGo, false)
	GameUtil.SetActive(self._delicacyGoList[2].finishGo, false)
	GameUtil.SetActive(self._delicacyGoList[3].finishGo, false)

	self._recipeBtn = Framework.ButtonAdapter.GetFrom(mainViewGo, "recipeBtn")
	self._btnJumpShop = self:getGo("mainViewGo/btnJumpShop")
	self._btnJumpItem = self:getGo("mainViewGo/btnJumpItem")

	local bottomGo = goutil.findChild(mainViewGo, "bottomGo")

	self._materialGoList = {}

	local allMaterialTran = goutil.findChild(bottomGo, "allMaterialGo").transform
	local names

	for i = 1, allMaterialTran.childCount do
		local go = allMaterialTran:GetChild(i - 1).gameObject

		names = string.split(go.name, "_")
		self._materialGoList[checknumber(names[2])] = {
			itemGo = go,
			foodImaGo = goutil.findChild(go, "foodIma"),
			choiseGo = goutil.findChild(go, "choiseGo"),
			nameTxt = goutil.findChildTextComponent(go, "nameTxt")
		}

		GameUtil.SetActive(self._materialGoList[checknumber(names[2])].choiseGo, false)
	end

	self._cookingBtn = Framework.ButtonAdapter.GetFrom(bottomGo, "cookingBtn")
	self._countTxt = goutil.findChildTextComponent(bottomGo, "countTxt")
	self._rightTitleTxt.text = ""
	self._countTxt.text = ""

	GameUtil.SetActive(self._noDelicacyGo, false)

	self._flyEffect = self:getGo("mainViewGo/flyEffect")
	self._flyFoodCell = self:getGo("mainViewGo/flyEffect/foodCell")
	self._flyFoodGroup = ItemGroup.New(self._flyEffect, self._flyFoodCell)
	self._flyRecordPos = self._flyEffect:GetComponent("TestRecordPos")
	self._liwuheEffect = self:getGo("mainViewGo/liwuheEffect")
end

function GoddessCookView:onEnter()
	GoddessCookView.super.onEnter(self)

	self._actId = self:getFirstParam()
	self._selectFood = {}

	if checknumber(self._actId) <= 0 then
		printError("sr----  GoddessCookView:onEnter() y运营-美女美食    需要传入活动id！！")
	else
		self._actId = GoddessDelicacyConfig.instance:getOpenActivityId()
	end

	GlobalDispatcher:addListener(GlobalNotify.UpdataGoddessDelicacyCook, self._updataViewShow, self)

	for _, item in pairs(self._delicacyGoList) do
		if item and item.itemGo then
			GameUtil.SetActive(item.itemGo, false)
		end
	end

	self._rightTitleTxt.text = lang("text_goddess_desc_26")

	self:_updataViewShow()
end

function GoddessCookView:_updataViewShow(params)
	GameUtil.SetActive(self._guoImaGo, true)

	self._goddessInfo = GoddessDelicacyModel.instance:getGoddessInfo()
	self._choisMatList = {}
	self._selectFood = {}

	self:_updataRightMenuShow()
	self:_updateFoodShow()

	if params == nil or params.cookDishId == nil then
		return
	end

	local setId = params.changeSetId
	local titleStr = ""
	local descStr = ""

	if params.cookDishId > 0 then
		titleStr = lang("text_goddess_desc_32")

		local name, peifang = GoddessDelicacyModel.instance:getShareFoodInfo(self._actId, params.cookDishId, true)

		descStr = params.isOpen and langPara("text_goddess_desc_36", name, peifang) or langPara("text_goddess_desc_35", name, peifang)
	else
		titleStr = lang("text_goddess_desc_33")
		descStr = lang("text_goddess_desc_34")
	end

	TipsFacade.instance:openTipWindow(titleStr, descStr, function()
		MaterialController.instance:showChangeSetInTemp(setId)
	end, lang("mail_confirm"), UnityEngine.TextAnchor.MiddleLeft)
end

function GoddessCookView:_updateFoodShow()
	local foodList = self._goddessInfo.foodOptions

	if foodList == nil or #foodList == 0 then
		printError("sr----  GoddessCookView:_updataBottomMaterialShow()  y运营-美女美食     没有菜谱？")

		return
	end

	local allCount = #self._materialGoList

	if allCount < #foodList then
		printError("sr----  GoddessCookView:_updataBottomMaterialShow()  y运营-美女美食   和策划商量的最大支持个数 = " .. allCount)
	end

	local foodCfg

	for i = 1, allCount do
		if self._materialGoList[i] and self._materialGoList[i].itemGo then
			uGuiUtil.clearImage(self._materialGoList[i].foodImaGo)

			local foodId = checknumber(foodList[i])

			if foodList[i] and foodId > 0 then
				GameUtil.SetActive(self._materialGoList[i].itemGo, true)
				GameUtil.SetActive(self._materialGoList[i].choiseGo, table.indexof(self._choisMatList, i))

				foodCfg = GoddessDelicacyConfig.instance:getNotesFoodCfg(self._actId, foodId)
				self._materialGoList[i].nameTxt.text = foodCfg.name

				uGuiUtil.setSpriteToImage(self._materialGoList[i].foodImaGo, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(foodCfg.icon))

				if not string.nilorempty(foodCfg.cost) then
					local matType, matId, matNum = MaterialMgr.getMatParams(foodCfg.cost)
					local matHaveNum = MaterialModel.instance:getMaterialsNumber(matType, matId)

					GameUtil.SetGray(self._materialGoList[i].itemGo, matHaveNum <= 0)

					self._materialGoList[i].nameTxt.text = langPara("%s(%d/%d)", foodCfg.name, checknumber(self._selectFood[foodId]) * matNum, matHaveNum)
				else
					self._materialGoList[i].nameTxt.text = foodCfg.name
				end
			else
				GameUtil.SetActive(self._materialGoList[i].itemGo, false)
			end
		end
	end
end

function GoddessCookView:_updataRightMenuShow()
	local todayList = self._goddessInfo.todayDishes
	local dishInfo = self._goddessInfo.dishInfoList
	local dishCfg

	for i = 1, #self._delicacyGoList do
		if todayList and todayList[i] then
			dishCfg = GoddessDelicacyConfig.instance:getNotesDishCfg(self._actId, todayList[i])

			if dishCfg == nil then
				GameUtil.SetActive(self._delicacyGoList[i].itemGo, false)
				printError("sr---美女美食  GoddessCookView:_updataRightMenuShow()   没有此菜式 = " .. todayList[i])
			else
				GameUtil.SetActive(self._delicacyGoList[i].itemGo, true)
				uGuiUtil.setSpriteToImage(self._delicacyGoList[i].foodImaGo, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(dishCfg.icon))

				self._delicacyGoList[i].nameTxt.text = dishCfg.name

				if dishInfo and checknumber(dishInfo[todayList[i]]) == GoddessDelicacyController.instance.unLockFinish then
					GameUtil.SetActive(self._delicacyGoList[i].finishGo, true)
				else
					GameUtil.SetActive(self._delicacyGoList[i].finishGo, false)
				end
			end
		else
			GameUtil.SetActive(self._delicacyGoList[i].itemGo, false)
		end
	end

	if todayList == nil or #todayList == 0 then
		GameUtil.SetActive(self._noDelicacyGo, true)
	else
		GameUtil.SetActive(self._noDelicacyGo, false)
	end

	local actCfg = GoddessDelicacyConfig.instance:getGoddessActivityCfg(self._actId)

	self._countTxt.text = langPara("text_goddess_desc_16", actCfg.dailyCookTimes - self._goddessInfo.todayCookedTimes, actCfg.dailyCookTimes)
end

function GoddessCookView:_updateFlyFoodCell(cell, data, index)
	local go = cell.mainGO
	local foodCfg = GoddessDelicacyConfig.instance:getNotesFoodCfg(self._actId, data)

	uGuiUtil.setSpriteToImage(go, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(foodCfg.icon))
end

function GoddessCookView:_clearFlyFood(cell, data, index)
	local go = cell.mainGO

	uGuiUtil.clearImage(go)
	UnityTweens.TweenPosition.StopTween(go)
end

function GoddessCookView:_showCookEffect()
	if self._goddessInfo == nil or self._goddessInfo.foodOptions == nil then
		return
	end

	local targetList = {}

	for i = 1, #self._choisMatList do
		if self._choisMatList[i] and checknumber(self._goddessInfo.foodOptions[self._choisMatList[i]]) > 0 then
			table.insert(targetList, checknumber(self._goddessInfo.foodOptions[self._choisMatList[i]]))
		end
	end

	self._isCooking = true
	self._flyCount = #targetList

	self._flyFoodGroup:updateWithMoArray(targetList, self._updateFlyFoodCell, self)
	self._flyRecordPos:LoadPlan(self._flyCount - 1)

	local targetPos = GameUtil.getAnchoredPos(self._guoImaGo)

	self._flyFoodGroup:updateWithMoArray(targetList, function(target, cell, data, index)
		local formPos = GameUtil.getAnchoredPos(cell.mainGO)
		local tween = UnityTweens.TweenPosition.StartTween(cell.mainGO, Vector3.New(formPos.x, formPos.y, 0), Vector3.New(targetPos.x, targetPos.y, 0), 1, UnityTweens.EaseType.linear, 0, UnityTweens.CoordSpace.Anchor)

		tween:AddListener(self._onFlyEffectEnd, self)
	end, self)
end

function GoddessCookView:_onFlyEffectEnd()
	self._flyCount = self._flyCount - 1

	if self._flyCount == 0 then
		local targetList = {}

		for i = 1, #self._choisMatList do
			if self._choisMatList[i] and checknumber(self._goddessInfo.foodOptions[self._choisMatList[i]]) > 0 then
				table.insert(targetList, checknumber(self._goddessInfo.foodOptions[self._choisMatList[i]]))
			end
		end

		local effPath = "20240430/liwuhe/fx_ui_liwuhe02.prefab"

		self.pmEff = UIEffectManager.instance:playEffect(self, effPath, self.mainGO, 0, 0, false, nil, function(handler, eff)
			GoddessDelicacyController.instance:csRequestFoodNotesCookReq(self._actId, targetList)
			GameUtil.SetActive(self._guoImaGo, true)

			self._isCooking = false
		end, function()
			GameUtil.SetActive(self._guoImaGo, false)
		end)

		self.pmEff:setParent(self._liwuheEffect.transform)
		self.pmEff:setLocalPos(-81, 273, 0)
		self.pmEff:setScale(0.96)
		self.pmEff:setEffTime(2)
		self._flyFoodGroup:dispose(self._clearFlyFood, self)
	end
end

function GoddessCookView:_onClickMaterialBtn(index)
	local foodList = self._goddessInfo.foodOptions
	local foodId = foodList[index]

	self._choisMatList = self._choisMatList or {}

	local num = table.indexof(self._choisMatList, index)
	local foodCfg = GoddessDelicacyConfig.instance:getNotesFoodCfg(self._actId, foodId)
	local matType, matId, matNum, matHaveNum

	if not string.nilorempty(foodCfg.cost) then
		local var_23_0, var_23_1, var_23_2 = MaterialMgr.getMatParams(foodCfg.cost)

		matNum = var_23_2
		matHaveNum = MaterialModel.instance:getMaterialsNumber(var_23_0, var_23_1)
	end

	self._selectFood[foodId] = self._selectFood[foodId] or 0

	if not num then
		local isEnough = true

		if not string.nilorempty(foodCfg.cost) then
			isEnough = matHaveNum >= matNum * self._selectFood[foodId] + 1
		end

		if #self._choisMatList >= 4 then
			FloatWordMgr.instance:show(lang("text_goddess_desc_21"))
		elseif not isEnough then
			FloatWordMgr.instance:show(lang("道具不足"))
		else
			self._selectFood[foodId] = self._selectFood[foodId] + 1

			table.insert(self._choisMatList, index)
			GameUtil.SetActive(self._materialGoList[index].choiseGo, true)
		end
	else
		self._selectFood[foodId] = self._selectFood[foodId] - 1

		table.remove(self._choisMatList, num)
		GameUtil.SetActive(self._materialGoList[index].choiseGo, false)
	end

	self:_updateFoodShow()
end

function GoddessCookView:_onClickDelicacyMenuBtn(index)
	local todayList = self._goddessInfo.todayDishes
	local dishInfo = self._goddessInfo.dishInfoList

	if self._delicacyGoList == nil or self._delicacyGoList[index] == nil then
		return
	end

	if todayList == nil or todayList[index] == nil then
		return
	end

	local dishCfg = GoddessDelicacyConfig.instance:getNotesDishCfg(self._actId, todayList[index])

	if dishCfg == nil then
		return
	end

	local info = {
		dishId = dishCfg.dishId,
		name = dishCfg.name,
		icon = dishCfg.icon,
		foodIds = dishCfg.foodIds,
		idsCount = #dishCfg.foodIds,
		stage = checknumber(dishInfo[dishCfg.dishId]),
		desc = dishCfg.desc,
		activityId = dishCfg.activityId
	}

	UIStateManager.instance:push(ViewName.GoddessContent, info)
end

function GoddessCookView:_onClickCooking()
	if self._isCooking then
		FloatWordMgr.instance:show(lang("正在制作中，请稍后~"))

		return
	end

	if self._choisMatList == nil or #self._choisMatList == 0 then
		FloatWordMgr.instance:show(lang("text_goddess_desc_20"))

		return
	end

	if #self._choisMatList > 4 then
		FloatWordMgr.instance:show(lang("text_goddess_desc_21"))

		return
	end

	local actCfg = GoddessDelicacyConfig.instance:getGoddessActivityCfg(self._actId)

	if actCfg and self._goddessInfo.todayCookedTimes >= actCfg.dailyCookTimes then
		FloatWordMgr.instance:show("今日次数已使用完！")

		return
	end

	self:_showCookEffect()
end

function GoddessCookView:_onJumpItem()
	GotoMgr.gotoByString(GoddessDelicacyConfig.instance:getCommonValue("JUMP_ITEM"))
end

function GoddessCookView:_onJumpShop()
	GotoMgr.gotoByString(GoddessDelicacyConfig.instance:getCommonValue("JUMP_SHOP"))
end

return GoddessCookView
