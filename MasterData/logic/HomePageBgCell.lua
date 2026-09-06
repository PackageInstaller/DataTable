-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/material/proxy/homepagebg/HomePageBgCell.lua

module("logic.extensions.material.proxy.homepagebg.HomePageBgCell", package.seeall)

local HomePageBgCell = class("HomePageBgCell", MaterialCell)

function HomePageBgCell:ctor(target)
	self.target = target
	self.topGo = goutil.findChild(self.target, "topGo")
	self._imgIcon = goutil.findChild(self.target, "ImgIcon")
end

function HomePageBgCell:setCfgData(data)
	HomePageBgCell.super.setCfgData(self, data)
	GameUtil.addClickHandler(self.target, self._OnClick, self)

	if self._effSSR then
		UIEffectManager.instance:stopEffect(self._effSSR)

		self._effSSR = nil
	end

	self._effSSR = self:playRareEffect(data.quality, self.topGo)

	uGuiUtil.setSpriteToImage(self._imgIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(data.icon2))
end

function HomePageBgCell:dispose()
	HomePageBgCell.super.dispose(self)

	if self._effSSR then
		UIEffectManager.instance:stopEffect(self._effSSR)

		self._effSSR = nil
	end

	uGuiUtil.clearImage(self._imgIcon)
end

function HomePageBgCell:OnDestroy()
	HomePageBgCell.super.OnDestroy(self)

	self.mainGO = nil
	self.data = nil
	self._clickBack = nil

	if self._effSSR then
		UIEffectManager.instance:stopEffect(self._effSSR)

		self._effSSR = nil
	end

	uGuiUtil.clearImage(self._imgIcon)
end

function HomePageBgCell:_OnClick()
	print(">>>>>>>>>>>itemtile  click 点击事件处理")
	GameUtil.callBack(self._clickBack, self)
	GameUtil.callBack(self.callback, self)

	if self.autoTips then
		CommonTipsMgr.instance:openMaterialTips(self.target, self.type, self.id)
	end
end

return HomePageBgCell
