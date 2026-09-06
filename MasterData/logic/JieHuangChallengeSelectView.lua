-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jiehuangchallenge/view/JieHuangChallengeSelectView.lua

module("logic.extensions.jiehuangchallenge.view.JieHuangChallengeSelectView", package.seeall)

local JieHuangChallengeSelectView = class("JieHuangChallengeSelectView", ViewComponent)

function JieHuangChallengeSelectView:ctor()
	JieHuangChallengeSelectView.super.ctor(self)
end

function JieHuangChallengeSelectView:buildUI()
	JieHuangChallengeSelectView.super.buildUI(self)

	self._btnSelect = self:getBtn("btnSelect")
	self._tableview = self:getGo("tableview")
	self._buffCell = self:getGo("buffCell")
end

function JieHuangChallengeSelectView:bindEvents()
	JieHuangChallengeSelectView.super.buildUI(self)
	GameUtil.addClickHandler(self._btnSelect, self._onClickSelect, self)
end

function JieHuangChallengeSelectView:unbindEvents()
	JieHuangChallengeSelectView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSelect)
end

function JieHuangChallengeSelectView:onEnter()
	JieHuangChallengeSelectView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.MiyaChallengeChoice, self._PM_MiyaChallengeChoiceRes, self)

	self._tableList = ScrollerList.create(self._tableview, self._buffCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._select = {}

	self:_refreshView()
end

function JieHuangChallengeSelectView:onExit()
	JieHuangChallengeSelectView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.MiyaChallengeChoice, self._PM_MiyaChallengeChoiceRes, self)
	self._tableList:dispose()
end

function JieHuangChallengeSelectView:_refreshView()
	if not MiyaChallengeModel.instance:getExchangeBuff() then
		self:close()

		return
	end

	local list = {}
	local buffData = {}

	buffData.index = 1
	buffData.newParam = checknumber(MiyaChallengeModel.instance:getExchangeBuff().buffId)
	buffData.oldParam = MiyaChallengeModel.instance:getBuff() and MiyaChallengeModel.instance:getBuff().buffId or nil
	self._select[buffData.index] = self._select[buffData.index] or false
	buffData.isOld = self._select[buffData.index]

	if buffData.newParam == 0 then
		-- block empty
	else
		table.insert(list, buffData)
	end

	local limitData = {}

	limitData.index = 2
	limitData.newParam = checknumber(MiyaChallengeModel.instance:getExchangeBuff().limitId)
	limitData.oldParam = MiyaChallengeModel.instance:getBuff() and MiyaChallengeModel.instance:getBuff().limitId or nil
	self._select[limitData.index] = self._select[limitData.index] or false
	limitData.isOld = self._select[limitData.index]

	if limitData.newParam == 0 then
		-- block empty
	else
		table.insert(list, limitData)
	end

	local conditionData = {}

	conditionData.index = 3
	conditionData.newParam = checknumber(MiyaChallengeModel.instance:getExchangeBuff().conditionId)
	conditionData.oldParam = MiyaChallengeModel.instance:getBuff() and MiyaChallengeModel.instance:getBuff().conditionId or nil
	self._select[conditionData.index] = self._select[conditionData.index] or false
	conditionData.isOld = self._select[conditionData.index]

	if conditionData.newParam == 0 then
		-- block empty
	else
		table.insert(list, conditionData)
	end

	self._tableList:reloadData(list)
end

function JieHuangChallengeSelectView:_onClickSelect()
	local result = {}

	result.buffId = self._select[1] == true and MiyaChallengeModel.instance:getBuff() and MiyaChallengeModel.instance:getBuff().buffId or checknumber(MiyaChallengeModel.instance:getExchangeBuff().buffId)
	result.limitId = self._select[2] == true and MiyaChallengeModel.instance:getBuff() and MiyaChallengeModel.instance:getBuff().limitId or checknumber(MiyaChallengeModel.instance:getExchangeBuff().limitId)
	result.conditionId = self._select[3] == true and MiyaChallengeModel.instance:getBuff() and MiyaChallengeModel.instance:getBuff().conditionId or checknumber(MiyaChallengeModel.instance:getExchangeBuff().conditionId)

	MiyaChallengeController.instance:sendPM_MiyaChallengeChoiceReq(result)
end

function JieHuangChallengeSelectView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local txtA = goutil.findChildTextComponent(go, "txtA")
	local txtB = goutil.findChildTextComponent(go, "txtB")
	local txtNumberA = goutil.findChildTextComponent(go, "txtNumberA")
	local txtNumberB = goutil.findChildTextComponent(go, "txtNumberB")
	local selectGoA = goutil.findChild(go, "selectA")
	local selectGoB = goutil.findChild(go, "selectB")
	local btnA = GameUtil.asBtn(goutil.findChild(go, "btnA"))
	local btnB = GameUtil.asBtn(goutil.findChild(go, "btnB"))

	if data.index == 1 then
		txtA.text = data.oldParam and MiyaChallengeConfig.instance:getBuffCfg(data.oldParam).des or lang("暂无记录")
		txtB.text = MiyaChallengeConfig.instance:getBuffCfg(data.newParam).des
	elseif data.index == 2 then
		txtA.text = data.oldParam and FormationValidatorConfig.instance:getFormationValidatorCfg(data.oldParam).desc or lang("暂无记录")
		txtB.text = FormationValidatorConfig.instance:getFormationValidatorCfg(data.newParam).desc
	elseif data.index == 3 then
		txtA.text = data.oldParam and (MiyaChallengeConfig.instance:getWindDesc(3, data.oldParam) or "未定义") or lang("暂无记录")
		txtB.text = MiyaChallengeConfig.instance:getWindDesc(3, data.newParam) or "未定义"
	else
		txtA.text = lang("暂无记录")
		txtB.text = lang("暂无记录")
	end

	txtNumberA.text = data.oldParam and (MiyaChallengeConfig.instance:getNum(data.index, data.oldParam) or "未定义") or lang("")
	txtNumberB.text = MiyaChallengeConfig.instance:getNum(data.index, data.newParam) or "未定义"

	GameUtil.SetActive(selectGoA, self._select[data.index])
	GameUtil.SetActive(selectGoB, not self._select[data.index])
	btnA:RemoveClickListener()

	if data.oldParam then
		btnA:AddClickListener(function()
			self:onClickIcon(data.index, true)
		end)
	else
		btnA:AddClickListener(function()
			return
		end)
	end

	btnB:RemoveClickListener()
	btnB:AddClickListener(function()
		self:onClickIcon(data.index, false)
	end)
end

function JieHuangChallengeSelectView:_clearCell(cell)
	local go = cell.gameObject
	local btnA = GameUtil.asBtn(goutil.findChild(go, "btnA"))
	local btnB = GameUtil.asBtn(goutil.findChild(go, "btnB"))

	btnA:RemoveClickListener()
	btnB:RemoveClickListener()
end

function JieHuangChallengeSelectView:onClickIcon(type, status)
	self._select[type] = status

	self._tableList:refresh()
end

function JieHuangChallengeSelectView:_PM_MiyaChallengeChoiceRes()
	FloatWordMgr.instance:show(lang("保存成功"))
	self:close()
end

return JieHuangChallengeSelectView
