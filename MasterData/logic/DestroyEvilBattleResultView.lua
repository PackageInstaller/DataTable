-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/destroyevil/view/DestroyEvilBattleResultView.lua

module("logic.extensions.destroyevil.view.DestroyEvilBattleResultView", package.seeall)

local DestroyEvilBattleResultView = class("DestroyEvilBattleResultView", TableViewComponent)

function DestroyEvilBattleResultView:ctor()
	DestroyEvilBattleResultView.super.ctor(self)

	self.isCloseView = false
end

function DestroyEvilBattleResultView:bindEvents()
	DestroyEvilBattleResultView.super.bindEvents(self)
	GameUtil.asBtn(self.viewBgGo):AddClickListener(self.OnClickResultView, self)
	GameUtil.addClickHandler(self.helpMeBtn, self._onClickHelpMe, self)
	GameUtil.addClickHandler(self.helpOtherBtn, self._onClickHelpOther, self)
	self.modelInfoLua:bindEvents()
end

function DestroyEvilBattleResultView:unbindEvents()
	DestroyEvilBattleResultView.super.unbindEvents(self)
	GameUtil.asBtn(self.viewBgGo):RemoveClickListener()
	GameUtil.rmClickHandler(self.helpMeBtn)
	GameUtil.rmClickHandler(self.helpOtherBtn)
	self.modelInfoLua:unbindEvents()
end

function DestroyEvilBattleResultView:onExit()
	DestroyEvilBattleResultView.super.onExit(self)
	BattleSettlementModel.instance:onReset()

	self.srGraphic.raycastTarget = true

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
	GlobalDispatcher:removeListener(GlobalNotify.FriendSelected, self._onSelectFriend, self)
end

function DestroyEvilBattleResultView:destroyUI()
	DestroyEvilBattleResultView.super.destroyUI(self)
	self.modelInfoLua:destroyUI()

	self.modelInfoLua = nil
	self.isCloseView = false
end

function DestroyEvilBattleResultView:buildUI()
	DestroyEvilBattleResultView.super.buildUI(self)

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

function DestroyEvilBattleResultView:onEnter()
	DestroyEvilBattleResultView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.FriendSelected, self._onSelectFriend, self)

	self.isCloseView = false

	ViewMgr.instance:close(ViewName.BulletScreen)
	ViewMgr.instance:close(ViewName.SendBullet)

	self.battleInfo = DestroyEvilModel.instance:GetBattleBossInfo()
	self.helpTxt.text = self.battleInfo.isMyBoss and "求助信息" or "求助信息"

	if self.battleInfo.isMyBoss and self.battleInfo.monsterLeftHp > 0 then
		GameUtil.SetActive(self.helpMeBtn, true)
	else
		GameUtil.SetActive(self.helpMeBtn, false)
	end

	self.bloodBarSli.value = checknumber(self.battleInfo.monsterLeftHp) / (self.battleInfo.monsterTotalHp or 1)
	self.bloodCountTxt.text = checknumber(self.battleInfo.monsterLeftHp) .. "/" .. (self.battleInfo.monsterTotalHp or 1)

	local value = math.floor(100 * checknumber(self.battleInfo.monsterLeftHp) / (self.battleInfo.monsterTotalHp or 1))

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

function DestroyEvilBattleResultView:OpenBattleInfoShow()
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

function DestroyEvilBattleResultView:OnAnimEndTween()
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

function DestroyEvilBattleResultView:OnClickResultView()
	if not self.isCloseView then
		return
	end

	BattleController.instance:endBattle()
end

function DestroyEvilBattleResultView:_getPath()
	return {
		cellPath = "battleInfoGo/goodsInfoGo/goodsItem",
		viewPath = "battleInfoGo/goodsInfoGo/goodsListSR"
	}
end

function DestroyEvilBattleResultView:_cellSize()
	return 780, 110
end

function DestroyEvilBattleResultView:_updateCell(view, cell, data)
	MaterialMgr.resetAll(cell)

	local proxy = MaterialMgr.setCell(data.type, data.id, cell)

	if proxy then
		proxy.binder:setNum(data.num)
	end
end

function DestroyEvilBattleResultView:_onClickHelpMe()
	if self.battleInfo.isMyBoss and self.battleInfo.monsterLeftHp > 0 then
		ViewMgr.instance:open(ViewName.FriendSelect, 0, 0, lang("请选择好友发起求助"))
	else
		BattleController.instance:endBattle()
	end
end

function DestroyEvilBattleResultView:_onClickHelpOther()
	BattleController.instance:endBattle()
end

function DestroyEvilBattleResultView:_onSelectFriend(ids)
	FloatWordMgr.instance:show("好友已召集")
	DestroyEvilAgent.instance:sendPM_DestroyEvilConveneBuddyReq(self.battleInfo.actId, ids)
end

return DestroyEvilBattleResultView
