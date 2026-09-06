-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/youngchampionking/view/YoungchampionkingsupportrecordView.lua

module("logic.extensions.youngchampionking.view.YoungchampionkingsupportrecordView", package.seeall)

local YoungchampionkingsupportrecordView = class("YoungchampionkingsupportrecordView", ViewComponent)

function YoungchampionkingsupportrecordView:ctor()
	YoungchampionkingsupportrecordView.super.ctor(self)
end

function YoungchampionkingsupportrecordView:unbindEvents()
	YoungchampionkingsupportrecordView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function YoungchampionkingsupportrecordView:bindEvents()
	YoungchampionkingsupportrecordView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
end

function YoungchampionkingsupportrecordView:buildUI()
	YoungchampionkingsupportrecordView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._tabtableviewGo = self:getGo("tabtableview")
	self._tabtablecellGo = self:getGo("tabtablecell")
	self._tablecellGo = self:getGo("tablecell")
	self._tableviewGo = self:getGo("tableview")
	self._scrollerList = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._tabScrollerList = ScrollerList.create(self._tabtableviewGo, self._tabtablecellGo, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))
	self._emptyGo = self:getGo("empty")
end

function YoungchampionkingsupportrecordView:onExit()
	YoungchampionkingsupportrecordView.super.onExit(self)
	self._scrollerList:dispose()
	self._tabScrollerList:dispose()
end

function YoungchampionkingsupportrecordView:onEnter()
	YoungchampionkingsupportrecordView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_YCKGetGuessRecordRes, self._onPM_YCKGetGuessRecordRes, self)

	self._activityId = self:getFirstParam()

	local curStepId = YoungChampionKingModel.instance:getCurStepId()

	self._curSelectTab = YoungChampionKingController.instance:getRoundIdByStepId(curStepId)

	self:_updateUI()
end

function YoungchampionkingsupportrecordView:_onClickbtnClose()
	self:close()
end

function YoungchampionkingsupportrecordView:_updateUI()
	self:_updateTab()
end

function YoungchampionkingsupportrecordView:_updateTab()
	local roundCfgs = YoungChampionKingConfig.instance:getRoundCfgs(self._activityId)
	local cfgs = {}

	for i, v in ipairs(roundCfgs) do
		if v.gussPlanId > 0 then
			table.insert(cfgs, v)
		end
	end

	self._tabScrollerList:reloadData(cfgs)

	if self._curSelectTab <= 0 or self._curSelectTab > #cfgs then
		self:_onClickTabCell(cfgs[1].roundId)
	else
		self:_onClickTabCell(self._curSelectTab)
	end
end

function YoungchampionkingsupportrecordView:_updateCell(view, cell, data)
	local _Img_Tag = goutil.findChild(cell, "Img_Tag")
	local change_Tag = _Img_Tag:GetComponent("UIImageSpriteChange")
	local txt_Tag = goutil.findChild(cell, "txt_Tag")
	local _Left_Head = goutil.findChild(cell, "Head_Left/Img_Head")
	local _Right_Head = goutil.findChild(cell, "Head_Right/Img_Head")
	local _Right_Name = goutil.findChild(cell, "Head_Right/Txt_Name"):GetComponent("Text")
	local _Left_Name = goutil.findChild(cell, "Head_Left/Txt_Name"):GetComponent("Text")
	local txtScore = goutil.findChildTextComponent(cell, "txtScore")
	local showValueGo = goutil.findChild(cell, "showValue")
	local txtSupport = goutil.findChildTextComponent(showValueGo, "txtSupport")
	local resultGo = goutil.findChild(showValueGo, "result")
	local resultChange = resultGo:GetComponent("UIImageSpriteChange")
	local txtResult = goutil.findChildTextComponent(resultGo, "txtValue")

	HeadItemController.instance:setHeadCellByInfo(_Right_Head, data.playerB)
	HeadItemController.instance:setHeadCellByInfo(_Left_Head, data.playerA)

	_Right_Name.text = data.playerB.userName
	_Left_Name.text = data.playerA.userName
	txtSupport.text = string.format("应援:%s", data.guessNum)

	local isLeft = checknumber(data.targetPlayerId) == checknumber(data.playerA.userId)

	if isLeft then
		GameUtil.setAnchoredPos(showValueGo, 250, 20)
	else
		GameUtil.setAnchoredPos(showValueGo, 615, 20)
	end

	if data.result and data.result ~= 0 then
		txtScore.text = string.format("%s:%s", data.playerAWinCount, data.playerBWinCount)

		goutil.setActive(resultGo, true)

		if data.result > 0 then
			txtResult.text = string.format("+%s", data.result)

			resultChange:SetState(0)
		else
			txtResult.text = data.result

			resultChange:SetState(1)
		end

		goutil.setActive(_Img_Tag, true)

		local isWin = data.playerAWinCount > data.playerBWinCount

		change_Tag:SetState(isWin and 0 or 1)
		goutil.setActive(txt_Tag, false)
	else
		goutil.setActive(resultGo, false)
		goutil.setActive(_Img_Tag, false)
		goutil.setActive(txt_Tag, true)

		txtScore.text = ""
	end
end

function YoungchampionkingsupportrecordView:_clearCell(cell)
	local _Left_Head = goutil.findChild(cell, "Head_Left/Img_Head")
	local _Right_Head = goutil.findChild(cell, "Head_Right/Img_Head")

	HeadItemController.instance:resetHeadCell(_Right_Head)
	HeadItemController.instance:resetHeadCell(_Left_Head)
end

function YoungchampionkingsupportrecordView:_updateTabCell(view, cell, cfg, tag)
	local btn = Framework.ButtonAdapter.Get(cell.gameObject)
	local txtDesc = goutil.findChildTextComponent(cell.gameObject, "txt")
	local change = cell.gameObject:GetComponent(ComponentType.UIChangeGroup)

	txtDesc.text = cfg.roundName

	change:SetState(self._curSelectTab == cfg.roundId and 0 or 1)
	btn:AddClickListener(function()
		self:_onClickTabCell(cfg.roundId)
	end)
end

function YoungchampionkingsupportrecordView:_clearTabCell(cell)
	return
end

function YoungchampionkingsupportrecordView:_onClickTabCell(roundId)
	self._curSelectTab = roundId

	YoungChampionKingController.instance:sendPM_YCKGetGuessRecordReq(self._activityId, roundId)
	self._tabScrollerList:refresh()
end

function YoungchampionkingsupportrecordView:_onPM_YCKGetGuessRecordRes()
	local info = YoungChampionKingModel.instance:getGuessRecordInfo()

	self._scrollerList:reloadData(info.recordList)
	goutil.setActive(self._emptyGo, not info.recordList or #info.recordList <= 0)
end

return YoungchampionkingsupportrecordView
