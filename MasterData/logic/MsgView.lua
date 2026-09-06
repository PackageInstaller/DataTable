-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/gm/view/MsgView.lua

module("logic.extensions.gm.view.MsgView", package.seeall)

local MsgView = class("MsgView", ViewComponent)
local json = require("cjson")

function MsgView:ctor()
	self.lastMsgList = {}
	self.rcdMsgList = {}
	self._lastMsgId = 0
	self.lastMsgIdList = {}
	self.rcdMsgIdList = {}
end

function MsgView:bindEvents()
	GameUtil.asBtn(self.btnStart):AddClickListener(self.onClickStart, self)
	GameUtil.asBtn(self.btnStop):AddClickListener(self.onClickStop, self)
	GameUtil.asBtn(self.btnClear):AddClickListener(self.onClickClear, self)
	GameUtil.asBtn(self.btnMsg):AddClickListener(self.onClickMsg, self)
	GameUtil.addClickHandler(self.btnSiftError, self.onClickSiftError, self)
	GameUtil.addClickHandler(self._BtnExpend, self.onClickExpend, self)
	self._clgText:AddOnValueChanged(self._onValueChanged, self)
	settimer(0, self.showMsg2, self)
end

function MsgView:unbindEvents()
	GameUtil.asBtn(self.btnStart):RemoveClickListener()
	GameUtil.asBtn(self.btnStop):RemoveClickListener()
	GameUtil.asBtn(self.btnClear):RemoveClickListener()
	GameUtil.asBtn(self.btnMsg):RemoveClickListener()
	GameUtil.rmClickHandler(self.btnSiftError)
	GameUtil.rmClickHandler(self._BtnExpend)
	self._clgText:RemoveOnValueChanged()
	removetimer(self.showMsg2, self)
end

function MsgView:buildUI()
	self.container = self:getGo("Right/gm/MsgScroll")
	self.btnStart = self:getGo("Right/gm/MsgScroll/BtnStart")
	self.btnStop = self:getGo("Right/gm/MsgScroll/BtnStop")
	self.btnClear = self:getGo("Right/gm/MsgScroll/BtnClear")
	self.btnMsg = self:getGo("Right/gm/MsgScroll/BtnMsg")
	self.btnSiftError = self:getGo("Right/gm/MsgScroll/BtnSiftError")
	self._BtnExpend = self:getGo("Right/gm/MsgScroll/BtnExpend")
	self.txtState = self:getTxt("Right/gm/MsgScroll/txtState")
	self._clgText = self:getInput("Right/gm/MsgScroll/ClgInput/Input")
	self._curViewDatas = {}
	self._curViewSizes = {}
	self._tableview = self:getGo("Right/gm/MsgScroll/ScrollView"):GetComponent("UITableview")
	self._tableCell = self:getGo("Right/gm/MsgScroll/Cell")
	self._tabCon = self:getGo("Right/gm/MsgScroll/ScrollView/Viewport/Content")

	GameUtil.SetActive(self._tableCell, false)

	self._txtMsg = self:getTxt("Right/gm/MsgScroll/Cell/txtMsg")

	self._tableview:RegisterCallback(self._numInView, self._cellSize, self._cellAtIndex, self)
	self._tableview:RegisterUpdateCellCallback(self._onCellUpdate)
	self._tableview:RegisterReloadFinishCallback(self._onReloadFinish)
	GMController.instance:getIsRecMsg()
end

function MsgView:_onValueChanged()
	self:_updateSiftError(false)
end

function MsgView:_numInView()
	return #self._curViewDatas
end

function MsgView:_cellSize(view, id)
	return 0, self._curViewDatas[id + 1].height
end

function MsgView:_cellAtIndex(view, idx)
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self._tableCell)

	local data = self._curViewDatas[idx + 1]

	cell.data = idx + 1
	cell.index = idx

	self:_updateCell(view, cell, data)

	return cell
end

function MsgView:_onCellUpdate(view, cell)
	local idx = cell.index
	local data = self._curViewDatas[idx + 1]

	cell.data = idx + 1

	self:_updateCell(view, cell, data)
end

function MsgView:_updateCell(view, cell, data)
	local txt = goutil.findChildTextComponent(cell, "txtMsg")
	local btn = GameUtil.asBtn(goutil.findChild(cell, "BtnStart"))
	local repGo = goutil.findChild(cell, "BtnRep")
	local btnSave = GameUtil.asBtn(goutil.findChild(cell, "BtnSave"))
	local btnRep = GameUtil.asBtn(repGo)

	btn:RemoveClickListener()
	btn:AddClickListener(function()
		GMController.instance:copyToClipBoard(data.msg)
	end)
	GameUtil.SetActive(repGo, GMController.instance:hasRep(data))
	btnRep:RemoveClickListener()
	btnRep:AddClickListener(function()
		GMController.instance:replayMsg(data)
	end)
	GameUtil.SetActive(btnSave.gameObject, GMController.instance:hasRep(data))
	btnSave:RemoveClickListener()
	btnSave:AddClickListener(function()
		GMController.instance:saveMsg(data)
	end)

	local len = string.len(data.str)

	txt.text = data.str

	local h = txt.preferredHeight

	GameUtil.setHeight(txt, h)

	self._curViewSizes[cell.data] = {
		0,
		h
	}
end

function MsgView:_onReloadFinish()
	self._tableview:Refresh()

	local ox = self._tableview:GetCellSize(#self._curViewDatas - 1)
	local ofsy = self._tableview:GetMaxOffset()

	self._tableview:SetOffset(ofsy - math.max(0, ox - 620), false)
end

function MsgView:reloadData()
	self._tableview:ReloadData()
end

function MsgView:destroyUI()
	return
end

function MsgView:onEnter()
	self:setBtnState()

	self._isExpendMsg = false

	GameUtil.setUIGroupIdx(self._BtnExpend, self._isExpendMsg and 1 or 0)

	self._isSiftError = false

	self:_updateSiftError(self._isSiftError)
	self:showMsg()
	GlobalDispatcher:addListener(GMModel.Notify.GMCONTROLLER_DUMP_MSG, self.dealMsg, self)
	GlobalDispatcher:addListener(GMModel.Notify.MSGVIEW_CLICK_SHOW, self.onClickMsg, self)
	GlobalDispatcher:addListener(GMModel.Notify.MSGVIEW_CLICK_ERROR_TIPS, self.onClickErrorTips, self)
end

function MsgView:onEnterFinished()
	return
end

function MsgView:onExit()
	GlobalDispatcher:removeListener(GMModel.Notify.GMCONTROLLER_DUMP_MSG, self.dealMsg, self)
	GlobalDispatcher:removeListener(GMModel.Notify.MSGVIEW_CLICK_SHOW, self.onClickMsg, self)
	GlobalDispatcher:removeListener(GMModel.Notify.MSGVIEW_CLICK_ERROR_TIPS, self.onClickErrorTips, self)
end

function MsgView:onExitFinished()
	return
end

function MsgView:dealMsg()
	local lastId = self._lastMsgId
	local msgList = GMController.instance:getAllMsg()

	for i = self._lastMsgId + 1, #msgList do
		lastId = lastId + 1

		table.insert(self.lastMsgList, msgList[i])
	end

	self._lastMsgId = lastId
end

function MsgView:setBtnState()
	GameUtil.SetActive(self.btnStart, not GMController.instance.isRecMsg)
	GameUtil.SetActive(self.btnStop, GMController.instance.isRecMsg)

	self.txtState.text = GMController.instance.isRecMsg and "状态: " .. "<color=#00ff00>●</color>" or "状态: " .. "<color=#ff0000>✖</color>"
end

function MsgView:hide()
	GameUtil.SetActive(self.container, false)
	self:_updateSiftError(false)
end

function MsgView:show()
	GameUtil.SetActive(self.container, true)
	self:showMsg()
end

function MsgView:showMsg2()
	if self.lastMsgList and #self.lastMsgList > 0 then
		local obj = table.remove(self.lastMsgList, 1)

		self._txtMsg.text = obj.str
		obj.height = self._txtMsg.preferredHeight

		table.insert(self.rcdMsgList, obj)
		self:showMsg()
	end
end

function MsgView:showMsg()
	if self.container.activeSelf then
		local str = self._clgText:GetText()
		local filterArr = string.split(str, ",")
		local list = self.rcdMsgList

		self._curViewDatas = {}

		for i = 1, #list do
			local obj = list[i]
			local isFitInput = false

			if filterArr ~= nil and #filterArr > 0 and filterArr[1] ~= "" then
				if table.indexof(filterArr, obj.key) then
					isFitInput = true
				elseif table.indexof(filterArr, obj.key:gsub("_", "-")) then
					isFitInput = true
				else
					local strArr = string.split(obj.key, "_")

					if strArr and strArr[1] == filterArr[1] then
						isFitInput = true
					end
				end
			else
				isFitInput = true
			end

			local isFitError = false

			if self._isSiftError then
				if obj.statusType == GMController.StatusType.Error then
					isFitError = true

					for j = i - 1, 1, -1 do
						local temp = list[j]

						if temp and temp.useType == GMController.MsgUseType.Request and temp.key == obj.key then
							table.insert(self._curViewDatas, temp)

							break
						end
					end
				end
			else
				isFitError = true
			end

			if isFitInput and isFitError then
				if self._isExpendMsg then
					table.insert(self._curViewDatas, obj)
				elseif obj.idx == 1 then
					table.insert(self._curViewDatas, obj)
				elseif obj.idx == 2 then
					local tem = clone(obj)

					tem.str = "\t<color=#00FFFF>还有更多信息 ......</color>\n------"
					tem.height = 60

					table.insert(self._curViewDatas, tem)
				end
			end
		end

		self._tableview:ReloadData()
	end
end

function MsgView:onClickStart()
	GMController.instance:setIsRecMsg(true)
	self:setBtnState()
end

function MsgView:onClickStop()
	GMController.instance:setIsRecMsg(false)
	self:setBtnState()
end

function MsgView:onClickClear()
	self.lastMsgList = {}
	self.rcdMsgList = {}

	GMController.instance:clearMsg()

	self._lastMsgId = 0

	self:showMsg()
end

function MsgView:onClickMsg()
	self:_updateMsgViewShow(not self.container.activeSelf)
end

function MsgView:onClickErrorTips()
	local isNeedShow = not self.container.activeSelf

	self:_updateMsgViewShow(isNeedShow)
	self:_updateSiftError(isNeedShow)
end

function MsgView:onClickSiftError()
	self:_updateSiftError(not self._isSiftError)
end

function MsgView:onClickExpend()
	self:_updateSiftExpend(not self._isExpendMsg)
end

function MsgView:_updateSiftExpend(isExpendMsg)
	self._isExpendMsg = isExpendMsg

	GameUtil.setUIGroupIdx(self._BtnExpend, self._isExpendMsg and 1 or 0)
	self:showMsg()
end

function MsgView:_updateMsgViewShow(isNeedShow)
	if isNeedShow then
		self:show()
	else
		self:hide()
	end
end

function MsgView:_updateSiftError(isSiftError)
	self._isSiftError = isSiftError

	GameUtil.setUIGroupIdx(self.btnSiftError, self._isSiftError and 1 or 0)
	self:showMsg()
end

return MsgView
