-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/material/proxy/item/HolyStripeMockCell.lua

module("logic.extensions.material.proxy.item.HolyStripeMockCell", package.seeall)

local HolyStripeMockCell = class("HolyStripeMockCell", HolyStripeCell)

function HolyStripeMockCell:setData(data)
	HolyStripeMockCell.super.setData(self, data)
	self:setUiOfMock(true)
end

function HolyStripeMockCell:_OnClick()
	GameUtil.callBack(self._clickBack, self)

	if self.autoTips then
		CommonTipsMgr.instance:openMaterialTips(self.imgBg, self.type, self.id, self.data)
	end
end

return HolyStripeMockCell
