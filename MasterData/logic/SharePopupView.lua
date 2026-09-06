-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sharetask/view/SharePopupView.lua

module("logic.extensions.sharetask.view.SharePopupView", package.seeall)

local SharePopupView = class("SharePopupView", ViewComponent)

function SharePopupView:ctor()
	SharePopupView.super.ctor(self)

	self.isClickLater = false
	self.goodsItemList = nil
end

function SharePopupView:bindEvents()
	SharePopupView.super.bindEvents(self)
	self.closeBtn:AddClickListener(function()
		self:OnClickLaterOrGotoBtn(true)
	end, self)
	self.gotoBtn:AddClickListener(function()
		self:OnClickLaterOrGotoBtn(false)
	end, self)
end

function SharePopupView:unbindEvents()
	SharePopupView.super.unbindEvents(self)
	self.closeBtn:RemoveClickListener()
	self.gotoBtn:RemoveClickListener()
end

function SharePopupView:onExit()
	SharePopupView.super.onExit(self)
	removetimer(self.CalculationSurplusTime, self)
	removetimer(self.FlyEffFinished, self)
	self.scrollList1:dispose()
	self.scrollList2:dispose()
end

function SharePopupView:destroyUI()
	SharePopupView.super.destroyUI(self)
	self.petPhoto:clear()

	self.goodsItemList = nil

	if self.flyEff then
		UIEffectManager.instance:stopEffect(self.flyEff)

		self.flyEff = nil
	end
end

function SharePopupView:buildUI()
	SharePopupView.super.buildUI(self)

	self.viewBgGo = self:getGo("viewBgGo")

	local spriteRawGo = goutil.findChild(self.viewBgGo, "spriteRawIma")

	self.petPhoto = PetPhotoShow.Get(spriteRawGo)
	self.timerTxt = goutil.findChildTextComponent(self.viewBgGo, "timerTxt")
	self.monsterTxt = goutil.findChildTextComponent(self.viewBgGo, "monsterTxt")
	self.goodsItemList = {
		goutil.findChild(self.viewBgGo, "goodsGo_1"),
		goutil.findChild(self.viewBgGo, "goodsGo_2"),
		goutil.findChild(self.viewBgGo, "goodsGo_3"),
		goutil.findChild(self.viewBgGo, "goodsGo_4"),
		goutil.findChild(self.viewBgGo, "goodsGo_5"),
		goutil.findChild(self.viewBgGo, "goodsGo_6"),
		goutil.findChild(self.viewBgGo, "goodsGo_7"),
		goutil.findChild(self.viewBgGo, "goodsGo_8")
	}
	self.closeBtn = Framework.ButtonAdapter.GetFrom(self.viewBgGo, "closeBtn")
	self.gotoBtn = Framework.ButtonAdapter.GetFrom(self.viewBgGo, "gotoBtn")
	self.timerTxt.text = ""
	self.monsterTxt.text = ""
	self.cell = self:getGo("viewBgGo/itemCell")
	self.rewardList1 = self:getGo("viewBgGo/rewardList1")
	self.rewardList2 = self:getGo("viewBgGo/rewardList2")
	self.scrollList1 = ScrollerList.create(self.rewardList1, self.cell, GameUtil.handler(self._upateCell, self), GameUtil.handler(self.clearCell, self))
	self.scrollList2 = ScrollerList.create(self.rewardList2, self.cell, GameUtil.handler(self._upateCell, self), GameUtil.handler(self.clearCell, self))
	self.itemFlyGo = self:getGo("itemFlyGo")

	self.itemFlyGo:SetActive(false)
end

function SharePopupView:_upateCell(view, cell, data, tag)
	local go = goutil.findChild(cell, "node")

	MaterialMgr.setCellByCfg(data, go)
end

function SharePopupView:clearCell(cell)
	local go = goutil.findChild(cell, "node")

	MaterialMgr.resetAll(go)
end

function SharePopupView:onEnter()
	SharePopupView.super.onEnter(self)

	local popupCfg = ActivityPopupConfig.instance:getAutoCfgById(7)

	ViewAutoShowController.instance:saveTypeDone(popupCfg)
	self.itemFlyGo:SetActive(false)
	self.viewBgGo:SetActive(true)

	self.bossInfo = ShareTaskModel.instance:GetMyShareBossInfo()

	if self.bossInfo == nil or not self.bossInfo.isHaveBoss then
		printError("sr---- 怪物来袭  SharePopupView:onEnter()    怪物信息空！")

		return
	end

	self.baseInfo = ShareTaskModel.instance:GetShareTaskBaseInfo()

	local cfg = ShareTaskConfig.instance:GetBossBaseCfg(self.bossInfo.bossTypeId)

	if cfg == nil then
		printError("sr---- 怪物来袭  SharePopupView:onEnter()  未获取到对应等级Boss配置 ： ", self.bossInfo.bossTypeId)

		return
	end

	removetimer(self.CalculationSurplusTime, self)

	local allTime = ShareTaskConfig.instance:GetBossShowTime()

	self.surplusTime = math.ceil(self.bossInfo.startTime / 1000 + allTime - checknumber(ServerTime.now()))
	self.monsterTxt.text = string.format("<size=26>%s</size> <size=24>%s级</size>", cfg.name, cfg.monsterLevel)

	local modelCfg = CharacterConfig.instance:getModelCo(cfg.monsterId)
	local showLihui = modelCfg and not string.nilorempty(modelCfg.bustName)

	self.petPhoto:showPetEffect(cfg.monsterId, showLihui, cfg.modelSize)
	self.scrollList1:reloadData(MaterialMgr.changeItemStrArr(cfg.fallReward))
	self.scrollList2:reloadData(MaterialMgr.changeItemStrArr(cfg.defeatReward))
	settimer(1, self.CalculationSurplusTime, self, true)
end

function SharePopupView:CalculationSurplusTime()
	self.surplusTime = self.surplusTime - 1

	if self.surplusTime == 0 then
		self.timerTxt.text = "怪物已逃离！！"

		FloatWordMgr.instance:show("怪物来袭活动结束！")
	end

	if self.surplusTime < 0 then
		removetimer(self.CalculationSurplusTime, self)

		if self.itemFlyGo and self.itemFlyGo.activeSelf then
			-- block empty
		else
			self:close()
		end

		return
	end

	local hour = math.floor(self.surplusTime / 3600)
	local min = math.floor((self.surplusTime - hour * 3600) / 60)
	local sec = self.surplusTime - hour * 3600 - min * 60

	self.timerTxt.text = hour > 0 and string.format("怪物逃离 %s时%s分", hour, min) or string.format("怪物逃离 %s分%s秒", min, sec)
end

function SharePopupView:OnClickLaterOrGotoBtn(isLater)
	self.isClickLater = isLater

	self.viewBgGo:SetActive(false)
	self.itemFlyGo:SetActive(true)
	GlobalDispatcher:addListener(GlobalNotify.GetFuncBtnPosRes, self.OnGetFuncBtnPos, self)
	GlobalDispatcher:dispatch(GlobalNotify.GetFuncBtnPosReq, 47)
end

function SharePopupView:OnGetFuncBtnPos(pos)
	pos = pos or Vector3.New(0, 0, 0)

	GlobalDispatcher:removeListener(GlobalNotify.GetFuncBtnPosRes, self.OnGetFuncBtnPos, self)

	local effPath = "fx_ui_xinshouzhiyin/fx_xinshouzhiyin_003/fx_feiru_xingxing.prefab"

	self.flyEff = UIEffectManager.instance:playEffect(self, effPath, self.itemFlyGo, 0, 0, false, nil, nil, nil, self)

	self.itemFlyGo.transform:DOMove(pos, 1)
	self.itemFlyGo.transform:DOScale(Vector3.New(0, 0, 0), 1)
	settimer(1, self.FlyEffFinished, self, false)
end

function SharePopupView:FlyEffFinished()
	removetimer(self.CalculationSurplusTime, self)
	removetimer(self.FlyEffFinished, self)
	TaskController.instance:foreceClearState()
	self:close()

	if not self.isClickLater then
		UIStateManager.instance:push(ViewName.ShareTask)
	end
end

return SharePopupView
