-- chunkname: @modules/logic/versionactivity3_7/travelgo/view/item/TravelGoDescItem.lua

module("modules.logic.versionactivity3_7.travelgo.view.item.TravelGoDescItem", package.seeall)

local TravelGoDescItem = class("TravelGoDescItem", LuaCompBase)

function TravelGoDescItem:init(viewGO)
	self.viewGO = viewGO
	self._gotitle = gohelper.findChild(self.viewGO, "title")
	self._goDay = gohelper.findChild(self.viewGO, "title/day")
	self._txtDay = gohelper.findChildText(self.viewGO, "title/day/#txt_Day")
	self._luckTag1 = gohelper.findChild(self.viewGO, "title/luckTag1")
	self._luckTag2 = gohelper.findChild(self.viewGO, "title/luckTag2")
	self._luckTag3 = gohelper.findChild(self.viewGO, "title/luckTag3")
	self._imageBG = gohelper.findChildImage(self.viewGO, "Image_BG")
	self._txtDescr = gohelper.findChildText(self.viewGO, "Image_BG/#txt_Descr")
	self._gorewardScroll = gohelper.findChild(self.viewGO, "Image_BG/Scroll View")
	self._goReward = gohelper.findChild(self.viewGO, "Image_BG/Scroll View/Viewport/Rewards")

	local scrollParam = SimpleListParam.New()

	scrollParam.cellClass = TravelGoRewardDescItem
	self.rewardList = GameFacade.createSimpleListComp(self._goReward, scrollParam, nil, self.viewContainer)
end

function TravelGoDescItem:setData(param)
	self.day = param.day
	self.desc = param.desc
	self.rewardMOs = param.rewardMOs
	self.luckType = param.luckType

	if self.day then
		local str = GameUtil.getNum2Chinese(self.day)

		self._txtDay.text = GameUtil.getSubPlaceholderLuaLang(luaLang("TravelGoView_2"), {
			str
		})

		gohelper.setActive(self._luckTag1, self.luckType == TravelGoEnum.LuckEventType.UnLuck)
		gohelper.setActive(self._luckTag2, self.luckType == TravelGoEnum.LuckEventType.LittleLuck)
		gohelper.setActive(self._luckTag3, self.luckType == TravelGoEnum.LuckEventType.VeryLuck)
	end

	gohelper.setActive(self._gotitle, self.day)

	self._txtDescr.text = self.desc

	if self.luckType then
		local str = "v3a7_xiaoruiannong_game_luckitembg" .. self.luckType

		UISpriteSetMgr.instance:setTravelGoSprite(self._imageBG, str)
	else
		UISpriteSetMgr.instance:setTravelGoSprite(self._imageBG, "v3a7_xiaoruiannong_game_luckitembg4")
	end

	self:refreshReward()
end

function TravelGoDescItem:addRewardList(rewardMOs)
	self.rewardMOs = rewardMOs

	self:refreshReward()
end

function TravelGoDescItem:refreshReward()
	gohelper.setActive(self._gorewardScroll, self.rewardMOs and #self.rewardMOs > 0)

	if self.rewardMOs then
		self.rewardList:setData(self.rewardMOs)
	end
end

return TravelGoDescItem
