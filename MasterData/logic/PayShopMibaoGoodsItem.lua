-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/payshop/view/mibaogoodsitem/PayShopMibaoGoodsItem.lua

module("logic.extensions.payshop.view.mibaogoodsitem.PayShopMibaoGoodsItem", package.seeall)

local PayShopMibaoGoodsItem = class("PayShopMibaoGoodsItem", PayShopMibaoGoodsItemBase)

function PayShopMibaoGoodsItem:buildUI()
	PayShopMibaoGoodsItem.super.buildUI(self)

	self._txtLimit = goutil.findChild(self.mainGO, "showRewardCon/txtLimit"):GetComponent(goutil.Type_UIText)
	self._boxIcon = goutil.findChild(self.mainGO, "boxIcon")
	self._showRewardCon = goutil.findChild(self.mainGO, "showRewardCon")
	self._showRewardParent = goutil.findChild(self.mainGO, "showRewardCon/reward")
	self._showRewardCell = goutil.findChild(self.mainGO, "showRewardCon/cell")
	self._showRewardGroup = ItemGroup.New(self._showRewardParent, self._showRewardCell, nil, nil, true)
	self._boxIcon2 = goutil.findChild(self.mainGO, "showRewardCon/boxIcon")
end

function PayShopMibaoGoodsItem:onExit()
	PayShopMibaoGoodsItem.super.onExit(self)
	uGuiUtil.clearImage(self._boxIcon)
	uGuiUtil.clearImage(self._boxIcon2)
	self._showRewardGroup:dispose(function(item)
		local parent = goutil.findChild(item.mainGO, "cell")

		MaterialMgr.resetAll(parent)
	end)
end

function PayShopMibaoGoodsItem:_getLimitTxt()
	return self._txtLimit
end

function PayShopMibaoGoodsItem:setIcon(goodsCfg)
	if self:_isFirstBuy(goodsCfg) then
		self:_setRechargeIcon(goodsCfg)
	else
		self:_setNorIcon(goodsCfg)
	end
end

function PayShopMibaoGoodsItem:_setNorIcon(goodsCfg)
	goutil.setActive(self._boxIcon, false)
	goutil.setActive(self._showRewardCon, true)
	uGuiUtil.setSpriteToImage(self._boxIcon2, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(goodsCfg.icon))

	local t2 = string.split(goodsCfg.content, "#")
	local dataList = {}

	for i, v in ipairs(t2) do
		table.insert(dataList, {
			cfgStr = v
		})
	end

	local isgift = goodsCfg.groupId > 0

	if isgift then
		local gcfg = PayShopConfig.instance:getGroupCfg(goodsCfg.groupId)
		local presentGains = string.split(gcfg.presentGain, "#")

		for i, v in ipairs(presentGains) do
			table.insert(dataList, {
				isgift = true,
				cfgStr = v,
				totalDays = gcfg.totalDays
			})
		end
	end

	self._showRewardGroup:updateWithMoArray(dataList, function(item, data)
		local parent = goutil.findChild(item.mainGO, "cell")
		local giftTag = goutil.findChild(item.mainGO, "giftTag")
		local giftTagText = goutil.findChildTextComponent(item.mainGO, "giftTag/text")
		local proxy = MaterialMgr.setCellByCfg(data.cfgStr, parent)

		goutil.setActive(giftTag, data.isgift)

		if data.isgift then
			giftTagText.text = data.totalDays .. "天"
		end
	end)
end

function PayShopMibaoGoodsItem:_setRechargeIcon(goodsCfg)
	goutil.setActive(self._boxIcon, true)
	goutil.setActive(self._showRewardCon, false)
	uGuiUtil.setSpriteToImage(self._boxIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(goodsCfg.icon))
end

return PayShopMibaoGoodsItem
