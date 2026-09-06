-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holylight/view/HolyLightDiceSelectView.lua

module("logic.extensions.holylight.view.HolyLightDiceSelectView", package.seeall)

local HolyLightDiceSelectView = class("HolyLightDiceSelectView", ViewComponent)

function HolyLightDiceSelectView:buildUI()
	HolyLightDiceSelectView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._btnSure = goutil.findChild(self.mainGO, "btnSure")
	self._choseCellsGo = goutil.findChild(self.mainGO, "choseCells")
	self._choseCells = {}

	for idx = 1, self._choseCellsGo.transform.childCount do
		local mainGo = self._choseCellsGo.transform:GetChild(idx - 1)
		local cell = {}

		cell._mainGo = mainGo
		cell._select = goutil.findChild(mainGo, "select")
		cell._imgSelect = goutil.findChild(mainGo, "select/img")
		cell._txtName = goutil.findChildTextComponent(mainGo, "txtName")
		cell._desc = goutil.findChild(mainGo, "desc")
		cell._txtDesc = goutil.findChildTextComponent(mainGo, "desc/txt")
		cell._touzi = goutil.findChild(mainGo, "touzi")
		cell._touziGoList = {}

		for idx = 1, cell._touzi.transform.childCount do
			local go = cell._touzi.transform:GetChild(idx - 1)

			table.insert(cell._touziGoList, go)
		end

		self._choseCells[idx] = cell
	end
end

function HolyLightDiceSelectView:bindEvents()
	HolyLightDiceSelectView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)

	for i, cell in ipairs(self._choseCells) do
		GameUtil.addClickHandler(cell._mainGo, GameUtil.handler(self._onClickChoseCell, self, i))
	end
end

function HolyLightDiceSelectView:unbindEvents()
	HolyLightDiceSelectView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)

	for _, cell in ipairs(self._choseCells) do
		GameUtil.rmClickHandler(cell._mainGo)
	end
end

function HolyLightDiceSelectView:onEnter()
	HolyLightDiceSelectView.super.onEnter(self)

	self._activityId = HolyLightController.instance:getActivityId()

	if self._activityId <= 0 then
		TipsFacade.instance:openTipWindowNoX("提示", "不在活动范围内", function()
			self:close()
		end, "确定", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	self._holyLightMgr = HolyLightController.instance:getHolyLightMgr(self._activityId)
	self._curSelectId = self._holyLightMgr:getNormalDieceId()

	self:_onUpdateChoseCol()
end

function HolyLightDiceSelectView:onExit()
	HolyLightDiceSelectView.super.onExit(self)
end

function HolyLightDiceSelectView:_onUpdateChoseCol()
	for diceId, cell in ipairs(self._choseCells) do
		local data = HolyLightConfig.instance:getHlDiceData(self._activityId, diceId)
		local isUnlock = self._holyLightMgr:isUnlockOfNormalDice(diceId)
		local isSelected = self._curSelectId == diceId

		GameUtil.SetActive(cell._imgSelect, isSelected)
		GameUtil.SetActive(cell._select, isUnlock)

		cell._txtName.text = data.name

		GameUtil.SetActive(cell._desc, not isUnlock)

		cell._txtDesc.text = data.desc

		for idx, value in ipairs(data.randList) do
			local go = cell._touziGoList[idx]

			if value < 10 then
				GameUtil.getUIImageSpriteChange(go):ChangeSprite(string.format("board_touzi_0%s", value))
			else
				GameUtil.getUIImageSpriteChange(go):ChangeSprite(string.format("board_touzi_%s", value))
			end
		end
	end
end

function HolyLightDiceSelectView:_onClickSure()
	if not self._holyLightMgr:isUnlockOfNormalDice(self._curSelectId) then
		FloatWordMgr.instance:show("未解锁该骰子")

		return
	end

	self._holyLightMgr:setNormalDieceId(self._curSelectId)
	GlobalDispatcher:dispatch(GlobalNotify.HolyLightDiceSelectSure, self._curSelectId)
	self:close()
end

function HolyLightDiceSelectView:_onClickChoseCell(id)
	if not self._holyLightMgr:isUnlockOfNormalDice(id) then
		return
	end

	self._curSelectId = id

	self:_onUpdateChoseCol()
end

return HolyLightDiceSelectView
