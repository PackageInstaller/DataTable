-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/glorybattle/view/GlorybattleTopCell.lua

module("logic.extensions.glorybattle.view.GlorybattleTopCell", package.seeall)

local GlorybattleTopCell = class("GlorybattleTopCell", CustomRightCell)

GlorybattleTopCell.prefabUrl = "ui/views/glorybattle/glorybattletopcell.prefab"

function GlorybattleTopCell:buildUI()
	self._iconGo = goutil.findChild(self.mainGO, "icon")
	self._lwIconGo = goutil.findChild(self.mainGO, "lw/icon")
	self._lwGo = goutil.findChild(self.mainGO, "lw")
	self._limitGo = goutil.findChild(self.mainGO, "limit")
	self._btnTips = Framework.ButtonAdapter.Get(self._lwIconGo)

	self._btnTips:AddClickListener(self._onClickBtnTips, self)
end

function GlorybattleTopCell:checkAndShowIcon(activityId, creepsId)
	self._activityId = activityId
	self._creepsId = creepsId

	local info = GlorybattleModel.instance:getInfo(activityId)
	local isUse = GlorybattleModel.instance:isLastPvpUse(activityId, creepsId)
	local isPetTryCard = creepsId > GlorybattleModel.instance:getPetCardFakePetIdAddNum()
	local holyStripeInfo = GlorybattleModel.instance:getHolyStripeInfo(activityId, creepsId)
	local holyStripeSuitId = 0

	if info.challengeInfo.curRound == 0 then
		isUse = true
	end

	if isPetTryCard then
		local petCardId = GlorybattleModel.instance:petIdFakeChangeRealPetCardId(creepsId)
		local petCardCfg = GlorybattleConfig.instance:getPetCardCfg(activityId, petCardId)

		if petCardCfg.holyStripeSuitId > 0 then
			holyStripeSuitId = petCardCfg.holyStripeSuitId
		end
	end

	if holyStripeInfo then
		holyStripeSuitId = holyStripeInfo.holyStripeId
	end

	goutil.setActive(self._iconGo, not isUse)
	goutil.setActive(self._limitGo, isPetTryCard)
	goutil.setActive(self._lwGo, holyStripeSuitId > 0)

	if holyStripeSuitId > 0 then
		local holyStripeCfg = GlorybattleConfig.instance:getHolyStripeSuitCfg(holyStripeSuitId)
		local url = string.format("%s.png", holyStripeCfg.iconUrl)

		uGuiUtil.setSpriteToImage(self._lwIconGo, uGuiUtil.SpriteType.BigBg, url)
	end
end

function GlorybattleTopCell:onExit()
	uGuiUtil.clearImage(self._lwIconGo)
end

function GlorybattleTopCell:_onClickBtnTips()
	if self._activityId and self._creepsId then
		local holyStripeInfo = GlorybattleModel.instance:getHolyStripeInfo(self._activityId, self._creepsId)

		if holyStripeInfo then
			local holyStripeCfg = GlorybattleConfig.instance:getHolyStripeSuitCfg(holyStripeInfo.holyStripeId)

			UIStateManager.instance:push(ViewName.GlorybattlelwtipsView, holyStripeCfg.suitId)
		end
	end
end

return GlorybattleTopCell
