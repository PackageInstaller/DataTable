-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sharetask/view/ShareBattleResultView.lua

module("logic.extensions.sharetask.view.ShareBattleResultView", package.seeall)

local ShareBattleResultView = class("ShareBattleResultView", TableViewComponent)

function ShareBattleResultView:ctor()
	ShareBattleResultView.super.ctor(self)

	self.isCloseView = false
end

function ShareBattleResultView:bindEvents()
	ShareBattleResultView.super.bindEvents(self)
	GameUtil.asBtn(self.viewBgGo):AddClickListener(self.OnClickResultView, self)
	self.modelInfoLua:bindEvents()
end

function ShareBattleResultView:unbindEvents()
	ShareBattleResultView.super.unbindEvents(self)
	GameUtil.asBtn(self.viewBgGo):RemoveClickListener()
	self.modelInfoLua:unbindEvents()
	self.helpItemLua:unbindEvents()
end

function ShareBattleResultView:onExit()
	ShareBattleResultView.super.onExit(self)
	BattleSettlementModel.instance:onReset()

	self.srGraphic.raycastTarget = true

	self.modelInfoLua:onExit()
	self.helpItemLua:onExit()

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

function ShareBattleResultView:destroyUI()
	ShareBattleResultView.super.destroyUI(self)
	self.modelInfoLua:destroyUI()

	self.modelInfoLua = nil
	self.helpItemLua = nil
	self.isCloseView = false
end

function ShareBattleResultView:buildUI()
	ShareBattleResultView.super.buildUI(self)

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

	self.helpItemLua = ShareHelpItem.New()

	self.helpItemLua:buildUI(self.helpInfoGo.gameObject)

	self.srGraphic = goutil.findChild(self.goodsInfoGo, "goodsListSR"):GetComponent(typeof(UnityEngine.UI.Graphic))
end

function ShareBattleResultView:onEnter()
	ShareBattleResultView.super.onEnter(self)

	self.isCloseView = false

	ViewMgr.instance:close(ViewName.BulletScreen)
	ViewMgr.instance:close(ViewName.SendBullet)

	self.battleInfo = ShareTaskModel.instance:GetBattleBossInfo()

	self.helpItemLua:onEnter(self)

	if self.battleInfo.isMyBoss and not self.battleInfo.isParam then
		self.helpTxt.text = "求助信息"
	else
		local use, all = ShareTaskModel.instance:GetBattleUseAndTotalCount(self.battleInfo.isMyBoss)

		self.helpTxt.text = "助战信息：" .. use .. "/" .. all
	end

	if self.battleInfo.isMyBoss then
		local var_7_0 = ShareTaskModel.instance:GetMyShareBossInfo()

		if not var_7_0 then
			var_7_0 = ShareTaskModel.instance:GetOtherShareBossInfo()

			local bossInfo = var_7_0

			self.bloodBarSli.value = bossInfo.curHp / bossInfo.maxHp
			self.bloodCountTxt.text = bossInfo.curHp .. "/" .. bossInfo.maxHp

			local value = math.floor(100 * bossInfo.curHp / bossInfo.maxHp)

			self.bloodRatioTxt.text = value .. "%"

			local bossCfg = ShareTaskConfig.instance:GetBossBaseCfg(bossInfo.bossTypeId)

			if not self.battleInfo.isMyBoss and self.battleInfo.isParam then
				self._curViewDatas = {}
			else
				self._curViewDatas = ShareTaskModel.instance:ParsingGoodsStr(bossCfg.fallReward)
				self.srGraphic.raycastTarget = #self._curViewDatas > 5
			end

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
	end
end

function ShareBattleResultView:OpenBattleInfoShow()
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

	if not self.battleInfo.isMyBoss and self.battleInfo.isParam then
		-- block empty
	else
		curDelay = curDelay + 0.2

		self.goodsTitleGo:DOAnchorPos(Vector2.New(0, -380), curTime):SetDelay(curDelay)

		curDelay = curDelay + 0.3

		self.goodsInfoGo:DOAnchorPos(Vector2.New(0, -430), curTime):SetDelay(curDelay)
	end

	self.endTween = TweenUtil.DoDelay(curTime + curDelay, function()
		self:OnAnimEndTween()
	end)
end

function ShareBattleResultView:OnAnimEndTween()
	if self.endTween then
		self.endTween:Kill(true)
	end

	self.bloodTitleGo:DOKill(true)
	self.bloodInfoGo:DOKill(true)
	self.helpTitleGo:DOKill(true)
	self.helpInfoGo:DOKill(true)

	if not self.battleInfo.isMyBoss and self.battleInfo.isParam then
		-- block empty
	else
		self.goodsTitleGo:DOKill(true)
		self.goodsInfoGo:DOKill(true)
	end

	self.isCloseView = true

	goutil.setActive(self.textTipsGo, true)
end

function ShareBattleResultView:OnClickResultView()
	if not self.isCloseView then
		return
	end

	BattleController.instance:endBattle()
end

function ShareBattleResultView:_getPath()
	return {
		cellPath = "battleInfoGo/goodsInfoGo/goodsItem",
		viewPath = "battleInfoGo/goodsInfoGo/goodsListSR"
	}
end

function ShareBattleResultView:_cellSize()
	return 780, 110
end

function ShareBattleResultView:_updateCell(view, cell, data)
	MaterialMgr.resetAll(cell)

	local proxy = MaterialMgr.setCell(data.itemType, data.itemId, cell)

	proxy.binder:setNum(data.count)
end

function ShareBattleResultView:_popupPerfectPassView()
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

return ShareBattleResultView
