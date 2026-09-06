-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/view/saintknight/WholecardpublicityView.lua

module("logic.extensions.bonus.view.saintknight.WholecardpublicityView", package.seeall)

local WholecardpublicityView = class("WholecardpublicityView", ViewComponent)

function WholecardpublicityView:ctor()
	WholecardpublicityView.super.ctor(self)
end

function WholecardpublicityView:unbindEvents()
	WholecardpublicityView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnGoto)
end

function WholecardpublicityView:bindEvents()
	WholecardpublicityView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnGoto, self._onClickGoto, self)
end

function WholecardpublicityView:buildUI()
	WholecardpublicityView.super.buildUI(self)

	self._monthcardConGo = self:getGo("card/monthcardCon")
	self._resmonthcardCon = self:getGo("card/resmonthcardCon")
	self._item = self:getGo("card/item")
	self._monthcardGroup = ItemGroup.New(self._monthcardConGo, self._item, nil, nil, true)
	self._resmonthcardGroup = ItemGroup.New(self._resmonthcardCon, self._item, nil, nil, true)
	self._btnGoto = self:getBtn("btnGoto")
end

function WholecardpublicityView:onExit()
	WholecardpublicityView.super.onExit(self)
	self._monthcardGroup:dispose(function(item)
		MaterialMgr.resetAll(item)
	end)
	self._resmonthcardGroup:dispose(function(item)
		MaterialMgr.resetAll(item)
	end)
end

function WholecardpublicityView:onEnter()
	WholecardpublicityView.super.onEnter(self)

	self._mothcardCfg = string.split("4:90145:1#104:2:3000#204:2:300#60:1:3600", "#")
	self._resmothcardCfg = string.split("4:36:10#4:112:10#4:90274:12000#4:90275:30", "#")

	self._monthcardGroup:updateWithMoArray(self._mothcardCfg, self._updateCell, self)
	self._resmonthcardGroup:updateWithMoArray(self._resmothcardCfg, self._updateCell, self)
end

function WholecardpublicityView:_updateCell(item, data)
	local itemCon = goutil.findChild(item.mainGO, "itemCon")

	MaterialMgr.setCellByCfg(data, itemCon)
end

function WholecardpublicityView:_onClickGoto()
	GotoMgr.gotoByString("mibao#MonthCard2022")
end

return WholecardpublicityView
