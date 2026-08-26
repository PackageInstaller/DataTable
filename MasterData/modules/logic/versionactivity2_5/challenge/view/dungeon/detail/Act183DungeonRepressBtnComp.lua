-- chunkname: @modules/logic/versionactivity2_5/challenge/view/dungeon/detail/Act183DungeonRepressBtnComp.lua

module("modules.logic.versionactivity2_5.challenge.view.dungeon.detail.Act183DungeonRepressBtnComp", package.seeall)

local Act183DungeonRepressBtnComp = class("Act183DungeonRepressBtnComp", Act183DungeonBaseComp)
local HasRepress_RepressBtnTxtPosX = 25
local NotRepress_RepressBtnTxtPosX = 0

function Act183DungeonRepressBtnComp:init(go)
	Act183DungeonRepressBtnComp.super.init(self, go)

	self._btnrepress = gohelper.getClickWithDefaultAudio(self.go)
	self._txtbtnrepress = gohelper.findChildText(self.go, "txt_Cn")
	self._gosetrepresshero = gohelper.findChild(self.go, "#go_setrepresshero")
	self._simagerepressheroicon = gohelper.findChildSingleImage(self.go, "#go_setrepresshero/#simage_repressheroicon")
	self._imagecareer = gohelper.findChildImage(self.go, "#go_setrepresshero/#image_Career")
end

function Act183DungeonRepressBtnComp:addEventListeners()
	self.addEventCb(self, Act183Controller.instance, Act183Event.OnUpdateBadgeDetailVisible, self._onUpdateBadgeDetailVisible, self)
	self._btnrepress:AddClickListener(self._btnrepressOnClick, self)
end

function Act183DungeonRepressBtnComp:removeEventListeners()
	self._btnrepress:RemoveClickListener()
end

function Act183DungeonRepressBtnComp:_btnrepressOnClick()
	local params = {
		activityId = self._activityId,
		episodeMo = self._episodeMo
	}

	Act183Controller.instance:openAct183RepressView(params)
end

function Act183DungeonRepressBtnComp:updateInfo(episodeMo)
	Act183DungeonRepressBtnComp.super.updateInfo(self, episodeMo)

	self._isCanReRepress = self._groupEpisodeMo:isEpisodeCanReRepress(self._episodeId)
end

function Act183DungeonRepressBtnComp:checkIsVisible()
	return self._isCanReRepress
end

function Act183DungeonRepressBtnComp:show()
	Act183DungeonRepressBtnComp.super.show(self)

	local repressHeroMo = self._episodeMo:getRepressHeroMo()
	local hasRepress = repressHeroMo ~= nil

	gohelper.setActive(self._gosetrepresshero, hasRepress)

	if hasRepress then
		if not HasRepress_RepressBtnTxtPosX then
			local repressTxtPosX = NotRepress_RepressBtnTxtPosX

			recthelper.setAnchorX(self._txtbtnrepress.transform, repressTxtPosX)

			if not hasRepress then
				return
			end

			local iconUrl = repressHeroMo:getHeroIconUrl()

			self._simagerepressheroicon:LoadImage(iconUrl)

			local career = repressHeroMo:getHeroCarrer()

			UISpriteSetMgr.instance:setCommonSprite(self._imagecareer, "lssx_" .. tostring(career))
		end
	end
end

function Act183DungeonRepressBtnComp:_onUpdateBadgeDetailVisible(isVisible)
	local isRepressBtnVisible = self:checkIsVisible()

	if isRepressBtnVisible then
		gohelper.setActive(self.go, not isVisible)
	end
end

function Act183DungeonRepressBtnComp:onDestroy()
	self._simagerepressheroicon:UnLoadImage()
	Act183DungeonRepressBtnComp.super.onDestroy(self)
end

return Act183DungeonRepressBtnComp
