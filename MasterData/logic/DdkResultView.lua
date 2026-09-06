-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/darkdragonknife/view/DdkResultView.lua

module("logic.extensions.darkdragonknife.view.DdkResultView", package.seeall)

local DdkResultView = class("DdkResultView", ViewComponent)

function DdkResultView:ctor()
	DdkResultView.super.ctor(self)
end

function DdkResultView:buildUI()
	DdkResultView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._txtScore = self:getTxt("score/txtScore")
	self._txtTime = self:getTxt("time/txtTime")
end

function DdkResultView:bindEvents()
	DdkResultView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._clickClose, self)
end

function DdkResultView:unbindEvents()
	DdkResultView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function DdkResultView:destroyUI()
	DdkResultView.super.destroyUI(self)
end

function DdkResultView:onEnter()
	DdkResultView.super.onEnter(self)

	local params = self:getFirstParam()
	local totalScore = params.totalScore
	local tickTime = params.tickTime

	self._txtScore.text = langPara("获得积分 +%s", totalScore)
	self._txtTime.text = langPara("游戏时长：%s", tickTime)
end

function DdkResultView:onEnterFinished()
	DdkResultView.super.onEnterFinished(self)
end

function DdkResultView:onExit()
	DdkResultView.super.onExit(self)
end

function DdkResultView:onExitFinished()
	DdkResultView.super.onExitFinished(self)
end

function DdkResultView:_clickClose()
	local params = self:getFirstParam()
	local tickTime = params.tickTime
	local serverKey = DDragonKModel.instance:getServerKey()
	local clientKey = DDragonKModel.instance:getClientKey()

	serverKey = GenEncryptedKeyUtil.dxor(serverKey, clientKey)

	local encryptedKey = 0

	local function encrypt(num)
		encryptedKey = num % 2 == 0 and encryptedKey + (num + serverKey) * 5381 or encryptedKey + (num + clientKey) * 31
	end

	local gameTime = math.min(tickTime, checknumber(DDragonKConfig.instance:getCommonCfg("MAX_GAME_TIME")))

	encrypt(gameTime)
	DarkDragonKnifeAgent.instance:sendPM_DarkDragonKnifeEndGameReq(gameTime, encryptedKey)
	self:close()
	params.closeCallBack()
end

return DdkResultView
