-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/warriortower/view/WTowerBoxView.lua

module("logic.extensions.warriortower.view.WTowerBoxView", package.seeall)

local WTowerBoxView = class("WTowerBoxView", TableViewComponent)

function WTowerBoxView:ctor()
	WTowerBoxView.super.ctor(self)
end

function WTowerBoxView:_getPath()
	return {
		cellPath = "Top/box",
		viewPath = "Top/grids"
	}
end

function WTowerBoxView:bindEvents()
	return
end

function WTowerBoxView:unbindEvents()
	return
end

function WTowerBoxView:buildUI()
	WTowerBoxView.super.buildUI(self)

	self._prog = goutil.findChildComponent(self._tableview, "Viewport/Content/Prog", "Slider")
end

function WTowerBoxView:destroyUI()
	WTowerBoxView.super.destroyUI(self)
end

function WTowerBoxView:onEnter()
	self._infos = {}
	self._effRotateList = {}

	self:_refreshBoxes()
	WTowerController.instance:registerLocalNotify("RefreshPrize", self._refreshBoxes, self)
	WTowerController.instance:registerLocalNotify(WTowerModel.REFRESH_TOWER_INFO, self._refreshBoxes, self)
	WTowerController.instance:registerLocalNotify(WTowerModel.ReceiveEff, self._effStatus, self)
	GlobalDispatcher:addListener(WTowerModel.ReceiveAuto, self._refreshBoxes, self)
end

function WTowerBoxView:onEnterFinished()
	return
end

function WTowerBoxView:onExit()
	self._infos = nil

	WTowerController.instance:unregisterLocalNotify("RefreshPrize", self._refreshBoxes, self)
	WTowerController.instance:unregisterLocalNotify(WTowerModel.REFRESH_TOWER_INFO, self._refreshBoxes, self)
	WTowerController.instance:unregisterLocalNotify(WTowerModel.ReceiveEff, self._effStatus, self)
	GlobalDispatcher:removeListener(WTowerModel.ReceiveAuto, self._refreshBoxes, self)

	for key, value in pairs(self._effRotateList) do
		UIEffectManager.instance:stopEffect(value)
	end
end

function WTowerBoxView:onExitFinished()
	self._tableview:Travel(function(cell)
		Framework.ButtonAdapter.GetFrom(cell.gameObject, "Box"):RemoveClickListener()
		MaterialMgr.resetAll(cell.gameObject)
	end, nil)
end

function WTowerBoxView:_cellSize()
	return 120, 130
end

function WTowerBoxView:_updateCell(view, cell, data)
	local towerId = checknumber(WTowerModel.instance:getTowerId())

	if data._state == 2 then
		if self._effRotateList[cell] then
			UIEffectManager.instance:stopEffect(self._effRotateList[cell])
		end

		local effResPath = "fx_ui_yongzhezhita/fx_ui_yongzhezhita_xuanzhuan.prefab"

		self._effRotateList[cell] = UIEffectManager.instance:playEffect(self, effResPath, nil, 0, 0, true, false, nil, function(target, eff)
			eff.effGo.transform:SetParent(cell.gameObject.transform)
			GameUtil.setAnchoredPos(eff.effGo, 0, 0)
			GameUtil.setLocalScale(eff.effGo, 0.9, 0.9, 0.9)
			eff:setScrollRectClipping(self:getGo(self:_getPath().viewPath):GetComponent(typeof(UnityEngine.UI.ScrollRect)))
		end)
		self._effRotateList[cell].hideEffWhileNotOnTop = false
	elseif self._effRotateList[cell] then
		UIEffectManager.instance:stopEffect(self._effRotateList[cell])

		self._effRotateList[cell] = nil
	end

	local txt = goutil.findChild(cell.gameObject, "TxtLevel"):GetComponent("Text")

	txt.text = langPara("tip_missionnum", data._level)

	local strs = string.split(data._prizeStr, "#")
	local proxy = MaterialMgr.setCellByCfg(strs[1], goutil.findChild(cell.gameObject, "icon"))

	if proxy then
		proxy.binder:setGray(data._state == 1)
		goutil.setActive(goutil.findChild(cell, "received"), data._state == 1)
	end

	local cellBtn = Framework.ButtonAdapter.GetFrom(cell.gameObject, "Box")

	if data._state == 2 then
		cellBtn:AddClickListener(function()
			UIEffectManager.instance:stopEffect(self._effRotateList[cell])

			self._effRotateList[cell] = nil

			WTowerController.instance:getBoxPrize(towerId)
		end, self)
	end

	goutil.setActive(cellBtn.gameObject, data._state == 2)

	local bgChange = goutil.findChildComponent(cell.gameObject, "BoxbottomBg", "UIImageSpriteChange")

	bgChange:ChangeStateNow(data._state == 2 and 1 or 0)
end

function WTowerBoxView:_refreshBoxes()
	for key, value in pairs(self._effRotateList) do
		UIEffectManager.instance:stopEffect(value)
	end

	self._effRotateList = {}

	local boxInfos = WTowerModel.instance:getBoxInfos(true)

	self._curViewDatas = {}

	for i = #boxInfos, 1, -1 do
		table.insert(self._curViewDatas, boxInfos[i])
	end

	self._tableview:ReloadData()
end

function WTowerBoxView:_onReloadFinish()
	local towerId = checknumber(WTowerModel.instance:getTowerId())
	local boxMaxLen = #WTowerModel.instance:getBoxInfo(towerId)

	self._tableview:MoveCellToCebter(boxMaxLen - WTowerController.instance:getCenterBoxIndex())

	self._prog.value = WTowerModel.instance:getMaxReachLevel(towerId) / (#self._curViewDatas * 5)
end

function WTowerBoxView:_effStatus(flag)
	for key, value in pairs(self._effRotateList) do
		goutil.setActive(value.effGo, flag)
	end
end

return WTowerBoxView
