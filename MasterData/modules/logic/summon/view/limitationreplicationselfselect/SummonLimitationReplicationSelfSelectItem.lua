-- chunkname: @modules/logic/summon/view/limitationreplicationselfselect/SummonLimitationReplicationSelfSelectItem.lua

module("modules.logic.summon.view.limitationreplicationselfselect.SummonLimitationReplicationSelfSelectItem", package.seeall)

local SummonLimitationReplicationSelfSelectItem = class("SummonLimitationReplicationSelfSelectItem", LuaCompBase)

function SummonLimitationReplicationSelfSelectItem:init(go)
	self.go = go
	self._imageunselectRole = gohelper.findChildImage(self.go, "unselect/#image_unselectRole")
	self._imageselectRole = gohelper.findChildImage(self.go, "selected/#image_selectRole")
	self._imageframe = gohelper.findChildImage(self.go, "selected/#image_frame")
	self._btnclick = gohelper.findChildButtonWithAudio(self.go, "#btn_click")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SummonLimitationReplicationSelfSelectItem:addEventListeners()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function SummonLimitationReplicationSelfSelectItem:removeEventListeners()
	self._btnclick:RemoveClickListener()
end

function SummonLimitationReplicationSelfSelectItem:_btnclickOnClick()
	if not self.heroId then
		return
	end

	SummonController.instance:dispatchEvent(SummonEvent.onLimitationReplicationSelectHero, self.heroId)
end

function SummonLimitationReplicationSelfSelectItem:_editableInitView()
	self._goselected = gohelper.findChild(self.go, "selected")
	self._gounselect = gohelper.findChild(self.go, "unselect")
	self.animator = gohelper.findChildComponent(self.go, "", gohelper.Type_Animator)
end

function SummonLimitationReplicationSelfSelectItem:setInfo(heroId)
	self.heroId = heroId

	self:refreshUI()
end

function SummonLimitationReplicationSelfSelectItem:refreshUI()
	local iconName = "v3a4_sp_summon_icon_" .. tostring(self.heroId)
	local iconBgName = "v3a4_sp_summon_icon_bg_" .. tostring(self.heroId)

	UISpriteSetMgr.instance:setSummonSprite(self._imageselectRole, iconName)
	UISpriteSetMgr.instance:setSummonSprite(self._imageunselectRole, iconName)
	UISpriteSetMgr.instance:setSummonSprite(self._imageframe, iconBgName)
end

function SummonLimitationReplicationSelfSelectItem:setSelect(heroId)
	local isSelect = self.heroId == heroId

	if isSelect ~= self.isSelect then
		local animName = isSelect and "select" or "unselect"

		self.animator:Play(animName, 0, 0)
		logNormal("播放切换动画 当前id: " .. tostring(self.heroId) .. " 选择id: " .. tostring(heroId) .. "动画名: " .. animName)
	end

	self.isSelect = isSelect
end

function SummonLimitationReplicationSelfSelectItem:onDestroy()
	return
end

return SummonLimitationReplicationSelfSelectItem
