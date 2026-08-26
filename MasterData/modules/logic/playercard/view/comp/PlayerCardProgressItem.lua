-- chunkname: @modules/logic/playercard/view/comp/PlayerCardProgressItem.lua

module("modules.logic.playercard.view.comp.PlayerCardProgressItem", package.seeall)

local PlayerCardProgressItem = class("PlayerCardProgressItem", ListScrollCellExtend)

function PlayerCardProgressItem:onInitView()
	self._imagepic = gohelper.findChildImage(self.viewGO, "#image_pic")
	self._imageicon = gohelper.findChildImage(self.viewGO, "#image_icon")
	self._txtname = gohelper.findChildText(self.viewGO, "#txt_name")
	self._txten = gohelper.findChildText(self.viewGO, "#txt_en")
	self._goselect = gohelper.findChild(self.viewGO, "select")
	self._txtorder = gohelper.findChildText(self.viewGO, "select/#txt_order")
	self._goselecteffect = gohelper.findChild(self.viewGO, "select/#go_click")
	self._btnclick = gohelper.findChildButton(self.viewGO, "#btn_click")
	self._typeItemList = {}

	if self._editableInitView then
		self:_editableInitView()
	end
end

function PlayerCardProgressItem:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function PlayerCardProgressItem:removeEvents()
	self._btnclick:RemoveClickListener()
end

function PlayerCardProgressItem:_editableInitView()
	for _, value in pairs(PlayerCardEnum.ProgressShowType) do
		local gotype = gohelper.findChild(self.viewGO, "progress/type" .. value)

		gohelper.setActive(gotype, false)

		self._typeItemList[value] = gotype
	end

	gohelper.setActive(self._goselect, false)
end

function PlayerCardProgressItem:resetType()
	for key, gotype in pairs(self._typeItemList) do
		gohelper.setActive(gotype, false)
	end
end

function PlayerCardProgressItem:_editableAddEvents()
	return
end

function PlayerCardProgressItem:_editableRemoveEvents()
	return
end

function PlayerCardProgressItem:_btnclickOnClick()
	PlayerCardProgressModel.instance:clickItem(self.index)
	gohelper.setActive(self._goselecteffect, true)
	AudioMgr.instance:trigger(AudioEnum.WeekWalk.play_artificial_ui_carddisappear)
end

function PlayerCardProgressItem:onUpdateMO(mo)
	self.mo = mo
	self.config = mo.config
	self.playercardinfo = self.mo.info
	self.index = self.mo.index
	self.type = self.config.type

	UISpriteSetMgr.instance:setPlayerCardSprite(self._imagepic, "playercard_progress_img_" .. self.index)
	UISpriteSetMgr.instance:setPlayerCardSprite(self._imageicon, "playercard_progress_icon_" .. self.index)
	self:refreshItem()

	local index = PlayerCardProgressModel.instance:getSelectIndex(self.index)

	if index then
		gohelper.setActive(self._goselect, true)

		self._txtorder.text = tostring(index)
	else
		gohelper.setActive(self._goselect, false)
		gohelper.setActive(self._goselecteffect, false)
	end
end

function PlayerCardProgressItem:refreshItem()
	self._txtname.text = self.config.name
	self._txten.text = self.config.nameEn

	for index, gotype in pairs(self._typeItemList) do
		gohelper.setActive(gotype, false)
	end

	local gotype = self._typeItemList[self.type]

	gohelper.setActive(gotype, true)

	if self.type == PlayerCardEnum.ProgressShowType.Normal then
		local txtProgress = gohelper.findChildText(gotype, "#txt_progress")
		local goNone = gohelper.findChild(gotype, "none")
		local progress = self.playercardinfo:getProgressByIndex(self.index)
		local canshow = progress ~= -1

		gohelper.setActive(goNone, not canshow)
		gohelper.setActive(txtProgress.gameObject, canshow)

		txtProgress.text = progress
	elseif self.type == PlayerCardEnum.ProgressShowType.Explore then
		local exploreCollection = self.playercardinfo.exploreCollection
		local txtNum1 = gohelper.findChildText(gotype, "#txt_num1")
		local txtNum2 = gohelper.findChildText(gotype, "#txt_num2")
		local txtNum3 = gohelper.findChildText(gotype, "#txt_num3")

		if not string.nilorempty(exploreCollection) then
			local arr = GameUtil.splitString2(exploreCollection, true) or {}

			txtNum1.text = arr[3][1] or 0
			txtNum2.text = arr[1][1] or 0
			txtNum3.text = arr[2][1] or 0
		else
			txtNum1.text = 0
			txtNum2.text = 0
			txtNum3.text = 0
		end
	elseif self.type == PlayerCardEnum.ProgressShowType.Room then
		local txtNum1 = gohelper.findChildText(gotype, "#txt_num1")
		local txtNum2 = gohelper.findChildText(gotype, "#txt_num2")
		local roomCollection = self.playercardinfo.roomCollection
		local arr = string.splitToNumber(roomCollection, "#")

		if arr then
			if not arr[1] then
				local landNum = 0

				txtNum1.text = landNum and landNum or 0

				if arr then
					if not arr[2] then
						local buildingNum = 0

						txtNum2.text = buildingNum and buildingNum or 0
					end
				end
			end
		end
	end
end

function PlayerCardProgressItem:onDestroyView()
	return
end

return PlayerCardProgressItem
