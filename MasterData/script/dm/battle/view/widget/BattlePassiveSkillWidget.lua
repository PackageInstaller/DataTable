-- chunkname: @/tmp/or_script/lua_compile/dm/battle/view/widget/BattlePassiveSkillWidget.lua

BattlePassiveSkillWidget = class("BattlePassiveSkillWidget", BattleWidget, _M)

function BattlePassiveSkillWidget:initialize(view, isLeft)
	super.initialize(self, view)

	if isLeft then
		self:setIsLeft()
	end
end

function BattlePassiveSkillWidget:dispose()
	super.dispose(self)
end

function BattlePassiveSkillWidget:setIsLeft()
	self._isLeft = true
end

function BattlePassiveSkillWidget:init(passiveSkill)
	self._passiveSkill = passiveSkill
	self._heroPassiveSkill = {}
	self._masterPassiveSkill = {}

	for i = 1, #self._passiveSkill do
		local skillInfo = self._passiveSkill[i]

		if skillInfo.master then
			local index = skillInfo.index

			self._masterPassiveSkill[index] = skillInfo
		else
			self._heroPassiveSkill[#self._heroPassiveSkill + 1] = skillInfo
		end
	end

	self._touchEnabled = false

	self:_setupView()
end

function BattlePassiveSkillWidget:_setupView()
	local view = self:getView()

	view:setScale(0.9)
	view:removeAllChildren()

	local posX = 0
	local length = 38
	local lengthM = 41

	if self._passiveSkill.showMasterSkill and table.nums(self._masterPassiveSkill) > 0 then
		local masterPassiveSkill = cc.CSLoader:createNode("asset/ui/BattleMasterPassiveSkill.csb")

		masterPassiveSkill:setScale(0.7555555555555555)
		view:addChild(masterPassiveSkill)
		masterPassiveSkill:setPosition(cc.p(posX, 2))

		posX = self._isLeft and posX + lengthM or posX - lengthM

		for index = 1, 6 do
			local skillImg = masterPassiveSkill:getChildByFullName("Image_" .. index)

			if self._masterPassiveSkill[index] then
				skillImg:setVisible(true)
			else
				skillImg:setVisible(false)
			end
		end

		masterPassiveSkill:getChildByFullName("Image_bg"):setTouchEnabled(true)
		masterPassiveSkill:getChildByFullName("Image_bg"):addClickEventListener(function()
			AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
			self:onClickShowTip()
		end)
	end

	for i = 1, #self._heroPassiveSkill do
		local skillInfo = self._heroPassiveSkill[i]
		local node = cc.Node:create()

		view:addChild(node)
		node:setPosition(cc.p(posX, -5))
		node:setScale(1.05)

		local skillId = skillInfo.id
		local imageBg = ccui.ImageView:create("zd_bg_lp_2.png", ccui.TextureResType.plistType)

		node:addChild(imageBg)
		imageBg:setPosition(cc.p(0, -12))

		local icon = ConfigReader:getDataByNameIdAndKey("Skill", skillId, "Icon")
		local image = ccui.ImageView:create("asset/skillIcon/" .. icon .. ".png")

		node:addChild(image)
		image:setTouchEnabled(true)
		image:setScale(0.22)
		image:setPosition(cc.p(0, 2))
		image:addClickEventListener(function()
			AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
			self:onClickShowTip()
		end)

		posX = self._isLeft and posX + length or posX - length
	end
end

function BattlePassiveSkillWidget:onClickShowTip()
	if not self._touchEnabled then
		return
	end

	self._listener:showPassiveSkillTip(self._passiveSkill, self._isLeft)
end

function BattlePassiveSkillWidget:setListener(listener)
	self._listener = listener
end

function BattlePassiveSkillWidget:setTouchEnabled(enabled)
	self._touchEnabled = enabled
end
