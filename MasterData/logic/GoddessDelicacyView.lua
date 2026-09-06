-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddessdelicacy/view/GoddessDelicacyView.lua

module("logic.extensions.goddessdelicacy.view.GoddessDelicacyView", package.seeall)

local GoddessDelicacyView = class("GoddessDelicacyView", ViewComponent)

function GoddessDelicacyView:ctor()
	GoddessDelicacyView.super.ctor(self)
end

function GoddessDelicacyView:bindEvents()
	GoddessDelicacyView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._tipsBtn:AddClickListener(function()
		UIStateManager.instance:push(ViewName.RulesView, "goddessdelicacy")
	end, self)
	self._gotoBtn:AddClickListener(function()
		if self._goddessInfo.todayDishes == nil or #self._goddessInfo.todayDishes == 0 then
			FloatWordMgr.instance:show("已全部完成~下次再来吧~")

			return
		end

		UIStateManager.instance:push(ViewName.GoddessCook, self._actCfg.activityId)
	end, self)
	self._recipeBtn:AddClickListener(function()
		UIStateManager.instance:push(ViewName.GoddessRecipe)
	end, self)
	GameUtil.addClickHandler(self._btnJumpItem, self._onJumpItem, self)
	GameUtil.addClickHandler(self._btnJumpShop, self._onJumpShop, self)
end

function GoddessDelicacyView:unbindEvents()
	GoddessDelicacyView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._tipsBtn:RemoveClickListener()
	self._gotoBtn:RemoveClickListener()
	self._recipeBtn:RemoveClickListener()
end

function GoddessDelicacyView:onExit()
	GoddessDelicacyView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdataGoddessDelicacyInfo, self._updataViewShow, self)

	self._roleModel = RoleObjectPool.instance:removeRole(self._roleModel)
	self._goddessInfo = nil
end

function GoddessDelicacyView:destroyUI()
	GoddessDelicacyView.super.destroyUI(self)

	for _, item in pairs(self._delicacyGoList) do
		if item and item.foodImaGo then
			uGuiUtil.clearImage(item.foodImaGo)
		end
	end

	self._delicacyGoList = nil
end

function GoddessDelicacyView:buildUI()
	GoddessDelicacyView.super.buildUI(self)

	local upShowGo = self:getGo("upShowTran")

	self._closeBtn = Framework.ButtonAdapter.GetFrom(upShowGo, "viewCloseBtn")
	self._tipsBtn = Framework.ButtonAdapter.GetFrom(upShowGo, "viewNameTxt/tipsBtn")
	self._sprintGo = self:getGo("sprintGo")
	self._timeTxt = goutil.findChild(upShowGo, "viewTimeGo/timeTxt"):GetComponent("Text")
	self._timeTxt.text = ""
	self._delicacyGoList = {}

	local delicacyGo = self:getGo("delicacyGos/delicacyGo_1")

	self._delicacyGoList[1] = {
		itemGo = delicacyGo,
		foodImaGo = goutil.findChild(delicacyGo, "foodIma"),
		finishGo = goutil.findChild(delicacyGo, "finishGo"),
		foodTxt = goutil.findChildTextComponent(delicacyGo, "foodTxt")
	}
	delicacyGo = self:getGo("delicacyGos/delicacyGo_2")
	self._delicacyGoList[2] = {
		itemGo = delicacyGo,
		foodImaGo = goutil.findChild(delicacyGo, "foodIma"),
		finishGo = goutil.findChild(delicacyGo, "finishGo"),
		foodTxt = goutil.findChildTextComponent(delicacyGo, "foodTxt")
	}
	delicacyGo = self:getGo("delicacyGos/delicacyGo_3")
	self._delicacyGoList[3] = {
		itemGo = delicacyGo,
		foodImaGo = goutil.findChild(delicacyGo, "foodIma"),
		finishGo = goutil.findChild(delicacyGo, "finishGo"),
		foodTxt = goutil.findChildTextComponent(delicacyGo, "foodTxt")
	}
	self._noDelicacyGo = goutil.findChild(self.mainGO, "noDelicacyGo")
	self._gotoBtn = self:getBtn("gotoBtn")
	self._countTxt = goutil.findChild(self.mainGO, "countTxt"):GetComponent("Text")
	self._dialogueTxt = goutil.findChild(self.mainGO, "dialogueGo/dialogueTxt"):GetComponent("Text")
	self._recipeBtn = self:getBtn("recipeBtn")
	self._recipeRedGo = self:getGo("recipeBtn/recipeRed")
	self._countTxt.text = ""
	self._dialogueTxt.text = ""

	GameUtil.SetActive(self._recipeRedGo, false)

	self._btnJumpItem = self:getGo("btnJumpItem")
	self._btnJumpShop = self:getGo("btnJumpShop")
end

function GoddessDelicacyView:onEnter()
	GoddessDelicacyView.super.onEnter(self)

	local actId = GoddessDelicacyConfig.instance:getOpenActivityId()

	if checknumber(actId) <= 0 then
		error("sr----  GoddessDelicacyView:onEnter() y运营-美女美食    活动时间过了，还能打开？请配置功能开启id！！" .. actId)

		return
	end

	GlobalDispatcher:addListener(GlobalNotify.UpdataGoddessDelicacyInfo, self._updataViewShow, self)

	self._actCfg = GoddessDelicacyConfig.instance:getGoddessActivityCfg(actId)

	for _, item in pairs(self._delicacyGoList) do
		if item and item.itemGo then
			GameUtil.SetActive(item.itemGo, false)
		end
	end

	self._timeTxt.text = self._actCfg.timeDes
	self._dialogueTxt.text = self._actCfg.dialogueDes

	self:_updataViewShow()
	GoddessDelicacyController.instance:csRequestFoodNotesGetInfoReq(actId)

	local x, y, scale = 0, 0, -0.7

	self._roleModel = RoleObjectPool.instance:removeRole(self._roleModel)
	self._roleModel = RoleObjectPool.instance:addRoleToParent(self._roleModel, GoddessDelicacyConfig.instance:getCommonValue("SHOW_SKINID", true), self._sprintGo, scale, nil, true, x, y)

	local value = GameUtil.getUserDayData("GoddessDelicacyRed")

	if checknumber(value) ~= 1 then
		GameUtil.saveUserDayData("GoddessDelicacyRed", 1)
	end

	GameUtil.SetActive(self._recipeRedGo, RedPointModel.instance:isActiveByServer(214))
end

function GoddessDelicacyView:_updataViewShow()
	self._goddessInfo = GoddessDelicacyModel.instance:getGoddessInfo()

	local todayList = self._goddessInfo.todayDishes
	local dishInfo = self._goddessInfo.dishInfoList
	local dishCfg

	for i = 1, #self._delicacyGoList do
		if todayList and todayList[i] then
			dishCfg = GoddessDelicacyConfig.instance:getNotesDishCfg(self._actCfg.activityId, todayList[i])

			if dishCfg == nil then
				GameUtil.SetActive(self._delicacyGoList[i].itemGo, false)
				printError("sr---美女美食  GoddessDelicacyView:_updataViewShow()   没有此菜式 = " .. todayList[i])
			else
				GameUtil.SetActive(self._delicacyGoList[i].itemGo, true)
				uGuiUtil.setSpriteToImage(self._delicacyGoList[i].foodImaGo, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(dishCfg.icon))

				self._delicacyGoList[i].foodTxt.text = dishCfg.name

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
		uGuiUtil.setImageGrayState(self._gotoBtn, true)
	else
		GameUtil.SetActive(self._noDelicacyGo, false)
		uGuiUtil.setImageGrayState(self._gotoBtn, false)
	end

	self._countTxt.text = langPara("text_goddess_desc_16", self._actCfg.dailyCookTimes - self._goddessInfo.todayCookedTimes, self._actCfg.dailyCookTimes)
end

function GoddessDelicacyView:_onJumpItem()
	GotoMgr.gotoByString(GoddessDelicacyConfig.instance:getCommonValue("JUMP_ITEM"))
end

function GoddessDelicacyView:_onJumpShop()
	GotoMgr.gotoByString(GoddessDelicacyConfig.instance:getCommonValue("JUMP_SHOP"))
end

return GoddessDelicacyView
