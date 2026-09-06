-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guide/view/GuideQilinView.lua

module("logic.extensions.guide.view.GuideQilinView", package.seeall)

local GuideQilinView = class("GuideQilinView", ViewComponent)

GuideQilinView.TOTAL_TIME = 3600

function GuideQilinView:ctor()
	GuideQilinView.super.ctor(self)
end

function GuideQilinView:buildUI()
	self._btnClose = self:getBtn("lefttop/btnClose")
	self._petContainer = self:getGo("petContainer")

	self:_buildInfoUI()

	self._rewardGroup = self:getGo("rewards/rewardGroup")
	self._rewardCfgs = ActivityParamsConfig.instance:getHuangjinshenglongCfgs()
	self._rewardsRectTrans = self:getGo("rewards"):GetComponent(typeof(UnityEngine.RectTransform))
end

function GuideQilinView:_buildInfoUI()
	self._info = self:getGo("spriteIconGo")
	self._txtName = goutil.findChildTextComponent(self._info, "spriteNameTxt")
	self._btnIntroduce = Framework.ButtonAdapter.GetFrom(self._info, "btnIntroduce")
	self._btnSkill = Framework.ButtonAdapter.GetFrom(self._info, "btnSkill")
	self._rare = self:getGo("spriteIconGo/rare")
end

function GuideQilinView:bindEvents()
	self._btnClose:AddClickListener(self.close, self)
	self._btnSkill:AddClickListener(self._onClickSkill, self)
	self._btnIntroduce:AddClickListener(self._onClickIntroduce, self)
end

function GuideQilinView:unbindEvents()
	self._btnClose:RemoveClickListener()
	self._btnSkill:RemoveClickListener()
	self._btnIntroduce:RemoveClickListener()
end

local effPaths = {
	{
		goPath = "",
		path = "fx_ui_songhuangjinshenglong/fx_ui_songhuangjinshenglong_qifen.prefab"
	}
}

function GuideQilinView:_createEffects()
	for k, v in ipairs(effPaths) do
		self:_playEffect(v.path, (not string.nilorempty(v.goPath) or nil) and self:getGo(v.goPath), self._effs)
	end
end

function GuideQilinView:_playEffect(url, parent, list)
	local eff = UIEffectManager.instance:playEffect(self, url, parent, 0, 0, true, nil, nil, function(self2, uiEffect)
		uiEffect:setClipping(parent:GetComponent(goutil.Type_RectTransform))
		uiEffect:setParent(parent.transform)
		uiEffect:setScale(1)
		uiEffect:setLocalPos(0, 0, 0)
	end)

	table.insert(list, eff)
end

function GuideQilinView:onEnter()
	self._raceId = 10324
	self._role = RoleObjectPool.instance:addRoleToParent(self._role, self._raceId, self._petContainer.transform)
	self._effs = {}

	self:_createEffects()
	self:_updateInfo()
	NewHandAgent.instance:sendGetKirinInfoReq(self._onGetInfo, self)
end

function GuideQilinView:_updateInfo()
	local petCfg = CharacterConfig.instance:getPetCo(self._raceId)

	MaterialMgr.setCell(MatType.Rare, self._raceId, self._rare)

	self._txtName.text = petCfg.name
end

function GuideQilinView:_onGetInfo(msg)
	GuideModel.instance:setGainedIds(msg.GainIds)
	self:_refresh()
end

function GuideQilinView:_refresh()
	self._items = {}

	if self._receiveEffs then
		for _, v in ipairs(self._receiveEffs) do
			UIEffectManager.instance:stopEffect(v)
		end
	end

	self._receiveEffs = {}

	GameUtil.updateCellsWithCreate(self._rewardGroup, self._rewardCfgs, self._updateOneReward, self)
end

function GuideQilinView:_updateOneReward(cell, cfg)
	local btnReceive = Framework.ButtonAdapter.GetFrom(cell, "btnReceive")
	local imgReceived = goutil.findChild(cell, "imgReceived")
	local txtCondition = goutil.findChildTextComponent(cell, "GameObject/txtCondition")
	local itemPoint = goutil.findChild(cell, "itemPoint")
	local canReceiveGo = goutil.findChild(cell, "canReceive")
	local txtCurProgress = goutil.findChildTextComponent(cell, "GameObject/txtCurProgress")
	local idx = checknumber(cfg.subKey)
	local condition = cfg.value.condition
	local material = cfg.value.mp

	MaterialMgr.setCellByCfg(material, itemPoint)
	table.insert(self._items, itemPoint)

	local passCondition = FuncOpenController.instance:parseCondition(condition)
	local received = GuideModel.instance:getGainedById(idx)
	local canReceive = passCondition and not received

	imgReceived:SetActive(received)
	btnReceive.gameObject:SetActive(not received)
	canReceiveGo:SetActive(canReceive)

	if canReceive then
		local url = "fx_ui_longchengmibao/fx_ui_longchengmibao.prefab"

		self:_playEffect(url, canReceiveGo, self._receiveEffs)
	end

	local conditionParams = string.splitToNumber(condition, ",")
	local lockTip = ""

	if conditionParams[1] == 2 then
		txtCondition.text = string.format("训练师等级%s级领取", conditionParams[2])
		txtCurProgress.text = string.format("当前训练师等级：<color=#FFE570FF>%s</color>级", MofangModel.instance:getCurLv())
	elseif conditionParams[1] == 4 then
		local chapterId, stageId = conditionParams[2], conditionParams[3]
		local stageCfg = CopyConfig.instance:getStageById(chapterId, stageId)

		txtCondition.text = string.format("通关%s领取", stageCfg.stageName)

		local maxChapterId, maxStageId = PlotCopyModel.instance:getCurMaxProgress()
		local maxStageCfg = CopyConfig.instance:getStageById(maxChapterId, maxStageId)

		txtCurProgress.text = string.format("当前进度：<color=#FFE570FF>%s</color>", maxStageCfg.stageName)
		lockTip = string.format("剧情关卡达到%s即可领取", stageCfg.stageName)
	end

	txtCurProgress.gameObject:SetActive(not received)
	btnReceive:AddClickListener(function()
		self:_onClickReceive(idx, passCondition, lockTip)
	end)
end

function GuideQilinView:_addContent(uiText, content)
	uiText.text = content
end

function GuideQilinView:_onClickReceive(index, passCondition, lockTip)
	print("clickReceive")

	if not passCondition then
		FloatWordMgr.instance:show(lockTip)
	else
		NewHandAgent.instance:sendGainFinalGiftReq(index, function(msg)
			GuideModel.instance:setGainedById(index)
			self:_refresh()
		end)
	end
end

function GuideQilinView:_onClickIntroduce()
	PetbookModel.instance:setSelectedPet(self._raceId)
	UIStateManager.instance:push(ViewName.HandbookpetinfoView, self._raceId)
end

function GuideQilinView:_onClickSkill()
	PetbookController.instance:previewBattle(self._raceId)
end

function GuideQilinView:onExit()
	GuideQilinView.super.onExit(self)
	removetimer(self._onTick, self)

	self._role = RoleObjectPool.instance:removeRole(self._role)
	self._role = nil

	for _, eff in ipairs(self._effs) do
		UIEffectManager.instance:stopEffect(eff)
	end

	for _, v in ipairs(self._receiveEffs) do
		UIEffectManager.instance:stopEffect(v)
	end

	self._effs = nil

	MaterialMgr.resetAll(self._rare)
end

return GuideQilinView
