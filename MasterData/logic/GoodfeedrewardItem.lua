-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goodfeel/view/GoodfeedrewardItem.lua

module("logic.extensions.goodfeel.view.GoodfeedrewardItem", package.seeall)

local GoodfeedrewardItem = class("GoodfeedrewardItem", BaseLuaOnce)

function GoodfeedrewardItem:ctor(go)
	GoodfeedrewardItem.super.ctor(self, go)
end

function GoodfeedrewardItem:buildUI()
	GoodfeedrewardItem.super.buildUI(self)

	self._ylqTag = self:getGo("ylqTag")
	self._ylqTagChange = self._ylqTag:GetComponent(ComponentType.UIImageSpriteChange)
	self._ylqText = self:getText("ylqTag/text")
	self._lvText = self:getText("lvText")
	self._okBtn = self:getBtn("getBtn")
	self._itemCon = self:getGo("itemCon")
	self._itemCell = self:getGo("itemCon/cell")
	self._itemGroup = ItemGroup.New(self._itemCon, self._itemCell, nil, nil, true)
end

function GoodfeedrewardItem:bindEvents()
	GoodfeedrewardItem.super.bindEvents(self)
	self._okBtn:AddClickListener(self._onClickGetBtn, self)
end

function GoodfeedrewardItem:unbindEvents()
	GoodfeedrewardItem.super.unbindEvents(self)
	self._okBtn:RemoveClickListener()
end

function GoodfeedrewardItem:onEnter(raceId, cfg, gainBit, index)
	GoodfeedrewardItem.super.onEnter(self)

	self._raceId = raceId
	self._lv = cfg.lv

	local canGain = GoodFeelModel.instance:checkCanGainLvRewardByLv(raceId, cfg.lv)
	local list = string.split(cfg.prize, "#")
	local isGain = GameUtil.isBitOpenByDigit(gainBit, cfg.lv - 1)

	goutil.setActive(self._ylqTag, isGain or not canGain)
	goutil.setActive(self._okBtn.gameObject, not isGain and canGain)

	self._ylqText.text = isGain and "已领取" or "未达成"
	self._lvText.text = string.format("好感度%s级", cfg.lv)

	self._itemGroup:updateWithMoArray(list, function(item, data)
		MaterialMgr.setCellByCfg(data, item.mainGO)
	end)
end

function GoodfeedrewardItem:onExit()
	GoodfeedrewardItem.super.onExit(self)
	MaterialMgr.resetAll(self._itemCon)
end

function GoodfeedrewardItem:_onClickGetBtn()
	GoodFeelingAgent.instance:sendPM_GFGainPrizeReq(self._raceId, self._lv)
end

return GoodfeedrewardItem
