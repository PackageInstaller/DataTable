-- chunkname: @modules/logic/sodache/view/inside/SodacheCheckView.lua

module("modules.logic.sodache.view.inside.SodacheCheckView", package.seeall)

local SodacheCheckView = class("SodacheCheckView", BaseView)

function SodacheCheckView:onInitView()
	self._goevent = gohelper.findChild(self.viewGO, "event")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "event/#btn_close")
	self._goexdice = gohelper.findChild(self.viewGO, "event/Middle/extra")
	self._gobaseitem = gohelper.findChild(self.viewGO, "event/Middle/base/Attr/Icons/sodache_diceitem")
	self._goexitem = gohelper.findChild(self.viewGO, "event/Middle/extra/Attr/Icons/sodache_diceitem")
	self._btncheck = gohelper.findChildButtonWithAudio(self.viewGO, "event/Bottom/#btn_throw")
	self._godice = gohelper.findChild(self.viewGO, "event/Bottom")
	self._goresult = gohelper.findChild(self.viewGO, "result")
	self._btnclose2 = gohelper.findChildButtonWithAudio(self.viewGO, "result/root/#btn_close")
	self._goresultsuccess = gohelper.findChild(self.viewGO, "result/root/Bg/Success")
	self._goresultbigsuccess2 = gohelper.findChild(self.viewGO, "result/root/Bg/BigSuccess")
	self._goresultfail = gohelper.findChild(self.viewGO, "result/root/Bg/Fail")
	self._goresultdice = gohelper.findChild(self.viewGO, "result/root/Bottom")
	self._goresultsuccessbg = gohelper.findChild(self.viewGO, "result/root/Bottom/success/go_successbg")
	self._goresultbigsuccessbg = gohelper.findChild(self.viewGO, "result/root/Bottom/bigsuccess/go_successbg")
	self._anim = gohelper.findComponentAnim(self.viewGO)
end

function SodacheCheckView:addEvents()
	self._btnclose:AddClickListener(self.closeThis, self)
	self._btnclose2:AddClickListener(self.closeThis, self)
	self._btncheck:AddClickListener(self.onClickCheck, self)
	SodacheController.instance:registerCallback(SodacheEvent.OnCheckResult, self._onResult, self)
end

function SodacheCheckView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnclose2:RemoveClickListener()
	self._btncheck:RemoveClickListener()
	SodacheController.instance:unregisterCallback(SodacheEvent.OnCheckResult, self._onResult, self)
end

function SodacheCheckView:onOpen()
	gohelper.setActive(self._goevent, true)
	gohelper.setActive(self._goresult, false)

	self._diceComp = MonoHelper.addNoUpdateLuaComOnceToGo(self._godice, SodacheCheckDicePart)
	self._diceComp2 = MonoHelper.addNoUpdateLuaComOnceToGo(self._goresultdice, SodacheCheckDicePart)
	self.useCardMo = self.viewParam.cardMo
	self.choiceCo = self.viewParam.choiceCo

	local baseDiceId = self.choiceCo.baseDice
	local minDice = 1
	local maxDice = 4
	local str = SodacheConfig.instance:getConstVal(SodacheEnum.ConstId.BaseDiceCount)

	if not string.nilorempty(str) then
		local arr = string.splitToNumber(str, ",")

		minDice = arr[1] or minDice
		maxDice = arr[2] or maxDice
	end

	local baseDiceCount = Mathf.Clamp(SodacheUtil.getAttr(SodacheEnum.AttrId.DiceCount) + SodacheUtil.getAttr(SodacheEnum.AttrId.DiceCountEx), minDice, maxDice)
	local baseDiceList = {}

	for i = 1, baseDiceCount do
		table.insert(baseDiceList, baseDiceId)
	end

	local exDiceList = {}

	if self.useCardMo then
		exDiceList = string.splitToNumber(self.useCardMo.serverMo.itemCo.diceList, "#") or {}
	end

	gohelper.setActive(self._goexdice, #exDiceList > 0)
	gohelper.CreateObjList(self, self._createDiceItems, baseDiceList, nil, self._gobaseitem, SodacheDiceItem)
	gohelper.CreateObjList(self, self._createDiceItems, exDiceList, nil, self._goexitem, SodacheDiceItem)
	self._diceComp:updateDices(self.choiceCo.verifyCond)
	self._diceComp2:updateDices(self.choiceCo.verifyCond)
end

function SodacheCheckView:_createDiceItems(obj, data, index)
	obj:setData(data, true)
end

function SodacheCheckView:onClickCheck()
	SodacheInsideRpc.instance:sendSodacheInsideSceneOperation(SodacheEnum.OperType.SelectChoice, tostring(self.choiceCo.id) .. ((self.useCardMo or nil) and "#" .. self.useCardMo.serverMo.configId))
end

function SodacheCheckView:onClickModalMask()
	self:closeThis()
end

local CloseAnimName = {
	[0] = "fail_",
	"success_",
	"bigsuccess_"
}

function SodacheCheckView:_onResult(resultMo)
	AudioMgr.instance:trigger(AudioEnum3_7.Sodache.check_begin)

	self._resultMo = resultMo
	resultMo.isUse = true

	gohelper.setActive(self._goresult, true)

	local dices = resultMo.dices
	local result = resultMo.result

	gohelper.setActive(self._goresultsuccessbg, result == 1)
	gohelper.setActive(self._goresultbigsuccessbg, result == 2)
	gohelper.setActive(self._goresultsuccess, result == 1)
	gohelper.setActive(self._goresultbigsuccess2, result == 2)
	gohelper.setActive(self._goresultfail, result == 0)

	local closeAnimName = CloseAnimName[result] .. "close"

	self.viewContainer:setCloseAnimName(closeAnimName)

	for i = 1, 10 do
		local diceGo = gohelper.findChild(self.viewGO, string.format("result/root/Dice/pos%d/sodache_diceitem_result", i))

		if dices[i] then
			local dice = MonoHelper.addNoUpdateLuaComOnceToGo(diceGo, SodacheDiceResultItem)

			dice:setData(dices[i])
		else
			gohelper.setActive(diceGo, false)
		end
	end

	self._anim.enabled = true

	self._anim:Play("check_in", 0, 0)
	TaskDispatcher.runDelay(self._delayShowResult, self, 0.833)
	UIBlockHelper.instance:startBlock("SodacheCheckView_Result", 1.1)
end

function SodacheCheckView:_delayShowResult()
	if self._resultMo.result == SodacheEnum.CheckResult.Fail then
		AudioMgr.instance:trigger(AudioEnum3_7.Sodache.check_fail)
	elseif self._resultMo.result == SodacheEnum.CheckResult.Success then
		AudioMgr.instance:trigger(AudioEnum3_7.Sodache.check_success)
	elseif self._resultMo.result == SodacheEnum.CheckResult.BigSuccess then
		AudioMgr.instance:trigger(AudioEnum3_7.Sodache.check_bigsuccess)
	end

	local openAnimName = CloseAnimName[self._resultMo.result] .. "open"

	self._anim:Play(openAnimName, 0, 0)
end

function SodacheCheckView:onClose()
	if self._resultMo then
		self._resultMo.callback(self._resultMo.callobj)
	end

	TaskDispatcher.cancelTask(self._delayShowResult, self)
end

return SodacheCheckView
