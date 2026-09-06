-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/elementspark/view/ElementSparkOccupiedEffectView.lua

module("logic.extensions.elementspark.view.ElementSparkOccupiedEffectView", package.seeall)

local ElementSparkOccupiedEffectView = class("ElementSparkOccupiedEffectView", ViewComponent)

function ElementSparkOccupiedEffectView:ctor()
	ElementSparkOccupiedEffectView.super.ctor(self)
end

function ElementSparkOccupiedEffectView:unbindEvents()
	ElementSparkOccupiedEffectView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function ElementSparkOccupiedEffectView:bindEvents()
	ElementSparkOccupiedEffectView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function ElementSparkOccupiedEffectView:buildUI()
	ElementSparkOccupiedEffectView.super.buildUI(self)

	self._txtOccupiedList = {}

	for i = 1, 5 do
		local txt = self:getTxt("occupied/txtOccupiedDesc_" .. i)

		table.insert(self._txtOccupiedList, txt)
	end

	self._txtCampScoreRate = self:getTxt("effect/txtCampScoreRate")
	self._txtPersonScoreRate = self:getTxt("effect/txtPersonScoreRate")
	self._txtPetShopScore = self:getTxt("effect/txtPetShopScore")
	self._txtCampScore = self:getTxt("effect/txtCampScore")
	self._txtPersonScore = self:getTxt("effect/txtPersonScore")
	self._btnClose = self:getBtn("btnClose")
end

function ElementSparkOccupiedEffectView:onExit()
	ElementSparkOccupiedEffectView.super.onExit(self)
end

function ElementSparkOccupiedEffectView:onEnter()
	ElementSparkOccupiedEffectView.super.onEnter(self)

	local chunkInfoDesc = ElementSparkController.instance:getBelongMeChunkDesc()
	local contentArr = string.split(chunkInfoDesc, "：")
	local detailArr = string.split(contentArr[2], ",")

	for i, txt in ipairs(self._txtOccupiedList) do
		txt.text = detailArr[i]
	end

	local info = ElementSparkModel.instance:getInfo()
	local campInfo = ElementSparkModel.instance:getCampInfo()

	self._txtCampScoreRate.text = checknumber(campInfo.manualCampScoreRate) .. "/分钟"
	self._txtPersonScoreRate.text = checknumber(campInfo.manualPersonScoreRate) .. "/分钟"
	self._txtPetShopScore.text = checknumber(campInfo.manualPetShopScoreRate) .. "/分钟"
	self._txtCampScore.text = checknumber(campInfo.autoCampScoreRate) .. "/分钟"
	self._txtPersonScore.text = checknumber(campInfo.autoPersonScoreRate) .. "/分钟"
end

return ElementSparkOccupiedEffectView
