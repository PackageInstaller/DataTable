-- chunkname: @modules/logic/rouge/map/view/levelup/RougeLevelUpView.lua

module("modules.logic.rouge.map.view.levelup.RougeLevelUpView", package.seeall)

local RougeLevelUpView = class("RougeLevelUpView", BaseView)

function RougeLevelUpView:onInitView()
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

function RougeLevelUpView:addEvents()
	self._btnclosebtn:AddClickListener(self._btnclosebtnOnClick, self)
end

function RougeLevelUpView:removeEvents()
	self._btnclosebtn:RemoveClickListener()
end

function RougeLevelUpView:_btnclosebtnOnClick()
	self:closeThis()
end

function RougeLevelUpView:_editableInitView()
	self.pointGoList = self:getUserDataTb_()

	gohelper.setActive(self._gopoint, false)
	self._simagebg:LoadImage("singlebg/rouge/team/rouge_team_rolegroupbg.png")
end

function RougeLevelUpView:onUpdateParam()
	return
end

function RougeLevelUpView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.LvUp)

	self.rougeInfo = RougeModel.instance:getRougeInfo()

	self:refreshStyle()
	self:refreshLevel()
	self:refreshCapacity()
	self:refreshTalent()
	self:playPointAnim()
end

function RougeLevelUpView:refreshStyle()
	local style = self.rougeInfo.style
	local season = self.rougeInfo.season
	local styleCo = lua_rouge_style.configDict[season][style]

	self._txtfaction.text = styleCo.name

	UISpriteSetMgr.instance:setRouge2Sprite(self._imagefaction, string.format("%s_light", styleCo.icon))
end

function RougeLevelUpView:refreshLevel()
	self._txtlevel1.text = "Lv." .. self.viewParam.preLv
	self._txtlevel2.text = "Lv." .. self.viewParam.curLv
end

function RougeLevelUpView:refreshCapacity()
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

function RougeLevelUpView:refreshTalent()
	self._txttalen.text = GameUtil.getSubPlaceholderLuaLang(luaLang("rouge_lv_up_talent"), {
		1
	})
end

RougeLevelUpView.WaitTime = 0.5

function RougeLevelUpView:playPointAnim()
	TaskDispatcher.cancelTask(self._playPointAnim, self)
	TaskDispatcher.runDelay(self._playPointAnim, self, RougeLevelUpView.WaitTime)
end

function RougeLevelUpView:_playPointAnim()
	for _, go in ipairs(self.pointGoList) do
		go = gohelper.findChild(go, "green")

		gohelper.setActive(go, true)
	end
end

function RougeLevelUpView:onClose()
	TaskDispatcher.cancelTask(self._playPointAnim, self)
end

function RougeLevelUpView:onDestroyView()
	self._simagebg:UnLoadImage()
end

return RougeLevelUpView
