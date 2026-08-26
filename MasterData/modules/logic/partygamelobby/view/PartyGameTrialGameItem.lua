-- chunkname: @modules/logic/partygamelobby/view/PartyGameTrialGameItem.lua

module("modules.logic.partygamelobby.view.PartyGameTrialGameItem", package.seeall)

local PartyGameTrialGameItem = class("PartyGameTrialGameItem", ListScrollCellExtend)

function PartyGameTrialGameItem:onInitView()
	self._simagelevel = gohelper.findChildSingleImage(self.viewGO, "has/#simage_level")
	self._txtname = gohelper.findChildText(self.viewGO, "has/#txt_name")
	self._goselect = gohelper.findChild(self.viewGO, "has/#go_select")
	self._txtnum = gohelper.findChildText(self.viewGO, "has/#go_select/#txt_num")
	self._txtindex = gohelper.findChildText(self.viewGO, "index/#txt_index")
	self._btnclickarea = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_clickarea")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function PartyGameTrialGameItem:addEvents()
	self._btnclickarea:AddClickListener(self._btnclickareaOnClick, self)
end

function PartyGameTrialGameItem:removeEvents()
	self._btnclickarea:RemoveClickListener()
end

function PartyGameTrialGameItem:_btnclickareaOnClick()
	return
end

function PartyGameTrialGameItem:_editableInitView()
	self._goIndex = gohelper.findChild(self.viewGO, "index")
	self._goEmpty = gohelper.findChild(self.viewGO, "empty")
	self._goHas = gohelper.findChild(self.viewGO, "has")
	self._goVxRefresh = gohelper.findChild(self.viewGO, "vx_refresh")
	self._goAnim = self.viewGO:GetComponent(gohelper.Type_Animator)

	gohelper.setActive(self._goVxRefresh, false)
	gohelper.setActive(self._goselect, false)
	gohelper.setActive(self._goIndex, false)
end

function PartyGameTrialGameItem:_editableAddEvents()
	return
end

function PartyGameTrialGameItem:_editableRemoveEvents()
	return
end

function PartyGameTrialGameItem:UpdateGameInfo(gameCo)
	if gameCo == nil then
		return
	end

	self.gameId = gameCo.id
	self._txtname.text = gameCo.name

	self._simagelevel:LoadImage(ResUrl.getPartyTrialPlayPath(self.gameId))
end

function PartyGameTrialGameItem:refreshSelectState()
	return
end

function PartyGameTrialGameItem:onDestroyView()
	return
end

return PartyGameTrialGameItem
