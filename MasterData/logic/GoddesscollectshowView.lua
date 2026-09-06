-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscollector/view/GoddesscollectshowView.lua

module("logic.extensions.goddesscollector.view.GoddesscollectshowView", package.seeall)

local GoddesscollectshowView = class("GoddesscollectshowView", ViewComponent)
local RARE_SKIN_SHOW_DIC = {
	5,
	9,
	7,
	6,
	8,
	10,
	3
}
local SHOW_SKIN_CELL_NUM = 7

function GoddesscollectshowView:ctor()
	GoddesscollectshowView.super.ctor(self)
end

function GoddesscollectshowView:unbindEvents()
	GoddesscollectshowView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnJump)
	GameUtil.rmClickHandler(self._btnRule)
end

function GoddesscollectshowView:bindEvents()
	GoddesscollectshowView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnJump, self._onClickBtnJump, self)
	GameUtil.addClickHandler(self._btnRule, self._onClickRule, self)
end

function GoddesscollectshowView:buildUI()
	GoddesscollectshowView.super.buildUI(self)

	self._rewardcell = self:getGo("scorollReward/rewardcell")
	self._tableview = self:getGo("scorollReward/tableview")
	self._scrollList = ScrollerList.create(self._tableview, self._rewardcell, GameUtil.handler(self._updateRewardCell, self), GameUtil.handler(self._clearRewardCell, self))
	self._txtProgress = self:getTxt("total/txtProgress")
	self._progressSlider = self:getSlider("scorollReward/tableview/viewport/content/progressSlider")
	self._txtTime = self:getTxt("txtOpenTime/txt")
	self._btnJump = self:getGo("btnJump")
	self._btnRule = self:getGo("btnRule")
end

function GoddesscollectshowView:onExit()
	GoddesscollectshowView.super.onExit(self)

	for i, sequence in ipairs(self._fadeSequenceList) do
		sequence:Kill(true)

		sequence = nil
	end

	GlobalDispatcher:removeListener(GoddesscollectorController.PM_GoddessCollectorGetInfoRes, self._getInfoRes, self)
	GlobalDispatcher:removeListener(GoddesscollectorController.PM_GoddessCollectorGainPrizeRes, self._onUpdate, self)
end

function GoddesscollectshowView:onEnter()
	GoddesscollectshowView.super.onEnter(self)
	GlobalDispatcher:addListener(GoddesscollectorController.PM_GoddessCollectorGetInfoRes, self._getInfoRes, self)
	GlobalDispatcher:addListener(GoddesscollectorController.PM_GoddessCollectorGainPrizeRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.OnMaterialItemChange, self._onMaterialsChange, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	GoddesscollectorModel.instance:setActivityId(self._activityId)

	self._activityType = 124
	self._actCfg = GoddesscollectorConfig.instance:getActCfg(self._activityId)
	self._collectPrizeCfg = GoddesscollectorConfig.instance:getPrizeCfgs(self._actCfg.skinPrizePlanId)
	self._curRewardIdx = 0
	self._skinPlanId = self._actCfg.skinPlanId
	self._qualityDic = GoddesscollectorConfig.instance:getQualityToSkinIdDic(self._skinPlanId, RARE_SKIN_SHOW_DIC)
	self._fadeInterval = 1
	self._waitInterval = 1
	self._fadeSequenceList = {}

	for i = 1, SHOW_SKIN_CELL_NUM do
		local sequence = self._fadeSequenceList[i]

		if sequence then
			sequence:Kill(true)

			sequence = nil
		end

		local sequence = DG.Tweening.DOTween.Sequence()

		table.insert(self._fadeSequenceList, sequence)
	end

	self._animIndexList = {
		1,
		1,
		1,
		1,
		1,
		1,
		1
	}

	self:_setUI()
	GoddessCollectorAgent.instance:sendPM_GoddessCollectorGetInfoReq(self._activityId)
end

function GoddesscollectshowView:_getInfoRes()
	for i = 1, SHOW_SKIN_CELL_NUM do
		local sequence = self._fadeSequenceList[i]

		if sequence then
			sequence:Kill(true)

			sequence = nil
		end

		local sequence = DG.Tweening.DOTween.Sequence()

		table.insert(self._fadeSequenceList, sequence)
	end

	self._animIndexList = {
		1,
		1,
		1,
		1,
		1,
		1,
		1
	}

	self:_onUpdate()
	self:_setAnimation()
end

function GoddesscollectshowView:_setUI()
	self._txtTime.text = GameUtil.getActTimeDesc(self._activityType, self._activityId)

	for idx, rareId in ipairs(RARE_SKIN_SHOW_DIC) do
		local pointRareChange = self:getGo("show/cell" .. idx .. "/pointRare"):GetComponent(ComponentType.UIImageSpriteChange)

		pointRareChange:SetState(rareId)

		local imgPet = self:getGo("show/cell" .. idx .. "/imgPet/mask/img")
		local imgPetComp = imgPet:GetComponent(goutil.Type_UIImage)

		imgPetComp.color = Color.New(1, 1, 1, 0)
	end
end

function GoddesscollectshowView:_onUpdate()
	self:_updateData()
	self:_updateUI()
end

function GoddesscollectshowView:_updateData()
	self._qualityList = GoddesscollectorModel.instance:getSkinQualityList()
end

function GoddesscollectshowView:_updateUI()
	for idx, rareId in ipairs(RARE_SKIN_SHOW_DIC) do
		local txtSkinNum = self:getTxt("show/cell" .. idx .. "/skinNum")
		local skinNum = GoddesscollectorModel.instance:getSkinQualityNumBySkinRareId(rareId)

		txtSkinNum.text = "已拥有:" .. skinNum
	end

	local scoreList = {}

	for i, v in ipairs(self._collectPrizeCfg) do
		table.insert(scoreList, v.needScore)
	end

	self._scrollList:reloadData(self._collectPrizeCfg)

	local curScore = GoddesscollectorModel.instance:getSkinCollectScore()
	local nextScore = self:_getNextScore()

	self._txtProgress.text = nextScore == nil and "已全部完成" or "距离下一级奖励：" .. curScore .. "/<color=#EB4642>" .. nextScore .. "</color>"

	self._scrollList:updateUnderSlider(self._progressSlider, curScore, scoreList)
end

function GoddesscollectshowView:_setAnimation()
	for idx, qualityIdx in ipairs(RARE_SKIN_SHOW_DIC) do
		local skinRareShowCfg = self._qualityDic[qualityIdx]
		local imgPet = self:getGo("show/cell" .. idx .. "/imgPet/mask/img")
		local imgPetComp = imgPet:GetComponent(goutil.Type_UIImage)
		local curImgIdx = self._animIndexList[idx]
		local cellGo = self:getGo("show/cell" .. idx)

		if not skinRareShowCfg or #skinRareShowCfg == 0 then
			GameUtil.SetActive(cellGo, false)
		else
			GameUtil.SetActive(cellGo, true)

			local modelCo = CharacterConfig.instance:getModelCo(checknumber(skinRareShowCfg[curImgIdx].skinId))

			uGuiUtil.clearImage(imgPet)
			uGuiUtil.setSpriteToImage(imgPet, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName))

			local sequence = self._fadeSequenceList[idx]

			if sequence then
				sequence:Kill(true)

				sequence = nil
			end

			sequence = DG.Tweening.DOTween.Sequence()
			self._fadeSequenceList[idx] = sequence

			local randomTime = math.random(30, 50) / 10
			local fadeInTween = imgPetComp:DOFade(1, randomTime):SetEase(DG.Tweening.Ease.Linear)
			local fadeOutTween = imgPetComp:DOFade(0, self._fadeInterval):SetEase(DG.Tweening.Ease.Linear):OnComplete(function()
				local length = #skinRareShowCfg

				self._animIndexList[idx] = self._animIndexList[idx] % length + 1

				local curImgIdx = self._animIndexList[idx]
				local modelCo = CharacterConfig.instance:getModelCo(checknumber(skinRareShowCfg[curImgIdx].skinId))

				uGuiUtil.clearImage(imgPet)
				uGuiUtil.setSpriteToImage(imgPet, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName))
			end)

			sequence:Append(fadeInTween)
			sequence:AppendInterval(self._waitInterval)
			sequence:Append(fadeOutTween)
			sequence:SetLoops(-1)
		end
	end
end

function GoddesscollectshowView:_updateRewardCell(view, cell, data)
	local item = goutil.findChild(cell, "item")
	local geted = goutil.findChild(cell, "geted")
	local txtScore = goutil.findChildTextComponent(cell, "txtScore")
	local btnGet = goutil.findChild(cell, "btnGet")
	local effect = goutil.findChild(cell, "effect")
	local hasGet = checkbool(GoddesscollectorModel.instance:isGainSkinCollectPrize(data.prizeId))
	local isCanGet = GoddesscollectorModel.instance:isCanGainSkinCollectPrize(data.prizeId)

	txtScore.text = data.needScore

	MaterialMgr.setCellByCfg(data.prize, item)
	GameUtil.SetActive(geted, hasGet)
	GameUtil.SetActive(btnGet, isCanGet and not hasGet)
	self:_clearCellEffect(effect)

	if isCanGet and not hasGet then
		self:_playCellEffect(effect)
	end

	GameUtil.addClickHandler(btnGet, GameUtil.handler(self._onClickGetPrize, self, data), self)
end

function GoddesscollectshowView:_clearRewardCell(cell)
	local item = goutil.findChild(cell, "item")
	local effect = goutil.findChild(cell, "effect")
	local btnGet = goutil.findChild(cell, "btnGet")

	MaterialMgr.resetAll(item)
	self:_clearCellEffect(effect)
	GameUtil.rmClickHandler(btnGet)
end

local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"

function GoddesscollectshowView:_playCellEffect(effGo)
	self:_clearCellEffect(effGo)

	local uiEffect = UIEffectManager.instance:playEffect(self, effPath, effGo.transform, 0, 0, true, false, nil, function(target, eff)
		eff:setClipping(self:getGo("scorollReward/tableview/viewport").transform)
	end)

	uiEffect:setParent(effGo.transform)
	uiEffect:setLocalPos(0, 0, 0)
	uiEffect:setScale(1)

	self._cellEffects = self._cellEffects or {}
	self._cellEffects[effGo] = uiEffect
end

function GoddesscollectshowView:_clearCellEffect(effGo)
	if self._cellEffects and self._cellEffects[effGo] then
		UIEffectManager.instance:stopEffect(self._cellEffects[effGo])

		self._cellEffects[effGo] = nil
	end
end

function GoddesscollectshowView:_getNextScore()
	for i, data in ipairs(self._collectPrizeCfg) do
		local curScore = GoddesscollectorModel.instance:getSkinCollectScore()
		local isCanGet = curScore >= data.needScore

		if isCanGet then
			self._curRewardIdx = data.prizeId
		end
	end

	if self._curRewardIdx < #self._collectPrizeCfg then
		return self._collectPrizeCfg[self._curRewardIdx + 1].needScore
	end
end

function GoddesscollectshowView:_onClickGetPrize(data)
	local hasGet = checkbool(GoddesscollectorModel.instance:isGainSkinCollectPrize(data.prizeId))

	if not hasGet then
		local isCanGet = GoddesscollectorModel.instance:isCanGainSkinCollectPrize(data.prizeId)

		if isCanGet then
			GoddessCollectorAgent:sendPM_GoddessCollectorGainPrizeReq(self._activityId, GameEnum.GoddessCollector_PrizeType.SKIN_PRIZE, data.prizeId)
		else
			TipsFacade.instance:openCommonTips("还没达到条件哦~")
		end
	end
end

function GoddesscollectshowView:_onMaterialsChange(mo)
	if mo:GetMatType() == MatType.PET_SKIN then
		GoddessCollectorAgent.instance:sendPM_GoddessCollectorGetInfoReq(self._activityId)
	end
end

function GoddesscollectshowView:_onClickBtnJump()
	PetbookModel.instance:setPetbookTab(PetbookModel.TAB_PET_SKINID)
	UIStateManager.instance:push(ViewName.PetbookView)
end

function GoddesscollectshowView:_onClickRule()
	TipsFacade.instance:openRulesView("yanmobestpartnerview_1")
end

return GoddesscollectshowView
