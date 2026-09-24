-- chunkname: @modules/logic/versionactivity4_0/concertlimit/view/candyroom/CandyRoomPanelRewardItem.lua

module("modules.logic.versionactivity4_0.concertlimit.view.candyroom.CandyRoomPanelRewardItem", package.seeall)

local CandyRoomPanelRewardItem = class("CandyRoomPanelRewardItem")

function CandyRoomPanelRewardItem:init(go)
	self.go = go
	self._gonorpanel = gohelper.findChild(self.go, "go_norpanel")
	self._gonorpanelbg = gohelper.findChild(self._gonorpanel, "bg")
	self._gonorpanelicon = gohelper.findChild(self._gonorpanel, "go_icon")
	self._gonorpanelnum = gohelper.findChild(self._gonorpanel, "go_num")
	self._txtnorpanelnum = gohelper.findChildText(self._gonorpanelnum, "txt_num")
	self._txtnorpanelname = gohelper.findChildText(self._gonorpanel, "txt_name")
	self._gonorpanelhasget = gohelper.findChild(self._gonorpanel, "go_hasget")
	self._btnnorpanelclick = gohelper.findChildButtonWithAudio(self._gonorpanel, "btn_click")
	self._gosp = gohelper.findChild(self.go, "go_sp")
	self._simagespicon = gohelper.findChildSingleImage(self._gosp, "simage_icon")
	self._simagespname = gohelper.findChildSingleImage(self._gosp, "simage_name")
	self._simagespitem = gohelper.findChildSingleImage(self._gosp, "simage_item")
	self._gospnum = gohelper.findChild(self._gosp, "go_tag")
	self._txtspnum = gohelper.findChildText(self._gosp, "go_tag/txt_num")
	self._gospcanget = gohelper.findChild(self._gosp, "go_canget")
	self._gosphasget = gohelper.findChild(self._gosp, "go_hasget")
	self._btnspclick = gohelper.findChildButtonWithAudio(self._gosp, "btn_click")

	self:_initItem()
	self:_addEvents()
end

function CandyRoomPanelRewardItem:_initItem()
	gohelper.setActive(self._gosphasget, false)
	gohelper.setActive(self._gonorpanelhasget, false)
	gohelper.setActive(self._btnnorpanelclick.gameObject, false)
end

function CandyRoomPanelRewardItem:_addEvents()
	self._btnspclick:AddClickListener(self._onBtnClick, self)
end

function CandyRoomPanelRewardItem:_removeEvents()
	self._btnspclick:RemoveClickListener()
end

function CandyRoomPanelRewardItem:_onBtnClick()
	local rewardList = GameUtil.splitString2(self._rewardCo.reward, true)

	MaterialTipController.instance:showMaterialInfo(rewardList[1][1], rewardList[1][2])
end

function CandyRoomPanelRewardItem:refresh(rewardId)
	self._rewardId = rewardId
	self._rewardCo = CandyRoomConfig.instance:getActivity245RewardCo(self._rewardId)

	if self._rewardCo then
		local isSp = true

		isSp = self._rewardCo.isSp

		if self._rewardCo.isSp then
			if self._rewardCo.isSp ~= 1 then
				isSp = false
			end

			self._itemCos = string.splitToNumber(self._rewardCo.reward, "#")
			self._itemCo, self._itemIcon = ItemModel.instance:getItemConfigAndIcon(self._itemCos[1], self._itemCos[2])

			gohelper.setActive(self._gosp, isSp)
			gohelper.setActive(self._gonorpanel, not isSp)

			self._getCount = CandyRoomModel.instance:getSummonedCountByRewardId(self._rewardId)

			if isSp then
				self:_refreshSp()
			else
				self:_refreshNorPanel()
			end
		end
	end
end

function CandyRoomPanelRewardItem:_refreshSp()
	self._simagespname:LoadImage(ResUrl.getV4a0ConcertCandyRoomLangIcon(self._rewardCo.spPanelTitle))
	self._simagespicon:LoadImage(ResUrl.getV4a0ConcertCandyRoomRewardPanelSingleBg(self._rewardCo.spPanelIcon))
	gohelper.setActive(self._gospnum, self._rewardCo.availableTime > 1 and self._getCount < self._rewardCo.availableTime)

	if self._getCount < self._rewardCo.availableTime then
		self._txtspnum.text = GameUtil.getSubPlaceholderLuaLang(luaLang("candyroom_limitgetcount"), {
			self._rewardCo.availableTime - self._getCount
		})
	end

	self._simagespitem:LoadImage(self._itemIcon)
	gohelper.setActive(self._gosphasget, self._getCount >= self._rewardCo.availableTime)
end

function CandyRoomPanelRewardItem:_refreshNorPanel()
	self._item = IconMgr.instance:getCommonItemIcon(self._gonorpanelicon)

	self._item:setMOValue(self._itemCos[1], self._itemCos[2], self._itemCos[3])
	self._item:isShowName(false)
	self._item:setCountFontSize(35)
	gohelper.setActive(self._gonorpanelnum, self._rewardCo.availableTime > 1 and self._getCount < self._rewardCo.availableTime)

	if self._getCount < self._rewardCo.availableTime then
		self._txtnorpanelnum.text = GameUtil.getSubPlaceholderLuaLang(luaLang("candyroom_limitgetcount"), {
			self._rewardCo.availableTime - self._getCount
		})
	end

	self._txtnorpanelname.text = self._itemCo.name

	gohelper.setActive(self._gonorpanelhasget, self._getCount >= self._rewardCo.availableTime)
end

function CandyRoomPanelRewardItem:destroy()
	self._simagespitem:UnLoadImage()
	self._simagespicon:UnLoadImage()
	self._simagespname:UnLoadImage()
	self:_removeEvents()
end

return CandyRoomPanelRewardItem
