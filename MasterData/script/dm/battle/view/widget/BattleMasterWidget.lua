-- chunkname: @/tmp/or_script/lua_compile/dm/battle/view/widget/BattleMasterWidget.lua

BattleMasterWidget = class("BattleMasterWidget", BattleWidget, _M)

local SkillStackRes = {
	[6] = {
		bottom = "zhandou_img_nz_di.png",
		progress = {
			"zhandou_img_nz_1.png",
			"zhandou_img_nz_2.png",
			"zhandou_img_nz_3.png",
			"zhandou_img_nz_4.png",
			"zhandou_img_nz_5.png",
			"zhandou_img_nz_6.png"
		}
	}
}

function BattleMasterWidget:initialize(view)
	super.initialize(self, view)
	self:setupView(view)
end

function BattleMasterWidget:dispose()
	if self._skillStSchedule then
		LuaScheduler:getInstance():unschedule(self._skillStSchedule)

		self._skillStSchedule = nil
	end

	super.dispose(self)
end

function BattleMasterWidget:setupView(view)
	self._grayCover = view:getChildByFullName("gray_cover")
	self._skillNode = view:getChildByName("skill_node")
	self._skillWidgets = {}
	self._skillStackProgress = {}

	for i = 1, 3 do
		local node = self._skillNode:getChildByName("skill" .. i)
		local skillWidget = node:getChildByName("skill")

		self._skillWidgets[i] = skillWidget

		local anim = cc.MovieClip:create("qbbbbbbbb_jinenganniu")

		anim:addTo(node)
		skillWidget:changeParent(anim:getChildByName("icon"))
		anim:gotoAndStop(1)
		anim:addCallbackAtFrame(107, function(cid, mc)
			mc:gotoAndPlay(57)
		end)
		anim:addCallbackAtFrame(144, function(cid, mc)
			mc:gotoAndPlay(110)
		end)
		anim:addCallbackAtFrame(170, function(cid, mc)
			mc:gotoAndStop(1)
		end)

		self._skillStackProgress[i] = node:getChildByName("progress")

		self._skillStackProgress[i]:setVisible(false)
	end

	view:setVisible(false)
end

function BattleMasterWidget:StackSkill(skillId, stacknum, totalnum)
	local function statck(index, stacknum, totalnum)
		if self._skillStackProgress[index] and SkillStackRes[totalnum] then
			self._skillStackProgress[index]:setVisible(true)
			self._skillStackProgress[index]:loadTexture(SkillStackRes[totalnum].bottom, ccui.TextureResType.plistType)

			local percent = self._skillStackProgress[index]:getChildByName("percent")

			if SkillStackRes[totalnum].progress[stacknum] then
				percent:loadTexture(SkillStackRes[totalnum].progress[stacknum], ccui.TextureResType.plistType)
				percent:setVisible(true)
			end

			if stacknum == 0 then
				percent:setVisible(false)
			end
		end
	end

	for k, v in pairs(self._skills) do
		print(v.id, skillId)

		if v.id == skillId then
			statck(k, stacknum, totalnum)

			break
		end
	end
end

function BattleMasterWidget:setupSkills(skills)
	self:getView():setVisible(true)

	self._skills = skills or {}

	for i = 1, 3 do
		local node = self._skillNode:getChildByName("skill" .. i)

		node:setVisible(true)

		local skillWidget = self._skillWidgets[i]
		local skill = self._skills[i]
		local anim = skillWidget:getParent():getParent()

		anim:gotoAndStop(1)

		if skill and type(skill) == "table" then
			skillWidget:getChildByName("icon"):loadTexture("asset/skillIcon/" .. skill.icon .. ".png")

			skillWidget.skillType = skill.type
			skillWidget.skillId = skill.id
			skillWidget.level = skill.level

			skillWidget:addTouchEventListener(function(sender, eventType)
				self:onClickedSkill(sender, eventType)
			end)

			local masterSkillTag = ConfigReader:getDataByNameIdAndKey("Skill", skill.id, "MasterSkillTag")

			if masterSkillTag and masterSkillTag ~= "" then
				node:getChildByName("tagIcon"):setLocalZOrder(2)
				node:getChildByName("tagIcon"):setVisible(true)

				local tag = node:getChildByName("tagIcon"):getChildByName("tag")

				tag:setString(Strings:get(masterSkillTag))

				local size = tag:getContentSize()

				size.width = size.width + 30
				size.height = node:getChildByName("tagIcon"):getContentSize().height

				node:getChildByName("tagIcon"):setContentSize(size)
				tag:center(size)
				tag:offset(0, 4)
			else
				node:getChildByName("tagIcon"):setVisible(false)
			end

			node:getChildByName("tagIcon"):setVisible(false)
		else
			node:setVisible(false)
			skillWidget:addTouchEventListener(function(sender, eventType)
				self._listener:getMainMediator():dispatch(ShowTipEvent({
					tip = "没有该技能或技能未解锁"
				}))
			end)
		end
	end
end

function BattleMasterWidget:setListener(listener)
	self._listener = listener
end

function BattleMasterWidget:setHp(value)
	self._hp = math.min(value, self._maxHp)
	self._hp = math.max(value, 0)

	if self._hp <= 0 then
		-- block empty
	end
end

function BattleMasterWidget:setRp(value)
	self._mp = math.min(value, self._maxMp)
	self._mp = math.max(value, 0)

	if self._mp >= self._maxMp then
		if not self._executing and not self._skillForbid then
			self:showSkillNode()
		end
	else
		self._executing = false

		self:hideSkillNode()

		self._prePlaySkill = nil
	end
end

function BattleMasterWidget:checkSkillState()
	if self._listener then
		self._listener:checkSkillState(self)
	end
end

function BattleMasterWidget:updateMasterInfo(data)
	self._maxHp = data.maxHp
	self._maxMp = data.maxMp

	self:setupSkills(data.skills)
	self:setRp(data.mp)
	self:setHp(data.hp)
end

function BattleMasterWidget:forbidSkillChange(isForbid)
	self._skillForbid = isForbid

	if self._mp and self._maxMp then
		if self._mp >= self._maxMp then
			if not self._executing and not self._skillForbid then
				self:showSkillNode()
			elseif self._executing and self._skillForbid then
				self._listener:cancelMasterSkill(self, self._curMasterSkillType)
				self:hideSkillNode()
			else
				self._executing = false

				self:hideSkillNode()
			end
		else
			self._executing = false

			self:hideSkillNode()

			self._prePlaySkill = nil
		end
	end

	if self._skillForbid then
		-- block empty
	end
end

function BattleMasterWidget:setTouchEnabled(enabled)
	self._touchEnabled = enabled
end

function BattleMasterWidget:isTouchEnabled()
	return self._touchEnabled
end

function BattleMasterWidget:getCurMasterSkillType()
	return self._curMasterSkillType or nil
end

function BattleMasterWidget:onClickedSkill(sender, eventType)
	if eventType == ccui.TouchEventType.began then
		if self._listener then
			local parentView = sender:getParent()
			local pos = parentView:convertToWorldSpace(cc.p(sender:getPosition()))

			self._listener:showSkillTip(sender.skillId, sender.level, cc.p(pos.x + 100 + 0 * AdjustUtils.getSafeX(), pos.y + 50))
		end
	elseif eventType == ccui.TouchEventType.canceled then
		if self._listener then
			self._listener:hideSkillTip()
		end
	elseif eventType == ccui.TouchEventType.ended then
		if self._listener then
			self._listener:hideSkillTip()
		end

		if not self._touchEnabled then
			return
		end

		if self._executing then
			if self._curMasterSkillType == sender.skillType then
				self:cancelSkill(sender)
			end

			return
		end

		if sender.skillEnabled then
			self:executeSkill(sender)
		end
	end
end

function BattleMasterWidget:cancelSkill(sender)
	local skillType = sender.skillType

	AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
	self._listener:cancelMasterSkill(self, skillType)

	self._executingcancel = true
	self._prePlaySkill = nil
end

function BattleMasterWidget:executeSkill(sender)
	local skillType = sender.skillType

	AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

	self._curMasterSkillType = skillType

	self._listener:applyMasterSkill(self, skillType)
end

function BattleMasterWidget:willExecute()
	self._executing = true

	for i, skill in ipairs(self._skills) do
		if skill and type(skill) == "table" then
			local skillWidget = self._skillWidgets[i]

			if skillWidget.skillType == self._curMasterSkillType then
				local anim = skillWidget:getParent():getParent()

				anim:gotoAndPlay(108)

				self._prePlaySkill = anim
			else
				local anim = skillWidget:getParent():getParent()

				anim:gotoAndStop(1)
			end
		end
	end
end

function BattleMasterWidget:cancelExecute(rp)
	for i, skill in ipairs(self._skills) do
		if skill and type(skill) == "table" then
			local skillWidget = self._skillWidgets[i]

			if skillWidget.skillType == self._curMasterSkillType then
				skillWidget.skillEnabled = true

				local anim = skillWidget:getParent():getParent()

				anim:gotoAndStop(1)
			end
		end
	end

	self._executing = false
	self._executingcancel = false

	self:setRp(rp)
end

function BattleMasterWidget:getSkillNode(index)
	local skill = self._skills[index]

	if skill and type(skill) == "table" then
		return self._skillWidgets[index]
	end
end

function BattleMasterWidget:showSkillNode()
	self._grayCover:setVisible(false)

	local willSound = true
	local canSound = false

	for i, skill in ipairs(self._skills) do
		if skill and type(skill) == "table" then
			canSound = true

			local skillWidget = self._skillWidgets[i]

			if skillWidget.skillEnabled then
				willSound = false
			end

			skillWidget.skillEnabled = true

			local anim = skillWidget:getParent():getParent()
			local frameIndex = anim:getCurrentFrame()

			if frameIndex > 107 or frameIndex < 14 then
				anim:gotoAndPlay(14)
			end
		end
	end

	if willSound and canSound then
		AudioEngine:getInstance():playEffect("Se_Alert_Char_Ready", false)
	end
end

function BattleMasterWidget:hideSkillNode()
	self._grayCover:setVisible(true)

	for i, skill in ipairs(self._skills) do
		if skill and type(skill) == "table" then
			local skillWidget = self._skillWidgets[i]

			skillWidget.skillEnabled = false

			local anim = skillWidget:getParent():getParent()
			local frameIndex = anim:getCurrentFrame()

			if frameIndex <= 144 then
				anim:gotoAndStop(1)
			end
		end
	end
end

function BattleMasterWidget:setSkillTouchEnabled(isTrue)
	local skillNode = self:getView():getChildByName("skill_node")

	for i, skill in ipairs(self._skills) do
		if skill and type(skill) == "table" then
			local skillWidget = self._skillWidgets[i]

			skillWidget:setTouchEnabled(isTrue)
		end
	end
end

function BattleMasterWidget:onDoSkill(data)
	if data.type == self:getCurMasterSkillType() then
		for i = 1, 3 do
			local skillWidget = self._skillWidgets[i]

			if skillWidget.skillType == self._curMasterSkillType then
				local anim = skillWidget:getParent():getParent()

				anim:gotoAndPlay(145)
			end
		end
	end
end
