-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/longhuang/LonghuangmainView.lua

module("logic.extensions.timelimitedchallenge.view.longhuang.LonghuangmainView", package.seeall)

local LonghuangmainView = class("LonghuangmainView", TimeLimitedMainView)

function LonghuangmainView:_setEffectUrls()
	self._effPaths = {
		{
			goPath = "imgSlogan",
			path = "fx_ui_chiyanlonghuangtiaozhan/fx_fx_ui_chiyanlonghuangtiaozhan_zi.prefab"
		},
		{
			goPath = "btnStart",
			path = "fx_ui_chiyanlonghuangtiaozhan/fx_ui_chiyanlonghuangtiaozhan_jinru.prefab"
		},
		{
			goPath = "",
			path = "fx_ui_chiyanlonghuangtiaozhan/fx_ui_chiyanlonghuangtiaozhan_bg.prefab"
		}
	}
end

function LonghuangmainView:buildUI()
	LonghuangmainView.super.buildUI(self)

	self._challengeId = LonghuangGameModel.instance:getChallengeId()
	self._btnPlayGame = self:getBtn("btnContainer/btnPlayGame")
	self._playMoney = self:getGo("btnContainer/money")
	self._txtMoney = goutil.findChildTextComponent(self._playMoney, "txtMoney")
	self._imgMoney = goutil.findChild(self._playMoney, "imgMoney")
	self._gameCostStr = TimeLimitedConfig.instance:getLongHuangCommonValue("GAME_COST")
	self._regainCost = Vector3.New(unpack(string.splitToNumber(self._gameCostStr, ":")))
	self._txtMoney.text = self._regainCost.z .. "重玩"
	self._txtNull:GetComponent(goutil.Type_UIText).text = lang("longhuang_nobuff_tip")
end

function LonghuangmainView:bindEvents()
	LonghuangmainView.super.bindEvents(self)
	self._btnPlayGame:AddClickListener(self._onClickPlayGame, self)
end

function LonghuangmainView:unbindEvents()
	LonghuangmainView.super.unbindEvents(self)
	self._btnPlayGame:RemoveClickListener()
end

function LonghuangmainView:onEnter()
	LonghuangmainView.super.onEnter(self)
	MaterialMgr.setIcon(self._imgMoney, self._regainCost.x, self._regainCost.y)

	self._buffCfg = nil

	self:_updateBuffUI()
	GlobalDispatcher:addListener(GlobalNotify.LonghuangBuffUpdate, self._updateBuffUI, self)
end

function LonghuangmainView:onExit()
	LonghuangmainView.super.onExit(self)
	uGuiUtil.clearImage(self._imgMoney)
	GlobalDispatcher:removeListener(GlobalNotify.LonghuangBuffUpdate, self._updateBuffUI, self)
end

function LonghuangmainView:_updateCircleUI()
	LonghuangmainView.super._updateCircleUI(self)

	if not LonghuangGameModel.instance:isDataInit() then
		TimedChallengeGameAgent.instance:sendPM_TimedChallengeGetInfoReq(self._challengeId, self._onGameInfoRes, self)
	else
		self:_updateBuffUI()
	end
end

function LonghuangmainView:_onGameInfoRes(msg)
	LonghuangGameModel.instance:setDodgeTime(msg.dodgeTime)
	self:_updateBuffUI()
end

function LonghuangmainView:_updateBuffUI()
	local dodgeTime = LonghuangGameModel.instance:getDodgeTime()

	print("dodgeTime = " .. dodgeTime)

	self._buffCfg, self._isMaxBuff = TimeLimitedConfig.instance:getLongHuangGameBuffCfg(dodgeTime)
	self._hasBuff = self._buffCfg ~= nil

	self._txtNull:SetActive(not self._hasBuff)
	self._buffCell:setActive(self._hasBuff)

	if self._hasBuff then
		self._buffCell:updateWithPanduolaBuffCfg(self._buffCfg)
	end

	self._playMoney:SetActive(self._hasBuff)
end

function LonghuangmainView:_onClickStart()
	if self._isEmpty then
		FloatWordMgr.instance:show("今天的挑战次数已经用完了")

		return
	end

	UIStateManager.instance:push(ViewName.LonghuangdetailView)
end

function LonghuangmainView:_onClickBuffTips()
	UIStateManager.instance:push(ViewName.TimelimitedeffectpreView, self._challengeId)
end

function LonghuangmainView:_onClickPlayGame()
	if self._isMaxBuff then
		FloatWordMgr.instance:show("当前已经是最优的效果，无需重玩")
	elseif not self._hasBuff then
		self:_openGameView()
	else
		local graphicStr, isMatEnough, tip = TLChallengeController.instance:getMatParams(self._gameCostStr)
		local params = {}

		params.title = lang("重玩躲避火球")
		params.text = string.format("你确定要消耗%s，重玩躲避火球吗？\n", graphicStr)

		function params.okHandler()
			if not isMatEnough then
				FloatWordMgr.instance:show(tip)
			else
				self:_openGameView()
			end
		end

		params.okTarget = self
		params.challengeId = self._challengeId
		params.buffCfg = self._buffCfg
		params.showCancel = true

		UIStateManager.instance:push(ViewName.ResetBuffView, params)
	end
end

function LonghuangmainView:_openGameView()
	UIStateManager.instance:push(ViewName.LonghuanggameView)
end

return LonghuangmainView
