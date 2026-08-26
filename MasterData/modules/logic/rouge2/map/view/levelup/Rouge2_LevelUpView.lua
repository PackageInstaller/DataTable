-- chunkname: @modules/logic/rouge2/map/view/levelup/Rouge2_LevelUpView.lua

module("modules.logic.rouge2.map.view.levelup.Rouge2_LevelUpView", package.seeall)

local Rouge2_LevelUpView = class("Rouge2_LevelUpView", BaseView)

function Rouge2_LevelUpView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_bg")
	self._btnclosebtn = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_closebtn")
	self._imagefaction = gohelper.findChildImage(self.viewGO, "Left/#image_faction")
	self._txtfaction = gohelper.findChildText(self.viewGO, "Left/#txt_faction")
	self._txtlevel1 = gohelper.findChildText(self.viewGO, "Right/level/#txt_level1")
	self._txtlevel2 = gohelper.findChildText(self.viewGO, "Right/level/#txt_level2")
	self._gopoint = gohelper.findChild(self.viewGO, "Right/volume/layout/#go_point")
	self._txttalen = gohelper.findChildText(self.viewGO, "Right/talen/#txt_talen")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_LevelUpView:addEvents()
	self._btnclosebtn:AddClickListener(self._btnclosebtnOnClick, self)
end

function Rouge2_LevelUpView:removeEvents()
	self._btnclosebtn:RemoveClickListener()
end

function Rouge2_LevelUpView:_btnclosebtnOnClick()
	self:closeThis()
end

function Rouge2_LevelUpView:_editableInitView()
	self.pointGoList = self:getUserDataTb_()

	gohelper.setActive(self._gopoint, false)
	self._simagebg:LoadImage("singlebg/rouge/team/rouge_team_rolegroupbg.png")
end

function Rouge2_LevelUpView:onUpdateParam()
	return
end

function Rouge2_LevelUpView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.LvUp)

	self.rougeInfo = Rouge2_Model.instance:getRougeInfo()

	self:refreshStyle()
	self:refreshLevel()
	self:refreshCapacity()
	self:refreshTalent()
	self:playPointAnim()
end

function Rouge2_LevelUpView:refreshStyle()
	local style = self.rougeInfo.style
	local season = self.rougeInfo.season
	local styleCo = lua_rouge_style.configDict[season][style]

	self._txtfaction.text = styleCo.name

	UISpriteSetMgr.instance:setRouge2Sprite(self._imagefaction, string.format("%s_light", styleCo.icon))
end

function Rouge2_LevelUpView:refreshLevel()
	self._txtlevel1.text = "Lv." .. self.viewParam.preLv
	self._txtlevel2.text = "Lv." .. self.viewParam.curLv
end

function Rouge2_LevelUpView:refreshCapacity()
	local preTeamSize = self.viewParam.preTeamSize
	local teamSize = self.viewParam.curTeamSize

	for i = 1, teamSize do
		local go = gohelper.cloneInPlace(self._gopoint)
		local image = go:GetComponent(gohelper.Type_Image)

		gohelper.setActive(go, true)

		if preTeamSize < i then
			table.insert(self.pointGoList, go)
			UISpriteSetMgr.instance:setRougeSprite(image, "rouge_team_volume_light")
		else
			UISpriteSetMgr.instance:setRougeSprite(image, "rouge_team_volume_2")
		end
	end
end

function Rouge2_LevelUpView:refreshTalent()
	self._txttalen.text = GameUtil.getSubPlaceholderLuaLang(luaLang("rouge_lv_up_talent"), {
		1
	})
end

Rouge2_LevelUpView.WaitTime = 0.5

function Rouge2_LevelUpView:playPointAnim()
	TaskDispatcher.cancelTask(self._playPointAnim, self)
	TaskDispatcher.runDelay(self._playPointAnim, self, Rouge2_LevelUpView.WaitTime)
end

function Rouge2_LevelUpView:_playPointAnim()
	for _, go in ipairs(self.pointGoList) do
		go = gohelper.findChild(go, "green")

		gohelper.setActive(go, true)
	end
end

function Rouge2_LevelUpView:onClose()
	TaskDispatcher.cancelTask(self._playPointAnim, self)
end

function Rouge2_LevelUpView:onDestroyView()
	self._simagebg:UnLoadImage()
end

return Rouge2_LevelUpView
