-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/mission/TLCBattleResultView.lua

module("logic.extensions.timelimitedchallenge.view.mission.TLCBattleResultView", package.seeall)

local TLCBattleResultView = class("TLCBattleResultView", ViewComponent)

function TLCBattleResultView:unbindEvents()
	TLCBattleResultView.super.unbindEvents(self)
	self._btnOk:RemoveClickListener()
end

function TLCBattleResultView:bindEvents()
	TLCBattleResultView.super.bindEvents(self)
	self._btnOk:AddClickListener(self._onClickOk, self)
end

function TLCBattleResultView:onExit()
	TLCBattleResultView.super.onExit(self)

	for _, v in ipairs(self._cells) do
		MaterialMgr.resetAll(v)
	end

	self._cells = nil
end

function TLCBattleResultView:buildUI()
	TLCBattleResultView.super.buildUI(self)

	self._btnOk = self:getBtn("bg/bg_3/btnOk")
	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "bg/bg_3/txtTitle")
	self._imgBgSpriteChange = goutil.findChildComponent(self.mainGO, "bg", typeof(UIImageSpriteChange))
	self._tips = self:getGo("bg/tips")
	self._txtTips = goutil.findChildTextComponent(self._tips, "txtTips")
	self._txtOk = goutil.findChildTextComponent(self._btnOk.gameObject, "Text")
	self._rewards = self:getGo("bg/rewards")
	self._curDamage = self:getGo("bg/curDamage")
	self._totalDamage = self:getGo("bg/totalDamage")
	self._txtCurDamageTitle = goutil.findChildTextComponent(self._curDamage, "txtTitle")
	self._txtTotalDamageTitle = goutil.findChildTextComponent(self._totalDamage, "txtTitle")
	self._txtCurDamage = goutil.findChildTextComponent(self._curDamage, "Text")
	self._txtTotalDamage = goutil.findChildTextComponent(self._totalDamage, "Text")
	self._goSuccess = goutil.findChild(self._totalDamage, "goSuccess")
	self._itemsView = self:getGo("bg/rewards/itemsView/Viewport/Content").transform
	self._itemsLayout = self:getGo("bg/rewards/itemsView/Viewport/Content/items"):GetComponent(typeof(UILayoutMulLines))
	self._txtSuccess = goutil.findChildTextComponent(self._goSuccess, "Text")
	self._tipTitle = self:getGo("bg/tipTitle")
	self._txtTitle = goutil.findChildTextComponent(self._tipTitle, "txtTitle")
	self._tipContent = self:getTxt("bg/tipContent")
	self._txtRewardTitle = goutil.findChildTextComponent(self._rewards, "Text")
end

function TLCBattleResultView:onEnter()
	TLCBattleResultView.super.onEnter(self)

	local height = 480
	local params = self:getOpenParam()

	if params then
		self._closeHandler = params[1]
		self._closeTarget = params[2]
	end

	self._cells = {}

	local btlResultInfo = TLChallengeController.instance:getBattleResultInfo()

	self._btlResultInfo = btlResultInfo

	local petCo = TLChallengeController.instance:getChallengePetCo(btlResultInfo.challengeId)
	local challengeId = btlResultInfo.challengeId

	if TimeLimitedConfig.instance:isCircleChallenge(challengeId) then
		local cfg = TimeLimitedConfig.instance:getCfgById(challengeId)
		local petCfg = CharacterConfig.instance:getPetCo(cfg.raceId)
		local names = string.split(petCfg.name, "·")

		self._txtSuccess.text = "击败" .. names[#names]
	end

	if btlResultInfo.challengeId == 22 then
		self._imgBgSpriteChange:SetState(3)
	elseif btlResultInfo.challengeId == 147 then
		self._imgBgSpriteChange:SetState(4)
	else
		self._imgBgSpriteChange:SetState(btlResultInfo.challengeId - 1)
	end

	self._txtCurDamage.text = checknumber(btlResultInfo.singleDamage)
	self._txtCurDamageTitle.text = btlResultInfo.singleDamgeTitle or ""

	self._curDamage:SetActive(not string.nilorempty(btlResultInfo.singleDamgeTitle))

	self._txtTotalDamage.text = checknumber(btlResultInfo.totalDamage)
	self._txtTotalDamageTitle.text = btlResultInfo.totalDamageTitle or ""

	self._totalDamage:SetActive(btlResultInfo.totalDamage ~= nil)

	self._txtTitle.text = btlResultInfo.title
	self._txtTips.text = btlResultInfo.tips or ""

	self._tips:SetActive(not string.nilorempty(btlResultInfo.tips))
	self._goSuccess:SetActive(btlResultInfo.showSuccess)

	if btlResultInfo.items and #btlResultInfo.items > 0 then
		self._txtOk.text = "领取奖励"

		self._rewards:SetActive(true)
		self:_updateRewards(btlResultInfo.items)
	else
		height = height - 100
		self._txtOk.text = "知道了"

		self._rewards:SetActive(false)
	end

	if btlResultInfo.pushStack then
		UIJumper.instance:pushOneStack(btlResultInfo.pushStack, true)
	end

	local hasTip = not string.nilorempty(btlResultInfo.text)

	self._tipTitle:SetActive(hasTip)
	self._tipContent.gameObject:SetActive(hasTip)

	if hasTip then
		self._txtTitle.text = btlResultInfo.subTitle
		self._tipContent.text = btlResultInfo.text
	end

	local rewardTitle = btlResultInfo.rewardTitle

	self._txtRewardTitle.text = string.nilorempty(rewardTitle) and "获得奖励" or rewardTitle
end

function TLCBattleResultView:_updateRewards(items)
	local transform = self._itemsLayout.transform
	local cnt = transform.childCount

	items = items or {}

	local itemsCnt = #items

	while cnt < itemsCnt do
		cnt = cnt + 1

		local prefab = transform:GetChild(0).gameObject
		local child = UGUIToolHelper.AddChild(transform.gameObject, prefab)

		child.transform.localScale = prefab.transform.localScale
	end

	for i = 1, itemsCnt do
		local go = transform:GetChild(i - 1).gameObject

		go:SetActive(true)
		self:_updateOneReward(go, items[i])
	end

	for i = itemsCnt + 1, cnt do
		local go = transform:GetChild(i - 1).gameObject

		go:SetActive(false)
	end

	if itemsCnt <= self._itemsLayout.lines then
		self._itemsLayout.layoutOption = UILayoutSingleLine.LayoutOption.HorizontalCenter

		Framework.TransformUtil.SetLocalPos(self._itemsLayout.transform, 350, -54, 0)
	else
		self._itemsLayout.layoutOption = UILayoutSingleLine.LayoutOption.LeftRight

		Framework.TransformUtil.SetLocalPos(self._itemsLayout.transform, 50, -50, 0)
	end

	local sizeDelta = self._itemsView.sizeDelta

	sizeDelta.y = 10 + math.abs(math.ceil(itemsCnt / self._itemsLayout.lines) * self._itemsLayout.verticalSpace)
	self._itemsView.sizeDelta = sizeDelta

	self._itemsLayout:Layout()
end

function TLCBattleResultView:_updateOneReward(cell, data)
	local matStr = string.format("%s:%s:%s", data.type, data.id, data.num)

	if data.type == MatType.Pet then
		print("pet.id = " .. data.id .. " num = " .. data.num)

		local petMo = BagPetsController.instance:getPet(data.id)

		MaterialMgr.setCellByMo(petMo, cell)
	else
		MaterialMgr.setCellByCfg(matStr, cell)
	end

	table.insert(self._cells, cell)
end

function TLCBattleResultView:_onClickOk()
	MaterialController.instance:showChangeSetInTemp(self._btlResultInfo.changeSetId)
	self:_onClickClose()
end

function TLCBattleResultView:_onClickClose()
	self:close()

	if ViewMgr.instance:isOpen(ViewName.AruisiMainView) then
		-- block empty
	else
		BattleController.instance:endBattle()
	end

	GameUtil.callBack(self._closeHandler, self._closeTarget)
end

return TLCBattleResultView
