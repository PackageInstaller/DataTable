-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/monument/MonumentLookoverView.lua

module("logic.extensions.playerinfo.view.monument.MonumentLookoverView", package.seeall)

local M = class("MonumentLookoverView", MonumentMainView)

function M:ctor()
	M.super.ctor(self)
end

function M:onEnter()
	local params = self:getFirstParam()

	if params then
		local index = params.index or 1

		self._moList = params.list

		self:_turnToIndex(index)
		self._monumentItemView:setCanClick(false)
		goutil.setActive(self._btnPreviousPage.gameObject, #self._moList > 1)
		goutil.setActive(self._btnNextPage.gameObject, #self._moList > 1)
	end
end

function M:showMonumentInfo(monumentMo)
	M.super.showMonumentInfo(self, monumentMo)

	local txtGO = self._txtLevel.gameObject

	if monumentMo:getIsNoShow() and not PlayerCourseModel.instance:editPermission() then
		local myMo = MonumentConfig.instance:getMonumentCfgById(monumentMo)

		if not myMo:getIsFinish() then
			goutil.setActive(txtGO, true)

			local tempStr = string.format("（<color=#FFFFFF>%d</color>/%d）", monumentMo:getUpgradeFinishCnt(), monumentMo:getUpgradeMaxCnt())

			self._txtDesc1.text = "???" .. tempStr
			self._txtDesc2.text = "???"
			self._txtLevel.text = ""
		end
	else
		goutil.setActive(txtGO, false)
	end

	self._monumentItemView:deleteRedPoint()
end

return M
