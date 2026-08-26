-- chunkname: @modules/logic/rouge/view/RougeFactionItemSelected_BtnItem.lua

module("modules.logic.rouge.view.RougeFactionItemSelected_BtnItem", package.seeall)

local RougeFactionItemSelected_BtnItem = class("RougeFactionItemSelected_BtnItem", UserDataDispose)

function RougeFactionItemSelected_BtnItem:onInitView()
	self._gonormal = gohelper.findChild(self.viewGO, "#go_normal")
	self._goselect = gohelper.findChild(self.viewGO, "#go_select")
	self._golock = gohelper.findChild(self.viewGO, "#go_lock")
	self._lockAnim = gohelper.onceAddComponent(self._golock, gohelper.Type_Animator)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeFactionItemSelected_BtnItem:addEvents()
	self._itemClick:AddClickListener(self._onItemClick, self)
end

function RougeFactionItemSelected_BtnItem:removeEvents()
	if self._itemClick then
		self._itemClick:RemoveClickListener()

		self._itemClick = nil
	end
end

function RougeFactionItemSelected_BtnItem:ctor(parent)
	self:__onInit()

	self._parent = parent
end

function RougeFactionItemSelected_BtnItem:init(go)
	self.viewGO = go
	self._trans = go.transform

	self:onInitView()
	self:addEvents()
end

function RougeFactionItemSelected_BtnItem:transform()
	return self._trans
end

function RougeFactionItemSelected_BtnItem:setIndex(index)
	self._index = index
end

function RougeFactionItemSelected_BtnItem:index()
	return self._index
end

function RougeFactionItemSelected_BtnItem:_getDetailTrans()
	return self._parent._detailTrans
end

function RougeFactionItemSelected_BtnItem:_getDetailText()
	return self._parent._txtdec
end

function RougeFactionItemSelected_BtnItem:_getDetailIcon()
	return self._parent._detailimageicon
end

function RougeFactionItemSelected_BtnItem:_onItemClick()
	self._parent:_btnItemOnSelectIndex(self:index(), self._isUnlock)
end

function RougeFactionItemSelected_BtnItem:_editableInitView()
	self._itemClick = gohelper.getClickWithAudio(self.viewGO)
	self._normalIcon = gohelper.findChildImage(self._gonormal, "icon")
	self._selectIcon = gohelper.findChildImage(self._goselect, "icon")

	self:setData(nil)
	self:setSelected(false)
end

function RougeFactionItemSelected_BtnItem:_getActiveSkillCO(skillType, skillId)
	local rougeConfig = RougeOutsideModel.instance:config()

	return rougeConfig:getSkillCo(skillType, skillId)
end

function RougeFactionItemSelected_BtnItem:setData(skillType, skillId, isUnlock)
	self._skillId = skillId
	self._isUnlock = isUnlock
	self._skillType = skillType

	if not skillId then
		self:setActive(false)

		return
	end

	local activeSkillCO = self:_getActiveSkillCO(self._skillType, skillId)
	local icon = activeSkillCO and activeSkillCO.icon

	if not string.nilorempty(icon) then
		UISpriteSetMgr.instance:setRouge2Sprite(self._normalIcon, icon, true)
		UISpriteSetMgr.instance:setRouge2Sprite(self._selectIcon, icon, true)
	else
		logError(string.format("未配置肉鸽流派技能图标, 技能类型 = %s, 技能id = %s", skillType, skillId))
	end

	gohelper.setActive(self._golock, not self._isUnlock)

	local animName = self._isUnlock and "idle" or "unlock"

	self._lockAnim:Play(animName)
	self:setActive(true)
end

function RougeFactionItemSelected_BtnItem:setActive(bool)
	gohelper.setActive(self.viewGO, bool)
end

function RougeFactionItemSelected_BtnItem:onUnlocked()
	self._isUnlock = true

	self:setSelected(false)

	local animatorPlayer = SLFramework.AnimatorPlayer.Get(self._lockAnim.gameObject)

	animatorPlayer:Play("unlock", self.endPayAnim, self)
end

function RougeFactionItemSelected_BtnItem:endPayAnim()
	gohelper.setActive(self._golock, false)
end

function RougeFactionItemSelected_BtnItem:onDestroyView()
	self:removeEvents()
	self:__onDispose()
end

function RougeFactionItemSelected_BtnItem:setSelected(isSelected)
	if self._isSelected == isSelected then
		return
	end

	self._isSelected = isSelected

	gohelper.setActive(self._gonormal, not isSelected)
	gohelper.setActive(self._goselect, isSelected)

	if isSelected then
		self:_resetDetailTxt()
		self:_refreshDetailIcon()
	end
end

function RougeFactionItemSelected_BtnItem:isSelected()
	return self._isSelected or false
end

function RougeFactionItemSelected_BtnItem:_resetDetailTxt()
	local textCmp = self:_getDetailText()

	if not self._skillId then
		textCmp.text = ""

		return
	end

	local activeSkillCO = self:_getActiveSkillCO(self._skillType, self._skillId)

	textCmp.text = activeSkillCO.desc
end

function RougeFactionItemSelected_BtnItem:_refreshDetailIcon()
	if not self._skillId then
		return
	end

	local image = self:_getDetailIcon()
	local activeSkillCO = self:_getActiveSkillCO(self._skillType, self._skillId)

	UISpriteSetMgr.instance:setRouge2Sprite(image, activeSkillCO.icon)
end

return RougeFactionItemSelected_BtnItem
