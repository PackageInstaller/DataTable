-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pigraise/view/PigraiseprizeView.lua

module("logic.extensions.pigraise.view.PigraiseprizeView", package.seeall)

local PigraiseprizeView = class("PigraiseprizeView", ViewComponent)

function PigraiseprizeView:ctor()
	PigraiseprizeView.super.ctor(self)
end

function PigraiseprizeView:buildUI()
	PigraiseprizeView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._tableGo = self:getGo("tableview")
	self._itemGo = self:getGo("tablecell")
	self._tableview = ScrollerList.create(self._tableGo, self._itemGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function PigraiseprizeView:bindEvents()
	PigraiseprizeView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
end

function PigraiseprizeView:unbindEvents()
	PigraiseprizeView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function PigraiseprizeView:destroyUI()
	PigraiseprizeView.super.destroyUI(self)
end

function PigraiseprizeView:onEnter()
	PigraiseprizeView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.PigRaiseStateUpdate, self._refreshList, self)
	self:_refreshList()
end

function PigraiseprizeView:onEnterFinished()
	PigraiseprizeView.super.onEnterFinished(self)
end

function PigraiseprizeView:onExit()
	PigraiseprizeView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.PigRaiseStateUpdate, self._refreshList, self)
	self._tableview:dispose()
end

function PigraiseprizeView:onExitFinished()
	PigraiseprizeView.super.onExitFinished(self)
end

function PigraiseprizeView:_refreshList()
	local dataList = PigraiseModel.instance:getPrizeDatas()

	if dataList == nil or #dataList == 0 then
		self._tableview:regGetDataLen(function()
			return 0
		end)
	else
		self._tableview:regGetDataLen(function()
			return math.max(#dataList, 20)
		end)
	end

	self._tableview:reloadData(dataList)
end

function PigraiseprizeView:_updateCell(view, cell, data)
	local btnReceive = goutil.findChild(cell, "state/btnReceive")
	local txtNotFinish = goutil.findChild(cell, "state/txtNotFinish")
	local txtReceived = goutil.findChild(cell, "state/txtReceived")

	GameUtil.rmClickHandler(btnReceive)

	local txtDes = goutil.findChildTextComponent(cell, "imgDes/txt")

	if data then
		txtDes.text = string.format("亲密度达到%s级", data.id)

		local cfg = PigraiseConfig.instance:getLevelCfgById(PigraiseModel.instance:getDefineId(), data.id)

		if data.id <= PigraiseModel.instance:getCurLevel() then
			goutil.setActive(txtNotFinish.gameObject, false)

			if data.isGetPrize then
				goutil.setActive(txtReceived.gameObject, true)
				goutil.setActive(btnReceive.gameObject, false)
			else
				goutil.setActive(txtReceived.gameObject, false)
				goutil.setActive(btnReceive.gameObject, true)
				GameUtil.addClickHandler(btnReceive, GameUtil.handler(self._onGainLvPrize, self, data))
			end
		else
			goutil.setActive(txtReceived.gameObject, false)
			goutil.setActive(btnReceive.gameObject, false)
			goutil.setActive(txtNotFinish.gameObject, true)
		end

		self:_updateCellPirzes(cell, cfg.upgradePrize)
	else
		self:_updateCellPirzes(cell)
	end
end

function PigraiseprizeView:_clearCell(cell)
	self:_updateCellPirzes(cell)

	local btnReceive = goutil.findChild(cell, "state/btnReceive")

	GameUtil.rmClickHandler(btnReceive)
end

function PigraiseprizeView:_updateCellPirzes(cell, prizeStr)
	local str = prizeStr or ""
	local t = string.split(str, "#")
	local items = {}

	for i = 1, 4 do
		items[i] = goutil.findChild(cell, "items/" .. i)

		MaterialMgr.resetAll(items[i])

		if t then
			goutil.setActive(items[i], i <= #t)

			if i <= #t then
				MaterialMgr.setCellByCfg(t[i], items[i])
			end
		else
			goutil.setActive(items[i], false)
		end
	end
end

function PigraiseprizeView:_onGainLvPrize(data)
	PigraiseController.instance:gainIntimacyPrizeReq(data.id)
end

return PigraiseprizeView
