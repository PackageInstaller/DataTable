-- chunkname: @modules/logic/versionactivity3_7/travelgo/view/item/TravelGoSkillRewardItem.lua

module("modules.logic.versionactivity3_7.travelgo.view.item.TravelGoSkillRewardItem", package.seeall)

local TravelGoSkillRewardItem = class("TravelGoSkillRewardItem", LuaCompBase)

function TravelGoSkillRewardItem:init(viewGO)
	self.viewGO = viewGO
	self._txtDescr = gohelper.findChildText(self.viewGO, "#txt_Descr")
	self._imageName = gohelper.findChildImage(self.viewGO, "#txt_Descr/Image_Name")
	self._txtName = gohelper.findChildText(self.viewGO, "#txt_Descr/Image_Name/#txt_Name")
	self._goBtn = gohelper.findChildButton(self.viewGO, "#go_btn")
	self._imageBG = gohelper.findChildImage(self.viewGO, "#image_BG")
	self._gonormalqulity = gohelper.findChild(self.viewGO, "#go_level2")
	self._gohighqulity = gohelper.findChild(self.viewGO, "#go_level3")
	self._goStar = gohelper.findChild(self.viewGO, "#go_Dec")
	self._imageIconBG = gohelper.findChildImage(self.viewGO, "#image_IconBG")
	self._imageIcon = gohelper.findChildImage(self.viewGO, "#image_IconBG/#image_Icon")
	self.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(self.viewGO)
end

function TravelGoSkillRewardItem:addEventListeners()
	self.addClickCb(self, self._goBtn, self.onClick, self)
end

function TravelGoSkillRewardItem:setData(param, onClickItem, context)
	self.param = param
	self.skillCfg = param.skillCfg
	self.onClickItem = onClickItem
	self.context = context
	self._txtDescr.text = self.skillCfg.desc
	self._txtName.text = self.skillCfg.name

	local str = "v3a7_xiaoruiannong_game_skillitembg" .. self.skillCfg.rare

	UISpriteSetMgr.instance:setTravelGoSprite(self._imageBG, str)

	local isHighRare = self.skillCfg.rare == 3

	gohelper.setActive(self._gohighqulity, isHighRare)
	gohelper.setActive(self._gonormalqulity, not isHighRare)

	local colorStr = TravelGoController.instance:getSkillRareColor(self.skillCfg.rare)
	local color = GameUtil.parseColor(colorStr)

	self._imageIconBG.color = color
	self._imageName.color = color

	UISpriteSetMgr.instance:setBuffSprite(self._imageIcon, self.skillCfg.icon)
end

function TravelGoSkillRewardItem:onClick()
	if not self.onClickItem then
		return
	end

	self.animatorPlayer:Play(UIAnimationName.Close, self._onPlayCloseFinished, self)
end

function TravelGoSkillRewardItem:_onPlayCloseFinished()
	if self.onClickItem then
		self.onClickItem(self.context, self.param)
	end
end

return TravelGoSkillRewardItem
