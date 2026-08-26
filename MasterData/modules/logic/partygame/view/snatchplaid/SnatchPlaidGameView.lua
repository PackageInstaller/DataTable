-- chunkname: @modules/logic/partygame/view/snatchplaid/SnatchPlaidGameView.lua

module("modules.logic.partygame.view.snatchplaid.SnatchPlaidGameView", package.seeall)

local SnatchPlaidGameView = class("SnatchPlaidGameView", SceneGameCommonView)

function SnatchPlaidGameView:onOpen()
	SnatchPlaidGameView.super.onOpen(self)
	self:initSceneCountDown()
end

function SnatchPlaidGameView:initSceneCountDown()
	gohelper.setActive(self._partygamebattlebar, false)

	local itemRes = self.viewContainer:getSetting().otherRes.num
	local sceneRoot = gohelper.findChild(GameSceneMgr.instance:getCurScene():getSceneContainerGO(), "game6_p(Clone)/ecsobjs")

	self._sceneGo = self.viewContainer:getResInst(itemRes, sceneRoot)
	self._countDownTxt = gohelper.findChildText(self._sceneGo, "#txt_num")
	self._countDownTxt2 = gohelper.findChildText(self._sceneGo, "#txt_num2")
end

function SnatchPlaidGameView:viewUpdate()
	if self._countDownTxt then
		local countDown = PartyGameCSDefine.SnatchPlaidGameInterfaceCs.GetCountDown()
		local curStatus = PartyGameCSDefine.SnatchPlaidGameInterfaceCs.GetCurStatus()

		if countDown > 0 then
			if curStatus == 4 then
				self._countDownTxt2.text = math.ceil(countDown)
				self._countDownTxt.text = ""
			else
				self._countDownTxt.text = math.ceil(countDown)
				self._countDownTxt2.text = ""
			end
		else
			self._countDownTxt.text = ""
			self._countDownTxt2.text = ""
		end
	end
end

function SnatchPlaidGameView:onDestroyView()
	if self._sceneGo then
		gohelper.destroy(self._sceneGo)
	end

	self._sceneGo = nil
	self._countDownTxt = nil
	self._countDownTxt2 = nil

	SnatchPlaidGameView.super.onDestroyView(self)
end

return SnatchPlaidGameView
