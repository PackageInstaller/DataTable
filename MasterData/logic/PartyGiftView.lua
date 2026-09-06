-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/partysummary/view/PartyGiftView.lua

module("logic.extensions.partysummary.view.PartyGiftView", package.seeall)

local PartyGiftView = class("PartyGiftView", TableViewComponent)

function PartyGiftView:ctor()
	PartyGiftView.super.ctor(self)

	self._choiActId = nil
	self._partyGiftInfo = nil
end

function PartyGiftView:onExit()
	PartyGiftView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.Party_UpdataPartyGiftInfo, self._updataPartyGiftSR, self)

	if self.pmEff then
		UIEffectManager.instance:stopEffect(self.pmEff)
	end

	self.pmEff = nil

	goutil.destroy(self._spineAnimGo)
	uGuiUtil.clearImage(self._bgGo)
end

function PartyGiftView:destroyUI()
	PartyGiftView.super.destroyUI(self)

	self._partyGiftInfo = nil
end

function PartyGiftView:bindEvents()
	PartyGiftView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
end

function PartyGiftView:unbindEvents()
	PartyGiftView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
end

function PartyGiftView:buildUI()
	PartyGiftView.super.buildUI(self)

	self._closeBtn = self:getBtn("bgGo/closeBtn")
	self._timeTxt = self:getTxt("timeGo/timeTxt")
	self._timeTxt.text = ""
	self._animGo = self:getGo("animGo")
	self._bgGo = self:getGo("bgGo")
	self._tabListSRGo = self:getGo("prizeItemSR")
	self._viewport = self:getGo("prizeItemSR/Viewport")
	self._timeGo = self:getGo("timeGo")
	self._tipGo = self:getGo("tipsTxt")
end

function PartyGiftView:onEnter()
	PartyGiftView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.Party_UpdataPartyGiftInfo, self._updataPartyGiftSR, self)

	self._choiActId = checknumber(self:getFirstParam())

	if self._choiActId <= 0 then
		self._choiActId = PartySummaryConfig.instance:getPartyGiftActivityId()
	end

	if self._choiActId <= 0 then
		printError("sr--- 派对口令      PartyGiftView:onEnter()       时间未到怎么打开了？")
		self:close()

		return
	end

	local isInTime = false
	local actCfg = ActivityDefineConfig.instance:getCfgById(GameEnum.ActivityType.PartyGift, self._choiActId)

	if actCfg == nil or string.nilorempty(actCfg.startTime) then
		self._timeTxt.text = ""

		printError("sr--- 派对口令     PartyGiftView:onEnter()       策划未配置 = " .. self._choiActId)
	else
		local startTime = GameUtil.string2date(actCfg.startTime)
		local endTime = GameUtil.string2date(actCfg.endTime)

		isInTime = GameUtil.checkIsInTimePeriod(actCfg.startTime, actCfg.endTime)
		self._timeTxt.text = langPara("FunArena_HallView_Tips_1", startTime.month, startTime.day, startTime.hour, startTime.min, endTime.month, endTime.day, endTime.hour, endTime.min)
	end

	self:_initUI()

	self._partyGiftInfo = nil
	self._curViewDatas = PartySummaryConfig.instance:getGiftPrizeCfgs(self._choiActId)

	self:_updataPartyGiftSR(0, nil, nil)

	self._spineAnimGo = self:getResInstance("effect/prefabs/ui/20220930/0930shengzhupaidui/0930shengzhupaidui-ui_p.prefab")

	goutil.addChildToParent(self._spineAnimGo, self._animGo)

	if isInTime then
		PartySummaryController.instance:csGetPartyGiftGetInfoReq()
	end
end

function PartyGiftView:_initUI()
	local cfg = PartySummaryConfig.instance:getGiftPrizeBgCfgs(self._choiActId)

	local function func()
		self._bgGo:GetComponent(goutil.Type_UIImage):SetNativeSize()
	end

	uGuiUtil.setSpriteToImage(self._bgGo, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgFolderUrl("activitypopup", cfg.bgName), func)
	GameUtil.setLocalPos(self._bgGo, cfg.bgPos[1], cfg.bgPos[2], 0)
	GameUtil.setLocalPos(self._tabListSRGo, cfg.taskPosAndSize[1], cfg.taskPosAndSize[2], 0)
	GameUtil.setLocalPos(self._tipGo, cfg.tipPos[1], cfg.tipPos[2], 0)
	GameUtil.setLocalPos(self._timeGo, cfg.timePos[1], cfg.timePos[2], 0)
	GameUtil.setWidth(self._viewport, cfg.taskPosAndSize[3])
	GameUtil.setHeight(self._viewport, cfg.taskPosAndSize[4])
end

function PartyGiftView:_playSpineAnimAnim()
	local count = self._spineAnimGo.transform.childCount

	for i = 1, count do
		local go = self._spineAnimGo.transform:GetChild(i - 1).gameObject
		local graphic = go:GetComponent(typeof(Spine.Unity.SkeletonGraphic))

		if graphic then
			local data = graphic.skeletonDataAsset:GetAnimationStateData()

			if data.SkeletonData:FindAnimation("idle1") ~= nil then
				graphic.startingAnimation = "idle1"

				graphic.AnimationState:SetAnimation(0, "idle1", true)
				graphic:Update(0)
			end
		end
	end
end

function PartyGiftView:_updataPartyGiftSR(status, msg, isNotify)
	if status == nil or status ~= 0 then
		return
	end

	if self._partyGiftInfo == nil then
		self._partyGiftInfo = {
			loginDays = 0,
			prizeIds = {}
		}
	end

	if msg and msg.activityId == self._choiActId then
		if isNotify then
			table.insert(self._partyGiftInfo.prizeIds, checknumber(msg.prizeId))
		else
			self._partyGiftInfo.prizeIds = {}

			for _, id in pairs(msg.prizeId or {}) do
				if checknumber(id) > 0 then
					table.insert(self._partyGiftInfo.prizeIds, checknumber(id))
				end
			end

			self._partyGiftInfo.loginDays = checknumber(msg.loginDays)
		end
	end

	if self._curViewDatas and #self._curViewDatas > 1 then
		for i = 1, #self._curViewDatas do
			self._curViewDatas[i].state = 1

			if self._curViewDatas[i].progress <= self._partyGiftInfo.loginDays then
				self._curViewDatas[i].state = table.indexof(self._partyGiftInfo.prizeIds, self._curViewDatas[i].id) and 2 or 0
			end
		end

		table.sort(self._curViewDatas, function(a, b)
			if a.state == b.state then
				return a.id < b.id
			end

			return a.state < b.state
		end)
	end

	self._tableview:ReloadData()
end

function PartyGiftView:_getPath()
	return {
		cellPath = "prizeItem",
		viewPath = "prizeItemSR"
	}
end

function PartyGiftView:_cellSize()
	return 630, 80
end

function PartyGiftView:_updateCell(view, cell, data)
	local titleTxt = goutil.findChildTextComponent(cell, "titleTxt")
	local descTxt = goutil.findChildTextComponent(cell, "descTxt")
	local stateTxt = goutil.findChildTextComponent(cell, "stateTxt")
	local colorChange = stateTxt:GetComponent(ComponentType.UITextColorChange)
	local goodsPos = goutil.findChild(cell, "goodsPos")
	local reveiceBtnGo = goutil.findChild(cell, "reveiceBtn")
	local finishGo = goutil.findChild(cell, "finishGo")

	MaterialMgr.resetAll(goodsPos)
	GameUtil.asBtn(reveiceBtnGo):RemoveClickListener()

	titleTxt.text = data.title
	descTxt.text = data.desc

	MaterialMgr.setCellByCfg(data.prize, goodsPos)

	if data.state == 0 then
		stateTxt.text = ""

		GameUtil.SetActive(finishGo, false)
		GameUtil.SetActive(reveiceBtnGo, true)
	elseif data.state == 1 then
		if data.progress == self._partyGiftInfo.loginDays + 1 then
			stateTxt.text = string.format("明日登录解锁")

			colorChange:SetState(1)
		else
			stateTxt.text = string.format("尚未解锁")

			colorChange:SetState(0)
		end

		GameUtil.SetActive(finishGo, false)
		GameUtil.SetActive(reveiceBtnGo, false)
	elseif data.state == 2 then
		stateTxt.text = ""

		GameUtil.SetActive(reveiceBtnGo, false)
		GameUtil.SetActive(finishGo, true)
	end

	GameUtil.asBtn(reveiceBtnGo):AddClickListener(function()
		if data.state == 1 then
			FloatWordMgr.instance:show("该口令还未解锁！")

			return
		end

		if data.state == 2 then
			FloatWordMgr.instance:show("该奖励已领取过了！")

			return
		end

		self:_onClickGiftItem(data.codeWordGroupId, data.codeWordId)
	end, self)
end

function PartyGiftView:_onClickGiftItem(groupId, codeId)
	local cfg = CodeWordConfig.instance:getWordGroupCfg(groupId)

	if cfg == nil or string.nilorempty(cfg.channelIds) then
		printError("sr---派对口令   PartyGiftView:_onClickGiftItem()  code_word_group   口令组配置空？？")

		return
	end

	local channelIds = string.split(cfg.channelIds, "#")
	local textCfg = CodeWordConfig.instance:getTextCfg(groupId, codeId)

	if textCfg == nil or string.nilorempty(textCfg.text) then
		printError("sr---派对口令   PartyGiftView:_onClickGiftItem()  code_word   口令组配置空？？")

		return
	end

	local id = 2

	if channelIds and channelIds[1] then
		id = checknumber(channelIds[1])
	end

	self:close()
	UIStateManager.instance:push(ViewName.chat, id, textCfg.text)
end

return PartyGiftView
