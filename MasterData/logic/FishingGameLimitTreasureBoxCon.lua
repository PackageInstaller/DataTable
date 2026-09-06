-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fishinggame/model/FishingGameLimitTreasureBoxCon.lua

module("logic.extensions.fishinggame.model.FishingGameLimitTreasureBoxCon", package.seeall)

local FishingGameLimitTreasureBoxCon = class("FishingGameLimitTreasureBoxCon", FishingGameFishCon)
local CloseBg = "ui/bigbg/views/fishinggame/board_diaoyuxiaoyouxi_07.png"
local OpenBg = "ui/bigbg/views/fishinggame/board_diaoyuxiaoyouxi_08.png"

function FishingGameLimitTreasureBoxCon:buildUI()
	FishingGameLimitTreasureBoxCon.super.buildUI(self)

	self._countDown = goutil.findChild(self.container, "countDown")
	self._txtCountDown = goutil.findChildTextComponent(self.container, "countDown/txtCountDown")
end

function FishingGameLimitTreasureBoxCon:_onSetUI()
	self._lastOpened = nil

	FishingGameLimitTreasureBoxCon.super._onSetUI(self)
	self:_updateLimitTreasureUI()
end

function FishingGameLimitTreasureBoxCon:updateUI()
	FishingGameLimitTreasureBoxCon.super.updateUI(self)
	self:_updateLimitTreasureUI()
end

function FishingGameLimitTreasureBoxCon:setGray(isGray)
	FishingGameLimitTreasureBoxCon.super.setGray(self, false)
end

function FishingGameLimitTreasureBoxCon:reset()
	if self._countDown then
		GameUtil.SetActive(self._countDown, false)
	end

	self._lastOpened = nil

	FishingGameLimitTreasureBoxCon.super.reset(self)
end

function FishingGameLimitTreasureBoxCon:_updateLimitTreasureUI()
	if not self.container or not self._unit then
		return
	end

	local isOpened = self._unit._isLimitTreasureOpened

	if self._img and self._lastOpened ~= isOpened then
		if isOpened then
			if not OpenBg then
				do
					local bgPath = CloseBg

					uGuiUtil.setSpriteToImage(self._img, uGuiUtil.SpriteType.BigBg, bgPath)
					GameUtil.SetActive(self._img, true)

					self._lastOpened = isOpened
				end

				local isIdle = self._unit:getCurState() == FishingGameEnum.UnitState.Idle

				if self._countDown then
					GameUtil.SetActive(self._countDown, isOpened and isIdle)
				end

				if self._txtCountDown then
					local countDownTimer = math.max(0, math.ceil(checknumber(self._unit._countDownTimer)))

					self._txtCountDown.text = tostring(countDownTimer)
				end
			end
		end
	end
end

return FishingGameLimitTreasureBoxCon
