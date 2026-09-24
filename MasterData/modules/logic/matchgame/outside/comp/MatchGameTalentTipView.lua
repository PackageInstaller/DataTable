-- chunkname: @modules/logic/matchgame/outside/comp/MatchGameTalentTipView.lua

module("modules.logic.matchgame.outside.comp.MatchGameTalentTipView", package.seeall)

local MatchGameTalentTipView = class("MatchGameTalentTipView", BaseView)

function MatchGameTalentTipView:onInitView()
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Close")
	self._goRoot = gohelper.findChild(self.viewGO, "#go_Root")
	self._scrollList = gohelper.findChildScrollRect(self.viewGO, "#go_Root/#scroll_List")
	self._goContent = gohelper.findChild(self.viewGO, "#go_Root/#scroll_List/Viewport/Content")
	self._goDescItem = gohelper.findChild(self.viewGO, "#go_Root/#scroll_List/Viewport/Content/#go_DescItem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MatchGameTalentTipView:addEvents()
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
end

function MatchGameTalentTipView:removeEvents()
	self._btnClose:RemoveClickListener()
end

function MatchGameTalentTipView:_btnCloseOnClick()
	self:closeThis()
end

function MatchGameTalentTipView:_editableInitView()
	self._tranRoot = self._goRoot.transform
	self._tranScroll = self._scrollList.transform
	self._tranContent = self._goContent.transform

	NavigateMgr.instance:addEscape(self.viewName, self.closeThis, self)
end

function MatchGameTalentTipView:onUpdateParam()
	return
end

function MatchGameTalentTipView:onOpen()
	self:refreshUI()
	self:updateHeight()
	self:updatePosition()
end

function MatchGameTalentTipView:refreshUI()
	if self.viewParam then
		local talentIdList = self.viewParam.talentIdList
		local hasTalent = talentIdList and #talentIdList > 0

		if not hasTalent then
			return
		end

		gohelper.CreateObjList(self, self._refreshTalentDescItem, talentIdList, self._goContent, self._goDescItem)
	end
end

function MatchGameTalentTipView:_refreshTalentDescItem(goDescItem, talentId, index)
	local txtDesc = gohelper.findChildText(goDescItem, "txt_Desc")
	local talentCo = lua_activity244_talent.configDict[talentId]

	SkillHelper.addHyperLinkClick(txtDesc)

	if talentCo then
		if not talentCo.desc then
			local desc = ""
			local totalDesc = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("matchgametalenttipview_index"), index, desc)

			txtDesc.text = SkillHelper.buildDesc(totalDesc)
		end
	end
end

function MatchGameTalentTipView:updatePosition()
	if self.viewParam then
		local screenPos = self.viewParam.screenPos

		if not screenPos then
			return
		end

		local posX, posY = recthelper.screenPosToAnchorPos2(screenPos, self._tranRoot)

		recthelper.setAnchor(self._tranScroll, posX, posY)
	end
end

function MatchGameTalentTipView:updateHeight()
	ZProj.UGUIHelper.RebuildLayout(self._tranContent)

	local contentHeight = recthelper.getHeight(self._tranContent)
	local scrollHeight = Mathf.Clamp(contentHeight, MatchGameEnum.TalentTipsHeight_Min, MatchGameEnum.TalentTipsHeight_Max)

	recthelper.setHeight(self._tranScroll, scrollHeight)
end

function MatchGameTalentTipView:onClose()
	return
end

function MatchGameTalentTipView:onDestroyView()
	return
end

return MatchGameTalentTipView
