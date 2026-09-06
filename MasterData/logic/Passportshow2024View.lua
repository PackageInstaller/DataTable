-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/passport/view/Passportshow2024View.lua

module("logic.extensions.passport.view.Passportshow2024View", package.seeall)

local Passportshow2024View = class("Passportshow2024View", PassportshowView)

function Passportshow2024View:buildUI()
	Passportshow2024View.super.buildUI(self)

	self._imgMid = self:getGo("container/mid/imgMid")
	self._imgSlogan = self:getGo("container/mid/imgSlogan")
	self._btnBuyImgBg = self:getGo("container/rightTop/pos2/btnBuyPassport/imgBg")
	self._changeGroup = nil
	self._txtDiamondNum = nil
end

function Passportshow2024View:_updateCell(view, cell, data)
	local component = GameUtil.AddLuaOnce(cell.gameObject, Passport2024CellItem)

	if self._scrollRect and self._curData and data then
		component:setData(self, self._scrollRect, self._curData, data)
	end
end

function Passportshow2024View:_refreshUI()
	Passportshow2024View.super._refreshUI(self)

	local funcCfg = self._curData.funcCfg

	if self._imgSlogan and not string.nilorempty(funcCfg.slogan) then
		local path = GameUrl.getPassportBGUrl(funcCfg.slogan)

		uGuiUtil.setSpriteToImage(self._imgSlogan, uGuiUtil.SpriteType.BigBg, path, function()
			self._imgSlogan.gameObject:GetComponent(goutil.Type_UIImage):SetNativeSize()
		end)
	end

	if self._imgMid then
		GameUtil.SetActive(self._imgMid, false)

		if funcCfg and not string.nilorempty(funcCfg.midBG) then
			GameUtil.SetActive(self._imgMid, true)

			local com = GameUtil.getUIImageSpriteChange(self._imgMid)

			if com then
				com:ChangeSprite(funcCfg.midBG)
			end
		end
	end

	if self._imgMid then
		GameUtil.SetActive(self._imgMid, false)

		if funcCfg and not string.nilorempty(funcCfg.midBG) then
			GameUtil.SetActive(self._imgMid, true)

			local com = GameUtil.getUIImageSpriteChange(self._imgMid)

			if com then
				com:ChangeSprite(funcCfg.midBG)
			end
		end
	end

	if funcCfg and not string.nilorempty(funcCfg.btnBuyBG) then
		local com = GameUtil.getUIImageSpriteChange(self._btnBuyImgBg)

		if com then
			com:ChangeSprite(funcCfg.btnBuyBG)
		end
	end
end

function Passportshow2024View:_getPassportbuyViewExtraParam()
	local funcCfg = self._curData.funcCfg

	if funcCfg and not string.nilorempty(funcCfg.descAll) then
		local param = {}

		param.descAll = funcCfg.descAll

		return param
	end
end

return Passportshow2024View
