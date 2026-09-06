-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fanruichallenge/view/FanRuiChallengeBuffView.lua

module("logic.extensions.fanruichallenge.view.FanRuiChallengeBuffView", package.seeall)

local FanRuiChallengeBuffView = class("FanRuiChallengeBuffView", ViewComponent)

function FanRuiChallengeBuffView:ctor()
	FanRuiChallengeBuffView.super.ctor(self)
end

function FanRuiChallengeBuffView:buildUI()
	FanRuiChallengeBuffView.super.buildUI(self)

	self._btnCancel = self:getBtn("btnCancel")
	self._btnSure = self:getBtn("btnSure")
	self._itemList = {}

	for i = 1, 3 do
		self._itemList[i] = {}

		for j = 1, 3 do
			local item = {}

			item.btn = self:getBtn(string.format("node%d/btn%d", i, j))
			item.txt = self:getTxt(string.format("node%d/btn%d/txt", i, j))
			item.select = self:getGo(string.format("node%d/btn%d/select", i, j))
			self._itemList[i][j] = item
		end
	end
end

function FanRuiChallengeBuffView:bindEvents()
	FanRuiChallengeBuffView.super.bindEvents(self)
	self._btnCancel:AddClickListener(self.close, self)
	self._btnSure:AddClickListener(self._onClickSure, self)

	for i = 1, 3 do
		for j = 1, 3 do
			local item = self._itemList[i][j]

			item.btn:AddClickListener(function()
				self:_onClickBtn(i, j)
			end)
		end
	end
end

function FanRuiChallengeBuffView:unbindEvents()
	FanRuiChallengeBuffView.super.unbindEvents(self)
	self._btnCancel:RemoveClickListener()
	self._btnSure:RemoveClickListener()

	for i = 1, 3 do
		for j = 1, 3 do
			local item = self._itemList[i][j]

			item.btn:RemoveClickListener()
		end
	end
end

function FanRuiChallengeBuffView:onEnter()
	FanRuiChallengeBuffView.super.onEnter(self)

	local params = self:getOpenParam()

	self._planId = params[1]
	self._choiceId1 = checknumber(params[2])
	self._choiceId2 = checknumber(params[3])
	self._choiceId3 = checknumber(params[4])

	self:_initState()
end

function FanRuiChallengeBuffView:onExit()
	FanRuiChallengeBuffView.super.onExit(self)
end

function FanRuiChallengeBuffView:_onClickSure()
	GlobalDispatcher:dispatch(GlobalNotify.FanRuiClgChoiceFinish, self._choiceId1, self._choiceId2, self._choiceId3)
	self:close()
end

function FanRuiChallengeBuffView:_initState()
	for i = 1, 3 do
		local choiceId = self["_choiceId" .. i]

		for j = 1, 3 do
			local item = self._itemList[i][j]
			local cfg = FanRuiChallengeConfig.instance:getProjectedPlanCfg(self._planId, i, j)

			item.txt.text = FanRuiChallengeController.instance:getRangeStr(cfg.valueRange)

			goutil.setActive(item.select, choiceId == j)
		end
	end
end

function FanRuiChallengeBuffView:_updateState(x, y)
	self["_choiceId" .. x] = y

	for i = 1, 3 do
		if i == x then
			for j = 1, 3 do
				local item = self._itemList[i][j]

				goutil.setActive(item.select, j == y)
			end
		end
	end
end

function FanRuiChallengeBuffView:_onClickBtn(i, j)
	self:_updateState(i, j)
end

return FanRuiChallengeBuffView
