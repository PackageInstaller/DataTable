-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/niannianchall/view/NianNianChallMainView.lua

module("logic.extensions.niannianchall.view.NianNianChallMainView", package.seeall)

local NianNianChallMainView = class("NianNianChallMainView", ViewComponent)

function NianNianChallMainView:ctor()
	NianNianChallMainView.super.ctor(self)
end

function NianNianChallMainView:unbindEvents()
	NianNianChallMainView.super.unbindEvents(self)
	self._btnRank:RemoveClickListener()
	self._tipRank:RemoveClickListener()
	self._tipTry:RemoveClickListener()
	self._btnTry:RemoveClickListener()
	self._btnRule:RemoveClickListener()
	self._btnIntroduce:RemoveClickListener()
	self._btnSkill:RemoveClickListener()
	self._btnGoto:RemoveClickListener()
	self._btnChall:RemoveClickListener()
	self._closeButton:RemoveClickListener()
end

function NianNianChallMainView:bindEvents()
	NianNianChallMainView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnRank:AddClickListener(self._onClickRank, self)
	self._tipRank:AddClickListener(self._onClickRank, self)
	self._tipTry:AddClickListener(self._onClickTry, self)
	self._btnTry:AddClickListener(self._onClickTry, self)
	self._btnRule:AddClickListener(self._onClickRule, self)
	self._btnIntroduce:AddClickListener(self._onClickIntroduce, self)
	self._btnSkill:AddClickListener(self._onClickSkill, self)
	self._btnGoto:AddClickListener(self._onClickGoto, self)
	self._btnChall:AddClickListener(self._onClickStart, self)
end

function NianNianChallMainView:buildUI()
	NianNianChallMainView.super.buildUI(self)

	self._closeButton = self:getBtn("topleft/btnClose")
	self._con = self:getGo("con")
	self._btnRank = self:getBtn("btnRank")
	self._tipRank = self:getBtn("tipRank")
	self._pointRankItem = self:getGo("tipRank/pointItem")
	self._txtTipRank = goutil.findChildTextComponent(self._tipRank, "txtTip")
	self._btnTry = self:getBtn("btnTry")
	self._pointTryItem = self:getGo("tipTry/pointItem")
	self._tipTry = self:getBtn("tipTry")
	self._btnRule = self:getBtn("topleft/btnRule")
	self._btnGoto = self:getBtn("contract/btnGoto")
	self._txtMainName = self:getTxt("topleft/title")
	self._txtRules = self:getTxt("rules/cell_1")
	self._btnChall = self:getBtn("btnChallenge/btnStart")
	self._challengeId = 23
	self._slider = self:getGo("ScrollRect/ViewPort/Content/progressBar"):GetComponent(typeof(UnityEngine.UI.Slider))
	self._gridLayout = self:getGo("ScrollRect/ViewPort/Content/prizes"):GetComponent(typeof(UnityEngine.UI.GridLayoutGroup))
	self._content = self:getGo("ScrollRect/ViewPort/Content"):GetComponent(typeof(UnityEngine.RectTransform))
	self._viewPort = self:getGo("ScrollRect/ViewPort"):GetComponent(typeof(UnityEngine.RectTransform))
	self._scrollRect = self:getGo("ScrollRect"):GetComponent(typeof(UnityEngine.UI.ScrollRect))
	self._txtCurScore = self:getTxt("total/txtNum")
	self._bar = DiscreteProgressBar.New(self._slider, self._gridLayout)
	self._txtCurNum = self:getTxt("txtCurNum")

	self:_buildInfoUI()
end

function NianNianChallMainView:onExit()
	NianNianChallMainView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.NianNianChallGetPrize, self._updateProgressBar, self)

	for _, eff in ipairs(self._effs) do
		UIEffectManager.instance:stopEffect(eff)
	end

	self._effs = nil
end

function NianNianChallMainView:onEnter()
	NianNianChallMainView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.NianNianChallGetPrize, self._updateProgressBar, self)

	self._effs = {}
	self._raceId = checknumber(NianNianChallConfig.instance:getCommonCfg("RANK_PET_RACE_ID"))

	self:_updateInfo(self._raceId)
	self:_updateProgressBar()

	self._txtMainName.text = lang("nian_chall_main_name")
	self._txtRules.text = lang("nian_chall_main_rule")
end

function NianNianChallMainView:_buildInfoUI()
	self._info = self:getGo("info")
	self._pointRare = goutil.findChild(self._info, "pointRare")
	self._txtName = goutil.findChildTextComponent(self._info, "txtName")
	self._btnIntroduce = Framework.ButtonAdapter.GetFrom(self._info, "btnIntroduce")
	self._btnSkill = Framework.ButtonAdapter.GetFrom(self._info, "btnSkill")
end

function NianNianChallMainView:_updateInfo(raceId)
	self.skinId = raceId

	local petCfg = CharacterConfig.instance:getPetCo(raceId)

	MaterialMgr.setCell(MatType.Rare, raceId, self._pointRare)

	if self._txtName then
		self._txtName.text = petCfg.name
	end

	if not self._skinId then
		local skinId = raceId

		self._role = RoleObjectPool.instance:removeRole(self._role)

		local scale = 1

		self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, scale, nil, nil, 0, 0)

		if self._pointExchangeItem then
			MaterialMgr.setCell(MatType.Pet, raceId, self._pointExchangeItem)
		end

		local names = string.split(petCfg.name, "·")

		if self._txtTipExchange then
			self._txtTipExchange.text = string.format("可兑换%s", self._shortName)
		end

		local collegeId = PetCollegeConfig.instance:raceId2ChallengeId(checknumber(self.skinId))

		if checknumber(collegeId) > 0 then
			local stageCfgs = PetCollegeConfig.instance:getStageCfg(collegeId)
			local passedStageId = PetCollegeModel.instance:getCurrPassStageId(collegeId)
			local prizeDic = {}

			for k, v in ipairs(stageCfgs) do
				if passedStageId < k then
					local matType, matId, matNum = unpack(string.splitToNumber(v.firstPassPrize, ":"))
					local key = matType .. ":" .. matId

					prizeDic[key] = checknumber(prizeDic[key]) + matNum
				end
			end

			local matStr = ""

			for k, v in pairs(prizeDic) do
				matStr = k .. ":" .. v
			end

			MaterialMgr.setCellByCfg(matStr, self._pointTryItem)
			self._tipTry.gameObject:SetActive(not string.nilorempty(matStr))
		end
	end
end

function NianNianChallMainView:_onClickClose()
	self:close()
end

function NianNianChallMainView:_onClickRank()
	UIStateManager.instance:push(ViewName.LightKingRankView, self._challengeId)
end

function NianNianChallMainView:_onClickTry()
	local skinId = self.skinId

	if skinId then
		local cfg = PetSkinConfig.instance:getPetSkinCfg(skinId)

		if cfg then
			local raceId = cfg.raceId

			FuncOpenController.instance:openFunc(149, raceId)
		end
	end
end

function NianNianChallMainView:_onClickIntroduce()
	local skinId = self.skinId

	if skinId then
		local cfg = PetSkinConfig.instance:getPetSkinCfg(skinId)

		if cfg then
			local raceId = cfg.raceId

			PetbookController.instance:openPetinfoView(raceId)
		end
	end
end

function NianNianChallMainView:_onClickSkill()
	local skinId = self.skinId

	if skinId then
		local cfg = PetSkinConfig.instance:getPetSkinCfg(skinId)

		if cfg then
			local raceId = cfg.raceId

			PetbookController.instance:previewBattle(raceId, self.skinId)
		end
	end
end

function NianNianChallMainView:_onClickRule()
	UIStateManager.instance:open(ViewName.RulesView, "niannianchallenge")
end

function NianNianChallMainView:_onClickGoto()
	UIStateManager.instance:push(ViewName.HeartGrowUpView)
end

function NianNianChallMainView:_updateProgressBar2()
	local prizeCfgs = NianNianChallConfig.instance:getPrizeCfg()
	local prizeNum = #prizeCfgs
	local cellWidth = self._gridLayout.cellSize.x
	local spacingX = self._gridLayout.spacing.x
	local sliderRectTrans = self._slider:GetComponent(typeof(UnityEngine.RectTransform))
	local gridRectTrans = self._gridLayout:GetComponent(typeof(UnityEngine.RectTransform))
	local sizeDelta = sliderRectTrans.sizeDelta
	local barWidth = cellWidth * (prizeNum - 1) + spacingX * prizeNum

	sizeDelta.x = barWidth
	sliderRectTrans.sizeDelta = sizeDelta

	Framework.TransformUtil.SetAnchoredPos(gridRectTrans, spacingX, 0)
	GameUtil.updateCellsWithCreate(self._gridLayout, prizeCfgs, self._updateOnePrize, self)

	local curScore = NianNianChallModel.instance:getStageId()
	local progressVal = 0

	for k, v in ipairs(prizeCfgs) do
		local score = v.stageId

		if curScore < score then
			local preCfg = prizeCfgs[k - 1]
			local preScore = 0

			if preCfg then
				preScore = preCfg.stageId
			end

			progressVal = progressVal + (curScore - preScore) / (score - preScore) * spacingX / barWidth

			break
		else
			progressVal = progressVal + (cellWidth + spacingX) / barWidth
		end
	end

	print("updateVal = " .. progressVal)

	self._slider.value = progressVal
end

function NianNianChallMainView:_onClickStart()
	local actId = checknumber(NianNianChallConfig.instance:getCommonCfg("PET_GROWTH_PATH_ACTIVITY_ID"))

	GrowUpRoadController:getHasGainPet(actId, function(torf)
		if torf then
			UIStateManager.instance:push(ViewName.NianNianChallView)
		else
			TipsFacade.instance:openPopupWindow("", lang("nian_chall_enter_stage_tip"), function()
				UIStateManager.instance:push(ViewName.HeartGrowUpView)
			end, nil, "前往", nil, UnityEngine.TextAnchor.MiddleCenter)
		end
	end)
end

function NianNianChallMainView:_updateOnePrize(go, cfg)
	local itemPoint = goutil.findChild(go, "item/itemcell")
	local txtNum = goutil.findChildTextComponent(go, "txtNum")
	local received = goutil.findChild(go, "item/received")

	MaterialMgr.setCellByCfg(cfg.prizeShow, itemPoint)

	local btn = Framework.ButtonAdapter.GetFrom(go, "btn")

	txtNum.text = cfg.stageId

	local gained = NianNianChallModel.instance:getProcessPrize(cfg.prizeId)

	received:SetActive(gained)

	local canGain = cfg.stageId <= NianNianChallModel.instance:getStageId()

	if canGain and not gained then
		local url = "fx_ui_longchengmibao/fx_ui_longchengmibao.prefab"

		self:_playEffect(url, go, 0.7, true)
		btn.gameObject:SetActive(true)
		btn:AddClickListener(function()
			self:_onClickPrize(cfg)
		end)
	else
		btn.gameObject:SetActive(false)
	end
end

function NianNianChallMainView:_onClickPrize(cfg)
	NianNianChallController.instance:sendGetPrize(cfg.prizeId)
end

function NianNianChallMainView:_playEffect(url, parent, scale)
	local eff = UIEffectManager.instance:playEffect(self, url, parent, 0, 0, true, nil, nil, function(self2, uiEffect)
		uiEffect:setClipping(self._viewPort)
		uiEffect:setParent(parent.transform)
		uiEffect:setScale(scale or 1)

		local rectTrans = uiEffect.effGo:GetComponent(typeof(UnityEngine.RectTransform))

		Framework.TransformUtil.SetAnchoredPos(rectTrans, 0, 11.5)

		uiEffect.hideEffWhileNotOnTop = true
	end)

	table.insert(self._effs, eff)
end

function NianNianChallMainView:_updateProgressBar(needSetOffset)
	local curScore = NianNianChallModel.instance:getStageId()
	local scores = {}
	local prizeCfgs = NianNianChallConfig.instance:getPrizeCfg()

	for _, v in ipairs(prizeCfgs) do
		table.insert(scores, v.stageId)
	end

	local x = self._bar:setValue(scores, curScore)

	self._content.sizeDelta = Vector2.New(x + 70, 100)
	self._txtCurScore.text = string.format("关卡数\n%d", curScore)

	if self._canGainEffs then
		for _, v in ipairs(self._canGainEffs) do
			UIEffectManager.instance:stopEffect(v)
		end
	end

	self._canGainEffs = {}
	self._minGainedId = 0

	GameUtil.updateCellsWithCreate(self._gridLayout, prizeCfgs, self._updateOnePrize, self)

	if needSetOffset then
		local viewPortSize = self._viewPort.rect.size.x
		local contentSize = self._content.sizeDelta.x
		local maxOffset = contentSize - viewPortSize

		Framework.TransformUtil.SetAnchoredPos(self._content, 0, 0)

		local x, y, z = Framework.TransformUtil.GetLocalPos(self._content.transform, 0, 0, 0)
		local cellWidth = self._gridLayout.cellSize.x
		local spacingX = self._gridLayout.spacing.x

		x = x - math.min(maxOffset, cellWidth * self._minGainedId + spacingX * self._minGainedId)

		Framework.TransformUtil.SetLocalPos(self._content.transform, x, 0, 0)
	end
end

return NianNianChallMainView
