-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originfight/view/OriginFightSummonView.lua

module("logic.extensions.originfight.view.OriginFightSummonView", package.seeall)

local OriginFightSummonView = class("OriginFightSummonView", ViewComponent)

function OriginFightSummonView:ctor()
	OriginFightSummonView.super.ctor(self)
end

function OriginFightSummonView:unbindEvents()
	OriginFightSummonView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnRebuild)
end

function OriginFightSummonView:bindEvents()
	OriginFightSummonView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnRebuild, self._onClickBtnRebuild, self)
end

function OriginFightSummonView:buildUI()
	OriginFightSummonView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtOpenTime = self:getTxt("txtOpenTime/txt")
	self._btnRebuild = self:getGo("rebuild/btnRebuild")
	self._eff = self:getGo("eff")
	self._imgAoqiRect = self:getGo("imgBg/img"):GetComponent(goutil.Type_RectTransform)
end

function OriginFightSummonView:onExit()
	OriginFightSummonView.super.onExit(self)

	for i, cfg in ipairs(self._godFavorCfgs) do
		local cellGo = self:getGo("cells/cell" .. cfg.godFavorId)

		GameUtil.rmClickHandler(cellGo)
	end

	for i, tween in ipairs(self._effAnimList) do
		tween:Kill()

		tween = nil
	end

	self._effAnimList = nil

	self._moveSequence:Kill(true)

	self._moveSequence = nil
end

function OriginFightSummonView:onEnter()
	OriginFightSummonView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_OriginFightInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.PM_OriginFightCommonGodFavorRes, self._onGodFavorRes, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 525001
	end

	self._collectNum = 1
	self._effEndPoint = Vector3.New(0, -249, 0)
	self._effAnimList = {}
	self._actCfg = OriginFightConfig.instance:getActCfg(self._activityId)
	self._godFavorCfgs = OriginFightConfig.instance:getGodFavorCfgs(self._activityId)
	self._moveSequence = DG.Tweening.DOTween.Sequence()
	self._perFloatTime = 0.5

	self:_onSetUI()
	OriginFightController.instance:sendPM_OriginFightInfoReq(self._activityId)
end

function OriginFightSummonView:_initSummonGodUI()
	for i, cfg in ipairs(self._godFavorCfgs) do
		local cellGo = self:getGo("cells/cell" .. cfg.godFavorId)
		local imgGodFavor = goutil.findChild(cellGo, "imgGodFavor")

		GameUtil.SetGray(imgGodFavor, true)
		GameUtil.addClickHandler(cellGo, GameUtil.handler(self._onClickCell, self, cfg.godFavorId, cfg.gainType), self)
	end
end

function OriginFightSummonView:_onSetUI()
	if self._txtOpenTime then
		self._txtOpenTime.text = ActivityDefineController.instance:getActTimeShow(self._activityId)
	end

	self:_initSummonGodUI()

	local imgAoqiPos = GameUtil.getAnchoredPos(self._imgAoqiRect.gameObject)
	local posY = imgAoqiPos.y
	local moveUpTween = self._imgAoqiRect:DOAnchorPosY(posY + 10, self._perFloatTime):SetEase(DG.Tweening.Ease.Linear)
	local moveBackTween = self._imgAoqiRect:DOAnchorPosY(posY, self._perFloatTime):SetEase(DG.Tweening.Ease.Linear)
	local moveDownTween = self._imgAoqiRect:DOAnchorPosY(posY - 10, self._perFloatTime * 2):SetEase(DG.Tweening.Ease.Linear)

	self._moveSequence:Append(moveUpTween)
	self._moveSequence:Append(moveDownTween)
	self._moveSequence:Append(moveBackTween)
	self._moveSequence:SetLoops(-1)
end

function OriginFightSummonView:_onUpdate()
	local storyId = OriginFightModel.instance:popStoryId()

	if storyId then
		GlobalDispatcher:dispatch(GlobalNotify.PushStory, storyId, StoryModel.StoryType.SCCopy)
	end

	self._info = OriginFightModel.instance:getInfo(self._activityId)
	self._hasSummonGodFavorIds = self._info.hasSummonGodFavorIds

	local hasSummonAllGodFavorNum = #self._hasSummonGodFavorIds
	local godFavorNum = #self._godFavorCfgs

	for i, cfg in ipairs(self._godFavorCfgs) do
		local cellGo = self:getGo("cells/cell" .. cfg.godFavorId)
		local imgGodFavor = goutil.findChild(cellGo, "imgGodFavor")
		local summon = goutil.findChild(cellGo, "summon")
		local goSummon = goutil.findChild(cellGo, "goSummon")
		local godFavorFinish = table.indexof(self._hasSummonGodFavorIds, cfg.godFavorId)

		GameUtil.SetActive(summon, godFavorFinish)
		GameUtil.SetActive(goSummon, not godFavorFinish)
		GameUtil.SetGray(imgGodFavor, not godFavorFinish)
	end

	GameUtil.SetActive(self._btnRebuild, godFavorNum <= hasSummonAllGodFavorNum)
end

function OriginFightSummonView:_onClickBtnTip()
	local key = self._actCfg.ruleKey

	TipsFacade.instance:openRulesView(key)
end

function OriginFightSummonView:_onClickCell(godFavorId, gainType)
	local godFavorCfg = self._godFavorCfgs[godFavorId]
	local hasSummonGodFavorIds = self._info.hasSummonGodFavorIds

	if table.indexof(hasSummonGodFavorIds, godFavorId) then
		FloatWordMgr.instance:show("已成功召唤此神眷")

		return
	end

	local gainTypeArr = string.split(gainType, "#")

	if gainTypeArr[1] == "pay" then
		local matType, matId, matNum = MaterialMgr.getMatParams(godFavorCfg.cost)
		local matName = MaterialMgr.getMaterialsNameByCfg(godFavorCfg.cost)
		local content = string.format("确认要提交%d%s给永恒圣龙吗?", matNum, matName)

		local function okFunc()
			OriginFightController.instance:sendPM_OriginFightCommonGodFavorReq(self._activityId, godFavorId)
		end

		TipsFacade.instance:openPopupCostMatViewNew(matType, matId, matNum, content, okFunc)
	elseif gainTypeArr[1] == "story" then
		OriginFightController.instance:sendPM_OriginFightCommonGodFavorReq(self._activityId, godFavorId)
	elseif gainTypeArr[1] == "fight" then
		OriginFightController.instance:enterBattleClg(self._activityId)
	elseif gainTypeArr[1] == "game" then
		UIStateManager.instance:push(gainTypeArr[2], self._activityId, godFavorId)
	end
end

function OriginFightSummonView:_onClickBtnRebuild()
	local summonGodNum = #self._hasSummonGodFavorIds

	if summonGodNum < #self._godFavorCfgs then
		FloatWordMgr.instance:show("尚未集齐所有神眷，无法重构")

		return
	end

	self:_playAllEffAnim()
end

function OriginFightSummonView:_onGodFavorRes(godFavorId)
	local godFavorCfg = self._godFavorCfgs[godFavorId]

	GlobalDispatcher:dispatch(GlobalNotify.PushStory, godFavorCfg.storyId, StoryModel.StoryType.SCCopy)
	self:_onUpdate()
end

function OriginFightSummonView:_playAllEffAnim()
	ViewBlockMgr.instance:blockClick(true, self)

	local paths = {
		self._effEndPoint
	}
	local eff = self:getGo("effs/eff1")

	self._collectNum = self._collectNum + 1

	self:playViewEffectUniGo("fx_ui_xinshouzhiyin/fx_xinshouzhiyin_003/fx_feiru_xingxing.prefab", eff, self.mainGO.transform, false)

	local moveTween = TweenUtil.DOTweenMovePath(eff.transform, false, paths, 0.5, self._playNextEffAnim, self, DG.Tweening.Ease.Linear)

	GameUtil.setLocalScale(eff, 200, 200, 200)
	table.insert(self._effAnimList, moveTween)
end

function OriginFightSummonView:_playNextEffAnim()
	local godFavorNum = #self._godFavorCfgs

	if godFavorNum >= self._collectNum then
		local eff = self:getGo("effs/eff" .. self._collectNum)
		local paths = {
			self._effEndPoint
		}

		self:playViewEffectUniGo("fx_ui_xinshouzhiyin/fx_xinshouzhiyin_003/fx_feiru_xingxing.prefab", eff, self.mainGO.transform, false)

		self._collectNum = self._collectNum + 1

		local moveTween = TweenUtil.DOTweenMovePath(eff.transform, false, paths, 0.5, self._playNextEffAnim, self, DG.Tweening.Ease.Linear)

		GameUtil.setLocalScale(eff, 200, 200, 200)
		table.insert(self._effAnimList, moveTween)
	else
		self:playViewEffectUniGo("20241220/zhongyanzhizhan/fx_ui_bianbai.prefab", self._eff, self.mainGO.transform, false, function()
			ViewBlockMgr.instance:blockClick(false, self)

			local storyId = self._actCfg.tiTanStoryId

			GlobalDispatcher:dispatch(GlobalNotify.PushStory, storyId, StoryModel.StoryType.SCCopy)
			UIStateManager.instance:push(ViewName.OriginFightGetRewardView, self._activityId)
			UIStateManager.instance:popByName(ViewName.OriginFightCollectView)
			UIStateManager.instance:popByName(ViewName.OriginFightSummonView)
		end, nil)
	end
end

return OriginFightSummonView
