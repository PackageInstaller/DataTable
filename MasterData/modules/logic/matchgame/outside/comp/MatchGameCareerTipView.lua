-- chunkname: @modules/logic/matchgame/outside/comp/MatchGameCareerTipView.lua

module("modules.logic.matchgame.outside.comp.MatchGameCareerTipView", package.seeall)

local MatchGameCareerTipView = class("MatchGameCareerTipView", BaseView)

function MatchGameCareerTipView:onInitView()
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Close")
	self._goRoot = gohelper.findChild(self.viewGO, "#go_Root")
	self._goContainer = gohelper.findChild(self.viewGO, "#go_Root/#go_Container")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MatchGameCareerTipView:addEvents()
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
end

function MatchGameCareerTipView:removeEvents()
	self._btnClose:RemoveClickListener()
end

function MatchGameCareerTipView:_btnCloseOnClick()
	self:closeThis()
end

function MatchGameCareerTipView:_editableInitView()
	self._tranView = self.viewGO.transform
	self._tranRoot = self._goRoot.transform
	self._tranContainer = self._goContainer.transform

	NavigateMgr.instance:addEscape(self.viewName, self.closeThis, self)
end

function MatchGameCareerTipView:onUpdateParam()
	return
end

function MatchGameCareerTipView:onOpen()
	self:refreshUI()
	self:updatePosition()
end

function MatchGameCareerTipView:refreshUI()
	local childCount = self._tranContainer.childCount

	for i = 1, childCount do
		local child = self._tranContainer:GetChild(i - 1)

		if child then
			local elementId = string.match(child.name, "%d+")

			elementId = tonumber(elementId)

			local elementCo = lua_activity244_element.configDict[elementId]

			if elementCo then
				local imageIcon = gohelper.findChildImage(child.gameObject, "image_Icon")
				local txtName = gohelper.findChildText(child.gameObject, "txt_Name")

				MatchGameHelper.setCharacterElement(elementId, imageIcon, txtName)
			else
				logError(string.format("三消灵感配置不存在 elementId = %s, rootName = %s", elementId, child.gameObject.name))
			end
		end
	end
end

function MatchGameCareerTipView:updatePosition()
	if self.viewParam then
		local screenPos = self.viewParam.screenPos

		if not screenPos then
			return
		end

		local posX, posY = recthelper.screenPosToAnchorPos2(screenPos, self._tranView)

		recthelper.setAnchor(self._tranRoot, posX, posY)
	end
end

function MatchGameCareerTipView:onClose()
	return
end

function MatchGameCareerTipView:onDestroyView()
	return
end

return MatchGameCareerTipView
