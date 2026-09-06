-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/passport/view/Passport2024CellItem.lua

module("logic.extensions.passport.view.Passport2024CellItem", package.seeall)

local Passport2024CellItem = class("Passport2024CellItem", PassportCellItem)

function Passport2024CellItem:buildUI()
	Passport2024CellItem.super.buildUI(self)

	self._cellGroup = nil
end

function Passport2024CellItem:initView()
	Passport2024CellItem.super.initView(self)

	if self._imgBg then
		local funcCfg = self._curData.funcCfg

		GameUtil.SetActive(self._imgBg, false)

		if funcCfg and not string.nilorempty(funcCfg.cellBG) then
			GameUtil.SetActive(self._imgBg, false)

			local com = GameUtil.getUIImageSpriteChange(self._imgBg)

			if com then
				com:ChangeSprite(funcCfg.cellBG)
			end
		end
	end
end

return Passport2024CellItem
