-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godaruishichallenge/view/GodARuiShiChallengeMainView.lua

module("logic.extensions.godaruishichallenge.view.GodARuiShiChallengeMainView", package.seeall)

local GodARuiShiChallengeMainView = class("GodARuiShiChallengeMainView", ViewComponent)

GodARuiShiChallengeMainView.ChallengeCellPosition = {
	{
		rotate = -197,
		x = -297,
		y = 187,
		bubblepos = {
			-138.4,
			2.3
		}
	},
	{
		rotate = -176,
		x = -414,
		y = 23,
		bubblepos = {
			-171,
			20
		}
	},
	{
		rotate = -160,
		x = -414,
		y = -176,
		bubblepos = {
			-156,
			19
		}
	},
	{
		rotate = 17,
		x = 328,
		y = 216,
		bubblepos = {
			81,
			0
		}
	},
	{
		rotate = -6,
		x = 456,
		y = 70,
		bubblepos = {
			77,
			0
		}
	},
	{
		rotate = -21,
		x = 482,
		y = -137,
		bubblepos = {
			91,
			-8
		}
	}
}

function GodARuiShiChallengeMainView:ctor()
	self._bossScale = 1.3
	self._nomalScale = 0.8
	self._effectBtnScale = 1.3
	self._changeProgress = 0.7
	self._effectOffect = 180
end

function GodARuiShiChallengeMainView:buildUI()
	GodARuiShiChallengeMainView.super.buildUI(self)

	self._btnClose = self:getBtn("leftTop/btnClose")
	self._btnRule = self:getBtn("btnRule")
	self._btnTip = self:getBtn("btnTip")
	self._challengeCell = self:getGo("challengeCell")
	self._challengeGo = self:getGo("challengeGroup")
	self._challengeGroup = ItemGroup.New(self._challengeGo, self._challengeCell)
	self._txtWave = self:getTxt("count/txt")
	self._btnReset = self:getBtn("btnReset")
	self._bg = self:getGo("bg")
	self._energySlider = self:getSlider("energySlider")
	self._energyEffect = self:getGo("energySlider/energyEffect")
	self._txtProgress = self:getTxt("energySlider/txt")
	self._energyIcon = self:getGo("energySlider/txt/item")
	self._roleCon = self:getGo("con")
	self._roleBubble = self:getGo("con/bubble")
	self._btnRole = GameUtil.asBtn(self:getGo("con/btnClick"))
	self._btnOneKey = self:getBtn("btnOneKey")
	self._oneKeyItem = self:getGo("oneKeyItem/item")
	self._oneKeyItemGo = self:getGo("oneKeyItem")
	self._txtTips = self:getTxt("txtTips")
	self._tipsIcon = self:getGo("txtTips/item")
end

function GodARuiShiChallengeMainView:bindEvents()
	GodARuiShiChallengeMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnRule, self._onClickRule, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnOneKey, self._onClickOneKey, self)
	GameUtil.addClickHandler(self._btnReset, self._onClickReset, self)
	GameUtil.addClickHandler(self._btnRole, self._onClickRole, self)
end

function GodARuiShiChallengeMainView:unbindEvents()
	GodARuiShiChallengeMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnRule)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnOneKey)
	GameUtil.rmClickHandler(self._btnReset)
	GameUtil.rmClickHandler(self._btnRole)
end

function GodARuiShiChallengeMainView:onEnter()
	GodARuiShiChallengeMainView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.GodARuiShiChallengeInfoRes, self._refreshUI, self)
	GlobalDispatcher:addListener(GlobalNotify.GodARuiShiChallengeSkipRes, self._PM_GodARuiShiChallengeSkipRes, self)
	GlobalDispatcher:addListener(GlobalNotify.GodARuiShiChallengeOneKeyPassRes, self._refreshUI, self)
	self:_initView()
	GodARuiShiChallengeController.instance:send_GodARuiShiChallengeInfoReq(self._challengeId)
end

function GodARuiShiChallengeMainView:onExit()
	GodARuiShiChallengeMainView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.GodARuiShiChallengeInfoRes, self._refreshUI, self)
	GlobalDispatcher:removeListener(GlobalNotify.GodARuiShiChallengeSkipRes, self._PM_GodARuiShiChallengeSkipRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.GodARuiShiChallengeOneKeyPassRes, self._refreshUI, self)
	self._challengeGroup:dispose(self._clearCell, self)
	BubbleController.instance.CloseView(self)

	self._role = RoleObjectPool.instance:removeRole(self._role)

	uGuiUtil.clearImage(self._energyIcon)
	uGuiUtil.clearImage(self._tipsIcon)
	uGuiUtil.clearImage(self._bg)

	for i, v in pairs(self._btnEffect) do
		if v then
			UIEffectManager.instance:stopEffect(v)
		end
	end

	for i, v in pairs(self._btnShineEffect) do
		if v then
			UIEffectManager.instance:stopEffect(v)
		end
	end

	UIEffectManager.instance:stopEffect(self._energyEffectHandle)
	UIEffectManager.instance:stopEffect(self._resetEffect)
	UIEffectManager.instance:stopEffect(self._mainViewEffect)
	removetimer(self._showShineEffect, self)
end

function GodARuiShiChallengeMainView:_initView()
	local enterParams = self:getOpenParam()

	self._challengeId = enterParams[1]
	self._raceId = enterParams[2]
	self._perPass = GodARuiShiChallengeModel.instance:getTempPass()
	self._perScore = GodARuiShiChallengeModel.instance:getTempScore()
	self._cfgChallenge = GodARuiShiChallengeConfig.instance:getGlyData(self._challengeId)
	self._challengeBossTimes = GodARuiShiChallengeConfig.instance:getChallengeBossTimes(self._challengeId)
	self._maxWave = GodARuiShiChallengeConfig.instance:getChallengeMaxWave(self._challengeId)

	local skinId = 10144

	if not self._donotLoadRole and skinId then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._roleCon, nil, nil, false)
	end

	self._bubbleIndex = 1

	local var_7_0

	var_7_0, self._bubbleIndex = GodARuiShiChallengeConfig.instance:getRandomMyBubble(self._bubbleIndex)

	BubbleController.instance.OpenView(self, var_7_0, self._roleBubble.transform.position)

	if not string.nilorempty(self._cfgChallenge.passSaleAward) then
		MaterialMgr.setCellByCfg(self._cfgChallenge.passSaleAward, self._oneKeyItem)
	end

	GameUtil.SetActive(self._oneKeyItem, true)

	if self._btnEffect ~= nil then
		for i, v in pairs(self._btnEffect) do
			if v then
				UIEffectManager.instance:stopEffect(v)
			end
		end
	end

	self._btnEffect = {}

	if self._btnShineEffect ~= nil then
		for i, v in pairs(self._btnShineEffect) do
			if v then
				UIEffectManager.instance:stopEffect(v)
			end
		end
	end

	self._btnShineEffect = {}

	local cfgLimit = TimeLimitedConfig.instance:getCfgById(self._challengeId)
	local evolveChallengeId = GodARuiShiChallengeConfig.instance:getChallengeEvolveChallengeId()

	if cfgLimit and GameUtil.checkIsInTimePeriod(cfgLimit.absoluteOpenDay, self._cfgChallenge.passSaleAwardTime) and evolveChallengeId == self._challengeId then
		GameUtil.SetActive(self._oneKeyItemGo, true)
	else
		GameUtil.SetActive(self._oneKeyItemGo, false)
	end

	if evolveChallengeId == self._challengeId then
		GameUtil.SetActive(self._btnOneKey, true)
	else
		GameUtil.SetActive(self._btnOneKey, false)
	end

	if self._cfgChallenge.storyId and self._cfgChallenge.storyId > 0 and not GodARuiShiChallengeModel.instance:getFirstEnter(self._challengeId) then
		GodARuiShiChallengeModel.instance:saveFirstEnter(self._challengeId)
		GlobalDispatcher:addListener(GlobalNotify.EndStory, self._endStory, self)
		GlobalDispatcher:dispatch(GlobalNotify.StartStory, self._cfgChallenge.storyId)
	end
end

function GodARuiShiChallengeMainView:_refreshUI()
	local evolveChallengeId = GodARuiShiChallengeConfig.instance:getChallengeEvolveChallengeId()

	if GodARuiShiChallengeModel.instance:isPass() and (self._perPass == nil or self._perPass == false) then
		UIStateManager.instance:popByName(ViewName.GodARuiShiChallengeMainView)

		if self._challengeId == evolveChallengeId then
			UIStateManager.instance:push(ViewName.DivineEvolveTipView)
		else
			UIStateManager.instance:push(ViewName.DivineEvolveTipView, function()
				return
			end, lang("完成生命主宰"))
		end

		self.resetting = false

		return
	end

	self._perPass = GodARuiShiChallengeModel.instance:getTempPass()

	local stateList = {}
	local state = GodARuiShiChallengeModel.instance:getStage()
	local haveEnemy = false

	for i, v in ipairs(state) do
		table.insert(stateList, {
			isBoss = false,
			stageId = v.stageId,
			isFinish = v.isFinish,
			pos = GodARuiShiChallengeMainView.ChallengeCellPosition[i]
		})

		haveEnemy = v.isFinish ~= false and v.isFinish or true
	end

	local isBossFinish = true

	if GodARuiShiChallengeModel.instance:haveBoss() then
		local bossTime = GodARuiShiChallengeModel.instance:getBossTime()

		if bossTime < self._challengeBossTimes then
			isBossFinish = false
		end

		table.insert(stateList, {
			isBoss = true,
			stageId = GodARuiShiChallengeModel.instance:getBossId(),
			isFinish = isBossFinish,
			pos = GodARuiShiChallengeMainView.ChallengeCellPosition[6]
		})

		if isBossFinish == false or not isBossFinish then
			haveEnemy = true
		end
	end

	local curWave = GodARuiShiChallengeModel.instance:getCurWave()
	local residueWave = self._maxWave - curWave + 1
	local isEnd = residueWave < 0 or not haveEnemy

	if isEnd then
		residueWave = 0
		stateList = {}

		GameUtil.SetActive(self._btnReset, false)
		GameUtil.SetActive(self._txtTips, false)
	else
		GameUtil.SetActive(self._btnReset, true)
		GameUtil.SetActive(self._txtTips, true)
	end

	self._txtWave.text = langPara("今日波次:<size=30>%d/%d</size>", residueWave, self._maxWave)

	local perScore = isEnd and 70 or GodARuiShiChallengeConfig.instance:getStageInfo(self._challengeId, state[1].stageId).score
	local tipsTxt = ""

	uGuiUtil.clearImage(self._energyIcon)
	uGuiUtil.clearImage(self._tipsIcon)

	if self._challengeId == evolveChallengeId then
		uGuiUtil.setSpriteToImage(self._energyIcon, nil, GameUrl.getItemIconUrl("icon_shengmingjinghua"))
		uGuiUtil.setSpriteToImage(self._tipsIcon, nil, GameUrl.getItemIconUrl("icon_shengmingjinghua"))

		tipsTxt = langPara("击退敌人将夺回生命之树的生命精华")
	else
		uGuiUtil.setSpriteToImage(self._energyIcon, nil, GameUrl.getItemIconUrl("icon_sqarssp"))
		uGuiUtil.setSpriteToImage(self._tipsIcon, nil, GameUrl.getItemIconUrl("icon_sqarssp"))

		tipsTxt = langPara("击退敌人将获得启示水晶碎片")
	end

	self._txtTips.text = tipsTxt
	self._showBubble = true

	self._challengeGroup:updateWithMoArray(stateList, GameUtil.handler(self._updateCell, self))

	local score = GodARuiShiChallengeModel.instance:getScore()

	if self._perScore == nil then
		GodARuiShiChallengeModel.instance:saveTempScore()

		self._perScore = GodARuiShiChallengeModel.instance:getTempScore()
	end

	local progress = score / self._cfgChallenge.score
	local perProgress = self._perScore / self._cfgChallenge.score
	local energyEffectPath = "20220902/shenqiaruisi/fx_ui_sqars_jinghua.prefab"

	UIEffectManager.instance:stopEffect(self._energyEffectHandle)

	self._energyEffectHandle = nil
	self._energyEffectHandle = UIEffectManager.instance:playEffect(self, energyEffectPath, nil, 0, 0, true, nil, nil, self._setShuimian, self)

	self._energyEffectHandle:setParent(self._energyEffect.transform)
	self._energyEffectHandle:setLocalPos(0, 0, 0)
	self._energyEffectHandle:setScale(1)

	self._txtProgress.text = self.challengId == GodARuiShiChallengeConfig.instance:getChallengeEvolveChallengeId() and langPara("%d%% ", progress * 100) or langPara("%d/%d ", score, self._cfgChallenge.score)

	uGuiUtil.clearImage(self._bg)
	UIEffectManager.instance:stopEffect(self._mainViewEffect)

	self._mainViewEffect = nil

	if progress < self._changeProgress then
		uGuiUtil.setSpriteToImage(self._bg, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgFolderUrl("godaruishichallenge", "bg_shenqiaruisi_01"))
	else
		local mainEffectPath = "20220902/shenqiaruisi/fx_ui_sqars_jiemian.prefab"

		uGuiUtil.setSpriteToImage(self._bg, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgFolderUrl("godaruishichallenge", "bg_shenqiaruisi_02"))

		self._mainViewEffect = UIEffectManager.instance:playEffect(self, mainEffectPath, nil, 0, 0, true)

		self._mainViewEffect:setParent(self._bg.transform)
		self._mainViewEffect:setLocalPos(0, 0, 0)
		self._mainViewEffect:setScale(1)
	end

	if perProgress < self._changeProgress and progress >= self._changeProgress then
		self:_showChangeBgEffect()
	end

	GodARuiShiChallengeModel.instance:saveTempScore()

	if GodARuiShiChallengeModel.instance:getBossBattleEnd() then
		if GodARuiShiChallengeModel.instance:haveBoss() and isBossFinish == false then
			self:_onClickBoss(GodARuiShiChallengeModel.instance:getBossId())
		end

		GodARuiShiChallengeModel.instance:setBossBattleEnd(false)
	end

	self.resetting = false
end

function GodARuiShiChallengeMainView:_updateCell(item, data, i)
	local go = item.mainGO
	local headIcon = goutil.findChild(go, "headIcon/icon")
	local typeChange = goutil.findChildComponent(go, "headIcon/type", "UIImageSpriteChange")
	local bubble = goutil.findChild(go, "bubble")
	local txtBubble = goutil.findChildTextComponent(go, "bubble/ImgC_Bg/TxtC_Word")
	local effect = goutil.findChild(go, "headIcon/effect")
	local btn = GameUtil.asBtn(goutil.findChild(go, "headIcon/type"))

	GameUtil.setLocalRotation(effect, 0, 0, 0)

	if self._btnEffect[i] then
		UIEffectManager.instance:stopEffect(self._btnEffect[i])
	end

	self._btnEffect[i] = nil

	if data.isFinish == true then
		GameUtil.SetActive(item.mainGO, false)
	else
		local btnEffectPath

		if data.isBoss == true then
			btnEffectPath = "20220902/shenqiaruisi/fx_ui_sqars_qiu_hong.prefab"
		else
			local cfg = GodARuiShiChallengeConfig.instance:getStageInfo(self._challengeId, data.stageId)
			local typeInfo = GodARuiShiChallengeConfig.instance:getStageTypeInfo(cfg.type)

			btnEffectPath = "20220902/shenqiaruisi/" .. typeInfo.effectHeadIcon .. ".prefab"
		end

		local effectHandler = UIEffectManager.instance:playEffect(self, btnEffectPath, nil, 0, 0, true, nil, nil, function()
			GameUtil.setLocalRotation(effect, 0, 0, self._effectOffect + data.pos.rotate)
		end)

		effectHandler:setParent(effect.transform)
		effectHandler:setLocalPos(0, 0, 0)
		effectHandler:setScale(self._effectBtnScale, self._effectBtnScale, self._effectBtnScale)

		self._btnEffect[i] = effectHandler

		GameUtil.SetActive(item.mainGO, true)
	end

	GameUtil.setAnchoredPos(item.mainGO, data.pos.x, data.pos.y)

	if data.isBoss == true then
		GameUtil.setLocalScale(item.mainGO, self._bossScale, self._bossScale, self._bossScale)
	else
		GameUtil.setLocalScale(item.mainGO, self._nomalScale, self._nomalScale, self._nomalScale)
	end

	GameUtil.setLocalRotation(typeChange.gameObject, 0, 0, data.pos.rotate)
	MaterialMgr.resetAll(headIcon)

	if data.isBoss == true then
		typeChange:SetState(0)

		local cfg = GodARuiShiChallengeConfig.instance:getBossCreeps(self._challengeId, data.stageId)

		MaterialMgr.setIcon(headIcon, MatType.Pet, cfg[1].raceId)
	else
		local cfg = GodARuiShiChallengeConfig.instance:getStageInfo(self._challengeId, data.stageId)
		local creepCfg = GodARuiShiChallengeConfig.instance:getCreeps(cfg.creepsMasterId)

		typeChange:SetState(cfg.type)
		MaterialMgr.setIcon(headIcon, MatType.Pet, creepCfg[1].raceId)
	end

	local randomNum = math.random(1, 6)

	if self._showBubble == true and (data.isFinish == false or not data.isFinish) and randomNum < i then
		GameUtil.SetActive(bubble, true)

		self._showBubble = false
	else
		GameUtil.SetActive(bubble, false)
	end

	if i > 3 then
		GameUtil.setLocalRotation(bubble, 0, 0, 0)
		GameUtil.setLocalRotation(txtBubble.gameObject, 0, 0, 180)
	else
		GameUtil.setLocalRotation(bubble, 0, 180, 0)
		GameUtil.setLocalRotation(txtBubble.gameObject, 0, 180, 180)
	end

	GameUtil.setAnchoredPos(bubble, data.pos.bubblepos[1], data.pos.bubblepos[2])

	txtBubble.text = GodARuiShiChallengeConfig.instance:getRandomEnemyBubble()

	GameUtil.rmClickHandler(btn)

	if data.isBoss == true then
		GameUtil.addClickHandler(btn, function()
			self:_onClickBoss(data.stageId)
		end, self)
	else
		GameUtil.addClickHandler(btn, function()
			self:_onClickState(data.stageId)
		end, self)
	end
end

function GodARuiShiChallengeMainView:_clearCell(item)
	local go = item.mainGO
	local headIcon = goutil.findChild(go, "headIcon/icon")
	local btn = GameUtil.asBtn(go)

	MaterialMgr.resetAll(headIcon)
	GameUtil.rmClickHandler(btn)
end

function GodARuiShiChallengeMainView:_onClickRule()
	UIStateManager.instance:open(ViewName.RulesView, "shenqiAruisi_rule")
end

function GodARuiShiChallengeMainView:_onClickOneKey()
	local type, id, num

	type, id, num = MaterialMgr.getMatParams(self._cfgChallenge.passSaleCost)

	if type ~= nil and id ~= nil and num ~= nil then
		TipsFacade.instance:openPopupCostMatViewNew(type, id, num, langPara("确定要花费%d神钻，直接一键通过?", num), function()
			GodARuiShiChallengeAgent.instance:sendPM_GodARuiShiChallengeOneKeyPassReq(self._challengeId)
		end)
	end
end

function GodARuiShiChallengeMainView:_onClickRole()
	local var_18_0

	var_18_0, self._bubbleIndex = GodARuiShiChallengeConfig.instance:getRandomMyBubble(self._bubbleIndex)

	GlobalDispatcher:dispatch(GlobalNotify.UpdateBubble, var_18_0, self._roleBubble.transform.position)
end

function GodARuiShiChallengeMainView:_onClickBoss(stageId)
	local customFmtMo = GodARuiShiChallengeModel.instance:getCustomFmtMo()

	customFmtMo:initParams(self._challengeId, stageId, true)
	CustomFmtController.instance:showMissionView(customFmtMo)
end

function GodARuiShiChallengeMainView:_onClickState(stageId)
	local customFmtMo = GodARuiShiChallengeModel.instance:getCustomFmtMo()

	customFmtMo:initParams(self._challengeId, stageId, false)
	CustomFmtController.instance:showMissionView(customFmtMo)
end

function GodARuiShiChallengeMainView:_onClickReset()
	local curWave = GodARuiShiChallengeModel.instance:getCurWave()

	if curWave >= self._maxWave then
		FloatWordMgr.instance:show(lang("进入毁灭万物次数已耗尽"))
	else
		TipsFacade.instance:openPopupWindow(lang("提示"), lang("是否确认使用毁灭万物技能，使用后 将扣取波次 本波的剩余关卡将无法挑战"), function()
			GodARuiShiChallengeAgent.instance:sendPM_GodARuiShiChallengeSkipReq(self._challengeId)
			SurveyController.instance:reportBehavior(201189)
		end)
	end
end

function GodARuiShiChallengeMainView:_onOneKeyPassRes()
	return
end

function GodARuiShiChallengeMainView:_PM_GodARuiShiChallengeSkipRes()
	self.resetting = true

	GameUtil.SetActive(self._btnReset, false)
	UIEffectManager.instance:stopEffect(self._resetEffect)

	self._resetEffect = nil

	for i, v in pairs(self._btnShineEffect) do
		if v then
			UIEffectManager.instance:stopEffect(v)
		end
	end

	self._btnShineEffect = {}

	removetimer(self._showShineEffect, self)
	self:_showResetEffect()
end

function GodARuiShiChallengeMainView:_onClickTip()
	UIStateManager.instance:push(ViewName.GodARuiShiChallengeImageTipView, self._cfgChallenge.ruleId, "godaruishichallenge")
end

function GodARuiShiChallengeMainView:_endStory()
	GlobalDispatcher:removeListener(GlobalNotify.EndStory, self._endStory, self)
	self:_onClickTip()
end

function GodARuiShiChallengeMainView:_showChangeBgEffect()
	return
end

function GodARuiShiChallengeMainView:_showResetEffect()
	local effectPath = "20220902/shenqiaruisi/fx_ui_sqars_huimiewanwu.prefab"

	self._resetEffect = UIEffectManager.instance:playEffect(self, effectPath, nil, 0, 0, false)

	self._resetEffect:setParent(self._bg.transform)
	self._resetEffect:setLocalPos(0, 0, 0)
	self._resetEffect:setScale(1)

	for i, v in pairs(self._challengeGroup:getItems()) do
		GameUtil.SetActive(v.mainGO, false)
	end

	removetimer(self._showShineEffect, self)
	settimer(0.8, self._showShineEffect, self, false)
end

function GodARuiShiChallengeMainView:_showShineEffect()
	local shineEffectPath = "20220902/shenqiaruisi/fx_ui_sqars_qiu_huimiewanwu.prefab"

	for i, v in pairs(self._challengeGroup:getItems()) do
		local headIcon = goutil.findChild(v.mainGO, "headIcon/effectShine")

		GameUtil.setLocalRotation(headIcon, 0, 0, 0)

		local shineEffect = i > 3 and UIEffectManager.instance:playEffect(self, shineEffectPath, nil, 0, 0, false, nil, nil, function()
			GameUtil.setLocalRotation(headIcon, 0, 0, 180)
		end) or UIEffectManager.instance:playEffect(self, shineEffectPath, nil, 0, 0, false)

		shineEffect:setParent(headIcon.transform)
		shineEffect:setLocalPos(0, 0, 0)
		shineEffect:setScale(1)

		self._btnShineEffect[i] = shineEffect
	end

	self:_refreshUI()
end

function GodARuiShiChallengeMainView:_setShuimian(eff)
	local shuimian = goutil.findChild(eff.effGo, "glow/shuimian")
	local score = GodARuiShiChallengeModel.instance:getScore()
	local progress = score / self._cfgChallenge.score

	GameUtil.setLocalPos(shuimian, 0.022, -0.24 + 0.44 * progress, 0)
end

return GodARuiShiChallengeMainView
