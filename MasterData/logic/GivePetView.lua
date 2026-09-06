-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/givepet/view/GivePetView.lua

module("logic.extensions.givepet.view.GivePetView", package.seeall)

local GivePetView = class("GivePetView", ViewComponent)

function GivePetView:ctor()
	GivePetView.super.ctor(self)
end

function GivePetView:buildUI()
	GivePetView.super.buildUI(self)

	self._closeBtn = self:getBtn("closeBtn")
	self._tipBtn = self:getBtn("tipBtn")
	self._getView = self:getGo("getView")
	self._getText = goutil.findChildTextComponent(self._getView, "getText")
	self._maxFast = goutil.findChildTextComponent(self.mainGO, "maxFast")
	self._rareCell = self:getGo("spriteIconGo/rareCell")
	self._spriteSkillBtn = self:getBtn("spriteIconGo/spriteSkillBtn")
	self._spriteExplainBtn = self:getBtn("spriteIconGo/spriteExplainBtn")
	self._time = goutil.findChildTextComponent(self.mainGO, "time")
	self._timeText = goutil.findChildTextComponent(self.mainGO, "time/Text")
	self._receiveBtn = self:getBtn("receiveBtn")
	self._redPoint = self:getGo("receiveBtn/redPoint")
	self._receiveText = goutil.findChildTextComponent(self._receiveBtn.gameObject, "Text")
	self._showText = goutil.findChildTextComponent(self.mainGO, "showText")
	self._role = self:getGo("role")
end

function GivePetView:bindEvents()
	GivePetView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._tipBtn:AddClickListener(self._onClickTip, self)
	self._spriteSkillBtn:AddClickListener(self._onClickSkill, self)
	self._spriteExplainBtn:AddClickListener(self._onClickExplain, self)
	self._receiveBtn:AddClickListener(self._onClickReceive, self)
end

function GivePetView:unbindEvents()
	GivePetView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._tipBtn:RemoveClickListener()
	self._spriteSkillBtn:RemoveClickListener()
	self._spriteExplainBtn:RemoveClickListener()
	self._receiveBtn:RemoveClickListener()
end

function GivePetView:destroyUI()
	GivePetView.super.destroyUI(self)
end

function GivePetView:onEnter()
	GivePetView.super.onEnter(self)

	local petPhotoShow = PetPhotoShow.Get(self._role)

	petPhotoShow:showPetEffect(10144, true, 8.5)
	goutil.setActive(self._getText.gameObject, false)

	self._getTextList = {
		speed = 1,
		createPosY = 0,
		move = 9999,
		distance = GameUtil.getHeight(self._getText.gameObject),
		recell = {}
	}

	MaterialMgr.setCell(MatType.Rare, 10144, self._rareCell)

	local activity = GivePetConfig.instance:getActivity()

	for i, v in ipairs(activity) do
		if ServerTime.now() >= GameUtil.string2time(v.startTime) and ServerTime.now() <= GameUtil.string2time(v.endTime) then
			self._activityInfo = v

			break
		end
	end

	if self._activityInfo then
		self:_timer()
		AresActivityAgent:sendPM_AresActivityGetInfoReq(self._activityInfo.id, function(msg)
			if msg.hasGainPrize then
				self._receiveText.text = "已领取"

				self._receiveBtn:RemoveClickListener()
			end

			self._hasReachCondition = msg.hasReachCondition and not msg.hasGainPrize

			uGuiUtil.setImageGrayStateRecursive(self._receiveBtn.gameObject, not self._hasReachCondition)

			if self._hasReachCondition then
				local effPath = "fx_ui_renshouyizhiaruis/fx_ui_renshouyizhiaruisi_lingqu.prefab"

				self._receiveEff = UIEffectManager.instance:playEffect(self, effPath, nil, 0, 0, true, nil, nil, function(finishHandler, eff)
					eff.effGo.transform:SetParent(self._receiveBtn.gameObject.transform)
					Framework.TransformUtil.SetLocalPos(eff.effGo.transform, 0, 0, 0)
					Framework.TransformUtil.SetLocalScale(eff.effGo.transform, 1, 1, 1)
				end)
			end

			goutil.setActive(self._redPoint, self._hasReachCondition)
		end)
		settimer(1, self._timer, self, true)
		FixedUpdateBeat:Add(self._updateGetView, self)
	else
		TipsFacade.instance:openTipWindow("提示", "活动未开启")
	end
end

function GivePetView:onEnterFinished()
	GivePetView.super.onEnterFinished(self)
end

function GivePetView:onExit()
	GivePetView.super.onExit(self)

	for i, v in ipairs(self._getTextList) do
		goutil.destroy(v)
	end

	if self._receiveEff then
		UIEffectManager.instance:stopEffect(self._receiveEff)
	end

	removetimer(self._timer, self)
	MaterialMgr.resetAll(self._rareCell)
	GivePetModel.instance:clearUser()
	FixedUpdateBeat:Remove(self._updateGetView, self)
end

function GivePetView:onExitFinished()
	GivePetView.super.onExitFinished(self)
end

function GivePetView:_updateGetView()
	if self._getTextList.move < self._getTextList.distance then
		for i = #self._getTextList, 1, -1 do
			local anchored = GameUtil.getAnchoredPos(self._getTextList[i])

			if anchored.y <= GameUtil.getHeight(self._getTextList[i]) then
				GameUtil.setAnchoredPos(self._getTextList[i], anchored.x, anchored.y + self._getTextList.speed)
			else
				table.insert(self._getTextList.recell, table.remove(self._getTextList, i))
			end
		end

		self._getTextList.move = self._getTextList.move + self._getTextList.speed
	else
		local userData = GivePetModel.instance:getUser()

		if userData then
			local cell = #self._getTextList.recell > 0 and table.remove(self._getTextList.recell, 1) or goutil.cloneAndSetParent(self._getText.gameObject, self._getView.transform)

			goutil.setActive(cell, true)

			local _text = goutil.findChildTextComponent(cell, "")

			_text.text = string.format(self._activityInfo.notReceiveTip, userData.name)

			UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(_text.gameObject:GetComponent(goutil.Type_RectTransform))

			local viewHeight = GameUtil.getHeight(self._getView)

			table.insert(self._getTextList, cell)

			if self._getTextList.createPosY > -1 * viewHeight then
				GameUtil.setAnchoredPos(cell, 0, self._getTextList.createPosY)

				self._getTextList.move = 0
				self._getTextList.distance = math.abs(math.min(viewHeight + self._getTextList.createPosY - GameUtil.getHeight(cell), 0))
				self._getTextList.createPosY = self._getTextList.createPosY - GameUtil.getHeight(cell)
			else
				GameUtil.setAnchoredPos(cell, 0, -1 * viewHeight)

				self._getTextList.move = 0
				self._getTextList.distance = GameUtil.getHeight(cell)
			end
		end
	end
end

function GivePetView:_onClickTip()
	local rule = RulesConfig.instance:getRuleCo("givepet")

	TipsFacade.instance:openTipWindow(rule.title, rule.rules)
end

function GivePetView:_onClickSkill()
	PetbookController.instance:previewBattle(10144)
end

function GivePetView:_onClickExplain()
	PetbookController.instance:openPetinfoView(10144)
end

function GivePetView:_onClickReceive()
	if self._hasReachCondition then
		AresActivityAgent.instance:sendPM_AresActivityGainPrizeReq(self._activityInfo.id, function()
			self._receiveText.text = "已领取"
			self._hasReachCondition = false

			UIEffectManager.instance:stopEffect(self._receiveEff)

			self._receiveEff = nil

			uGuiUtil.setImageGrayStateRecursive(self._receiveBtn.gameObject, true)
		end)
	else
		FloatWordMgr.instance:show("通关剧情副本5-12即可领取")
	end
end

function GivePetView:_timer()
	if GivePetModel.instance:isUpdate() then
		AresActivityAgent.instance:sendPM_AresActivityGetRecordReq(self._activityInfo.id, function(msg)
			if msg.firstRecord then
				self._maxFast.text = string.format("最快记录:<color=#EDDFAAFF>%s</color>", msg.firstRecord.userName)
			end

			GivePetModel.instance:addUser(msg.commonRecord)
		end)
	end

	local _endTime = GameUtil.string2time(self._activityInfo.endTime)

	if _endTime > ServerTime.now() then
		local temp = GameUtil.getTimeDDHHMMSS(_endTime - ServerTime.now())

		self._timeText.text = string.format("%d天%02d时%02d分%02d秒", temp.day, temp.hour, temp.min, temp.sec)
	else
		self._time.text = "活动已结束"
		self._timeText.text = ""
	end
end

return GivePetView
