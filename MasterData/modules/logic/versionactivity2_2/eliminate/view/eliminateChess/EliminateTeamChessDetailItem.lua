-- chunkname: @modules/logic/versionactivity2_2/eliminate/view/eliminateChess/EliminateTeamChessDetailItem.lua

module("modules.logic.versionactivity2_2.eliminate.view.eliminateChess.EliminateTeamChessDetailItem", package.seeall)

local EliminateTeamChessDetailItem = class("EliminateTeamChessDetailItem", ListScrollCellExtend)

function EliminateTeamChessDetailItem:onInitView()
	self._imageQuality = gohelper.findChildImage(self.viewGO, "#image_Quality")
	self._goLocked = gohelper.findChild(self.viewGO, "#go_Locked")
	self._goSelected = gohelper.findChild(self.viewGO, "#go_Selected")
	self._simageChess = gohelper.findChildSingleImage(self.viewGO, "ChessMask/#image_Chess")
	self._imageChess = gohelper.findChildImage(self.viewGO, "ChessMask/#image_Chess")
	self._txtFireNum = gohelper.findChildText(self.viewGO, "image_Fire/#txt_FireNum")
	self._goResources = gohelper.findChild(self.viewGO, "#go_Resources")
	self._goResource = gohelper.findChild(self.viewGO, "#go_Resources/#go_Resource")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function EliminateTeamChessDetailItem:addEvents()
	return
end

function EliminateTeamChessDetailItem:removeEvents()
	return
end

local ZProj_UIEffectsCollection = ZProj.UIEffectsCollection

function EliminateTeamChessDetailItem:_editableAddEvents()
	self._goClick = gohelper.getClick(self.viewGO)

	self._goClick:AddClickListener(self.onClick, self)
end

function EliminateTeamChessDetailItem:_editableRemoveEvents()
	if self._goClick then
		self._goClick:RemoveClickListener()
	end
end

function EliminateTeamChessDetailItem:onClick()
	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_activity_open)
	EliminateChessController.instance:dispatchEvent(EliminateChessEvent.ShowChessInfo, self._soliderId)
end

function EliminateTeamChessDetailItem:setSoliderId(id)
	self._soliderId = id

	self:initInfo()
	self:initResource()
	self:refreshView()
end

function EliminateTeamChessDetailItem:refreshView()
	if self._soliderId == nil then
		return
	end

	self:canUse()
	self:setGrayState()
end

function EliminateTeamChessDetailItem:setGrayState()
	if self._effectCollection == nil then
		self._effectCollection = ZProj_UIEffectsCollection.Get(self.viewGO)
	end

	if self._effectCollection then
		self._effectCollection:SetGray(not self._canUse)
	end

	if self.cacheColor == nil then
		self.cacheColor = self._imageChess.color
	end

	self.cacheColor.a = self._canUse and 1 or 0.5
	self._imageChess.color = self.cacheColor
end

function EliminateTeamChessDetailItem:canUse()
	self._canUse = EliminateTeamChessModel.instance:canUseChess(self._soliderId)

	return self._canUse
end

function EliminateTeamChessDetailItem:initInfo()
	local config = EliminateConfig.instance:getSoldierChessConfig(self._soliderId)

	self._txtFireNum.text = config.defaultPower

	if config and not string.nilorempty(config.resPic) then
		SurvivalUnitIconHelper.instance:setNpcIcon(self._simageChess, config.resPic, self._onChessLoaded, self)
	end

	UISpriteSetMgr.instance:setV2a2EliminateSprite(self._imageQuality, EliminateConfig.instance:getSoldierChessQualityImageName(config.level), false)
end

function EliminateTeamChessDetailItem:_onChessLoaded()
	if not self.cacheColor then
		return
	end

	self._imageChess.color = self.cacheColor
end

function EliminateTeamChessDetailItem:initResource()
	self._cost = EliminateConfig.instance:getSoldierChessConfigConst(self._soliderId)

	if not self._cost then
		return
	end

	self._resourceItem = self:getUserDataTb_()

	for _, cost in ipairs(self._cost) do
		local resourceId = cost[1]
		local num = cost[2]
		local item = gohelper.clone(self._goResource, self._goResources, resourceId)
		local resourceImage = gohelper.findChildImage(item, "#image_Quality")
		local resourceNumberText = gohelper.findChildText(item, "#image_Quality/#txt_ResourceNum")

		UISpriteSetMgr.instance:setV2a2EliminateSprite(resourceImage, EliminateTeamChessEnum.ResourceTypeToImagePath[resourceId], false)

		resourceNumberText.text = num

		gohelper.setActive(item, true)

		self._resourceItem[resourceId] = {
			item = item,
			resourceImage = resourceImage,
			resourceNumberText = resourceNumberText
		}
	end
end

function EliminateTeamChessDetailItem:updateInfo()
	return
end

function EliminateTeamChessDetailItem:onDestroyView()
	return
end

return EliminateTeamChessDetailItem
