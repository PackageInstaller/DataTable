-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerreturn/view/PlayerReturnSignView.lua

module("logic.extensions.playerreturn.view.PlayerReturnSignView", package.seeall)

local PlayerReturnSignView = class("PlayerReturnSignView", ViewComponent)

function PlayerReturnSignView:ctor()
	PlayerReturnSignView.super.ctor(self)

	self._signItemList = nil
end

function PlayerReturnSignView:bindEvents()
	PlayerReturnSignView.super.bindEvents(self)
end

function PlayerReturnSignView:unbindEvents()
	PlayerReturnSignView.super.unbindEvents(self)
end

function PlayerReturnSignView:onExit()
	PlayerReturnSignView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.PR_UpdataSignInfo, self._updataAllItemShow, self)
end

function PlayerReturnSignView:destroyUI()
	PlayerReturnSignView.super.destroyUI(self)

	self._tabItemList = nil
end

function PlayerReturnSignView:buildUI()
	PlayerReturnSignView.super.buildUI(self)

	self._sigdayTxt = goutil.findChildTextComponent(self.mainGO, "sigdayTxt")
	self._signItemList = {}

	for i = 1, 7 do
		local go = self:getGo("sigItem_" .. i)

		if go then
			self._signItemList[i] = {
				itemGo = go,
				itemBtn = Framework.ButtonAdapter.GetFrom(go, "bgImaBtn"),
				matPos = goutil.findChild(go, "matPos"),
				reachGo = goutil.findChild(go, "reachGo"),
				dayTxt = goutil.findChildTextComponent(go, "dayTxt"),
				numTxt = goutil.findChildTextComponent(go, "numTxt"),
				receiveGo = goutil.findChild(go, "receiveGo")
			}
		end
	end

	self._sigdayTxt.text = ""
end

function PlayerReturnSignView:onEnter()
	PlayerReturnSignView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.PR_UpdataSignInfo, self._updataAllItemShow, self)
	PlayerReturnController.instance:csRegressGetSignInInfoReq()

	self._actiInfo = PlayerReturnModel.instance:getOpenActivityInfo()
	self._mainCfg = self:getFirstParam()

	if self._mainCfg == nil then
		self._mainCfg = PlayerReturnConfig.instance:getReturnMainViewCfgs(self._actiInfo.actId, 1)
	end

	self:_updataAllItemShow()
end

function PlayerReturnSignView:_updataAllItemShow()
	self._openDays = GameUtil.getDaysByTimestamp(self._actiInfo.startTime, ServerTime.now())
	self._sigdayTxt.text = "已回归天数：" .. self._openDays .. "天"

	if self._signItemList == nil or #self._signItemList == 0 then
		return
	end

	local allCfgs = PlayerReturnConfig.instance:getReturnSignCfgs(self._mainCfg.planId)
	local receiveList = PlayerReturnModel.instance:getAllSignInfo()

	for i = 1, #self._signItemList do
		if self._signItemList[i] and allCfgs[i] then
			MaterialMgr.resetAll(self._signItemList[i].matPos)
			self._signItemList[i].itemBtn:RemoveClickListener()

			if receiveList[i] then
				GameUtil.SetActive(self._signItemList[i].reachGo, false)
				GameUtil.SetActive(self._signItemList[i].receiveGo, true)

				self._signItemList[i].dayTxt.text = string.format("第%s天", ConstString.ChineseNumber[i])
			else
				GameUtil.SetActive(self._signItemList[i].receiveGo, false)

				if i <= self._openDays then
					GameUtil.SetActive(self._signItemList[i].reachGo, true)

					self._signItemList[i].dayTxt.text = ""
				else
					GameUtil.SetActive(self._signItemList[i].reachGo, false)

					self._signItemList[i].dayTxt.text = string.format("第%s天", ConstString.ChineseNumber[i])
				end
			end

			if not string.nilorempty(allCfgs[i].prize) then
				local goodsInfo = string.split(allCfgs[i].prize, ":")
				local hwLua = MaterialMgr.setCell(checknumber(goodsInfo[1]), checknumber(goodsInfo[2]), self._signItemList[i].matPos)

				self._signItemList[i].numTxt.text = "x" .. goodsInfo[3]
			end

			self._signItemList[i].itemBtn:AddClickListener(function()
				if receiveList[i] then
					FloatWordMgr.instance:show("已领取，不可重复领取！")

					return
				end

				if i > self._openDays then
					FloatWordMgr.instance:show("未达到要求，不可领取！")

					return
				end

				PlayerReturnController.instance:csRegressGainSignInPrizeReq(i)
			end, self)
		end
	end
end

return PlayerReturnSignView
