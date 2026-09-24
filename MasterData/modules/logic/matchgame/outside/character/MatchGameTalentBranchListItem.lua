-- chunkname: @modules/logic/matchgame/outside/character/MatchGameTalentBranchListItem.lua

module("modules.logic.matchgame.outside.character.MatchGameTalentBranchListItem", package.seeall)

local MatchGameTalentBranchListItem = class("MatchGameTalentBranchListItem", SimpleListItem)

function MatchGameTalentBranchListItem:onInit(viewGO)
	self._goSelect = gohelper.findChild(self.viewGO, "go_Select")
	self._goUnselect = gohelper.findChild(self.viewGO, "go_Unselect")
	self._imageIcon1 = gohelper.findChildImage(self.viewGO, "go_Select/image_Icon1")
	self._txtName1 = gohelper.findChildText(self.viewGO, "go_Select/txt_Name1")
	self._imageIcon2 = gohelper.findChildImage(self.viewGO, "go_Unselect/image_Icon2")
	self._txtName2 = gohelper.findChildText(self.viewGO, "go_Unselect/txt_Name2")
	self._goRedDot = gohelper.findChild(self.viewGO, "go_RedDot")
end

function MatchGameTalentBranchListItem:onItemShow(data)
	self._config = data.config
	self._branchId = self._config.id
	self._branchType = self._config.type
	self._nodeList = data.nodeList

	if self._config then
		self._txtName1.text = self._config
		self._txtName2.text = self._config

		if self._config then
			UISpriteSetMgr.instance:setMatchGameSprite(self._imageIcon1, self._config, true)
			UISpriteSetMgr.instance:setMatchGameSprite(self._imageIcon2, self._config, true)
			RedDotController.instance:addRedDot(self._goRedDot, RedDotEnum.DotNode.MatchGameTalentCategory, self._branchId)
		end
	end
end

function MatchGameTalentBranchListItem:onSelectChange(isSelect)
	if self._isSelect == isSelect then
		return
	end

	self._isSelect = isSelect

	gohelper.setActive(self._goSelect, isSelect)
	gohelper.setActive(self._goUnselect, not isSelect)

	if self._config and self._isSelect then
		MatchGameController.instance:onClickTalentBranchTab(self._config.id)
	end
end

return MatchGameTalentBranchListItem
