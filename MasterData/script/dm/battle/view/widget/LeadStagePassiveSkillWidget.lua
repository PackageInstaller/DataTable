-- chunkname: @/tmp/or_script/lua_compile/dm/battle/view/widget/LeadStagePassiveSkillWidget.lua

LeadStagePassiveSkillWidget = class("LeadStagePassiveSkillWidget", BattleWidget, _M)

function LeadStagePassiveSkillWidget:initialize(view, isLeft)
	super.initialize(self, view)

	if isLeft then
		self:setIsLeft()
	end
end

function LeadStagePassiveSkillWidget:dispose()
	super.dispose(self)
end

function LeadStagePassiveSkillWidget:setIsLeft()
	self._isLeft = true
end

function LeadStagePassiveSkillWidget:init(passiveSkill)
	self._passiveSkill = passiveSkill

	self:_setupView()
end

function LeadStagePassiveSkillWidget:_setupView()
	self._imgIcon = self:getView():getChildByName("icon")
	self._text = self:getView():getChildByName("desc")

	local info = ConfigReader:getRecordById("MasterLeadStage", self._passiveSkill.leadStageId)

	self._imgIcon:loadTexture(info.Icon, ccui.TextureResType.plistType)
	self._imgIcon:ignoreContentAdaptWithSize(true)
	self._imgIcon:setScale(0.4)
	self._text:setString(Strings:get(info.RomanNum) .. Strings:get(info.StageName))
	self._text:setTextColor(GameStyle:getLeadStageColor(self._passiveSkill.leadStageLevel))
	self:getView():getChildByFullName("click"):addClickEventListener(function()
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

		if #self._passiveSkill == 0 then
			return
		end

		self:onClickShowTip()
	end)
end

function LeadStagePassiveSkillWidget:onClickShowTip()
	if not self._touchEnabled then
		return
	end

	self._listener:showPassiveSkillTip(self._passiveSkill, self._isLeft)
end

function LeadStagePassiveSkillWidget:setListener(listener)
	self._listener = listener
end

function LeadStagePassiveSkillWidget:setTouchEnabled(enabled)
	self._touchEnabled = enabled
end
