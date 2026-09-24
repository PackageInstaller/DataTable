-- chunkname: @modules/logic/matchgame/outside/character/MatchGameTalentNodeListItem.lua

module("modules.logic.matchgame.outside.character.MatchGameTalentNodeListItem", package.seeall)

local MatchGameTalentNodeListItem = class("MatchGameTalentNodeListItem", SimpleListItem)

function MatchGameTalentNodeListItem:onInit(viewGO)
	self._goLock = gohelper.findChild(self.viewGO, "go_Lock")
	self._txtName1 = gohelper.findChildText(self.viewGO, "go_Lock/txt_Name")
	self._imageIcon1 = gohelper.findChildSingleImage(self.viewGO, "go_Lock/image_Icon")
	self._goUnlock = gohelper.findChild(self.viewGO, "go_Unlock")
	self._txtName2 = gohelper.findChildText(self.viewGO, "go_Unlock/NameBg/txt_Name")
	self._imageIcon2 = gohelper.findChildSingleImage(self.viewGO, "go_Unlock/image_Icon")
	self._goActive = gohelper.findChild(self.viewGO, "go_Active")
	self._imageBg3 = gohelper.findChildSingleImage(self.viewGO, "go_Active")
	self._txtName3 = gohelper.findChildText(self.viewGO, "go_Active/NameBg/txt_Name")
	self._imageIcon3 = gohelper.findChildSingleImage(self.viewGO, "go_Active/image_Icon")
	self._goSelect = gohelper.findChild(self.viewGO, "go_Select")
	self._goCost = gohelper.findChild(self.viewGO, "go_Cost")
	self._goEffect_Unlock = gohelper.findChild(self.viewGO, "go_UIEff_Unlock")
	self._goEffect_Unlockable = gohelper.findChild(self.viewGO, "go_UIEff_Unlockable")
	self._goEff_Activate = gohelper.findChild(self.viewGO, "go_UIEff_Activate")
	self._costComp = MatchGameCostComp.Get(self._goCost)

	self._costComp:setTitleVisible(false)
	gohelper.setActive(self._goEffect_Unlock, false)
	gohelper.setActive(self._goEff_Activate, false)
end

function MatchGameTalentNodeListItem:onItemShow(data)
	self._preNodeId = self._nodeId
	self._preStatus = self._status
	self._nodeCo = data
	self._nodeId = self._nodeCo.nodeId

	local name = self._nodeCo.name

	self._txtName1.text = name
	self._txtName2.text = name
	self._txtName3.text = name

	local icon = self._nodeCo.icon
	local iconUrl = ResUrl.getMatchGameSingleBg(icon, "talent")

	self._imageIcon1:LoadImage(iconUrl)
	self._imageIcon2:LoadImage(iconUrl)
	self._imageIcon3:LoadImage(iconUrl)

	local branchCo = lua_activity244_talent_branch.configDict[self._nodeCo.branch]

	if branchCo then
		if not branchCo.nodeBg then
			local bg = ""
			local bgUrl = ResUrl.getMatchGameSingleBg(bg, "talent")

			self._imageBg3:LoadImage(bgUrl)
			self:refreshUI()
		end
	end
end

function MatchGameTalentNodeListItem:refreshUI()
	self:refreshCost()
	self:refreshStatus()
	self:setPosition()
end

function MatchGameTalentNodeListItem:refreshCost()
	local costList = MatchGameConfig.instance:getTalentNodeCost(self._nodeId)

	self._costComp:onUpdateMO(costList)

	self._isItemEnough = MatchGameModel.instance:isItemEnough(costList)
end

function MatchGameTalentNodeListItem:refreshStatus()
	self._status = MatchGameModel.instance:getTalentNodeStatus(self._nodeId)
	self._isUnlock = self._status == MatchGameEnum.TalentNodeStatus.Unlock

	gohelper.setActive(self._goEffect_Unlock, false)
	gohelper.setActive(self._goEff_Activate, false)
	gohelper.setActive(self._goEffect_Unlockable, self._isUnlock and self._isItemEnough)
	gohelper.setActive(self._goLock, self._status == MatchGameEnum.TalentNodeStatus.Lock)
	gohelper.setActive(self._goUnlock, self._status == MatchGameEnum.TalentNodeStatus.Unlock)
	gohelper.setActive(self._goActive, self._status == MatchGameEnum.TalentNodeStatus.Active)
	gohelper.setActive(self._goCost, self._status ~= MatchGameEnum.TalentNodeStatus.Active)
end

function MatchGameTalentNodeListItem:playActiveEffect()
	gohelper.setActive(self._goUnlock, false)
	gohelper.setActive(self._goCost, false)
	gohelper.setActive(self._goActive, true)
	gohelper.setActive(self._goEff_Activate, true)
	AudioMgr.instance:trigger(MatchGameAudioEnum.ActiveTalent)
end

function MatchGameTalentNodeListItem:playUnlockEffect()
	gohelper.setActive(self._goLock, false)
	gohelper.setActive(self._goUnlock, true)
	gohelper.setActive(self._goEffect_Unlock, true)
end

function MatchGameTalentNodeListItem:onSelectChange(isSelect)
	gohelper.setActive(self._goSelect, isSelect)
end

function MatchGameTalentNodeListItem:setPosition()
	local isEven = self.itemIndex % 2 == 0
	local posX = (self.itemIndex - 1) * MatchGameEnum.TalentNodeSpaceWidth + MatchGameEnum.TalentNodeStartSpace

	if isEven then
		if not MatchGameEnum.TalentNodePosY_Even then
			local posY = MatchGameEnum.TalentNodePosY_Odd

			self._posX = posX
			self._posY = posY

			recthelper.setAnchor(self.transform, posX, posY)
		end
	end
end

function MatchGameTalentNodeListItem:getPosition()
	return self._posX, self._posY
end

function MatchGameTalentNodeListItem:onDestroy()
	self._imageIcon1:UnLoadImage()
	self._imageIcon2:UnLoadImage()
	self._imageIcon3:UnLoadImage()
	self._imageBg3:UnLoadImage()
end

return MatchGameTalentNodeListItem
