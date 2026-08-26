-- chunkname: @modules/logic/playercard/view/comp/PlayerCardBaseInfoItem.lua

module("modules.logic.playercard.view.comp.PlayerCardBaseInfoItem", package.seeall)

local PlayerCardBaseInfoItem = class("PlayerCardBaseInfoItem", ListScrollCellExtend)

function PlayerCardBaseInfoItem:onInitView()
	self._gohero = gohelper.findChild(self.viewGO, "#go_role")
	self._txthero = gohelper.findChildText(self.viewGO, "#go_role/txt_role")
	self._txtheronum = gohelper.findChildText(self.viewGO, "#go_role/txt_role/#txt_num")
	self._goothers = gohelper.findChild(self.viewGO, "#go_others")
	self._goselect = gohelper.findChild(self.viewGO, "select")
	self._txtbase = gohelper.findChildText(self.viewGO, "#go_others/#txt_base")
	self._txtnum = gohelper.findChildText(self.viewGO, "#go_others/layout/#txt_num")
	self._txtdesc = gohelper.findChildText(self.viewGO, "#go_others/layout/#txt_dec")
	self._txtorder = gohelper.findChildText(self.viewGO, "select/#txt_order")
	self._goselectclick = gohelper.findChild(self.viewGO, "select/#go_click")
	self._goselecteffect = gohelper.findChild(self.viewGO, "select/#go_click/ani")
	self._btnclick = gohelper.findChildButton(self.viewGO, "#btn_click")
	self._typeItemList = {}
	self._hasShowEffect = false

	if self._editableInitView then
		self:_editableInitView()
	end
end

function PlayerCardBaseInfoItem:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function PlayerCardBaseInfoItem:removeEvents()
	self._btnclick:RemoveClickListener()
end

function PlayerCardBaseInfoItem:_editableInitView()
	return
end

function PlayerCardBaseInfoItem:_editableAddEvents()
	return
end

function PlayerCardBaseInfoItem:_editableRemoveEvents()
	return
end

function PlayerCardBaseInfoItem:onUpdateMO(mo)
	self.mo = mo
	self.config = mo.config
	self.playercardinfo = self.mo.info
	self.index = self.mo.index
	self.type = self.config.type

	self:refreshItem()

	local index = PlayerCardBaseInfoModel.instance:getSelectIndex(self.index)

	self._txtorder.text = tostring(index)

	if index then
		gohelper.setActive(self._goselecteffect, not self._hasShowEffect)
		gohelper.setActive(self._goselect, true)

		self._hasShowEffect = true
	else
		gohelper.setActive(self._goselect, false)
		gohelper.setActive(self._goselectclick, false)
	end
end

function PlayerCardBaseInfoItem:refreshItem()
	self._isHeroNum = self.index == PlayerCardEnum.RightContent.HeroCount

	gohelper.setActive(self._gohero, self._isHeroNum)
	gohelper.setActive(self._goothers, not self._isHeroNum)

	if self._isHeroNum then
		self._txthero.text = self.config.name
		self._txtheronum.text = self.playercardinfo:getHeroCount()
		self.chesslist = self:getUserDataTb_()
		self.chesslist = self.chesslist or {}

		if #self.chesslist <= 0 then
			for i = 1, 5 do
				self.chesslist[i] = gohelper.findChildImage(self._gohero, "collection/collection" .. i .. "/#image_full")
			end
		end

		local heroRareNNPercent, heroRareNPercent, heroRareRPercent, heroRareSRPercent, heroRareSSRPercent = self.playercardinfo:getHeroRarePercent()

		self.chesslist[1].fillAmount = heroRareNNPercent or 100
		self.chesslist[2].fillAmount = heroRareNPercent or 100
		self.chesslist[3].fillAmount = heroRareRPercent or 100
		self.chesslist[4].fillAmount = heroRareSRPercent or 100
		self.chesslist[5].fillAmount = heroRareSSRPercent or 100
	else
		self._txtbase.text = self.config.name

		local num, desc = self.playercardinfo:getBaseInfoByIndex(self.index, true)

		self._txtnum.text = num
		self._txtdesc.text = desc or ""
	end
end

function PlayerCardBaseInfoItem:_btnclickOnClick()
	if self.index == PlayerCardEnum.RightContent.HeroCount then
		GameFacade.showToast(ToastEnum.PlayerCardCanotClick)

		return
	end

	PlayerCardBaseInfoModel.instance:clickItem(self.index)
	gohelper.setActive(self._goselectclick, true)
	gohelper.setActive(self._goselecteffect, true)
	AudioMgr.instance:trigger(AudioEnum.WeekWalk.play_artificial_ui_carddisappear)
end

function PlayerCardBaseInfoItem:onSelect(isSelect)
	return
end

function PlayerCardBaseInfoItem:onDestroyView()
	return
end

return PlayerCardBaseInfoItem
