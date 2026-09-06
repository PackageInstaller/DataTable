-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonDefaultGridShowView.lua

module("logic.extensions.season.view.SeasonDefaultGridShowView", package.seeall)

local SeasonDefaultGridShowView = class("SeasonDefaultGridShowView", SeasonBaseGridShowView)

function SeasonDefaultGridShowView:ctor()
	SeasonDefaultGridShowView.super.ctor(self)
end

function SeasonDefaultGridShowView:unbindEvents()
	SeasonDefaultGridShowView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
end

function SeasonDefaultGridShowView:bindEvents()
	SeasonDefaultGridShowView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
end

function SeasonDefaultGridShowView:buildUI()
	SeasonDefaultGridShowView.super.buildUI(self)

	self._txtDesc = self:getTxt("layout/desc/txtDesc")
	self._prizeGo = self:getGo("layout/resource")
	self._prizeItem = self:getGo("layout/resource/items")

	if self._prizeGo then
		GameUtil.SetActive(self._prizeGo, false)

		self._prizeItemLayout = self._prizeItem:GetComponent(typeof(UnityEngine.UI.LayoutElement))
	end
end

function SeasonDefaultGridShowView:onExit()
	SeasonDefaultGridShowView.super.onExit(self)

	if self._prizeItem then
		MaterialMgr.resetAll(self._prizeItem)
	end
end

function SeasonDefaultGridShowView:onEnter()
	SeasonDefaultGridShowView.super.onEnter(self)

	local params = self:getFirstParam()

	GameUtil.SetActive(self._prizeGo, false)

	if self._prizeItem and not string.nilorempty(params.strPrize) then
		GameUtil.SetActive(self._prizeGo, true)
		MaterialMgr.resetAll(self._prizeItem)
		MaterialMgr.setCellListByCfg(params.strPrize or "", self._prizeItem)

		if self._prizeItemLayout then
			self._prizeItemLayout:CalculateLayoutInputVertical()
		end
	end
end

return SeasonDefaultGridShowView
