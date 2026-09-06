-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tonglinshiji/view/TongLinShiJiExtView.lua

module("logic.extensions.tonglinshiji.view.TongLinShiJiExtView", package.seeall)

local TongLinShiJiExtView = class("TongLinShiJiExtView", ViewComponent)

function TongLinShiJiExtView:ctor()
	TongLinShiJiExtView.super.ctor(self)
end

function TongLinShiJiExtView:buildUI()
	TongLinShiJiExtView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._bottomRule = self:getGo("bottomRule")
	self._txtRule = self:getTxt("bottomRule/Text")
	self._btnTotal = self:getGo("total")
	self._rewardTag = self:getGo("total/tag")
	self._reward = self:getGo("total/reward")
	self._txtPowerWord = self:getGo("total/txt")
	self._imgTotalProgress = self._btnTotal.gameObject:GetComponent(goutil.Type_UIImage)
	self._root = self:getGo("total/root")
	self._clipRect = self._btnTotal.gameObject:GetComponent(goutil.Type_RectTransform)
	self._redPoint = self:getGo("total/redPoint")
	self._txtTotalProgress = self:getTxt("total/score")
	self._bg = self:getGo("btnsChallenge/btn/bg")
	self._btnsChallenge = self:getGo("btnsChallenge")
	self._cellGoList = GameUtil.getChildren(self._btnsChallenge.transform) or {}
	self._cellList = {}
end

function TongLinShiJiExtView:bindEvents()
	TongLinShiJiExtView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnTotal, self._onClickBtnGet, self)
end

function TongLinShiJiExtView:unbindEvents()
	TongLinShiJiExtView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnTotal)

	for i, cell in ipairs(self._cellList) do
		GameUtil.rmClickHandler(cell.go)
	end
end

function TongLinShiJiExtView:onEnter()
	TongLinShiJiExtView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_JiClgGetInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.PM_JiClgGainPrizeRes, self._onGetPrize, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = TongLinShiJiController.instance:getActivityId()
	end

	self._activityType = TongLinShiJiController.instance:getActivityType()

	local isInTime = TongLinShiJiController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		local text = string.format("活动不在开启期限内( activityId = %d )", self._activityId)

		local function func()
			self:close()
		end

		TipsFacade.instance:openTipWindow("提示", text, func, "确定", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	self._effList = {}
	self._effHeight = GameUtil.getHeight(self._bg)

	for idx, cell in ipairs(self._cellGoList) do
		local cur = {}

		cur.txt = goutil.findChildTextComponent(cell, "score")
		cur.bg = goutil.findChildComponent(cell, "bg", "Image")
		cur.root = goutil.findChild(cell, "bg/root")
		cur.clipRect = cur.root.gameObject:GetComponent(goutil.Type_RectTransform)
		cur.go = cell

		table.insert(self._cellList, cur)
	end

	self:_onSetUI()
	TongLinShiJiController.instance:sendPM_JiClgGetInfoReq(self._activityId)
end

function TongLinShiJiExtView:onExit()
	TongLinShiJiExtView.super.onExit(self)
	uGuiUtil.clearImage(self._reward)
	MaterialMgr.resetAll(self._pointRare)
	MaterialMgr.resetAll(self._itemcell)

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	self._cellList = {}

	UIEffectManager.instance:stopEffect(self._eff)

	self._eff = nil

	if self._effList then
		for effGo, eff in pairs(self._effList) do
			UIEffectManager.instance:stopEffect(eff)

			self._effList[effGo] = nil
		end

		self._effList = nil
	end
end

function TongLinShiJiExtView:_onSetUI()
	self._txtRule.text = TongLinShiJiConfig.instance:getCommonValue(self._activityId, "ruleExtremBottom")

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._bottomRule.transform)
	self:_onUpdate()
end

function TongLinShiJiExtView:_init()
	GameUtil.SetActive(self._reward, false)
	GameUtil.SetActive(self._rewardTag, false)
	GameUtil.SetActive(self._txtTotalProgress, false)
	GameUtil.SetActive(self._txtPowerWord, false)
end

function TongLinShiJiExtView:_onUpdate()
	self:_updateData()
	self:_updateUI()
end

function TongLinShiJiExtView:_updateData()
	self._curModel = TongLinShiJiModel.instance:GetModel(self._activityId)
end

function TongLinShiJiExtView:_updateUI()
	self:_init()

	local canGetReward = TongLinShiJiController.instance:CanGetExtReward(self._activityId)
	local showRedPoint = TongLinShiJiController.instance:isInActivityTime(self._activityId) and canGetReward

	GameUtil.SetActive(self._redPoint, showRedPoint)

	local canGetExtReward = TongLinShiJiController.instance:CanGetExtReward(self._activityId)
	local curExtPowers = TongLinShiJiModel.instance:GetCurExtPowers(self._activityId)
	local curExtTotalPower = TongLinShiJiModel.instance:GetCurExtTotalPower(self._activityId)
	local extClgPower = TongLinShiJiConfig.instance:getJiActivityData(self._activityId).extremeTotalScoreLimit

	self._txtTotalProgress.text = "<color=#6bf4ff>" .. curExtTotalPower .. "</color>/" .. extClgPower
	self._imgTotalProgress.fillAmount = curExtTotalPower / extClgPower

	GameUtil.SetActive(self._reward, canGetExtReward)
	GameUtil.SetActive(self._rewardTag, canGetExtReward)
	GameUtil.SetActive(self._txtTotalProgress, not canGetExtReward)
	GameUtil.SetActive(self._txtPowerWord, not canGetExtReward)

	if canGetExtReward then
		local skillName = TongLinShiJiConfig.instance:getCommonValue(self._activityId, "rewardImageName")

		uGuiUtil.setSpriteToImage(self._reward, uGuiUtil.SpriteType.BigBg, GameUrl.getSkillIconUrl(skillName))
	end

	local extScoreRange = TongLinShiJiConfig.instance:getJiActivityData(self._activityId).extremeScoreRange

	for idx, cell in ipairs(self._cellList) do
		if self._effList and self._effList[cell.root] then
			UIEffectManager.instance:stopEffect(self._effList[cell.root])

			self._effList[cell.root] = nil
		end

		if not GameEnum.TonglingShiRaceTypeName[idx] then
			local type = ""

			if curExtPowers then
				local curStagePower = checknumber(curExtPowers[type])

				cell.txt.text = "已注入:" .. curStagePower
				cell.bg.fillAmount = curStagePower / extScoreRange[2]

				local function loadHandler(target, eff)
					eff.effGo.transform:SetParent(cell.root.transform)
					GameUtil.setLocalPos(eff.effGo.transform, 0, 0, 0)

					if idx ~= 2 then
						GameUtil.setLocalScale(eff.effGo.transform, 1, 1, 1)
					else
						GameUtil.setLocalScale(eff.effGo.transform, 0.3, 1, 1)
					end

					if cell.clipRect then
						eff:setClipping(cell.clipRect)
					end
				end

				local fillAmount = curStagePower / extScoreRange[2]

				self._effList[cell.root] = UIEffectManager.instance:playEffect(self, "20241122/fx_ui_tlsj_tiaozhan0" .. idx .. ".prefab", cell.root.transform, 0, 0, true, false, nil, loadHandler)

				GameUtil.setAnchoredPos(cell.root, 0, self._effHeight * fillAmount, 0)
			else
				cell.txt.text = "已注入:0"
				cell.bg.fillAmount = 0
			end

			GameUtil.addClickHandler(cell.go, function()
				local canGetExtReward = TongLinShiJiController.instance:CanGetExtReward(self._activityId)

				if canGetExtReward then
					FloatWordMgr.instance:show("元素已平衡，快去聚力造极吧！")

					return
				end

				if self._curModel.extremeInfo.gainPrize then
					FloatWordMgr.instance:show("已完成，无需再次挑战")

					return
				end

				UIStateManager.instance:push(ViewName.TongLinShiJiExtStageView, self._activityId, type)
			end)
		end
	end

	UIEffectManager.instance:stopEffect(self._eff)

	self.eff = nil

	if canGetExtReward then
		local function loadHandler(target, eff)
			eff.effGo.transform:SetParent(self._root.transform)
			GameUtil.setLocalPos(eff.effGo.transform, 0, 0, 0)
			GameUtil.setLocalScale(eff.effGo.transform, 1, 1, 1)

			if self._clipRect then
				eff:setClipping(self._clipRect)
			end
		end

		self._eff = UIEffectManager.instance:playEffect(self, "fx_ui_juqingfuben/fx_ui_juqingfuben01.prefab", self._root.transform, 0, 0, true, false, nil, loadHandler)
	end
end

function TongLinShiJiExtView:_onGetPrize()
	UIEffectManager.instance:stopEffect(self._eff)

	self._eff = nil

	self:_onUpdate()
end

function TongLinShiJiExtView:_onClickBtnTip()
	local key = TongLinShiJiConfig.instance:getCommonValue(self._activityId, "ruleKeyExtrem")

	TipsFacade.instance:openRulesView(key)
end

function TongLinShiJiExtView:_onClickBtnGet()
	local canGetExtReward = TongLinShiJiController.instance:CanGetExtReward(self._activityId)

	if not canGetExtReward then
		FloatWordMgr.instance:show("不满足聚力条件")

		return
	end

	if self._curModel.extremeInfo.gainPrize then
		FloatWordMgr.instance:show("已领取奖励，无法再次领取")

		return
	end

	UIStateManager.instance:push(ViewName.TongLinShiJiExtPassView, self._activityId, TongLinShiJiModel.EXT_PRIZE_TYPE)
end

return TongLinShiJiExtView
