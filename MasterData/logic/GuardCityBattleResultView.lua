-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guardcity/view/GuardCityBattleResultView.lua

module("logic.extensions.guardcity.view.GuardCityBattleResultView", package.seeall)

local GuardCityBattleResultView = class("GuardCityBattleResultView", TableViewComponent)

function GuardCityBattleResultView:ctor()
	GuardCityBattleResultView.super.ctor(self)

	self.isCloseView = false
end

function GuardCityBattleResultView:bindEvents()
	GuardCityBattleResultView.super.bindEvents(self)
	GameUtil.asBtn(self.viewBgGo):AddClickListener(self.OnClickResultView, self)
	GameUtil.addClickHandler(self.helpMeBtn, self._onClickHelpMe, self)
	GameUtil.addClickHandler(self.helpOtherBtn, self._onClickHelpOther, self)
	self.modelInfoLua:bindEvents()
end

function GuardCityBattleResultView:unbindEvents()
	GuardCityBattleResultView.super.unbindEvents(self)
	GameUtil.asBtn(self.viewBgGo):RemoveClickListener()
	GameUtil.rmClickHandler(self.helpMeBtn)
	GameUtil.rmClickHandler(self.helpOtherBtn)
	self.modelInfoLua:unbindEvents()
end

function GuardCityBattleResultView:onExit()
	GuardCityBattleResultView.super.onExit(self)
	BattleSettlementModel.instance:onReset()

	self.srGraphic.raycastTarget = true

	GuardCityController.instance:endHelp()
	self.modelInfoLua:onExit()

	if self.battleTween then
		self.battleTween:Kill(true)
	end

	if self.endTween then
		self.endTween:Kill(true)
	end

	self.bloodTitleGo:DOKill(true)
	self.bloodInfoGo:DOKill(true)
	self.helpTitleGo:DOKill(true)
	self.helpInfoGo:DOKill(true)
	self.goodsTitleGo:DOKill(true)
	self.goodsInfoGo:DOKill(true)
end

function GuardCityBattleResultView:destroyUI()
	GuardCityBattleResultView.super.destroyUI(self)
	self.modelInfoLua:destroyUI()

	self.modelInfoLua = nil
	self.isCloseView = false
end

function GuardCityBattleResultView:buildUI()
	GuardCityBattleResultView.super.buildUI(self)

	self.viewBgGo = self:getGo("viewBgGo")
	self.textTipsGo = self:getGo("textTipsGo")
	self.battleInfoGo = self:getGo("battleInfoGo")
	self.bloodTitleGo = goutil.findChild(self.battleInfoGo, "bloodTitleGo"):GetComponent(goutil.Type_RectTransform)
	self.bloodInfoGo = goutil.findChild(self.battleInfoGo, "bloodInfoGo"):GetComponent(goutil.Type_RectTransform)
	self.bloodBarSli = goutil.findChild(self.bloodInfoGo, "bloodBarSli"):GetComponent("Slider")
	self.bloodCountTxt = goutil.findChildTextComponent(self.bloodInfoGo.gameObject, "bloodCountTxt")
	self.bloodRatioTxt = goutil.findChildTextComponent(self.bloodInfoGo.gameObject, "bloodRatioTxt")
	self.bloodBarSli.value = 0
	self.bloodCountTxt.text = ""
	self.bloodRatioTxt.text = ""
	self.helpTitleGo = goutil.findChild(self.battleInfoGo, "helpTitleGo"):GetComponent(goutil.Type_RectTransform)
	self.helpTxt = goutil.findChildTextComponent(self.helpTitleGo.gameObject, "helpTxt")
	self.helpInfoGo = goutil.findChild(self.battleInfoGo, "helpInfoGo"):GetComponent(goutil.Type_RectTransform)
	self.goodsTitleGo = goutil.findChild(self.battleInfoGo, "goodsTitleGo"):GetComponent(goutil.Type_RectTransform)
	self.goodsInfoGo = goutil.findChild(self.battleInfoGo, "goodsInfoGo"):GetComponent(goutil.Type_RectTransform)
	self.modelInfoGo = self:getGo("modelInfoGo")
	self.modelInfoLua = SettlementFirstPart.New()

	self.modelInfoLua:buildUI(self.modelInfoGo)

	self.infoShowGo = goutil.findChild(self.helpInfoGo.gameObject, "infoShowGo")
	self.helpMeBtn = Framework.ButtonAdapter.GetFrom(self.infoShowGo, "helpBtns/helpMeBtn")
	self.helpOtherBtn = Framework.ButtonAdapter.GetFrom(self.infoShowGo, "helpBtns/helpOtherBtn")
	self.srGraphic = goutil.findChild(self.goodsInfoGo, "goodsListSR"):GetComponent(typeof(UnityEngine.UI.Graphic))
end

function GuardCityBattleResultView:onEnter()
	GuardCityBattleResultView.super.onEnter(self)
	GuardCityController.instance:startHelp()

	self.isCloseView = false

	ViewMgr.instance:close(ViewName.BulletScreen)
	ViewMgr.instance:close(ViewName.SendBullet)

	self.battleInfo = GuardCiytModel.instance:GetBattleBossInfo()
	self.helpTxt.text = self.battleInfo.isMyBoss and "求助信息" or "求助信息"

	GameUtil.SetActive(self.helpMeBtn, self.battleInfo.isMyBoss == true)

	self.bloodBarSli.value = checknumber(self.battleInfo.curHp) / (self.battleInfo.maxHp or 1)
	self.bloodCountTxt.text = checknumber(self.battleInfo.curHp) .. "/" .. (self.battleInfo.maxHp or 1)

	local value = math.floor(100 * checknumber(self.battleInfo.curHp) / (self.battleInfo.maxHp or 1))

	self.bloodRatioTxt.text = value .. "%"
	self._curViewDatas = {}

	if self.battleInfo.changeSetId then
		for i, v in pairs(MaterialController.instance:getTempItemsByChangeSetId(self.battleInfo.changeSetId) or {}) do
			table.insert(self._curViewDatas, v)
		end
	end

	self.srGraphic.raycastTarget = #self._curViewDatas > 5

	self._tableview:ReloadData()
	Framework.TransformUtil.SetAnchoredPos(self.bloodTitleGo, 1500, 20)
	Framework.TransformUtil.SetAnchoredPos(self.bloodInfoGo, 1500, -30)
	Framework.TransformUtil.SetAnchoredPos(self.helpTitleGo, 1500, -85)
	Framework.TransformUtil.SetAnchoredPos(self.helpInfoGo, 1500, -135)
	Framework.TransformUtil.SetAnchoredPos(self.goodsTitleGo, 1500, -360)
	Framework.TransformUtil.SetAnchoredPos(self.goodsInfoGo, 1500, -410)
	self.battleInfoGo:SetActive(false)
	goutil.setActive(self.textTipsGo, false)
	AudioBgmPlayer.instance:startPlayEffect(30100)
	self.modelInfoGo:SetActive(true)
	self.modelInfoLua:onEnter(true, self)

	self.battleTween = TweenUtil.DoDelay(self.modelInfoLua:getNeedTime(), function()
		self:OpenBattleInfoShow()
	end)
end

function GuardCityBattleResultView:OpenBattleInfoShow()
	if self.battleTween then
		self.battleTween:Kill(true)
	end

	if self.isCloseView then
		return
	end

	self.battleInfoGo:SetActive(true)

	local curTime = 0.4
	local curDelay = 0.2

	self.bloodTitleGo:DOAnchorPos(Vector2.New(0, 0), curTime):SetDelay(curDelay)

	curDelay = curDelay + 0.3

	self.bloodInfoGo:DOAnchorPos(Vector2.New(0, -50), curTime):SetDelay(curDelay)

	curDelay = curDelay + 0.2

	self.helpTitleGo:DOAnchorPos(Vector2.New(0, -105), curTime):SetDelay(curDelay)

	curDelay = curDelay + 0.3

	self.helpInfoGo:DOAnchorPos(Vector2.New(0, -155), curTime):SetDelay(curDelay)

	curDelay = curDelay + 0.2

	self.goodsTitleGo:DOAnchorPos(Vector2.New(0, -380), curTime):SetDelay(curDelay)

	curDelay = curDelay + 0.3

	self.goodsInfoGo:DOAnchorPos(Vector2.New(0, -430), curTime):SetDelay(curDelay)

	self.endTween = TweenUtil.DoDelay(curTime + curDelay, function()
		self:OnAnimEndTween()
	end)
end

function GuardCityBattleResultView:OnAnimEndTween()
	if self.endTween then
		self.endTween:Kill(true)
	end

	self.bloodTitleGo:DOKill(true)
	self.bloodInfoGo:DOKill(true)
	self.helpTitleGo:DOKill(true)
	self.helpInfoGo:DOKill(true)
	self.goodsTitleGo:DOKill(true)
	self.goodsInfoGo:DOKill(true)

	self.isCloseView = true

	goutil.setActive(self.textTipsGo, true)
end

function GuardCityBattleResultView:OnClickResultView()
	if not self.isCloseView then
		return
	end

	GuardCityController.instance:endHelp()
	BattleController.instance:endBattle()
end

function GuardCityBattleResultView:_getPath()
	return {
		cellPath = "battleInfoGo/goodsInfoGo/goodsItem",
		viewPath = "battleInfoGo/goodsInfoGo/goodsListSR"
	}
end

function GuardCityBattleResultView:_cellSize()
	return 780, 110
end

function GuardCityBattleResultView:_updateCell(view, cell, data)
	MaterialMgr.resetAll(cell)

	local proxy = MaterialMgr.setCell(data.type, data.id, cell)

	if proxy then
		proxy.binder:setNum(data.num)
	end
end

function GuardCityBattleResultView:_popupPerfectPassView()
	local isSuccess = false

	if not isSuccess then
		return
	end

	local enumType = BattleSettlementModel.instance:getType()

	if not PlotCopyModel.instance:isPerfectPass(enumType) then
		return
	end

	if enumType ~= BattleSettlementModel.Enum.PlotCopy then
		return
	end

	local params = BattleSettlementModel.instance:getParams()

	if params.isPerfectPassBefore then
		return
	end

	ViewMgr.instance:open(ViewName.PerfectPassView, params.chapterId, params.stageId)
end

function GuardCityBattleResultView:_onClickHelpMe()
	if not self.battleInfo.isMyBoss then
		return
	end

	if self.battleInfo.isKillBoss then
		FloatWordMgr.instance:show("你太强了，无需求助他人！")

		return
	end

	GuardCityController.instance:readySendHelp(self.battleInfo.readyAttack)
	ViewMgr.instance:open(ViewName.FriendSelect, 0, 0, lang("请选择好友发起求助"))
end

function GuardCityBattleResultView:_onClickHelpOther()
	UIJumper.instance:pushClearCurStack(ViewName.GuardCityMainView, true, self._activityId)
	UIJumper.instance:pushOneStack(ViewName.GuardCityHelpView, true, self.battleInfo.activityId)
	GuardCityController.instance:endHelp()
	BattleController.instance:endBattle()
end

return GuardCityBattleResultView
