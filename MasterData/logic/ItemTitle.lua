-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/material/proxy/title/ItemTitle.lua

module("logic.extensions.material.proxy.title.ItemTitle", package.seeall)

local ItemTitle = class("ItemTitle", MaterialCell)

function ItemTitle:ctor(target)
	self.target = target
	self._imgIconChange = goutil.findChildComponent(target, "ImgIcon", "UIImageSpriteChange")
	self.topGo = goutil.findChild(self.target, "topGo")
end

function ItemTitle:setCfgData(data)
	ItemTitle.super.setCfgData(self, data)
	self._imgIconChange:ChangeSprite(data.icon)
	GameUtil.addClickHandler(self.target, self._OnClick, self)

	if self._effSSR then
		UIEffectManager.instance:stopEffect(self._effSSR)

		self._effSSR = nil
	end

	self._effSSR = self:playRareEffect(5, self.topGo)
end

function ItemTitle:dispose()
	ItemTitle.super.dispose(self)

	if self._effSSR then
		UIEffectManager.instance:stopEffect(self._effSSR)

		self._effSSR = nil
	end
end

function ItemTitle:OnDestroy()
	ItemTitle.super.OnDestroy(self)

	self.mainGO = nil
	self.data = nil
	self._clickBack = nil

	if self._effSSR then
		UIEffectManager.instance:stopEffect(self._effSSR)

		self._effSSR = nil
	end
end

function ItemTitle:_OnClick()
	print(">>>>>>>>>>>itemtile  click 点击事件处理")
	GameUtil.callBack(self.callback, self)
	CommonTipsMgr.instance:openMaterialTips(self.target, MatType.Title, self.cfg.titleId)
end

return ItemTitle
