-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingisaacclg/view/KingIsaacClgExView.lua

module("logic.extensions.kingisaacclg.view.KingIsaacClgExView", package.seeall)

local KingIsaacClgExView = class("KingIsaacClgExView", ViewComponent)

function KingIsaacClgExView:ctor()
	KingIsaacClgExView.super.ctor(self)
end

function KingIsaacClgExView:buildUI()
	KingIsaacClgExView.super.buildUI(self)

	self._tagView = goutil.findChild(self.mainGO, "tagView")
end

function KingIsaacClgExView:bindEvents()
	KingIsaacClgExView.super.bindEvents(self)
end

function KingIsaacClgExView:unbindEvents()
	KingIsaacClgExView.super.unbindEvents(self)
end

function KingIsaacClgExView:destroyUI()
	KingIsaacClgExView.super.destroyUI(self)
end

function KingIsaacClgExView:onEnter()
	KingIsaacClgExView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._customFmtMo = params[1]
	self._templatePosList = self._customFmtMo:getTemplatePosList()

	self.addGEvent(self, GlobalNotify.RefreshEnemyFmt, self._onUpdate, self)
	self:_onUpdate()
end

function KingIsaacClgExView:onExit()
	KingIsaacClgExView.super.onExit(self)
end

function KingIsaacClgExView:_onUpdate()
	local rightFormation = self._customFmtMo:getCurRightFormation()
	local positions = rightFormation:GetPositions()
	local parentTran = self._tagView.transform

	for idx = 0, parentTran.childCount - 1 do
		local mainGo = parentTran:GetChild(idx).gameObject
		local img = goutil.findChild(mainGo, "img")
		local posId = idx + 1
		local isClone = table.indexof(self._templatePosList, posId) ~= false

		GameUtil.SetActive(mainGo, isClone)

		if isClone then
			local isHavePet = positions[posId] > 0

			GameUtil.SetActive(img, not isHavePet)
		end
	end
end

return KingIsaacClgExView
