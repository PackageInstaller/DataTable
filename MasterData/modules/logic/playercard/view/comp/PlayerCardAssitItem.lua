-- chunkname: @modules/logic/playercard/view/comp/PlayerCardAssitItem.lua

module("modules.logic.playercard.view.comp.PlayerCardAssitItem", package.seeall)

local PlayerCardAssitItem = class("PlayerCardAssitItem", LuaCompBase)

function PlayerCardAssitItem:init(go)
	self.viewGO = go
	self.goEmpty = gohelper.findChild(go, "empty")
	self.goRole = gohelper.findChild(go, "#go_roleitem")
	self.simageHead = gohelper.findChildSingleImage(go, "#go_roleitem/rolehead")
	self.imageCareer = gohelper.findChildImage(go, "#go_roleitem/career")
	self.imageLevel = gohelper.findChildImage(go, "#go_roleitem/layout/level")
	self.txtLevel = gohelper.findChildTextMesh(go, "#go_roleitem/layout/#txt_level")
	self.imagQuality = gohelper.findChildImage(go, "#go_roleitem/quality")
	self.goExskill = gohelper.findChild(go, "#go_exskill")
	self.imageExskill = gohelper.findChildImage(go, "#go_exskill/#image_exskill")
	self.btnClick = gohelper.findChildButtonWithAudio(go, "#btn_clickarea")
	self.goSelectedEff = gohelper.findChild(go, "selected_eff")
end

function PlayerCardAssitItem:playSelelctEffect()
	gohelper.setActive(self.goSelectedEff, false)
	gohelper.setActive(self.goSelectedEff, true)
	PlayerCardController.instance:playChangeEffectAudio()
end

function PlayerCardAssitItem:setData(info, isPlayerSelf, compType)
	self.info = info
	self.isPlayerSelf = isPlayerSelf
	self.compType = compType

	self:showcharacterinfo(info)
end

local breakImgValue = {
	0.23,
	0.42,
	0.59,
	0.78,
	1
}

function PlayerCardAssitItem:showcharacterinfo(info)
	if info then
		::label_4_0::

		if info ~= 0 then
			if info.heroId then
				local notIsEmpty = true

				if info.heroId == "0" or info.heroId == 0 then
					notIsEmpty = false

					goto label_4_1
				end

				gohelper.setActive(self.goEmpty, self.isPlayerSelf and not notIsEmpty)
				gohelper.setActive(self.goRole, notIsEmpty)

				if notIsEmpty then
					if self.isPlayerSelf then
						info = HeroModel.instance:getByHeroId(info.heroId)
					end

					local heroConfig = HeroConfig.instance:getHeroCO(info.heroId)
					local skinConfig = SkinConfig.instance:getSkinCo(info.skin)

					self.simageHead:LoadImage(ResUrl.getHeadIconSmall(skinConfig.retangleIcon))

					local lev, rank = HeroConfig.instance:getShowLevel(info.level)

					UISpriteSetMgr.instance:setCommonSprite(self.imageCareer, string.format("lssx_%s", heroConfig.career), true)

					if rank > 1 then
						UISpriteSetMgr.instance:setCommonSprite(self.imageLevel, string.format("dongxi_xiao_%s", rank - 1), true)
						gohelper.setActive(self.imageLevel, true)
					else
						gohelper.setActive(self.imageLevel, false)
					end

					self.txtLevel.text = lev

					if info.exSkillLevel then
						if not breakImgValue[info.exSkillLevel] then
							local val = 0

							self.imageExskill.fillAmount = val

							gohelper.setActive(self.goExskill, val > 0)
							UISpriteSetMgr.instance:setRoomSprite(self.imagQuality, "quality_" .. CharacterEnum.Color[heroConfig.rare])

							self.heroId = heroConfig.id
						end
					end
				else
					gohelper.setActive(self.goExskill, false)

					self.heroId = nil
				end

				if self.notIsFirst and self.heroId ~= self.tempHeroId then
					self:playSelelctEffect()
				end

				self.tempHeroId = self.heroId
				self.notIsFirst = true
			end
		end
	end
end

function PlayerCardAssitItem:btnClickOnClick()
	if self.isPlayerSelf and self.compType == PlayerCardEnum.CompType.Normal then
		ViewMgr.instance:openView(ViewName.ShowCharacterView, {
			notRepeatUpdateAssistReward = true
		})
	end
end

function PlayerCardAssitItem:addEventListeners()
	self.btnClick:AddClickListener(self.btnClickOnClick, self)
end

function PlayerCardAssitItem:removeEventListeners()
	self.btnClick:RemoveClickListener()
end

function PlayerCardAssitItem:onDestroy()
	self.simageHead:UnLoadImage()
end

return PlayerCardAssitItem
