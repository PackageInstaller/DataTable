-- chunkname: @modules/logic/tips/view/SkillBuffDescComp.lua

module("modules.logic.tips.view.SkillBuffDescComp", package.seeall)

local SkillBuffDescComp = class("SkillBuffDescComp", LuaCompBase)

function SkillBuffDescComp:init(go)
	self._goBuffContainer = go
	self._btnclosebuff = gohelper.findChildButtonWithAudio(go, "buff_bg")
	self._goBuffItem = gohelper.findChild(go, "#go_buffitem")
	self._txtBuffName = gohelper.findChildText(go, "#go_buffitem/title/txt_name")
	self._goBuffTag = gohelper.findChild(go, "#go_buffitem/title/txt_name/go_tag")
	self._txtBuffTagName = gohelper.findChildText(go, "#go_buffitem/title/txt_name/go_tag/bg/txt_tagname")
	self._txtBuffDesc = gohelper.findChildText(go, "#go_buffitem/txt_desc")

	gohelper.setActive(go, false)
end

function SkillBuffDescComp:addEventListeners()
	self._btnclosebuff:AddClickListener(self._closebuff, self)
end

function SkillBuffDescComp:removeEventListeners()
	self._btnclosebuff:RemoveClickListener()
end

function SkillBuffDescComp:_closebuff()
	gohelper.setActive(self._goBuffContainer, false)
end

function SkillBuffDescComp:onShowBuff(skillName, clickPos)
	gohelper.setActive(self._goBuffContainer, true)
	self:setBuffInfo(skillName)
	self:setBuffPos(clickPos)
end

function SkillBuffDescComp:setBuffInfo(skillName)
	local skillEffectCo = SkillConfig.instance:getSkillEffectDescCoByName(skillName)

	self._txtBuffName.text = SkillConfig.instance:processSkillDesKeyWords(skillName)
	self._txtBuffDesc.text = HeroSkillModel.instance:skillDesToSpot(skillEffectCo.desc)

	local buffTagName = FightConfig.instance:getBuffTag(skillName)

	gohelper.setActive(self._goBuffTag, not string.nilorempty(buffTagName))

	self._txtBuffTagName.text = buffTagName
end

function SkillBuffDescComp:setBuffPos(clickPos)
	local x = clickPos.x - 20
	local y = clickPos.y
	local trans = self._goBuffItem.transform
	local viewTrans = self._goBuffContainer.transform

	ZProj.UGUIHelper.RebuildLayout(trans)

	local width, height = recthelper.getWidth(trans), recthelper.getHeight(trans)
	local viewWidth, viewHeight = recthelper.getWidth(viewTrans), recthelper.getHeight(viewTrans)

	if -viewWidth / 2 > x - width - 10 then
		x = -viewWidth / 2 + width + 10
	end

	if -viewHeight / 2 > y - height / 2 - 10 then
		y = -viewHeight / 2 + height / 2 + 10
	end

	recthelper.setAnchorY(trans, y)
end

return SkillBuffDescComp
